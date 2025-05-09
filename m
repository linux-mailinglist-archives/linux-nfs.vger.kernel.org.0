Return-Path: <linux-nfs+bounces-11644-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8E3AB1E71
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 22:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9861B507CF1
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 20:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA69241663;
	Fri,  9 May 2025 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpGfwbOf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A3A1E25F8
	for <linux-nfs@vger.kernel.org>; Fri,  9 May 2025 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746823191; cv=none; b=KqGve9NEJaDLFZQUx0LZf56CLuoJ6dJ8j/UlMitwALgifqowtO3ze+zcdtZC9Iv/OOuMUiYIqIyVRwlMpxu33vK9KyKrG/4Tm/xha5TtaXixIF/3oNQyTsbLQV51n81m1TS5O0kFFg8QxpzWqf0lhauGg1L8v7fBeiCWWrDpbhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746823191; c=relaxed/simple;
	bh=Zz/dtWRyr6SiDWZ9AKL9RyRkfC0EHJaMtaFQf0eEbtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fm+VRCaJCVGho7bA1H0hDgOWv53/lhA2XCKgiK4LJ+1oUd3ul9Oj6qhneNJqVh9ueQXfwVhQq0plUugeJEaFXnEcLVKUsE6/1C/TM9Q8sZ4Tvq53SdN99gaDY+Xl+GrpS/8/nZDwavCW7Wv2+xauh3hKN7uEa6Z6RZrNSWAyAJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpGfwbOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9684EC4CEE4;
	Fri,  9 May 2025 20:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746823190;
	bh=Zz/dtWRyr6SiDWZ9AKL9RyRkfC0EHJaMtaFQf0eEbtk=;
	h=From:To:Cc:Subject:Date:From;
	b=qpGfwbOfK/1LYcQ2x8HK3J3eihKh8eiH7LMfm9uiu3G9Y10neglWDWfAfVpTmhmRN
	 xbGgw4ufmUGo9eelHZLwuXVt1NHBvQrrxwuy7NHaugXnL5sU8AJa0PS3Umv1Qh6+6c
	 7FSTIWaVT+OD0WcWXYZ9ReVdOCWhUXpfqdvoofK4jlv0hO+sxZ7OmTCZqofYrXB7+X
	 sISM8lgE8V2qXy+cVE9u+l33jh/JxHzsGi0/QQd7qtszQbwUYscN4FNu7xrZPEttUi
	 9AvglzMYXt+pwUJgL5mirBRDTZ5ecQuaHp69U2dQpSbHPLUACZo5ClAiEsZx53H+DW
	 NNg2h1Ueb5QyQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@hammerspace.com>,
	anna@kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH] pnfs/flexfiles: connect to NFSv3 DS using TLS if MDS connection uses TLS
Date: Fri,  9 May 2025 16:39:49 -0400
Message-ID: <20250509203949.21715-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implementation follows bones of the pattern that was established in
commit a35518cae4b325 ("NFSv4.1/pnfs: fix NFS with TLS in pnfs").

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/pnfs_nfs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 91ef486f40b9..b4ccdf78d4dd 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -830,10 +830,16 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 				.servername = clp->cl_hostname,
 				.connect_timeout = connect_timeout,
 				.reconnect_timeout = connect_timeout,
+				.xprtsec = clp->cl_xprtsec,
 			};
 
-			if (da->da_transport != clp->cl_proto)
+			if (da->da_transport != clp->cl_proto &&
+			    clp->cl_proto != XPRT_TRANSPORT_TCP_TLS)
 				continue;
+			if (da->da_transport == XPRT_TRANSPORT_TCP &&
+			    mds_srv->nfs_client->cl_proto == XPRT_TRANSPORT_TCP_TLS)
+				xprt_args.ident = XPRT_TRANSPORT_TCP_TLS;
+
 			if (da->da_addr.ss_family != clp->cl_addr.ss_family)
 				continue;
 			/* Add this address as an alias */
@@ -841,6 +847,9 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 					rpc_clnt_test_and_add_xprt, NULL);
 			continue;
 		}
+		if (da->da_transport == XPRT_TRANSPORT_TCP &&
+		    mds_srv->nfs_client->cl_proto == XPRT_TRANSPORT_TCP_TLS)
+			da->da_transport = XPRT_TRANSPORT_TCP_TLS;
 		clp = get_v3_ds_connect(mds_srv,
 				&da->da_addr,
 				da->da_addrlen, da->da_transport,
-- 
2.43.0


