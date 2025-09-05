Return-Path: <linux-nfs+bounces-14055-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D03B44BC5
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 04:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5060A7B6BCD
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 02:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E202624DCE5;
	Fri,  5 Sep 2025 02:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYYF7oSC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56657246BC6;
	Fri,  5 Sep 2025 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040454; cv=none; b=Ei354lS4XOgeut7FAAq5XXBqXiXWDe0yN+9M5TmmY8NIF7OaqKcScRT8Mxfhe8rpN6lIiHlmHzslO2nQcR9sdoZ5Rd+tVMTns1wmXgtHB5Sdyz+SOQCAN/1BQVszCuHHCOKxa/4RaAOoFhXCFFcda+1bQNF2FGDCaZmm5VQIEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040454; c=relaxed/simple;
	bh=UtEHgCYNC8YStao7ct/JqrQBLdDxGf+yLN+qigPPYgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JATSJSqx/8KzB8cJb612ZIOEdda+8hnljNyRBQISk8KUQeNjV0H1tR3DI8XVA3Tbr7UXKivMIAjfOOhm01ia+5kb97M84g9nb84VEz3Qfks2O1VDAZnF0FdHtr0KXGv9m2VVxOPr7H2p/1yatjkw4zFXOnFLtxrgnItzobOfgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYYF7oSC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7724cacc32bso1375959b3a.0;
        Thu, 04 Sep 2025 19:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757040452; x=1757645252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tr7ELGOkxuEFTNKTRlSXZHzuS005z5Na+L9CuZ7aiI=;
        b=CYYF7oSC5GYM3t7zOQLKGZCb6+nfHN3KclPaQIV8Ih/qHO7wFDvRLGlWjFu4Bv/CEu
         +wDlw8tG+DKayupy8Nzd8+J5SenBfVAHoQb8YeN4j1rFHHT+nAL69S2JWpy7WFvX9G/h
         xHRFcTremNlOZsbCCpcorfqlCyIH4XOTYj5c0AmWQflyptll1KUKykc0SR+75WfY5537
         bNO/UN7GHx8j00LibgbVtkSoKaea/+jkqWlNKC2waegbcdGDeatZ9LlLs3hZcGY5AYf4
         dckpHwGOzjPv+nj3gnSkwJ0g2+xlal3ZqhPAZ04u8no0cY70LL3Wkq57FoCwwc0Jp553
         soLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040452; x=1757645252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tr7ELGOkxuEFTNKTRlSXZHzuS005z5Na+L9CuZ7aiI=;
        b=nHaUoyOXN2NZ1Dlu6JwU/TpYPWk2eewVtCb8TfecevHVWUQaSt5OoFlRVJGOMSciC2
         6j+OVLgfFIqgUSV2GzYIXz6sAOiiV5zOnCipqDMZH8baAo5kV/mTnhrGXazBF5rFJJ+t
         uqDOaw5RWqaKkOkncEbOJopmGz1cfyPvrQVjhVZwbtFZdsU+6Vz7nu5xvdVW54bz7rQ/
         vsLuCRm4qsYSY2QLiQ1/idcjJKkZrZ0GqUa9bWpbH/EU26SyapEY+HpTGFfKPKKXkz+k
         EOjzrK5bAgjPOFg2EE8t388FhsWb2XkPTQ1LNjiDiymAgqSxKiBjUhYIu7k7I5HP5ufY
         6bfA==
X-Forwarded-Encrypted: i=1; AJvYcCU0t43WMLHC2GToV72p+2DAUux0vhT7k3FsB6Qbh0QQynAWFUBM3Rr5KACyrS/kqW6bbMLo9grh@vger.kernel.org, AJvYcCU24StHa++UjNewOAuPVauwMeNtKhjDYDQiPr33Wdm0Cr8SBblEq06mtA9ZEmGCVm6m7F58H1/8+Qc=@vger.kernel.org, AJvYcCVmGBz1h1P0x2FkMSeYkSCKeHEmoouN0qphn2UzmkGKVQES6R/gM0YYEj7n4pN61m9xjdx1pKlEw12FkeHW@vger.kernel.org, AJvYcCWrjYlX1Q4FwmsEW8TyXUkDZQEnFHofuyqpU8Bqx3Ysy9iXKLNMVicL+2bFC1OEdZoXyXojqP2/+eBU@vger.kernel.org
X-Gm-Message-State: AOJu0YzTrXKdUq6sQjS16I4pXELhfDhNM6Pr6p0mix/IUzbuao3gVj6U
	nPpyArbL5f07gZy6hdNYA9nS0l9PuIp61jjgk4AKyQkgMu2iV0cRHrvB
