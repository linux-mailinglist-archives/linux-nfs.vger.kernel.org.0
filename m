Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A42D29EB
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 14:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387870AbfJJMrG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 08:47:06 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:38027 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387594AbfJJMrG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Oct 2019 08:47:06 -0400
Received: by mail-io1-f52.google.com with SMTP id u8so13328952iom.5
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 05:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vYUW9IXrqpkv9hIRguedc0baL1AlyP7Y6THvHazRWcw=;
        b=rZtdSS+CVQtS4XuzlJXhqZ9QxQAJuGLgsuxZmw3YmVHvBxAGPRffBh/qHlSGhppS2o
         LSLZi2O6gS0iAbo2MMe5dSe1LyJ3eHp629pBArHROvwGj7ibwGu0adios7G74xB/8XjP
         x1QOr0bjIn3G2iTQr9/O07iw2Q/r2jHvOO+BAZrl5J5Q1ffeYUFdPTqyc6GijuBDVU5F
         s+9J2QfUjCJoyx0aedk6dJ+2CGffVGZ0wHGYOR74kbPCSdoINtqYulfrmeeqRnXtpSgD
         tgp97dvIqfPCVHh1GFU+r+LYrVM0R7UyXltTuRyv2DvfLUBkaEWhi2h9MgLOm2qze5ma
         UBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vYUW9IXrqpkv9hIRguedc0baL1AlyP7Y6THvHazRWcw=;
        b=AusDyp/fv2h5kN8+UWEpJwm7w7wnGptUtga8ooEjhoToe+DTj/RnRVe1VpVlQewUez
         1FwBiPScNPV7fukHmkutQLkbXl0voS//366l9Koh5y9VPIE1M0AHTljbkQAd99OgZjQr
         uR9NupLzatdPEolqEVOxBsxP3e+eTBByOBCKR1ZgpUXldvtBUXbeOArF0IjbjzTLimt/
         L5UKX7c8xGTzFRIbFe3s/E8UmLd5vt98fDG9zn/ksg9+bJlLjKksDVvfjINf6GCTaI89
         AYNM7ZcmmpEGoTJIyRF+5V3fPwYs159OaQ3aHzXXHBsWcP0o43PIeDMJAUlCDkD5rq5+
         INGw==
X-Gm-Message-State: APjAAAUcA7ZUB+atVztoaT+ffJBVMnsGDvcvNgEkn8QxRVSpeFT1axQj
        2iEMmoBsDOZw8wHK+UPujJo=
X-Google-Smtp-Source: APXvYqxtT72mvrQjbMWQgcLTbLNo+U3dkVGfuDqLZdYZvQDwcji43JmeoEk5g4x2ACZPHJMyuXuQkA==
X-Received: by 2002:a6b:f90f:: with SMTP id j15mr9151821iog.257.1570711625371;
        Thu, 10 Oct 2019 05:47:05 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r2sm1100930ilm.17.2019.10.10.05.47.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Oct 2019 05:47:04 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 17/20] NFSD check stateids against copy stateids
Date:   Thu, 10 Oct 2019 08:46:19 -0400
Message-Id: <20191010124622.27812-18-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
References: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Incoming stateid (used by a READ) could be a saved copy stateid.
Using the provided stateid, look it up in the list of copy_notify
stateids. If found, use the parent's stateid and parent's clid
to look up the parent's stid to do the appropriate checks.

