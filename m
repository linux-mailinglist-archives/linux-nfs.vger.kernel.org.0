Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93901863C5
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2020 04:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgCPDjh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 15 Mar 2020 23:39:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:35364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729383AbgCPDjh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 15 Mar 2020 23:39:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EAA21ACC6;
        Mon, 16 Mar 2020 03:39:34 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker\@Netapp.com" <Anna.Schumaker@Netapp.com>
Date:   Mon, 16 Mar 2020 14:39:28 +1100
Cc:     "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/RFC] NFS: Minimize COMMIT calls during writeback.
In-Reply-To: <b557a1d43105b42b304a2682ce8e2c31637e1989.camel@hammerspace.com>
References: <87y2s1rwof.fsf@notabene.neil.brown.name> <b557a1d43105b42b304a2682ce8e2c31637e1989.camel@hammerspace.com>
Message-ID: <87v9n5rmrz.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16 2020, Trond Myklebust wrote:

> On Mon, 2020-03-16 at 11:05 +1100, NeilBrown wrote:
>> Since 4.13 (see Fixes: commit) NFS has sent a COMMIT request for
>> every
>> .writepages() call it received - when the writes submitted for that
>> call
>> have all completed.
>>=20
>> This works well enough when COMMIT is fast, but if COMMIT is slow
>> these
>> calls can overlap each other, overload the server, and substantially
>> reduce throughput.
>>=20
>> I looked at this due to a report of regression when writing to a
>> Ganesha
>> NFS server with tracing showing multiple overlapping COMMITs, and
>> individual commits typically taking 200ms to 300ms.  This resulted in
>> 2
>> orders of magnitude slow down when writing 1000x1M from /dev/zero
>> with dd.
>> This is easily reproduced by adding 'msleep(300)' to nfsd_commit() in
>> the
>> Linux NFS server.
>
>
> When there is overlap of writeback to the same file, then it is almost
> always because we're hitting memory reclaim on the client. In that case
> we want to ensure that memory reclaim completes, which it won't do if
> we delay COMMIT.
> IOW: this behaviour is very much intentional.

What do you mean by "overlap of writeback" ?
The ->writepages calls are sequential - they don't overlap.
The WRITE rpcs are asynchronous so of course they overlap.
The COMMITs are expected to overlap with subsequent WRITEs.
It is only when COMMITs overlap with COMMITs that I think we might
overload the server, and I cannot see how that would ever be a useful
thing to do.

In the cases I've experiment with there is plenty of memory, but the
total write size exceeds dirty_threshold, so writeout starts to limit
the amount of dirty memory.  Certainly we want the COMMIT promptly as
a group of writes finish, but that group doesn't need to be tiny.

(Our initial explorations found that increasing dirty_threshold to
larger than the write size restored normal performance)

