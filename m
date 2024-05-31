Return-Path: <linux-nfs+bounces-3501-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C208D5A60
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 08:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518E4283BC9
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 06:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC0478B4E;
	Fri, 31 May 2024 06:14:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06633CA;
	Fri, 31 May 2024 06:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717136088; cv=none; b=MujxNVBluxk1lcHLF0DAtY9bqRP9QuTQXNq4xKJ6ahiKkAUqm0iM093a9H3yJl7s2dkzdoHjhN0pAdipVSQc0I3I7bdenkTRWXgKy+y17dnwfD9K/HWmzI8es+R3LmtMrEEvJ/FI01sUjMJwlAHWjFWsKkgohl0AYVmxvCdMyYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717136088; c=relaxed/simple;
	bh=9sT3MQVbINa2QkpjT76cLIiEX5eklfCgeONx5HJU7Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKf0U3+Baffc9m0f6nEHRadXWnBm59XsqX9PXYQ97TjNZtyx4/hLpY76AGJFVOyGDzVue2uBpck83qn0uR4v+2IqY5Y8Rl/YEwOwvdGmOtIF5UTTfqtYXrW5JUmKE4oDU7jHS1FMUZlN0dRtM+z9bExCN8X1/Z8jM31Sdh7JiNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D3D768BFE; Fri, 31 May 2024 08:14:43 +0200 (CEST)
Date: Fri, 31 May 2024 08:14:43 +0200
From: "hch@lst.de" <hch@lst.de>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "hch@lst.de" <hch@lst.de>, "anna@kernel.org" <anna@kernel.org>,
	"willy@infradead.org" <willy@infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: support large folios for NFS
Message-ID: <20240531061443.GA18075@lst.de>
References: <20240527163616.1135968-1-hch@lst.de> <777517bda109f0e4a37fdd8a2d4d03479dfbceaf.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777517bda109f0e4a37fdd8a2d4d03479dfbceaf.camel@hammerspace.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 29, 2024 at 09:59:44PM +0000, Trond Myklebust wrote:
> Which tree did you intend to merge this through? Willy's or Anna and
> mine? I'm OK either way. I just want to make sure we're on the same
> page.

I'm perfectly fine either way too.  If willy wants to get any other
work for generic_perform_write in as per his RFC patches the pagecache
tree might be a better place, if not maybe the nfs tree.


