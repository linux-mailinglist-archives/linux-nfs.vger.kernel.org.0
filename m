Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F93723BDD7
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Aug 2020 18:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgHDQMJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Aug 2020 12:12:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25474 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729752AbgHDQMF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Aug 2020 12:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596557510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yn1kWQ2C+haRL+XS3lCNj+OasAA0FywDY72xN8yUQGo=;
        b=Vrk1MFxc3grV1W9u2MySECbB89xGNkhLp36z/xDppDHWwR/pZGUZbKpt7I1G/oJVE8F8bH
        7YNs6CQ8orAQHA7UksOEItKg0/hmIFiqdPwKMV/gyUj/A9/xXMwv7t1JfKUGaKVl5Y0wiC
        ImeSuZU6kHJ9KIhypmBqgsHIjodLPms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-vhrMNTmhPEy4SeSjg2xknQ-1; Tue, 04 Aug 2020 12:11:48 -0400
X-MC-Unique: vhrMNTmhPEy4SeSjg2xknQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1386800461;
        Tue,  4 Aug 2020 16:11:47 +0000 (UTC)
Received: from f32-node1.dwysocha.net (dhcp145-42.rdu.redhat.com [10.13.145.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 827A770107;
        Tue,  4 Aug 2020 16:11:47 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Olga.Kornievskaia@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS4: Fix oops when copy_file_range is attempted with NFS4.0 source
Date:   Tue,  4 Aug 2020 12:11:47 -0400
Message-Id: <20200804161147.8948-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following oops is seen during xfstest/565 when the 'test'
(source of the copy) is NFS4.0 and 'scratch' (destination) is NFS4.2
[   59.692458] run fstests generic/565 at 2020-08-01 05:50:35
[   60.613588] BUG: kernel NULL pointer dereference, address: 0000000000000008
[   60.624970] #PF: supervisor read access in kernel mode
[   60.627671] #PF: error_code(0x0000) - not-present page
[   60.630347] PGD 0 P4D 0
[   60.631853] Oops: 0000 [#1] SMP PTI
[   60.634086] CPU: 6 PID: 2828 Comm: xfs_io Kdump: loaded Not tainted 5.8.0-rc3 #1
[   60.637676] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[   60.639901] RIP: 0010:nfs4_check_serverowner_major_id+0x5/0x30 [nfsv4]
[   60.642719] Code: 89 ff e8 3e b3 b8 e1 e9 71 fe ff ff 41 bc da d8 ff ff e9 c3 fe ff ff e8 e9 9d 08 e2 66 0f 1f 84 00 00 00 00 00 66 66 66 66 90 <8b> 57 08 31 c0 3b 56 08 75 12 48 83 c6 0c 48 83 c7 0c e8 c4 97 bb
[   60.652629] RSP: 0018:ffffc265417f7e10 EFLAGS: 00010287
[   60.655379] RAX: ffffa0664b066400 RBX: 0000000000000000 RCX: 0000000000000001
[   60.658754] RDX: ffffa066725fb000 RSI: ffffa066725fd000 RDI: 0000000000000000
[   60.662292] RBP: 0000000000020000 R08: 0000000000020000 R09: 0000000000000000
[   60.666189] R10: 0000000000000003 R11: 0000000000000000 R12: ffffa06648258d00
[   60.669914] R13: 0000000000000000 R14: 0000000000000000 R15: ffffa06648258100
[   60.673645] FS:  00007faa9fb35800(0000) GS:ffffa06677d80000(0000) knlGS:0000000000000000
[   60.677698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   60.680773] CR2: 0000000000000008 CR3: 0000000203f14000 CR4: 00000000000406e0
[   60.684476] Call Trace:
[   60.685809]  nfs4_copy_file_range+0xfc/0x230 [nfsv4]
[   60.688704]  vfs_copy_file_range+0x2ee/0x310
[   60.691104]  __x64_sys_copy_file_range+0xd6/0x210
[   60.693527]  do_syscall_64+0x4d/0x90
[   60.695512]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   60.698006] RIP: 0033:0x7faa9febc1bd

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/nfs4file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 8e5d6223ddd3..24e4e6a4e94a 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -142,7 +142,8 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	/* Only offload copy if superblock is the same */
 	if (file_in->f_op != &nfs4_file_operations)
 		return -EXDEV;
-	if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
+	if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY) ||
+	    !nfs_server_capable(file_inode(file_in), NFS_CAP_COPY))
 		return -EOPNOTSUPP;
 	if (file_inode(file_in) == file_inode(file_out))
 		return -EOPNOTSUPP;
-- 
2.26.2