>
>> This patch changes the details of when COMMIT is sent without
>> changing
>> the general approach.
>>=20
>> Where previously the writes from a single .writepages() call were
>> accounted together in a nfs_io_completion, now the writes from
>> multiple
>> writepages() calls are accounted together.  The set of writepages
>> calls
>> that are grouped together are all those from when one COMMIT call
>> ends
>> to when the next COMMIT call ends.  This automatically reduces the
>> rate
>> of COMMIT requests when COMMIT itself is slow.
>> (If there are no COMMIT calls pending, the first .writepages will get
>>  an nfs_io_completion to itself, then subsequenct writepages requests
>>  until the first COMMIT completes will go in the next
>> nfs_io_completion)
>>=20
>> There are typically at most two nfs_io_completion structures
>> allocated
>> for writeback to a given inode.
>>=20
>> - If there was been any writepages calls since the last time a COMMIT
>>   completed, there will be an nfs_io_completion stored in the inode
>> (in
>>   nfs_mds_commit_info) which new writepages requests are accounted
>> it.
>>=20
>> - If there is no pending COMMIT request, but there are pending
>> writeback
>>   WRITES, there will be another nfs_io_completion which is not
>> attached
>>   and which is draining.  When it fully drains a COMMIT will be sent.
>>   When that COMMIT completes, the attached nfs_io_completion will be
>>   detached and allowed to drain.
>>=20
>> The rpcs_out counter now counts the unattached nfs_io_completion as
>> well
>> as any pending COMMIT requests.  As an unattached nfs_io_completion
>> will
>> soon turn into a COMMIT request, this seems reasonable.  It allows us
>> to
>> clearly detect when there are no longer any COMMITs expected to
>> complete, so we know to detach any nfs_io_completion from the inode
>> and
>> allow it to drain.
>>=20
>> As we use atomic accesses (e.g.  xchg and kref_get_unless_zero()) to
>> access the attached nfs_io_completion, we now use kfree_rcu() to free
>> it, to ensure it is not accessed after it is freed.
>>=20
>> With 300ms commits, this improves throught of a 1G dd by 2 orders of
>> magnitude.  Even without the 300ms delay, this noticeably improves
>> throughput to a Linux NFS server is a simple VM.
>>=20
>> Fixes: 919e3bd9a875 ("NFS: Ensure we commit after writeback is
>> complete")
>> Signed-off-by: NeilBrown <neilb@suse.de>
>> ---
>>  fs/nfs/inode.c          |  1 +
>>  fs/nfs/write.c          | 50 ++++++++++++++++++++++++++++++++++++---
>> --
>>  include/linux/nfs_xdr.h |  7 ++++++
>>  3 files changed, 53 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
>> index 11bf15800ac9..c00b54491949 100644
>> --- a/fs/nfs/inode.c
>> +++ b/fs/nfs/inode.c
>> @@ -2110,6 +2110,7 @@ static void init_once(void *foo)
>>  	INIT_LIST_HEAD(&nfsi->commit_info.list);
>>  	atomic_long_set(&nfsi->nrequests, 0);
>>  	atomic_long_set(&nfsi->commit_info.ncommit, 0);
>> +	nfsi->commit_info.ioc =3D NULL;
>>  	atomic_set(&nfsi->commit_info.rpcs_out, 0);
>>  	init_rwsem(&nfsi->rmdir_sem);
>>  	mutex_init(&nfsi->commit_mutex);
>> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
>> index c478b772cc49..57e209f964e4 100644
>> --- a/fs/nfs/write.c
>> +++ b/fs/nfs/write.c
>> @@ -47,6 +47,7 @@ struct nfs_io_completion {
>>  	void (*complete)(void *data);
>>  	void *data;
>>  	struct kref refcount;
>> +	struct rcu_head rcu;
>>  };
>>=20=20
>>  /*
>> @@ -134,7 +135,7 @@ static void nfs_io_completion_release(struct kref
>> *kref)
>>  	struct nfs_io_completion *ioc =3D container_of(kref,
>>  			struct nfs_io_completion, refcount);
>>  	ioc->complete(ioc->data);
>> -	kfree(ioc);
>> +	kfree_rcu(ioc, rcu);
>>  }
>>=20=20
>>  static void nfs_io_completion_get(struct nfs_io_completion *ioc)
>> @@ -720,6 +721,8 @@ static void nfs_io_completion_commit(void *inode)
>>  	nfs_commit_inode(inode, 0);
>>  }
>>=20=20
>> +static void nfs_commit_end(struct nfs_mds_commit_info *cinfo);
>> +
>>  int nfs_writepages(struct address_space *mapping, struct
>> writeback_control *wbc)
>>  {
>>  	struct inode *inode =3D mapping->host;
>> @@ -729,9 +732,37 @@ int nfs_writepages(struct address_space
>> *mapping, struct writeback_control *wbc)
>>=20=20
>>  	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGES);
>>=20=20
>> -	ioc =3D nfs_io_completion_alloc(GFP_KERNEL);
>> -	if (ioc)
>> -		nfs_io_completion_init(ioc, nfs_io_completion_commit,
>> inode);
>> +	rcu_read_lock();
>> +	ioc =3D rcu_dereference(NFS_I(inode)->commit_info.ioc);
>> +	if (ioc && kref_get_unless_zero(&ioc->refcount)) {
>> +		rcu_read_unlock();
>> +		/* We've successfully piggybacked on the attached ioc
>> */
>> +	} else {
>> +		rcu_read_unlock();
>> +		ioc =3D nfs_io_completion_alloc(GFP_KERNEL);
>> +		if (ioc) {
>> +			struct nfs_io_completion *ioc_prev;
>> +
>> +			nfs_io_completion_init(ioc,
>> nfs_io_completion_commit,
>> +					       inode);
>> +			/* Temporarily elevate rpcs_out to ensure a
>> commit
>> +			 * completion *will* happen after we attach
>> this ioc,
>> +			 * so it *will* get a chance to drain.
>> +			 */
>> +			atomic_inc(&NFS_I(inode)-
>> >commit_info.rpcs_out);
>> +			nfs_io_completion_get(ioc);
>> +			ioc_prev =3D xchg(&NFS_I(inode)->commit_info.ioc,
>> +				    ioc);
>> +			/* ioc_prev is normally NULL, but racing
>> writepages
>> +			 * calls might result in it being non-NULL.
>> +			 * In either case it is safe to put it - worst
>> case
>> +			 * we get an extra COMMIT.
>> +			 */
>> +			nfs_io_completion_put(ioc_prev);
>> +			/* release temporary ref on rpcs_out */
>> +			nfs_commit_end(&NFS_I(inode)->commit_info);
>
> So won't this normally trigger the xchg(NULL) in nfs_commmit_end()? For
> most cases, I'd expect commit_info.rpcs_out to be zero until we start
> actually sending out the COMMITs.

On the first writepages call after a period of quiet, that is exactly
correct.  The ioc that we have just allocated and attached will
immediately be detached.  It will have a refcount of 1 at this point so
nothing further happens.
Then WRITEs get queued elevating the refcount.  This will eventually
drain and a COMMIT will be sent.  So the behaviour for the firstpages
call is exactly like the current code (I think I mentioned that in the
commit message).
If the WRITEs and COMMIT complete before the next .writepages, then that
writepages will behave the same way.
But if the WRITEs or COMMIT are still pending, then rpcs_out will still
be elevated....
Only - no.  Unattached iocs are meant to be counted in rpcs_out, but I
haven't got that right.  So we can still end up with parallel COMMITs.
I think that might explain some slightly odd numbers in my testing.

Here is the new version.

Thanks for the review.

NeilBrown

From: NeilBrown <neilb@suse.de>
Subject: [PATCH] NFS: Minimize COMMIT calls during writeback.

Since 4.13 (see Fixes: commit) NFS has sent a COMMIT request for every
.writepages() call it received - when the writes submitted for that call
have all completed.

This works well enough when COMMIT is fast, but if COMMIT is slow these
calls can overlap each other, overload the server, and substantially
reduce throughput.

I looked at this due to a report of regression when writing to a Ganesha
NFS server with tracing showing multiple overlapping COMMITs, and
individual commits typically taking 200ms to 300ms.  This resulted in 2
orders of magnitude slow down when writing 1000x1M from /dev/zero with dd.
This is easily reproduced by adding 'msleep(300)' to nfsd_commit() in the
Linux NFS server.

This patch changes the details of when COMMIT is sent without changing
the general approach.

Where previously the writes from a single .writepages() call were
accounted together in a nfs_io_completion, now the writes from multiple
writepages() calls are accounted together.  The set of writepages calls
that are grouped together are all those from when one COMMIT call ends
to when the next COMMIT call ends.  This automatically reduces the rate
of COMMIT requests when COMMIT itself is slow.
(If there are no COMMIT calls pending, the first .writepages will get
 an nfs_io_completion to itself, then subsequenct writepages requests
 until the first COMMIT completes will go in the next nfs_io_completion)

There are typically at most two nfs_io_completion structures allocated
for writeback to a given inode.

=2D If there was been any writepages calls since the last time a COMMIT
  completed, there will be an nfs_io_completion stored in the inode (in
  nfs_mds_commit_info) which new writepages requests are accounted it.

=2D If there is no pending COMMIT request, but there are pending writeback
  WRITES, there will be another nfs_io_completion which is not attached
  and which is draining.  When it fully drains a COMMIT will be sent.
  When that COMMIT completes, the attached nfs_io_completion will be
  detached and allowed to drain.

The rpcs_out counter now counts the unattached nfs_io_completion as well
as any pending COMMIT requests.  As an unattached nfs_io_completion will
soon turn into a COMMIT request, this seems reasonable.  It allows us to
clearly detect when there are no longer any COMMITs expected to
complete, so we know to detach any nfs_io_completion from the inode and
allow it to drain.

As we use atomic accesses (e.g.  xchg and kref_get_unless_zero()) to
access the attached nfs_io_completion, we now use kfree_rcu() to free
it, to ensure it is not accessed after it is freed.

With 300ms commits, this improves throught of a 1G dd by 2 orders of
magnitude.  Even without the 300ms delay, this noticeably improves
throughput to a Linux NFS server is a simple VM.

Fixes: 919e3bd9a875 ("NFS: Ensure we commit after writeback is complete")
Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 fs/nfs/inode.c          |  1 +
 fs/nfs/write.c          | 69 +++++++++++++++++++++++++++++++++++++----
 include/linux/nfs_xdr.h |  7 +++++
 3 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 11bf15800ac9..c00b54491949 100644
=2D-- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2110,6 +2110,7 @@ static void init_once(void *foo)
 	INIT_LIST_HEAD(&nfsi->commit_info.list);
 	atomic_long_set(&nfsi->nrequests, 0);
 	atomic_long_set(&nfsi->commit_info.ncommit, 0);
+	nfsi->commit_info.ioc =3D NULL;
 	atomic_set(&nfsi->commit_info.rpcs_out, 0);
 	init_rwsem(&nfsi->rmdir_sem);
 	mutex_init(&nfsi->commit_mutex);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index c478b772cc49..6dbb055f80bf 100644
=2D-- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -47,6 +47,7 @@ struct nfs_io_completion {
 	void (*complete)(void *data);
 	void *data;
 	struct kref refcount;
+	struct rcu_head rcu;
 };
=20
 /*
@@ -134,7 +135,7 @@ static void nfs_io_completion_release(struct kref *kref)
 	struct nfs_io_completion *ioc =3D container_of(kref,
 			struct nfs_io_completion, refcount);
 	ioc->complete(ioc->data);
=2D	kfree(ioc);
+	kfree_rcu(ioc, rcu);
 }
=20
 static void nfs_io_completion_get(struct nfs_io_completion *ioc)
@@ -715,9 +716,15 @@ static int nfs_writepages_callback(struct page *page, =
struct writeback_control *
 	return ret;
 }
=20
+static void nfs_commit_end(struct nfs_mds_commit_info *cinfo);
+
 static void nfs_io_completion_commit(void *inode)
 {
 	nfs_commit_inode(inode, 0);
+	/* this came from a detached nfs_io_completion, which is now
+	 * no longer active, so must decrement rpcs_out.
+	 */
+	nfs_commit_end(&NFS_I(inode)->commit_info);
 }
=20
 int nfs_writepages(struct address_space *mapping, struct writeback_control=
 *wbc)
@@ -729,9 +736,46 @@ int nfs_writepages(struct address_space *mapping, stru=
ct writeback_control *wbc)
=20
 	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGES);
