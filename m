Return-Path: <linux-nfs+bounces-8629-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACFF9F50D7
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 17:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9961730D3
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 16:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4510B1F76DA;
	Tue, 17 Dec 2024 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtPMKi6S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD81D1F7582;
	Tue, 17 Dec 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452009; cv=none; b=UojPDO+FOc7jx6fb0NU0P8Ps8LHz8rBRDaMROcqtZ4VhHW1vk1dCo2kjSboEopFyodVVp84Wp3DPlmTWz3L6XwG9KQobr1Ys3SOHufaqiP5c1wNAsn7eBEuzj7P2HxbZTpHsUkbFDoCNYKzjikqeCsfjm836lLwDmG0zaKSHBRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452009; c=relaxed/simple;
	bh=IKiMlbHKdsAOVicyR7fjBrKL7cu5uBWz9FdHlUHqWrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yj1m7Bg9vlxM7UNCGa8o1MYrw1n11TT0XklkwYoORiedtUbKNxA6ocRym/ZB1HkvbsjSTxY9BL9AgVZuPFnI3koMYJjbKhVmk8O2iMGfdkKiw22EWuFRBFCHyCc7x59W6+UNzDyUbMtXWbgLpUf8yxZ8GhKGnPEBG4BuFlrzh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtPMKi6S; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-725f2f79ed9so4389465b3a.2;
        Tue, 17 Dec 2024 08:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734452007; x=1735056807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kahqqPMSTr9XgU+xN0T1Ws/ewFe4FMQQ8UQQ00n/SUM=;
        b=ZtPMKi6SZGYlbv/By5PXHuplIth7qfwOzSaeNvi64gGVO8F9QLD8xou2D3Cg4uXcnf
         +EmrV0R6O1EdP7MtF5XZoDHhWADuB08CZEnYjEqNiUky07hlbrW9141X3PRHw7SL91Sq
         aCcsip5t3e9JDXyoUMDMFGDYVYn6zBhdoAdJzVzj19pZ+W9cEPS1NdI7t4hxIgPJaPcQ
         m6AJyXh5dbYkW3DCc9FcGf87bAq9tnG2QLdgX7LYniSF1zJBI5LtpJxBh0Lr+KjjuHG1
         auJMKZjeBmXElB46BVOw2UxSzMm3pczTmaCJcrnegB53hkkPxrSEiiFvyHOZEWNNdt2G
         1aTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734452007; x=1735056807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kahqqPMSTr9XgU+xN0T1Ws/ewFe4FMQQ8UQQ00n/SUM=;
        b=dnjeo+r7J/m6E8iIL6+Cz6GTR0+3HnUmXvbiKGyzoKAu6tERyj38IaSw1Su17QXbHR
         a/2mhOPELAAye5P99Q1AMLuw1CJzFAXSV4JNGvIcMdDisvDgEy8qjuwM1jcLREnaK/2n
         YXRpPdWY1Ni2l1PSnhciFCND24Xe2q5YeEyObQflDB3C0yFPGEAvgfQmXpKihau+vSoS
         ud50cVq4ysidpKk/iaDj62ZrRywTqz8YuK5e1g0z2usYsjRKnkXqrc8Re0IcHx45OYoK
         xBAVChVQbNCeV0GE+i1y+/giBcfDPWt4vM820l1SPxSV3VSPDRQV2OVgG6sNhhZLj2H/
         7OJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLMtTKFpqUDRFkFs42U8Mv9DCBaJqz9/9fi6OzBuyrFCUA+Mnxc8bCx+ris5VD52TaAqzvBHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgiFOCm/8f+RlZh8oOPLeen1vG3/fxKI6TY7kLofBBTHVwdj6+
	xiWmqDQ6Hxjz2ElpVxkpAgOX9e4A8y2bNAUf+iAgrODmFUg1pikt
X-Gm-Gg: ASbGnculVDVjHQTstWXMTHO+gzoN+OAgYb5zA93QGRs1LW4cKkPm65BCMA27ukdKRkQ
	zpsrso6lMjZivi0LZUTYWdQ4qar69XnzU1RWKvmt0Lys65RjlYl8UBoSKDgT/vHUJAGJgGj3z+q
	iL1nK1Uf8H2dzGXMOwHjVUElCIg+qMJ8Eub44526+plpib7J7GCFpWle1pci+mWMxh6Czemud8p
	AnXRbAynruCh2dtg/mbpKnR4PpJwel6d487JLsKvth9OkcXsoyf50oJO4bO2JK/QlkSLJyOUoI=
X-Google-Smtp-Source: AGHT+IHFkdSu25meZ3P40S+TgoYUNiCRsPaAFdS/ugZ0zuvDJbW0VQPUcPHg1pqZLNrOw0lfVX8WnQ==
X-Received: by 2002:a05:6a20:4321:b0:1db:e338:ab0a with SMTP id adf61e73a8af0-1e1dfbfbe83mr29896481637.8.1734452006837;
        Tue, 17 Dec 2024 08:13:26 -0800 (PST)
Received: from localhost.localdomain ([222.205.46.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad5664sm6879415b3a.73.2024.12.17.08.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 08:13:26 -0800 (PST)
From: Gax-c <zichenxie0106@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	bcodding@redhat.com
Cc: linux-nfs@vger.kernel.org,
	chenyuan0y@gmail.com,
	zzjas98@gmail.com,
	Zichen Xie <zichenxie0106@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] NFS: Fix potential buffer overflowin nfs_sysfs_link_rpc_client()
Date: Wed, 18 Dec 2024 00:13:12 +0800
Message-Id: <20241217161311.28640-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zichen Xie <zichenxie0106@gmail.com>

name is char[64] where the size of clnt->cl_program->name remains
unknown. Invoking strcat() directly will also lead to potential buffer
overflow. Change them to strscpy() and strncat() to fix potential
issues.

Fixes: e13b549319a6 ("NFS: Add sysfs links to sunrpc clients for nfs_clients")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nfs/sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index bf378ecd5d9f..7b59a40d40c0 100644
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
2.25.1


