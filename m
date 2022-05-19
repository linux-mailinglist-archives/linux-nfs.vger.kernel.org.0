Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BFA52D93B
	for <lists+linux-nfs@lfdr.de>; Thu, 19 May 2022 17:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241582AbiESPuv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 May 2022 11:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbiESPt0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 May 2022 11:49:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CD47CB19
        for <linux-nfs@vger.kernel.org>; Thu, 19 May 2022 08:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07ADBB8256A
        for <linux-nfs@vger.kernel.org>; Thu, 19 May 2022 15:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFF8C385AA;
        Thu, 19 May 2022 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652975248;
        bh=yDCXqHGz4ZY/OCzx3HkBMTBqsvtJ87c6o5ddW84PcD8=;
        h=From:To:Cc:Subject:Date:From;
        b=Vgt11zj48UUjoVWto3a592i5aP4yg2AK7Pxz1tn5LNttKzYjXiegZi0Px0dp+AoRy
         NJJuIb4SxCBBzRSxIONZlK+15Hm6f6qdspGa4Ksp3mWJJ1CqzpKLIx71i4bN4+mSv6
         o0+YHPW2gjZ21CZfdBblimmrWA8jG3otTxd8FqsRqHzmpkIYdqSR2Sdk9HQ4B6LX8K
         wpnQpM366+0o1qYIZFVBa5WyWQgt3TUApBCXHAKZfm+Z6lZF87xvT3iKUbf+idOiPb
         eXp+R35c4zoP9YnpdkBOlQ98Rs8oALV/XKWgiC9Akl4UjcBLSPccg+bPXmxf3H3l4L
         VJZAy5EN1e2vQ==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, steved@redhat.com
Cc:     anna@kernel.org
Subject: [PATCH v2 1/2] rpcctl: Use the correct function for setting xprts offline and online
Date:   Thu, 19 May 2022 11:47:26 -0400
Message-Id: <20220519154727.3577715-1-anna@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.36.1

