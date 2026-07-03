Return-Path: <linux-nfs+bounces-22958-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dOunD3ctR2oAUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22958-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 05:33:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D0C6FE37D
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 05:33:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=g+m8Uw8N;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22958-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22958-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6865F306D8B2
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jul 2026 03:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA60306757;
	Fri,  3 Jul 2026 03:33:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DDB30C164;
	Fri,  3 Jul 2026 03:32:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783049580; cv=none; b=Ym4ROgYoRQw+0mDQJHxtJSxFK1sI1xqd9bm0Fj4DxW8jzj1ZO1y0j/F1HvnUkTHLe3LgdscVl+QdqjArVvi2Wy4nSRqJF6OBp5jjq4WTQA8VlUqPaoSVtqbCih3rqaEEkhWxxqWRxDRRWZrmCGOqZLFc2FnWuRD0Gy8W/fSoIzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783049580; c=relaxed/simple;
	bh=voviGqTGQPSemFptJDez/r58pUKhSxCLlp81nQEyLWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JCxCouTj+0/8nBE6dnB9fUwdAiNgWeclWjJS5zAfHb3RxTZmO/+inX1yq6j5l9omXQgHuVm0M1bfg04jNsMPisdP7XQSKwlQXcO1mox5FXLvq0jtvQghJybz18PnGoYMqHNIAdp0+1eAwJHdo3UDATUv8MOW76pI6R4GNz0zs7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+m8Uw8N; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117251F000E9;
	Fri,  3 Jul 2026 03:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783049566;
	bh=eHRs2IQ1+jjS6boktaY1cIFCKznQL4Ms2em86RPj6n4=;
	h=From:To:Cc:Subject:Date;
	b=g+m8Uw8NPSeiQftrspEoO8Y9jEyB1dEWuJVg4//AFqnUFkZyKmWwaVXm87g8MCJzN
	 +J2s0PfhuK9Qz6aFqgD0Eis5liZvotqia/N/OFMq/iSYPEqUnOBqCxT3kydSNWGw+Y
	 Zeoyp5/+Pcvkl02DSh1YPpUJLm570YgemvbrltRQqCUm+Qond/NBcLJRVc6a2T6JI0
	 Elv2igGFhds1FF6la7Wy5igfEGyy1Kopzrf+cePBCLknUWuRifTI6tymB/p8PoX3ud
	 BV09THdzVz2nEK/JepVqcHNwSA93/+gXQMl1ck+P8G/GX/teVUdib3VBSIORueF8p5
	 +VMYr1ar2ivKQ==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.1.y 1/2] nfsd: release layout stid on setlease failure
Date: Thu,  2 Jul 2026 23:32:42 -0400
Message-ID: <20260703033243.1539871-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22958-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:clm@meta.com,m:jlayton@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9D0C6FE37D

From: Chris Mason <clm@meta.com>

commit 30d55c8aabb261bc3f427d6b9aae7ef6206063f9 upstream.

nfs4_alloc_stid() publishes the new stid into cl->cl_stateids via
idr_alloc_cyclic() under cl_lock before returning to
nfsd4_alloc_layout_stateid(). When nfsd4_layout_setlease() then
fails, the error path frees the layout stateid directly with
kmem_cache_free() without ever calling idr_remove(), leaving the
IDR slot pointing at freed slab memory. Any subsequent IDR walker
(states_show, client teardown) dereferences the dangling pointer.

The correct teardown for an IDR-published stid is nfs4_put_stid(),
which removes the IDR slot under cl_lock, dispatches sc_free
(nfsd4_free_layout_stateid) to release ls->ls_file via
nfsd4_close_layout(), and drops the nfs4_file reference in its
tail.

A second issue blocks that switch: nfsd4_free_layout_stateid()
unconditionally inspects ls->ls_fence_work via
delayed_work_pending() under ls_lock, but
INIT_DELAYED_WORK(&ls->ls_fence_work, ...) currently runs only
after the setlease call. On the setlease-failure path the
destructor would touch an uninitialized delayed_work.

    nfsd4_alloc_layout_stateid()
      nfs4_alloc_stid()           /* idr_alloc_cyclic under cl_lock */
      nfsd4_layout_setlease()     /* fails */
        nfs4_put_stid()
          nfsd4_free_layout_stateid()
            delayed_work_pending(&ls->ls_fence_work)  /* needs INIT */
            nfsd4_close_layout()  /* nfsd_file_put(ls->ls_file) */
          put_nfs4_file()

Fix by hoisting the ls_fenced / ls_fence_delay / INIT_DELAYED_WORK
initialization above the nfsd4_layout_setlease() call, and replace
the manual nfsd_file_put + put_nfs4_file + kmem_cache_free cleanup
with a single nfs4_put_stid(stp).

Fixes: c5c707f96fc9 ("nfsd: implement pNFS layout recalls")
Cc: stable@vger.kernel.org
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ cel: no ls_fence_work in 6.1.y; dropped INIT_DELAYED_WORK hunk ]
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4layouts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 308214378fd3..84bb200e24ad 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -242,9 +242,7 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 	BUG_ON(!ls->ls_file);
 
 	if (nfsd4_layout_setlease(ls)) {
-		nfsd_file_put(ls->ls_file);
-		put_nfs4_file(fp);
-		kmem_cache_free(nfs4_layout_stateid_cache, ls);
+		nfs4_put_stid(stp);
 		return NULL;
 	}
 
-- 
2.54.0


