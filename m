Return-Path: <linux-nfs+bounces-13575-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B053B225F5
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 13:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451381674DE
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 11:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DDE2EA162;
	Tue, 12 Aug 2025 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHrvyP5e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCA22E3B17
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998572; cv=none; b=u2qOTUmA5m+leANtjVJZT88g3wfqIdwfqQMcrDRuy+i4i8UKtm2YWutSDfFmGGYyYVsJUJvF2hIe4VYTQmxpbMGOKf5v7Qfnvfzb19rv6Ts/r2nj2Iw/o2ViwtFDcuuRciQpYhAhzABgs4TC+rjn0lv6cS/eJnfii7E9jjb+ulM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998572; c=relaxed/simple;
	bh=hqvAW9VqZvFwwOOPbFowE4y7MXdnL4jOMPJzHxqgl+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KbZz5N9mbH9pBmfDDgfxqw+nfAdHSPyW+0dJG0l5EpiZqbJhMnFEBJHB/aaNnPVjicf/IAI513qd4Zzl4U1RzaHRf1JiKgaUStLUyAa4n7pBdERWbjbpH6Oto0oj0Qo8OUE0EmBZph1bA61SoWsmKCpTpNtSUCpgRI3ViGZ8xu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHrvyP5e; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bed310fa1so4526096b3a.2
        for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 04:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754998570; x=1755603370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1sIrVaS9RKhXqVZzY0HIx0H4Bu2IljIjXqbQtHIWX6Q=;
        b=kHrvyP5eYlMDCvR4jyV3ddM3NdOpqA+TjbZvvgMX69bkV/ntPmclaDukgYlXjEKrHV
         38BId0OYYGMvtfwV69UZANTil6cETTt90G4WVWjhHp/EqWr69S7Be6Tp5ERMHrg+pGN0
         N7A1a1rHaYfSyIxiBRAylttyZANisd5P+OOQ/G29ggEfZI/RTzydeOy9M5J5BYxmooIK
         kj8Vdx/oSywJwSHW5yqCRfTRY8ySh4xS7oePSyHoRDfusICGISxE5a0K14M1QncmgCw2
         8b5VMfvzQ3QKVHod9MwDAUb399ISpJK8CJ2jOixjRv8DL/A1neMihXY/0aEctPKfG7IE
         zyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754998570; x=1755603370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1sIrVaS9RKhXqVZzY0HIx0H4Bu2IljIjXqbQtHIWX6Q=;
        b=gJMZSoiqUKElSvnl/MsUCD4ZItWjAcJZUWbHUYMo44PDse3L/AoUgqpQKgumzWY5tU
         4xzsRLvBN3vfKFs6ymAhfom4KpTYayC3pctMlfhVlt6jRvzy6CIH3yxTHDjTBDUsz1hp
         mZrfH+eDBD/qRrX8DbHWpNcc9UITBV9EQAIZiCSu54K2pZcjXbjKlIWIMR9jI0OlBO/y
         HPCD+jmWLKcD6t9N6A9XD08e7NxUF0pX59syO4hI93VmFy3YVQHSX/KzGWe/rDXQrrxZ
         5Zq9IZM/ycTC5ftOpeTrs0rZllJaG42IIBiP5cWyPklxiPjhVaPezGqh27FX0Qf+/nMU
         VPlA==
X-Forwarded-Encrypted: i=1; AJvYcCX+zVbQAiEIYMI22b9mI+lQNNVWRIyLtPf5WYLzb0HU8HE8hfiyBV8ws4B6gYopqi++3baYT+2ZVCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnNdceB+I7yZMSIKQZjcliWLNIDe3pQK4j3C88msRn0LNBwObE
	OSbJfurJ/knVhelE7WzTwsqSo4I/PMk3UOAmLtiVqZVOK5lsTCUV2Gi6
