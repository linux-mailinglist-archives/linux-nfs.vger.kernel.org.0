Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6087ECAF0
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Nov 2023 20:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjKOTCW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Nov 2023 14:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjKOTCV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Nov 2023 14:02:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9BAE5
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 11:02:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DA3C433CA
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 19:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700074937;
        bh=Oxl0F+p87/Zb7F7ROl2xmY/7M8/1Z0fxZEGCh8/KSVc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tbsd97z/IHKHj0EtAf0Lc2RDXWIrdalQs5ATrPlaH+lVv/+nRXwJ/GaqO1jSj8UUJ
         aE66cqRAngM2UFSL2YBTOwnrwy0srejpHJfCtjHZyqucG17beEZCZiXubGULDy1QMl
         yrJNaMUX4CAbuxmPYHJUfTOnkuENgNz6RP1AZi/88gFLtYQpppBMS9HtTHCSkAIKv4
         uwEVIx6BTyjgayK8MBaedfKRtJyU2jt/vS5TDDWvapwxWCKaL/D1xKgL9rzYlNYbn+
         nim9U0NZogfAPE8MYFDSzxvFaN/uPrD+Fon3EQb5dwwqtsg9beIwYu0F9JqmqeiZDY
         LLOBEVE34vvtA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFSv4.1/pnfs: Ensure we handle the error NFS4ERR_RETURNCONFLICT
Date:   Wed, 15 Nov 2023 13:55:29 -0500
Message-ID: <20231115185529.303842-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115185529.303842-2-trondmy@kernel.org>
References: <20231115185529.303842-1-trondmy@kernel.org>
 <20231115185529.303842-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Once the client has processed the CB_LAYOUTRECALL, but has not yet
successfully returned the layout, the server is supposed to switch to
returning NFS4ERR_RETURNCONFLICT. This patch ensures that we handle
that return value correctly.

Fixes: 183d9e7b112a ("pnfs: rework LAYOUTGET retry handling")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e7e80c67d82b..7e3053339d6a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -170,6 +170,7 @@ static int nfs4_map_errors(int err)
 	case -NFS4ERR_RESOURCE:
 	case -NFS4ERR_LAYOUTTRYLATER:
 	case -NFS4ERR_RECALLCONFLICT:
+	case -NFS4ERR_RETURNCONFLICT:
 		return -EREMOTEIO;
 	case -NFS4ERR_WRONGSEC:
 	case -NFS4ERR_WRONG_CRED:
@@ -558,6 +559,7 @@ static int nfs4_do_handle_exception(struct nfs_server *server,
 		case -NFS4ERR_GRACE:
 		case -NFS4ERR_LAYOUTTRYLATER:
 		case -NFS4ERR_RECALLCONFLICT:
+		case -NFS4ERR_RETURNCONFLICT:
 			exception->delay = 1;
 			return 0;
 
@@ -9691,6 +9693,7 @@ nfs4_layoutget_handle_exception(struct rpc_task *task,
 		status = -EBUSY;
 		break;
 	case -NFS4ERR_RECALLCONFLICT:
+	case -NFS4ERR_RETURNCONFLICT:
 		status = -ERECALLCONFLICT;
 		break;
 	case -NFS4ERR_DELEG_REVOKED:
-- 
2.41.0

