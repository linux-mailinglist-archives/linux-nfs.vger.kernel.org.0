Return-Path: <linux-nfs+bounces-7682-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552CC9BDD31
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 03:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C751C22D77
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 02:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9500190079;
	Wed,  6 Nov 2024 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2lXm+lc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFF5190056;
	Wed,  6 Nov 2024 02:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861401; cv=none; b=J/IPBJ1QGxLWzLhRI8mZQOwuuHVludHpn2LZkNGRCXZZ7xJV6q2VOfCQYT6J//iGHkdVyQ+5s1ov+sM6nPj8bhQWaXc9iws7CrrM7tlOCV3A+AQrAq7iub690tG23pLNxltrkCJSH6kFVqV8iYzA+ZxEirdt6A9u/lU176UTGGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861401; c=relaxed/simple;
	bh=WHdYZyKYmj7xiGxF0fx2SDirkvcvGaVZgFNhWTcTcOs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YzUZ3t+rIGiStr2fQA2K5Er3UenTWkg00aTa+6lUDmN+J49tCnzrzoZZkRyDsI5orDxdYTpGPMWP/WjnpqgC7R7wYanO76aXl51NPCY/UCiFj2RPC4ObjvVgYvgSSqTONT1jmeVAFBLr52O3uKh7nEZ7eiFJK+78OD2yiVFqp/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2lXm+lc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso4840121b3a.3;
        Tue, 05 Nov 2024 18:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730861399; x=1731466199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmR98cWU1ulDZaP8dZ+K15F19ez22dKqwVUZTiGwrq8=;
        b=K2lXm+lcZolfh8Pc3JCW36gk1X4LPky8JDVuEo9FdHi7guQuJ0AWoheI+xQ18webSU
         tbU89559CPE4Pqq8a2Wb9TRg7ZvXzJHT1ZuT6GjjX/hM1tG0EWMhDhp4Jzx1C7UEyL/w
         f7C4GYeD58UIvLS24b5fc8YS/l0wcqjeg1zMSJhicKQbj/6hcqhtzqJ9+3g2ewMC0hZy
         45cem7XhM+MNW9y1tV3WsxFihAPIp7C0POI/qy+8ECDeJMZe/01ADdmRgj+Wiey0Oww3
         MSvxAC69AxVpFCkfkKUkP0r/auHJqd0ctULCVMn1CrFUiIncgBlzng4g9AHZYGQ21VvQ
         rn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730861399; x=1731466199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmR98cWU1ulDZaP8dZ+K15F19ez22dKqwVUZTiGwrq8=;
        b=G51RJNWJqwZ3Zh0NJ7UvtZo1pOjKupS8nJUqBxqpWn8UUs/eIW4nbOnxMwFqB1jry4
         pvfcFWa1jgebWUYBrdGOcbpm3j5+lSdHtXQb5Yg7q600TAdLYgnkiBUCErd/HeJ0S2mt
         vmxVdcPfVjJAvgFDHxd+Ig7OTWIyNCtz0nYKunFiwutwa19WmmtlaF36z4is83/v4BKp
         dgw28sYjACrgAk6DHQo4+Mnza3oFMDHR7Z+c3xX532GdZHsn4gpz0uoYDwE8o3MLS9Ag
         HWQzMowbpXQUjdxFMlZHzV8xcYZIwn9+BtzzSIJa/T3uJ55l/9IaPSlrbUqCnlrfVYxA
         WpvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwEzo2SS4rlWc9ghI/0WTba0UlK+IWGsmOdtIp9OdX3ZeGLfa44mKejh0B/iWc/DGkSbSG8g0BLdury1s=@vger.kernel.org, AJvYcCX25GAN8uDdH3rrvRegFOtrhFDuqEeolv4lfQcA11wHNpxZXCIxuLSObL7UKye3Uma3BLACy1U90Fy/@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+72Mxwcr9x7+semQk8cyBJEJQgrKFhtM94VOmzqxOwqZtp9V
	NVTnYpfB2Bsx11CrlG3svMDiuEyw0FMmrjg4a0mKqQhvD5u0rwzp
X-Google-Smtp-Source: AGHT+IH3GWlc3718py/4iMlXY0Kwb/RLZw61xjAAcLiM+WM58X9tyK76osdiPDn69Ez6GqZ051Et1w==
X-Received: by 2002:a05:6a21:32a8:b0:1db:e3a2:eaba with SMTP id adf61e73a8af0-1dbe3a2ec0fmr10227263637.11.1730861398955;
        Tue, 05 Nov 2024 18:49:58 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e99a62bd39sm288547a91.48.2024.11.05.18.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 18:49:58 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org (open list:NFS, SUNRPC, AND LOCKD CLIENTS),
	linux-kernel@vger.kernel.org (open list)
Cc: Daniel Yang <danielyangkang@gmail.com>
Subject: [PATCH] nfs_sysfs_link_rpc_client(): Replace strcpy with strscpy
Date: Tue,  5 Nov 2024 18:49:51 -0800
Message-Id: <20241106024952.494718-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function strcpy is deprecated due to lack of bounds checking. The
recommended replacement is strscpy.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
 fs/nfs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index bf378ecd5..f3d0b2ef9 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -280,7 +280,7 @@ void nfs_sysfs_link_rpc_client(struct nfs_server *server,
 	char name[RPC_CLIENT_NAME_SIZE];
 	int ret;
 
-	strcpy(name, clnt->cl_program->name);
+	strscpy(name, clnt->cl_program->name);
 	strcat(name, uniq ? uniq : "");
 	strcat(name, "_client");
 
-- 
2.39.5


