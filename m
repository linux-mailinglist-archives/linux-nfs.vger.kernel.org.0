Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441E05B62A6
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 23:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiILVW4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 17:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiILVWy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 17:22:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5A32AC65
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 14:22:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 659D9B80C9E
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B705C433D6
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:22:51 +0000 (UTC)
Subject: [PATCH v1 04/12] SUNRPC: Clarify comment that documents
 svc_max_payload()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 12 Sep 2022 17:22:50 -0400
Message-ID: <166301777040.89884.17493610305295762804.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <166301759113.89884.7985359396842428444.stgit@oracle-102.nfsv4.dev>
References: <166301759113.89884.7985359396842428444.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Note the function returns a per-transport value, not a per-request
value (eg, one that is related to the size of the available send or
receive buffer space).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 32a537f852fe..149171774bc6 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1554,8 +1554,12 @@ bc_svc_process(struct svc_serv *serv, struct rpc_rqst *req,
 EXPORT_SYMBOL_GPL(bc_svc_process);
 #endif /* CONFIG_SUNRPC_BACKCHANNEL */
 
-/*
- * Return (transport-specific) limit on the rpc payload.
+/**
+ * svc_max_payload - Return transport-specific limit on the RPC payload
+ * @rqstp: RPC transaction context
+ *
+ * Returns the maximum number of payload bytes the current transport
+ * allows.
  */
 u32 svc_max_payload(const struct svc_rqst *rqstp)
 {


