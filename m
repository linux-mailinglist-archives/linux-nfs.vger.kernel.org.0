Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AB27A4C4C
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjIRPah (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjIRPae (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:30:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F23121
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:28:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB35BC43215;
        Mon, 18 Sep 2023 13:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045472;
        bh=eXTZv14LOOiCHZd9ksCmHuQpOJzqOBb+PiU1sl4vLWU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KJwUrL4GSNobr3CYUDf4IH8dk/uMPO/i2uHlrOMarNrkTQu7iTSK46k8iYiK3+QtT
         X8nl2qoQsO/rWYAHsSCRfo/GnYB1tnLPlbLhrgprmD/Z3zVtaNrYlnie7x5gIVSNae
         TgIXRU9UtiIeZHabcwLbTzTBuQa8O1uMKCQ5yMbfRT9jd3tABbOls2IJ4QD9mawPCa
         To0Qy3ZVnQELJy6ofka9DeEPZlcQaMfkZ5/I2gbln6LDzJ/UxG1304s1+1h7FTUYhL
         rLkvjX+ujQTnY+vgaP0/Cwe/mDP0Rb8nY1u0oXdXYe/tG/laRJZprvjDe848cmhOnF
         Wzz79YftBWm5A==
Subject: [PATCH v1 10/52] NFSD: Add nfsd4_encode_fattr4_change()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:57:51 -0400
Message-ID: <169504547175.133720.14191467995288731906.stgit@manet.1015granger.net>
In-Reply-To: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
References: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Refactor the encoder for FATTR4_CHANGE into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

The code is restructured a bit to use the modern xdr_stream flow,
and the encoded cinfo value is made const so that callers of the
encoders can be passed a const cinfo.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c        |   56 +++++++++++++++++++++++++++-------------------
 fs/nfsd/nfsfh.c          |    2 +-
 fs/nfsd/nfsfh.h          |    3 ++
 fs/nfsd/xdr4.h           |    2 ++
 include/linux/iversion.h |    2 +-
 5 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e7f1a856fb0b..3149cfcdac35 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2530,17 +2530,6 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 	return true;
 }
 
-static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
-			     struct svc_export *exp)
-{
-	if (exp->ex_flags & NFSEXP_V4ROOT) {
-		*p++ = cpu_to_be32(convert_to_wallclock(exp->cd->flush_time));
-		*p++ = 0;
-	} else
-		p = xdr_encode_hyper(p, nfsd4_change_attribute(stat, inode));
-	return p;
-}
-
 static __be32 nfsd4_encode_nfstime4(struct xdr_stream *xdr,
 				    struct timespec64 *tv)
 {
@@ -2581,15 +2570,17 @@ static __be32 *encode_time_delta(__be32 *p, struct inode *inode)
 }
 
 static __be32
-nfsd4_encode_change_info4(struct xdr_stream *xdr, struct nfsd4_change_info *c)
+nfsd4_encode_change_info4(struct xdr_stream *xdr, const struct nfsd4_change_info *c)
 {
-	if (xdr_stream_encode_bool(xdr, c->atomic) < 0)
-		return nfserr_resource;
-	if (xdr_stream_encode_u64(xdr, c->before_change) < 0)
-		return nfserr_resource;
-	if (xdr_stream_encode_u64(xdr, c->after_change) < 0)
-		return nfserr_resource;
-	return nfs_ok;
+	__be32 status;
+
+	status = nfsd4_encode_bool(xdr, c->atomic);
+	if (status != nfs_ok)
+		return status;
+	status = nfsd4_encode_changeid4(xdr, c->before_change);
+	if (status != nfs_ok)
+		return status;
+	return nfsd4_encode_changeid4(xdr, c->after_change);
 }
 
 /* Encode as an array of strings the string given with components
@@ -3013,6 +3004,26 @@ static __be32 nfsd4_encode_fattr4_fh_expire_type(struct xdr_stream *xdr,
 	return nfsd4_encode_uint32_t(xdr, mask);
 }
 
+static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
+					 const struct nfsd4_fattr_args *args)
+{
+	const struct svc_export *exp = args->exp;
+	u64 c;
+
+	if (unlikely(exp->ex_flags & NFSEXP_V4ROOT)) {
+		u32 flush_time = convert_to_wallclock(exp->cd->flush_time);
+
+		if (xdr_stream_encode_u32(xdr, flush_time) != XDR_UNIT)
+			return nfserr_resource;
+		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+			return nfserr_resource;
+		return nfs_ok;
+	}
+
+	c = nfsd4_change_attribute(&args->stat, d_inode(args->dentry));
+	return nfsd4_encode_changeid4(xdr, c);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3153,10 +3164,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_CHANGE) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = encode_change(p, &args.stat, d_inode(dentry), exp);
+		status = nfsd4_encode_fattr4_change(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_SIZE) {
 		p = xdr_reserve_space(xdr, 8);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 355bf0db3235..dbfa0ac13564 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -771,7 +771,7 @@ enum fsid_source fsid_source(const struct svc_fh *fhp)
  * assume that the new change attr is always logged to stable storage in some
  * fashion before the results can be seen.
  */
-u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode)
+u64 nfsd4_change_attribute(const struct kstat *stat, const struct inode *inode)
 {
 	u64 chattr;
 
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 40426f899e76..6ebdf7ea27bf 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -293,7 +293,8 @@ static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
 	fhp->fh_pre_saved = false;
 }
 
-u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode);
+u64 nfsd4_change_attribute(const struct kstat *stat,
+			   const struct inode *inode);
 __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp);
 __be32 fh_fill_post_attrs(struct svc_fh *fhp);
 __be32 __must_check fh_fill_both_attrs(struct svc_fh *fhp);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 5c3eb3691f8b..d6059b0549f5 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -110,6 +110,8 @@ nfsd4_encode_uint64_t(struct xdr_stream *xdr, u64 val)
 	return nfs_ok;
 }
 
+#define nfsd4_encode_changeid4(x, v)	nfsd4_encode_uint64_t(x, v)
+
 /**
  * nfsd4_encode_opaque_fixed - Encode a fixed-length XDR opaque type result
  * @xdr: target XDR stream
diff --git a/include/linux/iversion.h b/include/linux/iversion.h
index f174ff1b59ee..8f972eaca2ed 100644
--- a/include/linux/iversion.h
+++ b/include/linux/iversion.h
@@ -256,7 +256,7 @@ inode_peek_iversion(const struct inode *inode)
  * For filesystems without any sort of change attribute, the best we can
  * do is fake one up from the ctime:
  */
-static inline u64 time_to_chattr(struct timespec64 *t)
+static inline u64 time_to_chattr(const struct timespec64 *t)
 {
 	u64 chattr = t->tv_sec;
 


