Return-Path: <linux-nfs+bounces-17259-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BF7CD6F71
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 20:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DB7A3003FC8
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 19:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D070F336EC5;
	Mon, 22 Dec 2025 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgibM/Q8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF913358C0
	for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766431808; cv=none; b=jTH5bdHE/z68DnVS1iNeaO/+uDJELv14MCY4otuXnNP2i3wucmhdm5D/CIWzjSOGT/9T3pVFhx/UaCXKKrf2iogXt33fvfsRFIbFZ5zsrkZNDf/aBA5O7jbT65F7UrNvYfVMErA9uUS4qneUcaup0UEbU9nFFnoZlhjGOb0w8dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766431808; c=relaxed/simple;
	bh=HYvb8sflls5s3x1P0b/c1n4eRwy5eiAg7TuCTXC+L8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgMg1WGHJ6D+IN925HsNw5NlXryd0UMSOCrUKO2m81ZbJuMDYevxObPpG8vFOcT8NinKqfV1AoAKg/kpjvYjxLyeAJSUygxp4ndY2iyRkPyCMG9MoWlQTVqeHosihBPwCbKbgFvxaDtLJeEifbJU+tEQuOu8d4drcoiVf2pF3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgibM/Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B965C4CEF1;
	Mon, 22 Dec 2025 19:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766431808;
	bh=HYvb8sflls5s3x1P0b/c1n4eRwy5eiAg7TuCTXC+L8w=;
	h=From:To:Cc:Subject:Date:From;
	b=jgibM/Q84Yz2Ak0qElioebyj3v+66Gf6CD6aT0IJL47JsgS1ppsEyTfBi5TrthZXs
	 hxIq+KJI+lDBQI4ptIaMWjzNYv0QQOgrUNw5pEoTXBCwVDEpoqFpC8W/mj4ZhE9UWD
	 Y5FeQkJpRxgV9SZ/dPBrdvrGMvBZZK+h9pMDXfDjkstImLQP1eAz8peUm1fSBkxe+V
	 tJ6nHwBLFvLrbvnMT9dkXsRywq2mrBr14HfC+gBhWeIr5Fy6M9AAahXwdNwHCKwFKB
	 CFXB+YPDRCCrDG1EF/wXig+EssimW2HTsrWxDph0uTzZaqACJgYIN9zSemxE4Y7xIs
	 LXEeXbEyDy8Yg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/2] nfsd: fix handling of timed out idmap lookups
Date: Mon, 22 Dec 2025 14:30:03 -0500
Message-ID: <20251222193005.1492196-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Following up on:

  https://lore.kernel.org/linux-nfs/20251127175753.134132-1-ailiop@suse.com/#r

This series addresses an issue occurring during v4 compound decoding, when
idmap lookup upcall responses are delayed in userspace. This causes the
related request to be marked for deferral and to be dropped, preventing
nfs4svc_encode_compoundres from being executed and thus never clearing the
session slot flag NFSD4_SLOT_INUSE. Subsequent requests will fail with
NFSERR_JUKEBOX, given that the slot will be marked as in use.

The first patch fixes this by making sure that no deferrals can happen
during decoding.

The second patch fixes the return code of delayed idmap lookups, so that
clients will retry the operation instead of aborting with an error.

Changes since v1:
- Address review comments
- Add Cc: stable tag

Anthony Iliopoulos (2):
  nfsd: never defer requests during idmap lookup
  nfsd: fix return error code for nfsd_map_name_to_[ug]id

 fs/nfsd/nfs4idmap.c | 52 +++++++++++++++++++++++++++++++++++++++------
 fs/nfsd/nfs4proc.c  |  2 --
 fs/nfsd/nfs4xdr.c   | 16 ++++++++++++++
 3 files changed, 62 insertions(+), 8 deletions(-)

-- 
2.52.0


