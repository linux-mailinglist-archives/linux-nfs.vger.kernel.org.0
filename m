Return-Path: <linux-nfs+bounces-6845-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B3398F714
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 21:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04781F21427
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 19:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A041A76CF;
	Thu,  3 Oct 2024 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Faqniezg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8951A727F
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984109; cv=none; b=eczSw9icDnfFsgmh7YjFtRN1SZbduoLPqt7h27XCnbJ7Bd6YgKiNiN/wTyXUu4rwNlNREj6IdWgHrub4n5j3G9rKJNQB7BbJhtA/HkB4z3stnkusJB0EFbpceuZK7aplqQZGep4QYXCbCst50GfbmXhYxTgJp+64GNgrhY9aZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984109; c=relaxed/simple;
	bh=Y5JAYdrl1fcRPxjfNiaeXTuXBy4NCDXId8+T/RaDQU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcdoNRTzaWAkHP2Zvv+QJMN/cj/RDpj2C8TZJRQk+jMI6BxRYj1Ccpn1GHbP/dMj8+EPyhfvT2p17AoSRQxWbh4a/6NB6sANYkGMy3Cqk16KhDpEddZIKe1S+XhEE/HlRSeNwsa3fyU8G9WhIwXvn4lXvHsbAuEr57VSvN5di3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Faqniezg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681AAC4CEC5;
	Thu,  3 Oct 2024 19:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727984109;
	bh=Y5JAYdrl1fcRPxjfNiaeXTuXBy4NCDXId8+T/RaDQU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FaqniezgCaB9At80lswrlGNSJtw8BSEiy2h6jDUw1R/YBpD1c40gHhTeQko8hr5Xu
	 yF59qWVv3cphStkw58t+qbC5FeupupGLm4UY+JsGmbyAC/eTWCJG89pb/G/N6yvwWr
	 wnUNv3jS2udx99RG7Mb/O8PybGNJDMNQiOVd27lPBWZ+XhovUJJpQzTclYxMyCZMeV
	 K+1fniwUZWPiWpz5R1xuCutSjXvZBkfO2udm4a2IXAUbmbIllMoiOZ17IZhxnPW+e2
	 ERlFnTesNC8/iQSDcMocK4Tk9mDV/bHD9y9jR4x0rcYkXsTWh10XA9rf8ZatoCWlKF
	 l7wkxjnIi9Gqw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [6.12-rc2 v2 PATCH 3/7] nfsd/localio: fix nfsd_file tracepoints to handle NULL rqstp
Date: Thu,  3 Oct 2024 15:35:00 -0400
Message-ID: <20241003193504.34640-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241003193504.34640-1-snitzer@kernel.org>
References: <20241003193504.34640-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise nfsd_file_acquire, nfsd_file_insert_err, and
nfsd_file_cons_err will hit a NULL pointer when they are enabled and
LOCALIO used.

Example trace output (note xid is 0x0 and LOCALIO flag set):
 nfsd_file_acquire: xid=0x0 inode=0000000069a1b2e7
 may_flags=WRITE|LOCALIO ref=1 nf_flags=HASHED|GC nf_may=WRITE
 nf_file=0000000070123234 status=0

Fixes: c63f0e48febf ("nfsd: add nfsd_file_acquire_local()")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index c625966cfcf3..b8470d4cbe99 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1113,7 +1113,7 @@ TRACE_EVENT(nfsd_file_acquire,
 	),
 
 	TP_fast_assign(
-		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->xid = rqstp ? be32_to_cpu(rqstp->rq_xid) : 0;
 		__entry->inode = inode;
 		__entry->may_flags = may_flags;
 		__entry->nf_ref = nf ? refcount_read(&nf->nf_ref) : 0;
@@ -1147,7 +1147,7 @@ TRACE_EVENT(nfsd_file_insert_err,
 		__field(long, error)
 	),
 	TP_fast_assign(
-		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->xid = rqstp ? be32_to_cpu(rqstp->rq_xid) : 0;
 		__entry->inode = inode;
 		__entry->may_flags = may_flags;
 		__entry->error = error;
@@ -1177,7 +1177,7 @@ TRACE_EVENT(nfsd_file_cons_err,
 		__field(const void *, nf_file)
 	),
 	TP_fast_assign(
-		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->xid = rqstp ? be32_to_cpu(rqstp->rq_xid) : 0;
 		__entry->inode = inode;
 		__entry->may_flags = may_flags;
 		__entry->nf_ref = refcount_read(&nf->nf_ref);
-- 
2.44.0


