Return-Path: <linux-nfs+bounces-1440-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0FF83CEEF
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 22:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83201F226A6
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 21:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27F713A256;
	Thu, 25 Jan 2024 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="V+Prrtwy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF93C131E4F
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219782; cv=none; b=T6eE9gyZhoxthQdzTFPaFFF7PJTP+dADoF/PX8wBHaW8AVztdzECJL5QaFD7tGi1V9G6ae0VE7MZID6pDhWaOC50FcykPTFBX9pJTw18L6zrGKHY6DpzwSvZvTrPGK6x8ZVcIIWXmjejDoOMi9YLTLGmchRXNS3eeOw4p+NGGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219782; c=relaxed/simple;
	bh=qbLdoK7pNgT6MXGasUpNn2hS4oYJdBG1q/u3YpsP3sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alKBy+XJoeHt/Z75KMs7FASabk63OUNr4b0OhkOYVagkrbmQDHN8aBxfT37onc7HmeembFg3+nxUThKR7q4h2nowfdgx2pgmFOrFlZ/Rf+czVE0GAZmvYhONriCdC1lgu/Wp3WKJvctYsjXoaWljn+kELqGEI1Jy9jG0Sx7xB6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=V+Prrtwy; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-602c8a0cdb1so1035337b3.3
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 13:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706219780; x=1706824580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8G30FTf9bJfEnk9upURjOnEixj7hMKJNTXGQfnA8y5o=;
        b=V+PrrtwyIPL3cu9LvMyJzHTPVLskoCCZbiB92x3xE2sTm+SkpD/IJGBqzUzI5svI4B
         /pzm7ztBqztfYJJNlRxIA9QVEHmD0eCxu9mE+Jz7Q6xJgAOzWmax6EKzJTXK6IqS8VYy
         3aohwTHu+TLyQyBsFjCcVn1gDxQ8Okz1to8Ufk5suQPj7jMJ9pc7MV05L5/rh2kUwuui
         1Q43oWwX4lAvdyR0iL1RngC9/7idsPh+9FKSeMBJX0qXwwv4gUwEH/utahl8zrpvVdhp
         3HA/KEeUQbc0MXkPG00qGnug9Mzh90d3/qp3yF+whoAqS0D/JBfr3xvAj2nuLRMYjXBt
         /Fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706219780; x=1706824580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8G30FTf9bJfEnk9upURjOnEixj7hMKJNTXGQfnA8y5o=;
        b=Sj3veCqLF/5BgP5QHCTT6XstlZUtUScmeoAyO0zXAjaRmobz12+N5exLQYmjYN+n0+
         jJf3Y6K7jb7USfZfIy40bCMRLdx7rea7Hvyy2C/ZijB4sUQhE76NooP9xPDUiBDolaGz
         VrB4aw52kt0TvlKhOgJilhj4GP7BTgyYAyElz/JdlJ6qAX51wgWMu/rjk3MuMzlYsIWW
         LP2+Z74R9JUEvckaw+jnc/fFkvyyue/7LoU8CVf8uLqcqEOkBn6AeDzTbHUgew2Rqh80
         Tj51dCcsDy0JwQQQPhJxgRKJWpj/Cjx/b74zGlDC92jkB2paEB+d2K2WedQt/ib2LULV
         Bxqg==
X-Gm-Message-State: AOJu0Yzzgd0uRNmljMvQSGPN6nKZKmo+JgVgz7/AFHRr3pfwUwLEWxJM
	Zzex8Szwt0klWOs8D1vEtzvwO1EvWauvRMwGEp8t14e9CjrfrzAWSEehU9jsCfQ=
X-Google-Smtp-Source: AGHT+IGlqGOMbTm3TJwhdB4T0lr79jdQ2dAPlr+3PWUUP9aVa035nUS1Xsc5p8uMEsJz4CLcj8W2BQ==
X-Received: by 2002:a81:e703:0:b0:5ff:5220:4450 with SMTP id x3-20020a81e703000000b005ff52204450mr475878ywl.42.1706219779751;
        Thu, 25 Jan 2024 13:56:19 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m69-20020a0dca48000000b005ff913889dbsm942546ywd.50.2024.01.25.13.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 13:56:19 -0800 (PST)
Date: Thu, 25 Jan 2024 16:56:18 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 10/13] nfsd: move th_cnt into nfsd_net
Message-ID: <20240125215618.GB1602047@perftesting>
References: <cover.1706212207.git.josef@toxicpanda.com>
 <0fa7bf5b5bbc863180e50363435b5a56c43dc5e3.1706212208.git.josef@toxicpanda.com>
 <ZbLMJxLWIvomQIzO@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbLMJxLWIvomQIzO@tissot.1015granger.net>

On Thu, Jan 25, 2024 at 04:01:27PM -0500, Chuck Lever wrote:
> On Thu, Jan 25, 2024 at 02:53:20PM -0500, Josef Bacik wrote:
> > This is the last global stat, move it into nfsd_net and adjust all the
> > users to use that variant instead of the global one.
> 
> Hm. I thought nfsd threads were a global resource -- they service
> all network namespaces. So, shouldn't the same thread count be
> surfaced to all containers? Won't they all see all of the nfsd
> processes?
> 

I don't think we want the network namespaces seeing how many threads exist in
the entire system right?

Additionally it appears that we can have multiple threads per network namespace,
so it's not like this will just show 1 for each individual nn, it'll show
however many threads have been configured for that nfsd in that network
namespace.

I'm good either way, but it makes sense to me to only surface the network
namespace related thread count.  I could probably have a global counter and only
surface the global counter if net == &init_net.  Let me know what you prefer.
Thanks,

Josef

