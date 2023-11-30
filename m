Return-Path: <linux-nfs+bounces-193-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6F77FECD7
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 11:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205E7281BA2
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 10:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A98034565;
	Thu, 30 Nov 2023 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg6sS2iH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B77310D0
	for <linux-nfs@vger.kernel.org>; Thu, 30 Nov 2023 02:29:01 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50aab20e828so1073051e87.2
        for <linux-nfs@vger.kernel.org>; Thu, 30 Nov 2023 02:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701340139; x=1701944939; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pq1/+rVYf9qtUQ7i7SzbPq4zoOW2Kh1CldBRPHk9WNQ=;
        b=Rg6sS2iHHT3XagMBGcf5qalEnmCi6Cv17tjRfoYBdDThfYTar34dI27xOG7y4U8YtA
         6/aqQ9Hk2mLNYv8MhS1QVXWgmhAVkp8odOj60isRVPAzgRR3ngpbIjwEwY7fmuDsG4KQ
         23XKHinXdCWzP0AJGcftY3uEHJHO1gP7V5roLIO3ilKWxoDIX4HESpzT2SW8rqvyUAqH
         jkLzZx+ZA/sfGU5UnPbbJwH7C89Bs/GPINSTvl7DYhP4Yjy7MA+mz4fDQZaOur7kzJV7
         E7QAvlhSCDigHd//UGhkD4YLo6iZT9gt1gU8nMIL4qx563UIFo3ZW+cwEUpAH6JZlBio
         sWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701340139; x=1701944939;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pq1/+rVYf9qtUQ7i7SzbPq4zoOW2Kh1CldBRPHk9WNQ=;
        b=nNWzEaEp2rmh/jLLGg6Nt9/xEDMZRP8aaTtAHlGKNq2epZOmoQUEHA/Fg98ZFtLQzx
         OlMocesJKV6NdKVinzdPeZpME+5TljA+PmeZLIX5RuDfRXcQLeNWW5TpbDbMDRTeDFEO
         W5oLBVeiD0TZXVPLN1xqQWwkxOKmoUcv61hx4Vvd8yc2EHJ7J6FA/LLcXZmhRHp4R7e9
         CMKqHtbO2iUxUparcmHkfHMz44wUl/Ant5leaESv1R4tKh4IQ1tk54qCeRKgC5xbuCVB
         vH/Y8d9C+FeqlpP2fSDClftdjXdIM4Ui2fvPPhhDskqhzsZOG2XMkisMFkUlfisvm61Z
         42VA==
X-Gm-Message-State: AOJu0YyGcSHwLjoFxbyzJdoUKgpdE/s+CEKDP1/vyDfkxhBPMmb3bM9V
	r92SBvwVypoL/4z5htnEaFmKDPChWny7WssAFjtsH/3P
X-Google-Smtp-Source: AGHT+IELw01I/6sf795N0ivPGs6crYQlDmT9mOhdx2kaR7fjv8fi/sUXWcx1AapnpJG9NIgdp3C6IuwbNGHeTlfN9m0=
X-Received: by 2002:a19:7507:0:b0:50a:778b:590 with SMTP id
 y7-20020a197507000000b0050a778b0590mr12211757lfe.68.1701340139322; Thu, 30
 Nov 2023 02:28:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdcCKBGR8FUSEeEMngKqwz98Xc2HFXnhX5i_1ioEiuaQg@mail.gmail.com>
 <83a30ef92afa05d50232bd3c933f8eb45ed8f98b.camel@kernel.org>
 <CALXu0UerMnjs9y4gQTvy-v-gqSgO2imFbMAZ87LFj1tQqvfjiQ@mail.gmail.com>
 <0d7966163db13d71cb4679d51db5cacf91f42b6b.camel@kernel.org>
 <CALXu0Uf9LiNL7SA57vSq5pMBVBZESWexcRwDR0XMc9fFpPiNkQ@mail.gmail.com>
 <CALXu0UccoNs0A4MjQH7gPboarWyZcRQzsy2zJRxk51LR0hGDVQ@mail.gmail.com>
 <ZWDgvFfkAF8e3MFj@tissot.1015granger.net> <afb9281a81c2001588dbaf46e0ac13fc99ffbb41.camel@kernel.org>
In-Reply-To: <afb9281a81c2001588dbaf46e0ac13fc99ffbb41.camel@kernel.org>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 30 Nov 2023 11:28:00 +0100
Message-ID: <CALXu0UcCzV1g0z6Uka3tKEhJc0MFVj89TzWKeT7upXuOVYWE0Q@mail.gmail.com>
Subject: Re: <DOT>foo gets NFSv4 HIDDEN attribute by default by nfsd? Re: How
 to set the NFSv4 "HIDDEN" attribute on Linux?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Nov 2023 at 15:52, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Fri, 2023-11-24 at 12:43 -0500, Chuck Lever wrote:
> > On Thu, Nov 23, 2023 at 11:24:10PM +0100, Cedric Blancher wrote:
> > > Also, it is legal for a nfsd to give the DOT files (/.foo) the HIDDEN
> > > attribute by default? Right now on Windows they show up because NFSv4
> > > HIDDEN is not set, and it is annoying.
> >
> > I suppose an NFS server could do this, but I'm not aware of any
> > other multi-protocol file server (eg, Oracle ZFS or NetApp) that
> > does.
> >
> > Dot-files are obscured on POSIX systems by the NFS clients and their
> > user space (ls and graphical file navigators). I don't see why the
> > Windows NFS client can't be similarly architected. Or perhaps it
> > could fabricate the HIDDEN attribute for such files itself.
> >
> >
>
> Question. GETATTR operates on filehandles, which are roughly analogous
> to inode with Linux nfsd:
>
> $ touch visible
> $ ln visible .hidden
>
> Is the resulting inode and filehandle now considered HIDDEN or not?
>
> These kinds of issues are endemic when trying to map MS Windows concepts
> onto Linux (and vice-versa)

No, this is actually a good example to show that it *WORKS*.

1. Assuming Linux adds support for a user.xattr to set the NFSv4 HIDDEN flag
2. Assuming nfsd can give the flag on a per extended regular
expression basis depending on the filename, which would default to
"^\..+$" (all files starting with DOT get the NFSv4 HIDDEN flag)

Then of course [1] overrides [2], which means that the eregex is only
used if no user.xattr sets the flag.
In your example the file "visible" does not have the HIDDEN flag set
(no eregex match), but the hardlink would have that flag set.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

