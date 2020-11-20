Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AD42BB79D
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbgKTUml (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbgKTUml (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:42:41 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F17C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:41 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id g19so5340491qvy.2
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Sd8dJ+vhY4totOWquvfDXBmvbzE5i3ocYTvi910W9zE=;
        b=WhDWHszmVJf4XuCQl32MhL+YtV0zl+CGeP5eA406VYKxmV4l/v+EsTtqmGCZEWCs4L
         KGM0M3YYYwX4rA3UoWgcZO88/5Zdx8UjhjMqUqO3OF9dsvg+WKXJOI0SazrTn3ET8ZoN
         DlZ3NbZjIRkwGIboy1L4hKg+2JymaJoUb3nMxqFiRWVH7B7mQo4xf5+pHWjCBr0Db7tW
         /ZUUw7qEi7tTOpl3TE+dvmbeKn+5ixAi3bnlPmB7GiOIk/MXsMnplHwLbrn0NIxNNfMB
         AG0Pa2DoZb/rvGQC4zMJt6xc+WMDcc08TlVH0clZ1lTlZGfUhgnvsnxLsXnQmT/xY1V3
         qcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Sd8dJ+vhY4totOWquvfDXBmvbzE5i3ocYTvi910W9zE=;
        b=ir5lSzlD0jb+C7jNUp2GoufUxEYMlo3k16usDeymaYbDuejntFThqf/dhbvafpJRcW
         KBAJwLBHbGA50rRZ2saVQx2xI/tZoA8pNxCyAI2XTv9pfdg/YdFYYTEvu+SwZ6e+0QEg
         PvhgC4TJCh3eM9OmtannFbmiW0G/EegkdcxodPxlm+W9TdZCA6bA8sSjF2M8niWf4e/M
         IFaFMZmpSACupSss8/1Rv0D8axkxYpZgg8fk3SV/Fnj84uS0orpunrZ+PN8LCkDqSqwY
         o5qBYsNWTm72pKHdg6WujqTPk1f4+janbYL5/Xk7L2h8/OwiLU7CXovQzNEFCU2b90+Z
         k0zw==
X-Gm-Message-State: AOAM530V0SHFRuOvozzrK7VOT+ZB9Y75mL73EanWhEBKo0Ri7P4hZ/wv
        3OIVmtheDC8xo4++rDiXkI3rDCgObgk=
X-Google-Smtp-Source: ABdhPJxyjAXHtPoYLxTE+b5R09OCjRW4A/87JAlc8EXStWMVdnOsLzvX+dP7XfiWJL44dVi51Hb/Zg==
X-Received: by 2002:a0c:fbac:: with SMTP id m12mr18352801qvp.52.1605904960211;
        Fri, 20 Nov 2020 12:42:40 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c1sm2794402qkd.74.2020.11.20.12.42.39
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:42:39 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKgcl3029513
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:42:38 GMT
Subject: [PATCH v2 100/118] NFSD: Update the NFSv2 READLINK argument decoder
 to use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:42:38 -0500
Message-ID: <160590495858.1340.4398743109655305209.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
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
index 998a1f94c6f8..94b1fa0c3c58 100644
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
@@ -669,9 +670,9 @@ static const struct svc_procedure nfsd_procedures2[18] = {
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
index 68a17a9b750f..d2af4ab51418 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -320,19 +320,6 @@ nfssvc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p)
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


