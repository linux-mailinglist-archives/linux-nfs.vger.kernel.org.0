Return-Path: <linux-nfs+bounces-9553-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C71A1AB42
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 21:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C457164280
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A1E1F7545;
	Thu, 23 Jan 2025 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTeWnuod"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276C31F7080;
	Thu, 23 Jan 2025 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663939; cv=none; b=GOYbCJe2439l8RrRRzjFo013Dji4AgxFFXtK3aokwqmEjC/oQvCArT8i3qk6RM4u3Ff22JtFLUC7VUObqPV6gSW6eeyEuXbgsbnv05IpMTOFrejLVYv23U8Bw4f85oOlynZSj07/erVpbYZQGTYdwV4ORvmHbrfaIYLEPeyYvyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663939; c=relaxed/simple;
	bh=IsX74en0tidPpWpPwlknHnxNcTKlCQ+ZyFjLYGnQLfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UMNJQ4utMTfRAKMHiI09Ga9EK+qUNqZgKz3+pLqB5Ys+0HUkeKH3IGKMFKsBb91Ls7XXnHBj5CzusCYNZQbR1dk3YI0ryQ36uGCCxHsfBn6aiw2vxhDUZKgN5T4t5NtmG5hOltOwpNkCr89N0RLIgKniZxHSXWdpmQHM8S6/KDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTeWnuod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13324C4CEE1;
	Thu, 23 Jan 2025 20:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737663938;
	bh=IsX74en0tidPpWpPwlknHnxNcTKlCQ+ZyFjLYGnQLfo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RTeWnuodW0+YtD+vxn1sr+uO2FOdoB6yUtlAY+iGtxgOcVquDlwEciZQozPaWmoxt
	 emi9xBTrM/cu20czgLFWbq+kAEJrEzkMNIIaSU1uWcPZvjf0GWIkM6IM347J+DTkmQ
	 Le+I8G6YbNZ+DeAIiChFaqGuisnlLZ0OFSEXHmVQIdCfwFlv6aGM0RbbADqJmjFL6i
	 HSokMIMkHeYsmo65kcFc7/A8JEdQ2tu+Hm2yce3OImB3VWOsgQCCUyHwFYfcEF2R/c
	 pIfHBxhzWJ5NJBc5vG5tJt2sNCeXOdxZC301EBbD0Z7KvXEEenvqa/e4A8sWCJwImb
	 YnZOJpRyIAYNw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 23 Jan 2025 15:25:19 -0500
Subject: [PATCH 2/8] nfsd: fix CB_SEQUENCE error handling of
 NFS4ERR_{BADSLOT,BADSESSION,SEQ_MISORDERED}
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-nfsd-6-14-v1-2-c1137a4fa2ae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2700; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=IsX74en0tidPpWpPwlknHnxNcTKlCQ+ZyFjLYGnQLfo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnkqW8QzxwRqEmYfF+TnMadWRxcFVz1X3TVfAVV
 S8ZJOhFZMqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5KlvAAKCRAADmhBGVaC
 FQLZD/4tZpo2femFaa6Z0yKOa8UC4cDqt66iJruriv0atznBfsDo/7zGzBWrl7lehZ6s+cG5Knq
 FM6znChgD5HC/f0mKKNxhBNwdU+aPKvNhbWH0VkjfWD1gdMXrIVJtZ7ytKZdVitcaW6OhBeXp8X
 BHR5aNqPEJxc2PLam9eA+q+crESIPdotap5Xitz93GFyypjwldQzgAu4pHUhwib+iGIdnKdv6O9
 6THM3bSE+246K5mSRXuZJ20rVXmo2SesmVtRGyQVNgSkkKMrm5po4Jkq6rxZKoHPVI7UOp127se
 9FKiWWC+rqBKJdMgUd2hsKNZCiikcnq4R0C3XROlMlw7oFyGuY89mwmqGhG9EZHXsb2PLXuBIF3
 y6ftq3gyLj39LiCfcIG3sdOJeFllSvCNDuUNeaJDqpsGK0e5uU4Gt5LK7I6aRIRag+2UwqVIga4
 nFV/RFD4eXz/bAZ/ZOdlEUendrO2Hj+KcqVTyKCfLbwOkQxAJtvVbHW6XyblmT1kVTJZYAY8YC2
 A134EvOl8EEJ/GeUhioUBBVJh4nxRaDyUGNfk9fHfca2qohpHx+awLXsuO2d3gHCq3VMBgOVXGW
 yc2g5KBO6K5/+nuth9+7Rahp7uIC5Ju/O7EWKA2cvjK7kt8jrOd4Ulc/1Be/68UR0pkF6cuB0Qu
 +RkRj1UCVLZyZ5g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The current error handling has some problems:

BADSLOT and BADSESSION: don't release the slot before retrying the call

SEQ_MISORDERED: does some sketchy resetting of the seqid? I can't find any
recommendation about doing that in the spec, and it seems wrong.

Handle all three errors the same way: release the slot, but then handle
it just like we would as if we hadn't gotten a reply; mark the session
as faulty, and retry the call.

Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for processing more cb errors")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index e12205ef16ca932ffbcc86d67b0817aec2436c89..bfc9de1fcb67b4f05ed2f7a28038cd8290809c17 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1371,17 +1371,24 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		nfsd4_mark_cb_fault(cb->cb_clp);
 		ret = false;
 		break;
+	case -NFS4ERR_BADSESSION:
+	case -NFS4ERR_BADSLOT:
+	case -NFS4ERR_SEQ_MISORDERED:
+		/*
+		 * These errors indicate that something has gone wrong
+		 * with the server and client's synchronization. Release
+		 * the slot, but handle it as if we hadn't gotten a reply.
+		 */
+		nfsd41_cb_release_slot(cb);
+		fallthrough;
 	case 1:
 		/*
 		 * cb_seq_status remains 1 if an RPC Reply was never
 		 * received. NFSD can't know if the client processed
 		 * the CB_SEQUENCE operation. Ask the client to send a
-		 * DESTROY_SESSION to recover.
+		 * DESTROY_SESSION to recover, but keep the slot.
 		 */
-		fallthrough;
-	case -NFS4ERR_BADSESSION:
 		nfsd4_mark_cb_fault(cb->cb_clp);
-		ret = false;
 		goto need_restart;
 	case -NFS4ERR_DELAY:
 		cb->cb_seq_status = 1;
@@ -1390,14 +1397,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 
 		rpc_delay(task, 2 * HZ);
 		return false;
-	case -NFS4ERR_BADSLOT:
-		goto retry_nowait;
-	case -NFS4ERR_SEQ_MISORDERED:
-		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
-			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
-			goto retry_nowait;
-		}
-		break;
 	default:
 		nfsd4_mark_cb_fault(cb->cb_clp);
 	}
@@ -1405,10 +1404,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	nfsd41_cb_release_slot(cb);
 out:
 	return ret;
-retry_nowait:
-	if (rpc_restart_call_prepare(task))
-		ret = false;
-	goto out;
 need_restart:
 	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
 		trace_nfsd_cb_restart(clp, cb);

-- 
2.48.1


