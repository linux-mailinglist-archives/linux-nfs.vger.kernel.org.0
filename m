Return-Path: <linux-nfs+bounces-917-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FBB823D62
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 09:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43DB1F24A0B
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 08:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B7B200CD;
	Thu,  4 Jan 2024 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svario.it header.i=@svario.it header.b="az7ikxVS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49861200DD
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svario.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svario.it
Received: from localhost.localdomain (dynamic-093-132-037-253.93.132.pool.telefonica.de [93.132.37.253])
	by mail.svario.it (Postfix) with ESMTPSA id 28524DF79C;
	Thu,  4 Jan 2024 09:26:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1704356771; bh=nUp2vVf5E9HO1ApbhA0yJ4SB9r/fFtjKZLAR53ijJJ0=;
	h=From:To:Cc:Subject:Date:From;
	b=az7ikxVSN308oLRm8Gy+zZCZiScgYwyb3YYBlv4FJcsbU9Ubcya84C8UEMHFPM+23
	 U6+yUozmQSlYv6CLvKeGlof4rzfDZNNhLPimQVbNYAO3+1/i8jqxYmDLZjPrrIlH0R
	 GkBMSTkF7cU2by9v0xjD6Fttv83gY8G/FlcBfskFtV+RuSnJbuFM+D31lE/4cPZM3c
	 AeENWgx5ra2NgykTkMTjFIEe7CKSAeu5Ea1tojRzfRim+s+3qaiIKbnFiEkD8JOiaG
	 gNpmvLys7yfJXXwwC2TWtbDMTdluMEW9IIFEwlOXQkKGbIRvSPqG7u8cC9VjKhniUV
	 S6Y/U3ehI52RQ==
From: Gioele Barabucci <gioele@svario.it>
To: linux-nfs@vger.kernel.org
Cc: Steve Dickson <steved@redhat.com>,
	Gioele Barabucci <gioele@svario.it>
Subject: [PATCH v2 0/3] Typos and documentation fixes
Date: Thu,  4 Jan 2024 09:25:25 +0100
Message-ID: <20240104082528.1425699-1-gioele@svario.it>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

the following three patches fix a few typos detected by Debian's QA tool
lintian. The last patch also adds Documentation= options to various
service files.

--
v2: rebased on top of 2.7.1-rc3, added S-o-B trailers

Regards, 

Gioele Barabucci (3):
  Fix typos in error messages
  Fix typos in manpages
  systemd: Add Documentation= option to service units

 support/export/export.c           | 2 +-
 support/export/v4root.c           | 2 +-
 systemd/nfs-blkmap.service        | 1 +
 systemd/nfs-idmapd.service        | 1 +
 systemd/nfs-mountd.service        | 1 +
 systemd/nfs-server.service        | 1 +
 systemd/nfsdcld.service           | 1 +
 systemd/rpc-gssd.service.in       | 1 +
 systemd/rpc-statd-notify.service  | 1 +
 systemd/rpc-statd.service         | 1 +
 systemd/rpc-svcgssd.service       | 1 +
 utils/exportfs/exports.man        | 2 +-
 utils/mount/mount_libmount.c      | 2 +-
 utils/mount/nfs.man               | 4 ++--
 utils/mount/nfsmount.conf.man     | 2 +-
 utils/nfsdcld/nfsdcld.man         | 2 +-
 utils/nfsdcltrack/nfsdcltrack.man | 2 +-
 17 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.43.0


