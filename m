Return-Path: <linux-nfs+bounces-2237-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D328759BF
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Mar 2024 22:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2235D288DE3
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Mar 2024 21:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A11613B7AB;
	Thu,  7 Mar 2024 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZmZpT30"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8613BAC3
	for <linux-nfs@vger.kernel.org>; Thu,  7 Mar 2024 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847942; cv=none; b=nZoHCFfHz9nqZDM/aShDICskdSOkT9t31HTxO8qI4NVHIprtKIQdaEEqEP6/ZiaDb+ETOR36CRt3nFBwlqkKP8kx1Vz9XYZ3luJIad7tnuMk3JGsx130uqFHs2+XNEzDbW+jVI/o4fBoLg1xlHUB/iU0CsD4f6v/V5u4mCv97Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847942; c=relaxed/simple;
	bh=xPlJe9JYtGxo7cSiPmx+yDpITcv8m3XMDvJXHSppajY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=An0LODGkC6vMRGCmm/cABNJxviYy0Zm4ShvGR7NAngy1jzCTBM3tHrB6cSmRkDjB2bs4Oc5bEIeMjSZleoC3eDoGDdvTrE9kRfz5c2MxS8qjWNPUAgUuvp+gbX9LA8mHWfMtO54ngApDDbUS2FPujwleHTZl9rodx+ZWg2Jx4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZmZpT30; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-690a23f4572so4289166d6.0
        for <linux-nfs@vger.kernel.org>; Thu, 07 Mar 2024 13:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709847940; x=1710452740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ6FEFryjuxp5uJob/978okrCPISJ0LKXNI2wPsigN4=;
        b=HZmZpT30GZ0JyPzr8X1RHDKKpPAm5be0YkgYWknXNsAFgRy0nWnRDJNLNwN7dO5eKF
         mkvW/cgI4mdXazFuED/RSh0CCp6r6WsdTIy4u8uXOeiRYpw2/REPBGLkVuCXvR8gebkf
         MZXLSdDVwEtPCPSpyYNkCEjha6sucALa1lWkwxGqiTlLRQBcIttDd/US2GnssB4rZ968
         TQSg5cCy/5syKIDbEWYnJ479QnGyMlaCZ245wG/D82Oua2JMQjs0ebIK97NFmsf8xNGL
         EjDZ9kdlKQpeJelE1oPHRnxjTQjtiwpc2RHLCc2xA0tnsIwLUMVHU6e1QBhRN25UyRl3
         YFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847940; x=1710452740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQ6FEFryjuxp5uJob/978okrCPISJ0LKXNI2wPsigN4=;
        b=sW1WfngWV3sLe8gZOnc812rVxjoLxecTlBWioaDnXr5gDUB/abTIMnPmhX9840otv/
         7buDeJxNUnahZSIWUDE2S4zHXEbhGRIF39p1xCSDnmXoFT93tJSSUdxKzxMnnNwKADpy
         RK6iSdx4L4VkwEgiyJAfhLbvVA0CQxPbGVMSmZYp8j0ia5/ZKBz1liwDYGYIhFz5ifPb
         19UCndrnHxhp/YXpspvT2DXb+Y3QlgM4iXQy5lDRHDJyNTdVTvcbRAMl0ri54kNFdWYn
         7yj3HDQ8Zwr5gtk2DpaH8VakoiFEmXj/J1PoIOtZd5WlcgY6pnKYZQkC9BIpbduPrRqD
         FnYA==
X-Gm-Message-State: AOJu0Yy/++kOjSZmnoAX6UMZqfmUu4L9pcwuBetkymYMUN7VFNhRhi3L
	EDJiGjjAfIBFWWOQZvZLxTLgXzpAsh7ycqJO8fqy9BJmJOqGGeg=
X-Google-Smtp-Source: AGHT+IFGdJjy0EtiMzLqaLmkvNUBr6M9Wau2wGjxYZvW2Yd6nQ8HeiFEYunA/xJ+QujU1/O/F1AlHA==
X-Received: by 2002:a0c:c24a:0:b0:690:b2d0:8586 with SMTP id w10-20020a0cc24a000000b00690b2d08586mr248799qvh.39.1709847939779;
        Thu, 07 Mar 2024 13:45:39 -0800 (PST)
Received: from localhost.localdomain (c-73-145-170-161.hsd1.mi.comcast.net. [73.145.170.161])
        by smtp.gmail.com with ESMTPSA id ly9-20020a0562145c0900b0069010959b00sm9109666qvb.44.2024.03.07.13.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 13:45:39 -0800 (PST)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: Steve Dickson <SteveD@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: allow more than 64 backlogged connections
Date: Thu,  7 Mar 2024 16:39:13 -0500
Message-ID: <20240307213913.2511954-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When creating a listener socket to be handed to /proc/fs/nfsd/portlist,
we currently limit the number of backlogged connections to 64. Since
that value was chosen in 2006, the scale at which data centres operate
has changed significantly. Given a modern server with many thousands of
clients, a limit of 64 connections can create bottlenecks, particularly
at at boot time.
By converting to using an argument of -1, we allow the backlog to be set
by the default value in /proc/sys/net/core/somaxconn.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 utils/nfsd/nfssvc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/nfsd/nfssvc.c b/utils/nfsd/nfssvc.c
index 46452d972407..c781054dbdae 100644
--- a/utils/nfsd/nfssvc.c
+++ b/utils/nfsd/nfssvc.c
@@ -205,7 +205,7 @@ nfssvc_setfds(const struct addrinfo *hints, const char *node, const char *port)
 			rc = errno;
 			goto error;
 		}
-		if (addr->ai_protocol == IPPROTO_TCP && listen(sockfd, 64)) {
+		if (addr->ai_protocol == IPPROTO_TCP && listen(sockfd, -1)) {
 			xlog(L_ERROR, "unable to create listening socket: "
 				"errno %d (%m)", errno);
 			rc = errno;
-- 
2.44.0


