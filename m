Return-Path: <linux-nfs+bounces-13656-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AFCB27811
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 07:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A31AA6A27
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 05:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C932BF001;
	Fri, 15 Aug 2025 05:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA+2Fbe5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22129272E67;
	Fri, 15 Aug 2025 05:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755234182; cv=none; b=WgB+bjq0/YBpOl2ecrP/LZwXtbJi09iLDMLs9GUGhcZjAylrH9p9IJg05mK4fhFETiS5RnsOrAY+Mg0QSEJxP2qvoNGD1g/uSV3Fkm4n6WRRXncGuBKLvJALJLENeaBbIe1WVvuy0JCjMlB0ZXOl9OBB2HNnrjCWaktHY9FFWEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755234182; c=relaxed/simple;
	bh=mxfjGVRdFypJIneNgJQfCt5r3cUJE/yR+JCsjk/Oi90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmlUh6aFDdsamk0QFjTSp64/KuLY1g9ernMo7R2zZ0VhPS8DDBREoXqeIhvHzcP2rROYQfBA+gONwWXSrhJxyCl7Ri6uAni09mTJNrAUMK62wBO2VwZIAX8dFIlQTRojvuZHsxf0Qn5tSFCtlZ1bV/T6kkoI8Z3cTi5EqjPZTxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA+2Fbe5; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b47174beb13so1114435a12.2;
        Thu, 14 Aug 2025 22:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234180; x=1755838980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi5PFbe1K4XbqRUhP6Ms3ZRXGTgHp0ZImPelGcEgGdY=;
        b=YA+2Fbe55RznJOf3YF/2hHonbbMfGyEXNmRkxgggk7Vcy1l2YeZDFoOM6tVjp1PH0x
         eof6RYKeu5PKAiOnolDGIhuBplM4rD6g6EUF5ZI44LZ4jo3GjrBUvSKoBlItcgLC4R+4
         1urZq/BazExo3LvG0j5i3bwHg+gJMIQULYf7dqr32dTNa+Rs2KdSbdqXf8zUa2pI7bQ9
         e6MUeXNMBNa4w883v3y2Q4D4gSkEedEFj4+fQfHCGusWVYm4eoTA1J0xUd+gMa3IvR8o
         azybg37YCuC4ths5/XLMNuFKzMxLpKmx+c5mrYE3wWCycgmIx5J4FPOHn+ARYxF3IHDU
         xK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234180; x=1755838980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi5PFbe1K4XbqRUhP6Ms3ZRXGTgHp0ZImPelGcEgGdY=;
        b=lrD3qsFhzl3Li6uMKkV4olRjTofSWefGThsLFr9jpCrkjX+esZBRQByfIh19uoWUla
         K+UM6XLdLUmZsvQBOb5xP47lwdjm8xOC/qOY3uzGBVo5Vo8AZ1fc8fNfNa88/Z5jj0qi
         BfGRNEm2eEMgiovW3C7xec/mzu6gHWDvegfw8zyxRrtr8qkT8WjiLLH/Ok0Ers6xXEHT
         HNNXAgUie9B/iuS1odcRrOVVTdSMMP1E21tA107uFAX+Z/TKc+AhbCBchOd2hcyJPe89
         xnIQ52TJK54FkxpvPjjBnc1IVt8DaNtfUlv2wc0IuizNiJ8wreng2LYfQA/gy8YF9FSX
         5cgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9eF5aqh8v0J/v/iFWg92ic0IesVkgrJszTcQJQBnHIDFW+0m5hYi4vi1LB5C882AD6mrxj0O3r3U=@vger.kernel.org, AJvYcCVyl7RMlpAtlkgU9vlya9rm83VhbGnZnbd+3ytTykq31moAbTwvyeCSIT9MT/6KBsAaBsRi52lW@vger.kernel.org, AJvYcCWJdTDOZlHCvR3eFS8oY2/MyBR6pvayi9aHZ7Mn0KDJFr570bWIOhlek+WmlIM6l2oGtOI4NDYIBNaEVaZ9@vger.kernel.org, AJvYcCWsVsWl1L4D01KycyeYRiFC11CDXiIFtI17uLmg0xLBw2n6jorY96SgJNCgt6OjgUJ4G1wKwVhw1W9i@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt35vQ+Tko2Tz815Rq03qvjQH+Z0o+48dHq/2XYriQZ52hZ2ho
	Cjna7cDzLuLyPw+gVtbJEIMRDgiYCTFWOWRdH5Vot/LI49drmAT+9hzs00Va6g==
X-Gm-Gg: ASbGncvYOWk/SKFVJQSEq3cvE4vLnLlK3vw6YjQ0y04kXpw4O2XhdnjvGl6c+TodtBt
	f55U2CXovFGN9m9IcVthIqcTGQa6+BCeh08GTTvbW+W8nA6oScDuNDDSI9qC07dCh570PlKNPYG
	sgdMYHfcH5vqRx0mdwN/5zXwwBT3vpHkjg5ooD+ndlgUeRe8TefLoYl8LclETb0angP5lqs1H6s
	+DWiGShbhxXVYQvam8+cBUVmz93aM5PaRiTZj4n606jkgZOk3WnCabyUDHjDndcdYgaEwnSdhI8
	VUA02P1u1nDF9dzQ4HZvmIkvRyKVOjEW/buB+er//wvGwPbsm+WWNRwLQ9iqaQl1uP63vB+5Etg
	5VsoJjQGJnpRDvfF7HuE1xcOhvgZxuUxD+EGrWUqbaeNHsqyarNgQvu2eHsUHdF7+nzCqscyb8j
	88MdW5Kdn/ajsRdAuqTwm/g2X6ifU=
