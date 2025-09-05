Return-Path: <linux-nfs+bounces-14056-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73462B44BC6
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 04:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0855A10CB
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 02:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A7C22E004;
	Fri,  5 Sep 2025 02:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhEP47Ph"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFE42641E3;
	Fri,  5 Sep 2025 02:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040460; cv=none; b=X0zKFCR8Ih6sMY70c1y075rT1Oj0IXko7NqYgDJRspuNyl1qOdUWtsbn2UoDcOegolOvc5B0/0xTfQX9KiBFvmdG7TkiziCEZogtVqcZX/zEwhktVEuNJE3zEsqbCVcxfO2pTC7TyMrQSxJgN+680FGBOdIVoOql+TEmetDTY5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040460; c=relaxed/simple;
	bh=w/oYAbmeU1N4zxqgBVYWveh1msm4OYF6Q5nBahuQfVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPD1tbWbRSnaVDyRQG0/piVY78E6XQ1ooQ1gWaIJ69RdKITgHfkRE/uwuKM+g5c01m3B9vArWTH0xEJv9sjAtav2yyyG0bEd34wR+hcF1z3bDr876L8xCHpBH9qSypXVq6uIQyFri3+bJh7jDC/FTl6ToGPjxtVJgxNeDNl0AxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhEP47Ph; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7724fe9b24dso1221166b3a.2;
        Thu, 04 Sep 2025 19:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757040458; x=1757645258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1EWHajpMqKqyxA8GWEtrMVXQwoVeft66qRlv9TDlNE=;
        b=KhEP47PhGRAUnrle/j5vtgX9m9ep3Bwoy8vd+too2nPnNegYu+WaaZ9CWBDkPdpZA/
         35su8K8WnD24Vm6zgiqo1kukNksfZbBSXDUMtQs/u+eYXGapBa8TCYUKslLQcCXyhKLO
         /hL7INCAzYZTNhBxaO2hQui1kopI75qpLdZNPl1Z5YRzfwvQepN1qheVOxsT/CWHr5//
         MLZqZ89jlN1hLuDTQnM3xJ+tKH8x2FAhTLx4BsV7rTF4OiD7M3KNKaZcQO6s72W/iAL8
         wmxWEXKbzOB7nTg2bM7qBGHQNkMQAxH4+1awqWzwYpho6c9HPnep+g9YksyqI099dnjQ
         EQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040458; x=1757645258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1EWHajpMqKqyxA8GWEtrMVXQwoVeft66qRlv9TDlNE=;
        b=rdu+yCwvWcnrUV6mNybkw8uryk0eIAGMAL7SRB2NfyNk4HNFOiVxOFWO8FmVqIPtlv
         URhpjsrSbVy/tuxI8UJcqr4rYHxxczB8C5ju7I22LEUuR7rnoYe4v6lhYifTSj0EqLth
         ie6eZJbP4rdYSyG08sc9qzqbqHOLAVPuwYR0nbdnEyCJUe43fwEYslZZb7V/lELFlJsj
         q6b/93ZdyfsJbNrhJaNzXPt6J914jX3rOfxjSQvCwNniAy7SfMgy7dGSs+ovfTB2/agh
         wEWqqg24jXsTyQZOMV+jbTPt/Nj1Crnq7QOnz+hQU/i72GMx8c9RJSiNRi08mUYJ8jha
         dchw==
X-Forwarded-Encrypted: i=1; AJvYcCVj9I6xV5DMq7doKAcRZs35DzdWGomrpmUAHmyc/b5JPuu2nWgJt7ppzGvs0tDgpx85jsXXlBDI6b6T@vger.kernel.org, AJvYcCWZS7mV41NvTkPLsLUiBapU4EY9RKbNAzqBI5RA5bZUSJALaSdjTmWl9m0GW0XHxucfIHnRoT1M@vger.kernel.org, AJvYcCXYO1u3Fow42Cx7UzVyKKA1z9J7O94VTW1Wfmu9O+z2KJAyROtm0t3jCfaDfqGeegHZXCokz8/70eAsrvfq@vger.kernel.org, AJvYcCXp9+X5E3XVH4AOSN5/NNIUYvw7sO2jgYrBnL/T3h0ymS6T4dNYIdWq+D7rkwo4yVR1CK6l0KqCIWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuY1kMOLscQI8Dbm5MZQty7HbdkBmvgPOOgyHllRaeuwpt7tLk
	DS/w+9DRDiraVHptqBHoYe4PzhdWeqtnqAs19ud6OJmXe266V17liLShzhvRwQ==
X-Gm-Gg: ASbGncsknf8a4GDxvHFQjecVTTYLEnOAvrpgViCLlrmFtPiFiU2ajKUFYNnWKilccly
	tJUvaRDGKhcMDKugm8nvChu/lJdx6KivbAQSPnzxgeEUk2OQarQ4u2HnegH9kHscyX/ZHv9YRDG
	rg4mOOre0QUIRywfJ8pIQ5GeNKMj6xUFWkKGyWFVdi7kMn1gsJO72LYkNAwOraS3VuES4LyGcRq
	+N2CvbPprbtPE5krzKLeojvy6PZhLlusVCc2X7XREdZ0qCBFlT+aD3noaWQN/bFVfTevrgU74kt
	XYXBirlZwrfuUcw+FWxPASZXwrhQQA1IfK2Y5qkaE9EadiTtZqzBh17y3uom18AiPPzYk5DoI64
	ZL/FwcU56geKBJcoOcLFOEbNC/8wcfSWb76tI+hnpgsKZ7UIc6LtGZzvWL3d2iha1d3FRK4o6kc
	oqIuAPdWt1b/3XD7wL5+/SUGnZBOA=
X-Google-Smtp-Source: AGHT+IEX64nfMru9GugujC6DsIEIeho+MjIw85M5xAJP6i7Xx1NoXALA29BzByuoUSArpy/50s7n8w==
X-Received: by 2002:a05:6a00:1a94:b0:772:4fc6:84b3 with SMTP id d2e1a72fcca58-7724fc689a8mr23059661b3a.31.1757040458343;
        Thu, 04 Sep 2025 19:47:38 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e0519sm12991858b3a.84.2025.09.04.19.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:47:37 -0700 (PDT)
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
Subject: [PATCH v2 3/7] net/handshake: Expose handshake_sk_destruct_req publically
Date: Fri,  5 Sep 2025 12:46:55 +1000
Message-ID: <20250905024659.811386-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905024659.811386-1-alistair.francis@wdc.com>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
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
v2:
 - Fix build failures

 include/net/handshake.h |  1 +
 net/handshake/request.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/net/handshake.h b/include/net/handshake.h
index 10f301f3c660..89dc169eae89 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -44,6 +44,7 @@ bool tls_handshake_cancel(struct sock *sk);
 void tls_handshake_close(struct socket *sock);
 
 bool handshake_req_cancel(struct sock *sk);
+void handshake_sk_destruct_req(struct sock *sk);
 
 u8 tls_get_record_type(const struct sock *sk, const struct cmsghdr *msg);
 void tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 02269f212c70..bb61c9a1a03d 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -342,3 +342,20 @@ bool handshake_req_cancel(struct sock *sk)
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


