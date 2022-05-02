Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B453517B08
	for <lists+linux-nfs@lfdr.de>; Tue,  3 May 2022 01:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiEBXzD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 May 2022 19:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiEBXyX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 May 2022 19:54:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6834DA6
        for <linux-nfs@vger.kernel.org>; Mon,  2 May 2022 16:50:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 095A7B81B05
        for <linux-nfs@vger.kernel.org>; Mon,  2 May 2022 23:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB40C385AC;
        Mon,  2 May 2022 23:50:49 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH] rpcctl.py: Use the correct function for setting xprts offline and online
Date:   Mon,  2 May 2022 16:50:47 -0700
Message-Id: <20220502235047.8222-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Otherwise the tool will tell us:
    'Namespace' object has no attribute 'set_state'

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/rpcctl/rpcctl.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index b8df556b682c..2a69eacd3103 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -142,7 +142,7 @@ class Xprt:
                 xprt.set_state("offline")
                 xprt.set_state("remove")
             else:
-                args.set_state(args.property)
+                xprt.set_state(args.property)
         print(xprt)
 
 
-- 
2.36.0

