Return-Path: <linux-nfs+bounces-11098-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704EBA84F1E
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 23:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8DB8A8645
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D206120D4EB;
	Thu, 10 Apr 2025 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schmersal.org header.i=@schmersal.org header.b="hIBiQGgB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F103F1E5B62
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744319898; cv=none; b=Vg0LFqg5VrpWVYwcXI4jxHNPfl4cJhlsXRTgGXs9EcMJyE8vUsO6KgD3MbIj4EEiEsv5qo+TTWo+B1Z4n5F2v12qLEf0VEw95jsMtrN1UBQodYbWXon0kYJCINWPnVpvOCHz1yVFKZz4WWqjyftTPJAQ9HZlMValJHjIuuGcbCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744319898; c=relaxed/simple;
	bh=S0k5lyxhNZpBwMrtsGs7HmXManabuD95nQZ8GbGbS+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fbxauFWEHxoSCfIabqaFj6hKT1Ieyg8wQI8EOSlGrVadce9i7wc1zvnjEUpdEezW0ZZKZaC1fkyfB469p6YaCRGFnZyr02/3+LfarWxCh7wY1t9OngjneUbJ09Qyx0cnf8z2NyUCt7QDT4jjzOB0nzcWbK5JueoTrBNPJWP5enU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schmersal.org; spf=pass smtp.mailfrom=schmersal.org; dkim=pass (2048-bit key) header.d=schmersal.org header.i=@schmersal.org header.b=hIBiQGgB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schmersal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmersal.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225df540edcso25342185ad.0
        for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 14:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmersal.org; s=google; t=1744319896; x=1744924696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGlcnfF0plkltriSKEboXIFk7+9sHqBnnGBw0EnT9PU=;
        b=hIBiQGgBXtKFwUQNiBbk/1D/hydW9dlGEaU4nPx8pSOoiRN/YSFJ1TeWj3LQcXAoMv
         8YinhWJaEYjW5T6+csc7A69Jyus4DCPHsRlSkisKVCKfj941KYQKPeYzDkDzBVgaoNtV
         X6FpduzYZrOfursb66cslmlnB0kK7u6++19VfXqDiUyIMyl0fCZtdTimdEmzRE1bU3d0
         fFgqFjcDz38DimTBcmhs/Fvqer0nco1Z1Z6mcPz8h1AXy+H4EP/uYhYYnC8npBsFv/UP
         PJifhNPYdQ628S+366N0jq0MoKBENAGQGxCjF6Kur8NizphI90yzTJUYZh88Ayn4dBDw
         rlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744319896; x=1744924696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGlcnfF0plkltriSKEboXIFk7+9sHqBnnGBw0EnT9PU=;
        b=PARlwS961Y7i2YP2L1iv8dZnKudNGrYcgMrgbB5AP8tkeSpX63hyLyrZHFO55MpXvr
         MCbgMvwGL97J45nJzx9O+fblU1mUuN88C/fZeP6MaVPV3jJlg4Wx2IIz+545QakeAlzN
         aLuPdYFWPWuK3XxfyBH48CoaprSOvl+oOjbjFFGF50gozritwHcy8kPQMqiD3Jn2uD97
         V+piFtuIMrOgIs/iK7jO+Om4x/jF61RKo5eUSIpdFvjm0O8ctxMiU8MK/TQiFMcLp1Gx
         gNJ0Husf3JyCY/kVtCw3KXG4IiBKlb9bnTxlS3UE4nc3Wg39B2uHFnU8Y5nBUpqdcr65
         xsfA==
X-Gm-Message-State: AOJu0Yynj+CFBh3mtHtAbt1cNSouNfvyaKhS8xEgpCnqtrfw+XWhUtls
	uHmNz8OgA2LK95oB33pxTZsIhZXhU0ZktmVUkdp6dbrEyYzN6DxNnN654D9YAgk=
X-Gm-Gg: ASbGnctmnLPbl7J7wYkNhWwPoake8/PrShn1mcnHzg2AmyxQlXX4T1oBYyp3WX6XET9
	mHvaz6W8WKtbaSo3+V56xEj4vYojNnB0zJyL2xjW13HFbYWPPrAml8+A5gijE32sfM5qNGS7IHw
	OKGCn40QKl+G6kr99+86fXk0r/cfaepgYmOWOQJ6ncN5kb/fF481G/9NvaLErzhWb0db84YeyTs
	KIPN67S3c1Gd/nxyCbh7q71vwOCMjINon6t/C6UcJvM6IlaJ5mIzdHbc2zRPWY3oaNjU66RLFW+
	b1+elkADsTCTwTHh4eaDg7Dct+JmpjCNQuSP7ilL/crM9LevhBPuKYHVMSEXtvlxpFKhJdd0sej
	h2cN6YiZNmlPub6ZE7UixztiwkhXRwkVmNrqpdMg=
X-Google-Smtp-Source: AGHT+IFr2fGoWh95Fl5uP9vPIDr8zI+w193p6lbQqK3gGtPCXyCC7ZRxA3sanre0g0H3WkyLWZYj+Q==
X-Received: by 2002:a17:903:1b25:b0:21f:98fc:8414 with SMTP id d9443c01a7336-22b7f93cb2emr63402215ad.26.1744319896045;
        Thu, 10 Apr 2025 14:18:16 -0700 (PDT)
Received: from bryan-ThinkStation-P520.tds.net (h69-129-150-238.mdsnwi.tisp.static.tds.net. [69.129.150.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccb596sm35249295ad.220.2025.04.10.14.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 14:18:15 -0700 (PDT)
From: bryan@schmersal.org
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Bryan Schmersal <bryan@schmersal.org>
Subject: [PATCH 2/5] Allow max_retries and delay_time to be passed as arguments to compound()
Date: Thu, 10 Apr 2025 14:17:57 -0700
Message-Id: <20250410211757.480605-1-bryan@schmersal.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryan Schmersal <bryan@schmersal.org>

Signed-off-by: Bryan Schmersal <bryan@schmersal.org>
---
 nfs4.1/nfs4client.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index a180872..ba1e087 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -534,9 +534,9 @@ class SessionRecord(object):
         res = self.remove_seq_op(res)
         return res
 
-    def compound(self, ops, **kwargs):
-        max_retries = 10
-        delay_time = 1
+    def compound(self, ops, **kwargs):[]
+        max_retries = kwargs.pop('max_retries', 10)
+        delay_time = kwargs.pop('delay_time', 1)
         handle_state_errors = kwargs.pop("handle_state_errors", True)
         saved_kwargs = kwargs
         do_prepare = True
-- 
2.34.1


