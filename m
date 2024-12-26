Return-Path: <linux-nfs+bounces-8793-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270D29FCD53
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 20:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFF0162B6D
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 19:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284C9145A17;
	Thu, 26 Dec 2024 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS1CMPC6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E672BCF5
	for <linux-nfs@vger.kernel.org>; Thu, 26 Dec 2024 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735240670; cv=none; b=VSqs3WOd8/ONU0gAF3a8PBy4ng/os5thiVXWH8HacUCMmPTg09FYknBKjlR7qeqqN7zoFkpH7Qlvew2jkp+BAUqgJBRXPH8lOMsqlZPZO04G7Q18hnK5atyBPG3SR8q0/7gsabGPkf7FphagAZ2qh0MFtmcNa2exUfYMFk6p11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735240670; c=relaxed/simple;
	bh=RgOX0zWEHM5OeuDZSdDT+oWM2TekTwQYtSp8y1FYhSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpnUaFsVehCfIbBBquxzLrk0pBN3h8ufBd+BX8mKo5cxvzvr8fKMNjbA9YBGxovWsaiF9voLsmlPd/U7NOaGOoQ/ui+8uhg+HDma/oiyDk0FCGAT1Cqx9SzvvmTj9nLSngdhY/noBHJWm/DW3SfoTXniA2tsVkDvYqirB6oDs9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KS1CMPC6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso1133261166b.2
        for <linux-nfs@vger.kernel.org>; Thu, 26 Dec 2024 11:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735240666; x=1735845466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXJUKpng2sb1OxPv8dn9bz6z5HWbf//D3YH0/VT8zDg=;
        b=KS1CMPC6FcUSyD1UlAe0BtfUncYYTWTkBUGPpTVNrpQE1noxGdacmmqKgjMb/dpvee
         AiEKsYxWW9jIFBtAoP4ZNYO3u5UCrKv9NcYUc5xqdJDTAFQSGNciwYmKue31Adqs7Bah
         yIoQFkuwOvqVzgLnc8Fc4Qpd77+KUFd/neklbNSJy0vOGKMzFXFxffvFu6919BQdwHtN
         NLUF9tYnAagjSbtNdrA2VWSqkjUSQYelOXDRgYnhWzZ3ycibFvT3eEelTXAoK349P33c
         oQWjoc2bs9C7WHZx1KJiB7kJnhETSlVuybfC1Y9r+pRGEZ0lVDwqDgVzAWH6Nrk/XI+S
         9nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735240666; x=1735845466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXJUKpng2sb1OxPv8dn9bz6z5HWbf//D3YH0/VT8zDg=;
        b=rsTxsYE5yvMvLymziSiRoAcHFzTkLGa1Kzas9L/UQpSnQMxTkXxkeWKLuvpquaa8H3
         jGac918XZ6OR/LmEDbfCCKQvyrt9+uHAaKeab2p+RQ9Sr8winWDcbNssjvgI5YtCtTgV
         3MLP4ulrPJ4NEJVWaWiP2FmEE+NUGzo0ONahLUSf/MpnhESbwNtOY5L1WpOBiKkV0AXh
         E6LblUTAg27Wc1UC65THEbDQ71IqLsCXACm2EM2SXZbM/OUVGd3yvjnkd2xXd0WxVZEF
         3G598YnV+B1gmO5G9bBsjJXqOP9grzDfYij+qcQm7vE38NhjgNj6Ze0JWq75dW3K9Inp
         fnaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW59dWWoMr4hs1iyXAIzVeYEDumx4kj62Mmwg24B2zODSW4fvT3Eg7nDe4y+JWfsh2GhMLNJ1z9cPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQt47dwS/LrXqbgGO8ibrBZZKPggfbK2qIKK7sy+3E9inMiJmd
	R9LBgT09AJdiNQKuKCJ2cDDSNr0JcPY0Sbk6P1pCHpOA4o85RceB
X-Gm-Gg: ASbGnctC7Gog/xx666LtkMYgRsB/TrTi6vg09W13TTsGP8K2t1/wwmFcWfTgW9j1SFe
	+XIef7NWKDeVlozthpryhlVi3iQ1t1RQhEPMlxPZJNbkLRcqslMsh6OdbOult6ua+1UZRoy/y+4
	ZLtJvt4P0apTSn/R3YqIyglf5xDPmvlcgqrmtAhz85jCk0Dna9eWKMkNGfsjNeJc4HWSnoKLp7s
	kXA/FSjn6RnkHf3ulW85NOlYCC4qCTE9VHYr6U7KeTxSnfmMgBlIpBlVj/GTEeB5rFCtbgTVJTj
	bfxdkjJ15PofVydp
