Return-Path: <linux-nfs+bounces-12867-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ABEAF664C
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 01:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0BB3AA2E8
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jul 2025 23:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E0B1FE46D;
	Wed,  2 Jul 2025 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtGNX/TX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B72DE708
	for <linux-nfs@vger.kernel.org>; Wed,  2 Jul 2025 23:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751499229; cv=none; b=PTzi4B3T7Z0imhumMd/eLGoFEUrTVnEhE02b0145wUV1W2YKogmbuBjxNaDb0aAhPJXGV3qyKa9FTo+1enzgNLObswF9QKJgwAd03VAZnLH0HeWiLPyrtjtgQdyDLTP3Xinf1N+i0jtSUsjTCWxlfDMbS+pgn8FzV6wU1dbfHzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751499229; c=relaxed/simple;
	bh=DHio5CvJezT4tbwV0MG1VxTImeCugaJ6B0BTgEWdxa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JYcTUBYErpQaGNCBNlYGTExhoMVZy6qiRPbxzm0x/+2HvJXdwELuTMzBFfjxUmgFG7hpRJOvVcwax8MyAabVovv8tN9GaV9AHGtSSVZGmEY4nLqFAIUdr1IrMw6dm5W6+QJkO2s/c6LyHMkN1sOsBGLD1hnzZOfjP6GKlVjmx/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtGNX/TX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF085C4CEE7;
	Wed,  2 Jul 2025 23:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751499228;
	bh=DHio5CvJezT4tbwV0MG1VxTImeCugaJ6B0BTgEWdxa8=;
	h=From:To:Cc:Subject:Date:From;
	b=qtGNX/TXjGofNMz0vzOU9JvfywKgxw96M82MqH5x2BXjbV++ozQ26n8TwytVj0fvI
	 J50nHNk04ToLbvGnanvVhCaKCxW4zHSsUSiHpcCDr67asuNaKbg2+hMyimIMW0+Mb7
	 8oL1lTnS9TilTUXyDQNFkH2XVrcNCyBhOnmpwNBJbKdswFzs59BU2efYcbjxIvqgLs
	 oOe/pS4L+tZQ7RO8yTC/W0x1xlffqylPRSJWiSuVu4b6aApDiaicmPizQ6rT9MNziq
	 MY6obLmWRktzoh22KivVaUmcd3YG535yCU5sj+FmB+xkcXHSpCqXCLRKCHRn8TpVTa
	 xNHC4QI2Mz/uA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/2] Relocate fh_getattr()
Date: Wed,  2 Jul 2025 19:33:43 -0400
Message-ID: <20250702233345.1128154-1-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Tucked away in Mike's LOCALIO branch is a patch that, among other
changes, moves fh_getattr() to fs/nfsd/vfs.c. My feeling is that
either:

 - fh_getattr() remains as part of the NFSD FH API, thus it belongs
   in fs/nfsd/nfsfh.c; or

 - if it is to be relocated to fs/nfsd/vfs.c, then it should adopt
   the naming convention used for the public functions in that
   source file.

This patch series tries on the first approach, for size.

It's a nit, I know.

Chuck Lever (2):
  NFSD: Relocate the fh_want_write() and fh_drop_write() helpers
  NFSD: Move the fh_getattr() helper

 fs/nfsd/nfsfh.c | 23 +++++++++++++++++++++++
 fs/nfsd/nfsfh.h | 38 ++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.h   | 33 ---------------------------------
 3 files changed, 61 insertions(+), 33 deletions(-)

-- 
2.50.0


