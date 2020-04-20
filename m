Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637821B0129
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 07:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDTFuB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 01:50:01 -0400
Received: from mail.fudan.edu.cn ([202.120.224.73]:49776 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbgDTFuB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 Apr 2020 01:50:01 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Apr 2020 01:49:59 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=yAOu0VUkborL/7+dqlJ4jWkJ1m2aAADVyJZ3KeTxc1w=; b=3
        Vwu87CCBMNoOn8C3OXoqNfWk/SbXJqSw+e7lDhS92qY78pj/qLTaNn7w+ibW2IAp
        iqTcgm5gQY7pl2PlClqregA8jJ1LD8hSO8DYT1qYWKZEoJmXUwXtmd1oY1szPuWd
        9WOtgK+AaFI6yZZT0mLP0TFbNChzxNv4mk9FhbaV5k=
Received: from localhost.localdomain (unknown [120.229.255.67])
        by app2 (Coremail) with SMTP id XQUFCgA3ywicNp1ePAAeAA--.3223S3;
        Mon, 20 Apr 2020 13:43:57 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Olaf Kirch <okir@suse.de>, Andrew Morton <akpm@osdl.org>,
        Andreas Gruenbacher <agruen@suse.de>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] nfs: Fix potential posix_acl refcnt leak in nfs3_set_acl
Date:   Mon, 20 Apr 2020 13:43:28 +0800
Message-Id: <1587361410-83560-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgA3ywicNp1ePAAeAA--.3223S3
X-Coremail-Antispam: 1UD129KBjvJXoWrKFW3tr4ruw1xtFykAw1DZFb_yoW8JF45pw
        4Ikr1UtF98tFW8tas8Aw48W34kAa10qw1rKwn5Wa1SvrnxXasxCFyYqw13XFWUArW8JF18
        Wr1Yg3y3Z3WDCaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
        6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVW8WwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUO2NtUUUUU
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs3_set_acl() invokes get_acl(), which returns a local reference of the
posix_acl object to "alloc" with increased refcount.

When nfs3_set_acl() returns or a new object is assigned to "alloc",  the
original local reference of  "alloc" becomes invalid, so the refcount
should be decreased to keep refcount balanced.

The reference counting issue happens in one path of nfs3_set_acl(). When
"acl" equals to NULL but "alloc" is not NULL, the function forgets to
decrease the refcnt increased by get_acl() and causes a refcnt leak.

Fix this issue by calling posix_acl_release() on this path when "alloc"
is not NULL.

Fixes: b7fa0554cf1b ("[PATCH] NFS: Add support for NFSv3 ACLs")
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 fs/nfs/nfs3acl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
index c5c3fc6e6c60..b5c41bcca8cf 100644
--- a/fs/nfs/nfs3acl.c
+++ b/fs/nfs/nfs3acl.c
@@ -274,6 +274,8 @@ int nfs3_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	}
 
 	if (acl == NULL) {
+		if (alloc)
+			posix_acl_release(alloc);
 		alloc = acl = posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
 		if (IS_ERR(alloc))
 			goto fail;
-- 
2.7.4

