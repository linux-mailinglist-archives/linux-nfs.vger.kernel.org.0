Return-Path: <linux-nfs+bounces-1500-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 871DE83E0D6
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 18:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12817B244B2
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F222032D;
	Fri, 26 Jan 2024 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPMQ9w+g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD5D20303
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291181; cv=none; b=hL60GCg0ZYZZMZD1G9MWrrLy3QmCMQzfXwLCAy+PbBmwUQBuElE8F8JUUiyCovXW5LDCKWkpa4nUOSfzVVFAD6yWZF60yxwJjA1XKHNn6AuQqmrhHXhzJKEtxNdvZhhz0f4GEvapelZ1kd8K7vPSIaYqE8yUTGrn8Ek7SPVIO0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291181; c=relaxed/simple;
	bh=w5Ztfv03oez4zsZd54ZBZfikfZeBIRvATmbZjwYSxYE=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOUEZxatQ/eGIMdEhIldOgQFTUje9Usz0lUa3CDdvu9XIqH8UII6py9NGRrk+Y4L5TA+pxreXnCxfhctdkQ8OTYjadmptas2r9ilEWHvxKjnC6Q7M62g14bRJFAoPNTb4hk3rRuVVh7IMss3Kfklenn62+cI8TQQHzMVpD6mPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPMQ9w+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0817AC433C7
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706291181;
	bh=w5Ztfv03oez4zsZd54ZBZfikfZeBIRvATmbZjwYSxYE=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=uPMQ9w+ghPK4tiQwSrByfPPFfXRIhaQ3wmIAgE3HUeRhXktHnScQJt7UKEnio0Mnl
	 4CW0e8jGpHDUhI2K3DMdlHY7WyD+QF0mCe6f+wix4QMerNjlZLn5XZ6ye++p169EvC
	 HHy+MJ+scx+MKUfjJ/zGxtHKxkQqZde6QNyIIuGUfte/UwNsAAR7DTBucwJx75H5K2
	 nkhgaMje5rvujOWpYcjuAngUFpUZOCAcx63A6k06X/pPOknm2QXNLVF0lhy2g8E5+0
	 MJeEDOLKM6tKsjQoLItxUPvC0JsPPVt+xe7HRIfrP1XdHCP/lkdQzSkfaSGa0mwfho
	 nkKTChsZJozhA==
Subject: [PATCH 2 11/14] NFSD: Replace comment with lockdep assertion
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Fri, 26 Jan 2024 12:46:20 -0500
Message-ID: 
 <170629118001.20612.7293384112958646908.stgit@manet.1015granger.net>
In-Reply-To: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
References: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
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

Convert a code comment into a real assertion.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 45a31f051595..d73c66fa131d 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1315,12 +1315,13 @@ void nfsd4_shutdown_callback(struct nfs4_client *clp)
 	nfsd41_cb_inflight_wait_complete(clp);
 }
 
-/* requires cl_lock: */
 static struct nfsd4_conn * __nfsd4_find_backchannel(struct nfs4_client *clp)
 {
 	struct nfsd4_session *s;
 	struct nfsd4_conn *c;
 
+	lockdep_assert_held(&clp->cl_lock);
+
 	list_for_each_entry(s, &clp->cl_sessions, se_perclnt) {
 		list_for_each_entry(c, &s->se_conns, cn_persession) {
 			if (c->cn_flags & NFS4_CDFC4_BACK)



