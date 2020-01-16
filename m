Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D84313D940
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 12:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgAPLoY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 06:44:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgAPLoY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Jan 2020 06:44:24 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9B8D207E0;
        Thu, 16 Jan 2020 11:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579175063;
        bh=33EBja95wRnaNleuYy5XxD+LZM5YdUGD5P0ToeNX6gQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pXUPk2wBwNnoNQQ3GzQoZbPwEN8jZRUYYisL5GC74/OverB94Q+4zrzbrdfMcYvMe
         1VXNTotPuLj1/R+gX5W1eT6QpYUvrGQvDKs7ulbVvOg7iCT+Lmos/+vUBTbY8+fven
         EesDo2HbE5YXmPBJM0kdlntHnZX3CTgpM/Jdc1Ho=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable NFS v4.1 and v4.2
Date:   Thu, 16 Jan 2020 12:44:07 +0100
Message-Id: <1579175047-11351-2-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579175047-11351-1-git-send-email-krzk@kernel.org>
References: <1579175047-11351-1-git-send-email-krzk@kernel.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NFS is widely used in debugging and Continuous Integration systems, so
enable the newest versions of protocol: v4.1 and v4.2.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

This happens to fix also troubles with mounting NFS v4 root after but in
commit 6d972518b821 ("NFS: Add fs_context support."):

  mount.nfs4 -o vers=4,nolock 192.168.1.10:/srv/nfs/odroidhc1 /new_root
  [ 24.980839] NFS4: Couldn't follow remote path
  [ 24.986201] NFS: Value for 'minorversion' out of range
  mount.nfs4: Numerical result out of range
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 80373fe0280d..493ba3d3cf1e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1094,6 +1094,8 @@ CONFIG_PSTORE_RAM=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-- 
2.7.4

