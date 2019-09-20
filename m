Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6714BB8EF6
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 13:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438173AbfITL0I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 07:26:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38073 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438179AbfITL0I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Sep 2019 07:26:08 -0400
Received: by mail-io1-f67.google.com with SMTP id k5so15323192iol.5
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2019 04:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mT/Rzj/K1U6LEdiuCQ0lI11+dkVn7b9E0XXmRpME0Iw=;
        b=L0hcTQaxV8tWoYW+YxfWvV652jMyLbKAjaRxV1Yn1a2PNN0bAn+CrM6haVrz1rrB7C
         NkIiFUUATU+H6s0Ro70G/R0HD6mLM2ddrLlznOOj1mqwRdP+ZMtsH1bDQiSYdDFkJGPG
         5qCDctlZ+lNvaR9/WTuScAyhT8aVOGkE+F8jH6OfDMa9SOrdOC2liBQ7K0z38ZWk07tg
         GEsHDIrc3z4O9r8ZxxrvPy4nzSt6hMwSb090QCCX1vHGIKIpZtB4KkBbdY2ZyX6SgTvt
         /+u6hqWTdq4wjLUjIpusCTNPsex280T7OvCJtm3bdUvGnEblS2HzXS09bko+rKbp+EcD
         /UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mT/Rzj/K1U6LEdiuCQ0lI11+dkVn7b9E0XXmRpME0Iw=;
        b=FGFAnuPTKwM0hVZSQuLAS/PE1R1VBdgujpV5cexHToGcZWiNpjzFfyuxb7Azab4/MJ
         I6UqRyUVXcfsBlFuNGyeHDiejO0QvpVCM6xko+reCtWNY+RpH1tH98bxxyxPAGRzToVz
         DpNYALFS5OYayz4nvzrpcgisEBrJO8C+jnzQfSRSFrlgzM6qrRv9eMo3beSqyrMnIqzX
         ZeLDC2D8jj++f9DWlqn/H4iDWq876Z+izzl4Oa5eQAAR0TaYyWpDQSm68OzEgafrGuts
         GuyKxPBNYlo0umWafb3vzfBoeQsE1fYAOt2P44UbvRglio0u4XqxZyyQqk/c7DMCKSds
         igrQ==
X-Gm-Message-State: APjAAAUAy1oD1CYa6FU2sEWNKkhQm3dlYaLjU9qaZnJbifcvFVgNi5tO
        RypVos+jQ7+IUsgR4iVQNFomPpfTtw==
X-Google-Smtp-Source: APXvYqz4dbuW1lrZ0hrHtY6UP7e0JWsA8yXBOVTpveDWwkgIPtFfYB0lUNRsjJmK2WLDcFnNJck/Ow==
X-Received: by 2002:a5e:9319:: with SMTP id k25mr19119010iom.290.1568978767125;
        Fri, 20 Sep 2019 04:26:07 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q74sm1308736iod.72.2019.09.20.04.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 04:26:06 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v3 4/9] NFSv4: Handle RPC level errors in LAYOUTRETURN
Date:   Fri, 20 Sep 2019 07:23:43 -0400
Message-Id: <20190920112348.69496-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920112348.69496-4-trond.myklebust@hammerspace.com>
References: <20190920112348.69496-1-trond.myklebust@hammerspace.com>
 <20190920112348.69496-2-trond.myklebust@hammerspace.com>
 <20190920112348.69496-3-trond.myklebust@hammerspace.com>
 <20190920112348.69496-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Handle RPC level errors by assuming that the RPC call was successful.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c |  9 +++++++++
 fs/nfs/pnfs.c     | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index fcdfddfd3ab4..a5deb00b5ad1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9057,6 +9057,15 @@ static void nfs4_layoutreturn_done(struct rpc_task *task, void *calldata)
 	if (!nfs41_sequence_process(task, &lrp->res.seq_res))
 		return;
 
+	/*
+	 * Was there an RPC level error? Assume the call succeeded,
+	 * and that we need to release the layout
+	 */
+	if (task->tk_rpc_status != 0 && RPC_WAS_SENT(task)) {
+		lrp->res.lrs_present = 0;
+		return;
+	}
+
 	server = NFS_SERVER(lrp->args.inode);
 	switch (task->tk_status) {
 	case -NFS4ERR_OLD_STATEID:
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 6436047dc999..abc7188f1853 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1455,6 +1455,21 @@ int pnfs_roc_done(struct rpc_task *task, struct inode *inode,
 	case 0:
 		retval = 0;
 		break;
+	case -NFS4ERR_NOMATCHING_LAYOUT:
+		/* Was there an RPC level error? If not, retry */
+		if (task->tk_rpc_status == 0)
+			break;
+		/* If the call was not sent, let caller handle it */
+		if (!RPC_WAS_SENT(task))
+			return 0;
+		/*
+		 * Otherwise, assume the call succeeded and
+		 * that we need to release the layout
+		 */
+		*ret = 0;
+		(*respp)->lrs_present = 0;
+		retval = 0;
+		break;
 	case -NFS4ERR_DELAY:
 		/* Let the caller handle the retry */
 		*ret = -NFS4ERR_NOMATCHING_LAYOUT;
-- 
2.21.0

