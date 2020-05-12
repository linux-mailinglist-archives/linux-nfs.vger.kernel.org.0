Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC14B1D00C8
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbgELVYJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731308AbgELVYI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:24:08 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF27C061A0C;
        Tue, 12 May 2020 14:24:08 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h26so12440630qtu.8;
        Tue, 12 May 2020 14:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ygVfFXoXHsJFejgiuBymCQ4HlLT1pPdMAMnaNdaa1JU=;
        b=F6Bsl1lXcfP89qEgyoL4CCzNxA2aXC7ac73lZD6C1VD0GpIRO2gYlBGp+u5nHclbjk
         q7gz5Jj0+H3vZKQHcgMKt8qvH7y6i8qAsNbOWscVEKXpelsvmR1zLra5na9mUG+R8Ljy
         29QhSMa4XOjfV3A362IRo5TkDT4/30+Rq3doGuaHi/5JN6URgxKVVc9Y1TWNjC+fh63u
         AGAWiUa55JkHuhJofmWIQvy7MRiQEcYs0egz3wARLtz+D+HdYo+f2hMHM3OfCttqe9KQ
         R6GLNuSX4cqA6WaI530fNp4Uo+AXDg2XSaxYFGlWvIilZbNY1j0YM2IPFTOmV3IN89BL
         exew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ygVfFXoXHsJFejgiuBymCQ4HlLT1pPdMAMnaNdaa1JU=;
        b=emBek9x5zU7iUNQBzMMTZtu5cjs4fpyjTiZB6Qz2ecAaUFlkPWPoXpmBEeY1neeb2j
         /QBKRo+4D/14UbB7gj6345ICSfr55fFFeKtGWtIyt0S0/gCRoks2jPGpD6+HVdt7TJMm
         tiS1cDatCAJSVVszzkuh6/QziwZfrR0/f6J/KeLUZ5KTH4zxDAismrwCwQCdYoiKMVwk
         dlO+y2WVVf5bDOg6X2w8vAhJaEjL5snD5Fzz8XJKOgrJphiQLRaGlrpReq5EiCH8SVKe
         +v8el9hNLx6z6/AWHGdE0TkEqbqfNXZnNHeHCRLRBycRJqBOynqjRITvUyxu4uVEvALy
         SA8A==
X-Gm-Message-State: AGi0PuYKWN7+QPsT2ulrK9h13Zzdm9L7gJeyIwgwI+fe6KTkEVsD2Kai
        xMhSnr1TXadxTZUuJ9Q3hmbFrM2I
X-Google-Smtp-Source: APiQypL0nb+3Aexi6rST0nBEty1rjjr13v51Tya82/1TmN4SJxI0pHOtaV7fN7VveJX2UJn6NPoMBQ==
X-Received: by 2002:ac8:6b44:: with SMTP id x4mr13273225qts.353.1589318647918;
        Tue, 12 May 2020 14:24:07 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y18sm13924352qty.41.2020.05.12.14.24.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:24:07 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLO5Cv009945;
        Tue, 12 May 2020 21:24:05 GMT
Subject: [PATCH v2 23/29] SUNRPC: svc_show_status() macro should have enum
 definitions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:24:05 -0400
Message-ID: <20200512212405.5826.89968.stgit@klimt.1015granger.net>
In-Reply-To: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
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
index 6e32c4e16f7d..6fa08c36c6ca 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1057,6 +1057,17 @@ TRACE_EVENT(svc_recv,
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

