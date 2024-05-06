Return-Path: <linux-nfs+bounces-3165-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF20D8BCADF
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 11:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B33F2811F0
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 09:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F271A1422A4;
	Mon,  6 May 2024 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="eyGF3Tm7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F66BFA3
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988284; cv=none; b=U60wR4t5diCsLr4sPJobFb8rvoeRFUp3zyZOSSao53pzhFZk5km3Kog4YduyfgZSyq/cnLKrcbE/lfrlbMyzmrBdT8uoQe3opmMzLb8vOcjvlDA/L490TZBr08xxAWVuY821rsqg/toWnbWZgY+hg9AzkrQ5TtNKLWdGo5VJiLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988284; c=relaxed/simple;
	bh=6CdsEindACuKh5AJ+11kbksjh8RL2D/kNSB2HPq2I7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XeKOEnc5GRv19lesNkkUVXaCdRIMdCy1C94kxtZd6RAijc0se6tBApMCOSQS6Y7l2fCYe03I0QfsdIZY/dAwJxcn3DyaF59LsFiJPXvIvh2aw1DI0xkl0ga1T/zFROOzDnrMHFMqg6liCj+tsQjivBsTu/ikTBqDgoU9TE9g4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=eyGF3Tm7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41ba1ba5591so12190715e9.1
        for <linux-nfs@vger.kernel.org>; Mon, 06 May 2024 02:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1714988281; x=1715593081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/hwwuBoYXUdT5QU8PL0XlxCIznffGxvNaq3SFnRKKU=;
        b=eyGF3Tm7jJ5lgl9DYMIei1Bu/C/Bj8oZwYBLUDJ3agfaG85FSScVu+ADQ8ZSvF9KQ/
         9XSWA/VHNEJNqkpgFGjZ8DCXMzXGkykuYnRtSDC3Y1/QJSwNXNNiuTjqhrrLm7VEM4u4
         gXIUgCnli/wnfEzLacCDoOQ7fwD4yCgrqGtNV+IlisBn3qLF3CtYXmHx5HjJW52CdIny
         7Xw25wzhbDRwx+Qlq6QtIiZ89Drro7Uha35120Ff6j0V6aPM8JfgNzll1dhq/sC1uN9D
         JV86kwTw+lGrAnkTvZfts0xW0Mn13vCOXoMA3XAXB+/eDmGJq91J1JIPsLvdE4+7QCpU
         NREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988281; x=1715593081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/hwwuBoYXUdT5QU8PL0XlxCIznffGxvNaq3SFnRKKU=;
        b=FBTj+N1UNSNZ43b/eMJws5a9rP451zM1Rx0hNgqsztrJVD2YDgVL1hpy+dX0MupLPq
         sJrmwZzfcAncqRK0997JHTQVVhLidQRalfim9UYPkMx1bE+TXRD8iSwwJQ01F2YhipNp
         rtVejDz+reBBhNl80Q6cBDT4qbermr7L1eYQPZO9pkqH3oR7reyTsOo4Tnl2b6bqp/WM
         y5BTLBk42lgIQLOjrHfSpxxLX1Ysee1hkqna2bf63HgzfT949p+R6CyjjJWwfy5Y1XSy
         EweCSa87814XVpXci2AEXS99YixFFBP9pjXuse0SS/lMskmFIwIWuMn1fxpT8fdfyMku
         YdqA==
X-Gm-Message-State: AOJu0YwI3wsbvw0oOKF+sQiWhA0IJDwfsVFo2/iWDW0Wr2uxe96ieJsm
	46YRxQlpyggE10UszlobAhlUNk8YZ7wJLZKNMsNuqaQXGszQQNGJws5OMixdeug=
X-Google-Smtp-Source: AGHT+IFUFvr45EQW6GY0CEj7dXAwDeb+en/ZER8Ho3nXG6Pj+SXxyTIYsW9HhzvI4N2jEbmIzT5wFg==
X-Received: by 2002:a05:600c:458d:b0:41a:b8be:a0b5 with SMTP id r13-20020a05600c458d00b0041ab8bea0b5mr7128327wmo.10.1714988281469;
        Mon, 06 May 2024 02:38:01 -0700 (PDT)
Received: from jupiter.vstd.int ([176.230.79.220])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c1c0d00b0041be58cdf83sm15464160wms.4.2024.05.06.02.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 02:38:01 -0700 (PDT)
From: Dan Aloni <dan.aloni@vastdata.com>
To: chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Sagi Grimberg <sagi.grimberg@vastdata.com>
Subject: [PATCH v3] rpcrdma: fix handling for RDMA_CM_EVENT_DEVICE_REMOVAL
Date: Mon,  6 May 2024 12:37:59 +0300
Message-Id: <20240506093759.2934591-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under the scenario of IB device bonding, when bringing down one of the
ports, or all ports, we saw xprtrdma entering a non-recoverable state
where it is not even possible to complete the disconnect and shut it
down the mount, requiring a reboot. Following debug, we saw that
transport connect never ended after receiving the
RDMA_CM_EVENT_DEVICE_REMOVAL callback.

The DEVICE_REMOVAL callback is irrespective of whether the CM_ID is
connected, and ESTABLISHED may not have happened. So need to work with
each of these states accordingly.

Fixes: 2acc5cae2923 ('xprtrdma: Prevent dereferencing r_xprt->rx_ep after it is freed')
Cc: Sagi Grimberg <sagi.grimberg@vastdata.com>
Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 net/sunrpc/xprtrdma/verbs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 4f8d7efa469f..432557a553e7 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -244,7 +244,11 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		pr_info("rpcrdma: removing device %s for %pISpc\n",
 			ep->re_id->device->name, sap);
-		fallthrough;
+		switch (xchg(&ep->re_connect_status, -ENODEV)) {
+		case 0: goto wake_connect_worker;
+		case 1: goto disconnected;
+		}
+		return 0;
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 		ep->re_connect_status = -ENODEV;
 		goto disconnected;
-- 
2.39.3


