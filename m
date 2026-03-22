Return-Path: <linux-nfs+bounces-20313-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKNbGaxfwGltHAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20313-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Mar 2026 22:31:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 064C72EAD9F
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Mar 2026 22:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68956300232F
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Mar 2026 21:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C70264617;
	Sun, 22 Mar 2026 21:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTGiWubB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB97210785
	for <linux-nfs@vger.kernel.org>; Sun, 22 Mar 2026 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215081; cv=none; b=BPVc5oEazoDcgDfmkP0ehD/RrNggFwrqW2LNp1DlcyJUWcRdaf/L/An5jgH3TRfDDWZYuxiqfP5hvyQ7ENlN2rmFGLAWfRZVBsgZGG4zym1dngKaRaZIgr5j0mVsAlccKIoXTUOKPqvRKHJfmnEWJ7kCYyqQ5gTwpVUQF4O9zTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215081; c=relaxed/simple;
	bh=ztBQlr4DojOrBH9vjZhWTIYB9V/7Y+/7VOFgH5AUeN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPR+fhRoc2OHVvR5WUrMQ13FQnAjb78Zo7c3otXvGB7qZ5vVTBFhA1lXha8m+CctJtnOGFTYPdtbCpbpAnugmRT70LHGAkPdwmWqEKiCxw00iczVJ97rIgA/FNuTlcBLyLxGxh+nkupvbUpX2Lzr7CZ4YozgzL8pLFkk8AAM75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTGiWubB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48704db565eso11842935e9.1
        for <linux-nfs@vger.kernel.org>; Sun, 22 Mar 2026 14:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774215078; x=1774819878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkWmMBGqLU53ZHn70d7vN2dCAh8bPswasxv95uuwbGY=;
        b=hTGiWubBnY9APCkHJ000Y/l7zrKRJay4/0/QSTo8Xc61DM1wvsXY4Uj2TXh38dVSmK
         Z9EQ0y4OosoQYka1SVkDzRtCCDo2IVcHayM8ml8Lnt8YPjjzc8w8ubX7AywmcRaQ3sT+
         1vDehAPrWUtcObp3s0dEB7dcEvP/PPPSeNamfbJJlXpDEp6iiluPpqeWT+T97JXTd1pF
         nF4mmZzfqx88XT04zV8hSmoXw1T0d2hSO3aRuHhWtOSrpJWYQOa/ZoU3RpZUd4/uT4Yz
         JkJo4UbSxtBQqMR0zsXedC5jvZkURgIKdirSrat9XeQHrerRLTaR/FHsVRf3EFjje898
         zIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774215078; x=1774819878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IkWmMBGqLU53ZHn70d7vN2dCAh8bPswasxv95uuwbGY=;
        b=ST2E2XmBXp2B2SCemM8Lf/A+T266Y8TK2xTH6xS0PG9yWPp/vQ2qKQDpnJ1Bw+BoWT
         boVOnAyAxSlzTseOQ3NZULdo/fII3qKY5+wm2xFI99C1YtEK25QTk+g+W2GtkjSzvxkd
         nxJWjKx9uEZpWNxel9qe/G7Kv6cqt3gOzEwtnmuACpj5G1rqLVQtWF0pkT/TWoMf0y1k
         Mr0O7UH/cqiYwj05/LFB1foouu6GjlX8Xc3ocrApzGxUpTAuOxafUHbtZ6V+It+K9lb5
         QshMsIeehbmPjgPWvl+mAW3r6K0om2aq/MaqJL9QGDVFaKC1IRoupXu2t3Oe4a33yLIS
         1rGA==
X-Forwarded-Encrypted: i=1; AJvYcCVt/UgLEQ6H39iTRTBxFywrYPsxnB/BTqvUMJkJiOo1FjtsrdbTki8lE0DodosRUzbQv/zAymbB8c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDruvV9m0Qhrv8VWaCxgMhCxlAdQjZBOm4wMDasYPxP26IYH21
	bmX+6RMYMgwbasbeBK/RUKLbCTTu0IHfutAmAfqQ5Si1w57vkRZj++Y1
