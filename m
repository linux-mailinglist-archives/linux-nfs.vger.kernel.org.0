Return-Path: <linux-nfs+bounces-6058-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A775D9665E1
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 17:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00DD5B25C05
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09843192D77;
	Fri, 30 Aug 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Afx1EZ0F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA6A1C687
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032427; cv=none; b=cFF0FKTjgD41Q+5COntA33E3Gatx2CvId/zMrePBPY4QjlCKhaKHty90UEV1ZYRlnXnmYFQDHBHerzCfPLryjrLtyNQ7A8TZRlYsNQqKk1aARwTfK0cRCYWkpJzULN6h1cwQcJjeix0bHM5l6bcIbMGUxFHttbmPwCQ58N+NI6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032427; c=relaxed/simple;
	bh=fJl1t/jPHE0eMDQysiQCxHtm5Nma5U0b+a3EVEKAEE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PRwdncXFcTCfdxW5zMvacCmCzKhElop/CC6oFxl6Vb/eyJP1Larg/13MI1GwHIOQUEW74+npjv8/xgku7tQ04P62eAn6j33WLsd5slzdLBUI4aGavXY+iMwQ4A9+lJ86rPqajPcyfUl7Kpzo4IHKtXKYSPvG3OugieA7pFZJw/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Afx1EZ0F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725032424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+fHUkea/f+1l3RqfNpHUhq19dOQeT5EnmcxgTY2ceQY=;
	b=Afx1EZ0FD4JWUju5ZphVv5xiPx+Ali98FcoHGMrTD+v1aw9YO1g9U2Cu9jUoSCSUc5K0Ur
	CuKTcqlDvRYXkFg5epfskwLhdOcjl8R1nNibQdmRQZlYEKElYnDtgvbNWSGVsfEhxC4+Bz
	iaqlqIhLArJryd/yROltAds32vy+FFM=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-CEIhV6SlPg2DjppNSfX2KQ-1; Fri, 30 Aug 2024 11:40:23 -0400
X-MC-Unique: CEIhV6SlPg2DjppNSfX2KQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3df160a723eso534963b6e.2
        for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 08:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032421; x=1725637221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fHUkea/f+1l3RqfNpHUhq19dOQeT5EnmcxgTY2ceQY=;
        b=moOZzZ7gGd0hQoYrteSAhc3r+3eKLujBa5nBfXOE5bYSlVkwRgzYgH30a6GTNU0NXj
         rc129yhrgBo5NqD+4BTPoxvS0+qF9TPOtRu3kOweuKry83FQdNO3GuBRvEUQJneHg9m0
         iH1fMvRz/ZxWZOHVfoIAfXGePuVUez8Q+x0SZy0j/lkiHCKSu1gE31Cxb1rA4iue7UdO
         ZjdGoWCpu6Dbvr0HoQDitDj39bHMolPU5u+N6OoPMhyO8p3As7CYCn9CO5lFdJIrc0I0
         5Eq06/FiMfYXwfhSamI2mI4CVm83FUZuN9nJ0QleVkhHdhfWgN0Qg5GTdkqVB3uTfgYv
         MWzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeUPfvPU1+3jiErEGuOu7QX3syvqeW3EZQGRP1VMHNLcet8Lv8xj45sZfI3fwnNjd9LaH10zFabII=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxb4puvpVmosSy5Wi/vHbLo5I++4CDLkqReHF1IobrOhlsqjwl
	rucRYBi3jisUcnRq8m4beocpaRLboT7HmnobzZk4ahPtJCIgT8sPfOmzYPYqoxHboEu2X81SS9W
	fKCfDL7SkuylL98+/YixRy9T9zizgPLkLDSW9e/slLqkqsGGfUPwBkug+W74kRpH3RA==
X-Received: by 2002:a05:6808:2214:b0:3de:223a:89ad with SMTP id 5614622812f47-3df05e54b59mr6648361b6e.29.1725032421354;
        Fri, 30 Aug 2024 08:40:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMU+/5oqxrkmX9b4x0ICuDlVb7yKfeJeHu3xVeVSLSsmrh4tC30kixs8nVB1PbUWlxP2PPOQ==
X-Received: by 2002:a05:6808:2214:b0:3de:223a:89ad with SMTP id 5614622812f47-3df05e54b59mr6648335b6e.29.1725032420938;
        Fri, 30 Aug 2024 08:40:20 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.250.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c8270asm14810321cf.10.2024.08.30.08.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 08:40:20 -0700 (PDT)
Message-ID: <ab08bb95-7326-4570-b10d-12534be6488b@redhat.com>
Date: Fri, 30 Aug 2024 11:40:18 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH rpcbind 4/4] systemd/rpcbind.service.in: Want/After
 systemd-tmpfiles-setup
