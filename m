Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1BE1CE8FC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 01:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgEKXRS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 May 2020 19:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgEKXRS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 May 2020 19:17:18 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF24C061A0C
        for <linux-nfs@vger.kernel.org>; Mon, 11 May 2020 16:17:18 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 617341C21; Mon, 11 May 2020 19:17:17 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/2] nfsd4: common stateid-printing code
Date:   Mon, 11 May 2020 19:17:15 -0400
Message-Id: <1589239036-17100-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

There's a problem with how I'm formatting stateids.  Before I fix it,
I'd like to move the stateid formatting into a common helper.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c107caa56525..ded08aeae497 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2422,6 +2422,11 @@ static void nfs4_show_owner(struct seq_file *s, struct nfs4_stateowner *oo)
 	seq_quote_mem(s, oo->so_owner.data, oo->so_owner.len);
 }
 
+static void nfs4_show_stateid(struct seq_file *s, stateid_t *stid)
+{
+	seq_printf(s, "0x%16phN", stid);
+}
+
 static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 {
 	struct nfs4_ol_stateid *ols;
@@ -2437,7 +2442,9 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 	nf = st->sc_file;
 	file = find_any_file(nf);
 
-	seq_printf(s, "- 0x%16phN: { type: open, ", &st->sc_stateid);
+	seq_printf(s, "- ");
+	nfs4_show_stateid(s, &st->sc_stateid);
+	seq_printf(s, ": { type: open, ");
 
 	access = bmap_to_share_mode(ols->st_access_bmap);
 	deny   = bmap_to_share_mode(ols->st_deny_bmap);
@@ -2470,7 +2477,9 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
 	nf = st->sc_file;
 	file = find_any_file(nf);
 
-	seq_printf(s, "- 0x%16phN: { type: lock, ", &st->sc_stateid);
+	seq_printf(s, "- ");
+	nfs4_show_stateid(s, &st->sc_stateid);
+	seq_printf(s, ": { type: lock, ");
 
 	/*
 	 * Note: a lock stateid isn't really the same thing as a lock,
@@ -2499,7 +2508,9 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 	nf = st->sc_file;
 	file = nf->fi_deleg_file;
 
-	seq_printf(s, "- 0x%16phN: { type: deleg, ", &st->sc_stateid);
+	seq_printf(s, "- ");
+	nfs4_show_stateid(s, &st->sc_stateid);
+	seq_printf(s, ": { type: deleg, ");
 
 	/* Kinda dead code as long as we only support read delegs: */
 	seq_printf(s, "access: %s, ",
@@ -2521,7 +2532,9 @@ static int nfs4_show_layout(struct seq_file *s, struct nfs4_stid *st)
 	ls = container_of(st, struct nfs4_layout_stateid, ls_stid);
 	file = ls->ls_file;
 
-	seq_printf(s, "- 0x%16phN: { type: layout, ", &st->sc_stateid);
+	seq_printf(s, "- ");
+	nfs4_show_stateid(s, &st->sc_stateid);
+	seq_printf(s, ": { type: layout, ");
 
 	/* XXX: What else would be useful? */
 
-- 
2.26.2

