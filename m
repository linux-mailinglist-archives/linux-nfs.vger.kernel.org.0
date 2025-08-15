Return-Path: <linux-nfs+bounces-13652-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D1FB277F7
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 07:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A831CE3BF5
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 05:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95255244690;
	Fri, 15 Aug 2025 05:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSVRoEed"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E2242D66;
	Fri, 15 Aug 2025 05:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755234160; cv=none; b=FE08mSO5WrG4q7uN/aUJbnrkAdcDmQCYUAU8xHYczFbUdwTYmXKqTnk7L77Rrjl8F5kUD1hWhYwZSb7onl+7+d3VQvssLlNhuImFZEops/puowF6tl/NmvF8UhiPr6TTsmWavdlx3YlfxqDsCdLz06UXSmLVkXnuwucFXw6q2D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755234160; c=relaxed/simple;
	bh=p67jO3RmrFN46SRVNjcEkPQJCdnJd8+gbJzoHF2fRPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1qS5IbkKRJghLJoMSF75aGDEqCEGEy1zA2hgVrCVB7t283P4UbGWGA4xp9Jat986Tvc+VVsLE9V3Etv96AnhxKu5XqBbIkk5dXyjvsHvS73eZTX3guDjjSNkjmu86TYcfZfAxwLnQdtgtrSb/earA1nRaQBZ5gJsM4f8EzphVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSVRoEed; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-244580536efso12140465ad.1;
        Thu, 14 Aug 2025 22:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234157; x=1755838957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KvInbCUt8tTGLRjQNfEmbBCvEDs8pNQ8LImh9T5E8A=;
        b=aSVRoEedZISMoqLhYgXrzuOjMiMhUUCRV8I/nefbrSOn7JVSqWB6HZ54P4V9FKuGdu
         gDioz6OZ96Hy7RJeNANsJReSE8t0PUc9X7ok7D3Q0ybbWDXRZO59M+UsO50xA7XHVTuV
         5MpZxiQNSqJsn0EO9ytlgCVzVbnfyyjwbWVRAqkzoQTbWJ36NmRl6OrBWcbfKcUcuVMl
         4wrDx5h/AOPqdAmM7r+9B27WrpJV+aBY2JGEWghcQPuzhDzO3WrhnAkldKhdrQOG/FYb
         L2HqdRUwiPfX70cimUc6cdQ/gfgr1He9s1wrAuryBcFsYLG6IN819GXOP18C1ybnMmqb
         zz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234157; x=1755838957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KvInbCUt8tTGLRjQNfEmbBCvEDs8pNQ8LImh9T5E8A=;
        b=uFxVc1XkO4nDRo2mVPNjV7KVZSUXt3DKuFHZ1/dU5vIIoC1uDV+qkOgaNnfkkgkirb
         fGtFm/Bidzwgpqo1pGIjsW4mqRRoidlJkNNUp8uZ6EO6MWiyUOU7Jumb640iTG3/m0r7
         qQRbv/ffzvjHExfF3TTVE2JpQgpWxZ2oCoVC9W1yd6O0Y2qmdSDYU8o5/hyI+hhk53pO
         iTrEn3p0nAAFgMexFSznxuHLLkIBnYvDEmLWBIOk4drOxyfK4FdArIT4DCUZhUiw/naQ
         /58B9zvcvDdshnvfj+VWYgNFFwl7TfN2zCVyovxieQtCUQVwWbl7cvB6Phh3+AQHoqWH
         7d6g==
X-Forwarded-Encrypted: i=1; AJvYcCVVdc/NCbyojIZ1unWroQnCMpI3oYv+x38CLef7bNMYRozgRLn3yfIizeKZtH7RV8/8ScQK/Rd34C4Y@vger.kernel.org, AJvYcCVa+xLnNcARgj0rrL6+VXwM4a7JJQ2M8QTw4brG0qrvXquL3F4OMKPeWUJo5OvpsSNXRFmH1TaM@vger.kernel.org, AJvYcCWMHzoDlrE/pEBUDn1mhj/7ubdgVNK26yU+g5EZkW08KnDmEEo7z/30iRzIJemadHfflVvlfpmZYW0=@vger.kernel.org, AJvYcCXQAvenIjxHRTKCk4wNfTyiVwolWiFNnLAYEDD8w3QBT2jilFaXoNCQmll9EZoBj5EFbfrMAVGrYIDg+MLm@vger.kernel.org
X-Gm-Message-State: AOJu0YzaGHdfxbHQh64kBzYy+CfSWAtWyBKkMPNUzc3SQOvwFFxOiinm
	m+7isNjYjNIeFA9lpL2zDtHk5SL6mRZWnuc6rkFxukxULp3WEJ7g9gX0
