Return-Path: <linux-nfs+bounces-13236-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD76B111C3
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 21:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEACA3A6AA1
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 19:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6692222D2;
	Thu, 24 Jul 2025 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDDP9VXc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0B2ECE8D
	for <linux-nfs@vger.kernel.org>; Thu, 24 Jul 2025 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385474; cv=none; b=pJa3wBfPIZz6MCWNUm4kZbxF7PiTkdCPiz0hqiFNL8CkOjZR3xfZIlRxyLHRKYjuY6O5LR6ZG6ZVI//PrfqWsdt0Z+Y8MhLMEg9uTP5cFxrE08eXFKQvpMUWIaOAJYkGF5SBoModkdavSSxfGijkFboQvRLm7mWjV21QAv7jgeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385474; c=relaxed/simple;
	bh=3JlBlNu9YSycTI9u/dIkyiyMNt1HFdi72gm6pZEMSWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAme2K7DpiT1aPmrl1OIf49JTDr4LxAX7aUIfJ13CTkcgWVO2L54ebwqXoIf10cHWQTQHk3tmLyRB7hW7dnPolxlo7pHGkg9MvOkuQ5EyoQMpEgRSwQkERz4wDRcASmzAjCUd1zuw/MZ6lzC+LI8Z26J6R26MUGvWzyC0Y1Xu88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDDP9VXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88F7C4CEED;
	Thu, 24 Jul 2025 19:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753385474;
	bh=3JlBlNu9YSycTI9u/dIkyiyMNt1HFdi72gm6pZEMSWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WDDP9VXcb5AkfWKL06GQn6al78aIc08lOjgARylIUwnzCQr33t3KfZl1zlvR6w54t
	 mDoKWirjf1AC1AWOI1bNOrVGc3ujQl8XNN9fiNvQTuQ4tXlQsgAqzvEU+qN6J0RIai
	 FPUqDC/tfGwlloDC+CXVThdkaCISzk64bJntYaybaeh1XCdNsT/WIUai23K6GSc7aq
	 8mRI7Njp2LkyENfwN6bQAzQc6xdYXX874OPAK4VaeG5Qz4IJRCuUlCdq3hciPWXRgM
	 Ki3trgNiN7BPsQEE9Y8x4+mT2piWHLDz56AAjE9WEE8XWRFSJ8Y3E/ZDQU0ZY6pykX
	 FSaG2FYaWlQ2g==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v5 07/13] nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
Date: Thu, 24 Jul 2025 15:30:56 -0400
Message-ID: <20250724193102.65111-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250724193102.65111-1-snitzer@kernel.org>
References: <20250724193102.65111-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

Previously nfs_local_probe() was made to disable and then attempt to
re-enable LOCALIO (via LOCALIO protocol handshake) if/when it was
called and LOCALIO already enabled.

Vague memory for _why_ this was the case is that this was useful
if/when a local NFS server were to be restarted with a local NFS
client connected to it.

But as it happens this causes an absurd amount of LOCALIO flapping
which has a side-effect of too much IO being needlessly sent to NFSD
(using RPC over the loopback network interface).  This is the
definition of "serious performance loss" (that negates the point of
having LOCALIO).

So remove this mis-optimization for re-enabling LOCALIO if/when an NFS
server is restarted (which is an extremely rare thing to do).  Will
revisit testing that scenario again but in the meantime this patch
restores the full benefit of LOCALIO.

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
---
 fs/nfs/localio.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 510d0a16cfe9..ecfe22a105ea 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -180,10 +180,8 @@ static void nfs_local_probe(struct nfs_client *clp)
 		return;
 	}
 
-	if (nfs_client_is_local(clp)) {
-		/* If already enabled, disable and re-enable */
-		nfs_localio_disable_client(clp);
-	}
+	if (nfs_client_is_local(clp))
+		return;
 
 	if (!nfs_uuid_begin(&clp->cl_uuid))
 		return;
@@ -244,7 +242,8 @@ __nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		case -ENOMEM:
 		case -ENXIO:
 		case -ENOENT:
-			/* Revalidate localio, will disable if unsupported */
+			/* Revalidate localio */
+			nfs_localio_disable_client(clp);
 			nfs_local_probe(clp);
 		}
 	}
-- 
2.44.0


