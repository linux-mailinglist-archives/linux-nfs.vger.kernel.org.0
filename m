Return-Path: <linux-nfs+bounces-13419-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3ADB1AB06
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 00:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDA43A74ED
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 22:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E351DE4C3;
	Mon,  4 Aug 2025 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xyl6v7dr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33C2E371C
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754347732; cv=none; b=bi6iq2G589cX1dtz2tl78FG9/IbGW4SOLgmYAWWBO5gxyVofLtiGDaUTvYRKtKYpBj8WtiSZgYgnhbO+nzp3Z2xZFY11DM6/FtKX3gXYM6mMAI+L40TCF2NPaq1FU5rEx5VCMPoxA6YesfhRrX85HAd2k9L28JpHHm/dW30phjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754347732; c=relaxed/simple;
	bh=ktBfDGJaO5YgaQOxV4OQyWJtVWyz2kOCq3mJ5HEZZzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=unVvjqZInC9autXR4VJcwifENZHS3i9olkV8nvNZRWExJ64BTxMsm16OfmuKyQICgpd41Pg9fc3ASEcGol3pPQq8rP+aMKM/ieEPgOcsSpfaEsGGc/D09I390jg6apTMZce2obBKk6dt7KT/PuyFH18ztT6eZtQLXPPSdwZTsAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xyl6v7dr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7F2C4CEF0;
	Mon,  4 Aug 2025 22:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754347732;
	bh=ktBfDGJaO5YgaQOxV4OQyWJtVWyz2kOCq3mJ5HEZZzM=;
	h=From:To:Cc:Subject:Date:From;
	b=Xyl6v7drtvJ6xuBPIK96NJHX7MyCbZBUtNrXXFOUMojbx+uGB5GEBppBg3VRvP3bh
	 qOtytCFu5bC2y+abtBSqeTXfcT8MeKirAdfHZYde7elnVg4waTELkrPQw5RnQMK6Wg
	 7XYAvgBILPVrfVHlXlhos7bmuwUw2y8I37pqtuZQ+ULZtouqeAZ7A/2dm7Q8twnWq1
	 0NpeeA2ahZUR6SwYydvUDAW0Mrj+dfCbfxTUPr5JPtZ//DfOR8gaox6LrHOLXHOOA4
	 4+FNy6nVNQI4UTngKRfhY5dxeYAIxOWRhQDpMsY3Q9uH0y9G92dGVVgD1DEEFAotbG
	 /H+mSq6gC6hmA==
From: Eric Biggers <ebiggers@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 0/2] nfsd: Clean up nfs4_make_rec_clidname()
Date: Mon,  4 Aug 2025 22:46:58 +0000
Message-ID: <20250804224701.2278773-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two cleanups for the MD5 calculation and formatting in
nfs4_make_rec_clidname().

Eric Biggers (2):
  nfsd: Replace open-coded conversion of bytes to hex
  nfsd: Eliminate an allocation in nfs4_make_rec_clidname()

 fs/nfsd/nfs4recover.c | 31 +++++--------------------------
 fs/nfsd/state.h       |  4 +++-
 2 files changed, 8 insertions(+), 27 deletions(-)


base-commit: 35a813e010b99894bb4706c56c16a580bf7959c2
-- 
2.50.1.565.gc32cd1483b-goog


