Return-Path: <linux-nfs+bounces-8836-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C509FDC23
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Dec 2024 20:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80452161C9F
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Dec 2024 19:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E96316F288;
	Sat, 28 Dec 2024 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehdq5wQ7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE32111
	for <linux-nfs@vger.kernel.org>; Sat, 28 Dec 2024 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735414584; cv=none; b=ePfRCJ53Jk/2zpNDqYqpzV2eAnidMkJxLd7zLDMV8c0dnrrndbVy8YwzTFwRFmrycuVI15W5T+rWFXVx8Aw84ypK/MUeXe6CnhYeA1p/lswPK5MjOhMMCtQyoQvHXgxN6NpQAvOtgAsPXT9QGelw2M4QVngYCjFgkleSsE1WtYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735414584; c=relaxed/simple;
	bh=Akx1V+q+r9EEU/tb9bWat5ygmD2BWqxQeF0TG+jTlTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDeKU5cjiennUSxaBGiEaXu8vuW9r0Kix2CxKyAHJ+AGBGpR62rRnQnr3yGeztNLlnxszoUyQxFtzKsLE9AQdhXpHpUJi/ojcI/QAs6t+q8Cx0vTC5auP6tHxsYCh7j6NZ92VLipfsOGZq1ZH2k+Hhej4t4hE0aihx/1O2L6Vm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehdq5wQ7; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so16282147a12.1
        for <linux-nfs@vger.kernel.org>; Sat, 28 Dec 2024 11:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735414580; x=1736019380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gn58RloNVo6Sep/k0zVSMNcnAsyr80kQyG14LNUeAs8=;
        b=ehdq5wQ7ORbUHo0Ih3Lu3bZpUxbXCJM0+ibHd7R5UI9owyB6gaBknsUmh50+cx6yXP
         Nvyqivi7q+cftnbecOtdaxbcaksveO+2FGgszifBuGavftharlXJdU5p5iQCB8LFgqor
         2jyAX598cgWpjotzS9ShZ8LGrzY/4Wf5DZiLW1jnah5W/OjCGlugafptjUcyK9EnnmHV
         tWdipiLvkSH4E1YpSBQCt/HIA/IjqDoIanOK9GGcl/b65T0Mv0SP9eiKb9Lb5yYMkCye
         2kWJAqwLlIBiX8CO2qzcWGiDGjpYVEij6wRm21Iawv+PGcpP6RjguwZXgLldljetND8M
         jKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735414580; x=1736019380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gn58RloNVo6Sep/k0zVSMNcnAsyr80kQyG14LNUeAs8=;
        b=ZHHUfQxaMyti6KHjYf3au59oU2GnDZ4VDkSgyJ1UBRYEo5YULxexGs97IlxRndvKi9
         FJ3mJvVWN299YgHW0GNwwtSAiH5kLR0gXIglyhS6B22Od/vyx/K/hmQtASrQUWdu05dx
         ahBJLfREfF4zaLCkemhRjKKp35gaUqM+rcv3qH7QRYxhH1OVMfXEK1XfoaCIKDXijtOp
         S/BW706OZUd4v4BUT2ZkTKISUvjREit81t9vfdZ9g3IlIAKIkw0HDJVxVpUDJi3N/ZLG
         OWDpJvVdi3R7sttt6x3S/tSfwT8QQ200ER5Dpj3xZGeLBgvHYsxnSUs86WJbgA7X/EJL
         vsIw==
X-Forwarded-Encrypted: i=1; AJvYcCVhsu9tgV+WsbqRefMu6tTekvV6BOh57m1rCasayjbNnY1Rmb2frwWkwJz87WO94Aj4dlh5amUwnRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkM/sRP8+jUgXfy12r0AxM2drgn5pYXJfQTTwjF6VYZZ5ckugg
	dIyasSyg2EYMfrU0ihcdQ752t//WBzntGJhgzbgR76CiJNUvRmOt
