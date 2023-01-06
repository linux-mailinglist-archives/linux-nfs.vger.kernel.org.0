Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03493660359
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jan 2023 16:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjAFPd5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Jan 2023 10:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbjAFPd4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Jan 2023 10:33:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C684E37246
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 07:33:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 545BFB81D9D
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 15:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B478C433D2;
        Fri,  6 Jan 2023 15:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673019231;
        bh=TZ7dYTm1ZkNokXZQm4eQ91frJCTyhCCWUu82dIXD4Os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEltLyLQBGRdaqb2jHfGXzbgTMDnh2nJrSZaQAHCwcUZl8YRh4ckHc7I3VqQ8RQBT
         HgVRzNe5K45asu3hOeN4SpnjDn0FH/WLXqDT7D2pyDhd6a0ecoBDcxkj/IL+05wh+O
         V3A7Fk689R1A33Gkfe+L6+4zli4KDjStaKxLeKVtzAt45cYJnWcKOODv2gIdeT9OFM
         R1p/CglSUuK+wCr40AxMPvax8aEgTHRJ8fLlTxoBk9toRHE+dP0vEWd4tysP94JKEv
         RGodDQOOu/O0RPb29nxUqFfyzC6g4kiamcciMbOTyunMSKWxSo+TE+hNEnrX1RJq6J
         r1yf13IgVZKcw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>
Subject: [PATCH v2 2/2] nfsd: fix potential race in nfs4_find_file
Date:   Fri,  6 Jan 2023 10:33:48 -0500
Message-Id: <20230106153348.104214-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106153348.104214-1-jlayton@kernel.org>
References: <20230106153348.104214-1-jlayton@kernel.org>
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

The WARN_ON_ONCE check is not terribly useful. It also seems possible
for nfs4_find_file to race with the destruction of an fi_deleg_file
while trying to take a reference to it.

Now that it's safe to pass nfs_get_file a NULL pointer, remove the WARN
and NULL pointer check. Take the fi_lock when fetching fi_deleg_file.

Cc: NeilBrown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 655fcfec0ace..f923bab09a31 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6415,23 +6415,26 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
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
+		ret = nfsd_file_get(s->sc_file->fi_deleg_file);
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

