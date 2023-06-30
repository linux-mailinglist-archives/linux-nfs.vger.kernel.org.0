Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D515D743246
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 03:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjF3Be7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 21:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjF3Be5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 21:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39202974
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 18:34:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81A5D61583
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 01:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A47C433C8;
        Fri, 30 Jun 2023 01:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688088895;
        bh=x1UKdQpoj6wz+PK5JCfNNkz1npmN/K7ofEhcQ7wwEX0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z6sbHQ5MV2KBbzqko+ihnUsNY9r3ZsxmdiHo54RzBDzqKE5FABeUg00iRnjDBHDO7
         9MjvdZquNNazNZSJUPzniVBMROaRJ/eDvSXXF6DDyLYisbdk1Nn2Q7U3zZ/gOH9gSk
         0Ac+oIoNcQxcQFHywDZSQjMIxhDtacmEaQT5j2+TRH8aDfxtQ0O5wmM8HhuN+ZQ6WD
         5mw+SIjwMy+s8NFsZDv9b1Ok1WGq8hholw2YXrU0I98YqHSoQ0LjfaJwkBBEL+E2af
         aPPbQy4wyim9mqgdM4tI2rTP35AnbKjFucntQLuBvapFpCabpdA4hNur85o7vlcpWz
         nw0spqhl3hAbw==
