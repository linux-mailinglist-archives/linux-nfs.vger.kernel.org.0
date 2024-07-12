Return-Path: <linux-nfs+bounces-4865-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFC292FBAD
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 15:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C681C21782
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5593616B390;
	Fri, 12 Jul 2024 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="jwCjyeKN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04C12BB15;
	Fri, 12 Jul 2024 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720791953; cv=none; b=RRJ5s+FLlVb4ztpmBf4d6fdg6O8KVuiC42rhIi1626mKloBpGrio53O1W8xy10/60TgEMm1OC6EDhZX/Y6QmfdtD19AD8C3C2vgYACp6K96iZSY06JwzjAfZ/Y9EIBeyYEQ73Ygn9EWn4oFbc8Ugn2o5MKfHZRB0Epo3fExnRFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720791953; c=relaxed/simple;
	bh=o+4Nno4p9kTEGnjycsFuoOAxBV4KU4nOQMA4urnZIWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fzl8v95FRzkwyfbjafj90bwqrmywHC4qDlTgDHCGC+MsLIQ0WQtJGZUwmvKyb7w1LJOXB5si9xCGWiI2UgR6pNjOuybQm3s56pRwhkauOYcaIT+warWruSpGV1lop6MElQSaFfk6nctGL70sDRRa1CvrnZlyf2nsf/laGgspG5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=jwCjyeKN; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=gWM32B86wx1XISKeXKW53i5p7I1IPlyOLxGF4sKFg+M=; t=1720791950;
	x=1721223950; b=jwCjyeKNPSV7VXrimyDPwn/npCkg6V5X0C0LZEPsCaWrcioGeK0Vpl9vbMnH9
	AfixhD/2fzb+uMrhYOK7h1pecHfN3plCgptkxfFOEi4lkm5iXLkwlqfwBo5d3tlyRvUQQSOw3wQ0u
	tPw7sliPnRF9Nr8xV6rK1DtJysXR5OEDXD9KqzL8a5YlhNWOKkVmZRa3xgNJQ5rvde1u954ZUvkFK
	ApWs6byZfjiNpZPiFfizSwnNoEAxL24srfW3cF9DO6lZQuVqLZm3jUaU1Jd1QPLJ3ajO+2U7XYdQZ
	zagabd7zoMVcObzC2MdovGtff0QC5eSUOd/6+P+UC5tW9Zonrg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sSGao-0000g3-Oz; Fri, 12 Jul 2024 15:45:46 +0200
Message-ID: <868ccc20-00b3-4472-b081-0d26254a0f66@leemhuis.info>
Date: Fri, 12 Jul 2024 15:45:45 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
To: Chuck Lever III <chuck.lever@oracle.com>, Greg KH <greg@kroah.com>
Cc: Sherry Yang <sherry.yang@oracle.com>,
 Calum Mackay <calum.mackay@oracle.com>, linux-stable
 <stable@vger.kernel.org>, Petr Vorel <pvorel@suse.cz>,
 Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "kernel-team@fb.com" <kernel-team@fb.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, Avinesh Kumar <akumar@suse.de>,
 Neil Brown <neilb@suse.de>, Josef Bacik <josef@toxicpanda.com>,
 Jeff Layton <jlayton@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
 <2fc3a3fd-7433-45ba-b281-578355dca64c@oracle.com>
 <296EA0E6-0E72-4EA1-8B31-B025EB531F9B@oracle.com>
 <2024070638-shale-avalanche-1b51@gregkh>
 <E1A8C506-12CF-474B-9C1C-25EC93FCC206@oracle.com>
 <2024070814-very-vitamins-7021@gregkh>
 <64D2D29F-BCC0-4A44-BB75-D85B80B75959@oracle.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <64D2D29F-BCC0-4A44-BB75-D85B80B75959@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1720791950;39225201;
X-HE-SMSGID: 1sSGao-0000g3-Oz

On 08.07.24 19:49, Chuck Lever III wrote:
>> On Jul 8, 2024, at 6:36 AM, Greg KH <greg@kroah.com> wrote:
>> On Sat, Jul 06, 2024 at 07:46:19AM +0000, Sherry Yang wrote:
>>>> On Jul 6, 2024, at 12:11 AM, Greg KH <greg@kroah.com> wrote:
>>>> On Fri, Jul 05, 2024 at 02:19:18PM +0000, Chuck Lever III wrote:
>>>>>> On Jul 2, 2024, at 6:55 PM, Calum Mackay <calum.mackay@oracle.com> wrote:
>>>>>> On 02/07/2024 5:54 pm, Calum Mackay wrote:
>>>>>>> I noticed your LTP patch [1][2] which adjusts the nfsstat01 test on v6.9 kernels, to account for Josef's changes [3], which restrict the NFS/RPC stats per-namespace.
>>>>>>> I see that Josef's changes were backported, as far back as longterm v5.4,
> [...]
>>>>>> I'm wondering if this difference between NFS client, and NFS server, stat behaviour, across kernel versions, may perhaps cause some user confusion?
>>>>>
>>>>> As a refresher for the stable folken, Josef's changes make
>>>>> nfsstats silo'd, so they no longer show counts from the whole
>>>>> system, but only for NFS operations relating to the local net
>>>>> namespace. That is a surprising change for some users, tools,
>>>>> and testing.
>>>>>
>>>>> I'm not clear on whether there are any rules/guidelines around
>>>>> LTS backports causing behavior changes that user tools, like
>>>>> nfsstat, might be impacted by.
>>>>
>>>> The same rules that apply for Linus's tree (i.e. no userspace
>>>> regressions.)
>>> [...]
>>> If no userspace regression, should we revert the Josef’s NFS client-side changes on LTS?
>>
>> This sounds like a regression in Linus's tree too, so why isn't it
>> reverted there first?
> 
> There is a change in behavior in the upstream code, but Josef's
> patches fix an information leak and make the statistics more
> sensible in container environments. I'm not certain that
> should be considered a regression, but confess I don't know
> the regression rules to this fine a degree of detail.

Chuck pointed me to this thread (I had an eye on it already anyway) and
asked for advice. Take everything I write here with a grain of salt, as
this is somewhat tricky situation which makes it hard to predict how
Linus would actually want to see this handled. Maybe I should have CCed
him, but I doubt he cares right now; but we maybe should bring him in,
if an actual user complains.

With that out of the way, let me write a few thoughts:

* That some test breaks is not a regression, as regressions are about
"practical issues", not some ABI/API changes that only some tests care
about. So if it's just a test that broke update it.

* If a user would reported something like "this change broke my app" it
obviously would be something totally different. But that did not happen
yet afaics -- or did it? But from the discussion it sounds like that is
something that will likely happen down the road. If that's the case I'd
say it's best to prevent that from happening.

* Not sure how Linus would react if a user would complain that some
workflow broke because rpc_stat are now per net namespace and shows
different numbers (e.g. using a format that does not break any apps). It
would likely depend on the actual case and how bad he would consider the
information leak.

> If it is indeed a regression, how can we go about retaining
> both behaviors (selectable by Kconfig or perhaps administrative
> UI)?

That likely might be the best idea if user report an actual regression
due to this. But switching the format of any existing file creates quite
some trouble, as others already mentioned in this thread. So maybe
providing the newer format in a different file and allowing to disable
the older one though a Kconfig setting might be the best way forward.
Sure, it would take years until people would have switched over, but
that's how it is with our "no regressions" rule.

Does that help?

Ciao, Thorsten

