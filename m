Return-Path: <linux-nfs+bounces-11337-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55DAA9FA85
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 22:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 017C77AA41D
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 20:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A5F1F91C7;
	Mon, 28 Apr 2025 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFhLGyzU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC71DF735;
	Mon, 28 Apr 2025 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871904; cv=none; b=M/iZVH7Egbu+DGwkaGuWZmwv1ZLkcYI654Xqt+c2n+04L+ftExh6R09ubj64ZyIP6o3iWp3bfxaJ0rqUPCjPB6vBk8Es5wyinzByuvzL3JbzeBxPhAwrMqpYxE01CyP821wjGcnybrGGtf3FDWtLYJBaIw5+RSf5hUOdLB/615E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871904; c=relaxed/simple;
	bh=FZVcFjh1VAcUB/0d4RTfRpRlkWZkG/HiBaW+DMlaMWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dj/LMpjzmdT/iP2+qxZ0IYAXtQMJMgRzH2MF247U00TwQxDYRghSpftw2akw0yXr3nYr0b/Pco3rgZIqE14yG2yek/hMHdz6Yi8zcH5UTJRi11jy02z0SrGcux+VqlXhC9dkW0mke6yASQJfEf2WD3ixDVfCu4doAmEFGutC8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFhLGyzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B5EC4CEE4;
	Mon, 28 Apr 2025 20:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745871904;
	bh=FZVcFjh1VAcUB/0d4RTfRpRlkWZkG/HiBaW+DMlaMWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tFhLGyzURGLhE5+B5uMPCcJghpiWL+pvwym0o0WIw4jBdxBI2jaU+Q4VkrcVmGSpk
	 9tl2WUCqEzqsqaAS/UeCgtfWrbJU57rHHjd2v3QQx9nLAVvO+N9Uad7oQeWBTjMsjc
	 HL2qr7idQlk7dZYhb66+ho3grg6Nm5Fs0ldsVffF/ml+UfbgtDtzLVNxYblocy6sl2
	 mGO94AthaadxJVd+JSODtbOCwcY370eoZlOpuWFeKNaMzWxnBMftJhYSMyElKgg+Lw
	 UM0Rai2qaQ1sY7CKi+8ecp+YWPmFiZY2d7mb26i3lyr+Ccg1vplyw9vmAf6uKIlqwq
	 zqOdtebLRfEIw==
From: cel@kernel.org
To: linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH] nfsd: use SHA-256 library API instead of crypto_shash API
Date: Mon, 28 Apr 2025 16:24:58 -0400
Message-ID: <174587186737.4987.2432564499412550491.b4-ty@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428193658.861896-1-ebiggers@kernel.org>
References: <20250428193658.861896-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 28 Apr 2025 12:36:58 -0700, Eric Biggers wrote:
> This user of SHA-256 does not support any other algorithm, so the
> crypto_shash abstraction provides no value.  Just use the SHA-256
> library API instead, which is much simpler and easier to use.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] nfsd: use SHA-256 library API instead of crypto_shash API
      commit: 8b12406ec23b18ac4e3af45bfdd47515e45c6cdd

--
Chuck Lever


