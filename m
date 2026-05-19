Return-Path: <linux-nfs+bounces-21709-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COJTAxKmDGq8jwUAu9opvQ
	(envelope-from <linux-nfs+bounces-21709-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 20:04:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D92583668
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 20:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 387F430234D9
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 18:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95792F12B3;
	Tue, 19 May 2026 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="k1v4LAjU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7093438BA;
	Tue, 19 May 2026 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213733; cv=none; b=kTgsvVs185dNONanqmSOPY9iBlgaraBHHznozeRdA9g3Bkj3fPBsA3u9E4B2LEm0ewRHGr6yL0+3l7bCdCM0x/heuUoUGLNkM3bhn3GdrWEdAKPOM1gsIAby1UmeNuD46xIbIIMFazarZrz8nOr8XGD6u4kRt8UL3ezsmYVoTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213733; c=relaxed/simple;
	bh=zuAlRJE6rpq1ZCAkupOWWT3uV2T4cwHYVDA7Rnrasnk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oF9Gypun2IgDZgBKd0C4g3PSQDEzRX5ZbXGbDMNMC9rB4dgZC2Rwz6XPohxh7ciXfh4zM9CpAUPac3Ma+O3mIBpbNfeiChok7/mh0HOja/bSEH6rB/4wb7yCDl5C5Umzor2XlQUAPseh3wHlaYr+JxC0beKlJUQu33fp1H4xEJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=k1v4LAjU; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64JHeZ2p3322431;
	Tue, 19 May 2026 11:02:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=XEuaXZIesXXw4DjYEske26zGayAIqXRfUsQKj2KgiLA=; b=k1v4LAjUs9NS
	22XtJFTpnPd8iiDe1c+X1PBr4BDfF0AhP66JXtCODV4zxg83kvKnXCSgzm5Wy1YX
	8TSGqSMD7eAvZZLtB0b8oihAoA1+E+ZuUKe8i+RcWadBIisQIkP9Kci/n5mOO7Gy
	GyCOwe+GQK8DeHVNfBGLdigiIYdS1gfwVyc75AE6WX5zv/JGWtfto2548g7+HfWv
	DZfPJWyNjClhFz8a19rym9yS9XNv1pw2iiQTjf/hWcXkgOkGtT4YVCpQgqzQ6B13
	gw33onSYHUpha/tYxtp3rmmTQmALnI5XvIo+/Rszw/xLM4cfwl66TAAamUSjlYpk
	HDKB0U9wdA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4e8vfar50k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 19 May 2026 11:02:07 -0700 (PDT)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 18:01:39 +0000
From: Chris Mason <clm@meta.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust
	<trondmy@gmail.com>, <linux-nfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] nfsd: drain inflight callbacks in probe_callback_sync
Date: Tue, 19 May 2026 10:49:15 -0700
Message-ID: <20260519180032.1852793-4-clm@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519180032.1852793-2-clm@meta.com>
References: <20260519180032.1852793-2-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wN1O72FwbXQyeY6yvxoJAGcqKCCvR-XB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3OSBTYWx0ZWRfX4h2DEhBx4PZN
 eyjguao4Pd6fy2VUWk2KuxzeJsikq65YkatQfhPsk+C8bQxUMeekvACR2dNJCkEw5pRk0U7CmRO
 ZJxop10uDbVHLsPvucxomhd44J5diTgXNzz0jJoIuk6nSzQL3Ee+h0Zy4WlC+Pk6ktDKU+JkVBL
 xRMYvKctMzcFxKJ9KsdPzeA7xQXkBtfmZTG7XFWz9P/GJI3ZSDgZ0k4+t8nPmORG4yEOGu94Dfh
 qXzqqOIUfL0LYbVJnyqysA+fD+ytQWBv0w++lwMWoyEiT7kRNnh9yljumd6t9NvZZlzrOzNlnQV
 2HvLa0RcHLjP+JeaTbSrW/SgiZ3B2a9IUQtHR8sv+AIEfTv5RSQe1VsJ5q+W6vw90aRgLOgSxG5
 MHyqzr7o+7IlPSFCO6IySbxIdEdxBAlKwCZ0PvUJEl8/kg2919qOOpwMPl8iY4L/R4jiTmlosPA
 BImcZ3KbD4R1lOOUNiA==
X-Authority-Analysis: v=2.4 cv=SORykuvH c=1 sm=1 tr=0 ts=6a0ca59f cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=VabnemYjAAAA:8 a=7wVLLY6u0NvinqmkYrsA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: wN1O72FwbXQyeY6yvxoJAGcqKCCvR-XB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21709-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,fieldses.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,meta.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 63D92583668
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd4_destroy_session() calls nfsd4_probe_callback_sync() to quiesce
the backchannel before nfsd4_put_session_locked() drops the last
se_ref and frees the session. nfsd4_probe_callback_sync() only
flushes cl_callback_wq, which drains the work_struct that submits
CB RPCs but returns before the rpciod-side completion tail
(rpc_call_done -> rpc_release -> nfsd41_destroy_cb) has run. A CB
RPC submitted just before teardown can therefore still be executing
on rpciod, with clp->cl_cb_session pointing at the session about to
be freed:

    CPU 0 (DESTROY_SESSION)              CPU 1 (rpciod)
    -----                                -----
    nfsd4_probe_callback_sync(clp)
      flush_workqueue(cl_callback_wq)    nfsd4_cb_sequence_done()
                                           reads clp->cl_cb_session
    nfsd4_put_session_locked(ses)
      free_session(ses)
      kfree(ses)
                                         nfsd41_destroy_cb()
                                           dec cl_cb_inflight

The se_ref gate in nfsd4_put_session_locked() does not close this
window: the backchannel dispatch path does not take a se_ref via
nfsd4_get_session_locked(), so se_ref can already be zero while a
CB RPC is still in flight against the session.

cl_cb_inflight, added by commit 2bbfed98a4d8 ("nfsd: Fix races
between nfsd4_cb_release() and nfsd4_shutdown_callback()"), is the
barrier that covers the full window: nfsd4_run_cb() bumps it before
queue_work() and nfsd41_destroy_cb() drops it from rpc_release,
after the last cl_cb_session dereference. nfsd4_shutdown_callback()
already calls nfsd41_cb_inflight_wait_complete() after its
flush_workqueue() for this reason; nfsd4_probe_callback_sync() was
not updated when cl_cb_inflight was introduced.

Fix by waiting on cl_cb_inflight in nfsd4_probe_callback_sync()
after the workqueue flush, so every queued CB RPC has reached its
rpc_release before the caller proceeds to free the session.

Fixes: 2bbfed98a4d82ac4 ("nfsd: Fix races between nfsd4_cb_release() and nfsd4_shutdown_callback()")
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/nfs4callback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 8af2d0cc37c2..6cf5591651e4 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1246,6 +1246,7 @@ void nfsd4_probe_callback_sync(struct nfs4_client *clp)
 {
 	nfsd4_probe_callback(clp);
 	flush_workqueue(clp->cl_callback_wq);
+	nfsd41_cb_inflight_wait_complete(clp);
 }
 
 void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
-- 
2.52.0