X-Gm-Gg: ASbGncsu97TKjk85tApj1mz1VRNbent97KTcAsgu2weUwZf8+ICzOFw5JdDpKnghWHI
	0s7EHRKz7Pe9sHx1iKft+7kA5Q8JdaglYl3OVEItN5x1M+Ug1L2utBmrBxkrfQOAH9izN1MO57x
	vZyujO7KBep1L3cYyludv3dMY5mT2jvPTXp3sVZJVr/9XvFr7Z/5M/hxjIwE//CCFmp122urgr4
	yjXaVEbhLQ/wcymt6ElOVxcCZ6zyPtvl60oF1wLxM59UU9V/fWJdOr7VL9IeViFF4BadqDn2f0G
	mPn+JGM4E4YTYUkxIhnhdll+Iyse0hLt0D5mqjR7oV5m6JQagoe3D29rJmdGeiGgDnWEfeiaWCF
	Z1zY9ojpe4AoUPIXT8AVOC9iYFCTWFqNEoB9MfL81ycyVf34fT9TvmawWOFxo38KTRdf1rMgCsI
	hKyvyOfhH6DGsdb1gL22U/Vdma10k=
X-Google-Smtp-Source: AGHT+IEpxJLcudozMK0RlH08J4zC+7BkrtPegzKfFrmhuSA37TLE3wdFwvGA3QhoSWRGB7n6xUFADg==
X-Received: by 2002:a05:6a20:3c8e:b0:243:b656:dcc9 with SMTP id adf61e73a8af0-243d6f8ddcemr29359920637.55.1757040452539;
        Thu, 04 Sep 2025 19:47:32 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e0519sm12991858b3a.84.2025.09.04.19.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:47:32 -0700 (PDT)
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
Subject: [PATCH v2 2/7] net/handshake: Make handshake_req_cancel public
Date: Fri,  5 Sep 2025 12:46:54 +1000
Message-ID: <20250905024659.811386-3-alistair.francis@wdc.com>
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

As part of supporting KeyUpdate we are going to want to call
handshake_req_cancel() to cancel an existing handshake in order to
instead start a KeyUpdate request.

This is required to avoid hash conflicts when handshake_req_hash_add()
is called as part of submitting the KeyUpdate request.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - Fix build failures

 include/net/handshake.h   | 2 ++
 net/handshake/handshake.h | 1 -
 net/handshake/request.c   | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/handshake.h b/include/net/handshake.h
index a07fecea87eb..10f301f3c660 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -43,6 +43,8 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
 bool tls_handshake_cancel(struct sock *sk);
 void tls_handshake_close(struct socket *sock);
 
+bool handshake_req_cancel(struct sock *sk);
+
 u8 tls_get_record_type(const struct sock *sk, const struct cmsghdr *msg);
 void tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
 		    u8 *level, u8 *description);
diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index a48163765a7a..55c25eaba0f4 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -88,6 +88,5 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags);
 void handshake_complete(struct handshake_req *req, unsigned int status,
 			struct genl_info *info);
-bool handshake_req_cancel(struct sock *sk);
 
 #endif /* _INTERNAL_HANDSHAKE_H */
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 274d2c89b6b2..02269f212c70 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -17,6 +17,7 @@
 
 #include <net/sock.h>
 #include <net/genetlink.h>
+#include <net/handshake.h>
 #include <net/netns/generic.h>
 
 #include <kunit/visibility.h>
-- 
2.50.1


