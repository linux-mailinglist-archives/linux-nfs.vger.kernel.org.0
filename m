Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEE72EAE4C
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbhAEPak (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbhAEPak (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:30:40 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AA9C061798
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:30:00 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id g24so21029782qtq.12
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=iKVdinXngdEoCUgnIQSNWZSkMjjHieXbtc37ayHSX7Y=;
        b=HsDbmZuAVhw45PTS0TMRJsH+eYKmj90C1bIC6sz1tP3i/E5Hxs5mJA3I9P/H1+YRj9
         BCQl7J3VtkmFirwiq9nuBkkph8UTJ/XruH0dGPY4anHz7IgwUQBZ9J43kBb5U6ZYbEgJ
         aqF0dM3J8n+0uVoASH8EMednUQIWfjdsgJ7o0pX2pP65HEzwVyFHFrvwV1PU+psB09uU
         a4/OQ3zaJYJDTBacFDolS/qnbsXB5Y1XQaBcoa4ORGhTfgWuHJNIgVuqkO6YxKx7eOFE
         K3l2Y2wlDnxPgKS6sn81dbJPKOlYgOh+I1v3BBqAWULiA7OGBQooU5/jjACUXNmo32GJ
         lh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=iKVdinXngdEoCUgnIQSNWZSkMjjHieXbtc37ayHSX7Y=;
        b=IYNHgoswkzWpl7sEiBqCk9/suc6ME83Hkclipgm0Sx3Ktbv08BMeYOl9YDNyJu6ayl
         EXheXcW2gnMArRnxUhID7D4Y8iik5CIme/3IdDM18GkPcIegrC5bXtbQ63M8QqkvivhP
         hDTr/9GwQgxoBQVkpcPaB68Ns+/VeEZFCEvuLDVm8bTHlrhtvk0NDO2iQIbAsyWElpru
         xNmZ7yMTUlMXfQaRTfcoWpcps/J9a9WD+L3eixiQXj/Z7Ik/adPr81V9ECRjLxviqDlK
         3NblqK9u+UhaQnsI3hmI10xu30rkBIBvJrNOgVmUSEeMiHvGK3bE9cnFd7B1G/6HBjW7
         Cehw==
X-Gm-Message-State: AOAM531zeAhtS1/Z72wHrQznuPbyjQWDWjagyfzSKsdC0wc5q8sjFbGv
        ihm6aflde7R4e8d80MS9oeOEPoAGmVU=
X-Google-Smtp-Source: ABdhPJzF7J4UfxrY3wTc91MO6DWY/301vMjqzLnI/1RLoFfD6e2XazvimamzEwbRAWtbLxFXU9LcQA==
X-Received: by 2002:aed:3441:: with SMTP id w59mr18525qtd.153.1609860599117;
        Tue, 05 Jan 2021 07:29:59 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y15sm38687qto.51.2021.01.05.07.29.58
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:29:58 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FTvUt020820
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:29:57 GMT
Subject: [PATCH v1 03/42] SUNRPC: Move definition of XDR_UNIT
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:29:57 -0500
Message-ID: <160986059742.5532.14612206049969450349.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: The unit of XDR alignment is defined by RFC 4506,
not as part of the RPC message header. Thus it belongs in
include/linux/sunrpc/xdr.h.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/msg_prot.h |    3 ---
 include/linux/sunrpc/xdr.h      |   13 ++++++++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/msg_prot.h b/include/linux/sunrpc/msg_prot.h
index 43f854487539..938c2bf29db8 100644
--- a/include/linux/sunrpc/msg_prot.h
+++ b/include/linux/sunrpc/msg_prot.h
@@ -10,9 +10,6 @@
 
 #define RPC_VERSION 2
 
-/* size of an XDR encoding unit in bytes, i.e. 32bit */
-#define XDR_UNIT	(4)
-
 /* spec defines authentication flavor as an unsigned 32 bit integer */
 typedef u32	rpc_authflavor_t;
 
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 9b35ce50cf2b..8b61ec92366f 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -19,6 +19,13 @@
 struct bio_vec;
 struct rpc_rqst;
 
+/*
+ * Size of an XDR encoding unit in bytes, i.e. 32 bits,
+ * as defined in Section 3 of RFC 4506. All encoded
+ * XDR data items are aligned on a boundary of 32 bits.
+ */
+#define XDR_UNIT		sizeof(__be32)
+
 /*
  * Buffer adjustment
  */
@@ -331,7 +338,7 @@ ssize_t xdr_stream_decode_string_dup(struct xdr_stream *xdr, char **str,
 static inline size_t
 xdr_align_size(size_t n)
 {
-	const size_t mask = sizeof(__u32) - 1;
+	const size_t mask = XDR_UNIT - 1;
 
 	return (n + mask) & ~mask;
 }
@@ -361,7 +368,7 @@ static inline size_t xdr_pad_size(size_t n)
  */
 static inline ssize_t xdr_stream_encode_item_present(struct xdr_stream *xdr)
 {
-	const size_t len = sizeof(__be32);
+	const size_t len = XDR_UNIT;
 	__be32 *p = xdr_reserve_space(xdr, len);
 
 	if (unlikely(!p))
@@ -380,7 +387,7 @@ static inline ssize_t xdr_stream_encode_item_present(struct xdr_stream *xdr)
  */
 static inline int xdr_stream_encode_item_absent(struct xdr_stream *xdr)
 {
-	const size_t len = sizeof(__be32);
+	const size_t len = XDR_UNIT;
 	__be32 *p = xdr_reserve_space(xdr, len);
 
 	if (unlikely(!p))