Update the copy notify timestamp (cpntf_time) with current time
this making it 'active' so that laundromat thread will not delete
copy notify state.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4state.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b7859b6..f0942bd 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4534,7 +4534,8 @@ static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4
 
 static __be32 lookup_clientid(clientid_t *clid,
 		struct nfsd4_compound_state *cstate,
-		struct nfsd_net *nn)
+		struct nfsd_net *nn,
+		bool sessions)
 {
 	struct nfs4_client *found;
 
@@ -4555,7 +4556,7 @@ static __be32 lookup_clientid(clientid_t *clid,
 	 */
 	WARN_ON_ONCE(cstate->session);
 	spin_lock(&nn->client_lock);
-	found = find_confirmed_client(clid, false, nn);
+	found = find_confirmed_client(clid, sessions, nn);
 	if (!found) {
 		spin_unlock(&nn->client_lock);
 		return nfserr_expired;
@@ -4588,7 +4589,7 @@ static __be32 lookup_clientid(clientid_t *clid,
 	if (open->op_file == NULL)
 		return nfserr_jukebox;
 
-	status = lookup_clientid(clientid, cstate, nn);
+	status = lookup_clientid(clientid, cstate, nn, false);
 	if (status)
 		return status;
 	clp = cstate->clp;
@@ -5177,7 +5178,7 @@ void nfsd4_cleanup_open_state(struct nfsd4_compound_state *cstate,
 
 	dprintk("process_renew(%08x/%08x): starting\n", 
 			clid->cl_boot, clid->cl_id);
-	status = lookup_clientid(clid, cstate, nn);
+	status = lookup_clientid(clid, cstate, nn, false);
 	if (status)
 		goto out;
 	clp = cstate->clp;
@@ -5579,7 +5580,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return nfserr_bad_stateid;
-	status = lookup_clientid(&stateid->si_opaque.so_clid, cstate, nn);
+	status = lookup_clientid(&stateid->si_opaque.so_clid, cstate, nn,
+				 false);
 	if (status == nfserr_stale_clientid) {
 		if (cstate->session)
 			return nfserr_bad_stateid;
@@ -5669,6 +5671,59 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 		   cps->cp_stateid.stid.si_opaque.so_id);
 	kfree(cps);
 }
+/*
+ * A READ from an inter server to server COPY will have a
+ * copy stateid. Look up the copy notify stateid from the
+ * idr structure and take a reference on it.
+ */
+static __be32 _find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
+		     struct nfs4_cpntf_state **cps)
+{
+	copy_stateid_t *cps_t;
+	struct nfs4_cpntf_state *state = NULL;
+
+	if (st->si_opaque.so_clid.cl_id != nn->s2s_cp_cl_id)
+		return nfserr_bad_stateid;
+	spin_lock(&nn->s2s_cp_lock);
+	cps_t = idr_find(&nn->s2s_cp_stateids, st->si_opaque.so_id);
+	if (cps_t) {
+		state = container_of(cps_t, struct nfs4_cpntf_state,
+				     cp_stateid);
+		if (state->cp_stateid.sc_type != NFS4_COPYNOTIFY_STID)
+			return nfserr_bad_stateid;
+		refcount_inc(&state->cp_stateid.sc_count);
+	}
+	spin_unlock(&nn->s2s_cp_lock);
+	if (!state)
+		return nfserr_bad_stateid;
+	*cps = state;
+	return 0;
+}
+
+static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
+			       struct nfs4_stid **stid)
+{
+	__be32 status;
+	struct nfs4_cpntf_state *cps = NULL;
+	struct nfsd4_compound_state cstate;
+
+	status = _find_cpntf_state(nn, st, &cps);
+	if (status)
+		return status;
+
+	cps->cpntf_time = get_seconds();
+	memset(&cstate, 0, sizeof(cstate));
+	status = lookup_clientid(&cps->cp_p_clid, &cstate, nn, true);
+	if (status)
+		goto out;
+	status = nfsd4_lookup_stateid(&cstate, &cps->cp_p_stateid,
+				NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
+				stid, nn);
+	put_client_renew(cstate.clp);
+out:
+	nfs4_put_cpntf_state(nn, cps);
+	return status;
+}
 
 void nfs4_put_cpntf_state(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
 {
@@ -5706,6 +5761,8 @@ void nfs4_put_cpntf_state(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
 	status = nfsd4_lookup_stateid(cstate, stateid,
 				NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
 				&s, nn);
+	if (status == nfserr_bad_stateid)
+		status = find_cpntf_state(nn, stateid, &s);
 	if (status)
 		return status;
 	status = nfsd4_stid_check_stateid_generation(stateid, s,
@@ -6738,7 +6795,8 @@ static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct
 		 return nfserr_inval;
 
 	if (!nfsd4_has_session(cstate)) {
-		status = lookup_clientid(&lockt->lt_clientid, cstate, nn);
+		status = lookup_clientid(&lockt->lt_clientid, cstate, nn,
+					 false);
 		if (status)
 			goto out;
 	}
@@ -6922,7 +6980,7 @@ static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct
 	dprintk("nfsd4_release_lockowner clientid: (%08x/%08x):\n",
 		clid->cl_boot, clid->cl_id);
 
-	status = lookup_clientid(clid, cstate, nn);
+	status = lookup_clientid(clid, cstate, nn, false);
 	if (status)
 		return status;
 
@@ -7069,7 +7127,7 @@ struct nfs4_client_reclaim *
 	__be32 status;
 
 	/* find clientid in conf_id_hashtbl */
-	status = lookup_clientid(clid, cstate, nn);
+	status = lookup_clientid(clid, cstate, nn, false);
 	if (status)
 		return nfserr_reclaim_bad;
 
-- 
1.8.3.1

