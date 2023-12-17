Return-Path: <linux-nfs+bounces-680-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75330816008
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Dec 2023 15:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86421C21EC9
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Dec 2023 14:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F9E44C7D;
	Sun, 17 Dec 2023 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svario.it header.i=@svario.it header.b="WtIqlJzW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70144C7B
	for <linux-nfs@vger.kernel.org>; Sun, 17 Dec 2023 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svario.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svario.it
Received: from localhost.localdomain (dynamic-093-133-078-169.93.133.pool.telefonica.de [93.133.78.169])
	by mail.svario.it (Postfix) with ESMTPSA id 35312DEDA2;
	Sun, 17 Dec 2023 15:56:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1702825002; bh=A/ODxf27EJHTlsGHF6bPFLUEl8cBq0xEWAsH6hLhhyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtIqlJzWB42sOewXYdZGbUKpVzOxs0ByML7rueyPUI8L+mKd5dPsWO4qVn9QRvWoj
	 vdavbMGJ3leYhzk3HKeOSmG0cC+5/L1IK9C0Ca3pyTFub8plGmGO3XbO0Ws2GXIW+j
	 Thv5FZc572i7h4p4k0vl/YoQkUxwTnAdXy1Oi08kn9uYXmaWD0LRsIOySrRFCF8G0X
	 0eoDnswwixkI5wbCWgtDc2VCBso+ZwDqbkgwCYkEjP6yp+SXZMKqV9fbtn0XGWuwcm
	 j/pv/XcCc9hGcVtTrLTMOpEN6+l2vYiPbZWsHx57+zdfLRii+iypcj6ty1pQrqMcVu
	 Ys2IVoV58kO8A==
From: Gioele Barabucci <gioele@svario.it>
To: linux-nfs@vger.kernel.org
Cc: Steve Dickson <steved@redhat.com>,
	Gioele Barabucci <gioele@svario.it>
Subject: [PATCH 2/3] Fix typos in manpages
Date: Sun, 17 Dec 2023 15:55:38 +0100
Message-ID: <20231217145539.1380837-3-gioele@svario.it>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231217145539.1380837-1-gioele@svario.it>
References: <20231217145539.1380837-1-gioele@svario.it>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 utils/exportfs/exports.man        | 2 +-
 utils/mount/nfs.man               | 4 ++--
 utils/mount/nfsmount.conf.man     | 2 +-
 utils/nfsdcld/nfsdcld.man         | 2 +-
 utils/nfsdcltrack/nfsdcltrack.man | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index b7582776..58537a22 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -298,7 +298,7 @@ set.
 
 The
 .I nocrossmnt
-option can explictly disable
+option can explicitly disable
 .I crossmnt
 if it was previously set.  This is rarely useful.
 .TP
diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index c0ba4d08..7103d28e 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -964,7 +964,7 @@ Some server features misbehave in the face of a migration-compatible
 identification string.
 The
 .B nomigration
-option retains the use of a traditional client indentification string
+option retains the use of a traditional client identification string
 which is compatible with legacy NFS servers.
 This is also the behavior if neither option is specified.
 A client's open and lock state cannot be migrated transparently
@@ -1832,7 +1832,7 @@ auxiliary services such as the NLM service can choose
 any unused port number at random.
 .P
 Common firewall configurations block the well-known rpcbind port.
-In the absense of an rpcbind service,
+In the absence of an rpcbind service,
 the server administrator fixes the port number
 of NFS-related services so that the firewall
 can allow access to specific NFS service ports.
diff --git a/utils/mount/nfsmount.conf.man b/utils/mount/nfsmount.conf.man
index 10287cdf..6419190c 100644
--- a/utils/mount/nfsmount.conf.man
+++ b/utils/mount/nfsmount.conf.man
@@ -43,7 +43,7 @@ and will be shifted to lower case before being passed to the filesystem.
 .PP
 Boolean mount options which do not need an equals sign must be given as
 .RI \[dq] option =True".
-Instead of preceeding such an option with
+Instead of preceding such an option with
 .RB \[dq] no \[dq]
 its negation must be given as
 .RI \[dq] option =False".
diff --git a/utils/nfsdcld/nfsdcld.man b/utils/nfsdcld/nfsdcld.man
index 861f1c49..ee6e9dcf 100644
--- a/utils/nfsdcld/nfsdcld.man
+++ b/utils/nfsdcld/nfsdcld.man
@@ -198,7 +198,7 @@ initialize client tracking in the following order:  First, the \fBnfsdcld\fR upc
 the \fBnfsdcltrack\fR usermodehelper upcall.  Finally, the legacy client tracking.
 .PP
 This daemon should be run as root, as the pipe that it uses to communicate
-with the kernel is only accessable by root. The daemon however does drop all
+with the kernel is only accessible by root. The daemon however does drop all
 superuser capabilities after starting. Because of this, the \fIstoragedir\fR
 should be owned by root, and be readable and writable by owner.
 .PP
diff --git a/utils/nfsdcltrack/nfsdcltrack.man b/utils/nfsdcltrack/nfsdcltrack.man
index cc24b7a2..3905ba46 100644
--- a/utils/nfsdcltrack/nfsdcltrack.man
+++ b/utils/nfsdcltrack/nfsdcltrack.man
@@ -80,7 +80,7 @@ section.  For example:
 .br
   storagedir = /shared/nfs/nfsdcltrack
 .in -5
-Debuging to syslog can also be enabled by setting "debug = 1" in this file.
+Debugging to syslog can also be enabled by setting "debug = 1" in this file.
 .SH "LEGACY TRANSITION MECHANISM"
 .IX Header "LEGACY TRANSITION MECHANISM"
 The Linux kernel NFSv4 server has historically tracked this information
-- 
2.42.0


