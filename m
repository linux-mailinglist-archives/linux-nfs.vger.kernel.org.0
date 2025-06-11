Return-Path: <linux-nfs+bounces-12340-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F4CAD6384
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 01:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45BD27A2DE9
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 23:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DD42561C2;
	Wed, 11 Jun 2025 22:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5KVNRsd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13462517AF;
	Wed, 11 Jun 2025 22:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682708; cv=none; b=GCaT+bdoZGWOuFU0amB5KLfp2l58rI4Ze4YrYjOTi53jHw8tmBmRZ1V0ROEL8glo+MzZjOfTupZVW5VKrxeuQGiGpxY6JMNASO6R5AU+UqywVI2P7IdANPI8SL3e51Zi8tSsU7bp0aQygHbqnHyI4pKpiK+hwAuMAyoKp0lKZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682708; c=relaxed/simple;
	bh=Jz7KQxqw8AvwiC5yF5NvhqsrEUzcFf30WSK7xO3MynA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ralPb06cbnDF17eBTLxUS4HCCmNrQHwSHwWtmLzCKIVGukMvyGJ3k9Yud0J+X/Q5kHzqJa4dzby/AIYXw4sc57p2Kxde0WvCQ3vffIIGqS24fK5bV+zA0kVMe0qKNBwNmR4HuZOTqcUZMamP911iZ4kyy02lo16XE0f6XLOxKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5KVNRsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18626C4CEE3;
	Wed, 11 Jun 2025 22:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749682708;
	bh=Jz7KQxqw8AvwiC5yF5NvhqsrEUzcFf30WSK7xO3MynA=;
	h=Date:From:To:Cc:Subject:From;
	b=o5KVNRsdkzwUhLptf0UPAyq01Ky8hwEnxTgBFzk34vTfU75Lq35i+1c5kesg72851
	 pxMbW4fStzYk8WlcFMIpHiBil5vRMiMAFMcbEMFPLsThtFUUJ2w3syjLKl7tY6Gs4j
	 UqyAl45VsMxr7yjj8pZTUdQv227Zrloi69U4lFfDs7TbjXjSmao8deCA/b6haIAh1+
	 UlGM/pOpJqjjoQtalorX6BRQh95SK5f2rJL+YO1oO43gR11JoHCD0QlWLnum3gNyRe
	 6lYd2b1uCQBoTSYlcsjIwUOjFfaaREHHOVaDzD24169wjAxYXxjKkGOzhPPTbGkTHW
	 izO5EXxePItlw==
Date: Wed, 11 Jun 2025 16:58:18 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] NFSD: Avoid multiple -Wflex-array-member-not-at-end
 warnings
Message-ID: <aEoKCuQ1YDs2Ivn0@kspp>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Update `struct knfsd_fh` to use indices into the `fh_raw` array,
allowing removal of the flexible-array member `fh_fsid[]`. Refactor
related code accordingly.

With this changes, fix many instances of the following type of
warnings:

fs/nfsd/nfsfh.h:79:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/state.h:763:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/state.h:669:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/state.h:549:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/xdr4.h:705:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/xdr4.h:678:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Co-developed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use indices into `fh_raw`. (Christoph)
 - Remove union and flexible-array member `fh_fsid`. (Christoph)

