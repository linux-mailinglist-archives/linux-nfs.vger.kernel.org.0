Return-Path: <linux-nfs+bounces-17112-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F9FCBFE1E
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 22:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D271F30274F8
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 21:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8867329377;
	Mon, 15 Dec 2025 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="K63yqePN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20CA329371
	for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833263; cv=none; b=JE9HH4i8m+vxBWVOLOhu9L2ZXhcIwxtVprwhCYBKjt2fZzrGdlF8TbSfzOoZIlnavPyyj11WXzx5JMHXQIbskcO6+n2BjmU7nVVl5q20ZYYHbqaOjX8kMv7vCJYAeR6SOvceHyYZMfFlU9pAYDOyKGrGZeVZDtNHPv61YnSLPVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833263; c=relaxed/simple;
	bh=C50hFOdj+5tf5Z45mvIITWQBaaJP68nJhansPLDtxiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y3gD/38o6HAMSB60KFYpeGv+0Am6Ehl46YaTSAdupWZRT48egVF6ZidcKKjscAyp41j4cu8FQdmmXSYc+KqT6nNMgolAEw6o4Lg7n1iU/DdwQYzophdsi0BmZeGFyKysNgzUaojDEkQ0wsyooj2q2XsaqtSwJGtvUVISU3XP0XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=K63yqePN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so5248243a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 13:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765833258; x=1766438058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4scFUZ0HqWgR/L0FBp6hI8S1Mhc4wumL29J9z1jST4=;
        b=K63yqePN+IilYq/bgbQg8eXQukpYkZSIOe0svLb4Xyp47x3SSK026tiHb7+sjaPJft
         LCszdU3XABd3pM8P3yzR7O+HUCkvF6YgdyXXmZXzjtaoy/Dmd4nb0rgMRyTqTNsNwONo
         vo0/Ln6w/14boJWyoKFkeKr5OLXzTnPzM2T267g46jrQUjqsMAGfLE/75M7aVeA3irun
         u2lk6B4eFsbS43ycA7w2RdG0ttLpY09LtNU2Wf49f8uqkEJx6f0xbVOiHCNvfr+FY7cd
         SH8TvGizdfoYC33vV4Hq/ZSxAWLZo3NC1wPjCD+nMPCprLapBHKRg8LStj5fc48H+Mp+
         ycAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765833258; x=1766438058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f4scFUZ0HqWgR/L0FBp6hI8S1Mhc4wumL29J9z1jST4=;
        b=ECkUFB+qiM1XPq+6xtEoQozaXP6sY8Ek207TfKTw7vryRN864jQHzmE0yhf/EfJo2R
         kaMKQWqbT0QlrhqTiyVj2ah8h27OI+OsFK5sxhdIvyTV6qpkw6QGrRy+KGb6VGetpIYK
         b+61axaL/oCnasmXh18mYBtepOzoCV7o3VvWS5LT+EVyvQStypKR/rrsHDoSuAdqpoUP
         A3KAfY8suKtW0jQ1gDthDPjY4r0boJjczj/eeFAL+zzPcA6R1d9UnbEt2aY2Fnw+sz4T
         GHR2DNgj3YR1prppFEqCeSzzJZEZ/bgqK7gLDat8tNDqEgoHZ/cbpX222DPDrxoq/MxM
         +AEg==
X-Forwarded-Encrypted: i=1; AJvYcCWAJQRRQPeANFxJs8tRo0rEr3bdCKtUpf3gfn7Mr9Y/R2Mh02YYVLdV+bvu5MGJebIcWpnZ6FvSjaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWfmKq2P6hwIc+witNq4jJv7fSPb7G5c5zRBcAfSHd6OJLoh6n
	YGnsIVrJMwhcpKG1pAlykvi44HEJGpEzyoAwcf83rZjqrvzNcyoWS0wxjxdygFFlfNI=
X-Gm-Gg: AY/fxX7fS+bfgg3eiDWa4Ym2n/7DHECWqqK/vVpqNePWGYLcMIYs7mv7FoIH4Ojn+d+
	nO6wUXdpLACbYv6+es5y7JMayM/pVT/DBfTg8O1iy6KaRCSDHjxXg4xHXqNTtGKQWT/LzWHbUZV
	HE7c5g4ZCglu4ZI+Wu8U8ZP3w7yNTsAHaMfcn5olUODm+uCNIMT1crzXyRhTNA3rrPkw6+5fno6
	xhEqQb3lsl22QugM6As2soaF1vSolx1V1qD7czz8MHRnP7tRS2qoElGcuyTBokMOh1qyLEKMoLm
	21Q8fnk0NlT0liNN18NTJvmxnaz1BEOffsO4z7S9tE9JMPp6We0R8lvknupL8/10vxA4NdydIBV
	jtgbzyQqwGtVVop+7TKvBS/3Zc2UkFi82/dzmh2Xkubaukqyroyp2hhgqnh2lfH2TLAZTwml6M7
	NPEeK3awEG1N3jImn82WS0h/hUKFYhuMtsJOBngQwtwg==
