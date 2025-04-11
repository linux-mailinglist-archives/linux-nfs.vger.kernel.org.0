Return-Path: <linux-nfs+bounces-11103-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080B7A85BA5
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 13:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C731BA1E22
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 11:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5119E238C22;
	Fri, 11 Apr 2025 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="n+/IMJcs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BAD238C1A
	for <linux-nfs@vger.kernel.org>; Fri, 11 Apr 2025 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744370884; cv=none; b=Pw8ubZYmf1CNyMbXrWTz1mtKtddSaeuOkrtJ5cFxfAUaC1MP22yEp6MNGRm6jw+i5DbRSIJZ+x6vbtt65YY5qL1vdIU1wV3Mp/yk7jSLvmm2xyvbXBzPjDiWrHYZUKlF/IYoKeMoVEgX+SVNs4zyi77TdzyX9b9o5L7WznAwfEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744370884; c=relaxed/simple;
	bh=0IckNQmKdvYYuhyPuQljTcDizY1sJu3g1TrvMaqt0mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5JQZh/qyF/SI2ES0oH/JTeOCaoyYGuEUDgWUljOf3AEqp8TcA+cZ6Ro42G7T7PNZg1Tim2SiFY/dKYoxzPa0ZcwG6qJ/ykV3u16MpuVBL3KtRhTlH1OXA/Jz6gBjZDUzUrZFuhaH/to8RfdTaUdjaQHsHFxgyIKlnRzlDM3mKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=n+/IMJcs; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [IPv6:2001:638:700:1038::1:9b])
	by smtp-o-3.desy.de (Postfix) with ESMTP id A3E9911F98B
	for <linux-nfs@vger.kernel.org>; Fri, 11 Apr 2025 13:19:24 +0200 (CEST)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 3BE5813F647
	for <linux-nfs@vger.kernel.org>; Fri, 11 Apr 2025 13:19:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 3BE5813F647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1744370357; bh=FlEuR5qtGd1C7BjzKevauFx0CaAJosN3VqZ7bR3KOs4=;
	h=From:To:Cc:Subject:Date:From;
	b=n+/IMJcs3pkRYE50UKWPe2EED0GLQQMhPreYBF8p5HseHt/6F/zHLdHJQ4/jmCcdu
	 KRK7G8vz7DUdz31sy46BQwwA5jhxdanicR8k8MS7cE+H4GGCFKSToLybUlvFsnvy5e
	 lJ5vViiFCDeIseB9KJu3UkKCCq4dadDjrKInIMDs=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 31129120043;
	Fri, 11 Apr 2025 13:19:17 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 262A116003F;
	Fri, 11 Apr 2025 13:19:17 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [IPv6:2001:638:700:1038::1:52])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 0931432008B;
	Fri, 11 Apr 2025 13:19:16 +0200 (CEST)
Received: from nairi.desy.de (zitpcx23514.desy.de [131.169.214.185])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id DFEB98004E;
	Fri, 11 Apr 2025 13:19:15 +0200 (CEST)
From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] pynfs: add test for read with delegation stateid after close
Date: Fri, 11 Apr 2025 13:19:02 +0200
Message-ID: <20250411111902.132591-1-tigran.mkrtchyan@desy.de>
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
 nfs4.1/server41tests/st_delegation.py | 50 ++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index f27e852..ea4c073 100644
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
@@ -390,3 +390,51 @@ def testCbGetattrWithChange(t, env):
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
+    # craete file with some data
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
+    delegstateid = res.resarray[-2].delegation.read.stateid
+
+    res = close_file(sess1, fh, stateid=stateid)
+    check(res)
+
+    # Issue READ with delegation sateid
+    res = read_file(sess1, fh, 0, 10, delegstateid)
+    check(res)
+
+    # cleanup: return delegation
+    res = sess1.compound([op.putfh(fh), op.delegreturn(delegstateid)])
+    check(res)
-- 
2.49.0


