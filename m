Return-Path: <linux-nfs+bounces-3970-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8FA90C33F
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 07:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F111F24A10
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 05:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286CC1C696;
	Tue, 18 Jun 2024 05:53:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1798017984;
	Tue, 18 Jun 2024 05:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718689987; cv=none; b=RCLZQrfbRNBhuXwqDnxtxuTSsmnz8+PxAtu5/fBCHQv1d4z+dZI0iXyJi9arNxIqXkKS7C2Cp7gyP+lGz52HxYeTdqN2sRNWx0S1zDGLEKSd0Vj/wky7QkwlFBwQGL/Rj5R+lIsrosYdeTEalQmQThMcJXPYGCx+kDRdqijaCqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718689987; c=relaxed/simple;
	bh=sktL/BLxmNsYl1jUrsHkZjhWX7xL7+ulpULuMFjkhXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAMp/1E88+YkrAuQX7XUrsqXjSe2PMOpgq/p5K8RAegFwtLrAR+IQjU0FlY5NsGNhkn7x9pp8aD0kzXLNYDfVvyWv22C2e+6VvpfdDkUWBCX9eVlZAdX34pFzE+gfhq16gPqela9JghSzE2BDGtcGf9ysqxnXdXbmk+GgYeADtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CB33E67373; Tue, 18 Jun 2024 07:52:53 +0200 (CEST)
Date: Tue, 18 Jun 2024 07:52:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Barry Song <21cnbao@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-mm@kvack.org, Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] nfs: fix nfs_swap_rw for large-folio swap
Message-ID: <20240618055253.GA27945@lst.de>
References: <20240614100329.1203579-1-hch@lst.de> <20240614100329.1203579-2-hch@lst.de> <20240614112148.cd1961e84b736060c54bdf26@linux-foundation.org> <CAGsJ_4wnWzoScqO9_NddHcDPbe_GbAiRFVm4w_H+QDmH=e=Rsw@mail.gmail.com> <20240616085436.GA28058@lst.de> <CAGsJ_4ytrnXJbfVi=PpTw34iBDqEoAm3b16oZr2VQpVWLmh5zA@mail.gmail.com> <20240617053201.GA16852@lst.de> <CAGsJ_4xQgY4kn46NO2=OWh2oDUj2F1-oYCRnKG4KCPJFfBT=Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xQgY4kn46NO2=OWh2oDUj2F1-oYCRnKG4KCPJFfBT=Ng@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 17, 2024 at 08:02:47PM +1200, Barry Song wrote:
> I did everything the same as above,
> but always got failure at the last step to swapon:
> /mnt/test # swapon swapfile
> swapon: /mnt/test/swapfile: swapon failed: Invalid argument

You are probably missing

CONFIG_NFS_SWAP=y

in your .config.


