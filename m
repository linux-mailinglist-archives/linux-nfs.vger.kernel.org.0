Return-Path: <linux-nfs+bounces-16285-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EF3C50848
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 05:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7483B429F
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 04:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A9F2D9798;
	Wed, 12 Nov 2025 04:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnioBE+9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FE12DCC04
	for <linux-nfs@vger.kernel.org>; Wed, 12 Nov 2025 04:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762921706; cv=none; b=eeceBKLO9FaipinhiQMXgurrycG5pxZhQ25+h5gZ/qqGAj7tmtcZ2xvlLQYu04vdrkA56Aemy4B4CmQ1t5aNYVJdEhauzNpJ7+0ymaD85xxo3gg1nSb5KqcpfOKNxgUOVuxic8txu7NGtnwvYVf9VgNxoWAEa++w75ad/ijP1ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762921706; c=relaxed/simple;
	bh=zP/NG7w1+KArs879n8cQJzWDunWwyIPS5O4paM2aWv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBplq8p6Utj/LleCXt58VQEjNYPMdD+1jzosXZE/qvDpj4G1cWgfC1tUvcf1PT/ksWV9slrPrP+qPJqyGNnndB74b2OvN70kKXxMUUHSS7KDBZmuf1xJCTANJasB7PQDIT6k+DebxdANqLpW3FMQgAjUi4GaXlSL50Kui3/9ATg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnioBE+9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-343684a06b2so395213a91.1
        for <linux-nfs@vger.kernel.org>; Tue, 11 Nov 2025 20:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762921704; x=1763526504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkGiIciWDidvQkbZlkaOibwVplEAw58SDT70kiDe31U=;
        b=MnioBE+9RluMS451pD6BCq/wgG9AjNRfLpn3OOC6f+TMcIvVk0/QKxcdwKXZ5j7RKz
         IXGk9ZbS6MQqb9+Q81yvkIDMcbyhlvmJ02GAISA3RgQEnsK2hwieOmHZ7PrHm69r2btP
         yXEfqYVr75TfX3tmLmgKCecYybtptcijEuAJSv6IqQht7VDsqfO3cRwzoepmlQOLABf+
         +ZhOBP9Vh5VakngdMhP1UU/Cl7dkDRWmY30DOJNsNoaUSBYebRGgVB7iLLQL+hvtsYW0
         sf+PRnXJpRZ5XKtr1Vcdchvbs4fQVAzOBCj13NbgEzR9m3buyp6iuyW2IJqEA2t/2e9Z
         Y5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921704; x=1763526504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zkGiIciWDidvQkbZlkaOibwVplEAw58SDT70kiDe31U=;
        b=vM8LKkgaEZppUh1mDByuxJa8YlvlwLAH0U+i7AEQrRoNrqs8EgudgZluicKj2PDj2v
         8A11x+8Sh9izr6amLN25G+gb+aSWofPyUXyp02VahfQw9uF5AMg9lAdFnPwomeYiVsYc
         cBiUeGKfaAlgIJjvAWQAS8OPi6+BoImhsV2upku1PzxZCM5/lLlhZ7qtJRX4H7Glhahi
         Hf2qyswrlc3Qnlsash2pyXaIPa5PZX9C0M2rnCpcJbR37xp7To1Rag396uWBJQmnVxaK
         R/2OtmGQGgMgti39eAuOg0IJGYfB5E5vHeGVlmaNATHldKGn5oz8IIki86wZU1JWbFo6
         P/rw==
X-Forwarded-Encrypted: i=1; AJvYcCVht4z4kMu7DDnaLc+P2wOm4XzK4VWThMrdKlzmlJlSX4rvpNAfuDT8E3HurGthxMJqKqrkf6s6I5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy243Le/PbUhesxnkBf9WBfMCLqNyX4F9NE8iuj0kfzsktrSO5U
	YkWV+vNy3U/W+ZqrE2nrjLXR86exhqIuYcthvyrcfyqhfJOi+jPrZqUG
X-Gm-Gg: ASbGnctt53Ys+xYf1zba17ApqjMt81T8L7oP6Mm8W/+VucEY+ocTwH04QjcdYS3q8qK
	p/hbGKwGol8ZhkMeDmyaQdtUQRME0uBfaDIjeIs7eVu6b3NYWfzky4WckqO7MnCBWBO9pQR3i0r
	cU72LAIXqWoRfyKU2XgBxCYbh/Q2nv8M6nGXpMFJYh+roZkg4zUrW6YGXp2FUEVcWPIEXdvHqvU
	yDhvUtZX1IcBW7emG7T94KqBDuTetETd2bZ3d/9aZZaSmIlJNSV/iM18kAwGylt2HAlUuqmT6Gi
	Z9z2pQRb40oJImR18LPysi2ktrMvKAAXmYDeS+n8VvxiPLFA5lZgaw+6/bo+su+/ivw6PZaRmzC
	c+CIwzJq7KXKzURX1PLFxAztG7bfcchAnz8oHuZQsClzak44Svk7sccjEXTzzfmUoD2VV6LA5kv
	T3RtI1JgvoeTxuyFDqe6mcp2onD+i0tfySMhvcOotG0azybWV5vU0bG2XV126qZ4ntLe6GbDz1H
	hGIo40n5w==
X-Google-Smtp-Source: AGHT+IFz599JMY+HbLZlN+Y4HCQji4lI/mnZmgyLfcZAZDfwLpsK/Yd65k0yw0c8AJv/WsCEFQFd3Q==
X-Received: by 2002:a17:90b:4b89:b0:341:8b2b:43c with SMTP id 98e67ed59e1d1-343dde81845mr1915818a91.18.1762921704526;
        Tue, 11 Nov 2025 20:28:24 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fbc0dsm854681a91.2.2025.11.11.20.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 20:28:24 -0800 (PST)
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
Subject: [PATCH v5 3/6] net/handshake: Ensure the request is destructed on completion
Date: Wed, 12 Nov 2025 14:27:17 +1000
Message-ID: <20251112042720.3695972-4-alistair.francis@wdc.com>
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

To avoid future handshake_req_hash_add() calls failing with EEXIST when
performing a KeyUpdate let's make sure the old request is destructed
as part of the completion.

Until now a handshake would only be destroyed on a failure or when a
sock is freed (via the sk_destruct function pointer).
handshake_complete() is only called on errors, not a successful
handshake so it doesn't remove the request.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v5:
 - No change
v4:
 - Improve description in commit message
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
2.51.1


