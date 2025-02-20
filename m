Return-Path: <linux-nfs+bounces-10215-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41965A3E15E
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 17:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E633916F73E
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 16:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901D0214806;
	Thu, 20 Feb 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFmuObO6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A457214803;
	Thu, 20 Feb 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070053; cv=none; b=naVSYB2PViR79fHMzss2O6bPa4SZjHrxw+bDyBcPrGm3WTO9+ikk0HXtFdB3+Sd7/VzRoVrMnSBg5ipqWXDG7JcWQrELMBMiYeT4Bf77RhgP++QGZKOCUmLi1QAMZant3wJJRWIfq33915BA4ZCYbeh2W9nh6MjuOwtMC5O/iDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070053; c=relaxed/simple;
	bh=Wft6oG6T8/oEeeQa1GWtph/ItnypOf1z1wIgrP2JdHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=prJ9APZxbBCNaGc1aoC5sgqzXZEHW8mN8WVe9UZN5Rbtziuu2wHRbRvdNYOjSyceeqJWUCBkoyXbubwsaK1AYxLrdKM59hZ11nDfTUUxXjPcYIXTh1Te2jrevMkqfyHrs/6atK+ltjDKJB34zXC3Ge98mECTUXYM/Yz1En/n4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFmuObO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC4AC4CEEB;
	Thu, 20 Feb 2025 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740070052;
	bh=Wft6oG6T8/oEeeQa1GWtph/ItnypOf1z1wIgrP2JdHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CFmuObO6Km08jTaUQ2diKRG0ueul0lafRhF/tjow4faEK1PLv14LVh7EsRgKAm8dO
	 ol4z33DhmRWzF085w4Mrw2eywo7gv3MMdrFK3nw/s1dfCtaBz5N06bArA7N8B+GGUN
	 hVrHwet3TtXKd8R2Nlp+fivB+AiKr3s+r6I2J2mKdOE/CB8OwFwKvfaJHhTFEHFAjD
	 Y9FUFjJrj6S02qsCCkSc5/vI0w3OXl4u6YgUtSOAQzxcJdyjR09idFvt07JlEN/FiT
	 56G/I73HOPlILcMMv5A4jOXZPuEcjMT8vv5VRUxhGJlwJQFsbUnrQvKBmgqVEYmvDt
	 /m2+bnxb5YcIw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 20 Feb 2025 11:47:17 -0500
Subject: [PATCH v2 5/5] nfsd: handle errors from rpc_call_async()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-nfsd-callback-v2-5-6a57f46e1c3a@kernel.org>
References: <20250220-nfsd-callback-v2-0-6a57f46e1c3a@kernel.org>
In-Reply-To: <20250220-nfsd-callback-v2-0-6a57f46e1c3a@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Wft6oG6T8/oEeeQa1GWtph/ItnypOf1z1wIgrP2JdHE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnt1yemp+lyVjGK9VZRdurO3X1oCmfc3OCc3xy6
 LEbJOQvmLGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ7dcngAKCRAADmhBGVaC
 FR2kD/9ltlTi8jLn1usSf6osbYMROoo7/bZ8zaop6ikyJu59DSN3apuyGSdR3vl+qr+Eh/9OzVT
 sbKxufKda2W/ciSdGVmW38zZ/3BlvObGMttGPQK93y3k0lqAz3qLYTUWm7VEH7yPb/IrA2aoz09
 HIHstn0JajBNQrm44YJoozhFXIakGfLK7AkWjNqfleufqIzooJZhJRpCOmjde7jR8+1gP8gKHjn
 t3tAzOPEtKU8mSY38BZ1nDvKuQeUa1sfQe42E13Sm7/EQz/g70sY9mm1bqur+mb2OtY3vyzkRAr
 u0Shk6Ex+HD0RK9+LPDhBcv+ZKr8j7fSltLzVu8Yz0BCkeAhWbpu/5D3NZJ7Aqur0I58eA6a2aT
 1p5p93JQkEaockCG/brCffe9ES++fAkWFRd3LTIqFGMhKwZxtqGhUGXE3oQoMuS+YBHrTdf8bmo
 Lqn9qx8W1rf12vxrJzgvRLGzJxrkvZ9/tF7r9QhDNXfuyuXo63qi2cCYe6aOb+N2joMSO0sQ4AI
 1HrtkPb0lBvqCKlhaKR0iCojM9PNinsfopgnuCkiWFpP+HkJipmfSjObF4uE7R4dsNleMh1StAZ
 PReoR1bjDQQr3w0uiiE1VcLsReT/Wg43mNLjAaqNqnv3FqnVLQ9yMOeGWMLzglkg+WI1mHA2gRv
 BkjihJtmT8jZdZw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

It's possible for rpc_call_async() to fail (mainly due to memory
allocation failure). If it does, there isn't much recourse other than to
requeue the callback and try again later.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 018533bb83a3ca6fda46e072eebca6d2583c393a..3f21de06154e3f80818c85a92d6044058339697f 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1592,7 +1592,7 @@ nfsd4_run_cb_work(struct work_struct *work)
 		container_of(work, struct nfsd4_callback, cb_work);
 	struct nfs4_client *clp = cb->cb_clp;
 	struct rpc_clnt *clnt;
-	int flags;
+	int flags, ret;
 
 	trace_nfsd_cb_start(clp);
 
@@ -1625,8 +1625,12 @@ nfsd4_run_cb_work(struct work_struct *work)
 
 	cb->cb_msg.rpc_cred = clp->cl_cb_cred;
 	flags = clp->cl_minorversion ? RPC_TASK_NOCONNECT : RPC_TASK_SOFTCONN;
-	rpc_call_async(clnt, &cb->cb_msg, RPC_TASK_SOFT | flags,
-			cb->cb_ops ? &nfsd4_cb_ops : &nfsd4_cb_probe_ops, cb);
+	ret = rpc_call_async(clnt, &cb->cb_msg, RPC_TASK_SOFT | flags,
+			     cb->cb_ops ? &nfsd4_cb_ops : &nfsd4_cb_probe_ops, cb);
+	if (ret != 0) {
+		set_bit(NFSD4_CALLBACK_REQUEUE, &cb->cb_flags);
+		nfsd4_queue_cb(cb);
+	}
 }
 
 void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,

-- 
2.48.1


