Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696E06B75E9
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Mar 2023 12:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCMLYL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Mar 2023 07:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCMLYK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Mar 2023 07:24:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05875708E
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 04:24:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67DECB80FF1
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 11:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4A1C433D2;
        Mon, 13 Mar 2023 11:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678706647;
        bh=TlcbceEXHDicqaLW+S5tCvrTm7BgX0Ir1KdlwWzbKs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MlS16jF0JmWyTT3tQ95NiZk/gKDD1NWjitPAZExYprhkoyJ/BXKstlc5q9IV4cz5P
         l6/UwYm/az073gXsk6soUCn0FUfh4TUjfCOJhwweIyFoHiQn/SqjxXbf0I03PYZoHU
         DBgpBerRb6BuECfc4kBowT0sJFSVTgqLO1BeK8vnl4i4EEco3kZ0tbjJNvi+hVssBK
         OVDpb1tsD30Ey3tS/vmLyk6k5v8Tw67aKUylTLvwGeo63KHZZKiiYtoka3aRTFivGF
         IjXAU3ppvVZuqx3P2HcRv2iZLfdZaA+udq2Q03Y3UYx8OdesTe2mO2RNW5l8Q/1Nby
         b9LKh2mCbQ2HQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     calum.mackay@oracle.com
Cc:     bfields@fieldses.org, ffilzlnx@mindspring.com,
        linux-nfs@vger.kernel.org, Frank Filz <ffilz@redhat.com>
Subject: [pynfs PATCH v2 5/5] LOCK24: fix the lock_seqid in second lock request
Date:   Mon, 13 Mar 2023 07:24:01 -0400
Message-Id: <20230313112401.20488-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313112401.20488-1-jlayton@kernel.org>
References: <20230313112401.20488-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This test currently fails against Linux nfsd, but I think it's the test
that's wrong. It basically does:

open for read
read lock
unlock
open upgrade
write lock

The write lock above is sent with a lock_seqid of 0, which is wrong.
RFC7530/16.10.5 says:

   o  In the case in which the state has been created and the [new
      lockowner] boolean is true, the server rejects the request with the
      error NFS4ERR_BAD_SEQID.  The only exception is where there is a
      retransmission of a previous request in which the boolean was
      true.  In this case, the lock_seqid will match the original
      request, and the response will reflect the final case, below.

Since the above is not a retransmission, knfsd is correct to reject
this call. This patch fixes the open_sequence object to track the lock
seqid and set it correctly in the LOCK request.

With this, LOCK24 passes against knfsd.

Cc: Frank Filz <ffilz@redhat.com>
Fixes: 4299316fb357 (Add LOCK24 test case to test open uprgade/downgrade scenario)
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.0/servertests/st_lock.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/nfs4.0/servertests/st_lock.py b/nfs4.0/servertests/st_lock.py
index 468672403ffe..9d650ab017b9 100644
--- a/nfs4.0/servertests/st_lock.py
+++ b/nfs4.0/servertests/st_lock.py
@@ -886,6 +886,7 @@ class open_sequence:
         self.client = client
         self.owner = owner
         self.lockowner = lockowner
+        self.lockseqid = 0
     def open(self, access):
         self.fh, self.stateid = self.client.create_confirm(self.owner,
 						access=access,
@@ -900,14 +901,17 @@ class open_sequence:
         self.client.close_file(self.owner, self.fh, self.stateid)
     def lock(self, type):
         res = self.client.lock_file(self.owner, self.fh, self.stateid,
-                    type=type, lockowner=self.lockowner)
+                                    type=type, lockowner=self.lockowner,
+                                    lockseqid=self.lockseqid)
         check(res)
         if res.status == NFS4_OK:
             self.lockstateid = res.lockid
+            self.lockseqid += 1
     def unlock(self):
         res = self.client.unlock_file(1, self.fh, self.lockstateid)
         if res.status == NFS4_OK:
             self.lockstateid = res.lockid
+            self.lockseqid += 1
 
 def testOpenUpgradeLock(t, env):
     """Try open, lock, open, downgrade, close
-- 
2.39.2

