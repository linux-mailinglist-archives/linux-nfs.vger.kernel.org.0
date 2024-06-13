Return-Path: <linux-nfs+bounces-3719-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B09906303
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1597C1C220CA
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FAB135A46;
	Thu, 13 Jun 2024 04:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0MNEvVH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC8134414
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252270; cv=none; b=fmnKjP15U4xiXHQI8PsUhGWEQQAGJNT9KK09OCyonFtHP4qd4XIiy1R72RZMSFw1co9rurRStAOMH/VGw0Vow+k8VEEt9OxKc437vILr/SqZOZJgLUwpQp40W5NZAcewIe6qR/8IXBVen2digHtebiN/onpRM4ztBo83cmNrPbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252270; c=relaxed/simple;
	bh=aoL/lDctGiS3XXACQ5vdk0QGeF6ZqSQouBkuNBuAjLI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8iN0dV77/KwI8Q9d1x7lHDImLxEih/VtFbCVzl0ZrSDZoK6px6SRHX0G4LGozp7ImMcQXp9ZHjskZndBreb9W8BEkhIg6TjDxIP7eXFpH8+scjfRIwoqFAIRsZ6P1Rb3M2ZJa2uMTaGIC/mQ4y9zerc6LBvxPSkOHSXperwtnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0MNEvVH; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b0825b8421so3608986d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252268; x=1718857068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QtVwbega8NvnHdt/uKvwDjYc1+36fjrMQHuiAk477o=;
        b=Y0MNEvVHPgl9DCN5h9lLkV0CRDp2or/P/MB7KSqoieg7rk/dfm75IkMSGuvrcEpOxi
         2tEnQa7HJnYHb+w+TcQ/eQh5fEqYsyQJs824jWqgUIZHg9RXAdO8t9t+mLxYptC6mDVU
         X311D4G8fo89uSYNyIj4p3hsCgZD7ugtQ2jDIvFFwVg4KBW/H+6QBWbqg27ArQ824Aq8
         Ls3RM3mhia+SBcPm48vhcZuNVtbrNp/JBTQFE8VuRPqkk4XGdFyhdL+uHGPZOCtYbz5c
         w9fREzEpf+uRpB04l6fPLzDXq2V1OxDnBlaLE6QsxgWsU0HJzj9dChwxy8MQE0R7v/lw
         0ccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252268; x=1718857068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QtVwbega8NvnHdt/uKvwDjYc1+36fjrMQHuiAk477o=;
        b=ZoqbAT9k1fQNHIBFJFb3jsLnDT7UjwB+UeiQCXNIxbs2GebCMnMU7BjDWIcp43hSIa
         R2+kWSt8IE6ACN4T7mGGuvZ4TffCvMlzqSoM26nS6N2EuhCSQ1iaENSW7rH4xVkjiY6c
         yPd1f9GUeZAkATsIPxM9E8JjTF4STQcmlkbdUH5sLqpLa1lmqALcznnlruyA8//ueS44
         8deMPavfEuvL6bgqojphO8PBmol3X6++LONjZ0/luQbPuKKy0jABLIBC7zJgdfQD+hY5
         /dHVuNRm336GUpDQPP3cT8ouB1Tbn8lFtupqXvqxW5Ya3fzB+9apuB9HBWOdy3UUVnf9
         s1Mw==
X-Gm-Message-State: AOJu0Ywy2zA5WnaXC32QgdImttAMR+jb+TU7Lm8ITOsBrzcKhcdlFwyw
	zBp8mjxu0zsbSIYq7sZtsvpwBODgFcl9f3CVqwCtVBIbcP6UCCvrN4Fb
X-Google-Smtp-Source: AGHT+IEmVS6P96QdC/hvKbRbfDXHnSR/S3HcoBSuJEfiCwRL8PrAVvhCG+B8a+P2lJQ7oeZyRu5d8w==
X-Received: by 2002:a05:6214:5248:b0:6b0:7caa:457c with SMTP id 6a1803df08f44-6b192028a7bmr37890306d6.24.1718252267908;
        Wed, 12 Jun 2024 21:17:47 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.47
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:47 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 10/19] NFSv4: Enable attribute delegations
Date: Thu, 13 Jun 2024 00:11:27 -0400
Message-ID: <20240613041136.506908-11-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-10-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
 <20240613041136.506908-3-trond.myklebust@hammerspace.com>
 <20240613041136.506908-4-trond.myklebust@hammerspace.com>
 <20240613041136.506908-5-trond.myklebust@hammerspace.com>
 <20240613041136.506908-6-trond.myklebust@hammerspace.com>
 <20240613041136.506908-7-trond.myklebust@hammerspace.com>
 <20240613041136.506908-8-trond.myklebust@hammerspace.com>
 <20240613041136.506908-9-trond.myklebust@hammerspace.com>
 <20240613041136.506908-10-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index efa07c275338..140ff1d75320 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1339,8 +1339,13 @@ nfs4_map_atomic_open_share(struct nfs_server *server,
 	if (!(server->caps & NFS_CAP_ATOMIC_OPEN_V1))
 		goto out;
 	/* Want no delegation if we're using O_DIRECT */
-	if (openflags & O_DIRECT)
+	if (openflags & O_DIRECT) {
 		res |= NFS4_SHARE_WANT_NO_DELEG;
+		goto out;
+	}
+	/* res |= NFS4_SHARE_WANT_NO_PREFERENCE; */
+	if (server->caps & NFS_CAP_DELEGTIME)
+		res |= NFS4_SHARE_WANT_DELEG_TIMESTAMPS;
 out:
 	return res;
 }
-- 
2.45.2


