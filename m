Return-Path: <linux-nfs+bounces-16153-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0EDC3D398
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 20:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9560F3AB39D
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 19:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DAA34F24B;
	Thu,  6 Nov 2025 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9NObgKd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C79335BA5
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456936; cv=none; b=jRovV5+ocuzf9u4zen+2AtaRCydR5Nn8UM/qWMKnN6Sb4/lUqnAnZM1Jc9KA5ppk4Dre8CaANojAGut8iTeGFHwAhlSNN6ezbhwnN7cGb9EZudmtCIBh29JU67DTddWulRRTyMupvWPPU/Unjy9KuLW3lKG3W0BYIqH0JEnlaV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456936; c=relaxed/simple;
	bh=Qd/DAK6OT+mphCRDnwifNLpl2LfGN62CDZiwf3ZZ5CU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dsr/loHBigXmIcF4Lz9m+pYS8hlt3XVb1pvt427qrVAMAyNSIU0ftaDJ//wWgjboQw0Evtv0/Y+m3x6BW1dZRSccridqVPvRRf1OsBFj2L+IFEYPPpak+0VDUOGvOQkGClWj/cNR5Uc+kh8DP9zRfSqti4brtRyZtluPpvsVd44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9NObgKd; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so974700f8f.3
        for <linux-nfs@vger.kernel.org>; Thu, 06 Nov 2025 11:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762456932; x=1763061732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TARNetY/7a0+kYWYr0yLvbYebuOPI2tOv2M0+ltQxfA=;
        b=S9NObgKdxnw2knt6wFKvM0yu2efhQZH6GOc+YlFyWtpNF7lvkncCN8O2GLohc24CvL
         rruNCnDfPoI4VW9VrAx1OL9dNZcJ7T+p6qrieH1vJS+qk/yPfOBymn2exZv6DbmbP9Bc
         ps3fm8B6L6w3MjIseSM6rF/9WMELw2Uc1OjxW7oTveNBasQURP8wf4aQvJOPOLfxM/iv
         +qOizeD7UlDC+EXBJWmkJ0muDZAcPoJL+x6FteAC6mB2gbJ6QoOYPWWn7d2UK0mKR8t8
         74jqLjRNK//VCXVcnglNU5xZ0CfxQmxEnLrPROb5hneXvb86CrUvQGT9XTxfn5T78zi7
         tonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762456932; x=1763061732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TARNetY/7a0+kYWYr0yLvbYebuOPI2tOv2M0+ltQxfA=;
        b=wSn4MZWFzZhzm0oFcm9vpNcKK/XKssPXZWnVTXvRDjpUxfO60lcvS06rInefQv5zPL
         4eueHeXJ9Usd6Sq8uqD21BP98wpUhjuAdbYAT/RAVCiwUtFMT30FHnC+2j2lxhMRpFSX
         lxLF6guSkZayKH/90poUJjVz9PpTW2MnWaRwy6EAWSujsE4XEFBlFuHizYd1CRAt/BkW
         Th56wsHE3Xybvz8SEgTEDtSC84Hw/q3AVEIxpt8pRrfDIktH+IKETwIyfc4dUoNzjC8D
         n2OIFF81BYm0ftAG2QJfOK14obpvWLYhiODRK1l1VNMJPOySqmOjtL7GMdg6s/PAASP2
         Ugsw==
X-Forwarded-Encrypted: i=1; AJvYcCXKsoLpaNQPN+tRO9Ct4W8Xr06u947RvkQpSfqSCl/5yMz9vLPHr2bVB94ooU7zLtLNN9LNXqsD0Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YxykwKIUgTM8ajJCedQS9yKeeL8jPTbgz0xzJDji8Fxgb2TWGIL
	viJkK1Fy022I92uY1UXyQQZ5C3GVpLJ55E9XyWpp79P6P9JYJGzh9fJl
X-Gm-Gg: ASbGncvltHQPgSDxLjAhVp6chsAyHVI5LXWqD8XdEo/wKrMpnUa6/YtyXvQWMXjbjTu
	e+HpZv/n3djoABRe9pTJfzovOHhjp1+rMekuOG0EWH3dmdeCDJz3OhusAbeB5A3+7vRobaXwDBO
	/YiycWW3eIEfVzCYHose4y3Sw749B+DAPn4mGUgQFWWkOCjic0V9D/mPrO6RUIVBNDVazpz7gXe
	OZAxcA7d7IXDBwsxjaTKwHIIz/IfLYGfS4dTBwRXNFwwgr0Si78k+rHppvel4SMYLql+kEO2WFr
	b8z6mGDo0BQ7Cvrl963U2XaBaOjF0GVsjY8QDNY/3RKAzmywCs8npyfu8VzVNIM5NyPuY/z/D4Z
	ubJTUdGNkCDF/oPyPqtCrkLCiKrLUJrpwdoGop/6C2EsdwMfFF6UNkMnkrtcf0o4FexLWyzmObt
	AFGGaNgook67L6BUi97W6Vr31p3kvJ0ezntdWG+rXpNO9ZJfyJ6y8b
X-Google-Smtp-Source: AGHT+IF0zk1oUWx1cX2TrjwxiRfGz7OlqtiKsuQpEdmlJOBBFKKufGqeju6Ue4zxLppOIjOWOiCuwQ==
X-Received: by 2002:a05:6000:230c:b0:429:d436:f142 with SMTP id ffacd0b85a97d-42aefb490ccmr237515f8f.57.1762456932207;
        Thu, 06 Nov 2025 11:22:12 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b28asm764140f8f.6.2025.11.06.11.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:22:11 -0800 (PST)
