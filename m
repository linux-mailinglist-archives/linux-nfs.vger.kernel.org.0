Return-Path: <linux-nfs+bounces-17027-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 739DFCB4D3D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Dec 2025 06:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0297E3007601
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Dec 2025 05:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918997E0E4;
	Thu, 11 Dec 2025 05:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvE3cubw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB55E3B8D67
	for <linux-nfs@vger.kernel.org>; Thu, 11 Dec 2025 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765432678; cv=none; b=WxYg/MiEyr+jaJCDAAWdDcD2JqsBDKRyjd4TuKiW07eO+3qMX9V6L+3WjF/bDKPSzbm7wdGyNrE1MyTGQFzyRJBrtqGJNIEChaxf2XAf7a32BI+o/yWqzQXhNOTjWUiRMs1YvILrmPAGndZbFLqIilr6cAwERgCw7c5Vq82op/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765432678; c=relaxed/simple;
	bh=MAzWEpMIG90GQLhuQtIZfCyigjeg6tn6AOfmQm1HM5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAk9C7J/NEUgFW2cGlLFXONf8mXAztz50yZTjqm5WUw7xWUvEJ95LV1DNOMmKqi6rvLoySNXYBOl/8SWSGV2iQFJCIH1Cet4EMILXjNIUqWBB1jgPuWdiqGDEfT3J44shauk/k9KYybL+9j3bVVq54A46iac2LjytgBBHKYzFsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvE3cubw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42e33956e76so196692f8f.3
        for <linux-nfs@vger.kernel.org>; Wed, 10 Dec 2025 21:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765432675; x=1766037475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JmoJ7kZC9bzxieL8Zpv3A7KMAU2gf8Ue+eURcwH1w+8=;
        b=mvE3cubw4NAT7W2jorMmYkdN8Wu4+cNuEB4vDaKinTRyE13KEZXV//UtbKTfzvnGc5
         jYI0UsVJq3S7cs261if6OtFZ9Q38ReI9iLxPRm+IOQZ58zFZ40BJCISI6MHtwIrVThku
         baj+sF3d0EcTnApNi2kIyZBTdniMhOfBY/hnQWr9YM4RuIMVcHOYrp6jZFj77u1xj1nU
         jmbN09OXqU8MH2/EewrMjBfb7TJwlbYldUP+upcr8BDNVDjzswYw+PcTjlG8jz2ecHlv
         Tvu+uWUJhSTxtrlucQq0BBaY4hQAJJOdVMFeYsSmD0OW95jYxUdh2wNevtMIcSzfloIV
         FfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765432675; x=1766037475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmoJ7kZC9bzxieL8Zpv3A7KMAU2gf8Ue+eURcwH1w+8=;
        b=SSUEpSSJucqJHsx8N12K1vplZT7hyMbhB6gEYZEeh8B9q9BZQF324slX6v1yavIt0W
         GP8NDbouBK2pW8eq1ZZaFd09AjYpFeOv8Yd+IsBjrzx4ihsS/2NNIvpdzJnC3nE+LQsR
         kfSAXnp6raa1YktZ20JiovZqnugobPr7GBfIfJYq9xHrBLou2K+b+xXQLi4+qolQm3xm
         NcVUFekjikCrTLKbyv0Oj2j9e0l46/QnANecV0DKVUC9ARqMLA2km50XUxhwDdOSsS1G
         v8AockG2VzNY2I6/LVugz5rLrZO8w9RKG/1je56wp9shon0CJcwn/9FYxocWkTQu+GoG
         zsDg==
X-Forwarded-Encrypted: i=1; AJvYcCV7xD0KB/FDun2ApbS8RUXU/bjBOQZWj9oMjUaRC8AMP+tFH3XM3N//GzN1dtmITWsOIykrdNsp+EI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxo4SBYuiuZQeCd9GCURmq55QMDxHsajk2TyaENUUdUKMi6Ggo
	9CTx9wOti+hWQ8uwuUXI5YSZZ3zNruo5iZBeuHim1SF13Ozj+wjL4gRI
