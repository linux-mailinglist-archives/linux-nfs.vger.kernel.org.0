Return-Path: <linux-nfs+bounces-3857-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2D3909CAC
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Jun 2024 10:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F09B211E1
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Jun 2024 08:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2866178CCB;
	Sun, 16 Jun 2024 08:54:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56EE61FF0;
	Sun, 16 Jun 2024 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718528091; cv=none; b=A5ajgdJ1NZoDtVneQmJGyeDLs/+8j5S/iQUnW7f0blv3D0rJUbOpNxiJwQeCpMLJmCGj6CKUqetEahTD8WFjCIbnavwrbEeCfqIoI0Nu4A1/KcEQIqYOihCkZfVkQFXie62evQPa+eF4RPyQBXMvbkaZ4f8Fj/bHYRuDfuUtIrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718528091; c=relaxed/simple;
	bh=ftFB80sqxyJ1Z+pS9SPnxv/3vGK8AqMjgp+JDNiifEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUQoSXkKfagMIq0DTLDXahWUPhmkCbPJkgoXvW5AKKErgxPP1mDdO+nTt8ZAJCidCig4Hpl7vactpNVGABsybdNq8xDNSWtKyojPKWJKe4Vjb2/quHP03Vrx5/tVQBFXP4EV33s6IS/8oN1HOz1/fHf723QUpZDFh4hcQmthfWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 42E6168AFE; Sun, 16 Jun 2024 10:54:37 +0200 (CEST)
Date: Sun, 16 Jun 2024 10:54:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-mm@kvack.org, Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] nfs: fix nfs_swap_rw for large-folio swap
Message-ID: <20240616085436.GA28058@lst.de>
References: <20240614100329.1203579-1-hch@lst.de> <20240614100329.1203579-2-hch@lst.de> <20240614112148.cd1961e84b736060c54bdf26@linux-foundation.org> <CAGsJ_4wnWzoScqO9_NddHcDPbe_GbAiRFVm4w_H+QDmH=e=Rsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4wnWzoScqO9_NddHcDPbe_GbAiRFVm4w_H+QDmH=e=Rsw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jun 16, 2024 at 12:16:10PM +1200, Barry Song wrote:
> As I understand it, this isn't happening because we don't support
> mTHP swapping out to a swapfile, whether it's on NFS or any
> other filesystem.

It does happen.  The reason why I sent this patch is becaue I observed
the BUG_ON trigger on a trivial swap generation workload (usemem.c from
xfstests).


