Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC0AB42CC
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 23:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391594AbfIPVON (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 17:14:13 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35221 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391726AbfIPVON (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 17:14:13 -0400
Received: by mail-io1-f68.google.com with SMTP id q10so2534013iop.2
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FkJA5NZVA3SfnZ9SpaIKC970zxZFIqt+2LS0HGfJkFM=;
        b=aGaEI/U846Un/LOj/dsdEYNaCz/YG7OimKyXrggszWFRGPYvJCfhXE3J6TxZXIIkDs
         ejKA55lRCvRPZz1h8J7cbhjrDuMteacFFz6Did424MxHMstCIU3eCxKhTxd1/1bDFYC+
         EeYXZDfyrUsATehCQgnW2mRMIf/R0WtYOs1qs5URFvOHOp/jn4eGVC1qPWWe8HWhM9gz
         5iFPM6LBn7mvOUoNANaO+7udl10J2Cnz6Rf47LDoxIAVVQJbfcLd2BoNuAXcJMS1x96W
         gSxiZP9KfW5SuocfuDq5odNCCG4u2f3IilnpFyp3CuM8GKNB6gbFCoSWLCljPyRttDtd
         d85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FkJA5NZVA3SfnZ9SpaIKC970zxZFIqt+2LS0HGfJkFM=;
        b=Vu8Gy/y0qBr14MdxZ7sBO6/FwjYnmk71oCsj2k1OweGyI2VJqYmfuprOc/9vwmFo7c
         AV0w/CJt8YwzSiUR1Q7SXPo/1e/pEvEIJXG6ISa5TRDp1Vzj/IH3fa5aSE31+mCLZg8D
         LaJ87c43+VxoH5th1khZrc4esUhf4ozvxdjlH2XnTL20DbuVvJnwcpgwagB8zzb6Wfsz
         wkWh9z8qQg0Ck7sJX7su992knTeTS6EypZ/bW21JQnvQjtpOLrDCpveWADJ/jBhH2Ha8
         H+jzG9psdYNR3VEAb8/HEMoZSGqVbGwTXTKFsFU+NA4ZPsr92lY8zFHumN9UJSxmRvoa
         qwgw==
X-Gm-Message-State: APjAAAUySV9gjINK4e4Zv8YqF1QGQr4TL7sK5yZNC8rJDmmSEGBYYMKS
        QdM2rTD6rm9tK79tC7iLvdw=
X-Google-Smtp-Source: APXvYqyALkxOyPSGHhdWe6O6OX0i+qahVpFmfm8FUyZQqk0t6C05wBAFKm8ubT0cVwjtpDW/l4h8oA==
X-Received: by 2002:a6b:ec16:: with SMTP id c22mr342384ioh.185.1568668452377;
        Mon, 16 Sep 2019 14:14:12 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l186sm71853ioa.54.2019.09.16.14.14.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 14:14:11 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 17/19] NFSD generalize nfsd4_compound_state flag names
Date:   Mon, 16 Sep 2019 17:13:51 -0400
Message-Id: <20190916211353.18802-18-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Allow for sid_flag field non-stateid use.

Signed-off-by: Andy Adamson <andros@netapp.com>
---
 fs/nfsd/nfs4proc.c  | 8 ++++----
 fs/nfsd/nfs4state.c | 7 ++++---
 fs/nfsd/xdr4.h      | 6 +++---
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 75ecdbd..90d0b67 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -531,9 +531,9 @@ static __be32 nfsd4_open_omfg(struct svc_rqst *rqstp, struct nfsd4_compound_stat
 		return nfserr_restorefh;
 
 	fh_dup2(&cstate->current_fh, &cstate->save_fh);
-	if (HAS_STATE_ID(cstate, SAVED_STATE_ID_FLAG)) {
+	if (HAS_CSTATE_FLAG(cstate, SAVED_STATE_ID_FLAG)) {
 		memcpy(&cstate->current_stateid, &cstate->save_stateid, sizeof(stateid_t));
-		SET_STATE_ID(cstate, CURRENT_STATE_ID_FLAG);
+		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
 	}
 	return nfs_ok;
 }
@@ -543,9 +543,9 @@ static __be32 nfsd4_open_omfg(struct svc_rqst *rqstp, struct nfsd4_compound_stat
 	     union nfsd4_op_u *u)
 {
 	fh_dup2(&cstate->save_fh, &cstate->current_fh);
-	if (HAS_STATE_ID(cstate, CURRENT_STATE_ID_FLAG)) {
+	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG)) {
 		memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid_t));
-		SET_STATE_ID(cstate, SAVED_STATE_ID_FLAG);
+		SET_CSTATE_FLAG(cstate, SAVED_STATE_ID_FLAG);
 	}
 	return nfs_ok;
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 062c0c4..81c52282 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7928,7 +7928,8 @@ static int nfs4_state_create_net(struct net *net)
 static void
 get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
-	if (HAS_STATE_ID(cstate, CURRENT_STATE_ID_FLAG) && CURRENT_STATEID(stateid))
+	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
+	    CURRENT_STATEID(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
 
@@ -7937,14 +7938,14 @@ static int nfs4_state_create_net(struct net *net)
 {
 	if (cstate->minorversion) {
 		memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
-		SET_STATE_ID(cstate, CURRENT_STATE_ID_FLAG);
+		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
 	}
 }
 
 void
 clear_current_stateid(struct nfsd4_compound_state *cstate)
 {
-	CLEAR_STATE_ID(cstate, CURRENT_STATE_ID_FLAG);
+	CLEAR_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
 }
 
 /*
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 2937e06..0b4fe07 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -46,9 +46,9 @@
 #define CURRENT_STATE_ID_FLAG (1<<0)
 #define SAVED_STATE_ID_FLAG (1<<1)
 
-#define SET_STATE_ID(c, f) ((c)->sid_flags |= (f))
-#define HAS_STATE_ID(c, f) ((c)->sid_flags & (f))
-#define CLEAR_STATE_ID(c, f) ((c)->sid_flags &= ~(f))
+#define SET_CSTATE_FLAG(c, f) ((c)->sid_flags |= (f))
+#define HAS_CSTATE_FLAG(c, f) ((c)->sid_flags & (f))
+#define CLEAR_CSTATE_FLAG(c, f) ((c)->sid_flags &= ~(f))
 
 struct nfsd4_compound_state {
 	struct svc_fh		current_fh;
-- 
1.8.3.1

