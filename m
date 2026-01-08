Return-Path: <linux-nfs+bounces-17587-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3FCD00770
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 01:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 074F63012278
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 00:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0873D199FB0;
	Thu,  8 Jan 2026 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T15BA2G7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389513E02A;
	Thu,  8 Jan 2026 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767832135; cv=none; b=klrSeoWmJn01zZ+XQYN1owRW6eHhbEcE4vkow8EmXySaJM8Fty0FXsEFJWOWvMUoz1oSvlaNCvv6Amr6ncbrxXnOLoApFUaCvbiT3FmX6c2+iX7iUiGZUDvpdxVtBw7czLvTl3TbqqA0jAuMRnvBF3yPk2uRrps4zWuwrb6j2o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767832135; c=relaxed/simple;
	bh=dilqyGF+66/wOjxQew1lwSNg437K+ZeGUCd0+jqqBHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4QQRQSkUPGfFiU5dkb7WTETDNWDE83r+5KusSk8X36mbqT4Xny4NAkEENWfiokR6AIzaRUZq/WFXwXjbbAPSn4JpQRIaCxpWFi18K0fyLWZ7jWtkJzsRdJZAMEU3CzLLCHj1t4MnUz76S9ESFqmeHjxzX7qLn+1zkm8v/5N/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T15BA2G7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8671DC4CEF1;
	Thu,  8 Jan 2026 00:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767832135;
	bh=dilqyGF+66/wOjxQew1lwSNg437K+ZeGUCd0+jqqBHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T15BA2G7TNpp+j1/Wwp783DlBWnfPd0eARBwBszk4KKVTreo4r7NDIIf/GLwJzr6J
	 9aa8qmwiipoRuQUhCyreGNBSXRwUfq/PZ9ixOpQUvnv4Gf1gz6fslL6Br1eHT8xPxC
	 rHRa4Mz+7sO49SqzbIYFCJQXXFumYx3EBDk79dp/XxsCM0eA3mb+tjDrlao+KKu/mY
	 3uQQi7qP0zoSzWDzmSMG+jUv0mmCpha9jTjSoaNVNfU0YgnTSmr6DFzr3RMqOpGTzh
	 k6W2LZJDBNhomD80Tv5j1HNXY0TqEyqY/rV6kcE+8hA0qSlX+SJZVZigyhHPbFIrqS
	 uSomnoIgaR71w==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] nfsd, sunrpc: allow for a dynamically-sized threadpool
Date: Wed,  7 Jan 2026 19:28:51 -0500
Message-ID: <176783211844.3906223.2883879157306428101.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
References: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 06 Jan 2026 13:59:42 -0500, Jeff Layton wrote:
> This version of the patchset fixes a number of warts in the first, and
> hopefully gets this closer to something mergeable.
> 
> This patchset allows nfsd to dynamically size its threadpool as needed.
> The main user-visible change is the addition of new controls that allow
> the admin to set a minimum number of threads.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/8] sunrpc: split svc_set_num_threads() into two functions
      commit: 039d0b7837eaad0d904631df3ec26b4961ee740a
[2/8] sunrpc: remove special handling of NULL pool from svc_start/stop_kthreads()
      commit: 040f69a4bff8ba6236d69bca06c62adb7588268b
[3/8] sunrpc: track the max number of requested threads in a pool
      commit: 2672a852bfc6d7597a8b202cf5ee813a4a04b1b8
[4/8] sunrpc: introduce the concept of a minimum number of threads per pool
      commit: 80099415fa314dec028bbb3e904ed57ddea55d1c
[5/8] sunrpc: split new thread creation into a separate function
      commit: ad23853b5e7bc156652fd957425d6891dd864ea1
[6/8] sunrpc: allow svc_recv() to return -ETIMEDOUT and -EBUSY
      commit: a37178a2642f98fd6cbed39fa0c508dce3bd7bf8
[7/8] nfsd: adjust number of running nfsd threads based on activity
      commit: f375bafd744fa40cdc48d252e5f5db1242100881
[8/8] nfsd: add controls to set the minimum number of threads per pool
      commit: fe054be1747e1754bc81ea3dabbf85dfab2bed27

--
Chuck Lever


