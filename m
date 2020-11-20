Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE482BB7B6
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgKTUnY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgKTUnX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:43:23 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FCFC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:23 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id q7so5295150qvt.12
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=yLKnZwV6Re27aAJJTmXp1NA4VAz4wTFtjy78xbEasX8=;
        b=JqxRQIo7X/siaysGbLD0L/UW+02yvQNOuAPQ9kKkgC+2jpzd6kXXK1ndUbEN+m+yE5
         uL2L1g5d/xw8t3b/V802UnUsktH+ZIB1c7b2EVtfWpVJZjF5myYBMM0wQy3RKatrp7xi
         2TsK2WD7o/IL9j8ma+gWNBXkgrcE9orgc9VslHBWak4r5PSKQdIg4FCk5AJgcwKQHTb/
         v2aHRyBXBmbLVYkBSInSVxTilAXS/DeavmqNaCX701Gu+MoDNEPOMdv1b+FtwsJENE+C
         HH8QGLvFuG2yTOK8nQ6RNJ1LMstuob3uvs+gg8V5YuobIP/DA5xtTyBrmwF3t3QGwUfD
         6hTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=yLKnZwV6Re27aAJJTmXp1NA4VAz4wTFtjy78xbEasX8=;
        b=m7F08cW6qP5k6+GmXwZDIjpS0kydD/7NIQRdkvxYHsjppW2cAAMg8aRo2mx+Umuak6
         x+X15ct600DsLxkoEDjOtFPRMJv5zPvMplSEbfA5I1gD2maCgtNxneNFR+t5t4c7feL+
         5jzz01kdzTwVMNxr+PopU2w+G/RIYsGeMWy5OaGSIm0ctyj6t6u91+mWfCy2UB6duyHy
         ud5Au4W3NL1n0BmZ8gyo+D2KXC/5uEnsq5QEhnVvU0UH69UbdQd9Dqw7nJzSjupx1A6I
         4CMF5/g3Y2SUBsyXDRG7OAc8nPRX8oA8tPTe8lK9Dl0t45HcR519Il+XGHu9eBsAR59R
         p17g==
X-Gm-Message-State: AOAM532a9/dV1Rcf7vIf39iujekoXiHKE04BtBcIK7MPQdixI5thBWwk
        AFRYnW7xvbKP+/AlVuqfhhhzTRT7VyY=
X-Google-Smtp-Source: ABdhPJwVG31QmUCpuSFEYLWIOdS4dyv2qAK+XdorArmgiLAaA0632EKWG1ZkR0fD1ioCcBYX5TivzQ==
X-Received: by 2002:a05:6214:9a5:: with SMTP id du5mr16561052qvb.56.1605905002377;
        Fri, 20 Nov 2020 12:43:22 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o21sm2985055qko.9.2020.11.20.12.43.21
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:43:21 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKhKPm029538
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:43:20 GMT
Subject: [PATCH v2 108/118] NFSD: Update the NFSv2 SYMLINK argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:43:20 -0500
Message-ID: <160590500071.1340.3076531536590397193.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsxdr.c |  117 ++++++------------------------------------------------
 1 file changed, 12 insertions(+), 105 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index f02fef8a805e..92e9143842d3 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -66,26 +66,6 @@ encode_fh(__be32 *p, struct svc_fh *fhp)
 	return p + (NFS_FHSIZE>> 2);
 }
 
