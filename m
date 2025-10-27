Return-Path: <linux-nfs+bounces-15663-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A89CC0DF5B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 895FE4F3B2C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FDA25785D;
	Mon, 27 Oct 2025 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bp8qCY5F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55A72472A4
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570514; cv=none; b=sQvcnTJ32+wkMyYryK4zI6xpO6pWrTYSqbPu9yyq+qdNz2fRgFknLc5zhCMDUWgiLmg9wpTS6ubb9uF+6sFgr4DfHKbq03yfS3kEobzoKknOhnKxyj4oK2xhvUBVcIN6px7SeOc4zn7B5IHfLJOhJX/vAUk0bWABN90+C/pRZYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570514; c=relaxed/simple;
	bh=XEY/HXku+1tboGOeQ/h2K4b5WHdIWgY9LaUHo/Ix2lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1b0eQ8ASYOYeFxU3DzyZ1KKSBSa1y6ihazx2raQ5ZWwZKFsNiYFNji2XPY7wAlbYLg+BvNXMCMnnyehM57C11i9vjAV3TCI9vSZUvQ9I7Wvug5Ol5yQuntj+aRNskLqqXywdqIY/kYykMVCgK+S9lp2VzePa9SptcG8r0PmeJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bp8qCY5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0BDC4CEF1;
	Mon, 27 Oct 2025 13:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761570514;
	bh=XEY/HXku+1tboGOeQ/h2K4b5WHdIWgY9LaUHo/Ix2lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bp8qCY5F4aU/+fxzErc6bggyHWFBLQA8eJXUZ5tNr6k+Acu0WGJhRoYr/7K9orw32
	 Kx1uTfHr/LD82hDa+dy3xPjuf7x+PmWaaS+8eKc5XTEqeRunJaSECoKSF/7f2Vdfuh
	 UZUg0LjqW6ArldHGsnbgS+X1nq4CsAZdEQFzkP2PWkizxPXXFK1rwGGCzznm6dtHin
	 0QXmYbtgfBu6SpRSKnsFiVFSAO+LF/8/CyzQTjgoNyOvxWNXvdGXb5a6CplDl6p+Mu
	 a6OyCf8pUGKHuly/GWMrSq9OfbMFtaz1bH2ufNUexWPRLgNRfuP0G+VIxEDP+rgUQH
	 J9yHZ7DNpSX5A==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [v6.18-rcX PATCH 0/3] nfs/localio: fixes for recent misaligned DIO changes
Date: Mon, 27 Oct 2025 09:08:30 -0400
Message-ID: <20251027130833.96571-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <aPZ-dIObXH8Z06la@kernel.org>
References: <aPZ-dIObXH8Z06la@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

These changes are needed to fix v6.18-rc1 commit c817248fc831
("nfs/localio: add proper O_DIRECT support for READ and WRITE").

This patchset fixes the KASAN use-after-free bug that was reported here:
https://lore.kernel.org/linux-nfs/aPSvi5Yr2lGOh5Jh@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com/

I still contend there wasn't an actual problem but these changes bring
more control to the misaligned DIO IO completion by marshalling it
through the use of a refcount.

With the additional minimal memory barriers associated with atomic_t
methods the KASAN splat no longer occurs.

Also, removed "dead code" to handle ENOTBLK that shouldn't ever be
seen by NFS, and backfill misaligned DIO short read support.

Thanks,
Mike

Mike Snitzer (3):
  nfs/localio: remove unecessary ENOTBLK handling in DIO WRITE support
  nfs/localio: add refcounting for each iocb IO associated with NFS pgio header
  nfs/localio: backfill missing partial read support for misaligned DIO

 fs/nfs/localio.c | 149 +++++++++++++++++++++++++++++------------------
 1 file changed, 91 insertions(+), 58 deletions(-)

-- 
2.44.0


