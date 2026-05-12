Return-Path: <linux-nfs+bounces-21544-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAk2I191A2rf5wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21544-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:45:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3143852815D
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BF3A32F254C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254A234405B;
	Tue, 12 May 2026 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVMjmQ5b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0265936D9FE
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609644; cv=none; b=X1UoWbOIxH63ox5d/ZFMDBM3tE5xMwcDSRp8Xjgg/6GcCPiWnq+dElMsqIME+xcdsePcyfEQxsixsx7B5b4cZUjO01o2zOAHiACQsw6s92xltWCMekmZa2QWH+miYkuH+NYSfsAwuwk90DQFhYs99c76RnNtqKD+7/Q7lqTlGWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609644; c=relaxed/simple;
	bh=J3YRhC7aRvOQE0PE0HjCTBZ0ghkpiThKAq0jE1lLfMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wt51u/6DpjOSJitr3Wpa4Wq1VcDT2i65TFsGfsrEfjP8O+z04GPaIz6UVoaNeCFaQ0zzwA+NbgIJDc1KrEksWj4I9ZqwuFHBYyp5HWMwwAZ92B+H5azN4+9K7cu/AxInO5GeOmU3naz1Ccyp8P53B6HsVgk2ypnkroQylEwBiHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVMjmQ5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283C5C2BCC7;
	Tue, 12 May 2026 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609643;
	bh=J3YRhC7aRvOQE0PE0HjCTBZ0ghkpiThKAq0jE1lLfMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QVMjmQ5bfSRvFSVbYmTyzQeSzFBKaaDI3ZJSEk4gGNBLU+89CvX0J+TOTVjZq5u6W
	 FGg7n+1pjy/zgndePXljR//rAZSUVCblkqW8ekmUXy7G/Mou/p4cuV79YHeTHwmbJM
	 XWjij0hdktmsGz6z4vn+tpLYavzEoC5j0UP7f6Ke193pkkafbFK5VlG4hB7VICuPFN
	 kBLy/dAU1ARjbmVRNVj4FhWSC9LM8oi/p4TWBRDpwOgsu7TTl5/8P50jUEjeed4TH+
	 O3ElyEhcsAXh4w+gS+ig21NH7jvAXTxGbZsZpt63O/PZUGEQ8EqgL8kKUqIhDPOGCs
	 loPZHIpkXhlng==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:39 -0400
Subject: [PATCH 04/38] lockd: Translate nlm__int__deadlock in
 __nlm4svc_proc_lock_msg()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-4-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=SOJYkqaGcOwEdiY7lWEBNxSfc3qLWVG63lUXEx/RNM4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23kmyPxLrht/36daI67Im2vC7atwJ/6kKtyT
 gXcdl4FoxKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5AAKCRAzarMzb2Z/
 l084D/9VgvhNHPIMQHTR3hxx4DZGVYgw46oPhaIzwQmheK7cqaazlPnroukRtNy7DAGgUJ0VJKq
 SX4hUQ7+onK36HKDOTQyo6ep+75u/clq+CsRnPUF359ElXEddYqkZ1yO7eg7TBETtBz4ZzHacB4
 IQZkmR5uuOoIdAP+znR+MoXO0Nw/GCXyAxpNRDY6iSgACr4vO6V5I50OyHq1fMtuidd8l567PHx
 vYdSa/bpNrddJ3gjfbgjcgRCFCngGy1aicvQZb6b+TU0+/efWWavzfx7QdhQiGtQRbhdqj09Rro
 4ZNqxgzBfU2q6oCXN55sLZrYD6Hi2lgwIGVfXK4SDBZDPFkmSsv8nQ5einl9G+9aIym6AIpxcj7
 lO0VcufJ/8BjUpTMW0/a/Gp9WQ8qN5mNePVdi4TKmNm+b37raaEt+iPGolnwUL1THDxZ91ZfUAM
 1g8lJfE+y/021JRT6iOS0mgfIAKeG3wLmscmhjDsHkz2trgPPn4/GSSvehxB6nEabE88tv8xdqD
 5vokNQLDvDGI23fiscBNDS/ElUvCLO52C4sacCpwC1IUmfg7j4cok4LZCsYHepNqmND7xRPpWSN
 BeLlTgvHSvaIgW55EGPL7Bq/Vpa+u1lRLhLYsvQ9C6aCC8abhKqMAXfEaYuIDdd1Akx0npHoSPV
 ebQc8zRKGj1SKdA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 3143852815D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21544-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

When nlmsvc_lock() detects a deadlock it returns the internal
sentinel nlm__int__deadlock (30001), which version-specific
handlers must translate to a wire-valid status before the reply
is encoded.  The xdrgen LOCK_MSG handler stores the sentinel
unmodified in resp->status; the LOCK_RES callback then places
30001 on the v4 wire, where the client rejects the reply.

Commit 9e0d0c619407 ("lockd: Introduce nlm__int__deadlock")
established the translation boundary and updated the synchronous
v4 path nlm4svc_do_lock(), but the xdrgen LOCK_MSG handler added
later in commit b2be4e28c23a ("lockd: Use xdrgen XDR functions
for the NLMv4 LOCK_MSG procedure") missed the corresponding
remap.  Apply the same translation in __nlm4svc_proc_lock_msg()
so deadlock results are reported as nlm4_deadlock on LOCK_RES.

Fixes: b2be4e28c23a ("lockd: Use xdrgen XDR functions for the NLMv4 LOCK_MSG procedure")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 2bd71bc2b481..886b56317e5f 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -668,6 +668,8 @@ __nlm4svc_proc_lock_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
 	resp->status = nlmsvc_lock(rqstp, file, host, &argp->lock,
 				   argp->xdrgen.block, &resp->cookie,
 				   argp->xdrgen.reclaim);
+	if (resp->status == nlm__int__deadlock)
+		resp->status = nlm4_deadlock;
 	nlmsvc_release_lockowner(&argp->lock);
 
 out:

-- 
2.54.0