X-Gm-Gg: ASbGncu+ss6bu5JaE65PDmozQI3lkMZMtV1nkXi7cKlhoQzhLaYgHFTtnePCH8w6x9j
	qqcbfWmNRzV5zkdNhDkt9JPN3qr+Nrc3WHsd/4hx3edbQF0+hgM2A99x3SkIeSzuiLFWcyhl/Lr
	Hs8qrqyso4ewUkz6K3xM92R/yWobjmpA/kmGlq1kvgyN1CMLZDjE9fcSpVYWXsZUdy46TIHuvht
	peblKXRPXf2uV5EMa7d+Gtd0cU/nxf4ctZdnNbcyyKJwAr6D+uGlT3z1VCVuRu9j0q3kBi+plOm
	Ted2JxXaiHKU/D7i
X-Google-Smtp-Source: AGHT+IFhZpl+RyQS4KP0FVZKSrfvDU+9IrJ4fAb4qfXnIxTVSaAS5A6uHibE/h33p3WMddQaPR9VNw==
X-Received: by 2002:a17:907:6e8d:b0:aa6:68bc:160d with SMTP id a640c23a62f3a-aac08154dd4mr3335343266b.16.1735414580341;
        Sat, 28 Dec 2024 11:36:20 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e89537dsm1290763166b.54.2024.12.28.11.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 11:36:19 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 814D2BE2EE7; Sat, 28 Dec 2024 20:36:18 +0100 (CET)
Date: Sat, 28 Dec 2024 20:36:18 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Scott Mayhew <smayhew@redhat.com>,
	Jur van der Burg via Bugspray Bot <bugbot@kernel.org>,
	anna@kernel.org, trondmy@kernel.org, jlayton@kernel.org,
	linux-nfs@vger.kernel.org, cel@kernel.org, 1091439@bugs.debian.org,
	1091439-submitter@bugs.debian.org, 1087900@bugs.debian.org,
	1087900-submitter@bugs.debian.org
Subject: Re: kernel BUG at fs/nfsd/nfs4recover.c:534 Oops: invalid opcode:
 0000
Message-ID: <Z3BTMhIfOedhgqlk@eldamar.lan>
References: <20241209-b219580c0-d09195e1d9e8@bugzilla.kernel.org>
 <20241209-b219580c2-2def6494caed@bugzilla.kernel.org>
 <Z22DIiV98XBSfPVr@eldamar.lan>
 <7c76ca67-8552-4cfa-b579-75a33caa3ed2@oracle.com>
 <Z22r2RBlGT8PUHHb@eldamar.lan>
 <Z25LCAz9-qDVAop9@eldamar.lan>
 <9e988cfa-5a27-4139-b922-b5c416ae0c72@oracle.com>
 <Z2-V_reIDIgJ1AH7@eldamar.lan>
 <ae592779-4eb5-410e-b9bc-49165fbb643d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae592779-4eb5-410e-b9bc-49165fbb643d@oracle.com>

Hi Chuck,

