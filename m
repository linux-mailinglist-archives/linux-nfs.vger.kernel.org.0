Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C1C1C1BBB
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgEARd3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728495AbgEARd3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:33:29 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D5EC061A0C;
        Fri,  1 May 2020 10:33:29 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k12so8498435qtm.4;
        Fri, 01 May 2020 10:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=VL2gfxbWc+cf0Wxk2VwYcXWvICIUvv49PplPw5QhzN8=;
        b=eaO0Q6UsHyLztCL8VBzl4dUrVxibimgf/VQdpzkA8ufZyszO9v63dp6j+BNuL6kLHM
         DRgk4OIS2QcymWEKqRtQF40Rm6wx0ocNmd32RAJIME/WxgD2pWLM0uVDxmXdZYWKFt/d
         JfsBW5QwtPIxJ9tCs3VMF3lwFdTz1DgS6hJs1UIktWadrHhpZKTeFIn0qr/EJ//nxZIC
         tJS48B/BORUpwp+kYEr+I5s/gwpVIWpYB8Sk3LxvvDWeH38VAaAGEgkhEDdlpsRy9YdP
         bEZ7DmMIB8ZzomRq/qVqrSgsplL2Sbp35Hha+nyKfnCQPixqP047bNp9TRwLea67T9Ii
         mqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=VL2gfxbWc+cf0Wxk2VwYcXWvICIUvv49PplPw5QhzN8=;
        b=aAoTsN2Jlsay8mvLxO+RurYx1cQtzpe3vYiytZCOU+JEgTOn3hkvqW0k0kRAjfgkUz
         iV7Md3LLjtgKhAie8f8UEsEwyytQEs0iapJdZaykusN03rR88joNIKrsO4fomumIDWaX
         1MmHMPHbWn0nxhJgAuSvloQYLGImiykyr7pr0qqf6knnDFdOjqMIPSkyPcFO77zq65MF
         MjYVJkJhPs0l6bbsRiDtz29xv7+/QOhlPIu6LPeXIgGQ44+n4aAKwsEo6y9u8zCogZPn
         HkLou59OqJxU8Ro4or+HLm0aVqGnGNWhRCe/tDNjRraqQX80rAipa8ntphCwzyX0FTxo
         rGoQ==
X-Gm-Message-State: AGi0PuZAmNVuHihSWOCZdnaSyyHOQU768Ka0IdTJ2xf/vJOUqVVlSP3T
        uQcTyNbKl0K1Lo849TKke0hqghHr
X-Google-Smtp-Source: APiQypIeGPJwXNo17mkFTzUSqFjLmlkZDxyGyvzvxs+UihAMvXA2SulNMPV+yFxCNQeQhAh1FUT0qA==
X-Received: by 2002:ac8:3665:: with SMTP id n34mr4896322qtb.227.1588354408545;
        Fri, 01 May 2020 10:33:28 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w42sm3078261qtj.63.2020.05.01.10.33.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:33:28 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HXQ9F026703;
        Fri, 1 May 2020 17:33:26 GMT
Subject: [PATCH v1 1/7] SUNRPC: svc_show_status() macro needs enum
 definitions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 01 May 2020 13:33:26 -0400
Message-ID: <20200501173326.3798.84253.stgit@klimt.1015granger.net>
In-Reply-To: <20200501172849.3798.75190.stgit@klimt.1015granger.net>
References: <20200501172849.3798.75190.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Add missing TRACE_DEFINE_ENUMs in
include/trace/events/sunrpc.h

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 3158b3f7e01e..287011041e92 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1024,6 +1024,17 @@ TRACE_EVENT(svc_recv,
 			show_rqstp_flags(__entry->flags))
 );
 
+TRACE_DEFINE_ENUM(SVC_GARBAGE);
+TRACE_DEFINE_ENUM(SVC_SYSERR);
+TRACE_DEFINE_ENUM(SVC_VALID);
+TRACE_DEFINE_ENUM(SVC_NEGATIVE);
+TRACE_DEFINE_ENUM(SVC_OK);
+TRACE_DEFINE_ENUM(SVC_DROP);
+TRACE_DEFINE_ENUM(SVC_CLOSE);
+TRACE_DEFINE_ENUM(SVC_DENIED);
+TRACE_DEFINE_ENUM(SVC_PENDING);
+TRACE_DEFINE_ENUM(SVC_COMPLETE);
+
 #define svc_show_status(status)				\
 	__print_symbolic(status,			\
 		{ SVC_GARBAGE,	"SVC_GARBAGE" },	\

