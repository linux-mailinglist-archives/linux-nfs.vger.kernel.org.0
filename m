Return-Path: <linux-nfs+bounces-8311-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F5A9E0CF3
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 21:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683A9160508
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 20:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C8A1DED7D;
	Mon,  2 Dec 2024 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7mBA3en"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AEF1DED76
	for <linux-nfs@vger.kernel.org>; Mon,  2 Dec 2024 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733170944; cv=none; b=R3A4cHvslXEEw06aYfBgLF9Dd0yqPPbsuwLIdItsPYqHirrsJEciUIfD9DosjX9PRUuhimFRAdwvDwPgU1U+m6ADliEZyOv+0DgZf/vBou0rJr/WmCQqRkyo7m8qyrRO1g9ipGeTZs2gr1ZjR/RkJ6rnprWc1PQs2BZwq9wT0i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733170944; c=relaxed/simple;
	bh=ce1TgnYWN1Tz+3Q5s5WTve387JDmyLD7luE875Pxwvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSBO/YQGJXtfayISAktEiVdBGV4qGXgyX2Ic31c7Bsq9mcvyb8XnwROXR9Z+kUsu2Or5FSQ/SB8QjdySmjnxwHO1Wnd9dc7wBDaZwY8R6VQMnUZfGQ/t9kABuYwdi8Skw+epmzg/quVj86WoPFyf1lcenmU4jQdwyqPHDcHFuKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7mBA3en; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffc86948dcso47844071fa.2
        for <linux-nfs@vger.kernel.org>; Mon, 02 Dec 2024 12:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733170940; x=1733775740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCSd6dWwicugJ2qnaotoSiXU4KFArrv8yNPHSe4DS60=;
        b=j7mBA3enwgHY6NKRCpcxPjI9utIfzHTUytrPYHSm701975y9NV/4dpsO35cIurJtKG
         SVj4IOV3GNQUnz3LgjHe86k3FJSqC2wCEEgbJe3Mj5mUsRUTKO7MZZw6aSO4OpPwbVJg
         6w1BQFbjMWM7KLDhI9x6ntByzgU/iNpWsPf3FE2kxzRFTh6mZ1qmIQg+O0C2waAu+vBz
         5CGs2oSjRdpoKoO0k1Zp4OK9VuJrKs3m56QPUIto4GYgwG+IENdivC8xcGK8Ye1km3Gv
         rRCGg8QO8wL7kPTkXy8Wk93k3om98ODAy6SXiqB114CFWXfjb7uNU0Yuo5iVEjZH+YSB
         Q0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733170940; x=1733775740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCSd6dWwicugJ2qnaotoSiXU4KFArrv8yNPHSe4DS60=;
        b=KH9YJCp0NJIKgv+WK2eIRVUfsBqabfY/BuETj5eUdJ3F9n6Id0oHRzOM1Xvh8Gtipa
         79oiedyNEodv6xu5d7A95k/ufbozgjDeixzNKOo9zWPaB5kgks6/S9CHlgut7PFKc/+n
         fa193E2qIDqx/rUnmRg6FfR7nUSfkIoUd3q810ERkKgiwyI0RuQO1xLW5c0ERtOF8+JX
         ZuEF6buWv52dlHvTx/ZsJX3DYcu+elMb+YJ1MGuhLKbfQzTlO4/2eyc2ht5/S8aBYAdD
         TDV9isWTR8MobR7cf6xjRkkSa/bEieTKZx3QbQyfUQsLvIuHO9VvnseANODBgs2UYNIP
         lGpg==
X-Forwarded-Encrypted: i=1; AJvYcCX49eXVnRNAh/7KrZuNuDDGAUDxRHwuV/WKWXe6gOo5AAbujTTRKHfr8V3L2SYHFtzTGA1TSLfdxPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkPqbtrWqYBBDco+3NplQpTAthtDhfEKGSgP6lCcXxlwUbBoL5
	e2tqiA7tCLuIsvOIFA4CAl6nHMVLQKnMsnDPJxuCYlj6aYZeXcjZ