X-Gm-Gg: ATEYQzwkYpjJBcH3ukBrcXHeU4mwFzerw2kPZLthEjQURUwiGV612I3jIj0NzV4Jn1M
	v9kvnHv7xpTA0pDAhIfVk2NW/+L3RVn27OQ2SSvfKRUgku6hkB3WrLtzFvtY3ExxB4UqCrlHUOt
	a/j+878q+xIanyXdQ6V6cZfC11RXKIrz0g3TC70dX3m0Wtr2wf3aBVCJGqMoFYbnkwuIqCTDsCR
	sQA98lWWxNbWWX8SxQCRa5w+OswJ2g2V1804ME/8eRZ4zoZUJmuT80ml1ds6f0bNt7gnribPoFM
	v467adD7K6gb+DeZ4Fd7sVWkPQDpYFZ9c4SU8COwbTMbc9mXgA+d4fd43hcx30FP8VfKkok4f2u
	MYKJKJTu8UDRLLHqBVlpgjwGho5FFSQDhQR9bpDQFlwl1XmwA98l8bL/d82sjFLx/TVnNBfl/vW
	pZjFfjRvHcjG0a/xi3ZLJ06JTeZ4B1Ie/f/i9s1WleSNzZ5aKZipm2E3Asgec=
X-Received: by 2002:a05:600d:8401:b0:485:35a4:939f with SMTP id 5b1f17b1804b1-486fee297bcmr97759665e9.28.1774215077923;
        Sun, 22 Mar 2026 14:31:17 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae016sm23142753f8f.4.2026.03.22.14.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 14:31:17 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 18DABBE2EE7; Sun, 22 Mar 2026 22:31:16 +0100 (CET)
Date: Sun, 22 Mar 2026 22:31:16 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Steve Dickson <steved@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/2] nfsd/nfsdctl: default to starting with v4.0 servers
 disabled
Message-ID: <acBfpHr2e6LMmiGQ@eldamar.lan>
References: <20251008-master-v1-0-c879be4973c8@kernel.org>
 <a04afd6b-e295-4100-a785-2b6feb6b3cf7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a04afd6b-e295-4100-a785-2b6feb6b3cf7@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20313-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,eldamar.lan:mid]
X-Rspamd-Queue-Id: 064C72EAD9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Steve, Jeff,

On Sun, Mar 22, 2026 at 04:30:02PM -0400, Steve Dickson wrote:
> 
> 
> On 10/8/25 4:13 PM, Jeff Layton wrote:
> > At this week's NFS Bakeathon, we had a discussion around deprecating the
> > NFSv4.0 protocol. To prepare for that eventuality, make the NFS server
> > only accept NFSv4.0 if it was explicitly requested in the config file or
> > in command-line options.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Jeff Layton (2):
> >        nfsd: disable v4.0 by default
> >        nfsdctl: disable v4.0 by default
> > 
> >   utils/nfsd/nfsd.c       | 5 +++--
> >   utils/nfsdctl/nfsdctl.c | 2 +-
> >   2 files changed, 4 insertions(+), 3 deletions(-)
> > ---
> > base-commit: 612e407c46b848932c32be00b835a7b5317e3d08
> > change-id: 20251008-master-724587cca99a
> > 
> > Best regards,
> Committed... (tag: nfs-utils-2-9-1-rc1)
> 
> My apologies for taking so long... The CVE
> took longer than expected and there was
> some issues with recent patches,
> which caused another release..
> 
> Turning off a protocol version (v4.0)
> on the server by default which this rc
> release does, is not a small thing
> although with the 7.X kernels the
> v4.0 client is already off.

I have one small followup question on that. The nfs.conf reads:

[nfsd]
# debug=0
# threads=16
# host=
# port=0
# grace-time=90
# lease-time=90
# udp=n
# tcp=y
# vers3=y
# vers4=y
# vers4.0=y
# vers4.1=y
# vers4.2=y
[...]

Should the 'default off' change as well be reflected in the commented
entry for vers4.0 and read vers4.0=n for consistency?

Regards,
Salvatore

