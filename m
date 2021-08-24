Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123F83F68A0
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Aug 2021 20:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbhHXSCt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Aug 2021 14:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbhHXSCn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Aug 2021 14:02:43 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C24C05340A
        for <linux-nfs@vger.kernel.org>; Tue, 24 Aug 2021 10:51:18 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a66so5340671qkc.1
        for <linux-nfs@vger.kernel.org>; Tue, 24 Aug 2021 10:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=koi2dAiEUZGWQ61rcZsKU0jg5BRUtQ/tg2nRQ2aR2zE=;
        b=enVfT31jqUAud7b3MgK343g4uXuPgFNj2FDfP8ZadH6GmGvaEZQ4rqZsCQkOWtEEgk
         1UOwotC2W3jEfeWH3RbmONsKdoRQayGeYhPPI6k53SsO8skWatAwP7fHRGpaxvX5NSBe
         /RM1IrGekDX06JGkwBh48pEGuJb0R4KHG7Iexq+n63IBisRcyO7o2voJCwGdzcTPpH4l
         S9xg1s7EPv9dHZ4wfIYt4GznGTsgaSixN+JARReIFZOspK/qTaeKwnsfGz3osRrCc0PI
         8Ms7eBYCPn+MqeD3tvuMvJygh3n/Adlitr8C0PKSEqyPC31SRhCvXvqzJNxB1Z3brXxh
         utIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=koi2dAiEUZGWQ61rcZsKU0jg5BRUtQ/tg2nRQ2aR2zE=;
        b=ibRIiSSifTbWzHqyHn2d+brfFKl+aEt6eYZ8xomM+fe99jg5Jca2EO65w71pwQjab9
         ZAfaNBFrq79YQ72alL6rxEoS4q3qW163/5HSXGuToyhogzqssqZqwWl8jZyYg7VNrw+7
         uvSE9nyC08q7bV+29G9N4RVbzu7LqBgvPflve3IG7xccP5miz1oGAQWL0FLQTK+dloP4
         tie3ZiVtJ6OQPwLxsR93S2L8oCdBPJds//jYAJZsyExXAV7lAJpmLpoAMcz0YRkhIm/2
         ZuwqpZeBQZpcOp/o+P5qO6aQ7EaWYjXV5JwbYgTlKMTfzvDoVNDwyMGux8BWIqVa5MUM
         gqvw==
X-Gm-Message-State: AOAM530JjxjB5CvYmw0gXzjINKhxlSNBg5o+94n80w8w8b7pmTvQU80g
        eZT7M3erPfhuF+gKSz2iDp3e2cJmnCenqA==
X-Google-Smtp-Source: ABdhPJzj5CErqI+/v//a39GMx4tBeiTWQVsS9JqTifbV5FsdeMDB/IdvuCcIvTRu4C6pSu8ERU/NKA==
X-Received: by 2002:a37:6697:: with SMTP id a145mr28269099qkc.5.1629827477761;
        Tue, 24 Aug 2021 10:51:17 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:549b:da99:adb5:676c])
        by smtp.gmail.com with ESMTPSA id n18sm11519658qkn.63.2021.08.24.10.51.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:51:17 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/5] SUNRPC keep track of number of transports to unique addresses
Date:   Tue, 24 Aug 2021 13:51:03 -0400
Message-Id: <20210824175108.19746-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210824175108.19746-1-olga.kornievskaia@gmail.com>
References: <20210824175108.19746-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Currently, xprt_switch keeps a number of all xprts (xps_nxprts)
that were added to the switch regardless of whethere it's an
nconnect transport or a transport to a trunkable address.
Introduce a new counter to keep track of transports to unique
destination addresses per xprt_switch.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprtmultipath.h | 1 +
 net/sunrpc/clnt.c                    | 2 +-
 net/sunrpc/xprtmultipath.c           | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
index b19addc8b715..bbb8a5fa0816 100644
--- a/include/linux/sunrpc/xprtmultipath.h
+++ b/include/linux/sunrpc/xprtmultipath.h
@@ -18,6 +18,7 @@ struct rpc_xprt_switch {
 	unsigned int		xps_id;
 	unsigned int		xps_nxprts;
 	unsigned int		xps_nactive;
+	unsigned int		xps_nunique_destaddr_xprts;
 	atomic_long_t		xps_queuelen;
 	struct list_head	xps_xprt_list;
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index a5b7f6e34d15..451ac7d031db 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2799,7 +2799,7 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 
 	task = rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_ASYNC,
 			&rpc_cb_add_xprt_call_ops, data);
-
+	data->xps->xps_nunique_destaddr_xprts++;
 	rpc_put_task(task);
 success:
 	return 1;
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index c60820e45082..1693f81aae37 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -139,6 +139,7 @@ struct rpc_xprt_switch *xprt_switch_alloc(struct rpc_xprt *xprt,
 		xps->xps_iter_ops = &rpc_xprt_iter_singular;
 		rpc_sysfs_xprt_switch_setup(xps, xprt, gfp_flags);
 		xprt_switch_add_xprt_locked(xps, xprt);
+		xps->xps_nunique_destaddr_xprts = 1;
 		rpc_sysfs_xprt_setup(xps, xprt, gfp_flags);
 	}
 
-- 
2.27.0