X-Gm-Gg: ASbGncsIfdyoBAZr381WP1lY676nU5dq7WhBgxfopB7nqXzRDs6huZ2UeBc4w9A+J4o
	33i7RRJtEdWvjh62Nv5r2dSfycBZa0IAUkbEIV9fy7uicoGUf/XUTpITm4y/DUJxuIdp2QzB6H+
	vY1apUTeyOOeLHgIrX6e9Qg9yymZiqtFvPAo4tdkRfXZlIO2ee7Pghin1soY27smOH+N2Cu7Xze
	dJYBP53AgV8VDY+TPt6x20bIOLM3B8Uv2zGRDxccu7r2nYsmS4nM+56yHsttCBNmlivEZrCx11I
	26iaCTJlg3I9ibxfdLVmjJXiHnJCAwaLNQ75RnLu+LHfSL6ueZCvP5+C8TeUvn2JSIBCHR2On4z
	hGKhl7uwndft3JwzK4vZtLhS3775ZW+ExLENhOgR73Ua9KQwlXROMrBMD9tzyMF8hXMxbSjIFJa
	WjrUvprhheegj+TFVr3OfbiAC279g=
X-Google-Smtp-Source: AGHT+IFH+OSkE7l+lj2EnSVnkTcqL9+YMNtK2tre9BkCjoc5zJE0Ky8LTNiG//ckenUsfyTJOUv3vA==
X-Received: by 2002:a17:903:2f10:b0:23f:f074:415e with SMTP id d9443c01a7336-2446d6f108fmr10850335ad.14.1755234157302;
        Thu, 14 Aug 2025 22:02:37 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53c6e1sm5128645ad.115.2025.08.14.22.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:02:36 -0700 (PDT)
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
Subject: [PATCH 3/8] net/handshake: Expose handshake_sk_destruct_req publically
Date: Fri, 15 Aug 2025 15:02:05 +1000
Message-ID: <20250815050210.1518439-4-alistair.francis@wdc.com>
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

Define a `handshake_sk_destruct_req()` function and expose it publically
so that other subsystems can destruct the handshake req.

This will be used as part of the KeyUpdate to ensure any existing
requests anre cancelled and destructed if required.

This is required to avoid hash conflicts when handshake_req_hash_add()
is called as part of submitting the KeyUpdate request.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/net/handshake.h |  1 +
 net/handshake/request.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/net/handshake.h b/include/net/handshake.h
index 8a64729614e1..fab4760049c6 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -43,6 +43,7 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
 bool tls_handshake_cancel(struct sock *sk);
 void tls_handshake_close(struct socket *sock);
 
+void handshake_sk_destruct_req(struct sock *sk);
 bool handshake_req_cancel(struct sock *sk);
 
 u8 tls_get_record_type(const struct sock *sk, const struct cmsghdr *msg);
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 274d2c89b6b2..bb727a9ad042 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -341,3 +341,20 @@ bool handshake_req_cancel(struct sock *sk)
 	return true;
 }
 EXPORT_SYMBOL(handshake_req_cancel);
+
+/**
+ * handshake_sk_destruct_req - destroy an existing request
+ * @sk: socket on which there is an existing request
+ */
+void handshake_sk_destruct_req(struct sock *sk)
+{
+	struct handshake_req *req;
+
+	req = handshake_req_hash_lookup(sk);
+	if (!req)
+		return;
+
+	trace_handshake_destruct(sock_net(sk), req, sk);
+	handshake_req_destroy(req);
+}
+EXPORT_SYMBOL(handshake_sk_destruct_req);
-- 
2.50.1


