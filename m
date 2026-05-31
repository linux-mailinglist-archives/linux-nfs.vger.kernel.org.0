Return-Path: <linux-nfs+bounces-22131-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHYZOWIlHGr9KAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22131-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 14:11:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 659BF615FDA
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 14:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB6083043FAE
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 12:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7308D3876C6;
	Sun, 31 May 2026 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5qw0ytC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460F38838A;
	Sun, 31 May 2026 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780229234; cv=none; b=tZcM+81m1eVqTRcApS9KCguhFDyjTnVnocd3ynB9604FH+G+LEu6rL4Pq9o+jRhv2dvqK4xNI25yXur6HyndzxDbjabLdfz9BdzGcjVjVfvRXn12EXUmxbIyHLa/35aNBfj8IpVFFmouOUk0wdJ9f+TaH0c5TkqAJg9XhaNCMSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780229234; c=relaxed/simple;
	bh=1vfWi9y3a7gGGmAoW4IQEoCTMgYGcpuY/jSiFCrofK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tLUFeFwvY6ESXvqfSsfj+JPPyBXUeJqVVZESCPPWA5UNIegauzyAFmbfBp67xbFqmKJjXr2f0UZGtoy7jELyxDU2GDzaYviAyTXT4e5BPoG10Keh7IhlBo10ff7+AZDkvDOAAVqra3KZhVY7IRoCY0SipklPYDhQYIwi7cYWgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5qw0ytC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0A21F00898;
	Sun, 31 May 2026 12:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780229233;
	bh=1xc+zaGDrjFNlfES7FXlGY0hjKA4MQ66aFt0cOyujuI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O5qw0ytCKkTTC417y9H0xN7mXhOnzB+aeijE5sHaS5/ZkBIQF0tAtb63lU2IBzwT1
	 aVRjt2T+Ygh3thPAgHYq0mS7mc5Lu1t9groNjR5lJQFbwrCf+cffWMVI8jbC6iG2yU
	 dGHJjIUcHBD4U+qyC1q1OgRVYb207VrtZvrU3hZEmsQ3OJx87GzU1n6VifyzFsGdsr
	 gtlz9D1VlxThX32PSGXhnloJoSLgas5Xu7B/yVJdLeeqIXSKejVw/Js0bVjzV8OQMu
	 Thrva7jvBT1E0gr8ZwwaYYXQ0tXZbS2doPTKlHWU3wjIZRk1H8mDn+UymNfzQ966Yt
	 kk7LN8eTCgtIg==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 31 May 2026 08:07:00 -0400
Subject: [PATCH 3/6] nfsd: fix nfsd_file leak on inter-server COPY setup
 failure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-nfsd-testing-v1-3-7bfa481b0540@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1vfWi9y3a7gGGmAoW4IQEoCTMgYGcpuY/jSiFCrofK0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHCRrcUnYo3uNx6MJt1u2PqJQzdTdMr+5hy9q0
 1/GoiMjJN+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahwkawAKCRAADmhBGVaC
 FQnLD/kBS2iJkVP64AVpHwuZNtEG3toLukRoSsYS4MWpY6dP0z6xKD7LBPqAdKjD9EEZdB0apUA
 CLkSzBdgqFtf77fwRR4zMP+jqNAgXlRt24C1CZbW5Pr2NV20A5qRTG97jx1vge1N/BcweyJgo3Q
 dq+A4FD02HiEfEbKtgIpfz1s+Atvh7D0TZmk2i0c/71ivJwQKLFx/ycbO3M+s1PC8/hUdlceAR/
 PYoHV3nY9N0taEaeKetBerPAjQoS8O9O8olb+VfIV2y1xZT8A+YDYx0juEH8vTirBtN1dSFrZId
 UZAevmOwdvu14iFAfS8YK+FdXscQG2wh9n5DWAbNbcpQuANvjTPOJvKZv9PvUryLfTiA/2sS5Es
 3A/Ewm+99xMB1mdltsnkBrWwyvVZhGyYdMuB04yJtqz6LFcQdehJylMPkhSmu+ocCsf7wgzJG1J
 Ifnc8Fejs0lJqi9LIEvSCTKWZqdpL5NbPu2qnoWUDY8W/JDQm0tYhq0r0pmUotZf6B51kdqRhGL
 ae564r042DWC5TuOSxw9l975oefc2EERx4Kte5KK22nJvE8O9+PhZMp1UMUxQcvM/ax73H4VfnU
 U4tNyCdkh9VOju8CMf7DTmPqZazbrXqOYjDhn+BLhioZCR8I5vMrtQKvISr3IQsl7Fpv43cf+aF
 WyEDfx7+puccSvQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22131-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 659BF615FDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When nfsd4_setup_inter_ssc() fails, nfsd4_copy() returns
nfserr_offload_denied directly, bypassing the out: label where
release_copy_files() would drop the nf_dst reference taken by
nfs4_preprocess_stateid_op(). Each failed inter-server COPY
leaks one nfsd_file, pinning file/inode/dentry/vfsmount.

Fix by setting status and jumping to out: instead of returning
directly.

Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9473aeb53f72..017474cd63b5 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2159,16 +2159,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		}
 		status = nfsd4_setup_inter_ssc(rqstp, cstate, copy);
 		if (status) {
-			trace_nfsd_copy_done(copy, status);
-			return nfserr_offload_denied;
+			status = nfserr_offload_denied;
+			goto out;
 		}
 	} else {
 		trace_nfsd_copy_intra(copy);
 		status = nfsd4_setup_intra_ssc(rqstp, cstate, copy);
-		if (status) {
-			trace_nfsd_copy_done(copy, status);
-			return status;
-		}
+		if (status)
+			goto out;
 	}
 
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,

-- 
2.54.0


