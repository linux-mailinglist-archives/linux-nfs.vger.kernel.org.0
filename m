Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED893AC0D0
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 21:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392364AbfIFTqy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 15:46:54 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:40287 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393209AbfIFTqx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 15:46:53 -0400
Received: by mail-io1-f43.google.com with SMTP id h144so15382560iof.7
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XqllJiCq3cCmwUoY54G0UqLI2GuOcXJI7qJi9mxJt1Y=;
        b=qIexWDcvP6tiNjznk5C8mJnGRl3SjmWAJ0UopQYXsgru172JaULB+B146cYx+k8O+H
         vIRuSTmk98E+SxR9yz1cXC5EvMS2qFW7gdzgTLRJ3+jUWOkO1he9UJ6AdtlrJxbBU2/e
         471JNan6OajvcgfNATLQCg09bFyAVEbO6CikQtUnEfTgcU/iEhUA4FfSwH85B/SzJZ3X
         W8QrRWpHXkBwDcdHAWzZhS9NYKaNDGjoQ8sRf/Cd5ZoFxhKVppLMHPG8gZeoqYwi90Ph
         ovNNaJtyw5vHFrBqxV8ux4m4OeW7mSedMN28ES6ztNkdmLk5fPdFIZaobQnWDqfhmGQS
         N5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XqllJiCq3cCmwUoY54G0UqLI2GuOcXJI7qJi9mxJt1Y=;
        b=SHT/B8o9M07Xln997jSEcWhE3olsqlweOF8XVkH/skIAUDOH1LOR+/De/A4eeY9q6r
         fySK5m6qhLNTBEu3etMFuPPu4klCowtDW32Ls5vZRk/d9QWfW2t0WoOINTGrqqWUcclq
         RirZ6c1sVGiOfS+HX9bo5QnyIWS5puSx4kL2fX/YxeOhIPOqjHeeGMyE4jW6MDA4HjMk
         WjFOgp5zpwaPhU4pASl7L7brf2nqfWBlnSwPrKmzQpA81oOmheGrofRrPgV5liU5NLLL
         4fIfGN+IJNbogBMdTAJAc6DMW0MuYYogHJCPGonTDmIDeHB9ncNKSUUClx6sgDmE9KVA
         J5lQ==
X-Gm-Message-State: APjAAAX0s2rBrrTqC7OQi5Qf2HmkqqDyGoUwjVlXghk8bJgd9B1tgRG8
        I77gumuKhel5aL8IJCkY/Xk=
X-Google-Smtp-Source: APXvYqyD1Yp6CA8JgruJizixFJtnTYt1HqtLEekxC/OM5aeme+cpHGhnQeXED/F/Ef0ZC+usIabdeQ==
X-Received: by 2002:a05:6602:259a:: with SMTP id p26mr11842118ioo.65.1567799212653;
        Fri, 06 Sep 2019 12:46:52 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id i14sm5118085ioi.47.2019.09.06.12.46.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 12:46:52 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 17/19] NFSD generalize nfsd4_compound_state flag names
Date:   Fri,  6 Sep 2019 15:46:29 -0400
Message-Id: <20190906194631.3216-18-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
References: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
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
index e220c43..c38a0ef 100644
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
index 1bce9d6..b3c1068 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7925,7 +7925,8 @@ static int nfs4_state_create_net(struct net *net)
 static void
 get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
-	if (HAS_STATE_ID(cstate, CURRENT_STATE_ID_FLAG) && CURRENT_STATEID(stateid))
+	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
+	    CURRENT_STATEID(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
 
@@ -7934,14 +7935,14 @@ static int nfs4_state_create_net(struct net *net)
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

