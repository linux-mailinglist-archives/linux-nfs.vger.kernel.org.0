Return-Path: <linux-nfs+bounces-13294-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D68F1B1466F
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 04:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6DF7A649F
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 02:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEB5217730;
	Tue, 29 Jul 2025 02:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NA4c40rR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB7207DFE;
	Tue, 29 Jul 2025 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753757016; cv=none; b=KVFulU80Z/eRonHINBmuATNnB6KLBPB1Nk4Twr59850zHqNyAGSwrHHpsixh4kuxVxcogAwDIWhHI8l+0KBdPqJ5o2Y5yDBEF94HwcbTgsYl0G4QGDWRO1VorLc0AU99oCbxxP1EgGhexGL/7baqJlhOuK7wKGw0mIX9XNivEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753757016; c=relaxed/simple;
	bh=MRfUaealSRtdSmAeJu0e/IqHYX9b2MdOPG/HupVSKUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6X4/ugbrwmcaNOj8cPQaL/sW8JCRl7EUqWwehsUMvioKY5MNmnVOfuZNVQKI12mn0E0zroX6qQQWNwfp0iK7tnRyqyCSJeHdnQQZfbL/Pxat0TbMMCfCXV/Og5jD24UslnllqXHCWP/zJzwZEOJKSNBTCi+Q455QpogyLeCOrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NA4c40rR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b34a8f69862so4282624a12.2;
        Mon, 28 Jul 2025 19:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753757015; x=1754361815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUc8kFhAV7hypvAgEkTcPRzYg5s34VrqAAtY84jsOyQ=;
        b=NA4c40rRoThnUi9QK84QpWE1AT+34ltvolNVaFTGVARaW1IGA8VgAda+wN/knBs+81
         FyhtCGLghYXzgct1LqFGShqORvlXpDIzj80SoPgJtCBySD4UXLyJbXMooW/xopNjDUht
         nUuGrWIxOU7tA0eXQyRuFrgVwaWncloKIIbcqtm0Lb9uBmhY1b60awJikje/WXVJy7nB
         F+DNGv8dw4SXZ5X5F0jBio7Pj2Qdcwlg+zmkLFMokvVZthC20PmQCKxpNQLND9iuSysb
         tivccKTErEFcyz+2kUowLfK/WzK6tsl/FC/SJTkG0adPdxby/T7XWAHSyDHUuRCkmmM6
         HIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753757015; x=1754361815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUc8kFhAV7hypvAgEkTcPRzYg5s34VrqAAtY84jsOyQ=;
        b=CCuFIDkd6P6N05fSE8ZyKzqNwaEncilnlgR4xldg0++TTg6Xm1d2ABwU2AUPMjb47x
         v8gpZwAAhNb7MtEaPlMLJdMdRKYBj22bsNudd4YWt9eG+qB8LznpwKj5noZxQ54wIhF8
         8LFeqkSsBA8vy3k7embs6qWpUb2tvPTxBwTobnXsGyHLZkwYH89MF8Wb6mNIhxymew0j
         sQHPKmk3cEgkLMelLBH6skiBMhMK0wF7yxYq248gi5N3E0F6CNdl7eyKcbLriLKIrFLy
         3whtgMZ/mAoZNkEA++nQEHCgXaCi3+r9pL+tSkISiM+yfBVHDkaT2Gr7f3OwbTsPqiuy
         gyFw==
X-Forwarded-Encrypted: i=1; AJvYcCW5G0ypzyZby7DYPBiExB7aeVXfrh331bQtPn9+ePB7n/EHOkrcMsHERM9LwcROZ1itnAbJcL/4na0=@vger.kernel.org, AJvYcCXFDc9KydQgoRM+9zFzmMRH3Bmf4EHYVdgoBObG9pfjlZ3CQZrLdDaSKfnQiG9WCgQM/KoPdGpF/QIt@vger.kernel.org, AJvYcCXhi5FMOYnk9+gi1DXqZN7fLjDGmKG1AbLxHN1fIzlbyXtsHbikhWfUqXJuSMpx6S8gKsbcKuZl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqqo3TQ9yZzsCVBb/PLOyRI1dqlfdOrzz0mefeHsCHW3rIo6bi
	rIIAVR99vevMZbpRNbxdDG518uFgHiNNTUd2k1hxrWs1YqQ8S+DDWoPp
