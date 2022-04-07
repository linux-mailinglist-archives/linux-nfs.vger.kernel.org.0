Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48834F83F4
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 17:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345080AbiDGPqx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 11:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345123AbiDGPqh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 11:46:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C18C6B54
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 08:44:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CEEE61EB6
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 15:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E962C385B2
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 15:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649346271;
        bh=JdLNTLNoccxME1ykAb6vaTCpoobIqzNPmf+4E3wWhbQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kagtjd/dZvZ/+AyyYVU6oxUubBo8nSgkDykUAzBT4yC9wrv/pRo/dEYEyKsF7DKQS
         57PdCFqZQs4nJdtIdvR1m8tGZv9xe4wi3JP5hBfvR2xYyEldRA96EtNkmA1KZ3MIR8
         xEFGO/UKo0+Gl42btaHgWJlLrxKdcFgYl2UEV2ajXtMsPxhP7rGhJihiFMmAdpTDJP
         d8AOXxJthBqWNMBPJQ2ZirrmtaZzFTTh20dJtvtCEi+C2LBiIG1V/8kCe9pnWRxleR
         KmktIWcvrF3yOTmKW4iQs+PPGOCquFPYTHvmu+pOU3zLNlcnDQmWYA9L9aTmqZGxwC
         xgy/Y4VNcNzKA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/7] SUNRPC: Handle ENOMEM in call_transmit_status()
Date:   Thu,  7 Apr 2022 11:38:04 -0400
Message-Id: <20220407153809.1053261-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407153809.1053261-1-trondmy@kernel.org>
References: <20220407153809.1053261-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Both call_transmit() and call_bc_transmit() can now return ENOMEM, so
let's make sure that we handle the errors gracefully.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/clnt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 3c7407104d54..07328f1d3885 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2200,6 +2200,7 @@ call_transmit_status(struct rpc_task *task)
 		 * socket just returned a connection error,
 		 * then hold onto the transport lock.
 		 */
+	case -ENOMEM:
 	case -ENOBUFS:
 		rpc_delay(task, HZ>>2);
 		fallthrough;
@@ -2283,6 +2284,7 @@ call_bc_transmit_status(struct rpc_task *task)
 	case -ENOTCONN:
 	case -EPIPE:
 		break;
+	case -ENOMEM:
 	case -ENOBUFS:
 		rpc_delay(task, HZ>>2);
 		fallthrough;
-- 
2.35.1

