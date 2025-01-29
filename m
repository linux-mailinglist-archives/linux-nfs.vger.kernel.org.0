Return-Path: <linux-nfs+bounces-9746-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2614CA21E7E
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 15:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BF03A4A0D
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D281E1A08;
	Wed, 29 Jan 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lif2vhFZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C221E104E;
	Wed, 29 Jan 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159381; cv=none; b=MpwTH48qQShAXTAKIpCB6abb/XWNxMHeHpmhaQrKkc4q7OL3+ABmjwk9vaLFp/4oPZ39lMBlZ14F81xYcE0qWNVkpNu0CarJF0TdkrrOtxmV1TasmqEXLasvvLxrEIp24ojBHF/RigKHBOKU9kU33S4TWZlynO5dA2UYkrnNxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159381; c=relaxed/simple;
	bh=19AYU4SSbPjPQC7+XNZ1MQH3GXYQCjOF4g6ErrSsPeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oah2SrKM4PdTWLYOrSkkfi35qT3gjOM8FGlU7XneMSu4R5QZNp+Es4sIAkLAYrXAGskGXntzc37E2nmmrABlj/r3+OYnMER/OcgRUV75x0Hrc327l9KMX5w3OMwr1CZwmFOISMp4x7z9/d0+opFfy4KztjclMuoHC4NUuLh5WaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lif2vhFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68750C4CED1;
	Wed, 29 Jan 2025 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159381;
	bh=19AYU4SSbPjPQC7+XNZ1MQH3GXYQCjOF4g6ErrSsPeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lif2vhFZ2ct2cpuFgiNg8hZqFn8lzzvhDceAkrp645XeRaPsgyzofyvpOQV6VG65w
	 IHc4GiSChRPvTa7UssADn4V+LGGOKaPG5+Nnk2zopPQqeUP/AFCfC0X+9Ykq7DYEx/
	 uVEt+WJhD/4kfCUYlFA4xtLzHnnqTfreCP7S9KX/m8RFXaAuwaPJIGf+HsU2lgh+1E
	 5v6ZE3ufVow+3qsIORuFV37cG8YvXxTnS7xNd9Gv1dmQsJj7xfMSX0hBSBWPTdu/t4
	 r+MJzQLCp9cnYYF80S71lm5GE6Q+hZHhuRnMQ82GvBWcCCH1sIulrzuyyKm6g1hOh0
	 qlx4wFXG0uicg==
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
Subject: [PATCH AUTOSEL 6.13 6/8] NFS: Fix potential buffer overflowin nfs_sysfs_link_rpc_client()
Date: Wed, 29 Jan 2025 07:58:59 -0500
Message-Id: <20250129125904.1272926-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129125904.1272926-1-sashal@kernel.org>
References: <20250129125904.1272926-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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


