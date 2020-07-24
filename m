Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662E222D086
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jul 2020 23:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGXVaA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Jul 2020 17:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGXVaA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Jul 2020 17:30:00 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06215C0619D3
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jul 2020 14:30:00 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id p205so11234235iod.8
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jul 2020 14:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=USXv8GRRHC5l4q3KotXZGxXffOscv2Z1D1us9T/Uhqk=;
        b=R+Y6GOh2DBQNRWwB8h3il29dh9Ymt6bQU2b4VRWozNJJ5RRNR1yVbdu5x4BBNYFTAp
         iuSEM9lYzO5W3TVQUydZZvTL+lZIx6tSMlvIZUDRUw1Hvnc0J6fKH9g+AVboDYxcb/5n
         2Qrsi3zZJQ3H+z83i5iYTV/dP8WKXzXUoHddPK9e8+lx9i656qr20m80agJzddewwPOO
         jWx6j5m9HPgG5onFPScfTfv82dGqWoRme9zcP6qMMOL7lfmTgzrne1fRaYpdNAht7ZuZ
         n8Ugj8iu4knuUS+kLLUNXieKxYXdrkaHrKb0wOEL1GebffUvdFD1hZwwTuGqyY+oo+Zr
         yw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=USXv8GRRHC5l4q3KotXZGxXffOscv2Z1D1us9T/Uhqk=;
        b=dZh/EcbiM6LuKRgYRQai+SfS/ILzun71/RbYANNQLRe6M68QDImjZvvK9ChKmmF/qb
         ndhMOjpSrxMuyKY19ITMFkWc4ctllLad92mZpeSqnKc1tnRPh0DIPC5AjUnCJCzo8TFH
         N87j2Gy88Vjyn/iOOCcj5vR3bCJYkFGZFlpIVfiETHPm5gjNt0B6lnBsyQU75bKNznpC
         kP2WTCbbHCv5ey9V2v1p/v9t40yQyKcKTQ2qym9W8iF/9DTCjleOj+Hcwx7L8ZsWz011
         JBS0yZRCx9YrVz87RHFIXiGw4jom8iOTxkWKZnw1iXoX2vTYXpWC3oz+64hBeDKkVUnd
         my+w==
X-Gm-Message-State: AOAM5318yTNf9tmoxEXip3wuST0cAex8AmCve2ANeXPf7nVWKKTAwPzQ
        HVpkKEL8MHZqIYVfRnjN7M+xCgt9
X-Google-Smtp-Source: ABdhPJwaWRBJfmMYiDH4z9QodDU+VHKdYysP+zleHtvGLEbWzLyxk4OtXDZ9RM8FiWq9AtyxyrHVLQ==
X-Received: by 2002:a05:6602:2cca:: with SMTP id j10mr12439575iow.22.1595626198979;
        Fri, 24 Jul 2020 14:29:58 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d9sm3828486ios.33.2020.07.24.14.29.57
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 14:29:58 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 06OLTvTu006626
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jul 2020 21:29:57 GMT
Subject: [PATCH] SUNRPC: Refresh the show_rqstp_flags() macro
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 24 Jul 2020 17:29:57 -0400
Message-ID: <159562619699.1732.3784007127107401842.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that show_rqstp_flags() can recognize and display the
RQ_AUTHERR flag, added in commit 83dd59a0b9af ("SUNRPC/nfs: Fix
return value for nfs4_callback_compound()") and the RQ_DATA flag,
added in commit ff3ac5c3dc23 ("SUNRPC: Add a server side
per-connection limit").

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 6a12935b8b14..65d7dfbbc9cd 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1250,15 +1250,34 @@ DECLARE_EVENT_CLASS(svc_xdr_buf_class,
 DEFINE_SVCXDRBUF_EVENT(recvfrom);
 DEFINE_SVCXDRBUF_EVENT(sendto);
 
+/*
+ * from include/linux/sunrpc/svc.h
+ */
+#define SVC_RQST_FLAG_LIST						\
+	svc_rqst_flag(SECURE)						\
+	svc_rqst_flag(LOCAL)						\
+	svc_rqst_flag(USEDEFERRAL)					\
+	svc_rqst_flag(DROPME)						\
+	svc_rqst_flag(SPLICE_OK)					\
+	svc_rqst_flag(VICTIM)						\
+	svc_rqst_flag(BUSY)						\
+	svc_rqst_flag(DATA)						\
+	svc_rqst_flag_end(AUTHERR)
+
+#undef svc_rqst_flag
+#undef svc_rqst_flag_end
+#define svc_rqst_flag(x)	TRACE_DEFINE_ENUM(RQ_##x);
+#define svc_rqst_flag_end(x)	TRACE_DEFINE_ENUM(RQ_##x);
+
+SVC_RQST_FLAG_LIST
+
+#undef svc_rqst_flag
+#undef svc_rqst_flag_end
+#define svc_rqst_flag(x)	{ BIT(RQ_##x), #x },
+#define svc_rqst_flag_end(x)	{ BIT(RQ_##x), #x }
+
 #define show_rqstp_flags(flags)						\
-	__print_flags(flags, "|",					\
-		{ (1UL << RQ_SECURE),		"RQ_SECURE"},		\
-		{ (1UL << RQ_LOCAL),		"RQ_LOCAL"},		\
-		{ (1UL << RQ_USEDEFERRAL),	"RQ_USEDEFERRAL"},	\
-		{ (1UL << RQ_DROPME),		"RQ_DROPME"},		\
-		{ (1UL << RQ_SPLICE_OK),	"RQ_SPLICE_OK"},	\
-		{ (1UL << RQ_VICTIM),		"RQ_VICTIM"},		\
-		{ (1UL << RQ_BUSY),		"RQ_BUSY"})
+		__print_flags(flags, "|", SVC_RQST_FLAG_LIST)
 
 TRACE_EVENT(svc_recv,
 	TP_PROTO(struct svc_rqst *rqst, int len),


