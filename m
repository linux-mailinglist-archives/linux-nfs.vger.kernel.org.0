Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0B986B48
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2019 22:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404538AbfHHUS5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Aug 2019 16:18:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35875 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404689AbfHHUS5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Aug 2019 16:18:57 -0400
Received: by mail-ot1-f65.google.com with SMTP id r6so123775145oti.3
        for <linux-nfs@vger.kernel.org>; Thu, 08 Aug 2019 13:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=08CA8KVqXGnCPxyeJ+Uig0RqEG+TU4i4fiAvDA7C6Wc=;
        b=Om52ygJ3lY+S/DnJWL+dhf6+cuGtSnb7YZVTHJ5eY220s26Gjao0BH/7VfGBv7RDmc
         nFVa6KxcQUnppFoq9OtNKlpSVNZcG1p8NF0kwwOoy6ERYzsR/VU9UHlPClYA0uuirD7h
         q2xaZ6vRC9tIpySD8mZXdq6iHYc2r8cp7KnVMGt3NV2dbJPZnCPp4UzREJbqYePo4lva
         hXDbLguE//15cFdakg83areDRc3TipSnJFTv1crZtXc0QLCVE52LNXCzx6TJDf3owjOu
         qhwGNsnObA/mgn5rqxN+wtwlrpnhqQq2220AcZURfNtK+ZCeOAPXKADU4WSJxQQB5mRe
         VPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=08CA8KVqXGnCPxyeJ+Uig0RqEG+TU4i4fiAvDA7C6Wc=;
        b=Uw8qzTVHgJ71dhUPsrMoX2+KrfiHinru750oHv00fywjKtC5jdLO/NRiTjPwcWbEj2
         ALzONwTgnTI+UnhCKLHCObWCJZS1o9z640P+Wq5KZZav99xgc6yC+meRjpcYheY97Ola
         RERCq/XJDi2TPwGFb+ECd97jKPeOJ5IpDcIfW57uwglKdpYWp3qJV/Uq6Uz37Owhz+Cq
         1vU5EfQVDMRIk83kVVAh5l+BNmZOQtZ+iIHS0p/3N5C6L46zm7jKc+sCE7VwHMw376Jl
         gtroh9Z1RlxtGzeBtc/Vw49q/grN8uaYYedD8D5OzGhzpz22U9YuETL9xCgriIbqZyMr
         hdAA==
X-Gm-Message-State: APjAAAWhY7+PyHagz3NiN/nDqHWqxX+pAj0AUtcackREPmDhberUiOhN
        z+bMe18AHDKFzqGVAvN7TQZSnE/m
X-Google-Smtp-Source: APXvYqwjblNL4eGtRKeKJu9P5Lq0agJXU0Viv2nrZBO3li/ElsUzfPhDVkTS/5/N9I1wKXUItw3xWQ==
X-Received: by 2002:a02:b88b:: with SMTP id p11mr18609134jam.144.1565295536263;
        Thu, 08 Aug 2019 13:18:56 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id m20sm93590523ioh.4.2019.08.08.13.18.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 13:18:55 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 6/9] NFSD check stateids against copy stateids
Date:   Thu,  8 Aug 2019 16:18:45 -0400
Message-Id: <20190808201848.36640-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
References: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Incoming stateid (used by a READ) could be a saved copy stateid.
Update the copy notify timestamp (cpntf_time) with current time.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4state.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index bd962f1..31a32ec 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5672,6 +5672,43 @@ void free_cpntf_state(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
 	nfs4_put_stid(cps->cp_p_stid);
 	kfree(cps);
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
+	cps->cpntf_time = get_seconds();
+	*stid = cps->cp_p_stid;
+
+	return nfs_ok;
+}
 
 /*
  * Checks for stateid operations
@@ -5704,6 +5741,8 @@ void free_cpntf_state(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
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

