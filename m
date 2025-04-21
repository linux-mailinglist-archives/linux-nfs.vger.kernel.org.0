Return-Path: <linux-nfs+bounces-11210-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4BAA9577A
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Apr 2025 22:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981A0188DE9E
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Apr 2025 20:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D881F03EA;
	Mon, 21 Apr 2025 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="FHEkxxvR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE4D1E0E13
	for <linux-nfs@vger.kernel.org>; Mon, 21 Apr 2025 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745268279; cv=none; b=rrpBwfizC/DlV/BSGk5N98OmfA0ivetBBxfKc8IVF9xKtHKGihmJM56SPDvVXwfxx6JvApKpcHXU/ub42GPrgkx4YbTT8yEmEgEi3DM8T31ybTa5x5WBcScNyo3oyIXiK9yIx46wmrwstP/yTag8yvWoYglD3PAq7vhEAhOA2Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745268279; c=relaxed/simple;
	bh=jEtzNrLdaHSrsS8dewFbTc5tjuvUcnuSEJ4DayCva7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fupwXkNBeipMfexibM4z9TgqujkdkNhgRNrao8QQPVboC+Ij3vN+RENXNKjWpcHC+eof5kTDoDGBsZ1co8scOA8pDQ/SJY4adDGDVrXgUsVcG4WDTgj1U8ovEkfI3uQWEyb1Vjw5cuWGrGdRTxAIZzGDkOk3mJEp9etZ0cbreEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=FHEkxxvR; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 1814413F647
	for <linux-nfs@vger.kernel.org>; Mon, 21 Apr 2025 22:44:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 1814413F647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1745268267; bh=i5kjhqSUp9zyjqxeDgidmRZqj+p5WXZWHNuduV56xnI=;
	h=From:To:Cc:Subject:Date:From;
	b=FHEkxxvRit8tYE641lCWPKKBsZDDeq2v2vHTecK0I2jgA8dZ9sE01hs0K6/arx2Ir
	 fiBr0A310c5aMfDSappJk70jbnDiO5R8n7Nrq93rNksO4VWh9FN5c5GFZyZPonSdtt
	 mwh69lCPeCuZ90haad2zffnNfCJX3pMMmLFMUDHI=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 0D3F520040;
	Mon, 21 Apr 2025 22:44:27 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [194.95.239.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 0177240044;
	Mon, 21 Apr 2025 22:44:26 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id D7DAF10A3CC;
	Mon, 21 Apr 2025 22:44:25 +0200 (CEST)
Received: from nairi.desy.de (VPN0027.desy.de [131.169.253.26])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 97DBE80046;
	Mon, 21 Apr 2025 22:44:25 +0200 (CEST)
From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH pynfs v2] pynfs: add test for read with delegation stateid after close
Date: Mon, 21 Apr 2025 22:44:24 +0200
Message-ID: <20250421204424.35730-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test checks the independence of delegation stateid from open
stateid.

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 nfs4.1/server41tests/st_delegation.py | 53 ++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index f27e852..41095b9 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -2,7 +2,7 @@ from .st_create_session import create_session
 from .st_open import open_claim4
 from xdrdef.nfs4_const import *
 
-from .environment import check, fail, create_file, open_file, close_file, do_getattrdict
+from .environment import check, fail, create_file, open_file, close_file, do_getattrdict, close_file, write_file, read_file
 from xdrdef.nfs4_type import *
 import nfs_ops
 op = nfs_ops.NFS4ops()
@@ -390,3 +390,54 @@ def testCbGetattrWithChange(t, env):
     if FATTR4_TIME_DELEG_MODIFY in attrs2:
         if attrs1[FATTR4_TIME_MODIFY] == attrs2[FATTR4_TIME_DELEG_MODIFY]:
             fail("Bad modify time: ", attrs1[FATTR4_TIME_MODIFY], " == ", attrs2[FATTR4_TIME_DELEG_MODIFY])
+
+def testDelegReadAfterClose(t, env):
+    """Test read with delegation stateid after close
+
+    Create file with some data. Open the file for read, get delegation, close the file.
+    Tesr that reads with delegation stateid still works.
+
+    FLAGS: deleg all
+    CODE: DELEG26
+    """
+    sess1 = env.c1.new_client_session(b"%s_1" % env.testname(t))
+
+    name = env.testname(t)
+    owner = b"owner_%s" % name
+
+    # create file with some data
+    res = create_file(sess1, owner)
+    check(res)
+
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+
+    res = write_file(sess1, fh, b'data', 0, stateid)
+    check(res)
+
+    res = close_file(sess1, fh, stateid=stateid)
+    check(res)
+
+
+    # open file, get delegation, close the file
+    access = OPEN4_SHARE_ACCESS_READ | OPEN4_SHARE_ACCESS_WANT_READ_DELEG;
+    res = open_file(sess1, owner, access = access)
+    check(res)
+
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+
+    if not _got_deleg(res.resarray[-2].delegation):
+        fail("Failed to get delegation")
+    delegstateid = res.resarray[-2].delegation.read.stateid
+
+    res = close_file(sess1, fh, stateid=stateid)
+    check(res)
+
+    # Issue READ with delegation stateid
+    res = read_file(sess1, fh, 0, 10, delegstateid)
+    check(res)
+
+    # cleanup: return delegation
+    res = sess1.compound([op.putfh(fh), op.delegreturn(delegstateid)])
+    check(res)
-- 
2.49.0


