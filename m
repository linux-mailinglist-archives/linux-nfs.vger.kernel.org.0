Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BBB2BB717
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbgKTUeF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbgKTUeF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:34:05 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3063C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:04 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id z3so8084350qtw.9
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=64M8+66Vtjxv9O9begeuBI/TuNRu/dLLVZDpWDC3Wdc=;
        b=L3j9Nzjx26NX1MtvAnjubNfJ+aE9TyLcC5xlKU32QFDWANx01DBS0PYwmPGSqqaBR1
         aBLcTeKGra89lJ/3Y7524FROa1CK6fsHAvucOwuOWEJnB9rjmsLx+mUcNkTsjs3F4o2O
         652s5rAq2Bi5pOtnRhUCy67B4IL3X8bQCjxPYWsWvOInEnALM0FIWWAyJkLNEXhG4eLE
         eXa7SPY9EoPS1kK3kHbOAFYceCIIoGRWm4RiucQBves/prNcvbW4RSPhHbbSaQMlCUXd
         J2dgTLGFJUnoF1zDHHCLYGcJhHXWRY0CHW9MVgUSNwRTf+NdZ8hcAF4vu/kZI7PLa8ZU
         Ak7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=64M8+66Vtjxv9O9begeuBI/TuNRu/dLLVZDpWDC3Wdc=;
        b=ARto+IpQjqKI++LJ/4mrV3gxN2Krd57CqKS8FQhPvFjo5nSAY1JXNoyqOJ6174sGsi
         iiwml8AVDKeY8kPHBFQiS8hFL9THZn+53BlCSL1hqfMs/A+toOnAKw+p924ynlikeFZp
         EuMGuDSXyZY1/Q6y+CIQeyF7S0r3FR91uuaHsDYGqLq7T0pPFEQk8bjmlqPqysSRg2Dx
         jfNySmNlIwvIebMnC7vAbnsRx+a5RE1tpKdBd9X6b9JImaW3JEvu+atR3dzYnBxuCRf+
         T023hNZkvKrmG99P2PUvG5Az6A41TwY7sk2/Ehaxsv/XvTH4ShJo+IgHbR56lzvaCQRp
         OjCg==
X-Gm-Message-State: AOAM533K0x01gv3ctUeN3to3uY/pevEKXMalqFVZo0/+6uZR44LnhDxA
        7NrdvVy6icBXPL7sTbo26Sg4jR1wfHc=
X-Google-Smtp-Source: ABdhPJw5VzaGuBmFHqV6/qnGgNQ1rpJmAKTgGEkV8cRhdYVIpV30tz4Dugq2B1MfNFRlr3//C2B8Uw==
X-Received: by 2002:ac8:74d3:: with SMTP id j19mr18300664qtr.259.1605904443744;
        Fri, 20 Nov 2020 12:34:03 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a85sm2841657qkg.3.2020.11.20.12.34.02
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:34:03 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKY2PG029211
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:34:02 GMT
Subject: [PATCH v2 003/118] SUNRPC: Prepare for xdr_stream-style decoding on
 the server-side
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:34:02 -0500
Message-ID: <160590444205.1340.4589231865882719752.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
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
index 2729d2d6efce..abbb032de4e8 100644
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


