Return-Path: <linux-nfs+bounces-2141-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A62686E66E
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 17:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4471C22D8C
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 16:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9022AF1A;
	Fri,  1 Mar 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="X4UwwrYV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56044848D
	for <linux-nfs@vger.kernel.org>; Fri,  1 Mar 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311833; cv=none; b=Y8K6siVioeU0IHScOrTi5ZpX9tx5CR/Ktnn7qJifvAp4h+H4RENz9dxkXmOa+2alLigL6YGW1IWmL/A7/yF1yAwXgYlDznmxm9EcNtJK6Sff1JayEWYV+mlMY175MbBWdDSaD3jIwiX4/8eHhl1BFPkQ6H3uR2hClDxDdw0TOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311833; c=relaxed/simple;
	bh=7LvQj/z/WuxMQiDIODl58xUgQGN8gB5yelrpjUT7ajY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNxW2Lq8nyYa6qI1vB7m9ihXIEDO0q12ddymVCtOBWYNBfPr9k3yvR9/jaeu7ffTOCtHkJ8zAuaLJbSavmHdpGSuy1aMpx03GPzngd3uQxKDAwZVxlmX+VY/hotZNlEsX2T0vi76P5MlnNLbnimtA0v5uYizKEq7kPC0wyH9Tq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=X4UwwrYV; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-787ef8b194dso252550685a.1
        for <linux-nfs@vger.kernel.org>; Fri, 01 Mar 2024 08:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1709311829; x=1709916629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/b5P3Fk9z/LOIcGc51y749zFSPmPeATL/rkMs3SmVs=;
        b=X4UwwrYVBudohjvUIA6shB41tUM2ehCJeP3cptQvCuTRgVqDp8DkpyfgVgUbOMU9WK
         NMSWtX7rKZypjnbi+4//ls0FX62Pd/eBfuLYdp0lPCTbp6KyWkBUG8NT7vdvHEtumxLL
         8Uycd6M1in51aVD4xuUbxjG4Up3w4AbeJ80xrRkZQ2kfdhaAiyPwzeyYa7oQTOD79JQy
         5QLIbkiu7QNxwBRYSi3AyFL61iL3Mn3YDoGtHUD3Sxa/3kTumEBee6kAwp0dnxZmAHYi
         I9wAJzdWsi164QtP/XrgDcGmOdVAj8wegRR96JaZ1XALdKHgbu9YHajY0zxyj984BoTw
         Mwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709311829; x=1709916629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/b5P3Fk9z/LOIcGc51y749zFSPmPeATL/rkMs3SmVs=;
        b=PNCMW0FMMIf0/R5QXAv1H1Gh2vSAjYEUw2Q73oy4G776YkDMYkehNC1KEPsy4ObAH9
         +KTygiUEhIgJpEbAz/4GhN0cI84du0kFsLtxsOlSmCixgGkeYwNCyZMgmYTH9Niwe/Gd
         Hd0toHPwKdYZ3snZ80M9/JcT0PiuCAiU401XcnH7D98ikF1O3mH5sDQC4yOBvG18tA0N
         IK+uopYRnpFVcGtJvwN5HaATaP36gzJrYCx1eneh8mBG1Fk7VdSoYiSsatTNHrrecnjD
         qBzWHsQHh1cLsQD7xhB+k74xNdqLWUkdq7LDqLyU0KWOtiIgIIIHQd5Bev7v6xI5s88d
         RQaw==
X-Forwarded-Encrypted: i=1; AJvYcCXmX7PZ8xBR7DJ+IM9gm/40wWWNcqMWCrlB6c5AOPPmuvCzNkLvJ6HFrU7jNX3MMdvj17K94FIY7d6om1i2mSbLg7vYJeLl7ntW
X-Gm-Message-State: AOJu0YxrgY2QbbzJpI2Iw0AbNwEmH1H5bMHm3elvhi35v6MNVg6FR8j2
	BWGvM1EcuhG63P+PkkMPuz3mH4KU3D2StuRsEGl/QOuq+Vk83KlCq2lRw+9AXH7yhpzyhS/6eJD
	z
X-Google-Smtp-Source: AGHT+IHeHvC45ix6Ih+YoXPNqH3WOu5iqGx1Ot/W+oe1g2LYT9qa3Z3kDA/FfSei+BiBCzTQ6QQOdw==
X-Received: by 2002:a05:6214:bd4:b0:690:3329:3012 with SMTP id ff20-20020a0562140bd400b0069033293012mr2646077qvb.26.1709311829638;
        Fri, 01 Mar 2024 08:50:29 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id pc16-20020a056214489000b006904d5bf148sm1600100qvb.134.2024.03.01.08.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 08:50:29 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfs: properly protect nfs_direct_req fields
Date: Fri,  1 Mar 2024 11:49:56 -0500
Message-ID: <ca2f5e31d321b19fdb033f10ce6aec79c337a648.1709311699.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709311699.git.josef@toxicpanda.com>
References: <cover.1709311699.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We protect accesses to the nfs_direct_req fields with the dreq->lock
ever where except nfs_direct_commit_complete.  This isn't a huge deal,
but it does lead to confusion, and we could potentially end up setting
NFS_ODIRECT_RESCHED_WRITES in one thread where we've had an error in
another.  Clean this up to properly protect ->error and ->flags in the
commit completion path.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfs/direct.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index c03926a1cc73..befcc167e25f 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -606,6 +606,7 @@ static void nfs_direct_commit_complete(struct nfs_commit_data *data)
 
 	trace_nfs_direct_commit_complete(dreq);
 
+	spin_lock(&dreq->lock);
 	if (status < 0) {
 		/* Errors in commit are fatal */
 		dreq->error = status;
@@ -613,6 +614,7 @@ static void nfs_direct_commit_complete(struct nfs_commit_data *data)
 	} else {
 		status = dreq->error;
 	}
+	spin_unlock(&dreq->lock);
 
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 
@@ -625,7 +627,10 @@ static void nfs_direct_commit_complete(struct nfs_commit_data *data)
 			spin_unlock(&dreq->lock);
 			nfs_release_request(req);
 		} else if (!nfs_write_match_verf(verf, req)) {
-			dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
+			spin_lock(&dreq->lock);
+			if (dreq->flags == 0)
+				dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
+			spin_unlock(&dreq->lock);
 			/*
 			 * Despite the reboot, the write was successful,
 			 * so reset wb_nio.
-- 
2.43.0


