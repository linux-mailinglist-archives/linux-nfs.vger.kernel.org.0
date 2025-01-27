Return-Path: <linux-nfs+bounces-9696-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A570BA20018
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 22:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E44787A2384
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 21:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA4518FDBD;
	Mon, 27 Jan 2025 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4GPWXvD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682C1DA4E
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014621; cv=none; b=smFW0IrYWbz6RxTFevjZ3SU245ZCJSv3tvpnBSGHR4Ki6nH/JrdRH5RxLpYy/bLLEEhD7Spk6OMSEvmD/7iYMocYGlBCU/6K+7mDiGcu9FNlSg/Dvs+yJAW/vrBUwK1zDD/pjkAm4YQK68EdjRTuS7YaYlbNnQWIAM8H31vyVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014621; c=relaxed/simple;
	bh=DVWczIPahLVhvwgNiiIJKspMVPQ3swNAw1Y1cpOscc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+EEVfEb3VL+qYNC9fM0oy9qce7PGkH566tZNQY6WPLMF2/u+0YSivtnvw6zxjqXp5KBY4EMPTh9HLfcqBNw7Fsq6miHEEBmcaMR7mWP7R1GWLfSTRpmDxUiaF+s89XmjgCsZHFPEtVurLz5+2sWNIGfhUejNDoz10K5XdrVY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4GPWXvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61046C4CED2;
	Mon, 27 Jan 2025 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738014620;
	bh=DVWczIPahLVhvwgNiiIJKspMVPQ3swNAw1Y1cpOscc8=;
	h=From:To:Cc:Subject:Date:From;
	b=O4GPWXvDvV6hdCvI7r4sKCaf2jAELzuh9ueMx63cRpoHyLzLk/KSGSqPEIYKRDY57
	 d8CKBUFN0pSIg8UTintUvXs8GCMHxqzQc9nb82wj7qkz7w5NF3dJVIguIlNaKXlJ8q
	 SvoT7nNAYJjMb20Y6UpuIrOOU8WWpSYd0jRfH5FOUktyY9Lyn1WwCKXysVmBfqe+Y4
	 sWlfJLMUIDBh9ja43TjOhL/a26/ZSDajNn3yruMObWx48L2QlcuD75JIkdfT8cq55o
	 hn+NGo8+H4nBN+dLBlSAWUi6UCe174g5LPHbUjQ866IUMzIaKqVedzlfSQDvPaEahn
	 GpXStaVOI05ag==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 0/5] NFS & SUNRPC: Sysfs Improvements
Date: Mon, 27 Jan 2025 16:50:14 -0500
Message-ID: <20250127215019.352509-1-anna@kernel.org>
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

Thoughts?
Anna

Changes for v2:
- Added a file for rpc_clnt information
- Added a file for on-step xprt deletion

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


