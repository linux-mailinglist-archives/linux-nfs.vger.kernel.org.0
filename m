Return-Path: <linux-nfs+bounces-15383-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6651FBEDD3E
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 02:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FBD3B652F
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 00:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1162AD16;
	Sun, 19 Oct 2025 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvWNZ9Kh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7528695
	for <linux-nfs@vger.kernel.org>; Sun, 19 Oct 2025 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760832640; cv=none; b=AyVBU9vjjgmi3AfgkP3h6wPqXpcikFOXYeGoa3yV78IfyttUDfOqSF14p0rXQQXeGA0B2sDSFqVgDw9fMmmmAgbbI2JnIZkAI1U+vnten2OofExuv5lWC9tQq46OD91zQQFVPsP6ck/6BxjBRkDtjli0HyCDfQzkd3gisfz8KFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760832640; c=relaxed/simple;
	bh=bJYJLKPAuG4T3XFymx9mP0dvI0h31UrW+HSsUWQ07uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jtq0TSMk5tdhN3KN0O1SmJ7kUv0VGBHFaQDlN5U+9UdRkTzqdCzlZhY7c9uWm6X9izNnzCntIyeBLC/f5N3e2IPx9/oaJcepZc4Z1wRtIW9ZW6dtTN54ztqHs84Ct7k7TOcUQqb7kgDzRr1yslkON38aWyyO/yEPEvTvb5oeSfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvWNZ9Kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D930C4CEFB;
	Sun, 19 Oct 2025 00:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760832640;
	bh=bJYJLKPAuG4T3XFymx9mP0dvI0h31UrW+HSsUWQ07uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvWNZ9Khu4psoET+MGavcRlXBFfOWGWB7yFAmpY/k9L0NLpJ+yLUvW6s0FJ48FGja
	 HdvYaHCm4f7S9IEGSeRqyrxfP5TJV7wwv6iDwPRvVK87HK3MOYlHb1fsjXc4zStEJE
	 EsWS82681KCWJhqmE4kFSIii/te8f5jq2fnJEQfhaRH+SDRWxoGHorrtEDkLEMTIq/
	 YeOtHzDLyWL1uVoif2G3x1W0ZV48coumNzCoZKT/X0/OSZTlcdTNmj0sb+TNyVS7+6
	 r6EB8QWDUhlhUw8kyqAptPVWJ5EJcgLEl5TH4v00u9pVC4tvmq1v1ukyBEcqFSHOk8
	 WGMvxsD25aOSg==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 4/4] NFS: Check the TLS certificate fields in nfs_match_client()
Date: Sat, 18 Oct 2025 20:10:36 -0400
Message-ID: <1dda941b02901f0690a464086e811f486e70150c.1760831906.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760831906.git.trond.myklebust@hammerspace.com>
References: <cover.1760831906.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the TLS security policy is of type RPC_XPRTSEC_TLS_X509, then the
cert_serial and privkey_serial fields need to match as well since they
define the client's identity, as presented to the server.

Fixes: 90c9550a8d65 ("NFS: support the kernel keyring for TLS")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/client.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 4e3dcc157a83..54699299d5b1 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -338,6 +338,14 @@ static struct nfs_client *nfs_match_client(const struct nfs_client_initdata *dat
 		/* Match the xprt security policy */
 		if (clp->cl_xprtsec.policy != data->xprtsec.policy)
 			continue;
+		if (clp->cl_xprtsec.policy == RPC_XPRTSEC_TLS_X509) {
+			if (clp->cl_xprtsec.cert_serial !=
+			    data->xprtsec.cert_serial)
+				continue;
+			if (clp->cl_xprtsec.privkey_serial !=
+			    data->xprtsec.privkey_serial)
+				continue;
+		}
 
 		refcount_inc(&clp->cl_count);
 		return clp;
-- 
2.51.0


