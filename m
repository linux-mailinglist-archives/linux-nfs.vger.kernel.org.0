Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B5C275EC0
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Sep 2020 19:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIWRhP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Sep 2020 13:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30307 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbgIWRhP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Sep 2020 13:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600882634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPNdDejQDjllbdUj51RyPOfu793kTt+QhR08kLI6cR4=;
        b=JHBtGbEGPuaxMdwlDtokIhf9+KX+Cq4MvmgnK+WQbJHHECph8fAItNt+UoZ6mKY49+bNFs
        R4hhmXUyDjm2xdCP9etXncNnA9GEWLikD0YzlxZiqvnhJ9uwjiypLk2T1DHDl9Yi2foGab
        XJzQTdHA8U1ntsGPI7Yml9afqilMZHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-m1ffHZX2OPep6hWxbbgeMg-1; Wed, 23 Sep 2020 13:37:08 -0400
X-MC-Unique: m1ffHZX2OPep6hWxbbgeMg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0907018C521D;
        Wed, 23 Sep 2020 17:37:07 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9597A6198D;
        Wed, 23 Sep 2020 17:37:06 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id EF77710C1FA0; Wed, 23 Sep 2020 13:37:05 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2 v3] NFSv4: Fix a livelock when CLOSE pre-emptively bumps state sequence
Date:   Wed, 23 Sep 2020 13:37:04 -0400
Message-Id: <787d0d4946efb286f4dc51051b048277c0dc697e.1600882430.git.bcodding@redhat.com>
In-Reply-To: <cover.1600882430.git.bcodding@redhat.com>
References: <cover.1600882430.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in
CLOSE/OPEN_DOWNGRADE") the following livelock may occur if a CLOSE races
with the update of the nfs_state:

Process 1           Process 2           Server
=========           =========           ========
 OPEN file
                    OPEN file
                                        Reply OPEN (1)
                                        Reply OPEN (2)
 Update state (1)
 CLOSE file (1)
                                        Reply OLD_STATEID (1)
 CLOSE file (2)
                                        Reply CLOSE (-1)
                    Update state (2)
                    wait for state change
 OPEN file
                    wake
 CLOSE file
 OPEN file
                    wake
 CLOSE file
 ...
                    ...

As long as the first process continues updating state, the second process
will fail to exit the loop in nfs_set_open_stateid_locked().  This livelock
has been observed in generic/168.

Fix this by detecting the case in nfs_need_update_open_stateid() and
then exit the loop if:
 - the state is NFS_OPEN_STATE, and
 - the stateid sequence is > 1, and
 - the stateid doesn't match the current open stateid

Fixes: 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE")
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs4proc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6e95c85fe395..8c2bb91127ee 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1588,19 +1588,21 @@ static void nfs_test_and_clear_all_open_stateid(struct nfs4_state *state)
 static bool nfs_need_update_open_stateid(struct nfs4_state *state,
 		const nfs4_stateid *stateid)
 {
-	if (test_bit(NFS_OPEN_STATE, &state->flags) == 0 ||
-	    !nfs4_stateid_match_other(stateid, &state->open_stateid)) {
+	if (test_bit(NFS_OPEN_STATE, &state->flags)) {
+		/* The common case - we're updating to a new sequence number */
+		if (nfs4_stateid_match_other(stateid, &state->open_stateid) &&
+			nfs4_stateid_is_newer(stateid, &state->open_stateid)) {
+			nfs_state_log_out_of_order_open_stateid(state, stateid);
+			return true;
+		}
+	} else {
+		/* This is the first OPEN */
 		if (stateid->seqid == cpu_to_be32(1))
 			nfs_state_log_update_open_stateid(state);
 		else
 			set_bit(NFS_STATE_CHANGE_WAIT, &state->flags);
 		return true;
 	}
-
-	if (nfs4_stateid_is_newer(stateid, &state->open_stateid)) {
-		nfs_state_log_out_of_order_open_stateid(state, stateid);
-		return true;
-	}
 	return false;
 }
 
-- 
2.20.1

