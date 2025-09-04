Return-Path: <linux-nfs+bounces-14034-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E412B43F82
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 16:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CAC1CC307D
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 14:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73CB30102F;
	Thu,  4 Sep 2025 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8q2fLE/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E41EEA54
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996965; cv=none; b=qNPc/O3XxXZAOYDop4Vm/rb0dM3P7CSkYKOu1zOTqqNr5MGjAsxgfRB18l2rz36KNWDqilmkGr5yT4MXbOL9lPYneIVi7pIp8ZWpvlrIhYnQKWBRzKj3bj0Kmwzw3wcyBFfSG8kyFg/lXbKBc86+MfFtkmklVs7NiChhn/RD8J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996965; c=relaxed/simple;
	bh=8GC804Q5+f604i6VY4XMwbDtvtysGG+ibtm8moKtDCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qU9mI6mkb34AehyxJU3GPYkTJitZmeIt8EES/ksqJpKS7r4pQbLdP8PMeeFteGK1XcZY1W8IA6Z/rW39f8ow5bd0jHdFAYgOEl63Y8/fNJXScQc54xS8q/FDKtPhfPX9MjCGEhNSeEauKaDhDlvQmunOsffinmDrLJYX2VcpTSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8q2fLE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D327CC4CEF0;
	Thu,  4 Sep 2025 14:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996965;
	bh=8GC804Q5+f604i6VY4XMwbDtvtysGG+ibtm8moKtDCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r8q2fLE//trPGu+bY5g0eCxQw+GodsUkc/owUhrFFVEw4uYGZzv90BktnmldCWhMw
	 0+d05cZOmKjuHONCXtvi4zxs+H6KrBpDXjQBXe/tbWP5wvwsUrwekk8p4zaSRA5/pv
	 GoGD9tPB3c42w6LKnUNkLltYeBlQY1+e6ptsPh7lIyvDpuvmJJDTfZmNIombsdg1dX
	 DXmLXALDTorUarfOZ2Uf5/1o9CuAhtlHfmTmIpKXw54sLKgBTX0fD6I1wlweqAZrDx
	 M91GxKB6EYHJWCLA22rq7ZnzTjODNCxcYos1+4hddX7nQnTijzGHUAv7dgW8hGPOcb
	 vJNFqAztiBaxA==
Date: Thu, 4 Sep 2025 10:42:43 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH 1/2] NFSD: fix misaligned DIO READ to not use a
 start_extra_page, exposes rpcrdma bug?
Message-ID: <aLmlY-xdYh73UaAf@kernel.org>
References: <aLClcl08x4JJ1UJu@kernel.org>
 <20250830173852.26953-1-snitzer@kernel.org>
 <20250830173852.26953-2-snitzer@kernel.org>
 <2559f795-bdc9-4d39-aa03-e6a6d89e9f84@oracle.com>
 <92908105-9261-42f9-a0fd-ebfaf3e2f564@oracle.com>
 <aLdcbnELMGHB-B_E@kernel.org>
 <18b20826-3c9f-4763-b0ac-c7f1dc2be4d4@oracle.com>
 <aLdhL7xFxR-r7H_m@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLdhL7xFxR-r7H_m@kernel.org>

On Tue, Sep 02, 2025 at 05:27:11PM -0400, Mike Snitzer wrote:
> On Tue, Sep 02, 2025 at 05:16:10PM -0400, Chuck Lever wrote:
> > 
> > I am testing with a physically separate client and server, so I believe
> > that LOCALIO is not in play. I do see WRITEs. And other workloads (in
> > particular "fsx -Z <fname>") show READ traffic and I'm getting the
> > new trace point to fire quite a bit, and it is showing misaligned
> > READ requests. So it has something to do with dt.
> 
> OK, yeah I figured you weren't doing loopback mount, only thing that
> came to mind for you not seeing READ like expected.  I haven't had any
> problems with dt not driving READs to NFSD...
> 
> You'll certainly need to see READs in order for NFSD's new misaligned
> DIO READ handling to get tested.

I was doing some additional testing of the v9 changes last night and
realized why you weren't seeing any READs come through to NFSD:
"flags=direct" must be added to the dt commandline. Otherwise it'll
use buffered IO at the client and the READ will be serviced by the
client's page cache.

But like I said in another reply: when I just use v3 and RDMA (without
the intermediary of flexfiles at the client) I'm not able to see the
data mismatch with dt...

So while its unlikely: does adding "flags=direct" cause dt to fail
when NFSD handles the misaligned DIO READ?

Mike

