Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FDA2DBF4A
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Dec 2020 12:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgLPLU3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Dec 2020 06:20:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42686 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLPLU3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Dec 2020 06:20:29 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kpUqQ-0002oR-2i; Wed, 16 Dec 2020 11:19:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: fix spelling mistake in Kconfig "accesible" -> "accessible"
Date:   Wed, 16 Dec 2020 11:19:45 +0000
Message-Id: <20201216111945.11014-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a few spelling mistakes in the Kconfig help text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/nfsd/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index dbbc583d6273..1d70a23fc002 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -97,7 +97,7 @@ config NFSD_BLOCKLAYOUT
 	help
 	  This option enables support for the exporting pNFS block layouts
 	  in the kernel's NFS server. The pNFS block layout enables NFS
-	  clients to directly perform I/O to block devices accesible to both
+	  clients to directly perform I/O to block devices accessible to both
 	  the server and the clients.  See RFC 5663 for more details.
 
 	  If unsure, say N.
@@ -111,7 +111,7 @@ config NFSD_SCSILAYOUT
 	help
 	  This option enables support for the exporting pNFS SCSI layouts
 	  in the kernel's NFS server. The pNFS SCSI layout enables NFS
-	  clients to directly perform I/O to SCSI devices accesible to both
+	  clients to directly perform I/O to SCSI devices accessible to both
 	  the server and the clients.  See draft-ietf-nfsv4-scsi-layout for
 	  more details.
 
@@ -125,7 +125,7 @@ config NFSD_FLEXFILELAYOUT
 	  This option enables support for the exporting pNFS Flex File
 	  layouts in the kernel's NFS server. The pNFS Flex File  layout
 	  enables NFS clients to directly perform I/O to NFSv3 devices
-	  accesible to both the server and the clients.  See
+	  accessible to both the server and the clients.  See
 	  draft-ietf-nfsv4-flex-files for more details.
 
 	  Warning, this server implements the bare minimum functionality
-- 
2.29.2

