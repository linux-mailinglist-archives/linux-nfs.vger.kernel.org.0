Return-Path: <linux-nfs+bounces-6896-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 464F7991E46
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Oct 2024 14:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB3C1C20C22
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Oct 2024 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25540173355;
	Sun,  6 Oct 2024 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcD5qg3F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6954F95
	for <linux-nfs@vger.kernel.org>; Sun,  6 Oct 2024 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728218631; cv=none; b=NF41wBuzavtNBtvRZ324rA6weB4e6uhLkVLmnKd6BtWsp1Bil3AhCCDBO6iHAfYyv1lv/f07dJZwG+Kjhmcgs5LtZ74FziuGegP+nEAAA0T9YQjwCyx2cojVGmJWSPle+uQICQNDBCFxTgMHkEjMH5Rf+OaAQn/oJDECOJLWlE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728218631; c=relaxed/simple;
	bh=ZjsVEnVjboWCeNaXG1l5KFjt/wooW6sq91TuxoIseOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aiPy5maOF2Sm81OTFJDSKvPb65ZcrfEZ3uV184u5oaXCSjl9andyyJ40e+DWiTgAVDL0/cdzqvCIX8NqAE29IHtJ2airzJ1nFnGBnWucczAFX6PH7etCWCKBZuWUaVtw7ezAsn1+Gkr1XrBHIkuYc+fYHBhFIdfmLJBaLiZPu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bcD5qg3F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728218628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qt8fAYPSEdlXfwGUNsqWj7Clp3GFjfeAzZ56uNEWgDU=;
	b=bcD5qg3FfmMbo8pnkJgXH3Qm9Ep08+VWUpWxeOfsfbiRH4uPyfLpuJnGeQllFWAEDIpJ0O
	FVVA7p6eE778bSL9ChA4DaNFdIQQZWAR70hEUav1SgyzfXo7WNc8qE4cMNSVP5S/NocIUk
	5AjEHixbQRbUXZZAOCM38PdyBFxGD3k=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-QatqOU_LOL6kgfuMsYbbxw-1; Sun, 06 Oct 2024 08:43:46 -0400
X-MC-Unique: QatqOU_LOL6kgfuMsYbbxw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7ac9ce5844eso707412685a.0
        for <linux-nfs@vger.kernel.org>; Sun, 06 Oct 2024 05:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728218626; x=1728823426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qt8fAYPSEdlXfwGUNsqWj7Clp3GFjfeAzZ56uNEWgDU=;
        b=J+bTwuVyhzp8lh3JKXndbOzycqJhMbaPj0ApGdgM+TjuY6dW77mSzkqGK8VnZuMnU7
         aldqldvnDwkjahfPSOp/PClEW2SyuLjs/vUlQKhQ3OuaeGcjK5pJZmCcepb38q/HIawj
         b0djUYV39tgW/EFTZaztJbjyyK/N01ae/SkH+wKUGl25q1SdGVAfkoj/UCTDvc8BYAQa
         SGfwcfzx2yt1WpvQiqRZqZKjXV/riCy11V50L2Ptp5lwITtIhqapWteUCDqpheOwJ2Nl
         KfLB3j63DAB4tadFfzEIlnGBq62GmnEKR3f+NZOguPvh8pjwMd2N9uEYVMO1VJBiRWVw
         f6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXpmKc9uTVYTscrI+Y+SxU+QAEJC2bS6vGiV3YtQvjrRSRP+PBSlbjblpUtmQkwMxcnpZNcBQdZndY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGbxyST6jR6RPBE1Cw+5yqNjVbD0DMJfzKbFklaJsSbsJD2OCu
	jphjluAkWv7pNX34jv2uLYklB/GF2TuxXjV0XIwXtGtFInAZXVLY1U4nBqPUT/xzJmAROLiJVb2
	jzsg+2TutYFcNB4d3+xnk0DVjZUMdJtVlbVaWyFQEFXMmvrE36DXbonJT+A==
X-Received: by 2002:a05:620a:460e:b0:7a7:da1e:fe2d with SMTP id af79cd13be357-7ae6f43a8d4mr1502792085a.25.1728218625898;
        Sun, 06 Oct 2024 05:43:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyVMwjWdr97eMwqNDxITNXCFMBfvO4qc4NCGY9Pnsr4qgqg0pid4DwHIuvEaIrUaJScAiMpg==
X-Received: by 2002:a05:620a:460e:b0:7a7:da1e:fe2d with SMTP id af79cd13be357-7ae6f43a8d4mr1502788185a.25.1728218625482;
        Sun, 06 Oct 2024 05:43:45 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.132.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da7559ea0sm16812961cf.55.2024.10.06.05.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 05:43:43 -0700 (PDT)
