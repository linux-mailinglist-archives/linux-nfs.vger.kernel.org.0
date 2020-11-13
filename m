Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523252B1DF1
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgKMPCn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMPCn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:02:43 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477C0C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:02:43 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id u4so8996345qkk.10
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=h52B0d445gcmq5mJuPTAR+iDeh62oOOthfLOcK1a21s=;
        b=QsL8b84vhXarjYBDWyOZeAXNNPRGbsTo1d6CJddMMsGx4n88kxsEillnoi2oyaw194
         NaWNgD4csmGkIksfB93D0+xA/gYHMeHnq4wHlw/3PTqFu8A7A6V6sCe7I8q7ntFpgByK
         42djGiNCIcHbC574JaSSYeB4aNswIhm0v4DmSC6Jg0GO1gJ/Lj1/rU+YZ8zO99SN36Ze
         vt3SXaZ0VXBoSc42rqYUfOyK7AlRxg+fFXI7/uUjmCEeVISpPQGU1yj4+8pbps90dnnK
         1k+WgDMfw/WT/CKAI0NWj245gnUqgrQCYfqspamdBEzaR34L6ZZciU0ahsqbdYNJmaKq
         ku9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=h52B0d445gcmq5mJuPTAR+iDeh62oOOthfLOcK1a21s=;
        b=VnvxkOMLKtNfBypNO/WoEnuRJOgfzaGiBgqJRPX320Yxrmdzdel5MiOlkBsCiyZcMz
         WNnMYNUn0E/xsXHMFNvJSMsrHv5dk89DfrjTosqbIGIp9dzgPD47ztdJMxUzhVAQ4eG8
         WeqArbvrzO30AmUCY4akUCquwnF1BsPNmqjduIHUFHd8qsCSnMG5X1SwIRzWGNJz64Oz
         dG3xzkmp4SsFgzW9Ep0wVaF7LbLXgIgek7diWw03XXgr+mAfn7G3po/X5hsTQiq7zLn6
         fpvbJFZMJywqEq+p6dBMQjQxqLdWWEZdnwHcMfRK904BD1mIXF6tnLVEo03uNcwMPY4g
         hXZg==
X-Gm-Message-State: AOAM532EOimuj544AFJBs7bvlqN19OtjjlqjebGMkX3yW1t5ASwFqC0C
        g85ZjokgWCPENLO16bqLBo6T216jpmU=
X-Google-Smtp-Source: ABdhPJxuParydcq4GZgGoCgDvG1p4HJXNLJfvXOQGJHNxEMJYxhBIhdlrcAu+GvBIr+vURILB7qR3g==
X-Received: by 2002:a05:620a:98a:: with SMTP id x10mr2426320qkx.259.1605279761203;
        Fri, 13 Nov 2020 07:02:41 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 199sm2308016qkj.61.2020.11.13.07.02.40
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:02:40 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF2dhn032646
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:02:39 GMT
Subject: [PATCH v1 03/61] SUNRPC: Prepare for xdr_stream-style decoding on the
 server-side
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:02:39 -0500
Message-ID: <160527975951.6186.924950848939300125.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A "permanent" struct xdr_stream is allocated in struct svc_rqst so
that it is usable by all server-side decoders. A per-rqst scratch
buffer is also allocated to handle decoding XDR data items that
cross page boundaries.

To demonstrate how it will be used, add the first call site for the
new svcxdr_init_decode() API.

As an additional part of the overall conversion, add symbolic
constants for successful and failed XDR operations. Returning "0" is
overloaded. Sometimes it means something failed, but sometimes it
means success. To make it more clear when XDR decoding functions
succeed or fail, introduce symbolic constants.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c          |    3 ++-
 fs/nfsd/nfssvc.c           |    4 +++-
 include/linux/sunrpc/svc.h |   16 ++++++++++++++++
 include/linux/sunrpc/xdr.h |    5 +++++
 net/sunrpc/svc.c           |    5 +++++
 5 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e3c6bea83bd6..66274ad05a9c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5321,7 +5321,8 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, __be32 *p)
 	args->ops = args->iops;
 	args->rqstp = rqstp;
 
-	return !nfsd4_decode_compound(args);
+	return nfsd4_decode_compound(args) == nfs_ok ?	XDR_DECODE_DONE :
+							XDR_DECODE_FAILED;
 }
 
 int
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 27b1ad136150..daeab72975a3 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1020,7 +1020,9 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	 * (necessary in the NFSv4.0 compound case)
 	 */
 	rqstp->rq_cachetype = proc->pc_cachetype;
-	if (!proc->pc_decode(rqstp, argv->iov_base))
+
+	svcxdr_init_decode(rqstp, argv->iov_base);
+	if (proc->pc_decode(rqstp, argv->iov_base) == XDR_DECODE_FAILED)
 		goto out_decode_err;
 
 	switch (nfsd_cache_lookup(rqstp)) {
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index c220b734fa69..bb6c93283697 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -248,6 +248,8 @@ struct svc_rqst {
 	size_t			rq_xprt_hlen;	/* xprt header len */
 	struct xdr_buf		rq_arg;
 	struct xdr_buf		rq_res;
+	struct xdr_stream	rq_xdr_stream;
+	struct page		*rq_scratch_page;
 	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
 	struct page *		*rq_respages;	/* points into rq_pages */
 	struct page *		*rq_next_page; /* next reply page to use */
@@ -557,4 +559,18 @@ static inline void svc_reserve_auth(struct svc_rqst *rqstp, int space)
 	svc_reserve(rqstp, space + rqstp->rq_auth_slack);
 }
 
+/**
+ * svcxdr_init_decode - Prepare an xdr_stream for svc Call decoding
+ * @rqstp: controlling server RPC transaction context
+ * @p: Starting position
+ *
+ */
+static inline void svcxdr_init_decode(struct svc_rqst *rqstp, __be32 *p)
+{
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
+
+	xdr_init_decode(xdr, &rqstp->rq_arg, p, NULL);
+	xdr_set_scratch_page(xdr, rqstp->rq_scratch_page);
+}
+
 #endif /* SUNRPC_SVC_H */
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 6e9edb4dcc0f..3fffd7f15c3a 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -19,6 +19,11 @@
 struct bio_vec;
 struct rpc_rqst;
 
+enum xdr_decode_result {
+	XDR_DECODE_FAILED = 0,
+	XDR_DECODE_DONE = 1,
+};
+
 /*
  * Buffer adjustment
  */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index b41500645c3f..4187745887f0 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -614,6 +614,10 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 	rqstp->rq_server = serv;
 	rqstp->rq_pool = pool;
 
+	rqstp->rq_scratch_page = alloc_pages_node(node, GFP_KERNEL, 0);
+	if (!rqstp->rq_scratch_page)
+		goto out_enomem;
+
 	rqstp->rq_argp = kmalloc_node(serv->sv_xdrsize, GFP_KERNEL, node);
 	if (!rqstp->rq_argp)
 		goto out_enomem;
@@ -842,6 +846,7 @@ void
 svc_rqst_free(struct svc_rqst *rqstp)
 {
 	svc_release_buffer(rqstp);
+	put_page(rqstp->rq_scratch_page);
 	kfree(rqstp->rq_resp);
 	kfree(rqstp->rq_argp);
 	kfree(rqstp->rq_auth_data);


