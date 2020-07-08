Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87262218C46
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 17:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbgGHPuW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 11:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgGHPuW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 11:50:22 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D825C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 08:50:22 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 80so41968191qko.7
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 08:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMXumYlEHiWgHY3PeWGbuEe5vvQlvPkNCx3e1sy12ME=;
        b=uxR3sp5P+YMISuGSI5ev32RdKSNRNtHRAGS1XnVY7p7A5CrPHVLucobANQEIO6IDyF
         T1J+zlHjuZvlEkxfDSMJ3bYeNBd5bede0PqQmbNnLf+e8VQgeOdtAqgGEpQumjApUzeO
         SrorMTGlx1iWa7fEdlewPAtpBylS/CMloVABsKYQgpeUp1m1zNo25IBzcCdlr04RbY9J
         r69B3WVxb+ih6/gJD4PTzjih91JQnZ5djY21LhR0BzI1eVQTeNi1fUEScgM/UNixYFIU
         4jPhxPVjoBplkOELvBkIpmM/HwUibM/JHICytHggm7IQbhzF+lyRUdMKBQt4zFwbzKiq
         Zi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UMXumYlEHiWgHY3PeWGbuEe5vvQlvPkNCx3e1sy12ME=;
        b=d35VbrVauvmqTas3Rh0u7m3uQgSOUYkPbsssYs4jUhic5ujp0baq4K2F4def2gxWQU
         UFGN2oiS/jUFtjxdggHtphtDgzx+SpJAN1rOBYsbrKBuI2t1HpKxZmG01H1901a8WpW2
         iLVsCEpVdVupz4b2R+nsvw8hpiGmIZqeQXtezrDM90ha3v+xOikfaPr0X71GlMDcYqkY
         A0pxZkwOhT3UMzmkUBfeceO6V+HD3AY5FkH3Ni1mXUk7HfKUpVmIFmEii9ocnvMeG/YI
         8eYVIBkXfwaeVoKZn2zkZJKhJbUyEWnN+kibxVMyCHMtkEJs61j9QoGexzXnCY313kzn
         oeLA==
X-Gm-Message-State: AOAM531tXH+IBNVcdcVt1/UqV2mQm2w7BmXq1OWns5tmE7c3Qv37CSO4
        84JuawMtbOTQQtkjWWAwhtj5xuNA
X-Google-Smtp-Source: ABdhPJxhSkRVkG/2KCFqWBnfRDpe4pGIj5c3ePjeROKhA5DJqFyZV+E1R2gLvnj5d+ztERtxiiTLuw==
X-Received: by 2002:a05:620a:40c1:: with SMTP id g1mr58107735qko.391.1594223421511;
        Wed, 08 Jul 2020 08:50:21 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id h41sm26996qtk.68.2020.07.08.08.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 08:50:20 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v1 1/1] NFS: Fix interrupted slots by sending a solo SEQUENCE operation
Date:   Wed,  8 Jul 2020 11:50:18 -0400
Message-Id: <20200708155018.110150-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708155018.110150-1-Anna.Schumaker@Netapp.com>
References: <20200708155018.110150-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We used to do this before 3453d5708b33, but this was changed to better
handle the NFS4ERR_SEQ_MISORDERED error code. This commit fixed the slot
re-use case when the server doesn't receive the interrupted operation,
but if the server does receive the operation then it could still end up
replying to the client with mis-matched operations from the reply cache.

We can fix this by sending a SEQUENCE to the server while recovering from
a SEQ_MISORDERED error when we detect that we are in an interrupted slot
situation.

Fixes: 3453d5708b33 (NFSv4.1: Avoid false retries when RPC calls are interrupted)
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs4proc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e32717fd1169..5de41a5772f0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -774,6 +774,14 @@ static void nfs4_slot_sequence_acked(struct nfs4_slot *slot,
 	slot->seq_nr_last_acked = seqnr;
 }
 
+static void nfs4_probe_sequence(struct nfs_client *client, const struct cred *cred,
+				struct nfs4_slot *slot)
+{
+	struct rpc_task *task = _nfs41_proc_sequence(client, cred, slot, true);
+	if (!IS_ERR(task))
+		rpc_wait_for_completion_task(task);
+}
+
 static int nfs41_sequence_process(struct rpc_task *task,
 		struct nfs4_sequence_res *res)
 {
@@ -790,6 +798,7 @@ static int nfs41_sequence_process(struct rpc_task *task,
 		goto out;
 
 	session = slot->table->session;
+	clp = session->clp;
 
 	trace_nfs4_sequence_done(session, res);
 
@@ -804,7 +813,6 @@ static int nfs41_sequence_process(struct rpc_task *task,
 		nfs4_slot_sequence_acked(slot, slot->seq_nr);
 		/* Update the slot's sequence and clientid lease timer */
 		slot->seq_done = 1;
-		clp = session->clp;
 		do_renew_lease(clp, res->sr_timestamp);
 		/* Check sequence flags */
 		nfs41_handle_sequence_flag_errors(clp, res->sr_status_flags,
@@ -852,10 +860,15 @@ static int nfs41_sequence_process(struct rpc_task *task,
 		/*
 		 * Were one or more calls using this slot interrupted?
 		 * If the server never received the request, then our
-		 * transmitted slot sequence number may be too high.
+		 * transmitted slot sequence number may be too high. However,
+		 * if the server did receive the request then it might
+		 * accidentally give us a reply with a mismatched operation.
+		 * We can sort this out by sending a lone sequence operation
+		 * to the server on the same slot.
 		 */
 		if ((s32)(slot->seq_nr - slot->seq_nr_last_acked) > 1) {
 			slot->seq_nr--;
+			nfs4_probe_sequence(clp, task->tk_msg.rpc_cred, slot);
 			goto retry_nowait;
 		}
 		/*
-- 
2.27.0

