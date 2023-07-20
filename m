Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAEA75B029
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 15:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjGTNfi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 09:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjGTNfb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 09:35:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C7430CD;
        Thu, 20 Jul 2023 06:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8667761A7C;
        Thu, 20 Jul 2023 13:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F2DC433C7;
        Thu, 20 Jul 2023 13:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689860096;
        bh=QTkYoAapURqmzcdL8QyMLIliJ+XrKOTiuGvzEQ20CoM=;
        h=From:To:Cc:Subject:Date:From;
        b=o909l8EzFZ/iHhjEaS53GhD08wNWfMWdWwsK9wjzt0Wtz2OrZYYA03CpHQsSTOnBt
         WqKA+W0OKE/YYYn9vsQTTRF3Mna8K3kfRsEi/KiFLtjDbfVtRNFwOzbn6xKBYXehLD
         bMeqjLWhN5DirRkC6nb72GuGr7ZMRyeolOYMME3ALkUiqxQkKwL5c/1gcuWc2kZIVa
         4AKQAkRSCs5LZMnH7OTG6re5oEJBLBhNHu+T+Mw53an3shJ0F1N91t+2JTiAkAurSI
         1DQCiZjXxEUn4izZKrpGc5V4nDZr63KS/50ciaNG0EdPALisev0SI/vu0G9RI7cOYm
         LpAc6ygAx5oGA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: add a MODULE_DESCRIPTION
Date:   Thu, 20 Jul 2023 09:34:53 -0400
Message-ID: <20230720133454.38695-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I got this today from modpost:

    WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfsd/nfsd.o

Add a module description.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 1b8b1aab9a15..7070969a38b5 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1626,6 +1626,7 @@ static void __exit exit_nfsd(void)
 }
 
 MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
+MODULE_DESCRIPTION("The Linux kernel NFS server");
 MODULE_LICENSE("GPL");
 module_init(init_nfsd)
 module_exit(exit_nfsd)
-- 
2.41.0

