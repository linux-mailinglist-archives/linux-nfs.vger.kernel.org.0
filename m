Return-Path: <linux-nfs+bounces-17368-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC05CEB09A
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31C9830074B8
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E61223C4F3;
	Wed, 31 Dec 2025 02:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwNsWlLI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06383A14
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147729; cv=none; b=TOKrSPwzwCvjZwG9Pgknt6dsEbgVE+BT3v9r4ml/huIWZIriB2xamMIYs1LxzkH7XTcC1WsDfib49YFavDLdfTVQbnFiHc4xDttdUJg9sJNTSKmK9fZMTsFDWDvHNUY8AORRSZc6ax+4latV9t0AFo3TFjT7Sgp6LVDN+muNx+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147729; c=relaxed/simple;
	bh=g0Jq+5imPQEfSpSqxfmczoHEEnRyn2NJ4Yb5xHFKAtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtI8gph0wouEpg7SAFpU9IuHBhM/DsgpganYjwZvtukCkg7xT/cDeKWfiJ6nHy6z3NO7cey6/EJq1rxFpBcV5QW0tGRDjFF457skUnUa0sDgkywTQsJyytZGUetzdStjm4DbRXwiD6A18KBNrpZKhFH5/ZXnIVHbizTFLLTPVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwNsWlLI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so8101775b3a.1
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147725; x=1767752525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/xKs7kyo4J8rwB1E4F4E0z2rf/3IE+DWrEenf/ki9g=;
        b=QwNsWlLIpPUJq5EN4/S0YzmJ59O03fuWGYUKmlECrWUhAu+P77TZt1ZM8OF4iNSrxr
         l/SXum6xq+D4moWbKm2PaEWXwGTff4clC35v+8Ixqp5dO5UVkvL3nYw8A52/8JowEkqw
         PwPzZT4j/VbLA559mIOCisF27ZrMQBsvV3hrKIjAuacPmj/k0kitJQKdBEz+mTOSLad0
         h0y4RgQa565o/aAcE7V0feGViexaEOv5g5kHccCIVEZNcfK0Uw0CVoYWdcNmUWek8CQs
         4+zSwtl8caLSoIB47HD25KZDVfZn5cL1LwhN+Shn0tL79P5q5faRgwDc74u4IgSPHI3R
         Pucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147725; x=1767752525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z/xKs7kyo4J8rwB1E4F4E0z2rf/3IE+DWrEenf/ki9g=;
        b=IIw6O7xBs6AyVqGCbC+8VjolVd+ugmA0z5UpBalzSAV0/BEgxkAvLhVJLOV6mfbHwR
         wMlzcEYt8q3B9HsgP609boGkDTIZOad4qKIejytt8IzJit6zk7ssZJEfqMTU7XEEY0z/
         Cts3zxQSLvSVIjcMfeUJu411Im7XNHnKnr9oVap8mqvYCKx75UYjkmUh9yrTjD1v50PE
         jFdI2D67icEDO6F2wwBC5xtivYqlGHZNjVq3+p6qWXvUJ2cgPGeVMAjlYkKUTdwPqsk6
         Ha8wU5msmP3kREVSyyGKAHkrIybBnD1UWg6LpYWuU1CSlITivojaQyHmQZqUIXicUbIS
         Acsg==
X-Gm-Message-State: AOJu0YwC5NyA/+C6Zm/F1Qslx1aFdAcscBzFvnq3GURmEHP2/tcPG/j/
	FjR3NTNymBTAt0wYKWvkuPJUAcYUSH1nwl/kzaCg+M5Qel+jgo4XO7vbmsZ7e50=
X-Gm-Gg: AY/fxX7O70e3KvytCakBP6KsY8KqsFq6HbA7HaZykfiwkdwrKXpZDTWcA7an/UIVfFy
	Oo6nyLa5cr+Fl1DiIbxkDjSNyPOdIMV3guLCdkL50ViUS3QPhkoL/1I/GYHM9A9S1T6zcDW0Bel
	iP/cyEP4kRTtqNORsqmmEiQBKlY8KAAGau3crDnRwzvMSitsPzTJ6bNrGsvHX7NYkXHPyRoM1l3
	Z53UGET2N1DgDH/eRKt4OBYnU6aDHYdS00YT8NS7Wiy0OStMsSv1fko5FT3eQBd7PF/RmJOLFMN
	vHgkd4cTCFzHOSYmrnWB8cFzHpphh3R2+VnwlFT6giN2CTE4M8MTFpJ9W/BKv7iF5JbjBbMn6ku
	4kNWmKC78qjZ8B1wCklJrAz0Q+vDrH2MeTdQ6xw/+HSdiLV7JDudfPGQCaRWU2NzO1JPTWLmVm8
	av2dWBvaT3uDKOuTkRwKu/1F5CtjiBY5CuyHXfrfqYHNHSvCNdfnTtK1Ei
