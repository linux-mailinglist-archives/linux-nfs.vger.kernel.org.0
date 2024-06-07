Return-Path: <linux-nfs+bounces-3592-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A49990067F
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB0F2811B7
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F576195990;
	Fri,  7 Jun 2024 14:27:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00BF1974F7
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770422; cv=none; b=kMM6ZPiY4x/xjU/ZSBQ78N1F0lyjYlgIFGvQvxXWHkNaOcy/4djCVwJ0obMrni8OFfa3/cOPyzTeEnRXBf5C3oURIuaZJy/BjvnF6Ie3fXXADDSFG0lp1j2Cgr3hq1Eac5zbpQTnNBnwH4f3zLvhd6L4no2KZtVVUSsV1jtQ6bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770422; c=relaxed/simple;
	bh=cIb3MJM4RkF/Px7ti/U0lk0FUmVhCpxVRzmtxzt/KG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hS6r4m+x9BKAWbpt/npFeu2DXQMfX8QZHZQDyEYg2ZlPun2YB85uEQddWFKwm1SaOISJ3vixNUeS0hqdiwp2GEfSCLrHcxaThoAf3S+giRz6TJuo0/MfA62/rwaCND0vF5+X+wcgb6ot8fn4Jty1FG8qHY0FkaDY3kefWfUN8kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79523244ccfso170304285a.0
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770419; x=1718375219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9dlgZkIscT7i9SR2+2bwIs/yvQBVrOiww8RhLy2Pik=;
        b=mrEL74Pv5uuqpcNi9FnCO74oHAQXDGDXjtqUSDbplJOOHeaY7ZdA8etPBNHmAeH2nc
         T4LV/hUD6R1rDbCNVZS5zi627UyhLE3ZUniQ10pqvKGHhSvGh6n9BsJzbP7y6gM5KHFp
         gegpqPWQo3RYsdFXeowzyIW967IMd/nW67CWYV5kNiUseCcw/pVZqz5sitzlENJmmfOw
         aNTX5NStjdyaMusd65cizIIFgCpfDDO8TSXwO+TqaEXl0QUpGYqOXZybRpNGVtuGdE0l
         eurJ/koJ9q5Wz2WQR6TfIB3jCOKhPmDplmhRohO/ImfnU0Gedoz3rrwn9HVHGy8Pem2w
         CAPw==
X-Gm-Message-State: AOJu0YxDXXGCxMkIMgr/UyNHqrvjS/0tlNRK7ul6REv/ocNao59gNHhk
	AZq4d1lp7qRpz5zEAPScybekPsSDfyVvaNlLgHO1L1++DP3M9sHsBpFdnW2UO0iJmcb19nqTwZ0
	NLlrSuQ==
X-Google-Smtp-Source: AGHT+IHotzhRr4UBIYXOGXx8RlCjPjkX4JTugM40+0xsVIHsU7q3grEsemIIu31kmAFFCRfvh1I+Pg==
X-Received: by 2002:a05:620a:1a22:b0:795:4d37:82a8 with SMTP id af79cd13be357-7954d378dbcmr153909885a.22.1717770419305;
        Fri, 07 Jun 2024 07:26:59 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79532887f13sm170522585a.71.2024.06.07.07.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:26:58 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 07/29] sunrpc: add and export rpc_ntop6_addr_noscopeid
Date: Fri,  7 Jun 2024 10:26:24 -0400
Message-ID: <20240607142646.20924-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Tao <tao.peng@primarydata.com>

Signed-off-by: Peng Tao <tao.peng@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 include/linux/sunrpc/addr.h |  9 +++++++++
 net/sunrpc/addr.c           | 19 +++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/addr.h b/include/linux/sunrpc/addr.h
index 07d454873b6d..e1007bddc3c4 100644
--- a/include/linux/sunrpc/addr.h
+++ b/include/linux/sunrpc/addr.h
@@ -68,6 +68,9 @@ static inline bool __rpc_copy_addr4(struct sockaddr *dst,
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
+extern size_t rpc_ntop6_addr_noscopeid(const struct in6_addr *addr,
+				       char *buf, const int buflen);
+
 static inline bool rpc_cmp_addr6(const struct sockaddr *sap1,
 				 const struct sockaddr *sap2)
 {
@@ -94,6 +97,12 @@ static inline bool __rpc_copy_addr6(struct sockaddr *dst,
 	return true;
 }
 #else	/* !(IS_ENABLED(CONFIG_IPV6) */
+static size_t rpc_ntop6_addr_noscopeid(const struct in6_addr *addr,
+				       char *buf, const int buflen)
+{
+	return 0;
+}
+
 static inline bool rpc_cmp_addr6(const struct sockaddr *sap1,
 				   const struct sockaddr *sap2)
 {
diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
index 97ff11973c49..78a123a7c39b 100644
--- a/net/sunrpc/addr.c
+++ b/net/sunrpc/addr.c
@@ -25,12 +25,9 @@
 
 #if IS_ENABLED(CONFIG_IPV6)
 
-static size_t rpc_ntop6_noscopeid(const struct sockaddr *sap,
-				  char *buf, const int buflen)
+size_t rpc_ntop6_addr_noscopeid(const struct in6_addr *addr,
+				char *buf, const int buflen)
 {
-	const struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sap;
-	const struct in6_addr *addr = &sin6->sin6_addr;
-
 	/*
 	 * RFC 4291, Section 2.2.2
 	 *
@@ -55,13 +52,23 @@ static size_t rpc_ntop6_noscopeid(const struct sockaddr *sap,
 	 */
 	if (ipv6_addr_v4mapped(addr))
 		return snprintf(buf, buflen, "::ffff:%pI4",
-					&addr->s6_addr32[3]);
+				&addr->s6_addr32[3]);
 
 	/*
 	 * RFC 4291, Section 2.2.1
 	 */
 	return snprintf(buf, buflen, "%pI6c", addr);
 }
+EXPORT_SYMBOL_GPL(rpc_ntop6_addr_noscopeid);
+
+static size_t rpc_ntop6_noscopeid(const struct sockaddr *sap,
+				  char *buf, const int buflen)
+{
+	const struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sap;
+	const struct in6_addr *addr = &sin6->sin6_addr;
+
+	return rpc_ntop6_addr_noscopeid(addr, buf, buflen);
+}
 
 static size_t rpc_ntop6(const struct sockaddr *sap,
 			char *buf, const size_t buflen)
-- 
2.44.0


