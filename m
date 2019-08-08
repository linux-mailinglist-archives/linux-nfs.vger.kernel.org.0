Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE2E386B4A
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2019 22:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404686AbfHHUS6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Aug 2019 16:18:58 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:45128 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404689AbfHHUS5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Aug 2019 16:18:57 -0400
Received: by mail-ot1-f54.google.com with SMTP id x21so30525054otq.12
        for <linux-nfs@vger.kernel.org>; Thu, 08 Aug 2019 13:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ckHldEI1R+gFQe6K9V1FcaieFYOzIFEfgY5wB9rno0=;
        b=pdaT/H3Fq0VNoT3pqzFw0+XvLxM2xN6ji4CCXbHMHG54rpA7AiFqDM9FIr6hsBrAup
         SDV2F3dEf3yJl4QNOGi/a62a/0LpJenzfOHTRkc9JO5/3+V8n2Vc4JVEwWMMySarGeQy
         zyfUBIrzy6bxPzOLacmzUzs5lPwkwUtyZCVQX48YJ+RzRjPdj0DaRTZILDi1PYc9Ov02
         oIGQCHHQm275s4zn+gSXjhSrDFceWTTlCuxV3zSB68/n+NUaagPiqFZKk2DJpkf81RvG
         ++rWtKYyz/vd+ScTWmdChH2hdQJYb/2Lqre2KDmX7wFF4PbSltLdDX5lLyc1YrOlPnI8
         tddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ckHldEI1R+gFQe6K9V1FcaieFYOzIFEfgY5wB9rno0=;
        b=tkh2ep9+nQZd12UOcQFYTaGQc4j/IvtAZ0bNWOb1/7QGMu7L2qoDzL10elrXyZ5aIr
         EfXkez3NukxexDiT/a+By1f9C0vli/awNW3GDOqcZQvqy+h3vQfhFEDFtAPQFmSE7MhD
         MAd9d5Up01jCL8PVwHiFzzSCvXszcs5D0/qOWxgdGSlNxeKWMiPnr5lJUsrWWAYBLQAE
         VBQcVnNV5SpySdWz3vjv7r3OJrrnuMcINuS/m1cyDjOuUn5pmyryI3XZD1lN3dcmtCWZ
         ocgUjxNE6504vlaTV/JyMGyFDtToLTWxQhipvYMRACknJMlGlpyMCsHdlm/VcXraMM6R
         QOFQ==
X-Gm-Message-State: APjAAAVL8pu91MVYxG/YO3UvRrosG4fGlIGJMVXLPuQ1t023RoSrF9aR
        cA7j23K6hCI+FnK6bMeBiXg=
X-Google-Smtp-Source: APXvYqyVKuAJDE9IPKCfIiOzMxaoFmBzZHfV4FvGNEDi3gw5Z0b49nxRI/TGTJigLQSEscEF0iNyLQ==
X-Received: by 2002:a02:810:: with SMTP id 16mr11649731jac.121.1565295537117;
        Thu, 08 Aug 2019 13:18:57 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id m20sm93590523ioh.4.2019.08.08.13.18.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 13:18:56 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 7/9] NFSD generalize nfsd4_compound_state flag names
Date:   Thu,  8 Aug 2019 16:18:46 -0400
Message-Id: <20190808201848.36640-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
References: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
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
index 47f6b52..ef961f1 100644
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
index 31a32ec..85d00b2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7900,7 +7900,8 @@ static int nfs4_state_create_net(struct net *net)
 static void
 get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
-	if (HAS_STATE_ID(cstate, CURRENT_STATE_ID_FLAG) && CURRENT_STATEID(stateid))
+	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
+	    CURRENT_STATEID(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
 
@@ -7909,14 +7910,14 @@ static int nfs4_state_create_net(struct net *net)
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
index c6c8b43..687f81d 100644
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

