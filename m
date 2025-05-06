Return-Path: <linux-nfs+bounces-11515-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B08CAAC7C2
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057FC7BBE2F
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213EE2820BA;
	Tue,  6 May 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZOhMnslr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC3281503
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541326; cv=none; b=lLtDM6nwG2QFhaii+LE60P3DFUmrdWftphD1DKdLm5uYsvT6dlTg+Ffud+rqlnEC9/3WcoSfWC8fJsZBZeMaoD9Vkdx3aC9QMNx9byAOojif68Kq7QEZr1krp091TA7zOcqmU14emqF4D60Q1jBEhQ02QeVawgWgk7ss39AkqwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541326; c=relaxed/simple;
	bh=J+mg6cEpXyQQIWs6kbcnPXhgAhiUqyGZFrGo/eaz0PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie+Am24N7O/0yIUO2yV6zCxue9EVKej1jYb//VAXAlr0/TmPa/ZyvevQDO8lziP0y716ozZSx4Ns1nKRK/WzeqYyySzqtPbcukuB3SozeaUrYchuX0WFQllPFVCHY3G04hHSu8fSNpXzJABFtUPKRx/zPHL7nSs329BG/PVMPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZOhMnslr; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7cadd46eb07so391565485a.3
        for <linux-nfs@vger.kernel.org>; Tue, 06 May 2025 07:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746541323; x=1747146123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jdO/xzSRxYVpKMGXriepq+O9+XVFu9E8u5yhtKyYDnI=;
        b=ZOhMnslr9UmXEj/zb5CyM+Uv09zHyn8EmKr/L2E+LZLycY48L/BlzLVK66560wI6n/
         jmn1jAYwnMS2b/pWIUlYJCfqeF3tbBKly/taq1pNZVyyB1sxujvdE+TA1HXKMh6kl7fk
         UI0ny2OcCAINk0gvoQ0Rqt8Cg04tVa3hmaqYLr/WI731yYoLVSkrKghItYw7GNVz7+ol
         vgNXJQnRAlW92dWwsLdPfkdfnBmNb7VKQr7sPtF0yH5dX/A6leN4BMWfEWVzCDISPYmv
         dfFoB/ilC/hIDHmvL5mtD7QbJiSAybjePMjZN7OwWp26CKxqA7d8jtzrxPsyztDtsObn
         FwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746541323; x=1747146123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdO/xzSRxYVpKMGXriepq+O9+XVFu9E8u5yhtKyYDnI=;
        b=q9Wz1/hMeUfvIEfHDcga145Wbg8RJKP2KPh7ry203hWYauUTIvNLzxfd1ZmpibUAGp
         ZgkCLi6Jx4Y6qHBJSdNNTE23n9H/AwsuubRoetphWmgafoElwKqzDflgu0rU7UH/82y5
         aJG5X/5nFcTUPtoQntNKq+DtRDLORBteW8DLwO6iZSUUwq4kd2r6kc5UYdnB61upUwWY
         NaVKQdEEvqn0tXScyW23lY3R/tvlD8CoWrjoeD4H1xYO7kjyCJM6xIACfqdpm5uUJlXv
         Tl3SFBIGN6j1/gFy0qkxSjjfFEukio9QnrKtyj8gH0aPb3ae18JfcUvt4yTxdh5PXRUa
         J6sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGOK6E8O1x6o1p0wCO21jotfFPOcyNSzSkuVpx8DbTb+sUSFLy6j/2iAO7dHy4dxdQ0N2bDl4jLyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi1AEdKObRCTpdYz7EYAE+b8qJKxcjp0PWbTcfOhAHMeFcng1i
	c7pWPEKPeBb1GUQdyczauo+1gqo9r5mpt7Lw3OWIcgun7WsCMQFGJJQ8IjaXkG8=
X-Gm-Gg: ASbGncvrVAsusDlmIj4jZsKobR3ORJvKHtseAUmVKLxkQN0hm6KogTUSdXe2h68Rgr9
	PbKjgqhGwXdGgrCJpwGYhSL+E/QyINRK0nGgH3NwvZuvoWRSGQA8tjTfyd+upOTrRSEfKMNpifw
	j7fIBrDwWY9vO9A6pgFhEZt5lEwlF0jKlb7dTiK5nB4M1AcG1hlJ96lcWYB+/2d7aLq4g4gPobD
	xUImIu4gn1ZR3YlW0Co6UnyE+FQpDu+xaIeug5gb8u8D4vEQInr4O9x+ysCsMrnm+iqH7CfLaJc
	SkCmLGuWJ18Ty6Np71rUg7tFRNwxcLM6Aht3GOHxhqPVKp49tPH0TwDDq6zj4K3EhoDL1sc5Hkr
	Q9JaysYZ9Ws++FqVgQGQ=
X-Google-Smtp-Source: AGHT+IEf9c6kwoiIpN+a2MZ0HbS9Mmr9K12+N98aGW0tMtHt4ybp37bnK02L8TRsbNfmOUe+ef7j0w==
X-Received: by 2002:a05:620a:2953:b0:7c5:3c0a:ab7e with SMTP id af79cd13be357-7cad5b20805mr2276438785a.5.1746541323354;
        Tue, 06 May 2025 07:22:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cad243f477sm715703285a.96.2025.05.06.07.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 07:22:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uCJBK-000000006iP-1U2Q;
	Tue, 06 May 2025 11:22:02 -0300
Date: Tue, 6 May 2025 11:22:02 -0300
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
Message-ID: <20250506142202.GJ2260621@ziepe.ca>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-2-cel@kernel.org>
 <aBoJ64qDSp7U3twh@infradead.org>
 <20250506131722.GG2260621@ziepe.ca>
 <aBoRSeERzax5lTvH@infradead.org>
 <20250506135536.GH2260621@ziepe.ca>
 <be740f28-8d68-400c-85bc-81cc4e48ccc6@kernel.org>
 <20250506141705.GI2260621@ziepe.ca>
 <d7115cd7-c34c-4212-b244-e5247ac68fcc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7115cd7-c34c-4212-b244-e5247ac68fcc@kernel.org>

On Tue, May 06, 2025 at 10:19:06AM -0400, Chuck Lever wrote:
> >> In this patch I'm trying to include the reg/inv multiplier in the
> >> calculation, but that doesn't seem to be enough to make "accept"
> >> reliable, IMO due to this extra calculation in calc_sq_size().
> > 
> > Did ib_create_qp get called with more than max_qp_wr ?
> 
> The request was for, like, 9300 SQEs. max_qp_wr is 32K on my systems.

Sounds like it is broken then..

	props->max_qp_wr	   = 1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);

So it is ignoring the wqe_size adustment.. It should adjust by the worst
case result of calc_send_wqe() for the device..

Jason

