Return-Path: <linux-nfs+bounces-11512-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07549AAC7AA
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E5298152F
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7AC28312C;
	Tue,  6 May 2025 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TKH2bQx6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80799283129
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541029; cv=none; b=PjCCo4GjTOGXc2kRllK5VsTgtoWawOODodnpQSEi5akPEXLxb9ZdCcJMPZTnv8oPNQtTVvOjRPPT38Q8DuSIzneM+i8IhgGvDNMF4XfF/oCyVVvsws/kMt65to0in+is1QQp4aQXi87CKQd/k3IS3j2Y7M9vqFxihUfvDtI8mEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541029; c=relaxed/simple;
	bh=iVhTKt1Xp028t1DCZj48CMF1sFbEZupc52pfp/AmjI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fApKcYzPGIFDexh7ScJwW7CwUZN00+dmwp6t/GvSFyVVJAcjacBZ6TmIPZPnjPRlpplXnXoxXynQQl9zoOjqn/TKam/vMEorMs5YItFD2wnTVtB1HPo+uWMc917HCENDsCbgcGo/nwYB+3Ue9iOf5V2wo5a/IT6xcOkIcXkW4pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TKH2bQx6; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ecfbf8fa76so77923046d6.0
        for <linux-nfs@vger.kernel.org>; Tue, 06 May 2025 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746541026; x=1747145826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KK9ug9bvWYaDUfsuM/+3s0BmRqqb/lZlQy3p//oYh08=;
        b=TKH2bQx6O7yzwZ6oSk+ykfmvqD+bO6c2LTFHmEfg4NWri5gEQLpp+5kQ47rAcRnO7q
         Kx2sINkmGXkTN/y7e5zy5RJ6zUr11ZI75xxU5Gs9BAjGYo0YXeJZJn6F1HQuYlYJl7n6
         rXCJIEW+ROFu5HmNMi214YYV4ZhJcgOVwfw3oYiQ6mcsWiCZsRiVQ9K6KwMqueXlwApO
         v/0oPTVPC+3fcxNcePf9MQ7p7tefr/FbEDJxWDRZ2Q2/UZ2D8iTyYO/YTGbG0GuqEdmm
         8i0E33Mgh3jeQ70TjBG93b7VVw89DjIMVNbHYkRl3ADZaTUrVk4GXY+vGeloqiSgHfJb
         eDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746541026; x=1747145826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KK9ug9bvWYaDUfsuM/+3s0BmRqqb/lZlQy3p//oYh08=;
        b=Fr2zMhk+OgaGtULULuQ7HniU/ruOWK4omynv272l1iMY0d4RCkD/d3DBZYKX4o+CQd
         t8eslsUvZe/5edkkOb7Eq+trhu8wqF+IJWUjFKo+V5PS3fhvGu5acKR5K0q15uLHyjNT
         qu0hJs61rZMWbSyg1GFolg3po+FwVMeiGWgEAqQ+fr3QXVvS/JfxA6Ndv+XGMUmMYxNt
         ajB9uM46l9KclLNRO2QqM595iYiTS12DJYgPixbKQFv8iYDdnMzBQM1H8ZysTOlvJc1y
         nogMfTqzdyMbHYzT9gHqmnJTt1iemv8fazyHKB/IxxSOjRpixmI+18cgpCJ7Jkeg4XQw
         FZXg==
X-Forwarded-Encrypted: i=1; AJvYcCX163qIHEEmkd1IekqKLD/vG17BAbm/lflNAHVWNMdU/yX69IXLQRwd32MSo53o9P1k1I2MEsFsUBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/R5A/nEeZn5n9NCRAt5nJ8674seuVbSB8xjgsHVjGU7P2xrR
	SKUlA3x2lygAtSwCPKUH91hdVOt+K6R70Ss95egcoKK3L+Fvj9TOsqfIOuJhCP4=
X-Gm-Gg: ASbGncs69d6tITXQ2qABFte5XlgrYeoZPDZTSJR9QVVeXdP3AzYdqe10vBwcnTBiId6
	ruO9pSjOInZRxXq8Np+cvYl8r9DwhHakEqV/FGx3+iha3oLY+LOYnNHTLmDxX824cH6fXYUhBPA
	VK5EvDreXNIRhlzhJ9bHblfZ6WSPZp6BPTCz4qTdFCNs7ski4Ect2oE8ioPBSKyOPRYZlq6fiiA
	lJfQ2Mj1vPZnMDLB0j8dSWmLL0E/jQ2C+ZmbQDmlKdxYOVaJ5ELZNdaASvjhlkeDAxIvrVLRIoW
	NoHm0ZcX/aEAvOVxZ07SQZGmVdat7jM5ZwJn9kDGUQmX5DbdlXu53Wi3u6FuzmGnvviWBzVUgad
	hL2jVcDoHWi92hpfo3zU=
