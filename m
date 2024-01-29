Return-Path: <linux-nfs+bounces-1566-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3582C840BF3
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 17:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14DD289D2E
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4B5156980;
	Mon, 29 Jan 2024 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laRNPT3c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12A15696E;
	Mon, 29 Jan 2024 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546609; cv=none; b=kuNj0dJHWDIm08Gz+Iywlyibg6P5JIOk3CnSoGKWbUXhY8MRjIY7eYTUgIhzowUUMFQQsmYjVQ+IXAV27SzPkTSCtF7DrvVWjAvmRP/5mKHEFXQZIjNbkvULLMOD6wa8c780D9LkLfAQTC3s1+wYIameZMsK+hc8nsfHwmgLD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546609; c=relaxed/simple;
	bh=voj97DXC6XBrs98JAwhjCQUkvl5U2tQpl3APSKbLqyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gCZ82/xDxSKe8Ki0KK54YirXJzt0+aSDX0E3h5QniveFNm6C+SyerAOWc/BQZIUFtt06AvsX1yIdElBQF5v1k4I+wbttZiMXwZ2soXP/zCQwcCenlpnvdalPT0Ihm4gN+gwcu22k5hh++kESM7W9TLjEX6gKbzuSLfSYWnkYVUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laRNPT3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFCCC433F1;
	Mon, 29 Jan 2024 16:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706546608;
	bh=voj97DXC6XBrs98JAwhjCQUkvl5U2tQpl3APSKbLqyI=;
	h=From:Date:Subject:To:Cc:From;
	b=laRNPT3cOAwnQoEFi3BWxg44C7ZxS1WSuHp4MA7uMGDaOp2GkeTHIXBRppySguNeV
	 zIm/Q9MeLm3smjFn8s177bZPzIgKHhYx61fkXfnO8bDJpkyiPr534K3g/TiWW637eq
	 Uiy9Lq4eXf6k4lRiJNYFCnhtAXTSx0Ce9L4ZZeZciykEgois3svBp5qefEtc7O/h7w
	 Wh26qh9Y28cBikTd7OYuh/l4H8cNhcX3uzLEv/WyGApedFwBz/HczZBiEnIS+hqNhD
	 Pq9oJzuRvQ42fEkxscPIcqoyeIBP7n0HoDVU4SfriVPL3DV6H7mxHjmRRNWj+npqkU
	 2VEcSL1WZskQQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 29 Jan 2024 11:43:15 -0500
