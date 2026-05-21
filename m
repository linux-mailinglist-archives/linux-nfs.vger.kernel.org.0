Return-Path: <linux-nfs+bounces-21766-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNHSEtI2D2qSHgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21766-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 18:46:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 910315A98D7
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 18:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FBC03347074
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 15:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD22B36A34F;
	Thu, 21 May 2026 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL1NHx9I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D0E368D65
	for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378578; cv=pass; b=VrCMXK3yrkBPf6pvlGnxci8bGqe0chC0bYLcG8u050dBKzaxe4DZTW4p2UPVvyxSTmglRL1hqRm/59j572iOCTPZ9X1svAeJbU5TImGKRhsWXEiGOf/Yiw/2tTGNJOSA9U+TJ0XcFqxAe0U5tbjdbLuBq2u95OtK+REm9m0xgqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378578; c=relaxed/simple;
	bh=oTJGeDYTACLQP4b7lcnYS7MF/F8SkeHi472hQfd2CPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnoed14J5rO2QVUiQu2qylOOQv+fUAo63srtZYhmNFy0rBhCeFYd60eMd3OfWrngvV44bCub6YHyaewELgi/WZ+WLvsuWGjyljDIHTFqXttVRPAAn7Ug/DjMPAhK/ipPAy4GkU7LwwrOVF3ycgid2jRO2C1wkDEs3ULosAPeBl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lL1NHx9I; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-6314287380bso4501342137.3
        for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 08:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779378575; cv=none;
        d=google.com; s=arc-20240605;
        b=gI9/Yd/4eefhN7m73ovraRbIiVsohG9dpQdJmNLmFUKSbNF9VpKVRK7RuARcrFoBr6
         Sgj6+mKkgtZf84oL5tCWJQ77R5Ab3ZPw8Kfwxm2kxgcZR/E+WNeezzUTFYjapveiHD/1
         MEOsAeWGGzTqc2RmHNeLG4oyDF1auXqAx4f1iPUrV59F59rZR64Kcoh7gZOVZMyKnKGy
         yHFElGJLAjY24oTf/Vcl9OYxtYitBsRR8cRI+/KKRG43+2IU83LdobJP7JPUV2F6+n7h
         dornysWcqlMDl5rK83qvS/0GzO31BWkcCO0Jq7G3h3IxuehNTcCQ0OiHGAfND+nXflFv
         reNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BTiKHHtH6isAoh5+/ntoHPqjIgkFbjjbM7Qgllx7bcY=;
        fh=TPkaLw5MSHa4WlZ1rNVa2sfGwAtzODocMUa+A3WhGww=;
        b=iMhsgsYLxuHkSEM8EcaKRtNSxr+lhc30ba0KjX6t+IJ4Jneook8KgZTGTWHYlA8FGb
         +7ebkqgAvQ513d8DNTuMsdEnGszw6W62J/DwxLPQaipfsqoIboeOwjK1KvvFMGbDlZAZ
         nEXIStZPnKC0px1YUcQ+HGbGgVYpGm0FMVVW1RYlbxQ/+IciTTU9OlW2Skxo9ix8ZQfL
         dmXHXqsxh8VSv6kQOkGxY6UF2HJgWhHyU8yi0WRE2HY1kkqKOOZAKihdIqo8VfgXV5Hd
         4C26W/+5CD6U6xuv51LCFxJ4rKm1yLUWaFBgZBAr7etPGTpH84GWgDbhOThneseFgmf4
         onng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779378575; x=1779983375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTiKHHtH6isAoh5+/ntoHPqjIgkFbjjbM7Qgllx7bcY=;
        b=lL1NHx9IIKtcx4n399OipzLHTG7xOmxIhzXqniZ5H/PlWZnBHPquJmbnT+WXpW8VGl
         gD5K7nwalvqc4Jt0om+M7KYYupeksRrANY4jRunce7CrRXOXxqnPI7tkmKyFagBaXwF0
         8hbAFX6ZrBAhSIQxY+fV56hM0QhsKH/3w0jYikbW8LAIDNiMade6YzJVU1Efx90sVY3x
         4RhbDvS072Slf7nSGxLx08t5GZTGyaCT39m+CpTwAhqunSH3Y9mmA6I+HSghd2xMwMha
         PQ0O8KzBHHVN1VIStAFdCi0DV3GfXQMWyTqCZkVW0qbXHgDdJtycc4DpHzSHcGvAFvB1
         f1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779378575; x=1779983375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BTiKHHtH6isAoh5+/ntoHPqjIgkFbjjbM7Qgllx7bcY=;
        b=KByVYJfA7qthfZQj5Xg0Wz9AIsHkOTUZoXHlCU+zoySQXKT2fbhTjp69H4mqf+U6WL
         rvBQKEJlv3AvBFSZyrOgYOkGBKxq3UycQRIJwoycOYqg5z5ZoPpZe1TXm3eF/lPkzdA7
         C+814NjlwBBh8IhmfQTPXwVG30VVAVbMnGDwv8G5xlQU8skHcTYVtie4IQfeeTJNRC2Z
         o6qA8NMMJ5SS4bYn2UNJ1cU4cHkpYuENvDq6NKyJmCvbzNVRPT4mdCjHMLZecAFcvr+o
         ekXQXMkqTa188dNdDSO1bst4qbHzqE2jq5P98b5eFu2hEFqHCyIIR/TdPiKdFx4fBSgN
         fcRA==
