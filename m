Return-Path: <linux-nfs+bounces-4363-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C1391A34D
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 12:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC671F22F12
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 10:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DD871B3A;
	Thu, 27 Jun 2024 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="B4Ds9cp/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C366A4501F
	for <linux-nfs@vger.kernel.org>; Thu, 27 Jun 2024 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482495; cv=none; b=dApOelfde1J5xMJP5J07bte6VQAXWrnWFfImmh8ewf21HJpXCMIDGxDEAQFLo8dnBVMql63YOzJuyKtOhuZFPtWTnsaHdS6n3QbBqaXXMziiUi7tuaOa9vn6B/ReKdRg2s7N0mDe2ciMUee5GzMzSLSPxpYRylD7H9M9tsKbiA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482495; c=relaxed/simple;
	bh=yPJyYSeU5VmheAo4lTrsfMptclBHkcndYqGbKyDloyE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Yq/EOBNVLCl5vT9Gr+oFaE6S/ZM80Q0reAhKysP/k7XlmlrdV88Vt6rHZEPCKWwB3XGKDdwFb5Z1N1MPIe8zUMfu7syxXrQZ9G1V/ni4So2OHk34e3tTqyMV+lQsgi/nhAl09mFV0ZRnQl0M05mBe6SLdepAFRE1QRX6ZgjOo2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=B4Ds9cp/; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so449981fa.0
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jun 2024 03:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1719482491; x=1720087291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=16FykWRljFOxc2fhfDF33MaQd3ZkvRluKtEq7iRVdGs=;
        b=B4Ds9cp/wgVcBhQ4QXq3w53gmLGVMAl5QX1dpJP/X3N1TLZ3JULvaqvJsMWKIJRV7I
         8J482UL1ZGqR9t9yQFc9ThSelemM7CsKHJyAXhx/xizXrCNrMciQPl+ad/0olrUigmc2
         Nwzsxk2k8depemwf1eeKY/b5X+vNroQNP4qO/381CUWacMzo9iJ3/0eInIhm15ouQXOG
         pdiFhrpskrYbkay4nh7ZUirIp+S+GWddi050Bz2yeHKYcXer6gyfI76eaBoWblpV4OV8
         MzZ2axKWbkmJPx0kZhxODAAgN5RQt6dK2pZC4KfiZdkP70kmEsP0lMLjmhd2qslWGmd2
         DbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719482491; x=1720087291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16FykWRljFOxc2fhfDF33MaQd3ZkvRluKtEq7iRVdGs=;
        b=PCZRoF2u3BY7iqWj/LD+giywcAhG3/WNzXigCexPA4SQsSDdHT3MDFSoTIxKysTGeQ
         wI/BzookG7iPy+XmXEyLtF0mbS3xZCjxmU1CQ4k1ltE4rbHG3BNsl+YQrbUAnXSgHp6n
         2Ol/qcTLihoPdNBo8GpfHDlgB4VPm/5fD27WVecpMRpEC5L/DC9lb6gY+ifT1ziToo7F
         RidxZxIaphqQnUdlUShNLW7htJHoTD6UhvayjjeoQQ93bG911iGwj9vUc8hl7FY8vKmB
         ug39aCgBqBkwP3y9lQgTEC9f2JxtP11UTUVWbKb2WeJsjdQtIZgGuPh7qQgqrVVdgiQB
         7ctw==
X-Gm-Message-State: AOJu0Yx2Pc3QMntqCtnUKUxqnEzScqFXpuLIqrQqFzGjF53J1gNawf68
	lOqujq3yXf1MoiJMfu+JUuNsd5Ijf2mC6V4PKDXEH1wgOBvTY6w4SiqUMWhNwYD7tAehkWazCib
	Y
X-Google-Smtp-Source: AGHT+IHgFay0vbUOn5s5dcknnWF0o72jsFw0nuCBBLtT97W4+7E9kh/OL2g3T9vHtWe/Oe94KC3mYw==
X-Received: by 2002:a2e:b173:0:b0:2ec:5945:62e9 with SMTP id 38308e7fff4ca-2ee4645fff7mr26280391fa.32.1719482491332;
        Thu, 27 Jun 2024 03:01:31 -0700 (PDT)
