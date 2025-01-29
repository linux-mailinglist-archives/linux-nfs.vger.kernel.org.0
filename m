Return-Path: <linux-nfs+bounces-9748-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBC1A21EB2
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 15:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530581883B1C
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F03C1EE03D;
	Wed, 29 Jan 2025 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGyM5kXf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E151EE039;
	Wed, 29 Jan 2025 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159423; cv=none; b=lZ9AMeK3C6F/NUAY/9GlhOH/Deb4r/6KtvjV0NKMEjJrs6l4GJevfQHkx29yzJNsWbZAzGMjH9/GO6xs3nUlFG9axuI7QkZTgA4Ux0/s5RpGe5y+EfS26TFmbQqTmUsls+4n6n0JF6PoAFlAEl1OnDJeaVzWLwlhUxwkTYaj0Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159423; c=relaxed/simple;
	bh=19AYU4SSbPjPQC7+XNZ1MQH3GXYQCjOF4g6ErrSsPeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GRKwSm/qS4CUMOG/7eKxu0/wtogurXDpmpFnQm1bykHHlXWneI9h1q8sK06n0ANUuWxo+dqSH4yAmpMsIxmSecpSJ+guDzT7XMVoNAWfyh6R8s0+nH6oDaBcGdsRbIy2gjiCWYjL1GXuFeAH9cwjZXSrYNlUW5s9i5bGbq8aeVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGyM5kXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3050EC4CED3;
	Wed, 29 Jan 2025 14:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159422;
	bh=19AYU4SSbPjPQC7+XNZ1MQH3GXYQCjOF4g6ErrSsPeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pGyM5kXfeL+73qWM+xrOTC73um30M8YDAZdIE2cgBlB3/P009X8X38LTpHPUYWOxx
	 XrfCgFVUWezoQ/SjDbR3CqBCUlIz6qVCq9YSUucx4/ZH/F5WSUXgyT1kS6UAPpmQYW
	 5WVG+HdNpWAkOFcwIRjIbj/ftzBQ5o1GLbi6ub/8mJhQJiWLDLEse+QAAej8Pe3x6t
	 NoTMDhdZVf2um+hkrj6mJlnc4wV1wiNUiGQcY7mecdijBonJPfwrxCFuRdcsSDsxFC
	 fMWiQE6kwXxOI4QXBBl+bf5JsvX0QGVCvaqKl5r/MfFtYhNrB1lciNUzcbMZu3S22e
	 FkBi4CXxrksBQ==
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
Subject: [PATCH AUTOSEL 6.6 2/2] NFS: Fix potential buffer overflowin nfs_sysfs_link_rpc_client()
Date: Wed, 29 Jan 2025 07:59:55 -0500
Message-Id: <20250129125958.1273172-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129125958.1273172-1-sashal@kernel.org>
References: <20250129125958.1273172-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
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


