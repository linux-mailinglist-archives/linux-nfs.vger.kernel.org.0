Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB672EAE85
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbhAEPdX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbhAEPdX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:33:23 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD65C061793
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:32:42 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id v126so26717856qkd.11
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AEPcFkkW+BzzpizK6dn04qQ1b3yoPd7eaMzroqgeS8Q=;
        b=uCemquH6w/hD5X4glDeABKzm916gTCYJRHsKa+gfRFCfr9LyP26OaOwcfpWLR508DK
         oEfPx1AxNqmpvt8xldFXWb4//zvUwbma/fOG/wGdTZNEKqgi08X+turm0gxqVjVHbXMI
         Qw7ZjAvgfmm0TxCC07DuAXB/9fwTvOB3oHBfxTsEiLkxb7dHhkBvtzyosGww5ymWEj3C
         b/Qp6rtLLfQgKyXy3vNnZ6J9DK3UNRWRLV4FoyoTALj9gBmn6gtBF+VzJz3AgxUQlzhX
         GmYKbUnZ9QdnxGldAUoZUpibJ+Oi1K1O00cqDl1LOgOxVkYnkA/L5/oAF0vnAGTSOoG+
         TAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=AEPcFkkW+BzzpizK6dn04qQ1b3yoPd7eaMzroqgeS8Q=;
        b=fEUO24MyQD6oBZb2fZbqn4V5sI3Ckk3Og6JdrxWNhj4uPbpR9/nM5RxvMqgluCmQ5d
         oj9hHbogOINRNnHhvQuZTrwBjV8dWG/FSaEFJDpOYfBNufNaMw23kCqsG9meiIGTUwnd
         6i/bj9ABhmoBnx1Q+ykkspQX2epavSmuqz2oZlYf/IVQUU3mShaYLFqr5sp8Oesf1iv2
         pF/xpkEsKtTAaAC1O9160+hKBVENEf1Uu19DLhc9YeQIu/YkEbjs3v4cc0eOArR/3QJA
         IE4kfROZjqhOZQvEaXdB+2wLjNhWyNZGRkZEzut9QO4oRX5lezPprflfRkaPdupuFpo2
         tPeg==
X-Gm-Message-State: AOAM5325p9VexWyLyqnmTtbu/JDBnP3CNXe8kxcjcqTiiid4f6sy7zwb
        Bos8pwCIoJd4OmtDagWmSt6HCr1YyZU=
X-Google-Smtp-Source: ABdhPJz2u3Kv/R1JMloI8+fK/U8hhtkvtSgW19kmj9FnrrUoGSUn34qvjY6nXSxu0YBYOM6OayRn4Q==
X-Received: by 2002:a37:a80a:: with SMTP id r10mr2454qke.467.1609860761660;
        Tue, 05 Jan 2021 07:32:41 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w8sm46457qts.50.2021.01.05.07.32.40
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:32:41 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FWeIR020922
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:32:40 GMT
Subject: [PATCH v1 34/42] NFSD: Update the NFSv2 GETACL argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:32:40 -0500
Message-ID: <160986076005.5532.6867620081951278716.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs2acl.c |   10 +++++-----
 fs/nfsd/nfsxdr.c  |   11 ++++++++++-
 fs/nfsd/xdr.h     |    1 +
 fs/nfsd/xdr3.h    |    2 +-
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 899762da23c9..df2e145cfab0 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -188,17 +188,17 @@ static __be32 nfsacld_proc_access(struct svc_rqst *rqstp)
 
 static int nfsaclsvc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_getaclargs *argp = rqstp->rq_argp;
 
-	p = nfs2svc_decode_fh(p, &argp->fh);
-	if (!p)
+	if (!svcxdr_decode_fhandle(xdr, &argp->fh))
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &argp->mask) < 0)
 		return 0;
-	argp->mask = ntohl(*p); p++;
 
-	return xdr_argsize_check(rqstp, p);
+	return 1;
 }
 
-
 static int nfsaclsvc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_setaclargs *argp = rqstp->rq_argp;
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index f2cb4794aeaf..5ab9fc14816c 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -38,7 +38,16 @@ decode_fh(__be32 *p, struct svc_fh *fhp)
 	return p + (NFS_FHSIZE >> 2);
 }
 
-static bool
+/**
+ * svcxdr_decode_fhandle - Decode an NFSv2 file handle
+ * @xdr: XDR stream positioned at an encoded NFSv2 FH
+ * @fhp: OUT: filled-in server file handle
+ *
+ * Return values:
+ *  %false: The encoded file handle was not valid
+ *  %true: @fhp has been initialized
+ */
+bool
 svcxdr_decode_fhandle(struct xdr_stream *xdr, struct svc_fh *fhp)
 {
 	__be32 *p;
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index d700838f6512..035c99c7b384 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -165,5 +165,6 @@ void nfssvc_release_readres(struct svc_rqst *rqstp);
 /* Helper functions for NFSv2 ACL code */
 __be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp, struct kstat *stat);
 __be32 *nfs2svc_decode_fh(__be32 *p, struct svc_fh *fhp);
+bool svcxdr_decode_fhandle(struct xdr_stream *xdr, struct svc_fh *fhp);
 
 #endif /* LINUX_NFSD_H */
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 64af5b01c5d7..43db4206cd25 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -102,7 +102,7 @@ struct nfsd3_commitargs {
 
 struct nfsd3_getaclargs {
 	struct svc_fh		fh;
-	int			mask;
+	__u32			mask;
 };
 
 struct posix_acl;


