Return-Path: <linux-nfs+bounces-246-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733698013A3
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Dec 2023 20:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F2FB20DF8
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Dec 2023 19:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CE04F8B6;
	Fri,  1 Dec 2023 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQnP2VPq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6239A
	for <linux-nfs@vger.kernel.org>; Fri,  1 Dec 2023 11:42:05 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35d374bebe3so1861985ab.1
        for <linux-nfs@vger.kernel.org>; Fri, 01 Dec 2023 11:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701459725; x=1702064525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ErTBYvi7SZGb4GfuMjTtkAdp5NyG4fmuiIlOwg3jEyQ=;
        b=JQnP2VPqhFR7rSRmsKQLd5n0thfxcGGeLHu//ZNG9RRysupC+O+ioZ8993+RYOwdaR
         Kom1IHV0OoPqIUiiPcRjGzRDkKvZ7xSsYgjQTH8yjXbH8pQVOYS78783xS+Yel60ujUW
         qtlyq+HloU0vbF9qJPnwtpPjoUhcefVMLSugrjaVjz3wh69VBxoN1ZKx5B0rh2ClXgJa
         ABkX95Z0fcfk7rJYGXHKRK2pf1z+tcD2UmITgfwkk1XrG7M57pCgPcf1MUrbMA2hnesl
         CWl2e1nKZFbO0uL3uoTKYna1CPLg7Rvmp2ymXah+FUKmnsW4OSEaInuFIH6Hesc0F45H
         rG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701459725; x=1702064525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ErTBYvi7SZGb4GfuMjTtkAdp5NyG4fmuiIlOwg3jEyQ=;
        b=WzkfaCT1Q0Qyrpc06kOu8IiCawWtJEYdS3iOk5ITszEqDGMQRIL8Oq1v/JZg2bPLd1
         HJ2bwEnhNfPCsfOaRfk2a7Uhmpru+ANwe0+37SL4o09HYTLRaChRHjGyrgKwphkUR5et
         1TVM5GpNhouGJlK34VuEPPMwhBifQYe0i5y2VuxGEWdP0kEbJmpWJq8l7cLnnBFFW+dS
         xJvZxHGIl+7+GRCzv3UD8zVuvBoDN7EMk1J0hUfBh1ITfOCrW+1NNF+vN//tyMzRE37E
         btHNAF3WTuElIh+BbxAtf966ky3mUJ5X50i4fUZZayB0QXnwxuxHPnKcO0EXlUICTViS
         FAjA==
X-Gm-Message-State: AOJu0YxvphtuyLMbnvelk+lmmG1k//NgtYrSpXpHyqjzhsz4UeblZmXt
	nj2UQHeYlfqqGQS0gk50vzBhy0dUswU=
X-Google-Smtp-Source: AGHT+IHnHIR6XaB7wbflXZRiQ0JFmqivizpUdC2Lhwhth1eOHfuxYZPnavXHEde2JoCBJyWwXr/Kdw==
X-Received: by 2002:a05:6e02:1907:b0:35d:5779:4a5 with SMTP id w7-20020a056e02190700b0035d577904a5mr1160095ilu.0.1701459724709;
        Fri, 01 Dec 2023 11:42:04 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:d571:8cad:241d:7d80])
        by smtp.gmail.com with ESMTPSA id h3-20020a056e021d8300b0034fd4562accsm1262917ila.28.2023.12.01.11.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 11:42:04 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] SUNRPC: fix _xprt_switch_find_current_entry logic
Date: Fri,  1 Dec 2023 14:42:03 -0500
Message-Id: <20231201194203.20444-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

Fix the logic for picking current transport entry.

Fixes: 95d0d30c66b8 ("SUNRPC create an iterator to list only OFFLINE xprts")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/xprtmultipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 701250b305db..74ee2271251e 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -284,7 +284,7 @@ struct rpc_xprt *_xprt_switch_find_current_entry(struct list_head *head,
 		if (cur == pos)
 			found = true;
 		if (found && ((find_active && xprt_is_active(pos)) ||
-			      (!find_active && xprt_is_active(pos))))
+			      (!find_active && !xprt_is_active(pos))))
 			return pos;
 	}
 	return NULL;
-- 
2.39.1


