Return-Path: <linux-nfs+bounces-9556-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3678BA1AB4E
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 21:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D597016C950
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867751F9412;
	Thu, 23 Jan 2025 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmQvZ/1r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55D1CCEED;
	Thu, 23 Jan 2025 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663944; cv=none; b=ZVqHhV+K7okLCRk1G71R5NelPBoncHumApEtFVd4ZhgDG/hmUAkufRJL05YpjEy3u2Od1jRNaMCKWlSFfeQD2WpuKDw4ALevJE+PdVU26hk0Kox+gpDfVGsy+NzWROIQX54IzjoMugCSeQitJFex5Gb0hD3mBnrIFC8LM2mxyd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663944; c=relaxed/simple;
	bh=8jE8AV+5NZQfqaq9QWaFF6/enwy/4N/euWyTI3i5WO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2/LmVDxjIcyZOd7mXoVQLqhv6URfgcizIM06TgamImWsclpF9r7bKzIo8EzhGZp3ZaLPswnj+yBMXVH+VTx69TOK7CD7xQTQszA4PvNkLlvMJcCUKj890IgtSg3NdqhbH8BJEH3zJjBsKbeUMa/FVB/mdaT+2OnMsOjY2qxtpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmQvZ/1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D368C4CEE3;
	Thu, 23 Jan 2025 20:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737663943;
	bh=8jE8AV+5NZQfqaq9QWaFF6/enwy/4N/euWyTI3i5WO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RmQvZ/1riq0hIcj2WRuuWY475X8JdbK9cl8TPTjt7HOMIY+Fy794JNokztZ7YRiYS
	 k8Y7rTYfc1Y2oNtRDh9itw79pty8DZje4squzNbniwnCEXFL4Rb9gqq/jP1ilSgH5c
	 EIC+PxHwEjnFoFm/nD/kjfDq+Wf3i8SJlF5VHNBu39E6CZCWwzXOOL28XCpur98iX1
	 nfaATVtUwEhqExOsUK7mnD9ahBqw6X5Js02ESO9BF4AX6yv2NSm0IdZz8ZUNJMI3NR
	 FiGKPwBR9cVpYc+CAEh0vQU62PD/ULFG3y/Hqd78yL+nrJvtkgiWqOK7sHTe/BPr5/
	 MQGVS581s2ErA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 23 Jan 2025 15:25:22 -0500
Subject: [PATCH 5/8] nfsd: reverse default of "ret" variable in
 nfsd4_cb_sequence_done()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-nfsd-6-14-v1-5-c1137a4fa2ae@kernel.org>
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
In-Reply-To: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1602; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=8jE8AV+5NZQfqaq9QWaFF6/enwy/4N/euWyTI3i5WO0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnkqW8n/QS7u6slO3VkLC01yGiqSgaUr798KUml
 RAIUKrL9EqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5KlvAAKCRAADmhBGVaC
 FQ4wD/0R6HsSEh2umD60HSYqVcjvTzxEcdVXkzCxyU4HqOqelezMh7O8TN8ScU8mOUvSQ+0+d6e
 97JHPijsa+sJkDJqa64R3gdFomorrc3cz565GXUaQxdsn8kOMSUdYVaCIvfwruf22WU4Jk/VbpE
 Wm4bpyxYeHqwfutlAMh1oVUKKQQjrTv7319yIL7h8sGQlyLt2CoQzpyXFMxgeSTfaygpTezuy2F
 EfR5dfWuvECI97HmfOVQFqLabzvVhMmO1ZIrwR3+Nx1vpki504Rp7a45fA9aCk8Qw4KdwirtRBQ
 5R0tLK8+DSEjPHBTDGLesRpVl6W5C9GB1PaHi/Fjn8JO8mWtsWMcCs2eokd2KsOqhFCOLNon499
 p1046wCyfe/6c0tLNol8BaLiekr8+sFjNK6PHg38zOcCS7buIxb/5l2k0a8TjxL2wl74YKkg2fL
 czQBnWohYMI8RwsuVQ3c3Afju7Qt0VVO9QxzjDlIKfJA6VHo8TI416pKOC4sDRGK1W7GXimU0pN
 JrksIpHpxyoVAU/2KAfw/luTAGc6RSoXgxLszCb7wTCscvP1ZW7wwkHtgUjEuwoNXf+fSMtJ3Pb
 aOLyEqMONb7fGm8ZFNt5lu3gAfWFKhauPsyNUppuPEaCf0mn4WpcOQz8xcDMqeaAWqmMA3KcQuJ
 a/6mSwFGukdwHRQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently it's set to true and which must be overridden in each error
case. The only time that it should return true however is if the client
returned 0. Change it to default to false, and only set it to true if
the CB_SEQUENCE request succeeded.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index dcd1c16ca5e6cc1928cae74b89ff4b36912503df..258bda1193f664f048e7b802082c8307b0a88821 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1332,7 +1332,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 {
 	struct nfs4_client *clp = cb->cb_clp;
 	struct nfsd4_session *session = clp->cl_cb_session;
-	bool ret = true;
+	bool ret = false;
 
 	if (!clp->cl_minorversion) {
 		/*
@@ -1365,11 +1365,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 * (sequence ID, cached reply) MUST NOT change.
 		 */
 		++session->se_cb_seq_nr[cb->cb_held_slot];
+		ret = true;
 		break;
 	case -ESERVERFAULT:
 		++session->se_cb_seq_nr[cb->cb_held_slot];
 		nfsd4_mark_cb_fault(cb->cb_clp);
-		ret = false;
 		break;
 	case -NFS4ERR_BADSESSION:
 	case -NFS4ERR_BADSLOT:
@@ -1399,7 +1399,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		rpc_delay(task, 2 * HZ);
 		return false;
 	default:
-		ret = false;
 		nfsd4_mark_cb_fault(cb->cb_clp);
 	}
 	trace_nfsd_cb_free_slot(task, cb);

-- 
2.48.1


