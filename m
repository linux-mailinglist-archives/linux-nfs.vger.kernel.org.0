Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC072721C5
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 13:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgIULEq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 07:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726367AbgIULEq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 07:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600686285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oSBnktT2kTPcVmUcg+sTRFLjfY2yslyu8lr49XNhb+k=;
        b=T3zu3tcBVlnD9GpEXQMrg/6nt3ckSE1NjAeeVlGuXFBSINTB3mXZrEI+DhpXOhk6VmXgoa
        h1AkORf1RtfpE15UmRt6nd04rIufDj9PHXA6IloELRrn6X7bH1nGod+Qu2w86pZCCXWAot
        ogm+6G707V2liPq5dRl2TjYG397qQaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-LuJdFMW9PgC1Gy7DhLGFHw-1; Mon, 21 Sep 2020 07:04:43 -0400
X-MC-Unique: LuJdFMW9PgC1Gy7DhLGFHw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C47B3800688;
        Mon, 21 Sep 2020 11:04:42 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B43319C4F;
        Mon, 21 Sep 2020 11:04:42 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id DAF2710C311B; Mon, 21 Sep 2020 07:04:41 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFSv4: Fix a livelock when CLOSE pre-emptively bumps state sequence
Date:   Mon, 21 Sep 2020 07:04:39 -0400
Message-Id: <5a7f6bbf4cf2038634a572f42ad80e95a8d0ae9c.1600686204.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in
CLOSE/OPEN_DOWNGRADE") the following livelock may occur if a CLOSE races
with the update of the nfs_state:

Process 1	  Process 2	   Server
=========         =========	   ========
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
 fs/nfs/nfs4proc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 45e0585e0667..9ced7a62c05e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1570,10 +1570,14 @@ static bool nfs_need_update_open_stateid(struct nfs4_state *state,
 {
 	if (test_bit(NFS_OPEN_STATE, &state->flags) == 0 ||
 	    !nfs4_stateid_match_other(stateid, &state->open_stateid)) {
-		if (stateid->seqid == cpu_to_be32(1))
+		if (stateid->seqid == cpu_to_be32(1)) {
 			nfs_state_log_update_open_stateid(state);
-		else
-			set_bit(NFS_STATE_CHANGE_WAIT, &state->flags);
+		} else {
+			if (!nfs4_stateid_match_other(stateid, &state->open_stateid))
+				return false;
+			else
+				set_bit(NFS_STATE_CHANGE_WAIT, &state->flags);
+		}
 		return true;
 	}
 
-- 
2.20.1

