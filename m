Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375CE55DDE0
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jun 2022 15:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbiF0Vbo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jun 2022 17:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbiF0Vbo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jun 2022 17:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49FE6A449
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jun 2022 14:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656365502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aCYzTwquSTHn2f2KIEEWzTbW0J6BSJdADJFyFkPB7QQ=;
        b=ZcbHgsE/bdnsn5imvO/guaOhz7bqNwmNqRxhOXqfqZ9eJqM64T+Glv3S5aZ9hdrSZ6eEXg
        UrmM+EUUHulparLIG/ZsHpDCbVn1rfP2Rvr8u6tXwbZtTJou5jr4EMJ3r/7C2hpd5v6ypn
        H9b0d57z/9GQkxOOl+LObp915kH3UGA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-zPCNHu8fMIKhf3-KMfNUWg-1; Mon, 27 Jun 2022 17:31:36 -0400
X-MC-Unique: zPCNHu8fMIKhf3-KMfNUWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A8AE857DDB;
        Mon, 27 Jun 2022 21:31:30 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.35.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44A012166B26;
        Mon, 27 Jun 2022 21:31:30 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id CA0961A27D8; Mon, 27 Jun 2022 17:31:29 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Add an fattr allocation to _nfs4_discover_trunking()
Date:   Mon, 27 Jun 2022 17:31:29 -0400
Message-Id: <20220627213129.1104710-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This was missed in c3ed222745d9 ("NFSv4: Fix free of uninitialized
nfs4_label on referral lookup.") and causes a panic when mounting
with '-o trunkdiscovery':

PID: 1604   TASK: ffff93dac3520000  CPU: 3   COMMAND: "mount.nfs"
 #0 [ffffb79140f738f8] machine_kexec at ffffffffaec64bee
 #1 [ffffb79140f73950] __crash_kexec at ffffffffaeda67fd
 #2 [ffffb79140f73a18] crash_kexec at ffffffffaeda76ed
 #3 [ffffb79140f73a30] oops_end at ffffffffaec2658d
 #4 [ffffb79140f73a50] general_protection at ffffffffaf60111e
    [exception RIP: nfs_fattr_init+0x5]
    RIP: ffffffffc0c18265  RSP: ffffb79140f73b08  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ffff93dac304a800  RCX: 0000000000000000
    RDX: ffffb79140f73bb0  RSI: ffff93dadc8cbb40  RDI: d03ee11cfaf6bd50
    RBP: ffffb79140f73be8   R8: ffffffffc0691560   R9: 0000000000000006
    R10: ffff93db3ffd3df8  R11: 0000000000000000  R12: ffff93dac4040000
    R13: ffff93dac2848e00  R14: ffffb79140f73b60  R15: ffffb79140f73b30
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #5 [ffffb79140f73b08] _nfs41_proc_get_locations at ffffffffc0c73d53 [nfsv4]
 #6 [ffffb79140f73bf0] nfs4_proc_get_locations at ffffffffc0c83e90 [nfsv4]
 #7 [ffffb79140f73c60] nfs4_discover_trunking at ffffffffc0c83fb7 [nfsv4]
 #8 [ffffb79140f73cd8] nfs_probe_fsinfo at ffffffffc0c0f95f [nfs]
 #9 [ffffb79140f73da0] nfs_probe_server at ffffffffc0c1026a [nfs]
    RIP: 00007f6254fce26e  RSP: 00007ffc69496ac8  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 0000000000000000  RCX: 00007f6254fce26e
    RDX: 00005600220a82a0  RSI: 00005600220a64d0  RDI: 00005600220a6520
    RBP: 00007ffc69496c50   R8: 00005600220a8710   R9: 003035322e323231
    R10: 0000000000000000  R11: 0000000000000246  R12: 00007ffc69496c50
    R13: 00005600220a8440  R14: 0000000000000010  R15: 0000560020650ef9
    ORIG_RAX: 00000000000000a5  CS: 0033  SS: 002b

Fixes: c3ed222745d9 ("NFSv4: Fix free of uninitialized nfs4_label on referral lookup.")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/nfs4proc.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c0fdcf8c0032..bb0e84a46d61 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4012,22 +4012,29 @@ static int _nfs4_discover_trunking(struct nfs_server *server,
 	}
 
 	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
 	locations = kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
-	if (page == NULL || locations == NULL)
-		goto out;
+	if (!locations)
+		goto out_free;
+	locations->fattr = nfs_alloc_fattr();
+	if (!locations->fattr)
+		goto out_free_2;
 
 	status = nfs4_proc_get_locations(server, fhandle, locations, page,
 					 cred);
 	if (status)
-		goto out;
+		goto out_free_3;
 
 	for (i = 0; i < locations->nlocations; i++)
 		test_fs_location_for_trunking(&locations->locations[i], clp,
 					      server);
-out:
-	if (page)
-		__free_page(page);
+out_free_3:
+	kfree(locations->fattr);
+out_free_2:
 	kfree(locations);
+out_free:
+	__free_page(page);
 	return status;
 }
 
-- 
2.34.1