X-Gm-Gg: ASbGncvrZ0LjGxu2HORYe2bKsgRtPl7AByADH+ecKenjUFk6k6S6LzP7roHnM54eUWt
	5mm63dkbmD45G7r63A8iAf5EQR584xl2oNyLRlcSi9gKRBu+aQI4nwiVpKP2PYdrL0vzXRigH0Z
	yBmw7dbFYps67wZRgZohNFqeSSWBqbGnO61/g5B0Dp4K2QdyZT8AbvG8GLlnvx64InhZZ5R1OwN
	kX8eZBnaJvS4Au2qqTz7Ih0QnAqy2keuf6SnlhVWfvrq88WVBV2SfntQHDkeWErK094vFjQKTcd
	S4sjLM9OmPFEMMDh73U50CT21Z2+DZG1U1hDL0VaOwS5rp9FKdlqKbsptShR/fJCu4HGTUd3DP/
	6ULogbrOSvOCh0W7Khx3DzpMh0BHsangdnRW6JS70XiV6dl127h+EdUJ9uw==
X-Google-Smtp-Source: AGHT+IGOqyHn14WLfQOel3ipcJo/UGkOGlHhg0FtmYY+lCUwBt4H9dmqy5NQB+HGUtV57g+LvFt38Q==
X-Received: by 2002:a17:903:1987:b0:240:99da:f0b1 with SMTP id d9443c01a7336-242c21dc55cmr253590205ad.36.1754998569915;
        Tue, 12 Aug 2025 04:36:09 -0700 (PDT)
