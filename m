Return-Path: <linux-nfs+bounces-6406-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4089769DD
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 15:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0727DB21C78
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 13:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465651A3040;
	Thu, 12 Sep 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbDXu4Vb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7341D52B;
	Thu, 12 Sep 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146161; cv=none; b=LWX+t5KXd2LD6+MbSBpDhecjMaqom2nycaJNimz8Bb/oXySjRcD9knw5nYw7dLEuTbdoIlDGiEhh7hzqPIckA9GHHcOqAmuFkNqPLHlNE2sHF9sjxoiUI8dYaz2tiPya7cRGwMoNgbhgbJi51rAqgEiSRBQ3Irm/IWBgDB1kLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146161; c=relaxed/simple;
	bh=DhkEH8ExzFb5xrRh5wL4/exJl72OCo+ono29/8YfNxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEl57XeQyZYz4/PpfHVnjAVO+mzP1DHm8bMhAJsj6MJB6Mir8+rTD7M30ley00Ll2LIoo8jTcIeMRPWaT3r01Usz1fp7/x1JYO3NrwmO07DSke3UPtMc261qUt1WPj36vpBkXJo2qw2XMBObBxsQoUlwXCQq6wJqB7efobTam5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbDXu4Vb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A835CC4CECC;
	Thu, 12 Sep 2024 13:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726146160;
	bh=DhkEH8ExzFb5xrRh5wL4/exJl72OCo+ono29/8YfNxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bbDXu4Vbs2li49y06D9uXknvzsgdhVblx8o7SmcwgvuFkYOyBxhw/r1wrv7IJ/VgX
	 iR7dvoBBz38agIOmm92Fnaxka27pRmejtuOcWmcQCs7jSsLn0+2oZmYktsqJmXhK7g
	 YGFJLgYsO6vDbV0zV2ThoZ6YWKGudB3GE7i50RmUcP9pzPQRxAZ2PEqt6wJDX7Mh7f
	 ro/xSKx5s+i3zw3wLqBHE39WsREl2kk7GPvQn8bi5h7438XY3bPkxladoSeo9vSi8U
	 aaij2zA5UurcsmIK7JJwPiQWQosGZqVAt511V+j5vYJ6XWPuiFgcmcWi7ho3VoaZ7J
	 3RmDzG4VWTiLA==
Received: by pali.im (Postfix)
	id B4368A4E; Thu, 12 Sep 2024 15:02:35 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] nfs: Propagate AUTH_NULL/AUTH_UNIX PATHCONF NFS3ERR_ACCESS failures
Date: Thu, 12 Sep 2024 15:02:17 +0200
Message-Id: <20240912130220.17032-3-pali@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912130220.17032-1-pali@kernel.org>
References: <20240912130220.17032-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Linux NFS3 server returns NFS3ERR_ACCESS for PATHCONF procedure if
client-selected auth flavor is not enabled for export which is being
mounted. Ignoring this error results in choosing wrong auth flavor during
mount and so making the mount point inaccessible. It is because Linux NFS3
server allows to call other procedures used during mount time (FSINFO and
GETATTR) also with auth flavor which is explicitly disabled on particular
export.

This is particularly problem with mounting AUTH_NULL-only exports from
Linux NFS3 server as kernel client first try to use AUTH_UNIX auth flavor,
even when AUTH_UNIX is not announced by the MNTv3 server.

Do not propagate this failure for other auth methods, like GSS, as Linux
NFS3 server expects that accessing root export GSS dir may be done also by
other auth methods.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 fs/nfs/client.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 8286edd6062d..5171ae112355 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -864,7 +864,19 @@ static int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *mntfh, str
 		pathinfo.fattr = fattr;
 		nfs_fattr_init(fattr);
 
-		if (clp->rpc_ops->pathconf(server, mntfh, &pathinfo) >= 0)
+		error = clp->rpc_ops->pathconf(server, mntfh, &pathinfo);
+		/*
+		 * Linux NFS3 server for PATHCONF procedure returns back error
+		 * NFS3ERR_ACCESS when selected auth flavor is not enabled for
+		 * export. For auth flavors without authentication (none and
+		 * sys) propagate error back to nfs_probe_server() caller and
+		 * allow to choose different auth flavor.
+		 */
+		if (error == -EACCES && (
+		     server->client->cl_auth->au_flavor == RPC_AUTH_UNIX ||
+		     server->client->cl_auth->au_flavor == RPC_AUTH_NULL))
+			return error;
+		else if (error >= 0)
 			server->namelen = pathinfo.max_namelen;
 	}
 
-- 
2.20.1


