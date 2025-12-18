Return-Path: <linux-nfs+bounces-17176-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0825CCA9C7
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 08:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB54B302B13B
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 07:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC5B285041;
	Thu, 18 Dec 2025 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTyEEuEP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F9A287505
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042104; cv=none; b=ukzQLe7Wl4NBAaFDJbojODiLjbAI/nQrbdPLJNaBjaSRDwu62/mV8BBb8WIT35DaFL9MSFzKeN/CugmfbTZrXMAjYZIJc2n1ApmdzUgaZqG6xA9vGHeSZSnY2ppLfNkm/poD0/Ew774CVQftU9V8dijcFQTje4+zD6Vhu6D0p6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042104; c=relaxed/simple;
	bh=8gwakvXezFb99wt9tySsmTVuUKfgnESJgW+UIyQkFK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfyWgLQ8CHq2No0qeOaPZ55BtsskM3uhgYN2T0XuMxWFLTKL1tFdOJUdUxl2B2/p032HjMmgjkhpxvoj3YjFZJ0tlvjpV4xujgXjX0BcV4DhG1H6MNPck9+0e7HHKciNJNTNxE42bY0IPWcgALqKx9s+jSefxSV0/dmiq6SrD88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTyEEuEP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0ac29fca1so2881105ad.2
        for <linux-nfs@vger.kernel.org>; Wed, 17 Dec 2025 23:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766042102; x=1766646902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/pl+Ae4j5ENAjWN1xpeLWK26RMJlTfTPSfhVgHChu8=;
        b=YTyEEuEPRXAUL/8mr/ufjaeNmDbf2nzJZRSsd5YQejm+BxtQbkczTNxqf+M+4oNAUT
         MOQcO7LuiOCRoYhGc02OrHb7YAEH4bE3QEVgOPvsa8JtxIooaLQPIkUmAVEZtNUF0dAN
         0dQphaoEAOcRgEZdyf2S3dGVrBvozT2sFhfUUsaEUPMvvy0GVOYGscYzG6cdivCtLpj1
         1YUOMqqYpUOT3fq80gYbEzxbkjnjKfW4shZqWXj/xSz87+IkL6IxP6VIhFmjAg3HHNLO
         ai6hygaijcKnnThoCbmf7U50N1Y2qi5xQgKCsBjepWMiDQqGxOdzNWnKdsVraTMYI6tb
         MhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766042102; x=1766646902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m/pl+Ae4j5ENAjWN1xpeLWK26RMJlTfTPSfhVgHChu8=;
        b=IyD4Phj4ZQM7YbGoD6iSidQwDlc7K5h7SztUe4eCvzumKR4Lh72DS7ZfVymXBko7el
         OfYvWsjzgpO/NZQ8GEv2atRGkYsoDvJR+JVFyNZMq07+JzAxDw0kJTnnkibioPyprzIt
         /Ck19FKeuY1EHenq8ygwc2y1zCxeFjVTV3yKYdTZ77Dthxstxw5Q93I12zkkVYDaTqHE
         XyZ/eYWe2r0qESmIKlNId2BRuicDMtY/E80djisdufs2943+a2/Ht5IteeoxV4+tpOCm
         3QZ/29CvQ866QsgeXQsccC/18VaC5101McrxT1/QQK+QDk3VeSTUvlySS8MQIjRLe/5h
         AjqQ==
X-Gm-Message-State: AOJu0YwgvT5znMtO7tBV5Kh+pZHYGVz+G6NMm/mId34DSNxrfUep0FKP
	ROJSRknTpDfdeC4pgmZDSFuC71aO8gxw6Ksubt1GgudVER7TY4ErcxOyiCn+EA==
