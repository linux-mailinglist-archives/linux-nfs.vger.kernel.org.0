Return-Path: <linux-nfs+bounces-9980-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2315A2DDBF
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 13:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D842164EEB
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 12:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2141DED73;
	Sun,  9 Feb 2025 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqiHea+j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AF8243378;
	Sun,  9 Feb 2025 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104297; cv=none; b=oPN/mhR2YXdjZf8Agoq+8ePNl+XrEhkQRvHM0mGMISzGwN5lnhWbXI+sKPDUxFe7TuP7ZWq9XLolpBvLBn4bkrmDLhzepYa6gez0P8gNFZpMKJikk0dq1x7MXxJPzDoueb8yc3cP1iysp8fn47BOAIBP6+OjVjcWBUrkr87ob80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104297; c=relaxed/simple;
	bh=6qs4KEh6BP5gYfAONsh/Ruc8BEtsMmRYjEFJ2fGMAOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npvUrjujLL4ieJ7jzDzKwVubohBK+jkj5eP2IPzckfUIWr8keniNJsGQpfgGVyAWxHXhOpiHpkaOHEz3k47/9Q1rY1x38YPSMdEAw0OR5quODtesNMo7qM5adHy+r256i7NCZ4cj+qzZOlppg9IPjVC8zi8/TxSUwc/4gYONH64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqiHea+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D9DC4CEE9;
	Sun,  9 Feb 2025 12:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739104297;
	bh=6qs4KEh6BP5gYfAONsh/Ruc8BEtsMmRYjEFJ2fGMAOs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BqiHea+jgEnke+y9fgdQIdD6rbAYEpw71ZnSC6Sx0Oqw/Jx+tb9oudxeUNxNSnHWb
	 rKWtAekzs4lNpIfgxwQrsfjMadqrQf6tKIAbcdaYhrYfD1DkDPRPhA2vLoOtUTaFly
	 TSO6INjEyVUb6KR7Sq4DLbLOLoi+qrFgMX2ysm7tdJEN414lgvr5gKJR0dAfTsbQdm
	 uiFQeka7CmDroZY6I1xklHJ/cKhO+B0irhrga26MfdpZFofPVK0n4UtBriMoqYrMjg
	 XFVdGLuszuxO38kuj6NUPi905od0itNvUKhkPEH+56RaU1ggUcPUyIym2gwq9pk8R3
	 6nbJj63zZi9Ig==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 09 Feb 2025 07:31:25 -0500
Subject: [PATCH v6 4/7] nfsd: only check RPC_SIGNALLED() when restarting
 rpc_task
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-nfsd-6-14-v6-4-396dd1bed647@kernel.org>
References: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
In-Reply-To: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6qs4KEh6BP5gYfAONsh/Ruc8BEtsMmRYjEFJ2fGMAOs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnqKAj33NOGGmOHz9LxEEcJ0Scy/MVzlAJqUJNp
 kIcu49dfRKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6igIwAKCRAADmhBGVaC
 Fd83EACFizt1o5oaU2/rw4euXsAswdIH+NgTmiFAO/v0mwqAVtfLG3rgf/p1bGyYoaRfio+cgb8
 5HcH03sriljR22+IPamd+qXWO8lSrFHOvcyHIWOLmaIIq87iEGLkchKMhKFjunNCV2sNtMrIgyl
 T8I3TqKJp4hPiiMxMieAEKqKX73fljyVUDHbc9JQM4oWwsjIs8EYjFSje+tMd51MRUWLC/UpKl8
 fhyUa1Ci3AFIoyVoNUvZXBMSLe7U4YuzACJ/QaUnm78o5ile5F+OXhbg9ISEyeikxaLTgDsbnBQ
 HmSkIB8x0K3bNDl3CejiJKvY4HNyWmKBZa5OM4rDcdfEm/qBk7mBRFHB3h2Ds9yuynHq8h1NyZr
 VTnIT8ZjFnNJ30G85MV384FPVTddY5RA+5yUIH9Q1W9w8O3gEq9Ua+bD7P4SWW0USlBsGzbKSsP
 uuaK6t/8RyjKJjBLkObtR1PDtiGWV0RrfvyflruyOEcKe6BsliCJaQ0Z9iywSBvR7WWVm3gLN59
 br3KVCy600KLY6wPScYWWFOQ78KrUCtlQI8bxWZ4LnHW/kNyhZfnwCwuuVzv8DeuCPSKr4twhLd
 goUfHNCzgexwI1tQv2+7xwN3A+b2Z0q3TxGehi7Xnk0aC7fOULiUU5X+iXXFWO45S9GvO+Qp3wo
 OH01ORtaNCv0xZg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

nfsd4_cb_sequence_done() currently checks RPC_SIGNALLED() when
processing the compound and releasing the slot. If RPC_SIGNALLED()
returns true, then that means that the client is going to be torn down.

Don't check RPC_SIGNALLED() after processing a successful reply. Check
it only before restarting the rpc_task. If it returns true, then requeue
the callback instead of restarting the task.

Also, handle rpc_restart_call() and rpc_restart_call_prepare() failures
correctly, by requeueing the callback.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 7596d0f7dcad44f462ca483979b9c9138ab5dbaf..8cfd6ffa6e18c4db5924d35f7b3344dbf350700e 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1379,8 +1379,8 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		goto requeue;
 	case -NFS4ERR_DELAY:
 		cb->cb_seq_status = 1;
-		if (!rpc_restart_call(task))
-			goto out;
+		if (RPC_SIGNALLED(task) || !rpc_restart_call(task))
+			goto requeue;
 		rpc_delay(task, 2 * HZ);
 		return false;
 	case -NFS4ERR_BADSLOT:
@@ -1396,14 +1396,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	}
 	trace_nfsd_cb_free_slot(task, cb);
 	nfsd41_cb_release_slot(cb);
-
-	if (RPC_SIGNALLED(task))
-		goto requeue;
-out:
 	return ret;
 retry_nowait:
-	rpc_restart_call_prepare(task);
-	goto out;
+	/*
+	 * RPC_SIGNALLED() means that the rpc_client is being torn down and
+	 * (possibly) recreated. Requeue the call in that case.
+	 */
+	if (!RPC_SIGNALLED(task)) {
+		if (rpc_restart_call_prepare(task))
+			return false;
+	}
 requeue:
 	nfsd41_cb_release_slot(cb);
 	nfsd4_requeue_cb(task, cb);

-- 
2.48.1


