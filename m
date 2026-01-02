Return-Path: <linux-nfs+bounces-17404-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F34CEF790
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 00:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F32C8300BEFC
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jan 2026 23:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3011F8AC8;
	Fri,  2 Jan 2026 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUqLpxVy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC798299AB5
	for <linux-nfs@vger.kernel.org>; Fri,  2 Jan 2026 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767396639; cv=none; b=dJDykOhIcg5+s4aclyyZIoBRbvpjR+ArzVgoppOVY1rw8n+EURETFOk/g8oKP1wC8c7BFB/pb+fyAS5UcYXFf1Ciah6u90a1WyheMXPWBVIwIjz27/8G8bNxMQinxi9oqYLowC3PyToeLN3IAS+xYoQwn1cgkNUFB1rvOu4tAxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767396639; c=relaxed/simple;
	bh=moKIz5Ld8xajCABvcxgdytzAPIubMf8OhdTukxr5IzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2B3pQNPvdM3VmBHfoyRPTX8EFocnUsiOrHjtnJ4QWAJyvIiGrTVmRbRQywd2hKAA+VvDcwliBIv1CVJ7pPtmt1VkY1+b/IfftHfLW7AMaIJf+EDqvqI0iSlwMsamdYhmgORuysT45WE8CsN7jgJG4QHklqWSClOw7nkFm03+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUqLpxVy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0a33d0585so114571085ad.1
        for <linux-nfs@vger.kernel.org>; Fri, 02 Jan 2026 15:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767396637; x=1768001437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUK1qxG3XNdlIN5wGsmxZ9ze2xZ7wFRokLFaNRKof7A=;
        b=dUqLpxVyqzxNi+YsGOV3WbGbg91NV+9iWM1KNdnt+45DRhEA2uyv1r9M+5MoJGpPI9
         +5t+iR+VNefF5E5VugKqQMuOu4AgEY/bs4GxolCnxD7K2iDqFCnmqQtCtxjpvdbB4DsP
         TcykLMj3+sPHjKinEMwB0WWIroKVJu/xs/Pba7EirV7jYyY4v/66iYK+GSL3UWCVtji0
         KwAzDPBjuRiPgbyzQQtuyZM63ootHCZxgOR8oWG+jCmkTV4UjDvzv9+jRGwE4G/4d8MY
         vQ/kYkBfzVZ0Kfyk70FTt4BcnT91Lr3boPwGxR6Mgxa7JLiu93ltTcm6NUp1LfJh2gTR
         uGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767396637; x=1768001437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dUK1qxG3XNdlIN5wGsmxZ9ze2xZ7wFRokLFaNRKof7A=;
        b=NAGRAkmpwe9CUQJC6wKdn1jY4ayHA1C1cmZYGodQOQ4vjwNkh0zP2NHOf73NM2BGLX
         K6NLRsBSgIL7qm/Bbi4W66UhoAhfNjtcwd/qp0UG8FminDVCHk6ty6b5w3otclY7qGxv
         carE/9nxLHcYTF/Vrc1BTxvM8t8tIPofMFHJmKtrR/IRqinLYYgpVsB1p+hSh6LoMyRH
         yNUX8vzqG6FBZQn+AN2PV8kZyMpe+1O8q6cUQv12ESLuTx394EvK0SdZhCFP2W/7Ln/V
         7s6naZ/RYIw17ZH2iYOq3yPmSipBM6+gAiGQVlaabGKFl1Lvibq5q6nO+CWhmFjrJpBq
         ZWig==
X-Gm-Message-State: AOJu0Ywbl/z6xkjHq+HveVuGRCSHa2rIXRGRRRiR0T7JzaaqXNDBCKy8
	Ud21peY/h8J5vIr1/QrnOM5szSkRK+Lb4/lxvotcyaiRnwjf3aNIr1aKKdkrLr0=
X-Gm-Gg: AY/fxX4OBJMxL4YbuIDh+U5HLE/s+krAgY0+W54VcUvE+OUkRRSFvuJK4Bg+Vukyy4z
	LhshBI+RIWTOkR9AqMhe6ue47CGn8Mfl6bOM2MRxNAuk1pP0c0FZZ+A8sCBeGKaDwvXqUE7CXHE
	x5oGLtZ4YQwHrvJYhk9dKWXRpum4mwDla/Q5v22RW38bTZSAq+llfnOHpvr8W1EKJXdkgnsrkhz
	p3wL4ueP5+CJoQUCrllzAJf/aXwYMKlb1W9oZwtnlcJEPRcgQsNw89E9lSeAW1DcSTBl6nW7MsV
	x+TuJg3WB5ncpenpAR9GRnZK1ya67WXpmqxtzvAjIJQqRTeE0eewKUIFZbRKozeIAFnq9rho1+R
	+stW3X80jNgzJhmJ3qA4rq7J+AzA/h9gAbtqJuTB81guBhKXxDvPLXhhpSFPE5v1Ltp5hZWaQJS
	SL3+ktUPKUf+NIJ5LIYpiX7XfmQ2yzWOsSCG5QdNkLTlb/5v642pqk2c5b
X-Google-Smtp-Source: AGHT+IH+GQ8o/46Un8CtzZpAUknUJPyC//5GzhoJf4Bl6l3FJjqX+D6Jv5mmUaoutM4WoQRNqPQsXw==
X-Received: by 2002:a17:903:4b2f:b0:2a0:9e6f:2ce2 with SMTP id d9443c01a7336-2a2f283de25mr425803525ad.41.1767396636994;
        Fri, 02 Jan 2026 15:30:36 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c71853sm391508805ad.19.2026.01.02.15.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 15:30:36 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 6/7] Set SB_POSIXACL if the server supports the extension
Date: Fri,  2 Jan 2026 15:29:33 -0800
Message-ID: <20260102232934.1560-7-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260102232934.1560-1-rick.macklem@gmail.com>
References: <20260102232934.1560-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

Check to see if both the POSIX draft default ACL and
POSIX draft access ACL are supported by the server.
If so, set SB_POSIXACL.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 57d372db03b9..aa0f53c3d01d 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1352,6 +1352,11 @@ int nfs_get_tree_common(struct fs_context *fc)
 		goto error_splat_super;
 	}
 
+	/* Set SB_POSIXACL if the server supports the NFSv4.2 extension. */
+	if ((server->attr_bitmask[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL) &&
+	    (server->attr_bitmask[2] & FATTR4_WORD2_POSIX_ACCESS_ACL))
+		s->s_flags |= SB_POSIXACL;
+
 	s->s_flags |= SB_ACTIVE;
 	error = 0;
 
-- 
2.49.0


