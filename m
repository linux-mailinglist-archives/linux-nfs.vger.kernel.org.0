Return-Path: <linux-nfs+bounces-3972-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A6C90C357
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 08:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C331F2396D
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 06:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7007D199B0;
	Tue, 18 Jun 2024 06:13:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6822CAB;
	Tue, 18 Jun 2024 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691228; cv=none; b=L8m5RPncDVKajL+uXpp5orxt+vJjUVLMIO32KYqMyTPXBShAoar8lll2Vb+pLjMEJPD5L2uMivEb3HvBB8pYB1BsJgzAxMK1AvTVG7cKGMPdBb4R1HhP/lgkq4fSKLecbBfClOlR9EtMWDr1I0U0N/0Eq34Jc3WoEeS4juqbACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691228; c=relaxed/simple;
	bh=FGZejL7sL6LL+VMt6fkBwRt7BuMgFbaT8nQqiOo0j58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cafPgeQmNkF/c75C87qslMef8xO409b/Vvb1YIrbpQyj+rhlxCPYHmd6WRWVvvSgWfIe5Angz5ngoDClwBdCO+gVJMJ06csQQ9mM4/SAWoNxh7JFi9ppSN4oDoRGqCmKNNfjrgmppuG+bo5zN7/utGV84QilQL3pEV0wFSe2jPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1C10267373; Tue, 18 Jun 2024 08:13:41 +0200 (CEST)
Date: Tue, 18 Jun 2024 08:13:40 +0200
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
Message-ID: <20240618061340.GA28200@lst.de>
References: <20240614100329.1203579-1-hch@lst.de> <20240614100329.1203579-2-hch@lst.de> <20240614112148.cd1961e84b736060c54bdf26@linux-foundation.org> <CAGsJ_4wnWzoScqO9_NddHcDPbe_GbAiRFVm4w_H+QDmH=e=Rsw@mail.gmail.com> <20240616085436.GA28058@lst.de> <CAGsJ_4ytrnXJbfVi=PpTw34iBDqEoAm3b16oZr2VQpVWLmh5zA@mail.gmail.com> <20240617053201.GA16852@lst.de> <CAGsJ_4xQgY4kn46NO2=OWh2oDUj2F1-oYCRnKG4KCPJFfBT=Ng@mail.gmail.com> <20240618055253.GA27945@lst.de> <CAGsJ_4xMzU2N=c-vtLv+vJwSJFcADjdaUONc=8yDTm52QabOXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xMzU2N=c-vtLv+vJwSJFcADjdaUONc=8yDTm52QabOXw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 18, 2024 at 06:05:33PM +1200, Barry Song wrote:
> Yes, that was exactly what I missed. I then figured it out, reproduced
> the issue,
> and discovered that the root cause was unrelated to large folios. It
> was actually
> due to a batched bio plugging optimization from 2022. You can find the new patch
> here:
> 
> https://lore.kernel.org/linux-mm/20240617220135.43563-1-21cnbao@gmail.com/

I don't really see any point in keeping the VM_BUG_ON.  The underlying
direct I/O code doesn't really care about the size at all.


