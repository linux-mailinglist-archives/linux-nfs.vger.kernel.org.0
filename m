Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34C7B3D05D
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404099AbfFKPJV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:09:21 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53304 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbfFKPJU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:09:20 -0400
Received: by mail-it1-f193.google.com with SMTP id m187so5489237ite.3;
        Tue, 11 Jun 2019 08:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Cs22RVTP9M4t5Y+In/GyaXHpttA9IFvUx3BrwLycUq0=;
        b=fHzeKK+cXVMgXBLLhOAOosqTc3ftP/cAKaDZT98O+OIG6OoSUIbD64RthFDaTxsMFE
         K2tWnjU42Kb5QJDlLqhCXTmr03Zb56w4Kg3YYK71ReaHLSo8m92r974XCcSqNOWV+JuF
         gzXMmGjlkwNig+ERubVyuY8EJBnY9FJv+81alK4oqWHTBcqOhXb4aSdQXZXL8YLES/VI
         imwK3eLyEh0+lCRa4XNYZWIMgtXHn/lSKkukX2d3YID1przwIrrXvZaObfOJujZg9x3m
         7M0M8klk0apQ7aVLTml9ZtGE8idZmb/YuyJ/i/qC6rnWRVomGHTraM9YVlVTe0gumP8Q
         E73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Cs22RVTP9M4t5Y+In/GyaXHpttA9IFvUx3BrwLycUq0=;
        b=qwRP8Vbvfx2wiYr6ytgOawE4D0QZavGNqCDkKOOO6gYYs05SlsSsxxAzaT8oRSLvgv
         UJ8SvQSzmiBii+RdsMo+yiafPBKN4U0tuVs8m27nBHwhrg6xlFo9aHUVJzGNOHuevR+j
         cNXdZVFEbukKaAWxOY86RcdLXYnGyfttlGfkhQZZ9/24f+3LjCafDlQmnBO6Gn6CYEfz
         DTQqgWt8xYSzBEVEvbyA8+njquaj4DiTgT2nS51PFCarsvwDfLHCEokzKemobkknxiFb
         3YRDoXd5dtt3iREt3eRodgLNg16azHt2Ddo+tFp0iOlRlrpNwXQH/TMtBLD2vKOoO1Vx
         Ewgw==
X-Gm-Message-State: APjAAAVZlxhe88gJwAG98qW/QItmeUl4QdFRB44WS2xTVeaFqx1dmDZl
        5MMjmAbRY+rhExHkOKHo+TFP1rO3
X-Google-Smtp-Source: APXvYqwtIfNhtLh92m7/s9NpXv5EQydi8HZNH+0FpcXPD/ptHzlloNgtCx20ANsKVZMwiJqWs52hOg==
X-Received: by 2002:a24:67ce:: with SMTP id u197mr11240219itc.146.1560265759743;
        Tue, 11 Jun 2019 08:09:19 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b6sm4679895iok.71.2019.06.11.08.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:09:19 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5BF9I7I021770;
        Tue, 11 Jun 2019 15:09:18 GMT
Subject: [PATCH v2 15/19] NFS4: Add a trace event to record invalid CB
 sequence IDs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 11 Jun 2019 11:09:18 -0400
Message-ID: <20190611150918.2877.79129.stgit@manet.1015granger.net>
In-Reply-To: <20190611150445.2877.8656.stgit@manet.1015granger.net>
References: <20190611150445.2877.8656.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Help debug NFSv4 callback failures.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/callback_proc.c |   28 ++++++++++++++++++++--------
 fs/nfs/nfs4trace.h     |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 3159673..f39924b 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -414,27 +414,39 @@ __be32 nfs4_callback_devicenotify(void *argp, void *resp,
 validate_seqid(const struct nfs4_slot_table *tbl, const struct nfs4_slot *slot,
 		const struct cb_sequenceargs * args)
 {
+	__be32 ret;
+
+	ret = cpu_to_be32(NFS4ERR_BADSLOT);
 	if (args->csa_slotid > tbl->server_highest_slotid)
-		return htonl(NFS4ERR_BADSLOT);
+		goto out_err;
 
 	/* Replay */
 	if (args->csa_sequenceid == slot->seq_nr) {
+		ret = cpu_to_be32(NFS4ERR_DELAY);
 		if (nfs4_test_locked_slot(tbl, slot->slot_nr))
-			return htonl(NFS4ERR_DELAY);
+			goto out_err;
+
 		/* Signal process_op to set this error on next op */
+		ret = cpu_to_be32(NFS4ERR_RETRY_UNCACHED_REP);
 		if (args->csa_cachethis == 0)
-			return htonl(NFS4ERR_RETRY_UNCACHED_REP);
+			goto out_err;
 
 		/* Liar! We never allowed you to set csa_cachethis != 0 */
-		return htonl(NFS4ERR_SEQ_FALSE_RETRY);
+		ret = cpu_to_be32(NFS4ERR_SEQ_FALSE_RETRY);
+		goto out_err;
 	}
 
 	/* Note: wraparound relies on seq_nr being of type u32 */
-	if (likely(args->csa_sequenceid == slot->seq_nr + 1))
-		return htonl(NFS4_OK);
-
 	/* Misordered request */
-	return htonl(NFS4ERR_SEQ_MISORDERED);
+	ret = cpu_to_be32(NFS4ERR_SEQ_MISORDERED);
+	if (args->csa_sequenceid != slot->seq_nr + 1)
+		goto out_err;
+
+	return cpu_to_be32(NFS4_OK);
+
+out_err:
+	trace_nfs4_cb_seqid_err(args, ret);
+	return ret;
 }
 
 /*
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index cd1a5c0..6beb1f2 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -490,6 +490,44 @@
 			__entry->highest_slotid
 		)
 );
+
+TRACE_EVENT(nfs4_cb_seqid_err,
+		TP_PROTO(
+			const struct cb_sequenceargs *args,
+			__be32 status
+		),
+		TP_ARGS(args, status),
+
+		TP_STRUCT__entry(
+			__field(unsigned int, session)
+			__field(unsigned int, slot_nr)
+			__field(unsigned int, seq_nr)
+			__field(unsigned int, highest_slotid)
+			__field(unsigned int, cachethis)
+			__field(int, error)
+		),
+
+		TP_fast_assign(
+			__entry->session = nfs_session_id_hash(&args->csa_sessionid);
+			__entry->slot_nr = args->csa_slotid;
+			__entry->seq_nr = args->csa_sequenceid;
+			__entry->highest_slotid = args->csa_highestslotid;
+			__entry->cachethis = args->csa_cachethis;
+			__entry->error = -be32_to_cpu(status);
+		),
+
+		TP_printk(
+			"error=%d (%s) session=0x%08x slot_nr=%u seq_nr=%u "
+			"highest_slotid=%u",
+			__entry->error,
+			show_nfsv4_errors(__entry->error),
+			__entry->session,
+			__entry->slot_nr,
+			__entry->seq_nr,
+			__entry->highest_slotid
+		)
+);
+
 #endif /* CONFIG_NFS_V4_1 */
 
 TRACE_EVENT(nfs4_setup_sequence,

