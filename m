Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA52EAE82
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbhAEPdJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbhAEPdI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:33:08 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE73C061574
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:32:53 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id h4so26817368qkk.4
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=NO77RhHtUedYp4qFpiBBG4Tv5P6/osz6EYRha2NhNhk=;
        b=LBH1OY977QFEYCShgeKGpDgu3FDfHV05KkXE9b+UwIqHtyvPMiXk4UbO3jmRAellJb
         ZEpGVIsOtk0vyI8bkf4sDmCPY+lV2mV9pOWj0JlBF9k2arnMchAYv5BCl4K/0elMr7rk
         6NSwp9thWx7TFtBhpyZxP3GQ+IyP+TUcs9TgHEoxz7abONTcsKoTod2tkD2VF0S4NhqC
         S7cgp1rCkkwpXiTzIpOIk6ReSUTAp71DEtVYGcTUuqkxbV2de9ALP1qemwy9ZgZImI82
         FoL63rgerMxbXHz7gMDZMSD4MYyiT8+kjTmH5hAWlOsNZmHTte6ZSBE7nnX6KLBgX6UL
         mkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=NO77RhHtUedYp4qFpiBBG4Tv5P6/osz6EYRha2NhNhk=;
        b=S9GtNyVw6ytbQJvrGb5cJjslytqDXK/8pqRYBNKMnrSBW52mTnZ9osZkgrmdg/DLOO
         V6uucmhuIsLpTKZKxoviN0HGRrB/tsGr53462KtOnO0LlH/eNn2eJPRK6grsosmtIIFx
         Qaq7LZ1DRutWnwR3L423vdQNUR6i7m67UrRHz5C2c/fzGuQ5p8+0y5EXYkrLPsO/QrPy
         1Vp/7J0oBOnO20NlBuNkHvqglEYa0gGSFDJ/u/HsIHKQGhm/I35RX+rKhKbXMZ1IoVQ/
         wa+syRde6NbrwGX8pRAlCqYSYzDsdWW4PgfHozj6uUwmcIbrJu3JcHPNWZuyomroZFQX
         VxrQ==
X-Gm-Message-State: AOAM533cKjbBEgb7mGZZ4JUqcJq2QioBVg2D7yer8ZWT2Y4QESgVeGK2
        zTRm4JwUMI2xbmfVpUdvrb8CQHSIRSU=
X-Google-Smtp-Source: ABdhPJw3E3IXEEUyfgTlyT2GRgiR1Lg7VJY9blwvgZYSQs9bzUF3EMrsXiTPrUbCgULnwpAmTENwDg==
X-Received: by 2002:a37:2dc5:: with SMTP id t188mr48503qkh.5.1609860772287;
        Tue, 05 Jan 2021 07:32:52 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x28sm62386qtv.8.2021.01.05.07.32.51
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:32:51 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FWoll020928
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:32:50 GMT
Subject: [PATCH v1 36/42] NFSD: Update the NFSv2 SETACL argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:32:50 -0500
Message-ID: <160986077062.5532.1683255539753503273.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs2acl.c |   29 ++++++++++++-----------------
 fs/nfsd/xdr3.h    |    2 +-
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index df2e145cfab0..123820ec79d3 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -201,28 +201,23 @@ static int nfsaclsvc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p)
 
 static int nfsaclsvc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_setaclargs *argp = rqstp->rq_argp;
-	struct kvec *head = rqstp->rq_arg.head;
-	unsigned int base;
-	int n;
 
-	p = nfs2svc_decode_fh(p, &argp->fh);
-	if (!p)
+	if (!svcxdr_decode_fhandle(xdr, &argp->fh))
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &argp->mask) < 0)
+		return 0;
+	if (argp->mask & ~NFS_ACL_MASK)
 		return 0;
-	argp->mask = ntohl(*p++);
-	if (argp->mask & ~NFS_ACL_MASK ||
-	    !xdr_argsize_check(rqstp, p))
+	if (!nfs_stream_decode_acl(xdr, NULL, (argp->mask & NFS_ACL) ?
+				   &argp->acl_access : NULL))
+		return 0;
+	if (!nfs_stream_decode_acl(xdr, NULL, (argp->mask & NFS_DFACL) ?
+				   &argp->acl_default : NULL))
 		return 0;
 
-	base = (char *)p - (char *)head->iov_base;
-	n = nfsacl_decode(&rqstp->rq_arg, base, NULL,
-			  (argp->mask & NFS_ACL) ?
-			  &argp->acl_access : NULL);
-	if (n > 0)
-		n = nfsacl_decode(&rqstp->rq_arg, base + n, NULL,
-				  (argp->mask & NFS_DFACL) ?
-				  &argp->acl_default : NULL);
-	return (n > 0);
+	return 1;
 }
 
 static int nfsaclsvc_decode_fhandleargs(struct svc_rqst *rqstp, __be32 *p)
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 43db4206cd25..5afb3ce4f062 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -108,7 +108,7 @@ struct nfsd3_getaclargs {
 struct posix_acl;
 struct nfsd3_setaclargs {
 	struct svc_fh		fh;
-	int			mask;
+	__u32			mask;
 	struct posix_acl	*acl_access;
 	struct posix_acl	*acl_default;
 };