X-Google-Smtp-Source: AGHT+IHfW2tMpo7JSMRUfWuqJPTI95KykdEA+sXXbpzW28CCs6+DYKpACzkzoqJ7Hv9T5S6Ux64oUg==
X-Received: by 2002:a17:903:1ad0:b0:242:b315:ddaf with SMTP id d9443c01a7336-2446d6eeb19mr12372625ad.7.1755234180198;
        Thu, 14 Aug 2025 22:03:00 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53c6e1sm5128645ad.115.2025.08.14.22.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:02:59 -0700 (PDT)
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
Subject: [PATCH 7/8] net/handshake: Support decoding the HandshakeType
Date: Fri, 15 Aug 2025 15:02:09 +1000
Message-ID: <20250815050210.1518439-8-alistair.francis@wdc.com>
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

Support decoding the HandshakeType as part of the TLS handshake
protocol.

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/net/handshake.h |  1 +
 include/net/tls_prot.h  | 17 +++++++++++++++++
 net/handshake/alert.c   | 26 ++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/include/net/handshake.h b/include/net/handshake.h
index 8f791c55edc9..d13dc6299c37 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -54,6 +54,7 @@ void handshake_sk_destruct_req(struct sock *sk);
 bool handshake_req_cancel(struct sock *sk);
 
 u8 tls_get_record_type(const struct sock *sk, const struct cmsghdr *msg);
+u8 tls_get_handshake_type(const struct sock *sk, const struct cmsghdr *cmsg);
 void tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
 		    u8 *level, u8 *description);
 
diff --git a/include/net/tls_prot.h b/include/net/tls_prot.h
index 68a40756440b..5125e7c22cb3 100644
--- a/include/net/tls_prot.h
+++ b/include/net/tls_prot.h
@@ -23,6 +23,23 @@ enum {
 	TLS_RECORD_TYPE_ACK = 26,
 };
 
+/*
+ * TLS Record protocol: HandshakeType
+ */
+enum {
+	TLS_HANDSHAKE_TYPE_CLIENT_HELLO = 1,
+	TLS_HANDSHAKE_TYPE_SERVER_HELLO = 2,
+	TLS_HANDSHAKE_TYPE_NEW_SESSION_TICKET = 4,
+	TLS_HANDSHAKE_TYPE_END_OF_EARLY_DATA = 5,
+	TLS_HANDSHAKE_TYPE_ENCRYPTED_EXTENSIONS = 8,
+	TLS_HANDSHAKE_TYPE_CERTIFICATE = 11,
+	TLS_HANDSHAKE_TYPE_CERTIFICATE_REQUEST = 13,
+	TLS_HANDSHAKE_TYPE_CERTIFICATE_VERIFY = 15,
+	TLS_HANDSHAKE_TYPE_FINISHED = 20,
+	TLS_HANDSHAKE_TYPE_KEY_UPDATE = 24,
+	TLS_HANDSHAKE_TYPE_MESSAGE_HASH = 254,
+};
+
 /*
  * TLS Alert protocol: AlertLevel
  */
diff --git a/net/handshake/alert.c b/net/handshake/alert.c
index 329d91984683..7e16ef5ed913 100644
--- a/net/handshake/alert.c
+++ b/net/handshake/alert.c
@@ -86,6 +86,32 @@ u8 tls_get_record_type(const struct sock *sk, const struct cmsghdr *cmsg)
 }
 EXPORT_SYMBOL(tls_get_record_type);
 
+/**
+ * tls_get_handshake_type - Look for TLS HANDSHAKE_TYPE information
+ * @sk: socket (for IP address information)
+ * @cmsg: incoming message to be parsed
+ *
+ * Returns zero or a TLS_HANDSHAKE_TYPE value.
+ */
+u8 tls_get_handshake_type(const struct sock *sk, const struct cmsghdr *cmsg)
+{
+	u8 record_type, msg_type;
+
+	if (cmsg->cmsg_level != SOL_TLS)
+		return 0;
+	if (cmsg->cmsg_type != TLS_GET_RECORD_TYPE)
+		return 0;
+
+	record_type = *((u8 *)CMSG_DATA(cmsg));
+
+	if (record_type != TLS_RECORD_TYPE_HANDSHAKE)
+		return 0;
+
+	msg_type = *((u8 *)CMSG_DATA(cmsg) + 4);
+	return msg_type;
+}
+EXPORT_SYMBOL(tls_get_handshake_type);
+
 /**
  * tls_alert_recv - Parse TLS Alert messages
  * @sk: socket (for IP address information)
-- 
2.50.1


