Return-Path: <linux-nfs+bounces-21622-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLmXKPY2BmqWgQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21622-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 22:56:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0A4546D98
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 22:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7EAF301486A
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 20:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E073BF66E;
	Thu, 14 May 2026 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUjz9c03"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C0B3F4121
	for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792174; cv=none; b=De8O4Cf/e0Qopqx/BnkKbBzQV/a+rN8PXFq0UoFqTze/hpffMaEeeLwgbuRcai+MDp7+SnxobTa9dk/6oR/fVensU1IHxaFaWQ70VeX1WQ0DVYqmDKV88Q3G6qowCbA5JHfxb2+eikQHJ1X0hUsSBH1A8pUmyrZespdjo6j0WFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792174; c=relaxed/simple;
	bh=Hpu9dgU/jLmTdhs63lSkJdyUVx82AZ7r5eMwngetHzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDNIHLb9Sb9AyOgmZM6BtmRQIDzC05T3TgB5pDhFrXk6JAKETHFV2v/9QpATa2PIM7JlaCsGsbz98FvK+AbdXIhnjEz8hp87yWRYdhY4HzPa/oAdmuLdOiQrglxaISd+mMZyU73FJvDLVkexMosOylgtysdyuXqS0CYq2RgKB8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUjz9c03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76221C2BCB7;
	Thu, 14 May 2026 20:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778792174;
	bh=Hpu9dgU/jLmTdhs63lSkJdyUVx82AZ7r5eMwngetHzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pUjz9c03O2K7Sxww7Cs6KjbhXl4BUK9rrSUgC8jd5OPh4Rj+HetYyks776OtN9byq
	 xXZFNmPTOIEOv0r/hs3usElCg/Z0RCO6IC/+rEl4gHoLbt3Z0GS8lXixh/7K8xd55P
	 OmBEcZjIGLpdyomcvT5RmYFG3edKmeIrTTkcb/Y9VjqTIdVk/2roC0nmeYWpbEEQhe
	 pCcmvlbNP41E5DdePcap8XRsZnCNHPAAzgsDCUdwrzYH+Q8+h8PTcL0lsmukdxoFrm
	 zQPFaoExLifqTk37ZgPoLiSQoDihT6p7kit2gl9X7Dx5YYNBOPH0kdmo4s9E4/f3Ag
	 BZoTlEpQ4cz1A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 1/3] lockd: Plug nlm_file leak when nlm_do_fopen() fails
Date: Thu, 14 May 2026 16:56:04 -0400
Message-ID: <20260514205607.348291-2-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514205607.348291-1-cel@kernel.org>
References: <20260514205607.348291-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE0A4546D98
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21622-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

A client can repeatedly drive nlm_do_fopen() failures by presenting
file handles that the underlying export rejects. After kzalloc_obj()
succeeds in nlm_lookup_file(), the freshly allocated nlm_file is not
yet inserted into nlm_files[]. The nlm_do_fopen() failure path jumps
to out_unlock, which releases nlm_file_mutex and returns without
freeing the allocation, so each failure leaks one nlm_file.

Route the failure through out_free so kfree() runs before the
function returns.

Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcsubs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index e24bacea7e03..0b81d8db0919 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -166,7 +166,7 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
 
 	nfserr = nlm_do_fopen(rqstp, file, mode);
 	if (nfserr)
-		goto out_unlock;
+		goto out_free;
 
 	hlist_add_head(&file->f_list, &nlm_files[hash]);
 
-- 
2.54.0


