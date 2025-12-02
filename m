Return-Path: <linux-nfs+bounces-16855-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3898BC9D3C8
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 23:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42B9E347379
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 22:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6982D2F83BB;
	Tue,  2 Dec 2025 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8IEAwQb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F0F2F691E
	for <linux-nfs@vger.kernel.org>; Tue,  2 Dec 2025 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764715331; cv=none; b=Q/s2KYeYVZBKrY0mM1ekNEq5VCHxu2+Hh4p5bzxAVkr1SMd/8O+Jr2nkJBCi/SxwXJhOXWb+fwEF+VGFN4+CaWdMyJa+0GhL8SDoSJmmFZyRFkk2Cg4aHj5r5B8oKrhtLHgv0Xvd01yGuARbOLa8GnXhO1XQvRLJ3P5QRHt7YcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764715331; c=relaxed/simple;
	bh=G2xoRv4uXcR7Bzvh/Tff5CkC2NAzTg4Z5LNfVLjb4cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRRAGmYa1kWCkA0zeorupBiD9HYxmfP5pzz1EXB45aOnDn0cxKO9gfU4xLTGl/5FFmw/oJfKNN13aa8ko6O2B5wRH87X1o8VyB3WKbTVT7hKK9//VDNtoaSZJPq2zwbt0qQFzs0XcRSTueWesXqzzDt46ahuwZUeEZEcyhpmSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8IEAwQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C44C4CEF1;
	Tue,  2 Dec 2025 22:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764715330;
	bh=G2xoRv4uXcR7Bzvh/Tff5CkC2NAzTg4Z5LNfVLjb4cc=;
	h=From:To:Cc:Subject:Date:From;
	b=G8IEAwQbj4b+pBzkL5Uiaap/bnghKWI1Whx1AJipX9czLBxF2k+6Ot5WvICs9mGzw
	 PbeDiLr/uoifUDb88hDZ+5cGXD0n4H3yxYCSrqsS+Ui0VLT4/XsjagMxwkqdFLwZzG
	 U5lA93CbcE5m986+YYzEwewxhkLn8wulWrq1nyvIvvE+YwuQd0e4aTga/Ci8AAcRrR
	 7ACnEZQFFNY0oCrNPHQNAO7eWbhGEPkwkiat0P7GxKLlAFYLPbNgcc0mPpuZyhF30u
	 2V9B1NbWzwa/YAmdBBX19ICfKrU1pxO8bVXBWuNq97ngm0yjPnO++8VNyT3emQImTQ
	 +AKwcV4a4ANAg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 1/2] nfsd: prevent write delegations when client has existing opens
Date: Tue,  2 Dec 2025 17:42:07 -0500
Message-ID: <20251202224208.4449-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

When a client holds an existing OPEN stateid for a file and then
requests a new OPEN that could receive a write delegation, the
server must not grant that delegation. A write delegation promises
the client it can handle "all opens" locally, but this promise is
violated when the server is already tracking open state for that
same client.

Currently, nfsd4_check_conflicting_opens() prevents write
delegations only when other clients have write opens. It does not
check for existing opens from the same client. This creates a
problematic situation:

1. Client opens file O_RDONLY, gets READ delegation (or just OPEN)
2. Client returns READ delegation but keeps the OPEN stateid
3. Client opens same file O_WRONLY
4. Server grants WRITE delegation
5. nfsd4_add_rdaccess_to_wrdeleg() tries to add READ access
6. Finds fp->fi_fds[O_RDONLY] already set from step 1

Seen with generic/750 over NFSv4.1.

Fixes: 1d3dd1d56ce8 ("NFSD: Enable write delegation support")
X-Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

Changes since v1:
* This patch replaces https://lore.kernel.org/linux-nfs/20251201220955.1949-1-cel@kernel.org/
* 2/2 adds a canary where this bug was caught


diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 35004568d43e..1c9802d06de1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5947,11 +5947,16 @@ static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
 	 */
 	spin_lock(&fp->fi_lock);
 	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
-		if (st->st_openstp == NULL /* it's an open */ &&
-		    access_permit_write(st) &&
-		    st->st_stid.sc_client != clp) {
-			spin_unlock(&fp->fi_lock);
-			return -EAGAIN;
+		if (st->st_openstp == NULL /* it's an open */) {
+			if (st->st_stid.sc_client != clp &&
+			    access_permit_write(st)) {
+				spin_unlock(&fp->fi_lock);
+				return -EAGAIN;
+			}
+			if (st->st_stid.sc_client == clp) {
+				spin_unlock(&fp->fi_lock);
+				return -EAGAIN;
+			}
 		}
 	}
 	spin_unlock(&fp->fi_lock);
-- 
2.52.0


