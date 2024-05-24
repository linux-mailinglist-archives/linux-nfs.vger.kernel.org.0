Return-Path: <linux-nfs+bounces-3367-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB288CE4C5
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 13:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D0F2823D6
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 11:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA8684FAC;
	Fri, 24 May 2024 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="QNXOHSK1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FABE83A19;
	Fri, 24 May 2024 11:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716549385; cv=none; b=kO9uNQ+GhDqQkbRRfD4G7mQr4Hsfi1qjrOlOqQVrpwtdLHv9o8FxY14iBTB6M7A4G4jKAFKFyd2ZpzJFP7WuVGAAmDnSCu8+w23g9693Gkle/3Q6fjBIOXnXSLJo1X0AgeJ5kmbMHtZnRex4InvnOSVWPHfo2oSs5jy3kISz+dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716549385; c=relaxed/simple;
	bh=oYVpw1lCIhmODT9z7ABo2JQswJluusXqyxAUWMY1H0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NV6AArPmdcskztfJidAzLyYEHfcmnMiVEEjLakyFgVmzp8GWNv2S0pPuYSE8pgAWhno5rW3sPlLjW+5Q+H797Qc9LRYbr9OvPA+/OOK8S5I502/kAADGLmlQ7HwLfcrzjUDLDica+qIjv02Alb9Ye5iJvyYTwh08Z8p4WjefRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=QNXOHSK1; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=vatKQCd19zVpo9z7MIY/Ii3SiGceuMeeq99+c0g9mvk=;
	t=1716549383; x=1716981383; b=QNXOHSK1Zimeko8iHqnlaZrVt6enAqGcx+zwZK9WnACQrh5
	0TRgoOU5wQJytAbgZ+rTZoomLcHYWHNxsuPswcpuX4boiAKKF+2ed782821+zYDbYSjyxaa+3qVtC
	lIslt3Log/ffF5sqWpIaZNLRw8yljAjHKSukmxjqyzCza0Za0FGfKarvXywct/4ukLWhlt4IqPH4A
	Q0oLT2+fNvu1cLbhvsM4IGQsZdcXTTQ+nVgbwiSoGnOT2/hTC9miXev8/fp4cRUS8SZUCHv1Qfg2R
	6TLbJEJpn/8A2AAp3llOt9k97891uKJIyBra47YiDNM8Pu44HFVW+mbOzYc+HveQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sASuK-0005l8-B8; Fri, 24 May 2024 13:16:20 +0200
Message-ID: <90700421-4567-4e28-ae71-8541086b46e2@leemhuis.info>
Date: Fri, 24 May 2024 13:16:15 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD: Unable to initialize client recovery tracking! (-110)
To: Jeff Layton <jlayton@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, regressions@lists.linux.dev,
 it+linux-nfs@molgen.mpg.de, Linus Torvalds <torvalds@linux-foundation.org>
References: <aaeae060-2be0-4b9f-818c-1b7d87e41a5f@molgen.mpg.de>
 <e8ab863e-18a5-4c16-b0c8-a3ab6440a9f6@molgen.mpg.de>
 <5096230634b5bab2e5094c0d52780ffe2fa75bb9.camel@kernel.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <5096230634b5bab2e5094c0d52780ffe2fa75bb9.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716549383;6b1d1540;
X-HE-SMSGID: 1sASuK-0005l8-B8

On 21.05.24 12:01, Jeff Layton wrote:
> On Tue, 2024-05-21 at 11:55 +0200, Paul Menzel wrote:
>> Am 19.04.24 um 18:50 schrieb Paul Menzel:
>>
>>> Since at least Linux 6.8-rc6, Linux logs the warning below:
>>>
>>>      NFSD: Unable to initialize client recovery tracking! (-110)
>>>
>>> I haven’t had time to bisect yet, so if you have an idea, that’d be great.
>>
>> 74fd48739d0488e39ae18b0168720f449a06690c is the first bad commit
>> commit 74fd48739d0488e39ae18b0168720f449a06690c
>> Author: Jeff Layton <jlayton@kernel.org>
>> Date:   Fri Oct 13 09:03:53 2023 -0400
>>
>>      nfsd: new Kconfig option for legacy client tracking
>>
>>      We've had a number of attempts at different NFSv4 client tracking
>>      methods over the years, but now nfsdcld has emerged as the clear winner
>>      since the others (recoverydir and the usermodehelper upcall) are
>>      problematic.
> [...]
> It sounds like you need to enable nfsdcld in your environment. The old
> recovery tracking methods are deprecated. The only surviving one
> requires the nfsdcld daemon to be running when recovery tracking is
> started. Alternately, you can enable this option in your kernels if you
> want to keep using the deprecated methods in the interim.

Hmm. Then why didn't this new config option default to "Y" for a while
(say a year or two) before changing the default to off? That would have
prevented people like Paul from running into the problem when running
"olddefconfig". I think that is what Linus would have wanted in a case
like this, but might be totally wrong there (I CCed him, in case he
wants to share his opinion, but maybe he does not care much).

But I guess that's too late now, unless we want to meddle with config
option names. But I guess that might not be worth it after half a year
for something that only causes a warning (aiui).

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

