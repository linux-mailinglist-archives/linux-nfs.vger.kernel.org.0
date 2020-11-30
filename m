Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7502C8E8F
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 21:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgK3T7E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 14:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgK3T7E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 14:59:04 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD52C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 11:58:23 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 7so9157410qtp.1
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 11:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=nBlbg7bOymMb4vqNlPSqNPRalqrACOziCwYhySDJ21Y=;
        b=DQYBEu9SCXVRfp4JjeDXHQJbDQ96Huq87gvSAwbHwobvgk0SZULA965hWYtsA33Bpu
         hCOnc288PcWDdFHfFeqM6GneEvuJf0qlKvznkPwCZS0PONYwLMZ6/nA7Js/dkhtB86/q
         /RSKh2OMIEIguykOBlJ60QtFMKeWKtQLZ8UwsUTc0hmnvAnE1+xBf4EHdb0Z2gn+fqgL
         K7xGXNDv9OAbSc2TqOKu+ljKMehzs7c5xc+40JElfQ7jWpVSHxQyS6hgBIcknjJnrcvi
         VbQbWgponOXFwKPx4XWq2IBf4z1Mzp0AFMFS8BuPew9ZPWzMqmRsDZr0VozouqFNjZeL
         +5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=nBlbg7bOymMb4vqNlPSqNPRalqrACOziCwYhySDJ21Y=;
        b=M8c5f+tonrUxlooXYiVbcBMqNp4TlCNJRln2DOjdmlzcAqzszvA+YarzjYz9T7FPwM
         wOmDL6CgWNC+x205427A8NRSqL/777zuk2tI46qoUfDr4uF1DIxK00TmGZ7Ux52X9cob
         lx/mxDzl3lXQnIrXhGxY7xlRWy1MPJ9tw1+V5ahZCT71/iR3QcWbI+1M5PsWZ58nFGQr
         lgOAvsWk50Byto80c1m8hFKQhZLtsQIkPrGRthtPRrPcrTZ6VJaTnOdZc1ADJUMSKduR
         yIppj71+BgPIIzJ2eoCIWEYMfwy1tIfADqsDiuJAuNU0DH8FbNV2NIVgBLPabq1onDsA
         9prQ==
X-Gm-Message-State: AOAM530lPtZGDwVxFv1Z7ix5nOsNIGxpVmjg3qD/gVsvBCeL+z5ENBki
        C65Cbp6nbvWfLAvH80f2VO6RfNwrrIM=
X-Google-Smtp-Source: ABdhPJy2y5Sa4YKzst5Y/5uX9SnUJ+mjJKu4qztQmd2uEbcEKhiAnWoD4ZY1OCE7DlLoVBUhiJhvPA==
X-Received: by 2002:ac8:41d7:: with SMTP id o23mr24386005qtm.368.1606766302639;
        Mon, 30 Nov 2020 11:58:22 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h26sm17027049qkh.127.2020.11.30.11.58.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 11:58:21 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AUJwJVa029350;
        Mon, 30 Nov 2020 19:58:19 GMT
Subject: [PATCH v2] SUNRPC: Remove XDRBUF_SPARSE_PAGES flag in gss_proxy
 upcall
From:   Chuck Lever <chuck.lever@oracle.com>
To:     simo@redhat.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 30 Nov 2020 14:58:19 -0500
Message-ID: <160676629926.384675.11452129892621714986.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There's no need to defer allocation of pages for the receive buffer.

- This upcall is quite infrequent
- gssp_alloc_receive_pages() can allocate the pages with GFP_KERNEL,
  unlike the transport
- gssp_alloc_receive_pages() knows exactly how many pages are needed

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_rpc_upcall.c |   15 ++++++++++-----
 net/sunrpc/auth_gss/gss_rpc_xdr.c    |    1 -
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_rpc_upcall.c b/net/sunrpc/auth_gss/gss_rpc_upcall.c
index af9c7f43859c..d1c003a25b0f 100644
--- a/net/sunrpc/auth_gss/gss_rpc_upcall.c
+++ b/net/sunrpc/auth_gss/gss_rpc_upcall.c
@@ -200,7 +200,7 @@ static int gssp_call(struct net *net, struct rpc_message *msg)
 
 static void gssp_free_receive_pages(struct gssx_arg_accept_sec_context *arg)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < arg->npages && arg->pages[i]; i++)
 		__free_page(arg->pages[i]);
@@ -210,14 +210,19 @@ static void gssp_free_receive_pages(struct gssx_arg_accept_sec_context *arg)
 
 static int gssp_alloc_receive_pages(struct gssx_arg_accept_sec_context *arg)
 {
+	unsigned int i;
+
 	arg->npages = DIV_ROUND_UP(NGROUPS_MAX * 4, PAGE_SIZE);
 	arg->pages = kcalloc(arg->npages, sizeof(struct page *), GFP_KERNEL);
-	/*
-	 * XXX: actual pages are allocated by xdr layer in
-	 * xdr_partial_copy_from_skb.
-	 */
 	if (!arg->pages)
 		return -ENOMEM;
+	for (i = 0; i < arg->npages; i++) {
+		arg->pages[i] = alloc_page(GFP_KERNEL);
+		if (!arg->pages[i]) {
+			gssp_free_receive_pages(arg);
+			return -ENOMEM;
+		}
+	}
 	return 0;
 }
 
diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
index c636c648849b..d79f12c2550a 100644
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


