Return-Path: <linux-nfs+bounces-11990-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FABBAC8396
	for <lists+linux-nfs@lfdr.de>; Thu, 29 May 2025 23:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFA53A5BA3
	for <lists+linux-nfs@lfdr.de>; Thu, 29 May 2025 21:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6E0292918;
	Thu, 29 May 2025 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4wYWuhr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BFA230264;
	Thu, 29 May 2025 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748554156; cv=none; b=jzN3Z9i96SVHsw/aYDcwMHQ2SeL1wx0uBrLbtQ0NuewannmxZZEj8hOBWwbYhx6//4C5jKanEt2Qtz4FWDOStgLcQd/v2sE9ihZqm4KKFuvDpgxURp3HFlJE6Km0IQuVjQCiWsbKQ8uHS5DtutEd7ZdVeBz5vf1XRwUoYbe2Z8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748554156; c=relaxed/simple;
	bh=Z7YYvdU8l1NsqGFyiGTHFFAwNt4oUnYsGMlfLS7rMhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWtKSsuy/SuSWwW/+7qFQ6+2T5MWkZqPxk0ESKoBNSupzBvUGBWXq2cfJ+RmlaMR1PtEMgs91F9q9oiwQ2pa3R3K+QgmOxsXvLYTtMXy8pFnswx/R7zCvGR+9H8r7zLju6xhj6Evq345ShRey0lSlkoypQqyLdNTtgNhU6GxS5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4wYWuhr; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a36748920cso1414027f8f.2;
        Thu, 29 May 2025 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748554153; x=1749158953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U85oeX4MkrW5FWx8nWXUgVEfSLqp8ilr+jmCQrjfSfs=;
        b=C4wYWuhrt0uewTtpmTW87GPsruB/S2f+rv6CTYkIOwcmRCF9Ce96H9v68kXVRSbY6A
         smbch16wLpQgozjxvf8qksUuaPcXEaGaiV0b0Dw6vD0rWEK9QnpQ+Ml0L+fMPv2MJocP
         q7/tgUqzmhrMaRW7IVHFSwIk46aCtmk5wl9Tgl9jrXy5fx4r304gaw0FPTabBovK9VRh
         RubCg4lIxDsory6uv+YRfWh+oOKh58YZXjJZdKa2V9Z3djHOX/090UBPBDCsn/zCl4ST
         nc14HSUj1TybXAsYc6foSXBleye5S+UOynmBo/LDdb/h10X7mDIJIN/IrXVu55rVGhsB
         PUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748554153; x=1749158953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U85oeX4MkrW5FWx8nWXUgVEfSLqp8ilr+jmCQrjfSfs=;
        b=SbKpd9DfSDJvxIkSUbh/uqOM7lu0lUrmcG/s3Vjh22IcxlweNuNIh5kwHIEShOHPBd
         2BY9ct41U5b8pnAzfkdVG2HmtkcAk8pSGUEp5ABjqlaEHSWNB6NjsEr5ITDAvDzebbOl
         fmj9RbEDGVhEwAa84GR8NlytlLilw9tJs7+zcBeX+SvrFMtbkjjlAMizoyz/Xtx2Onab
         nDRZAboG+K7DSTtZktF5o8CEO9i4dgwZsBBRy6MsU50ZoCLFVee01Kbax30ba3Sz82cV
         iQFE4sz9JXCFum4BRM4XRkAWD1MOoXzeDSDYZ0J/CD35tTBozI5DR0mha39PCNCkwNZW
         w6Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUuAuL5dqzPVtewpqKLJabCzDIZ0CTm8X7rgGKJ4Vruo2mLEGkLL/sJOSTE+81c994pufodPfsP6tMInA==@vger.kernel.org, AJvYcCVsojNxnrisAxDrL6HIFLWkTZkqokIyjL6Zm3ei1GTzJJAXZ+ibONtIIHbuxljssITejNIsm23lg8E=@vger.kernel.org, AJvYcCXSE3lp0fd5Y8k6xOeMVw7jJH+3R4yvEyRTs+Llw2dxbVQTdAI3TiLOejeXgkfCLwa6uSPDJeug@vger.kernel.org
X-Gm-Message-State: AOJu0YzDlNFvu3SLv2Nf5dIfL4rLxdN1p2zANk/8jbE2HoMI8M+3eM/q
	Nb1tLzpnWmVAkBSqenNWSXXWjuoTIJsEb+BHDC2QfDZ0hduIqC5ktIvA
X-Gm-Gg: ASbGncvaDiYU5dTr4SzuOW52OTlMUZ8/HviCm7pLvbufzIVqBkl0OU8IQvNxa157BeZ
	jXDIs/n7IAaYUIAen3KR0kfj/3iFRzwv4mKCq+xT4tqNuPTMOG0gHCNksgQ66m4piX4xngzHOei
	zN54PUSkF74CHIM413CwHLH7WpF/1gRU/zAc9UQ0PXVD8carFTJt1X4Vihs4bZ8Hsn/UIaUO0TY
	aQvV5K66xQXRvRjeeHI0ApS8CNLNntKgGf3FNHyTaFePANkPeUrOT1gUc1DKEwAtll5h9F2T4Xm
	byZJoZEyWPafFe6ROk9L1/aEYQ1hNhDBnZDWv/psstNJgIs1R9p9IP0WonH/VCLIhercJ3vUlWF
	19AhZ/Ck8W12ZZQ==
X-Google-Smtp-Source: AGHT+IGT6Wwf7gVpUfM1Nqzr6escLgno2IMcSQrRw0Uy2H2YCSoD17fP2R1YZIFdVF1bLqkmaXgCqw==
X-Received: by 2002:a05:6000:2891:b0:3a4:e706:5326 with SMTP id ffacd0b85a97d-3a4f7a23e5cmr643811f8f.3.1748554152539;
        Thu, 29 May 2025 14:29:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00972b5sm3085052f8f.76.2025.05.29.14.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 14:29:12 -0700 (PDT)
Date: Thu, 29 May 2025 22:29:11 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
 <jlayton@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, Steve French
 <sfrench@samba.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 net-next 2/7] socket: Rename sock_create_kern() to
 __sock_create_kern().
Message-ID: <20250529222911.37dc04f3@pumpkin>
In-Reply-To: <20250526053013.GC11639@lst.de>
References: <20250523182128.59346-1-kuniyu@amazon.com>
	<20250523182128.59346-3-kuniyu@amazon.com>
	<20250526053013.GC11639@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 May 2025 07:30:13 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, May 23, 2025 at 11:21:08AM -0700, Kuniyuki Iwashima wrote:
> > Let's rename sock_create_kern() to __sock_create_kern() as a special
> > API and add a fat documentation.
> > 
> > The next patch will add sock_create_kern() that holds netns refcnt.  
> 
> Maybe do this before patch 1 to reduce the churn of just touching a
> lot of the same callers again?

You also really want untouched source files to fail to compile.
If nothing else it'll stop backports going badly awry.

	David

