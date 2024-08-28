Return-Path: <linux-nfs+bounces-5829-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4B1961B25
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 02:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336D41F23F3A
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 00:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11DC11CA0;
	Wed, 28 Aug 2024 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SldUF1KO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF7F18D
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724805890; cv=none; b=FNEt9BcQh0d8fy0CcQGxvFnnpzDV5CPDwa34HFxRm5XcOKR4YVshaXlMcsgCBAQPJ3Hs0jDUf6pdAaax3AL5qpJzQIp29geJVU+w1w0DXfhss+Ag0/TUR5RatXbo9AYJzn1eyJH//JiBzeFXiff+T9oe6VT4EZ8L2rjceUV3Upo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724805890; c=relaxed/simple;
	bh=iR07u0U7hbbt4A9vvl3yHAbqWNiH9cpYDM+agvXywQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZS7Q6/HjQszOApQBgvHLDEVsTft3unes1MHGMRGqgm94bDq6iSORugPXNw5vqnZH/bC2cBhTELmj6AiwzhUMzbAlYp1XSnQM/pzo6Msg6HkmaD5zzXLRo/uFlUjv9UHsnXB/SCUHyI2GuuDllS3YD6BBg5AGSAMtSa4+TJ8/Xg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SldUF1KO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0953C4AF54;
	Wed, 28 Aug 2024 00:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724805890;
	bh=iR07u0U7hbbt4A9vvl3yHAbqWNiH9cpYDM+agvXywQ8=;
	h=From:To:Cc:Subject:Date:From;
	b=SldUF1KOG+OAdTswB2J6IMjY+1r6FUQ8mJJzDBS5BXch7PLPmSoVYJDrz+9PqfQBb
	 QpYwn4h45x2GmJo3dS7BQFzdiBiV8NdNIcLrtqkGuJMkFtkfzV0na4WbyUH1VGM8+Y
	 IqfUNnL9vF9FyEXoF8dmBvKAxW4Czz++muSXPoYhJYwNJB3zcjbBtVAAUVNIVQqvJt
	 0BA8L0y6xjj94tYSXJ+VTf277Oew2yR3pdto2nagl0F1ws1AAB68e9ompSdHfmoHG5
	 IVVmp00oBMOm4djzzrrVy7OO5j4niCSNZQIT+WvZgt92UClkhs6Av6mEdE1/YCVbo6
	 a7Y857zeQNk6A==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/6] Split up refactoring of fh_verify()
Date: Tue, 27 Aug 2024 20:44:39 -0400
Message-ID: <20240828004445.22634-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

These six patches are meant to replace:

  nfsd: factor out __fh_verify to allow NULL rqstp to be passed
  nfsd: add nfsd_file_acquire_local()

I've removed the @nfs_vers parameter to __fh_verify(), and tried
something a little different with the trace points. Please check
my math.

These have been compile-tested, but no more than that. Interested in
comments.

Chuck Lever (2):
  NFSD: Avoid using rqstp->rq_vers in nfsd_set_fh_dentry()
  NFSD: Short-circuit fh_verify tracepoints for LOCALIO

NeilBrown (4):
  NFSD: Handle @rqstp == NULL in check_nfsd_access()
  NFSD: Refactor nfsd_setuser_and_check_port()
  nfsd: factor out __fh_verify to allow NULL rqstp to be passed
  nfsd: add nfsd_file_acquire_local()

 fs/nfsd/export.c    |  29 ++++--
 fs/nfsd/filecache.c |  61 +++++++++++--
 fs/nfsd/filecache.h |   3 +
 fs/nfsd/lockd.c     |   6 +-
 fs/nfsd/nfsfh.c     | 210 ++++++++++++++++++++++++++------------------
 fs/nfsd/nfsfh.h     |   5 ++
 fs/nfsd/trace.h     |  18 ++--
 7 files changed, 223 insertions(+), 109 deletions(-)

-- 
2.45.2


