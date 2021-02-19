Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D49320151
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 23:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhBSWXQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 17:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhBSWXN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 17:23:13 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B573C06178A;
        Fri, 19 Feb 2021 14:22:33 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e2so5814372ilu.0;
        Fri, 19 Feb 2021 14:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tUiXt38vszTo/8I4Tq05S3DKXWtyC93gf//69MCl9bI=;
        b=WmUBk1i1WxpKzqh/WrjSTcH2JYceqpG2GkbZmLLj5LnN4S+lj2KbHF4iWF2zpDBG/m
         x4VE+XrmKOO/OMzP3QS7T+lizbjJCJ2w6D2zx0V21YrjHlMMfHX0nNQr+arBgUSLg3B1
         lWbpALH3uD2JAAqRYfv1HTQDAuAfrl/4+0rqfByael5ypUdwaDmTbco2W1Wztn2Bapr7
         FHbdDo4xeYIJiHNFdB0rLnagg3FziBNQaiiRX4K2yu2sgBh8x6Uepi88mrsOf1VyQTUf
         XjDPZyYPmjPep0z8DAMkX0gnjt3pAyrUbhu+8fDh/UgaDJ4c2AMB/6EBWKYiypL7I/1i
         8XqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tUiXt38vszTo/8I4Tq05S3DKXWtyC93gf//69MCl9bI=;
        b=SlqnnaOeui7lIZNLIRonrHwLsDEn/Oss2w0A1VfR3AZ7LKbu4CFmz1XeabtdXI4kBg
         wWqGBxKKKvV0fl4iaIJYbAipiecgcpbVAsAktNrLKEBfhsMpYp89x/Gq/8DsVzmUI9nb
         iCw6TWKZn/ttRYXA5359exYqfoDz8/x+AhHtR+hsBxNECpU1Rc+XJazg6xrHDPylLeDK
         0YWVNVCIoKmm1k4U1tEHqUNw5y3XDgAu15ogVCMhHXS8nJ0byWj4NImJG0SYC7yx7xuf
         +eA7Rt1sEPUn6TgIknZBT+n56w++NYgon78fHbRV//2J3BNGTd5UuwlGYP9k/KemeiQ9
         g7Vg==
X-Gm-Message-State: AOAM533NGSDxGmGwOcjIH0VvkfYUR4zSmAzEI6u0wvK+VJBFYNr07KEZ
        mX3khNhcdmwmVupEQrDBTnbOj6OJW4lPxPjD
X-Google-Smtp-Source: ABdhPJxTF2eOPiEl6F/rr9pQp0bg1FYrCXk7F6h87MBYJtpsmB9Y7beiMatGH4ghXMNRjFP5Ar7plw==
X-Received: by 2002:a92:cd8a:: with SMTP id r10mr5614069ilb.110.1613773352889;
        Fri, 19 Feb 2021 14:22:32 -0800 (PST)
Received: from Olgas-MBP-470.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id b19sm8456290ioj.50.2021.02.19.14.22.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 19 Feb 2021 14:22:32 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [PATCH v3 2/3] [NFS] cleanup: remove unneeded null check in nfs_fill_super()
Date:   Fri, 19 Feb 2021 17:22:32 -0500
Message-Id: <20210219222233.20748-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20210219222233.20748-1-olga.kornievskaia@gmail.com>
References: <20210219222233.20748-1-olga.kornievskaia@gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

In nfs_fill_super() passed in nfs_fs_context can never be NULL.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 4034102010f0..59d846d7830f 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1026,7 +1026,7 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 	sb->s_blocksize = 0;
 	sb->s_xattr = server->nfs_client->cl_nfs_mod->xattr;
 	sb->s_op = server->nfs_client->cl_nfs_mod->sops;
-	if (ctx && ctx->bsize)
+	if (ctx->bsize)
 		sb->s_blocksize = nfs_block_size(ctx->bsize, &sb->s_blocksize_bits);
 
 	if (server->nfs_client->rpc_ops->version != 2) {
-- 
2.27.0

