Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CCD2791F6
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 22:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgIYUVJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 16:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727183AbgIYUTJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 16:19:09 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601065147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ixwFrCRhUas5/OBo1xF2KyDVsCGZN5j+loRNkw3RRY8=;
        b=YSfCgdFmrVEp8mR2FnikW1DmUAfF9ywvElLXpcTVpHNO1zDLUPWzo+w7i4phseAa4cxdcU
        12NLzE6XBL6Ma+7ru/BTXCf6YK/rz4nM7xNZoj3OdgRKhn283BP0n8JCiumQNBF9Li3Fkq
        +a6qhk7RKilKm8G99y541gr3EbzZgwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-1qsli5waMPWI4V__pmGq6w-1; Fri, 25 Sep 2020 15:48:42 -0400
X-MC-Unique: 1qsli5waMPWI4V__pmGq6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7A98807356;
        Fri, 25 Sep 2020 19:48:40 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DC3F73662;
        Fri, 25 Sep 2020 19:48:40 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id C435010C311B; Fri, 25 Sep 2020 15:48:39 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1] NFSv4: Wait for stateid updates after CLOSE/OPEN_DOWNGRADE
Date:   Fri, 25 Sep 2020 15:48:39 -0400
Message-Id: <faecc3aa23aa1e772875fba9cf42ca7259002181.1601063270.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

We can avoid this situation by not issuing an immediate retry with a bumped
seqid when CLOSE/OPEN_DOWNGRADE receives NFS4ERR_OLD_STATEID.  Instead,
take the same approach used by OPEN and wait at least 5 seconds for
outstanding stateid updates to complete if we can detect that we're out of
sequence.

Note that after this change it is still possible (though unlikely) that
CLOSE waits a full 5 seconds, bumps the seqid, and retries -- and that
attempt races with another OPEN at the same time.  In order to avoid this
race (which would result in the livelock), update
nfs_need_update_open_stateid() to handle the case where:
 - the state is NFS_OPEN_STATE, and
 - the stateid doesn't match the current open stateid

Finally, nfs_need_update_open_stateid() is modified to be idempotent and
renamed to better suit the purpose of signaling that the stateid passed
is the next stateid in sequence.

Fixes: 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE")
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs4_fs.h   |  8 +++++
 fs/nfs/nfs4proc.c  | 81 +++++++++++++++++++++++++++-------------------
 fs/nfs/nfs4trace.h |  1 +
 3 files changed, 56 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 0c9505dc852c..065cb04222a1 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -599,6 +599,14 @@ static inline bool nfs4_stateid_is_newer(const nfs4_stateid *s1, const nfs4_stat
 	return (s32)(be32_to_cpu(s1->seqid) - be32_to_cpu(s2->seqid)) > 0;
 }
 
+static inline bool nfs4_stateid_is_next(const nfs4_stateid *s1, const nfs4_stateid *s2)
+{
+	u32 seq1 = be32_to_cpu(s1->seqid);
+	u32 seq2 = be32_to_cpu(s2->seqid);
+
+	return seq2 == seq1 + 1U || (seq2 == 1U && seq1 == 0xffffffffU);
+}
+
 static inline bool nfs4_stateid_match_or_older(const nfs4_stateid *dst, const nfs4_stateid *src)
 {
 	return nfs4_stateid_match_other(dst, src) &&
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6e95c85fe395..50242ac85c3a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1547,19 +1547,6 @@ static void nfs_state_log_update_open_stateid(struct nfs4_state *state)
 		wake_up_all(&state->waitq);
 }
 