v1:
 - Link: https://lore.kernel.org/linux-hardening/aBp37ZXBJM09yAXp@kspp/

 fs/nfsd/export.c      |  2 +-
 fs/nfsd/export.h      |  2 +-
 fs/nfsd/nfs4layouts.c | 10 ++++----
 fs/nfsd/nfsfh.c       | 58 +++++++++++++++++++++++--------------------
 fs/nfsd/nfsfh.h       | 30 +++++++++++-----------
 5 files changed, 52 insertions(+), 50 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 88ae410b4113..654d54a7148f 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1231,7 +1231,7 @@ rqst_exp_get_by_name(struct svc_rqst *rqstp, struct path *path)
 struct svc_export *
 rqst_exp_find(struct cache_req *reqp, struct net *net,
 	      struct auth_domain *cl, struct auth_domain *gsscl,
-	      int fsid_type, u32 *fsidv)
+	      int fsid_type, void *fsidv)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_export *gssexp, *exp = ERR_PTR(-ENOENT);
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index 4d92b99c1ffd..9b2719d8a3e2 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -131,6 +131,6 @@ static inline struct svc_export *exp_get(struct svc_export *exp)
 }
 struct svc_export *rqst_exp_find(struct cache_req *reqp, struct net *net,
 				 struct auth_domain *cl, struct auth_domain *gsscl,
-				 int fsid_type, u32 *fsidv);
+				 int fsid_type, void *fsidv);
 
 #endif /* NFSD_EXPORT_H */
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 290271ac4245..6dcd2c9ec15b 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -56,7 +56,7 @@ static void
 nfsd4_alloc_devid_map(const struct svc_fh *fhp)
 {
 	const struct knfsd_fh *fh = &fhp->fh_handle;
-	size_t fsid_len = key_len(fh->fh_fsid_type);
+	size_t fsid_len = key_len(fh->fh_raw[FH_FSID_TYPE]);
 	struct nfsd4_deviceid_map *map, *old;
 	int i;
 
@@ -64,8 +64,8 @@ nfsd4_alloc_devid_map(const struct svc_fh *fhp)
 	if (!map)
 		return;
 
-	map->fsid_type = fh->fh_fsid_type;
-	memcpy(&map->fsid, fh->fh_fsid, fsid_len);
+	map->fsid_type = fh->fh_raw[FH_FSID_TYPE];
+	memcpy(&map->fsid, fh->fh_raw + FH_FSID, fsid_len);
 
 	spin_lock(&nfsd_devid_lock);
 	if (fhp->fh_export->ex_devid_map)
@@ -73,9 +73,9 @@ nfsd4_alloc_devid_map(const struct svc_fh *fhp)
 
 	for (i = 0; i < DEVID_HASH_SIZE; i++) {
 		list_for_each_entry(old, &nfsd_devid_hash[i], hash) {
-			if (old->fsid_type != fh->fh_fsid_type)
+			if (old->fsid_type != map->fsid_type)
 				continue;
-			if (memcmp(old->fsid, fh->fh_fsid,
+			if (memcmp(old->fsid, map->fsid,
 					key_len(old->fsid_type)))
 				continue;
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index aef474f1b84b..01ff91a28fb6 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -161,37 +161,40 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 	if (fh->fh_size == 0)
 		return nfserr_nofilehandle;
 
-	if (fh->fh_version != 1)
+	if (fh->fh_raw[FH_VERSION] != 1)
 		return error;
 
 	if (--data_left < 0)
 		return error;
-	if (fh->fh_auth_type != 0)
+	if (fh->fh_raw[FH_AUTH_TYPE] != 0)
 		return error;
-	len = key_len(fh->fh_fsid_type) / 4;
+	len = key_len(fh->fh_raw[FH_FSID_TYPE]) / 4;
 	if (len == 0)
 		return error;
-	if (fh->fh_fsid_type == FSID_MAJOR_MINOR) {
+	if (fh->fh_raw[FH_FSID_TYPE] == FSID_MAJOR_MINOR) {
 		/* deprecated, convert to type 3 */
+		u32 *fsidv = (u32 *)(fh->fh_raw + FH_FSID);
+
 		len = key_len(FSID_ENCODE_DEV)/4;
-		fh->fh_fsid_type = FSID_ENCODE_DEV;
+		fh->fh_raw[FH_FSID_TYPE] = FSID_ENCODE_DEV;
 		/*
 		 * struct knfsd_fh uses host-endian fields, which are
 		 * sometimes used to hold net-endian values. This
 		 * confuses sparse, so we must use __force here to
 		 * keep it from complaining.
 		 */
-		fh->fh_fsid[0] = new_encode_dev(MKDEV(ntohl((__force __be32)fh->fh_fsid[0]),
-						      ntohl((__force __be32)fh->fh_fsid[1])));
-		fh->fh_fsid[1] = fh->fh_fsid[2];
+		fsidv[0] = new_encode_dev(MKDEV(
+			ntohl((__force __be32)fsidv[0]),
+			ntohl((__force __be32)fsidv[1])));
+		fsidv[1] = fsidv[2];
 	}
 	data_left -= len;
 	if (data_left < 0)
 		return error;
 	exp = rqst_exp_find(rqstp ? &rqstp->rq_chandle : NULL,
 			    net, client, gssclient,
-			    fh->fh_fsid_type, fh->fh_fsid);
-	fid = (struct fid *)(fh->fh_fsid + len);
+			    fh->fh_raw[FH_FSID_TYPE], fh->fh_raw + FH_FSID);
+	fid = (struct fid *)(fh->fh_raw + FH_FSID + len);
 
 	error = nfserr_stale;
 	if (IS_ERR(exp)) {
@@ -233,7 +236,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 	 */
 	error = nfserr_badhandle;
 
-	fileid_type = fh->fh_fileid_type;
+	fileid_type = fh->fh_raw[FH_FILEID_TYPE];
 
 	if (fileid_type == FILEID_ROOT)
 		dentry = dget(exp->ex_path.dentry);
@@ -463,18 +466,19 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
 {
 	if (dentry != exp->ex_path.dentry) {
 		struct fid *fid = (struct fid *)
-			(fhp->fh_handle.fh_fsid + fhp->fh_handle.fh_size/4 - 1);
+			(fhp->fh_handle.fh_raw + FH_FSID +
+			 fhp->fh_handle.fh_size - 1);
 		int maxsize = (fhp->fh_maxsize - fhp->fh_handle.fh_size)/4;
 		int fh_flags = (exp->ex_flags & NFSEXP_NOSUBTREECHECK) ? 0 :
 				EXPORT_FH_CONNECTABLE;
 		int fileid_type =
 			exportfs_encode_fh(dentry, fid, &maxsize, fh_flags);
 
-		fhp->fh_handle.fh_fileid_type =
+		fhp->fh_handle.fh_raw[FH_FILEID_TYPE] =
 			fileid_type > 0 ? fileid_type : FILEID_INVALID;
 		fhp->fh_handle.fh_size += maxsize * 4;
 	} else {
-		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
+		fhp->fh_handle.fh_raw[FH_FILEID_TYPE] = FILEID_ROOT;
 	}
 }
 
@@ -520,8 +524,8 @@ static void set_version_and_fsid_type(struct svc_fh *fhp, struct svc_export *exp
 retry:
 	version = 1;
 	if (ref_fh && ref_fh->fh_export == exp) {
-		version = ref_fh->fh_handle.fh_version;
-		fsid_type = ref_fh->fh_handle.fh_fsid_type;
+		version = ref_fh->fh_handle.fh_raw[FH_VERSION];
+		fsid_type = ref_fh->fh_handle.fh_raw[FH_FSID_TYPE];
 
 		ref_fh = NULL;
 
@@ -562,9 +566,9 @@ static void set_version_and_fsid_type(struct svc_fh *fhp, struct svc_export *exp
 		fsid_type = FSID_ENCODE_DEV;
 	else
 		fsid_type = FSID_DEV;
-	fhp->fh_handle.fh_version = version;
+	fhp->fh_handle.fh_raw[FH_VERSION] = version;
 	if (version)
-		fhp->fh_handle.fh_fsid_type = fsid_type;
+		fhp->fh_handle.fh_raw[FH_FSID_TYPE] = fsid_type;
 }
 
 __be32
@@ -610,18 +614,18 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 	fhp->fh_export = exp_get(exp);
 
 	fhp->fh_handle.fh_size =
-		key_len(fhp->fh_handle.fh_fsid_type) + 4;
-	fhp->fh_handle.fh_auth_type = 0;
+		key_len(fhp->fh_handle.fh_raw[FH_FSID_TYPE]) + 4;
+	fhp->fh_handle.fh_raw[FH_AUTH_TYPE] = 0;
 
-	mk_fsid(fhp->fh_handle.fh_fsid_type,
-		fhp->fh_handle.fh_fsid,
+	mk_fsid(fhp->fh_handle.fh_raw[FH_FSID_TYPE],
+		fhp->fh_handle.fh_raw + FH_FSID,
 		ex_dev,
 		d_inode(exp->ex_path.dentry)->i_ino,
 		exp->ex_fsid, exp->ex_uuid);
 
 	if (inode)
 		_fh_update(fhp, exp, dentry);
-	if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID) {
+	if (fhp->fh_handle.fh_raw[FH_FILEID_TYPE] == FILEID_INVALID) {
 		fh_put(fhp);
 		return nfserr_stale;
 	}
@@ -644,11 +648,11 @@ fh_update(struct svc_fh *fhp)
 	dentry = fhp->fh_dentry;
 	if (d_really_is_negative(dentry))
 		goto out_negative;
-	if (fhp->fh_handle.fh_fileid_type != FILEID_ROOT)
+	if (fhp->fh_handle.fh_raw[FH_FILEID_TYPE] != FILEID_ROOT)
 		return 0;
 
 	_fh_update(fhp, fhp->fh_export, dentry);
-	if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID)
+	if (fhp->fh_handle.fh_raw[FH_FILEID_TYPE] == FILEID_INVALID)
 		return nfserr_stale;
 	return 0;
 out_bad:
@@ -776,9 +780,9 @@ char * SVCFH_fmt(struct svc_fh *fhp)
 
 enum fsid_source fsid_source(const struct svc_fh *fhp)
 {
-	if (fhp->fh_handle.fh_version != 1)
+	if (fhp->fh_handle.fh_raw[FH_VERSION] != 1)
 		return FSIDSOURCE_DEV;
-	switch(fhp->fh_handle.fh_fsid_type) {
+	switch (fhp->fh_handle.fh_raw[FH_FSID_TYPE]) {
 	case FSID_DEV:
 	case FSID_ENCODE_DEV:
 	case FSID_MAJOR_MINOR:
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 5103c2f4d225..26975ede465a 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -43,22 +43,17 @@
  *   filesystems must not use the values '0' or '0xff'. 'See enum fid_type'
  *   in include/linux/exportfs.h for currently registered values.
  */
-
 struct knfsd_fh {
 	unsigned int	fh_size;	/*
 					 * Points to the current size while
 					 * building a new file handle.
 					 */
-	union {
-		char			fh_raw[NFS4_FHSIZE];
-		struct {
-			u8		fh_version;	/* == 1 */
-			u8		fh_auth_type;	/* deprecated */
-			u8		fh_fsid_type;
-			u8		fh_fileid_type;
-			u32		fh_fsid[]; /* flexible-array member */
-		};
-	};
+	char		fh_raw[NFS4_FHSIZE];
+#define FH_VERSION		0
+#define FH_AUTH_TYPE		1
+#define FH_FSID_TYPE		2
+#define FH_FILEID_TYPE		3
+#define FH_FSID			4
 };
 
 static inline __u32 ino_t_to_u32(ino_t ino)
@@ -141,10 +136,12 @@ extern enum fsid_source fsid_source(const struct svc_fh *fhp);
  * sparse from complaining. Since these values are opaque to the
  * client, that shouldn't be a problem.
  */
-static inline void mk_fsid(int vers, u32 *fsidv, dev_t dev, ino_t ino,
-			   u32 fsid, unsigned char *uuid)
+static inline void mk_fsid(int vers, void *fsid, dev_t dev, ino_t ino,
+			   u32 fsid_num, unsigned char *uuid)
 {
+	u32 *fsidv = fsid;
 	u32 *up;
+
 	switch(vers) {
 	case FSID_DEV:
 		fsidv[0] = (__force __u32)htonl((MAJOR(dev)<<16) |
@@ -152,7 +149,7 @@ static inline void mk_fsid(int vers, u32 *fsidv, dev_t dev, ino_t ino,
 		fsidv[1] = ino_t_to_u32(ino);
 		break;
 	case FSID_NUM:
-		fsidv[0] = fsid;
+		fsidv[0] = fsid_num;
 		break;
 	case FSID_MAJOR_MINOR:
 		fsidv[0] = (__force __u32)htonl(MAJOR(dev));
@@ -260,9 +257,10 @@ static inline bool fh_match(const struct knfsd_fh *fh1,
 static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
 				 const struct knfsd_fh *fh2)
 {
-	if (fh1->fh_fsid_type != fh2->fh_fsid_type)
+	if (fh1->fh_raw[FH_FSID_TYPE] != fh2->fh_raw[FH_FSID_TYPE])
 		return false;
-	if (memcmp(fh1->fh_fsid, fh2->fh_fsid, key_len(fh1->fh_fsid_type)) != 0)
+	if (memcmp(fh1->fh_raw + FH_FSID, fh2->fh_raw + FH_FSID,
+			key_len(fh1->fh_raw[FH_FSID_TYPE])) != 0)
 		return false;
 	return true;
 }
-- 
2.43.0


