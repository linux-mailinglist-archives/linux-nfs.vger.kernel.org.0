Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D2F2C3420
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 23:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389966AbgKXWjY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 17:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731770AbgKXWjY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 17:39:24 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AF2C0613D6
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 14:39:24 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id h20so927717qkk.4
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 14:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Lk4aLYXRof9fgTZaa2HhStXtQBo0PnyuXqFnidC4Ftw=;
        b=qCuETC2zorLa011hyvpjf62MM4t2GmaOafdDtAatyyGm5HsqY2x30O1ahIjg2/ITIy
         FcAwHdfvjSwmkMmasZAsb+Gg+dzobwet+eGSr09eLOvMHWL2jDAGQyRa5G+2rZjqXggL
         8fqHVxhVGwIHOGkJznDL4IHRhYzWAWd3q0lDaatN8dg7IMmKUEubQtFWgdY6h3hXfQNi
         /2AHrKboUBUzPDs9DX+PDW6GpI8ghrY4MkWky3g90dPCoKGCLmYKTWduidmG5rUWcqi6
         RNkp8FeIw0IPfudcs7pJvCpGS8jDgM2a9meFZnneCTETFqrf7dIZjOpJTjrbJgXhdSU3
         CYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Lk4aLYXRof9fgTZaa2HhStXtQBo0PnyuXqFnidC4Ftw=;
        b=MxdiX6o89ZCEPC585n2yjfShR7sLnq9hvLt0qhvMQOymQRmaH8lL+7TGhQ3b7WutPa
         3vHXqvmqNd2sIZXUsmQvycGcEwtiTwOdJlWpuL7Gq7TcLKKEcx4RCWXw1lTgZrniJsjd
         6kj4kfbS6W5ir80rYuygKbWlx+fXuWiz6+V3Acpy4nH6PcdN+Szyg8BrEQky2CxA1f5q
         MqUO/c8f8A0uj/UNv27Xamp4c0MNHi/q+YY8ybFd8Dq/r57w/i/topX3W900s01Q7Bit
         Fr3rDblR03Vp6tczdmVKnlYdG/TNnXp0UMQl+f4DtIbXCaO7rS4FZfkh7FUmfyZfeb/N
         QoMA==
X-Gm-Message-State: AOAM530OlzrNz8bkm+MrlGoF1X4hS1NQhVi5TKWII5Blidl2jPYx+31N
        jTLBkldZVdmuOlUMBTBNyxPTXqrMLvw=
X-Google-Smtp-Source: ABdhPJx0xZ55DKyTTn79bHeYhoKv3ce/MSO/a5bJzFQvxrD9dlkEzrckzkcOJ2OUZGezAdwD4M9Bqw==
X-Received: by 2002:a37:6445:: with SMTP id y66mr551679qkb.100.1606257562903;
        Tue, 24 Nov 2020 14:39:22 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o22sm521904qto.96.2020.11.24.14.39.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 14:39:22 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AOMdJF1013457;
        Tue, 24 Nov 2020 22:39:20 GMT
Subject: [PATCH v1] SUNRPC: Remove XDRBUF_SPARSE_PAGES flag in gss_proxy
 upcall
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trond.myklebust@primarydata.com, simo@redhat.com,
        bfields@fieldses.org
Date:   Tue, 24 Nov 2020 17:39:19 -0500
Message-ID: <160625754220.280431.690992380938118353.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 9dfd87da1aeb ("rpc: fix huge kmalloc's in gss-proxy") added
gssp_alloc_receive_pages() to fully allocate the receive buffer
for gss_proxy upcalls.

However, later, 431f6eb3570f ("SUNRPC: Add a label for RPC calls
that require allocation on receive") sets the XDRBUF_SPARSE_PAGES
flag for this receive buffer anyway. That doesn't appear to have
been necessary, since gssp_alloc_receive_pages() still exists.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_rpc_xdr.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
index 2ff7b7083eba..44838f6ea25e 100644
--- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
+++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
@@ -771,7 +771,6 @@ void gssx_enc_accept_sec_context(struct rpc_rqst *req,
 	xdr_inline_pages(&req->rq_rcv_buf,
 		PAGE_SIZE/2 /* pretty arbitrary */,
 		arg->pages, 0 /* page base */, arg->npages * PAGE_SIZE);
-	req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
 done:
 	if (err)
 		dprintk("RPC:       gssx_enc_accept_sec_context: %d\n", err);


