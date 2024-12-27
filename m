Return-Path: <linux-nfs+bounces-8808-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516CD9FD772
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 20:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A64A1880461
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 19:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8AB1DD525;
	Fri, 27 Dec 2024 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="JWHPav/L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004F5433D9;
	Fri, 27 Dec 2024 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735327091; cv=none; b=svEI5+A5Q4+W57Bz3eiMaIWA5WLfUbF8jrD+FWwaOXs792MeHv80cHjrgfaWTLafFMqLdSdxMzRnQr2W8PYemI6GEp1irlOy+ZLMCZtE0i9k+GaD7n0BEmxPNWPJMpp/O6tUNAJPNWG8BrgKIMFbNN/LYQFo87BZ4sLyl161Dow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735327091; c=relaxed/simple;
	bh=+5VkRUPQNNxI7PB2kQvTcGLW9ZabD9FR368mm5St2bo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AOWXk75asGpouIgwHtAQ4pc4b22ZconR+BzGqhhjL4L6oHCdgDHSfVFUrzVyHzJvWkzLipaVVHCb0X2aqF9ZE06t8OKrxbg99xG3Ss/jDXKoFVeB1x7UDuAEK4P21xQd9j5ZU3lxhtbNmtcJ1yHNqSRNDVmLxq5abi2nf5qT7I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=JWHPav/L; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1735327086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+tI9IaR8j0Yh3ldwm8YLrHNIwIU+o5zOLZk+zEBzhSs=;
	b=JWHPav/LtLZaFlFKjshHxPcds+zu2AihQHH8uOxjZqJvteoJrCLAkinGRwSiczhrCvrpae
	t0mWyplDkQNiNvrztTsPZ9GDDTJFwm0YrfsfkZ+WDz0H7IsP+R6ZD3yQ0+XmxvkwqOhcA/
	F6yVzVTRSrfu0xfrI+dMhdcEFTUmOQU+7/W9IATK5mvSvWo6+kgIZpMSR6EV5CkXZu2GT7
	83JEDihlpEBQ5BsheKd2ec3P2xVban2rsJ7IeG4Tevbt5uhhRw3gL+Zt2fEKmfc3SGUqrw
	0ZN1EjUl09qmOgzGTrRRWnhaLdz5q/B02izxvuBx1M8j9NRQk4+CUCc19hsxRQ==
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dsimic@manjaro.org,
	stable@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] nfs: Make NFS_FSCACHE select NETFS_SUPPORT instead of depending on it
Date: Fri, 27 Dec 2024 20:17:58 +0100
Message-Id: <4faf55b5022a9e363e3cad791144064636ed0eba.1735326877.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Having the NFS_FSCACHE option depend on the NETFS_SUPPORT options makes
selecting NFS_FSCACHE impossible unless another option that additionally
selects NETFS_SUPPORT is already selected.

As a result, for example, being able to reach and select the NFS_FSCACHE
option requires the CEPH_FS or CIFS option to be selected beforehand, which
obviously doesn't make much sense.

Let's correct this by making the NFS_FSCACHE option actually select the
NETFS_SUPPORT option, instead of depending on it.

Fixes: 915cd30cdea8 ("netfs, fscache: Combine fscache with netfs")
Cc: stable@vger.kernel.org
Reported-by: Diederik de Haas <didi.debian@cknow.org>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 fs/nfs/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 0eb20012792f..d3f76101ad4b 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -170,7 +170,8 @@ config ROOT_NFS
 
 config NFS_FSCACHE
 	bool "Provide NFS client caching support"
-	depends on NFS_FS=m && NETFS_SUPPORT || NFS_FS=y && NETFS_SUPPORT=y
+	depends on NFS_FS
+	select NETFS_SUPPORT
 	select FSCACHE
 	help
 	  Say Y here if you want NFS data to be cached locally on disc through

