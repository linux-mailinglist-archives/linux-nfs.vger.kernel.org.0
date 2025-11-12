Return-Path: <linux-nfs+bounces-16284-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381A6C50851
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 05:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CECA189BCDE
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 04:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65592DA74C;
	Wed, 12 Nov 2025 04:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoE6Xg4Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1A22D979C
	for <linux-nfs@vger.kernel.org>; Wed, 12 Nov 2025 04:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762921700; cv=none; b=OwhAQL93DAQrGMdVMIC1DBkjbZDdlO248ze8wo1n2Goexh0ZWfK0jENlLjZbSKCpc+rYoWdos+mZm7F1bIY2rWdd7H87a3k26lQYzYze4vVa5BXw7L4Q3d67aXPnIOe3vsWWjPTjtc3MqbonR6q4URZt3+JDTqL6900WiYYo830=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762921700; c=relaxed/simple;
	bh=jaHChIsFwQccM67eVRPs/t3TxiMgA+k62NpjHrap2Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BF7zl94VsOzAFM/q82LMxlYdpTYhiRHumBRiL6xzw7CFOdEo+qwpT1LybgstRiAGoHGENr7Ji6+/Oi5/44xGIqwNaGQgzAd5GwwhVmViZWVadG3WdvcqV47HpE2qM1aip63OFVl7cpgphzBLPrWlikx5meguksWpzsettmg0vhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoE6Xg4Y; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3418ad69672so290763a91.3
        for <linux-nfs@vger.kernel.org>; Tue, 11 Nov 2025 20:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762921698; x=1763526498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfXE4RQsTo13oDtpS18/YqY50MP5ENyfIi78Z5opJm4=;
        b=HoE6Xg4YO3Umx5sJsEPhcNawAdjSYIbUpnrsed1+S0199rZk+FR1EoJ05G27zsSV1D
         UyShQv71scLUb6Vc9VZnQ4PA+aHxA8KOThr75eQAWCOfVsclvUyRnocbyLKQaION8e5i
         ugAw7DAisys+tRTUtRAZiFOWw2ebJSalNIYMUFgl81u9aMO6LnHJShoHh+a9MfKYhjNb
         /zq349rCkoAYeqx5jm4W1nZyNKhaMYEuIe7L9mjwiMWYNWT8VaTaLM5eeSDmk6ao3rHP
         5x8STq0+j7NmQOMOcRQsO/2zHwuq4CKefPlQ9zoasrzvYbna+nSTVgE6ExVuc7KNb7cX
         xgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921698; x=1763526498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TfXE4RQsTo13oDtpS18/YqY50MP5ENyfIi78Z5opJm4=;
        b=N1Zy6DAF5yr0HCUBbzrNSYpTcfJZFKcH2L9Vtv3XIfUAndiie9vf1z7ZOfuENM96Cn
         Iha22NOR9k5grkSA2yhlYM/ySTGMWkxKZcls6zTFAzRXF6Tr89nrQOnRz89KLUmWhOt5
         bm2BnBCfmS1huT46COkYgKnmNr3k+ZesN9hNFmQ0MocxGnGMao5EVHYoK1dCOKxEnY2b
         m/EypqWqMJ7pc6juh0uxz5CmVaVMeqXG2qkuB31FrGXx4BW9U+APA/ENtKM4u5uyJ4jP
         vLpTThvlepdgIJxKFcvaDsU+TAGWd4Wjj4iNhnkPEzYh4U4M2LTz4dYs8+yaPwKh2j99
         8PZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOu9p1o1isCw3Ac2xlidbnNNcl5UITXxShI41gPLCOA2oXS+nRyIyKDK9zM+ofvPfOdt+znC+ATF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXDXEMy8yUX+J4iDS+CKtoSEbNKvV+5oEiWbgBiaelpSyxfFWo
	P0cncn8JphIUORrJpuEY0/lJV+YLyaO5IwboTHg0ToG1MZ9p6WBE6kXc
X-Gm-Gg: ASbGncubZEW7Pdjtz8hSWHwr9h+0eaRoYX1t+WdWoch7/xwP4Mmwr+wvbpFyX3/xzOK
	PYb13Vi9OW6OHY7VWiubjkDc27NlcxRyAikkZaY7XWmPnXV2AaAhH7QWIkro3TaTES9LPjpEtJ7
	4PIq3SIPrpcIMHwffc41Gyu9Yuabu0OtSSSyU9XHGRk7+R1tVwl87Z7zZwWNPWGT2jXjI1RMMUz
	6Fn/AF0c5Pp3qIdsqZTlExVj6R+8ZExtgDul3OPXY/WVj7LcS8ocEyUE2STGTpq/0NWTc6ogJg5
	EaDOXLuaJuQWEp8jdDaOYz/LC6thIAv18QufM0nnBohASfoJgzwOu7peg7JBEXITAjGLKsZPVzV
	6FwT8Wy8Ms1aTunAGDIuMZ94y6xlLz+5c2+ZN41qN3rmWn0Lp8wQFVV7A5biQCL2wslSM0VUMle
	BpFu2mCSdAhbzebjFPNpnFKC8AqdTLh5sguk1gpJtim0S7xouaA+w93+2RO7DzAQfCpGZLhwFeU
	N/hmy7W1w==
X-Google-Smtp-Source: AGHT+IGasMEo2f3YSuRreEs/8zog7GQY45X0or6PmRJCkVtaVHjxXqWGnHYHC3SejrjGvw9vVcyiWQ==
X-Received: by 2002:a17:90a:fc50:b0:343:a631:28a8 with SMTP id 98e67ed59e1d1-343dded5123mr2073086a91.37.1762921698484;
        Tue, 11 Nov 2025 20:28:18 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fbc0dsm854681a91.2.2025.11.11.20.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 20:28:18 -0800 (PST)
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
Subject: [PATCH v5 2/6] net/handshake: Define handshake_sk_destruct_req
Date: Wed, 12 Nov 2025 14:27:16 +1000
Message-ID: <20251112042720.3695972-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112042720.3695972-1-alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v5:
 - No change
v4:
 - No change
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
2.51.1