X-Google-Smtp-Source: AGHT+IEvZUtYwZa1SZ/cFCQNjg29xJoJHrVvES6KhmC3A0eMkLDH2ehc+Ojv03qFQ4cWbICze4ktDg==
X-Received: by 2002:a05:6a00:8086:b0:7e8:4587:e8c8 with SMTP id d2e1a72fcca58-7ff6687381bmr30108840b3a.59.1767147725132;
        Tue, 30 Dec 2025 18:22:05 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:04 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 01/17] Add definitions for the POSIX draft ACL attributes
Date: Tue, 30 Dec 2025 18:21:03 -0800
Message-ID: <20251231022119.1714-2-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251231022119.1714-1-rick.macklem@gmail.com>
References: <20251231022119.1714-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

The draft defines four new attributes as an extension to
NFSv4.2.  This patch adds definitions of these four attributes
to the nfs4.h file.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 include/linux/nfs4.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index e947af6a3684..9d70a5e6a8d0 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -516,6 +516,39 @@ enum {
 	FATTR4_XATTR_SUPPORT		= 82,
 };
 
+/*
+ * Symbol names and values are from draft-rmacklem-nfsv4-posix-acls
+ * "POSIX Draft ACL support for Network File System Version 4, Minor version 2"
+ * Section 10.
+ */
+enum {
+	ACL_MODEL_NFS4			= 1,
+	ACL_MODEL_POSIX_DRAFT		= 2,
+	ACL_MODEL_NONE			= 3,
+};
+
+enum {
+	ACL_SCOPE_FILE_OBJECT		= 1,
+	ACL_SCOPE_FILE_SYSTEM		= 2,
+	ACL_SCOPE_SERVER		= 3,
+};
+
+enum {
+	POSIXACE4_TAG_USER_OBJ		= 1,
+	POSIXACE4_TAG_USER		= 2,
+	POSIXACE4_TAG_GROUP_OBJ		= 3,
+	POSIXACE4_TAG_GROUP		= 4,
+	POSIXACE4_TAG_MASK		= 5,
+	POSIXACE4_TAG_OTHER		= 6,
+};
+
+enum {
+	FATTR4_ACL_TRUEFORM		= 89,
+	FATTR4_ACL_TRUEFORM_SCOPE	= 90,
+	FATTR4_POSIX_DEFAULT_ACL	= 91,
+	FATTR4_POSIX_ACCESS_ACL		= 92,
+};
+
 /*
  * The following internal definitions enable processing the above
  * attribute bits within 32-bit word boundaries.
@@ -598,6 +631,10 @@ enum {
 #define FATTR4_WORD2_TIME_DELEG_ACCESS	BIT(FATTR4_TIME_DELEG_ACCESS - 64)
 #define FATTR4_WORD2_TIME_DELEG_MODIFY	BIT(FATTR4_TIME_DELEG_MODIFY - 64)
 #define FATTR4_WORD2_OPEN_ARGUMENTS	BIT(FATTR4_OPEN_ARGUMENTS - 64)
+#define FATTR4_WORD2_ACL_TRUEFORM	BIT(FATTR4_ACL_TRUEFORM - 64)
+#define FATTR4_WORD2_ACL_TRUEFORM_SCOPE	BIT(FATTR4_ACL_TRUEFORM_SCOPE - 64)
+#define FATTR4_WORD2_POSIX_DEFAULT_ACL	BIT(FATTR4_POSIX_DEFAULT_ACL - 64)
+#define FATTR4_WORD2_POSIX_ACCESS_ACL	BIT(FATTR4_POSIX_ACCESS_ACL - 64)
 
 /* MDS threshold bitmap bits */
 #define THRESHOLD_RD                    (1UL << 0)
-- 
2.49.0


