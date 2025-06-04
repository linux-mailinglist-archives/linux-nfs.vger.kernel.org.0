Return-Path: <linux-nfs+bounces-12096-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA61ACE25F
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 18:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCF0176264
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 16:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68E91DED7C;
	Wed,  4 Jun 2025 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zvecr3db"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44CF1DE3DB;
	Wed,  4 Jun 2025 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749055376; cv=none; b=CWZUuh0triAfYjkyPu+9wayRwJydEYwF8XurdVNgt31gNLkyni6iBrndHXUPsunph+BTu77NhBjQtbHYW+5GGJUG+Xmd6XwWtyE3enYhXhGQfkKTbYQkdiYGafZAjJ4lUokQnCXz7IoxlL/oxa/C9xtV5L7JRpWSEFEIWYrJkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749055376; c=relaxed/simple;
	bh=mejzYDp6yemYLbRK0vx0qOCqvSMgpHoIVhfXx3tCZUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ht/xCx8hzb7WnrfsVtCMdl7WeJJq5hZQyH+pq50yPuE9owgHz6hvgWmYlECbtJJKkOnGIbCitUoUnFMR/TemAXOMjXj1v1vJ5wjTpZHd8uH9JiS/p4ib0OtVyhpKih+8f8ezn2E5WLw9ztx2MoQWy24LMl2BSg7OCknGtqztb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zvecr3db; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA13AC4CEE4;
	Wed,  4 Jun 2025 16:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749055376;
	bh=mejzYDp6yemYLbRK0vx0qOCqvSMgpHoIVhfXx3tCZUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zvecr3dbW7l52g2pQsEqnBlHhSWcmWBWTimJngL4URASf9HWTQ4/XCY4ItBQaSW0t
	 /+fwWsXy5X5kjyjwauFXC4+PBqK5X3VC0L/T9ymAe78Im8IXr3kAYGskzMXYAY9Z7d
	 sm9XeGGAm4+eEuZn8fi0youHp1cBgbrUhapoKEMKBHpxg3qw+7/T9yAEve3KwOdxCK
	 tOiRqGfjs9CMa1tO9kGUtRmEVHknRVV+GGJbH/taJFO8qT7GpI5BStnaJ7I+AsvxsF
	 cqLK7T2s0SaMPe2ePdcOUVmr0rUW+mjVrQk6lzSfRmcflA9LtBTRydi2VU6mfBe/OW
	 cHqd0onKFfpwA==
Date: Wed, 4 Jun 2025 19:42:52 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] nfs: create a kernel keyring
Message-ID: <aEB3jDb3EK2CWqNi@kernel.org>
References: <20250515115107.33052-1-hch@lst.de>
 <20250515115107.33052-3-hch@lst.de>
 <c2044daa-c68e-43bf-8c28-6ce5f5a5c129@grimberg.me>
 <aCdv56ZcYEINRR0N@kernel.org>
 <692256f1-9179-4c19-ba17-39422c9bad69@grimberg.me>
 <20250602152525.GA27651@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602152525.GA27651@lst.de>

On Mon, Jun 02, 2025 at 05:25:25PM +0200, Christoph Hellwig wrote:
> On Sat, May 17, 2025 at 12:45:02PM +0300, Sagi Grimberg wrote:
> >
> >
> > On 16/05/2025 20:03, Jarkko Sakkinen wrote:
> >> On Fri, May 16, 2025 at 02:47:18PM +0300, Sagi Grimberg wrote:
> >>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> >> Based on?
> >
> > Based on the same that nvme is doing. The only reason I see to have it
> > is to avoid having the user explicitly set perms on the key for tlshd to be
> > able to load it. nvme creates its own keyring that possessors can use, so 
> > makes
> > sense that nfs has this keyring as well.
> 
> Jarkoo, can you please state your objections clearly?  You've only
> asked this one liner question in response to Sagi's question but not
> even commented the original patch.

OK, I put this in simple terms, so perhaps I learn something from
nvme and nfs code:

1. The code change itself, if this keyring is needed, it looks
   reasonable.
2. However, I don't see any callers within the scope of patch set
   for this keyring.

I could quite quickly grab the idea how NVME uses nvme_keyring in TLS
handshake code from drivers/nvme/target/{configfs.c,tcp.c}. I guess
similar idea will be used in nfs code but I don't see any use for it
in the patch set.

Thus, it is hard to grasp the idea of having this patch applied without
any supplemental patch set.

BR, Jarkko