Message-ID: <ef43bc4b-c445-4a0e-aaac-6cb57aca7c35@redhat.com>
Date: Sun, 6 Oct 2024 08:43:42 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: probable big in nfs-utils
To: Ian Kent <raven@themaw.net>, Charles Hedrick <hedrick@rutgers.edu>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <PH0PR14MB5493F5F79BCAE03BF2C25ED6AA722@PH0PR14MB5493.namprd14.prod.outlook.com>
 <0654ecc2-74fa-4e50-8878-bf37f17a5748@redhat.com>
 <209f2590-9bc6-4c01-a14b-87b7575a6f20@themaw.net>
 <fb80e74f-177f-4ff8-8987-8d4d313286cc@themaw.net>
 <b6744232-7d0b-4278-a71a-b9d744b8372d@themaw.net>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <b6744232-7d0b-4278-a71a-b9d744b8372d@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/4/24 10:58 PM, Ian Kent wrote:
> Here we go again ...
> 
> On 5/10/24 10:47, Ian Kent wrote:
>> Umm, let's try that again ...
>>
>> On 5/10/24 10:41, Ian Kent wrote:
>>> Hi Steve,
>>>
>>> On 5/10/24 03:54, Steve Dickson wrote:
>>>> Hello,
>>>>
>>>> On 10/4/24 2:14 PM, Charles Hedrick wrote:
>>>>> While looking into a problem that turns out to be somewhere else, I 
>>>>> noticed that in gssd_proc.c , getpwuid is used. The context is 
>>>>> threaded, and I verified with strace that the thread is sharing 
>>>>> memory with other threads. I believe this should be changed to 
>>>>> getpwuid_r. Similarly the following call to getpwnam.
>>>>>
>>>>> Is this the right place for reports on nfs-utils?
>>>> Yes... but I'm not a fan of change code, that been around
>>>> for a while, without fixing a problem... What problem does changing
>>>> getpwuid to getpwuid_r fix?
>>>>
>>>> Patches are always welcome!
>>>>
>>>> steved.
>>>>
>>>>
>>>
>>> Yeah, getpwuid(3) and getpwnam() aren't thread safe and presumably 
>>> gssd is a service so it
>>>
>>> could have multiple concurrent callers.
>>>
>>>
> 
> [PATCH} nfs-utils: use getpwuid_r() and getpwnam_r() in gssd
> 
> 
> gssd uses getpwuid(3) and getpwnam(3) in a pthreads context but
> these functions are not thread safe.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> 
> diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
> index 2ad84c59..2a376b8f 100644
> --- a/utils/gssd/gssd_proc.c
> +++ b/utils/gssd/gssd_proc.c
> @@ -489,7 +489,10 @@ success:
>   static int
>   change_identity(uid_t uid)
>   {
> -       struct passwd   *pw;
> +       struct passwd  pw;
> +       struct passwd *ppw;
> +       char *pw_tmp;
> +       long tmplen;
>          int res;
> 
>          /* drop list of supplimentary groups first */
> @@ -502,15 +505,25 @@ change_identity(uid_t uid)
>                  return errno;
>          }
> 
> +       tmplen = sysconf(_SC_GETPW_R_SIZE_MAX);
> +       if (tmplen < 0)
> +               bufsize = 16384;
> +
> +       pw_tmp = malloc(tmplen);
> +       if (!pw_tmp) {
> +               printerr(0, "WARNING: unable to allocate passwd buffer\n");
> +               return errno ? errno : ENOMEM;
> +       }
> +
>          /* try to get pwent for user */
> -       pw = getpwuid(uid);
> -       if (!pw) {
> +       res = getpwuid_r(uid, &pw, pw_tmp, tmplen, &ppw);
> +       if (!ppw) {
>                  /* if that doesn't work, try to get one for "nobody" */
> -               errno = 0;
> -               pw = getpwnam("nobody");
> -               if (!pw) {
> +               res = getpwnam_r("nobody", &pw, pw_tmp, tmplen, &ppw);
> +               if (!ppw) {
>                          printerr(0, "WARNING: unable to determine gid 
> for uid %u\n", uid);
> -                       return errno ? errno : ENOENT;
> +                       free(pw_tmp);
> +                       return res ? res : ENOENT;
>                  }
>          }
> 
> @@ -521,12 +534,13 @@ change_identity(uid_t uid)
>           * other threads. To bypass this, we have to call syscall() 
> directly.
>           */
>   #ifdef __NR_setresgid32
> -       res = syscall(SYS_setresgid32, pw->pw_gid, pw->pw_gid, pw->pw_gid);
> +       res = syscall(SYS_setresgid32, pw.pw_gid, pw.pw_gid, pw.pw_gid);
>   #else
> -       res = syscall(SYS_setresgid, pw->pw_gid, pw->pw_gid, pw->pw_gid);
> +       res = syscall(SYS_setresgid, pw.pw_gid, pw.pw_gid, pw.pw_gid);
>   #endif
> +       free(pw_tmp);
>          if (res != 0) {
> -               printerr(0, "WARNING: failed to set gid to %u!\n", pw- 
>  >pw_gid);
> +               printerr(0, "WARNING: failed to set gid to %u!\n", 
> pw.pw_gid);
>                  return errno;
>          }
> 
> 
checking file utils/gssd/gssd_proc.c
Hunk #1 FAILED at 489.
Hunk #2 FAILED at 502.
Hunk #3 FAILED at 521.
3 out of 3 hunks FAILED

What branch are you applying this patch to?
Maybe it is me copying the patch over...

Try git format-patch that seems to work.

steved.


