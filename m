Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AF978753C
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 18:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242513AbjHXQYj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 12:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242584AbjHXQYb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 12:24:31 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FAD1BDA
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 09:24:19 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34bae11c5a6so17855ab.0
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 09:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692894259; x=1693499059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Dl+uMoAIZiMgbo237+OzeANU9FxzTKRIy7w+apXFvk=;
        b=FmATE2QsnNbcubzY+5Y1bVV+UPkLlRNv6/W3pWU+ldWO8W3RNEgI3ibBloYQVShQgJ
         rDwyXB5f7IaBLgWrKH0X0C5rJRv3uauD0h2mJDQvbbStNmHzsjmn7P7ZdVmih6zvgvxe
         L99e75tye+ADvoqwyl5gOH9ZKWeYMr1tVHgFM9MGHs9dFk+IpCuJQApXu+wg3pWxffFC
         UvZjBUS8A3G7vA+jhi/zcxHVfUJtlxJdRPN0CLpp7m2tJW6eCSJ0sr5vd9nfsibyEJWH
         Ox7mYTK9mQ5qOBHTUs1M9puEutIvhZDNyi502GdOeL6ibOTKoinVqdlk4aGKA5bwk4CE
         3yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692894259; x=1693499059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Dl+uMoAIZiMgbo237+OzeANU9FxzTKRIy7w+apXFvk=;
        b=ZNXGQS5RUFRdJ/i1NKVgBHMJvawbDkoUMTA/WP0LDExZmoHa+R8YvfYtSoBwj4fBlG
         r++m9t3C/Sk1gmA1cLv7YeegrEVFU/tanf+f12Lv8rCfqqDW67/H5ylj0XLvGSz3UGty
         k0NHdSesJcavYn+6jQsYzSLMVvT9/09MaPtjYOk7nbZeXkWxuQnqlmsoyH8sVQRQxaG2
         WMbMHgklbme3rTmtdz6jUfS5Fybf9/TUpdlJlh57mQwseNxXSljSsUSv1711p3bOy7s5
         5PpZXPO2OHRNGxYWidG+19KalEbcZgnJeFe7c6qt1VTGJCj4WVrJQa90KUcL3Ek6n0nJ
         Eirw==
X-Gm-Message-State: AOJu0YyHnA70UXDhj1scI60TJtwKbuP8vQZOK5f6iIPFoWfaAVZBGrEt
        nKYiFFzn81nSoE9yOwtQ6wAVoxdTdlc=
X-Google-Smtp-Source: AGHT+IGKswN3ofalu+9DUVZ5tZof+tbZAEsPMWZO4QVhIEXDTnu7Z0UkRj/HJPbpbUhGToxpkx62rw==
X-Received: by 2002:a6b:5f0a:0:b0:792:6068:dcc8 with SMTP id t10-20020a6b5f0a000000b007926068dcc8mr4283756iob.2.1692894258961;
        Thu, 24 Aug 2023 09:24:18 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:905a:fe7:f724:cd05])
        by smtp.gmail.com with ESMTPSA id g10-20020a0566380c4a00b0042b3bf0baacsm4466768jal.138.2023.08.24.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 09:24:18 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSv4.1: fix pnfs MDS=DS session trunking
Date:   Thu, 24 Aug 2023 12:24:16 -0400
Message-Id: <20230824162416.17482-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Currently, when GETDEVICEINFO returns multiple locations where each
is a different IP but the server's identity is same as MDS, then
nfs4_set_ds_client() finds the existing nfs_client structure which
has the MDS's max_connect value (and if it's 1), then the 1st IP
on the DS's list will get dropped due to MDS trunking rules. Other
IPs would be added as they fall under the pnfs trunking rules.

Instead, this patch prposed to treat MDS=DS as DS trunking and
make sure that MDS's max_connect limit does not apply to the
1st IP returned in the GETDEVICEINFO list.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4client.c | 7 ++++++-
 net/sunrpc/clnt.c   | 9 ++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 27fb25567ce7..b35acd79b895 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -417,6 +417,7 @@ static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
 		.net = old->cl_net,
 		.servername = old->cl_hostname,
 	};
+	int max_connect = old->cl_max_connect;
 
 	if (clp->cl_proto != old->cl_proto)
 		return;
@@ -428,9 +429,12 @@ static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
 
 	xprt_args.dstaddr = clp_sap;
 	xprt_args.addrlen = clp_salen;
+	if (clp->cl_max_connect != old->cl_max_connect &&
+	    test_bit(NFS_CS_DS, &clp->cl_flags))
+		max_connect = clp->cl_max_connect;
 
 	rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
-			  rpc_clnt_test_and_add_xprt, NULL);
+			  rpc_clnt_test_and_add_xprt, &max_connect);
 }
 
 /**
@@ -1010,6 +1014,7 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 
 	__set_bit(NFS_CS_DS, &cl_init.init_flags);
+	cl_init.max_connect = NFS_MAX_TRANSPORTS;
 	/*
 	 * Set an authflavor equual to the MDS value. Use the MDS nfs_client
 	 * cl_ipaddr so as to use the same EXCHANGE_ID co_ownerid as the MDS
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d7c697af3762..325dad20a924 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2904,16 +2904,19 @@ static const struct rpc_call_ops rpc_cb_add_xprt_call_ops = {
  * @clnt: pointer to struct rpc_clnt
  * @xps: pointer to struct rpc_xprt_switch,
  * @xprt: pointer struct rpc_xprt
- * @dummy: unused
+ * @in_max_connect: pointer to the max_connect value for the passed in xprt transport
  */
 int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 		struct rpc_xprt_switch *xps, struct rpc_xprt *xprt,
-		void *dummy)
+		void *in_max_connect)
 {
 	struct rpc_cb_add_xprt_calldata *data;
 	struct rpc_task *task;
+	int max_connect = clnt->cl_max_connect;
 
-	if (xps->xps_nunique_destaddr_xprts + 1 > clnt->cl_max_connect) {
+	if (in_max_connect)
+		max_connect = *(int *)in_max_connect;
+	if (xps->xps_nunique_destaddr_xprts + 1 > max_connect) {
 		rcu_read_lock();
 		pr_warn("SUNRPC: reached max allowed number (%d) did not add "
 			"transport to server: %s\n", clnt->cl_max_connect,
-- 
2.39.1

