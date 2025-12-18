Return-Path: <linux-nfs+bounces-17177-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5E0CCA9A8
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 08:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CAD93052D54
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 07:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3080129B8D9;
	Thu, 18 Dec 2025 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVWO6sIq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868863C2F
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042106; cv=none; b=koBzvJWTri6EPqJwI85ygSalZQLqxtNzEDL3/WD7QwbiFNSxyxAhOFI7J4cdRoCIPA9Cyg2mGnmVKrq8rwoogQVRpif7ZXxQjpttsHSrRpz4wqzTSoZ28SwAVFdekgJ7lEHbOWUajGka4FYC4e5PxrXCgUyEiTpMdDuHoHe8yTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042106; c=relaxed/simple;
	bh=pRns/p8qUGtnC/QC1ZuapNMxuuDZQ6XiKTp/97aIhx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huWhK800r+ETJYZZFhTs9hnqGLm9jM0Ihvzfx0mBXfuMf3ylOQZGmdqPoY2hBOIDRgdLdd6mExkSD9QBWEW1RK7wpDxygt8q42i5JT+DNZcRQh8yRX2Lht/Jr4JUKy5wjcBucGIf+ky50JuPd2YmRV0qn12IV/EdqLNOlnbtKUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVWO6sIq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0bb2f093aso3275875ad.3
        for <linux-nfs@vger.kernel.org>; Wed, 17 Dec 2025 23:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766042104; x=1766646904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CORY8FH/WlBEn3Qb5B7X2Wmd/52aPahj+ZXJLVszXdQ=;
        b=dVWO6sIqAP3I3v95MkL1iFc7XPv72wXU0kbaY3oE9gThvmfqVSMRuazSSwBlyuC7p0
         mREszlRLMS+fn4CAly6vZ/S66PIRL0xsS6/dWsV1DlDwDH/9VOkFzzgDjjRs6fyKXj3u
         5fZEp69XMwcTctiMByplNkpgyZ3nBsJurI1d3fZMKWKmUOEithY429wCpMrQ3ZRYQ3HH
         y7BrHh1r1fNgp5vInN2rv503GmdW/r7jwR82jhRaBzAL1zizhmMO3NOtv++/Y6R4hF6M
         mpc1heTdv3iOgXXSGJm362zqdDlaNS42TAcCDENOFYB4B6YF1b9GPVrF0klo7UdBrkMo
         ojtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766042104; x=1766646904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CORY8FH/WlBEn3Qb5B7X2Wmd/52aPahj+ZXJLVszXdQ=;
        b=PTKjRmb0iMb0GEz6NX1d5UA/8GDR964apo4es5N1yKWp77PrnvtWkPzHC5VTKAn+r7
         zsCGX9uQjccH2FCGPQ/5g2DTckElXqBWp7ssB5KdfA9w5XOr3IdtMmz8qKB+HDz/lLD9
         GnQZXJGiq8Tffw3w8Af3OLKd6XdN27WBNXVsgFhil+/D60Znd789oh2rrQnqfD+9gEVN
         Cahbm9sRnGAIdmrOX3NorydK/0m9Mht4ORZp3sR/oy3cRnL3cZEKBiq1QHu+bpm0TsX1
         CeKKx4Hx5LUrGrB4H1ueDRcCbaMCj4t5LFOJdMLwzKacgxotneWhHvJxKINDS48l2Rx/
         IZgQ==
X-Gm-Message-State: AOJu0YyR0XTfnUX6EapcLCsQvAPkNicL2JkiVkCju/x54REi7Nd5/Fiq
	d0axkDc/jTwHaC0/4l/PDQy8psF4uau2Py1y2+YuAA1TF2EdWHCU6UNA
X-Gm-Gg: AY/fxX40Ab9keYBIOanzRucWCRq9bYNau24U5bwhk5K6kWsCsZi+ag7ZGe8bDLkA9Hl
	uYpnUxyOCvx4vu5s58B5Quw0HSSZiy5+ljy52GdLBFFY5yomQUkTzuCvZ7rxtN9LGsv7P0iaySu
	9S2isyCt8pTtEwKJbNHP96mFfcPpXH+CubqOmA6xRneCH5rbbcjaSZQf1aegxKdn4b5f2jj7tiS
	rLpQkqsyL2QlmETyMdSQ6NVSGh47ZBOvxd2iiMO8lfiC6oKMCl3EcbPWRAV8TGKjJiR2jSg21ca
	fHKyfi8LXV6FZHLYpg6TKHXNMJVixscml6s8bT0Vo1Rax9Ujr88F61pF3dyc4f6TklTi3K1gC7p
	DbuZpo5MegVJ1qG2SfOu64ICtoN3XFJs+VH1GtMfQT/b9nhSGE3Vf1BcttyfXEqblQOETiybIL0
	pgKpdCKvaSbeZsWWoHxNXbEGR6ENeqQw8gbEAqfeZRGt7ufO1RktbAbbsqrEeBMVo=
X-Google-Smtp-Source: AGHT+IEpCtqKmgyntboZzlk13mTVj9anL/72YuddlxqxylR+RF02+Z22J74u2i33Pf5KClryMqnYVQ==
X-Received: by 2002:a17:903:2442:b0:2a0:b62e:e016 with SMTP id d9443c01a7336-2a0b62ee12bmr144408405ad.32.1766042103783;
        Wed, 17 Dec 2025 23:15:03 -0800 (PST)
Received: from localhost.localdomain ([49.37.176.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d1926aa5sm14688455ad.68.2025.12.17.23.15.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Dec 2025 23:15:03 -0800 (PST)
From: Suhas Athani <suhas2012athani@gmail.com>
X-Google-Original-From: Suhas Athani <sathani@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	sathani@redhat.com,
	Suhas Athani <Suhas.Athani@ibm.com>
Subject: [PATCH 3/3] pynfs: Fix CB_GETATTR completion verification
Date: Thu, 18 Dec 2025 12:44:50 +0530
Message-ID: <20251218071450.58128-3-sathani@redhat.com>
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

The test previously tracked callback completion using a variable
captured before retrying GETATTR, which could result in false
failures if the callback arrived during a retry.

Update the verification to check cb.is_set() at the end of the test
to ensure the callback was actually received.

Signed-off-by: Suhas Athani <Suhas.Athani@ibm.com>
---
 nfs4.1/server41tests/st_delegation.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index 1d51838..a366002 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -345,7 +345,7 @@ def _testCbGetattr(t, env, change=0, size=0):
                                                           1<<FATTR4_TIME_ACCESS | 1<<FATTR4_TIME_MODIFY)])
 
     # wait for the CB_GETATTR
-    completed = cb.wait(2)
+    cb.wait(2)
     res = sess2.listen(slot)
 
     # Handle NFS4ERR_DELAY - retry until we get NFS4_OK
@@ -363,7 +363,7 @@ def _testCbGetattr(t, env, change=0, size=0):
     attrs2 = res.resarray[-1].obj_attributes
     sess1.compound([op.putfh(fh), op.delegreturn(deleg.write.stateid)])
     check(res, [NFS4_OK])
-    if not completed:
+    if not cb.is_set():
         fail("CB_GETATTR not received")
     return attrs1, attrs2
 
-- 
2.47.3


