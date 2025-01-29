Return-Path: <linux-nfs+bounces-9747-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0987A21EA2
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 15:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477BF18898B7
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E511E883E;
	Wed, 29 Jan 2025 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP73R/0n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84641E8837;
	Wed, 29 Jan 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159410; cv=none; b=f/Zy7rAZFQGCEXAnjgxib4tikm41swbG79IvalVfAvutGPhLSiRD5Ipw2z4uqEsN6tQQJI54TB7vNiAyH0gxr7cnORVzxTDzNOZ0GpO3PXwXOwvlN/mANQMfTb7lv43s8rcNwggEUu7dzfAOsTH03vxBUMX2qSc8HpIRCNWyaN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159410; c=relaxed/simple;
	bh=19AYU4SSbPjPQC7+XNZ1MQH3GXYQCjOF4g6ErrSsPeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MsInuWAHARMRbNsLSIK6CxrhXWRmd9z77/+vK8Kk7GJYHGZE9fvOKLZcKkPc/Aw1e3WlQfR+hDMVdPiak8lJZZ8e5YejhWqMP604E/Tzk0eOXSLWY3Yw+Q0lv6tCDv0Ap/SRcAK9aQvzvzvQgOD9E5STKRBmElcLHdpni0boje8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP73R/0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46385C4CED1;
	Wed, 29 Jan 2025 14:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159409;
	bh=19AYU4SSbPjPQC7+XNZ1MQH3GXYQCjOF4g6ErrSsPeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kP73R/0nT8xRk38nDrDXZMhiaSHPvW+R4+TCvERibMKU2Hz7zStFRzTxrfe/6WfeL
	 AdU0WiJGCiPDCPpVJFUVrnMBBSZZ5O+XgrvkThpTFWObhJ/C29gdzt9vzyR59uXw5j
	 VOvNxPwIBQrzwNLhpfrIXUIzSkwZLFzKH86VxV9Zld5CWjsA1w9Jhhzs/lEZQt7EG1
	 tCiEKCTmJjZqo3abSvA6V8HHeG0DFk6orYgLMKYCWGPiJ9Mw+fl903wsiT57e20Z3m
	 8O17M9UgL8cZEQ4+1j4WeSeIZch55Apy4T5ecKzhX82cBPYXe+F1mNitjsiC1jzSW+
	 jUeR/VXgyrhEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zichen Xie <zichenxie0106@gmail.com>,
	Benjamin Coddington <bcodding@redhat.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 6/8] NFS: Fix potential buffer overflowin nfs_sysfs_link_rpc_client()
Date: Wed, 29 Jan 2025 07:59:26 -0500
Message-Id: <20250129125930.1273051-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129125930.1273051-1-sashal@kernel.org>
References: <20250129125930.1273051-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Zichen Xie <zichenxie0106@gmail.com>

[ Upstream commit 49fd4e34751e90e6df009b70cd0659dc839e7ca8 ]

name is char[64] where the size of clnt->cl_program->name remains
unknown. Invoking strcat() directly will also lead to potential buffer
overflow. Change them to strscpy() and strncat() to fix potential
issues.

Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index bf378ecd5d9fd..7b59a40d40c06 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -280,9 +280,9 @@ void nfs_sysfs_link_rpc_client(struct nfs_server *server,
 	char name[RPC_CLIENT_NAME_SIZE];
 	int ret;
 
-	strcpy(name, clnt->cl_program->name);
-	strcat(name, uniq ? uniq : "");
-	strcat(name, "_client");
+	strscpy(name, clnt->cl_program->name, sizeof(name));
+	strncat(name, uniq ? uniq : "", sizeof(name) - strlen(name) - 1);
+	strncat(name, "_client", sizeof(name) - strlen(name) - 1);
 
 	ret = sysfs_create_link_nowarn(&server->kobj,
 						&clnt->cl_sysfs->kobject, name);
-- 
2.39.5


