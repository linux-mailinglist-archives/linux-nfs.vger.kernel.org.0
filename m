Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA4365EA93
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 13:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjAEMS6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 07:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjAEMSj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 07:18:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347F45AC42
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 04:18:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAA19B81A99
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 12:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E95EC433D2;
        Thu,  5 Jan 2023 12:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672921105;
        bh=U3gpEyf5QBzJEKnjH0ue60odV2fUDKZoZiBnNbUXgDY=;
        h=From:To:Cc:Subject:Date:From;
        b=fzWSVkh2znaiv4rCWpdVghUH/O5OeYfOCXMsTvRyp1cCv5Q8kaxpnL/x4zfVWdV2r
         ZlMsij2elwWRvQCPwq62c8s4IMNeDrIHD9v/X8SNWyjRSZdZDi4jbXR6Ja+fZdq8We
         gRiksscWwAbtzFAchfe/MBcwOrRixnVlo8LmWIQdkCJV8ze+mWaTdbhCmuIsPRaDf0
         qhOZftclhUMIlTxkVUQi9ArdsnXsMaCqrbaogpmy0JnxLlAU9weSNCciYnfvhN/ZkY
         pjPE8LxoB/kppjfEyw+GiVL7nrGw4nY4jawPgGQt5sDwbVtUFNO+KWi+A4CImvfp/h
         AoM3gHFS3djvw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: fix potential race in nfs4_find_file
Date:   Thu,  5 Jan 2023 07:18:23 -0500
Message-Id: <20230105121823.21935-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
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

Even though there is a WARN_ON_ONCE check, it seems possible for
nfs4_find_file to race with the destruction of an fi_deleg_file while
trying to take a reference to it.

put_deleg_file is done while holding the fi_lock. Take and hold it
when dealing with the fi_deleg_file in nfs4_find_file.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b68238024e49..3df3ae84bd07 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6417,23 +6417,27 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 static struct nfsd_file *
 nfs4_find_file(struct nfs4_stid *s, int flags)
 {
+	struct nfsd_file *ret = NULL;
+
 	if (!s)
 		return NULL;
 
 	switch (s->sc_type) {
 	case NFS4_DELEG_STID:
-		if (WARN_ON_ONCE(!s->sc_file->fi_deleg_file))
-			return NULL;
-		return nfsd_file_get(s->sc_file->fi_deleg_file);
+		spin_lock(&s->sc_file->fi_lock);
+		if (!WARN_ON_ONCE(!s->sc_file->fi_deleg_file))
+			ret = nfsd_file_get(s->sc_file->fi_deleg_file);
+		spin_unlock(&s->sc_file->fi_lock);
+		break;
 	case NFS4_OPEN_STID:
 	case NFS4_LOCK_STID:
 		if (flags & RD_STATE)
-			return find_readable_file(s->sc_file);
+			ret = find_readable_file(s->sc_file);
 		else
-			return find_writeable_file(s->sc_file);
+			ret = find_writeable_file(s->sc_file);
 	}
 
-	return NULL;
+	return ret;
 }
 
 static __be32
-- 
2.39.0

