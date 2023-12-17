Return-Path: <linux-nfs+bounces-679-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A76C816009
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Dec 2023 15:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 491F5B2269A
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Dec 2023 14:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F3344C77;
	Sun, 17 Dec 2023 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svario.it header.i=@svario.it header.b="mDzp0n88"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7CD44C7E
	for <linux-nfs@vger.kernel.org>; Sun, 17 Dec 2023 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svario.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svario.it
Received: from localhost.localdomain (dynamic-093-133-078-169.93.133.pool.telefonica.de [93.133.78.169])
	by mail.svario.it (Postfix) with ESMTPSA id 6CB38DEDA3;
	Sun, 17 Dec 2023 15:56:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1702825002; bh=pkCeLYOwM238t/LSezjOUDc/b73l5grGmhSZYVmp/AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mDzp0n88+VsgarNHfLFpef4FgQuCtzJjoxONtmj5vgBegxSTsrpwlpjdssAm6GG+3
	 QAMm/4sMV2j1oBYhHX4dEt1+gIPMiWpzzfgKk1xrfp1AoUD5iRoBsdh/bC2ecbg2TQ
	 cuRDKV9Y4osQVxESab0DWYu18luYBy3mU46yA5T6XFMya9U+eLH2iSeHgawFMPSyds
	 chn70LkH4fdKyzF6xCt/q+Cz5186VZe9wPZjoqHMstT9NM5rSQSTyRZJV+DiXt1XMN
	 JvGCSr+FtjF46WyW14FOpNWHhWsZ78zwcWThA1lg728RFnxVgxvs0Idyyt9hzOi26U
	 I65cwYrhI8CTw==
From: Gioele Barabucci <gioele@svario.it>
To: linux-nfs@vger.kernel.org
Cc: Steve Dickson <steved@redhat.com>,
	Gioele Barabucci <gioele@svario.it>
Subject: [PATCH 3/3] systemd: Add Documentation= option to service units
Date: Sun, 17 Dec 2023 15:55:39 +0100
Message-ID: <20231217145539.1380837-4-gioele@svario.it>
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
2.42.0


