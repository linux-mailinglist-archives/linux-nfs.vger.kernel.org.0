Return-Path: <linux-nfs+bounces-1979-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2682E8570D0
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 23:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F927B22EB7
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 22:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3948913B2B0;
	Thu, 15 Feb 2024 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ov1X2TZb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F4C13B2BF
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037727; cv=none; b=ao6rP4lesdDpTT8RUqVQZpWjhpK3XZEzK84mOKwC+YzJ+7jhXbbPjNIU/pDwgQ3pij34Gts4gpkNmFEUrnAA44FA4XAc40UhS8S73MLAI2rbqocL4QugGcqez2mRurC2zQvU0LZRAXZ0A7nbX/xaWizdKK8rxMfz2H0Jw8nK3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037727; c=relaxed/simple;
	bh=U1gmNEWTKo4IJSclkr9hTp4KH3uqfHMPAHWnlh8qeOc=;
	h=Subject:From:To:Date:Message-ID:MIME-Version:Content-Type; b=X0fl2QPepIrF87U96v7MJNdjXIgjLhYkzYjlKWTKLBEPuGHvgOd/u8e5BKgpHv8ulSe4W0grCNvUrZMWm5Wyf6MGM4SPl+Y600iQX5p29LcTVxm9OO39PoLVS3H7jjZgwfcVR47Q9p4PcRQU9sFpdVBPBFlpsrM/693TBCTSkzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ov1X2TZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B907C433F1
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 22:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708037726;
	bh=U1gmNEWTKo4IJSclkr9hTp4KH3uqfHMPAHWnlh8qeOc=;
	h=Subject:From:To:Date:From;
	b=ov1X2TZbQd9ksrAiDc7Z8BiFxfnq9vivLREKhEhr3hRONPkKm3IQ8mMwVW6GI0QqC
	 TXeykfvqb1b34/HoYC+ndKh5AWtX8y8GikQ2Nf19U4tKLdCR0hHHVJaaWR3La4BN7E
	 UoICuZ+TBIbu75cKbfB5TXQhgEOz1a/NsN8Tpy+gWLAIyR1DWAwjsJFwsNDfdesEeI
	 9oZKwcpVp9/2vF5G//QMq6MXeQ14arjOeoMAPlfdS06hQxlDrkoTTB/1xbk4i9L07r
	 NmCGM8gUSCBXUsD1kPJoV+qPTqqVJoRupv8Q9prpodK6qqFPWFODzfi0o69h9rkK3k
	 eruXm8HlXwBCg==
Subject: [PATCH v2 0/2] Fix NFSv4.0 RELEASE_LOCKOWNER in v6.1.y
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 15 Feb 2024 17:55:25 -0500
Message-ID: 
 <170803741752.10525.14867593238471365383.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Testing is nearly complete and has been successful so far. If folks
agree, I can send these to stable@ for origin/linux-6.1.y.

See also the nfsd-6.1.y branch in:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

---

NeilBrown (2):
      nfsd: fix RELEASE_LOCKOWNER
      nfsd: don't take fi_lock in nfsd_break_deleg_cb()


 fs/nfsd/nfs4state.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

--
Chuck Lever


