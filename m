Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2BB21A694
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2020 20:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgGISFt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Jul 2020 14:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGISFt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Jul 2020 14:05:49 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28217C08C5CE
        for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2020 11:05:49 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id j80so2721565qke.0
        for <linux-nfs@vger.kernel.org>; Thu, 09 Jul 2020 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0RjQhGXVN4i9/jc9LDGYNpXljREDNPAcDWrDbb6MfRs=;
        b=KgCohsGgEBDNWUwPCrFkkW82oJiqbRl+WLVpRNJKly9opmrD/RmmSDNf+gD/XwyhHO
         C82J33WN9YuekJ1f75MpDkAU73rNi0PCk+PzqaWa63j6rPbSAsTuEMjsiR7HMaLocsmO
         N1xL6Ltjh9MGPLOEagf+rEOF54I69UU5hENHEhGHftKM/f64qFyYjopwo56qa2Fw/4M8
         ZmF+OFNMxik0/7Y+EsBLHBYz84jqi9zrbHsEjAVREJ9tXv8ZmGat3YEih9xyRTXTQDw9
         mFv4Le7+Pcr3EbkHrQ6B5uozqf/UVD6XxhA7zPvE4QYoGyAI0mXed4OPnxX2Nmf/Z8KW
         1OEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0RjQhGXVN4i9/jc9LDGYNpXljREDNPAcDWrDbb6MfRs=;
        b=ggSHCdW5r5sPsYWH4S9F9IbzcAksg5Ow6onbiAuU1AwF34iPL+xPTwGcH/vtuQOZAj
         cX9o6tzBpRFFYdU+olTh/5M1Z9uR8qJTldMFV5PsBeJeZxL7Y2k80HOhVQ2JCW0s/1Cd
         TsY51x2Ksmcs3uYTcqtZz2Ko6LBBrz4Ra+bubLfdDRAacPr6Al/IKnRFzPr4TLfosGqG
         Yb48KjTl7OAyA8q63sgPVHHy6VYRNtQ16rgNZTa+1p5t6HojlPL2M0UCVkS0uJUh6NUP
         QdHscgLujNcdI5KVXFtjDzHki/7uUsfKfNt5vXdcd34gDpxBv334RjPSpIOj0zXZzyRN
         1yQQ==
X-Gm-Message-State: AOAM531lrPSHGWq9VGtSlzJdxKFX7Xaf2I6gWikkROMhYX44o37OTncA
        EGRw2wJGMqradhlCgindBvAtpcBC
X-Google-Smtp-Source: ABdhPJyYHUehaDS0vGLrGtEXm9DSmR5cJsf6fqMlOLKjwIL5dDfNgxXFb2jB+PZXCMIQNFiG1/SnzA==
X-Received: by 2002:a05:620a:15bc:: with SMTP id f28mr52542077qkk.322.1594317948058;
        Thu, 09 Jul 2020 11:05:48 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id v134sm4532707qkb.60.2020.07.09.11.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:05:47 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 1/1] NFS: Fix interrupted slots by sending a solo SEQUENCE operation
Date:   Thu,  9 Jul 2020 14:05:45 -0400
Message-Id: <20200709180545.903715-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709180545.903715-1-Anna.Schumaker@Netapp.com>
References: <20200709180545.903715-1-Anna.Schumaker@Netapp.com>
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
 fs/nfs/nfs4proc.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e32717fd1169..2e2dac29a9e9 100644
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
+		rpc_put_task_async(task);
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
@@ -852,10 +860,18 @@ static int nfs41_sequence_process(struct rpc_task *task,
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
+			if (task->tk_msg.rpc_proc != &nfs4_procedures[NFSPROC4_CLNT_SEQUENCE]) {
+				nfs4_probe_sequence(clp, task->tk_msg.rpc_cred, slot);
+				res->sr_slot = NULL;
+			}
 			goto retry_nowait;
 		}
 		/*
-- 
2.27.0

