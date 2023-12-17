Return-Path: <linux-nfs+bounces-681-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA143816012
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Dec 2023 16:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67C31C20C53
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Dec 2023 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EBD44C77;
	Sun, 17 Dec 2023 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svario.it header.i=@svario.it header.b="WN2YVfuT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB944C74
	for <linux-nfs@vger.kernel.org>; Sun, 17 Dec 2023 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svario.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svario.it
Received: from localhost.localdomain (dynamic-093-133-078-169.93.133.pool.telefonica.de [93.133.78.169])
	by mail.svario.it (Postfix) with ESMTPSA id C4A4FDE213;
	Sun, 17 Dec 2023 15:56:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1702824993; bh=Z881Z09PSgYg08AHk21M/UMd/LZXUxkGTVBiSHb3SZk=;
	h=From:To:Cc:Subject:Date:From;
	b=WN2YVfuTByO4O4/D1o2HoL+ko/aqCKpn+rXFHzz6qT4Ny2EnXYUYV9Wv+DyExx4HV
	 35EziGci07Qyymr/4bUoVPsmeCr1uHHcMqvOZqccqGMU40DWsUH8E0yNwheYvsdENG
	 Gt+Q102m7S2kTbnh2f4IsNBIQX0zU0sKZOra3CqkWw77vXNDM8b6gBwg7YQg7H4Bc1
	 em4nf1sD8ZbwWVH3PMxLijb1v367mLpX9Nj82mtRjdxRy65hKCYTZQO+6hSgbiYV6x
	 2lXkX8UDce8nePLuw7rmsWvLOyzQY31PcQWfNV494X4VQJJH9IPeDaVeeZq6Mu0yCZ
	 IEBE7adtJPszQ==
From: Gioele Barabucci <gioele@svario.it>
To: linux-nfs@vger.kernel.org
Cc: Steve Dickson <steved@redhat.com>,
	Gioele Barabucci <gioele@svario.it>
Subject: [PATCH 0/3] Typos and documentation fixes
Date: Sun, 17 Dec 2023 15:55:36 +0100
Message-ID: <20231217145539.1380837-1-gioele@svario.it>
X-Mailer: git-send-email 2.42.0
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
2.42.0


