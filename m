Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57F84F83E6
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 17:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345101AbiDGPq7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 11:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345135AbiDGPqr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 11:46:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7454DC6F1C
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 08:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8734B826CB
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 15:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1328AC385BB
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 15:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649346272;
        bh=geHWlCNz2of9qKMfCACUjEJei7ZoXiDns4tDKdJ9Pk8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GvqorTkLiyL3RSdIdgZOd39vEcFXGf0UeKg0i0YrtPIykJBxfwPEW6NEZ7no64HLz
         8PUF2Kc/tAB8/Dw6LVhqDjlJ3f0/RBPDD2SN/zuW06wuixbTEsGOIf4MmnZGR2FD6k
         rpEXoqcbTsmlf08Gif7Hzt6CiksfFSmpxsk+EExpwCPQ1HOCwKAToS8bdPQay0XSZ6
         8eMgM8T8dLXqPdQrYcTzaklHXbTQErq/jzmXzLcqxhApeH6GmotV9H2y4Xha8pWW9Y
         g5f2nBPsMz2pDGA9dyanSDdAgbASvninOM2i+rembs9NAIwt4g8gvmrRevB7AyRCx9
         g8oExaWDbTPzQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/7] SUNRPC: Handle low memory situations in call_status()
Date:   Thu,  7 Apr 2022 11:38:05 -0400
Message-Id: <20220407153809.1053261-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407153809.1053261-2-trondmy@kernel.org>
References: <20220407153809.1053261-1-trondmy@kernel.org>
 <20220407153809.1053261-2-trondmy@kernel.org>
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

We need to handle ENFILE, ENOBUFS, and ENOMEM, because
xprt_wake_pending_tasks() can be called with any one of these due to
socket creation failures.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/clnt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 07328f1d3885..6757b0fa5367 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2367,6 +2367,11 @@ call_status(struct rpc_task *task)
 	case -EPIPE:
 	case -EAGAIN:
 		break;
+	case -ENFILE:
+	case -ENOBUFS:
+	case -ENOMEM:
+		rpc_delay(task, HZ>>2);
+		break;
 	case -EIO:
 		/* shutdown or soft timeout */
 		goto out_exit;
-- 
2.35.1

