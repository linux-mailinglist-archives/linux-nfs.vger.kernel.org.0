Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD8B24BBAF
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 16:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfFSOdt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 10:33:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41166 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSOdt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 10:33:49 -0400
Received: by mail-io1-f68.google.com with SMTP id w25so38559441ioc.8;
        Wed, 19 Jun 2019 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Cs22RVTP9M4t5Y+In/GyaXHpttA9IFvUx3BrwLycUq0=;
        b=q0nFdIGdebyUJ9ipMH/oxOTG7SiZHWSA9+0PqJsbdjo2l1m+u3W6vcme7u41v2cF8x
         Uddj7b10Ee7okt5LYAZQeDi52hBPQkLMf2nHTWb6rAfxNBmkyUctGFtt1fhyMPvKQ5QE
         j+2h5F1CWPLydOE6X23Xe0Ozq99N/RdJ6MEFTsOYQbUVsLqYHb2gptJoiZftVxZag6kR
         78qilhIAFArp9JYZB1ZGhKknQuWrJYMowDrA3ybruFgys9xjc/O86Aj9v9Ly418hZQn3
         xlpLNpcs4H7tON46KyAJhnKXodITMVSSmhJcOM9sWTd0RAf70X7NkqsBbSKBk7StK+Kg
         VYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Cs22RVTP9M4t5Y+In/GyaXHpttA9IFvUx3BrwLycUq0=;
        b=MrqKT/mLak/Nb6flpo/oNVghLN3XU6z8EDhdlzEWS+wdd77G3mhwBQuh2DHEP4UckR
         LGqi/dJmrYwlOzfvYceI1UMXN4Pdp8YeApI2mY9UQ7+lOi/oHtQj1HzI75XtHhnZeHc/
         ba7QpfZjAU68BNwD5ehrblVLMNMigwpexsKIWTAIPZJ4LzsFs8UpN+5dW2RVf1sxHEJW
         q0zkEjW8rmU+QVMe+PelAbWS3N/G/4Cr+OPYjcjIkiVGDoc/TpnBm7LVhnCQS0664z78
         s4jhJ/IpNo3/6FsCQMv5HUWEHMng0fPDVT/S8UELVQrpglE/VTPotsu9U07KWtnI9Zbo
         HYoQ==
X-Gm-Message-State: APjAAAXNqwj3Plizudsx5WsrgOSoQAL1bPARnDSHdtAkU8bPeFTaAOhb
        f5YSjVU7ynszst3QrwJLXjY=
X-Google-Smtp-Source: APXvYqw/SUytEka2dXs8+Oz4omtlJ7K8TzfDGj7mRv/R61P8D9By5+YRJ217VSXXbqcg0+t1U7kHcA==
X-Received: by 2002:a02:7695:: with SMTP id z143mr91541625jab.135.1560954828817;
        Wed, 19 Jun 2019 07:33:48 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 20sm18776054iog.62.2019.06.19.07.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:33:48 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5JEXlT0004536;
        Wed, 19 Jun 2019 14:33:47 GMT
Subject: [PATCH v4 15/19] NFS4: Add a trace event to record invalid CB
 sequence IDs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:33:47 -0400
Message-ID: <20190619143347.3826.65233.stgit@manet.1015granger.net>
In-Reply-To: <20190619143031.3826.46412.stgit@manet.1015granger.net>
References: <20190619143031.3826.46412.stgit@manet.1015granger.net>
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

