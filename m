Return-Path: <linux-nfs+bounces-14929-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE1BB5E8A
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 06:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DD719C609C
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 04:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0D1D5CC6;
	Fri,  3 Oct 2025 04:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzEl4koh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A451EA7FF
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 04:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465947; cv=none; b=WU2+Cdq1eaqiu226TkeWjNG2em0EuuXlljenBYK5z+PfrFf6FgMTbrwx7rbk1n1m07Js4k77SbuMBRxezRh1rgwyc6PvFmVhLxRRc8K/tIQQjJpr0y6gDBIjggmyXJ7giNTapPzvIQPtrAaP6fuIhO6KvtooNEfREvjrVDuJInA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465947; c=relaxed/simple;
	bh=Bl1TRunIta5QQDe3lRPwonbH+J8i9iNM2VxNxK/XmSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwbHiafnhtAkmXL85s+tSjTkgI4fYKGihlcKASMfqKCy5y3Ujapbwfh68MVQw4mV5X01nk5r/rZe+4Hkz6NVxRN14c2qjRi+9gx6M+vS/WIoccc5kZKdCksEB4x7IMESj7HAK9V3I+9bEFQnoGsewSUJEfJpThzPWD42dSG8Xh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzEl4koh; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33082aed31dso2074938a91.3
        for <linux-nfs@vger.kernel.org>; Thu, 02 Oct 2025 21:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465944; x=1760070744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOV0qGYLCq+9ZQ//0z9A3z+3aG29/4P327MFfqw2xrc=;
        b=CzEl4kohMhiLGU72A5sArwP+L85QrX67hhJCG3zfczH5RdLXwJ0vzTKv8GqcLt/vu+
         1M3Aw781chc/cYYd/twjVhnvfx377c0fQo7ym4pFuL55xWQ+GxPGILVY1p1Q7YhqcI2n
         N53FYvgdCFEN2LLyxsaJJ7W7WQ55rWANY/ziMWRPFB7o7DiMbMaWx+kFVIWppCSpgMn9
         i11gloJmrGfnF656rGXnu19dPcCrSA8QFG9cc8iouylfpZZFrZlTSLx+ULenE+4rIrXR
         60LTItEVahVkLSp49+MPKEI7p995x4xnc4CGPdkhRULDj7et7w6cJc0yE1eqOa1FnIQM
         dqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465944; x=1760070744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOV0qGYLCq+9ZQ//0z9A3z+3aG29/4P327MFfqw2xrc=;
        b=UgP0RfPPYiEHwTxgzAKgdg1Kc4/oefgTNudZinMEl0es+sX0+A4hZwKLBZvX1DeUmF
         6K61OGtjhwE54pcb/WxOD+BXmfFeKiLlHMU2mwdO/Pbz67HheVH1MrRnL2MyhKtILoBE
         tBt0MxfVa6714asfUT1z284bHvjghmRcN70adBHmdgBOE0EKA/GL6NNdHdbOcMx8LBqw
         ThaNPMw8XGRdSj6bbYdNIkLYWRlGA0w3Hmpp+ceFJbsVKixZzGFcW0QmOf53KHqFmRKi
         8DtGaufq59l/Y41Zo4Bn7eiq/IJqE+RLpO9G6C4jElp71vdgX5lXuJ+CHLYhFv01KEdI
         +tew==
X-Forwarded-Encrypted: i=1; AJvYcCWzLIFYUlcDGIFhh9QxMN0AK+s4BIgiaRwvCOsxrTc3dpr/5Ehj8Z9uYNM/w+NrZv1xYTYXtGWcasE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze3Fqlz6CA3dB4+QSwLVa+7zf0NfKaKflETjTMkiYUkzg/pl3O
	1yt0EV5cdwOX0uvha2tuTV2OI13oEd6QA3+byrdwjr8e2RMAYW6LlIs4
X-Gm-Gg: ASbGncsfI5t20Kf8w+1njdLuYgg795LZHUv7JfUBxf+HIhG9ILKjxQmVt3OG6t7kqHb
	ubMfn/aklfCKqvZ6FXlqGB0uqSXKrQu9+a39S9VaNWoz6gZlLkn8OevHyMmd3Nkx7VT50bpOh0z
	iyLwGhYzbP7Tyh2IfLyxla2c5G0/JrGPxrHJzXB1r/OOqNUvZgZy0zhHFcxVRfviB+49k7oaTTf
	CvEhpOMYvape2glMH9F686g0Ma50StptzcjEHeB5oe6WQVb/DYHSJ1ngn/QdT9wOJy7Yl54AMjq
	sOqW9zniloeKQsyXdUDsfqPTyUNuVI7DIfBXZB/865YfXGfEOkkFI6Y9F0+kVUU+/xhk1PJnfp5
	/Sly8h5ymRiiTRmoJhy/mCbuIqONEKeZzY3pA6kUh1/MKvPfJ2NmS1scraxtN+Oen2ULcLkP8qo
	J5vTdFGGyrtIzmkTEy5rjYxwOHZaVSZS+gEhT8BTV7IJq+5enOr/VgtpuXVuXQLW0=
X-Google-Smtp-Source: AGHT+IGCDoUIKtDX/52HGaffkclK+hmjaIJ+Bue+zX3dUNN6Q+cAazG3rbJtO5YII+rQ/2wJMc8/6A==
X-Received: by 2002:a17:90b:1d92:b0:32e:389b:8762 with SMTP id 98e67ed59e1d1-339c264f452mr2016481a91.0.1759465944489;
        Thu, 02 Oct 2025 21:32:24 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:23 -0700 (PDT)
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
Subject: [PATCH v3 3/8] net/handshake: Ensure the request is destructed on completion
Date: Fri,  3 Oct 2025 14:31:34 +1000
Message-ID: <20251003043140.1341958-4-alistair.francis@wdc.com>
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

To avoid future handshake_req_hash_add() calls failing with EEXIST when
performing a KeyUpdate let's make sure the old request is destructed
as part of the completion.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v3:
 - New patch

 net/handshake/request.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 0d1c91c80478..194725a8aaca 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -311,6 +311,8 @@ void handshake_complete(struct handshake_req *req, unsigned int status,
 		/* Handshake request is no longer pending */
 		sock_put(sk);
 	}
+
+	handshake_sk_destruct_req(sk);
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
 
-- 
2.51.0


