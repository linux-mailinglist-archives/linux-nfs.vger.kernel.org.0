Return-Path: <linux-nfs+bounces-10438-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696D1A4CD9B
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 22:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC003A7EA6
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 21:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BF422F173;
	Mon,  3 Mar 2025 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="da9MpMmF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FB61F03C7;
	Mon,  3 Mar 2025 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741038097; cv=none; b=KUQHXzh31kKE1lkxTx+/1TgdktzXWluZw4dTvUBKgK0UEmlyTGQWsa25p4EB5uV/rD5vfzEeupxBlUcS1uvvbXUTOIC800Wg8EIPc11ezX6rW8DOSFYYfCFqO3EeDV5N3Ad6Km/B+HsRxiRjntKifiaplW8XrvRGn1XV+YxpBVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741038097; c=relaxed/simple;
	bh=RfJLyGbZQFlBxQrbiiAtnTGACEVv/rh9GHEh3E/qm5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/Lvc1gDLc3UyO0KPrDu+CcqRqumJjbuX9WUBP7bq9IIa8oFma4tL+KFfbGByVxDv4TfVo/xM2YPh8lWo/uNEFd6dKPU3XWuDkaAeld+zpwI6it7VO6Et3qpY1vvgsHKiK4S+TqKrK+Bc7cVyxs6T6OWlgoi6arb+VSyEEy5wFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=da9MpMmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDB8C4CED6;
	Mon,  3 Mar 2025 21:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741038097;
	bh=RfJLyGbZQFlBxQrbiiAtnTGACEVv/rh9GHEh3E/qm5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=da9MpMmFCrW4MntB5BMdDUjo6liOkXL/Zub+73Pym2MgrMHy2cr0P+6cBbZyHoKV3
	 DvFxH0cEYpUJ/Hoel3dvgzy2gzO7XnWRPyCGyO3YNaccBuXVeJvGuoqqj3ZumJX6k1
	 GtcwwuGdaYG+ovmyisUWTXa4TOQ86y4szodQ4wMIBOLDK7Z62t+Wnhf2abh5LNn7oh
	 1YvkR44KRK2QLgDsm3n0TlfLcJq+ereRF6zEJ7Qj5Mt231uMeCN8eGlKLi6cqI2GoF
	 ztNVuK1dkMeB6n4dG0n8oIZBy/XcireHBNVKDcQiQAbl7kckEynb8IFoV6fJEiFg87
	 57ttxG2G9NGhw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] nfsd: some small cleanup patches
Date: Mon,  3 Mar 2025 16:41:32 -0500
Message-ID: <174103804128.30685.4776199230562847610.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250303-nfsd-cleanup-v1-0-14068e8f59c5@kernel.org>
References: <20250303-nfsd-cleanup-v1-0-14068e8f59c5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 03 Mar 2025 12:25:58 -0500, Jeff Layton wrote:
> This is a pile of small patches that I've been collecting. None are
> terribly critical.
> 
> 

Applied to nfsd-testing, thanks!

[1/5] nfsd: reorganize struct nfs4_delegation for better packing
      commit: 125e6a10ea13220737fb44769e449a77609d0141
[2/5] nfsd: remove unneeded forward declaration of nfsd4_mark_cb_fault()
      commit: f47d831d1066a7f344bfe4d9046cc1d64855373e
[3/5] nfsd: remove obsolete comment from nfs4_alloc_stid
      commit: cb539e9d699a4507c28809edf2f8671fe1e1ef6e
[4/5] nfsd: clean up if statement in nfsd4_close_open_stateid()
      commit: a0f8129957c861f235abc7ae1c24ce11f9bb8d6d
[5/5] nfsd: use a long for the count in nfsd4_state_shrinker_count()
      commit: 2327318960a4c4ebb1745f09d5d310b9bb545e98

--
Chuck Lever


