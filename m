Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C263455CE
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 03:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCWC5n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 22:57:43 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:35932 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229946AbhCWC5a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Mar 2021 22:57:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0UT1O3Lg_1616468248;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UT1O3Lg_1616468248)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Mar 2021 10:57:28 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     linux-nfs@vger.kernel.org
Cc:     Eryu Guan <eguan@linux.alibaba.com>
Subject: [PATCH v2 2/2] sunrpc: honor rpc_task's timeout value in rpcb_create()
Date:   Tue, 23 Mar 2021 10:57:14 +0800
Message-Id: <20210323025714.28510-2-eguan@linux.alibaba.com>
X-Mailer: git-send-email 2.26.1.107.gefe3874
In-Reply-To: <20210323025714.28510-1-eguan@linux.alibaba.com>
References: <20210323025714.28510-1-eguan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently rpcbind client is created without setting rpc timeout (thus
using the default value). But if the rpc_task already has a customized
timeout in its tk_client field, it's also ignored.

Let's use the same timeout setting in rpc_task->tk_client->cl_timeout
for rpcbind connection.

Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
---
v2: no change since v1

 net/sunrpc/rpcb_clnt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index 38fe2ce8a5aa..647b323cc1d5 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -344,13 +344,15 @@ static struct rpc_clnt *rpcb_create(struct net *net, const char *nodename,
 				    const char *hostname,
 				    struct sockaddr *srvaddr, size_t salen,
 				    int proto, u32 version,
-				    const struct cred *cred)
+				    const struct cred *cred,
+				    const struct rpc_timeout *timeo)
 {
 	struct rpc_create_args args = {
 		.net		= net,
 		.protocol	= proto,
 		.address	= srvaddr,
 		.addrsize	= salen,
+		.timeout	= timeo,
 		.servername	= hostname,
 		.nodename	= nodename,
 		.program	= &rpcb_program,
@@ -705,7 +707,8 @@ void rpcb_getport_async(struct rpc_task *task)
 				clnt->cl_nodename,
 				xprt->servername, sap, salen,
 				xprt->prot, bind_version,
-				clnt->cl_cred);
+				clnt->cl_cred,
+				task->tk_client->cl_timeout);
 	if (IS_ERR(rpcb_clnt)) {
 		status = PTR_ERR(rpcb_clnt);
 		goto bailout_nofree;
-- 
2.26.1.107.gefe3874

