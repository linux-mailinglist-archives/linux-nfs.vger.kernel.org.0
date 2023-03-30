Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5846D0DAC
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Mar 2023 20:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjC3SYb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Mar 2023 14:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjC3SYa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Mar 2023 14:24:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95265FEB
        for <linux-nfs@vger.kernel.org>; Thu, 30 Mar 2023 11:24:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8150062096
        for <linux-nfs@vger.kernel.org>; Thu, 30 Mar 2023 18:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C71DC433D2;
        Thu, 30 Mar 2023 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680200668;
        bh=3USdfrjb5l7xlmDJ8ohzbDcPg5hh5psnp5u7gqpUa9U=;
        h=From:To:Cc:Subject:Date:From;
        b=nOsZpSs9M30qu21sbMlA6vGPU+zCYki3dl1vflO7+rgJyIz0zJBwHQUINLWHtiBAL
         pnMdrpZz0NQxssv58IYRKIg5/4sWICdk90kK/ZWrgH7ES6vsyDD0AKa/2ikYhKRbGe
         ULGCwBkN0VusM465Xo7rk/S1iBfG1qHkDpPOMk7rzARQqZT1uqiHSmpHpdwwgTRSSD
         sPS+YqR92wrEoWoYMDGhVa4FiSOKn3cf3OzFkNL2DQbWzI8LDBFWmLjgmHoK5gkMyk
         MWlIvvhXY7uAkJ07XyC/e1VMQlFyaMGnDg+Xo1Z5zHMvf7gMcqhpYP6LDE0BqNfZsu
         iUMClE3aDPWHA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, bcodding@redhat.com,
        Zhi Li <yieli@redhat.com>
Subject: [PATCH] sunrpc: only free unix grouplist after RCU settles
Date:   Thu, 30 Mar 2023 14:24:27 -0400
Message-Id: <20230330182427.19013-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While the unix_gid object is rcu-freed, the group_info list that it
contains is not. Ensure that we only put the group list reference once
we are really freeing the unix_gid object.

Reported-by: Zhi Li <yieli@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2183056
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/svcauth_unix.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 50e2eb579194..4485088ce27b 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -416,14 +416,23 @@ static int unix_gid_hash(kuid_t uid)
 	return hash_long(from_kuid(&init_user_ns, uid), GID_HASHBITS);
 }
 
-static void unix_gid_put(struct kref *kref)
+static void unix_gid_free(struct rcu_head *rcu)
 {
-	struct cache_head *item = container_of(kref, struct cache_head, ref);
-	struct unix_gid *ug = container_of(item, struct unix_gid, h);
+	struct unix_gid *ug = container_of(rcu, struct unix_gid, rcu);
+	struct cache_head *item = &ug->h;
+
 	if (test_bit(CACHE_VALID, &item->flags) &&
 	    !test_bit(CACHE_NEGATIVE, &item->flags))
 		put_group_info(ug->gi);
-	kfree_rcu(ug, rcu);
+	kfree(ug);
+}
+
+static void unix_gid_put(struct kref *kref)
+{
+	struct cache_head *item = container_of(kref, struct cache_head, ref);
+	struct unix_gid *ug = container_of(item, struct unix_gid, h);
+
+	call_rcu(&ug->rcu, unix_gid_free);
 }
 
 static int unix_gid_match(struct cache_head *corig, struct cache_head *cnew)
-- 
2.39.2