X-Google-Smtp-Source: AGHT+IEZo9++Gf6Wzsmft2S9bzdQM2w1f9IK8BmoavQ7UIRRAuSHfh5PgKusFPneyLhEfn+9GxOxOQ==
X-Received: by 2002:a17:907:3f26:b0:aaf:17d:803f with SMTP id a640c23a62f3a-aaf017d83dcmr573298566b.51.1735240666150;
        Thu, 26 Dec 2024 11:17:46 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f014538sm1008195666b.146.2024.12.26.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 11:17:45 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 087C4BE2EE7; Thu, 26 Dec 2024 20:17:45 +0100 (CET)
Date: Thu, 26 Dec 2024 20:17:45 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jur van der Burg via Bugspray Bot <bugbot@kernel.org>, anna@kernel.org,
	trondmy@kernel.org, jlayton@kernel.org, linux-nfs@vger.kernel.org,
	cel@kernel.org, 1091439@bugs.debian.org,
	1091439-submitter@bugs.debian.org, 1087900@bugs.debian.org,
	1087900-submitter@bugs.debian.org,
	Scott Mayhew <smayhew@redhat.com>
Subject: Re: kernel BUG at fs/nfsd/nfs4recover.c:534 Oops: invalid opcode:
 0000
Message-ID: <Z22r2RBlGT8PUHHb@eldamar.lan>
References: <20241209-b219580c0-d09195e1d9e8@bugzilla.kernel.org>
 <20241209-b219580c2-2def6494caed@bugzilla.kernel.org>
 <Z22DIiV98XBSfPVr@eldamar.lan>
 <7c76ca67-8552-4cfa-b579-75a33caa3ed2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c76ca67-8552-4cfa-b579-75a33caa3ed2@oracle.com>

Hi Chuck, hi all,

On Thu, Dec 26, 2024 at 11:33:01AM -0500, Chuck Lever wrote:
> On 12/26/24 11:24 AM, Salvatore Bonaccorso wrote:
> > Hi Jur,
> > 
> > On Mon, Dec 09, 2024 at 04:50:05PM +0000, Jur van der Burg via Bugspray Bot wrote:
> > > Jur van der Burg writes via Kernel.org Bugzilla:
> > > 
> > > I tried kernel 6.10.1 and that one is ok. In the mean time I
> > > upgraded nfs-utils from 2.5.1 to 2.8.1 which seems to fix the issue.
> > > Sorry for the noise, case closed.
> > > 
> > > View: https://bugzilla.kernel.org/show_bug.cgi?id=219580#c2
> > > You can reply to this message to join the discussion.
> > 
> > Are you sure this is solved? I got hit by this today after trying to
> > check the report from another Debian user:
> > 
> > https://bugs.debian.org/1091439
> > the earlier report was
> > https://bugs.debian.org/1087900
> > 
> > Surprisingly I managed to hit this, after:
> > 
> > Doing a fresh Debian installation with Debian unstable, rebooting
> > after installation. The running kernel is 6.12.6-1 (but now believe it
> > might be hit in any sufficient earlier version):
> > 
> > Notably, in kernel-log I see as well
> > 
> > [   50.295209] RPC: Registered tcp NFSv4.1 backchannel transport module.
> > [   52.158301] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
> > [   52.158333] NFSD: Using legacy client tracking operations.
> 
> Hi Salvatore,
> 
> If you no longer provision nfsdcltrack in user space, then you want to
> set CONFIG_NFSD_LEGACY_CLIENT_TRACKING to 'N' in your kernel config.

Right, while this might not be possible right now in the distribution,
to confirm, setting CONFIG_NFSD_LEGACY_CLIENT_TRACKING would resolve
the problem. In the distribution I think we would not yet be able to
do a hard cut for planned next stable release.

Remember, that in Debian we only with the current stable release got
again somehow on "track" with nfs-utils code.

> Otherwise, Scott Mayhew is the area expert (cc'd).

Thanks!

I will try to get more narrow down to the versions to see where the
problem might be introduced, but if you already have a clue, and know
what we might try (e.g. commit revert on top, or patch) I'm happy to
test this as well (since now reliably able to trigger it).

Regards,
Salvatore

