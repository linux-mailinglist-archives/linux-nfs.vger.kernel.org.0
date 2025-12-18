Return-Path: <linux-nfs+bounces-17175-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 152C2CCA9B1
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 08:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CF2E3000B5D
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 07:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A607A29898B;
	Thu, 18 Dec 2025 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7+OVI3v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA4287505
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042101; cv=none; b=dzkPNbaNqcd6ppdOljABL6ACY3SVMrG5sBw5ZqwFQREjukSMzjOIj4QgbIuISF5zcRi6PlnlVmmv9skbrNXzSJFfHs6qfkVa8QZEyNcAvQzbgvSTr5PvhCA3uQEt/iOoktjlP15BiDkB5N6kB7lzh5Mlu7+bZjZqa0qZPriWhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042101; c=relaxed/simple;
	bh=/y9MkvADFMcsmYvE1ddsnlJnaePJyAHmGkBSadSkccg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/mtfRBFD7M5Jn750ravXtRcnYEGxlUr06w3hTyTrNen2q02FqnnVf92iGBZ0KMZwD89opE2T9pCVuwHHpQTv0JgvljxVBJGMrhkO5vmbqWxTeKneqakjOUGEVtOfcEpftIdQ4m/JYKiRwgnQk2oZPq/N3oiWdk7FqvRQRxd+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7+OVI3v; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29f30233d8aso4348055ad.0
        for <linux-nfs@vger.kernel.org>; Wed, 17 Dec 2025 23:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766042099; x=1766646899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zdhljbo82J0wYUNTBfNteQUyRiOKz/nKgBkNMfvcmAk=;
        b=G7+OVI3vL5tfN1BMs4AkPnm0ZUnMbN5GEsJmzdFiOJzXsx5HDgsROnBQsB0QOMDmS8
         U2EnQSZLVrYCsqhXBXvR05Z4YyVadcP0HJwsF8M+uiqDOpBLbDNmarJK7WpGBz/y2koD
         LettGn39xsN7EG+GtAiLZA3GH443OM12wUUCb+KtHHkBAZZqMpl4zn/52Gv3esN9WWfw
         U+WlpsuNFBp1AGLK0S1MN6bhLge0TDjZtKePbDvVtMi/kZOKdtPcofZaDgK4JaN8A10u
         X5h9g82bRnsh4rS/Rv9cFsfgsY93hpr4PibJvZZ+xAtYvF1x7uPa/0XhmA/FEgqyCRjo
         hBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766042099; x=1766646899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdhljbo82J0wYUNTBfNteQUyRiOKz/nKgBkNMfvcmAk=;
        b=LQvFwFtkEQTsZPy72Urrmj/er97S51vdJ3MQsRXx2sQ1/j8OltgEw8hSdJ2OjDnRuR
         AZAj9pX6hSiFJInFWOrd4kid03iXo1JjYV+rCuSokuApEWuN2lRi8Hyf/8AjAgWeZV8X
         70JxigHFbxPVRrsoiRHcV+ceNiFWPG2IBDOq6ZIUZYGKA61+9/by4FDz/o/ayzzTRCRA
         g+h0TuFHMcTr+m8IouCpQH0eUKHHd8ZmUw95xdI9XHVuLlJ8i0HlatmBX10niXdNHy04
         L6Gy0W0qdkavq7J00D4CuFb2IZXWuOoO3OEKI44tKEbiXnI16SpD6WT7L7ynqO7Hpt8E
         uPfQ==
X-Gm-Message-State: AOJu0YzCSA9JlfdHTiAUc3upcgnVZ9bDd1etB8pf4BB/ZTNWja67OxGe
	X7Xkzx+jp4ZIKQxjGR+AAekBFDJNBGh3incZIVaccggkmjPS4zFE6ooC
X-Gm-Gg: AY/fxX7eNqHwYwtfW9nAfAGsxhih25SnAowST2Lwao34w2o+KbSQE8z9vLEuWYi+leW
	ayVg+1oqpQCILtbmwQc5UX7Jqzi2p38OB75nQYgC0LN+AzSHO5Afw44/dIeLveuIIakhxOciSVj
	EbFxnYGRLRKVcTZZ9KVK2aT6nrYBlxs0meYBS+da531pEO5iI75j0CVjiu7nwaItkUGdfoexHLb
	ivI3+p8xYtR5Bs71MzAgIQx2FczxYKChTPxDoeugZOFpziP8Dz4cvQmbzTnG31qnLOidlRGI4iX
	q0MC+vSzslbItWYfAwB/aSBzI9IAFfImm+aqFh6Uh3jZTtRMRFwWa7brtLRlZkggdSReEZ0//+l
	jwsDzqlMu7hsTLivAvv78pIfk6MOQfKN8buzv264POuenTz/FsawnHCLJHHFKZUG59brsE4zZ+T
	ZvAvC2+t1cYuoQgPmkupKTut9MnGRyVrEQIO23YNd7wvbqaPdqrsNdOcPe1oXU+Q4=
X-Google-Smtp-Source: AGHT+IFG9TGixAI7xHXaNvqu3Q9ZlPrOQ55clsFA6OHR09f5uh7HbrAMPnMgKd2YAnsTiaMN23xuCQ==
X-Received: by 2002:a17:902:cf4a:b0:2a0:cb8d:2edc with SMTP id d9443c01a7336-2a0cb8d31ecmr160202585ad.13.1766042099377;
        Wed, 17 Dec 2025 23:14:59 -0800 (PST)
Received: from localhost.localdomain ([49.37.176.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d1926aa5sm14688455ad.68.2025.12.17.23.14.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Dec 2025 23:14:58 -0800 (PST)
From: Suhas Athani <suhas2012athani@gmail.com>
X-Google-Original-From: Suhas Athani <sathani@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	sathani@redhat.com,
	Suhas Athani <Suhas.Athani@ibm.com>
Subject: [PATCH 1/3] pynfs: Fix OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS bitmask check
Date: Thu, 18 Dec 2025 12:44:48 +0530
Message-ID: <20251218071450.58128-1-sathani@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suhas Athani <Suhas.Athani@ibm.com>

The CB_GETATTR test incorrectly used
OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS as a mask when checking
server capabilities.

Fix this by correctly testing the capability bit using
(1 << OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS).

Signed-off-by: Suhas Athani <Suhas.Athani@ibm.com>
---
 nfs4.1/server41tests/st_delegation.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index f27e852..1a98200 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -315,7 +315,7 @@ def _testCbGetattr(t, env, change=0, size=0):
         fail("FATTR4_OPEN_ARGUMENTS not supported")
 
     if caps[FATTR4_SUPPORTED_ATTRS] & FATTR4_OPEN_ARGUMENTS:
-        if caps[FATTR4_OPEN_ARGUMENTS].oa_share_access_want & OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS:
+        if caps[FATTR4_OPEN_ARGUMENTS].oa_share_access_want & (1<<OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS):
             openmask |= 1<<OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS
 
     fh, deleg = __create_file_with_deleg(sess1, env.testname(t), openmask)
-- 
2.47.3


