Return-Path: <linux-nfs+bounces-3008-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051C98B29E9
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 22:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1807AB22039
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 20:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CB83AC0C;
	Thu, 25 Apr 2024 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8jiSkUN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C159A18EAB
	for <linux-nfs@vger.kernel.org>; Thu, 25 Apr 2024 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077281; cv=none; b=f7w/vW0Nb0Agss5V7okG6QuGZUhNlAXxoma1KXLb/eRGQws1DLSac/kdu1nJPhd4M26116B1OipWiKP7UXYhQTLmPkVlg9xLbsWonPRGtGRRolX3BD+zQsAYbXGn57BiAwSq6X2Q3vAeUbFIAxu0ZpzXd9qmbP3LbWzJ8egZYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077281; c=relaxed/simple;
	bh=vfuw6iqcs9M+nkHed+CT/H30rIurPUj0/QjcIzVg47o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFPutlS8k+fOhzjCqO8nWueMD2hTk2zg4dqO8XLcTre2kGY1ORHYhkck/nxhF0PHBSSvniGechnT7hMKSgcnG/I9b5ceUOiCqQMUgKNY4oCk6a2qYyeiZLzPaOI5R33MrYiKjYngxUxG16E+bdNTcFJi/9dPUNv5BLfEV8r62fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8jiSkUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403F6C113CC;
	Thu, 25 Apr 2024 20:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714077281;
	bh=vfuw6iqcs9M+nkHed+CT/H30rIurPUj0/QjcIzVg47o=;
	h=From:To:Cc:Subject:Date:From;
	b=p8jiSkUN7XXcTqAjWw/P6/cqEQ9FD4QL/eQ4dCcwOFqqRpqPyzi7y8/6zE53qKobo
	 1WmbyiWKY3Ypann3Mj8+ryIAeT+3gnzFGfAxu0zy1X8luYawB58ldrDThvHrLf1K7s
	 Ofh59J1WyTgQZ9XgIyA1O4LnkOkdmJUgO71lT8tvAlbK8xmCKC+2SF+w3nfuphTX8g
	 A2eNKO+8nO30CaFpH9ZIqFWVJ6o2S0yiawh4wIx096dGZNCaI+7jScOHJX3den5/hU
	 kckwC5D4etZKF9qEhyPpyVpFrsgaGCoE8N1a4nwqa1ArHPPq3noL7OlLqW1/XZZN/a
	 iO7SLR4ZYSHXQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH] NFS: Don't enable NFS v2 by default
Date: Thu, 25 Apr 2024 16:34:40 -0400
Message-ID: <20240425203440.440780-1-anna@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This came up during one of the Bake-a-thon discussions. NFS v2 support
was dropped from nfs-utils/mount.nfs in December 2021. Let's turn it
off by default in the kernel too, since this means there isn't a way
to mount and test it.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index f7e32d76e34d..57249f040dfc 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -33,12 +33,12 @@ config NFS_FS
 config NFS_V2
 	tristate "NFS client support for NFS version 2"
 	depends on NFS_FS
-	default y
+	default n
 	help
 	  This option enables support for version 2 of the NFS protocol
 	  (RFC 1094) in the kernel's NFS client.
 
-	  If unsure, say Y.
+	  If unsure, say N.
 
 config NFS_V3
 	tristate "NFS client support for NFS version 3"
-- 
2.44.0


