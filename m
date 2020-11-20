Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9432C2BB78F
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbgKTUl1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbgKTUl0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:41:26 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A024DC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:26 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id y197so10211855qkb.7
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+LIuNBK0rdtbtTpJjAwXmcaaFCxyCF+BELubmhBuRyA=;
        b=aQS/JBLOB/u/NYOSTt+iVqIi56mxxCfZyb0p3cfVqlbc9hRx6gs2iEJrvBDkpGpe/X
         q9iiWzOSWqs+UU6or4okx//vxvrA8MtCbQx2du8ITcK3qSrTgCBHMiovCpW3a248GEUx
         46XqFsaRNvrHWbOct2gSeIw/FR/WnwE2V+BClW7uEXkjcyLF//Icot25HOQJkUFwx2O+
         Vu5wvP4Hbi9RoEVW4/DL97RSVex/OY+p1ifdWhbiyIsEIk2tjFo1TbEvRqm14iq3MrDz
         GFKxPgjumLAoknoEKvAJJZCuzPbH9zmvTSlY5RH2A9PnOMN+kCZlGJWY+SbKi49nBUpc
         BQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=+LIuNBK0rdtbtTpJjAwXmcaaFCxyCF+BELubmhBuRyA=;
        b=DbTZ9WCx8xKfWidzLwJb0PRq+y3wnSJJD/Y7rhEwxtv/d1/tGVdjJrp2z+fvp+ayTB
         Un8k6n+Nl9ofqsLldd6CMGag5qQQSNsF80BP+rAZPF9DUiNNs1uMEpMdr1/gi5IgrMCt
         AUHSPzQyxspspn82vmmVgOgrKa5bZKlKx644oNmtoyaHyO1GnynmsH5f5itFXLttzOTz
         cI0rIvRW3X8JffPiYb8cgwFc6xMkYcfst6wKI+OSwS6nyuVEn9GIl4wG146O4caExfS7
         i9/7fWm+qdE9nqTItXbCVF9cGSixsn22iIV5mkvI27eTLRFa3NUxV3SOCdOr0I2Yj0pO
         yu+A==
X-Gm-Message-State: AOAM530UAajR3039c6epFK7htogaLfodfFNtixgNQvdGg+hwRb2qDaf/
        EVt1a2prR9G9Wc1vrt/rSwaW5fPd/ew=
X-Google-Smtp-Source: ABdhPJzP05TWff+gyrtREXpoh73aedayIBkdm+Vdb23qoL/ZvOHB6a/rFt8NCpnC7efxjabLoSVsJg==
X-Received: by 2002:a05:620a:1415:: with SMTP id d21mr19007199qkj.275.1605904885529;
        Fri, 20 Nov 2020 12:41:25 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v16sm2862668qka.72.2020.11.20.12.41.24
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:41:24 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKfNit029471
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:41:23 GMT
Subject: [PATCH v2 086/118] NFSD: Add helper to set up the pages where the
 dirlist is encoded
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:41:23 -0500
Message-ID: <160590488385.1340.10258347223480801893.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

De-duplicate some code that is used by both READDIR and READDIRPLUS
to build the dirlist in the Reply. Because this code is not related
to decoding READ arguments, it is moved to a more appropriate spot.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |   29 +++++++++++++++++++----------
 fs/nfsd/nfs3xdr.c  |   20 --------------------
 fs/nfsd/xdr3.h     |    1 -
 3 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 2c4fe7b8723d..a8aafbb4c0ac 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -435,6 +435,23 @@ nfsd3_proc_link(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
+static void nfsd3_init_dirlist_pages(struct svc_rqst *rqstp,
+				     struct nfsd3_readdirres *resp,
+				     int count)
+{
+	count = min_t(u32, count, svc_max_payload(rqstp));
+
+	/* Convert byte count to number of words (i.e. >> 2),
+	 * and reserve room for the NULL ptr & eof flag (-2 words) */
+	resp->buflen = (count >> 2) - 2;
+
+	resp->buffer = page_address(*rqstp->rq_next_page);
+	while (count > 0) {
+		rqstp->rq_next_page++;
+		count -= PAGE_SIZE;
+	}
+}
+
 /*
  * Read a portion of a directory.
  */
@@ -452,16 +469,12 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 				SVCFH_fmt(&argp->fh),
 				argp->count, (u32) argp->cookie);
 
-	/* Make sure we've room for the NULL ptr & eof flag, and shrink to
-	 * client read size */
-	count = (argp->count >> 2) - 2;
+	nfsd3_init_dirlist_pages(rqstp, resp, argp->count);
 
 	/* Read directory and encode entries on the fly */
 	fh_copy(&resp->fh, &argp->fh);
 
-	resp->buflen = count;
 	resp->common.err = nfs_ok;
-	resp->buffer = argp->buffer;
 	resp->rqstp = rqstp;
 	offset = argp->cookie;
 
@@ -513,16 +526,12 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 				SVCFH_fmt(&argp->fh),
 				argp->count, (u32) argp->cookie);
 
-	/* Convert byte count to number of words (i.e. >> 2),
-	 * and reserve room for the NULL ptr & eof flag (-2 words) */
-	resp->count = (argp->count >> 2) - 2;
+	nfsd3_init_dirlist_pages(rqstp, resp, argp->count);
 
 	/* Read directory and encode entries on the fly */
 	fh_copy(&resp->fh, &argp->fh);
 
 	resp->common.err = nfs_ok;
-	resp->buffer = argp->buffer;
-	resp->buflen = resp->count;
 	resp->rqstp = rqstp;
 	offset = argp->cookie;
 
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 35804abc9c1f..eceeda96f576 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -554,8 +554,6 @@ int
 nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_readdirargs *args = rqstp->rq_argp;
-	int len;
-	u32 max_blocksize = svc_max_payload(rqstp);
 
 	p = decode_fh(p, &args->fh);
 	if (!p)
@@ -564,14 +562,6 @@ nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p)
 	args->verf   = p; p += 2;
 	args->dircount = ~0;
 	args->count  = ntohl(*p++);
-	len = args->count  = min_t(u32, args->count, max_blocksize);
-
-	while (len > 0) {
-		struct page *p = *(rqstp->rq_next_page++);
-		if (!args->buffer)
-			args->buffer = page_address(p);
-		len -= PAGE_SIZE;
-	}
 
 	return xdr_argsize_check(rqstp, p);
 }
@@ -580,8 +570,6 @@ int
 nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_readdirargs *args = rqstp->rq_argp;
-	int len;
-	u32 max_blocksize = svc_max_payload(rqstp);
 
 	p = decode_fh(p, &args->fh);
 	if (!p)
@@ -591,14 +579,6 @@ nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, __be32 *p)
 	args->dircount = ntohl(*p++);
 	args->count    = ntohl(*p++);
 
-	len = args->count = min(args->count, max_blocksize);
-	while (len > 0) {
-		struct page *p = *(rqstp->rq_next_page++);
-		if (!args->buffer)
-			args->buffer = page_address(p);
-		len -= PAGE_SIZE;
-	}
-
 	return xdr_argsize_check(rqstp, p);
 }
 
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 08f909142ddf..789a364d5e69 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -93,7 +93,6 @@ struct nfsd3_readdirargs {
 	__u32			dircount;
 	__u32			count;
 	__be32 *		verf;
-	__be32 *		buffer;
 };
 
 struct nfsd3_commitargs {


