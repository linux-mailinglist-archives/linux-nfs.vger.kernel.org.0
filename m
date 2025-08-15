Return-Path: <linux-nfs+bounces-13651-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 873E3B277FF
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 07:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527FAAA6007
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 05:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AA9280037;
	Fri, 15 Aug 2025 05:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePQF3L3Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B825A640;
	Fri, 15 Aug 2025 05:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755234153; cv=none; b=kSXlt6QFSRjz8Yi6LW8dnhXD1w5G2x0/wqvCNiG2Yfp4U8xvDbjTNMi23OHLirEwASjaHivjKBqKg8Qkyhi62wO8vPNUF6CwWEuIejAtuJ+FIYb6/ltU+DbKMulhPZ8U0BigtGx39QOvF8Z/attPypCqO4XT17dxXUNE3HVQ/s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755234153; c=relaxed/simple;
	bh=ta+733zRJHmJJTLpgqTURHJaDH15kMNwSBSlgc7Iz8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlyQmh8dNARryMgSnAB3Uz5NDkd71mLMhNFsaVmovH2sSgx71m3m1pYAHU0zVN37vg3a8b3VvZAakC0b1pivg1HgKO3Smeomjr2f4p77XevsapxTyFRT0jA8xj7x6SNBue1G7mWtCInpWIzIfigw0DdeQT5f1yVUdrfAfMjxWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePQF3L3Q; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4717553041so1304477a12.3;
        Thu, 14 Aug 2025 22:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234151; x=1755838951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bYaR0txeJQ15MO4CAHzNGe+lgnMf7tAMLNjm+q8B+g=;
        b=ePQF3L3QW4dfRfjGE3IYMM8aEYbqGSy/V3QUdoAsdGGY5HaUJsFf60QGfzSzf4crAP
         +Wg9BB4u5VuRsia9hXOomIajUMP49wuME6wQkJAS7CZ7NCk42vrZQD0xCLzBJIz+L0UZ
         HFu5V5Qv3FuL7obOfGBktm7otVD6GFpat5mRxDKflQpkxvLBCBTQTlMNCqeJEa/S+/Co
         4bZRV3TpUKqU35inTkgZ5Wr3drXV2BGeaQM042TunRMYLWcqMy9nEjNWtRrYqqnma2oP
         QkwoATEXmF36MOnJ9eBqD4OZzjvVyHt6bLNJJtwd5iM1RcBO30Iwfc4gYoRDvcL9POKO
         LRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234151; x=1755838951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bYaR0txeJQ15MO4CAHzNGe+lgnMf7tAMLNjm+q8B+g=;
        b=OFqZhgVi2KIP3IF4M89igG4iNnv6Y0HGH998ZOAL2z7R1wXlVNiOIdj2BfvGl6X1nl
         TWrY+rCpiT0N0wFQhn3VDR8CnCMvUDZem8q9uvAsnpNLA+UyF1hQKocwwHiX4W7ufrdu
         TnSA9EApac0DhHmoUoBUscSZAeLd2c6ZOd40cvnDnHjEn5oCc9z+TIEZGSQ2vKj2ynTp
         Tj+p21hVqd0OvcKtWo+MDoo4Fgy6WQBLzorZ17FGBQpqhgkCrpZArf64S2yalFN52B5A
         Df1hB6WodniUhPAOZZqBzBAQFpRfnk1LO00AQsDqWDTh34Drink1pQnYVuxlPqZWqGQd
         E7Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUSzDBIdqP2FuTC4WHKgAgET+9HcoutfMOIpScSQKYia1R4rzC4vSqKNxWUjXixqvg8+bfc+XO8@vger.kernel.org, AJvYcCUbXRxP7RRttGo75oEcVZ8KuOJtjf5MP9QYXe3TdanmtZ0xQkBWKBcRLrru0xDAQ97WlOWVnQo6esCJ+vzJ@vger.kernel.org, AJvYcCUfNkAvA6gREYsUQ3h0Ac5GO3xPR4yefkjXQfj09cPsDhJShXQ6y1RaAUSfnu4R+HhbCz4GeBLNj6J9@vger.kernel.org, AJvYcCXATlFdoKsuZIgvqB9fVeVkqOkAeEtNIawdPHQIDgXnqY89jdFgc4q9gqhFQqjlUBVjZ3c0/RiCEzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYs2ovGJJgD8PDvF6tzBOn0y9IlVgwLkyqomAWdx3Rx51LmCAX
	N9ipUg8GZG/dWhS8WIAN5eG8phsziK8sTodMOfNYHVxF4hqzrL+q4WzG
