Return-Path: <linux-nfs+bounces-9805-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DBDA23648
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 22:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2351E16591B
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 21:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D491AF0CA;
	Thu, 30 Jan 2025 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqTD2Kpl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D401B1AC884
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271049; cv=none; b=FHlEPpg1HhMdBZ7mgaNmgVsP481rA6EbdqeKGgqEqUMWFnZxxl+oS4SSC6g9WdA4c/cEVV7X8algn4OFnm851GrKq+r+xBQjBX7BjzXOjcrTrskH9Mu5+bYZG7VPj/sRNYBPAvSuuvHmdWJOSwVK4WW8evVmAUeb3v0Peulux2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271049; c=relaxed/simple;
	bh=oSIcGgMUK4c5DwffLSn5kl7fW/bLkab9YCxP6/Dp/jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4joZcGMmuqGcYCdTmqqa/DUbY0OJ+tdxWjt92JgWIEeEtEzVVhynfO0s2uuS3Uc5tvRzTHIWX/kxU1JmYJqiqFJpXKQnE7aOA6c4wXxsHssEwHU1Sr1IOj5fC49yoo2m/K2XQSxi5VvjdWnckV+b466TDJVzrvGsUCaAPWpvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqTD2Kpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA67C4CED2;
	Thu, 30 Jan 2025 21:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738271049;
	bh=oSIcGgMUK4c5DwffLSn5kl7fW/bLkab9YCxP6/Dp/jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tqTD2KplRX15pXZnzfcINhwkhixQLQCpta3X2s+l5WbILQ5ItePZJpAki9YRfOan8
	 jYnfPVaG//f8TM/eQku0W7OrIH5NdbJzQ41dsnEErTkf4HSmC19HfVzzTkq1BiqHks
	 UxtSIMKMYl6fxsIpIpHc5BaEYlz1/o28A7tXaKvjf3Dmcyu2p7AaYoMVKzWHLm5Xm5
	 OwjlxOpfuJ6i6l1b9xoa887mXrTYSkpPrphQ02nft0VRUt2e8LDgYnOLooGbP1xkYT
	 AjLEK3U/9In+Ps/niq53ZPWoh9hP2M4eJEZ6qH4mgpCUssyAbMjF1EeuhZ1GRTOE/l
	 249sOLIkuf3cA==
From: cel@kernel.org
To: jlayton@kernel.org,
	Dai Ngo <dai.ngo@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/1] NFSD: fix hang in nfsd4_shutdown_callback
Date: Thu, 30 Jan 2025 16:04:05 -0500
Message-ID: <173827098614.49910.9884870664401566457.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <1738263687-28256-1-git-send-email-dai.ngo@oracle.com>
References: <1738263687-28256-1-git-send-email-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 30 Jan 2025 11:01:27 -0800, Dai Ngo wrote:
> If nfs4_client is in courtesy state then there is no point to retry
> the callback. This causes nfsd4_shutdown_callback to hang since
> cl_cb_inflight is not 0. This hang lasts about 15 minutes until TCP
> notifies NFSD that the connection was dropped.
> 
> This patch modifies nnfsd4_run_cb_work to skip the RPC call if
> nfs4_client is in courtesy state.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: fix hang in nfsd4_shutdown_callback
      commit: c1d827093999bd9c19d81b0af4b3034a55b49d5a

--
Chuck Lever


