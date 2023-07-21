Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2179975C9FC
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 16:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjGUO0r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjGUO0q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 10:26:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE942D4E;
        Fri, 21 Jul 2023 07:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4625C61CB7;
        Fri, 21 Jul 2023 14:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A71C433C7;
        Fri, 21 Jul 2023 14:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689949604;
        bh=BZeN9FeV38FBVrjv5jXNGq0zJx4/r5Rcx3nWPl6iuaY=;
        h=From:To:Cc:Subject:Date:From;
        b=Vcbic/Kb+piqXboSFZOVQfl6pHNk1vO6wfsVm5zsdQMckBjiqQ3UodaSo/ASRCVjV
         JDORFTxIgUeKLqOZ2tOuyN5sYGnCfwaUlSGfJkNCJecJo/Vz7AP7ws1PGdc2hdO1KZ
         sFQx4O4xTW/xxF2gam/apdtPWmBUDEHblBlG69iDjFSobvbSupV4vkbVEoRzvL3NUC
         5zkwyWwCrH12rW8xj5qhxGIk6hxoZforns+WFCgs6aSNImMJWGOU3E/EYGf6HmowNG
         El6ssSqqF7JICntljX4+uOBdoNp8F2eFCzHpNli/8RBS1Yah3YlZkAKgOvsPNgJ8DH
         tbsAOYIAZGnvA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     =?UTF-8?q?Andreas=20Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: better conform to setfacl's method for setting missing ACEs
Date:   Fri, 21 Jul 2023 10:26:41 -0400
Message-ID: <20230721142642.45871-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Andreas pointed out that the way we're setting missing ACEs doesn't
quite conform to what setfacl does. Change it to better conform to
how setfacl does this.

Cc: Andreas Grünbacher <andreas.gruenbacher@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4acl.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

Chuck, it might be best to fold this into the original patch, if it
looks ok.

diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index 64e45551d1b6..9ec61bd0e11b 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -742,14 +742,15 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
 	 *  no owner, owning group, or others entry,  a  copy of  the  ACL
 	 *  owner, owning group, or others entry is added to the Default ACL."
 	 *
-	 * If none of the requisite ACEs were set, and some explicit user or group
-	 * ACEs were, copy the requisite entries from the effective set.
+	 * Copy any missing ACEs from the effective set.
 	 */
-	if (!default_acl_state.valid &&
-	    (default_acl_state.users->n || default_acl_state.groups->n)) {
-		default_acl_state.owner = effective_acl_state.owner;
-		default_acl_state.group = effective_acl_state.group;
-		default_acl_state.other = effective_acl_state.other;
+	if (default_acl_state.users->n || default_acl_state.groups->n) {
+		if (!(default_acl_state.valid & ACL_USER_OBJ))
+			default_acl_state.owner = effective_acl_state.owner;
+		if (!(default_acl_state.valid & ACL_GROUP_OBJ))
+			default_acl_state.group = effective_acl_state.group;
+		if (!(default_acl_state.valid & ACL_OTHER))
+			default_acl_state.other = effective_acl_state.other;
 	}
 
 	*pacl = posix_state_to_acl(&effective_acl_state, flags);
-- 
2.41.0

