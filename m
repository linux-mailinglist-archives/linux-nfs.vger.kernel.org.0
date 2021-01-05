Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193382EAE7A
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbhAEPcr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbhAEPcr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:32:47 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDD2C06179A
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:32:32 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d14so26719563qkc.13
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vXIg3TTAMYA/x3GVdZiabfVYqYiXJclDZ4PP+hmvvdA=;
        b=NzJ6K8a8YhMLhw3v3fPbZ5P6XQ8EQEHdIGUrXg6zVioYCCy6arPHaxwfLCbgW5Cv7c
         EasvVTZ5ehsmLNPjfASXZA8R1iDOMoe64+VjBxCnAIz6ollFBVc1EQ98Ot1er6jecIQF
         dZ+Bk0FrnEzpHMN95H1HHDAnPwB50HbZL45AIl4QXgGbKA7jgH6YDp2feNPN9V/XbtLT
         K50VIs3nGPBPWXq0WE3JhqDnqVHfjlv0x0CjzuwbffaJO9eCWQX8T8B8IFbdcoR8tIcc
         Xa9e8RMyz9vrLjqJr5wlaQffHvlT17tkJ7bhDPuMZlvtb16LRUWmLwUk2M2y1tsYsDOL
         2rSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=vXIg3TTAMYA/x3GVdZiabfVYqYiXJclDZ4PP+hmvvdA=;
        b=nyU5iE5oBkUUaPEkxlyWkGJVcmS2udw4CwCclyJ5x9xCvtXHk0ZU+rqoKf8vyYwmey
         knkPTcIrUppkpPOO2vB9W6it9ri0oG1kdkses5zmQ00e7OAh8di5gSSC4zLIXHaabuy/
         qsnEeAl42T/S5uNFVpwW7vxGLXMihsv1kMlgeAigoGEPAuHuF2233v8iEUHU7D3sDi3r
         VP6U4SQ4uj241XaYmeOETrJAjCuFczxm8wu+Wm8l6pPFnrgu87+ZjFkZpybqOj8kStXg
         21aWj1+E4omamMU0kbqL6owTLik4cgS27ciLtRYo7IXFXbfKtHp4/KQXwD7FaPwspR4Y
         fc+Q==
X-Gm-Message-State: AOAM532Xes/iZfRNPQsEOsQPVUGsGizhU23GA6euTVqt+FM/sDNRpI7U
        UCa6gjBibSR/z0UtxrcFNkgJt0osz6U=
X-Google-Smtp-Source: ABdhPJydilAkssyOf3CxSvarmgMFhxsPC9mZWkTG1InBoWVmUU1q+Ud6F9WQsqAdNLBf4eE49SS28A==
X-Received: by 2002:ae9:f30c:: with SMTP id p12mr82446qkg.154.1609860751163;
        Tue, 05 Jan 2021 07:32:31 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r6sm125830qkk.127.2021.01.05.07.32.30
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:32:30 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FWTA8020916
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:32:29 GMT
Subject: [PATCH v1 32/42] NFSD: Update the NFSv2 SYMLINK argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:32:29 -0500
Message-ID: <160986074948.5532.6358484489073990169.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsxdr.c |  113 +++++-------------------------------------------------
 1 file changed, 10 insertions(+), 103 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 2e2806cbe7b8..f2cb4794aeaf 100644
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
 static bool
 svcxdr_decode_filename(struct xdr_stream *xdr, char **name, unsigned int *len)
 {
@@ -118,61 +98,6 @@ svcxdr_decode_diropargs(struct xdr_stream *xdr, struct svc_fh *fhp,
 		svcxdr_decode_filename(xdr, name, len);
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
 static bool
 svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		    struct iattr *iap)
@@ -435,40 +360,22 @@ nfssvc_decode_linkargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_symlinkargs *args = rqstp->rq_argp;
-	char *base = (char *)p;
-	size_t xdrlen;
+	struct kvec *head = rqstp->rq_arg.head;
 
-	if (   !(p = decode_fh(p, &args->ffh))
-	    || !(p = decode_filename(p, &args->fname, &args->flen)))
+	if (!svcxdr_decode_diropargs(xdr, &args->ffh, &args->fname, &args->flen))
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &args->tlen) < 0)
 		return 0;
-
-	args->tlen = ntohl(*p++);
 	if (args->tlen == 0)
 		return 0;
 
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
-
-	return 1;
+	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
+	args->first.iov_base = xdr_inline_decode(xdr, args->tlen);
+	if (!args->first.iov_base)
+		return 0;
+	return svcxdr_decode_sattr(rqstp, xdr, &args->attrs);
 }
 
 int


