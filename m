Return-Path: <linux-nfs+bounces-3726-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E0A90630A
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98F82849A6
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C2F136648;
	Thu, 13 Jun 2024 04:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuh8earp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD313213B
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252276; cv=none; b=d1nk/KCnJJbkYHfleh6lzdDbNtCpPVeR030FiGcGNEMAfbFvry3dZk3DhR+t0o1gltOkQwrEI0Z9t9euttMoAlwaCsQRzru0ijzxkpUaXbfL4pb8KjbtLOjTWCxB7kuOj/YdPbx+hHr1LsPChyRDZ76lEfqYyJcB1Zp17ol0lkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252276; c=relaxed/simple;
	bh=+QhbD0cJHsmZUUnuXTTup0buGi79bNCNfbL5JtYs/Os=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qqu/Cd5sZWJNJxTXpzCfq8tL4NvIVY/eTbPL1kh1os5YR8YHGwZ/m/lmLiAIj2tGl30tJb8SgKEvF7OqIOC1+ib38+ocQ+p2bZM98wn9k35pA6Ap5Yx900Kmr5uW9/FEvR7gJHxeYqBJnGXjl9Xd205zThSff2Xqk8LJEK1eQQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuh8earp; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b06bdbf9fdso3412516d6.0
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252274; x=1718857074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBi0Avyni3XvXGjN9VHc5/6ljyXF9oVpp2RRruw1EB8=;
        b=cuh8earpE5LbblwEksKSl6935Ghnzyw+QoTbeFXWSZblKBvqATUuZ+nbfCMx+o3MDd
         RA/97xfRaX60hPfOrdw10Dh9tNmnhxkVtnZhljkFgg0FELll4cwiu2AUYJ6imFqpgiy0
         nMNlf043DWjeAh7enPY49CUCE3WDYOwj8QWMUyoEJRflm16e++q0M6xNCdxawtbjBElx
         354ulmGRBE6Vz+ZMTi2qFF7rRpW0pIID0g4fKcz9RxMQ1wTa2TD0Rc75DN/NvOY46k4S
         pedDOO0uvDFQrSAZHDQjNg++af6bgtjQxcmi7Vjw0z5tfZR3k7YVCpeATzSLcPbVHfFH
         hbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252274; x=1718857074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBi0Avyni3XvXGjN9VHc5/6ljyXF9oVpp2RRruw1EB8=;
        b=bO/uAuOdFOMaHn2RBzZTWt1w1RsBlZGZMvkWlOM2MvMCzoNqaoM3jG9QKtphtYDftE
         rOr4vqFftZf1MoFOWllyFBPUUrbwLmOwy5Zfh5JXo8m4TpA70hWHhK+LJBwA5xiR617D
         cKcbQZo5X3AzM8elzsXVmKvCrkVOjQKo7rpQIUIIDvF2u5e0mOF9rnbDbgjI/2WAUsYd
         4RzcsfIaTuebCsIN8zf8/3SM09IrQXBhR3OVEVFHZoyvNn2VxZzLYtOU2k1Rh5DNlUjM
         1cvlDfSD8HIE6jb6Kzf3ZC5WlUXWW7DP1/hCJcrSl12WYx8onW33S6AyZyH1DsHAMJ+p
         U1cw==
X-Gm-Message-State: AOJu0YyJLRzobvXlZDyke4wySq6pG4YYl4TLIzVqAKmnv3UQG3aNeeFm
	atJfcH+NxKmLbL/+fXJwKz80jZZzhLDWfHy/yDMM7sK3Wm3ufWYuxr/g
X-Google-Smtp-Source: AGHT+IF4aMLk3TebsgXJXWxTPC5yITL7Crh7RZHXKFgGU28a0QP5bpmps7/ap8HPLeq8GxhJ7qsHdg==
X-Received: by 2002:a05:6214:3d8d:b0:6b0:6fc2:a6ef with SMTP id 6a1803df08f44-6b19196ce55mr38269166d6.21.1718252274083;
        Wed, 12 Jun 2024 21:17:54 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.53
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:53 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 17/19] NFSv4: Ask for a delegation or an open stateid in OPEN
Date: Thu, 13 Jun 2024 00:11:34 -0400
Message-ID: <20240613041136.506908-18-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-17-trond.myklebust@hammerspace.com>
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
 <20240613041136.506908-11-trond.myklebust@hammerspace.com>
 <20240613041136.506908-12-trond.myklebust@hammerspace.com>
 <20240613041136.506908-13-trond.myklebust@hammerspace.com>
 <20240613041136.506908-14-trond.myklebust@hammerspace.com>
 <20240613041136.506908-15-trond.myklebust@hammerspace.com>
 <20240613041136.506908-16-trond.myklebust@hammerspace.com>
 <20240613041136.506908-17-trond.myklebust@hammerspace.com>
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
 fs/nfs/nfs4proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 23947fca78fe..d41d86c713ea 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1358,6 +1358,8 @@ nfs4_map_atomic_open_share(struct nfs_server *server,
 	/* res |= NFS4_SHARE_WANT_NO_PREFERENCE; */
 	if (server->caps & NFS_CAP_DELEGTIME)
 		res |= NFS4_SHARE_WANT_DELEG_TIMESTAMPS;
+	if (server->caps & NFS_CAP_OPEN_XOR)
+		res |= NFS4_SHARE_WANT_OPEN_XOR_DELEGATION;
 out:
 	return res;
 }
-- 
2.45.2