X-Gm-Gg: ASbGncsxsLMScY2ycKrAnPLd0u5RXnU01PK8Ap4ZxPvMtToZjR/L+IzzbVA9B62JgzJ
	6/S/Ch9UiqtpBZP5HzAMIDc02E3JryudpxjiRwx55YSp5fTgNCTHD1D1G+fEZMNu26W4PYERnRX
	0gLBqRSTeGNIjtxg1c1JGZInI9N2vEe/3+7JQGTxsgCGVoJluJXXIRDGW2EkyyzBTgscDBvZUfp
	X6GP/UntZV/ded8REJMRQlhRIdn5W43NJNKCIXj7XR8EG1N9UGCMhx0spsXbhP9zoJEu7PunPaQ
	YeIOxttBzg==
X-Google-Smtp-Source: AGHT+IF+ea6oMI2R4JzVW/o0jJHq6SO4UY2/fTGfxmsu/be/SBGKOvu9L2iNP/jUO/JfCPxW18ydVQ==
X-Received: by 2002:a05:651c:1b10:b0:2f7:7ef7:7434 with SMTP id 38308e7fff4ca-2ffd60fe8dbmr120530851fa.37.1733170939703;
        Mon, 02 Dec 2024 12:22:19 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599973202sm538022966b.198.2024.12.02.12.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 12:22:19 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 8A1D6BE2EE7; Mon, 02 Dec 2024 21:22:17 +0100 (CET)
Date: Mon, 2 Dec 2024 21:22:17 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Steve Dickson <steved@redhat.com>
Cc: Sam Hartman <hartmans@debian.org>, Anton Lundin <glance@ac2.se>,
	linux-nfs@vger.kernel.org, Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: NFSv4 referrals broken when not enabling junction support
Message-ID: <Z04W-UXWVzY9vshK@eldamar.lan>
References: <Zv7NRNXeUtzpfbJg@eldamar.lan>
 <e7341203-c53c-4005-9d70-239073352b2b@redhat.com>
 <ZxUVlpd0Ec5NaWF1@eldamar.lan>
 <Zxv8GLvNT2sjB2Pn@eldamar.lan>
 <1fc7de18-eaf0-4a1e-bd41-e6072b0f3d7f@redhat.com>
 <Z0VVLw9htR7_C5Bc@elende.valinor.li>
 <e86284ac-7a77-440b-bb5d-bdb1e6f23a40@redhat.com>
 <Z04OnJtb1oDl5sfd@eldamar.lan>
 <328fdce3-a66b-4254-a178-389caf75a685@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <328fdce3-a66b-4254-a178-389caf75a685@redhat.com>

Hi Steve,


