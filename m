Return-Path: <linux-nfs+bounces-678-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90051816007
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Dec 2023 15:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B82628125F
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Dec 2023 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0876F44C65;
	Sun, 17 Dec 2023 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svario.it header.i=@svario.it header.b="WUC97PYx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C72044C7D
	for <linux-nfs@vger.kernel.org>; Sun, 17 Dec 2023 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svario.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svario.it
Received: from localhost.localdomain (dynamic-093-133-078-169.93.133.pool.telefonica.de [93.133.78.169])
	by mail.svario.it (Postfix) with ESMTPSA id F0792DE2B7;
	Sun, 17 Dec 2023 15:56:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1702825002; bh=XZYePS7JfSvkwjuXpnphG12TabeU8njK3rD0GiM4x1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WUC97PYxqcHIlzV31UNxT0CdzNhmeAIZZySvOkXVJQdicitn2zByd8IZYQnc5FUFy
	 kEpVBX0JxSiTb35H22JkCvLomhyyg/lmFQThyKloMR4MP6A3qU4xA7dsQwxvn3ai27
	 rTxwo5T5Dp2Wj16aX6XT1d7UcB9liPiUFPxpf2zUlhzU85Y75ghnSTiV0lPGnU1cKv
	 39A0sVY6Yurdwm74LusdMESSGDf9TAjlEHKVyq1RseMO3WTuF9jLzxUreyP690NFGU
	 D9zEAy1aOc2iQX1+tPoNCYk0AbVDUWfeKUeso3t+btFr/9QpKS2m8T0goZParLg6z+
	 iSPpBaxJEm3/A==
From: Gioele Barabucci <gioele@svario.it>
To: linux-nfs@vger.kernel.org
Cc: Steve Dickson <steved@redhat.com>,
	Gioele Barabucci <gioele@svario.it>
Subject: [PATCH 1/3] Fix typos in error messages
Date: Sun, 17 Dec 2023 15:55:37 +0100
Message-ID: <20231217145539.1380837-2-gioele@svario.it>
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
 support/export/export.c      | 2 +-
 support/export/v4root.c      | 2 +-
 utils/mount/mount_libmount.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/support/export/export.c b/support/export/export.c
index 100912cb..2c8c3335 100644
--- a/support/export/export.c
+++ b/support/export/export.c
@@ -140,7 +140,7 @@ export_read(char *fname, int ignore_hosts)
 					continue;
 
 				if (exp->m_export.e_flags & NFSEXP_FSID) {
-					xlog(L_ERROR, "When a reexport= option is present no manully assigned numerical fsid= options are allowed");
+					xlog(L_ERROR, "When a reexport= option is present no manually assigned numerical fsid= options are allowed");
 					return -1;
 				}
 			}
diff --git a/support/export/v4root.c b/support/export/v4root.c
index 03805dcb..c3b17a55 100644
--- a/support/export/v4root.c
+++ b/support/export/v4root.c
@@ -137,7 +137,7 @@ v4root_support(void)
 	if (!warned) {
 		xlog(L_WARNING, "Kernel does not have pseudo root support.");
 		xlog(L_WARNING, "NFS v4 mounts will be disabled unless fsid=0");
-		xlog(L_WARNING, "is specfied in /etc/exports file.");
+		xlog(L_WARNING, "is specified in /etc/exports file.");
 		warned++;
 	}
 	return 0;
diff --git a/utils/mount/mount_libmount.c b/utils/mount/mount_libmount.c
index aa4ac5c3..fd6cb2cb 100644
--- a/utils/mount/mount_libmount.c
+++ b/utils/mount/mount_libmount.c
@@ -442,7 +442,7 @@ int main(int argc, char *argv[])
 	mnt_init_debug(0);
 	cxt = mnt_new_context();
 	if (!cxt) {
-		nfs_error(_("Can't initilize libmount: %s"),
+		nfs_error(_("Can't initialize libmount: %s"),
 					strerror(errno));
 		rc = EX_FAIL;
 		goto done;
-- 
2.42.0


