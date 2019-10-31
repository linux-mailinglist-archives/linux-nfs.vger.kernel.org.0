Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70797EB9DA
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfJaWna (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:30 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46168 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbfJaWn3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:29 -0400
Received: by mail-yw1-f68.google.com with SMTP id i2so2772947ywg.13
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Vf/ZxAx5Dtp9saPC/f/GAFEOjUKA7pZQZ1SUKquX5bI=;
        b=XIyZw/iWiqNviYT/1J19/BvfSUlwIPT5l7XrcuRWNSBMG/UOkeDwJn7j/hi7S819h0
         9TntILhvQJhOZx4axw9QWDL457a7zkIm1436ZY8JmghnKkpe39QwF5wSSKM4pGdYGp2c
         njWZyewDggdLYqGlFinJlv0GPqnZe0IUW1KIeM+qHLhqttLLppdGQLSJyB6b+bhKmnuQ
         ATHyE1pFOtvnUyZJUZ54994TXRYiEhcul/s8tX70CtywPrQLmkyf+auBk8DpMALvLI9x
         UXFlBE6geVOZ+Pibwkg7P4S1Wym2pOf7OCOsSJNoYV6Gj6/DNNLcXEf+OiU9cXvDqCJP
         zCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vf/ZxAx5Dtp9saPC/f/GAFEOjUKA7pZQZ1SUKquX5bI=;
        b=dvHgezIKhmf6dU8gIcPztwJfSChPNVjWZHKCIuAcoygZXDiZSftJgK1fX3hFQBuKif
         MatN9vrAM85Bm/c/MX0FfXqbXkqEKhq5IMozC9SvjxvTpvcuU5E0XNcw7r0sB16z4tJE
         YljFZMG0rvKALHjg9CQoDrdMQP4GX3zJSEXl4xjAdiA3i0Zzb2NlSmvHRrnizFU07cu+
         yADZRAznUuHUYBpB0qJ7ht/5qYn4pCgqPgnkCL9DWvt3leirLo42U0PHVbOwW88Q06ID
         lGLSSrEzm6ovQqoq2HCQceUBDbivhWwI3CO3VLngM75OpOzaWFCyj7LeHN06J4JoAhxV
         Vuiw==
X-Gm-Message-State: APjAAAUnlgeejZ8zDT1WnGOxuyFkKfgJtkgZyW1eedEsnBR9SQSsO27p
        x/Kx1pWPNHNeqo6ZQW+dEbTNA8s=
X-Google-Smtp-Source: APXvYqyZ9yrXgyOMcwcQYStny3WzM7jh6nPGjwqYPFzbYS33Rgmw5BWJrZwwo4Zbd+3vf7JTUufGGQ==
X-Received: by 2002:a0d:ebd0:: with SMTP id u199mr6180913ywe.449.1572561806693;
        Thu, 31 Oct 2019 15:43:26 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.25
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:25 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 17/20] NFS: nfs_inode_find_state_and_recover() fix stateid matching
Date:   Thu, 31 Oct 2019 18:40:48 -0400
Message-Id: <20191031224051.8923-18-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-17-trond.myklebust@hammerspace.com>
References: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
 <20191031224051.8923-2-trond.myklebust@hammerspace.com>
 <20191031224051.8923-3-trond.myklebust@hammerspace.com>
 <20191031224051.8923-4-trond.myklebust@hammerspace.com>
 <20191031224051.8923-5-trond.myklebust@hammerspace.com>
 <20191031224051.8923-6-trond.myklebust@hammerspace.com>
 <20191031224051.8923-7-trond.myklebust@hammerspace.com>
 <20191031224051.8923-8-trond.myklebust@hammerspace.com>
 <20191031224051.8923-9-trond.myklebust@hammerspace.com>
 <20191031224051.8923-10-trond.myklebust@hammerspace.com>
 <20191031224051.8923-11-trond.myklebust@hammerspace.com>
 <20191031224051.8923-12-trond.myklebust@hammerspace.com>
 <20191031224051.8923-13-trond.myklebust@hammerspace.com>
 <20191031224051.8923-14-trond.myklebust@hammerspace.com>
 <20191031224051.8923-15-trond.myklebust@hammerspace.com>
 <20191031224051.8923-16-trond.myklebust@hammerspace.com>
 <20191031224051.8923-17-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In nfs_inode_find_state_and_recover() we want to mark for recovery
only those stateids that match or are older than the supplied
stateid parameter.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 3 ++-
 fs/nfs/nfs4_fs.h    | 6 ++++++
 fs/nfs/nfs4state.c  | 7 ++++---
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index e3d8055f0c6d..902baea1ecc6 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1207,7 +1207,8 @@ void nfs_inode_find_delegation_state_and_recover(struct inode *inode,
 	rcu_read_lock();
 	delegation = rcu_dereference(NFS_I(inode)->delegation);
 	if (delegation &&
-	    nfs4_stateid_match_other(&delegation->stateid, stateid)) {
+	    nfs4_stateid_match_or_older(&delegation->stateid, stateid) &&
+	    !test_bit(NFS_DELEGATION_REVOKED, &delegation->flags)) {
 		nfs_mark_test_expired_delegation(NFS_SERVER(inode), delegation);
 		found = true;
 	}
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 16b2e5cc3e94..40ab5540c2ae 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -572,6 +572,12 @@ static inline bool nfs4_stateid_is_newer(const nfs4_stateid *s1, const nfs4_stat
 	return (s32)(be32_to_cpu(s1->seqid) - be32_to_cpu(s2->seqid)) > 0;
 }
 
+static inline bool nfs4_stateid_match_or_older(const nfs4_stateid *dst, const nfs4_stateid *src)
+{
+	return nfs4_stateid_match_other(dst, src) &&
+		!(src->seqid && nfs4_stateid_is_newer(dst, src));
+}
+
 static inline void nfs4_stateid_seqid_inc(nfs4_stateid *s1)
 {
 	u32 seqid = be32_to_cpu(s1->seqid);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 0c6d53dc3672..a66acb6573d4 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1407,7 +1407,7 @@ nfs_state_find_lock_state_by_stateid(struct nfs4_state *state,
 	list_for_each_entry(pos, &state->lock_states, ls_locks) {
 		if (!test_bit(NFS_LOCK_INITIALIZED, &pos->ls_flags))
 			continue;
-		if (nfs4_stateid_match_other(&pos->ls_stateid, stateid))
+		if (nfs4_stateid_match_or_older(&pos->ls_stateid, stateid))
 			return pos;
 	}
 	return NULL;
@@ -1441,12 +1441,13 @@ void nfs_inode_find_state_and_recover(struct inode *inode,
 		state = ctx->state;
 		if (state == NULL)
 			continue;
-		if (nfs4_stateid_match_other(&state->stateid, stateid) &&
+		if (nfs4_stateid_match_or_older(&state->stateid, stateid) &&
 		    nfs4_state_mark_reclaim_nograce(clp, state)) {
 			found = true;
 			continue;
 		}
-		if (nfs4_stateid_match_other(&state->open_stateid, stateid) &&
+		if (test_bit(NFS_OPEN_STATE, &state->flags) &&
+		    nfs4_stateid_match_or_older(&state->open_stateid, stateid) &&
 		    nfs4_state_mark_reclaim_nograce(clp, state)) {
 			found = true;
 			continue;
-- 
2.23.0

