Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49101AC33E
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2019 01:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393177AbfIFXgd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 19:36:33 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:45940 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393168AbfIFXgc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 19:36:32 -0400
Received: by mail-io1-f47.google.com with SMTP id f12so16551187iog.12
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 16:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DJyZDyZ9ERtk6rz9n8ZUInKIULgRz6K+YD/DDWBpWaU=;
        b=aHj0CU0Gg118mdoaTMyekbGl1c0KqPNeUMFqdL8aF1o1Blp2Yr79eGk/bIsCsIVFDR
         jzEcbOcU3ExCJnwd689nQ97ksBD4eZyjqUCA0xWG5Bp7pMYBoEElN9BLJ0IBIigjYsTx
         FY+sZ5LBYiPBVdC0c44haijffL0QCxYuAsuMqMOzpuKmLi1toX1Sw5meETW/I4xj2AsG
         JxIfrOke2b5B2LOtj3aA74rF0zfb+cAwaBDLmoiloFqotE1YSnLXlh4O6uUpdHPeHumu
         LhwyLdn1mccQrhIlwi4SFoYEVUjb8nV2U9OkHa4K274dEIhbDh4N4tstwCL1aq9QnnhN
         qZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DJyZDyZ9ERtk6rz9n8ZUInKIULgRz6K+YD/DDWBpWaU=;
        b=h/tLCFhGLeJPkKzi86uPZ4wwId+kGwjvUHYEEIMc7iVyIMNf2fs7RlDNrqQnxDhCgV
         YJWcsKruSm2/OsjpCvOHcNLU30GMn67+bBJZw73zK7rBZO76pxXuG3ZX7HCWzFP7WB9J
         gIO7X0X3sdOhAjZ2ZyDua2cJpAKPKc9krlTy/7ttqlIKSVWbWkpjeDxwaTCIjha4988h
         ENLvEo1i7Ov6VmStyrJYtS15bR9wAyxT/5Pd6JRABPDXNAHghEMBpRhw1bCdqfEepvP3
         eVw+v2exn8ESaZbF8nfmiF66RG3ysKfnhdPK3TFIvBA9nu6Yk4y9Rkt+fQppmUSRcQQw
         gxxA==
X-Gm-Message-State: APjAAAU9t7bJnhGNJ3ygReUvmiUpF+2uX9zy3XOMivY/1k5RZaLT4Bdm
        xVoq8TIWWVjP25YU/BiDjZE=
X-Google-Smtp-Source: APXvYqx7uRhV6a5Wczq2OuvfXrgz+hCYq2492fYDOR00hDDj4jPRP2PWWuFIiGVrC6F+uFq7AIjZ3g==
X-Received: by 2002:a5e:9b12:: with SMTP id j18mr13037360iok.54.1567812991974;
        Fri, 06 Sep 2019 16:36:31 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r138sm10439360iod.59.2019.09.06.16.36.31
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:36:31 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 19/21] NFSD generalize nfsd4_compound_state flag names
Date:   Fri,  6 Sep 2019 19:36:09 -0400
Message-Id: <20190906233611.4031-20-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
References: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
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
index e220c43bbc25..c38a0ef2ee75 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -531,9 +531,9 @@ nfsd4_restorefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -543,9 +543,9 @@ nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
index 1bce9d6245db..b3c106878afd 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7925,7 +7925,8 @@ nfs4_state_shutdown(void)
 static void
 get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
-	if (HAS_STATE_ID(cstate, CURRENT_STATE_ID_FLAG) && CURRENT_STATEID(stateid))
+	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
+	    CURRENT_STATEID(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
 
@@ -7934,14 +7935,14 @@ put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
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
index c6c8b4337cfa..687f81ddce6b 100644
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
2.18.1

