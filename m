Return-Path: <linux-nfs+bounces-10683-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDC9A683B1
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 04:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1DD17ABD44
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 03:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845C820CCE5;
	Wed, 19 Mar 2025 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="TD65pRA9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80022524F
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742354662; cv=none; b=gZZ6y6MYsC0QXp5WxXLk0pKIQDnLe0KMuAQvGM7wCojAdhI8W7KOzYgXqRei9ND1+6XSafm8jPYxlo92xzpbNTmgY8rgm9I6zfaV5MkqzxZRDZZF0KgmFuNGEKBssEvIDPV1Wmy75lqvV7ABTFBzOH286pzQow8gLmYI58eFwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742354662; c=relaxed/simple;
	bh=MN9oZmbNILNdEvoHmvsDnZPCG22sTovtr1MWMH+ia4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RIZyKNxKoTyBecPwrOJBxzi50gw2MX+zanFzkEkAAEMrleaGCmLWlHe9F9q9bg4CIaaC5a+3q2JOiIIBJ6xm6vGXCbtT+xzlT1CVg47A0/g6jDj+crYCnO3L3LMFYT6QsFt/KDT9gImsM7kMzrS1O0gF6JphXcdrDV4pj2Vx5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=TD65pRA9; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1742354660; x=1773890660;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MN9oZmbNILNdEvoHmvsDnZPCG22sTovtr1MWMH+ia4A=;
  b=TD65pRA9c+iVS6EoL4IFo/8+4EvJj7QNEC48/E54JRLjQXdAVCK0PmOk
   QEwlIKL6KIuRpIpXuTF9ujI2ati1YDlFgH2iHZQNVXbsCEOUnxubTTyjt
   p3y5BdceQITQWUVmu/bng4FVZJiMiRcjv0jfDPOVV3e8zXABpiBue5nTY
   SDG6VK85YF9hmG3OxqU00AdbgHH/DW69UVYTtQB34wljS9n0lsKHPRRM0
   ibI1+nF/MFiINKBVWkV6b94Nr+r3lQjVkP4q3mNu9ZSMBsJsiZ6gEPRLI
   wrk5LTc3nthISkAvLeIwoaL5DOSz3fKZXI3PYSxDCmJv8GUyal2M/cbm9
   A==;
X-CSE-ConnectionGUID: Dnoj5PGtSlu/gGtOBTg/TA==
X-CSE-MsgGUID: sfW3vGp8ShC2iJXcGWu2fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="172482630"
X-IronPort-AV: E=Sophos;i="6.14,258,1736780400"; 
   d="scan'208";a="172482630"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 12:24:12 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 305A6D4C33
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 12:24:10 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id EAE6BD8B6E
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 12:24:09 +0900 (JST)
Received: from G08XZGSD200059.g08.fujitsu.local (unknown [10.167.135.156])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 5826E1A009A;
	Wed, 19 Mar 2025 11:24:09 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] pynfs: fix key error if FATTR4_OPEN_ARGUMENTS is not supported
Date: Wed, 19 Mar 2025 11:23:43 +0800
Message-ID: <20250319032402.1789-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If FATTR4_OPEN_ARGUMENTS is not supportd, DELEG24 and DELEG25
will throw:
	KeyError: 86

Check FATTR4_OPEN_ARGUMENTS in caps from server

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 nfs4.1/server41tests/st_delegation.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index fa9b451..f27e852 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -311,6 +311,9 @@ def _testCbGetattr(t, env, change=0, size=0):
                 OPEN4_SHARE_ACCESS_WRITE |
                 OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG)
 
+    if FATTR4_OPEN_ARGUMENTS not in caps:
+        fail("FATTR4_OPEN_ARGUMENTS not supported")
+
     if caps[FATTR4_SUPPORTED_ATTRS] & FATTR4_OPEN_ARGUMENTS:
         if caps[FATTR4_OPEN_ARGUMENTS].oa_share_access_want & OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS:
             openmask |= 1<<OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS
-- 
2.47.1