Received: from localhost.localdomain ([192.146.154.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b43dsm297272415ad.136.2025.08.12.04.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:36:09 -0700 (PDT)
From: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	jlayton@kernel.org,
	bcodding@redhat.com,
	linux-nfs@vger.kernel.org
Cc: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
Subject: [PATCH] pNFS/filelayout: Parameter to avoid MDS IO.
Date: Tue, 12 Aug 2025 07:35:56 -0400
Message-ID: <20250812113556.3951-1-gaurav.gangalwar@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Configurable parameter to avoid MDS IO in case of DS failure.
We want to retry same DS, similar to NFS hard mount retries.

Signed-off-by: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
---
 fs/nfs/filelayout/filelayout.c    | 40 +++++++++++++++++++++----------
 fs/nfs/filelayout/filelayout.h    |  2 ++
 fs/nfs/filelayout/filelayoutdev.c |  3 ++-
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index d39a1f58e18d..6a16151f5d1a 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -50,6 +50,7 @@ MODULE_DESCRIPTION("The NFSv4 file layout driver");
 
 #define FILELAYOUT_POLL_RETRY_MAX     (15*HZ)
 static const struct pnfs_commit_ops filelayout_commit_ops;
+bool filelayout_avoid_mds_io;
 
 static loff_t
 filelayout_get_dense_offset(struct nfs4_filelayout_segment *flseg,
@@ -185,16 +186,22 @@ static int filelayout_async_handle_error(struct rpc_task *task,
 	case -ENODEV:
 		dprintk("%s DS connection error %d\n", __func__,
 			task->tk_status);
-		nfs4_mark_deviceid_unavailable(devid);
-		pnfs_error_mark_layout_for_return(inode, lseg);
-		pnfs_set_lo_fail(lseg);
-		rpc_wake_up(&tbl->slot_tbl_waitq);
+		if (!filelayout_avoid_mds_io) {
+			nfs4_mark_deviceid_unavailable(devid);
+			pnfs_error_mark_layout_for_return(inode, lseg);
+			pnfs_set_lo_fail(lseg);
+			rpc_wake_up(&tbl->slot_tbl_waitq);
+		}
 		fallthrough;
 	default:
 reset:
-		dprintk("%s Retry through MDS. Error %d\n", __func__,
+		if (!filelayout_avoid_mds_io) {
+			dprintk("%s Retry through MDS. Error %d\n", __func__,
+				task->tk_status);
+			return -NFS4ERR_RESET_TO_MDS;
+		}
+		dprintk("%s Retry through DS. Error %d\n", __func__,
 			task->tk_status);
-		return -NFS4ERR_RESET_TO_MDS;
 	}
 	task->tk_status = 0;
 	return -EAGAIN;
@@ -257,7 +264,8 @@ filelayout_reset_to_mds(struct pnfs_layout_segment *lseg)
 {
 	struct nfs4_deviceid_node *node = FILELAYOUT_DEVID_NODE(lseg);
 
-	return filelayout_test_devid_unavailable(node);
+	return (!filelayout_avoid_mds_io &&
+		filelayout_test_devid_unavailable(node));
 }
 
 /*
@@ -465,11 +473,13 @@ filelayout_read_pagelist(struct nfs_pgio_header *hdr)
 	idx = nfs4_fl_calc_ds_index(lseg, j);
 	ds = nfs4_fl_prepare_ds(lseg, idx);
 	if (!ds)
-		return PNFS_NOT_ATTEMPTED;
+		return filelayout_avoid_mds_io ? PNFS_TRY_AGAIN :
+			PNFS_NOT_ATTEMPTED;
 
 	ds_clnt = nfs4_find_or_create_ds_client(ds->ds_clp, hdr->inode);
 	if (IS_ERR(ds_clnt))
-		return PNFS_NOT_ATTEMPTED;
+		return filelayout_avoid_mds_io ? PNFS_TRY_AGAIN :
+			PNFS_NOT_ATTEMPTED;
 
 	dprintk("%s USE DS: %s cl_count %d\n", __func__,
 		ds->ds_remotestr, refcount_read(&ds->ds_clp->cl_count));
@@ -508,11 +518,13 @@ filelayout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	idx = nfs4_fl_calc_ds_index(lseg, j);
 	ds = nfs4_fl_prepare_ds(lseg, idx);
 	if (!ds)
-		return PNFS_NOT_ATTEMPTED;
+		return filelayout_avoid_mds_io ? PNFS_TRY_AGAIN :
+			PNFS_NOT_ATTEMPTED;
 
 	ds_clnt = nfs4_find_or_create_ds_client(ds->ds_clp, hdr->inode);
 	if (IS_ERR(ds_clnt))
-		return PNFS_NOT_ATTEMPTED;
+		return filelayout_avoid_mds_io ? PNFS_TRY_AGAIN :
+			PNFS_NOT_ATTEMPTED;
 
 	dprintk("%s ino %lu sync %d req %zu@%llu DS: %s cl_count %d\n",
 		__func__, hdr->inode->i_ino, sync, (size_t) hdr->args.count,
@@ -843,7 +855,8 @@ fl_pnfs_update_layout(struct inode *ino,
 				  gfp_flags);
 	if (IS_ERR(lseg)) {
 		/* Fall back to MDS on recoverable errors */
-		if (!nfs_error_is_fatal_on_server(PTR_ERR(lseg)))
+		if (!filelayout_avoid_mds_io &&
+		    !nfs_error_is_fatal_on_server(PTR_ERR(lseg)))
 			lseg = NULL;
 		goto out;
 	} else if (!lseg)
@@ -1149,5 +1162,8 @@ static void __exit nfs4filelayout_exit(void)
 
 MODULE_ALIAS("nfs-layouttype4-1");
 
+module_param(filelayout_avoid_mds_io, bool, 0644);
+MODULE_PARM_DESC(filelayout_avoid_mds_io, "Disable IO from MDS");
+
 module_init(nfs4filelayout_init);
 module_exit(nfs4filelayout_exit);
diff --git a/fs/nfs/filelayout/filelayout.h b/fs/nfs/filelayout/filelayout.h
index c7bb5da93307..7df3485ea510 100644
--- a/fs/nfs/filelayout/filelayout.h
+++ b/fs/nfs/filelayout/filelayout.h
@@ -98,6 +98,8 @@ filelayout_test_devid_invalid(struct nfs4_deviceid_node *node)
 	return test_bit(NFS_DEVICEID_INVALID, &node->flags);
 }
 
+extern bool filelayout_avoid_mds_io;
+
 extern bool
 filelayout_test_devid_unavailable(struct nfs4_deviceid_node *node);
 
diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index 29d9234d5c08..fa557f8f9792 100644
--- a/fs/nfs/filelayout/filelayoutdev.c
+++ b/fs/nfs/filelayout/filelayoutdev.c
@@ -282,7 +282,8 @@ nfs4_fl_prepare_ds(struct pnfs_layout_segment *lseg, u32 ds_idx)
 			     dataserver_retrans, 4,
 			     s->nfs_client->cl_minorversion);
 	if (status) {
-		nfs4_mark_deviceid_unavailable(devid);
+		if (!filelayout_avoid_mds_io)
+			nfs4_mark_deviceid_unavailable(devid);
 		ret = NULL;
 		goto out;
 	}
-- 
2.43.7