Subject: [PATCH] sunrpc: fix assignment of to_retries in svc_process_bc
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-nfsd-fixes-v1-1-49a3a45bd750@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKLVt2UC/x2LQQqAIBAAvxJ7bkGlKPtKdDBday8WLkQg/j3pO
 MxMAaHMJLB0BTI9LHylBrrvwJ8uHYQcGoNRZlDaWExRAkZ+SVAFO056dmr3DtpwZ/pF69et1g8
 /ZnwAXAAAAA==
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Benjamin Coddington <bcodding@redhat.com>
Cc: Anna Schumaker <Anna.Schumaker@Netapp.com>, linux-nfs@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Aring <aahringo@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3126; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=voj97DXC6XBrs98JAwhjCQUkvl5U2tQpl3APSKbLqyI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlt9Wo3maIIq7zxY5nmGdTf+p0pbNUVaGRsBRZl
 dsQCOfFqFyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbfVqAAKCRAADmhBGVaC
 FfXkD/45Y8ftsDp8DK1GXuy+/AT0x3FQytqhaMUXtSnfYnUsx79OWGVAIUNoKCx0G8+LI4DKWUk
 fN/Vs/YRtn2oZ7UOjpUA2aLn9jTWOk73KMtbEjtt4AaT6i92C0LK65TXaQS4z8i2WF8Ck6xJXCk
 Kx8gm9VkpgYjMLgIrhJdDZk3JDJ0mtWZQunqmm+oc2D6UPYbvbB0qKYDApcVqwk0CW4ZPvp7Qnl
 N8Ug9RzE2DyJIVWs1mXmgRrmBHR1z25+vI4CDS2Y5GHexCHQ9+gyKUGBg8aC3TMNqP/I+eU7/0t
 Dmh37QFdrmY+YDxT6cXM4B22Bsjb5LZof5bZLG0+ZKTHbAjhUMYfXXWFm7mj39auWROWMjXSB1/
 QkMsdx8zV3Zj+XM/Tr0Zv8ZtQ0lMXjzAETlyQPmgS8+TVlQ8qrBlEBLZE+bl08r88HCo14cNiMm
 ZsO1mIE4Sj7HymHwCNwQdGNvVVAMAx/p2sfKi0STPBy0YvokRYwh03pOgw2RVuBRz7UxJf/ixLv
 TymzJcd3vgky1AuoaNN+NUu0q5PQLIufoXwEpoBqYmOwIHBPLUVIw60WC6Fa3tVNac8S/8p2mQC
 z2BkMgwc76tHX5Sn4i4NZj+eOx9yaDriYiMJdROZzXpCUlbjv2sJ/7Y0Xkxg/mlLU98wu3tTyHJ
 ydUw+goaJXhjdYQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Alex reported seeing this:

    [   18.238266] ------------[ cut here ]------------
    [   18.239286] UBSAN: shift-out-of-bounds in net/sunrpc/xprt.c:660:14
    [   18.240699] shift exponent 60000 is too large for 64-bit type 'long unsigned int'
    [   18.242277] CPU: 1 PID: 290 Comm: NFSv4 callback Not tainted 6.8.0-rc1devtest5+ #5814
    [   18.243846] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.16.0-4.module+el8.9.0+19570+14a90618 04/01/2014
    [   18.245460] Call Trace:
    [   18.245855]  <TASK>
    [   18.246200]  dump_stack_lvl+0x93/0xb0
    [   18.246785]  dump_stack+0x10/0x20
    [   18.247308]  ubsan_epilogue+0x9/0x40
    [   18.247875]  __ubsan_handle_shift_out_of_bounds+0x110/0x170
    [   18.248727]  ? ktime_get+0x130/0x2a0
    [   18.249317]  xprt_calc_majortimeo.isra.13.cold.45+0x12/0x23
    [   18.250184]  xprt_init_majortimeo.isra.27+0x9c/0x150
    [   18.251062]  xprt_init_bc_request+0xc1/0xd0
    [   18.251728]  rpc_run_bc_task+0xd3/0x1b0
    [   18.252328]  ? __pfx_rpc_run_bc_task+0x10/0x10
    [   18.253045]  ? __this_cpu_preempt_check+0x13/0x20
    [   18.253780]  ? xdr_inline_decode+0x5b/0x260
    [   18.254447]  svc_process_bc+0x3b2/0x4d0
    [   18.255069]  ? __pfx_svc_process_bc+0x10/0x10
    [   18.255755]  ? __lwq_dequeue+0x5c/0xe0
    [   18.256350]  ? __kasan_check_read+0x11/0x20
    [   18.257002]  ? svc_thread_should_sleep+0x15d/0x190
    [   18.257754]  ? svc_recv+0x918/0x13b0
    [   18.258321]  svc_recv+0xa7e/0x13b0
    [   18.258892]  nfs4_callback_svc+0x53/0xb0
    [   18.259508]  ? __pfx_nfs4_callback_svc+0x10/0x10
    [   18.260227]  kthread+0x1c2/0x210
    [   18.260744]  ? kthread+0x103/0x210
    [   18.261278]  ? __pfx_kthread+0x10/0x10
    [   18.261872]  ret_from_fork+0x3a/0x50
    [   18.262433]  ? __pfx_kthread+0x10/0x10
    [   18.263024]  ret_from_fork_asm+0x1b/0x30
    [   18.263684]  </TASK>
    [   18.264348] ---[ end trace ]---

to_initval can be very large and cause a shift overflow later. Ensure we
copy the correct value into to_retries.

Cc: Benjamin Coddington <bcodding@redhat.com>
Reported-by: Alexander Aring <aahringo@redhat.com>
Fixes: 57331a59ac0d NFSv4.1: Use the nfs_client's rpc timeouts for backchannel
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/svc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index f60c93e5a25d..d86bf5b051fa 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1598,7 +1598,7 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
 	/* Finally, send the reply synchronously */
 	if (rqstp->bc_to_initval > 0) {
 		timeout.to_initval = rqstp->bc_to_initval;
-		timeout.to_retries = rqstp->bc_to_initval;
+		timeout.to_retries = rqstp->bc_to_retries;
 	} else {
 		timeout.to_initval = req->rq_xprt->timeout->to_initval;
 		timeout.to_initval = req->rq_xprt->timeout->to_retries;

---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240129-nfsd-fixes-0d95718a0bca

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


