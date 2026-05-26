Return-Path: <linux-nfs+bounces-21983-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKu6ByLOFWqwcAcAu9opvQ
	(envelope-from <linux-nfs+bounces-21983-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 18:45:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0235D9EF8
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 18:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6A08301B507
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF5E3CF67D;
	Tue, 26 May 2026 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRJ9GdpF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3D3C9EED;
	Tue, 26 May 2026 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813547; cv=none; b=e7c3ERCoTxsFkJExay+YuaELbqy55/bQ/uwzVpv57M3JyR9ys8QfT/k3KKKvA5BdWwamI73uCV4Ls1S85eDTOBs5qKNGGsPA2BsqhTKatsNzyAZgSHWbeb9nhyHuD5d1DSesSYu0B4uP/Fc3RWg9Dgw/D7Apl6YQzIcSo2lYRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813547; c=relaxed/simple;
	bh=oBiyUV3sb+iaaUesrbu3m1O986pr2EXCTNctR4cskBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=axrmBOHi6X+v1cMflsxg+d7O2uh9tQYWKf9KdkwxQSml8QVsPGTeyBo3pTTBzyvQzKgMExHH9HKIMkCr+Owp+YYlN0EuHS03eq/NP3l9KTUvKIMRPtVgl8qevhfygg+GzltTN6D5OtaiIBo1uH1BK/5BibS732Y8kfw/EsQOz5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRJ9GdpF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4651F000E9;
	Tue, 26 May 2026 16:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779813546;
	bh=DWieJrj4IvMbaWC9sJ0oUMZcM7jWqQaqKc83yl2am7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WRJ9GdpFRpe+N2Cq7Rt6aFV9nbEdU9C4gVIaaGmSHQG1RXQqOcypLrkUB9K0fUagC
	 v54UrR8akKrvqr6ETlWqxOBW1YOJmoagJnTMgDo2vXzWt1MPMWoR6i63wq0yWvw24u
	 yM/nRKgyvaDkS8sLNggO2oXdxGpnXBKwbsZFu6XADc+SroiuGedMvVfsmf5tuNEQxZ
	 TJzg5d0eUHqSDbnlRYtXWg9i/ZnTA0b/zTqO8auHQVyoO0wiN5FnJfLmS68Up+8f1Z
	 Udxbi63Ex+EmBxIBxGPca4w/J3n4O+5oxlE5VvltGF3mROEMPWjp3GRy7xl7+sD3d6
	 7VllyN8Tlh4Cw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 26 May 2026 12:38:46 -0400
Subject: [PATCH 2/2] nfsd: clear CALLBACK_RUNNING on failed delegation
 recall queue
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-cb_recall_any_callback_running_stuck-v1-2-310011a028f3@kernel.org>
References: <20260526-cb_recall_any_callback_running_stuck-v1-0-310011a028f3@kernel.org>
In-Reply-To: <20260526-cb_recall_any_callback_running_stuck-v1-0-310011a028f3@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oBiyUV3sb+iaaUesrbu3m1O986pr2EXCTNctR4cskBk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqFcynpfyLsYChSKYRHZqyANynVbhFNJ0Pme+Nz
 39VYtDOyeeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahXMpwAKCRAADmhBGVaC
 FQY7D/9EvrdvD8OOnHtjf6Z1vBO86TKXEMv/XB0qcaNsCd6TBZtDo8L6doE3S1aMX7cpjyjnGHn
 zEev+pAu83oLWeOgAUh94iuKHPZGyhYk3nV2Qf0OPg/8OVYFpTyvt/otbjhiMQnXqhLrQPjglEN
 SPbIkdm8aE+GuutFV5NTsJqAWa1qpK5Khvdq79BWQ1jCDHjTdAu3tD+KUD/5fhVduC+ZFf2RC/G
 DzH6/ziLCwyo5s6B4BR9wzxFLwQt2dUhX+2o3epf5pi6AWGHRFuaDakolWCH+L0SbQpzM4eSVPT
 nkXF3FQNIeelU6ZHMDeNF+i7UidWGY/hdvfmPYdM2VVwMvbkHk5OkXKwkI/See4LdmzTU5LPaQY
 ArKmqkQbm660Q2e6D4bb3b6aZSSk5+UazJ2LRggMg2vvm83KIELx5ejZUJgD3X4w8OrjBGWQ5Yy
 Yew4u+h0FdX7HlZKvgbBYZUytJ+2EfpYi/9SE+5+M3ftpD0riloZ+lN2DpuC1w51F7HMGkuLAO7
 aZSXQ4TlpYZKSvRGtpQ4MaqhgyYqTmfK57h6ScVxRFY2cUZ0fsWnaB5rQ4+g4nIQArxCU5rM3qC
 tWod7vGzm0Mk2qDCVEYmNURZRiV0+PXQjaHSETUCEE8r/a0TTNz3nSVBkDVcushPBS0AhLbEZSG
 y6xMig2zAOJJ28g==
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
	TAGGED_FROM(0.00)[bounces-21983-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 1F0235D9EF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd_break_one_deleg() sets NFSD4_CALLBACK_RUNNING via test_and_set_bit
at entry to serialize recall work, then calls nfsd4_run_cb() to queue
the recall.  When the queue attempt fails the refcount bump is undone,
but the RUNNING bit is left set.  The only site that clears the bit is
nfsd41_destroy_cb() (fs/nfsd/nfs4callback.c), which runs from the
workqueue and is therefore unreachable when nothing was queued.

The bit becomes a permanent latch on dp->dl_recall.cb_flags: every
subsequent break_lease() on the same delegation hits the early-return
guard in nfsd_break_one_deleg() and silently skips the recall, so the
delegation is never broken and the conflicting open or lock stalls.

Fix by clearing NFSD4_CALLBACK_RUNNING on the !queued branch alongside
the refcount_dec.

Fixes: 1054e8ffc5c4 ("nfsd: prevent callback tasks running concurrently")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 57b99d1e74a6..0b4d7afc42c6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3479,8 +3479,10 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 	refcount_inc(&dp->dl_stid.sc_count);
 	queued = nfsd4_run_cb(&dp->dl_recall);
 	WARN_ON_ONCE(!queued);
-	if (!queued)
+	if (!queued) {
 		refcount_dec(&dp->dl_stid.sc_count);
+		clear_bit(NFSD4_CALLBACK_RUNNING, &dp->dl_recall.cb_flags);
+	}
 }
 
 static bool

-- 
2.54.0


