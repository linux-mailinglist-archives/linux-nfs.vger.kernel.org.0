Return-Path: <linux-nfs+bounces-15289-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52581BE3CCC
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 15:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FB664FA774
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 13:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB592E6135;
	Thu, 16 Oct 2025 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkoSrEcM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F101DF982
	for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622601; cv=none; b=CpLgtMAJPqO773SADIfCOrHa/ZRajDI9XsW536Vw/sUKs0xVbeLjrbw2DFFwCINrfsSOb5Pr1/0WeBcVZI8MoynXYO0yp9CTlktwKffI8DMSpEQK4CdVhO1pMToLHj659OT9vpwgFGRBht/I93R5AD1/e+gC40Rhx3dQMNhD6Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622601; c=relaxed/simple;
	bh=/1Mr70BgF+UQOnSpOtVbDpwV9eyvkTgTZrdtjq9RaIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNWFvGbcNgTxggTmPS3SxZNJql9RDezsbACSRMJ1Y3/Xff0QUE4QIgeZQypSfOrJ2BsO43U2CpxiQ5MgeEsY7pJEm2kDkZNqDNmfPzWXrTQ/LdseNdG87y2p4jrXW8oRWsz86vuAzqKONUoR43bYnmu8/e0P5+8dStrJhj8f11U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkoSrEcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B276C4CEFE;
	Thu, 16 Oct 2025 13:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760622600;
	bh=/1Mr70BgF+UQOnSpOtVbDpwV9eyvkTgTZrdtjq9RaIw=;
	h=From:To:Cc:Subject:Date:From;
	b=NkoSrEcMIItxcQH5axPCikldWKXkpOGAnSUtCMt24Qq5NxBFQr5lNK6s9CJ6tTVM7
	 M2tnzhe/pYaq4NgOgc57mMbd9MgE29S6XKKNwGriNcGv6s3oMfEPpGqI28psItZ6ov
	 nScTUxaVLZGWLNQnHA64HmBTlHhFSxpw1U/M67D+vLYTN0ed3zDbmq0654SnT637lV
	 RTdqXeU6xv6B+jkjfb4+/ZY6yN2XfDQncGzwtu/6BTe1kAlE/XGE5VJbecaTTV+jwn
	 vitS2qJtbSHTcyaokpWI1FnIqRxL5WwHTXFZfEn84JMjj7XXFZCJF3+TMb9pd1uGPW
	 qIqcleRiSU3Uw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 0/4] Fix unwanted memory overwrites
Date: Thu, 16 Oct 2025 09:49:54 -0400
Message-ID: <20251016134958.14050-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

<rtm@csail.mit.edu> reported some memory overwrites that can be
triggered by NFS client input. I was able to observe overwrites
by enabling KASAN and running his reproducer [1].

NFSD caches COMPOUNDs containing only a single SEQUENCE operation
whether the client requests it to or not, in order to work around a
quirk in the NFSv4.1 protocol. However, the predicate that
identifies solo SEQUENCE operations was incorrect.

Changes since v4:
* Replace 3/4 and 4/4 with Neil's "nfds: fix up v4.1 slot-based
  replay handling" series

Changes since v3:
* Neil observes that in this code path, SEQUENCE always the first op
* Expanding the size of the replay cache buffer is unnecessary
* Reordered and simplified the remaining patches
* Haven't yet addressed imbalanced maxresponsesize values

Changes since v2:
* Never cache a COMPOUND if SEQUENCE fails
* Enable caching of solo SEQUENCE operations again
* Reserve enough slot replay cache space to cache solo SEQUENCE

Changes since v1:
* Reordered patches
* Disable caching of solo SEQUENCE operations
* Additional clean up

Chuck Lever (2):
  NFSD: Skip close replay processing if XDR encoding fails
  NFSD: Never cache a COMPOUND when the SEQUENCE operation fails

NeilBrown (2):
  nfsd: ensure SEQUENCE replay sends a valid reply.
  nfsd: stop pretending that we cache the SEQUENCE reply.

 fs/nfsd/nfs4state.c | 123 +++++++++++++++++++++++---------------------
 fs/nfsd/nfs4xdr.c   |   5 +-
 fs/nfsd/xdr4.h      |  24 +--------
 3 files changed, 69 insertions(+), 83 deletions(-)

-- 
2.51.0


