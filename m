Return-Path: <linux-nfs+bounces-18046-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A974D38838
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA35A3053801
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741EC2D7810;
	Fri, 16 Jan 2026 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax418339"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4038D2C11CF;
	Fri, 16 Jan 2026 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598195; cv=none; b=LIZMFIdqszmX1Y70syRbbfo0vBZp/vFR/HioS5p1Ndn6Hs0219Da5ad61peEvhwOCrDm8te5yFyEudKeKngt3z8FY0ZDFDMQALTydKzMt4PaswYKWj+llEZ31IFfhy8dmCX86rW75hZoftIrhn2xywICGf9SCl18IzILAP+aUNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598195; c=relaxed/simple;
	bh=CkXvgq5Lhm8j81ONmd0WsKNbmcK3wYs5RPXWhElnX5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmIMuF0Wlbxkc2FnfwAUroaQ61osWSsGTNi6QT+atpctBFbpQyQFRwYTuXxeDJtdznaM4WJheHWJrH2mgpJ1EbPZR49PhcT+yZs5Ec7YTMDNPN2EnKbkVI6o2jEyAt0QGIlN+GPo4gP1qfPQmZAde696XTkyVa+N4e/HXynDQCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax418339; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC9AC116C6;
	Fri, 16 Jan 2026 21:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768598194;
	bh=CkXvgq5Lhm8j81ONmd0WsKNbmcK3wYs5RPXWhElnX5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ax418339ihxNc525c61nG9G5TZbs7Najd1WbDBZVonSV40Rk3o36Zbu0kUNhDpqi2
	 YdvPK6BnAkBZevx8Fi2z26Pz7myT5WMHHyBS3iJvmkk+IyCofgEy8U/WFa0myGiUy+
	 UB9TdWHOVz3acW8GJll4xBfrmcIbCwklt5TsNtvgRQ4tU7u/ZsMNSpO0AYi2hzcYYt
	 FC8hFZW8yrjocxn7gs0v4JsL5fK2hZwLmXDcOLIIgg/DugZgLPiI+6Lu7Ycs+a1vip
	 LBKrLQ/e71GSE0hRsnknBxFX3rS3pCN2pwoTQpSlgPMD9X0y5GNmBMR98GCbsCLqk7
	 AsTU8ECeBGpmQ==
Date: Fri, 16 Jan 2026 23:16:31 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chuck Lever <cel@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 3/4] RDMA/core: add MR support for bvec-based RDMA
 operations
Message-ID: <20260116211631.GI14359@unreal>
References: <20260114143948.3946615-1-cel@kernel.org>
 <20260114143948.3946615-4-cel@kernel.org>
 <20260116114236.GG14359@unreal>
 <20260116145027.GA16842@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116145027.GA16842@lst.de>

On Fri, Jan 16, 2026 at 03:50:27PM +0100, Christoph Hellwig wrote:
> On Fri, Jan 16, 2026 at 01:42:36PM +0200, Leon Romanovsky wrote:
> > On Wed, Jan 14, 2026 at 09:39:47AM -0500, Chuck Lever wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > > 
> > > The bvec-based RDMA API currently returns -EOPNOTSUPP when Memory
> > > Region registration is required. This prevents iWARP devices from
> > > using the bvec path, since iWARP requires MR registration for RDMA
> > > READ operations. The force_mr debug parameter is also unusable with
> > > bvec input.
> > 
> > I am not very familiar with iWARP. Do you know why we need a special
> > case here? Is there a reason we cannot avoid using scatterlists for
> > iWARP as well, now or in the future?
> 
> iWarp must use MRs for the destination of RDMA READ operations, but the
> core RW code can also optionally use it for other things.  So to support
> that natively here we'd need a bvec-based version of ib_map_mr_sg.  Which
> would be really nice to have for the storage host drivers anyway, but
> until then the scatterlist emulation here can do.  And implementing it
> might take a while, as ib_map_mr_sg is a very thin wrapper around a call
> into the low-level driver.

It is in my roadmap, but as you said, it will take time :(.

Thanks

