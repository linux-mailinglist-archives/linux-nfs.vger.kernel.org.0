Return-Path: <linux-nfs+bounces-8307-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A13F9E0C83
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 20:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00C6281CE1
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53761632FE;
	Mon,  2 Dec 2024 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="IyNBJudN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A721DE3C1
	for <linux-nfs@vger.kernel.org>; Mon,  2 Dec 2024 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168815; cv=none; b=Vxv6UFFXgswKPzo0YDp8xUDNkipyPvBVb6LoV6FpHkMPDSSekzkXZZ4N4WqpW+FViwUIebajwssNZtPB1zq6ZrR/1z8UDLORwzlPq0OScg1TR27hnL5bOnSOryTzkzv/yp5mfYcL9x7K5e8R6FzPv5+M4lYighVF6jv+iys3i3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168815; c=relaxed/simple;
	bh=eG+KmWTdFmdqsuPjPS8f+rinxGOzxG/zM1neaHEI/7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQChhm94vHoH+ZnUfwg/dxJoyNmwtTXpB73eES1lNAMuLKiLGKoRPlCcQKs8A4e7fgxxqq5zMwMqT0sL8aH//jxOaTOcMQrj8sj8X4+1sV+DL5Cpwz7D9/Fm7ta+TaQG8TWlQh/J9LzVHx7S/zkwBaQ/pY/c4G3ylf1chkDcwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IyNBJudN; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aNqD3t2iU0qzOHmzDmdn7OSgUvUWO11Xd49vZgzQ3mQ=; b=IyNBJudNMK0vy265dUI108CIft
	Avd/ZAJTc177xs7pHWBFOMo085Vr/gn3r8/flqFH7PJD46Sz/alph9PqlYog+IRjntyBhipSUFYF6
	zCFdmVwYGGE6bn0mhLWpOeTyRdo4GIf0ll7CpAaSXY2FpSTruaZFADL7/DLZxq5pEyBweCDEJwh2J
	cUGZ3gLZX+Norn8g4jEbSMMEeSI9FBILKpRgtjzOhVzjzo7//6c+dnNBQhbU4i3l7Svz5ugnhpKnd
	wiaC/oPFqK0SBUBV8czhb+Wu1hHDhIN1Qa0grjHYSkjbH6C4Wym5c6iOynYhfoA1qdbk5NmFlrJZg
	VusM/1dw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1tICNR-000SkH-AZ; Mon, 02 Dec 2024 19:46:37 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 62DFBBE2EE7; Mon, 02 Dec 2024 20:46:36 +0100 (CET)
Date: Mon, 2 Dec 2024 20:46:36 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Steve Dickson <steved@redhat.com>, Sam Hartman <hartmans@debian.org>,
	Anton Lundin <glance@ac2.se>
Cc: linux-nfs@vger.kernel.org, Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: NFSv4 referrals broken when not enabling junction support
Message-ID: <Z04OnJtb1oDl5sfd@eldamar.lan>
References: <Zv7NRNXeUtzpfbJg@eldamar.lan>
 <e7341203-c53c-4005-9d70-239073352b2b@redhat.com>
 <ZxUVlpd0Ec5NaWF1@eldamar.lan>
 <Zxv8GLvNT2sjB2Pn@eldamar.lan>
 <1fc7de18-eaf0-4a1e-bd41-e6072b0f3d7f@redhat.com>
 <Z0VVLw9htR7_C5Bc@elende.valinor.li>
 <e86284ac-7a77-440b-bb5d-bdb1e6f23a40@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e86284ac-7a77-440b-bb5d-bdb1e6f23a40@redhat.com>
X-Debian-User: carnil

Hi Steve,

On Mon, Dec 02, 2024 at 01:26:46PM -0500, Steve Dickson wrote:
> 
> 
> On 11/25/24 11:57 PM, Salvatore Bonaccorso wrote:
> > Hi Steve,
> > 
> > On Sat, Oct 26, 2024 at 09:04:01AM -0400, Steve Dickson wrote:
> > > 
> > > 
> > > On 10/25/24 4:14 PM, Salvatore Bonaccorso wrote:
> > > > Hi Steve,
> > > > 
> > > > On Sun, Oct 20, 2024 at 04:37:10PM +0200, Salvatore Bonaccorso wrote:
> > > > > Hi Steve,
> > > > > 
> > > > > On Tue, Oct 08, 2024 at 06:12:58AM -0400, Steve Dickson wrote:
> > > > > > 
> > > > > > 
> > > > > > On 10/3/24 12:58 PM, Salvatore Bonaccorso wrote:
> > > > > > > Hi Steve, hi linux-nfs people,
> > > > > > > 
> > > > > > > it got reported twice in Debian that  NFSv4 referrals are broken when
> > > > > > > junction support is disabled. The two reports are at:
> > > > > > > 
> > > > > > > https://bugs.debian.org/1035908
> > > > > > > https://bugs.debian.org/1083098
> > > > > > > 
> > > > > > > While arguably having junction support seems to be the preferred
> > > > > > > option, the bug (or maybe unintended behaviour) arises when junction
> > > > > > > support is not enabled (this for instance is the case in the Debian
> > > > > > > stable/bookworm version, as we cannot simply do such changes in a
> > > > > > > stable release; note later relases will have it enabled).
> > > > > > > 
> > > > > > > The "breakage" seems to be introduced with 15dc0bead10d ("exportd:
> > > > > > > Moved cache upcalls routines  into libexport.a"), so
> > > > > > > nfs-utils-2-5-3-rc6 as this will mask behind the #ifdef
> > > > > > > HAVE_JUNCTION_SUPPORT's code which seems needed to support the refer=
> > > > > > > in /etc/exports.
> > > > > > > 
> > > > > > > I had a quick conversation with Cuck offliste about this, and I can
> > > > > > > hopefully state with his word, that yes, while nfsref is the direction
> > > > > > > we want to go, we do not want to actually disable refer= in
> > > > > > > /etc/exports.
> > > > > > +1
> > > > > > 
> > > > > > > 
> > > > > > > Steve, what do you think? I'm not sure on the best patch for this,
> > > > > > > maybe reverting the parts masking behind #ifdef HAVE_JUNCTION_SUPPORT
> > > > > > > which are touched in 15dc0bead10d would be enough?
> > > > > > Yeah there is a lot of change with 15dc0bead10d
> > > > > > 
> > > > > > Let me look into this... At the up coming Bake-a-ton [1]
> > > > > 
> > > > > Thanks a lot for that, looking forward then to a fix which we might
> > > > > backport in Debian to the older version as well.
> > > > 
> > > > Hope the Bake-a-ton was productive :)
> > > > 
> > > > Did you had a chance to look at this issue beeing there?
> > > Yes I did... and we did talk about the problem.... still looking into it.
> > 
> > Reviewing the open bugs in Debian I remembered of this one. If you
> > have already a POC implementation/bugfix available, would it help if I
> > prod at least the two reporters in Debian to test the changes?
> > 
> > Thanks a lot for your work, it is really appreciated!
> I was not able to reproduce this at the Bakeathon
> with the latest nfs-utils... and today I took another
> look today...
> 
> Would mind showing me the step that cause the error
> and what is the error?

Let me ask the two reporters in Debian, Cc'ed.

Sam, Anton can you provide here how to reproduce the issue with
nfs-utils which you reported?

Context:
- https://bugs.debian.org/1035908
- https://bugs.debian.org/1083098

Regards,
Salvatore