Received: from jupiter.vstd.int ([176.230.79.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b65a0fsm18995405e9.16.2024.06.27.03.01.30
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:01:30 -0700 (PDT)
From: Dan Aloni <dan.aloni@vastdata.com>
To: linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: add 'noalignwrite' option for lock-less 'lost writes' prevention
Date: Thu, 27 Jun 2024 13:01:29 +0300
Message-Id: <20240627100129.2482408-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some applications that write to predefined non-overlapping
file offsets from multiple clients and therefore don't need to rely on
file locking. However, if these applications want non-aligned offsets
and sizes they need to either use locks or risk data corruption, as the
NFS client defaults to extending writes to whole pages.

This commit adds a new mount option `noalignwrite`, which allows to turn
that off and avoid the need of locking, as long as these applications
don't overlap on offsets.

Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 fs/nfs/fs_context.c       | 8 ++++++++
 fs/nfs/super.c            | 3 +++
 fs/nfs/write.c            | 3 +++
 include/linux/nfs_fs_sb.h | 1 +
 4 files changed, 15 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 6c9f3f6645dd..7e000d782e28 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -49,6 +49,7 @@ enum nfs_param {
 	Opt_bsize,
 	Opt_clientaddr,
 	Opt_cto,
+	Opt_alignwrite,
 	Opt_fg,
 	Opt_fscache,
 	Opt_fscache_flag,
@@ -149,6 +150,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_u32   ("bsize",		Opt_bsize),
 	fsparam_string("clientaddr",	Opt_clientaddr),
 	fsparam_flag_no("cto",		Opt_cto),
+	fsparam_flag_no("alignwrite",	Opt_alignwrite),
 	fsparam_flag  ("fg",		Opt_fg),
 	fsparam_flag_no("fsc",		Opt_fscache_flag),
 	fsparam_string("fsc",		Opt_fscache),
@@ -592,6 +594,12 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		else
 			ctx->flags |= NFS_MOUNT_TRUNK_DISCOVERY;
 		break;
+	case Opt_alignwrite:
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_NO_ALIGNWRITE;
+		else
+			ctx->flags &= ~NFS_MOUNT_NO_ALIGNWRITE;
+		break;
 	case Opt_ac:
 		if (result.negated)
 			ctx->flags |= NFS_MOUNT_NOAC;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index cbbd4866b0b7..1382ae19bba4 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -549,6 +549,9 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 	else
 		seq_puts(m, ",local_lock=posix");
 
+	if (nfss->flags & NFS_MOUNT_NO_ALIGNWRITE)
+		seq_puts(m, ",noalignwrite");
+
 	if (nfss->flags & NFS_MOUNT_WRITE_EAGER) {
 		if (nfss->flags & NFS_MOUNT_WRITE_WAIT)
 			seq_puts(m, ",write=wait");
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 2329cbb0e446..cfe8061bf005 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1315,7 +1315,10 @@ static int nfs_can_extend_write(struct file *file, struct folio *folio,
 	struct file_lock_context *flctx = locks_inode_context(inode);
 	struct file_lock *fl;
 	int ret;
+	unsigned int mntflags = NFS_SERVER(inode)->flags;
 
+	if (mntflags & NFS_MOUNT_NO_ALIGNWRITE)
+		return 0;
 	if (file->f_flags & O_DSYNC)
 		return 0;
 	if (!nfs_folio_write_uptodate(folio, pagelen))
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 92de074e63b9..4d28b4a328a7 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -157,6 +157,7 @@ struct nfs_server {
 #define NFS_MOUNT_WRITE_WAIT		0x02000000
 #define NFS_MOUNT_TRUNK_DISCOVERY	0x04000000
 #define NFS_MOUNT_SHUTDOWN			0x08000000
+#define NFS_MOUNT_NO_ALIGNWRITE		0x10000000
 
 	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
-- 
2.39.3


