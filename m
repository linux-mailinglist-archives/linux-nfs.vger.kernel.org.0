Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25898B8EF2
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 13:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438178AbfITLZ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 07:25:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35193 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438173AbfITLZ7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Sep 2019 07:25:59 -0400
Received: by mail-io1-f66.google.com with SMTP id q10so15380273iop.2
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2019 04:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+xAWTrh/Lsv4sQba0rlaTvUNAip8h2KHmmPmv3mJ88=;
        b=MEIPtDdAe69WuPjgv8mb5KS2Nj91HiHM7X/fNwxDpzOl2yVJnmopDhGCfIdaqH1ods
         0zqq3V1dJYVz+jQcuEA00Jo0GoSVYu1RseEF1q1OrwH+fFati7IcM+woA3i0HPHz68P+
         vXqoIw2yz4mwsMR5ns+0e4LbgQASlreSwdnfEP9HoHRdB2GW3IoDV9CFcqaA/sFFDzrO
         PMKu00F4Php/b2WSHMc/3e0RzC0NqECFQ4a8aetc/bV8ARFQLN4Km5z+VI/TwK1YVfGC
         eo7y2MTlnd3sGUTJyqNcRMqbVYjRndQijRonLh89ZMynxNCJ7WEgLBagIG+wpFXcSxJW
         zdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+xAWTrh/Lsv4sQba0rlaTvUNAip8h2KHmmPmv3mJ88=;
        b=uUE/0R5QsfuM/CtfGdvfyKLm+hgFnyL2eLq/2LFlnmWkPodb7Lxv+Jq0C1HHzFTdgq
         ztsA/qvfpRT/1pqwY7jykN2aYqtw3nKgXj/NKezXEewFBs8sgk1WuE8qbB+WmgeeF4zP
         HuV7jzG+PgggBqQSY6R/kRPrCdLlH7YmhP9ZjhK7W7tB89KQJtBiGj2N3Im7QXpPxBye
         KmVoV/MAOBqCL/MUL0e7V27BGjM3ic7laoLdbdRlaeW74GXT8h0enjZ55x0ZHGafXCnY
         jUIkNlj6543hUyHz7gR4ByCLMjEs6ppVqRrHZpDTZviOtD86w/uNY2++q67qNfDYngl7
         6Niw==
X-Gm-Message-State: APjAAAVKvFhroHHNhoK1GiGb54RpeYUlOolRR1JFF8FH6vTlUtJfpR0u
        aFqZBsDahzTIaGY8emb4Qw==
X-Google-Smtp-Source: APXvYqy60NN9T4al6mcSVmrGPUUn1jbaxNJmyfs4sWpX/Ay69eg+v9LejHvFRrKdkcM4d/+6JhXx2A==
X-Received: by 2002:a02:c787:: with SMTP id n7mr19292465jao.91.1568978758189;
        Fri, 20 Sep 2019 04:25:58 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q74sm1308736iod.72.2019.09.20.04.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 04:25:57 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/9] pNFS: Ensure we do clear the return-on-close layout stateid on fatal errors
Date:   Fri, 20 Sep 2019 07:23:40 -0400
Message-Id: <20190920112348.69496-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920112348.69496-1-trond.myklebust@hammerspace.com>
References: <20190920112348.69496-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

IF the server rejected our layout return with a state error such as
NFS4ERR_BAD_STATEID, or even a stale inode error, then we do want
to clear out all the remaining layout segments and mark that stateid
as invalid.

Fixes: 1c5bd76d17cca ("pNFS: Enable layoutreturn operation for...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 4525d5acae38..0418b198edd3 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1449,10 +1449,15 @@ void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
 	const nfs4_stateid *res_stateid = NULL;
 	struct nfs4_xdr_opaque_data *ld_private = args->ld_private;
 
-	if (ret == 0) {
-		arg_stateid = &args->stateid;
+	switch (ret) {
+	case -NFS4ERR_NOMATCHING_LAYOUT:
+		break;
+	case 0:
 		if (res->lrs_present)
 			res_stateid = &res->stateid;
+		/* Fallthrough */
+	default:
+		arg_stateid = &args->stateid;
 	}
 	pnfs_layoutreturn_free_lsegs(lo, arg_stateid, &args->range,
 			res_stateid);
-- 
2.21.0

