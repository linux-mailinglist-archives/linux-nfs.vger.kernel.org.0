Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EE772C7A2
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbjFLOOw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbjFLOOM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:14:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F251728
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 07:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 076E1629BA
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 14:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44717C4339E;
        Mon, 12 Jun 2023 14:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579245;
        bh=8PHT9ojTIcOKf0VV5n7pIX+G+OnPi4wyyhae4q3yCDg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M9AqbvrP/iiI9O0zv8S5Zup5yK+sRgAS14yhavRON6p35BswArljSQ3bnHqmwy2Ua
         ibgf6THHxPrkm83nXQvhzNKzo0ilfvuCEZhuB8l2a8LCqpMdFGTCyGGA3bNwl0F+5D
         wMXLN0KL7ipCuEdoUP5jgLE7uo/BrGVxKk/GxIgeuS5jC5C/kER6K7dJ1NSpZ5ZF7q
         s3ttsQ0Ijrt38o8aBmLk/32gbCoivjmpWLaAuwNDXLmUVKJO8pLFg/Vux5dNe3ACob
         OwJDDNJ9/VmAk5MPoKFHficB+CFPd0FNZ+V08+rCLbzp0grMTMhG3q2fPBWJuDjugx
         EL2uu0zsqoQ1g==
Subject: [PATCH v1 6/7] SUNRPC: Fix comments for transport class registration
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 12 Jun 2023 10:14:04 -0400
Message-ID: <168657924433.5674.7660984476060437991.stgit@manet.1015granger.net>
In-Reply-To: <168657912781.5674.12501431304770900992.stgit@manet.1015granger.net>
References: <168657912781.5674.12501431304770900992.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The preceding block comment before svc_register_xprt_class() is
not related to that function.

While we're here, add proper documenting comments for these two
publicly-visible functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 4af83a0fd395..6d70278bd88d 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -74,6 +74,13 @@ static LIST_HEAD(svc_xprt_class_list);
  *		  that no other thread will be using the transport or will
  *		  try to set XPT_DEAD.
  */
+
+/**
+ * svc_reg_xprt_class - Register a server-side RPC transport class
+ * @xcl: New transport class to be registered
+ *
+ * Returns zero on success; otherwise a negative errno is returned.
+ */
 int svc_reg_xprt_class(struct svc_xprt_class *xcl)
 {
 	struct svc_xprt_class *cl;
@@ -96,6 +103,11 @@ int svc_reg_xprt_class(struct svc_xprt_class *xcl)
 }
 EXPORT_SYMBOL_GPL(svc_reg_xprt_class);
 
+/**
+ * svc_unreg_xprt_class - Unregister a server-side RPC transport class
+ * @xcl: Transport class to be unregistered
+ *
+ */
 void svc_unreg_xprt_class(struct svc_xprt_class *xcl)
 {
 	dprintk("svc: Removing svc transport class '%s'\n", xcl->xcl_name);


