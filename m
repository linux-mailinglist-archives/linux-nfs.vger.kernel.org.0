Return-Path: <linux-nfs+bounces-17136-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 082E8CC6FCD
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Dec 2025 11:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7AEF30358FD
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Dec 2025 10:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B90B3451DB;
	Wed, 17 Dec 2025 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8rH7tmG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF06E2BE625
	for <linux-nfs@vger.kernel.org>; Wed, 17 Dec 2025 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765966191; cv=none; b=I5G5WKfT5ym+Ss08ajp7R5s6CtzLZ8lTK6vPzofAtLPQ0wyMX64t83H1paAbI0d45qDX3iTfdCk0urjbVxNpuVqyrC9An5FZW0o9w4c9Osf4ucygAuesjHFX4bKpMO3axWJjtm9JYU3ZLJAj7FgQsCVsU4Yvblt7AKDhVO4kXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765966191; c=relaxed/simple;
	bh=jOMggS9bNB+bJWsql36fUcIY3hmxWQ78ag010EH7hQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=je4I1T9W5RbfjZtmswFH4GIJE5XuoVEoviJStA1zMZQWbMag0C3vmc28u4j5OJ+Viwo2IZDGWdVd0Jkx+5KdK4v7DWdTPYfG8gf6hQN6gcnKvUUZx7Xp+Khpk+ZXRUYIXcc/dUz+a3WAakND4Ojr23qiz9gbVSxymG1rnc5PIwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8rH7tmG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7fc0c1d45a4so1375297b3a.0
        for <linux-nfs@vger.kernel.org>; Wed, 17 Dec 2025 02:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765966189; x=1766570989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ar/kK5M90gcLVB7ZJs9zKBKcswyzBaKRnoFyMvftGK4=;
        b=U8rH7tmG+Djbc/aTSYf5WQpoTp71n9q6UJiGFWS7Kr4j0QoEFy0frDrQ49VKlhcI3n
         9M1ys3GHBwBaYrnITQ5VpQ9uGoYfseaNsOG0aL12XMqB0LcjS95PvvmMEOeRLi57Q3CX
         i6+4+b08sBPqaa1RssclGjihsXP/u5k/gn4Bg1hlsN+rDOloMO7N5IQfWY0+vhlz6SPx
         ZYQqiQu25UHv4A7erco2xUe7ld3CLKUbbIbCgm4ylEcbmsIf8d0QBjV60PuHY3Hikstx
         6lyisQx5O5M8gC2hkIOapCZgQUbPlCKI3iEM0LWw5htO2WlMSUsZ7Yd0fBuDKqxPd//4
         QIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765966189; x=1766570989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ar/kK5M90gcLVB7ZJs9zKBKcswyzBaKRnoFyMvftGK4=;
        b=xPAzM5DgHLGTkZiXdJQOxyeNQm2a+zBMyKwfxCK3mIuMkLvawhLK4C8gUEpBIUbpPT
         tPzBTQ7tQeXjU/VlFeIk7u0OcAtXy9VxXyHYmruiwOY7Sn5XijLTjd37gAfCzGmiO7Aa
         CJnyYGhjLdkBWwtK6Jro1lMO1Tbhid6hWVFlhg3n0ybe5YC1pui4upBsnYOQBS1LH04l
         dHUar5sqPyYhXIu3kmqv1k6sBLYFXkZey4vpS7wpM3r6/reYYQWidSNSIhDk7SqfIJMg
         b4eL+fJvD8Ukt/lC8gN6WPvGYrWKlzo/g/uifeGjwNVHgDKWSG/MuHpp9+ofhNrWwIvn
         +sUg==
X-Gm-Message-State: AOJu0YzAqHdFaHziLqDECaIufcZj5g6kRlMRNXhht4JJdn7Xx/oCQoGW
	oP1MeBlRwB76AW9Lj1+pqzUWr82RU0O+v7iqVIIqi7CRbUYQIhkHX6yO
