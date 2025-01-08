Return-Path: <linux-nfs+bounces-8984-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EBEA0673D
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9597018896E8
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33715201259;
	Wed,  8 Jan 2025 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKxwvWnF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6AE18D626
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372194; cv=none; b=NXD+VnPAryZq3CmghUITqJDilvc7ycE5hteuX2vGoTtrmlxfX/mSzMDKHG9yC9lS+qz5PbkI+njq8DC/088mo0n/WkWPBSXrMNgvlpH1YGKaRK9m/xbGQ9yeoYYp9nkeU749Btdpt/Xee2uR3j3uh77eovFQ++FQNn4sxSbd2ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372194; c=relaxed/simple;
	bh=2oVODxU4IVX/7SQKT06F+g7ci7KysQEKcel8zfLudHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ViZNxwAYGPK+DBQhCPFerGcCqLEipbsvcNEQY3/4tJmrvRp2j/0fwiXcHrHrsn/iE+sNCqXllqElyUfG9jaGsmFRF+evDAhsNC7Aysuv2mVyE7BHZH1lGltBw6btLR4PWAPlTAa2tqGVrJXMZkwUnHDBvvrGk405o9I6e4hBl/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKxwvWnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CE1C4CEDF;
	Wed,  8 Jan 2025 21:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372193;
	bh=2oVODxU4IVX/7SQKT06F+g7ci7KysQEKcel8zfLudHo=;
	h=From:To:Cc:Subject:Date:From;
	b=dKxwvWnFjWTZy8HXbDSIq3m9TUO9KZdfP85rh4bhGbpgtQ8yb5TZCnn78M9IUVJre
	 g9FwAKr1wntbukPa4hTzAl7aikrjOMniM8tTMP7oYQWOhVvL6hhRrdH93QBwoLU9XQ
	 NPEzUhZOU3zwVywKdHw9D756+sYMHNwRrXdKsuzLziFieOjt+5sjG6EP6Sk9KN/5o4
	 PjQP3tVP2AbEXMjvF9KDnFCUE+vYGtxuuPvi3PAZZ3Ct1h98kmFH+tNPbK77SqpRFa
	 xIavhJXL4wG7xBg+orUhpL+SFHKLKdGjvg+3z5Soz9vqJ4jcXOeFk4tSpQsnOy+TDC
	 4lk4SPPe65l6g==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 0/3] NFS & SUNRPC Sysfs Improvements
Date: Wed,  8 Jan 2025 16:36:29 -0500
Message-ID: <20250108213632.260498-1-anna@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

These are a few improvements that have been in the back of my mind for a
while, and I finally had the chance to work on. The first patch adds a
(read-only) file to check the server's implementation id. The remaining
two patches are sunrpc side to display the xprtsec in use for each
transport and to add a new transport to the xprt switch.

Thoughts?
Anna

Anna Schumaker (3):
  NFS: Add implid to sysfs
  sunrpc: Add a sysfs attr for xprtsec
  sunrpc: Add a sysfs file for adding a new xprt

 fs/nfs/sysfs.c                       | 79 ++++++++++++++++++++++++++
 include/linux/sunrpc/xprtmultipath.h |  1 +
 net/sunrpc/sysfs.c                   | 83 ++++++++++++++++++++++++++++
 net/sunrpc/xprtmultipath.c           | 21 +++++++
 4 files changed, 184 insertions(+)

-- 
2.47.1


