Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00836F4511
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 15:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjEBNg3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 09:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjEBNg0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 09:36:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCFD6A5A
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 06:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C182462480
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 13:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D39C4339C;
        Tue,  2 May 2023 13:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683034574;
        bh=cREU9j+BYCVPtChZc46xMyHx5WzMy5qtAL1TmQg1vgU=;
        h=From:To:Cc:Subject:Date:From;
        b=Uh/ft862Wdbet1pnQFLpFUNyQ5lN9Fix2MTfuPtDqb/oNI+AwUJZ5VWaqwP9S34TC
         hHKjF1N0fx9EZnNCzYYaJLN8NFpGqqSRI6phVlN5HvtepXywK8ajm+uLlcN4yKV0gA
         TbFF4fiqLu55DZOw5hLzSpLxzUCI3Crbrwsw0v0bYX2WcguzrB804GQpJ206JFBgCT
         fiUJV5dn5Wn3vFlOiMrQUbpbPWmeOIkdBdO/dhgHI9pw6TGBVIMTZ2l7MCBUvBbeF/
         aHi6Kwb2nfMBjBbP+7gYsT8HQoPPj1nYzh4fhCwk+pr/wV+WW5f9l+7RTb0hpIpbi7
         ul/pDBtz2hllA==
From:   Christian Brauner <brauner@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, linux-nfs@vger.kernel.org,
        Sherry Yang <sherry.yang@oracle.com>
Subject: [PATCH] nfsd: use vfs setgid helper
Date:   Tue,  2 May 2023 15:36:02 +0200
Message-Id: <20230502-agenda-regeln-04d2573bd0fd@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2712; i=brauner@kernel.org; h=from:subject:message-id; bh=cREU9j+BYCVPtChZc46xMyHx5WzMy5qtAL1TmQg1vgU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQECjyOftpsf/hxUXfloRgn6xcXs37XZj7ecZpnrcgjg3pR b0GnjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkYL2RkmPc7Q3fP/1UztH1ueQSa6W iFHtiR1FL32nzL/xXT4mNX/mL4XzrrrLq3zXoZ9bA3TALfF6dZTdmizH71xr3oxb4Vpuc5WAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We've aligned setgid behavior over multiple kernel releases. The details
can be found in commit cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2' of
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping") and
commit 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0' of
git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux").
Consistent setgid stripping behavior is now encapsulated in the
setattr_should_drop_sgid() helper which is used by all filesystems that
strip setgid bits outside of vfs proper. Usually ATTR_KILL_SGID is
raised in e.g., chown_common() and is subject to the
setattr_should_drop_sgid() check to determine whether the setgid bit can
be retained. Since nfsd is raising ATTR_KILL_SGID unconditionally it
will cause notify_change() to strip it even if the caller had the
necessary privileges to retain it. Ensure that nfsd only raises
ATR_KILL_SGID if the caller lacks the necessary privileges to retain the
setgid bit.

Without this patch the setgid stripping tests in LTP will fail:

> As you can see, the problem is S_ISGID (0002000) was dropped on a
> non-group-executable file while chown was invoked by super-user, while

[...]

> fchown02.c:66: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700

[...]

> chown02.c:57: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700

With this patch all tests pass.

Reported-by: Sherry Yang <sherry.yang@oracle.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
ubuntu@imp1-vm:~/ltp-install$ sudo ./runltp -d /mnt -s chown02
INFO: ltp-pan reported all tests PASS
LTP Version: 20230127-112-gf41e8a2fa

ubuntu@imp1-vm:~/ltp-install$ sudo ./runltp -d /mnt -s fchown02
INFO: ltp-pan reported all tests PASS
LTP Version: 20230127-112-gf41e8a2fa

ubuntu@imp1-vm:~/src/git/xfstests$ sudo ./check -g perms
FSTYP         -- nfs
PLATFORM      -- Linux/x86_64 imp1-vm 6.3.0-nfs-setgid-3a3cfe624076 #20 SMP PREEMPT_DYNAMIC Tue May  2 12:35:51 UTC 2023
MKFS_OPTIONS  -- 127.0.0.1:/nfsscratch
MOUNT_OPTIONS -- -o vers=3,noacl 127.0.0.1:/nfsscratch /mnt/scratch
Passed all 41 tests
---
 fs/nfsd/vfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index bb9d47172162..c4ef24c5ffd0 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -388,7 +388,9 @@ nfsd_sanitize_attrs(struct inode *inode, struct iattr *iap)
 				iap->ia_mode &= ~S_ISGID;
 		} else {
 			/* set ATTR_KILL_* bits and let VFS handle it */
-			iap->ia_valid |= (ATTR_KILL_SUID | ATTR_KILL_SGID);
+			iap->ia_valid |= ATTR_KILL_SUID;
+			iap->ia_valid |=
+				setattr_should_drop_sgid(&nop_mnt_idmap, inode);
 		}
 	}
 }
-- 
2.34.1

