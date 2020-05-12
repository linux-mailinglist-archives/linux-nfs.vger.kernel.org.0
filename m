Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027101D006B
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgELVNP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELVNO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:13:14 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5498C061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:14 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z80so9708557qka.0
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jqKb55Pt+KHbF/fX6BJ5ck9TxbfE8k7Lu+u/zRrU55c=;
        b=qgJorDvVrDILWcWKIB4Q8QjWZ7rNOLg4maCh+EHyYf3/CU3C+Wvny06LjxaFEWmaed
         i2wr6ylQuHNFOpAbzYhCK0p7S3Qis28s+Cfb5/K6c+CBbaEVzqAO6adbN2gyheDbbAjO
         sAC6f9YWUZG9JJ8hURSpTgtlX/hfxUEGYkSzXTiYsB7lPUqFyFmIdd1E+t8t9GmGvfCd
         k43K5lpJjB/tTFCTVERsMv7knBLXO3eZZyw1J/MVcQwOgFNwlxhWdvOvp7I8PtHKtcPg
         DdvB7ZBWvA4je0oRm5O/MI9QH2vVfzn2tbNhsCfWxg0OTBBTZFKVPL99tSP1b9MsI09J
         LjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jqKb55Pt+KHbF/fX6BJ5ck9TxbfE8k7Lu+u/zRrU55c=;
        b=WX2DerTgnrUfju1Nuo+1K7YaB3J1ra91RxD8CeV0HOFylQO8GeP3JCrQiTGVA8LFtc
         TOPbOC8gvVEUHMfdPEtu/sw8Z0r6KPec1cf1g1+H472oegxkoOIFWFvxgRqgE/NvEcNh
         gEfYsNAhBQ3x8pIlZt6ZOS3Kf8blWwob019M7xjRVnsx7nHSoZFMI85wcGZkd9EtbNN3
         GIuCfF5KjcaJevgDOqh6xvroOgC/oi+ezt2BSpWNWjp15B6nyyOwxoYgCc2d5X3oNT7a
         ccUa/AzBis/J5OcWfqc0aAGQgnd24AC4t6qFuo93JpuOe4LpuZZVaVde8WwlqdIbaTOz
         RpHQ==
X-Gm-Message-State: AGi0PuaBSu2aQLiAbjn8COsnT70pZGQsJVNnnPEGwakHWNR+3t+p93Bf
        o0qOmSO51bUOpX+GjkMzQlY=
X-Google-Smtp-Source: APiQypJagqMbumbeHZ5bKwiiDcS2WAuCuzfpj0moWZyt6k3VN4tIzPB61CUZorqr/vMRi8OMfTaSjQ==
X-Received: by 2002:a37:7904:: with SMTP id u4mr22414403qkc.297.1589317994126;
        Tue, 12 May 2020 14:13:14 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y4sm13114751qti.33.2020.05.12.14.13.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:13:13 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLDCCq009795;
        Tue, 12 May 2020 21:13:12 GMT
Subject: [PATCH v1 04/15] SUNRPC: Update the rpc_show_task_flags() macro
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 May 2020 17:13:12 -0400
Message-ID: <20200512211312.3288.63606.stgit@manet.1015granger.net>
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

Recent additions to the RPC_TASK flags neglected to update
the tracepoint ENUM definitions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index ffd2215950dc..7d64aea7489e 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -142,29 +142,35 @@
 
 TRACE_DEFINE_ENUM(RPC_TASK_ASYNC);
 TRACE_DEFINE_ENUM(RPC_TASK_SWAPPER);
+TRACE_DEFINE_ENUM(RPC_TASK_NULLCREDS);
 TRACE_DEFINE_ENUM(RPC_CALL_MAJORSEEN);
 TRACE_DEFINE_ENUM(RPC_TASK_ROOTCREDS);
 TRACE_DEFINE_ENUM(RPC_TASK_DYNAMIC);
+TRACE_DEFINE_ENUM(RPC_TASK_NO_ROUND_ROBIN);
 TRACE_DEFINE_ENUM(RPC_TASK_SOFT);
 TRACE_DEFINE_ENUM(RPC_TASK_SOFTCONN);
 TRACE_DEFINE_ENUM(RPC_TASK_SENT);
 TRACE_DEFINE_ENUM(RPC_TASK_TIMEOUT);
 TRACE_DEFINE_ENUM(RPC_TASK_NOCONNECT);
 TRACE_DEFINE_ENUM(RPC_TASK_NO_RETRANS_TIMEOUT);
+TRACE_DEFINE_ENUM(RPC_TASK_CRED_NOREF);
 
 #define rpc_show_task_flags(flags)					\
 	__print_flags(flags, "|",					\
 		{ RPC_TASK_ASYNC, "ASYNC" },				\
 		{ RPC_TASK_SWAPPER, "SWAPPER" },			\
+		{ RPC_TASK_NULLCREDS, "NULLCREDS" },			\
 		{ RPC_CALL_MAJORSEEN, "MAJORSEEN" },			\
 		{ RPC_TASK_ROOTCREDS, "ROOTCREDS" },			\
 		{ RPC_TASK_DYNAMIC, "DYNAMIC" },			\
+		{ RPC_TASK_NO_ROUND_ROBIN, "NO_ROUND_ROBIN" },		\
 		{ RPC_TASK_SOFT, "SOFT" },				\
 		{ RPC_TASK_SOFTCONN, "SOFTCONN" },			\
 		{ RPC_TASK_SENT, "SENT" },				\
 		{ RPC_TASK_TIMEOUT, "TIMEOUT" },			\
 		{ RPC_TASK_NOCONNECT, "NOCONNECT" },			\
-		{ RPC_TASK_NO_RETRANS_TIMEOUT, "NORTO" })
+		{ RPC_TASK_NO_RETRANS_TIMEOUT, "NORTO" },		\
+		{ RPC_TASK_CRED_NOREF, "CRED_NOREF" })
 
 TRACE_DEFINE_ENUM(RPC_TASK_RUNNING);
 TRACE_DEFINE_ENUM(RPC_TASK_QUEUED);

