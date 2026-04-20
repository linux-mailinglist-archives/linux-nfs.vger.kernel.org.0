Return-Path: <linux-nfs+bounces-20971-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPvNLYJg5mkqvgEAu9opvQ
	(envelope-from <linux-nfs+bounces-20971-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 19:21:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3824E431066
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 19:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD3F030571B4
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31EC330646;
	Mon, 20 Apr 2026 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFTSG+O+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3832FA2E
	for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2026 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699513; cv=none; b=b08oCWuGcVKpSwW81zAMF1AaAgrscST9y6LwDo0VHq52D2QXhQG9pg965rGxBBf1oTehfIKLBjb+1Ht5s2oy3OxrDUmZbEcxGoLJO+53h7z96UzZiUSZCgA+wYaTfrQHa29SSxfl6nKNtRB6dfpkq52Ma2NpuSRMuKsgxrAqMsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699513; c=relaxed/simple;
	bh=1YPmlSibFAs93TrPIvpjlN+QQ8aYFSYODNs2PRv9JqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFXwqB9mrPoaGpIiLvzgagDRlX9cA2edMP1ohczH6k3VJMzVxOdKYBSDQ+gg1VVOYcXIpxQDpxSiD+rDEarL3Yr4fSND2tli6XiPaNBjTSfhkpm8bX1QVReLvFokjvxOfb2NqmqACZjpDc+7Ih9x28iGVCys4ehDqquMhFbeqws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFTSG+O+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9CEC19425;
	Mon, 20 Apr 2026 15:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776699513;
	bh=1YPmlSibFAs93TrPIvpjlN+QQ8aYFSYODNs2PRv9JqQ=;
	h=From:To:Cc:Subject:Date:From;
	b=hFTSG+O+y0yKagcgwzGonKMibIswdL5dSasDdLLT21ApYJ6q5yd8KmEoqlrLvNlUH
	 CH1YXMwSdz3J+pcZGdp8sdAX3+a03wEnvNvM5zb2P7pOTdlMYx8HLRL5YR7019FpWw
	 JBg9yRALXkzSX9sy225qyZOta4M/j4eItnldKHOK2MJQdF8dcYyW8/AL0lGS5D3o9f
	 g0Zd1dkfJM90wU77vTjnw1ju5RZFZM2YnrTPKchTFJIrgP57GJLb1mw/RY2kvj+xBM
	 9CEGLUcNMgiFFt/RmyHASiMmdwLiC061wyNS+hhSPl1hPdcxJOezJLFhEy9m7br9i2
	 xUbAD73wb/nsw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] NFSD: Increase the default max_block_size to 4MB
Date: Mon, 20 Apr 2026 11:38:30 -0400
Message-ID: <20260420153830.463215-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20971-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 3824E431066
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Commit 8a81f16de64f ("NFSD: Add a "default" block size") introduced
NFSSVC_DEFBLKSIZE at 1MB, well below the 4MB NFSSVC_MAXBLKSIZE
ceiling, with the stated intent that a later change would raise the
default.

Raising the default reduces per-RPC overhead on fast networks by
amortizing header processing and scheduling costs across larger
payloads. The halving loop in nfsd_get_default_max_blksize()
constrains the returned value to 1/4096 of available RAM, so the
new 4MB default takes effect only on systems with at least 16GB of
RAM. Smaller machines continue to receive the same computed value
as before. Administrators can still override the computed value
through /proc/fs/nfsd/max_block_size.

On systems where the new default takes effect,
svc_sock_setbufsize() sizes each service socket's send and receive
buffers as nreqs * max_mesg * 2. Quadrupling max_mesg therefore
quadruples the per-socket buffer reservation at a fixed thread
count, which operators tuning large thread pools should account
for.

Note well: Your NFS client implementation must support large read
and write size settings to benefit from this change.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsd.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index a01d70953358..daa63c1b161c 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -45,11 +45,10 @@ bool nfsd_support_version(int vers);
 
 /*
  * Default and maximum payload size (NFS READ or WRITE), in bytes.
- * The default is historical, and the maximum is an implementation
- * limit.
+ * The maximum is an implementation limit.
  */
 enum {
-	NFSSVC_DEFBLKSIZE       = 1 * 1024 * 1024,
+	NFSSVC_DEFBLKSIZE       = 4 * 1024 * 1024,
 	NFSSVC_MAXBLKSIZE       = RPCSVC_MAXPAYLOAD,
 };
 
-- 
2.53.0


