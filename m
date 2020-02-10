Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F63C15834A
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2020 20:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgBJTJL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Feb 2020 14:09:11 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40729 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJTJK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Feb 2020 14:09:10 -0500
Received: by mail-yw1-f67.google.com with SMTP id i126so3930299ywe.7
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2020 11:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WaM9tXI/bDvfjpAb3YSRIykH3fCTybrKKtQzVxNXnec=;
        b=FDvtfJTMYovLZGA4Ncs0zsZ2+htV3ZzPTELMSiGVhRQhjO75MyxNabhG5JZsF2lJ6G
         kVsydBGxnYP2vsrKSe2A+Uh+LerMsLa8/UykHdr4JZiMLgPxeYZWMmnaT6pfOytNT/Ly
         iUm+X/xrQADnTELmN8cOgPOqZ/gTGbA0xLQHza397tLhyZ89ofhLKRdcWnVvx6mEBAoe
         oXMTAPJSUX2ytw9UCEwDx5L1SBqJ4BpS/B8HA5Vj+RWdngrxIj58a+50R86+RtrYAWX6
         u6u9TTT2UUPFvYpQSjcIknH09yftLY3jpE9da7FkcmrXOA5vkRGe/Hjbh13kLUhlGtcG
         xMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WaM9tXI/bDvfjpAb3YSRIykH3fCTybrKKtQzVxNXnec=;
        b=s05iobvTiMj7hBopIQ6aa+YHwh/j4zHNumwBneoducGpMX36J6AkaBgdZqbz2OrQm0
         i4bDad3CK7arNtgHRXVP37EePkFCNJqVk3tm/IPR/2RfY1/cipGJGyOOlrYYrc4TwP/e
         QePrZ2QM/RotxCqHRhoragVyC9QBM4UE1JD9vqZXictWEpq1ZQ5wtQVMGhCcUuTa3WMI
         g9w7e40d/SR6G/R5Hh+Ch3HUWFaIQI+XKlFx1khqikRMDE6QHxwTY5LS9iyaTRVuEDHX
         6mhuIEQO5lUJSI4wFScHs3T/hzYDbB1/tkmKbm1WlDkvBTW5UfQosbIQCWoGMlwqfmPv
         Abgg==
X-Gm-Message-State: APjAAAW+SZzQOfYFbgRKiSgxU7dyuK1pEnDE090MwBrZsDdwgUxEwvD9
        qwtrAufmAjw3MuhbpLu/Us6zR+QRGA==
X-Google-Smtp-Source: APXvYqznVOwf+i0icW1mnGNTGICcMfbf1B4ko/YhIWCmV51UwvNLDB+t4Da7DKQ+76LjcimAilp8Mg==
X-Received: by 2002:a81:9304:: with SMTP id k4mr2314763ywg.323.1581361749214;
        Mon, 10 Feb 2020 11:09:09 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id i127sm639892ywe.65.2020.02.10.11.09.08
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:09:08 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4/pnfs: pnfs_set_layout_stateid() should update the layout cred
Date:   Mon, 10 Feb 2020 14:06:59 -0500
Message-Id: <20200210190659.557270-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210190659.557270-1-trond.myklebust@hammerspace.com>
References: <20200210190659.557270-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the cred assigned to the layout that we're updating differs from
the one used to retrieve the new layout segment, then we need to
update the layout plh_lc_cred field.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/callback_proc.c |  2 +-
 fs/nfs/pnfs.c          | 20 ++++++++++++++++----
 fs/nfs/pnfs.h          |  1 +
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index cd4c6bc81cae..b6ffac9963c8 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -280,7 +280,7 @@ static u32 initiate_file_draining(struct nfs_client *clp,
 		goto unlock;
 	}
 
-	pnfs_set_layout_stateid(lo, &args->cbl_stateid, true);
+	pnfs_set_layout_stateid(lo, &args->cbl_stateid, NULL, true);
 	switch (pnfs_mark_matching_lsegs_return(lo, &free_me_list,
 				&args->cbl_range,
 				be32_to_cpu(args->cbl_stateid.seqid))) {
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 542ea8dfd1bc..b21eb4882846 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -903,10 +903,21 @@ pnfs_destroy_all_layouts(struct nfs_client *clp)
 	pnfs_destroy_layouts_byclid(clp, false);
 }
 
+static void
+pnfs_set_layout_cred(struct pnfs_layout_hdr *lo, const struct cred *cred)
+{
+	const struct cred *old;
+
+	if (cred && cred_fscmp(lo->plh_lc_cred, cred) != 0) {
+		old = xchg(&lo->plh_lc_cred, get_cred(cred));
+		put_cred(old);
+	}
+}
+
 /* update lo->plh_stateid with new if is more recent */
 void
 pnfs_set_layout_stateid(struct pnfs_layout_hdr *lo, const nfs4_stateid *new,
-			bool update_barrier)
+			const struct cred *cred, bool update_barrier)
 {
 	u32 oldseq, newseq, new_barrier = 0;
 
@@ -914,6 +925,7 @@ pnfs_set_layout_stateid(struct pnfs_layout_hdr *lo, const nfs4_stateid *new,
 	newseq = be32_to_cpu(new->seqid);
 
 	if (!pnfs_layout_is_valid(lo)) {
+		pnfs_set_layout_cred(lo, cred);
 		nfs4_stateid_copy(&lo->plh_stateid, new);
 		lo->plh_barrier = newseq;
 		pnfs_clear_layoutreturn_info(lo);
@@ -1109,7 +1121,7 @@ void pnfs_layoutreturn_free_lsegs(struct pnfs_layout_hdr *lo,
 
 		pnfs_mark_matching_lsegs_invalid(lo, &freeme, range, seq);
 		pnfs_free_returned_lsegs(lo, &freeme, range, seq);
-		pnfs_set_layout_stateid(lo, stateid, true);
+		pnfs_set_layout_stateid(lo, stateid, NULL, true);
 	} else
 		pnfs_mark_layout_stateid_invalid(lo, &freeme);
 out_unlock:
@@ -2323,14 +2335,14 @@ pnfs_layout_process(struct nfs4_layoutget *lgp)
 
 	if (!pnfs_layout_is_valid(lo)) {
 		/* We have a completely new layout */
-		pnfs_set_layout_stateid(lo, &res->stateid, true);
+		pnfs_set_layout_stateid(lo, &res->stateid, lgp->cred, true);
 	} else if (nfs4_stateid_match_other(&lo->plh_stateid, &res->stateid)) {
 		/* existing state ID, make sure the sequence number matches. */
 		if (pnfs_layout_stateid_blocked(lo, &res->stateid)) {
 			dprintk("%s forget reply due to sequence\n", __func__);
 			goto out_forget;
 		}
-		pnfs_set_layout_stateid(lo, &res->stateid, false);
+		pnfs_set_layout_stateid(lo, &res->stateid, lgp->cred, false);
 	} else {
 		/*
 		 * We got an entirely new state ID.  Mark all segments for the
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 0fafdadc9c8d..cfb89d47c79d 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -267,6 +267,7 @@ bool nfs4_layout_refresh_old_stateid(nfs4_stateid *dst,
 void pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo);
 void pnfs_set_layout_stateid(struct pnfs_layout_hdr *lo,
 			     const nfs4_stateid *new,
+			     const struct cred *cred,
 			     bool update_barrier);
 int pnfs_mark_matching_lsegs_invalid(struct pnfs_layout_hdr *lo,
 				struct list_head *tmp_list,
-- 
2.24.1

