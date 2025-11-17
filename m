Return-Path: <linux-nfs+bounces-16458-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46317C65173
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 17:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7E9DA2997E
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824F32D47F2;
	Mon, 17 Nov 2025 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qad7bnHR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4062D47E2;
	Mon, 17 Nov 2025 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396151; cv=none; b=sCOBiHhO/sOVgDudz2UZiwujiRTc8m3TeomOhNO2f/tSPzHTxpTRufIX6w+AEUbDfG9tgk1BuXuRzMjC2z3RcSaDIbGLc9trmM8Y89M9HeTyjJEZi12S1QkfvZ7pFLRiznlL4ZJv/+pdTOM3Ei8VsHjUOFtaiRVX/6W/WK2AGQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396151; c=relaxed/simple;
	bh=HSABFkLCA81o6LdP7zKa6RIxaNlL+eO/uFqm2ZHAEsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPLJoDfL1VVH/Xf820IBZ+rSWGGNiqEQR+aYRlnj90auoqPUoaBwCohGqHYMbhYj5l9M4HtF+x6jpLv2tsLBXilGgLMxj+nGBaPyyJLvZOIX9RY1lvvjhM00Mh3GPfQ4EHDKSIhmLC/O3j94YtuSBtto4Hgivp+AaIb5R8Ij1W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qad7bnHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E430BC4AF09;
	Mon, 17 Nov 2025 16:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396150;
	bh=HSABFkLCA81o6LdP7zKa6RIxaNlL+eO/uFqm2ZHAEsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qad7bnHRJl2YReLwJOkk3B1yGsx9/9wSABCEUiktrusYagcg36s7DgOQCW623N0jo
	 7pmbWNbij1wYCC3jxMq8JEHC7xwHkHMf9txr2417GvUQzPol7KOdHPEGrHi/CLhVg7
	 suijUdFf2feaqqfTX+Omm2rwndKqrcTS+q+m3CGWvxi+N3eXOQOKsfMYZNp5pofjzG
	 c6QWmrAugCXASK3jEBIEanETCsjI8zGQ2c5grJ6bMsO+lvlD4tSDKGaqYahxdgjjLL
	 +B8F6Fj+l96Z3mOghBC6IEE/Jv4W7+WisLCu8FDivmbOuCc2jYkOBrr8B3vcf3gpbW
	 U+YWc5ipp45tg==
From: Chuck Lever <cel@kernel.org>
To: shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+099461f8558eb0a1f4f3@syzkaller.appspotmail.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	janak@mpiricsoftware.com
Subject: Re: [PATCH] nfsd: fix memory leak in nfsd_create_serv error paths
Date: Mon, 17 Nov 2025 11:15:46 -0500
Message-ID: <176339614007.12979.15536474028205578081.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117121121.3557585-1-shardul.b@mpiricsoftware.com>
References: <20251117121121.3557585-1-shardul.b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 17 Nov 2025 17:41:21 +0530, Shardul Bankar wrote:
> When nfsd_create_serv() calls percpu_ref_init() to initialize
> nn->nfsd_net_ref, it allocates both a percpu reference counter
> and a percpu_ref_data structure (64 bytes). However, if the
> function fails later due to svc_create_pooled() returning NULL
> or svc_bind() returning an error, these allocations are not
> cleaned up, resulting in a memory leak.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: fix memory leak in nfsd_create_serv error paths
      commit: d0ce35d0a4fe945e72b57be84d6e4e59c28e87d3

--
Chuck Lever