=20
=2D	ioc =3D nfs_io_completion_alloc(GFP_KERNEL);
=2D	if (ioc)
=2D		nfs_io_completion_init(ioc, nfs_io_completion_commit, inode);
+	rcu_read_lock();
+	ioc =3D rcu_dereference(NFS_I(inode)->commit_info.ioc);
+	if (ioc && kref_get_unless_zero(&ioc->refcount)) {
+		rcu_read_unlock();
+		/* We've successfully piggybacked on the attached ioc */
+	} else {
+		rcu_read_unlock();
+		ioc =3D nfs_io_completion_alloc(GFP_KERNEL);
+		if (ioc) {
+			struct nfs_io_completion *ioc_prev;
+
+			nfs_io_completion_init(ioc, nfs_io_completion_commit,
+					       inode);
+			/* This is now a detached ioc so we count it in
+			 * rpcs_out.  *After* we successfully attach it
+			 * below (likely, but not certain), we will call
+			 * nfs_commit_end() which might detach it immedately
+			 * if there are no outstanding commit.
+			 */
+			atomic_inc(&NFS_I(inode)->commit_info.rpcs_out);
+			nfs_io_completion_get(ioc);
+			ioc_prev =3D xchg(&NFS_I(inode)->commit_info.ioc,
+				    ioc);
+			/* ioc_prev is normally NULL, but racing writepages
+			 * calls might result in it being non-NULL.
+			 * In either case it is safe to put it - worst case
+			 * we get an extra COMMIT.
+			 */
+			if (ioc_prev)
+				/* This ioc_prev is now detached, so put it, and
+				 * keep the ref on rpcs_out
+				 */
+				nfs_io_completion_put(ioc_prev);
+			else
+				/* Attachment successful, so drop ref
+				 * on rpcs_out
+				 */
+				nfs_commit_end(&NFS_I(inode)->commit_info);
+		}
+	}
=20
 	nfs_pageio_init_write(&pgio, inode, wb_priority(wbc), false,
 				&nfs_async_write_completion_ops);
