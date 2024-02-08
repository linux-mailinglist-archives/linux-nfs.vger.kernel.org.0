Return-Path: <linux-nfs+bounces-1863-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 544F684E499
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 17:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3F81C24683
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 16:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5067CF31;
	Thu,  8 Feb 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtnfnZuF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CB7CF13
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408037; cv=none; b=FFY6CE+MIGLCUgVRIqH5EIfXoZPOfIRgU/X8oaM+WhGgtqU/C+QdgE6C7ll1P+/D50MUU10aZnSBeWtFKmsQ8aI95wwp5knkZLVKhk0fx18ANgrLcBS9wUXekoxQ9NfX9svh9Fbybn0kmhBUhBLYrRDlA1pvSbd9xwV94471Jo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408037; c=relaxed/simple;
	bh=nlXOmrIap7VvEVQUPdU++FWZ/tgUxD8WfAttIj8kaaM=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tH9rc7IngzLRIxSH4Ml/AT6PaO0PktvSHk/Z0pRB5toJ1rMtmbgO+dVaS+rcWDI1hy28B5gVcm4r7f6ipXWyDRuu9pl6rsigKBCl09PBhrvDmTuWjG+i1/S+gz1Ho5IEPkhS/E6iIxlH5TT4ND6qNK8ZJeocJrUn2eYUjxL6SVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtnfnZuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F29C433F1
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707408037;
	bh=nlXOmrIap7VvEVQUPdU++FWZ/tgUxD8WfAttIj8kaaM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=XtnfnZuFa89krShnbxCN1d3CfHtyxoKVejwZ/lirkgbI1jIqSbbsY0//CRZCAJg5C
	 cyVhWQ5gi8p/TJwYK6HAp+QAT6GzZ+325OzQof8hSdjH10+ZouVfSGbeuwdxXFNyIT
	 z1WmqozxN+wCuo06oofLX/326eQj4JuGjBxAIX1xwiS7zqLmw8hBOO6kJDhskaSVlR
	 ktUpLvZW5OVON9EiCjTUyS2J5InTmmlaT3abEl6WNf6kN7I5RncO+XWaF4et/HFE5X
	 tuphoA8p9TOjtcSSnFbhGQuHVpPygWZCsj6yBW2Eow69QXM+H4VrFyfpiY11sDQJmt
	 KWWWAUHR/T4sg==
Subject: [PATCH v1 2/2] NFSD: Document the phases of CREATE_SESSION
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 08 Feb 2024 11:00:35 -0500
Message-ID: 
 <170740803579.2139.11630593215813383417.stgit@manet.1015granger.net>
In-Reply-To: 
 <170740799184.2139.1775683633369731917.stgit@manet.1015granger.net>
References: 
 <170740799184.2139.1775683633369731917.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

As described in RFC 8881 Section 18.36.4, CREATE_SESSION can be
split into four phases. NFSD's implementation now does it like that
description.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index bca2c2878ad6..3b52728d8cb9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3614,6 +3614,8 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 		goto out_free_session;
 
 	spin_lock(&nn->client_lock);
+
+	/* RFC 8881 Section 18.36.4 Phase 1: Client record look-up. */
 	unconf = find_unconfirmed_client(&cr_ses->clientid, true, nn);
 	conf = find_confirmed_client(&cr_ses->clientid, true, nn);
 	if (!conf && !unconf) {
@@ -3621,6 +3623,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 		goto out_free_conn;
 	}
 
+	/* RFC 8881 Section 18.36.4 Phase 2: Sequence ID processing. */
 	if (conf)
 		cs_slot = &conf->cl_cs_slot;
 	else
@@ -3636,6 +3639,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 	cs_slot->sl_seqid++;
 	cr_ses->seqid = cs_slot->sl_seqid;
 
+	/* RFC 8881 Section 18.36.4 Phase 3: Client ID confirmation. */
 	if (conf) {
 		status = nfserr_wrong_cred;
 		if (!nfsd4_mach_creds_match(conf, rqstp))
@@ -3662,6 +3666,8 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 		move_to_confirmed(unconf);
 		conf = unconf;
 	}
+
+	/* RFC 8881 Section 18.36.4 Phase 4: Session creation. */
 	status = nfs_ok;
 	/* Persistent sessions are not supported */
 	cr_ses->flags &= ~SESSION4_PERSIST;



