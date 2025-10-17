Return-Path: <linux-nfs+bounces-15314-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3238BE64A3
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 06:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9AF619C65A9
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 04:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B8830B52B;
	Fri, 17 Oct 2025 04:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VllHUtkz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC230E0EC
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 04:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675027; cv=none; b=ias7Iq/Pxs0o1K3b9OhX2qm9f557bJvhuyW+P6/OVIzcE6jS4HqvyZa4eZ9rpDXnKK04kkj5iCYOCur1rrw0CfjLZFflmKai2ehI4rNN+XOCdj+7rYJJvq0UJU4xjnbP9DORimtinKuGIHUFhaHm5ecEfN770TjFgN4biahO36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675027; c=relaxed/simple;
	bh=37YeEv3sX+mmDjcIQ5fmoI0jB8MoKSf0MBI8d/gZIrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZ6WQLfBmMw8jIFaD8NV4wZGS9U9pTAfcZAYvjBEbMIaV7SbHoDylZ0xr31jtpbvttflgH5TcPxTfhZmZpjNQ2p0aT0IVCs/jbTjNDDE2ofzlkw4Hz/1zXUej19ZFKiwx4KLpVYk3F1U8gL8KaWu1U365+IiZjxUShy/ZRE7N4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VllHUtkz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-269639879c3so14089045ad.2
        for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 21:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675024; x=1761279824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhR6OqlULE14euOr7SOeJPbIcbHzF9rdhJ80nFJJwb0=;
        b=VllHUtkzMpkUXDvPypYbSO7h4bOUgAdTvvSKA0faHZYqPsXz3wQX/CK2IaTCL9+7jc
         3y7IrDez1pdZREPnV45jiEcl0FXjMh3E8OdTG7Gw5Iu9bAryYuxNucYUQWFpNDOATIo/
         5KVTpWnIioxUCqHO2oPvEaBixWNCGtfGrhyoa9mjqZQaOxjQybUYkzRAqeBUNkqYzcRK
         XiRAHrUxXPKXFE7J/OSXNDyXNn7SobMth4W5M3eGKfKTlmk8nXIsTShtpgS/wX26O5yu
         V/mVww6ON1msCEYb/3cODPaOOPlFJSc/QiLTiVOzeSuJxboqBXAWYIpVWgVGGJxbFmJK
         AV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675024; x=1761279824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhR6OqlULE14euOr7SOeJPbIcbHzF9rdhJ80nFJJwb0=;
        b=Mn5BM5TdtCivcSgzAUWrJ3VcUfbcHfX+FIe5bj4RnUAyLwE0Ih8drPVN6rdbz7yT9Y
         uWAFxLR5S0QXVCrVj531U+lI2GirfCUE2WifW2hYvi4AIzZ6CiU/Uo04uDFv5fLYsc39
         DgJUQQ6XD+zYecfV6t70rvekzOC+5lKNH/5V1Htb5zt5Q1cSKgogRfvBAGgEMiIgiORW
         sZNnD4CURabqpy+48bB3r0I8Gikwr5vaIM4QMQgoBw5ek4Fk4fNMnHc0PSpLYhTt/AO2
         0nR45b14IXmdB/44EoK3NO32BWPumBZjDfNYfnMtAu58r2SbbMQtCCkFh2cJAMKT6W4D
         z6Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWmzQEvYsaGEer7LLZT/GhGYuUuzssM+Z0BZN9FU4VgsyxcGCGDcaasL2UDVmxel45GLR3bM7nQ3kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRUcLMH9oTsiJGghf5N6Ytt0Q1taya0/pLIQ2g66GHzf2AjYV5
	wmw2xIY9gM8mBybR4x4jg4LfmlqGDy3a3LDYLfxRjU93iGt/y4afvkxt
X-Gm-Gg: ASbGnctA+DtMhjhkKkyrMnok9lZcXm5FtMqnoH0YbLnL0WkiSc3iT9kOP7/K/7fBtXK
	Pvq/Z++RUJiJdF7DIS2hBeisvwv26jgUiMSFlY0PTDDgGjXB8D6W4F7cA/yXZywHX7ROGhQWNmF
	WR6YApyQfG/7ZE+Nrf7Mtlusm0RWfyFtuyWxKgIlEZ42OxQKcAScq+qTpYWgHMMCZ/0uwVv/z9S
	HBHt7GpsnsSriJSv0wmJh4jvsS0dvJLmjsnmAfpgkQrwcN5ox78ghsvRmggkAw/zFIYLsXyEaon
	PbGRSjwPXsE4A5wGI0c6YBLlZq7dHIqBSakObEKgnAFkQwyZCSq9zOycEAGrNZwwv0Ip9vuzKOI
	OlmUdDF4EaNNOC5LshLbEVyc7/X3vZv9TBJwIzHExmrFdE5JR8GXsRPy76fkai4WeVd7yUuNoPT
	DwwKHs820MxWUeCLdytoPFKH8H+JYoxCj8JowkWN5ketl0cvrJaHpFnlX/NfbiT3b/Tf5YANTF6
	YOwrWX175di4ulIFSnd
X-Google-Smtp-Source: AGHT+IFs1j5KeQPUYHknhxmr73Cz8lIn7tiQ+fRQndA5W23hoDMgcJ9Yk8+rVDxwb74P5c6XfgnCZQ==
X-Received: by 2002:a17:903:b90:b0:269:9a7a:9a43 with SMTP id d9443c01a7336-290c9c89fdfmr20658745ad.10.1760675024212;
        Thu, 16 Oct 2025 21:23:44 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:23:43 -0700 (PDT)
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
Subject: [PATCH v4 2/7] net/handshake: Define handshake_sk_destruct_req
Date: Fri, 17 Oct 2025 14:23:07 +1000
Message-ID: <20251017042312.1271322-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017042312.1271322-1-alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
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
2.51.0


