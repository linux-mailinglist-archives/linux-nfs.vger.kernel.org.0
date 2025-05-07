Return-Path: <linux-nfs+bounces-11550-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A8CAAD5A1
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 08:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35D798093E
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 06:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861061D61BC;
	Wed,  7 May 2025 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rxXv5jhx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C04171A1;
	Wed,  7 May 2025 06:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746597849; cv=none; b=dQuIPUyE8YCdVDs/82Qf1/uAaoq0OkCtq7SsipcehZ3GVzXhoGy5ZVBnJBjimrnygERXi8SyS3jLJeBGl5XF3J9wemSvY62oalcuJKKBHMrc9d8LbjogX7Byc162CXbdLyt4zcu/ZtlG3TWpNmiUQLlKJcdoVqt1BEeBdL0kgoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746597849; c=relaxed/simple;
	bh=xyaq7YqtvE+ZT30qrdXB0dsaGtEBVNa3sL16S2vb9n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCKKdbRigMhjhXVEEgY91c2rzZEjdTJoqT4yzbOhVFqyfK0Wf8DWm+Ir2SVoUGb+UpHvEU9LDimwnwwm+JSmwShxLHWQWm75ZHdVOp5J5hiO1/g9I9AiXB9sz/pgkhHSxzbbzgpnNjpl/M6j6W6gFgfQ3WG3Iw22KEux1ggokMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rxXv5jhx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3Q2jDgnMElwL2BE0fmTeQle+MDZk0UfyGXf29wN2F6c=; b=rxXv5jhxkxSBm8XX7rfofA9Fql
	KfQeT5eDDQPGG1WTvQBHjFnu36da3j/UBaKMVpT803D78G3u/PqCnCz0cSJHgfrg2KqCFY9JjrW/o
	Lb4C+hLWCBaM24AF7IkAx868NQdtwUx8RBcvHeDXU84g5w8hfH/zPQSwNsPeG1/j7F0PUQRTp3FYZ
	TIvtAMXkmNLCFDaNZT7tDnNlqvk0cmbjiV/pHXk39WpdnKVTnwN06OtKCRdowFAE3NWNtpobZT/yp
	CWJvfQWjnkGO2i8dITnYQHldY8jm/eMg32uDhQ88A3QrXS0yaMCDXqC2dxOTPRkVBjR+5WEDvtGVo
	SoyxKIWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCXsz-0000000EKMd-1ww9;
	Wed, 07 May 2025 06:04:05 +0000
Date: Tue, 6 May 2025 23:04:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neil@brown.name>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] NFSD: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <aBr31WNad6GFOTda@infradead.org>
References: <aBp37ZXBJM09yAXp@kspp>
 <174657431631.3924073.6654014165534485350@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174657431631.3924073.6654014165534485350@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 07, 2025 at 09:31:56AM +1000, NeilBrown wrote:
> struct knfsd_fh has a fixed size determined by NFS4_FHSIZE.
> The fact that fh_fsid is "flexible" doesn't mean it is unlimited in
> size.  So moving it to the end of other structures is silencing a
> warning but leaving the code as potentially confusing.
> 
> Maybe just make it
>     u32 fh_fsid[4]; /* in practice the size varies but is always
>                      * limited by fh_raw above

Don't make this more complicated than needed.  Just killing the
magic union overlay over the raw array just complicates things, so
just use indices into it.  Below is a simple version, but this can
use some more work to split things up and to entirely avoid the
not exactly natural u32-based addressing in various helpers.

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 0363720280d4..804aa679a992 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1230,7 +1230,7 @@ rqst_exp_get_by_name(struct svc_rqst *rqstp, struct path *path)
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
index aef474f1b84b..f58da563d4fd 100644
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
+	switch(fhp->fh_handle.fh_raw[FH_FSID_TYPE]) {
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

