Return-Path: <linux-nfs+bounces-4793-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E33992E3EE
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 11:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EF9B20A2A
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 09:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B20315747C;
	Thu, 11 Jul 2024 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="IHWlugbK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF1156F39
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691955; cv=none; b=Oqh+01/p+cChYko98HFhaW2aB4TmExhG98sX5aaZRki0H5ue6hXOHConNRS7Pqcyj95fLIMDjRbGSnfjD5Nf+w7gzFDfezrvR0Gn39fj6LP4ifyRkmD5fE8uxZM7hStFBYwY7/oHyWELzkBHTVzRCbPPUz++pUez1IWoTilCQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691955; c=relaxed/simple;
	bh=MQ+7Sojr6KBt4qe6V+KdJq6Adpv93YUAocS4JZT4LRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HgHWpCEPS7xXJ2FE+ujTLoAwo2feBdaZ+hS2wAupFkwpxwYwBEOBqvOV49vzCM8tmw5uTBp1zwy9cHp8Z1HTFRj8pd+prmRyta26yfilQ/9VgxRV8oOBnV0OUhDBrLLMQWxPIsn6W4wbPpx78Ic/TMCElWV8QtOYaM0YQKdAu1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=IHWlugbK; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52caebc6137so573059e87.0
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 02:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1720691951; x=1721296751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GuuWVjlB0Cz7vUqKOIne/mXP7a2S7gB34xkezwA42A8=;
        b=IHWlugbKrgPbiAwBHrWOyL4bD0gbm5Kdk0vZ6nKfZeaKbedxgXbqqpJCX71cHpvDpp
         Shc8HDJ8/gWWev0EO+UqvvG2d97Zttdho7bjaJuUWwybxpg3s7oYUBOA5zLuihJuvzoA
         kET2HXvR3MndP8z1kHlO0Hd76mhcgAKL045keTeU8S2xD373c6BI72TFR0XLfX4LiJc+
         GfI45K1YOQtvDIbLoEPDpu6DLjj718h6aHWdJcZlwq7gEaIFQL12zpIUf6ELrNo8M8Js
         wrp7qq+6ugTIgybW+VUWdFiy6c15FKodNK1b6qdTfmrDiPaEx9yvV3EKKUGSc8iwBTFk
         OAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720691951; x=1721296751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuuWVjlB0Cz7vUqKOIne/mXP7a2S7gB34xkezwA42A8=;
        b=Lp4j2Gmkp61UghTEGNfOuw/cPVD04gjlR7OsM2TOgTQ3O17zyTv8/1jx0U++sF5e+0
         eIJH+qPblb8MT4RLAZVyx0YEL8u+r4U1pTHA4jVOLa7SdqIvwWZifnYtgRjqOrCcJ621
         2VL8byJrn4w4Tj8EBAP3LYiihLhKTjCPR57I3ECmzNDoV39m4NzIqGI4GCutqOVWR3NP
         4wREUmLgrBxZVQVJYIJpLn4dMtWsgX2h/C6HFYAb/IuUywzc3NLdXTOrPp/H1+7jsop1
         qnCgpyO7GMSzCVBk9yXiVBJZqE8B4KaFjVBPbxsH+dUqmi7bifUnG23dNpg9d0IaiPWK
         zR7Q==
X-Gm-Message-State: AOJu0YwFNvG3PgQqnusbzYXt47XMhGkzsEuUU6v8dPH47d4U4Yf/ADf2
	eIYxnKoXA0WOYh7QNYynIgzLiLd8NNrFm92TfLlWbbaohKjT4UZ7AIA12tKMZYWRmVj7YNLvcNP
	b
X-Google-Smtp-Source: AGHT+IH54NMvus/TRmrMfLiVkmV0kogw0GU5suMDAjQk7W866o7lzZtkL5UGq2FiElKLm4rQS0dV2g==
X-Received: by 2002:a05:6512:3c99:b0:52c:ddb8:6cfd with SMTP id 2adb3069b0e04-52eb99a0965mr5585703e87.40.1720691950659;
        Thu, 11 Jul 2024 02:59:10 -0700 (PDT)
Received: from jupiter.vstd.int ([176.230.79.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e187sm7374169f8f.21.2024.07.11.02.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 02:59:10 -0700 (PDT)
From: Dan Aloni <dan.aloni@vastdata.com>
To: chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] rpcrdma: fix handling for RDMA_CM_EVENT_DISCONNECTED due to address change
Date: Thu, 11 Jul 2024 12:59:07 +0300
Message-Id: <20240711095908.1604235-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We observed a scenario in IB bonding where RDMA_CM_EVENT_ADDR_CHANGE is
followed by RDMA_CM_EVENT_DISCONNECTED on a connected endpoint. This
sequence causes a negative reference splat and subsequent tear-down
issues due to a duplication in the disconnection path.

This fix aligns with the approach taken in a previous change
4836da219781 ("rpcrdma: fix handling for RDMA_CM_EVENT_DEVICE_REMOVAL"),
addressing a similar issue.

Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 net/sunrpc/xprtrdma/verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 432557a553e7..e42f5664ecaf 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -273,7 +273,8 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		wake_up_all(&ep->re_connect_wait);
 		return 0;
 	case RDMA_CM_EVENT_DISCONNECTED:
-		ep->re_connect_status = -ECONNABORTED;
+		if (xchg(&ep->re_connect_status, -ECONNABORTED) != 1)
+			break;
 disconnected:
 		rpcrdma_force_disconnect(ep);
 		return rpcrdma_ep_put(ep);
-- 
2.39.3