To: Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net, Josue Ortega <josue@debian.org>,
 NeilBrown <neilb@suse.de>, Thomas Blume <Thomas.Blume@suse.com>,
 Yann Leprince <yann.leprince@ylep.fr>,
 Steve Langasek <steve.langasek@canonical.com>
References: <20240823002322.1203466-1-pvorel@suse.cz>
 <20240823002322.1203466-5-pvorel@suse.cz> <20240823010143.GA1206597@pevik>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240823010143.GA1206597@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey!

My apologies for taking so long to address these patches.

On 8/22/24 9:01 PM, Petr Vorel wrote:
> Hi Steve,
> 
>> Add Want/After systemd-tmpfiles-setup.service. This is taken from Fedora
>> rpcbind-0.2.4-5.fc25 patch [1] which tried to handle bug #1401561 [2]
>> where /var/run/rpcbind.lock cannot be created due missing /var/run/
>> directory. But the suggestion to add RequiresMountFor=... was
>> implemented in ee569be ("Fix boot dependency in systemd service file").
> 
>> But even with RequiresMountsFor=/run/rpcbind in rpcbind.service and
>> /run/rpcbind.lock there is error on openSUSE Tumbleweed with rpcbind
>> 1.2.6:
> 
>> rpcbind.service: Failed at step NAMESPACE spawning /usr/sbin/rpcbind: Read-only file system
> 
>> Adding systemd-tmpfiles-setup.service fixes it.
> 
>> NOTE: Debian uses for this purpose remote-fs-pre.target (also works, but
>> systemd-tmpfiles-setup.service looks to me more specific).
>> openSUSE uses only After=sysinit.target as a result of #1117217 [3]
>> (also works).
> 
> Reading RH #1117217 once more I wonder if old Fedora patch [4], which places
> rpcbind.lock into /var/run/rpcbind/ would be a better solution:
> 
> configure.ac
> -  --with-statedir=ARG     use ARG as state dir [default=/var/run/rpcbind]
> +  --with-statedir=ARG     use ARG as state dir [default=/run/rpcbind]
> ...
> -  with_statedir=/var/run/rpcbind
> +  with_statedir=/run/rpcbind
> 
> src/rpcbind.c
> -#define RPCBINDDLOCK "/var/run/rpcbind.lock"
> +#define RPCBINDDLOCK RPCBIND_STATEDIR "/rpcbind.lock"
> 
> But I suppose other out-of-tree patch [5] is not a dependency for it, right?
I don't like out-of-tree patch but sometimes they are necessary
since I didn't what to force other distros to adapt what
I made Fedora use.

> 
> Debian [6] and openSUSE [7] use more simpler version to move to /run. Maybe time
> to upstream Fedora patch and distros will adopt it?
It is time! :-) I'm all for distros to consolidate into one code
base... it is much easier to find bugs and support. IMHO.

Please send patches [6] and [7] in the correct patch form and
I will commit them and mostly like create another release.

Thank you.. for point these differences out!!

steved.

> 
> Kind regards,
> Petr
> 
>> [1] https://src.fedoraproject.org/rpms/rpcbind/blob/rawhide/f/rpcbind-0.2.4-systemd-service.patch
>> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1401561
>> [3] https://bugzilla.suse.com/show_bug.cgi?id=1117217
> 
> [4] https://src.fedoraproject.org/rpms/rpcbind/blob/f41/f/rpcbind-0.2.4-runstatdir.patch
> [5] https://src.fedoraproject.org/rpms/rpcbind/blob/rawhide/f/rpcbind-0.2.4-systemd-rundir.patch
> [6] https://salsa.debian.org/debian/rpcbind/-/blob/master/debian/patches/run-migration?ref_type=heads
> [7] https://build.opensuse.org/projects/openSUSE:Factory/packages/rpcbind/files/0001-change-lockingdir-to-run.patch?expand=1
> 
>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>> ---
>>   systemd/rpcbind.service.in | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
>> diff --git a/systemd/rpcbind.service.in b/systemd/rpcbind.service.in
>> index 272e55a..771b944 100644
>> --- a/systemd/rpcbind.service.in
>> +++ b/systemd/rpcbind.service.in
>> @@ -7,7 +7,8 @@ RequiresMountsFor=@statedir@
>>   # Make sure we use the IP addresses listed for
>>   # rpcbind.socket, no matter how this unit is started.
>>   Requires=rpcbind.socket
>> -Wants=rpcbind.target
>> +Wants=rpcbind.target systemd-tmpfiles-setup.service
>> +After=systemd-tmpfiles-setup.service
> 
>>   [Service]
>>   ProtectSystem=full
> 


