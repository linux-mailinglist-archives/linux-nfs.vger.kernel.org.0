Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951FA24C660
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Aug 2020 21:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgHTTub (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Aug 2020 15:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgHTTua (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Aug 2020 15:50:30 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5E4C061385
        for <linux-nfs@vger.kernel.org>; Thu, 20 Aug 2020 12:50:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id D034179CC; Thu, 20 Aug 2020 15:50:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D034179CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1597953029;
        bh=PknS8UJz2dvQI191dd+4N3f+e0aINitCrz1S1eqnZME=;
        h=Date:To:Subject:From:From;
        b=Jx2ns1B4XFWWF3Cvmip5izpHx2Uabb/CJVYRuICxJBygrEjz2bEg7raHv6IsZW9ah
         5Zl0dRP+Bw+RTRS/ClhhAmyzj5ZlUA74vQ7AQkogDC0606xQOuZ66Pm3o3rA9jxllt
         fR+XXi3/prAEl9l0ic0nHa3UaI3Wp6KxxFqHgfUs=
Date:   Thu, 20 Aug 2020 15:50:29 -0400
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: give up callbacks on revoked delegations
Message-ID: <20200820195029.GD28555@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

The delegation is no longer returnable, so I don't think there's much
point retrying the recall.

(I think it's worth asking why we even need separate CLOSED_DELEG and
REVOKED_DELEG states.  But treating them the same would currently cause
nfsd4_free_stateid to call list_del_init(&dp->dl_recall_lru) on a
delegation that the laundromat had unhashed but not revoked, incorrectly
removing it from the laundromat's reaplist or a client's dl_recall_lru.)

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4c9c79fdc3b8..4b70657385f2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4513,7 +4513,8 @@ static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
 {
 	struct nfs4_delegation *dp = cb_to_delegation(cb);
 
-	if (dp->dl_stid.sc_type == NFS4_CLOSED_DELEG_STID)
+	if (dp->dl_stid.sc_type == NFS4_CLOSED_DELEG_STID ||
+	    dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID)
 	        return 1;
 
 	switch (task->tk_status) {
-- 
2.26.2

