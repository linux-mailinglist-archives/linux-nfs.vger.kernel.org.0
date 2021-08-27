Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0E23F9EF1
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Aug 2021 20:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhH0SiW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 14:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhH0SiW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 14:38:22 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3546FC061757
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 11:37:33 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id m21so8147524qkm.13
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 11:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1n7QWUAyir20rnEJ75DMV1yVxgJ5KdC9qxlhEbLzmGo=;
        b=ejhd46aq9QoFW9HDNv1Y/ezcX2Dqk3+W5EbDRO9H/H75B7oht+BiQ0Bd9K3zRm9H5K
         ZepWMnnpesbxYIVtHB+rZtmrJhxnjOyoC4fYL51UTsW7ua2DvYZE0yooclRVHXd/tuOt
         qwQxVcxo6J0VZqQ0plIsxGEPE7ZsvHH4avZ7tKrNS0un3sZ48pwRVN1ozX4PCtAqoqh5
         DQdvdbl6sLmVAeXDjKcg7GTqc6y4MwOszGIDtQdBhCQh8S0L7L1hlGZuvo0K9c+WpBRO
         KLoqn97bGHwsy1gN9X/re7kBZwNCr25UwelpFQBtMHYRq9tZTlupGZx6q5pBEoS1mgmA
         7CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1n7QWUAyir20rnEJ75DMV1yVxgJ5KdC9qxlhEbLzmGo=;
        b=ZrxQnuCNOymqImlPzYJMUOjZtpuyu1B/ltwWGi5AnnJWs9ZVoO7wYEVXV03Dqjfps0
         YHblGQrcRop/eBgbmS9K7z6aoN8ObWw3ycc23j0+ZGT5vTPM3iku0moPL0GB8QehJNMf
         jvoVAdJwk/cV7bHci/Nlw8m5hYq9rg195gLYtsA1OPNzL87UGgU33yNadEkDLaEZJKb0
         uGPOeW/6xcuyx7uodAMaNh1YN9MVjTz5cPUWJ9ahWyhrledW0XE7o80sRfrtmF1yZFN6
         tS19E0cAoJm4+v/ilK+7XrgKrHGjtF1Bu3wk8DNSxrM9jxcXBOV0DSDoVxmUTM0c3OCw
         UkNw==
X-Gm-Message-State: AOAM530r038iMkSiBIl4SviJp7p9EjbmqhAdex8S/7EbMLsoU7E5KvNz
        Noz4lyublon6UUDXpE3sE7Rv0a0OiHcq+A==
X-Google-Smtp-Source: ABdhPJxR3obVczUtyKywiQrbaI9QWjkYIDwg84fF7RLucjINcccfyEGuXTQdxQ7pRZF5sRSubk05wg==
X-Received: by 2002:a05:620a:199d:: with SMTP id bm29mr10476735qkb.14.1630089452398;
        Fri, 27 Aug 2021 11:37:32 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:b143:41d3:e2f6:337b])
        by smtp.gmail.com with ESMTPSA id bl36sm5207463qkb.37.2021.08.27.11.37.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Aug 2021 11:37:32 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 4/5] SUNRPC enforce creation of no more than max_connect xprts
Date:   Fri, 27 Aug 2021 14:37:18 -0400
Message-Id: <20210827183719.41057-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210827183719.41057-1-olga.kornievskaia@gmail.com>
References: <20210827183719.41057-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

If we are adding new transports via rpc_clnt_test_and_add_xprt()
then check if we've reached the limit. Currently only pnfs path
adds transports via that function but this is done in
preparation when the client would add new transports when
session trunking is detected. A warning is logged if the
limit is reached.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/client.c             | 1 +
 include/linux/sunrpc/clnt.h | 2 ++
 net/sunrpc/clnt.c           | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 486dec59972b..23e165d5ec9c 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -541,6 +541,7 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 
 	clnt->cl_principal = clp->cl_principal;
 	clp->cl_rpcclient = clnt;
+	clnt->cl_max_connect = clp->cl_max_connect;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nfs_create_rpc_client);
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index b2edd5fc2f0c..a4661646adc9 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -82,6 +82,7 @@ struct rpc_clnt {
 		struct work_struct	cl_work;
 	};
 	const struct cred	*cl_cred;
+	unsigned int		cl_max_connect; /* max number of transports not to the same IP */
 };
 
 /*
@@ -136,6 +137,7 @@ struct rpc_create_args {
 	char			*client_name;
 	struct svc_xprt		*bc_xprt;	/* NFSv4.1 backchannel */
 	const struct cred	*cred;
+	unsigned int		max_connect;
 };
 
 struct rpc_add_xprt_test {
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 451ac7d031db..f056ff931444 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2787,6 +2787,15 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 	struct rpc_cb_add_xprt_calldata *data;
 	struct rpc_task *task;
 
+	if (xps->xps_nunique_destaddr_xprts + 1 > clnt->cl_max_connect) {
+		rcu_read_lock();
+		pr_warn("SUNRPC: reached max allowed number (%d) did not add "
+			"transport to server: %s\n", clnt->cl_max_connect,
+			rpc_peeraddr2str(clnt, RPC_DISPLAY_ADDR));
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+
 	data = kmalloc(sizeof(*data), GFP_NOFS);
 	if (!data)
 		return -ENOMEM;
-- 
2.27.0