@@ -1677,8 +1721,21 @@ static void nfs_commit_begin(struct nfs_mds_commit_i=
nfo *cinfo)
=20
 static void nfs_commit_end(struct nfs_mds_commit_info *cinfo)
 {
=2D	if (atomic_dec_and_test(&cinfo->rpcs_out))
=2D		wake_up_var(&cinfo->rpcs_out);
+	if (atomic_dec_and_test(&cinfo->rpcs_out)) {
+		/* When a commit finishes, we must release any attached
+		 * nfs_io_completion so that it can drain and then request
+		 * another commit.
+		 */
+		struct nfs_io_completion *ioc;
+
+		ioc =3D xchg(&cinfo->ioc, NULL);
+		if (ioc) {
+			/* Count the detached completion */
+			atomic_inc(&cinfo->rpcs_out);
+			nfs_io_completion_put(ioc);
+		} else
+			wake_up_var(&cinfo->rpcs_out);
+	}
 }
=20
 void nfs_commitdata_release(struct nfs_commit_data *data)
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 94c77ed55ce1..89db1e9d461d 100644
=2D-- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1557,9 +1557,16 @@ struct nfs_pgio_header {
 };
=20
 struct nfs_mds_commit_info {
+	/* rpcs_out counts pending COMMIT rpcs plus pendng nfs_io_completions
+	 * which are *not* attached at 'ioc' below.  Such nfs_io_compleions
+	 * (normally at most one) will drain as writes complete and then trigger
+	 * a COMMIT, so they can be considered as pending COMMITs which haven't
+	 * been sent yet
+	 */
 	atomic_t rpcs_out;
 	atomic_long_t		ncommit;
 	struct list_head	list;
+	struct nfs_io_completion *ioc;
 };
