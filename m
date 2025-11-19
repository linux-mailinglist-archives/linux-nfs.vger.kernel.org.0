Return-Path: <linux-nfs+bounces-16545-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33384C6F379
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 15:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12E824F4BE9
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 13:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AF53612DF;
	Wed, 19 Nov 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcKgFtCF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB8B3612D4
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560709; cv=none; b=ldxVTcTCoxkEtFLFSFEToRcYoIyESpma5jJIdQJSIxzjFa2G+RhZHLSV/vxGG/9w25tsHxbghtueyj5bmEhMpgvZvcq97v8cSyoA4A5poLUWJAcVTlm7XFVlcKI+ojHSjOv4ZlE5LPvBy4zf25saFSRZh07farH8g0mCE/Rs0fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560709; c=relaxed/simple;
	bh=5hfKTCbULdlh1TXPL9Ge4boq3PyMZ1wrd8RFXCwLQt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7VxGBSWmqj0oaMOqK4z112ASKDi4Nbo1fGRd9Giyu0YDDUCkL5XAldoRVYGcVhUsYdI7quHOvA3LpBiw+PnUdudqJQdudk3n2ZpY1kfxPPdMn6U/2rgu75VPJ/diev/ma45+l5z1rICKxlFefELgccSGqwR7W9KKV+mMmje954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcKgFtCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9E1C4CEF5;
	Wed, 19 Nov 2025 13:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763560708;
	bh=5hfKTCbULdlh1TXPL9Ge4boq3PyMZ1wrd8RFXCwLQt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FcKgFtCF0UNe1r91rz7z0A8rA/DK6SbFzHz4zdUv9Jsx1y51K71CrKaQEqo9yw9ec
	 qVgxzusP4O0iWOZ+faA9lihJWGE4vmbuh1I4TuWqe0IQUd5ys6IPs7GThuu98SsbCa
	 lc69wTCJ5bYPIIg2bNzFg5+XNj0IV2lrL26UNs0cB4NYxxquz9UUNBUMImfJwHVqHk
	 7ygVY/j+u0MqWU47rWms3NDKVPu7PserffgDrAKM7DhZiP+Z0hBt6BHMInSZ2qBxIj
	 3KdZbkRzcw75dM9XL6cWEFl1ANG57kFkAme9vpTSUG8fY7RJc1PpboQZDVCHtAl/5Z
	 ZKnJjgozhN7DQ==
From: Trond Myklebust <trondmy@kernel.org>
To: Michael Stoler <michael.stoler@vastdata.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] Fix verifier initialisation races for dentries
Date: Wed, 19 Nov 2025 08:58:23 -0500
Message-ID: <cover.1763560328.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <53bc46637bdc4b267a318c74fb4c97cb382f29d1.camel@kernel.org>
References: <53bc46637bdc4b267a318c74fb4c97cb382f29d1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Michael Stoler reports seeing an issue in which an uninitialised
verifier on a dentry is causing an incorrect revalidation. This again is
causing him to see a removed file as being still present during an
exclusive create.
The fix should be to ensure that all verifiers are initialised before
calling d_splice_alias().

Trond Myklebust (3):
  NFS: Initialise verifiers for visible dentries in readdir and lookup
  NFS: Initialise verifiers for visible dentries in nfs_atomic_open()
  NFS: Initialise verifiers for visible dentries in
    _nfs4_open_and_get_state

 fs/nfs/dir.c      |  8 +++++---
 fs/nfs/nfs4proc.c | 27 ++++++++++++++-------------
 2 files changed, 19 insertions(+), 16 deletions(-)

-- 
2.51.1


