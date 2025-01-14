Return-Path: <linux-nfs+bounces-9206-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F452A11147
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 20:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A58188A384
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 19:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD798202C41;
	Tue, 14 Jan 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGHm85gS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D941F9F66;
	Tue, 14 Jan 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736883611; cv=none; b=AHLSculpwJAlb6BRRtK1wAysIKTai+rwS2l5NUnybtelwITDEV9FZP2S5I9kBTthmQBLTejTW+kTdMgFOxYwXKuEzH+jI7CLj8ebqJTH7NXJ5bzcaawo24Gs3IIAmuRXdYHvjmukjMyov+VKpLAXhgK6bEEvViWINh8/RaHAJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736883611; c=relaxed/simple;
	bh=94f1Y2Dto4ROJU2YdG+LZuNS4Pd2m0haQw20y4Yeq10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3/lLjNM1IhcOsOrWxPvQDhbkLSS7gOI3A4X0zHjz4MrC4ai5twdLVcGLu190k/qiYQhWypJsnLS0EvSkKc7bY271ZpdNWOHnMZuMXS1snrpJK4/SEa2lUFnCGDRtZlBH+BOHynmYoUhlNENPzyNmFQ5XMN6hKRyWrWRGQnqE/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGHm85gS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BA8C4CEDD;
	Tue, 14 Jan 2025 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736883611;
	bh=94f1Y2Dto4ROJU2YdG+LZuNS4Pd2m0haQw20y4Yeq10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YGHm85gS4VTAsOarKog6hEbUiehGW8KNjKUFeEGmw3Sf5DjSO5XoGXtxhSLT3uNUW
	 yvlb3G7ZV42rpUqhR2rbBD5xbtcv/EwnaDnvJu7+ZAwCjwQd9HQxtd4nRW40VvMkKR
	 W/VXNCUq7OCiCe6NVEaTnkIDS7q6kcY0UsAnhhflcq1cFv9rwLo5DmyC0mtg+ilIyf
	 Gq1ehNXFz16hVTJs7f3K8vFN4k5S2B4Wdl30kPTrUFilO2Zs4MMjd4cgY+PXjjsAXJ
	 RQl1++d5lfi/8pSUrAcOq2uoCRxUFdoGG8gsD1wqmE3UoiykKo5IXVXYK7ytI7gTPF
	 +K8g6tzm8XUlA==
From: cel@kernel.org
To: jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Li Lingfeng <lilingfeng3@huawei.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lilingfeng@huaweicloud.com
Subject: Re: [PATCH] nfsd: free nfsd_file by gc after adding it to lru list
Date: Tue, 14 Jan 2025 14:40:07 -0500
Message-ID: <173688345341.1372419.3275341539273169743.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250113025957.1253214-1-lilingfeng3@huawei.com>
References: <20250113025957.1253214-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 13 Jan 2025 10:59:57 +0800, Li Lingfeng wrote:
> In nfsd_file_put, after inserting the nfsd_file into the nfsd_file_lru
> list, gc may be triggered in another thread and immediately release this
> nfsd_file, which will lead to a UAF when accessing this nfsd_file again.
> 
> All the places where unhash is done will also perform lru_remove, so there
> is no need to do lru_remove separately here. After inserting the nfsd_file
> into the nfsd_file_lru list, it can be released by relying on gc.
> 
> [...]

Applied to nfsd-testing, thanks!

Cc-stable tag added.

[1/1] nfsd: free nfsd_file by gc after adding it to lru list
      commit: e57420be100ab3ff6d42992a37ce34f3e03d8d91

--
Chuck Lever


