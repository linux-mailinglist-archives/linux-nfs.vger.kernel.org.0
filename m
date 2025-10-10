Return-Path: <linux-nfs+bounces-15140-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B14BCE69E
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 21:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFEC44E1613
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 19:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5825D3016EA;
	Fri, 10 Oct 2025 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHI2tpbK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE03016E0
	for <linux-nfs@vger.kernel.org>; Fri, 10 Oct 2025 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760125499; cv=none; b=n0X0Si1tyyCIdQitf1ZWHeixh1IdwA0SD3mhfaJ9f7dm2MSQ73pOZ3al8anAhhD6GAPrXyEl1tH5vq4kGrcMUf1ubcUAqL7i3I6TQmnDFC8htGAoZNKuLbESrk58S5VskebazR91pOdLMsoQ0AsSNfp6RhmCZkbayPA3TQnyGWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760125499; c=relaxed/simple;
	bh=O21sQeGLHzhK8nweuTnQid+79WNyj2jn3ZSZB4kz5WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9bL/tDaSQMA//OAz2tpezWUj1weoa4U0wtnO//siPDfP9jLYlEXopHtup6L4yaxkKDKHaxtS9QiFm3PwuPCZEPid49Pn9ETZeUeElHjd+2Vrl4ZdgEWsn09iGxcQwHEyd9SnGWZJ9AiyETUO1OB3onvtWEwYg2Lei9XqSyxG54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IHI2tpbK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760125496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PlmNOwL5d2+3KO/zScnoVyysibPIuC6ZHdR8zadGTq0=;
	b=IHI2tpbK8kCFNCNrCVKawSxqM9+UaFPFM7CjUwo5L2TzHZCJ0bvvXNuHkFA3QcMwBGi+7C
	Hsrdu1rsAUt2YsiYa2NC4A70mU1SNrsXVO7dnsn2QmHjSHQT9M58vJmeHooudexhlCHZVe
	d68Vbs0id/JtZYEsiY+5rlfwWX3o6B0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-ZwnWH2BXMq6_W3jGdmyIZQ-1; Fri,
 10 Oct 2025 15:44:53 -0400
X-MC-Unique: ZwnWH2BXMq6_W3jGdmyIZQ-1
X-Mimecast-MFC-AGG-ID: ZwnWH2BXMq6_W3jGdmyIZQ_1760125492
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBC3818002CE;
	Fri, 10 Oct 2025 19:44:51 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.64])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 55B7E1955F42;
	Fri, 10 Oct 2025 19:44:50 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [RFC PATCH 1/1] nfsd: fix setting seq->maxslots for replay operations
Date: Fri, 10 Oct 2025 15:44:49 -0400
Message-ID: <20251010194449.10281-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Here's the problem this patch attempts the solve. Client has an
established session and used no more one slot at some point but
currently is only using slot 0. Thus it's sending compount requests
with sa_highest_slotid=0. Now say the client sent an op (eg OPEN),
the server processed it, reply to OPEN is cached in the reply cache,
and connection gets reset. Upon reconnection the client resends OPEN
again with same sequence slotid, seqid, sa_highest_slotid=0.
Server replies out of the replay cache. But it sends the reply with
sr_highest_slotid=0. As the result, the client throws away any
slots it had above slot 0. Then when it needs to use more than
one slot, a compound is sent with a "new" slot seqid=1. Server replied
with NFS4ERR_SEQ_MISORDERED (because it never realized to told the
client to shrink its slot table).

The problem lies in how the server's seq->maxslots is managed. Normally,
in nfsd4_decode_sequence() seq->maxslots get set to whatever the
client sent in sa_highest_slotid+1. But then in nfsd4_sequence()
processing of the sequence when everything is checked and processed
(ie., it's not a replay operation), then seq->maxslots gets
reassessed again and gets set to max of session->se_target_maxslots
and seq->maxslots). Once nfsd4_sequence() is done only then later
it gets encoded and nfsd4_encode_sequence() put the value of
seq->maxslots into sr_highest_slotid reply.

Now, when the compound is a replay, then encoding is done within
the nfsd4_sequence() itself and seq->maxslots is set to whatever it
decodes from the call (ie., client sent sa_highest_slot=0 so it's 0+1).
Thus, the encoding function puts value of 0 into sr_highest_slotid.
nfsd4_sequence() would later reset the seq->maxslot but it's useless
as the encoding (of the wrong value) is done by then.

The proposed fix is to explicitly set the seq->maxslots and
seq->target_maxslots as it's done for normal sequence processing
prior to calling encoding of replay cache info.

---comment it probably needs a Fixes but I'm not sure what that
should be. As I think this is day0 behaviour.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4state.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fa073353f30b..4b4d067f20d0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4413,6 +4413,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		cstate->slot = slot;
 		cstate->session = session;
 		cstate->clp = clp;
+		seq->maxslots = max(session->se_target_maxslots, seq->maxslots);
+		seq->target_maxslots = session->se_target_maxslots;
 		/* Return the cached reply status and set cstate->status
 		 * for nfsd4_proc_compound processing */
 		status = nfsd4_replay_cache_entry(resp, seq);
-- 
2.47.3


