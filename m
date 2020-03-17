Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB8C187E8A
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2020 11:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgCQKly (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Mar 2020 06:41:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgCQKly (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 17 Mar 2020 06:41:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C72ADAED2;
        Tue, 17 Mar 2020 10:41:50 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker\@Netapp.com" <Anna.Schumaker@Netapp.com>
Date:   Tue, 17 Mar 2020 21:41:44 +1100
Cc:     "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/RFC] NFS: Minimize COMMIT calls during writeback.
In-Reply-To: <d841ade018c9b90a74e7977243bf0975b87c4365.camel@hammerspace.com>
References: <87y2s1rwof.fsf@notabene.neil.brown.name> <b557a1d43105b42b304a2682ce8e2c31637e1989.camel@hammerspace.com> <87v9n5rmrz.fsf@notabene.neil.brown.name> <d841ade018c9b90a74e7977243bf0975b87c4365.camel@hammerspace.com>
Message-ID: <87eetrs1p3.fsf@notabene.neil.brown.name>
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

> On Mon, 2020-03-16 at 14:39 +1100, NeilBrown wrote:
>> On Mon, Mar 16 2020, Trond Myklebust wrote:
>>=20
>> > On Mon, 2020-03-16 at 11:05 +1100, NeilBrown wrote:
>> > > Since 4.13 (see Fixes: commit) NFS has sent a COMMIT request for
>> > > every
>> > > .writepages() call it received - when the writes submitted for
>> > > that
>> > > call
>> > > have all completed.
>> > >=20
>> > > This works well enough when COMMIT is fast, but if COMMIT is slow
>> > > these
>> > > calls can overlap each other, overload the server, and
>> > > substantially
>> > > reduce throughput.
>> > >=20
>> > > I looked at this due to a report of regression when writing to a
>> > > Ganesha
>> > > NFS server with tracing showing multiple overlapping COMMITs, and
>> > > individual commits typically taking 200ms to 300ms.  This
>> > > resulted in
>> > > 2
>> > > orders of magnitude slow down when writing 1000x1M from /dev/zero
>> > > with dd.
>> > > This is easily reproduced by adding 'msleep(300)' to
>> > > nfsd_commit() in
>> > > the
>> > > Linux NFS server.
>> >=20
>> > When there is overlap of writeback to the same file, then it is
>> > almost
>> > always because we're hitting memory reclaim on the client. In that
>> > case
>> > we want to ensure that memory reclaim completes, which it won't do
>> > if
>> > we delay COMMIT.
>> > IOW: this behaviour is very much intentional.
>>=20
>> What do you mean by "overlap of writeback" ?
>> The ->writepages calls are sequential - they don't overlap.
>> The WRITE rpcs are asynchronous so of course they overlap.
>> The COMMITs are expected to overlap with subsequent WRITEs.
>> It is only when COMMITs overlap with COMMITs that I think we might
>> overload the server, and I cannot see how that would ever be a useful
>> thing to do.
>>=20
>
> I mean that the NFS writeback code has exactly two cases where it
> starts to write out data before an fsync() or close() forces it to do
> so:
>
> 1) Read of a page that was written to, but not up to date
> 2) Memory pressure.
>
> IOW: If you're seeing overlapping commits, it is due to a situation
> where we're trying to free up the pages as soon as possible.
>
>> In the cases I've experiment with there is plenty of memory, but the
>> total write size exceeds dirty_threshold, so writeout starts to limit
>> the amount of dirty memory.  Certainly we want the COMMIT promptly as
>> a group of writes finish, but that group doesn't need to be tiny.
>>=20
>> (Our initial explorations found that increasing dirty_threshold to
>> larger than the write size restored normal performance)
>>=20
>
> That's the definition of memory pressure here. It's not the job of the
> filesystem to second guess what is going on in the higher layers. Its
> job is to write out data as quickly as possible when asked to do so.

