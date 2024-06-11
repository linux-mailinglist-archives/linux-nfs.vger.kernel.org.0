Return-Path: <linux-nfs+bounces-3645-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32D19032EE
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 08:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772B5284DD8
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 06:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7786F17279E;
	Tue, 11 Jun 2024 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMbupYo2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3E172799
	for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2024 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088302; cv=none; b=K2oq+UUvdjkKvzBxTzc6MfXLI5BFII7mW7kB/2VeugkOMfLW7aaNE8uuqDAiYfFWwxfYl3Q9xA0J+picZbFdgyoVdZTOMONS4uWgY7lFlgZYimVCWFAZ0qs2PzAJSJCHUkTIGkm/I9fZ+/LPmbpaNcV37hV8T8f2aK/S6HycNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088302; c=relaxed/simple;
	bh=aSoCy/MYWs+m2IQDee7JnNcEhFQNEeXt+Zs12PqGiHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OF1ZI5D8Dj/76hBjeEMIEp6w6M1BlU1TEGLyN8YWcR7hC57ENh2o3KYimnlptZtzW7EEpHoEnl5/58jbqsRPGFTGB0ZYHO0DQ20fYTHCzuS2HBNh32Iw/UbosnHseFrzCEwMRSbZOkTR4N8KEHwDyb048zMwcq4int+nHmnewUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMbupYo2; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7955f3d4516so175600085a.1
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 23:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718088300; x=1718693100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ibwqh6e/GoRugzf5zBN3rzGPL1kig847TWzldURPLtM=;
        b=XMbupYo2dR0bTvRc1qp4GCAiyP022IZLxFTpaWJuvp5azCCPWXDNji9wsQPQBb/7zP
         xmDA8+d5MhoIEiSS94OFPlaY+pnc/5Fd8HQKhZ0JU6q2E4j67JlodarmdTWLO3k6ENhi
         TKbZ5noA+guC8ViLqpWzOJQxaDCYLnJB98OT72GvjWoBCdlvO3q1539/kHIfoFBMZIoW
         xUiPUF9Shgpqkmg6B8MU//RvRzWjvm6h0Fm0GYesrPed9tgGQw2yxfmDfl4p3J0/+ZYF
         U4pIi36FdGNU/rR3Ztk9TFRS8+eBRz6Eptg9K+dJsh7K1EL9GJ/8NzCHNhzrcmeMsLmU
         ar5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718088300; x=1718693100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ibwqh6e/GoRugzf5zBN3rzGPL1kig847TWzldURPLtM=;
        b=fJnvZ1Bz62R1PyY6HYd5Idl4I7n7jYXRmmCxG6xydYUqvOeuLWzSBBi5/GWFas1Scl
         XYeeQQeOejPidPdyYUH+eNeqhYQjTrcVOgXIxLyss7pljKheqSqRi6uw3+bgkCBI2exs
         B7x+MRR+pitOsOZ1GU33iTwzD/W7VM+4VHpIvsK6XVOULDYQwIFSh/giBzzxfJTx2oRT
         ZonXmxXLCTTFSQRIjeo6SfC3w3AeZvzpwICqqgMAFATMiMKCsS0Jj8VE7iLFkleBmCqS
         BFEK1P29TbLYmkbJp55aisJMyGFIfcrRM1mdwEK/xERoyaccv5oHVHu9MKBQTQ1GdIcG
         QpBw==
X-Forwarded-Encrypted: i=1; AJvYcCX3I6TQBoexDKij7mH3vDIKK7uSGHW32EnJ747LQ5TptVoOlaydx4YHML8FZPXGeZ+lsUkLd0aanCUgVhalOwLHA6EpCf4Dtuua
X-Gm-Message-State: AOJu0YwAmVa6uDSNDr2rvr8XzfwdMcY1snl9RPGmcYzV4edHtcEeGXbf
	U1ELZ2Wyd7kuPqjdfjzg2a4ZSz944MxrvDt8DEfJOCAqxVmyB1A0RHp+/M8U5/NDC7ZY3NC5nxE
	KsfBKO8J6QsDek/ZwtRcb7wi6Uso=
X-Google-Smtp-Source: AGHT+IEfp3dy3AaWljYOEwEi/cZ6ahQhL57bZI6bGcJEEGULpwveVDal8dxKJoK6xMk0/9lPZHZvNAJtSsBa6nT/NvM=
X-Received: by 2002:a05:620a:4094:b0:796:5fd7:5219 with SMTP id
 af79cd13be357-797c2d9fffcmr274353385a.20.1718088299568; Mon, 10 Jun 2024
 23:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01c3bf2e-eb1f-4b7f-a54f-d2a05dd3d8c8@arm.com> <171807298283.14261.13687949173694068461@noble.neil.brown.name>
In-Reply-To: <171807298283.14261.13687949173694068461@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Jun 2024 09:44:48 +0300
Message-ID: <CAOQ4uxip8tD8H691qTcA8YFkcT78_iwQXy17=mJzyv6WWUaunQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH] NFS: add atomic_open for NFSv3 to handle O_TRUNC correctly.
To: NeilBrown <neilb@suse.de>
Cc: James Clark <james.clark@arm.com>, linux-nfs@vger.kernel.org, broonie@kernel.org, 
	Aishwarya.TCV@arm.com, ltp@lists.linux.it, Jan Kara <jack@suse.cz>, 
	Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 5:30=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
>
> On Fri, 07 Jun 2024, James Clark wrote:
> >
> > Hi Neil,
> >
> > Now that your fix is in linux-next the statvfs01 test is passing again.
> > However inotify02 is still failing.
> >
> > This is because the test expects the IN_CREATE and IN_OPEN events to
> > come in that order after calling creat(), but now they are reversed. To
> > me it seems like it could be a test issue and the test should handle
> > them in either order? Or maybe there should be a single inotify event
> > with both flags set for the atomic open?
>
> Interesting....  I don't see how any filesystem that uses ->atomic_open
> would get these in the "right" order - and I do think IN_CREATE should
> come before IN_OPEN.

Correct.

>
> Does NFSv4 pass this test?

Probably not.

>
> IN_OPEN is generated (by fsnotify_open()) when finish_open() is called,
> which must be (and is) called by all atomic_open functions.
> IN_CREATE is generated (by fsnotify_create()) when open_last_lookups()
> detects that FMODE_CREATE was set and that happens *after* lookup_open()
> is called, which calls atomic_open().
>
> For filesystems that don't use atomic_open, the IN_OPEN is generated by
> the call to do_open() which happens *after* open_last_lookups(), not
> inside it.

Correct.

>
> So the ltp test must already fail for NFSv4, 9p ceph fuse gfs2 ntfs3
> overlayfs smb.
>

inotify02 does not run on all_filesystems, only on the main test fs,
which is not very often one of the above.

This is how I averted the problem in fanotify16 (which does run on
all_filesystems):

commit 9062824a70b8da74aa5b1db08710d0018b48072e
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Tue Nov 21 12:52:47 2023 +0200

    fanotify16: Fix test failure on FUSE

    Split SAFE_CREAT() into explicit SAFE_MKNOD() and SAFE_OPEN(),
    because with atomic open (e.g. fuse), SAFE_CREAT() generates FAN_OPEN
    before FAN_CREATE (tested with ntfs-3g), which is inconsistent with
    the order of events expected from other filesystems.

inotify02 should be fixed similarly.

I did not find any other inotify test that watches IN_CREATE.
I did not find any other fanotify test that watches both FAN_CREATE
and FAN_OPEN.

Thanks,
Amir.

