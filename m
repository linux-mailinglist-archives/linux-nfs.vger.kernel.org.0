Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4FF62943
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391646AbfGHTX5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:23:57 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:42134 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbfGHTX4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:23:56 -0400
Received: by mail-io1-f46.google.com with SMTP id u19so37818080ior.9
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VBSbGO+lScidIvOtah0lpAqaf38piEyOCBDn6NrMdtI=;
        b=rKRZ4hhRE7g2R/LpfQkAiyiWEj/VO+miG9pZ1dYCE45FIgWoOvUq+YogvBU8NNy/H+
         jn8pS34UhUNBFUP12AA8KmppKYTxOHIDBIH2s53Ogq3GiklGW5Eyh9D1TLIzWT2RMlRT
         PVWiKLljlpNPqrQIzLfQEI7DYCshftN6Om1rx8R1mXx+iVIgnTzkdmgTF6oi86sgjhqc
         1ygIc4JhSpCM2GbsLLLVGmA5Jw8iDLoeSJ6USkQ02tnkhwPo7wcYmt8daLePBnOeYh3X
         egbkFLig819cG2188htHfY3cxumNFQB8gB+VRhI+2L2/5jjW3stI4uBTdOiBCLrbRpPL
         HjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VBSbGO+lScidIvOtah0lpAqaf38piEyOCBDn6NrMdtI=;
        b=fxdUz/Ed7LXrYGSlJ7GF9ufsfhUQtK5Qz7asVDzClO84BLn3Mp777DqqHIuGIKk1cE
         PieC+Vvr21soYGhrcOxah3toIGjfgI/OlTlPIuollSYDLp6AseaozK42RH2OYzkKaSoS
         nnqJ1pqQuFUSYC4xb2f4RjFsKxmpNmbbT0ifyX4Hq9KlGEhapc+tSgMwoLg3qb6EPJXx
         c5Mzqk1wfS823j557sAOxYfSWRKqGo6UMGDbkRc177BjrQCRbQjCejZBKhrqLhhUTtMZ
         xJTDspzIb6XpKLXsrAxqT6Oek/F5kQmyb7EhsIhCZ9CKVWrMDJ7XqTZSupzZenM6BcFr
         UCZg==
X-Gm-Message-State: APjAAAWEXykuTB3MG4LUvUB0Eu4y9dn3Ozv/pWJhLkgin5QbyH8KUzu2
        WIpdM05fbwz7XZitMdIm+pA=
X-Google-Smtp-Source: APXvYqwuRgUMlt/5QebFu2DGdiMaefZSh/u4X/w19eoJTPPGC6BDv/7uxz8iz2neAvRj8ZACm2MSmg==
X-Received: by 2002:a5e:8913:: with SMTP id k19mr3699980ioj.155.1562613836149;
        Mon, 08 Jul 2019 12:23:56 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v3sm9212841iom.53.2019.07.08.12.23.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:23:55 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 6/8] NFSD generalize nfsd4_compound_state flag names
Date:   Mon,  8 Jul 2019 15:23:50 -0400
Message-Id: <20190708192352.12614-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
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
index c39fa72..8c2273e 100644
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
index b786625..d7f4b96 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7466,7 +7466,8 @@ static int nfs4_state_create_net(struct net *net)
 static void
 get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
-	if (HAS_STATE_ID(cstate, CURRENT_STATE_ID_FLAG) && CURRENT_STATEID(stateid))
+	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
+	    CURRENT_STATEID(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
 
@@ -7475,14 +7476,14 @@ static int nfs4_state_create_net(struct net *net)
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
index bade8e5..9d7318c 100644
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

