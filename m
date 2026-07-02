Return-Path: <linux-nfs+bounces-22956-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CxWpGyHbRmqyegsAu9opvQ
	(envelope-from <linux-nfs+bounces-22956-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 23:41:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0584E6FD018
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 23:41:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Rp+iCbz3;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22956-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22956-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7506530257BE
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 21:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2224B39AD49;
	Thu,  2 Jul 2026 21:41:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04965396D2E;
	Thu,  2 Jul 2026 21:41:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028499; cv=none; b=V8tA+D92R/WhheNORFgqR/vASUivlaJNxT4yjPdJOXH/3oXTUPSsZiCqdBr3ZqEz1vCojNjxYflQ2K5SCGxLaKNUGYzD98u2SRbnaY8TW6K7GGvX2YPxFq0Srx3PkxFx24vfPT0UUpXDof2VFX+EH6pYV54+LHOqABWF4C4DcS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028499; c=relaxed/simple;
	bh=ddZPTIQBXHN5/ukPBn3a/jjJl2IOQXjI970W5ZUffJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fmHJLmnKZ1MMxHlk3pJ9WV9kv0QbVh5sTdlIMRKv0dOUNNgJ+KnI0hQ6RKpxHos1R7OMZpmRM0A50iEA0RVK4bvEsK37Be8C/OY3xlKgfehuQT/+5MF53debrl5Y/+zeD8o8TBv5B529V4ZTP28MdAstZCT7OCPWS4tUYHalwro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rp+iCbz3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FCD1F000E9;
	Thu,  2 Jul 2026 21:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783028497;
	bh=lraBce0bPA6Oz3ILSCazwgCxYsFFKeSpm0zKg9v8iJ8=;
	h=From:To:Cc:Subject:Date;
	b=Rp+iCbz3qdy9xg4iFGwqsJRfhYxwBVoYnpuSXFJ2tfuZD2gxzhpJLTsfvZb5MJRJr
	 1R8ZESyO+TYGZOIz8vVrPgboee9NNAWlEUg0vJ4g0ybfXDQvKujccVBipF+VotizE7
	 HoBk7mhvT57UtNqwwGlBpMB9Xy+3EhSoM4pFynbN6tjr34uOxQ2ZzsjkU3lT6h+k3n
	 p09hwyPHQlUxX0vOfGrhOno0Q3rssjK/WeLDk5q0NSlGcd46KO3q/oRJI9E+Xv7D+4
	 1qTWEQ0yg//GIuIKtvO/iXvqpfTN+XKUMFvKnGgiQkjm51mzey/8VZP1RFEq8yj4I/
	 JkliLBmwv7bJw==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.6.y 1/2] nfsd: release layout stid on setlease failure
Date: Thu,  2 Jul 2026 17:41:34 -0400
Message-ID: <20260702214135.533354-1-cel@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-22956-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:clm@meta.com,m:jlayton@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0584E6FD018

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
[ cel: no ls_fence_work in 6.6.y; dropped INIT_DELAYED_WORK hunk ]
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


