Return-Path: <linux-nfs+bounces-4794-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A21A92E3EF
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 11:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5687B2105F
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158CC15748C;
	Thu, 11 Jul 2024 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="QzPK4vqx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAC4156F55
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691956; cv=none; b=I+lmHm+vKNp+QUtDM9SarN9DLpE43fCTAh0iQug+RKXuW/rj4XGfUGcvD5ETttUgyegSsghshq1UC6vRi/4Khzi9MrGje6BQWUQqMEbr6xWrdJs8pupsIcacvXHRm6g45KnIKqNm1u6TJFOQjHnmfhgWN1rZrEjs2mhL8DgY0Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691956; c=relaxed/simple;
	bh=Md+1QMeKZTBCBzMvkdMXIwpGYRiLBpyJGgclFF0kO1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GCuCzqkvBm72OJKWBRydmLUjXhsoyKucBLKtWuFFqsnOnEYkmRPYjy9qxVsEkHxcIy4FMqylCu1OQOrsf7PBbEqDGs789LCVwHLlksHxHb//NCpsGYmEW0bowdhclrZOZliE8lttzcPycWe36sV7UhDCMhNcDcT0NBpbf4on/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=QzPK4vqx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4266fd39527so4887675e9.1
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 02:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1720691951; x=1721296751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiQWTkqBEvhamo2Q6nsLIxUCUX9Zp2ETDsaUOBT8mt0=;
        b=QzPK4vqxhI0nqtBDIMHv5afpLbyMIMakJdfyVba7o7tNW6I0bNvFgHFOTldJ4MF7K+
         8V+kYFanlenlFQG5AEnJya+5CjjtBl2ut4OWAgy5n038Wpkr8XzRvBUEKViA6uv8eBky
         SNwJE72fD0Gxf4DtaMK6BzbUNVxTI+UXD5P5oXJdKZBXfIF9GA+hhAmvA15hdCtMjgUZ
         I9Kt4xAzkI75ldd5OLlut6NrNKMkGEr8BV6sfs1CqZ7gzLOxFvaOFKjrO0QsmEKDKWSi
         9xl0RZjEjU2KboMZjNv4n6tREKu7kN5gaActgvXICfwnXqShj+Wocifn9SOK8plJ2r6o
         K6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720691951; x=1721296751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiQWTkqBEvhamo2Q6nsLIxUCUX9Zp2ETDsaUOBT8mt0=;
        b=KJ5GB3YQZg72gPv6WPtw21cNmMxWivKp+0/uOjmRy3Yth1hyEz8Hp/xkH/oeLjrPit
         EV/8ybtVmO/Znmz2BA8o8lUokKvakDTtFRx8rhD2dT9IHe7S+L/8vUtG9dyi+fDIvKqY
         TBxX+5Uq3g2s8AbMwXwbBp6YnIwjaLvuYQn61h0otVBE5k16jSPQHECXkrb08wDDHN9u
         H/e82lc5W2/W8HZD/GX7zICsT2bnIadTm1j22IC8BjOiGZitsL+2Kx360Bu6kX1YniIs
         r4TfH6pQEzaaiXPAVunflcr5zWPcOc0qT4LTJPRcSauVV5yTjloswHujMlr17XiTe8S3
         7BIw==
X-Gm-Message-State: AOJu0YwdvzaEn/K6ohjFdXBmAGlsG6LcA5kHwRTn7hYbvgL04DKCQEwq
	hoAlZrYfY48RxeCzrVf+lh+1WJxDqo98bVmSnV90wygNuTzKYJFk0QRns/gl5HPYM4cz7ttETZb
	K
X-Google-Smtp-Source: AGHT+IHnIV5xbmd/tbeiDuCcls6qw17JHHbry+iU2e8py3mni7JZgUPRbLq6+UIoH19Hpc+CiXbW9A==
X-Received: by 2002:adf:9798:0:b0:35e:6472:4390 with SMTP id ffacd0b85a97d-367cea6b7c9mr5218564f8f.27.1720691951684;
        Thu, 11 Jul 2024 02:59:11 -0700 (PDT)
Received: from jupiter.vstd.int ([176.230.79.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e187sm7374169f8f.21.2024.07.11.02.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 02:59:11 -0700 (PDT)
From: Dan Aloni <dan.aloni@vastdata.com>
To: chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] rpcrdma: improve handling of RDMA_CM_EVENT_ADDR_CHANGE
Date: Thu, 11 Jul 2024 12:59:08 +0300
Message-Id: <20240711095908.1604235-2-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240711095908.1604235-1-dan.aloni@vastdata.com>
References: <20240711095908.1604235-1-dan.aloni@vastdata.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It would be beneficial to implement handling similar to
RDMA_CM_EVENT_DEVICE_REMOVAL in the case where RDMA_CM_EVENT_ADDR_CHANGE
is issued for an unconnected CM.

Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 net/sunrpc/xprtrdma/verbs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index e42f5664ecaf..0342a0527733 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -244,14 +244,13 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		pr_info("rpcrdma: removing device %s for %pISpc\n",
 			ep->re_id->device->name, sap);
+		fallthrough;
+	case RDMA_CM_EVENT_ADDR_CHANGE:
 		switch (xchg(&ep->re_connect_status, -ENODEV)) {
 		case 0: goto wake_connect_worker;
 		case 1: goto disconnected;
 		}
 		return 0;
-	case RDMA_CM_EVENT_ADDR_CHANGE:
-		ep->re_connect_status = -ENODEV;
-		goto disconnected;
 	case RDMA_CM_EVENT_ESTABLISHED:
 		rpcrdma_ep_get(ep);
 		ep->re_connect_status = 1;
-- 
2.39.3