=20
 struct nfs_commit_info;
=2D-=20
2.25.1


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl5u9PAACgkQOeye3VZi
gbldZhAAhySbeiXU9jYvjvHDOKWdhM26pP2PKBcY11DS7+wed9Qr33k8QleTl6v1
lBQybtc7aRksc84YZFYBp6Xuy3UcBjrlk6KB2Vd1gV26oaFVy0dawetLnPI3rbiH
/uJ+g9CPmFrwcyifW7i1ADS6N2OWyQz7hMkQwWiC88dIyMaxDw9hZeuQLYzpke+y
3Tkd/m+7C7gWb1/79Urp87qeyzdMQwITj/RH3qKsbDsgTBvepxz9GcH9PVqtopni
7FOsT6G6ZUU8tZ2ZBJuUgqkKKDKq40mm1/hgKwLliEMbpWZkZfKgHQaS82xoeLA2
WQi9PaPRbY9F2gwocXw64+MFM7WiohpP5w2mfT9V6VpzPMIA88obp6RyPj8n0ymi
aGXpB32SELWEUtRef9C7TERKu96J27DjvaJh5YVWxWVT3ZpUCOnvqZeIQGaozL5o
q0+ZB2eEktRw0h7wTjGKJ97SOPcZ3UdOduMwuxRdYxQNV3SXLYn0/dsBDCWC5kXC
Cg1/2wGFRanRE0AZL4xubeMFRgHubKRoXqZ56TaIRX9uLMZXri9Qd1m8irt8pOf5
xHxGj0+gBx3UlV3LRcl3GX1lq54tLL/u9gKzQcamErqRzeffp5EtvnKQYBLs1nMl
k7DswFFbGIXlsQO1roTSqMOnUEGkNd4zuITVO+YtH8D2Uz4brMY=
=J9lN
-----END PGP SIGNATURE-----
--=-=-=--
