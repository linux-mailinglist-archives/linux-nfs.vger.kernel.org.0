Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72147AC0CF
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 21:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393173AbfIFTqx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 15:46:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46841 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392364AbfIFTqx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 15:46:53 -0400
Received: by mail-io1-f67.google.com with SMTP id x4so15341525iog.13
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 12:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lVGTrlWs/L4QetDhL2+g8xf8K9u7vUZMRANa1taGawM=;
        b=InG6o2HFORk8g0ANQpFRUkCJrs7oi5L0rJS/SvvR7mCR/y1JXKmC73OJfqbVbco/pr
         UolV65jZB0F8eiZgpOkOCWX9ADuKN40RogipunX08sFGeyEvZdV8i3rkgnLMCe6jlvyn
         uKIysnZBkYcerVRsH4aZ1iQJdOuawzSBl6DXP8Xrvn1E/xUtybfgVQ73Qt3qJUFX5/w5
         cJFb6h7C1twuaoWINnAoLKYNyJyJpWNZocbnl6Nc2H5/wXswdJjQJ9ou1AOx7Ewzm5XM
         Bm9SWR8+2RUmv9guOATAEOdUax0R/4BbxzT2GJnyko07DS9qVOezR4EJHHDvh7uutw4X
         OElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lVGTrlWs/L4QetDhL2+g8xf8K9u7vUZMRANa1taGawM=;
        b=N1d08DvslpkXrPQGwJoYXMplveuRA7xPYrUMqb7VHIWk5lZLevkj0DuhrbUQeU1HuF
         nopH3Hmdui2NmxLdyWJbbni9mbB9PzevbyIaCjZs6gX/6jYwnyY3M7BXgzVxD/NtBUXp
         EFAwZgQRX52YcsF0u9pFJ42nlKfL1bUmCgvAGsLfmOkrCcMYEde5tS68YZM3DwMpgsmr
         4mcEniHKIQ+mSqI7q+jOjtuvxMCFo55tkgs6gUanrWzvfTPM6KlmP9m67txWXJCEizWY
         tqDJTKU6Q6FfG5tPDjDZgDKAqn1lLD67sN42f+aMiFL5+GE1k0uKHgpfQgc5Maw8HoHw
         +pJw==
X-Gm-Message-State: APjAAAW48uDKyr0iGKLHuKA4lHFFpshAvPd6r+j/mejwOPZ2+8/bmT4q
        k5d0E+SjdLEghCUwAFLXyEg=
X-Google-Smtp-Source: APXvYqyltziu4w8XJe9fCvIg4en0094vh/pStrS4ym5+VinxUj8SXQz3MQPBM90aWvp5i95tMmtUbg==
X-Received: by 2002:a02:6616:: with SMTP id k22mr11618576jac.129.1567799211589;
        Fri, 06 Sep 2019 12:46:51 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id i14sm5118085ioi.47.2019.09.06.12.46.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 12:46:51 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 16/19] NFSD check stateids against copy stateids
Date:   Fri,  6 Sep 2019 15:46:28 -0400
Message-Id: <20190906194631.3216-17-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
References: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
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
index a6405c7..1bce9d6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4532,7 +4532,8 @@ static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4
 
 static __be32 lookup_clientid(clientid_t *clid,
 		struct nfsd4_compound_state *cstate,
-		struct nfsd_net *nn)
+		struct nfsd_net *nn,
+		bool sessions)
 {
 	struct nfs4_client *found;
 
@@ -4553,7 +4554,7 @@ static __be32 lookup_clientid(clientid_t *clid,
 	 */
 	WARN_ON_ONCE(cstate->session);
 	spin_lock(&nn->client_lock);
-	found = find_confirmed_client(clid, false, nn);
+	found = find_confirmed_client(clid, sessions, nn);
 	if (!found) {
 		spin_unlock(&nn->client_lock);
 		return nfserr_expired;
@@ -4586,7 +4587,7 @@ static __be32 lookup_clientid(clientid_t *clid,
 	if (open->op_file == NULL)
 		return nfserr_jukebox;
 
-	status = lookup_clientid(clientid, cstate, nn);
+	status = lookup_clientid(clientid, cstate, nn, false);
 	if (status)
 		return status;
 	clp = cstate->clp;
@@ -5175,7 +5176,7 @@ void nfsd4_cleanup_open_state(struct nfsd4_compound_state *cstate,
 
 	dprintk("process_renew(%08x/%08x): starting\n", 
 			clid->cl_boot, clid->cl_id);
-	status = lookup_clientid(clid, cstate, nn);
+	status = lookup_clientid(clid, cstate, nn, false);
 	if (status)
 		goto out;
 	clp = cstate->clp;
@@ -5577,7 +5578,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return nfserr_bad_stateid;
-	status = lookup_clientid(&stateid->si_opaque.so_clid, cstate, nn);
+	status = lookup_clientid(&stateid->si_opaque.so_clid, cstate, nn,
+				 false);
 	if (status == nfserr_stale_clientid) {
 		if (cstate->session)
 			return nfserr_bad_stateid;
@@ -5671,6 +5673,59 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
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
@@ -5710,6 +5765,8 @@ void nfs4_put_cpntf_state(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
 	status = nfsd4_lookup_stateid(cstate, stateid,
 				NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
 				&s, nn);
+	if (status == nfserr_bad_stateid)
+		status = find_cpntf_state(nn, stateid, &s);
 	if (status)
 		return status;
 	status = nfsd4_stid_check_stateid_generation(stateid, s,
@@ -6742,7 +6799,8 @@ static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct
 		 return nfserr_inval;
 
 	if (!nfsd4_has_session(cstate)) {
-		status = lookup_clientid(&lockt->lt_clientid, cstate, nn);
+		status = lookup_clientid(&lockt->lt_clientid, cstate, nn,
+					 false);
 		if (status)
 			goto out;
 	}
@@ -6926,7 +6984,7 @@ static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct
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

