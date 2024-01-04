Return-Path: <linux-nfs+bounces-920-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD3823D65
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 09:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28541F24AB5
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB96420307;
	Thu,  4 Jan 2024 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svario.it header.i=@svario.it header.b="H4w083Z5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B61EB2F
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svario.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svario.it
Received: from localhost.localdomain (dynamic-093-132-037-253.93.132.pool.telefonica.de [93.132.37.253])
	by mail.svario.it (Postfix) with ESMTPSA id 0FF4CDF79E;
	Thu,  4 Jan 2024 09:26:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1704356781; bh=agDXO7kBLj4MFRDmgaKtfyN7DWPjCr3tPnMZD+GWBsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H4w083Z5tFe1hmPNMM8/dvVwz6wAj77DE+XUZ0kZiQFwBP5OFL36GRIxdpu6vwKyc
	 po0K06khoBtKPu4TSfZ9YFvWFTIU9xX89BX4bmSS5NxAGs1N4XsSElKJ7ON+zqO7Hn
	 scu+WrddsozrIXZzb7++m6KpO6A57k++eMnTYO0/kNOg7mmIiWKZiM6PXIkLlcHsEO
	 2Pg3wAIhFCNY5Ar5giQRDA/zIMDc2YKNdMf3o2ZxMG9KAlC8yBRfgMBV/pdxB2+uqw
	 nVTRuQpa69CY+JN7oPjDqhu32VrDrFZhzR3/FkUwmRVoXby3UuiTUgNXbBZ8uKvMlX
	 Un7pubILeqD0Q==
From: Gioele Barabucci <gioele@svario.it>
To: linux-nfs@vger.kernel.org
Cc: Steve Dickson <steved@redhat.com>,
	Gioele Barabucci <gioele@svario.it>
Subject: [PATCH v2 3/3] systemd: Add Documentation= option to service units
Date: Thu,  4 Jan 2024 09:25:28 +0100
Message-ID: <20240104082528.1425699-4-gioele@svario.it>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104082528.1425699-1-gioele@svario.it>
References: <20240104082528.1425699-1-gioele@svario.it>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Gioele Barabucci <gioele@svario.it>
---
 systemd/nfs-blkmap.service       | 1 +
 systemd/nfs-idmapd.service       | 1 +
 systemd/nfs-mountd.service       | 1 +
 systemd/nfs-server.service       | 1 +
 systemd/nfsdcld.service          | 1 +
 systemd/rpc-gssd.service.in      | 1 +
 systemd/rpc-statd-notify.service | 1 +
 systemd/rpc-statd.service        | 1 +
 systemd/rpc-svcgssd.service      | 1 +
 9 files changed, 9 insertions(+)

diff --git a/systemd/nfs-blkmap.service b/systemd/nfs-blkmap.service
index 6aa45ba1..57181632 100644
--- a/systemd/nfs-blkmap.service
+++ b/systemd/nfs-blkmap.service
@@ -1,5 +1,6 @@
 [Unit]
 Description=pNFS block layout mapping daemon
+Documentation=man:blkmapd(8)
 DefaultDependencies=no
 Conflicts=umount.target
 After=rpc_pipefs.target
diff --git a/systemd/nfs-idmapd.service b/systemd/nfs-idmapd.service
index 198ca87c..d820f10c 100644
--- a/systemd/nfs-idmapd.service
+++ b/systemd/nfs-idmapd.service
@@ -1,5 +1,6 @@
 [Unit]
 Description=NFSv4 ID-name mapping service
+Documentation=man:idmapd(8)
 DefaultDependencies=no
 Requires=rpc_pipefs.target
 After=rpc_pipefs.target local-fs.target network-online.target
diff --git a/systemd/nfs-mountd.service b/systemd/nfs-mountd.service
index e8ece533..4618fab1 100644
--- a/systemd/nfs-mountd.service
+++ b/systemd/nfs-mountd.service
@@ -1,5 +1,6 @@
 [Unit]
 Description=NFS Mount Daemon
+Documentation=man:rpc.mountd(8)
 DefaultDependencies=no
 Requires=proc-fs-nfsd.mount
 Wants=network-online.target
diff --git a/systemd/nfs-server.service b/systemd/nfs-server.service
index 2cdd7868..ac17d528 100644
--- a/systemd/nfs-server.service
+++ b/systemd/nfs-server.service
@@ -1,5 +1,6 @@
 [Unit]
 Description=NFS server and services
+Documentation=man:rpc.nfsd(8) man:exportfs(8)
 DefaultDependencies=no
 Requires=network.target proc-fs-nfsd.mount
 Requires=nfs-mountd.service
diff --git a/systemd/nfsdcld.service b/systemd/nfsdcld.service
index a32d2430..3ced5658 100644
--- a/systemd/nfsdcld.service
+++ b/systemd/nfsdcld.service
@@ -1,5 +1,6 @@
 [Unit]
 Description=NFSv4 Client Tracking Daemon
+Documentation=man:nfsdcld(8)
 DefaultDependencies=no
 Conflicts=umount.target
 Requires=rpc_pipefs.target proc-fs-nfsd.mount
diff --git a/systemd/rpc-gssd.service.in b/systemd/rpc-gssd.service.in
index 6807db35..38382ed3 100644
--- a/systemd/rpc-gssd.service.in
+++ b/systemd/rpc-gssd.service.in
@@ -1,5 +1,6 @@
 [Unit]
 Description=RPC security service for NFS client and server
+Documentation=man:rpc.gssd(8)
 DefaultDependencies=no
 Conflicts=umount.target
 Requires=rpc_pipefs.target
diff --git a/systemd/rpc-statd-notify.service b/systemd/rpc-statd-notify.service
index aad4c0d2..962f18b2 100644
--- a/systemd/rpc-statd-notify.service
+++ b/systemd/rpc-statd-notify.service
@@ -1,5 +1,6 @@
 [Unit]
 Description=Notify NFS peers of a restart
+Documentation=man:sm-notify(8) man:rpc.statd(8)
 DefaultDependencies=no
 Wants=network-online.target
 After=local-fs.target network-online.target nss-lookup.target
diff --git a/systemd/rpc-statd.service b/systemd/rpc-statd.service
index 392750da..660ed861 100644
--- a/systemd/rpc-statd.service
+++ b/systemd/rpc-statd.service
@@ -1,5 +1,6 @@
 [Unit]
 Description=NFS status monitor for NFSv2/3 locking.
+Documentation=man:rpc.statd(8)
 DefaultDependencies=no
 Conflicts=umount.target
 Requires=nss-lookup.target rpcbind.socket
diff --git a/systemd/rpc-svcgssd.service b/systemd/rpc-svcgssd.service
index cb2bcd4f..401fba11 100644
--- a/systemd/rpc-svcgssd.service
+++ b/systemd/rpc-svcgssd.service
@@ -1,5 +1,6 @@
 [Unit]
 Description=RPC security service for NFS server
+Documentation=man:rpc.svcgssd(8)
 DefaultDependencies=no
 After=local-fs.target
 PartOf=nfs-server.service
-- 
2.43.0