X-Google-Smtp-Source: AGHT+IHzkJw2Wckz+Ne+7XL382bYH56yHPQzNXpYHC1FCC6YssmHX3xzyUfeNwRnEpNijECzyazpmw==
X-Received: by 2002:a05:6214:f07:b0:6f5:108b:d857 with SMTP id 6a1803df08f44-6f535417719mr71539876d6.36.1746541026379;
        Tue, 06 May 2025 07:17:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3d2f5csm70116606d6.58.2025.05.06.07.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 07:17:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uCJ6X-000000006TY-107C;
	Tue, 06 May 2025 11:17:05 -0300
Date: Tue, 6 May 2025 11:17:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v4 01/14] svcrdma: Reduce the number of rdma_rw contexts
 per-QP
Message-ID: <20250506141705.GI2260621@ziepe.ca>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-2-cel@kernel.org>
 <aBoJ64qDSp7U3twh@infradead.org>
 <20250506131722.GG2260621@ziepe.ca>
 <aBoRSeERzax5lTvH@infradead.org>
 <20250506135536.GH2260621@ziepe.ca>
 <be740f28-8d68-400c-85bc-81cc4e48ccc6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be740f28-8d68-400c-85bc-81cc4e48ccc6@kernel.org>

On Tue, May 06, 2025 at 10:13:00AM -0400, Chuck Lever wrote:
> On 5/6/25 9:55 AM, Jason Gunthorpe wrote:
> > On Tue, May 06, 2025 at 06:40:25AM -0700, Christoph Hellwig wrote:
> >> On Tue, May 06, 2025 at 10:17:22AM -0300, Jason Gunthorpe wrote:
> >>> On Tue, May 06, 2025 at 06:08:59AM -0700, Christoph Hellwig wrote:
> >>>> On Mon, Apr 28, 2025 at 03:36:49PM -0400, cel@kernel.org wrote:
> >>>>> qp_attr.cap.max_rdma_ctxs. The QP's actual Send Queue length is on
> >>>>> the order of the sum of qp_attr.cap.max_send_wr and a factor times
> >>>>> qp_attr.cap.max_rdma_ctxs. The factor can be up to three, depending
> >>>>> on whether MR operations are required before RDMA Reads.
> >>>>>
> >>>>> This limit is not visible to RDMA consumers via dev->attrs. When the
> >>>>> limit is surpassed, QP creation fails with -ENOMEM. For example:
> >>>>
> >>>> Can we find a way to expose this limit from the HCA drivers and the
> >>>> RDMA core?
> >>>
> >>> Shouldn't it be max_qp_wr?
> >>
> >> Does that allow for arbitrary combination of different WRs?  
> > 
> > I think it is supposed to be the maximum QP WR depth you can create..
> > 
> > A QP shouldn't behave differently depending on the WR operation, each
> > one takes one WR entry.
> > 
> > Chuck do you know differently?
> 
> qp_attr.cap.max_rdma_ctxs reserves a number of SQEs over and above
> qp_attr.cap.max_send_wr. The sum of those two cannot exceed max_qp_wr,
> of course.

Yes

> But there is a multiplier, due to whether the device wants a
> registration and invalidation WR in addition to each RDMA Read WR.

Yes, but both of these are in the rdma rw layer
 
> Further, in drivers/infiniband/hw/mlx5/qp.c :: calc_sq_size
> 
>         wq_size = roundup_pow_of_two(attr->cap.max_send_wr * wqe_size);
>         qp->sq.wqe_cnt = wq_size / MLX5_SEND_WQE_BB;
>         if (qp->sq.wqe_cnt > (1 << MLX5_CAP_GEN(dev->mdev,
> log_max_qp_sz))) {

And this log_max_qp_sz should be used to derive attr.max_qp_wr

> In this patch I'm trying to include the reg/inv multiplier in the
> calculation, but that doesn't seem to be enough to make "accept"
> reliable, IMO due to this extra calculation in calc_sq_size().

Did ib_create_qp get called with more than max_qp_wr ?

Or is max_qp_wr not working?

Jason

