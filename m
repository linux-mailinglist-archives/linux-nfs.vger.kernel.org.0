Return-Path: <linux-nfs+bounces-3589-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A74790067B
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516A61C22C19
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AE61667DE;
	Fri,  7 Jun 2024 14:26:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A049A196D86
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770417; cv=none; b=n/tXIpuA5if/Jv6nGaDvmfQkVsrYw/QMgSps+qI4e3S21qUIO/X8QmGOmZSANmMvhigJ1MJoA4JwxlQuq6YWNftmmwY6Lb7v4580rGDWzYs/aNF6HPSMN1IccQH2jU7R/KYhakbMrFQkSlKxAR3v47psVOOr49ngP2YUeY3nj+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770417; c=relaxed/simple;
	bh=u+yVCJP9T4jRabDlRBh1bzi82OVp2KbIuVYJsW3DrLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teB7pguYV4SZMGQRCvx87FNFY+I+JL4oVddPsk/01COpTmYSJiY1ENGJIg/+sqK/Le5phnsynSjsz1myim09cKuoGXzoS2yfBe8f8CU6Pbt9sPXDc0PkbhWNoNZLnKRizFHPti+jeYt56Svo5qI+7BXnj51tgNnh2fowscuYvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b065d12e81so1348136d6.0
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770415; x=1718375215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JnT3G4DeJGwG2/GZlIatV03S1FH8qpV3l3qo6ydsec=;
        b=HiftXMhsN4lQPPIz0Hq+hWQbD2Pqs9pR5tQe2PtcstSPLlU8W/og72S66Yv9V/Nw7+
         e01GydgO2PhkJV08fgZnOZPXPRbUiTXKVwmZa4oX6F9mVHwpIH/QdkXK90OBe+M1FlKr
         Hqh+DApx+J6upb0uBfktRAwww3YYa6Kp6yzxrStUt1hZ1o5fS2lO2Tcg9sUbXumwo6cq
         KYB41+3gk1mxbrsdpxksubUyUuUnBxyxKqXpY2egM49YDXm51lUH0NWM0ZtxD8J5uO+A
         sVPCA0Q6DKF9hTdK7UhvmuraVeVd2FwYrdnHsgvklbiYlGUOP7dYSS2if1eQ6LJcOkB5
         QnHQ==
X-Gm-Message-State: AOJu0YxfSrzLEV7nWMn+RT8E2MFtM5ssv0Ueaq2FtH0Fz2YUJSJorL3u
	xDntFjclgYcgmYcWbGXjcDohCzWapMHlP8Y0IuAXOA2MzbQjbSDjhsiNGVk4tstMaAJdQmq55CU
	3KCUVTw==
X-Google-Smtp-Source: AGHT+IF9Kx+xVD4+KEHebSPKka6AdwzXrNq4LyeAinL7z/viJDNpDH+FdK5vC6iROqwEfTy+yqn/qg==
X-Received: by 2002:a05:6214:3c9e:b0:6af:2a4e:140e with SMTP id 6a1803df08f44-6b059f2fa97mr30962726d6.65.1717770414732;
        Fri, 07 Jun 2024 07:26:54 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6214d7sm17491406d6.28.2024.06.07.07.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:26:54 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 04/29] sunrpc: handle NULL req->defer in cache_defer_req
Date: Fri,  7 Jun 2024 10:26:21 -0400
Message-ID: <20240607142646.20924-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weston Andros Adamson <dros@primarydata.com>

Dont crash with a NULL pointer dereference when req->defer isn't
set. This is needed for the localio path.

Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 net/sunrpc/cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 95ff74706104..b757b891382c 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -714,6 +714,8 @@ static bool cache_defer_req(struct cache_req *req, struct cache_head *item)
 			return false;
 	}
 
+	if (!req->defer)
+		return false;
 	dreq = req->defer(req);
 	if (dreq == NULL)
 		return false;
-- 
2.44.0


