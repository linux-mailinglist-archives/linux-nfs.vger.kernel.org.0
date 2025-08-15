Return-Path: <linux-nfs+bounces-13653-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62763B277FD
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 07:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E4A1CE3858
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 05:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F38A2BDC3E;
	Fri, 15 Aug 2025 05:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut2wvl9Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA62BDC35;
	Fri, 15 Aug 2025 05:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755234165; cv=none; b=OmFjGn/hZAVpXwk3i/URag1RRb3hoBXXdFwKqLYdXCNw3C93cD0ejA+0ftB9PdVLD/g/wtlJ3A+joNf9hCUjc1ciT5Lv7bw2ty1R+uo/t2/788mQE73NRDqXn3FZrG/Q6VWM5igMlDiNgpYcOWl3bjhJa3CHBbtFXhQlmH1c96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755234165; c=relaxed/simple;
	bh=ZYoIAvI8JvjAy7tsXH+fX8odbelCU/L+yqvG24kV89M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/YQu0x47aDrDEyQYP6ninT9DWOlkTWlF8NLdXoNxW6S/jqZPMYoCwhul07clRXTOPWJhdFgQyp1+W6ijxIrxselOZZJO/F+J1LeXwQyaTYqrZhlCa8s6BandBMAHDwzmWpdms8FulrtauID1jJxAAOTC61UlP2E7ajWusjb/PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ut2wvl9Y; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2445818eb6eso13557265ad.2;
        Thu, 14 Aug 2025 22:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234163; x=1755838963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZqqyoHZZ7YsUEio5GgDxrA+je+1nNyUxeRlVhWKQvs=;
        b=Ut2wvl9YtxQ7375MbhAjEsPSgsN8PuWFBe041eFUSXll/cJb7NKZzJi6JGf26nwzVi
         eMTKQvThE9ZZ0bnc5/J8sY5C1HCPbq1GGenKH/0lBTyAVzJJOmHZCebSxhwpPgHnVcZo
         nAusa1TAucQ/ch74lhQeumX9d2Xp6mlZ68rO5JGmzbGYRal95RXS0cN465HWfsqyVFpv
         DFKg7nos2lCHfthI33ZpnSQDWvuTyBeQHNSEcyK5ghg7lQORZgkde3zSYMar5JAEDyv9
         tdwdEdIs9/v9IBy0tQdlLlAshzhaYdJAwZUzIslIj6vW+/McnrGsrqt9rasXuKSpVsXN
         ZEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234163; x=1755838963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZqqyoHZZ7YsUEio5GgDxrA+je+1nNyUxeRlVhWKQvs=;
        b=aPwcMeUPQIecykW09vSdE3DXL7c11M6rGRufOLaNBaRcvpEOA9GVrW0B9fsF/EEeRz
         6F7qoyL4O14uACfO1W+VbAb/HaNomnOQXRx9oQnVXlPkT8xeI+BIsscbALN4zHbuINoh
         GkngC+ZIe1A+C8Wl06cFnwaL7d2YA/rMiXOL4VSpajdedqO29wlUaTy+j2RzN0x+y59l
         /YUxydRzPAhIKER+p28VVL26DBXR/TGNbfbTl48+POcxRi8b18HOPc9KOqcBmJTWXbyP
         FISfSL8uRQUYgiY8asGoW2Pb7UoZkvt7Ceh1cP2MuCzQQJOHRzxafDXiINYdzNSf2A5f
         3GIg==
X-Forwarded-Encrypted: i=1; AJvYcCUHGvH32IJePlVtfiuCvZfi5vgCStWHpoUgi7OUgrHnw/VwziidTwQBiinM1sPYfR8r6omi5qbkDVbh@vger.kernel.org, AJvYcCUL0DDHvM9R1r2sOmhrdkz3TemuhNnWXa7fX+9D78Zgj9oEyNSVlKNJ6hwlGwAmav28lCZf53iSo2Y=@vger.kernel.org, AJvYcCWrQr1g6gLmQB/id/ziNJJOXGZ/EJ0kXCz/DbL/g+Z5Vm3I8j5N1FLwU+b/+FgrllwJ9vkFPZHm@vger.kernel.org, AJvYcCXPkUhHMX3E7SApDKpK2lD+CIySILvK6ehyjweU85+YrAz8BhHmBuDhaYcXKyv4HJumK9PHa41MlGt+dtFg@vger.kernel.org
X-Gm-Message-State: AOJu0YyaC2/6lJQQs3Qoq8PrY159BWwECV0xmY3vLfGj7CT7jUz937UL
	Xn3G8CmF8m6CHnlaHrnaVOcofKeZpnOeFv0m9gCVhsUFX/c7DAA1x4Gt
X-Gm-Gg: ASbGncsJpvZkLUZfrqJ54eSEwe4Ca25e5mu/WiIkiPS33Tsuhj1DsAu+UnOcQBhnF/k
	H0B3HeaSWrU2OrPu0HA6JpvsXNoHTG+dUInP8fws2PW1PqmP/A7yo16Sy0H0yW4m+xObcI3s1PY
	Q7y9521ulNjWA0p5MoZn77w6ervnHR83NY4jTcs9lTfCPIVoaSByxSL7tAajWC6WgdCtwyKbZX2
	r3xUHCuzgCOY/jcurOzDCsyQrW4dlU3tb/ag1tBN3RUh5+SfjvBskAlNvfjO29owfKkF25qbL9J
	36QslylZoP+XqVzR7Fu+k18gXaPhJzU53EAG0qyrMCu/dH/5B4obVHL/uj4BOETLnI5o/FidZy0
	fr5je96jHy9hGLzGwIPvsOroML4lTbOf2SNfUBuwpD8nCgXkAvR5UHeHQKLefJTuyhLNNSjL9GQ
	cVQgHgXqrfOFgAsQGcDuhEcofMacg=
X-Google-Smtp-Source: AGHT+IG4eNpFbbY6CONpalTmgGqMktH1B9il2WlkRC8J04INCl901SG/4g+axvWD8CC3sg/+QQBV8g==
X-Received: by 2002:a17:903:1c7:b0:242:9bbc:3647 with SMTP id d9443c01a7336-2446d9e45ebmr10879945ad.57.1755234163041;
        Thu, 14 Aug 2025 22:02:43 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53c6e1sm5128645ad.115.2025.08.14.22.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:02:42 -0700 (PDT)
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
Subject: [PATCH 4/8] tls: Allow callers to clear errors
Date: Fri, 15 Aug 2025 15:02:06 +1000
Message-ID: <20250815050210.1518439-5-alistair.francis@wdc.com>
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

As part of supporting KeyUpdate we are going to pass errors up to the
callers of TLS to indaicate a KeyUpdate. Those layers will need to handle
the KeyUpdate and as part of that clear the error.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/net/tls.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/tls.h b/include/net/tls.h
index 857340338b69..7de960225da2 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -493,6 +493,13 @@ static inline bool tls_offload_tx_resync_pending(struct sock *sk)
 
 struct sk_buff *tls_encrypt_skb(struct sk_buff *skb);
 
+static inline void tls_clear_err(struct sock *sk)
+{
+	WRITE_ONCE(sk->sk_err, 0);
+	/* Paired with smp_rmb() in tcp_poll() */
+	smp_wmb();
+}
+
 #ifdef CONFIG_TLS_DEVICE
 void tls_device_sk_destruct(struct sock *sk);
 void tls_offload_tx_resync_request(struct sock *sk, u32 got_seq, u32 exp_seq);
-- 
2.50.1


