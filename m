Return-Path: <linux-nfs+bounces-14928-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF31CBB5E7E
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 06:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6751619C6088
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 04:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9F11E8324;
	Fri,  3 Oct 2025 04:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkI1BWbA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5D1E5B9A
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 04:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465940; cv=none; b=qVFW77WGcKed4hHgNKALZV2L7Uwle8M61rVFA+uQFGzuqzZ5+MX8kC3c4TLcDI5L7rX5LeFPmZSx8zspbAljqUGMf7TSZEHS37iOsOArHfbDV93sFZCeg1hCfLTkr7FXfz78P3nKT/OFAoe546y5FzrZp/99x32zSmMYBd6mR0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465940; c=relaxed/simple;
	bh=Z6w0x3oPOM6C3EiKqL/1mOmpceuMWimWzPhFuNGO/7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rnr4xq1Lu6kTjw4At2PCRTfn8bHBTZ6qlAYJEsWJbrvh51/ZZiS2HhFPkW5gob+uVpB3HD6WnKgQ/8CJ+9p1Y6lztin6LUsLbAVGKd+pevH7/oE8HRnokateZt20WB/G9zkYWHfkaZb/8dDG1Prh5bcteFbf8EjwMcFTuoTfEf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkI1BWbA; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so2159219a91.1
        for <linux-nfs@vger.kernel.org>; Thu, 02 Oct 2025 21:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465938; x=1760070738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9morpPQKu8lXMrpuy/uDVQLBubkYtfu9D8D3JxjNjjM=;
        b=ZkI1BWbAYYeCs965+UolecO0r7VtgGHULzfHhuUUNERxLeJJLX1pHS11sWPeUkfU24
         ozpWNjAOTltHmvJQTLHFw0FFUCek/aA8U+RqPdziox7PN6MC7LMcX8ZCuv61JfvQuSlj
         uXGHw5y2pSt+09zP1WguikSu83BQERTFgjCdk+v9h0UiQ+/ldx76eoDBrAdgu6E95VVo
         iydUyuRwzcs4pJ3rQ38/SJiJpFWYZsZ7V8tnfDZ/YpBlgMlYs73nbTcHliaorwXyRKBR
         2W3I0ZxfvuE+1jJtL0C9W4YhVucgCBmLn7LrDdMJW5c/Tbrv08sgOo8Wygg+EjDUIqSi
         xx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465938; x=1760070738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9morpPQKu8lXMrpuy/uDVQLBubkYtfu9D8D3JxjNjjM=;
        b=Yhm5iIqdjhi11XJlwBsBqvOJum/J4Rr96d7WvEPsD1IdM+LW82BgxMY3+qrlfgtMVM
         GwJ0IkHdT/+4+TEyL4DjSFaymmwVOxAuwvFvIG90g2lWH49vhs35IkLmaGGBO0ceg0cP
         bXTVo4QndplBEb8A320pCSipaIdkquX1qqV88Zd4MjimfkUm4PgDYSTebWevNiH/mjQc
         tpPOD2Tt1wdTRyO9uSySzYJVD4ohKVVlOHlUZ3ax4e28Bl1EXJ12otfhctHncdo7imx0
         J6GIOrfeqCSXyuO4PMx7RSgeVG1Wj4WCiJjl5PC3LjloCkYM3Qo4bV9Eou37dDvcL9Jt
         mTnA==
X-Forwarded-Encrypted: i=1; AJvYcCXRzxPPOK6bM6g+g4KkYqdoDYxH3jXEk5aNkAd5xWXwNxr6oXMrOd8jRLpJhjXZB3DJKM8wqTL3dN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNWCZ5ylzDowXbKN+xDmaFl3vWG04UDmb59OrfGENDwfRPM34r
	RcZ4f6EK2MI2sxoYmLmSKpk3+f0R+qdCUV7K1vSUU21BzITW2hEzpxTT
X-Gm-Gg: ASbGnctSxwZjRrszegUQKdJo5PNUz+eL1nA8XF4G7sZkHbhYemitODuGFr0jdcDtVzp
	0hF9cVxIHvhpEnNQ2lT4OEIB++GsDvUkNVzWZbmQp45k9x6U/zuRIm2ygjlNsARKPwF2bkw4Urv
	zK/DD9uZmOgm1UuvXQ52w9OW7RmSjFon5iaM8v2SdwyDPbjCM4Ko1OyKf5XyEakDxArlzTj129Y
	69g3X8e4gBReit6C1p4uojq3nPl3Wp0N8idLvoSe4cBj3JVDX7qPxbStpAgEVyyMsFblvsLV/5X
	ZTylO9sRNKSrwa4zLcVMtYOYaZ8ou5fNzMJNA/tQ9V8KHFs+fXkQSQFYTrcwipGs7ZYQc0IseKh
	S6eyKwk9lN1rvh3Us91p5hGEPD9MHmDx4Wh0ycCce+VxPcHAAr4pzyz3xSTevXhqHeOuYKEalym
	xD0NCHAXmYHalsJ03TkKJON9VUy9O0aHscZLmqz/63I419HCxWzFVk
X-Google-Smtp-Source: AGHT+IHs89hKTsl9/f/m+plS3Ev8/2NixvjRvxCPx92Pgo3FWsBpoEKCKAbX01MgtOEvv1xzIjE2Cw==
X-Received: by 2002:a17:90b:4b8b:b0:335:28ee:eebe with SMTP id 98e67ed59e1d1-339c279e977mr2022144a91.30.1759465938258;
        Thu, 02 Oct 2025 21:32:18 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:17 -0700 (PDT)
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
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 2/8] net/handshake: Define handshake_sk_destruct_req
Date: Fri,  3 Oct 2025 14:31:33 +1000
Message-ID: <20251003043140.1341958-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003043140.1341958-1-alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Define a `handshake_sk_destruct_req()` function to allow the destruction
of the handshake req.

This is required to avoid hash conflicts when handshake_req_hash_add()
is called as part of submitting the KeyUpdate request.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v3:
 - New patch

 net/handshake/request.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 274d2c89b6b2..0d1c91c80478 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk)
 		sk_destruct(sk);
 }
 
+/**
+ * handshake_sk_destruct_req - destroy an existing request
+ * @sk: socket on which there is an existing request
+ */
+static void handshake_sk_destruct_req(struct sock *sk)
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
+
 /**
  * handshake_req_alloc - Allocate a handshake request
  * @proto: security protocol
-- 
2.51.0


