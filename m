Return-Path: <linux-nfs+bounces-11138-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2B7A89CCD
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Apr 2025 13:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741F51886667
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Apr 2025 11:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B8127586B;
	Tue, 15 Apr 2025 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="eGd05loi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268D61DE2D6
	for <linux-nfs@vger.kernel.org>; Tue, 15 Apr 2025 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744717717; cv=none; b=qwPy3UbR6fWlO3elb1JwGDaBgIl/xfjWkSXKoXsSG2BjPTVp6+t1EaJgsZLVEczY2s8nMFa34dpOJpsK7I+kh+HuH4adWu/Ttrb8u2RlvsRadUh8wKU/pZah8lK9NwaQcT43vj+u0LNMOgwLJgQUjwQ8xNvoXva6wx/2PYTjljY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744717717; c=relaxed/simple;
	bh=CTNwRsQtn5pocPmDU+MhPBUF6BBfujb80CsCDcoVcwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlfCHn/+NiToMA5Lv6KAL4AiNgbqXUFKcMUVBnRT922W+45GGRLy1qmyYrkowxyLVR+ryVHslINpjHqbpenSF7s2ihCrVBjPiYqC1KXjgwiqkAHmaJmAXcUe9ZgkgKW3SoS9CPPhzDDCkwFyuJtXo8HPFQjW+QZadiNB4GgNFdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=eGd05loi; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	by smtp-o-3.desy.de (Postfix) with ESMTP id 9638611F7C7
	for <linux-nfs@vger.kernel.org>; Tue, 15 Apr 2025 13:48:25 +0200 (CEST)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-1.desy.de (Postfix) with ESMTP id B2EC011F744
	for <linux-nfs@vger.kernel.org>; Tue, 15 Apr 2025 13:48:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de B2EC011F744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1744717697; bh=lg9fjQRl6QX6jejRhEzAmAZHm9Iqe6VrtlzQh77yeO0=;
	h=From:To:Cc:Subject:Date:From;
	b=eGd05loiLuP7EEJQ5zJ1xlhjG0zCdQq5WsAUjnQ4/o5WbelMRUxpRoRgYm0p4QOLF
	 IVmz8vbVoVXtd0w8otUguMElH7+PLspVVevQGkZBxvx813sj5MgGfIfjJ31ktiiZCS
	 v8n8wx/7HeXAGnFuV5fBBTai8p2gMCZRhu7gBcKw=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id A7CBE120043;
	Tue, 15 Apr 2025 13:48:17 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [194.95.233.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 9D06B40044;
	Tue, 15 Apr 2025 13:48:17 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 850CC320093;
	Tue, 15 Apr 2025 13:48:16 +0200 (CEST)
Received: from nairi.desy.de (zitpcx23514.desy.de [131.169.214.185])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 6A1012004C;
	Tue, 15 Apr 2025 13:48:16 +0200 (CEST)
From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] deleg: break infinite loop in DELEG8 test
Date: Tue, 15 Apr 2025 13:48:14 +0200
Message-ID: <20250415114814.285400-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test assumes that the server can return either OK or DELAY,
however, the 'break' condition checks only for OK.

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 nfs4.1/server41tests/st_delegation.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index ea4c073..60b0de6 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -181,8 +181,8 @@ def testDelegRevocation(t, env):
                         owner, how, claim)
     while 1:
         res = sess2.compound(env.home + [open_op])
-        if res.status == NFS4_OK:
-            break;
+        if res.status == NFS4_OK or res.status == NFS4ERR_DELAY:
+            break
         check(res, [NFS4_OK, NFS4ERR_DELAY])
         # just to keep sess1 renewed.  This is a bit fragile, as we
         # depend on the above compound waiting no longer than the
-- 
2.49.0