X-Google-Smtp-Source: AGHT+IEEt+akPmb1rcPS7sv3/Sym3VpTRmzh0DgFaBpAmyCgQqzJEAyWfVxGa6MEhxoulIsJY/BSWQ==
X-Received: by 2002:a05:6402:1d4f:b0:640:c640:98c5 with SMTP id 4fb4d7f45d1cf-6499b349e4dmr12023739a12.34.1765833258526;
        Mon, 15 Dec 2025 13:14:18 -0800 (PST)
Received: from irdv-jcurley.dev.purestorage.com ([208.88.158.129])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6498222b01csm14492583a12.35.2025.12.15.13.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 13:14:18 -0800 (PST)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4/flexfiles: Layouts are only available if specific stripe has a valid mirror
Date: Mon, 15 Dec 2025 21:14:04 +0000
Message-Id: <20251215211404.103349-2-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251215211404.103349-1-jcurley@purestorage.com>
References: <20251215211404.103349-1-jcurley@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates ff_read_layout_has_available_ds to consider the specific
dss_id to ensure that there is at least one valid mirror for the
stripe to be read. Otherwise a deadlock can occur.

Also updates ff_rw_layout_has_available_ds in case there's any
performance or availability benefits to considering only the stripe
required for this particular write.

Fixes: a1491919c880 ("NFSv4/flexfiles: Update low level helper functions to be DS stripe aware.")
Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c    |  6 +--
 fs/nfs/flexfilelayout/flexfilelayout.h    |  2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 55 +++++++++++------------
 3 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index b5e6985034cb..4ee1229a617d 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1351,7 +1351,7 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 		rpc_wake_up(&tbl->slot_tbl_waitq);
 		fallthrough;
 	default:
