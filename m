Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD67228961
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jul 2020 21:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgGUToC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jul 2020 15:44:02 -0400
Received: from smtp-o-3.desy.de ([131.169.56.156]:52273 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730322AbgGUToC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 Jul 2020 15:44:02 -0400
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
        by smtp-o-3.desy.de (Postfix) with ESMTP id 6B445604B9
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jul 2020 21:44:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 6B445604B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1595360640; bh=b3PX4q+a14CUjCrFywSV0vdMplCkj4DKe7YfJDXVRoI=;
        h=From:To:Cc:Subject:Date:From;
        b=ZSsN3EicSmPsAq7weFs+4rk3JI0WivLf0rMVm5F5hPmjNOhbBdXECOe8kRzGhSrGf
         dampR/YPE9GbT8CoxSoAlOpDyc1KEvAz0BvCNEwK1oDKdgyvD7Bwt3tZC6R01F5HcU
         DQiiz8j7vm4jDAXdhg36Kw2SrMLScRT3jojdS6Cc=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [131.169.56.131])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id 65E92A00C3;
        Tue, 21 Jul 2020 21:44:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from ani.desy.de (zitpcx21033.desy.de [131.169.185.213])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 39A0810007B;
        Tue, 21 Jul 2020 21:44:00 +0200 (CEST)
From:   Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org,
        Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] nfs41client: fix raising an error when pnfs test hits non pnfs server
Date:   Tue, 21 Jul 2020 21:43:58 +0200
Message-Id: <20200721194358.18132-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

fail function is not defined

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 nfs4.1/nfs4client.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index f06d9c5..3d55f96 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -1,7 +1,7 @@
 import use_local # HACK so don't have to rebuild constantly
 import rpc.rpc as rpc
 import nfs4lib
-from nfs4lib import NFS4Error, NFS4Replay, inc_u32
+from nfs4lib import NFS4Error, NFS4Replay, inc_u32, UnexpectedCompoundRes
 from xdrdef.nfs4_type import *
 from xdrdef.nfs4_const import *
 from xdrdef.sctrl_pack import SCTRLPacker, SCTRLUnpacker
@@ -331,7 +331,7 @@ class NFS4Client(rpc.Client, rpc.Server):
         # Make sure E_ID returns MDS capabilities
         c = self.new_client(name, flags=flags)
         if not c.flags & EXCHGID4_FLAG_USE_PNFS_MDS:
-            fail("Server can not be used as pnfs metadata server")
+            raise UnexpectedCompoundRes("Server can not be used as pnfs metadata server")
         s = c.create_session(sec=sec)
         s.compound([op4.reclaim_complete(FALSE)])
         return s
-- 
2.26.2

