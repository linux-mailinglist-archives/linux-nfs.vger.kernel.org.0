Return-Path: <linux-nfs+bounces-15992-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6C1C2F4EE
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 05:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBA33B6116
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 04:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC692641C6;
	Tue,  4 Nov 2025 04:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bluetoad.com.au header.i=@bluetoad.com.au header.b="Z28JUT9e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from toadmail2.bluetoad.net.au (bluetoad.net.au [192.155.86.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639718FDDE
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 04:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.155.86.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762230916; cv=none; b=XDgld8ojdMQF0qrn0P/L12pjab/5z3f0gYleZY2GiFf8haWmkV0iqs1rq/yXjiW38DzxWdnkMKS85aVzQIDDcMFRs4pGYO6arP5Yb0hSJXWpIeEuvCVzwJQHtnCRcwTNpjWDuDUm0sTErwSgOxhgQL/jIXVe6a+YJhR4h9VGca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762230916; c=relaxed/simple;
	bh=ikZ4z+Xhn+JlbEWZvIxiuRCtsmi4rdU7uGXh6vx/CF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IhSyGPXAl1Eiy20a+KEQj+hB7oLn5l7kBbFIzDyi+t1Ik+R97PKr3T+zhezBBEUwkhvQmZp+8gbBgb2ra8LQicaQiesnqAyiV2CqWCFUzi1iUvT3VmLW1O3ZcMgpiQR6x1J0xeRglCufoZaIpKI5BGFsnGmauYkVRPjwq6WOTn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bluetoad.com.au; spf=pass smtp.mailfrom=bluetoad.com.au; dkim=pass (1024-bit key) header.d=bluetoad.com.au header.i=@bluetoad.com.au header.b=Z28JUT9e; arc=none smtp.client-ip=192.155.86.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bluetoad.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluetoad.com.au
Received: from bluetoad.com.au (unknown [1.146.123.122])
	by toadmail2.bluetoad.net.au (Postfix) with ESMTPSA id A9E075E0D1;
	Tue,  4 Nov 2025 14:35:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bluetoad.com.au;
	s=202004013; t=1762230912; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=SUEHeZopem/I0hgFL91DP4VwiKjASytgPIcGN1vNM8U=;
	b=Z28JUT9eBTKRXg0Wr+Yr/R2PBnzD22kRLfOC/Rjaws4+8cbFmiDIAVVeWi0+sn9np8uBMw
	0kD5THoMdGNLC/BDZ2Kwb9xIWX4MW/Gx8kRsukpNoFkn8C3Gt2wiPUNmQjQC6Qv632kqfw
	wJYdzoBlfmnr2OW1WgNQ3QV5i42Bs6M=
From: peter@bluetoad.com.au
To: linux-nfs@vger.kernel.org
Cc: Peter Schwenke <peter@bluetoad.com.au>,
	Peter Schwenke <pschwenke@ddn.com>
Subject: [PATCH] nfs-utils: Do not drop privileges if running as non-root user
Date: Tue,  4 Nov 2025 15:34:54 +1100
Message-Id: <20251104043454.751100-1-peter@bluetoad.com.au>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Schwenke <peter@bluetoad.com.au>

If sm-notify is not running root and is running
as the owner of the state directory, it is not
necessary to drop privileges.

The patch checks if the current user is the owner of the state
directory.

In the case of a ha-callout, the ha-callout will, more than likely, be running
as rpcuser - or similar.  That means the sm-notify program can not be called
from the ha-callout.

nsm_drop_privileges() is also called by statd.  However, that will fail for
a number of reasons such as not being able to create the PID file etc.  So,
this patch should not cause any issues for statd.  statd will still need to be
started as root.

Without this patch capabalities such as cap_setpcap, cap_setgid,
cap_net_bind_service=ep need to be set.  Clearly, that is an ugly hack and
best avoided.

Signed-off-by: Peter Schwenke <pschwenke@ddn.com>
Signed-off-by: Peter Schwenke <peter@bluetoad.com.au>
---
 support/nsm/file.c        | 11 +++++++++++
 utils/statd/sm-notify.man | 10 +++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/support/nsm/file.c b/support/nsm/file.c
index 5ec801c3..1e97b5b6 100644
--- a/support/nsm/file.c
+++ b/support/nsm/file.c
@@ -394,6 +394,7 @@ _Bool
 nsm_drop_privileges(const int pidfd)
 {
 	struct stat st;
+	uid_t uid;
 
 	(void)umask(S_IRWXO);
 
@@ -408,6 +409,16 @@ nsm_drop_privileges(const int pidfd)
 		return false;
 	}
 
+	/*
+	 * Check if we are running as non-root user and we are the owner of
+	 * the monitor directory.  Then there is no reason to drop privileges
+	 * and change groups etc.
+	 */
+	uid = getuid();
+	if (uid != 0 && uid == st.st_uid) {
+		return true;
+	}
+
 	if (!prune_bounding_set())
 		return false;
 
diff --git a/utils/statd/sm-notify.man b/utils/statd/sm-notify.man
index addf5d3c..2e82c683 100644
--- a/utils/statd/sm-notify.man
+++ b/utils/statd/sm-notify.man
@@ -275,7 +275,7 @@ section is
 .SH SECURITY
 The
 .B sm-notify
-command must be started as root to acquire privileges needed
+command is, generally, started as root to acquire privileges needed
 to access the state information database.
 It drops root privileges
 as soon as it starts up to reduce the risk of a privilege escalation attack.
@@ -290,6 +290,14 @@ chooses, simply use
 .BR chown (1)
 to set the owner of
 the state directory.
+.PP
+The
+.B sm-notify
+command can also be started by the user ID that owns the state directory.
+That is useful for the situation when it is called from an rpc-stat
+ha-callout program that is already running as the
+non-privileged user.  The non-root user will not have the capabilities
+to drop the root privileges as described above.
 .SH ADDITIONAL NOTES
 Lock recovery after a reboot is critical to maintaining data integrity
 and preventing unnecessary application hangs.
-- 
2.39.5