X-Gm-Gg: AY/fxX4E5QQupP1UnF+vPOqC6ncOAaXgeYVmFrU+a2kL4p2aQbN8bO0kOUjAsrDS1IM
	SJxJXeloeWSoO0Ig7vA25DxO0gEJVi4Xq3nlegZ/t8MsftDPjE5++wymDg3bpsTbmFndP4EPctp
	7rvqYcnrr/8nzqtVe+mXbQzriVYsHYYVizJrQgBYHQoGvJVfNiaMpuB32K0JnBXmIsd9exVog8w
	KXrr5/cv8yCkyWAEeHp2zhZrM072VguQ9McEb1TkHK7HZb0E8YN7LQF9mZpUMum/Eol6Q+HFpn+
	MWlcs/02J7EzE1deuTzn5REmpxHixy6bTVgdmNuFsXFcRxhA1ju3FdlVfoOJ+ZkDfseBlaGUnN2
	pS7TgKLAYzpBKDtL/sKh0V6FtqtaKoo1yuBk3AFdMFw04HUIuXbbWOs7xYWf/0rR8Z8OEk3FfN+
	hb52wuIMleSBspfpgO60lh4Z/QJPwmv2IbQQ2AmxHqPgTDoG0INPCmgNn4eud7Q2o=
X-Google-Smtp-Source: AGHT+IF3NW3yhQXbYq82Sx6i1VMpeTWm+Z+iyj6Zi3nMTaNm+pLEKO18GBT2Z3cd4CWqztvZvNEkYQ==
X-Received: by 2002:a05:6a20:a123:b0:366:1992:89a6 with SMTP id adf61e73a8af0-369b4335720mr15780229637.9.1765966188890;
        Wed, 17 Dec 2025 02:09:48 -0800 (PST)
Received: from localhost.localdomain ([49.37.176.170])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2599228dsm18227306a12.1.2025.12.17.02.09.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Dec 2025 02:09:48 -0800 (PST)
From: Suhas Athani <suhas2012athani@gmail.com>
X-Google-Original-From: Suhas Athani <sathani@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	sathani@redhat.com,
	Suhas Athani <Suhas.Athani@ibm.com>
Subject: [PATCH] pynfs: Fix bitmask check and handle NFS4ERR_DELAY in CB_GETATTR
Date: Wed, 17 Dec 2025 15:39:42 +0530
Message-ID: <20251217100942.63158-1-sathani@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suhas Athani <Suhas.Athani@ibm.com>

This patch fixes logic errors in the _testCbGetattr helper
function (used by DELEG24 and DELEG25).

Changes:
- Fix Open Arguments Mask: The test previously used
OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS directly
as a mask. It is now correctly shifted (1 << Constant) to check
the capability bit properly.
- Handle NFS4ERR_DELAY: Added a retry loop for the GETATTR
operation. The test now retries instead of failing immediately.
- Fix Callback Verification: Updated the completion check to
verify cb.is_set() at the end of the test. Previously, the test
tracked completion via a variable captured before the retry loop,
which could lead to false failures if the callback arrived during
a retry.

Signed-off-by: Suhas Athani <Suhas.Athani@ibm.com>
---
 nfs4.1/server41tests/st_delegation.py | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index f27e852..ef8fc2a 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -1,6 +1,7 @@
 from .st_create_session import create_session
 from .st_open import open_claim4
 from xdrdef.nfs4_const import *
+import time
 
 from .environment import check, fail, create_file, open_file, close_file, do_getattrdict
 from xdrdef.nfs4_type import *
@@ -315,7 +316,7 @@ def _testCbGetattr(t, env, change=0, size=0):
         fail("FATTR4_OPEN_ARGUMENTS not supported")
 
     if caps[FATTR4_SUPPORTED_ATTRS] & FATTR4_OPEN_ARGUMENTS:
-        if caps[FATTR4_OPEN_ARGUMENTS].oa_share_access_want & OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS:
+        if caps[FATTR4_OPEN_ARGUMENTS].oa_share_access_want & (1<<OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS):
             openmask |= 1<<OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS
 
     fh, deleg = __create_file_with_deleg(sess1, env.testname(t), openmask)
@@ -344,12 +345,26 @@ def _testCbGetattr(t, env, change=0, size=0):
                                                           1<<FATTR4_TIME_ACCESS | 1<<FATTR4_TIME_MODIFY)])
 
     # wait for the CB_GETATTR
-    completed = cb.wait(2)
+    cb.wait(2)
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
-    if not completed:
+    # Only expect NFS4_OK now since we handle DELAY
+    check(res, [NFS4_OK])
+    if not cb.is_set():
         fail("CB_GETATTR not received")
     return attrs1, attrs2
 
-- 
2.43.5


