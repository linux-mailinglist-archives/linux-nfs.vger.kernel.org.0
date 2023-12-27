Return-Path: <linux-nfs+bounces-820-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 966F581EAE2
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Dec 2023 01:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E581F21A1E
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Dec 2023 00:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7C3373;
	Wed, 27 Dec 2023 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VXCs6DIS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420E4372;
	Wed, 27 Dec 2023 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=eX8auJVlERlozjZVYX5dpmwc3qTmcNtRrInT7qoSsrg=; b=VXCs6DISUA8NtWJnYG3xkdlo9u
	3wfR33BC5I2SKGFTNTE2MaJZwz5SDZNyVP4uQEenPG8MFPDjpRKUL3YHebujE15oejiGZL9NNlrWj
	Wgft2zvb9IFpcDY0wtL/sE32Imv86cr7aQEbDvELhc3eBCfn9rTChkuymLFJ2QT6BImbz5sxASnzQ
	vP8TnFKrFeBRIVxmOBP6F5P3cVOQ35qhJgyG4rEWBpTiQNw7amm/zK5yKhALU3BoZ/eufUBeghwxU
	iZFCjVZUoABx28P4sBS4eEfcjBNv37KK+zELPGcpmtAZrESyXANaJ/jZ5JVIkLSUNRV6SPyQq4P1X
	1OStSr0Q==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIHVa-00Dh9T-0m;
	Wed, 27 Dec 2023 00:10:50 +0000
Message-ID: <9b5502ec-eee0-4ae7-bdc5-2bcaa3cd323b@infradead.org>
Date: Tue, 26 Dec 2023 16:10:49 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xprtrdma: removed unnecessary headers from verbs.c
Content-Language: en-US
To: Tanzir Hasan <tanzirh@google.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nick Desaulniers <nnn@google.com>, Al Viro <viro@zeniv.linux.org.uk>
References: <20231226-verbs-v1-1-3a2cecf11afd@google.com>
 <fadeaa0b-e9d2-4467-97ad-63ba8f7d8646@infradead.org>
 <CAE-cH4rc6gWNcsgm243i=dXQhaAQsC4gEz15GEWZO4HB7Vki3A@mail.gmail.com>
 <12958640-e6c0-43d3-a710-48ba7873c8f5@infradead.org>
 <CAE-cH4q2L4C6SHikUD5Le6K7T7Y39S9K1yvSFWvxCWq2crEZ3A@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAE-cH4q2L4C6SHikUD5Le6K7T7Y39S9K1yvSFWvxCWq2crEZ3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/26/23 16:04, Tanzir Hasan wrote:
> Hi Randy,
> 
>> Where can I find your current working list of what/how to #include?
>  Here is my current working list of what to #include.
> 
> #include <linux/bitops.h>
> #include <linux/interrupt.h>
> #include <linux/slab.h>
> #include <linux/sunrpc/addr.h>
> #include <linux/sunrpc/svc_rdma.h>
> #include <linux/log2.h>
> 
> #include <asm/barrier.h>
> 
> #include <rdma/ib_cm.h>
> 
> #include "xprt_rdma.h"
> #include <trace/events/rpcrdma.h>
> 
> There was a discussion here about when to include asm/asm-generics:
> https://lore.kernel.org/llvm/20231215210344.GA3096493@ZenIV/
> 
> If I misunderstood your question please let me know.

Yes, more the latter link for general info rather than the specific
info for this one source file.

Thanks.

-- 
#Randy

