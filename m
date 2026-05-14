Return-Path: <linux-nfs+bounces-21624-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF+KMfk2BmqWgQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21624-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 22:56:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8034E546DA6
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 22:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE9043041846
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 20:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AE03ACEE6;
	Thu, 14 May 2026 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvZF8Unk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755293F4121
	for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792176; cv=none; b=q/vJnrjOtUiAFFRw4DivySaeZmR/WreY9dOkSR6hro1zlFC/kdqCjDaAU130r57yvYT52EPyXakuXQxXr52EFjQEd+Szj3LrqnVSa7a2a5hadmy/pVWRfa8kTRBPy4cwvdxwFmxhF8rBaqVOvaJJ7At9+bUSws6rbfaKP2fvHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792176; c=relaxed/simple;
	bh=Wlb4zN3D8VnlJHDOKuYxFv7MS+6IiA7e7D+O7NRqiGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUWvON3odGWrz9+nieSOg6sx90WDl3p79Mdpj8cAipmsZuNHjDGoqVzSA0S9S0t/oMF82xb9Bhn1YHJAumCu8r0dEJygqxrx2S30U/hY2hpo71PYXQrgTdTjt99pXVANy3v1kqXv0/0JtCzsRs6hzAGbJxZczLJx332KxszZmWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvZF8Unk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915C7C2BCB3;
	Thu, 14 May 2026 20:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778792176;
	bh=Wlb4zN3D8VnlJHDOKuYxFv7MS+6IiA7e7D+O7NRqiGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GvZF8Unk1DGeVaJZ3Md7VBcS71Vwbvnlj+q/v/nrMvuBZ9Lee41GaDxxsK1LQoukb
	 c9VlnxGJmxj3IApKaQ9TrnSTnLq6PNj9biUDwtS00O+KYs1lqtCoNZ8WdPfDMe9xpl
	 k90UAxEI5yhv85Gh+AKXFyP9iyWfKxTI2hZvOjY293K80CCEPM+kICy0L0V2uKDuc5
	 QNrK0DjHhX99jAKWNBfrgTHCvx3zgCJhR0OMd0WIgViKTzV+lO+T1AmFyVUnggxbmJ
	 GjxiiHGZt4gx9yOGy8PlUPXWvaY8i7ksQCOPFfiLAUXe9O3B60jIJQo3p3sHMEeGTw
	 zURigq8iY5lRg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 2/3] lockd: Plug nlm_file refcount leak on cached nlm_do_fopen() failure
Date: Thu, 14 May 2026 16:56:06 -0400
Message-ID: <20260514205607.348291-4-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514205607.348291-1-cel@kernel.org>
References: <20260514205607.348291-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8034E546DA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21624-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The cached-file path in nlm_lookup_file() reaches the found: label
unconditionally, even when nlm_do_fopen() fails. At that label
*result and file->f_count are updated before the error is returned.
The wrappers nlm3svc_lookup_file() and nlm4svc_lookup_file() then
bail out of their switch without copying *result back to their
caller, so the proc handler's local nlm_file pointer remains NULL
and the cleanup path skips nlm_release_file(). The f_count
increment is never released, and nlm_traverse_files() can no
longer reap the file because its refcount never returns to zero
between requests.

Short-circuit the cached path so neither *result nor f_count is
touched when nlm_do_fopen() fails on a hashed nlm_file.

Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcsubs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 0b81d8db0919..58b87ec52930 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -150,6 +150,8 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
 			mutex_lock(&file->f_mutex);
 			nfserr = nlm_do_fopen(rqstp, file, mode);
 			mutex_unlock(&file->f_mutex);
+			if (nfserr)
+				goto out_unlock;
 			goto found;
 		}
 	nlm_debug_print_fh("creating file for", &lock->fh);
-- 
2.54.0


