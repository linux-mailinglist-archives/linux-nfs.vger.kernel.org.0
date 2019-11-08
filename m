Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC6FF5302
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2019 18:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfKHRyS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Nov 2019 12:54:18 -0500
Received: from fieldses.org ([173.255.197.46]:36448 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfKHRyS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 8 Nov 2019 12:54:18 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id D5F571C15; Fri,  8 Nov 2019 12:54:17 -0500 (EST)
Date:   Fri, 8 Nov 2019 12:54:17 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfsd: document callback_wq serialization of callback code
Message-ID: <20191108175417.GC758@fieldses.org>
References: <20191023214318.9350-1-trond.myklebust@hammerspace.com>
 <20191025145147.GA16053@pick.fieldses.org>
 <97f56de86f0aeafb56998023d0561bb4a6233eb8.camel@hammerspace.com>
 <20191025152119.GC16053@pick.fieldses.org>
 <20191025153336.GA20283@fieldses.org>
 <20191029214705.GA29280@fieldses.org>
 <20191107222712.GB10806@fieldses.org>
 <20191108175109.GA758@fieldses.org>
 <20191108175228.GB758@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108175228.GB758@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>
Date: Tue, 29 Oct 2019 16:02:18 -0400

The callback code relies on the fact that much of it is only ever called
from the ordered workqueue callback_wq, and this is worth documenting.

Reported-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4callback.c | 6 ++++++
 1 file changed, 6 insertions(+)

Also adding a comment, since I know this was a source of confusion when
investigating these races.

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index c94768b096a3..24534db87e86 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1243,6 +1243,12 @@ static struct nfsd4_conn * __nfsd4_find_backchannel(struct nfs4_client *clp)
 	return NULL;
 }
 
+/*
+ * Note there isn't a lot of locking in this code; instead we depend on
+ * the fact that it is run from the callback_wq, which won't run two
+ * work items at once.  So, for example, callback_wq handles all access
+ * of cl_cb_client and all calls to rpc_create or rpc_shutdown_client.
+ */
 static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 {
 	struct nfs4_cb_conn conn;
-- 
2.23.0

