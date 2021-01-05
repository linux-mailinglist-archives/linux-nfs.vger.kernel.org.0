Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5062EAE54
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbhAEPbB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbhAEPbB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:31:01 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37717C06179E
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:30:05 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id h4so26807743qkk.4
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=api75vfmsi7YaiUQDuMlZUbdyC7cX4thBLVHuevlZoo=;
        b=HO6lhPfZZ99aHrJN2/iG9cg2WKWep0yNDlarhKbxIYLQirwNOPa8sM9bxposVrKEMr
         fQ4D9BMWzz8sxhGYNy6frLWrMtjfNpxmbG6KTnOqwW8v3FnhOvTe2aKXaqB4aaKrOx/A
         vFDwkTLFjjcxmjRdARnQLDLhDhrofOcoTlhKbiUlvZWbaOAV4iIbekQZSyRCVwIMqGPy
         lUizduLTeWY8i4lc7fbTd658KnD3M+zCqMiTu5fYIfni0+4Hw5LdttnruvrHbS2cXFJi
         k4KzJMawlrGIh2uG0cJk4TYZCLvJ52GNRs9L/92l3eY10nqujHaZ0mNWw8648Wd+A6lU
         DMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=api75vfmsi7YaiUQDuMlZUbdyC7cX4thBLVHuevlZoo=;
        b=e3eWt6fbiJDeSzDVFjlKchwlFJ1qxnq0Bgy2470lVtuVYp7ZcSXhQw5SQ5LJhTaSnQ
         aUYWDw2E25v6J1Zp7uO/eHR6dNX1J/tV+BhWqnGTgwx/nLmrjm9/3HqorsDAW43sym+y
         K/I42ef76rptApFUvOOjpL1YV6NPAq4fAfssGru8qG7M3M+XXTmQpJdnrT947LhQPJeT
         h2WLlk5djnLgUZk+9rA/LayQ47zVmpdOhHb9D43JoHzcff4JhAMocYAoT0POvGO3UH0z
         R5L6RKVVzxceuAEFMPAa8B8hnB/ODdXQGMRaxOC46H6hPhZ7pC7gPYTwSD8PKJWI7c8+
         OjRQ==
X-Gm-Message-State: AOAM532FYPWPDExR2QppcNziMbhaAVvW3Ej79Ia5aRtYQ2baDtBMya7m
        zNa+jTR7eme/BJuqMLZgoWibcjtni8M=
X-Google-Smtp-Source: ABdhPJz0gu5E4hg4lBLmxMrIRFK8hjYB5ON9L8vnOC+/q9q7+KhkAgFERgzctIzmSZFEhNIcWtOltw==
X-Received: by 2002:a05:620a:15ea:: with SMTP id p10mr73502qkm.172.1609860604141;
        Tue, 05 Jan 2021 07:30:04 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h1sm60820qtr.1.2021.01.05.07.30.03
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:30:03 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FU2aQ020832
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:30:02 GMT
Subject: [PATCH v1 04/42] NFSD: Update GETATTR3args decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:30:02 -0500
Message-ID: <160986060270.5532.7651375067308848822.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3proc.c |    3 +--
 fs/nfsd/nfs3xdr.c  |   31 +++++++++++++++++++++++++------
 fs/nfsd/xdr3.h     |    2 +-
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index c9c64471c568..4b66f055141b 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -683,7 +683,6 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
  * NFSv3 Server procedures.
  * Only the results of non-idempotent operations are cached.
  */
-#define nfs3svc_decode_fhandleargs	nfs3svc_decode_fhandle
 #define nfs3svc_encode_attrstatres	nfs3svc_encode_attrstat
 #define nfs3svc_encode_wccstatres	nfs3svc_encode_wccstat
 #define nfsd3_mkdirargs			nfsd3_createargs
@@ -715,7 +714,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_decode = nfs3svc_decode_fhandleargs,
 		.pc_encode = nfs3svc_encode_attrstatres,
 		.pc_release = nfs3svc_release_fhandle,
-		.pc_argsize = sizeof(struct nfsd3_fhandleargs),
+		.pc_argsize = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd3_attrstatres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 821db21ba072..01335b0e7c60 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -29,8 +29,9 @@ static u32	nfs3_ftypes[] = {
 
 
 /*
- * XDR functions for basic NFS types
+ * Basic NFSv3 data types (RFC 1813 Sections 2.5 and 2.6)
  */
+
 static __be32 *
 encode_time3(__be32 *p, struct timespec64 *time)
 {
@@ -46,6 +47,26 @@ decode_time3(__be32 *p, struct timespec64 *time)
 	return p;
 }
 
+static bool
+svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh *fhp)
+{
+	__be32 *p;
+	u32 size;
+
+	if (xdr_stream_decode_u32(xdr, &size) < 0)
+		return false;
+	if (size == 0 || size > NFS3_FHSIZE)
+		return false;
+	p = xdr_inline_decode(xdr, size);
+	if (!p)
+		return false;
+	fh_init(fhp, NFS3_FHSIZE);
+	fhp->fh_handle.fh_size = size;
+	memcpy(&fhp->fh_handle.fh_base, p, size);
+
+	return true;
+}
+
 static __be32 *
 decode_fh(__be32 *p, struct svc_fh *fhp)
 {
@@ -312,14 +333,12 @@ void fill_post_wcc(struct svc_fh *fhp)
  */
 
 int
-nfs3svc_decode_fhandle(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_fhandleargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_fhandle *args = rqstp->rq_argp;
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
-		return 0;
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_nfs_fh3(xdr, &args->fh);
 }
 
 int
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 456fcd7a1038..62ea669768cf 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -273,7 +273,7 @@ union nfsd3_xdrstore {
 
 #define NFS3_SVC_XDRSIZE		sizeof(union nfsd3_xdrstore)
 
-int nfs3svc_decode_fhandle(struct svc_rqst *, __be32 *);
+int nfs3svc_decode_fhandleargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_sattrargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_diropargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_accessargs(struct svc_rqst *, __be32 *);


