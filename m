Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D5572C7BA
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjFLOO4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbjFLOOm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:14:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C148A10E9
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 07:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47928629BD
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 14:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EFBC4339B;
        Mon, 12 Jun 2023 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579251;
        bh=JG743CB01l3liH6PP0ugd6QB/cEaMR/c5BBA4LLg4ZQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=C2hS5IQZSOqLSiK29HXuQOCyblf3TmTMUWLgRobMpfUWrQm+tkYyoHlVfZ+soo49T
         4IAp9bcezMOylkUSdOVNw69JFjfS8gzdKSooFRz/k5feLx+gMEKhoGv4Flob/GR6jZ
         5IWbhW6pPo0AMNpv6TYj/mWRadP4eSlsFivQyyfKuLsf/1qyZ8qUkXGpEQQ4ACx6gx
         6E5bXsp8ZUMf4wXuf2WWKqz4ZfuhA6wXaSTyMS5kdELEnXIA3vPwiq3JW6ECO2FGe6
         Et21GNLjYUKkDew2VW2qo10jsxtvJsxZOckxRJUbMOJokS686n8jTzsupSziuJSxJE
         h6jTepM4Egh/g==
Subject: [PATCH v1 7/7] SUNRPC: Remove transport class dprintk call sites
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 12 Jun 2023 10:14:10 -0400
Message-ID: <168657925061.5674.3781063108645045001.stgit@manet.1015granger.net>
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

Remove a couple of dprintk call sites that are of little value.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 6d70278bd88d..ebdc2f70af90 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -86,8 +86,6 @@ int svc_reg_xprt_class(struct svc_xprt_class *xcl)
 	struct svc_xprt_class *cl;
 	int res = -EEXIST;
 
-	dprintk("svc: Adding svc transport class '%s'\n", xcl->xcl_name);
-
 	INIT_LIST_HEAD(&xcl->xcl_list);
 	spin_lock(&svc_xprt_class_lock);
 	/* Make sure there isn't already a class with the same name */
@@ -110,7 +108,6 @@ EXPORT_SYMBOL_GPL(svc_reg_xprt_class);
  */
 void svc_unreg_xprt_class(struct svc_xprt_class *xcl)
 {
-	dprintk("svc: Removing svc transport class '%s'\n", xcl->xcl_name);
 	spin_lock(&svc_xprt_class_lock);
 	list_del_init(&xcl->xcl_list);
 	spin_unlock(&svc_xprt_class_lock);


