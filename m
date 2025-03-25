Return-Path: <linux-nfs+bounces-10792-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B82A6F42B
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 12:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683DE1884156
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 11:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BC7BA36;
	Tue, 25 Mar 2025 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzUqLZyq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FED255E47
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902430; cv=none; b=bAnHY1dZqNY0+JK/ENRsFxL6pW/LvD42RiXndKwHikouIvwjyrTXZHyUe8ZeKIZ6cJO30x5S3vNQgrKV0F24CrmCJyQ/1T7n8iNYYiNqIZGJZoVrF3wzF5xwBcuv59pzEy4+AHwkFwH2sMDR7Bxg27B4eRuGzYNNMkGlvqEOYMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902430; c=relaxed/simple;
	bh=6vIIN4+VCCdfyN90gcmYBwcLLQynshEgacEPL5hdIoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=cRApMfFH5GOt3StLMnIUOeBSvZlDF5c4CyCKaJLPSvm2QcLJXrqeZIj+XUajoAGFWdFzL7TtZC6k4OU7dZiWe3NkWvMyb0HvYLZMJhJZXT8gYjblETTcsERhLR4ZlhUJYyPcZtssID3PoIovkU/DeGPVjqIXYnpbXTJWPtZKhUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzUqLZyq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so9837417a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 04:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742902426; x=1743507226; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0K+BJUPrie8Yo7b6ieg0NpPt6h6cua28R7eEqWdxxVA=;
        b=PzUqLZyqXVzz/fNxSO5DdbQhIJWEbBKsDngpGBgU4xwnWpY0wjWrZuminPjYCHp0n8
         nDjsuxBh22nyiV7SAv2dgXxIkJ/qIC+Dot2aEXFqestD1Elp5jq0WQJ0h2XALEYCG5Mw
         R/bnBtltSyXGOfvPvaLaEXIoW1r8ak2WLQrdmHqd2CJiNb7Q6H4i7v4DH9mEf0gBAXfH
         r+yS+Axetc7wGuzuc4e1lGbdkWF0hXtH26Emhzj5SWKqWkPQABGc9bRGAV/tKKTGABSf
         3nFbwnvTn+VFBILYH0oVuLs5Rb5jxq4tEZBw9nXhL4r2X558uwHbaSeJ3oxR8/8BwVO9
         pdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742902426; x=1743507226;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0K+BJUPrie8Yo7b6ieg0NpPt6h6cua28R7eEqWdxxVA=;
        b=Nnu6kIf7Sr0qZot6xikeV/o9OoBCLt+cghGReauy0YywBaca98JbPaipBPxwdveZ36
         /gq9tdr2vG/Dug00oX2dGVSE8k5OtHMANTb/lTby80kfp4cMRwdCNl8j5qvoiJ5Oqjz6
         DNdoe6eibVgLQe4RMPlPDQfGtpXLQBmlF0BrOITdOhagEPPN7LinL1Q5l9E4gSlM6OCv
         iAZWTn/1av6fqtnFGkulpHZm9CR40jLOGssgWl/744IVWnciNBrR//Fbw5bHIj2YYbEg
         9Qcok8AlleHR2TXu1LqvfaXgw32arOAgjXvMCpDKX2lNbueNyTH4jjLQtitETAL7aQSr
         xSdA==
X-Gm-Message-State: AOJu0YwPq8i+iJwiWHwjHCe1RmEHZs/BLmdnjr2Bz0XKkKRtofMwsJKX
	6D9HGV4WooVjWTqixgc/eWUWpOaH50Eaxf3hBc1djpvgFuShRu2bUHJy/VqE1jyZK9tX5/a+xuT
	mvCo1J6/2lCGszRKD3E3WyT9XMILbGonI
X-Gm-Gg: ASbGnctHbUbSXLnboslWDRJOXFHCF8rCmkL0uX7swubVQa0DsCTyHyoP4Xc1EJhGxz2
	NbsgbzbbJg5ygDVIN3sOh+p+09lpTYSTuFESBvAsTGnDPzDJj8Vu2SWmsH3+tDZhOi2mgx6a48h
	ENeXdS70fB+q8xuJjdqLYD0LUL5vqHpPWVvJU7ksPYRo4kYALpxvCq1oHC
