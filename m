Return-Path: <linux-nfs+bounces-8811-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06089FD920
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Dec 2024 07:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564AF3A24A8
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Dec 2024 06:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404441798F;
	Sat, 28 Dec 2024 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyF+cqOs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F21F12E4A
	for <linux-nfs@vger.kernel.org>; Sat, 28 Dec 2024 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735366149; cv=none; b=pL8xK4yA7hQdslcnpn4nPvm7tb7lja9CxTU8bZDMl7bhhRZDqC25iHSjrJQrwo3sFQZz0zZQopc5uzErT47EbgL1IULi+J0SNEiXnWjOzKViR4QXDbbzuL2oKSGrj2tykag69eHrZWFTCZR4ZldI7TVB3BVeyM2nTdsDhVnzPFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735366149; c=relaxed/simple;
	bh=NlSGAEMkSSCo44bKJXBvUfHTtH/Qfs8YAMNCQpZmAPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbzAVIVxx6DI75vdiQzvrt7zS+6MDj+lJMAMAo3e1mEaQPzlZyoneq3oW7JRJpLwHw5IRUTmwrmjjkUF1++XB5vZ4o+/tQA3mopQ7dRVZ4eYXtAuknHfYeRrWz7qtLrvYH0WTbdiksYqslqbfflHNI/3NmpHv353JyHc4lyjwHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyF+cqOs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1061493366b.1
        for <linux-nfs@vger.kernel.org>; Fri, 27 Dec 2024 22:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735366145; x=1735970945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RcpQ5yOFcWFmdi7os+lMiQ+7XTqRlYIcU1acCYL6czc=;
        b=HyF+cqOsYStBNtHR0aGA2YQDhQFhnkjYeVlCco7Q0C2wrUfs1N2A4PZIpFBcmNPHCK
         55A6rqlUsXj9hGR97Fku/fG0kxt13w6oemZJAZPg7/zpSgQ7m6u0b43VgarF2jyhNdd4
         WY1knG6BCn9Qm8YxwhT1StfL6cv8WQb+9hIsCXrgedGKFI+4J+Vs4dJSJCByyU6YBcIE
         XbFv0FAskwCWWyRXarQQl4lFXwHJy3CqqmeYSXLLni/5dQzAO3W8xOhbFIlfVZFJpFey
         oldJKDCo64euTX9GWYNCiI7tR0JhlT5wvZfDX17jKLheBq9rFsydBtdkhviEauAZHWwc
         BX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735366145; x=1735970945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcpQ5yOFcWFmdi7os+lMiQ+7XTqRlYIcU1acCYL6czc=;
        b=AfDnuy355iagGDZhDFb0jIpmWw/+u6GDVHmO0yxFOxs2JrDK5K02MxQbaBCh2Bpg/d
         DAP2PHW31JCPsM8TJ2g1BFiHeckR6YPvgQFqgV5GX0dz4qzZ804A84pUIccPVax0KLmH
         jlno5oZ15g2C6I2fpQ3eocqCp2HLWnnDlb9ixDF9ktXiNX10LtkUEqjrVv8KzDlZ6A5D
         JOSsZrC4p5fafk0C7g+KLJjyYSuGgZ5iAivovAxEDfq0grSgZFI6iJ34I+H5yZ8F7Cyd
         C6Zpk+eSsHB3AX7NFPbU0lWboVLSCisRS0SvV1CqLSdgnZV1VFFqtxJelJ6GfWVNlGdW
         wGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2yskF34CC7c8rmjzChxptmHVN00kRsonvhHfom/aOPDovqnPeEaEwCex+XtRLDes3LyXmDbzXvGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUjPfdyleqPaVe8DWQaPfLU5YVSvTFxEm0/5mFQg6xrIlIeELg
	BpuQUgrBvebpDNV68c0oTWgHcD8A84ocudDFoRVMXz38T7jVn8C8
X-Gm-Gg: ASbGnct04Xoev09p3tRXuK/O7dbInp6wnr9uYwSrUdlxXIKuHj7qFgdklBTdbSFhKH3
	B0FNzhS5M5XEBPL1rhUDFZut7elOvJNI0+1RHlp2TUB3CQuVd6wtxUmzH4Y9BTc/6YuHfhk+cfG
	btH5jZbZmmqIJpcf8oW4ok+m01VmVq3FRImxQI278VHrDGSmN0u4zdwBSZGpjHMM9lsBG/avnxv
	hSgdybmpU5vNU/M2T6DfGkrxJBo9d99AT1PbcKxtFUmVSDYh6Li4Pv+w0/AyowW0StbGzDhLQCK
	ROOqlZs7bB5ZSzF5
X-Google-Smtp-Source: AGHT+IHT9tT1kHa3EqY20uOX3WdXW/ljNqfcNGajE5kTeEuIHXbbbVFMEXGSsPnmbnez1xNGKfQOow==
X-Received: by 2002:a17:907:7f26:b0:aa6:96ad:f903 with SMTP id a640c23a62f3a-aac2c005b9fmr2686636766b.31.1735366145172;
        Fri, 27 Dec 2024 22:09:05 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aaec0aa223bsm920348066b.173.2024.12.27.22.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 22:09:04 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id B2D99BE2EE7; Sat, 28 Dec 2024 07:09:02 +0100 (CET)
