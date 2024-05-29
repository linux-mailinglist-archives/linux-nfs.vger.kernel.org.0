Return-Path: <linux-nfs+bounces-3470-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE168D36C1
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 14:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDED1F28D64
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 12:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7621A4C70;
	Wed, 29 May 2024 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="aIMjeblZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0EE23DE;
	Wed, 29 May 2024 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987072; cv=none; b=cCCTNIqqLoKg70ky6Si1q7W0GO7kxItdGxVTvoS0ybzQJBOYCTm16bTdS6uYbr7d0x7O5rbHnsSlsgLBB0udt94ZlNgcF6jZZc4xlLgxXEP7BezuYugFO/dztBPzsRqxK4eNwPBigMAsYovy07lYVPj5c2I8+3wCo/q3vqqVYvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987072; c=relaxed/simple;
	bh=nzeduYzqyrc4dtRTbpFp0fKRRmiHy1rwvKZ+9Q8IAwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImpWufHb1lNFEvoksjxmAMCyX82NOaQsXD7jYAgnWTskQDovtt/+Ay30WQRztY8RtR9eQqhKSRM07IIBRQAcjom91gTf6z/o3HvCxIJ0SBEq7pcrBb8aW7U5bOIXvme7OMGcdctJ9DHV/XJFNt6BcS/+RNnejBjmnVhrn0Kjf9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=aIMjeblZ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=CWj9EbBpza8KDASnIQoPoNPdtY21F25m+kK5YEbF3AU=;
	t=1716987070; x=1717419070; b=aIMjeblZzY15D/qHPVuh4QFjyCcKwNXWbPnQaDBZPs2JX5a
	OFrN1qGA1PBstYUxRaUKbbWIblyhF5CbYWXhOdtD2OpyP0PHbJ8gMKGW2FqTQY0EOgrK/aM+aygA7
	S/c3xKxg/Bit8fSgGZi7u0kCV8ZdcSc8wPQvPwoBrshDjTYHJHX2NuG1UTqNPGS3j9eNyLI53L7Ue
	b7gX0vP95crbW7PiNQD8KfcxzXkfsiuqmgdx3khsR8EGiEka5VLdtcLlhOgGoqqaWxQLMtC2yZ3b9
	TzZXL/fcfXTs6oQ49KnEYPYwwE6VAJEP6PbS61wjSrB8dz+6GCMltZCpViSizllQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sCIln-0006nE-IH; Wed, 29 May 2024 14:51:07 +0200
Message-ID: <5fb1d05f-1736-42dc-86dc-fdc1bddcaa0c@leemhuis.info>
Date: Wed, 29 May 2024 14:51:07 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD: Unable to initialize client recovery tracking! (-110)
To: Chuck Lever III <chuck.lever@oracle.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Jeff Layton <jlayton@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "it+linux-nfs@molgen.mpg.de" <it+linux-nfs@molgen.mpg.de>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <aaeae060-2be0-4b9f-818c-1b7d87e41a5f@molgen.mpg.de>
 <e8ab863e-18a5-4c16-b0c8-a3ab6440a9f6@molgen.mpg.de>
 <5096230634b5bab2e5094c0d52780ffe2fa75bb9.camel@kernel.org>
 <90700421-4567-4e28-ae71-8541086b46e2@leemhuis.info>
 <5360A648-8236-466C-A9D8-82F2BBE6F059@oracle.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <5360A648-8236-466C-A9D8-82F2BBE6F059@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716987070;c5569a1f;
X-HE-SMSGID: 1sCIln-0006nE-IH

On 24.05.24 18:09, Chuck Lever III wrote:
>> On May 24, 2024, at 7:16 AM, Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>> On 21.05.24 12:01, Jeff Layton wrote:
>>> On Tue, 2024-05-21 at 11:55 +0200, Paul Menzel wrote:
>>>> Am 19.04.24 um 18:50 schrieb Paul Menzel:
>>>>
>>>>> Since at least Linux 6.8-rc6, Linux logs the warning below:
>>>>>
>>>>>     NFSD: Unable to initialize client recovery tracking! (-110)
>>>>>
>>>>> I haven’t had time to bisect yet, so if you have an idea, that’d be great.
>>>>
>>>> 74fd48739d0488e39ae18b0168720f449a06690c is the first bad commit
>>>> commit 74fd48739d0488e39ae18b0168720f449a06690c
>>>> Author: Jeff Layton <jlayton@kernel.org>
>>>> Date:   Fri Oct 13 09:03:53 2023 -0400
>>>>
>>>>     nfsd: new Kconfig option for legacy client tracking
>>>>
>>>>     We've had a number of attempts at different NFSv4 client tracking
>>>>     methods over the years, but now nfsdcld has emerged as the clear winner
>>>>     since the others (recoverydir and the usermodehelper upcall) are
>>>>     problematic.
>>> [...]
>>> It sounds like you need to enable nfsdcld in your environment. The old
>>> recovery tracking methods are deprecated. The only surviving one
>>> requires the nfsdcld daemon to be running when recovery tracking is
>>> started. Alternately, you can enable this option in your kernels if you
>>> want to keep using the deprecated methods in the interim.
>>
>> Hmm. Then why didn't this new config option default to "Y" for a while
>> (say a year or two) before changing the default to off? That would have
>> prevented people like Paul from running into the problem when running
>> "olddefconfig". I think that is what Linus would have wanted in a case
>> like this, but might be totally wrong there (I CCed him, in case he
>> wants to share his opinion, but maybe he does not care much).
> 
> That's fair. I recall we believed at the time that very few people
> if anyone currently use a legacy recovery tracking mechanism, and
> the workaround, if they do, is easy.
> 
>> But I guess that's too late now, unless we want to meddle with config
>> option names. But I guess that might not be worth it after half a year
>> for something that only causes a warning (aiui).
> 
> In Paul's case, the default behavior might prevent proper NFSv4
> state recovery, which is a little more hazardous than a mere
> warning, IIUC.
> 
> To my surprise, it often takes quite some time for changes like
> this to matriculate into mainstream usage, so half a year isn't
> that long. We might want to change to a more traditional
> deprecation path (default Y with warning, wait, default N, wait,
> redact the old code).

Well, that would help anybody that already ran "make olddefconfig" with
a kernel that has 74fd48739d04, as they now have
NFSD_LEGACY_CLIENT_TRACKING unset in their .config -- at least unless we
rename that option and make it default to Y; but it would help everybody
that updates from the latest longterm kernel to a future kernel that
would contain a change like you outlined.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

