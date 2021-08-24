Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07493F68A2
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Aug 2021 20:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbhHXSCv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Aug 2021 14:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbhHXSCp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Aug 2021 14:02:45 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A17C05340F
        for <linux-nfs@vger.kernel.org>; Tue, 24 Aug 2021 10:51:22 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t190so24116429qke.7
        for <linux-nfs@vger.kernel.org>; Tue, 24 Aug 2021 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8KcYL9V8Gr9TmhS+STckBBjAx/nEA/AO9iMBAsiRX0=;
        b=J7IBXC/AbOW3ZE5+mfYj2rLHOqSN1oRcimkFJ8BZsbU8JSos5nW871cdb7ApRAP/3W
         XGlEY0v+yJGL1effzfRtl6ofwbtHG72skguUIh9VWdikeREc/eC3PMwVMXGb/fB2kxw0
         h681E6+wZ2Y2GSpL0vcXzu1G/1+TbgEByezQwZnM8JNQ6sgi+uSKoFkFKJn5ukua94Ie
         krSMlu7EMHBOFdFwRIeizvpFzXvQN6AroIQ0Fd47XjknXq++kGELTNXmRUjpskOFEtd3
         qo+PxTiA6eilc5rfbxW5IFZVQEuNSDLpTKFl8j65DS0cI09cuAz59Y/EvRrLdhO92wiW
         mYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8KcYL9V8Gr9TmhS+STckBBjAx/nEA/AO9iMBAsiRX0=;
        b=Teyutpn7FRp0JrqsYmCnUJ5icq/UxI+KopflFe8adKaWqaLGeuf2eSp6xILy22DyVZ
         u9+cPICo8wx0sy2Dc1nQQkjxrUSlcljnQSNKGQL2IL5oOhMtmAhKYTrOfhgW6j8uI43T
         PQHT9QwvniovkGDdKQVcbuiMJGCcTEngHa4eqPRR6+upnQzb7DP64scjUm+0fNKxX4xD
         J9c50UBZx/YHAgfz8eaBxzEOeLSj3vw7iDu0CKgMl4zf4KuoQheLuFBoR8+EdwFBRnEN
         DzMl0E1lvfLfd1YiYOVh351UBtHoLoVk4cFTW638AldMNO4RqeaFlravpvOu3FBmP/wD
         N/dg==
X-Gm-Message-State: AOAM531r8v58voO2uvaOfgI66R2oY5aB0nxA1JNSJrZscuwiD9+Bf9bu
        9iBVjyRg048os83y2wU8C2Q=
X-Google-Smtp-Source: ABdhPJzYQGxWU4jQ6okymIejvcexdccpJdi7lSmChetp2sE4SBSEDhr4VRx5MwFqtFi4Jat84EsRqQ==
X-Received: by 2002:a37:2ec1:: with SMTP id u184mr27566745qkh.500.1629827482065;
        Tue, 24 Aug 2021 10:51:22 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:549b:da99:adb5:676c])
        by smtp.gmail.com with ESMTPSA id n18sm11519658qkn.63.2021.08.24.10.51.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:51:21 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 4/5] SUNRPC enforce creation of no more than max_connect xprts
Date:   Tue, 24 Aug 2021 13:51:07 -0400
Message-Id: <20210824175108.19746-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210824175108.19746-1-olga.kornievskaia@gmail.com>
References: <20210824175108.19746-1-olga.kornievskaia@gmail.com>
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
index 451ac7d031db..05edb2d4b022 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2787,6 +2787,15 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 	struct rpc_cb_add_xprt_calldata *data;
 	struct rpc_task *task;
 
+	if (xps->xps_nunique_destaddr_xprts + 1 > clnt->cl_max_connect) {
+		rcu_read_lock();
+		pr_warn("SUNRPC: reached max allowed number (%d) did not add "
+			"transport to server: %s\n", clnt->cl_max_connect,
+			rcu_dereference(xprt->address_strings[RPC_DISPLAY_ADDR]));
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+
 	data = kmalloc(sizeof(*data), GFP_NOFS);
 	if (!data)
 		return -ENOMEM;
-- 
2.27.0