X-Gm-Gg: AY/fxX5LQ7y8MjtCRPtROZXVoOV0NyTzRLL1A3SPFMRgQwh+48U0qs86vy7cXdp9QbJ
	Wpo73HN/3Gba7KycYFxTzsPSkmhAEeUSEbASWqjXUxNp3Ay92rfY8O71r3MS8GNTThEeZ5pdbe/
	VNqSqNl3i+WS4DpDxuqxdGLVoHULzp3sV4WuOPxUuWmDgzorLLtSy426p8dI1cz0DkHhF/C6KRb
	zFX7cZK8bMhp9KTlMgORVCKrbs9+bUhJWTlHI2SgUnyOYvjkx6XHZOxTPtQt2k3TRV5qNvzPT1m
	1QWq1SpJLDyBf1bvH6XuSVTU0TyzZUmBD2DpDtVMbz2wlvn7Jy/fXZiyWuscjp5sMdUc7VeZ5tK
	VE4wNr/SpafB7IIZ+GywMxMTp5BtK8ywxPx+URAWUPu5D+gDvSPeMFVwc7++tcqHj8KLti5wmqQ
	jxp8sYc+JdGQZrGGHcbNECKM9aQ6U8cL+PvxUprt6IzefpwylcvW565CD7r6Tw
X-Google-Smtp-Source: AGHT+IHU4mPaz9Kg/96Gi+f+fOap/NTAuoznrFwHPxJrWIbhdd1Yn5ByMa6IXnXwG4qx+KLw0HpxEQ==
X-Received: by 2002:a05:6000:240a:b0:429:c450:8fad with SMTP id ffacd0b85a97d-42fa3b1aad4mr5012408f8f.53.1765432674959;
        Wed, 10 Dec 2025 21:57:54 -0800 (PST)
Received: from raspberrypi (p200300f97f21d40007e88c368107f7e5.dip0.t-ipconnect.de. [2003:f9:7f21:d400:7e8:8c36:8107:f7e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b9b26fsm3501186f8f.40.2025.12.10.21.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 21:57:54 -0800 (PST)
Date: Thu, 11 Dec 2025 06:57:54 +0100
From: Pycode <pycode42@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Removed unused variable
Message-ID: <aTpdYqy0Q5gGfr3p@raspberrypi>
References: <aTnfSQJ4QsfwTSf0@raspberrypi>
 <ca38feb0347cc38fd2fe3753628f7644a91aaa7a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca38feb0347cc38fd2fe3753628f7644a91aaa7a.camel@kernel.org>

On Thu, Dec 11, 2025 at 08:10:25AM +0900, Jeff Layton wrote:
> A more descriptive title is preferred: "Remove unused variable from
> nfs4_ff_alloc_deviceid_node()"
> 

Thanks for the advices!

> On Wed, 2025-12-10 at 21:59 +0100, Pycode wrote:
> > Signed-off-by: Pycode <pycode42@gmail.com>
> > 
> > Removed the unused variable ret in
> > fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > 
> > (Disclaimer this is my first patch, be sorry if I have done anything
> > wrong!)
> > ---
> >  fs/nfs/flexfilelayout/flexfilelayoutdev.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > index c55ea8fa3bfa..9cd04e85d52f 100644
> > --- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > +++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > @@ -53,7 +53,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
> >  	u32 mp_count;
> >  	u32 version_count;
> >  	__be32 *p;
> > -	int i, ret = -ENOMEM;
> > +	int i = -ENOMEM;
> >  
> 
> No need to initialize this.
> 
> >  	/* set up xdr stream */
> >  	scratch = folio_alloc(gfp_flags, 0);
> > @@ -88,7 +88,6 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
> >  	if (list_empty(&dsaddrs)) {
> >  		dprintk("%s: no suitable DS addresses found\n",
> >  			__func__);
> > -		ret = -ENOMEDIUM;
> >  		goto out_err_drain_dsaddrs;
> >  	}
> >  
> > @@ -134,7 +133,6 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
> >  			dprintk("%s: [%d] unsupported ds version %d-%d\n", __func__,
> >  				i, ds_versions[i].version,
> >  				ds_versions[i].minor_version);
> > -			ret = -EPROTONOSUPPORT;
> >  			goto out_err_drain_dsaddrs;
> >  		}
> >  
> 
> What about the dprintk() at the bottom of this function? Does this
> actually build?

There is no dprintk() at the bottom that used the variable.

> 
> -- 
> Jeff Layton <jlayton@kernel.org>