Subject: [PATCH RFC 3/4] NFSD: Encode attributes in WORD1 using a bitmask loop
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 29 Jun 2023 21:34:53 -0400
Message-ID: <168808889384.7728.12019491678161370671.stgit@manet.1015granger.net>
In-Reply-To: <168808788945.7728.6965361432016501208.stgit@manet.1015granger.net>
References: <168808788945.7728.6965361432016501208.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Replace the current implementation with a branch table. This creates
hard function scope boundaries, limiting side effects and reducing
instruction cache footprint (uncalled encoders remain out of the
cache).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |  301 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 190 insertions(+), 111 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 20e09e5510c9..8335ca1e2da0 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2948,6 +2948,7 @@ struct nfsd4_fattr_args {
 	struct nfs4_acl		*acl;
 	u32			rdattr_err;
 	bool			contextsupport;
+	bool			ignore_crossmnt;
 };
 
 typedef __be32(*nfsd4_enc_attr)(struct xdr_stream *xdr,
@@ -3276,6 +3277,191 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_word0_ops[] = {
 	[31]		= nfsd4_encode_fattr4_maxwrite,
 };
 
+static __be32 nfsd4_encode_fattr4_mode(struct xdr_stream *xdr,
+				       struct nfsd4_fattr_args *args)
+{
+	if (xdr_stream_encode_u32(xdr, args->stat.mode & S_IALLUGO) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_numlinks(struct xdr_stream *xdr,
+					   struct nfsd4_fattr_args *args)
+{
+	if (xdr_stream_encode_u32(xdr, args->stat.nlink) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_owner(struct xdr_stream *xdr,
+					struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_user(xdr, args->rqstp, args->stat.uid);
+}
+
+static __be32 nfsd4_encode_fattr4_owner_group(struct xdr_stream *xdr,
+					      struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_group(xdr, args->rqstp, args->stat.gid);
+}
+
+static __be32 nfsd4_encode_fattr4_rawdev(struct xdr_stream *xdr,
+					 struct nfsd4_fattr_args *args)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, 8);
+	if (!p)
+		return nfserr_resource;
+	*p++ = cpu_to_be32((u32) MAJOR(args->stat.rdev));
+	*p   = cpu_to_be32((u32) MINOR(args->stat.rdev));
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_space_avail(struct xdr_stream *xdr,
+					      struct nfsd4_fattr_args *args)
+{
+	u64 space = (u64)args->statfs.f_bavail * (u64)args->statfs.f_bsize;
+
+	if (xdr_stream_encode_u64(xdr, space) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_space_free(struct xdr_stream *xdr,
+					     struct nfsd4_fattr_args *args)
+{
+	u64 space = (u64)args->statfs.f_bfree * (u64)args->statfs.f_bsize;
+
+	if (xdr_stream_encode_u64(xdr, space) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_space_total(struct xdr_stream *xdr,
+					      struct nfsd4_fattr_args *args)
+{
+	u64 space = (u64)args->statfs.f_blocks * (u64)args->statfs.f_bsize;
+
+	if (xdr_stream_encode_u64(xdr, space) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_space_used(struct xdr_stream *xdr,
+					     struct nfsd4_fattr_args *args)
+{
+	u64 space = (u64)args->stat.blocks << 9;
+
+	if (xdr_stream_encode_u64(xdr, space) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_time_access(struct xdr_stream *xdr,
+					     struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_nfstime4(xdr, &args->stat.atime);
+}
+
+static __be32 nfsd4_encode_fattr4_time_create(struct xdr_stream *xdr,
+					      struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_nfstime4(xdr, &args->stat.btime);
+}
+
+static __be32 nfsd4_encode_fattr4_time_delta(struct xdr_stream *xdr,
+					     struct nfsd4_fattr_args *args)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT * 3);
+	if (!p)
+		return nfserr_resource;
+
+	encode_time_delta(p, d_inode(args->dentry));
+	return nfs_ok;
+}
+
+static __be32 nfsd4_encode_fattr4_time_metadata(struct xdr_stream *xdr,
+						struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_nfstime4(xdr, &args->stat.ctime);
+}
+
+static __be32 nfsd4_encode_fattr4_time_modify(struct xdr_stream *xdr,
+					      struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_nfstime4(xdr, &args->stat.mtime);
+}
+
+static __be32 nfsd4_encode_fattr4_mounted_on_fileid(struct xdr_stream *xdr,
+						    struct nfsd4_fattr_args *args)
+{
+	u64 ino = args->stat.ino;
+	int err;
+
+	if (!args->ignore_crossmnt &&
+	    args->dentry == args->exp->ex_path.mnt->mnt_root) {
+		err = nfsd4_get_mounted_on_ino(args->exp, &ino);
+		if (err)
+			return nfserrno(err);
+	}
+
+	if (xdr_stream_encode_u64(xdr, ino) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+#ifdef CONFIG_NFSD_PNFS
+
+static __be32 nfsd4_encode_fattr4_layout_types(struct xdr_stream *xdr,
+					       struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_layout_types(xdr, args->exp->ex_layout_types);
+}
+
+#endif
+
+static const nfsd4_enc_attr nfsd4_enc_fattr4_word1_ops[] = {
+	[0]		= nfsd4_encode_fattr4__noop,	/* mime type */
+	[1]		= nfsd4_encode_fattr4_mode,
+	[2]		= nfsd4_encode_fattr4__true,	/* no trunc */
+	[3]		= nfsd4_encode_fattr4_numlinks,
+	[4]		= nfsd4_encode_fattr4_owner,
+	[5]		= nfsd4_encode_fattr4_owner_group,
+	[6]		= nfsd4_encode_fattr4__noop,	/* quota_hard */
+	[7]		= nfsd4_encode_fattr4__noop,	/* quota_soft */
+	[8]		= nfsd4_encode_fattr4__noop,	/* quota_used */
+	[9]		= nfsd4_encode_fattr4_rawdev,
+	[10]		= nfsd4_encode_fattr4_space_avail,
+	[11]		= nfsd4_encode_fattr4_space_free,
+	[12]		= nfsd4_encode_fattr4_space_total,
+	[13]		= nfsd4_encode_fattr4_space_used,
+	[14]		= nfsd4_encode_fattr4__noop,	/* system */
+	[15]		= nfsd4_encode_fattr4_time_access,
+	[16]		= nfsd4_encode_fattr4__noop,	/* time_access_set */
+	[17]		= nfsd4_encode_fattr4__noop,	/* time_backup */
+	[18]		= nfsd4_encode_fattr4_time_create,
+	[19]		= nfsd4_encode_fattr4_time_delta,
+	[20]		= nfsd4_encode_fattr4_time_metadata,
+	[21]		= nfsd4_encode_fattr4_time_modify,
+	[22]		= nfsd4_encode_fattr4__noop,	/* time_modify_set */
+	[23]		= nfsd4_encode_fattr4_mounted_on_fileid,
+	[24]		= nfsd4_encode_fattr4__noop,	/* dir notif delay */
+	[25]		= nfsd4_encode_fattr4__noop,	/* dirent notif delay */
+	[26]		= nfsd4_encode_fattr4__noop,	/* dacl */
+	[27]		= nfsd4_encode_fattr4__noop,	/* sacl */
+	[28]		= nfsd4_encode_fattr4__noop,	/* change policy */
+	[29]		= nfsd4_encode_fattr4__noop,	/* fs status */
+#ifdef CONFIG_NFSD_PNFS
+	[30]		= nfsd4_encode_fattr4_layout_types,
+#else
+	[30]		= nfsd4_encode_fattr4__noop,
+#endif
+	[31]		= nfsd4_encode_fattr4__noop,	/* layout hint */
+};
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3292,7 +3478,6 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	u32 bmval2 = bmval[2];
 	struct svc_fh *tempfh = NULL;
 	int starting_len = xdr->buf->len;
-	u64 dummy64;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	void *context = NULL;
 	int contextlen;
@@ -3312,6 +3497,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	args.fhp = fhp;
 	args.exp = exp;
 	args.dentry = dentry;
+	args.ignore_crossmnt = (ignore_crossmnt != 0);
 
 	args.rdattr_err = 0;
 	if (exp->ex_fslocs.migrated) {
@@ -3399,121 +3585,14 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 
-	if (bmval1 & FATTR4_WORD1_MODE) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(args.stat.mode & S_IALLUGO);
-	}
-	if (bmval1 & FATTR4_WORD1_NO_TRUNC) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(1);
-	}
-	if (bmval1 & FATTR4_WORD1_NUMLINKS) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(args.stat.nlink);
-	}
-	if (bmval1 & FATTR4_WORD1_OWNER) {
-		status = nfsd4_encode_user(xdr, rqstp, args.stat.uid);
-		if (status)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_OWNER_GROUP) {
-		status = nfsd4_encode_group(xdr, rqstp, args.stat.gid);
-		if (status)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_RAWDEV) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32((u32) MAJOR(args.stat.rdev));
-		*p++ = cpu_to_be32((u32) MINOR(args.stat.rdev));
-	}
-	if (bmval1 & FATTR4_WORD1_SPACE_AVAIL) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		dummy64 = (u64)args.statfs.f_bavail * (u64)args.statfs.f_bsize;
-		p = xdr_encode_hyper(p, dummy64);
-	}
-	if (bmval1 & FATTR4_WORD1_SPACE_FREE) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		dummy64 = (u64)args.statfs.f_bfree * (u64)args.statfs.f_bsize;
-		p = xdr_encode_hyper(p, dummy64);
-	}
-	if (bmval1 & FATTR4_WORD1_SPACE_TOTAL) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		dummy64 = (u64)args.statfs.f_blocks * (u64)args.statfs.f_bsize;
-		p = xdr_encode_hyper(p, dummy64);
-	}
-	if (bmval1 & FATTR4_WORD1_SPACE_USED) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		dummy64 = (u64)args.stat.blocks << 9;
-		p = xdr_encode_hyper(p, dummy64);
-	}
-	if (bmval1 & FATTR4_WORD1_TIME_ACCESS) {
-		status = nfsd4_encode_nfstime4(xdr, &args.stat.atime);
-		if (status)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_TIME_DELTA) {
-		p = xdr_reserve_space(xdr, 12);
-		if (!p)
-			goto out_resource;
-		p = encode_time_delta(p, d_inode(dentry));
-	}
-	if (bmval1 & FATTR4_WORD1_TIME_METADATA) {
-		status = nfsd4_encode_nfstime4(xdr, &args.stat.ctime);
-		if (status)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_TIME_MODIFY) {
-		status = nfsd4_encode_nfstime4(xdr, &args.stat.mtime);
-		if (status)
-			goto out;
-	}
-	if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
-		status = nfsd4_encode_nfstime4(xdr, &args.stat.btime);
+	mask = bmval1;
+	for_each_set_bit(i, &mask, 32) {
+		status = nfsd4_enc_fattr4_word1_ops[i](xdr, &args);
 		if (status)
 			goto out;
 	}
-	if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
-		u64 ino = args.stat.ino;
 
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-                	goto out_resource;
-		/*
-		 * Get ino of mountpoint in parent filesystem, if not ignoring
-		 * crossmount and this is the root of a cross-mounted
-		 * filesystem.
-		 */
-		if (ignore_crossmnt == 0 &&
-		    dentry == exp->ex_path.mnt->mnt_root) {
-			err = nfsd4_get_mounted_on_ino(exp, &ino);
-			if (err)
-				goto out_nfserr;
-		}
-		p = xdr_encode_hyper(p, ino);
-	}
 #ifdef CONFIG_NFSD_PNFS
-	if (bmval1 & FATTR4_WORD1_FS_LAYOUT_TYPES) {
-		status = nfsd4_encode_layout_types(xdr, exp->ex_layout_types);
-		if (status)
-			goto out;
-	}
-
 	if (bmval2 & FATTR4_WORD2_LAYOUT_TYPES) {
 		status = nfsd4_encode_layout_types(xdr, exp->ex_layout_types);
 		if (status)


