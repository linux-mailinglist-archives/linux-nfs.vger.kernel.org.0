Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2768C52D93C
	for <lists+linux-nfs@lfdr.de>; Thu, 19 May 2022 17:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiESPux (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 May 2022 11:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241731AbiESPt1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 May 2022 11:49:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6BF7CB28
        for <linux-nfs@vger.kernel.org>; Thu, 19 May 2022 08:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85A26B825F6
        for <linux-nfs@vger.kernel.org>; Thu, 19 May 2022 15:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5474C34113;
        Thu, 19 May 2022 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652975249;
        bh=KA1DpMTgU5IhJ9T8CU20S/Ui/1sVmA4bIeBdoK+Xdj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+587dhUThgJJ4D1dqxYo6oljF093GRZskeDVShJJ48jS8VinwhiXS+KwPq8v8dVP
         5c/lPZZ7QL1p87QdC86oo0p0hNKgdXDWhvYTfotIE1bAT4Dkg7X6L+HzvZjY2+EhW6
         awYJ1lBkdom1S+3euMVgwspzR4mHuvfJCVtJc0npHjfdZcwNuvPj1phWMD/jhhtHlW
         14GztBrjlVVtcfPHEigA2w01Rly/FMUqfOqsV7vHcCT7EmJ0t9GT6gYT3Fw+52zeWt
         qBP9c2DZsAIbIH1+xatj64YnKl0SfVw7N3yJm+zAH44WCzNgH4FXKsrgy3cnk0FAp9
         NCXicgzplSaWA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, steved@redhat.com
Cc:     anna@kernel.org
Subject: [PATCH v2 2/2] rpcctl: Print a message if the user tries to modify a main xprt
Date:   Thu, 19 May 2022 11:47:27 -0400
Message-Id: <20220519154727.3577715-2-anna@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519154727.3577715-1-anna@kernel.org>
References: <20220519154727.3577715-1-anna@kernel.org>
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

'main' xprts cannot be set offline or removed, so print a helpful error
message in this case instead of a cryptic 'invalid argument' message.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/rpcctl/rpcctl.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 2a69eacd3103..d2110ad6de93 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -90,10 +90,18 @@ class Xprt:
         self.dstaddr = write_addr_file(self.path / "dstaddr", newaddr)
 
     def set_state(self, state):
+        if self.info.get("main_xprt"):
+            raise Exception(f"Main xprts cannot be set {state}")
         with open(self.path / "xprt_state", 'w') as f:
             f.write(state)
         self.read_state()
 
+    def remove(self):
+        if self.info.get("main_xprt"):
+            raise Exception("Main xprts cannot be removed")
+        self.set_state("offline")
+        self.set_state("remove")
+
     def add_command(subparser):
         parser = subparser.add_parser("xprt", help="Commands for individual xprts")
         parser.set_defaults(func=Xprt.show, xprt=None)
@@ -139,8 +147,7 @@ class Xprt:
             if args.property == "dstaddr":
                 xprt.set_dstaddr(socket.gethostbyname(args.newaddr[0]))
             elif args.property == "remove":
-                xprt.set_state("offline")
-                xprt.set_state("remove")
+                xprt.remove()
             else:
                 xprt.set_state(args.property)
         print(xprt)
-- 
2.36.1

