Return-Path: <linux-nfs+bounces-7195-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2089A08A3
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 13:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D982C1F23F00
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 11:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CF1204F9E;
	Wed, 16 Oct 2024 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GObkdPB0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA6A2076DA
	for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079308; cv=none; b=SYiFx5HTP9vDQy3m/POaytkVZqNZvIonUkX+Q0+i+QzZFC0NExz7LHlNorw82zITf8W8Gqsxrk0AwA3e9Z/sIL6M93ml21DoZp8FUNsgFjxrSCBDtewx93DTW3E9YL/99qtT65/pr6tPnKLKVIvX9P1A+igrf2XqFtYTdbFIZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079308; c=relaxed/simple;
	bh=VVTu70tv98puH0c6noYlH+9HzYoP6WKevvtBuIwanU4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=LiqMswC4I7R56AF2XDIEWqWwqmOSQucs97UP36KvOpr9/Bv6EnCklcRt9CKPJWWZBxuLIWvvnHr6gYpuHvMVYIHvj9X/IZ3tNhLH2Nb48+x1lyUI/+SIYxLDFtFwoOKYI3LB2Ydhs4SNUfH15Pkkc2bSsnlW+Sd2VCBjVtZ/jo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GObkdPB0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so4601220f8f.2
        for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 04:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729079305; x=1729684105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpwmcC4XdvJxSE1ZsmpIDb2iUQKkONcv1m5Cn51GsXk=;
        b=GObkdPB0utsM0IdY3KdO/S0ZzqnT+3Ao+IFFhEo6Fbs/7i0hpYcytdCyfOYlRwFhhN
         +OHWshzhTPlEBaXtZg2Ivo/+a7MuFma7KWejUl43yFP8cjm6xvIblMO/rcm1ZUBkMQ6r
         pxTnP3uDvmxJ5b/dRmGZSyuaDIM0pKt+1+ePSD9287kfwxHX1ZVArToyT4DCTKtIxtSc
         98CDhlfOsTtrKsqlZCdM5L8xLfwqISNKUj3o7MilF5gjJYr36oKewULI4SAPmiphgmtf
         A9dj2fe09zBvLA3efosU82BjKDpj5kuI6aHVimxhYGB4fGtVk5vZHINQUnuzXFQjaATD
         of/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729079305; x=1729684105;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jpwmcC4XdvJxSE1ZsmpIDb2iUQKkONcv1m5Cn51GsXk=;
        b=S8yCP3EIpei15D5/1vmZp2iOaGpKYmTT1V8KD3XqNfnCsxS410T7h4pMcM47TbE5LZ
         nLpgJvfmBjrGVudgsiW6KVjhg86wkbmugaoVEoBdRfGv5h2iQV319J+uLytpYvNjlRjb
         EvB+PTQ9vFndc8kPchrI2Gk9cm4vFZYo+z+BnLQXLsynYgq+fuoB+qPx520CFPkFDMIN
         hsa49rlB4Ts4I0kCtwmlMgbw8x08TjRIuNbpf3euqfveuAwThTIeJLbflv7Qz7u4WlT2
         RYgy7S+tdcw+k67Fu9GmlpDeE3HbFW+ybDKO6rtzbvmQ58e9uUQDv07NBHauwMUgH6+X
         Hpng==
X-Forwarded-Encrypted: i=1; AJvYcCWR0P5RbrgZNnF0WUbFcEaAcO4ep+80NB13QJSswnap6tyYIxLRsWhyLLCbTSOAEh27LIiFsZfA6yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE9YCCKCjHDslFnB0KFa0Ap2GlKQ9dKH9xHpDEhHNOXpqoWTjY
	SVcpRZFVy9zAJmwIpbz0K49ql0zep56aGK6FncySgIVytdfpC3fg
