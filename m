Return-Path: <linux-nfs+bounces-22035-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNAYDR9XGGoQjQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22035-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 16:54:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 380535F3FD2
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 16:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1594C30074DC
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 14:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18065379973;
	Thu, 28 May 2026 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYAkRs8Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3B0377009;
	Thu, 28 May 2026 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979111; cv=none; b=kBgvXyP8j3Jj0Y1e6m03IUOHhoSj+9l6WtO0mfvGtGVYsnRXYBX6Nb+18mQw/lpr5X48ziQzBQnbuETnLFT8hnSy8yiAL9pVcTu/LI6UR73RlHU1hSVkigyzNfm9L65h+6Dl22hYnkxNDaKJEUTTzasxgqYXZ5QMlOJLQ7BOeXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979111; c=relaxed/simple;
	bh=pKM7me9tBjwONJcHL8fwaY1tzNA338mtkfJUG6mzhik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CJ88erLL4p206aenDGQt7DLSzgIFFMRfoB/8wyfo68zaajabRKDahJhhOf181tf382gX3xUc/wXe3+waHDfMIxv+tyoiSN3+ryd5CgiGVfzBeBLqB007vgildnDPeVRVPGm35iCnPwgmftEDDGfLRkL0rQxEvkWNKyxdE4EEIW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYAkRs8Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D565C1F000E9;
	Thu, 28 May 2026 14:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779979108;
	bh=EGg63SDKPY36kmig11sCUOM9bHbOMx2w8k8traCGkzE=;
	h=From:Date:Subject:To:Cc;
	b=QYAkRs8ZbGfSoDoROGqhCNFiEVLoJFFflh6Dzu+/9NvZ8ff81YYO13ZEnvKmxpi33
	 CvfAELbpWBC9s4CyjoGJBjIgz3Ez8mzeZRDmihifEQ4uovOBuB5gkzBKH++SV7VW7c
	 maUuNXzEll70P3sE8+swYitRUflk8PplSGZOyGzqojVwQlwFKgprrXTBhXFLEWgOYD
	 xZHM++80C++bHcoHxCMiOECKzzGaRgxvbfxBpXCIHAknld0AMqA0XFZ6YAa+1i8qh1
	 ZgV5+95LA50xNh1lDKaOLETwspRtJFpngYzSYge9xzqIKZV9734KsTZvovyifrKMfH
	 399vXfFueo4dw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 28 May 2026 10:38:15 -0400
Subject: [PATCH] nfsd: fix XDR length calculation in
 nfsd4_ff_encode_layoutget
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-pnfs-fixes-v1-1-8a1255ae2f16@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2LQQqAIBAAvyJ7bkEtQ/pKdJBcay8mLkQg/T3pO
 MxMA6HKJLCoBpVuFr5yBzMo2M+QD0KOncFqO2tnPZacBBM/JDhF50zyY3DJQx9KpV/0ft3e9wM
 zZSHJXAAAAA==
