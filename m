Return-Path: <linux-nfs+bounces-12797-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB39AE971A
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Jun 2025 09:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F8D16160F
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Jun 2025 07:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9563820013A;
	Thu, 26 Jun 2025 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="riyrqm7A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945A4175A5
	for <linux-nfs@vger.kernel.org>; Thu, 26 Jun 2025 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750924051; cv=none; b=oCN8mV58Hl89lg4QD6H6jkWOr7SwGVgGGsVzlFxvITTNAN+5aM4gGBU+58CPLMuDsfzr32YGJ7582SeCE7juxbtC/78TGUSkbaZuPsGJqbZGeMk2IDiQCVHEWuNCMGiXVea/G8EX9qk8rZvn8TwMTYVJgZTM7RQ/wcv0gaP+Nng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750924051; c=relaxed/simple;
	bh=LfcaxuUlj97hMx7CtyzSJcZWWEtNWj0dXB0sz8/lQgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lKwoMJZTXAHCWjAWChjbYsH2mCqMFO13/dHR5Nwqq3ZUY7DvV2MSNPfDL/jV1A+/oiv51ric9+6JcoLLQaJK1rYZO3naSW/eyetSAfKjqK0WIDtnZOaGexk3NBGIanRcKF5VIxnBZi6tiBBbLmnmh/paLYqcZmL92oxcJSpoSxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=riyrqm7A; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 4D7CF11F744
	for <linux-nfs@vger.kernel.org>; Thu, 26 Jun 2025 09:47:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 4D7CF11F744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1750924045; bh=zDR/hrjs4y5oMMbVa8+4iXAnYxVKAvEb5+Xwrv3plPY=;
	h=From:To:Cc:Subject:Date:From;
	b=riyrqm7Ay6vGJzm/mCBMifp8hgiekozhsRxtw2odB8Nw92LNampcQdKmMu8dSoxJ/
	 urrdRWfElSM/cXWIMAWr9uybINQRH40oCGI0w1JzGTPrd/BK+7L30bWJiNx+Ivipaz
	 HLn3im0UlYA0ZkOAWRMJzYX7Fr1tKQwZt8+ogdzo=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 41D2E120043;
	Thu, 26 Jun 2025 09:47:25 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [IPv6:2001:638:d:c303:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 351CA40044;
	Thu, 26 Jun 2025 09:47:25 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [IPv6:2001:638:700:1038::1:52])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id BFF6310A3CC;
	Thu, 26 Jun 2025 09:47:23 +0200 (CEST)
Received: from nairi.desy.de (zitpcx23514.desy.de [131.169.214.185])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 92F328004E;
	Thu, 26 Jun 2025 09:47:23 +0200 (CEST)
From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	Chen Hanxiao <chenhx.fnst@fujitsu.com>
Subject: [PATCH pynfs] nfs4.1: mark slot free after compound op complete
Date: Thu, 26 Jun 2025 09:47:20 +0200
Message-ID: <20250626074720.121584-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For each compound request client allocates a session slot, but never
returns. Thus, eventually runs out of session slots.

Tested-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 nfs4.1/nfs4client.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index f4fabcc..fe404cd 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -551,6 +551,7 @@ class SessionRecord(object):
                 # operation itself receives NFS4ERR_DELAY
                 slot, seq_op = self._prepare_compound(saved_kwargs)
             time.sleep(delay_time)
+        slot.inuse = False
         res = self.remove_seq_op(res)
         return res
 
-- 
2.50.0


