Return-Path: <linux-nfs+bounces-9982-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5769AA2DDC3
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 13:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991F41887583
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C105A1DF98E;
	Sun,  9 Feb 2025 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLOlaLkS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959021DF980;
	Sun,  9 Feb 2025 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104299; cv=none; b=W8wpcqquhYRxurfFC7KidoSO5+2lt1wPNu7yvE/KEvW7GpL8qbZuMZ7HLjIIdGhxkUMvLklY/q3Dvl1nBfVZRvxg80pPBDxIRrIKd7+1mtSkfuH1GLSIlmAMHr19FwNGLBQmrBOkFFHTEN18amPg9JDv3tZT5oz15vDQUgyHgas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104299; c=relaxed/simple;
	bh=uEceOfOTweUpIYrM6qPyO2S8wS1ZMcH1/Lwhefs0PG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ctCTC/NmJvD/H/Yi5vpMezmDmkTmGmn1qKU5ARLqMjucw1sWOwPf98y6BmBK/ZEPuhYbOJNECY2JNi78OLerKsd3c48QNOWmounRz+GxJo+pYvKkWKv83w/iKbuTIACr0vNQfiRXprgF64d/pTS2EeogZSDZBHS+UYyo2gRtA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLOlaLkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F0DC4CEEF;
	Sun,  9 Feb 2025 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739104299;
	bh=uEceOfOTweUpIYrM6qPyO2S8wS1ZMcH1/Lwhefs0PG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TLOlaLkSS8CveN9QLj1u6bV5uhv0Uj4hnSj7/D6fYsITNFIt61dObYebROFEqRAgv
	 v5QsEd7vSQFxxjHqFU+scK8qHZgGN6QlRJkZ6NOOheeHdGPcZZ/8fztuicb7H8L5+L
	 9y4m2tsXvLdK3xZLYcBLtlWVjZl10lZ4ykZqfcmoeWMeFQP1tJAw8jcdqn3PJOFGej
	 mNoeP1teL+CefIdW5UCjYcyUWtBvMVXfVz/48q2AUIiG9R/WA4GTYti334btKQHhRY
	 qiQyuob9HctWeJCE193JftApQATE1/In7xJbSufV8uTt+qCSQT5Cy6CZu5QFM8uv43
	 zmtINoYMEXBEA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 09 Feb 2025 07:31:27 -0500
Subject: [PATCH v6 6/7] nfsd: handle NFS4ERR_BADSLOT on CB_SEQUENCE better
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-nfsd-6-14-v6-6-396dd1bed647@kernel.org>
References: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
In-Reply-To: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=995; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=uEceOfOTweUpIYrM6qPyO2S8wS1ZMcH1/Lwhefs0PG0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnqKAkMfnHqCJZlEW5Ykiq8h54lDvdowN8p6Mmt
 +9oeIn5sFOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6igJAAKCRAADmhBGVaC
 FbB+D/0ex2NjVBfoMQcdH5pLVT60pUYRzjPQ5K7iH+xFcmql076jqY6DDyR0BAnjflQ8OeCwCeW
 GUxpmhpGix81hGKvZagVSUYPhCn1pmnNzjJpmfsPcEEof13VZXtOBKiNaOSyjHVyEFPer97zbE9
 GY+0rQJNZdzGt5BNxG8V8xjKrk0sBJ9kc6jZOhmUnf5yTWyuRMz4uGyqrp5u9YdGX3ujExHB6kJ
 aoMyqBM9/yXHa8mNEJH2GXtJpgtrIZCzOQ+rhE8r/R0P/z0SIkBC/0YYE4B6WkO2uWFean9IGkk
 GIiT8hQaYUxqKHHc93kEkl8wn6saW5JUVwim4sLszYvnYpFl62OrkC3DQGbsdE0RczAHaeIMCDs
 yngW1pYeJiba9+XxZ8cDbbsd9I9zeSJModroQPbNvr9aOvKS8iGxRXk5U65IXpKMinn972RIVf2
 sNMRTzF8L8Hu+rfK4m8NHdxBjouuBPl/nchk7sc10e3nhj6SUvgk7fS51GmrWveFpjtx1gmEkMx
 U5zKg8y90guCFfcoNJoSllsoNB8aTCnGpXScBatnb5z8XrzTDzVaGoN2Uc6GRgCEGEUitGExIEQ
 AcczO7Q6gPCXv5YFw7iRZN0dmsFrrbYu3/G66062nNLky49qsZf/YhAla0fcan/hpI2A71Ry3so
 DjC0Dc4aXZxiEgg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently it just restarts the call, without getting a new slot.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 18803ebe2bddd433308cabd6f99b64ec887069a7..8ba1a2831e8601ac3af9c5f147d3dcddcc1bec77 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1389,6 +1389,13 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		rpc_delay(task, 2 * HZ);
 		return false;
 	case -NFS4ERR_BADSLOT:
+		/*
+		 * BADSLOT means that the client and server are out of sync
+		 * as to the backchannel parameters. Mark the backchannel faulty
+		 * and restart the RPC, but leak the slot so no one uses it.
+		 */
+		nfsd4_mark_cb_fault(cb->cb_clp);
+		cb->cb_held_slot = -1;
 		goto retry_nowait;
 	case -NFS4ERR_SEQ_MISORDERED:
 		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {

-- 
2.48.1


