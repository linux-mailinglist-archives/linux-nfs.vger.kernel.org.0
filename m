Return-Path: <linux-nfs+bounces-3751-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4958C9069EF
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 12:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7E32862D4
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 10:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CE31411E1;
	Thu, 13 Jun 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qcfm2f+i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09114265F
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274413; cv=none; b=hF+OZ2okoiAJaLZoyDusnXz0cglETf+TizjJPeZsWTjyHys4yGSWIqyj1O0WE5viuhV/wXh7DXRiuBl07EoTO05NtMunknqmt658LrijiBKEHthwec6IlfUT8AMeVQUIhk69X3m7LJhbcu2LGEV3lyI0twVytJOmXKrWquf/zV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274413; c=relaxed/simple;
	bh=HmS73kzo/BSVJ2FmT15ot7+BuMipU7gDKCIHSkeMdmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cqnp3ph9To6QTmYq5wZVghtZK/mDI18hvJg0t68ca76Bi2KR7HUan4wOqDxBhpCqs6VPagD1W9cbfaxTxFwP91ilI2yxRZepSGFV8OFyB5c3tNqtgdFoQd2X+yMN/369pLl/kpkcNgeQ68//63faxTdbmYOgs/2zbnpuYfI+CJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qcfm2f+i; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7955aaf8006so64519685a.1
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 03:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718274411; x=1718879211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msMt3NoK+jnD01K6V9N2dPJ6/bT7gdjIrrO/A0HcAWw=;
        b=Qcfm2f+i0XLnzRWo0P2NLr0oLK3fBBnlZUW34u6gneoCaxZr/O1bv3F+150j6MzyMd
         o3pTRipXA/pAkvVinurp1lcJimD1L3fpgPjwgYUrgiqSazf2TFN2AkrKj0SxlgzQJnj6
         7iFc3rBI6OcRyxIkc/s5VlLgPgcviYDSevq/oFdHJjROixCBc5zmdVVl0QmA7Qxip7Al
         1FMf0XR9bZRdX71pvU/uILSRAZj5QhOBb0ArNKT7UbCs6aPaso6OYPpVh8W+AcsLHno6
         aNE0Mpw738SqMDWFOrvKRH+Cjs9+E2Y1KvhEzFU/ptEDd7rGDyi2GoRu1VV9iytrh+Um
         1uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718274411; x=1718879211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msMt3NoK+jnD01K6V9N2dPJ6/bT7gdjIrrO/A0HcAWw=;
        b=lXKqygckg51zjKgclb79BDYH3C8B9xaK1V+KmWyuJgT61LJPHGPo6vHsPIiiAsx5Uq
         K9d9zAsx8d6uestEI28tDWq+qsG8g0WAWtGhMcOZfuL2BuDRH1e6r9II785q0H3uqeHo
         X0x1rLuWhFd4xIWTxHo+0v2V4Ocx1AnbaM7fswsTNku2FcjnlrhP5Nyb6QfZe6rKAH3y
         PRqdthz+zzVz+sBu2goZ35+FrEuT0Hoff4tJRL4adNL1XwufzVM05FdseBo/q1u283y3
         rPmrchcTu4ctyF/hTd818GrKiPpaSJ0R3uRw8BIB/Qa+edJMDnjHejliydUrLEWCQjfP
         oWyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVZUdUVCNqLCIm7e1iQljGWWXALjCFdo7wwyabMg90adBaR4qqWcWA79svM2GaI3RLwNf3bE9LDDbG28z1SHosWMlZN4ER01gg
X-Gm-Message-State: AOJu0YwplDlcwoO40VuMLpw6TwAJOze9eg6SH5UBnJNfwZFQ6g2MJd8b
	aG9NwTK7scN7JhJcD1m9TXzTIkqjHloEL+m69ixct0A1kAY6iPQScMrkX4XawUAPR6hWjbd8kT8
	4m1Eis7AZTAryVLbO1B2tmbWhQPKTWQ==
X-Google-Smtp-Source: AGHT+IG3UlBsD6qugNdd0fW5Escgxaa864anM0Q6UI9HT/P9rSGRb3UCP/8r+/f/4Dy/5wQ1/JqpE76RtcycspwAgEY=
X-Received: by 2002:a05:6214:3211:b0:6b0:7f83:adad with SMTP id
 6a1803df08f44-6b1a6587bc6mr49572226d6.39.1718274410965; Thu, 13 Jun 2024
 03:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxip8tD8H691qTcA8YFkcT78_iwQXy17=mJzyv6WWUaunQ@mail.gmail.com>
 <171815759406.14261.8092450471234028375@noble.neil.brown.name> <20240612071252.GA98398@pevik>
