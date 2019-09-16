Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E99B423F
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 22:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfIPUq3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 16:46:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37380 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733156AbfIPUq3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 16:46:29 -0400
Received: by mail-io1-f68.google.com with SMTP id b19so2341787iob.4
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+xAWTrh/Lsv4sQba0rlaTvUNAip8h2KHmmPmv3mJ88=;
        b=H/y+KzrcAVu4Qc8SRgF0TYfxefcCwUAPGrFLdQ/DjbtdfTAtKaRqdijbI4YoH328Yi
         UEjsWrgg62m6WShjxyKhkxK3E06M08Xhwf8eDMKx6RIeLBdV70TJHd+hfBNZILVJgYAq
         WMojnVcs2MWYMJCPfqPOVqH13oxffNryw/N0G1KF0Dhtvp6dYeErU+u4c3kQcBdWYd3q
         kpMT6XwjZmP6L2GXHQ/ZbiUHzAAYHLYtY/I1bbW8bdTGu3GBEL+fGqiWSzEQx8xsaAw+
         dM5CVyl0Oayz/7kPt1Q7dMh3FHpsso0NjHDee8s4j3LwGUuSM/2kTX0mWD4QgJA4IQG6
         0W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+xAWTrh/Lsv4sQba0rlaTvUNAip8h2KHmmPmv3mJ88=;
        b=rO3SCORPVa5VyfIFvsBZQhsNdGvwle5hIGjOu71OF8nWtAkTT7+B+sEGOQrCKuiZTK
         h2plJchJmV8B0LfypQ0qanQ6pHFYAafoJTyFcpPCJf+KEgNNTwxzLVbkoNW9hjQaWKW/
         FZDt6yWLyH8wIsgLgQCpAXaCfj0y3YfqK+oltrAktlpzHBn1RuWOycF0Fdh4i35QRADN
         b3c+NaEdaO58HlS127+pK90EfM8okBgGIlvnxAtICFIUawzg0cvB2E8is7kBumks09VF
         rGoLqi/ryjDbA3hD3Dq8PvnJBqmuWT6bBe8n7sAqwQlLxdH+HXwiraDEKzdF3VHJLIi3
         cWaA==
X-Gm-Message-State: APjAAAUwZGIYKDhni4e14Yfl7hfLytvshtIQHFEHIzEKMEyh2mNzxz1c
        5ssOH4hbC+FQR9FwHCkzdA==
X-Google-Smtp-Source: APXvYqzvV71DKHmIU7Ns1BbkO99NQpPpiOVUfzlKX/0m6DYa298aadnCRKSN5qAdsf9z7bYMp1NTCw==
X-Received: by 2002:a6b:f311:: with SMTP id m17mr280679ioh.0.1568666788118;
        Mon, 16 Sep 2019 13:46:28 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id c6sm3528iom.34.2019.09.16.13.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:46:27 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/9] pNFS: Ensure we do clear the return-on-close layout stateid on fatal errors
Date:   Mon, 16 Sep 2019 16:44:11 -0400
Message-Id: <20190916204419.21717-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
References: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
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