On Sat, Dec 28, 2024 at 12:13:56PM -0500, Chuck Lever wrote:
> On 12/28/24 1:09 AM, Salvatore Bonaccorso wrote:
> > Hi,
> > 
> > On Fri, Dec 27, 2024 at 04:31:44PM -0500, Chuck Lever wrote:
> > > On 12/27/24 1:36 AM, Salvatore Bonaccorso wrote:
> > > > Hi,
> > > > 
> > > > On Thu, Dec 26, 2024 at 08:17:45PM +0100, Salvatore Bonaccorso wrote:
> > > > > Hi Chuck, hi all,
> > > > > 
> > > > > On Thu, Dec 26, 2024 at 11:33:01AM -0500, Chuck Lever wrote:
> > > > > > On 12/26/24 11:24 AM, Salvatore Bonaccorso wrote:
> > > > > > > Hi Jur,
> > > > > > > 
> > > > > > > On Mon, Dec 09, 2024 at 04:50:05PM +0000, Jur van der Burg via Bugspray Bot wrote:
> > > > > > > > Jur van der Burg writes via Kernel.org Bugzilla:
> > > > > > > > 
> > > > > > > > I tried kernel 6.10.1 and that one is ok. In the mean time I
> > > > > > > > upgraded nfs-utils from 2.5.1 to 2.8.1 which seems to fix the issue.
> > > > > > > > Sorry for the noise, case closed.
> > > > > > > > 
> > > > > > > > View: https://bugzilla.kernel.org/show_bug.cgi?id=219580#c2
> > > > > > > > You can reply to this message to join the discussion.
> > > > > > > 
> > > > > > > Are you sure this is solved? I got hit by this today after trying to
> > > > > > > check the report from another Debian user:
> > > > > > > 
> > > > > > > https://bugs.debian.org/1091439
> > > > > > > the earlier report was
> > > > > > > https://bugs.debian.org/1087900
> > > > > > > 
> > > > > > > Surprisingly I managed to hit this, after:
> > > > > > > 
> > > > > > > Doing a fresh Debian installation with Debian unstable, rebooting
> > > > > > > after installation. The running kernel is 6.12.6-1 (but now believe it
> > > > > > > might be hit in any sufficient earlier version):
> > > > > > > 
> > > > > > > Notably, in kernel-log I see as well
> > > > > > > 
> > > > > > > [   50.295209] RPC: Registered tcp NFSv4.1 backchannel transport module.
> > > > > > > [   52.158301] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
> > > > > > > [   52.158333] NFSD: Using legacy client tracking operations.
> > > > > > 
> > > > > > Hi Salvatore,
> > > > > > 
> > > > > > If you no longer provision nfsdcltrack in user space, then you want to
> > > > > > set CONFIG_NFSD_LEGACY_CLIENT_TRACKING to 'N' in your kernel config.
> > > > > 
> > > > > Right, while this might not be possible right now in the distribution,
> > > > > to confirm, setting CONFIG_NFSD_LEGACY_CLIENT_TRACKING would resolve
> > > > > the problem. In the distribution I think we would not yet be able to
> > > > > do a hard cut for planned next stable release.
> > > > > 
> > > > > Remember, that in Debian we only with the current stable release got
> > > > > again somehow on "track" with nfs-utils code.
> > > > > 
> > > > > > Otherwise, Scott Mayhew is the area expert (cc'd).
> > > > > 
> > > > > Thanks!
> > > > > 
> > > > > I will try to get more narrow down to the versions to see where the
> > > > > problem might be introduced, but if you already have a clue, and know
> > > > > what we might try (e.g. commit revert on top, or patch) I'm happy to
> > > > > test this as well (since now reliably able to trigger it).
> > > > 
> > > > Okay so this was maybe obvious for you already but bisecting leads to
> > > > the first bad commit beeing:
> > > > 
> > > > 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")
> > > > 
> > > > The Problem is not present in v6.7 and it is triggerable with
> > > > 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")
> > > > 
> > > > Most importantly as the switch to defaulting to y was only in later
> > > > versions, explicitly setting CONFIG_NFSD_LEGACY_CLIENT_TRACKING=y.
> > > 
> > > Hi Salvatore -
> > > 
> > > I see that Scott recently sent a fix for a similar crash to linux-nfs@ :
> > > 
> > > https://lore.kernel.org/linux-nfs/032ff3ad487ce63656f95c6cdf3db8543fb0d061.camel@kernel.org/T/#t
> > 
> > Oh right, this described escactly the problem.
> > 
> > Do you think that can be made reaching 6.13 as well (and then
> > cherry-picked to the affected stable series 6.12.y) or do we have to
> > wait for landing in 6.14 first?
> 
> In nfsd-next, this fix is tagged:
> 
> Fixes: 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")
> 
> So it will be backported to all appropriate earlier kernels as soon as
> it goes into Linus's master via the v6.14 merge window (in a couple of
> weeks).

Yes right, I was more wondering if it is eliglible for already land in
v6.13 as it is a bufix. But the issue has been open for long already,
so I guess waiting until it lands in v6.14 and then only get applied
way down as needed has to be sufficient.

Thanks all for your work,

Regards,
Salvatore

