Return-Path: <linux-nfs+bounces-4766-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 373F092D113
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 13:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA0A28423D
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 11:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B583190485;
	Wed, 10 Jul 2024 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW61bM1z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFED18F2FB;
	Wed, 10 Jul 2024 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612501; cv=none; b=KbmUcwElUPTcC5hhYZYaiZ19sS9tjNX81jTnkqHyBHayrTOX6A9/41obO3IG/jYtWR17hVtXj3Lv+HYGwTtpCFHV+AYaCNjXXclBSns/XpQK1SrTx8YyKnierYWwlGlqv0toea8zVqjhjaNZ5hpNOSdweGrNqs8ex4oOojET42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612501; c=relaxed/simple;
	bh=QTqY3jKzEFQABUg6Rg7dCClmVbWmkm8U/ejMecki0z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfaJWoLm4c05KPe3xfcpaFJaCZ2oz1Aq4ThUL4yKbHxS2r9+8xxLVey8rIavNf9uBJAIEYHnvOEY/mfH+GOfJI5yCdCFNgi7TgV5LDl4thCOt3tvEf8jSDY+UILWNIIyg9mKe3KCxy0sDNgn5S38qAMq7MMCCi2CG8rxiCoWbJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW61bM1z; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7fa0b95a940so147258639f.0;
        Wed, 10 Jul 2024 04:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720612499; x=1721217299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WRdbKIeFMJ3c39LPKCgR6sVh4egOo8rm7sIYeQH0Nc=;
        b=LW61bM1zBByxxJ0nhoK9xiBoFkdxM4+dxeoKs0AuGXtU1NcE2InRF5QuYj/O8ljkFb
         j+2k8rgsjDVAlxeg8zOlfMLJ8dqrqfRrbgyFdvbssELd3bLlUpY3mTo0GMLEIB30SA2u
         VUpcd+3ZXey+ExnpVWtbWGjEmkCmY/CaMkIxj9qgyK5e9K/lL1kSkjDsh8c9Ac5XWyFx
         ct1s9OHX0tmkCF+C/bXoq15PCxRG5w6AZMOZmcdSV68E0vpPXWNh7gmXdfN+M/J7yumB
         M5GqM7yDrFdMsi4dOAbg2e8/W3P11AcvUfFpX2Cd3nRCZw2qRtODvbWKh3Tq5HT1X7yk
         2uyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720612499; x=1721217299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WRdbKIeFMJ3c39LPKCgR6sVh4egOo8rm7sIYeQH0Nc=;
        b=eISZKEZLEHEj05vOtwJyUgEemWIpCaiZh35NRLKIUWFQWEXz0uV8EWWqLtejg+Zz60
         ThyKVdqtxJyHafzedo9gauSk9B6aXoMjEkivAVaiXzyrOKq2Jmde02XftKTUyYfdQKQr
         skYWBWr3VTJ94S9SQwVMNFdF9YLgNh8WClPGZTw+goX6zqIBjXAteMQOEJQiKwhB3B78
         BLtnjM2SPU1lo+sHWHixPJMDdUQq96TjTb8J05pP+mAytqnzFPbGsDojCXbzb/M/Zgaz
         8AYRbK/Ui8F1wPo/WQGtSRb4Cn8MaXfpbdpH9oPaMS517cClv6QfHZ5cPI7oInRBgJ1U
         ww5w==
X-Forwarded-Encrypted: i=1; AJvYcCUq5l+LoBBaztLkPcR93ihOuBxENlLXAZukCHWdkL22MkaG9Ff9ZU8d4vHZ3ME8qGivSot7LiMMp1CPOCPUsYwv/Wr8DETGU/KzT+iunbXXAN+WsEYwaGSIWrr9jcVpAmLqgkLJN/rfWsf31edz4klEh6zyQglf96lBt4ORP6D4wes=
X-Gm-Message-State: AOJu0Yykh9upwNw6UYuoLa66/4aGczH/3YFEomkFs0wL41LJX0XxAhMF
	B5j3A0zwwQii89JmX3Ye7TvGwlruuhjlvVqN60iG9W4WM0ULMlYWnEM/GABVXRuP9M60OLXMIis
	wmKHhIr2o0nXXE1ZNbm99O2T700tioQ==
X-Google-Smtp-Source: AGHT+IGPmou7oCvakWbL/2tdECv9nZzd+Xsk6oGIin1oKTCJrHB9ohByM3cQdz6hGQisMa08T/GmXcCgnLV5P83dawA=
X-Received: by 2002:a05:6602:42:b0:7f6:85e8:3ced with SMTP id
 ca18e2360f4ac-7fffe62b752mr491688039f.2.1720612498538; Wed, 10 Jul 2024
 04:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4a706b9c-5c47-4e51-87fc-9a1c012d89ba@molgen.mpg.de>
