Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBF42731AA
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgIUSMc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgIUSMc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:12:32 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B3EC061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:32 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t12so14701399ilh.3
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=H2P9NUw4kcyH3D/g4QWWITIQjyToSM155bjkjXMSe00=;
        b=AePrSDhJZUgwARWDr8zAxxYFdw+ja+Twa9CJzy0juChgn/bnr/ze5v4f/HnlJarg4a
         yhx0WNkLkWh91CpuLbfQMuA9aCa/Nvk0bdNZnWWfhL+t9k4ChV2rtNPJ/kQadvOyilNk
         KwL1/+QiHmZOTI0tF5Ywn30HZGedokGybyGWvfeUW2LZd6coHJRwMraDpHYf5p7bh//O
         33LzN6/VnWr30VGpfKN7+HpK5og5PQc67a26SVoyX88qb2VfPEEh3v7Cgp/60GKZ6ZHm
         lFWw/V6clD9pGQNslWGZobfmp3Qa3Q1gucAsx7QDvdUQrl/M2XoijvIvmmJu/hh+Vxb7
         1OUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=H2P9NUw4kcyH3D/g4QWWITIQjyToSM155bjkjXMSe00=;
        b=i2DArBZm9NsuJxH37fDwwhJ+P+gnH9gxS2x7dE9z7mmCY98nfeVOfCbFM29eR3030H
         eDeH9lfbvHwQn+kLwUlbcMFYvuTi9O6HL/4DMvkDP2UdgYCiYtDcHvIIw86ib8q9lAIO
         jjYpehPP/MltEQ/71QKjLB+Cam6Uvh46idpzV+yiVZhKCkXV0t+/xblA6U/QRh2nadFx
         k6WuVIHKzB6UTeUfb/cN9pNAlkX5+GYto+EtaflKe5qzEH1x+wMRCo5jxeuHARRvRhty
         fmYQK0Gna0HjDWyR+9Q3EolMQJkfY2rhlWVU2YYzRVcwwwxZbG09RWkU91boiN+VLPUc
         52kg==
X-Gm-Message-State: AOAM531KwYLpPv23Wjh00y7QxiWY9zqWa+O3eo5Izf4XgOa5XLifvNkO
        Y30ST5SsdEdd5uITjOuUqF3suQ4zti0=
X-Google-Smtp-Source: ABdhPJwI6/k6Vtb8k5SJOv27CojYoW4hM4McZJ7Pokb4/7YHn99o3OfZCNpo+/0ZS7dp+R+OY0M0+Q==
X-Received: by 2002:a92:194b:: with SMTP id e11mr1087315ilm.133.1600711951880;
        Mon, 21 Sep 2020 11:12:31 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j85sm3445147ilg.44.2020.09.21.11.12.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:12:31 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LICUsW003899;
        Mon, 21 Sep 2020 18:12:30 GMT
Subject: [PATCH v2 19/27] NFSD: Add tracepoint in nfsd4_stateid_preprocess()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:12:30 -0400
Message-ID: <160071195018.1468.10585113594945321482.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Record the stateid being processed by each COMPOUND.

nfsd-1033  [003]   165.199589: nfsd_stateid_prep:    xid=0xeb2d9610 client 5f4fdc70:dbdb3569 stateid 00000001:00000002 status=OK

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   24 ++++++++++++++----------
 fs/nfsd/trace.h     |   34 ++++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f101202ed536..0cc928328c22 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5881,12 +5881,14 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 	if (nfp)
 		*nfp = NULL;
 
-	if (grace_disallows_io(net, ino))
-		return nfserr_grace;
+	if (grace_disallows_io(net, ino)) {
+		status = nfserr_grace;
+		goto out;
+	}
 
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
 		status = check_special_stateids(net, fhp, stateid, flags);
-		goto done;
+		goto out_check;
 	}
 
 	status = nfsd4_lookup_stateid(cstate, stateid,
@@ -5895,11 +5897,11 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 	if (status == nfserr_bad_stateid)
 		status = find_cpntf_state(nn, stateid, &s);
 	if (status)
-		return status;
+		goto out;
 	status = nfsd4_stid_check_stateid_generation(stateid, s,
 			nfsd4_has_session(cstate));
 	if (status)
-		goto out;
+		goto out_put;
 
 	switch (s->sc_type) {
 	case NFS4_DELEG_STID:
@@ -5914,19 +5916,21 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		break;
 	}
 	if (status)
-		goto out;
+		goto out_put;
 	status = nfs4_check_fh(fhp, s);
 
-done:
+out_check:
 	if (status == nfs_ok && nfp)
 		status = nfs4_check_file(rqstp, fhp, s, nfp, flags);
-out:
+out_put:
 	if (s) {
 		if (!status && cstid)
 			*cstid = s;
 		else
 			nfs4_put_stid(s);
 	}
+out:
+	trace_nfsd4_stateid_prep(rqstp, stateid, status);
 	return status;
 }
 
@@ -6066,7 +6070,7 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
 	struct nfs4_stid *s;
 	struct nfs4_ol_stateid *stp = NULL;
 
-	trace_nfsd_preprocess(seqid, stateid);
+	trace_nfsd4_seqid_prep(seqid, stateid);
 
 	*stpp = NULL;
 	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
@@ -6135,7 +6139,7 @@ nfsd4_open_confirm(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	oo->oo_flags |= NFS4_OO_CONFIRMED;
 	nfs4_inc_and_copy_stateid(&oc->oc_resp_stateid, &stp->st_stid);
 	mutex_unlock(&stp->st_mutex);
-	trace_nfsd_open_confirm(oc->oc_seqid, &stp->st_stid.sc_stateid);
+	trace_nfsd4_open_confirm(oc->oc_seqid, &stp->st_stid.sc_stateid);
 	nfsd4_client_record_create(oo->oo_owner.so_client);
 	status = nfs_ok;
 put_stateid:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 4fb668257ce2..be5fc0ce3c13 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -594,6 +594,36 @@ TRACE_EVENT(nfsd4_getattr,
 #include "filecache.h"
 #include "vfs.h"
 
+TRACE_EVENT(nfsd4_stateid_prep,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const stateid_t *stp,
+		__be32 status
+	),
+	TP_ARGS(rqstp, stp, status),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, si_id)
+		__field(u32, si_generation)
+		__field(unsigned long, status)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
+		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
+		__entry->si_id = stp->si_opaque.so_id;
+		__entry->si_generation = stp->si_generation;
+		__entry->status = be32_to_cpu(status);
+	),
+	TP_printk("xid=0x%08x client %08x:%08x stateid %08x:%08x status=%s",
+		__entry->xid, __entry->cl_boot, __entry->cl_id,
+		__entry->si_id, __entry->si_generation,
+		show_nfs4_status(__entry->status)
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_stateid_class,
 	TP_PROTO(stateid_t *stp),
 	TP_ARGS(stp),
@@ -660,11 +690,11 @@ DECLARE_EVENT_CLASS(nfsd_stateseqid_class,
 )
 
 #define DEFINE_STATESEQID_EVENT(name) \
-DEFINE_EVENT(nfsd_stateseqid_class, nfsd_##name, \
+DEFINE_EVENT(nfsd_stateseqid_class, nfsd4_##name, \
 	TP_PROTO(u32 seqid, const stateid_t *stp), \
 	TP_ARGS(seqid, stp))
 
-DEFINE_STATESEQID_EVENT(preprocess);
+DEFINE_STATESEQID_EVENT(seqid_prep);
 DEFINE_STATESEQID_EVENT(open_confirm);
 
 DECLARE_EVENT_CLASS(nfsd_clientid_class,


