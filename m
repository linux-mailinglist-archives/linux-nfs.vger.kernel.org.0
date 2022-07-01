Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1340C5635ED
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Jul 2022 16:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiGAOjr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Jul 2022 10:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiGAOjZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Jul 2022 10:39:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F057D1EC
        for <linux-nfs@vger.kernel.org>; Fri,  1 Jul 2022 07:37:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14EA562135
        for <linux-nfs@vger.kernel.org>; Fri,  1 Jul 2022 14:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E05AC3411E
        for <linux-nfs@vger.kernel.org>; Fri,  1 Jul 2022 14:37:16 +0000 (UTC)
Subject: [PATCH] SUNRPC: Fix server-side fault injection documentation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 01 Jul 2022 10:37:15 -0400
Message-ID: <165668623535.3724787.12286270527070652017.stgit@morisot.1015granger.net>
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

Fixes: 37324e6bb120 ("SUNRPC: Cache deferral injection")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/fault-injection/fault-injection.rst |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index eb9c2d9a4f5f..17779a2772e5 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -169,6 +169,13 @@ configuration of fault-injection capabilities.
 	default is 'N', setting it to 'Y' will disable disconnect
 	injection on the RPC server.
 
+- /sys/kernel/debug/fail_sunrpc/ignore-cache-wait:
+
+	Format: { 'Y' | 'N' }
+
+	default is 'N', setting it to 'Y' will disable cache wait
+	injection on the RPC server.
+
 - /sys/kernel/debug/fail_function/inject:
 
 	Format: { 'function-name' | '!function-name' | '' }