Fair enough.  I don't usually think of writeback as due to memory
pressure, but I can see that I filesystem wouldn't much care for the
distinction.

Still there is no overlap imposed by the VM.  The VM is sending a
sensible streak of writepages requests - as dd dirties more pages, the
VM asks NFS to write out more pages.  All in a nice orderly fashion.

>
>> > > This patch changes the details of when COMMIT is sent without
>> > > changing
>> > > the general approach.
>> > >=20
>> > > Where previously the writes from a single .writepages() call were
>> > > accounted together in a nfs_io_completion, now the writes from
>> > > multiple
>> > > writepages() calls are accounted together.  The set of writepages
>> > > calls
>> > > that are grouped together are all those from when one COMMIT call
>> > > ends
>> > > to when the next COMMIT call ends.  This automatically reduces
>> > > the
>> > > rate
>> > > of COMMIT requests when COMMIT itself is slow.
>> > > (If there are no COMMIT calls pending, the first .writepages will
>> > > get
>> > >  an nfs_io_completion to itself, then subsequenct writepages
>> > > requests
>> > >  until the first COMMIT completes will go in the next
>> > > nfs_io_completion)
>> > >=20
>> > > There are typically at most two nfs_io_completion structures
>> > > allocated
>> > > for writeback to a given inode.
>> > >=20
>> > > - If there was been any writepages calls since the last time a
>> > > COMMIT
>> > >   completed, there will be an nfs_io_completion stored in the
>> > > inode
>> > > (in
>> > >   nfs_mds_commit_info) which new writepages requests are
>> > > accounted
>> > > it.
>> > >=20
>> > > - If there is no pending COMMIT request, but there are pending
>> > > writeback
>> > >   WRITES, there will be another nfs_io_completion which is not
>> > > attached
>> > >   and which is draining.  When it fully drains a COMMIT will be
>> > > sent.
>> > >   When that COMMIT completes, the attached nfs_io_completion will
>> > > be
>> > >   detached and allowed to drain.
>> > >=20
>> > > The rpcs_out counter now counts the unattached nfs_io_completion
>> > > as
>> > > well
>> > > as any pending COMMIT requests.  As an unattached
>> > > nfs_io_completion
>> > > will
>> > > soon turn into a COMMIT request, this seems reasonable.  It
>> > > allows us
>> > > to
>> > > clearly detect when there are no longer any COMMITs expected to
>> > > complete, so we know to detach any nfs_io_completion from the
>> > > inode
>> > > and
>> > > allow it to drain.
>> > >=20
>> > > As we use atomic accesses (e.g.  xchg and kref_get_unless_zero())
>> > > to
>> > > access the attached nfs_io_completion, we now use kfree_rcu() to
>> > > free
>> > > it, to ensure it is not accessed after it is freed.
>> > >=20
>> > > With 300ms commits, this improves throught of a 1G dd by 2 orders
>> > > of
>> > > magnitude.  Even without the 300ms delay, this noticeably
>> > > improves
>> > > throughput to a Linux NFS server is a simple VM.
>> > >=20
>> > > Fixes: 919e3bd9a875 ("NFS: Ensure we commit after writeback is
>> > > complete")
>> > > Signed-off-by: NeilBrown <neilb@suse.de>
>> > > ---
>> > >  fs/nfs/inode.c          |  1 +
>> > >  fs/nfs/write.c          | 50
>> > > ++++++++++++++++++++++++++++++++++++---
>> > > --
>> > >  include/linux/nfs_xdr.h |  7 ++++++
>> > >  3 files changed, 53 insertions(+), 5 deletions(-)
>> > >=20
>> > > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
>> > > index 11bf15800ac9..c00b54491949 100644
>> > > --- a/fs/nfs/inode.c
>> > > +++ b/fs/nfs/inode.c
>> > > @@ -2110,6 +2110,7 @@ static void init_once(void *foo)
>> > >  	INIT_LIST_HEAD(&nfsi->commit_info.list);
>> > >  	atomic_long_set(&nfsi->nrequests, 0);
>> > >  	atomic_long_set(&nfsi->commit_info.ncommit, 0);
>> > > +	nfsi->commit_info.ioc =3D NULL;
>> > >  	atomic_set(&nfsi->commit_info.rpcs_out, 0);
>> > >  	init_rwsem(&nfsi->rmdir_sem);
>> > >  	mutex_init(&nfsi->commit_mutex);
>> > > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
>> > > index c478b772cc49..57e209f964e4 100644
>> > > --- a/fs/nfs/write.c
>> > > +++ b/fs/nfs/write.c
>> > > @@ -47,6 +47,7 @@ struct nfs_io_completion {
>> > >  	void (*complete)(void *data);
>> > >  	void *data;
>> > >  	struct kref refcount;
>> > > +	struct rcu_head rcu;
>> > >  };
>> > >=20=20
>> > >  /*
>> > > @@ -134,7 +135,7 @@ static void nfs_io_completion_release(struct
>> > > kref
>> > > *kref)
>> > >  	struct nfs_io_completion *ioc =3D container_of(kref,
>> > >  			struct nfs_io_completion, refcount);
>> > >  	ioc->complete(ioc->data);
>> > > -	kfree(ioc);
>> > > +	kfree_rcu(ioc, rcu);
>> > >  }
>> > >=20=20
>> > >  static void nfs_io_completion_get(struct nfs_io_completion *ioc)
>> > > @@ -720,6 +721,8 @@ static void nfs_io_completion_commit(void
>> > > *inode)
>> > >  	nfs_commit_inode(inode, 0);
>> > >  }
>> > >=20=20
>> > > +static void nfs_commit_end(struct nfs_mds_commit_info *cinfo);
>> > > +
>> > >  int nfs_writepages(struct address_space *mapping, struct
>> > > writeback_control *wbc)
>> > >  {
>> > >  	struct inode *inode =3D mapping->host;
>> > > @@ -729,9 +732,37 @@ int nfs_writepages(struct address_space
>> > > *mapping, struct writeback_control *wbc)
>> > >=20=20
>> > >  	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGES);
>> > >=20=20
>> > > -	ioc =3D nfs_io_completion_alloc(GFP_KERNEL);
>> > > -	if (ioc)
>> > > -		nfs_io_completion_init(ioc, nfs_io_completion_commit,
>> > > inode);
>> > > +	rcu_read_lock();
>> > > +	ioc =3D rcu_dereference(NFS_I(inode)->commit_info.ioc);
>> > > +	if (ioc && kref_get_unless_zero(&ioc->refcount)) {
>> > > +		rcu_read_unlock();
>> > > +		/* We've successfully piggybacked on the attached ioc
>> > > */
>> > > +	} else {
>> > > +		rcu_read_unlock();
>> > > +		ioc =3D nfs_io_completion_alloc(GFP_KERNEL);
>> > > +		if (ioc) {
>> > > +			struct nfs_io_completion *ioc_prev;
>> > > +
>> > > +			nfs_io_completion_init(ioc,
>> > > nfs_io_completion_commit,
>> > > +					       inode);
>> > > +			/* Temporarily elevate rpcs_out to ensure a
>> > > commit
>> > > +			 * completion *will* happen after we attach
>> > > this ioc,
>> > > +			 * so it *will* get a chance to drain.
>> > > +			 */
>> > > +			atomic_inc(&NFS_I(inode)-
>> > > > commit_info.rpcs_out);
>> > > +			nfs_io_completion_get(ioc);
>> > > +			ioc_prev =3D xchg(&NFS_I(inode)->commit_info.ioc,
>> > > +				    ioc);
>> > > +			/* ioc_prev is normally NULL, but racing
>> > > writepages
>> > > +			 * calls might result in it being non-NULL.
>> > > +			 * In either case it is safe to put it - worst
>> > > case
>> > > +			 * we get an extra COMMIT.
>> > > +			 */
>> > > +			nfs_io_completion_put(ioc_prev);
>> > > +			/* release temporary ref on rpcs_out */
>> > > +			nfs_commit_end(&NFS_I(inode)->commit_info);
>> >=20
>> > So won't this normally trigger the xchg(NULL) in nfs_commmit_end()?
>> > For
>> > most cases, I'd expect commit_info.rpcs_out to be zero until we
>> > start
>> > actually sending out the COMMITs.
>>=20
>> On the first writepages call after a period of quiet, that is exactly
>> correct.  The ioc that we have just allocated and attached will
>> immediately be detached.  It will have a refcount of 1 at this point
>> so
>> nothing further happens.
>> Then WRITEs get queued elevating the refcount.  This will eventually
>> drain and a COMMIT will be sent.  So the behaviour for the firstpages
>> call is exactly like the current code (I think I mentioned that in
>> the
>> commit message).
>> If the WRITEs and COMMIT complete before the next .writepages, then
>> that
>> writepages will behave the same way.
>> But if the WRITEs or COMMIT are still pending, then rpcs_out will
>> still
>> be elevated....
>> Only - no.  Unattached iocs are meant to be counted in rpcs_out, but
>> I
>> haven't got that right.  So we can still end up with parallel
>> COMMITs.
>> I think that might explain some slightly odd numbers in my testing.
>>=20
>> Here is the new version.
>>=20
>> Thanks for the review.
>>=20
>> NeilBrown
>>=20
>> From: NeilBrown <neilb@suse.de>
>> Subject: [PATCH] NFS: Minimize COMMIT calls during writeback.
>>=20
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
>>=20
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
>>  fs/nfs/write.c          | 69 +++++++++++++++++++++++++++++++++++++
>> ----
>>  include/linux/nfs_xdr.h |  7 +++++
>>  3 files changed, 71 insertions(+), 6 deletions(-)
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
>> index c478b772cc49..6dbb055f80bf 100644
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
>> @@ -715,9 +716,15 @@ static int nfs_writepages_callback(struct page
>> *page, struct writeback_control *
>>  	return ret;
>>  }
>>=20=20
>> +static void nfs_commit_end(struct nfs_mds_commit_info *cinfo);
>> +
>>  static void nfs_io_completion_commit(void *inode)
>>  {
>>  	nfs_commit_inode(inode, 0);
>> +	/* this came from a detached nfs_io_completion, which is now
>> +	 * no longer active, so must decrement rpcs_out.
>> +	 */
>> +	nfs_commit_end(&NFS_I(inode)->commit_info);
>>  }
>>=20=20
>>  int nfs_writepages(struct address_space *mapping, struct
>> writeback_control *wbc)
>> @@ -729,9 +736,46 @@ int nfs_writepages(struct address_space
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
>> +			/* This is now a detached ioc so we count it in
>> +			 * rpcs_out.  *After* we successfully attach it
>> +			 * below (likely, but not certain), we will
>> call
>> +			 * nfs_commit_end() which might detach it
>> immedately
>> +			 * if there are no outstanding commit.
>> +			 */
>> +			atomic_inc(&NFS_I(inode)-
>> >commit_info.rpcs_out);
>
> commit_info.rpcs_out is there in order to count the number of
> outstanding COMMITs. I'm not seeing why we need to change that
> definition, particularly given that there can be processes out there
> that are trying to wait for the count to go to zero.
>
> The I/O completion structure already has its own reference counter, and
> I can see nothing stopping you from modifying
> nfs_io_completion_commit() to do the same things you are trying to do
> in nfs_commit_end() here.

I don't see how that would work.
There are two events that need to happen asynchronously when a counter
hits zero.
One is that a COMMIT needs to be sent when the number of outstanding
writes from a particular set hits zero.  That is the nfs_io_completion
counter.
The other is that the currently growing set of pending commits needs to
be detached and allowed to drain so that another COMMIT will get sent.
This is what I'm using rpcs_out for.  It seems quite a natural extension
of its current use.

>
> However as I said, I have my doubts as to whether or not this is a good
> idea. It sounds to me as if you're trying to fix a memory management
> layer problem in the NFS layer.

I guess we really need to resolve this issue before we put too much
effort into sorting out differences over the code.

This is certainly not a memory management layer problem.  The MM layer
is doing exactly what it should - sending an orderly sequence of
writepages requests to the filesystem in response to relevant limits or
timeouts being reached.

NFS is putting these into effect by sending out WRITE requests for the
chosen pages, just as it should.

It is also sending COMMIT requests and this is where the problem lies.
It sometimes sends too many.

Clearly (I hope) sending one COMMIT request for every WRITE request
would be too many.  At the other end of the spectrum, only sending a
COMMIT when there are no out standing WRITEs and haven't been for some
time would be far too few.  We need something in between.

The current behaviour is to send one COMMIT for every writepages call.
This often works well but is quite arbitrary.  It ties details of the
NFS protocol to unrelated details of the MM behaviour which is not
designed to meet the specific needs of NFS.

This behaviour results in extremely poor performance in some
circumstances when COMMIT takes a long time - e.g. 300ms.  As the
frequency of COMMIT messages is tied to the behaviour of the MM, and not
the behaviour of the server, it can do things that hurt the server.
In particularly it can easily send COMMIT messages more frequently than
can be handled, which can overload the server.

I think it makes much more sense to tie the frequency of the COMMIT
messages to the speed at which the server replies to them, and in
particular only have a single COMMIT outstanding at a time.
Whether we then want to send a COMMIT immediately after the last one
returns, or after a short delay or with some other heuristic is
something I'm quite willing to discuss.  I have a solution that I like
but there might be a better one.

But can we at least agree that sending multiple concurrent COMMIT
requests is unlikely to be helpful, and to achieve this we need to let
the behaviour of the server affect the frequency of COMMITs??

Thanks,
NeilBrown


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl5wqWgACgkQOeye3VZi
gbkz/RAAl+8mzMqalgP/hWsJWgyvb3oic7XPLBv3YqRg5CWcLSHTnmK1jNe+NgJX
xArrDGTSi/263mi1rI6O8VI2a30Bk93JJfPMs/uY4Lqs58tccDkHUesvU4oRU3LK
gv7n3Zyqj9Ppup1d25zBLosSNy5+f3j5EuS1dpbXPYTUxoLdkFtVmoBdsREa5t5a
3HGWEKAm6Wcd2ej5mNiS+R6r/s/jLvzw78TTxqrpxLKuWGhzmxngQbM22yF5K17H
ifseUScdfcKzMm55Hs2Z/eg//X0e5MjIAIYGQ6WFSUKnd/ZpL7lDETx5E6vsIVqZ
aumjzfjt3hnkxh/uORvNbsR68KOpqAoohswfs5C5giRJYLcIq98odFRpLq8yWhTT
m/5ODk2B9AGIeni1CIwvG5jNNbcr6RXUtVuQh97sIML10lVYjdiGS/ylBqlPVg3M
CtyTRX2rkqhojlNmrNXRFVq0Zowl0QXSBTW+ZsCbyc4jTliLwHUKDTk6cpPM2vPT
UCwbmw4A/UcV8iVHrBNEOgCHGu4RvFHRMqtfZeZzqME2DV5G2lwx/G4QemGGVIhf
A6e6j7l4j6oEXhSL0iLZ2g0tFqZB8mF7p5roOhW1UzTsSMhUBxe/7DnH9eoi59rF
oSPeAKmjBqsQzlgvDN9ApF3qbErthCxIuG+wyiSxo4Y5rYcVjCE=
=m4O5
-----END PGP SIGNATURE-----
--=-=-=--
