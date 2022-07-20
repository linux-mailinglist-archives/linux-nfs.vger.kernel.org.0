Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446F157B696
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jul 2022 14:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiGTMj1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jul 2022 08:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiGTMj0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jul 2022 08:39:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBD04F672
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jul 2022 05:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A482F61780
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jul 2022 12:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CD7C3411E;
        Wed, 20 Jul 2022 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658320765;
        bh=ayoUfwliZ4RALwsqW4YaHcwiz9+XrlUURGnkW7fFOx8=;
        h=From:To:Cc:Subject:Date:From;
        b=q7+PQbDKiczKBC8CCIg7o+hUjikWa/QIpO8mcRs5jnPI+pspyXDp9HQQUs0OH5S5z
         iZyj81J0rfxktZEiwer1KpJ0qILN2zbCGPi9tNfiQYdf2t6azLHbAt4MMf5lIic7wB
         UxrTwr5AzjZ6iIl69Hi0gh1S/QFcOimyY6JcbnsbhX/MfNFUWSZEPQmn1QzohcpuxG
         Uu1nbcVJGz5Ugm8PDG4h9kM19TiinvARjIHGra+/1pmH9/eWF/jmyQ3k80kDLnYZf4
         S/h3qnvfkbOw/1azJ3dwOpn9conGTVPhY+wAzMshBPFjXXZN2QC6w1i2oz6gYsNa73
         HcdpuK5HGQf2w==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Olaf Kirch <okir@suse.com>
Subject: [PATCH] nfsd: silence extraneous printk on nfsd.ko insertion
Date:   Wed, 20 Jul 2022 08:39:23 -0400
Message-Id: <20220720123923.16753-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This printk pops every time nfsd.ko gets plugged in. Most kmods don't do
that and this one is not very informative. Olaf's email address seems to
be defunct at this point anyway. Just drop it.

Cc: Olaf Kirch <okir@suse.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 0621c2faf242..b6efc3b56fe9 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1517,7 +1517,6 @@ static struct pernet_operations nfsd_net_ops = {
 static int __init init_nfsd(void)
 {
 	int retval;
-	printk(KERN_INFO "Installing knfsd (copyright (C) 1996 okir@monad.swb.de).\n");
 
 	retval = nfsd4_init_slabs();
 	if (retval)
-- 
2.36.1

