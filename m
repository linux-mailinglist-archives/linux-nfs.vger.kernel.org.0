Return-Path: <linux-nfs+bounces-10124-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB68A36295
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 17:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130A13A7057
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49882676F8;
	Fri, 14 Feb 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVlEG8y5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8626770E
	for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548670; cv=none; b=E5dHLVf3X4tEOYwNUefgFfM0gqIPwq5YWPZWB17x2UpppzjKQ4k9HBUvwuRWeEcf07vnQJvrfsII/pt1PzVKYRhnbt/AwK9pvWWheQOC9Zsd9uHTraxZqByjeAGwHRCmK7QqOksD282dWxff7oM+J6KcBdzbaEN3+krFckEmAXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548670; c=relaxed/simple;
	bh=gnaMNOujQtnTMMAABOUb5+O5sm8b0cXQ+zVNuBFYc4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQJW/Wfo4oZWTC2ilZLvJMubLIVokZD+PpxvsAmntM5vap9+zRrTBGmoExIT69viLODMNrRji5irt5/Awq5gNmWotgROyDr1WMMWXXzbCh5PU7dvzKyB1SWVNYJLlGBhN6TWM0/DrVB2pWz6yFe99rtg6Gmwt8gD4meHuZLwCsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVlEG8y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1AEC4CED1;
	Fri, 14 Feb 2025 15:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739548670;
	bh=gnaMNOujQtnTMMAABOUb5+O5sm8b0cXQ+zVNuBFYc4k=;
	h=From:To:Cc:Subject:Date:From;
	b=WVlEG8y5apGyyBijNFrDe9ymUVCFvbRqsCqwdqEIE7hjKxXNCDU7yZYT+wkN4ZJ6+
	 d2bAK0vnlm0KJgaAlG8wuEmOw4WtQwMsRXss3k6PV44nd14OwplA/AdJ911w3naJFp
	 eXBf3KC/uRoC04ZWOwnO4gGF/Qby5r7XZ8/kCTcAwOfApYiSoOXwc5Bin8H/Y+S/n2
	 LQ+AU2bezKEC6ReMLnM9tahQ6LAd7vgE1lsfpeTVYxoE50xpL9GOOFlAnfbWhPatTS
	 0Br4W7TIzQhuRAV2tQkKSKTMq8NRphFicdhfoNe+F4IfB7rSzhPb6Itbf989+Ctucd
	 O/RQqNSnTXmyw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/3] Implement referring call lists for CB_OFFLOAD
Date: Fri, 14 Feb 2025 10:57:43 -0500
Message-ID: <20250214155746.18016-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I've built a naive proof-of-concept of the csa_referring_call_list
argument of the CB_SEQUENCE operation, and hooked it up for the
CB_OFFLOAD callback operation.

This has been pushed to my kernel.org "fix-async-copy" branch for
folks to play around with.

Compile-tested only. I'm sure this is still full of bugs and
misunderstanding.

Chuck Lever (3):
  NFSD: Record call's slot index
  NFSD: Implement CB_SEQUENCE referring call lists
  NFSD: Use a referring call list for CB_OFFLOAD

 fs/nfsd/nfs4callback.c | 132 +++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/nfs4proc.c     |  10 ++++
 fs/nfsd/nfs4state.c    |   1 +
 fs/nfsd/state.h        |  22 +++++++
 fs/nfsd/xdr4.h         |   5 ++
 fs/nfsd/xdr4cb.h       |   5 +-
 6 files changed, 169 insertions(+), 6 deletions(-)

-- 
2.47.0


