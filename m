Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D1446885
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 22:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfFNUBC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 16:01:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39261 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfFNUBC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jun 2019 16:01:02 -0400
Received: by mail-io1-f66.google.com with SMTP id r185so2455450iod.6
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2019 13:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/VhgsWvCDw4c6qtohGYFG2ObzXStFMVFTZy7reffHlI=;
        b=AJ4nHJWlq8N03mDPjLHVhOLyVfk8+ldrM5tS0j6jJEBqb8xi3iPPfNGTgQ5lWHIiwU
         5J6i03oaigMfxwud2Cn5AF/1iEj8jmnOLNNhf0defVjDXBQ654HJOdstboGNvbAcuQbY
         3aGux1kkR58nK6+q6xC3CcItG+2Tq0U8XlFPkox2JYjPWws0YwtENvaOEE9Ci8FD130Z
         NapzS10zrUpezV9PHuY2nbmB57vsa51t+29YbJJOgd6EbZ7WOQvBjOMWWbmll9mxGPGY
         lQ8fTzYbQJo6WqEHvLn2+9E9LtZnIfF4IiOwLKwfE3urEOrNt28IgGEoRXKxuaGlZcQ5
         OeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/VhgsWvCDw4c6qtohGYFG2ObzXStFMVFTZy7reffHlI=;
        b=I+qFk/egfyRxLBmNUIgbdZeUUKGP3w/90qqLYmAAijRk2vU9hGchmgDqKdKleBPeWR
         YJhbiwejN7VE73MLOh6OqG0mDIJdAvjUbGV9/vJ5foYnjkhzp1d/CD3IofUjaDOef2co
         h8+dg1i+Cd4aFfo7YggiC0FwKz6AhQFTuJZwFLg+P7W/lHREaX/GH6RFfhMH2saTO1p8
         p0vd0nkA3kFoongd7HYWE2ZwgFpDwBC9cYZqSwjiYia7loG1TfM/qXhxz2n2crPY2k6L
         OGDUVmOPegyNc4CYE/ZDQCRpFNt5wk+fQ3yEwwjLpfZgBGtAqRqEwjPNzfKet0eVJJRE
         l8TQ==
X-Gm-Message-State: APjAAAWMcIHOsq2il88UhMdfj+EAk3bUCGN6SpRlLPZOpF08EaBZdubB
        kWzy1bpooI8KWbUDYRsMLzE=
X-Google-Smtp-Source: APXvYqyXRvNLwNsfHO5k0Rj3+WN9XeXVWh5m8D/N9hhJkySduHt02xbnRG3WI4rSsLNZ3/gwN/kKpw==
X-Received: by 2002:a6b:7311:: with SMTP id e17mr2437388ioh.112.1560542461872;
        Fri, 14 Jun 2019 13:01:01 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p4sm6528115iod.68.2019.06.14.13.01.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 13:01:01 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 6/8] NFSD generalize nfsd4_compound_state flag names
Date:   Fri, 14 Jun 2019 16:00:52 -0400
Message-Id: <20190614200054.12394-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190614200054.12394-1-olga.kornievskaia@gmail.com>
References: <20190614200054.12394-1-olga.kornievskaia@gmail.com>
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
index d151257..8263f08 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7464,7 +7464,8 @@ static int nfs4_state_create_net(struct net *net)
 static void
 get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
-	if (HAS_STATE_ID(cstate, CURRENT_STATE_ID_FLAG) && CURRENT_STATEID(stateid))
+	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
+	    CURRENT_STATEID(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
 
@@ -7473,14 +7474,14 @@ static int nfs4_state_create_net(struct net *net)
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

