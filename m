Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9460D6110F6
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 14:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJ1MOC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 08:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiJ1MN5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 08:13:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BE1DB55A
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 05:13:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDD4D62406
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 12:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6D9C433C1;
        Fri, 28 Oct 2022 12:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666959235;
        bh=DXkS6Q6aZhglA8HoJx1goLAEaaCiiXjSiqYHA7tG1ok=;
        h=From:To:Cc:Subject:Date:From;
        b=GfyumwwPTWYeyCwKavL85QdweeB8wYpVdzk2DVnVMapcMlfu8ybjyNIIJofEJBXbZ
         yJKQOul27lB/gYPz3vDGGAU7PJaQqf9HVJx5WlTQq8nbWwW/qBFcB3JgBGPNANvQ4e
         airARP13RfH4DdD6VbDUi2Ch0yLE8bhaCUcCQkfx4o1P7aMKZv6YctnwEhwoRE7zlO
         0GpbglGR/NPj1RnFnwp6Lo3gfWmKB5IXZ7TtFxkCiwhM5sE7vAEXMI34YMNKAO+hPl
         pHpGH7MDiCb5f89ll+a1FR8KpZdKCviFb3QUc68LkPovrr/NJ2ZLWf2uHaEID52OJu
         R09TSq+Ffq64w==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Zhi Li <yieli@redhat.com>
Subject: [PATCH] nfsd: don't call nfsd_file_put from client states seqfile display
Date:   Fri, 28 Oct 2022 08:13:53 -0400
Message-Id: <20221028121353.33567-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We had a report of this:

    BUG: sleeping function called from invalid context at fs/nfsd/filecache.c:440

...with a stack trace showing nfsd_file_put being called from
nfs4_show_open. This code has always tried to call fput while holding a
spinlock, but we recently changed this to use the filecache, and that
started triggering the might_sleep() in nfsd_file_put.

states_start takes and holds the cl_lock while iterating over the
client's states, and we can't sleep with that held.

Have the various nfs4_show_* functions instead hold the fi_lock instead
of taking a nfsd_file reference.

Fixes: 78599c42ae3c ("nfsd4: add file to display list of client's opens")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2138357
Reported-by: Zhi Li <yieli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 51 +++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1ded89235111..dde621debeb2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -675,15 +675,26 @@ find_any_file(struct nfs4_file *f)
 	return ret;
 }
 
-static struct nfsd_file *find_deleg_file(struct nfs4_file *f)
+static struct nfsd_file *find_any_file_locked(struct nfs4_file *f)
 {
-	struct nfsd_file *ret = NULL;
+	lockdep_assert_held(&f->fi_lock);
+
+	if (f->fi_fds[O_RDWR])
+		return f->fi_fds[O_RDWR];
+	if (f->fi_fds[O_WRONLY])
+		return f->fi_fds[O_WRONLY];
+	if (f->fi_fds[O_RDONLY])
+		return f->fi_fds[O_RDONLY];
+	return NULL;
+}
+
+static struct nfsd_file *find_deleg_file_locked(struct nfs4_file *f)
+{
+	lockdep_assert_held(&f->fi_lock);
 
-	spin_lock(&f->fi_lock);
 	if (f->fi_deleg_file)
-		ret = nfsd_file_get(f->fi_deleg_file);
-	spin_unlock(&f->fi_lock);
-	return ret;
+		return f->fi_deleg_file;
+	return NULL;
 }
 
 static atomic_long_t num_delegations;
@@ -2616,9 +2627,11 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 	ols = openlockstateid(st);
 	oo = ols->st_stateowner;
 	nf = st->sc_file;
-	file = find_any_file(nf);
+
+	spin_lock(&nf->fi_lock);
+	file = find_any_file_locked(nf);
 	if (!file)
-		return 0;
+		goto out;
 
 	seq_printf(s, "- ");
 	nfs4_show_stateid(s, &st->sc_stateid);
@@ -2640,8 +2653,8 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 	seq_printf(s, ", ");
 	nfs4_show_owner(s, oo);
 	seq_printf(s, " }\n");
-	nfsd_file_put(file);
-
+out:
+	spin_unlock(&nf->fi_lock);
 	return 0;
 }
 
@@ -2655,9 +2668,10 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
 	ols = openlockstateid(st);
 	oo = ols->st_stateowner;
 	nf = st->sc_file;
-	file = find_any_file(nf);
+	spin_lock(&nf->fi_lock);
+	file = find_any_file_locked(nf);
 	if (!file)
-		return 0;
+		goto out;
 
 	seq_printf(s, "- ");
 	nfs4_show_stateid(s, &st->sc_stateid);
@@ -2677,8 +2691,8 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
 	seq_printf(s, ", ");
 	nfs4_show_owner(s, oo);
 	seq_printf(s, " }\n");
-	nfsd_file_put(file);
-
+out:
+	spin_unlock(&nf->fi_lock);
 	return 0;
 }
 
@@ -2690,9 +2704,10 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 
 	ds = delegstateid(st);
 	nf = st->sc_file;
-	file = find_deleg_file(nf);
+	spin_lock(&nf->fi_lock);
+	file = find_deleg_file_locked(nf);
 	if (!file)
-		return 0;
+		goto out;
 
 	seq_printf(s, "- ");
 	nfs4_show_stateid(s, &st->sc_stateid);
@@ -2708,8 +2723,8 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 	seq_printf(s, ", ");
 	nfs4_show_fname(s, file);
 	seq_printf(s, " }\n");
-	nfsd_file_put(file);
-
+out:
+	spin_unlock(&nf->fi_lock);
 	return 0;
 }
 
-- 
2.37.3

