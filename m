Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80638806E4
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Aug 2019 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfHCPAi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Aug 2019 11:00:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38557 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbfHCPAh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Aug 2019 11:00:37 -0400
Received: by mail-io1-f68.google.com with SMTP id j6so38880286ioa.5
        for <linux-nfs@vger.kernel.org>; Sat, 03 Aug 2019 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jP6jSiXxqPOpj4SyG5pF7m+G03jZg20kHJfasyqxaP4=;
        b=qO55BGTREs1CeT8fmLSmgSP+VM2wKy/vGbHLWYksPzd3Eo6emLOpKJClqrKbCDqtWS
         1Yd1tk8WnlHVOYqEjtPrVNKi/FRw2Z5UrBm/RU/lunjTrEe4D8vrxCTU8ClxL8F59KJi
         TcbLfzlomgIjOkTekQR50Ffm9dIcq4ha1ukpa99rvWRv7nizEQUNXfJCRjqmH1H5SHQ5
         yVBpH7240UV943OP6v0VIpkuWaPsBl9h6NTUL46kFLMA8fU5Mp6Fiw4Hv+hK5GvMAGVr
         zf00ybdfZGnNTDxNMute1U+U0vd6Op/l+QpAtJZpB8a+DWE9tn1sZgrfGCLPidGHp8up
         7P6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jP6jSiXxqPOpj4SyG5pF7m+G03jZg20kHJfasyqxaP4=;
        b=Y2I8Us4qgVzi3za+cvN/op24YpqvRLvfXuzbWlMu4/NA/FBokVgwoNW9KMACw1oH82
         oph/h/O1wTBtA2HAeT5CqjRvKDmYml7Q88IyqkyXw1tlOvHiMResGbjvRuEFUsUOZjTi
         Fp/i9YHf/cQOIXQrlYkHRfT2cx23FMCGFybqL790+XJrdZNZMOLKtBnV4PlanLKoageS
         GPn1cjNYfnVEmjGRJlEYL68pOwv10dEDSYt+uoIFO99p2dLB04FE0aBNahHH3fl4zT1w
         7S2vSTYP1N4cpVZemPqGxvnZd2p6w2eoim12JfFTpVBZrBFv7Z1blG6zUuRyUmHAya+S
         NAPQ==
X-Gm-Message-State: APjAAAX7q4J5gvhBicgTXbn87wDBvT3RQJRCudV4eHdukOGVG53YkOng
        9fTLjX/+03/TgMs7OwIqLjDPaEk=
X-Google-Smtp-Source: APXvYqyu+mt64j/bcHcPqSA+gAelDKepj7k9wzActFbUTj/fO2QZrzwVV/nxNzzNISSnb3ksRHDRkQ==
X-Received: by 2002:a02:22c6:: with SMTP id o189mr52897573jao.35.1564844436681;
        Sat, 03 Aug 2019 08:00:36 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id f20sm60820416ioh.17.2019.08.03.08.00.36
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 03 Aug 2019 08:00:36 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/8] NFSv4: Report the error from nfs4_select_rw_stateid()
Date:   Sat,  3 Aug 2019 10:58:23 -0400
Message-Id: <20190803145826.15504-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190803145826.15504-4-trond.myklebust@hammerspace.com>
References: <20190803145826.15504-1-trond.myklebust@hammerspace.com>
 <20190803145826.15504-2-trond.myklebust@hammerspace.com>
 <20190803145826.15504-3-trond.myklebust@hammerspace.com>
 <20190803145826.15504-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In pnfs_update_layout() ensure that we do report any fatal errors from
nfs4_select_rw_stateid().

Fixes: d9aba2b40de6 ("NFSv4: Don't use the zero stateid with layoutget")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 75bd5b552ba4..4525d5acae38 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1903,12 +1903,6 @@ pnfs_update_layout(struct inode *ino,
 		goto out_unlock;
 	}
 
-	if (!nfs4_valid_open_stateid(ctx->state)) {
-		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
-				PNFS_UPDATE_LAYOUT_INVALID_OPEN);
-		goto out_unlock;
-	}
-
 	/*
 	 * Choose a stateid for the LAYOUTGET. If we don't have a layout
 	 * stateid, or it has been invalidated, then we must use the open
@@ -1939,6 +1933,7 @@ pnfs_update_layout(struct inode *ino,
 					iomode == IOMODE_RW ? FMODE_WRITE : FMODE_READ,
 					NULL, &stateid, NULL);
 		if (status != 0) {
+			lseg = ERR_PTR(status);
 			trace_pnfs_update_layout(ino, pos, count,
 					iomode, lo, lseg,
 					PNFS_UPDATE_LAYOUT_INVALID_OPEN);
-- 
2.21.0

