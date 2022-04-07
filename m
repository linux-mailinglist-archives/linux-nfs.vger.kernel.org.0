Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A8C4F876D
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 20:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347008AbiDGSyb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 14:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347007AbiDGSy3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 14:54:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C0E195318
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 11:52:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED924B82964
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 18:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8195DC385A6
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 18:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649357545;
        bh=EnGFPXwFmV30OHTUGDdJOtNW6uPHvBWYnfRHsJMk4s0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iDg8bn6ApcHl9RD+xRX6JzkCx1OLEUY/d5NyON/AYtZ9rb0V2qyrRAL5gfhPtIPRI
         Lf9Ig9vSVSs7kzg/MCF1Y/WB5alarC5A8rkzDcQP8MMA4G627C1R2plpsnPplb8gCF
         fXQ6OfwuGIcm8h77cAxNbwCUWvydc/C7l1eIh0mvOzgoxVJseF3Z9VKX4SuzXV02i6
         Lb2gt78jJ+oRK/5nyX7v5ZKvGsCyBqj63lt0xT2pcb3iJPvf/b5U8j+KdUwe2209fU
         OJESiAmP2HbJb4wttKW2EhgcPPUxMHVns5QIMoYtJSXzrnvsB3nqVzum5GJQPsEThm
         T0HFhM+z+bIlQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/8] SUNRPC: Handle ENOMEM in call_transmit_status()
Date:   Thu,  7 Apr 2022 14:45:55 -0400
Message-Id: <20220407184601.1064640-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407184601.1064640-1-trondmy@kernel.org>
References: <20220407184601.1064640-1-trondmy@kernel.org>
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

Fixes: 0472e4766049 ("SUNRPC: Convert socket page send code to use iov_iter()")
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