X-Change-ID: 20260528-pnfs-fixes-4d551f83a5f8
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2680; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pKM7me9tBjwONJcHL8fwaY1tzNA338mtkfJUG6mzhik=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGFNfxvsloz+viTgXVJgb46j1ytBuLFLfMA/5q
 C/jFtOL7HOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahhTXwAKCRAADmhBGVaC
 FWc9D/kBW7nN9YIdWM6a5RGTC7ZatFZjZp5F0Uln10VrOTsLp5EHyR7cOWL+PE0ptWoVQ9kmH5P
 WbQeOXVZf1y+zU8OaFVtV28yTI/61KGCRFON9mnBrdmlFIcYBBSTeS+BZ/9wHMN+GbP4nIbwPdW
 Ly+PfhY+Kf+iIhd/Dp6s4njdmKpig1IV6EoAPqH0yfABKcWNv9Wr6vZbMpRBo4uf2AK0EFcpS4Q
 iERURrC+GcENLo7t+Z2EnhvDkzWuh/5jyv8cGtl4vuPqsxLcSbw+NmmxVtdNRekxOEjBfEnekOR
 ynXOdau/fz8xnIQn+vpNDgxDIWD8Z10sTOHzE8cw5BbfNuMimKiK385GJXEJeFOV/q/Hk7ZyNwK
 5k8UKW7kcPxteRdp3srJQ1K4Gem9IKVj1iRJ+hFu2+PzWf75ID5LfiPDYU07di7+vqp73HqJa8E
 eafywVJEVw507v4MgHsSWCvKqU6mTSG8vDOS25L3NkASVRZl6G/RnoNjTlh99+JWJQLLiYVQkwz
 mxwXvHt80twvC81PO+ZyHdI2nyYqvZpedWFbgJQ6QPJNAp8NRWOAKAJEpBb0h92ubBQIqjgES0m
 Oj6kLTjRv4gcbTbjkLzXV73Wbwn+ialepsNDXvRhSo6qUdihGVQkCL+W60QTo4CW4p9ZKPxVgjc
 ozqeu/Lbf22BVpw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22035-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 380535F3FD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The XDR buffer size calculation in nfsd4_ff_encode_layoutget() has
multiple errors that can result in either an out-of-bounds write or
leaking uninitialized kernel memory to the client:

 - fh_len doesn't account for XDR padding on the file handle data
 - uid and gid lengths use "8 + len" but xdr_encode_opaque() actually
   writes "4 + xdr_align_size(len)" bytes
 - ds_len omits the flags and stats_collect_hint fields (8 bytes),
   while len's header constant overestimates by 8 bytes -- these
   partially cancel but leave a net mismatch

The worst case occurs with short strings (e.g. uid=0, gid=0 with an
odd-sized file handle), where the function writes up to 5 bytes past
the reserved XDR buffer. Conversely, when string lengths happen to be
4-byte aligned, the reservation is too large and stale buffer content
is sent to the client.

Fix this by breaking out every encoded field explicitly in the ds_len
calculation, using xdr_align_size() for all variable-length opaque
fields, and correcting the header constants.

Fixes: 9b9960a0ca47 ("nfsd: Add a super simple flex file server")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/flexfilelayoutxdr.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index f9f7e38cba13..95b7957a34d9 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -30,19 +30,24 @@ nfsd4_ff_encode_layoutget(struct xdr_stream *xdr,
 	struct ff_idmap uid;
 	struct ff_idmap gid;
 
-	fh_len = 4 + fl->fh.size;
+	fh_len = 4 + xdr_align_size(fl->fh.size);
 
 	uid.len = sprintf(uid.buf, "%u", from_kuid(&init_user_ns, fl->uid));
 	gid.len = sprintf(gid.buf, "%u", from_kgid(&init_user_ns, fl->gid));
 
-	/* 8 + len for recording the length, name, and padding */
-	ds_len = 20 + sizeof(stateid_opaque_t) + 4 + fh_len +
-		 8 + uid.len + 8 + gid.len;
+	/* data server entry: deviceid + efficiency + stateid + fh list +
+	 * user + group + flags + stats_collect_hint
+	 */
+	ds_len = 16 + 4 + 4 + sizeof(stateid_opaque_t) + 4 + fh_len +
+		 4 + xdr_align_size(uid.len) +
+		 4 + xdr_align_size(gid.len) +
+		 4 + 4;
 
+	/* mirror: ds_count + ds */
 	mirror_len = 4 + ds_len;
 
-	/* The layout segment */
-	len = 20 + mirror_len;
+	/* stripe_unit + mirror_count + mirror */
+	len = 12 + mirror_len;
 
 	p = xdr_reserve_space(xdr, sizeof(__be32) + len);
 	if (!p)

---
base-commit: eb97e6388ea32148006bb88ebdb06a0b9ba78cd1
change-id: 20260528-pnfs-fixes-4d551f83a5f8

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