X-Gm-Gg: AY/fxX6T3DMRflmw6jsrVpeJFuKXfzoVSc18r6MfssFBXQpw3r8lmA/ERS+Ih+ItvmA
	Tml+E13gZZYiixzbMO3A9yhnvo8jVXFyBqPykBMSUhdvKwsTGXfWVvQ5AmlHyZ2SBTre9egWiBl
	ottH+0aedTY2S/+BC4iALzZixYyLM8Z750yA3r05jU6oDDgHBhw1FxAicC9NYQemOzHrCTaU1Ba
	c5wvY9Z7AjoHSn/M7TJpZj9NL6fftIkRBmnfsAsIB63zMWRgAdN7sRw30pLc9d6r3n9Iwq/O7BD
	0c1UefOgdYl/hnpYfCZUg+c5PBk335i3Gkg7Wfn9N03eZEN+1M95SIl7GV71FA608Xybx2xHqfn
	/fguN6NiE2Medsr49/BbWzeODd+15pG50bzY7ozwUcu09W7Q82RZhCX/Vy7UnFOH2KCclyfw2Hw
	ppIKARkcvp71shEaAnABIOLJmu79i5DbPo3e47fjwsrNFf+4bRSrmA8TP4Wg6F6+s=
X-Google-Smtp-Source: AGHT+IHeOORtxSmd2gNudS7Su2gC9pXmnYYZYwt9ydN2SvrR89ykyyOHh5sOsrq9vwa0o7wyNMydTg==
X-Received: by 2002:a17:902:f78a:b0:2a0:89b8:4686 with SMTP id d9443c01a7336-2a089b84c28mr171296745ad.46.1766042101543;
        Wed, 17 Dec 2025 23:15:01 -0800 (PST)
Received: from localhost.localdomain ([49.37.176.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d1926aa5sm14688455ad.68.2025.12.17.23.14.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Dec 2025 23:15:01 -0800 (PST)
From: Suhas Athani <suhas2012athani@gmail.com>
X-Google-Original-From: Suhas Athani <sathani@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	sathani@redhat.com,
	Suhas Athani <Suhas.Athani@ibm.com>
Subject: [PATCH 2/3] pynfs: Retry GETATTR on NFS4ERR_DELAY in CB_GETATTR test
Date: Thu, 18 Dec 2025 12:44:49 +0530
Message-ID: <20251218071450.58128-2-sathani@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251218071450.58128-1-sathani@redhat.com>
References: <20251218071450.58128-1-sathani@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suhas Athani <Suhas.Athani@ibm.com>

The CB_GETATTR helper may receive NFS4ERR_DELAY when a delegation
callback is still in progress.

Add a bounded retry loop for the GETATTR operation instead of
failing immediately. This makes the test more robust against
transient delays while still failing if progress does not occur.

Signed-off-by: Suhas Athani <Suhas.Athani@ibm.com>
---
 nfs4.1/server41tests/st_delegation.py | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index 1a98200..1d51838 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -1,6 +1,7 @@
 from .st_create_session import create_session
 from .st_open import open_claim4
 from xdrdef.nfs4_const import *
+import time
 
 from .environment import check, fail, create_file, open_file, close_file, do_getattrdict
 from xdrdef.nfs4_type import *
@@ -346,9 +347,22 @@ def _testCbGetattr(t, env, change=0, size=0):
     # wait for the CB_GETATTR
     completed = cb.wait(2)
     res = sess2.listen(slot)
+
+    # Handle NFS4ERR_DELAY - retry until we get NFS4_OK
+    retry_count = 0
+    max_retries = 5
+    while res.status == NFS4ERR_DELAY and retry_count < max_retries:
+        time.sleep(0.1)
+        res = sess2.compound([op.putfh(fh), op.getattr(1<<FATTR4_CHANGE | 1<<FATTR4_SIZE |
+            1<<FATTR4_TIME_ACCESS | 1<<FATTR4_TIME_MODIFY)])
+        retry_count += 1
+
+    if res.status == NFS4ERR_DELAY:
+        fail(f"GETATTR still returning DELAY after {max_retries} retries")
+
     attrs2 = res.resarray[-1].obj_attributes
     sess1.compound([op.putfh(fh), op.delegreturn(deleg.write.stateid)])
-    check(res, [NFS4_OK, NFS4ERR_DELAY])
+    check(res, [NFS4_OK])
     if not completed:
         fail("CB_GETATTR not received")
     return attrs1, attrs2
-- 
2.47.3