X-Forwarded-Encrypted: i=1; AFNElJ8dpZXRafG9ZPEW35WNHXKgfk8LsYBMrh2uV0YbASVYetFKgIVVEL1pqkGLpm8zRDUg6lWWmw0DOGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysuax47KTdPKXXcpUqfRZhlevowQtvBNdYSoPnZNRrvxLpgjzA
	880LbZgJhXdtJG/pWxxdPgaSnSK1Xgbv5fp6OQhFkAxi1pRFhabS65WCz1+pgzBanW6BUXL+URb
	W6xkK4PxQmn2/ey5+2o1blsrM2xIIu6o=
X-Gm-Gg: Acq92OHWSw9sDu9n5Gm3XVDedh3o6afHf0OeV8HQGxo8rXvhccQgoI/f+xmCx2RjwCO
	VW62ONOq2+dTTDdBb644uQaRI34kGADJYvywZxNWeQwzkd1OuRl/Q2SyWwgzMQbDmAaOU7jL0A+
	qiRxHZeqsUYavo19ywlY7EcRE5DqcRYnGaeCw9r0dbo12f7FPYcAztmb+fqYsVcPpaYO66JtIZK
	0T4+KihhrlVFCanVfXunRB5e87g/3NNDxOrb3ufYyoacoUq3ZH9ER7CQsr5ebXwE6QnKCSbEZpk
	f3fgk1DgLv1lyWQWvvzLEX/C0TbpM2eE+1a1qaE+MqnNs6TvriH/AME=
X-Received: by 2002:a05:6102:1591:b0:650:a9f6:4d29 with SMTP id
 ada2fe7eead31-67390b66b29mr2592164137.13.1779378575543; Thu, 21 May 2026
 08:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260416-abgraben-seeweg-a44ce660957f@brauner> <20260521-grube-leitfaden-0e5420c9bedc@brauner>
In-Reply-To: <20260521-grube-leitfaden-0e5420c9bedc@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 21 May 2026 21:49:23 +0600
X-Gm-Features: AVHnY4JMLUcx8yOSfS2Q9vtP8tvb48vFjP_vPMN644Wd5G5CD5CLlCbq3u4DVJI
Message-ID: <CAFfO_h4Em26Hfbv-DWF+9dNS8TBuGpfWjWFBUhLr7jYCKzj3_Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21766-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,kernel.org,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,uapi-group.org:url]
X-Rspamd-Queue-Id: 910315A98D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 4:54=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Apr 16, 2026 at 03:07:12PM +0200, Christian Brauner wrote:
> > On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > > I came upon this "Ability to only open regular files" uapi feature su=
ggestion
> > > from https://uapi-group.org/kernel-features/#ability-to-only-open-reg=
ular-files
> > > and thought it would be something I could do as a first patch and get=
 to
> > > know the kernel code a bit better.
> > >
> > > The following filesystems have been tested by building and booting th=
e kernel
> > > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REG=
ULAR that
> > > regular files can be successfully opened and non-regular files (direc=
tory, fifo etc)
> > > return -EFTYPE.
> > > - btrfs
> > > - NFS (loopback)
> > > - SMB (loopback)
> > >
> > > [...]
> >
> > - I've added an explanation why OPENAT2_REGULAR is only needed for some
> >   ->atomic_open() implementers but not others. What I don't like is tha=
t
> >   we need all that custom handling in there but it's managable.
> >
> > - I dropped the topmost style conversions. They really don't belong
> >   there and if we switch to something better we should use (1 << <nr>).
> >
> > - I split the EFTYPE errno introduction into a separate patch.
>
> So I've massaged this series a bit in that I moved OPENAT2_REGULAR into
> the upper 64-bit and internally use a __O_REGULAR bit. After having
> thought about it makes a lot more sense to move the openat2() only
> features into the upper 32-bit for the uapi space. I also ported the
> selftests to the TEST* framework to fit with Aleksa's recent rework.

Thanks for fixing up!

Regards,
Dorjoy

