Return-Path: <linux-nfs+bounces-12673-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D33AE4582
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 15:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F24A1707DB
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 13:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD32252912;
	Mon, 23 Jun 2025 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhcjVy3U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B5252910;
	Mon, 23 Jun 2025 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686611; cv=none; b=MXl9c59Xt02JP7+zV5C7zu+gPlhk2sYICa/eJBHK7xvATiu7tu7Dt9KxaIXlJ3CZYlEnr3/Icujp1sn3painUwZnCBKihz3KJC/RApxz82nXRR9fZZElCnFnYX+j8D7ByLh0tpllOeueVYCeNslH5ufkB2Bt1YZ02pgmc5sWZFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686611; c=relaxed/simple;
	bh=wOX12vfAsyg5x5J9yrKvyS2XrSu5UlromoWB1H8zCw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liLGPipOhp6X0Fr8he/SuH8tTOnXb07gsMOn/uV1qFc0dDKNmhnHxSePdGYIC+tgiXm9gkSmtXZVoPlL6DSJy++Yc0+EWUILZCc4NUOvV3qNEB7Yn7pnsU/fqPppi2GW2jTqzQDQQLLgPeJEZfN5zUPC5Y4JX+ASL4UNJxwoPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhcjVy3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5401FC4CEEA;
	Mon, 23 Jun 2025 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750686609;
	bh=wOX12vfAsyg5x5J9yrKvyS2XrSu5UlromoWB1H8zCw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EhcjVy3UzoTz85oSXtrE8rYR/2ZcQjBfEXc78FoQkTalgZ8irsX0jTxHKffxx60y2
	 uBgMVpRp7Mzjt7A7hN1Jakh3pCtIxf9Rsx/UVdTRJl+HKJ+r5wVWBlnwoSNVLVTPQh
	 To9NTYT9Mn3NHNDKSLIZnv+fyzfnNntkHcFQn92SQNrnd7iQwPlWbmvzPC69rzNbXt
	 t+aoIsWK2reFVP953fT2ofSn+nprkQ3jDXoPkLnvLXCoR5iB/6bvoeg9hHzkIJwIsc
	 CQosSekcocs5wjEJGFhLpUcxRRWldtGwzIKTBXnJfQQ1649qyQuAj4M65lT5JCP6K4
	 Ig3Ml52aOMdaQ==
From: Chuck Lever <cel@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH v4 0/2] nfsd: Implement large extent array support in pNFS
Date: Mon, 23 Jun 2025 09:50:04 -0400
Message-ID: <175068659324.1133799.8695446940765961429.b4-ty@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621165409.147744-1-sergeybashirov@gmail.com>
References: <20250621165409.147744-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sat, 21 Jun 2025 19:52:43 +0300, Sergey Bashirov wrote:
> This series is the result of splitting the patch v3. Removing dprintk is
> now done in a separate cleanup commit. No additional changes.
> 
> Prerequisite patch: [v3] nfsd: Use correct error code when decoding extents
> 
> 

Applied to nfsd-testing, thanks!

[1/2] nfsd: Drop dprintk in blocklayout xdr functions
      commit: 46e337cf767d14baf8738393adb9816f7d7b7db0
[2/2] nfsd: Implement large extent array support in pNFS
      commit: 49ccb2bd38c6cb6d713faee9bb958a3abcf76e28

--
Chuck Lever


