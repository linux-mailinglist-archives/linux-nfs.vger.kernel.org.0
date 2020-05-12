Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA361D006C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbgELVNW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELVNV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:13:21 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4445DC061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:20 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id i14so14101756qka.10
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KdysCjWeP8o1iq2I2jdOiDnC1yonBzxZy+m+leAe4MI=;
        b=cLflvzDr9efebmJADLaNr5pd8YUBRurSInZ25i9B4Aa2LfXwPIpqKIlK0/X6Cho1rq
         H1gUFVFrsN/7GYicrPbRl57/rrfi7Gw9e/sZpFgu744hkIoN17jN8Xd1VikBfk1qi2nL
         P5xYTserfhAtylTZHUHh7DnNNiyP0A7b237G742rB+3e2WBFeuWgtmFsotr/hGkbpniQ
         mSdU8Nv8SGGMWAz5BxqUmqX43rnnL3vzpOyCPZuCDnDHeVvOzzc5XC7SQKhkj4T3PTIo
         bLM8QbfnRx0ZZCi4e9eL3BeEhfZpI6R00kFRVBw3A3zBt49CKBYrUJOIVdZ4x0rut40Q
         O0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=KdysCjWeP8o1iq2I2jdOiDnC1yonBzxZy+m+leAe4MI=;
        b=Fff+5j9apxEbzdCIAU6Nu01JQ0V7ymqUlS8KsvdbHStuFFF5/kaEK2iLTjjyqMOvld
         R2rR3sd0QbmfpV4YWa5ob8YWD/iSIt32ifYo1/Io7IwNimwAg7ZOeMcc/MVGfpV83UXB
         e99K89H8shNbrKtEhUV60kpaLZekxCp2YqaFLA2ADfoU1Pj6q9GE/Cc9rUTz2D39tjks
         XLGNNqROrq/wyV6foPL3uulgTabYjWldur7SjOWV1bX1NaD9nt0X485WvZ/aTrRV6CIb
         LeFxfUQig7dn/CZ38YljjajCKtfR5VuRcopWswyVXuFXYynpgq6flHKICNyBKbXxw6vt
         nMgw==
X-Gm-Message-State: AGi0PuaY2YObG8M8oWVY6BICJSSkxYYfWhe3BqmE8i/5wh/RCkEllNtG
        WsLzXLknSIj5Fx+jZxs7514SnAig
X-Google-Smtp-Source: APiQypL02EpHRiyFzP6Z03a3vLT4N+N4KUJciQDJXBwanNwjB2wrYz5lKFDZVQgZHNRfVldlBqG3lw==
X-Received: by 2002:a37:7d7:: with SMTP id 206mr22692645qkh.75.1589317999575;
        Tue, 12 May 2020 14:13:19 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g187sm11840166qkf.115.2020.05.12.14.13.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:13:19 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLDIiW009798;
        Tue, 12 May 2020 21:13:18 GMT
Subject: [PATCH v1 05/15] SUNRPC: Update the RPC_SHOW_SOCKET() macro
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 May 2020 17:13:18 -0400
Message-ID: <20200512211317.3288.70487.stgit@manet.1015granger.net>
In-Reply-To: <20200512210724.3288.15187.stgit@manet.1015granger.net>
References: <20200512210724.3288.15187.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: remove unnecessary commas, and fix a white-space nit.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 7d64aea7489e..f6896bcfd97f 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -581,9 +581,9 @@
 #define RPC_SHOW_SOCKET				\
 	EM( SS_FREE, "FREE" )			\
 	EM( SS_UNCONNECTED, "UNCONNECTED" )	\
-	EM( SS_CONNECTING, "CONNECTING," )	\
-	EM( SS_CONNECTED, "CONNECTED," )	\
-	EMe(SS_DISCONNECTING, "DISCONNECTING" )
+	EM( SS_CONNECTING, "CONNECTING" )	\
+	EM( SS_CONNECTED, "CONNECTED" )		\
+	EMe( SS_DISCONNECTING, "DISCONNECTING" )
 
 #define rpc_show_socket_state(state) \
 	__print_symbolic(state, RPC_SHOW_SOCKET)

