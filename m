Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACFAF530F
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2019 18:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfKHR4A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Nov 2019 12:56:00 -0500
Received: from fieldses.org ([173.255.197.46]:36458 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbfKHR4A (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 8 Nov 2019 12:56:00 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id B41801C15; Fri,  8 Nov 2019 12:55:59 -0500 (EST)
Date:   Fri, 8 Nov 2019 12:55:59 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfsd: mark cb path down on unknown errors
Message-ID: <20191108175559.GD758@fieldses.org>
References: <20191023214318.9350-1-trond.myklebust@hammerspace.com>
 <20191025145147.GA16053@pick.fieldses.org>
 <97f56de86f0aeafb56998023d0561bb4a6233eb8.camel@hammerspace.com>
 <20191025152119.GC16053@pick.fieldses.org>
 <20191025153336.GA20283@fieldses.org>
 <20191029214705.GA29280@fieldses.org>
 <20191107222712.GB10806@fieldses.org>
 <20191108175109.GA758@fieldses.org>
 <20191108175228.GB758@fieldses.org>
 <20191108175417.GC758@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108175417.GC758@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>
Date: Tue, 22 Oct 2019 12:29:37 -0400

An unexpected error is probably a sign that something is wrong with the
callback path.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4callback.c | 1 +
 1 file changed, 1 insertion(+)

Also, while we're here....--b.

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 67d24a536082..c94768b096a3 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1126,6 +1126,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		}
 		break;
 	default:
+		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
 		dprintk("%s: unprocessed error %d\n", __func__,
 			cb->cb_seq_status);
 	}
-- 
2.23.0

