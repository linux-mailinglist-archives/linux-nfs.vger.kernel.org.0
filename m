Return-Path: <linux-nfs+bounces-9695-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F18A1DD13
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 21:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD2F3A4D4E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 20:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FEB193079;
	Mon, 27 Jan 2025 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtc2cAZD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB711917D6;
	Mon, 27 Jan 2025 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738008017; cv=none; b=G7hLCZcNjCopfyyIbOvi7Tlp7zpyWLs08FJDTonhEpof3IfrzPjX54OFzByRyisj5FUePDIZ4JkAFBx06FItg9LoIheyGFl5VBpqERFEi39U/s+E2DqYFE0sPQJqy5m5P6kfw2XhSrexFcGUegEO7CzxYK7XJbLbvwb21ohTjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738008017; c=relaxed/simple;
	bh=+ZBHbJOhhVFf70TQ5Jz8wBh4o6GBK1Txh5ZvTZfMuTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFMH2l/O58ZNqogtf1svwST8JmL0v6/yt0nqa1iCSNfQotUuuhWQH0fWY/li21M4c35kmPKCJYfRH7LmKM75hYLPvAZA1Q+Wb5/9B84c2iNYPhAxAr8Yyf+Qfi1ZEStryE2JEtrd5PHo0Y+wTgjVyDh5IO0hMvs88SCRjv7x0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtc2cAZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A949C4CED2;
	Mon, 27 Jan 2025 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738008017;
	bh=+ZBHbJOhhVFf70TQ5Jz8wBh4o6GBK1Txh5ZvTZfMuTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gtc2cAZD0kieQGnDUKlr9mq7OJlIvjQThpYb+Ku6LBAxro3vWPz5KXwvI+3gibvSI
	 HwoqESjUe1ZNY19NOwrJ2GverSjjIGDJAMV0ksojKWJRR42fjpT0rhiY3h43jVOWP3
	 xJh/GAJgsnTIBEbZEh0OB9l6Xgk0zvmdSbqT6hIG46DODpwAd7ugUDmobB31/1yyMI
	 D25cuijbaRZiyCYGekxrACSvqjhovFKPQLk1ZyDzCOvYN390LH9UwVJ+08G2RCPIII
	 3+veoBuzeKWUc0DKhMFQwBTUXHogzQFCCLrk7dRmwpsXft+7AkjWf0Sf+y1GNwIyyb
	 6wPL9H09lT7HA==
Date: Mon, 27 Jan 2025 12:00:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: nicolas.bouchinet@clip-os.org
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, codalist@coda.cs.cmu.edu,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, Nicolas Bouchinet
 <nicolas.bouchinet@ssi.gouv.fr>, Joel Granados <j.granados@samsung.com>,
 Bart Van Assche <bvanassche@acm.org>, Leon Romanovsky <leon@kernel.org>,
 Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, Al Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v1 0/9] Fixes multiple sysctl bound checks
Message-ID: <20250127120015.1dd5c039@kernel.org>
In-Reply-To: <20250127142014.37834-1-nicolas.bouchinet@clip-os.org>
References: <20250127142014.37834-1-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 15:19:57 +0100 nicolas.bouchinet@clip-os.org wrote:
> This patchset adds some bound checks to sysctls to avoid negative
> value writes.
> 
> The patched sysctls were storing the result of the proc_dointvec
> proc_handler into an unsigned int data. proc_dointvec being able to
> parse negative value, and it return value being a signed int, this could
> lead to undefined behaviors.
> This has led to kernel crash in the past as described in commit
> 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
> 
> Most of them are now bounded between SYSCTL_ZERO and SYSCTL_INT_MAX.
> nf_conntrack_expect_max is bounded between SYSCTL_ONE and SYSCTL_INT_MAX
> as defined by its documentation.
> 
> This patchset has been written over sysctl-testing branch [1].
> See [2] for similar sysctl fixes currently in review.

Please don't group patches for different subsystems in a series 
if there are no dependencies between them.

Only patch 3 seems relevant for netdev@ / core networking.

Please repost patch 3 separately with extended impact analysis and 
a Fixes tag (as requested by Joe).
-- 
pw-bot: cr

