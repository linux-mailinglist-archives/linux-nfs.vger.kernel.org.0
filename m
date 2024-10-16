Return-Path: <linux-nfs+bounces-7194-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047E19A08A2
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 13:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361021C22B22
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 11:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA862076BB;
	Wed, 16 Oct 2024 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PftNsVRR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B661206059
	for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079304; cv=none; b=d8xeAK+Zip8APg2S0Znw8jld2MIF418sdgt2kSEswEQxHWqLGJLbIw4H14vwbnfa/1JmWD5TQQOOaOlWJuU048307Xx3ZBI6qlmh3p0bhPRe1d1xrn8GDgmnMgv4B38IzQss1KmCTcMR6on+r7WYyiB0Hw8+ozOE335QUjpmsa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079304; c=relaxed/simple;
	bh=eu+25H83fZ3AZJj3Xmuho4Y+d5B4KXdwCNRVXTJBPis=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=eBYNiKBhEs56VWesIPuoUicpjqk7DSMAiFrpM924dsBbk+4XmloLtvSr/37d7iv/NV7cTTQj9ov6hVVMqGFlGMDOLfhCbXLQATaaIIV6v1J+jregd0dJwswDom9NDRgMUJx0pbn6bfQjfWUwtV5mJZkX0R6EsV2DBzQSpcrh5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PftNsVRR; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4ba20075so4288779f8f.0
        for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 04:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729079301; x=1729684101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PktEzubkoqqhwuLMCzcaMlIAVvRQ8abKGOIdjgaahjk=;
        b=PftNsVRRnlkjQ9RHxzj0nar3+LkNc5JJqRz5PTM5iEncpqRjX8e+m1XZKb1kLImYfg
         AYbBgXJV0napDqZm1YrhHlRpS5W6bpre18SHPdDnRoVG20X6gLP8p/zLlu/ch1tDB1JL
         fUt9JjYl4768JDFKCdr+3QuVPICveNDYiwbxSRzLyOwBtis2sXL7J2JzCaTTAKMFR3P9
         p9AcivlozcenwRmFvussd9LfgPCgeGdg3uls75SPOab678c8n9lRAn5LoMaZcrUy5oqP
         BsxrsN2Mo7yRienZLI9f3PDu/g3sAHf/jcAEoPMwTmlSmfwDvgZfSR/eS9Pnij51dlei
         67MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729079301; x=1729684101;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PktEzubkoqqhwuLMCzcaMlIAVvRQ8abKGOIdjgaahjk=;
        b=KPNYG0zPjtpEQDATfdjUcIsZdPhccGXMZ32wIGXFuxb8m1UE31O7fldXi6Mv27L5ci
         6XoUhfD9NVXSlXndvUcL0rnTxVmid5NFjiriyJI4e4Si/LFyc0xjlXrYIDJGkwUWjKrR
         Mdd0d8WbDRL/232P8K5kRL1yS6YjKzhGP1RnWfbNNc+aquzIytjoTRJp9mzW3KiOru6o
         ShvHzxjRipjZdOmFS9gN9XvLHL+8EVtG/Zz9ht9YNjImMCBKVx98P0xHiN1F0YNcAify
         F/iqAd8w/LzlVW9VI0ueCidBCUBIV3AHPBZ+uBJF94fymRTU3scVQxPced8pY5VKci0/
         xDnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT8PuC/1pqDWltV6gGX6L/nuTlvgUsc9/oRqEeHFecDOTzBRWfrN3ZGUSnrLOK1kZqX9fhsfG2tlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0dIvTeNxgokdl6mF6tN+CMsRTmQA5C/czji2RkgMaDGmf1Vn9
	/p9ZEdiKC4iwQUlP4bncu8E2Ftud8RcJEHvm51KET8/GD+y8GBih
X-Google-Smtp-Source: AGHT+IFa4sWXzR7P1MLTlsGnZu3PwAlq0AGf2LnzEx4wXorNLbOPQWrYsHY//h53XEZY0FONcX/KFA==
X-Received: by 2002:adf:ea8d:0:b0:37c:d1b6:a261 with SMTP id ffacd0b85a97d-37d55300b05mr12584883f8f.59.1729079301154;
        Wed, 16 Oct 2024 04:48:21 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc445fesm4109430f8f.113.2024.10.16.04.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 04:48:20 -0700 (PDT)
Message-ID: <30e0a095-4684-4271-8748-82d1ecd1facf@gmail.com>
Date: Wed, 16 Oct 2024 19:48:17 +0800
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
Subject: [RFC PATCH 2/5] SUNRPC: move macro for resvport to address header
Cc: kinglongmee@gmail.com, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 include/linux/sunrpc/addr.h     | 5 +++++
 include/linux/sunrpc/xprtsock.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/sunrpc/addr.h b/include/linux/sunrpc/addr.h
index 07d454873b6d..f662798c5d83 100644
--- a/include/linux/sunrpc/addr.h
+++ b/include/linux/sunrpc/addr.h
@@ -13,6 +13,11 @@
 #include <linux/in6.h>
 #include <net/ipv6.h>
 
+#define RPC_MIN_RESVPORT	(1U)
+#define RPC_MAX_RESVPORT	(65535U)
+#define RPC_DEF_MIN_RESVPORT	(665U)
+#define RPC_DEF_MAX_RESVPORT	(1023U)
+
 size_t		rpc_ntop(const struct sockaddr *, char *, const size_t);
 size_t		rpc_pton(struct net *, const char *, const size_t,
 			 struct sockaddr *, const size_t);
diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
index 700a1e6c047c..b627065db7ab 100644
--- a/include/linux/sunrpc/xprtsock.h
+++ b/include/linux/sunrpc/xprtsock.h
@@ -11,11 +11,6 @@
 int		init_socket_xprt(void);
 void		cleanup_socket_xprt(void);
 
-#define RPC_MIN_RESVPORT	(1U)
-#define RPC_MAX_RESVPORT	(65535U)
-#define RPC_DEF_MIN_RESVPORT	(665U)
-#define RPC_DEF_MAX_RESVPORT	(1023U)
-
 struct sock_xprt {
 	struct rpc_xprt		xprt;
 
-- 
2.47.0


