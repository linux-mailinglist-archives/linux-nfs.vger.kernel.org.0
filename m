Return-Path: <linux-nfs+bounces-3479-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC5B8D3EFE
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 21:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6741C214EB
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 19:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B561C0DEA;
	Wed, 29 May 2024 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1D62Utt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5060116DEBD
	for <linux-nfs@vger.kernel.org>; Wed, 29 May 2024 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717011879; cv=none; b=I5icMzJci3rf/8FVZa2aui+kwD+ehWuT+W0xhFfbclQstOL8Pg46IR/jLvd9t4csxQfcfGlZCY1xHmEKcHOvfI0IdxwzMM0AE3DxZ78Yr8ixe51LDNXlV5nJmny1POKPJZX3s5C5oaZj9jl9rP5vzztkmPs1YIdxtzAXyoETw0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717011879; c=relaxed/simple;
	bh=Xsr6npK3LLrAJ64O8esG/t4X0vCFrSDLIzgLXIEnXS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T/PBPLlI6bNA73LiqXEBuv1TCYRF87jBHyResrd6ym0YJUtzVKFWhr20INDqP4iZ5L5cxbGJG1wVe+grc5xR8zUm+sgbYNXqEgBXXCwenRngbA3fDTHhYzHb+WYxDxGRt2M/la8+ljTyZb1C2pYlIcUYC29Nz31ScJunPmI+TiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1D62Utt; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7e22af6fed5so461039f.2
        for <linux-nfs@vger.kernel.org>; Wed, 29 May 2024 12:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717011877; x=1717616677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkgDX1lR/XOOjMbByQT44U7+jhej0AB+ERM76QpvIXQ=;
        b=F1D62UttW56ugyG2RsQugMt28WWwnlvJAPr6TEv66UHIp4fItKcZyAnWS3hdvEWOA3
         sxOqeWB8wJq6mJc4OZQfulMtpBe/1EGmyCe/xAAoeCsyrCpiZYR6hBgZMAxRAs3baxPN
         oUyNS0L/PZnIB0RijrEt/CMjwBPqRPZUKNwz26ScGkTQcJSq+hZnFjWUs2q0acIz2jDM
         78P5fIyGhnKCvOXcIsHf38YDPBOPwAIMhU++kozyZrqzNlgZocI4UhzK5Z5x7HgsQbYY
         LtXP6DcKH1Zm3eoNJIRTCdx0ZG+Uvu6h1D1sWSMAZVmr3bJEjpmmxaroZQPL2XqligyW
         xp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717011877; x=1717616677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkgDX1lR/XOOjMbByQT44U7+jhej0AB+ERM76QpvIXQ=;
        b=Tunn7Sl9o+NII+SoivGvkTUY+Sdgq1CvWQfxzV4ie9VyW3iKl1ObteEqP10p7m9BmI
         3dG1b6gTJ3ofByvbodz+lpyTo3e2wAuxbbPsBr36MZtiCv+DBauJ7N1sNnyQoC358QyD
         6Yfe5SyME++g/fiw14PxsU7QVR0GYAVWZNOS06H7p0NEdbbLAvESUz5wd51i+Dtk6fPm
         Tjo5qdc7YnNZedVOZX/JBnOeQzCRIqpt5VI0v8Mdsiox7yKoYvSutPStVuRADMDxHXzy
         Yw338np0PhmXaZKCMHFXfBDXSWVPUQZeJKD/drge5Npc9OXrN23vlpYncPopuAP7T0ZD
         2yUw==
X-Gm-Message-State: AOJu0YwfmGkUkhVehTC0q5bsAgMp/MNAB4GwxAcGmCuEu1Vx4hZ535KX
	uonJAaZOryotxsSSLU5XAzw21chXIMUP9jP67Dr56jyVAB0wxbwu3edd+Q==
X-Google-Smtp-Source: AGHT+IH2EHZeAbphbIUfQUyFF9nGwoVXeue9Hv/a7saN1FGIq60eUriEYVjiehEz4sJWAaTZ2sodMw==
X-Received: by 2002:a05:6e02:1563:b0:36d:cdc1:d76c with SMTP id e9e14a558f8ab-3737b16fac0mr188732425ab.0.1717011877104;
        Wed, 29 May 2024 12:44:37 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:4931:c263:51e2:4f56])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3737c32ed33sm25585625ab.60.2024.05.29.12.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 12:44:36 -0700 (PDT)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1 enforce rootpath check in fs_location query
Date: Wed, 29 May 2024 15:44:35 -0400
Message-Id: <20240529194435.12126-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

In commit 4ca9f31a2be66 ("NFSv4.1 test and add 4.1 trunking transport"),
we introduce the ability to query the NFS server for possible trunking
locations of the existing filesystem. However, we never checked the
returned file system path for these alternative locations. According
to the RFC, the server can say that the filesystem currently known
under "fs_root" of fs_location also resides under these server
locations under the following "rootpath" pathname. The client cannot
handle trunking a filesystem that reside under different location
under different paths other than what the main path is. This patch
enforces the check that fs_root path and rootpath path in fs_location
reply is the same.

Fixes: 4ca9f31a2be6 ("NFSv4.1 test and add 4.1 trunking transport")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 94c07875aa3f..a691fa10b3e9 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4023,6 +4023,23 @@ static void test_fs_location_for_trunking(struct nfs4_fs_location *location,
 	}
 }
 
+static bool _is_same_nfs4_pathname(struct nfs4_pathname *path1,
+				   struct nfs4_pathname *path2)
+{
+	int i;
+
+	if (path1->ncomponents != path2->ncomponents)
+		return false;
+	for (i = 0; i < path1->ncomponents; i++) {
+		if (path1->components[i].len != path2->components[i].len)
+			return false;
+		if (memcmp(path1->components[i].data, path2->components[i].data,
+				path1->components[i].len))
+			return false;
+	}
+	return true;
+}
+
 static int _nfs4_discover_trunking(struct nfs_server *server,
 				   struct nfs_fh *fhandle)
 {
@@ -4056,9 +4073,13 @@ static int _nfs4_discover_trunking(struct nfs_server *server,
 	if (status)
 		goto out_free_3;
 
-	for (i = 0; i < locations->nlocations; i++)
+	for (i = 0; i < locations->nlocations; i++) {
+		if (!_is_same_nfs4_pathname(&locations->fs_path,
+					&locations->locations[i].rootpath))
+			continue;
 		test_fs_location_for_trunking(&locations->locations[i], clp,
 					      server);
+	}
 out_free_3:
 	kfree(locations->fattr);
 out_free_2:
-- 
2.39.1


