Return-Path: <linux-nfs+bounces-11226-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A96A98507
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 11:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A6C18866FA
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 09:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BCF1F4CA6;
	Wed, 23 Apr 2025 09:09:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D17225402
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399391; cv=none; b=OvJyptfMqmor40fwgz1qfaJIC9bhNPXDdH2icfquzINmRcgCRr8J11Lg5bCpXjnt5qIwgvt1HtFvy3CEwCDq83U6DcSaj6J5ZttEkPnHjEc7QNtkmQoWDDi/VBuWzB5xnH2P0tAuEKIvghAYN+OlZAvU43HrOdh/OVSVFrheSLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399391; c=relaxed/simple;
	bh=JMTyEa1AxC97lGbw1W6eVctuAw4pn62PsNbioKh5hyo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OMj3QmK7qEx6N48sA9gK7KcH9kqmCsY92HJ/+K+oSV6VNTEqsuCKHLR9LqoGlae7Z77VQ/QVfy4l3e1L0a7TAQnubTXUnt9U/Fc/xYVOAdyF1DQYyPhUvd8lICwpeew56p+OlWyBCPmrNggXwV+Yby+JJTcizCDxRK1xkjxjr48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1u7W6u-000ZwU-Nm;
	Wed, 23 Apr 2025 09:09:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neil@brown.name>
To: "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>
Cc: Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
 "Mike Snitzer" <snitzer@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Anna Schumaker" <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org,
 "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>
Subject: Re: [PATCH v2] nfs: add dummy definition for nfsd_file
In-reply-to: <8c67a295-8caa-4e53-a764-f691657bbe62@wanadoo.fr>
References: <>, <8c67a295-8caa-4e53-a764-f691657bbe62@wanadoo.fr>
Date: Wed, 23 Apr 2025 19:09:40 +1000
Message-id: <174539938027.500591.1190076221216165031@noble.neil.brown.name>

On Wed, 23 Apr 2025, Vincent Mailhol wrote:
> On 23/04/2025 at 09:32, NeilBrown wrote:
> > On Wed, 23 Apr 2025, Pali Roh=C3=A1r wrote:
> >> On Wednesday 23 April 2025 07:54:40 NeilBrown wrote:
> >>> On Wed, 23 Apr 2025, Pali Roh=C3=A1r wrote:
>=20
> (...)
>=20
> >>> Actually I do object to this fix (though I've been busy and hadn't had
> >>> much change to look at it properly).
> >>> The fix is ugly.  At the very least it should be wrapping in an=20
> >>>    #if  GCC_VERSION  < whatever
>=20
> I acknowledge that the fix is a bit ugly, but Mike is the only one who
> has proposed a solution so far.

FYI here is my current patch which fixes this problem and a few other
problems, but doesn't fix everything I (think I) have found, and may
introduce some problems because some of the interactions are subtle and
need careful review.

Once I'm confident of it I hope to break it up into individual patches
and submit.

The key idea for fixing this problem is to pass a pointer to the rcu
pointer to the function on the nfsd side where it can dereference it
sensibly.
I haven't got all the rcu annotations right yet so build testing isn't
completely conclusive.

I think the pointer that is passed to nfsd needs to be

   struct nfsd_file * __rcu * nfp;

i.e.  the __rcu needs to be between the two "*".  But to test that I
would need a newer sparse (I hope that will be sufficient).  My current
sparse install spits way too many errors to be taken seriously.

NeilBrown


diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 5c21caeae075..4ae499290312 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -207,11 +207,6 @@ void nfs_local_probe_async(struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe_async);
=20
-static inline struct nfsd_file *nfs_local_file_get(struct nfsd_file *nf)
-{
-	return nfs_to->nfsd_file_get(nf);
-}
-
 static inline void nfs_local_file_put(struct nfsd_file *nf)
 {
 	nfs_to->nfsd_file_put(nf);
@@ -226,12 +221,13 @@ static inline void nfs_local_file_put(struct nfsd_file =
*nf)
 static struct nfsd_file *
 __nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		    struct nfs_fh *fh, struct nfs_file_localio *nfl,
+		    struct nfsd_file **pnf,
 		    const fmode_t mode)
 {
 	struct nfsd_file *localio;
=20
 	localio =3D nfs_open_local_fh(&clp->cl_uuid, clp->cl_rpcclient,
-				    cred, fh, nfl, mode);
+				    cred, fh, nfl, pnf, mode);
 	if (IS_ERR(localio)) {
 		int status =3D PTR_ERR(localio);
 		trace_nfs_local_open_fh(fh, mode, status);
@@ -258,7 +254,7 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cr=
ed *cred,
 		  struct nfs_fh *fh, struct nfs_file_localio *nfl,
 		  const fmode_t mode)
 {
-	struct nfsd_file *nf, *new, __rcu **pnf;
+	struct nfsd_file *nf, **pnf;
=20
 	if (!nfs_server_is_local(clp))
 		return NULL;
@@ -270,29 +266,9 @@ nfs_local_open_fh(struct nfs_client *clp, const struct c=
red *cred,
 	else
 		pnf =3D &nfl->ro_file;
=20
-	new =3D NULL;
-	rcu_read_lock();
-	nf =3D rcu_dereference(*pnf);
-	if (!nf) {
-		rcu_read_unlock();
-		new =3D __nfs_local_open_fh(clp, cred, fh, nfl, mode);
-		if (IS_ERR(new))
-			return NULL;
-		/* try to swap in the pointer */
-		spin_lock(&clp->cl_uuid.lock);
-		nf =3D rcu_dereference_protected(*pnf, 1);
-		if (!nf) {
-			nf =3D new;
-			new =3D NULL;
-			rcu_assign_pointer(*pnf, nf);
-		}
-		spin_unlock(&clp->cl_uuid.lock);
-		rcu_read_lock();
-	}
-	nf =3D nfs_local_file_get(nf);
-	rcu_read_unlock();
-	if (new)
-		nfs_to_nfsd_file_put_local(new);
+	nf =3D __nfs_local_open_fh(clp, cred, fh, nfl, pnf, mode);
+	if (IS_ERR(nf))
+		return NULL;
 	return nf;
 }
 EXPORT_SYMBOL_GPL(nfs_local_open_fh);
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 6a0bdea6d644..6a5047af1357 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -152,7 +152,7 @@ EXPORT_SYMBOL_GPL(nfs_localio_enable_client);
 static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 {
 	LIST_HEAD(local_files);
-	struct nfs_file_localio *nfl, *tmp;
+	struct nfs_file_localio *nfl;
=20
 	spin_lock(&nfs_uuid->lock);
 	if (unlikely(!rcu_access_pointer(nfs_uuid->net))) {
@@ -167,17 +167,35 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 	}
=20
 	list_splice_init(&nfs_uuid->files, &local_files);
-	spin_unlock(&nfs_uuid->lock);
=20
 	/* Walk list of files and ensure their last references dropped */
-	list_for_each_entry_safe(nfl, tmp, &local_files, list) {
-		nfs_close_local_fh(nfl);
-		cond_resched();
+	while ((nfl =3D list_first_entry_or_null(&nfs_uuid->files,
+					       struct nfs_file_localio,
+					       list)) !=3D NULL) {
+		/* If nfs_uuid is already NULL, nfs_close_local_fh is
+		 * closing and we must wait, else we unlink and close.
+		 */
+		if (nfl->nfs_uuid) {
+			list_del_init(&nfl->list);
+			spin_unlock(&nfs_uuid->lock);
+			nfs_to_nfsd_file_put_local(&nfl->ro_file);
+			nfs_to_nfsd_file_put_local(&nfl->rw_file);
+			cond_resched();
+			spin_lock(&nfs_uuid->lock);
+			store_release_wake_up(&nfl->nfs_uuid, NULL);
+		} else {
+			/* nfs_close_local_fh() is doing the
+			 * close and we must wait. until it unlinks
+			 */
+			wait_var_event_spinlock(nfl,
+						list_first_entry_or_null(
+							&nfs_uuid->files,
+							struct nfs_file_localio,
+							list) !=3D nfl,
+						&nfs_uuid->lock);
+		}
 	}
=20
-	spin_lock(&nfs_uuid->lock);
-	BUG_ON(!list_empty(&nfs_uuid->files));
-
 	/* Remove client from nn->local_clients */
 	if (nfs_uuid->list_lock) {
 		spin_lock(nfs_uuid->list_lock);
@@ -237,7 +255,7 @@ static void nfs_uuid_add_file(nfs_uuid_t *nfs_uuid, struc=
t nfs_file_localio *nfl
 struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
 		   const struct nfs_fh *nfs_fh, struct nfs_file_localio *nfl,
-		   const fmode_t fmode)
+		   struct nfsd_file **pnf, const fmode_t fmode)
 {
 	struct net *net;
 	struct nfsd_file *localio;
@@ -261,7 +279,7 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	rcu_read_unlock();
 	/* We have an implied reference to net thanks to nfsd_net_try_get */
 	localio =3D nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
-					     cred, nfs_fh, fmode);
+					     cred, nfs_fh, pnf, fmode);
 	if (IS_ERR(localio))
 		nfs_to_nfsd_net_put(net);
 	else
@@ -273,8 +291,6 @@ EXPORT_SYMBOL_GPL(nfs_open_local_fh);
=20
 void nfs_close_local_fh(struct nfs_file_localio *nfl)
 {
-	struct nfsd_file *ro_nf =3D NULL;
-	struct nfsd_file *rw_nf =3D NULL;
 	nfs_uuid_t *nfs_uuid;
=20
 	rcu_read_lock();
@@ -285,28 +301,42 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 		return;
 	}
=20
-	ro_nf =3D rcu_access_pointer(nfl->ro_file);
-	rw_nf =3D rcu_access_pointer(nfl->rw_file);
-	if (ro_nf || rw_nf) {
-		spin_lock(&nfs_uuid->lock);
-		if (ro_nf)
-			ro_nf =3D rcu_dereference_protected(xchg(&nfl->ro_file, NULL), 1);
-		if (rw_nf)
-			rw_nf =3D rcu_dereference_protected(xchg(&nfl->rw_file, NULL), 1);
-
-		/* Remove nfl from nfs_uuid->files list */
-		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
-		list_del_init(&nfl->list);
+	spin_lock(&nfs_uuid->lock);
+	if (!rcu_access_pointer(nfl->nfs_uuid)) {
+		/* nfs_uuid_put has finished here */
 		spin_unlock(&nfs_uuid->lock);
 		rcu_read_unlock();
-
-		if (ro_nf)
-			nfs_to_nfsd_file_put_local(ro_nf);
-		if (rw_nf)
-			nfs_to_nfsd_file_put_local(rw_nf);
 		return;
 	}
+	if (list_empty(&nfs_uuid->files)) {
+		/* nfs_uuid_put() has started closing files, wait for it
+		 * to finished
+		 */
+		spin_unlock(&nfs_uuid->lock);
+		rcu_read_unlock();
+		wait_var_event(&nfl->nfs_uuid,
+			       rcu_access_pointer(nfl->nfs_uuid) =3D=3D NULL);
+		return;
+	}
+	/* tell nfs_uuid_put to wait for us */
+	RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
+	spin_unlock(&nfs_uuid->lock);
 	rcu_read_unlock();
+
+	nfs_to_nfsd_file_put_local(&nfl->ro_file);
+	nfs_to_nfsd_file_put_local(&nfl->rw_file);
+
+	rcu_read_lock();
+	if (WARN_ON(nfl->nfs_uuid !=3D nfs_uuid)) {
+		rcu_read_unlock();
+		return;
+	}
+	spin_lock(&nfs_uuid->lock);
+	list_del_init(&nfl->list);
+	wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
+	spin_unlock(&nfs_uuid->lock);
+
+	return;
 }
 EXPORT_SYMBOL_GPL(nfs_close_local_fh);
=20
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ab85e6a2454f..a20cc691c60a 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -378,11 +378,15 @@ nfsd_file_put(struct nfsd_file *nf)
  * the reference of the nfsd_file.
  */
 struct net *
-nfsd_file_put_local(struct nfsd_file *nf)
+nfsd_file_put_local(struct nfsd_file **nfp)
 {
-	struct net *net =3D nf->nf_net;
+	struct nfsd_file *nf =3D xchg(nfp, NULL);
+	struct net *net =3D NULL;
=20
-	nfsd_file_put(nf);
+	if (nf) {
+		net =3D nf->nf_net;
+		nfsd_file_put(nf);
+	}
 	return net;
 }
=20
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 238647fa379e..bafba15e905d 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -29,7 +29,6 @@ static const struct nfsd_localio_operations nfsd_localio_op=
s =3D {
 	.nfsd_net_put  =3D nfsd_net_put,
 	.nfsd_open_local_fh =3D nfsd_open_local_fh,
 	.nfsd_file_put_local =3D nfsd_file_put_local,
-	.nfsd_file_get =3D nfsd_file_get,
 	.nfsd_file_put =3D nfsd_file_put,
 	.nfsd_file_file =3D nfsd_file_file,
 };
@@ -47,6 +46,7 @@ void nfsd_localio_ops_init(void)
  * @rpc_clnt: rpc_clnt that the client established
  * @cred: cred that the client established
  * @nfs_fh: filehandle to lookup
+ * @pnf: pointer to storage for result. If already non-NULL, just get ref an=
d return.
  * @fmode: fmode_t to use for open
  *
  * This function maps a local fh to a path on a local filesystem.
@@ -60,7 +60,8 @@ void nfsd_localio_ops_init(void)
 struct nfsd_file *
 nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
-		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
+		   const struct nfs_fh *nfs_fh, struct nfsd_file *pnf,
+		   const fmode_t fmode)
 {
 	int mayflags =3D NFSD_MAY_LOCALIO;
 	struct svc_cred rq_cred;
@@ -71,6 +72,12 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *do=
m,
 	if (nfs_fh->size > NFS4_FHSIZE)
 		return ERR_PTR(-EINVAL);
=20
+	rcu_read_lock();
+	localio =3D nfsd_file_get(rcu_dereference(*pnf));
+	rcu_read_unlock();
+	if (localio)
+		return localio;
+
 	/* nfs_fh -> svc_fh */
 	fh_init(&fh, NFS4_FHSIZE);
 	fh.fh_handle.fh_size =3D nfs_fh->size;
@@ -92,6 +99,25 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *do=
m,
 	if (rq_cred.cr_group_info)
 		put_group_info(rq_cred.cr_group_info);
=20
+	if (!IS_ERR(localio)) {
+		struct nfsd_file *new;
+		rcu_read_lock();
+		nfsd_file_get(localio);
+	again:
+		new =3D cmpxchg(pnf, NULL, localio);
+		if (new) {
+			/* Some other thread installed an nfsd_file */
+			if (nfsd_file_get(new) =3D=3D NULL)
+				goto again;
+			/*
+			 * Drop the ref we were going to install and the
+			 * one we were going to return.
+			 */
+			nfsd_file_put(localio);
+			nfsd_file_put(localio);
+			localio =3D new;
+		}
+	}
 	return localio;
 }
 EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 9aa8a43843d7..9b34af9d4238 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -64,9 +64,9 @@ struct nfsd_localio_operations {
 						struct rpc_clnt *,
 						const struct cred *,
 						const struct nfs_fh *,
+						struct nfsd_file **,
 						const fmode_t);
-	struct net *(*nfsd_file_put_local)(struct nfsd_file *);
-	struct nfsd_file *(*nfsd_file_get)(struct nfsd_file *);
+	struct net *(*nfsd_file_put_local)(struct nfsd_file **);
 	void (*nfsd_file_put)(struct nfsd_file *);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
 } ____cacheline_aligned;
@@ -77,7 +77,7 @@ extern const struct nfsd_localio_operations *nfs_to;
 struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
 		   struct rpc_clnt *, const struct cred *,
 		   const struct nfs_fh *, struct nfs_file_localio *,
-		   const fmode_t);
+		   struct nfsd_file **pnf, const fmode_t);
=20
 static inline void nfs_to_nfsd_net_put(struct net *net)
 {
@@ -91,14 +91,14 @@ static inline void nfs_to_nfsd_net_put(struct net *net)
 	rcu_read_unlock();
 }
=20
-static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
+static inline void nfs_to_nfsd_file_put_local(struct nfsd_file **localiop)
 {
 	/*
 	 * Must not hold RCU otherwise nfsd_file_put() can easily trigger:
 	 * "Voluntary context switch within RCU read-side critical section!"
 	 * by scheduling deep in underlying filesystem (e.g. XFS).
 	 */
-	struct net *net =3D nfs_to->nfsd_file_put_local(localio);
+	struct net *net =3D nfs_to->nfsd_file_put_local(localiop);
=20
 	nfs_to_nfsd_net_put(net);
 }

