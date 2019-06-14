Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D828546884
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 22:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfFNUBC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 16:01:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38386 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfFNUBB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jun 2019 16:01:01 -0400
Received: by mail-io1-f68.google.com with SMTP id d12so424295iod.5
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2019 13:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2VQoAuMetaog4o/Urh6WX+aHtlv8tjfjtITzHaHizJ4=;
        b=LZ4F8NQnOhKZPmbKZWDNyKfrwtjBoRsv/5UtPj55oK4C9FkoquNUjic9n6RZTi3U2g
         lrRWJ614j0Udij1M9N2VTZGjYbQYbYOZ/Zyy5w1DaX9T6y+vgxwRYR8f1uwSKIzboRmF
         9fxnU16l3gurTVVVQvO5DL+knCYzn7vQNoZT5SP76849uY2Vypg6baZrtG7Kb2QR5TeJ
         iSXYJepZuHeSKvVHf+tJ3E3gs3e+KsdpM3phfu1ad4pzVwYR4etN7O1wMSO0LT3pJNdX
         dQOiVhc/okcVyyD6du9bZjOFd2wTS5muB1/2UpcZebOVG7qMUIKjnVo4lODZLrwLZZKD
         30fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2VQoAuMetaog4o/Urh6WX+aHtlv8tjfjtITzHaHizJ4=;
        b=ChEoC5qmJeEi9RfsC9MK2paMwExRzFLqpCudjrlG4BIAxlz0Ogk975/Q5zE6sWl8F6
         JlGxDwJk5S0MY0CRE7vOv1emYwfPF+LpNJL0j5Ya//qlWu5UtPGWatWJXKSAjkfWdU5W
         GNKTmwOpbLOW1B6mpfvfiB8Vt64f28acr+rCc2hfryKjFg290qzkCw0VxInKfK1PZT0q
         XTc+z8XamJrwWtbcwEYehC1iI9t08m3KxIHBxF1Gv/r5UnnIhRVPg9M86pXgXmGUd+k9
         Lz8nOi+zsu25/Pb5YTIksytGYkSWukL1nRJ1/h5fu0O64xYYrAEMg2VjJua1RlzTyasI
         69Tg==
X-Gm-Message-State: APjAAAWw+a6l04UeCOiLbg9fLU//2SdhrG6/BxsytmSUQqtTCDUpywDt
        aLX4NTTuPVJnjzAtNGc9HjMyS1teJXA=
X-Google-Smtp-Source: APXvYqwn1aJYZ5HMD/UNiKyoTXPPSmW3DkrhZxVKdg8dD7TVRwGVRQS9Jyw5caXDXlEwMzRhOg4HPg==
X-Received: by 2002:a02:cc8e:: with SMTP id s14mr69769193jap.142.1560542460960;
        Fri, 14 Jun 2019 13:01:00 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p4sm6528115iod.68.2019.06.14.13.00.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 13:01:00 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 5/8] NFSD check stateids against copy stateids
Date:   Fri, 14 Jun 2019 16:00:51 -0400
Message-Id: <20190614200054.12394-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190614200054.12394-1-olga.kornievskaia@gmail.com>
References: <20190614200054.12394-1-olga.kornievskaia@gmail.com>
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
index 07128ef..d151257 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5230,6 +5230,49 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 
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
@@ -5262,6 +5305,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
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

