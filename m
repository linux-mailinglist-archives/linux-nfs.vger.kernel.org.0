Return-Path: <linux-nfs+bounces-17983-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D98D30A00
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 12:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58F0330D9164
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 11:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B909936C0A3;
	Fri, 16 Jan 2026 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJN+KFgT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9583A3612DE;
	Fri, 16 Jan 2026 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563760; cv=none; b=ENhgk4qEyydVAuEl8oHRxFo18r0Xc2/0d4KuY/m+YvBAp89FjHXi3U3M0CXb9lrMDJ7bfuHADkbkvafXBZJZ94LirWT/XrQM3q+FWMftMIhy+p+ZqTX+3Z1Qcj1qOebTIndiILnCIOb+aOnrnHoToBRxXeGxEe/Bo6vm+efgoWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563760; c=relaxed/simple;
	bh=nWnSMCO2VRmWqtTDWj6K/12BvDFqP828BJ3f8gA3pBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ph9K48VXd3wS9SKtb1EXE8+1rnB/1gRU7NKIdxCheebS1Trc/sXoCvWowLQVDTEL+hj+k98dMGJv9IUED23MJ4s5pl0zVnn7q+qKlHnPUatHyJy2oKs6h5T8J1nniolg98hydoE2XJlVQRCpQyCk7j3qdPIFFqBxhmFvHyWSoZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJN+KFgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E35C19421;
	Fri, 16 Jan 2026 11:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768563760;
	bh=nWnSMCO2VRmWqtTDWj6K/12BvDFqP828BJ3f8gA3pBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJN+KFgTAl3uO06daYKTS6Yl/1DBPd43bABAXVopveQccAJMuxbSOj2iiUYOCFmxD
	 lkSJrkNUGGp697UTKZ0goz5C6yi+SDMUo0b21vXNZ+QAGYDtQPmb5sYNnkyZUcIERG
	 HtDutbrXvlFsfblpt8XEwivEb/x04s6JuaVlqWU2AxSzrVhn2uPzVVE2XX7Mqiv6y6
	 GQD9zwf1wI12f+7tSuwzMJNzgWDqwH/leLbxPSTYhGbFwvs28lbtyMOqpx3cMGLxv8
	 TKgkJzjwtVvSukVsH46HVXhvLzR+mGJEJDM2yYP/WUVocui5aFHRJ0htqL1K3b/RTv
	 OoKmdJGaFnrmQ==
Date: Fri, 16 Jan 2026 13:42:36 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 3/4] RDMA/core: add MR support for bvec-based RDMA
 operations
Message-ID: <20260116114236.GG14359@unreal>
References: <20260114143948.3946615-1-cel@kernel.org>
 <20260114143948.3946615-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114143948.3946615-4-cel@kernel.org>

On Wed, Jan 14, 2026 at 09:39:47AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The bvec-based RDMA API currently returns -EOPNOTSUPP when Memory
> Region registration is required. This prevents iWARP devices from
> using the bvec path, since iWARP requires MR registration for RDMA
> READ operations. The force_mr debug parameter is also unusable with
> bvec input.

I am not very familiar with iWARP. Do you know why we need a special
case here? Is there a reason we cannot avoid using scatterlists for
iWARP as well, now or in the future?

Thanks

