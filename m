Return-Path: <linux-nfs+bounces-16766-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2120BC8FD50
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 19:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3A514EA5A2
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 17:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9B12F616D;
	Thu, 27 Nov 2025 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="awZaClfS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="awZaClfS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085BA2F549E
	for <linux-nfs@vger.kernel.org>; Thu, 27 Nov 2025 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764266329; cv=none; b=EqZ9YThOBbVPHQaWrOa4Es+RG7DDAdmyDqkfbOKspSM8N+sjMzNjwl7DR2p03KFizXEIrLvvHIP+w00S4Qy3TGCbhEDdTkXPCuGB6fB851tgBC0R7RX/YczbgMM52NG3STGEZ29LmnsZN+vPSBvKMQcejylhqvP6sZgmNDVDw3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764266329; c=relaxed/simple;
	bh=9G/Dxo+bgGOU2AzhpFfqEvVvKBY+xzY7ipmI5VZzo6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYXU7Rb+gcDyzWWLrA1gOTMW5DCZdxfnfmd1n//Q6ASCwmx4FrKRXe/pYC32XXowSwsr/9IGjOeO2Wm+QrD7cGclzngEvJ7HkxPGaHQxDDkxtNxWx7A27Ab5uJ1vzsqO8wxp0xOYDOxXco1DRSO4mhHyUrOIa64ul4nY1gzQEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=awZaClfS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=awZaClfS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out2.suse.de (Postfix) with ESMTP id 1ACD35BCC1;
	Thu, 27 Nov 2025 17:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764266324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30KYWi6yVGsWMKGKDQnnTwu/HZUrR0y40HT8Lfe5xtA=;
	b=awZaClfSC2qpdNQwb1gyWZB9B/SO0lU61jCDyPKGFwBz7x5FFlZz7EMfUo6IV/Ox2ZWekt
	/LTO9RxRVOhJeBtknyWgvj5pSkI4abIB5cTXZW5OW0nXBL1QuFXdaWsKMiydfXerv223Qg
	BDAYY1tv5BLnjkjs41ZOp0MFt6PzoAE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764266324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30KYWi6yVGsWMKGKDQnnTwu/HZUrR0y40HT8Lfe5xtA=;
	b=awZaClfSC2qpdNQwb1gyWZB9B/SO0lU61jCDyPKGFwBz7x5FFlZz7EMfUo6IV/Ox2ZWekt
	/LTO9RxRVOhJeBtknyWgvj5pSkI4abIB5cTXZW5OW0nXBL1QuFXdaWsKMiydfXerv223Qg
	BDAYY1tv5BLnjkjs41ZOp0MFt6PzoAE=
From: Anthony Iliopoulos <ailiop@suse.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/2] nfsd: never defer requests during idmap lookup
Date: Thu, 27 Nov 2025 18:57:52 +0100
Message-ID: <20251127175753.134132-2-ailiop@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127175753.134132-1-ailiop@suse.com>
References: <20251127175753.134132-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,kunlun.arch.suse.cz:helo];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunlun.arch.suse.cz:helo,suse.com:mid,suse.com:email]
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO

During v4 request compound arg decoding, some ops (e.g. SETATTR) can
trigger idmap lookup upcalls. When those upcall responses get delayed
beyond the allowed time limit, cache_check() will mark the request for
deferral and cause it to be dropped.

This prevents nfs4svc_encode_compoundres from being executed, and thus the
session slot flag NFSD4_SLOT_INUSE never gets cleared. Subsequent client
requests will fail with NFSERR_JUKEBOX, given that the slot will be marked
as in-use, making the SEQUENCE op fail.

Fix this by making sure that the RQ_USEDEFERRAL flag is always clear during
nfs4svc_decode_compoundargs(), since no v4 request should ever be deferred.

Fixes: 2f425878b6a7 ("nfsd: don't use the deferral service, return NFS4ERR_DELAY")
Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 fs/nfsd/nfs4xdr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6040a6145dad..0a1a46b750ef 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5989,6 +5989,7 @@ bool
 nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd4_compoundargs *args = rqstp->rq_argp;
+	bool ret = false;
 
 	/* svcxdr_tmp_alloc */
 	args->to_free = NULL;
@@ -5997,7 +5998,11 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	args->ops = args->iops;
 	args->rqstp = rqstp;
 
-	return nfsd4_decode_compound(args);
+	clear_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
+	ret = nfsd4_decode_compound(args);
+	set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
+
+	return ret;
 }
 
 bool
-- 
2.52.0


