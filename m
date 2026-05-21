Return-Path: <linux-nfs+bounces-21757-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGkvBDQND2p7EgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21757-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 15:48:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF49F5A63E3
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 15:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2441E300EEA3
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 13:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C90312836;
	Thu, 21 May 2026 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nL/JmIfi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3522332E;
	Thu, 21 May 2026 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369953; cv=none; b=Br/56WjtUr3ePFZp1LxFLW7KapcBhYEDY1C6IpaQVdRRfSaeOpWc6EINJQQw2svARqRBIYjsoECnSV+Fo3haOIqE8uhULPRdvuY3fQu7ZUxLYq7BTvfGTa9EWXvc8ql/6o6LoZJfVxbH3bSJVZC85MZ5vqzp3lLcBcKRZF4WzG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369953; c=relaxed/simple;
	bh=f3JSTinykipr7bNDD8GAWbjJMabnnAYwd5YLw79glag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DZr19LDQwceW/Edl833uKZlLFsyh77N4sOe14yJx/NDS66men5YpHCWMlnHboAOO0rw+8kzjQsh/S3a4hqQ1mnpWFhlU5E/1LBco9EcudQPryOTYu7kkhX2McZUHu/TJxR+/zor3+6nJrVeDm+KfGSx5rkY4gsM4JBBohBdsfuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nL/JmIfi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA601F000E9;
	Thu, 21 May 2026 13:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779369951;
	bh=pvxycRKS1X1UAZRsM0QifyF6eCKSEZJrz3QdXOoBAgg=;
	h=From:Date:Subject:To:Cc;
	b=nL/JmIfigGXOZnUJc3UATF10E9+KnliXMa2DRK80/iwM2N2bMVMFaF0SdaCJbxcp1
	 0MXtxtQBFYAtUva+5CUbWm7c4KB/v1ACWfR2bpooAQmiV+WcQprnX9ICLztkP9KKp/
	 +4nyFTzk/S/exb+chCYXcj221XQrbrycslxpPEWgKCaHwXEjf3T8nkgRYlsYQJQVQg
	 QUkSFqINFZ1QwaGWn5PELzAEXi+UcIOK8hFQufAvzsM2MZ6C28STN0s0VDwMuSBy47
	 Sx4ogci5zbCZSfxQhm9VW1ewREtXhteDhvYX3+dcR3fF//IsTMAiNVho6En3bkDjwn
	 FXNYPdffApBkQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 21 May 2026 09:25:40 -0400
Subject: [PATCH] nfsd: fix inverted cp_ttl check in async copy reaper
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-async_copy_reaper_cp_ttl_inverted-v1-1-66b87cb1bf64@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3N0QqDMAxA0V+RPK9QO9RtvzJGyGLUwKglLTIR/
 31lj+fl3gOymEqGR3OAyaZZ11jRXhrgheIsTsdqCD70vguto7xHRl7TjiaUxJATlvJBjZtYkdH
 194E8XfnW+TfUTjKZ9Pt/PF/n+QNZTepJcwAAAA==
X-Change-ID: 20260521-async_copy_reaper_cp_ttl_inverted-697a0a3c850b
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Chris Mason <clm@meta.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=f3JSTinykipr7bNDD8GAWbjJMabnnAYwd5YLw79glag=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqDwfaxUapdsFYnRfUGidduNk7wUBq5aZKrmi56
 0kkGGcbyviJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCag8H2gAKCRAADmhBGVaC
 FfquEACScPE5HY+e4Wf+DV5jgsY3mp74mdRUF1CVsjIrVcrJLHRKlZ8pqG4c+3rdJzxia40wgDM
 Vf7QOhlyRBk+IdLUZNsLOgmMOZex0Y7mti3FuX6lOCtNRLC9F77LxZ7WaRppe+RxsYmHRWYGviC
 s47UzcSujVtGmeTSOAoR1CHL+Uat+Q2umg2Cu5UZVA3ZXMwvGbfzxMLJ08AE6Q5U9F8wWVfat/C
 cJez2bhlNxsy7PybEzLZ8tnrOhpKIfXA+Yl9xFmebxrp78+PeL4n/30fbUzC2I3+owd1Th+D6qM
 /aO1qBOQB5E1k+phQ+apZ1c6mM5MENMmAsduXPjFi07LNJvRgVWw1SaNm0Nodqq0TGgL7ok0lbC
 2IaU8ACWORyag3AgL1DoegIUHecj5O7zfZx+jv3xnWB1jqusXZsfBKGFmnFhBI7zIfYI/Gq8wgD
 6jTm7xg62bD3CJOyOpBifhB4h3hLiohXu2oSIoXDbm++MwopfLwATRyDDuVks9DMvX6+s/pPLZy
 +6PywcU8AHZSDwMUUXMwL7cPRVCKwsPre6tHHpo2eRQfNv+Vk1QamhQwK3LYuC/Ogn7MZX96SOD
 i5L5obokcUlSGGVI8nLFjqAeBisV6T//ZKE6r0+C/5/Av4Gi4apuHeQHTwSJCV33mQbUIfFCAfG
 IzpYR4X+4k2DJmw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21757-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: AF49F5A63E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd4_async_copy_reaper() is supposed to keep completed async copy
state around for NFSD_COPY_INITIAL_TTL (10) laundromat ticks so
that OFFLOAD_STATUS can report the result, then reap the state once
the countdown expires.

The TTL predicate is inverted: `if (--copy->cp_ttl)` is true while
ticks remain and false when the counter reaches zero.  This causes
the copy to be reaped on the very first tick (cp_ttl goes from 10
to 9, which is non-zero) instead of after all 10 ticks elapse.
Once reaped, OFFLOAD_STATUS returns NFS4ERR_BAD_STATEID because
the copy state has already been freed.

A secondary consequence: if cp_ttl ever reached zero (not possible
with the current initial value of 10 since the copy is reaped at
9), the copy would never be added to the reaplist and would leak
indefinitely on clp->async_copies.

Fix by negating the test so that cleanup runs when the TTL expires.

Fixes: 26e6e6939369 ("NFSD: Add nfsd4_copy time-to-live")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 85e94c30285a..72f410fd7a8a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1467,7 +1467,7 @@ void nfsd4_async_copy_reaper(struct nfsd_net *nn)
 		list_for_each_safe(pos, next, &clp->async_copies) {
 			copy = list_entry(pos, struct nfsd4_copy, copies);
 			if (test_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_flags)) {
-				if (--copy->cp_ttl) {
+				if (!--copy->cp_ttl) {
 					list_del_init(&copy->copies);
 					list_add(&copy->copies, &reaplist);
 				}

---
base-commit: e91f16e59f513a1e3fc052e2b630efebeaf9a4f2
change-id: 20260521-async_copy_reaper_cp_ttl_inverted-697a0a3c850b

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


