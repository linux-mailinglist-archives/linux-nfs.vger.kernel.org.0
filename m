Return-Path: <linux-nfs+bounces-8444-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0509E8E47
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 10:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97FE31888704
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 08:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59137215702;
	Mon,  9 Dec 2024 08:55:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41938215713;
	Mon,  9 Dec 2024 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734513; cv=none; b=X8ZJJhzSAFkzjRQEijbW7htf/GY0pRXT3zA3rAaD54IH7SBg+5PZJz8RwWkASZncddtWxgYtIZ0Wv3TROlJGV3PqJZYvHx9LbYOrn09CNc4KKpcy5c/M5GIv61CmZbolVGQRtS9SO7Fe4mlMhH/Z1GobAWyJAdLWY+nAQ9C6OAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734513; c=relaxed/simple;
	bh=Sx5tuVGwvldKiKbjin/8O8xKdARGBN3u7aH1k0prIn0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k8gcVOeiExrkRt1NoF6m9tDyzd809Nkz6XdoeMUtxehup8p+hel/lLI2NlOLI0Koe5sdqX3yBdOJcXRULYUEW192aWaze7YCtM3WgN0a6a4adaMKBzzm1kmBgcRpn5gJxKQtTGZxLZuS3IiPkywN8HVBMGR8jvNVtNz2nAcKIWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: bizesmtpsz3t1733734470t3a0xk6
X-QQ-Originating-IP: 0zwgXXY4uVyL+9RCbCNtwRYcWZjM93Hiokrooz7lcZQ=
Received: from localhost.localdomain ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Dec 2024 16:54:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9436664489369266355
From: chenxiaosong@chenxiaosong.com
To: gregkh@linuxfoundation.org,
	trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	huhai@kylinos.cn,
	chenxiaosong@kylinos.cn
Subject: [PATCH 4.19] NFS: fix null-ptr-deref in nfs_inode_add_request()
Date: Mon,  9 Dec 2024 08:54:10 +0000
Message-Id: <20241209085410.601489-1-chenxiaosong@chenxiaosong.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Ma+A2HZKKIKoV2XrcpQPY7e6H60M34Dg5bldmTOpnZB/kzi8vGN+7cYH
	pQlMigvGEVn6XIRQ+88JStv3inuPTbPtjO938L3Z+5r0leelUW2DrHw3uTCH1FMh2wS3tIi
	UFppIfsnBRm0ER0jmrTqYY1uhq/7+5OaaTDLwyZSmsYjB5RxNIosoyrvnkAFTQWUUOqmE18
	CtCzXOSybJV4Ns6vwUAa2PlhK+LRyNNwsPoxnWF2+U/6QGBhIhqVffiQxlZ7XTKpWy9d8qf
	2ZZ3pOgdqWtiyYNlk2/NQWjtRKmX/Seq5obrLUvZ67t9J6iKxXM2K7RLYtK8LImgvPTHSKm
	n73gjWXDhLhA/sbUPNVMZaI7zRsXCve5jALnyrVHYVF9McpoHJNAHSXG5SrTE+3wT/FJax6
	/Pdkk/C8kOdFgMp5qGNmt4VkaWqcmggEUcEstDfvh9QRjHniij3I8r4DIqhOatbD85pmpZP
	S/teD5XbuSMSl4JldvPxQ7AnFv0Bi2nxWZN7AxRTyPz+oZtOEmx11tS3+oX4ToF2O1CONUh
	VWqxDijkR9v7IH+TUbWukcZXKcSJTrK9dq/ATXn+c/tviybhau/ggRLqbKP64rTBPlZdhhW
	PGTTVpWoSaFSYtu7h88tWI3pbi/GKLEW7MtfSbp53C0kOgOeEXuHG6ZFvIlafs09O/yWjKQ
	QTlkdmg4uxzfLE5YdIvkRtoVW3enOsGEIcpBBYAz+BwDrq/mjwyjExlHa3Qt6HTR3u6gXCt
	ufFsLROMt5aOvIJxVLd2F/jow+Aq8q4AWcbLkYJuCh5Pk3vRejJGbAUNXwo+hHYUCpjZRIs
	KfBg3i3P+dESJjXiuu+vEuSbTzE1mfiTPD1Wfgsz412HQffRR8QbJnsGLmZDzl2w2RrSA9I
	M8VKEhyDHsKK+g3wFK3W7zG20Z12rynO8f7Q1e71bOzkYgH1exwMcvud7giPyF1xpW+N2KS
	Dt+o=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

There is panic as follows:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000080
  Call Trace:
   nfs_inode_add_request+0x1cc/0x5b8
   nfs_setup_write_request+0x1fa/0x1fc
   nfs_writepage_setup+0x2d/0x7d
   nfs_updatepage+0x8b8/0x936
   nfs_write_end+0x61d/0xd45
   generic_perform_write+0x19a/0x3f0
   nfs_file_write+0x2cc/0x6e5
   new_sync_write+0x442/0x560
   __vfs_write+0xda/0xef
   vfs_write+0x176/0x48b
   ksys_write+0x10a/0x1e9
   __se_sys_write+0x24/0x29
   __x64_sys_write+0x79/0x93
   do_syscall_64+0x16d/0x4bb
   entry_SYSCALL_64_after_hwframe+0x5c/0xc1

The above panic may happen as follows:

  nfs_updatepage
    nfs_writepage_setup
      nfs_setup_write_request
        nfs_try_to_update_request will return NULL
          nfs_wb_page will return 0
            if (clear_page_dirty_for_io(page)) == true
            nfs_writepage_locked will return 0
              nfs_do_writepage will return 0
                nfs_page_async_flush
                  if (nfs_error_is_fatal_on_server(ret)) == true
                  nfs_write_error_remove_page
                    generic_error_remove_page
                      truncate_inode_page
                        delete_from_page_cache
                          __delete_from_page_cache
                            page_cache_tree_delete
                              page->mapping = NULL
                nfs_page_async_flush() return 0 <== this is point
              nfs_do_writepage return 0
            nfs_writepage_locked return 0
          nfs_wb_page return 0
        nfs_try_to_update_request return NULL
        if (req != NULL) == false
        nfs_create_request
          req->wb_page = page // page->mapping == NULL
        nfs_inode_add_request
          mapping = page_file_mapping(req->wb_page) == NULL
            return page->mapping // is NULL
          spin_lock(&mapping->private_lock) // oops, mapping is NULL

Fix this by reporting fatal errors and stop writeback.

The patchset (29 patches) "Fix up soft mounts for NFSv4.x" [1] replaces
the custom error reporting mechanism. It seems that we can fix this bug
if we merge all the patchset into LTS 4.19. However, it is clear that
this is not the best option for LTS 4.19.

By the way, applying commit 22876f540bdf ("NFS: Don't call
generic_error_remove_page() while holding locks") into LTS 4.19 will
introduce other issues [2].

Link[1]: https://lore.kernel.org/all/20190407175912.23528-1-trond.myklebust@hammerspace.com/
Link[2]: https://lore.kernel.org/all/tencent_F89651CE8E1BFCEC42C4BFEDD0CA77F82609@qq.com/
Fixes: 89047634f5ce ("NFS: Don't interrupt file writeout due to fatal errors")
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/nfs/write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 65aaa6eaad2c..c69a539eee2c 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -660,7 +660,7 @@ static int nfs_page_async_flush(struct nfs_pageio_descriptor *pgio,
 	return ret;
 out_launder:
 	nfs_write_error_remove_page(req);
-	return 0;
+	return ret;
 }
 
 static int nfs_do_writepage(struct page *page, struct writeback_control *wbc,
-- 
2.34.1