X-Gm-Gg: ASbGncu4Y9HHJc+UyfUjw9e96Vphzmo4Vibj+mPnL/zXtD9+qSCx1LbKEo8G2/SHF6G
	24MUh8W7HxqV+ZE/8i2FvqTzgckvxN9nyaXMeb+PQi+8oOPFmAqVteyIL24AfzTMtRVHIcuykFc
	Nfc0DynzgqoKrefMlahCzDOFtpYOTLO2+Bf3f/wF+bbUOnki/Y/mgDNVSDZBSLgBO5vV6YesBM3
	cjLsgTuFuB62+0T6t+7tcJagysTPkMMkHvdNrRwuWzKfkJSuM0pKgO321izeWhdV5SLEzbrwJEZ
	ffMNrqkk3o49GDMX4+c8hcIkMJPwqnqvc4jVoNsAm0Z31bZ2qlyme48DRA/C372VLEHOz15J2wh
	G8+syoO6dlsQO4FMB9BSUDhdefg==
X-Google-Smtp-Source: AGHT+IGvnSnLVLEqZTFD+PzBwy1Cdk7P5Du3q9Qu7UOjqUQgKKgrycbGzQke7Edy0NFQh/gyLC2l1w==
X-Received: by 2002:a17:903:3b8b:b0:234:ba37:879e with SMTP id d9443c01a7336-23fb3178fdamr231355165ad.38.1753757014631;
        Mon, 28 Jul 2025 19:43:34 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fecd9ed12sm51327855ad.8.2025.07.28.19.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 19:43:34 -0700 (PDT)
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
Subject: [RFC 2/4] net/tls/tls_sw: use the record size limit specified
Date: Tue, 29 Jul 2025 12:41:50 +1000
Message-ID: <20250729024150.222513-5-wilfred.opensource@gmail.com>
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

Currently, for tls_sw, the kernel uses the default 16K
TLS_MAX_PAYLOAD_SIZE for records. However, if an endpoint has specified
a record size much lower than that, it is currently not respected.

This patch adds support to using the record size limit specified by an
endpoint if it has been set.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 include/net/tls.h |  1 +
 net/tls/tls_sw.c  | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 857340338b69..6248beb4a6c1 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -241,6 +241,7 @@ struct tls_context {
 
 	struct scatterlist *partially_sent_record;
 	u16 partially_sent_offset;
+	u32 tls_record_size_limit;
 
 	bool splicing_pages;
 	bool pending_open_record_frags;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index fc88e34b7f33..4c64f1436832 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1024,6 +1024,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	ssize_t copied = 0;
 	struct sk_msg *msg_pl, *msg_en;
 	struct tls_rec *rec;
+	u32 tls_record_size_limit;
 	int required_size;
 	int num_async = 0;
 	bool full_record;
@@ -1045,6 +1046,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		}
 	}
 
+	if (tls_ctx->tls_record_size_limit > 0) {
+		tls_record_size_limit = min(tls_ctx->tls_record_size_limit,
+					    TLS_MAX_PAYLOAD_SIZE);
+	} else {
+		tls_record_size_limit = TLS_MAX_PAYLOAD_SIZE;
+	}
+
 	while (msg_data_left(msg)) {
 		if (sk->sk_err) {
 			ret = -sk->sk_err;
@@ -1066,7 +1074,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		orig_size = msg_pl->sg.size;
 		full_record = false;
 		try_to_copy = msg_data_left(msg);
-		record_room = TLS_MAX_PAYLOAD_SIZE - msg_pl->sg.size;
+		record_room = tls_record_size_limit - msg_pl->sg.size;
 		if (try_to_copy >= record_room) {
 			try_to_copy = record_room;
 			full_record = true;
-- 
2.50.1


