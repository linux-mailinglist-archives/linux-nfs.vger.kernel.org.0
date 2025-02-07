Return-Path: <linux-nfs+bounces-9945-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0553FA2CE5A
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 21:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A1C1638D3
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 20:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFBD1AB528;
	Fri,  7 Feb 2025 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL5JH9yP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084FF1A5B94
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960947; cv=none; b=pe8xyu2pPHpiX4VBHioDrJBBidwOUw+YExZUkroPaXK9icN4iNAr5mY65F+3LAWcUWtT2QlSI3sIISleLeFMF9M56sXZHILVMQuCpiBclUKETdG7qB09Yu1xBTc27awrM7u+ndMQZx2Sd4EEuCn0tRIl+NeUa8ruAz6HLqvrH2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960947; c=relaxed/simple;
	bh=DR8TuVqg0hUKhBnmyahto5VFc4XTJ4O6FwxwwiTxAvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ATzfz8MSxYuHbZaEj/wBXVx+Bax9ppwXUa0CU5PwiW/GvCp3kJWJqyfZdQlY0pVYN4KDLug1Nb/JJm9POCzTuxvj9w5SaLJvNcX4aW8I/359rlW4hcXGLA2ynMfwuKcjSKcAksnlK9+eexAOKGJ4T9igqkVfZeQROOKpFlTnPrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL5JH9yP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C17AC4CED1;
	Fri,  7 Feb 2025 20:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738960946;
	bh=DR8TuVqg0hUKhBnmyahto5VFc4XTJ4O6FwxwwiTxAvs=;
	h=From:To:Cc:Subject:Date:From;
	b=CL5JH9yPck6kXUu2lnKX9mHKtrokqHFG2nbLK53MqX+ZZZifBObiF2xPknFjUYZfd
	 9SzNRS5rhTqv5dbVMclC2TCyytYzhivoE+aruGandbMgco3U1sHIWYuOKJ+a1HQ1Xh
	 qJaE8O2QIASJ38IoZnPRvaBgonC0k0zjkNyygll+nuB6mV49wIphZ4eMz7t7fyn2pm
	 JopNUSPE07x5GbolMM6t6LqQCoMDWfBqzjPvawwParKQ2VH7/GsiEERR7YcsTKPvns
	 RRgZDi1U9WCZXzfCzscxz/ki43LCdNE3SdxMqE5Ho/euRmboZRuDRkLNIgUpkN2Eu7
	 b0q7Oiw3IQlGQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v3 0/5] NFS & SUNRPC: Sysfs Improvements
Date: Fri,  7 Feb 2025 15:42:20 -0500
Message-ID: <20250207204225.594002-1-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

These are a handful of improvements that have been in the back of my
mind for a while. The first patch adds a (read-only) file to the NFS
client's sysfs collection to check the server's implementation id. The
remaining patches are on the sunrpc side.

I did look into the 'nconnect' and 'max_connect' NFS client mount
options and how they interact with adding a new xprt in patch 4. My
reading is that 'nconnect' is just the initial number of connections
made by the NFS client during mounting. That shouldn't disallow adding a
new connection. The 'max_connect' parameter refers to the maximum number
of unique IP addresses in an xprt switch. The new connection I generate
is a clone of the main xprt, not a new address, so this doesn't come
into play either. So I'm convinced adding a new xprt is okay to do here.

Changes in v3:
  * Fix up the mode bits for the max_connect file
  * Replace call to xprt_iter_get_xprt() with xprt_iter_get_next()

Thoughts?
Anna


Anna Schumaker (5):
  NFS: Add implid to sysfs
  sunrpc: Add a sysfs attr for xprtsec
  sunrpc: Add a sysfs files for rpc_clnt information
  sunrpc: Add a sysfs file for adding a new xprt
  sunrpc: Add a sysfs file for one-step xprt deletion

 fs/nfs/sysfs.c                       |  60 ++++++++
 include/linux/sunrpc/xprtmultipath.h |   1 +
 net/sunrpc/sysfs.c                   | 202 +++++++++++++++++++++++++++
 net/sunrpc/xprtmultipath.c           |  21 +++
 4 files changed, 284 insertions(+)

-- 
2.48.1