X-Gm-Gg: ASbGncvZIcjgjbDt+Vtq6X3OOH5+vCA+WZskBoO9t4Pq1FjwxsBBsQlqAP59kh2HjQ2
	yuP41NL7YiktYIoXVGj9rFDV3zngi0KPAWvkDHmEJz69ASP+5d6FAyGroC0JLrgNdis1GPb8amf
	qkxcsegCAvhVWHYLqC33zOEymZuz0mCNMYqhQPD+RzgkucZjTkf+lFVi6ECU5FJrpdzfgLiz6XY
	+RHGwYfacqnY2YQCay1nPz7evqv/iaaDByGIcYldSwF3rn3WP3A5+gPzqq+UlFwqhOcPtejb85k
	HQp8hfd+vbBN6x6ghFu2mO+36aBmPjEboAlzjT/qHMVzCrI8U2HbZ/WvCbd8I4M1fb/FEt/YcmG
	nJf8PmPeU/bTHzdwgR9fTufDUJKX1mTv43HShQ3rhCi6xfMU1XaekZFOXGQbN57ncpL8nXY8XdC
	0AobcjVl/NH8pbnYBbHPKBH0QWZmpkV+5XNjwfCQ==
X-Google-Smtp-Source: AGHT+IHbFa9wi3nz5/xQeXOUNqL7qBn+//4+UspNBNAPh8R+al2x4L9A89Rhs1lRGLSwUr5VjjqL+A==
X-Received: by 2002:a17:902:f647:b0:240:a504:cb84 with SMTP id d9443c01a7336-2446d865e0dmr13064545ad.30.1755234151526;
        Thu, 14 Aug 2025 22:02:31 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53c6e1sm5128645ad.115.2025.08.14.22.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:02:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 2/8] net/handshake: Make handshake_req_cancel public
Date: Fri, 15 Aug 2025 15:02:04 +1000
Message-ID: <20250815050210.1518439-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815050210.1518439-1-alistair.francis@wdc.com>
References: <20250815050210.1518439-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

As part of supporting KeyUpdate we are going to want to call
handshake_req_cancel() to cancel an existing handshake in order to
instead start a KeyUpdate request.

This is required to avoid hash conflicts when handshake_req_hash_add()
is called as part of submitting the KeyUpdate request.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/net/handshake.h        | 2 ++
 net/handshake/handshake-test.c | 1 +
 net/handshake/handshake.h      | 1 -
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/handshake.h b/include/net/handshake.h
index 449bed8c2557..8a64729614e1 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -43,6 +43,8 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
 bool tls_handshake_cancel(struct sock *sk);
 void tls_handshake_close(struct socket *sock);
 
+bool handshake_req_cancel(struct sock *sk);
+
 u8 tls_get_record_type(const struct sock *sk, const struct cmsghdr *msg);
 void tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
 		    u8 *level, u8 *description);
diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 55442b2f518a..c338b9977a71 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -13,6 +13,7 @@
 #include <net/sock.h>
 #include <net/genetlink.h>
 #include <net/netns/generic.h>
+#include <net/handshake.h>
 
 #include <uapi/linux/handshake.h>
 #include "handshake.h"
diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index a48163765a7a..55c25eaba0f4 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -88,6 +88,5 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags);
 void handshake_complete(struct handshake_req *req, unsigned int status,
 			struct genl_info *info);
-bool handshake_req_cancel(struct sock *sk);
 
 #endif /* _INTERNAL_HANDSHAKE_H */
-- 
2.50.1


