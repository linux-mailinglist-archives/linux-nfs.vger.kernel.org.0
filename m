Return-Path: <linux-nfs+bounces-8803-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0EE9FD0A1
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 07:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C89B163965
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 06:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3501F5F6;
	Fri, 27 Dec 2024 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cfWwIL5W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B745647
	for <linux-nfs@vger.kernel.org>; Fri, 27 Dec 2024 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735282091; cv=none; b=klu+M+I18LjpuFzZOkGw6KE4K4Q5Q4/EZ8xMxuECdliOD4yZQKeHOMxiPL/MYqGd6TNEmQnRVKt+IWiBt6kp3GZZjruQAmJvkT94rT9gIBZsdynnbtAA98hANPmUZu4mK8CHJaPznp6+UCFCt3i1uK7SDP3QKSK+GKyDTJnirJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735282091; c=relaxed/simple;
	bh=CnwDEIOsqdrLlsmwmPexEj06fBp6yczZaPkhf8S6zII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pf1rVPVy90rtt56PkvWZFLrA/+fhhc7OEo3wWVWEp6Cy/z6WD2WUbcopnq/Jzu6LR99uQnNqjNPx7OaaKRWXST1z0ENWU9U1QU4lANLq2GkUc9MKXvbF48eyKSrnT8TEsZbD/oYu/pU/ol5UzRSOPTidzcuLQnC2gVbTDYK73Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cfWwIL5W; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8YM2Q9S0FAaZ+aP3vTHn8pSZ0In5Xj3D+I83N/+iNZg=; b=cfWwIL5WTWLb6HNAY1d+uMwUfv
	M2hQrrmvBEs/ZdyZl1yzMJI4viruArnHf5TWqAwmiC+PEUI3V85dkBxaLe1dR+ayvF4Ipe3Etjt8t
	gV5h0O+xkI4hJKvBjGbPanR6Gy4zD+PWUr7PfPtcq/GiTsHvrljgkuPe1o2tQqb3fVDoyumemEtRq
	JumRKB6gfBF42OPBl9xnXmiVJbF2MNjfOmlJSI9bo0yFIf1bBQxSA8IxYhzG+NByIME66pNwMd+Ll
	yYxnWF6z3G9K0a97Vowa/V/dm2H70uMoI/1f5G6nstZnHyGQcaMQHuqLHO6itmtQ7LPJwvH+xJSZS
	prcDzkPg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1tR3xy-003FBn-0C; Fri, 27 Dec 2024 06:36:58 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id A7D09BE2EE7; Fri, 27 Dec 2024 07:36:56 +0100 (CET)
Date: Fri, 27 Dec 2024 07:36:56 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Chuck Lever <chuck.lever@oracle.com>, Scott Mayhew <smayhew@redhat.com>
Cc: Jur van der Burg via Bugspray Bot <bugbot@kernel.org>, anna@kernel.org,
	trondmy@kernel.org, jlayton@kernel.org, linux-nfs@vger.kernel.org,
	cel@kernel.org, 1091439@bugs.debian.org,
	1091439-submitter@bugs.debian.org, 1087900@bugs.debian.org,
	1087900-submitter@bugs.debian.org
Subject: Re: kernel BUG at fs/nfsd/nfs4recover.c:534 Oops: invalid opcode:
 0000
Message-ID: <Z25LCAz9-qDVAop9@eldamar.lan>
References: <20241209-b219580c0-d09195e1d9e8@bugzilla.kernel.org>
 <20241209-b219580c2-2def6494caed@bugzilla.kernel.org>
 <Z22DIiV98XBSfPVr@eldamar.lan>
 <7c76ca67-8552-4cfa-b579-75a33caa3ed2@oracle.com>
 <Z22r2RBlGT8PUHHb@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z22r2RBlGT8PUHHb@eldamar.lan>
X-Debian-User: carnil

Hi,

On Thu, Dec 26, 2024 at 08:17:45PM +0100, Salvatore Bonaccorso wrote:
> Hi Chuck, hi all,
> 
> On Thu, Dec 26, 2024 at 11:33:01AM -0500, Chuck Lever wrote:
> > On 12/26/24 11:24 AM, Salvatore Bonaccorso wrote:
> > > Hi Jur,
> > > 
> > > On Mon, Dec 09, 2024 at 04:50:05PM +0000, Jur van der Burg via Bugspray Bot wrote:
> > > > Jur van der Burg writes via Kernel.org Bugzilla:
> > > > 
> > > > I tried kernel 6.10.1 and that one is ok. In the mean time I
> > > > upgraded nfs-utils from 2.5.1 to 2.8.1 which seems to fix the issue.
> > > > Sorry for the noise, case closed.
> > > > 
> > > > View: https://bugzilla.kernel.org/show_bug.cgi?id=219580#c2
> > > > You can reply to this message to join the discussion.
> > > 
> > > Are you sure this is solved? I got hit by this today after trying to
> > > check the report from another Debian user:
> > > 
> > > https://bugs.debian.org/1091439
> > > the earlier report was
> > > https://bugs.debian.org/1087900
> > > 
> > > Surprisingly I managed to hit this, after:
> > > 
> > > Doing a fresh Debian installation with Debian unstable, rebooting
> > > after installation. The running kernel is 6.12.6-1 (but now believe it
> > > might be hit in any sufficient earlier version):
> > > 
> > > Notably, in kernel-log I see as well
> > > 
> > > [   50.295209] RPC: Registered tcp NFSv4.1 backchannel transport module.
> > > [   52.158301] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
> > > [   52.158333] NFSD: Using legacy client tracking operations.
> > 
> > Hi Salvatore,
> > 
> > If you no longer provision nfsdcltrack in user space, then you want to
> > set CONFIG_NFSD_LEGACY_CLIENT_TRACKING to 'N' in your kernel config.
> 
> Right, while this might not be possible right now in the distribution,
> to confirm, setting CONFIG_NFSD_LEGACY_CLIENT_TRACKING would resolve
> the problem. In the distribution I think we would not yet be able to
> do a hard cut for planned next stable release.
> 
> Remember, that in Debian we only with the current stable release got
> again somehow on "track" with nfs-utils code.
> 
> > Otherwise, Scott Mayhew is the area expert (cc'd).
> 
> Thanks!
> 
> I will try to get more narrow down to the versions to see where the
> problem might be introduced, but if you already have a clue, and know
> what we might try (e.g. commit revert on top, or patch) I'm happy to
> test this as well (since now reliably able to trigger it).

Okay so this was maybe obvious for you already but bisecting leads to
the first bad commit beeing:

74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")

The Problem is not present in v6.7 and it is triggerable with
74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")

Most importantly as the switch to defaulting to y was only in later
versions, explicitly setting CONFIG_NFSD_LEGACY_CLIENT_TRACKING=y.

Regards,
Salvatore