X-Google-Smtp-Source: AGHT+IETd6o2u9ItEbIotq4tk4pp5clwmTpMjSb1YheQl29OdoH3PxQPYVh1sbPSsHbE+h8Hqx08vuZ4S2mOkc3OySk=
X-Received: by 2002:a05:6402:2348:b0:5e8:c092:7a6 with SMTP id
 4fb4d7f45d1cf-5ebcd4f0b51mr13889918a12.21.1742902425810; Tue, 25 Mar 2025
 04:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <319477679.6763859.1740766422175.JavaMail.zimbra@desy.de> <732824542.7754132.1741023105596.JavaMail.zimbra@desy.de>
In-Reply-To: <732824542.7754132.1741023105596.JavaMail.zimbra@desy.de>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Tue, 25 Mar 2025 12:33:00 +0100
X-Gm-Features: AQ5f1JqnbGRPIgcWOOrsz2NuVKvJ-Fwm4vvBnVzTsdDtYmv9Ab6EgBYSnd8glnA
Message-ID: <CAPJSo4Upgd8EeULZToW4O6+3O3un6di1SiRU3iE9t9h1RCxoBA@mail.gmail.com>
Subject: Re: Unexpected low pNFS IO performance with parallel workload
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Has there been any progress, or solution found?

Lionel

On Mon, 3 Mar 2025 at 18:45, Mkrtchyan, Tigran <tigran.mkrtchyan@desy.de> wrote:
>
>
>
> I was able to reproduce low throughput with the fio command. The examples below read 200GB from multiple files.
> The --offset=98% is there just to read a small portion of a file, as our files are 33GB each. In 'case 1', the data is read from a single
> file, and when it reaches EOF, it switches to the next one. In 'case 2', all files are opened in advance, and data is read round-robin through
> all files.
>
> case 1: read files sequentially
> fio --name test --opendir=/pnfs/data --rw=randread:8 --bssplit=4k/25:512k --offset=98% --io_size=200G --file_service_type=sequential
>
>
> case 2: open all files and select round-robin from which to read
> fio --name test --opendir=/pnfs/data --rw=randread:8 --bssplit=4k/25:512k --offset=98% --io_size=200G --file_service_type=roundrobin
>
> The case 1 takes a couple of minutes (2-3).
> The case 2 takes two (2) hours.
>
> Tigran.
>
>
> ----- Original Message -----
> > From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> > To: "linux-nfs" <linux-nfs@vger.kernel.org>
> > Cc: "trondmy" <trondmy@kernel.org>, "Olga Kornievskaia" <aglo@umich.edu>
> > Sent: Friday, 28 February, 2025 19:13:42
> > Subject: Unexpected low pNFS IO performance with parallel workload
>
> > Dear NFS fellows,
> >
> > During HPC workloads on we notice that Linux NFS4.2/pNFS client menonstraits
> > unexpected low performance.
> > The application opens 55 files parallel reads the data with multiple threads.
> > The server issues flexfile
> > layout with tighly coupled NFSv4.1 DSes.
> >
> > Oservations:
> >
> > - despite 1MB rsize/wsize returned by layout, client never issues reads bigger
> > that 512k (offten much smaller)
> > - client always uses slot 0 on DS, and
> > - reads happen sequentialy, i.e. only one in-flight READ requests
> > - following reads often just read the next 512k block
> > - If instead of parallel application a simple dd is called, that multiple slots
> > and 1MB READs are sent
> >
> > $ dd if=/pnfs/xxxx/00054.h5 of=/dev/null
> > 45753381+1 records in
> > 45753381+1 records out
> > 23425731171 bytes (23 GB, 22 GiB) copied, 69.702 s, 336 MB/s
> >
> >
> > The client has 80 cores on 2 sockets, 512BG of RAM and runs REHL 9.4
> >
> > $ uname -r
> > 5.14.0-427.26.1.el9_4.x86_64
> >
> > $ free -g
> >               total        used        free      shared  buff/cache   available
> > Mem:             503          84         392           0          29         419
> >
> > $ lscpu | head
> > Architecture:                       x86_64
> > CPU op-mode(s):                     32-bit, 64-bit
> > Address sizes:                      46 bits physical, 48 bits virtual
> > Byte Order:                         Little Endian
> > CPU(s):                             80
> > On-line CPU(s) list:                0-79
> > Vendor ID:                          GenuineIntel
> > BIOS Vendor ID:                     Intel(R) Corporation
> > Model name:                         Intel(R) Xeon(R) CPU E5-2698 v4 @ 2.20GHz
> > BIOS Model name:                    Intel(R) Xeon(R) CPU E5-2698 v4 @ 2.20GHz
> >
> > The client and all DSes equiped  with 10GB/s NICs.
> >
> > Any ideas where to look?
> >
> > Best regards,
> >    Tigran.



-- 
Lionel

