Return-Path: <linux-nfs+bounces-11123-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0119A87088
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Apr 2025 06:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF3117A237
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Apr 2025 04:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07CF3D6A;
	Sun, 13 Apr 2025 04:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StaQkIup"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BEF322A
	for <linux-nfs@vger.kernel.org>; Sun, 13 Apr 2025 04:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744517278; cv=none; b=GfyVvCYd6WIHmPnlwkn/1DaNe9/9QUp/0AHe3PAgf5M5ZFrml3nc09tBIfDoMiIROMu4m5lNB2Ln1PvyfFXX/rwyi8kOkhOZeuAhCEeJRU6Bh9dw9KhVAhEhYok/LLsnJyCjH2J2NHkSPIFiaFeyxhvfk0hiOY1nVcIUxSYTeQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744517278; c=relaxed/simple;
	bh=T+9UE4VQG7DF+epK1aVNvSetThK0ZDSFV5iFxwSSPkM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aKeE/PT1sYHGARexGIcgSmrV07OlpY/lD7pjjHknzy04JpwTCXxJoyqO68NXqjoNnObejbr0OXVJLhcQtS6kFP+mYe4AVI8N6Lx7QgcYzSi2sMn8S9hyPXVKT/4SMuhywerAhaQ5QuaUS1LGm4IgDoR+EOodYnbXbliLN1Jvc1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StaQkIup; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-aee773df955so3489731a12.1
        for <linux-nfs@vger.kernel.org>; Sat, 12 Apr 2025 21:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744517276; x=1745122076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6NLiQCpE2GJ19tBJ52ZGj6+jpvNC2yqxp4jfsFx1PU=;
        b=StaQkIupwcB2twmYufeFO1A7teC02Vnm1KQGnzssgSWQZHgrpryZb5M/ZH0aEZgha1
         9gJOMgQ9+VWYPBZTxMJwOt859icC167k5Ev0tKanrCrX1dKX8YFwgrrSeXwWIWwW2YvG
         mV3FD2cZBE+pcuyJQjj0JK5dJ6WcMQ6/1/7rjxibJ37N4lq4vvE0Q5PS7l9qcHDTPh4l
         iESpoJgSJK6fAXiJJk5BAywjLT0Iu10X1yeaZo+kyPtuF7dIIPF+q+pcTfh9rLWFvMmX
         LcUnlQhu5HYp4Pp1mbMZK4GoJaMvlDnDza+uFqHQ4ZoFKrAUgI4OKZeKcs0Nhqdi0OIN
         57/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744517276; x=1745122076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6NLiQCpE2GJ19tBJ52ZGj6+jpvNC2yqxp4jfsFx1PU=;
        b=qml4XZT+iimUUokw+NlDmKQjc4gz8s/gUSutTDeg29nSTd5VTIU06MuwbB3AEr/6aH
         n/WdZe03w5CzTAv7fMxdVW4sgRU2TvMFxtVGsgSVW+FVe9UY0sGTg+5jOa/Sz6PKKesW
         +IQcaBCQzPVxO6kSbLdt40z4drEQK/l+5NHOaCBwQWP0Itb8kC7jI+KphE5Uz2w1i8bX
         0FbACw1nwsam8UUNI/IL57OYJovt0uZwmbhoO+636NJwl9O5di4hiJ4u3etQxgx4fcn8
         Zi14ahTW9WkrbwNOJ98JywL3rUnfPX0CBPw2cLRQ4kYAAomThAMhEpJxqPHtSQhfVtXU
         Ww8Q==
X-Gm-Message-State: AOJu0YxzZFYhGHhb5QRxBnhLQ7EV3QKABpQkkQl1IaDPH4OmsQimVOwe
	G8loCG9/Gpn58bLlXZTbbuin3DBOkYdbaJ8yJpdLxip6YMzA2M0yYbXRXOri
X-Gm-Gg: ASbGncsSc5C88KWkumWaghWldTY0zyI7zZsLyPqUrt6d7NrckJl13JqqeXExY5dgLyk
	gESA/FURjh7SD4qCW8y8muYhliDc7eXnuuEE9gCkHP915Rg9MJuimqz1JN/i3apTO2LJzLQ0lzT
	K8TU9FuXpuxjhekPpncFxIIslY70azholunBtwkjrsgJTT6u+P8VasHYBKgJNV2ufiX95Phm30Q
	QQmcoJHttbhlouZJxEHLKrmwuDfYusTLSpOEe0HtpyhCgNyaFvpCxJylVMli51uUCRgoZLusvWu
	gFUxWXpUMI6hZTdX0gRsuxqtPbjg8jZSRff82ELung==
X-Google-Smtp-Source: AGHT+IHf4xkB6cZLZAWgwe0vLQj+ORrptz+6bragyDNhldS+5MsoTZR3p2r+rp2uSZtdFnMrD7CrHg==
X-Received: by 2002:a17:902:d4cb:b0:21f:1348:10e6 with SMTP id d9443c01a7336-22bea05db99mr104203915ad.13.1744517275918;
        Sat, 12 Apr 2025 21:07:55 -0700 (PDT)
Received: from hh.localdomain ([222.247.199.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b628fasm75312825ad.32.2025.04.12.21.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 21:07:55 -0700 (PDT)
From: hhtracer@gmail.com
X-Google-Original-From: huhai@kylinos.cn
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	huhai <huhai@kylinos.cn>
Subject: [PATCH] nfs: Use IS_ERR_OR_NULL() helper function
Date: Sun, 13 Apr 2025 12:08:28 +0800
Message-Id: <20250413040828.2529-1-huhai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: huhai <huhai@kylinos.cn>

Use the IS_ERR_OR_NULL() helper instead of open-coding a
NULL and an error pointer checks to simplify the code and
improve readability.

No functional changes are intended.

Signed-off-by: huhai <huhai@kylinos.cn>
---
 fs/nfs/write.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 23df8b214474..bf44ab0f5de3 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -637,14 +637,13 @@ static int nfs_page_async_flush(struct folio *folio,
 				struct nfs_pageio_descriptor *pgio)
 {
 	struct nfs_page *req;
-	int ret = 0;
+	int ret;
 
 	req = nfs_lock_and_join_requests(folio);
-	if (!req)
-		goto out;
-	ret = PTR_ERR(req);
-	if (IS_ERR(req))
+	if (IS_ERR_OR_NULL(req)) {
+		ret = PTR_ERR_OR_ZERO(req);
 		goto out;
+	}
 
 	nfs_folio_set_writeback(folio);
 	WARN_ON_ONCE(test_bit(PG_CLEAN, &req->wb_flags));
-- 
2.25.1


