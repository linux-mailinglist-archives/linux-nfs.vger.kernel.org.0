Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 243FF62942
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391647AbfGHTX4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:23:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:47056 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbfGHTXz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:23:55 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so37785006iol.13
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1DYhl4o2u4Qt+0cLmr6alwIbXlZunWsjLZGLHFbDjDQ=;
        b=AOXz4f7GVLDHMoI09FZzd6eaga+YYExapPd7Cg6cOsSxvzQiwuvbSVTEAAd3bqUK2r
         m+sdiSEaFxd4ngHYU0+nlgotVxqhUhzE1pOWvrQ1MVTwJELOUtTWTnhzalXDcAz+y7St
         /5KgNEaDq5TXzyWw+59F30u1WeRJ4sMqkBeKfCS8GU5zQWEXQVlEAFaNfpbC4TMcHSkA
         Fo2lhA55d//l3Rlx7ugPhv0c38zVp/gE8xnQHJ5Ca65LlL8Hl+q8y1mM1Lb/H3jD+u/Y
         YcU/J5IANVB0mx49Tomlw3CGRhKCpHLWdxQbBr6kXu/oHCqJGuch/Au6u8LnInueaCMs
         Bc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1DYhl4o2u4Qt+0cLmr6alwIbXlZunWsjLZGLHFbDjDQ=;
        b=IHuFSuQa0+rHeNOnYN/H2jTeNLYvBhYeVVYfU3T7XBbghEbEUgo+Z2RSy5SrbQtgjs
         8UKJytjEsXc+URyoiRjf69Nncb7KyksYyzRYwkINZQOxyxn34IkTM280lfL67lLpGG4c
         CPCc5gx9nhmcqNcw2l68Y80cWJL/0F+AOMZovnF8mCM6OvYixPRG3zUAklIuoyhCYlXq
         OQhCLERm0nPubga4bXTJTEdSmyYKFWZpZggY/MrlC9PrOM9u6s33caquBCJpBgvWQZXv
         7ZJIh8BeDgKf8LhMPgv6Iz27okzipAp16LkcT4MSwxGuv0/ZNzvhHS1hh0kP48KRPnrp
         OApw==
X-Gm-Message-State: APjAAAXpm9SAiZsiZ7oBwODoz0WFETLHLznPacTsKuvLgJgKtNgi5ij1
        pbnnU12AKhCj/Ama7hSjJ8U=
X-Google-Smtp-Source: APXvYqz7otUBYuLx6MMIxaPiZ4LJ2dDznIwYGZBLFTeDYQQqvNNJN/zHmu0Zfsv2I2xWY5LLH1vPZQ==
X-Received: by 2002:a6b:c9d8:: with SMTP id z207mr20061886iof.184.1562613835127;
        Mon, 08 Jul 2019 12:23:55 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v3sm9212841iom.53.2019.07.08.12.23.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:23:54 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 5/8] NFSD check stateids against copy stateids
Date:   Mon,  8 Jul 2019 15:23:49 -0400
Message-Id: <20190708192352.12614-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Incoming stateid (used by a READ) could be a saved copy stateid.
On first use make it active and check that the copy has started
within the allowable lease time.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4state.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2555eb9..b786625 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5232,6 +5232,49 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 
 	return 0;
 }
+/*
+ * A READ from an inter server to server COPY will have a
+ * copy stateid. Return the parent nfs4_stid.
+ */
+static __be32 _find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
+		     struct nfs4_cpntf_state **cps)
+{
+	struct nfs4_cpntf_state *state = NULL;
+
+	if (st->si_opaque.so_clid.cl_id != nn->s2s_cp_cl_id)
+		return nfserr_bad_stateid;
+	spin_lock(&nn->s2s_cp_lock);
+	state = idr_find(&nn->s2s_cp_stateids, st->si_opaque.so_id);
+	if (state)
+		refcount_inc(&state->cp_p_stid->sc_count);
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
+
+	status = _find_cpntf_state(nn, st, &cps);
+	if (status)
+		return status;
+
+	/* Did the inter server to server copy start in time? */
+	if (cps->cp_active == false && !time_after(cps->cp_timeout, jiffies)) {
+		nfs4_put_stid(cps->cp_p_stid);
+		return nfserr_partner_no_auth;
+	} else
+		cps->cp_active = true;
+
+	*stid = cps->cp_p_stid;
+
+	return nfs_ok;
+}
 
 /*
  * Checks for stateid operations
@@ -5264,6 +5307,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	status = nfsd4_lookup_stateid(cstate, stateid,
 				NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
 				&s, nn);
+	if (status == nfserr_bad_stateid)
+		status = find_cpntf_state(nn, stateid, &s);
 	if (status)
 		return status;
 	status = nfsd4_stid_check_stateid_generation(stateid, s,
-- 
1.8.3.1

