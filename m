Return-Path: <linux-nfs+bounces-918-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EE2823D63
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 09:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619271F24A27
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 08:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023912030C;
	Thu,  4 Jan 2024 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svario.it header.i=@svario.it header.b="fPOGSsa5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5987020300
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svario.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svario.it
Received: from localhost.localdomain (dynamic-093-132-037-253.93.132.pool.telefonica.de [93.132.37.253])
	by mail.svario.it (Postfix) with ESMTPSA id 8F369DF79C;
	Thu,  4 Jan 2024 09:26:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1704356780; bh=u6d+d7z6/zrbtKhSlLdejqmTx7v0f5stcp0hkHx7eI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fPOGSsa5R5SzSLA2+sqE1eCfxcS8iYJbJ3zF7QBUEkvg+U13qAYsgvyHVSnKKajTT
	 tQ4Dl83ay3vlsf40ZKuvNxOUCbEVxqqDDyJg8xlwZ99657yhvvKhfT/jzKSgfkhNur
	 FlpOpJ+m/vmTNgQuFYC0nIyrdPU1CYAJk5HAs1G7lioKIu0H9h0MMZ+7GLqLuIeBw9
	 1yqYDWuzfuKNVvXqcyph/8jO7aZo6yq3Lj28fFRNxKBWo3dZAnob53nfwCuOhBrgkR
	 fHp/N4jtKMpWfssEviS3l2qpX2ASFVMMZS3bMcIv9vKTZRxYSRj+ptnerNTVdXvelG
	 OYJy72PwUphxg==
From: Gioele Barabucci <gioele@svario.it>
To: linux-nfs@vger.kernel.org
Cc: Steve Dickson <steved@redhat.com>,
	Gioele Barabucci <gioele@svario.it>
Subject: [PATCH v2 1/3] Fix typos in error messages
Date: Thu,  4 Jan 2024 09:25:26 +0100
Message-ID: <20240104082528.1425699-2-gioele@svario.it>
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
2.43.0