In-Reply-To: <20240612071252.GA98398@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 13 Jun 2024 13:26:38 +0300
Message-ID: <CAOQ4uxgyHrTR_-b5tKdtuCoyoKdrVWb=-h-CbiSP2pHVHM--CQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH] NFS: add atomic_open for NFSv3 to handle O_TRUNC correctly.
To: Petr Vorel <pvorel@suse.cz>
Cc: NeilBrown <neilb@suse.de>, James Clark <james.clark@arm.com>, linux-nfs@vger.kernel.org, 
	broonie@kernel.org, Aishwarya.TCV@arm.com, ltp@lists.linux.it, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 10:12=E2=80=AFAM Petr Vorel <pvorel@suse.cz> wrote:
>
> > On Tue, 11 Jun 2024, Amir Goldstein wrote:
> > > On Tue, Jun 11, 2024 at 5:30=E2=80=AFAM NeilBrown <neilb@suse.de> wro=
te:
>
> > > > On Fri, 07 Jun 2024, James Clark wrote:
>
> > > > > Hi Neil,
>
> > > > > Now that your fix is in linux-next the statvfs01 test is passing =
again.
> > > > > However inotify02 is still failing.
>
> > > > > This is because the test expects the IN_CREATE and IN_OPEN events=
 to
> > > > > come in that order after calling creat(), but now they are revers=
ed. To
> > > > > me it seems like it could be a test issue and the test should han=
dle
> > > > > them in either order? Or maybe there should be a single inotify e=
vent
> > > > > with both flags set for the atomic open?
>
> > > > Interesting....  I don't see how any filesystem that uses ->atomic_=
open
> > > > would get these in the "right" order - and I do think IN_CREATE sho=
uld
> > > > come before IN_OPEN.
>
> > > Correct.
>
>
> > > > Does NFSv4 pass this test?
>
> > > Probably not.
>
>
> > > > IN_OPEN is generated (by fsnotify_open()) when finish_open() is cal=
led,
> > > > which must be (and is) called by all atomic_open functions.
> > > > IN_CREATE is generated (by fsnotify_create()) when open_last_lookup=
s()
> > > > detects that FMODE_CREATE was set and that happens *after* lookup_o=
pen()
> > > > is called, which calls atomic_open().
>
> > > > For filesystems that don't use atomic_open, the IN_OPEN is generate=
d by
> > > > the call to do_open() which happens *after* open_last_lookups(), no=
t
> > > > inside it.
>
> > > Correct.
>
>
> > > > So the ltp test must already fail for NFSv4, 9p ceph fuse gfs2 ntfs=
3
> > > > overlayfs smb.
>
>
> > > inotify02 does not run on all_filesystems, only on the main test fs,
> > > which is not very often one of the above.
>
> > > This is how I averted the problem in fanotify16 (which does run on
> > > all_filesystems):
>
> > > commit 9062824a70b8da74aa5b1db08710d0018b48072e
> > > Author: Amir Goldstein <amir73il@gmail.com>
> > > Date:   Tue Nov 21 12:52:47 2023 +0200
>
> > >     fanotify16: Fix test failure on FUSE
>
> > >     Split SAFE_CREAT() into explicit SAFE_MKNOD() and SAFE_OPEN(),
> > >     because with atomic open (e.g. fuse), SAFE_CREAT() generates FAN_=
OPEN
> > >     before FAN_CREATE (tested with ntfs-3g), which is inconsistent wi=
th
> > >     the order of events expected from other filesystems.
>
> > > inotify02 should be fixed similarly.
>
> > Alternately - maybe the kernel should be fixed to always get the order
> > right.
> > I have a patch.  I'll post it separately.
>
> @Amir, if later Neil's branch get merged, maybe we should use on fanotify=
16
> creat() on the old kernels (as it was in before your fix 9062824a7 ("fano=
tify16:
> Fix test failure on FUSE")), based on kernel check.
>

I am hoping that the fix could be backported to v6.9.y and then we
won't need to worry about older LTS kernels for fanotify16, because
fuse only supports FAN_CREATE since v6.8.

Thanks,
Amir.

