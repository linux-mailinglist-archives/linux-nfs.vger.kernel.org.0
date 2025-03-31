Return-Path: <linux-nfs+bounces-10966-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5ACA76CE0
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 20:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9887A2DA9
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9D5210F4D;
	Mon, 31 Mar 2025 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxgvsU8V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1D226AF6
	for <linux-nfs@vger.kernel.org>; Mon, 31 Mar 2025 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743445509; cv=none; b=FIyGJIBF0xttj5Hme9SfKmnWYECSFKTz8AEqsmrwwmsYB4uInyLXiXphCVpGBgDc6Z1dnH/w3vbgi0V0rzWakhB84SA/lXbHNnKvi7mUPuFATcj1mMs/FNL5vmgBeCHoCKCJhngXfAHtpbUFeg29Ot/klfcjjMB2JHN/uhDbF+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743445509; c=relaxed/simple;
	bh=mO2r4g62y86h9bUUjAx2dHkv0nxBfmza3yb7YODJ774=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzO+ti8E1DNgB7zn8IKYcG8UdW/2cq710u/vms6SjZSuOFob0aaXP2hIbbW5+d2eSbZIFVW38cjeQGngTt+EI0XXLr0Ngzz9uKdlcwp49K+DybiicbenrhTKc4dPVTBY1B5YsrT5o49SAQ0hmE3FfEMmp+jUAoetkJ0HMza3Lzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxgvsU8V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743445505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHbz24c2KdMYTlcS1tG8Ys4XOdXgRQ5IsY/rW52M2/Q=;
	b=bxgvsU8VxNzSPSL5z8oQU7tyUPi7s5q3xBg+qCXvOEn4GRmA1uxoF3WA+QTkH2GVag2yne
	t4jEiEsfA7dvLfsmisDTxd08KyXNR+k+8pAaMPO5LSkWNybdZ4+rfADCJWxASr9j3BX0mb
	A0Eh23hVHh1xleHaNHaoZsoY+3V3RQc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-ZKnv4LqKMbKcFckl-TM4Og-1; Mon, 31 Mar 2025 14:25:04 -0400
X-MC-Unique: ZKnv4LqKMbKcFckl-TM4Og-1
X-Mimecast-MFC-AGG-ID: ZKnv4LqKMbKcFckl-TM4Og_1743445503
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e5bde483cdso4438137a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 31 Mar 2025 11:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743445502; x=1744050302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHbz24c2KdMYTlcS1tG8Ys4XOdXgRQ5IsY/rW52M2/Q=;
        b=ZGOL8qQgGbZZ5fLWlXhbJrqvRFTm3F/K3ku5VcvWIzdvGYl7OWs2fkNNlBnj4SgFPq
         4Ce3PVpmw4N4DzBXwBFNdAt7fy9cfMBt2JuvEs23+BcOIFVtiuFH83hHkrcVGEN7x3G3
         PyNHSCBkj/E9jh3pbDOsrPhCSg3EJCFivzKmyDXEDsx49qPEt5p3WJvwQErO1UFrplwC
         MnoRZ+wCYil1lVKrCw+c3EzbyFmlshfbNXf2Dv0PJF1Qs2Wgr55QfugZLL6dVL0VPrMI
         gWHHuJu3CfZLv0OkweNp8pR/KbtIQuVXTsm15ESkVvV3qlq8ce/aGdmp5nRXelYRSinv
         lacQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo7PK4Tpb7q/LNI+UN0cJ8QX7qA2pmGbuRlHPHe4nISZNpUhq8Z7TX/1F6GH+EY8UXUPYaCIAPuu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOWW2Pza2PDIsWNKrB+m30ZKHrc0a8Fayaw5mMTklYPS9QwZL
	IMqFtTHiFmSDPDVBdDvJTi5qUV9zyRmBgiAILJyWPnzt8bA70I6HFULjyA7XiAWJH74929LMAkF
	nfyv62ExeyqYUH8/iDcCWA24lJBm1M+/RzHjNpDq9pe9blG+BBfnJ3FIDkj12pVpf7diUEEAXQq
	rIu8YBg46y9y7vARKXHjdLsC8yB7lntpMom6nii7LX
X-Gm-Gg: ASbGncv3bcN0Qcq/YKqlFSVj330rAjTW5JRjCCHRa27Lunrd46BHZXV730PBlfSeo7W
	+y7L7y6xI+2DJQQaGZrGNexhAXFlSg/M3b8ucGRNak1uXa3/BHyK6pbSLMCEUa/+DpVISed8X1Z
	CjWPbnej9/c05DOUohGqhaHffNmLaU8Rc=
X-Received: by 2002:a05:6402:51cc:b0:5df:6a:54ea with SMTP id 4fb4d7f45d1cf-5edfce908acmr7889096a12.11.1743445501641;
        Mon, 31 Mar 2025 11:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN3n0yF0t79gg5tWFNujCFDexlP2fWy/MgQnDWjobfZCFEWjZpdmHOFfwPVsnYl2dQeEGSpws73aIEz/xUoC4=
X-Received: by 2002:a05:6402:51cc:b0:5df:6a:54ea with SMTP id
 4fb4d7f45d1cf-5edfce908acmr7889077a12.11.1743445501237; Mon, 31 Mar 2025
 11:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-5tyHWB9+Q9ONmWfF2LGe6wO1hZXvx2vEHb441Q3XkjzOFmQ@mail.gmail.com>
 <174337981427.9342.10894606812592381794@noble.neil.brown.name> <f9c6169d-edc6-47be-b6db-ec7eaaeb33cc@oracle.com>
In-Reply-To: <f9c6169d-edc6-47be-b6db-ec7eaaeb33cc@oracle.com>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Mon, 31 Mar 2025 14:24:49 -0400
X-Gm-Features: AQ5f1JqHYeS7cBf8a9RQKvptkaOcNRAW6WmfJshNLT83U7p9c7djOX8YEAk9t6g
Message-ID: <CACSpFtDd0u3rdePuFYLZVVS0j_arvmox_z9AQTCzQva+iv8rWQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in nfsd_permission
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <aglo@umich.edu>, jlayton@kernel.org, linux-nfs@vger.kernel.org, 
	Dai.Ngo@oracle.com, tom@talpey.com, NeilBrown <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 10:49=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 3/30/25 8:10 PM, NeilBrown wrote:
> > On Mon, 31 Mar 2025, Olga Kornievskaia wrote:
> >>
> >> This code would also make the behaviour consistent with prior to
> >> 4cc9b9f2bf4d. But now I question whether or not the new behaviour is
> >> what is desired going forward or not?
> >>
> >> Here's another thing to consider: the same command done over nfsv4
> >> returns an error. I guess nobody ever complained that flock over v3
> >> was successful but failed over v4?
> >
> > That is useful.  Given that:
> >  - exclusive flock without write access over v4 never worked
> >  - As Tom notes, new man pages document that exclusive flock without wr=
ite access
> >    isn't expected to work over NFS
> >  - it is hard to think of a genuine use case for exclusive flock withou=
t
> >    write access
> >
> > I'm inclined to leave this code as it is and declare your failing test
> > to no longer be invalid.
>
> For the record, which test exactly is failing? Is there a BugLink?

Test is just an flock()?

>
>
> > That is technically a regression, but
> > regressions only matter if people notice them (and complain to Linus).
> > No harm - no fowl.
>
> --
> Chuck Lever
>


