Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663A922131B
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2020 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGORCd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jul 2020 13:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgGORC3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jul 2020 13:02:29 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DEFC061755
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2020 10:02:29 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d18so3025919ion.0
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2020 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B1du7ESxAv65/20o5JoUU2qEgG2wKq/h11b/DD3/ktY=;
        b=Yl1FVLQQRSySLJ4SEVAGpNUikJ3udNi+ARNJ2JcMcfxwgB5ARh+lObxCGGjgVIGSMP
         VrCPsmTtFm/IVEM7pDQyCZVLaA5kuy1p9rfPFga+HnTJhN9BdgIl4grjs1ei6G2Zfp0Q
         Liu0KrfNn8Dg9DeNL1z7fnxXfQ7X0jYl+iue8o9pUJdlD7tD7TW5846Dzo4iv1Ema1iG
         dgpzT4o5uw09DGb12BSg6FanLQzIn8ZfvwcZUfgErKJeo9uIL9q1S9MwBs52C385v9I7
         zpBRmWNg9S1JcafC/Jgrakt0ktUxORKSCCSlMD1/5T/WLQoh1CqiDwNhOONOXqIMHeCf
         YQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B1du7ESxAv65/20o5JoUU2qEgG2wKq/h11b/DD3/ktY=;
        b=aqSXvo6K71EbJBpRqfZPkPA2Rhkl7fhcjpOxRyMU2bcf8UYjfDjGC4BYpzt6AP2Ah/
         24WYPXZKZxvdKSq4MpOVIXCNK/5SV1MAui7n9Drp7X7J3lfQ3sirThVppdpC1zcpk71+
         LVh268rRPvGisezLkPRob0H+eKrpIt/CCgWjOFme1so7rl1DjbgtrGvKmrnq6q9YVZpn
         evsD7zThECe+MnhNBt+gTMTHfbEY0YsqrUNL1vShk2ZxOiT8aB/OqybQhmfWuldQ3ZDg
         er9xsRCo1754vqc9MLI65oG76skuUDhlkQvaoZLDS95cUUGi+DckPYRaNeNiwGU2+qn4
         PeIQ==
X-Gm-Message-State: AOAM5322aDVU2zXyAXPAr5DEkAyfDgvV2tKJGXSyTN9H35ONoDsNJu0U
        5clopMHz6zPEGV53cb/CvEo=
X-Google-Smtp-Source: ABdhPJysf2C0uDdFCdxw75hpUMp5cDJ8X341fukW2fx+az4oQ6FwO6RLJ2wfF4gqrs3uiDBRKp/U3g==
X-Received: by 2002:a05:6602:2c4c:: with SMTP id x12mr213327iov.87.1594832548820;
        Wed, 15 Jul 2020 10:02:28 -0700 (PDT)
Received: from Olgas-MBP-286.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id s11sm1354953ili.79.2020.07.15.10.02.23
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Jul 2020 10:02:23 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] SUNRPC reverting d03727b248d0 ("NFSv4 fix CLOSE not waiting for direct IO compeletion")
Date:   Wed, 15 Jul 2020 13:04:15 -0400
Message-Id: <20200715170415.94140-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Reverting commit d03727b248d0 "NFSv4 fix CLOSE not waiting for
direct IO compeletion". This patch made it so that fput() by calling
inode_dio_done() in nfs_file_release() would wait uninterruptably
for any outstanding directIO to the file (but that wait on IO should
be killable).

The problem the patch was also trying to address was REMOVE returning
ERR_ACCESS because the file is still opened, is supposed to be resolved
by server returning ERR_FILE_OPEN and not ERR_ACCESS.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/direct.c | 13 ++++---------
 fs/nfs/file.c   |  1 -
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 3d113cf..1b79dd5 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -267,6 +267,8 @@ static void nfs_direct_complete(struct nfs_direct_req *dreq)
 {
 	struct inode *inode = dreq->inode;
 
+	inode_dio_end(inode);
+
 	if (dreq->iocb) {
 		long res = (long) dreq->error;
 		if (dreq->count != 0) {
@@ -278,10 +280,7 @@ static void nfs_direct_complete(struct nfs_direct_req *dreq)
 
 	complete(&dreq->completion);
 
-	igrab(inode);
 	nfs_direct_req_release(dreq);
-	inode_dio_end(inode);
-	iput(inode);
 }
 
 static void nfs_direct_read_completion(struct nfs_pgio_header *hdr)
@@ -411,10 +410,8 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 	 * generic layer handle the completion.
 	 */
 	if (requested_bytes == 0) {
-		igrab(inode);
-		nfs_direct_req_release(dreq);
 		inode_dio_end(inode);
-		iput(inode);
+		nfs_direct_req_release(dreq);
 		return result < 0 ? result : -EIO;
 	}
 
@@ -867,10 +864,8 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 	 * generic layer handle the completion.
 	 */
 	if (requested_bytes == 0) {
-		igrab(inode);
-		nfs_direct_req_release(dreq);
 		inode_dio_end(inode);
-		iput(inode);
+		nfs_direct_req_release(dreq);
 		return result < 0 ? result : -EIO;
 	}
 
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index ccd6c16..f96367a 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -83,7 +83,6 @@ int nfs_check_flags(int flags)
 	dprintk("NFS: release(%pD2)\n", filp);
 
 	nfs_inc_stats(inode, NFSIOS_VFSRELEASE);
-	inode_dio_wait(inode);
 	nfs_file_clear_open_context(filp);
 	return 0;
 }
-- 
1.8.3.1

