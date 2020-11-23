Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37712C1520
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgKWUEN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgKWUEM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:04:12 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2748C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:12 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id y197so18220855qkb.7
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eQANfuwWnOSHuC60MvPAFAvRrM9IVrY6VIQgnRQZKF0=;
        b=vGOgrm9iAsOWUoJ1vxKRoDEQaixN98Wp7N13RwTj8LJT4fwg+Pdnuym9dVanxoju0S
         N326oBgnGlX8usf1LbhRVXnx43Rojk/dEnOZRrQeUdcSlqFkCxn9Up8QrJLNEF429Y/T
         JeT40eQ3UvkmXi9920y4+HRQCgY0lvwngCNQTIeunMSlYKqGgTZ3i8LjlY+mKKJxdUr8
         TsPY8gvzfNTrwFu5gbLsLB0iiuqoSP244AyoiZ8yaQmMkgcCFsjw54mgEGhxOeltph0r
         3N7J09yUNCK9KhCRVtIrju9oIicqWSJ0GGzxl2LIc8wceYswNYNYPqzsUlEzB26cCFMZ
         Ezhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=eQANfuwWnOSHuC60MvPAFAvRrM9IVrY6VIQgnRQZKF0=;
        b=uA8t7EIVLLDKffvUEaDoVgqThRsJLafSJVQiBPVClycD5v/A8zRoWTdj8qJ535y9GI
         Y/l8XofSSjXel7UCTKv7NKCLLtLAOeO2JfzdGdRExiP/bIXFv0EythFQBFmwqqKYia3T
         HUX0AUnVhQrZVJgYUmpeKcQqNIPyMrvC2rj9mZ21CZQH7iH0dlLwVakMqc3O2Nr8KfSb
         QrZFheRip/zi1ZY6acrw+fMGqX3Y6C6cPB0AozGeD2iFLDDac3IJS9fGhkdgvHovZXve
         ZtUr5ipkPMTacYs1CWBZ1bHJq5yLih+KrAmDR3G40USVdrvNSViNvvDJsUBGkSUglADg
         gFng==
X-Gm-Message-State: AOAM533QGNbd7hgSUrKeiac3UtIE01xmAR1lcRA2IpVmuIrd2x75tztR
        GaNk4xcoiOlBOB/D65tERvWb4ZlEeS8=
X-Google-Smtp-Source: ABdhPJwlhef5wc9IRUodJOhcw74qyHokfaXTgCpWSg28VelcOZU67fTyS0LU8wrtv+gYnSada5sAdA==
X-Received: by 2002:ae9:d604:: with SMTP id r4mr1279514qkk.32.1606161851565;
        Mon, 23 Nov 2020 12:04:11 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s23sm9898676qke.11.2020.11.23.12.04.10
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:04:10 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK490G010272
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:04:09 GMT
Subject: [PATCH v3 02/85] SUNRPC: Prepare for xdr_stream-style decoding on the
 server-side
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:04:09 -0500
Message-ID: <160616184984.51996.13364904743048575286.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfssvc.c           |    2 ++
 include/linux/sunrpc/svc.h |   16 ++++++++++++++++
 net/sunrpc/svc.c           |    5 +++++
 3 files changed, 23 insertions(+)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 27b1ad136150..3fac172600ac 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1020,6 +1020,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	 * (necessary in the NFSv4.0 compound case)
 	 */
 	rqstp->rq_cachetype = proc->pc_cachetype;
+
+	svcxdr_init_decode(rqstp, argv->iov_base);
 	if (!proc->pc_decode(rqstp, argv->iov_base))
 		goto out_decode_err;
 
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


