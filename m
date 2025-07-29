Return-Path: <linux-nfs+bounces-13296-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 458F0B1467A
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 04:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726FC17FB2A
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 02:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0436621767A;
	Tue, 29 Jul 2025 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOW3eCtl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7230D1F419A;
	Tue, 29 Jul 2025 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753757042; cv=none; b=Ok4wlXioj+kXbAHDIpMzvFeK+Qei0uemWCh98SErLjX9IQbfDd9doqq73YS8wOpU+mslhZFuOiYAtlgxeVrlyEJSJiYMvmgIPAARN7cd2FT7CXZyvUXWDWLRDDDYCBOyv2EwZ4pAJ94tg3Qgl0I5Qv6chWmYEo3ETwgPoAjQrTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753757042; c=relaxed/simple;
	bh=EvYmYWtgKd8mjhgilzaDMPo8Q/bubDoA5KPliFrUEW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTxZv/w+mP7fqIQj8ut0D08b8/xNn/0ySyAeJJFjRoqqX/lL2UFn0sWPvqClILVifKFtMbkZOK9xCk6yKHnSiLZp06wBLu1cxDSL2TqiYxV9Txs/dRQAJ+8a/3iCLoMu9FevcNEiGcNc38kz12Xt/Fl1bvcHdO72MTYd3Dw5E1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOW3eCtl; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b31d489a76dso5258000a12.1;
        Mon, 28 Jul 2025 19:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753757040; x=1754361840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgt0RW1ytIxlMXzvFaCd3u+wuWOkXNFg3PALHarFCkw=;
        b=IOW3eCtlPgrnTCEy8mVt92olomZDUx5FFiYk3wVMZ1KausvJWhNk7GTwCb7zvH+RaB
         D9Oknfxdjjd+7MRaUAb+JqGyZd/h9n35yIvW1Rv/IaSFiVaUSSQwnwdfaGW0NDsYBEuQ
         4fU2CKTPQEQX6zLRFUu4L2enqyAisq3JTYpTRaSt1EjpWBf5+HynOxrYPyMyCHphbwtI
         zR71SmwUYkcLjVozgJ/ZEmJ7AHGuwdjJILsk8wmExWR/8nb5q1DFHRRuPz08qPapxtIZ
         8NMTWW5E8embLEE4GQhXJ+IT+Ht+MZbTfQjvl6vDav+yq9yu5/Ex/S8SRT5CJ70A+cP5
         Ieiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753757040; x=1754361840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgt0RW1ytIxlMXzvFaCd3u+wuWOkXNFg3PALHarFCkw=;
        b=gRHxJnoIpdj9HbZq8+so9XpmmJYijeUtSVKtaIWtsueW3IWrs60KgE0BYUClLF6AkZ
         h+YVcZ5hszA2gkwWVYGfOt0wtIxGUDq7fZA6zm6JzPcsc2Tz4u+wKd9erYrDpWVzF+qK
         jRdy2cVZHMPVFNeMAD7R8uKnbogt+WKgeVqaiRE5u/b4NA6tCzSm+lIAXkb4tnQj2b7N
         LjH6U6F/idjUb9c1LvDseJu+kR1FJRbfIXUo31xDq9CxP/kPNLKWJ9NeRVJJPdcy6lon
         J7kH1kAB60juEL8ELmQRqqzl0hut7cIRNRvoB4K1kFSu0eikLHUpUqehbnJsht2TtfOs
         p7WA==
X-Forwarded-Encrypted: i=1; AJvYcCVOJ5RBH7mZn1kfLpUYxvrz7KZQ67WGPUve6mI08vHzfEYAQSqG9nmZ8AXdI48/lIrEphT8xLD6Nucf@vger.kernel.org, AJvYcCVU7gs4PEpPYVpm1tguPrS6jgmxEmNonjb5rDXgEYlMbkKxcKn1Adi46wK36TscLuNzfRXfx7V9OmM=@vger.kernel.org, AJvYcCXNOwvEksKaXdPR2Ty+ZuW0wgcFPRXyKgf9WR8PrESBHJOy/Tswae/bL5zzyUjiM5A5b0DghXwf@vger.kernel.org
X-Gm-Message-State: AOJu0YymLxkdGXT7u0GFK61gOJHsqOXcxxhcPbhL9ecJbw++8K52RNyA
	f9/WMGLq7rHTa2NqlOU15mZM4VyEQYerh+Kmb0hFKydFoAzusJ8Q0VBZ
