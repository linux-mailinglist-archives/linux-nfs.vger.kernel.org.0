Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46752631C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 May 2022 15:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbiEMNjC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 May 2022 09:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381389AbiEMNgO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 May 2022 09:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB9A910F0
        for <linux-nfs@vger.kernel.org>; Fri, 13 May 2022 06:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652448973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hVPawnTkxPGLCr5szu5aRFwdd0z2bBmFtxHbY+Nwgbo=;
        b=DojGEBt/KBgD/CiXGwezNKVqz05wh0heBOnu4nSo3DcI2Q/vQeXJ2xL2pUzcnXn0nJ3XzG
        OwTlciBIi0f4VJ/NSRB1oxUKn9CUOPl2p3zqf7XF4HBspqGUFeutFyypKBy+8nKS35STI0
        7hL9WIGfus/cjApWgnDmq9HRs2iCIAk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-69nMdK8oP66QERjmmMSX-Q-1; Fri, 13 May 2022 09:36:09 -0400
X-MC-Unique: 69nMdK8oP66QERjmmMSX-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E066185A7B2;
        Fri, 13 May 2022 13:36:09 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 575B61121314;
        Fri, 13 May 2022 13:36:09 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id F356010C30F0; Fri, 13 May 2022 09:36:08 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, smayhew@redhat.com
Subject: [PATCH] NFSv4: Restore nfs4_label into copied nfs_fattr for referrals
Date:   Fri, 13 May 2022 09:36:08 -0400
Message-Id: <8ffe993a7aa39881d3e610d5424098ea7ec88180.1652448889.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

..which will fix up trying to free uninitialized nfs4_label:

PID: 790    TASK: ffff88811b43c000  CPU: 0   COMMAND: "ls"
 #0 [ffffc90000857920] panic at ffffffff81b9bfde
 #1 [ffffc900008579c0] do_trap at ffffffff81023a9b
 #2 [ffffc90000857a10] do_error_trap at ffffffff81023b78
 #3 [ffffc90000857a58] exc_stack_segment at ffffffff81be1f45
 #4 [ffffc90000857a80] asm_exc_stack_segment at ffffffff81c009de
 #5 [ffffc90000857b08] nfs_lookup at ffffffffa0302322 [nfs]
 #6 [ffffc90000857b70] __lookup_slow at ffffffff813a4a5f
 #7 [ffffc90000857c60] walk_component at ffffffff813a86c4
 #8 [ffffc90000857cb8] path_lookupat at ffffffff813a9553
 #9 [ffffc90000857cf0] filename_lookup at ffffffff813ab86b

Fixes: 9558a007dbc3 ("NFS: Remove the label from the nfs4_lookup_res struct")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs4proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a79f66432bd3..4566280e6ff2 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4235,6 +4235,7 @@ static int nfs4_get_referral(struct rpc_clnt *client, struct inode *dir,
 	int status = -ENOMEM;
 	struct page *page = NULL;
 	struct nfs4_fs_locations *locations = NULL;
+	struct nfs4_label *label = fattr->label;
 
 	page = alloc_page(GFP_KERNEL);
 	if (page == NULL)
@@ -4263,6 +4264,7 @@ static int nfs4_get_referral(struct rpc_clnt *client, struct inode *dir,
 
 	/* replace the lookup nfs_fattr with the locations nfs_fattr */
 	memcpy(fattr, &locations->fattr, sizeof(struct nfs_fattr));
+	fattr->label = label;
 	memset(fhandle, 0, sizeof(struct nfs_fh));
 out:
 	if (page)
-- 
2.31.1