Date: Sat, 28 Dec 2024 07:09:02 +0100
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
Message-ID: <Z2-V_reIDIgJ1AH7@eldamar.lan>
References: <20241209-b219580c0-d09195e1d9e8@bugzilla.kernel.org>
 <20241209-b219580c2-2def6494caed@bugzilla.kernel.org>
 <Z22DIiV98XBSfPVr@eldamar.lan>
 <7c76ca67-8552-4cfa-b579-75a33caa3ed2@oracle.com>
 <Z22r2RBlGT8PUHHb@eldamar.lan>
 <Z25LCAz9-qDVAop9@eldamar.lan>
 <9e988cfa-5a27-4139-b922-b5c416ae0c72@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e988cfa-5a27-4139-b922-b5c416ae0c72@oracle.com>

Hi,

On Fri, Dec 27, 2024 at 04:31:44PM -0500, Chuck Lever wrote:
> On 12/27/24 1:36 AM, Salvatore Bonaccorso wrote:
> > Hi,
> > 
> > On Thu, Dec 26, 2024 at 08:17:45PM +0100, Salvatore Bonaccorso wrote:
> > > Hi Chuck, hi all,
> > > 
> > > On Thu, Dec 26, 2024 at 11:33:01AM -0500, Chuck Lever wrote:
> > > > On 12/26/24 11:24 AM, Salvatore Bonaccorso wrote:
> > > > > Hi Jur,
> > > > > 
> > > > > On Mon, Dec 09, 2024 at 04:50:05PM +0000, Jur van der Burg via Bugspray Bot wrote:
> > > > > > Jur van der Burg writes via Kernel.org Bugzilla:
> > > > > > 
> > > > > > I tried kernel 6.10.1 and that one is ok. In the mean time I
> > > > > > upgraded nfs-utils from 2.5.1 to 2.8.1 which seems to fix the issue.
> > > > > > Sorry for the noise, case closed.
> > > > > > 
> > > > > > View: https://bugzilla.kernel.org/show_bug.cgi?id=219580#c2
> > > > > > You can reply to this message to join the discussion.
> > > > > 
> > > > > Are you sure this is solved? I got hit by this today after trying to
> > > > > check the report from another Debian user:
> > > > > 
> > > > > https://bugs.debian.org/1091439
> > > > > the earlier report was
> > > > > https://bugs.debian.org/1087900
> > > > > 
> > > > > Surprisingly I managed to hit this, after:
> > > > > 
> > > > > Doing a fresh Debian installation with Debian unstable, rebooting
> > > > > after installation. The running kernel is 6.12.6-1 (but now believe it
> > > > > might be hit in any sufficient earlier version):
> > > > > 
> > > > > Notably, in kernel-log I see as well
> > > > > 
> > > > > [   50.295209] RPC: Registered tcp NFSv4.1 backchannel transport module.
> > > > > [   52.158301] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
> > > > > [   52.158333] NFSD: Using legacy client tracking operations.
> > > > 
> > > > Hi Salvatore,
> > > > 
> > > > If you no longer provision nfsdcltrack in user space, then you want to
> > > > set CONFIG_NFSD_LEGACY_CLIENT_TRACKING to 'N' in your kernel config.
> > > 
> > > Right, while this might not be possible right now in the distribution,
> > > to confirm, setting CONFIG_NFSD_LEGACY_CLIENT_TRACKING would resolve
> > > the problem. In the distribution I think we would not yet be able to
> > > do a hard cut for planned next stable release.
> > > 
> > > Remember, that in Debian we only with the current stable release got
> > > again somehow on "track" with nfs-utils code.
> > > 
> > > > Otherwise, Scott Mayhew is the area expert (cc'd).
> > > 
> > > Thanks!
> > > 
> > > I will try to get more narrow down to the versions to see where the
> > > problem might be introduced, but if you already have a clue, and know
> > > what we might try (e.g. commit revert on top, or patch) I'm happy to
> > > test this as well (since now reliably able to trigger it).
> > 
> > Okay so this was maybe obvious for you already but bisecting leads to
> > the first bad commit beeing:
> > 
> > 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")
> > 
> > The Problem is not present in v6.7 and it is triggerable with
> > 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")
> > 
> > Most importantly as the switch to defaulting to y was only in later
> > versions, explicitly setting CONFIG_NFSD_LEGACY_CLIENT_TRACKING=y.
> 
> Hi Salvatore -
> 
> I see that Scott recently sent a fix for a similar crash to linux-nfs@ :
> 
> https://lore.kernel.org/linux-nfs/032ff3ad487ce63656f95c6cdf3db8543fb0d061.camel@kernel.org/T/#t

Oh right, this described escactly the problem.

Do you think that can be made reaching 6.13 as well (and then
cherry-picked to the affected stable series 6.12.y) or do we have to
wait for landing in 6.14 first?

Regards,
Salvatore