-static void nfs_state_log_out_of_order_open_stateid(struct nfs4_state *state,
-		const nfs4_stateid *stateid)
-{
-	u32 state_seqid = be32_to_cpu(state->open_stateid.seqid);
-	u32 stateid_seqid = be32_to_cpu(stateid->seqid);
-
-	if (stateid_seqid == state_seqid + 1U ||
-	    (stateid_seqid == 1U && state_seqid == 0xffffffffU))
-		nfs_state_log_update_open_stateid(state);
-	else
-		set_bit(NFS_STATE_CHANGE_WAIT, &state->flags);
-}
-
 static void nfs_test_and_clear_all_open_stateid(struct nfs4_state *state)
 {
 	struct nfs_client *clp = state->owner->so_server->nfs_client;
@@ -1585,21 +1572,19 @@ static void nfs_test_and_clear_all_open_stateid(struct nfs4_state *state)
  * i.e. The stateid seqids have to be initialised to 1, and
  * are then incremented on every state transition.
  */
-static bool nfs_need_update_open_stateid(struct nfs4_state *state,
+static bool nfs_stateid_is_sequential(struct nfs4_state *state,
 		const nfs4_stateid *stateid)
 {
-	if (test_bit(NFS_OPEN_STATE, &state->flags) == 0 ||
-	    !nfs4_stateid_match_other(stateid, &state->open_stateid)) {
+	if (test_bit(NFS_OPEN_STATE, &state->flags)) {
+		/* The common case - we're updating to a new sequence number */
+		if (nfs4_stateid_match_other(stateid, &state->open_stateid) &&
+			nfs4_stateid_is_next(&state->open_stateid, stateid)) {
+			return true;
+		}
+	} else {
+		/* This is the first OPEN in this generation */
 		if (stateid->seqid == cpu_to_be32(1))
-			nfs_state_log_update_open_stateid(state);
-		else
-			set_bit(NFS_STATE_CHANGE_WAIT, &state->flags);
-		return true;
-	}
-
-	if (nfs4_stateid_is_newer(stateid, &state->open_stateid)) {
-		nfs_state_log_out_of_order_open_stateid(state, stateid);
-		return true;
+			return true;
 	}
 	return false;
 }
@@ -1673,16 +1658,16 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
 	int status = 0;
 	for (;;) {
 
-		if (!nfs_need_update_open_stateid(state, stateid))
-			return;
-		if (!test_bit(NFS_STATE_CHANGE_WAIT, &state->flags))
+		if (nfs_stateid_is_sequential(state, stateid))
 			break;
+
 		if (status)
 			break;
 		/* Rely on seqids for serialisation with NFSv4.0 */
 		if (!nfs4_has_session(NFS_SERVER(state->inode)->nfs_client))
 			break;
 
+		set_bit(NFS_STATE_CHANGE_WAIT, &state->flags);
 		prepare_to_wait(&state->waitq, &wait, TASK_KILLABLE);
 		/*
 		 * Ensure we process the state changes in the same order
@@ -1693,6 +1678,7 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
 		spin_unlock(&state->owner->so_lock);
 		rcu_read_unlock();
 		trace_nfs4_open_stateid_update_wait(state->inode, stateid, 0);
+
 		if (!signal_pending(current)) {
 			if (schedule_timeout(5*HZ) == 0)
 				status = -EAGAIN;
@@ -3435,7 +3421,8 @@ static bool nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
 	__be32 seqid_open;
 	u32 dst_seqid;
 	bool ret;
-	int seq;
+	int seq, status = -EAGAIN;
+	DEFINE_WAIT(wait);
 
 	for (;;) {
 		ret = false;
@@ -3447,15 +3434,41 @@ static bool nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
 				continue;
 			break;
 		}
+
+		write_seqlock(&state->seqlock);
 		seqid_open = state->open_stateid.seqid;
-		if (read_seqretry(&state->seqlock, seq))
-			continue;
 
 		dst_seqid = be32_to_cpu(dst->seqid);
-		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) >= 0)
-			dst->seqid = cpu_to_be32(dst_seqid + 1);
-		else
+
+		/* Did another OPEN bump the state's seqid?  try again: */
+		if ((s32)(be32_to_cpu(seqid_open) - dst_seqid) > 0) {
 			dst->seqid = seqid_open;
+			write_sequnlock(&state->seqlock);
+			ret = true;
+			break;
+		}
+
+		/* server says we're behind but we haven't seen the update yet */
+		set_bit(NFS_STATE_CHANGE_WAIT, &state->flags);
+		prepare_to_wait(&state->waitq, &wait, TASK_KILLABLE);
+		write_sequnlock(&state->seqlock);
+		trace_nfs4_close_stateid_update_wait(state->inode, dst, 0);
+
+		if (signal_pending(current))
+			status = -EINTR;
+		else
+			if (schedule_timeout(5*HZ) != 0)
+				status = 0;
+
+		finish_wait(&state->waitq, &wait);
+
+		if (!status)
+			continue;
+		if (status == -EINTR)
+			break;
+
+		/* we slept the whole 5 seconds, we must have lost a seqid */
+		dst->seqid = cpu_to_be32(dst_seqid + 1);
 		ret = true;
 		break;
 	}
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index b4f852d4d099..484c1da96dea 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -1511,6 +1511,7 @@ DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_setattr);
 DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_delegreturn);
 DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_open_stateid_update);
 DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_open_stateid_update_wait);
+DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_close_stateid_update_wait);
 
 DECLARE_EVENT_CLASS(nfs4_getattr_event,
 		TP_PROTO(
-- 
2.20.1

