Return-Path: <linux-nfs+bounces-370-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D73807A7A
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 22:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31152824C0
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 21:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B037096B;
	Wed,  6 Dec 2023 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCGw6hXI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C11A9A
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 13:32:31 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-67ab85eee2fso412116d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 06 Dec 2023 13:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701898350; x=1702503150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjmnsa/PXIcnJR7hI9FkQeMZbLzo9sRPGi2QBjRRcD8=;
        b=RCGw6hXIpc+7P/k9Y/UT5cPDgp/Agr2F6o6Tkr/ZS6lx9bo02l2OZUd6IOV2/cLxMb
         rL9yzTrTBu577nqQ+LQEl7mOlqp6JpZ7AyS777nc0Ha0SHBqNIpIdRQ4FAdYUyE9xYs3
         XGXXwCLI4ycbzmBJZjaFqnI8byBqBVvG0iA62O/JBjK9637CglsR4f+k45FrDB/OvEjJ
         qdScdo1AXdfsPDYCmfxmLtPLR/9VqmM8h40whd1CkL/4D5EwQBvA/s3c034Htnu4h1B0
         Q9mX3ljHUcPijHUb1/7+obS5DgBrfSx1f3rMqM1Vk56w6TxlwJkhgPb++3FVIiv4d5Tq
         8/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898350; x=1702503150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rjmnsa/PXIcnJR7hI9FkQeMZbLzo9sRPGi2QBjRRcD8=;
        b=DNzgk+kFawYoq7YOgJEAoZxFDjZ5gSGVbEmaBvZ0825fWJRxThd2H8CTmuhqEYBDBU
         ntGdw5QU6owg/GOmRVWfgxz5eiASu7xHy+hDDxW1aYTniOfe1mbVlCiPF4FJWEgo6TJW
         8X/m2pNHP2iLOX6KjSUwlp1UHtVWt6kae7mwaRtvNv5g2AES2RsVQRCLEPYytWq4O6al
         SCUiKEQoskXKxlmVjaOZxpZBicLMcw57OvqTX1Zpht6yRBXDG9c2BHYj3H98r5OHoLRI
         pQvzRfIgezIqJXr5ms4+/JTNsofk+7k7tgSW3t1A++jEi+MuY+ysD1G19Ul7//Vrog01
         QvLw==
X-Gm-Message-State: AOJu0Yxfz2dkpdo8XHX9a1p1z5MpbM/DX3+xs6+wp/xj76XHC9MeFqkV
	NAsQP5o7KrcJOeSE1vXek61/3DXGxzA=
X-Google-Smtp-Source: AGHT+IELbGvXnVy3hUA5rh5cA/HSTdbeQuppExJD20DzCcg5unrzocxEIrcunSO2VRZlnO6Hv8ETjw==
X-Received: by 2002:a0c:e7ca:0:b0:67a:a546:6a5b with SMTP id c10-20020a0ce7ca000000b0067aa5466a5bmr2815267qvo.3.1701898350006;
        Wed, 06 Dec 2023 13:32:30 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b4ac:108b:be40:79b])
        by smtp.gmail.com with ESMTPSA id mk23-20020a056214581700b0067aad395037sm281417qvb.60.2023.12.06.13.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:32:29 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] reexport: add a missing header include
Date: Wed,  6 Dec 2023 16:32:28 -0500
Message-Id: <20231206213228.55481-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

Use of offsetof() function needs a stddef.h header include.

Fixes: 46f91dc8f0d9 ("fsidd: call anonymous sockets by their name only,
don't fill with NULs to 108 bytes")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 support/reexport/reexport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
index 0fb49a46..7f305267 100644
--- a/support/reexport/reexport.c
+++ b/support/reexport/reexport.c
@@ -8,6 +8,7 @@
 #include <sys/types.h>
 #include <sys/vfs.h>
 #include <errno.h>
+#include <stddef.h>
 
 #include "nfsd_path.h"
 #include "conffile.h"
-- 
2.39.1


