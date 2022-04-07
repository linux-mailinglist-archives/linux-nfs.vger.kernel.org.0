Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157444F8769
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 20:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiDGSy2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 14:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347003AbiDGSy1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 14:54:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C007194832
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 11:52:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B404961DD2
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 18:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83D2C385A0
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 18:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649357546;
        bh=v1GKfdZJkhBCnWe0zT+yWOMIjvsz805Rs3wLq8CE51M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Oz6nSMkcqvTFaSYb0Z9iE+P4QtRGDKRlMuUQs7Xn8gma4h7ECbGPz3GR9yif5nxMQ
         6YnMd37wZmRdXlZmZY9AnkPtmVrJoJStxSiVc7ATCr8q/PbqbUyqwlS8e/NSQQoJJm
         +weJSVZBLxx5oeGg6THNYcHVUaJfB6HmLSBoM6/L+aBx1kQHKHzlkc5WBt88vbVFug
         aINYlfn5GIpkPbGDImr7L01I5w0FchHikuBJwYN9BpfnG8beKrfpWwDyosS3LTeeKW
         S3b5jIDbqfQimsTo6Xr+HROiNNjVoNzdJbSUdnxetfSONvC4iM4bGpxnVDkzVC522S
         wH5MUcVQniygg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/8] SUNRPC: Handle low memory situations in call_status()
Date:   Thu,  7 Apr 2022 14:45:56 -0400
Message-Id: <20220407184601.1064640-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407184601.1064640-2-trondmy@kernel.org>
References: <20220407184601.1064640-1-trondmy@kernel.org>
 <20220407184601.1064640-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fixes: b61d59fffd3e ("SUNRPC: xs_tcp_connect_worker{4,6}: merge common code")
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

