Return-Path: <linux-nfs+bounces-5014-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0539939EC8
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 12:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552CC1F22676
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 10:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D409814E2CF;
	Tue, 23 Jul 2024 10:33:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F108514D710;
	Tue, 23 Jul 2024 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721730831; cv=none; b=Vl73APFNSK3hmVnq+KbtpNRFKxG7dhR4uF11q184ML6SPWl8fvyPeuqUaPJ9A0fk2sKyFHzove7qeULn9IcC7L5P2R+Hcg05MzxHUM0qEJa3OqWQTwjcenSToikaaU1g6YLRmQ1TYB8/Eu+y+Myevx4fHQYGFjQ2SLXzUiOhUXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721730831; c=relaxed/simple;
	bh=FgsNZLyJVQujcNgg+ovIPGVLlUHk+28zuGPLkC7ZNCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNT22JQLdjzcaoMvGUmKEwVvZ772gnf7UEEusqZk4nToxt7HkjNKdO+WYm4x16Z7dgyc6R8+er3seAVRM+OgkabmAcQyB6mSgR83i3MNmfPwxmiDaE+voHLA0oq/XRPrQYn20B59xiYGiPLtkJnjj76pFc0lUJFxSAf/F+aDM8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2A6C661E5FE01;
	Tue, 23 Jul 2024 12:33:34 +0200 (CEST)
Message-ID: <02ceb39e-e4fb-4f62-ac40-7afafbd620c1@molgen.mpg.de>
Date: Tue, 23 Jul 2024 12:33:33 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to debug intermittent increasing md/inflight but no disk
 activity?
To: Roger Heflin <rogerheflin@gmail.com>
Cc: linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 it+linux-raid@molgen.mpg.de
References: <4a706b9c-5c47-4e51-87fc-9a1c012d89ba@molgen.mpg.de>
 <CAAMCDedmjyyn93V+ScRTyqd1FbW5VJmbZHGMss3iwyqxwJL3Pg@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAAMCDedmjyyn93V+ScRTyqd1FbW5VJmbZHGMss3iwyqxwJL3Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Roger,


Thank you for your reply.

Am 10.07.24 um 13:54 schrieb Roger Heflin:
> How long does it freeze this way?

It froze up to five minutes I’d say.

> The disks getting bad blocks do show up as stopping activity for 3-60
> seconds (depending on the disks internal settings).
> 
> smartctl --xall <device> | grep -iE 'sector|reall' should show the
> reallocation counters.

These are SAS disks, and none of the array members has any errors. Example:

```
@grele:~$ sudo smartctl --xall /dev/sdy
[…]
Error counter log:
            Errors Corrected by           Total   Correction 
Gigabytes    Total
                ECC          rereads/    errors   algorithm 
processed    uncorrected
            fast | delayed   rewrites  corrected  invocations   [10^9 
bytes]  errors
read:          0        0         0         0          0     655487.372 
          0
write:         0        0         0         0          0      38289.771 
          0
```

> What kind of disks does the machine have?

Seagate ST16000NM004J (16 TB, SAS)

> On my home machine a bad sector freezes it for 7 seconds (scterc
> defaults to 7).  On some work large disk big raid the hang is minutes.
>     The raw disk is set to 10 (that is what the vendor told us) and
> that 10 + having potentially a bunch of IOs against the bad sector
> shows as minutes.
> 
> I wrote a script that work uses that both times how long smartctl
> takes for each disk (the bad disk takes >5 seconds, and up to minutes)
> and also shows the reallocated count and save a copy every hour so one
> can see what disk incremented its counter in the last hour and replace
> that disk.

A colleague also wrote a Perl program diskcheck, that is regularly run 
to check all the disks. Nothing suspicious here.


Kind regards,

Paul

