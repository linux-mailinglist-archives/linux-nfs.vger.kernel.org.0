Return-Path: <linux-nfs+bounces-2970-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E38F8AFD43
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 02:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B2B4B21532
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 00:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1834A639;
	Wed, 24 Apr 2024 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfvSRweI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8806634
	for <linux-nfs@vger.kernel.org>; Wed, 24 Apr 2024 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713917997; cv=none; b=QZMDSGQtKFSQcvfAobgEi8B4XbEScG3oX30cFdRMzr8gtX33VYHx7+Ms4RmbHVhLshzIsb6OESBnYcjzcJwLqGK7f59YjE+sHQyiM0OS2yOTwI+tqF3opGw89TGtp09ecdohk7adSVyzVXNclU6HDDAZWdvymcnWDL2b0R0GM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713917997; c=relaxed/simple;
	bh=symKpbS3bvS9FHK6X10OBiTz/4y018SnBH0ZbrWdB6M=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=dTsevxt7TchuMuJliGHuHglrs0XRv51VK/kji8xwaDV5df8RXq/Xf9cDs98UjM42QrILC3UtOFQDfMvqKQ9v1ZDgg0+31I7364RIY3dxGTnNNz3pf4Rl9SQNzaU9BBMh5VnLQuQTF3lL+tsHXImlgZYqVnmMLRkWZcl1Liiv4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfvSRweI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443DBC116B1;
	Wed, 24 Apr 2024 00:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713917996;
	bh=symKpbS3bvS9FHK6X10OBiTz/4y018SnBH0ZbrWdB6M=;
	h=Subject:From:To:Cc:Date:From;
	b=GfvSRweIBI6qAmfQ0QsA10g8xu4BeN1OcIz7fdNt+TViMvJRtEVk6oSLr3Q3MQhC0
	 NyufCQNmS5O9gG5ge008/lgy5wA7HiS5lIB098UjQwFzvKYJiZeioSNo9K0EMW0xcQ
	 TtCtTJrnwsaPqeIG0qEiUSkACZTz2e7zRTwS4D3pKTp4mFX3Qr8c6Tomd1rkLH/WQ/
	 EA1eic3b+km6hN3vh3RNyMW837PccX9UIpHshDXFsDkuPdO7wRGQrBMLdwVvvgPiOi
	 rMAJTgTlCpAFRL/btStXsf+Ae+BniZ1NwFMMdXnFQAdYCQFluWnIAU2w0CoqUAIfMh
	 acXppbPcwx+ng==
Subject: [PATCH 0/2] Revert NFSD callback client retransmit fixes
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <dai.ngo@oracle.com>
Date: Tue, 23 Apr 2024 20:19:55 -0400
Message-ID: 
 <171391782806.101038.14694256680827795210.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Read the patch descriptions for what these two patches do.

I've convinced myself that going back to the v6.8 behavior is
better than leaving these applied. I plan to send them to Linus
for v6.9-rc. See the nfsd-fixes branch in:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


---

Chuck Lever (2):
      Revert "NFSD: Reschedule CB operations when backchannel rpc_clnt is shut down"
      Revert "NFSD: Convert the callback workqueue to use delayed_work"


 fs/nfsd/nfs4callback.c | 26 +++++---------------------
 fs/nfsd/state.h        |  2 +-
 2 files changed, 6 insertions(+), 22 deletions(-)

--
Chuck Lever


