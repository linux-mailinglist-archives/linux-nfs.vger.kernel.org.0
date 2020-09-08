Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0902615CC
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 18:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbgIHQ4X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 12:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731818AbgIHQWu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 12:22:50 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373A4C09B041
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 07:40:12 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n133so15415235qkn.11
        for <linux-nfs@vger.kernel.org>; Tue, 08 Sep 2020 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pRD4TDkRALqxK9LxYsFQi/z7ytWafNFxICfASgS7Mbw=;
        b=eUiEDJtdxSonlW1nccEEFj0ULIyhpJEgzV4rKLl9q7KhfuREZ3TvAp3Ys1aqi3JNWP
         /TdA1SN3e+k1hu9YErgTw4ANuRVsaThsA+LMFD+jKKZrvSwAHTDaYvYN2QcgM2CQea0a
         RQXwqj+DQ8QhJlGLA/a+t6mLlrImJtP2GaKxVG4AmjK08vROYEZwwWkoAljWxmuk+u0F
         Qp4+aoii6sjPhY+3kcyKCM4g8ma8UxEMDduvUORG/9z/FPx8vt2uvr3qEGliRND+Ai4S
         +MLYgq5MxJt8BAQfvp0dX5pdab3M3xjRrGDO9nziMbbZ7XW6YXVW7oyVEn1oTW8Mniyk
         YLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pRD4TDkRALqxK9LxYsFQi/z7ytWafNFxICfASgS7Mbw=;
        b=swaLnw3CELHbG9u180NfVsrXnXIrykCAQAL/8gXzdIA1QkHnX0i/dJEgDW4INbHW0F
         ul+SvTjtNgk7WuZuB1aEfNffCOFXUAYMLoA7i7/W1HHT/IC7lJyNYpUAxUdWFb+meDoz
         fFfe21sQ8EGhQOiOcSSwVgVsbNdHkVEvpcyhMnZ/u10A7G20O9R8rYj4clSy8iwGLi2e
         IBTI8Wlvxp++m5gvuW0Ts4PFaoWRYWy2r1Zqyr558qQITOJFOjinPNn+Xk3ZCn77uFSN
         fibYjGue53dyK1gZ+Rks29b1iQSrsfhHVNmlV+xXwaShkEO8XOWE/ibEt8KYxpRquoJj
         V5eg==
X-Gm-Message-State: AOAM531aYIQxZSP7T4hliiAbLIm0oqoSLdh3Uq+WSKm6TcPwhqr8OoUN
        7qsxWiVTPpl0k8o/ve3QnWxfJSBz9mE=
X-Google-Smtp-Source: ABdhPJznCYZRgZKSKmig++XOXM3ibgc2tRvrQlfr29SkEGtSa5ACGZAWoyNg9k0Ow4Vcyzzmtyy3bA==
X-Received: by 2002:a37:c202:: with SMTP id i2mr350319qkm.169.1599576010818;
        Tue, 08 Sep 2020 07:40:10 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y10sm13991599qkf.47.2020.09.08.07.40.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 07:40:09 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 088Ee8EV024288;
        Tue, 8 Sep 2020 14:40:08 GMT
Subject: [PATCH] NFSD: Correct type annotations in user xattr XDR functions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     fllinden@amazon.com
Date:   Tue, 08 Sep 2020 10:40:08 -0400
Message-ID: <159957600810.2070.13566475771084248808.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Squelch some sparse warnings:

/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4692:24: warning: incorrect type in return expression (different base types)
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4692:24:    expected int
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4692:24:    got restricted __be32 [usertype]
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4702:32: warning: incorrect type in return expression (different base types)
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4702:32:    expected int
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4702:32:    got restricted __be32 [usertype]
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4739:13: warning: incorrect type in assignment (different base types)
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4739:13:    expected restricted __be32 [usertype] err
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4739:13:    got int
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4891:15: warning: incorrect type in assignment (different base types)
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4891:15:    expected unsigned int [assigned] [usertype] count
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4891:15:    got restricted __be32 [usertype]

Fixes: 23e50fe3a5e6 ("nfsd: implement the xattr functions and en/decode logic")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 259d5ad0e3f4..400b41b86595 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4679,7 +4679,7 @@ nfsd4_encode_noop(struct nfsd4_compoundres *resp, __be32 nfserr, void *p)
 /*
  * Encode kmalloc-ed buffer in to XDR stream.
  */
-static int
+static __be32
 nfsd4_vbuf_to_stream(struct xdr_stream *xdr, char *buf, u32 buflen)
 {
 	u32 cplen;
@@ -4795,7 +4795,7 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 	u32 xdrlen, offset;
 	u64 cookie;
 	char *sp;
-	__be32 status;
+	__be32 status, tmp;
 	__be32 *p;
 	u32 nuser;
 
@@ -4888,8 +4888,8 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 	cookie = offset + count;
 
 	write_bytes_to_xdr_buf(xdr->buf, cookie_offset, &cookie, 8);
-	count = htonl(count);
-	write_bytes_to_xdr_buf(xdr->buf, count_offset, &count, 4);
+	tmp = cpu_to_be32(count);
+	write_bytes_to_xdr_buf(xdr->buf, count_offset, &tmp, 4);
 out:
 	if (listxattrs->lsxa_len)
 		kvfree(listxattrs->lsxa_buf);


