Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D662B3F9EED
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Aug 2021 20:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhH0SiS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 14:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhH0SiS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 14:38:18 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12846C061757
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 11:37:29 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id u21so6085430qtw.8
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 11:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=koi2dAiEUZGWQ61rcZsKU0jg5BRUtQ/tg2nRQ2aR2zE=;
        b=AhVKSuR225KNBMqmD+rg4d1zKvIjlBuFNBw+XJnQjEHcCvxf5ypn4dyINDk5Nnn+Oq
         o7S5vrbB3A0YlUzrBAeif0OeE4xatj5Ev2JSFUk5sXpPqTiMJij1C8AeS6WhZ4/egvhf
         RB4C8NegWcmUH1HctXXfq1i1lZ+qW1aAiOIoFmhougP2cqTnL8YEq1oeD4X7Iv/z+SMN
         VwUxL9DKIBGYGrYLewXfE9BTmZVsxzbBouyY4X1bU1v+1rhZsreLeM9EGQoeO+1CaQI6
         feb1lRkpUduIK+RborDy0rfRdgzgFCXTphwtYbKqLQlsKhtM4+YCxbMjfAi+hDOSXIrR
         G2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=koi2dAiEUZGWQ61rcZsKU0jg5BRUtQ/tg2nRQ2aR2zE=;
        b=fqSXXe1f7/HfqdyPNLDvclHwTdmpW/sZKnBentMpOrjE2ZFxpyOtEij1Xz5o9BtgV9
         T7QCIwP8IeA8ikQETI/JEpe99xHuWHXVbJVzeTNWuHf/sGp84oRCwoQytiOL9oIQm+lU
         COHwiDWEdy56snpagygDuQIvA9TIevVxaMltO9NXCCcfJkcaxYxNPjhwVgd/FcT6n2Z8
         TbeIClefuLkursEdSSJ6OriT/UTOew1BmPisulEeOx3U/SE3XAvEU7JHr3mBMpvVI9bR
         Bz95JSBL7FkgifOLD0ekbEe2Pjn5/F2VbcAowa542XTAU5/8QywjZzC8Q6WI6UQW7GuX
         3XQg==
X-Gm-Message-State: AOAM533ieI4ykpmLJeG9Jq5Mih2kfLQ++q+lb6aNXsVxudsCaYocMhsJ
        GocWPEXpBpcKNHmG/obM5pI=
X-Google-Smtp-Source: ABdhPJz8CUS9aBSNyqloebe7vPQJ62ROqxxptj4HSeB78uIaKqyv+HgWFjaZAZuBhAJmI4n5ExS4eg==
X-Received: by 2002:ac8:4704:: with SMTP id f4mr9607375qtp.80.1630089448138;
        Fri, 27 Aug 2021 11:37:28 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:b143:41d3:e2f6:337b])
        by smtp.gmail.com with ESMTPSA id bl36sm5207463qkb.37.2021.08.27.11.37.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Aug 2021 11:37:27 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 1/5] SUNRPC keep track of number of transports to unique addresses
Date:   Fri, 27 Aug 2021 14:37:14 -0400
Message-Id: <20210827183719.41057-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210827183719.41057-1-olga.kornievskaia@gmail.com>
References: <20210827183719.41057-1-olga.kornievskaia@gmail.com>
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

