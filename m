Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F061D539200
	for <lists+linux-nfs@lfdr.de>; Tue, 31 May 2022 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344828AbiEaNtD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 May 2022 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiEaNtB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 May 2022 09:49:01 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2C21C136
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 06:49:00 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id l82so13198645qke.3
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PYLWJkHdUUIJ6iQ4eafOViUd+wC2V22z8U4Kbj4sAP8=;
        b=mJ1DByF4E5TCa+by3Sd7J0fuE3NYLGKhkQFx4Sn0eNAMv+OQdU/gncUY0in6SV6Y3l
         L6l0jfAgl9EnWgE/67YroAlWQN/5prcBwX1p2zf/Y62GiT2KIXjRur9LlauOwrwJlpby
         GpeKcnFLwVjheAgyuU43XZ27hOcR9JAV/GyEshL/+19BtGYGHQKm7b6Waak+JMKpa0gG
         TibKBQu9bGcImncjW/MG1bATqbi1li8pvmHZxXAHDEX029GLQdaLtSpuWYdRMWHQlvll
         pMk3+ptDw8aQ7SMfgS6WMt9a6ToWU1GCR5ry+UXkPOjFpuXX8e52M3QKts4mNTo/W9kf
         dyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PYLWJkHdUUIJ6iQ4eafOViUd+wC2V22z8U4Kbj4sAP8=;
        b=b5MU4xtoj9zDCgukV7qhxg1b4L5far1dktfz5uyV1H84bxqzSro+xDz4BB9kgJxIyQ
         fjDiKnG9Mc7iLxGS6XDGzK+IWk7KPz2go3gnVxucO7so7cLByME2nhPKCMPO6Okymgea
         EeHoDRwSzhH8IOSDQrX4kb4bOd6nx0UAOZifXx0+qmP6EnUrK5KejXTM1BT9ytjtJZhA
         4A79wNM+5xSV10lFPWGztoMojCN4Ej1wf9Nyaw/QNHx+lSOTtAwj/EU+KZf1jLSYwda1
         2f7Jz6PJttv6QY5RXftP3RlE0lojy5mvwTtSO8yled5MmDnkd8PAwSEV6u56Aiu49nf/
         SFiA==
X-Gm-Message-State: AOAM532jL/6/lji+AJw2lo/qiEhab9c8GOjKzc/5hUIECr141/sk5Ok9
        2nYeUWIkWLp0wFsOu9bVOUAIvoVy1jl+Jw==
X-Google-Smtp-Source: ABdhPJyv1RNjGhh8rSKz2rZ69dwEmRH0XKMyVTALm501hdmNXG8sEs5NqAILbHogADHY/BsHVatG2w==
X-Received: by 2002:a37:a1d0:0:b0:6a3:647a:675e with SMTP id k199-20020a37a1d0000000b006a3647a675emr33013452qke.399.1654004939257;
        Tue, 31 May 2022 06:48:59 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:8432:9f8c:1f08:792a])
        by smtp.gmail.com with ESMTPSA id o13-20020a05622a008d00b002f937991969sm9926583qtw.24.2022.05.31.06.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 06:48:57 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] pNFS: fix IO thread starvation problem during LAYOUTUNAVAILABLE error
Date:   Tue, 31 May 2022 09:48:54 -0400
Message-Id: <20220531134854.63115-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

In recent pnfs testing we've incountered IO thread starvation problem
during the time when the server returns LAYOUTUNAVAILABLE error to the
client. When that happens each IO request tries to get a new layout
and the pnfs_update_layout() code ensures that only 1 LAYOUTGET
RPC is outstanding, the rest would be waiting. As the thread that gets
the layout wakes up the waiters only one gets to run and it tends to be
the latest added to the waiting queue. After receiving LAYOUTUNAVAILABLE
error the client would fall back to the MDS writes and as those writes
complete and the new write is issued, those requests are added as
waiters and they get to run before the earliest of the waiters that
was put on the queue originally never gets to run until the
LAYOUTUNAVAILABLE condition resolves itself on the server.

With the current code, if N IOs arrive asking for a layout, then
there will be N serial LAYOUTGETs that will follow, each would be
getting its own LAYOUTUNAVAILABLE error. Instead, the patch proposes
to apply the error condition to ALL the waiters for the outstanding
LAYOUTGET. Once the error is received, the code would allow all
exiting N IOs fall back to the MDS, but any new arriving IOs would be
then queued up and one them the new IO would trigger a new LAYOUTGET.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/pnfs.c | 14 +++++++++++++-
 fs/nfs/pnfs.h |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 68a87be3e6f9..5b7a679e32c8 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2028,10 +2028,20 @@ pnfs_update_layout(struct inode *ino,
 	if ((list_empty(&lo->plh_segs) || !pnfs_layout_is_valid(lo)) &&
 	    atomic_read(&lo->plh_outstanding) != 0) {
 		spin_unlock(&ino->i_lock);
+		atomic_inc(&lo->plh_waiting);
 		lseg = ERR_PTR(wait_var_event_killable(&lo->plh_outstanding,
 					!atomic_read(&lo->plh_outstanding)));
-		if (IS_ERR(lseg))
+		if (IS_ERR(lseg)) {
+			atomic_dec(&lo->plh_waiting);
 			goto out_put_layout_hdr;
+		}
+		if (test_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags)) {
+			pnfs_layout_clear_fail_bit(lo, pnfs_iomode_to_fail_bit(iomode));
+			lseg = NULL;
+			if (atomic_dec_and_test(&lo->plh_waiting))
+				clear_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags);
+			goto out_put_layout_hdr;
+		}
 		pnfs_put_layout_hdr(lo);
 		goto lookup_again;
 	}
@@ -2152,6 +2162,8 @@ pnfs_update_layout(struct inode *ino,
 		case -ERECALLCONFLICT:
 		case -EAGAIN:
 			break;
+		case -ENODATA:
+			set_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags);
 		default:
 			if (!nfs_error_is_fatal(PTR_ERR(lseg))) {
 				pnfs_layout_clear_fail_bit(lo, pnfs_iomode_to_fail_bit(iomode));
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 07f11489e4e9..5c07da32320b 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -105,6 +105,7 @@ enum {
 	NFS_LAYOUT_FIRST_LAYOUTGET,	/* Serialize first layoutget */
 	NFS_LAYOUT_INODE_FREEING,	/* The inode is being freed */
 	NFS_LAYOUT_HASHED,		/* The layout visible */
+	NFS_LAYOUT_DRAIN,
 };
 
 enum layoutdriver_policy_flags {
@@ -196,6 +197,7 @@ struct pnfs_commit_ops {
 struct pnfs_layout_hdr {
 	refcount_t		plh_refcount;
 	atomic_t		plh_outstanding; /* number of RPCs out */
+	atomic_t		plh_waiting;
 	struct list_head	plh_layouts;   /* other client layouts */
 	struct list_head	plh_bulk_destroy;
 	struct list_head	plh_segs;      /* layout segments list */
-- 
2.27.0

