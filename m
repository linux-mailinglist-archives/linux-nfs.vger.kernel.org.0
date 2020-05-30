Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280CB1E91AD
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgE3Na2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgE3Na2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:30:28 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BD0C03E969;
        Sat, 30 May 2020 06:30:28 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id j3so5157416ilk.11;
        Sat, 30 May 2020 06:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3ba1hxQ7GeEKaEtWr9VxOdv11V5F/Wh/MWA7LICHSwU=;
        b=Rr8HvnpFCwCpDx9dQoQMWAYPy1OLpgi0JWJvS1DrvRUN80pr4LfFe30jvdoMlSBoRi
         3Hw9BUrhTTG6FPCCbweM3CRnzUpqtpSr8RO8t7HDu8Y3gclRhKp5UB3XES4r4GvhkHhB
         TolPOVIbUnC9XT9JeW/5QN4mSB928C1CX5fFbqKINleaT6IhELFD3LqRwXnAmWBOaXow
         +YuIo4gT7LT7Qka4bgYaXCQKj0VWdzwiIQHKgemCi9kBzqSz8OYxcN6XFKnx9SLtCwj4
         aRB/PINLvX9UjWRW8uqVeiXA4OTSYWlbttVnR5SrgcUwC7qogagepqSoEfn+92Eas7+a
         crew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=3ba1hxQ7GeEKaEtWr9VxOdv11V5F/Wh/MWA7LICHSwU=;
        b=KzsPj20yRandnLXDmcI1zXuSobMDYI1Yq1OwV8wcL/X4jyAFm1jbGiZ98lOaTz1FLy
         OUKhTS5L1+7uNya5ymWItysQE0CrIAVMKfIZWFwIuysOhqGwqI+UPMaxIY6N3LULjaKI
         FrFilza9FRma3T4Oqt8aAyyjgcSP7c7ClaoenPyY9WOR7V216R6uaChWj2+ifj4sTWmk
         qO1wx4hrVuUZJac8dpl2073rY5Mp5XUf7d5YSg+AJ15Bbd+CSYp4feMBUuWNs4gFs0b+
         mN199UfQ2XqnNgqSWAJsmI0bnyRqyEA9PV+lHJsXibIQqKvBu/urMblQa6aexFYskHqk
         ENLQ==
X-Gm-Message-State: AOAM533ZC//qi8pOWGTmPPb98kesh9cDNR2zmQn5nPoPNnKMhKMIumgZ
        dWfD0YgeDN2YufNZPS/kXmDYkCLj
X-Google-Smtp-Source: ABdhPJzAtpa4Zc+DeEkcao+vYbLktdD9bWxFNJ0IggpDODP1QJsKBP7zgPF1EuhzuNQD9u/g2Ew8/w==
X-Received: by 2002:a92:988a:: with SMTP id a10mr13077231ill.301.1590845427668;
        Sat, 30 May 2020 06:30:27 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d11sm5061618iod.11.2020.05.30.06.30.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:30:27 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDUQWJ001474;
        Sat, 30 May 2020 13:30:26 GMT
Subject: [PATCH v4 27/33] SUNRPC: svc_show_status() macro should have enum
 definitions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:30:26 -0400
Message-ID: <20200530133026.10117.18650.stgit@klimt.1015granger.net>
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
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
index 91c668bd4e4c..e24a8b0cc4bc 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1076,6 +1076,17 @@ TRACE_EVENT(svc_recv,
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