-		if (ff_layout_avoid_mds_available_ds(lseg))
+		if (ff_layout_avoid_mds_available_ds(lseg, dss_id))
 			return -NFS4ERR_RESET_TO_PNFS;
 reset:
 		dprintk("%s Retry through MDS. Error %d\n", __func__,
@@ -2113,7 +2113,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	return PNFS_ATTEMPTED;
 
 out_failed:
-	if (ff_layout_avoid_mds_available_ds(lseg))
+	if (ff_layout_avoid_mds_available_ds(lseg, dss_id))
 		return PNFS_TRY_AGAIN;
 	trace_pnfs_mds_fallback_read_pagelist(hdr->inode,
 			hdr->args.offset, hdr->args.count,
@@ -2195,7 +2195,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	return PNFS_ATTEMPTED;
 
 out_failed:
-	if (ff_layout_avoid_mds_available_ds(lseg))
+	if (ff_layout_avoid_mds_available_ds(lseg, dss_id))
 		return PNFS_TRY_AGAIN;
 	trace_pnfs_mds_fallback_write_pagelist(hdr->inode,
 			hdr->args.offset, hdr->args.count,
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index 17a008c8e97c..4378ce48f75b 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -247,7 +247,7 @@ const struct cred *ff_layout_get_ds_cred(struct nfs4_ff_layout_mirror *mirror,
 					 const struct pnfs_layout_range *range,
 					 const struct cred *mdscred,
 					 u32 dss_id);
-bool ff_layout_avoid_mds_available_ds(struct pnfs_layout_segment *lseg);
+bool ff_layout_avoid_mds_available_ds(struct pnfs_layout_segment *lseg, u32 dss_id);
 bool ff_layout_avoid_read_on_rw(struct pnfs_layout_segment *lseg);
 
 #endif /* FS_NFS_NFS4FLEXFILELAYOUT_H */
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index d25bac36dbd9..7d8c56b84ba6 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -21,7 +21,7 @@
 static unsigned int dataserver_timeo = NFS_DEF_TCP_TIMEO;
 static unsigned int dataserver_retrans;
 
-static bool ff_layout_has_available_ds(struct pnfs_layout_segment *lseg);
+static bool ff_layout_has_available_ds(struct pnfs_layout_segment *lseg, u32 dss_id);
 
 void nfs4_ff_layout_put_deviceid(struct nfs4_ff_layout_ds *mirror_ds)
 {
@@ -420,7 +420,7 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 				 lseg->pls_range.length, NFS4ERR_NXIO,
 				 OP_ILLEGAL, GFP_NOIO);
 	ff_layout_send_layouterror(lseg);
-	if (fail_return || !ff_layout_has_available_ds(lseg))
+	if (fail_return || !ff_layout_has_available_ds(lseg, dss_id))
 		pnfs_error_mark_layout_for_return(ino, lseg);
 	ds = NULL;
 out:
@@ -562,66 +562,63 @@ unsigned int ff_layout_fetch_ds_ioerr(struct pnfs_layout_hdr *lo,
 	return ret;
 }
 
-static bool ff_read_layout_has_available_ds(struct pnfs_layout_segment *lseg)
+static bool ff_read_layout_has_available_ds(struct pnfs_layout_segment *lseg,
+					    u32 dss_id)
 {
 	struct nfs4_ff_layout_mirror *mirror;
 	struct nfs4_deviceid_node *devid;
-	u32 idx, dss_id;
+	u32 idx;
 
 	for (idx = 0; idx < FF_LAYOUT_MIRROR_COUNT(lseg); idx++) {
 		mirror = FF_LAYOUT_COMP(lseg, idx);
 		if (!mirror)
 			continue;
-		for (dss_id = 0; dss_id < mirror->dss_count; dss_id++) {
-			if (!mirror->dss[dss_id].mirror_ds)
-				return true;
-			if (IS_ERR(mirror->dss[dss_id].mirror_ds))
-				continue;
-			devid = &mirror->dss[dss_id].mirror_ds->id_node;
-			if (!nfs4_test_deviceid_unavailable(devid))
-				return true;
-		}
+		if (!mirror->dss[dss_id].mirror_ds)
+			return true;
+		if (IS_ERR(mirror->dss[dss_id].mirror_ds))
+			continue;
+		devid = &mirror->dss[dss_id].mirror_ds->id_node;
+		if (!nfs4_test_deviceid_unavailable(devid))
+			return true;
 	}
 
 	return false;
 }
 
-static bool ff_rw_layout_has_available_ds(struct pnfs_layout_segment *lseg)
+static bool ff_rw_layout_has_available_ds(struct pnfs_layout_segment *lseg, u32 dss_id)
 {
 	struct nfs4_ff_layout_mirror *mirror;
 	struct nfs4_deviceid_node *devid;
-	u32 idx, dss_id;
+	u32 idx;
 
 	for (idx = 0; idx < FF_LAYOUT_MIRROR_COUNT(lseg); idx++) {
 		mirror = FF_LAYOUT_COMP(lseg, idx);
 		if (!mirror)
 			return false;
-		for (dss_id = 0; dss_id < mirror->dss_count; dss_id++) {
-			if (IS_ERR(mirror->dss[dss_id].mirror_ds))
-				return false;
-			if (!mirror->dss[dss_id].mirror_ds)
-				continue;
-			devid = &mirror->dss[dss_id].mirror_ds->id_node;
-			if (nfs4_test_deviceid_unavailable(devid))
-				return false;
-		}
+		if (IS_ERR(mirror->dss[dss_id].mirror_ds))
+			return false;
+		if (!mirror->dss[dss_id].mirror_ds)
+			continue;
+		devid = &mirror->dss[dss_id].mirror_ds->id_node;
+		if (nfs4_test_deviceid_unavailable(devid))
+			return false;
 	}
 
 	return FF_LAYOUT_MIRROR_COUNT(lseg) != 0;
 }
 
-static bool ff_layout_has_available_ds(struct pnfs_layout_segment *lseg)
+static bool ff_layout_has_available_ds(struct pnfs_layout_segment *lseg, u32 dss_id)
 {
 	if (lseg->pls_range.iomode == IOMODE_READ)
-		return  ff_read_layout_has_available_ds(lseg);
+		return  ff_read_layout_has_available_ds(lseg, dss_id);
 	/* Note: RW layout needs all mirrors available */
-	return ff_rw_layout_has_available_ds(lseg);
+	return ff_rw_layout_has_available_ds(lseg, dss_id);
 }
 
-bool ff_layout_avoid_mds_available_ds(struct pnfs_layout_segment *lseg)
+bool ff_layout_avoid_mds_available_ds(struct pnfs_layout_segment *lseg, u32 dss_id)
 {
 	return ff_layout_no_fallback_to_mds(lseg) ||
-	       ff_layout_has_available_ds(lseg);
+	       ff_layout_has_available_ds(lseg, dss_id);
 }
 
 bool ff_layout_avoid_read_on_rw(struct pnfs_layout_segment *lseg)
-- 
2.34.1


