Return-Path: <linux-nfs+bounces-3575-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC238FF859
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 01:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C920B24F64
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jun 2024 23:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16371B5B;
	Thu,  6 Jun 2024 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLIrHX0A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BA113E8BE
	for <linux-nfs@vger.kernel.org>; Thu,  6 Jun 2024 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717718033; cv=none; b=KfebUrMoPZRE9xWDpA65jAPB+xLt9WK78k5FF3Cb7g0HXXxcmJvLMFDiuhiJ/pZeFl/nqXEUIxa4/tVMdUMJvCpJrT2kKS4E0BnInDLa4+uj75rqCvaNn0qoqmSzhHFbcH0JHs/HWz5agtZfvQCB5kHfcaO624NPUNbvQ7SpdPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717718033; c=relaxed/simple;
	bh=IZBFjgzGGNHMCkmn/RBji5sawPu6HSlQ37CwOI9JZIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WaAP054gHhpgXk7owvd4uexzAyaPAeEGCLjGNBGT8PI/hHeF0Lt3QDWaXvYIV3lejVBidjF0ck2aGRHvk9AB22pLXY2n9yVil9f5ib3K+EM/6sJ6ufabPnNAM9f45RUfG8saYdRfTBN79LTul7LG9npILpohToojdYT/1W0RLnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLIrHX0A; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b90038cf7so2300538e87.0
        for <linux-nfs@vger.kernel.org>; Thu, 06 Jun 2024 16:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717718030; x=1718322830; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axo9BzJIrL8gWIw0K7sD90OAhBGpwB5fj0TKWcQq1W0=;
        b=HLIrHX0AVm5IjW7AHeO8AlO2pFTc1W/NiNcgapDoC9V2EEljSSPnoN182MNe5sBXFj
         w6DA4CGesYqFRAZoxbql2mOD8zn47jdvciT4P0Yift4CW5glrIsLZdEvCihpr4joJq1c
         CAeu3GAZdmF1jQ/COEJHKSw3GsX82sNvY/16cH/K3kWOaRaQvgsC2MPR4cch24czHD9i
         iX1zta/8WOcMUaeagaDTu1BBz1CaIZgN5OlcX9Q0XduTURiC7bydJZifmYquROZKReK4
         olZVXQH2118wigxscVSDpUglmaPWLxcxouubIP/ZLEkAzHRbT5PT4RLVlHng0m8owCRR
         iJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717718030; x=1718322830;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axo9BzJIrL8gWIw0K7sD90OAhBGpwB5fj0TKWcQq1W0=;
        b=RSf2YQ+UCMlUEZxnQW1A5GDHD6HDnmKJ4Rps9DXQzPoIt1p1RSEa1yo6g1F9zu2OII
         BlZHKY5aewy3yVe6ida1yWb0+7BAKbGvfh04zpG24mKyQMylNu3GwJCw/uJoiiiR4RFq
         emDtlE/SBrG4Wq+MnlRS+QMuBFOvDxOX+IPDZhRxqs/d4T4OXdq93pySmnrWAPnMNzUQ
         DbOs3OIg8SlUsRmg77Sy9IS2eP5j88kEGlaVqD+tVwIsDVv+nCyvMFQK2EFKh5Pkz3yL
         f96iWfMDmml98VX0DKa1dF0jSTXlJg0YUoAXjcUoOkXsNUKA4yjan2kvY/4MvafBDRKj
         5Dxg==
X-Gm-Message-State: AOJu0Ywyveq0Na6KMAb6XSaNhcpv5w8kvaNAgnOo90oNI43JzUFSzZEl
	AFW2+TYjKZq3o27OeTGUu5zXe+eg5b2kEbUkU607g/jAjTud1pFcG2kW4cns3oWbwNDPqQQHjLt
	p3XoWAAH5fezbULPBaeyIumeye595Z7Ma
X-Google-Smtp-Source: AGHT+IGXGRBwrWBQZKQM/+mtWSadksFI2p6EF0fSBiElgrVArmJx2tOAgQUbGW/0+l+ar3X0LAxLspVzYBeMngQjBXY=
X-Received: by 2002:a05:6512:3d8f:b0:529:adb8:dfc9 with SMTP id
 2adb3069b0e04-52bb9fd2a20mr694318e87.66.1717718029767; Thu, 06 Jun 2024
 16:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcBMY1mrgEgy4APSiFXDP5u=64YXNjiHHjh8RscPsB3row@mail.gmail.com>
 <b25436fa457256f0f409fbc33f60c13e8ab6af12.camel@kernel.org>
 <96A320F4-AFC1-4DD9-8D5D-784F13DE94D4@redhat.com> <CAAvCNcBjuTLwsLb7nQxaS_O8PVLGPxk=6y2Wj8rp3se0+YxvPQ@mail.gmail.com>
In-Reply-To: <CAAvCNcBjuTLwsLb7nQxaS_O8PVLGPxk=6y2Wj8rp3se0+YxvPQ@mail.gmail.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 7 Jun 2024 01:53:23 +0200
Message-ID: <CAAvCNcAe4ho539uhJ32qQJj5dBxBBAbKgPXXC15R4b=axtEvGA@mail.gmail.com>
Subject: Re: Implement NFSv4 TLS support with /usr/bin/openssl s_client?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 02:05, Dan Shelton <dan.f.shelton@gmail.com> wrote:
>
> On Thu, 25 Jan 2024 at 22:11, Benjamin Coddington <bcodding@redhat.com> wrote:
> >
> > On 25 Jan 2024, at 15:37, Jeff Layton wrote:
> >
> > > On Thu, 2024-01-25 at 03:21 +0100, Dan Shelton wrote:
> > >> Hello!
> > >>
> > >> Is it possible for a NFSv4 client to implement TLS support via
> > >> /usr/bin/openssl s_client?
> > >>
> > >> /usr/bin/openssl s_client would do the connection, and a normal
> > >> libtirpc client would connect to the other side of s_client.
> > >>
> > >> Does that work?
> > >>
> > >> Dan
> > >
> > > Doubtful. RPC over TLS requires some cleartext setup before TLS is
> > > negotiated. At one time Ben Coddington had a proxy based on nginx that
> > > could handle the TLS negotiation, but I think that might have been based
> > > on an earlier draft of the spec. It would probably need some work to be
> > > brought up to the state of the RFC.
> >
> > Yeah, its' a little bit rotted.  Wasn't super fresh to begin with, but it
> > did help bootstrap some implementation.
> >
> > You could also modify openssl to be aware of the clear text, something like:
> > https://github.com/bcodding/openssl/commit/9bf2c4d66eacccd3530fb2f3a0a6c87d5878348c
> >
> > .. but I think you're definitely in "what are you really trying to do?" territory.
>
> For example legacy NFSv4 client add-on? You cannot expect that
> everyone can or will update to the latest and greatest version, so
> either you have clients without TLS, which is a security risk, or have
> a way to retrofit them.

Is there a public NFSv4.1 server with TLS enabled, which I can use to
test whether openssl with
https://github.com/bcodding/openssl/commit/9bf2c4d66eacccd3530fb2f3a0a6c87d5878348c
can be used to plug in older clients?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