Date: Thu, 6 Nov 2025 19:22:10 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Chuck Lever <cel@kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, David Laight <David.Laight@ACULAB.COM>, Linux
 NFS Mailing List <linux-nfs@vger.kernel.org>, Linux List Kernel Mailing
 <linux-kernel@vger.kernel.org>, speedcracker@hotmail.com
Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
Message-ID: <20251106192210.1b6a3ca0@pumpkin>
In-Reply-To: <37bc1037-37d8-4168-afc9-da8e2d1dd26b@kernel.org>
References: <bbba88825d7b2b06031c1b085d76787a2502d70e.camel@kernel.org>
	<37bc1037-37d8-4168-afc9-da8e2d1dd26b@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 09:33:28 -0500
Chuck Lever <cel@kernel.org> wrote:

> FYI
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=220745

Ugg - that code is horrid.
It seems to have got deleted since, but it is:

	u32 slotsize = slot_bytes(ca);
	u32 num = ca->maxreqs;
	unsigned long avail, total_avail;
	unsigned int scale_factor;

	spin_lock(&nfsd_drc_lock);
	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
	else
		/* We have handed out more space than we chose in
		 * set_max_drc() to allow.  That isn't really a
		 * problem as long as that doesn't make us think we
		 * have lots more due to integer overflow.
		 */
		total_avail = 0;
	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
	/*
	 * Never use more than a fraction of the remaining memory,
	 * unless it's the only way to give this client a slot.
	 * The chosen fraction is either 1/8 or 1/number of threads,
	 * whichever is smaller.  This ensures there are adequate
	 * slots to support multiple clients per thread.
	 * Give the client one slot even if that would require
	 * over-allocation--it is better than failure.
	 */
	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);

	avail = clamp_t(unsigned long, avail, slotsize,
			total_avail/scale_factor);
	num = min_t(int, num, avail / slotsize);
	num = max_t(int, num, 1);

Lets rework it a bit...
	if (nfsd_drc_max_mem > nfsd_drc_mem_used) {
		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
		avail = min(NFSD_MAX_MEM_PER_SESSION, total_avail);
		avail = clamp(avail, n + sizeof(xxx), total_avail/8)
	} else {
		total_avail = 0;
		avail = 0;
		avail = clamp(0, n + sizeof(xxx), 0);
	}

Neither of those clamp() are sane at all - should be clamp(val, lo, hi)
with 'lo <= hi' otherwise the result is dependant on the order of the
comparisons.
The compiler sees the second one and rightly bleats.
I can't even guess what the code is actually trying to calculate!

Maybe looking at where the code came from, or the current version might help.

It MIGHT be that the 'lo' of slotsize was an attempt to ensure that
the following 'avail / slotsize' was as least one.
Some software archaeology might show that the 'num = max(num, 1)' was added
because the code above didn't work.
In that case the clamp can be clamp(avail, 0, total_avail/scale_factor)
which is just min(avail, total_avail/scale_factor).

The person who rewrote it between 6.1 and 6.18 might now more.

	David
	
> 
> 
> -------- Forwarded Message --------
> Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit
> slotsize greater than high limit total_avail/scale_factor
> Date: Thu, 06 Nov 2025 07:29:25 -0500
> From: Jeff Layton <jlayton@kernel.org>
> To: Mike-SPC via Bugspray Bot <bugbot@kernel.org>, cel@kernel.org,
> neilb@ownmail.net, trondmy@kernel.org, linux-nfs@vger.kernel.org,
> anna@kernel.org, neilb@brown.name
> 
> On Thu, 2025-11-06 at 11:30 +0000, Mike-SPC via Bugspray Bot wrote:
> > Mike-SPC writes via Kernel.org Bugzilla:
> > 
> > (In reply to Bugspray Bot from comment #5)  
> > > Chuck Lever <cel@kernel.org> replies to comment #4:
> > > 
> > > On 11/5/25 7:25 AM, Mike-SPC via Bugspray Bot wrote:  
> > > > Mike-SPC writes via Kernel.org Bugzilla:
> > > >   
> > > > > Have you found a 6.1.y kernel for which the build doesn't fail?  
> > > > 
> > > > Yes. Compiling Version 6.1.155 works without problems.
> > > > Versions >= 6.1.156 aren't.  
> > > 
> > > My analysis yesterday suggests that, because the nfs4state.c code hasn't
> > > changed, it's probably something elsewhere that introduced this problem.
> > > As we can't reproduce the issue, can you use "git bisect" between
> > > v6.1.155 and v6.1.156 to find the culprit commit?
> > > 
> > > (via https://msgid.link/ab235dbe-7949-4208-a21a-2cdd50347152@kernel.org)  
> > 
> > 
> > Yes, your analysis is right (thanks for it).
> > After some investigation, the issue appears to be caused by changes introduced in
> > include/linux/minmax.h.
> > 
> > I verified this by replacing minmax.h in 6.1.156 with the version from 6.1.155,
> > and the kernel then compiles successfully.
> > 
> > The relevant section in the 6.1.156 changelog (https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.1.156) shows several modifications to minmax.h (notably around __clamp_once() and the use of
> > BUILD_BUG_ON_MSG(statically_true(ulo > uhi), ...)), which seem to trigger a compile-time assertion when building NFSD.
> > 
> > Replacing the updated header with the previous one resolves the issue, so this appears
> > to be a regression introduced by the new clamp() logic.
> > 
> > Could you please advise who is the right person or mailing list to report this issue to
> > (minmax.h maintainers, kernel core, or stable tree)?
> >   
> 
> I'd let all 3 know, and I'd include the author of the patches that you
> suspect are the problem. They'll probably want to revise the one that's
> a problem.
> 
> Cheers,


