Return-Path: <linux-nfs+bounces-11501-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84324AAC70E
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C907A8C22
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C127A932;
	Tue,  6 May 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZLpmtbJY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEEA1F5849
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539740; cv=none; b=bhtuWaQ4Wdt4VX8hvG1ultCf1cnx5/cP8R3uVb8DjF60JRPHLnvkX9JvX+l2XsK+aHK+jkCYj1yW4k2KkBSTCIXT1OEVRTMXFzLYNjLs+gg7A4VbIP8IRf8G9OA5gC/Qq/jIQNiQKrElj1sQ87fMrmLT5TZzceSa2dZ5TU4va7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539740; c=relaxed/simple;
	bh=4/8rtOQ84hrt7xaLNFp36c7CMUUjH22rS/1Tp7wpJMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBrIjyYDYVKs5RwK0YcFr/qmGnEmUpNuO8znvLhf4WsqRk1xYo23FwZcYS72IIA+FopXRBhiU1cCdDKSClq74ZUchm0Lx7mpX9LlS/vPMNguuwEwj3n1YwYCXvsiaKLXo6F0QhPjFDdo367DUYQnX/ZIP0AhVwQoifbR4H1dRd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZLpmtbJY; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ecf0e07954so91176146d6.1
        for <linux-nfs@vger.kernel.org>; Tue, 06 May 2025 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746539737; x=1747144537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rf4JjGxQCwpgS6sftKvl9+EOOyc5cLZ6tjRaCrnWGTM=;
        b=ZLpmtbJY82wGry2WwoJMYQsB/EYYGWlLey/bgeol9lfl0r+6RmhVouKtgLW0dGoQTe
         GWFbXs+IBrvg9yG/1Mpou6cTGTcdvD1ZqlWq/N4sGC8nr/EgdYuKQ/QDIVY7byPsw0lb
         kb/J+lZs6AidHv+b1wok6tQVLeaGjeuj2wHVVWSc+kHOa+5BAWf2CT8s+sVxjjfFRC+p
         2NRNXIxQFpMZw+xFdu/0OHX1g75UbulYuXU6Ul1iN3v6op7Zv0bJOGPhkW0fcmUYqT9G
         cgbqFG9yxQI++ReDHXETfwKYzQEghbz8lohBVJTAw5GVJ1VKEfYJDLrZWJ/aoxmiO150
         6kwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746539737; x=1747144537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rf4JjGxQCwpgS6sftKvl9+EOOyc5cLZ6tjRaCrnWGTM=;
        b=V4/4UEaYYT28fz7XhddhTr22Unx6DgN/lR2GqW47e1px5kD8cS589K4q9ZSdPzKa7t
         /FlINIX5iiYydzRiQTPMirOclJzExpTUD9P3+FhoD8pLTDXL6vVZ3MvRNyGp95mnlkAz
         wq3eDJTjMjyRv1enoZCYr7od54nzasyrh3B7HdBJtQTUDt6nXHhFlHDU7ne4Z5jzpukH
         Y0M/4t4mGSIZZPh9Reys/jF+5sDukT+yOUuWfIYefLtMgqjopdbRPvqIIlOdalgLcIiP
         9DvBlmBHGRjptiyjMp3vnF7s5Tlon/gKK4itVShvnaf1Y1klduT/7HP5AohH0s1aIzvY
         NZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHko07U+PMsNPt4wBiGg2zBN8zTO/3J8J6zymbbNnr8iqFGL6vKLEdihBtVq8bzZ4D6yFSaLGMoys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx547+QkczebCkbmvfrDo9LJ2aM0HWFfc/PMZszGzW12NpjEtxx
	R7/yQkkRwdmv58D0WM1TyQs9kpYKlDjSprUnI9ovjRZ/KBI23yROsS3CCv2sQ78=
X-Gm-Gg: ASbGncv86ZRLvFKLYbjucCBH5E9rxlgBxIKF668/KZLzcxgXGzGcqGMskFxaycYjpkO
	I/d9+XQycuEFy+nN+dycL5wjoa1Sa0wqAnaMRHzXeAWIqddLMX78hWEJUlHhWI9XXz4RFfjftxB
	0UqmmtcnGqymiROXxVApmBeqHOLHRmxg+vm4SOu3T1L2VTYKEyqtHQv8IAPITFixQygEKXuYjx3
	RIK2V7Am0f5rPdAlwjhq+VTzYUpznUF5NpKf8+5vgZy0J3r6zTrCcX2HnAeApIuVyog48h23O1/
	P3T5Sodp3iPKWRYWHlbMVggox1FngLOSvr2SPb00AYmdLHzsvB4HPk/pFpSpQ3GO7ktgD76oiYy
	opVyUC0xJzJunvizkHrk=
X-Google-Smtp-Source: AGHT+IGaO8ljMXOeEkr4RUOojdJ5UwAMwDBVV7a9s0Z2nsjD98gxMNOlDK7kPEGavQ9nw4w+7DJ2mg==
X-Received: by 2002:a05:6214:c8a:b0:6e8:87bd:386e with SMTP id 6a1803df08f44-6f528ce8d39mr183708456d6.33.1746539737135;
        Tue, 06 May 2025 06:55:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f44f47dsm69906396d6.92.2025.05.06.06.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:55:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uCIlk-0000000062H-0ro4;
	Tue, 06 May 2025 10:55:36 -0300
Date: Tue, 6 May 2025 10:55:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: cel@kernel.org, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v4 01/14] svcrdma: Reduce the number of rdma_rw contexts
 per-QP
Message-ID: <20250506135536.GH2260621@ziepe.ca>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-2-cel@kernel.org>
 <aBoJ64qDSp7U3twh@infradead.org>
 <20250506131722.GG2260621@ziepe.ca>
 <aBoRSeERzax5lTvH@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBoRSeERzax5lTvH@infradead.org>

On Tue, May 06, 2025 at 06:40:25AM -0700, Christoph Hellwig wrote:
> On Tue, May 06, 2025 at 10:17:22AM -0300, Jason Gunthorpe wrote:
> > On Tue, May 06, 2025 at 06:08:59AM -0700, Christoph Hellwig wrote:
> > > On Mon, Apr 28, 2025 at 03:36:49PM -0400, cel@kernel.org wrote:
> > > > qp_attr.cap.max_rdma_ctxs. The QP's actual Send Queue length is on
> > > > the order of the sum of qp_attr.cap.max_send_wr and a factor times
> > > > qp_attr.cap.max_rdma_ctxs. The factor can be up to three, depending
> > > > on whether MR operations are required before RDMA Reads.
> > > > 
> > > > This limit is not visible to RDMA consumers via dev->attrs. When the
> > > > limit is surpassed, QP creation fails with -ENOMEM. For example:
> > > 
> > > Can we find a way to expose this limit from the HCA drivers and the
> > > RDMA core?
> > 
> > Shouldn't it be max_qp_wr?
> 
> Does that allow for arbitrary combination of different WRs?  

I think it is supposed to be the maximum QP WR depth you can create..

A QP shouldn't behave differently depending on the WR operation, each
one takes one WR entry.

Chuck do you know differently?

Jason

