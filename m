Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD9D5B42CE
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 23:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391730AbfIPVON (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 17:14:13 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:38242 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391727AbfIPVON (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 17:14:13 -0400
Received: by mail-io1-f48.google.com with SMTP id k5so2491854iol.5
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 14:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ggh0X7K6RiNd+ssWBMJ19hAXMZFj9oik6gRkgHkQxTI=;
        b=hpopZXUpD807gFBom7UbJ7Nmu9deaqqNXua0qGHElEPRUP0ZjBqIq3mmBYCw+XgWV3
         6Nvj0An0LRo5xhi5sgtz/zHwLXpIrIqCaqh7pVXXt3SzMN36a4NLn0RDwIrhbtf6UCGI
         2OHeYLQw4cmTUBt1gdqJDRWKUI7lTCYE6yIfrjlL+j7TZegdanW2Q4yYEkAoKbm8rFTV
         Wnzqv5wvLJQRWTepDrYH7Cij6MaaDcKN9XioBLEEg5c2ZMZnwanDJZMIkwBw5r3Jv9FJ
         hLxXNxdNG5bPIGu6U9SjHXx+r+PyHH41WceUZjHvvY3MfhZrx47l+0Xs1gVowSoZU5ES
         4omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ggh0X7K6RiNd+ssWBMJ19hAXMZFj9oik6gRkgHkQxTI=;
        b=RrM2K9Y2kw1+cFUnEsmcf8/ztdCNO2lhP63VUsRgCuYI52Y3Q5883yW8ch0rZvz0I2
         Jfcag1++82fytsfsTcNBsYZIKl81xPrmEJkwz9loie0JyMEqFajN8weWt/t+tGXNIWuY
         9BYpNX8hAvgapL9cMaCjbzFwGv5QgleO7QHD86mU8yjFazsXDYtKuobI4jzhVJ94VTtk
         /bWhxAt/SE+AIyWqrDbAA55VadBnZSrNNb+dh3YMAH5ZxXNcJw7woF2axPc84ZfXZoKJ
         lg0pVFUSd1cM+G0CH6+gEWSjVmGRn+WznL+Jr7zl06pxeHuBkFtdqRQSf9ZKOFCgssCp
         92Rw==
X-Gm-Message-State: APjAAAU9yXAoOtQwoOCdjwR2Xg0iikGE2YMboqHBc5WpE05T56PxHAUi
        OnTrcCRuCvknHe3xGHhNMzE=
X-Google-Smtp-Source: APXvYqzoeXakh6WPGR6rLAR46JtydFQr+n/yCEqrVlEGatN4pwx33Mu2oJludP1wuCp7Ov2e76+TjA==
X-Received: by 2002:a5d:9410:: with SMTP id v16mr403389ion.10.1568668451367;
        Mon, 16 Sep 2019 14:14:11 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l186sm71853ioa.54.2019.09.16.14.14.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 14:14:10 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 16/19] NFSD check stateids against copy stateids
Date:   Mon, 16 Sep 2019 17:13:50 -0400
Message-Id: <20190916211353.18802-17-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
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
index 857133f..062c0c4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4537,7 +4537,8 @@ static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4
 
 static __be32 lookup_clientid(clientid_t *clid,
 		struct nfsd4_compound_state *cstate,
-		struct nfsd_net *nn)
+		struct nfsd_net *nn,
+		bool sessions)
 {
 	struct nfs4_client *found;
 
@@ -4558,7 +4559,7 @@ static __be32 lookup_clientid(clientid_t *clid,
 	 */
 	WARN_ON_ONCE(cstate->session);
 	spin_lock(&nn->client_lock);
-	found = find_confirmed_client(clid, false, nn);
+	found = find_confirmed_client(clid, sessions, nn);
 	if (!found) {
 		spin_unlock(&nn->client_lock);
 		return nfserr_expired;
@@ -4591,7 +4592,7 @@ static __be32 lookup_clientid(clientid_t *clid,
 	if (open->op_file == NULL)
 		return nfserr_jukebox;
 
-	status = lookup_clientid(clientid, cstate, nn);
+	status = lookup_clientid(clientid, cstate, nn, false);
 	if (status)
 		return status;
 	clp = cstate->clp;
@@ -5180,7 +5181,7 @@ void nfsd4_cleanup_open_state(struct nfsd4_compound_state *cstate,
 
 	dprintk("process_renew(%08x/%08x): starting\n", 
 			clid->cl_boot, clid->cl_id);
-	status = lookup_clientid(clid, cstate, nn);
+	status = lookup_clientid(clid, cstate, nn, false);
 	if (status)
 		goto out;
 	clp = cstate->clp;
@@ -5582,7 +5583,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return nfserr_bad_stateid;
-	status = lookup_clientid(&stateid->si_opaque.so_clid, cstate, nn);
+	status = lookup_clientid(&stateid->si_opaque.so_clid, cstate, nn,
+				 false);
 	if (status == nfserr_stale_clientid) {
 		if (cstate->session)
 			return nfserr_bad_stateid;
@@ -5672,6 +5674,59 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
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
@@ -5709,6 +5764,8 @@ void nfs4_put_cpntf_state(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
 	status = nfsd4_lookup_stateid(cstate, stateid,
 				NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
 				&s, nn);
+	if (status == nfserr_bad_stateid)
+		status = find_cpntf_state(nn, stateid, &s);
 	if (status)
 		return status;
 	status = nfsd4_stid_check_stateid_generation(stateid, s,
@@ -6741,7 +6798,8 @@ static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct
 		 return nfserr_inval;
 
 	if (!nfsd4_has_session(cstate)) {
-		status = lookup_clientid(&lockt->lt_clientid, cstate, nn);
+		status = lookup_clientid(&lockt->lt_clientid, cstate, nn,
+					 false);
 		if (status)
 			goto out;
 	}
@@ -6925,7 +6983,7 @@ static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct
 	dprintk("nfsd4_release_lockowner clientid: (%08x/%08x):\n",
 		clid->cl_boot, clid->cl_id);
 
-	status = lookup_clientid(clid, cstate, nn);
+	status = lookup_clientid(clid, cstate, nn, false);
 	if (status)
 		return status;
 
@@ -7072,7 +7130,7 @@ struct nfs4_client_reclaim *
 	__be32 status;
 
 	/* find clientid in conf_id_hashtbl */
-	status = lookup_clientid(clid, cstate, nn);
+	status = lookup_clientid(clid, cstate, nn, false);
 	if (status)
 		return nfserr_reclaim_bad;
 
-- 
1.8.3.1

