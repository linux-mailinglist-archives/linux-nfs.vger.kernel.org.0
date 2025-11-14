Return-Path: <linux-nfs+bounces-16408-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0FAC5F3D7
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 21:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C03794E0369
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 20:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA1343D75;
	Fri, 14 Nov 2025 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfG60flH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739FC342536
	for <linux-nfs@vger.kernel.org>; Fri, 14 Nov 2025 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763152176; cv=none; b=EDYKS0ycXT7MRuoZda/MwJUCa51UVstzj1fiDnZSbnZ1w6k4mUUzVHqijOPQU+D6d5FxRwi/XiY94rOpiFVtqiOcgvYaHTrYOBnXZtRntfksrkb7gIu4iXEpjdzaJdbaWxCPMBue6ILQFUER03qV1Jlp7ZL6F1A5/nB9/gw3CcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763152176; c=relaxed/simple;
	bh=TW77I05qDQAOMaqkBjgxZJolt2m7oSCeDJmiQbOPv4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F649GjfivY9abB1OUp/CVBLRkQoAaTamPZ2Qpf/3mIojVPLrYukuqdy1LSfbt1tlta0M6SokEeuyl9F7RymQL68p8OKMzUpKtZkbrrVl28OuaQACbRYjdiOLS/yp7ygkYlbWea+PgdaeINyx2cbnfZEe4klAD3H5VX52ILKeKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfG60flH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67063C4CEF5;
	Fri, 14 Nov 2025 20:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763152176;
	bh=TW77I05qDQAOMaqkBjgxZJolt2m7oSCeDJmiQbOPv4U=;
	h=From:To:Cc:Subject:Date:From;
	b=OfG60flHKHf1ynsDOssW8i3EKB2Zzk8R5+MebLUOMkVw6fG/Kg5meC2DUY1ZISjic
	 2ituiu27drLSufBsnM3qRsA0TQNaEmRVW/oKupW5s9LIAlI8Vh1U8ZliuZGcsbAU4p
	 j9jkkvB2sDiCOZHQr1b0TT047OAETWPSdOdeb4xar9q2H76O1MFy5jzDCusgomYLVn
	 TOVt4LhPnBep5m6dLFBeVakJD04c9k136q0kw2nd5LR5s8k3r6xLNs4mnfnWFITXRL
	 W6HHrGay8ghS+ftUL5hqCfKzvlL1C2/HO2Fp9UuFO3auhuLj288dj+MLrO3deCQm04
	 fWz2w0sCx3FjA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 0/3] Update suppattr_exclcreat bitmask
Date: Fri, 14 Nov 2025 15:29:30 -0500
Message-ID: <20251114202933.6133-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

While working on some new pynfs tests to verify the behavior of
OPEN(create), I found a couple of bugs in NFSD's suppattr_exclcreat
bitmask.

I've split this into two "fix" patches, because the fixes have
different LTS blast radii. The third patch is a clean-up that
should not be backported.

I will post the new pynfs tests under separate cover.

Chuck Lever (3):
  NFSD: Clear SECLABEL in the suppattr_exclcreat bitmap
  NFSD: Clear TIME_DELEG in the suppattr_exclcreat bitmap
  NFSD: Clean up nfsd4_check_open_attributes()

 fs/nfsd/nfs4proc.c | 40 +++++++++++++++++++++-------------------
 fs/nfsd/nfs4xdr.c  |  7 +++++++
 2 files changed, 28 insertions(+), 19 deletions(-)

-- 
2.51.0


