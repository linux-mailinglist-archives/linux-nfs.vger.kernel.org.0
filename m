Return-Path: <linux-nfs+bounces-20662-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M+EHH460mm0UQcAu9opvQ
	(envelope-from <linux-nfs+bounces-20662-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 05 Apr 2026 12:33:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B433539E0CA
	for <lists+linux-nfs@lfdr.de>; Sun, 05 Apr 2026 12:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B99C3009161
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Apr 2026 10:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847B92C15AA;
	Sun,  5 Apr 2026 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pvAq4h6b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0034972627
	for <linux-nfs@vger.kernel.org>; Sun,  5 Apr 2026 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775385195; cv=none; b=ZnvHlsFR/+UvLQT6zXdbHd92RFOImU6HCY77akTHz5WjNXWj0/A1orItEcsKzgkAyk1p9CXISp2DDYLpde8zrTAaEmUznX3gh7byipyZwq6yVO0JSVimMysUAdHpoLfTlGWzABBxtFCFMT5APOeFT2qL6jVmhvGaoQtL2jUOPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775385195; c=relaxed/simple;
	bh=iUuSMZbXo7lKLUFUSjDqrmYLMdPJxMPacq6VP/6rVgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LkIw+xzQG+7h16luvNiODca03J5VVVCjaaz43wuzMDo8Kqf+jS/HPiXj+rXDFwiNf9YaBPxtEanz86W/WtXgCKWg2d0nhId5PmzzdpKrEBik32iLX3YrYjOmwpE/W71YHhSNVzmTOH/TR2r9GZ6H+Rd9VQ0G/ynKixsoJjUJraw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pvAq4h6b; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775385182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZdbGEBdKDFejyS3DjK8MKyXd7OZdpUCEhA3KnPERKMA=;
	b=pvAq4h6bwDE2trE6vbEE4TBqr3tRl0tkMowBw9ltx7EfYip4hpspZuZ41vG5f7RFpiHvga
	1rXqd4VW/JpKiC1mtGKzzRirhOei3LfQF4Vs/fbO5v4Uele8l6fXcfOASI3fEfYyYWh737
	W2axFD8fJYkCcQTvyHnFVqLr+EDlM3A=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nfs: use memcpy_and_pad in decode_fh
Date: Sun,  5 Apr 2026 12:32:14 +0200
Message-ID: <20260405103212.970232-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=770; i=thorsten.blum@linux.dev; h=from:subject; bh=iUuSMZbXo7lKLUFUSjDqrmYLMdPJxMPacq6VP/6rVgI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmXrHTylPZUNWwRO/Np8bN16q/V63cxbzqYfPL/C+ebg t0ve55+6yhlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJpMczMnTOSpvU8CT13tna R35rpt69/O5MTv/ZyJA6k8nOV8//tV3B8FciOmYfy2reoP/rw6qe1G+beHLSDLn1jdenq23Se81 0uI8RAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20662-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: B433539E0CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use memcpy_and_pad() instead of memcpy() followed by memset() to
simplify decode_fh().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/nfs/callback_xdr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 176873f45677..4382baddc9ee 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -96,8 +96,7 @@ static __be32 decode_fh(struct xdr_stream *xdr, struct nfs_fh *fh)
 	p = xdr_inline_decode(xdr, fh->size);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
-	memcpy(&fh->data[0], p, fh->size);
-	memset(&fh->data[fh->size], 0, sizeof(fh->data) - fh->size);
+	memcpy_and_pad(fh->data, sizeof(fh->data), p, fh->size, 0);
 	return 0;
 }
 