X-Google-Smtp-Source: AGHT+IG3mpkkFzwTf3IH5MKBzQRzp/zSOc071va3iNsSH4Qzd7MMx/QrEV63RcxWQBFjFqIzAaBNfg==
X-Received: by 2002:a5d:63c6:0:b0:37d:45c3:3459 with SMTP id ffacd0b85a97d-37d86bd5846mr2498671f8f.21.1729079304629;
        Wed, 16 Oct 2024 04:48:24 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc445fesm4109430f8f.113.2024.10.16.04.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 04:48:24 -0700 (PDT)
Message-ID: <e2f8d460-5b5a-474e-bdc4-ed95bd4dbcbd@gmail.com>
Date: Wed, 16 Oct 2024 19:48:22 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-US
To: Trond Myklebust <trondmy@hammerspace.com>,
 Chuck Lever <chuck.lever@oracle.com>
From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [RFC PATCH 3/5] SUNRPC: move helper xs_init_anyaddr to
 rpc_init_anyaddr
Cc: kinglongmee@gmail.com, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 include/linux/sunrpc/addr.h | 26 ++++++++++++++++++++++++++
 net/sunrpc/xprtsock.c       | 29 +----------------------------
 2 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/include/linux/sunrpc/addr.h b/include/linux/sunrpc/addr.h
index f662798c5d83..134450a9fd38 100644
--- a/include/linux/sunrpc/addr.h
+++ b/include/linux/sunrpc/addr.h
@@ -186,4 +186,30 @@ static inline u32 rpc_get_scope_id(const struct sockaddr *sa)
 	return ((struct sockaddr_in6 *) sa)->sin6_scope_id;
 }
 
+static inline int rpc_init_anyaddr(const int family, struct sockaddr *sap)
+{
+	static const struct sockaddr_in sin = {
+		.sin_family		= AF_INET,
+		.sin_addr.s_addr	= htonl(INADDR_ANY),
+	};
+	static const struct sockaddr_in6 sin6 = {
+		.sin6_family		= AF_INET6,
+		.sin6_addr		= IN6ADDR_ANY_INIT,
+	};
+
+	switch (family) {
+	case AF_LOCAL:
+		break;
+	case AF_INET:
+		memcpy(sap, &sin, sizeof(sin));
+		break;
+	case AF_INET6:
+		memcpy(sap, &sin6, sizeof(sin6));
+		break;
+	default:
+		return -EAFNOSUPPORT;
+	}
+	return 0;
+}
+
 #endif /* _LINUX_SUNRPC_ADDR_H */
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 0e1691316f42..c4c002fd7333 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -3125,33 +3125,6 @@ static const struct rpc_xprt_ops bc_tcp_ops = {
 	.inject_disconnect	= xs_inject_disconnect,
 };
 
-static int xs_init_anyaddr(const int family, struct sockaddr *sap)
-{
-	static const struct sockaddr_in sin = {
-		.sin_family		= AF_INET,
-		.sin_addr.s_addr	= htonl(INADDR_ANY),
-	};
-	static const struct sockaddr_in6 sin6 = {
-		.sin6_family		= AF_INET6,
-		.sin6_addr		= IN6ADDR_ANY_INIT,
-	};
-
-	switch (family) {
-	case AF_LOCAL:
-		break;
-	case AF_INET:
-		memcpy(sap, &sin, sizeof(sin));
-		break;
-	case AF_INET6:
-		memcpy(sap, &sin6, sizeof(sin6));
-		break;
-	default:
-		dprintk("RPC:       %s: Bad address family\n", __func__);
-		return -EAFNOSUPPORT;
-	}
-	return 0;
-}
-
 static struct rpc_xprt *xs_setup_xprt(struct xprt_create *args,
 				      unsigned int slot_table_size,
 				      unsigned int max_slot_table_size)
@@ -3180,7 +3153,7 @@ static struct rpc_xprt *xs_setup_xprt(struct xprt_create *args,
 		memcpy(&new->srcaddr, args->srcaddr, args->addrlen);
 	else {
 		int err;
-		err = xs_init_anyaddr(args->dstaddr->sa_family,
+		err = rpc_init_anyaddr(args->dstaddr->sa_family,
 					(struct sockaddr *)&new->srcaddr);
 		if (err != 0) {
 			xprt_free(xprt);
-- 
2.47.0