In-Reply-To: <4a706b9c-5c47-4e51-87fc-9a1c012d89ba@molgen.mpg.de>
From: Roger Heflin <rogerheflin@gmail.com>
Date: Wed, 10 Jul 2024 06:54:47 -0500
Message-ID: <CAAMCDedmjyyn93V+ScRTyqd1FbW5VJmbZHGMss3iwyqxwJL3Pg@mail.gmail.com>
Subject: Re: How to debug intermittent increasing md/inflight but no disk activity?
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-xfs@vger.kernel.org, 
	it+linux-raid@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

How long does it freeze this way?

The disks getting bad blocks do show up as stopping activity for 3-60
seconds (depending on the disks internal settings).

smartctl --xall <device> | grep -iE 'sector|reall' should show the
reallocation counters.

What kind of disks does the machine have?

On my home machine a bad sector freezes it for 7 seconds (scterc
defaults to 7).  On some work large disk big raid the hang is minutes.
   The raw disk is set to 10 (that is what the vendor told us) and
that 10 + having potentially a bunch of IOs against the bad sector
shows as minutes.

I wrote a script that work uses that both times how long smartctl
takes for each disk (the bad disk takes >5 seconds, and up to minutes)
and also shows the reallocated count and save a copy every hour so one
can see what disk incremented its counter in the last hour and replace
that disk.

On Wed, Jul 10, 2024 at 6:46=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Linux folks,
>
>
> Exporting directories over NFS on a Dell PowerEdge R420 with Linux
> 5.15.86, users noticed intermittent hangs. For example,
>
>      df /project/something # on an NFS client
>
> on a different system timed out.
>
>      @grele:~$ more /proc/mdstat
>      Personalities : [linear] [raid0] [raid1] [raid6] [raid5] [raid4]
> [multipath]
>      md3 : active raid6 sdr[0] sdp[11] sdx[10] sdt[9] sdo[8] sdw[7]
> sds[6] sdm[5] sdu[4] sdq[3] sdn[2] sdv[1]
>            156257474560 blocks super 1.2 level 6, 1024k chunk, algorithm
> 2 [12/12] [UUUUUUUUUUUU]
>            bitmap: 0/117 pages [0KB], 65536KB chunk
>
>      md2 : active raid6 sdap[0] sdan[11] sdav[10] sdar[12] sdam[8]
> sdau[7] sdaq[6] sdak[5] sdas[4] sdao[3] sdal[2] sdat[1]
>            156257474560 blocks super 1.2 level 6, 1024k chunk, algorithm
> 2 [12/12] [UUUUUUUUUUUU]
>            bitmap: 0/117 pages [0KB], 65536KB chunk
>
>      md1 : active raid6 sdb[0] sdl[11] sdh[10] sdd[9] sdk[8] sdg[7]
> sdc[6] sdi[5] sde[4] sda[3] sdj[2] sdf[1]
>            156257474560 blocks super 1.2 level 6, 1024k chunk, algorithm
> 2 [12/12] [UUUUUUUUUUUU]
>            bitmap: 2/117 pages [8KB], 65536KB chunk
>
>      md0 : active raid6 sdaj[0] sdz[11] sdad[10] sdah[9] sdy[8] sdac[7]
> sdag[6] sdaa[5] sdae[4] sdai[3] sdab[2] sdaf[1]
>            156257474560 blocks super 1.2 level 6, 1024k chunk, algorithm
> 2 [12/12] [UUUUUUUUUUUU]
>            bitmap: 7/117 pages [28KB], 65536KB chunk
>
>      unused devices: <none>
>
> In that time, we noticed all 64 NFSD processes being in uninterruptible
> sleep and the I/O requests currently in process increasing for the RAID6
> device *md0*
>
>      /sys/devices/virtual/block/md0/inflight : 10 921
>
> but with no disk activity according to iostat. There was only =E2=80=9Cli=
ttle
> NFS activity=E2=80=9D going on as far as we saw. This alternated for arou=
nd half
> an our, and then we decreased the NFS processes from 64 to 8. After a
> while the problem settled, meaning the I/O requests went down, so it
> might be related to the access pattern, but we=E2=80=99d be curious to fi=
gure
> out exactly what is going on.
>
> We captured some more data from sysfs [1].
>
> Of course it=E2=80=99s not reproducible, but any insight how to debug thi=
s next
> time is much welcomed.
>
>
> Kind regards,
>
> Paul
>
>
> [1]: https://owww.molgen.mpg.de/~pmenzel/grele.2.txt
>

