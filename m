Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE082EAE6A
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbhAEPcF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbhAEPcF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:32:05 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4B2C061793
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:31:50 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id c7so26782647qke.1
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5MJzPeJJLc2aRCx+IAlBcY2ccSdPvJbsRJJS+pdfcrc=;
        b=OoreJOF2fuQuCtPV/IdOJgwsXopqYdJhQr+3vg9CFVdUbN71lS7Zic5SvQTMU3JEsp
         +Rwp5/88Q6V3aaXDxbsN3BIaN3BhZAse8T0ElZs+1WixDaXbru0KFKAS/0Dbgj54s7wq
         UnipuNoAJdkvbKsl0LGVzmJQFzig43ybNs0cBUFPfxo4lxUReIRouihnSOiXxfCYoDio
         QBexsdIKthKkQCj13MFtARSABLsZfpIrFUUMV3/2lIeaRFNhD9SWsZ+7RaKdTPIO41+C
         bbabQu7E6jqMEP365WrluRY+OLQFIgIDAc5Nb1PgBnOkH5Rc3AkEMqEh6S/VcO1HAlH4
         nIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=5MJzPeJJLc2aRCx+IAlBcY2ccSdPvJbsRJJS+pdfcrc=;
        b=kWIh3qPswsCd3uxOE2jZBQ/3vrmHGwynjgoTUZEvH2L1xlinjO8Fb6VgvSyiWsJZq7
         hK9AgxerDe2O7Mw709TAFsXilbNus7Zym3FyVaOPA/sBzAcn1eahLH6myMuaOC2vmvKV
         Ymav1Ti9dyNXS2UYX7OgBHQtSPk2LrWOW90RlNQRDvze8bNRJa46/G5fhrcid/Zchj25
         HvsBL6/pxGIE4RuUQTdh3mGKIp+d0Af18dRpAFcOazUlNa4cR8yRC8uMfbb1wG3PfGLg
         dumbpSPqawMlO1DY1OEKAmle+npwkJNPtNzP+Zu7NcYuDI/Xf/o5VIZEVU2XZWPqH3DX
         ndTw==
X-Gm-Message-State: AOAM5336B9T7ssnID1pp2GxH0SpI+8BBtLM1tv0JRGlWgzoKflenFE6Y
        KxJP8AkDTt652z+jn+GFh/aJ8qqhDPw=
X-Google-Smtp-Source: ABdhPJz0XfmFB9vsEfRzbBcBxa0cSP5i4+DTmmXGlIXW7jXICLKqKnsX+L2xEgIzxg6Q4hBFea4L0Q==
X-Received: by 2002:a37:27d0:: with SMTP id n199mr8286qkn.377.1609860709041;
        Tue, 05 Jan 2021 07:31:49 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n62sm129118qkn.125.2021.01.05.07.31.48
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:31:48 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FVlQn020892
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:31:47 GMT
Subject: [PATCH v1 24/42] NFSD: Update the NFSv2 READLINK argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:31:47 -0500
Message-ID: <160986070740.5532.1963940465503958871.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the code that sets up the sink buffer for nfsd_readlink() is
moved adjacent to the nfsd_readlink() call site that uses it, then
the only argument is a file handle, and the fhandle decoder can be
used instead.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsproc.c |    9 +++++----
 fs/nfsd/nfsxdr.c  |   13 -------------
 fs/nfsd/xdr.h     |    6 ------
 3 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 814762793f9c..bdb47848f7fd 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -149,14 +149,15 @@ nfsd_proc_lookup(struct svc_rqst *rqstp)
 static __be32
 nfsd_proc_readlink(struct svc_rqst *rqstp)
 {
-	struct nfsd_readlinkargs *argp = rqstp->rq_argp;
+	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd_readlinkres *resp = rqstp->rq_resp;
+	char *buffer = page_address(*(rqstp->rq_next_page++));
 
 	dprintk("nfsd: READLINK %s\n", SVCFH_fmt(&argp->fh));
 
 	/* Read the symlink. */
 	resp->len = NFS_MAXPATHLEN;
-	resp->status = nfsd_readlink(rqstp, &argp->fh, argp->buffer, &resp->len);
+	resp->status = nfsd_readlink(rqstp, &argp->fh, buffer, &resp->len);
 
 	fh_put(&argp->fh);
 	return rpc_success;
@@ -674,9 +675,9 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	},
 	[NFSPROC_READLINK] = {
 		.pc_func = nfsd_proc_readlink,
-		.pc_decode = nfssvc_decode_readlinkargs,
+		.pc_decode = nfssvc_decode_fhandleargs,
 		.pc_encode = nfssvc_encode_readlinkres,
-		.pc_argsize = sizeof(struct nfsd_readlinkargs),
+		.pc_argsize = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd_readlinkres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+1+NFS_MAXPATHLEN/4,
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 11d27b219cff..02dd9888d93b 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -326,19 +326,6 @@ nfssvc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p)
 	return xdr_argsize_check(rqstp, p);
 }
 
-int
-nfssvc_decode_readlinkargs(struct svc_rqst *rqstp, __be32 *p)
-{
-	struct nfsd_readlinkargs *args = rqstp->rq_argp;
-
-	p = decode_fh(p, &args->fh);
-	if (!p)
-		return 0;
-	args->buffer = page_address(*(rqstp->rq_next_page++));
-
-	return xdr_argsize_check(rqstp, p);
-}
-
 int
 nfssvc_decode_linkargs(struct svc_rqst *rqstp, __be32 *p)
 {
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index d2ffda96975d..288c29a999db 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -52,11 +52,6 @@ struct nfsd_renameargs {
 	unsigned int		tlen;
 };
 
-struct nfsd_readlinkargs {
-	struct svc_fh		fh;
-	char *			buffer;
-};
-	
 struct nfsd_linkargs {
 	struct svc_fh		ffh;
 	struct svc_fh		tfh;
@@ -150,7 +145,6 @@ int nfssvc_decode_readargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_writeargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_createargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_renameargs(struct svc_rqst *, __be32 *);
-int nfssvc_decode_readlinkargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_linkargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_symlinkargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_readdirargs(struct svc_rqst *, __be32 *);