On Mon, Dec 02, 2024 at 02:57:54PM -0500, Steve Dickson wrote:
> 
> 
> On 12/2/24 2:46 PM, Salvatore Bonaccorso wrote:
> > Hi Steve,
> > 
> > On Mon, Dec 02, 2024 at 01:26:46PM -0500, Steve Dickson wrote:
> > > 
> > > 
> > > On 11/25/24 11:57 PM, Salvatore Bonaccorso wrote:
> > > > Hi Steve,
> > > > 
> > > > On Sat, Oct 26, 2024 at 09:04:01AM -0400, Steve Dickson wrote:
> > > > > 
> > > > > 
> > > > > On 10/25/24 4:14 PM, Salvatore Bonaccorso wrote:
> > > > > > Hi Steve,
> > > > > > 
> > > > > > On Sun, Oct 20, 2024 at 04:37:10PM +0200, Salvatore Bonaccorso wrote:
> > > > > > > Hi Steve,
> > > > > > > 
> > > > > > > On Tue, Oct 08, 2024 at 06:12:58AM -0400, Steve Dickson wrote:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > On 10/3/24 12:58 PM, Salvatore Bonaccorso wrote:
> > > > > > > > > Hi Steve, hi linux-nfs people,
> > > > > > > > > 
> > > > > > > > > it got reported twice in Debian that  NFSv4 referrals are broken when
> > > > > > > > > junction support is disabled. The two reports are at:
> > > > > > > > > 
> > > > > > > > > https://bugs.debian.org/1035908
> > > > > > > > > https://bugs.debian.org/1083098
> > > > > > > > > 
> > > > > > > > > While arguably having junction support seems to be the preferred
> > > > > > > > > option, the bug (or maybe unintended behaviour) arises when junction
> > > > > > > > > support is not enabled (this for instance is the case in the Debian
> > > > > > > > > stable/bookworm version, as we cannot simply do such changes in a
> > > > > > > > > stable release; note later relases will have it enabled).
> > > > > > > > > 
> > > > > > > > > The "breakage" seems to be introduced with 15dc0bead10d ("exportd:
> > > > > > > > > Moved cache upcalls routines  into libexport.a"), so
> > > > > > > > > nfs-utils-2-5-3-rc6 as this will mask behind the #ifdef
> > > > > > > > > HAVE_JUNCTION_SUPPORT's code which seems needed to support the refer=
> > > > > > > > > in /etc/exports.
> > > > > > > > > 
> > > > > > > > > I had a quick conversation with Cuck offliste about this, and I can
> > > > > > > > > hopefully state with his word, that yes, while nfsref is the direction
> > > > > > > > > we want to go, we do not want to actually disable refer= in
> > > > > > > > > /etc/exports.
> > > > > > > > +1
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Steve, what do you think? I'm not sure on the best patch for this,
> > > > > > > > > maybe reverting the parts masking behind #ifdef HAVE_JUNCTION_SUPPORT
> > > > > > > > > which are touched in 15dc0bead10d would be enough?
> > > > > > > > Yeah there is a lot of change with 15dc0bead10d
> > > > > > > > 
> > > > > > > > Let me look into this... At the up coming Bake-a-ton [1]
> > > > > > > 
> > > > > > > Thanks a lot for that, looking forward then to a fix which we might
> > > > > > > backport in Debian to the older version as well.
> > > > > > 
> > > > > > Hope the Bake-a-ton was productive :)
> > > > > > 
> > > > > > Did you had a chance to look at this issue beeing there?
> > > > > Yes I did... and we did talk about the problem.... still looking into it.
> > > > 
> > > > Reviewing the open bugs in Debian I remembered of this one. If you
> > > > have already a POC implementation/bugfix available, would it help if I
> > > > prod at least the two reporters in Debian to test the changes?
> > > > 
> > > > Thanks a lot for your work, it is really appreciated!
> > > I was not able to reproduce this at the Bakeathon
> > > with the latest nfs-utils... and today I took another
> > > look today...
> > > 
> > > Would mind showing me the step that cause the error
> > > and what is the error?
> > 
> > Let me ask the two reporters in Debian, Cc'ed.
> > 
> > Sam, Anton can you provide here how to reproduce the issue with
> > nfs-utils which you reported?
> > 
> Please note setting "enable-junction=no" does disable
> the referral code. aka in dump_to_cache()
> 
> #ifdef HAVE_JUNCTION_SUPPORT
>         write_fsloc(&bp, &blen, exp);
> #endif
> 
> So unless I'm not understanding something (which is very possible :-) )
> disabling junctions also disables referrals.

yes, and this is actually the problem reported here. If you have
distribution which cannot enable (yet) junction support, then referral
support regressed after 15dc0bead10d ("exportd: Moved cache upcalls
routines into libexport.a").

It was argued that, while is is clear that enabling junction support
is the preferred option (and we have done so in later versions in
Debian), when this is not enabled, and after nfs-utils-2-5-3-rc6, this
regressed in the referrals support.

My understanding is that Chuck in principle agrees that this is to be
considered a bug.

Hope this helps?

Regards,
Salvatore

