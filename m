Return-Path: <linux-nfs+bounces-22130-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOUoKTAlHGr9KAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22130-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 14:10:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC4D615FCB
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 14:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A153031127
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18561387364;
	Sun, 31 May 2026 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7PN48cR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE73B3876BB;
	Sun, 31 May 2026 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780229233; cv=none; b=EQ4bR7n/XDzu/t5pRdc7xLsCUQONw2W/J+URhSC1T5O5uhP1YdI370wfqwGngJMMx6DEarHb3FFCVu9W/RGzX1b6DNh67rwXOULulyKcypTvoKHKM7gcO1a37x5kRiDVjuhhG+DoLVudGDY8rl4rFac/qrQPj4oI5Nal5DRGoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780229233; c=relaxed/simple;
	bh=/I9bxMCfFdOH1dP4+9zNv55LZwzdl+pNMwwbwLA2LBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZAjO6GZopp2qB46YkKalMcpTGXU66xLzuYs4HPDYC59cA3sstBNcldyQ9+QVtOIQDDgHtbXSCVXPmeZNy8iwRYNIP2vctyTSNYgPTztEUxRAdZf/iO0Q2d9AElgRJvib8sUroJA0BA7LsZz8ZL/l4WfUYuQ73PIXxBpDv6ERCwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7PN48cR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFAA1F00899;
	Sun, 31 May 2026 12:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780229231;
	bh=l+psfsetjirdLnxmYGWA5Z9djwl1K/0Xqmz2IAvhk70=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Y7PN48cR68QxerMInpIl4i4z5SbcmLTKa+Z6A/j5eq8a0ByOsFnSzroiB1yARBdRi
	 ZpEn7WO45F480sWo4Si8FDaIeGqFNv/8LiuMeAtvznTfwKAu328BYgdfZ5wnsxSoGS
	 Nz4Ji5t24qrmO6S+mSqNqMoQ55D1AfvCaDGu+qGvogE/ZKjT20HcIttTvWRwQEILuw
	 6b2ap+qZZUXeKOiRX4HKnuUL/EgCWhgq7n1VDOpsexd5JJq5vGm1fA+UZdAKI1x8TU
	 Gd+P5omP3ON4+0SL0vg1FUSq59s7uKHvZANsopqZfLQR0gBahCx/LL/mknIIkW7sWP
	 aQCHw4p/sMKWw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 31 May 2026 08:06:59 -0400
Subject: [PATCH 2/6] nfsd: release path refs on follow_down() error
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-nfsd-testing-v1-2-7bfa481b0540@kernel.org>
References: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
In-Reply-To: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, David Howells <dhowells@redhat.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Rick Macklem <rmacklem@uoguelph.ca>, 
 Chris Mason <clm@meta.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1TY1jt6D0q/SS9QkSVMe2NiA77tvkl4xIAcyTR9UWJk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHCRqhPRa0v7OQwEoQLHqS2bExcSEeWQ4SqKxk
 AIvnqJtvVSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahwkagAKCRAADmhBGVaC
 FcE4D/0cDH0wSdF3TYWXF5gLEcZiqlCLDiMf8JlizVrbe2ERn0nIJD3G6t7r+WB1Pu05mEUmPWr
 4pt8/40dy8p7fT9lMT3XNooEmQzKheJni0bgfrcs0ZhFukwF4WKKgYlmBlvkX5JOXBkK7AfXSc8
 CE37ujKLEqvylIy2exD0POLloEo2njbWKpJIXAKiGMWkVPWgl6yD4J1MjCafWnQtgUg8JxR3Rdp
 9f3w1KYCWqvO6g1A961VzVcD5MHU0hp/KJ+1l3inlmF1ZSz8RACMBraT8WBjhxhQsrBg5oQ2Ten
 U6vop6JA36q3KVHL9sTTqBluJXHvm9fSK2nZ8q4xkiev6M1xFvc/yal8U+8C0CLlom9r6N9GBCQ
 przbBtYjjwwbMNVDl4kQh9xAbZA6vN0Vla0agjhyVgu+6i72gZCdAyqebTp8KvHVIl0lGx99MIn
 awirtCgXfZUzxiZ+76Pktf6BejE/XKmsLJVrAkRABBtRbx9BGX4mC8YpPRJiEVz40Rw0+B0u/RX
 5eKAzC5pC0qrQGTpUkhjytC2qH9dV1mmbl3MzmNLyrYCIqHvosYSvH5ExE/btn8yFnDFZe2ytHW
 st/trX1sBvkZLxM/e9mlZf4Lg7B6LlcsvppwlWbjjE5M0mrHnl7YwKJ4zMA9SXpQ461AwSARRl1
 JTCyhEQT4Wqw41Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22130-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: 0EC4D615FCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

nfsd_cross_mnt() initializes a local struct path with mntget() and
dget() before calling follow_down(). On a negative return the error
arm jumps to out without releasing those references:

    err = follow_down(&path, follow_flags);
    if (err < 0)
            goto out;

follow_down() never drops the caller's entry-time refs on any error
sub-case; for example a pre-cross d_manage() failure leaves path
untouched, so the mntget()/dget() taken on entry survive the call.

Every other early-exit arm in nfsd_cross_mnt() (other-namespace
return, IS_ERR(exp2), and the success tail after the swap) already
calls path_put(&path); the err < 0 arm is the lone omission. The
leak inflates mnt_count and d_count on each failed cross-mount,
blocking umount and pinning dentries against the shrinker, and is
reachable by any authenticated NFS client through nfsd_lookup_dentry
or the NFSv4 READDIR encode path.

Fix by calling path_put(&path) before the goto out in the err < 0
arm so the entry-time refs are released on all follow_down() error
returns.

Fixes: cc53ce53c869 ("Add a dentry op to allow processes to be held during pathwalk transit")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/vfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 62b56d73432a..95ce15440492 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -137,8 +137,10 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		follow_flags = LOOKUP_AUTOMOUNT;
 
 	err = follow_down(&path, follow_flags);
-	if (err < 0)
+	if (err < 0) {
+		path_put(&path);
 		goto out;
+	}
 	if (path.mnt == exp->ex_path.mnt && path.dentry == dentry &&
 	    nfsd_mountpoint(dentry, exp) == 2) {
 		/* This is only a mountpoint in some other namespace */

-- 
2.54.0


