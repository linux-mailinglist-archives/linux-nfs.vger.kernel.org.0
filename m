Return-Path: <linux-nfs+bounces-818-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4421781EACC
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Dec 2023 00:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762FD1C21096
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Dec 2023 23:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C8D5687;
	Tue, 26 Dec 2023 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mNlcdX7Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883F31078A;
	Tue, 26 Dec 2023 23:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=HVJev5bn/SXmUllhi1fZYGckmmp1VVLDmEqAwl2Z208=; b=mNlcdX7YAzTroaH2aOGFi3ncxR
	2pNVzBaD/QlHN+u5vcyz9kJsWseAFVvJP5qwfpYJojtLD66OSY2Hdxbv705YjapFqRt9x649dxUap
	xmXLFccJ/U2UE3uG62d1IC6SlQSIu1tJuY9x19T9yNKI970Yt1H0l4mu4krvCTfg+Gr1Tz08eFp6t
	ueFWeDf0saiU6NwIdKiYcLLBTGa6uGwZUvOLtTmBUJ0pxig+BimyaCGwZtR5W20M59Zkh6V4MUwsv
	cr5PBKj3rAuFqFBJg7EQUi1SpzJFHMo/eGV0ZbkePXXw4/quDWjgFOd2XlTiIuqIk6lw3+2eL1nss
	MQfvPDeg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIHFC-00DgKc-0t;
	Tue, 26 Dec 2023 23:53:54 +0000
Message-ID: <12958640-e6c0-43d3-a710-48ba7873c8f5@infradead.org>
Date: Tue, 26 Dec 2023 15:53:53 -0800
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
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAE-cH4rc6gWNcsgm243i=dXQhaAQsC4gEz15GEWZO4HB7Vki3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Tanzir,

On 12/26/23 15:35, Tanzir Hasan wrote:
> On Tue, Dec 26, 2023 at 3:20 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Hi,
>>
>> On 12/26/23 13:23, Tanzir Hasan wrote:
>>> asm-generic/barrier.h and asm/bitops.h are already brought into the
>>> header and the file can still be built with their removal.
>>
>> Brought into which header?
> Hi Randy,
> 
> Sorry for the poor explanation. I see that I left out the specific header.
> The inclusion of linux/sunrpc/svc_rdma.h brings in linux/sunrpc/rpc_rdma.h
> This brings in linux/bitops.h which is preferred over asm/bitops.h
> 
>> Does this conflict with Rule #1 in Documentation/process/submit-checklist.rst ?
> 
> Yes, this conflicts with Rule #1. A better version of this patch would be to add
> linux/bitops.h to this file directly. The main reason this patch
> exists is to clear
> out the asm-generic file since those are not preferred. I can do this by either
> including just linux/bitops.h or including both linux/bitops.h and
> asm/barrier.h.
> Would the second approach conform better with Rule #1?

Yes, it would IMO.

Where can I find your current working list of what/how to #include?

Thanks.

-- 
#Randy

