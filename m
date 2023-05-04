Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B35E6F6A48
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 13:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjEDLml (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 07:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEDLml (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 07:42:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF9D10B
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 04:42:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99AEA63391
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 11:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F9CC433D2;
        Thu,  4 May 2023 11:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683200559;
        bh=8aGNIJKtXpgEBNOhWL4emxcKzvE9oZ03/h2rK0ZJhEY=;
        h=From:To:Cc:Subject:Date:From;
        b=FoJ4JXob4AWCspTIELDk/U8XSwpKKvJuEJIJl8hPa96gJruC9W77WnhQ+JkzgdADL
         n+ox7xJ58TTt97bv65gog4rS0V6WCVxBZpCAlOo58UThrxJWKHBzS15w2Ka9TmwR5u
         YFkED6eBllBgjAMMmx9led3e0SSLdr2c78CeRUSJGbXfoQmxdVgT5CsSw5X4xFyTHq
         CJH1mYwRlsMpuL1wNpGvG3b49s3GyGzthDQnbY2pjBL81UqHh6iyFefWOoxB42Tuty
         RB4rBSQzQ9WJtvjp1mFG8vaTNEPPQZCSdC8PrsAdus+zYKQ9U6Q88e/da/yTXl5Nns
         GMYKYBfjAXPog==
From:   Jeff Layton <jlayton@kernel.org>
To:     Calum Mackay <calum.mackay@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] WRT18: have it also check the ctime between writes
Date:   Thu,  4 May 2023 07:42:37 -0400
Message-Id: <20230504114237.31090-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On many servers, the ctime doesn't have sufficient granularity to show
an apparent change between rapid writes, but some are able to do so.
Have the test also check the ctimes here and pass_warn if it doesn't
change after every write.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.0/servertests/st_write.py | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

I've been using this some to test the multigrain ctime patches, and I
think it'd be a reasonable addition. We could also consider adding a
separate test for this.

diff --git a/nfs4.0/servertests/st_write.py b/nfs4.0/servertests/st_write.py
index db1b1e585fdb..e635717f76c9 100644
--- a/nfs4.0/servertests/st_write.py
+++ b/nfs4.0/servertests/st_write.py
@@ -497,19 +497,27 @@ def testChangeGranularityWrite(t, env):
     c = env.c1
     c.init_connection()
     fh, stateid = c.create_confirm(t.word())
-    ops = c.use_obj(fh) + [c.getattr([FATTR4_CHANGE])] \
-        + [op.write(stateid, 0,  UNSTABLE4, _text)] + [c.getattr([FATTR4_CHANGE])] \
-        + [op.write(stateid, 10, UNSTABLE4, _text)] + [c.getattr([FATTR4_CHANGE])] \
-        + [op.write(stateid, 20, UNSTABLE4, _text)] + [c.getattr([FATTR4_CHANGE])] \
-        + [op.write(stateid, 30, UNSTABLE4, _text)] + [c.getattr([FATTR4_CHANGE])]
+    attrlist = [FATTR4_CHANGE, FATTR4_TIME_METADATA]
+    ops = c.use_obj(fh) + [c.getattr(attrlist)] \
+        + [op.write(stateid, 0,  UNSTABLE4, _text)] + [c.getattr(attrlist)] \
+        + [op.write(stateid, 10, UNSTABLE4, _text)] + [c.getattr(attrlist)] \
+        + [op.write(stateid, 20, UNSTABLE4, _text)] + [c.getattr(attrlist)] \
+        + [op.write(stateid, 30, UNSTABLE4, _text)] + [c.getattr(attrlist)]
     res = c.compound(ops)
     check(res)
-    chattr1 = res.resarray[1].obj_attributes
-    chattr2 = res.resarray[3].obj_attributes
-    chattr3 = res.resarray[5].obj_attributes
-    chattr4 = res.resarray[7].obj_attributes
+    chattr1 = res.resarray[1].obj_attributes[FATTR4_CHANGE]
+    chattr2 = res.resarray[3].obj_attributes[FATTR4_CHANGE]
+    chattr3 = res.resarray[5].obj_attributes[FATTR4_CHANGE]
+    chattr4 = res.resarray[7].obj_attributes[FATTR4_CHANGE]
     if chattr1 == chattr2 or chattr2 == chattr3 or chattr3 == chattr4:
-        t.fail("consecutive SETATTR(mode)'s don't all change change attribute")
+        t.fail("consecutive WRITE's don't change change attribute")
+
+    ctime1 = res.resarray[1].obj_attributes[FATTR4_TIME_METADATA]
+    ctime2 = res.resarray[3].obj_attributes[FATTR4_TIME_METADATA]
+    ctime3 = res.resarray[5].obj_attributes[FATTR4_TIME_METADATA]
+    ctime4 = res.resarray[7].obj_attributes[FATTR4_TIME_METADATA]
+    if compareTimes(ctime1, ctime2) == 0 or compareTimes(ctime2, ctime3) == 0 or compareTimes(ctime3, ctime4) == 0:
+        t.pass_warn("consecutive WRITE's don't all change time_metadata")
 
 def testStolenStateid(t, env):
     """WRITE with incorrect permissions and somebody else's stateid
-- 
2.40.1