-/*
- * Decode a file name and make sure that the path contains
- * no slashes or null bytes.
- */
-static __be32 *
-decode_filename(__be32 *p, char **namp, unsigned int *lenp)
-{
-	char		*name;
-	unsigned int	i;
-
-	if ((p = xdr_decode_string_inplace(p, namp, lenp, NFS_MAXNAMLEN)) != NULL) {
-		for (i = 0, name = *namp; i < *lenp; i++, name++) {
-			if (*name == '\0' || *name == '/')
-				return NULL;
-		}
-	}
-
-	return p;
-}
-
 static enum xdr_decode_result
 svcxdr_decode_filename(struct xdr_stream *xdr, char **name, unsigned int *len)
 {
@@ -119,61 +99,6 @@ svcxdr_decode_diropargs(struct xdr_stream *xdr, struct svc_fh *fhp,
 	return svcxdr_decode_filename(xdr, name, len);
 }
 
-static __be32 *
-decode_sattr(__be32 *p, struct iattr *iap, struct user_namespace *userns)
-{
-	u32	tmp, tmp1;
-
-	iap->ia_valid = 0;
-
-	/* Sun client bug compatibility check: some sun clients seem to
-	 * put 0xffff in the mode field when they mean 0xffffffff.
-	 * Quoting the 4.4BSD nfs server code: Nah nah nah nah na nah.
-	 */
-	if ((tmp = ntohl(*p++)) != (u32)-1 && tmp != 0xffff) {
-		iap->ia_valid |= ATTR_MODE;
-		iap->ia_mode = tmp;
-	}
-	if ((tmp = ntohl(*p++)) != (u32)-1) {
-		iap->ia_uid = make_kuid(userns, tmp);
-		if (uid_valid(iap->ia_uid))
-			iap->ia_valid |= ATTR_UID;
-	}
-	if ((tmp = ntohl(*p++)) != (u32)-1) {
-		iap->ia_gid = make_kgid(userns, tmp);
-		if (gid_valid(iap->ia_gid))
-			iap->ia_valid |= ATTR_GID;
-	}
-	if ((tmp = ntohl(*p++)) != (u32)-1) {
-		iap->ia_valid |= ATTR_SIZE;
-		iap->ia_size = tmp;
-	}
-	tmp  = ntohl(*p++); tmp1 = ntohl(*p++);
-	if (tmp != (u32)-1 && tmp1 != (u32)-1) {
-		iap->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
-		iap->ia_atime.tv_sec = tmp;
-		iap->ia_atime.tv_nsec = tmp1 * 1000; 
-	}
-	tmp  = ntohl(*p++); tmp1 = ntohl(*p++);
-	if (tmp != (u32)-1 && tmp1 != (u32)-1) {
-		iap->ia_valid |= ATTR_MTIME | ATTR_MTIME_SET;
-		iap->ia_mtime.tv_sec = tmp;
-		iap->ia_mtime.tv_nsec = tmp1 * 1000; 
-		/*
-		 * Passing the invalid value useconds=1000000 for mtime
-		 * is a Sun convention for "set both mtime and atime to
-		 * current server time".  It's needed to make permissions
-		 * checks for the "touch" program across v2 mounts to
-		 * Solaris and Irix boxes work correctly. See description of
-		 * sattr in section 6.1 of "NFS Illustrated" by
-		 * Brent Callaghan, Addison-Wesley, ISBN 0-201-32750-5
-		 */
-		if (tmp1 == 1000000)
-			iap->ia_valid &= ~(ATTR_ATIME_SET|ATTR_MTIME_SET);
-	}
-	return p;
-}
-
 static enum xdr_decode_result
 svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		    struct iattr *iap)
@@ -430,40 +355,22 @@ nfssvc_decode_linkargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd_symlinkargs *args = rqstp->rq_argp;
-	char *base = (char *)p;
-	size_t xdrlen;
-
-	if (   !(p = decode_fh(p, &args->ffh))
-	    || !(p = decode_filename(p, &args->fname, &args->flen)))
-		return 0;
+	struct kvec *head = rqstp->rq_arg.head;
 
-	args->tlen = ntohl(*p++);
+	if (!svcxdr_decode_diropargs(xdr, &args->ffh, &args->fname, &args->flen))
+		return XDR_DECODE_FAILED;
+	if (xdr_stream_decode_u32(xdr, &args->tlen) < 0)
+		return XDR_DECODE_FAILED;
 	if (args->tlen == 0)
-		return 0;
-
-	args->first.iov_base = p;
-	args->first.iov_len = rqstp->rq_arg.head[0].iov_len;
-	args->first.iov_len -= (char *)p - base;
-
-	/* This request is never larger than a page. Therefore,
-	 * transport will deliver either:
-	 * 1. pathname in the pagelist -> sattr is in the tail.
-	 * 2. everything in the head buffer -> sattr is in the head.
-	 */
-	if (rqstp->rq_arg.page_len) {
-		if (args->tlen != rqstp->rq_arg.page_len)
-			return 0;
-		p = rqstp->rq_arg.tail[0].iov_base;
-	} else {
-		xdrlen = XDR_QUADLEN(args->tlen);
-		if (xdrlen > args->first.iov_len - (8 * sizeof(__be32)))
-			return 0;
-		p += xdrlen;
-	}
-	decode_sattr(p, &args->attrs, nfsd_user_namespace(rqstp));
+		return XDR_DECODE_FAILED;
 
-	return 1;
+	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
+	args->first.iov_base = xdr_inline_decode(xdr, args->tlen);
+	if (!args->first.iov_base)
+		return XDR_DECODE_FAILED;
+	return svcxdr_decode_sattr(rqstp, xdr, &args->attrs);
 }
 
 int


