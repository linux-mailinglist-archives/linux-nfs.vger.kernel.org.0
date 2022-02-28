Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1F24C7A9D
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 21:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiB1Uiu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 15:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiB1Uit (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 15:38:49 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3BE17A84
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:38:10 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id g24so11371142qkl.3
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0FuAYtLnKT1mlulwvPsP9LLaHPo1cSJpwFcFGSUq3sE=;
        b=iZVjyIVWoNzx8+XlU6SJTFtd7u2TSwETi+e4tQF6B3HVJrp2HZx1nQ1iX+HD4LMiwd
         jYnpFBXyWkYmrVM2weX62vweMHdDit9NGmgxpeuaokMPFWfbn7l6dfhpNsVwae9kRP7A
         PgUVdCiK4Bg2g49VXbEtXPb36ZEuegoj5Iia7gWg3eTCX5hYw0a0XuThblGRhypYkbF7
         qf1pZHtyk78bYp0Q0137mHEbSiL4feSDBaLknutO8CEO3ra2hdKOKabiYekfzfmdTuVy
         55EP5bS0KiWojDb2Lb4NbbWY4rFQ3jjLlCZKgyKxwKyX82Qhi67Ew2rIHjgq2LT8348y
         PLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0FuAYtLnKT1mlulwvPsP9LLaHPo1cSJpwFcFGSUq3sE=;
        b=SkMawBruUG265cjIVMj7I/VEr5awSpp8uz1HLep1U8+Vpa9SFkAvZFvAWLiE2aDKMj
         XlcsshXe/69q0WF6L2+9JqQS/hf7HZgDaruYwCO+R39AULwlvuTMBbvhN3wooMqKLypT
         RcQQFJaAa8AFDjzcZ/K1G4e0fY2GYadZ5oMuzHIfWuAFTHushIJCaSzP+BG8uhXwmVhy
         sXlHdEDTZJbz/8OqmkU642TpE3TKGuvNC2CtCL0b6D5xT0gK5tCu5oCRoLKcJWn/RQXh
         bRnksZljRvZtPnajD1ejS40hN7M3mPndzdvx5KQhp/U0FG8R7huIOKQsnuTjf9s26iyx
         l0kQ==
X-Gm-Message-State: AOAM533DClmqS+jK5yWy6mwt90K9wGBHFbbkCV5HUvYhn3S7MMInkZhu
        Zr5+yAOmGYti/K4flJ4cMQM=
X-Google-Smtp-Source: ABdhPJx7nJ1JnHeZz+quzEKxhEYLeE66F26kY8HeFIqmNmxwFSQOxOSwK9Z7sB7127snRKcUnR2vHA==
X-Received: by 2002:a37:886:0:b0:60b:57d8:3192 with SMTP id 128-20020a370886000000b0060b57d83192mr12252074qki.67.1646080689281;
        Mon, 28 Feb 2022 12:38:09 -0800 (PST)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:4cc0:8dcd:bb8c:75c2])
        by smtp.gmail.com with ESMTPSA id p20-20020a05620a22b400b00648ca1458b4sm5457606qkh.5.2022.02.28.12.38.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 12:38:08 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 2/3] SUNRPC add function to offline remote trunkable transports
Date:   Mon, 28 Feb 2022 15:38:03 -0500
Message-Id: <20220228203804.61803-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220228203804.61803-1-olga.kornievskaia@gmail.com>
References: <20220228203804.61803-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Interate thru available transports in the xprt_switch for all
trunkable transports offline and remote them.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/clnt.h |  1 +
 net/sunrpc/clnt.c           | 39 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 267b7aeaf1a6..273e507c5c87 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -233,6 +233,7 @@ int		rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *,
 			struct rpc_xprt_switch *,
 			struct rpc_xprt *,
 			void *);
+void		rpc_clnt_destroy_trunked_xprts(struct rpc_clnt *);
 
 const char *rpc_proc_name(const struct rpc_task *task);
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 97165a545cb3..6bb317caa128 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2946,6 +2946,45 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_add_xprt);
 
+static int rpc_xprt_destroy(struct rpc_clnt *clnt, struct rpc_xprt *xprt, void *data)
+{
+	struct rpc_xprt *main_xprt;
+	struct rpc_xprt_switch *xps;
+	int err = 0;
+
+	xprt_get(xprt);
+
+	rcu_read_lock();
+	main_xprt = xprt_get(rcu_dereference(clnt->cl_xprt));
+	xps = xprt_switch_get(rcu_dereference(clnt->cl_xpi.xpi_xpswitch));
+	err = rpc_cmp_addr_port((struct sockaddr *)&xprt->addr,
+				(struct sockaddr *)&main_xprt->addr);
+	rcu_read_unlock();
+	xprt_put(main_xprt);
+	if (err)
+		goto out;
+
+	if (wait_on_bit_lock(&xprt->state, XPRT_LOCKED, TASK_KILLABLE)) {
+		err = -EINTR;
+		goto out;
+	}
+	xprt_set_offline_locked(xprt, xps);
+	xprt_delete_locked(xprt, xps);
+
+	xprt_release_write(xprt, NULL);
+out:
+	xprt_put(xprt);
+	xprt_switch_put(xps);
+	return err;
+}
+
+void rpc_clnt_destroy_trunked_xprts(struct rpc_clnt *clnt)
+{
+	rpc_clnt_iterate_for_each_xprt(clnt, rpc_xprt_destroy, NULL);
+	return;
+}
+EXPORT_SYMBOL_GPL(rpc_clnt_destroy_trunked_xprts);
+
 struct connect_timeout_data {
 	unsigned long connect_timeout;
 	unsigned long reconnect_timeout;
-- 
2.27.0

