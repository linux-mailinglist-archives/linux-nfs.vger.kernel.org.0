Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10137207AD2
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 19:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405847AbgFXRws (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Jun 2020 13:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405846AbgFXRws (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Jun 2020 13:52:48 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33861C061573
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2020 10:52:48 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id z2so2933499ilq.0
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2020 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hRilx8mC7ZJWf8/tv5Rfrt+x9vjLKu1wg3TD7vV+BBM=;
        b=q1sepUBUdhgO4s5kHEDDu4egdWgCGtmWVssrOerX0gyyJkJM3o8UIv7G+uBRZBV9jj
         NRrZji74JtgCWSHf3Zcj7DPgEGeVoSdUM07IIIb8WfxtF6xU6Z6eKVWbbO0C50BSI3ZL
         bcXZCCTbVrqY5e6PHaGb7WqQoPyORbiPpP6f6kJ9NtEP+bJ4JQxekOceJJiJXFRCDgwW
         kEjXPQ7RVk02AMwNGKNtasQ5MGeUnvk2Xe6YBgE0+h4s/BcPgAIrOY8k94PO3eoFZLi3
         WtbDB/0gGurYZ3Zsl1nUEyDzt/sfpyY6KydVHs2IMYUK/V1YHLM8MY60IiBNP8w1uF12
         tMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hRilx8mC7ZJWf8/tv5Rfrt+x9vjLKu1wg3TD7vV+BBM=;
        b=j0HCwR5/y4x3D7Qoybco2urxVsIUsU/sCSml4kSVfxe2fKf28u3be27TgTC5BZer6I
         VFpZ84HV+ZhKe8DpGV2lp5azKAR3UtcB6hDp+PYN/6SpIwPdSIua4g6XKqW80/TbAl29
         vKtDWrkCKbby9HBa+DaoIzD17JLKUXlZgzhcSVgprI/FtuvawcTY7SgY0mXGRtKGUydv
         0EGUIa+pGeziCEQQa9KMHpQVU5qyhU+DrKajCXHNyONCED/s60oEG1GEEI+ECsZXgbca
         3zNIUHMNZK3VRZS327KgSCu69L/js9mnhvl2Yth/yatO7wJSHESRzwVJbz+MV5K7by3r
         VwVA==
X-Gm-Message-State: AOAM533DU0aK3BFB7BaPTCYKszFjykCVV2GsjhCTrL/HdWL7kj5F63eB
        lakTR5Vmx0gBr2WUDJ6qGQ4=
X-Google-Smtp-Source: ABdhPJwKF0VwlrHpSEvGqV8wkSvRKJDxSHKfS1JjchMMoW97yb8RkSs3KTaZFDA9mtIoV5OqD/fssA==
X-Received: by 2002:a92:9904:: with SMTP id p4mr416142ili.240.1593021167541;
        Wed, 24 Jun 2020 10:52:47 -0700 (PDT)
Received: from Olgas-MBP-286.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id n17sm11783367iom.22.2020.06.24.10.52.45
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jun 2020 10:52:47 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4 fix CLOSE not waiting for direct IO compeletion
Date:   Wed, 24 Jun 2020 13:54:08 -0400
Message-Id: <20200624175408.74678-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Figuring out the root case for the REMOVE/CLOSE race and
suggesting the solution was done by Neil Brown.

Currently what happens is that direct IO calls hold a reference
on the open context which is decremented as an asynchronous task
in the nfs_direct_complete(). Before reference is decremented,
control is returned to the application which is free to close the
file. When close is being processed, it decrements its reference
on the open_context but since directIO still holds one, it doesn't
sent a close on the wire. It returns control to the application
which is free to do other operations. For instance, it can delete a
file. Direct IO is finally releasing its reference and triggering
an asynchronous close. Which races with the REMOVE. On the server,
REMOVE can be processed before the CLOSE, failing the REMOVE with
EACCES as the file is still opened.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Suggested-by: Neil Brown <neilb@suse.com>
CC: stable@vger.kernel.org

---
 fs/nfs/direct.c | 13 +++++++++----
 fs/nfs/file.c   |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 1b79dd5..3d113cf 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -267,8 +267,6 @@ static void nfs_direct_complete(struct nfs_direct_req *dreq)
 {
 	struct inode *inode = dreq->inode;
 
-	inode_dio_end(inode);
-
 	if (dreq->iocb) {
 		long res = (long) dreq->error;
 		if (dreq->count != 0) {
@@ -280,7 +278,10 @@ static void nfs_direct_complete(struct nfs_direct_req *dreq)
 
 	complete(&dreq->completion);
 
+	igrab(inode);
 	nfs_direct_req_release(dreq);
+	inode_dio_end(inode);
+	iput(inode);
 }
 
 static void nfs_direct_read_completion(struct nfs_pgio_header *hdr)
@@ -410,8 +411,10 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 	 * generic layer handle the completion.
 	 */
 	if (requested_bytes == 0) {
-		inode_dio_end(inode);
+		igrab(inode);
 		nfs_direct_req_release(dreq);
+		inode_dio_end(inode);
+		iput(inode);
 		return result < 0 ? result : -EIO;
 	}
 
@@ -864,8 +867,10 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 	 * generic layer handle the completion.
 	 */
 	if (requested_bytes == 0) {
-		inode_dio_end(inode);
+		igrab(inode);
 		nfs_direct_req_release(dreq);
+		inode_dio_end(inode);
+		iput(inode);
 		return result < 0 ? result : -EIO;
 	}
 
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index f96367a..ccd6c16 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -83,6 +83,7 @@ int nfs_check_flags(int flags)
 	dprintk("NFS: release(%pD2)\n", filp);
 
 	nfs_inc_stats(inode, NFSIOS_VFSRELEASE);
+	inode_dio_wait(inode);
 	nfs_file_clear_open_context(filp);
 	return 0;
 }
-- 
1.8.3.1