X-Gm-Gg: ASbGnctGFhwUWXnydzllaxKOzA9/waAkj64iAp7X3Ach45XL8T2J7xRC23gq4p6xEWM
	TR86/VhkYpPGY+TkxFx2pzxbgKPU14KqQ+W9tdVCZFDifRqMAsEk2LjMCD9gq/g7Lt+zC8o0GpM
	peToGCIEpnPMEs7qOmhRj693DQYjxY5JKW6IpXiIgDm7i0fubSTqMQE/6OLb9H3JhMIao9ljHGh
	c73fRKHc49W3NIIS1IpSrjNbw2TjDPZgvEKcxBXqSyZIYpYcuIwBA3A4HsRFwthLIMIFwOI0lRB
	1zu/ppOouKgLHNdYM4ER0VUu9e+TsjTSHaKo1OtWRyNxixziDVT5dX4tnwBoz1WCH0gpMNfjk35
	CMyPK+aGivtiTKZD7mryIpqq8sg==
X-Google-Smtp-Source: AGHT+IHoH2RqRBEpNTQOrmGzch5WJntLLn2XCTRa7EVmeo/2jrFb47DkbxUEJrAbw3CNGKSshrbO6A==
X-Received: by 2002:a17:903:98d:b0:240:44aa:7f3a with SMTP id d9443c01a7336-24044aa8419mr55052065ad.31.1753757040472;
        Mon, 28 Jul 2025 19:44:00 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fecd9ed12sm51327855ad.8.2025.07.28.19.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 19:43:59 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: alistair.francis@wdc.com,
	dlemoal@kernel.org,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC 4/4] nvme/target/tcp: set max record size in the tls context
Date: Tue, 29 Jul 2025 12:41:52 +1000
Message-ID: <20250729024150.222513-7-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729024150.222513-2-wilfred.opensource@gmail.com>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

During a tls handshake, a host may specify the tls record size limit
using the tls "record_size_limit" extension. Currently, the NVMe target
driver does not specify this value to the tls layer.

This patch adds support for setting the tls record size limit into the
tls context, such that outgoing records may not exceed this limit
specified by the endpoint.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 drivers/nvme/target/tcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 60e308401a54..f2ab473ea5de 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1784,6 +1784,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 					size_t tls_record_size_limit)
 {
 	struct nvmet_tcp_queue *queue = data;
+	struct tls_context *tls_ctx = tls_get_ctx(queue->sock->sk);
 
 	pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
 		 queue->idx, peerid, status);
@@ -1795,6 +1796,17 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	if (!status) {
 		queue->tls_pskid = peerid;
 		queue->state = NVMET_TCP_Q_CONNECTING;
+
+		/* Endpoint has specified a maximum tls record size limit */
+		if (tls_record_size_limit > TLS_MAX_PAYLOAD_SIZE) {
+			pr_err("queue %d: invalid tls max record size limit: %zu\n",
+			       queue->idx, tls_record_size_limit);
+			queue->state = NVMET_TCP_Q_FAILED;
+		} else if (tls_record_size_limit > 0) {
+			tls_ctx->tls_record_size_limit = (u32)tls_record_size_limit;
+			pr_debug("queue %d: host specified tls max record size %u\n",
+				 queue->idx, tls_ctx->tls_record_size_limit);
+		}
 	} else
 		queue->state = NVMET_TCP_Q_FAILED;
 	spin_unlock_bh(&queue->state_lock);
@@ -1808,6 +1820,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 		nvmet_tcp_schedule_release_queue(queue);
 	else
 		nvmet_tcp_set_queue_sock(queue);
+
 	kref_put(&queue->kref, nvmet_tcp_release_queue);
 }
 
-- 
2.50.1


