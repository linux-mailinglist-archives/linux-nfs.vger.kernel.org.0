Return-Path: <linux-nfs+bounces-8038-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAC59D14B9
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 16:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E4D7B29600
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 15:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900A01AAE33;
	Mon, 18 Nov 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="A46JdFkx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3849212EBE7
	for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944623; cv=none; b=Yc7+r9vbIRnKrI89Bcz9WFfb2WQOLthmaLZGHl5CR6lO5HSDyOivNwLXUirJmqY2gbO1ys1w3xnPf/YQystApOmkomtLT+whwJhNoMuVryMFBnhqVZbh2l4mBJrd4+3nzsZ3/dL2+DoOVTlqW1+7CtBVLqQpSazhwIm5TwfizEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944623; c=relaxed/simple;
	bh=kcDogkhRG79bRF/hTH7bZrbcC7Fk/NsfF19NEGAiLck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpj9Uj0qkHcil/CsLNc2mYt/e+s1mlL5dokSFIpG7hoPYB8TilqSnYm03G7elhLQrLKw5TAzPc1oLOBudgP86ybdgUi8gtHLvOBl2Xo8N+VPyim/ZhZcorfxgvGFTXbXpq/A3pilqyKse3Dkr8C4GSEFykAJFbToGD8+niZKhC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=A46JdFkx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfadf851e2so2993656a12.2
        for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 07:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1731944619; x=1732549419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KpFUDVrt0XeMTi+HuH1IPRtMoXAq5gtnsQCg87HD2eA=;
        b=A46JdFkxweNjjV6fuzXcXPENrUpCoPJEPnF1C4tBjIUrbeuftbDJW9XUXlDpFa6N4J
         R/c4uK9TkufevQ/TKWL16VFdiHQOuH6zqX5KfEXAfEHAf7Klssn62pCF2F62/hZk07Sc
         Z3us7Y5QNGbkilI/X7G5RF/56HZqtN1az4nhVXHw7tC2CVGYQic5YYitw5zbp73S/q30
         VHD2BZAv7OOgEymcmtrPMA4D1aHHWttLAS9FWVvI/7KNOR+NHzF5VP7dDgoRUgQh+pDP
         YfSVAB5yPkwEBCTFfKlkWcMNJyFLi8lph5HX2Pmfy+D0DeWPZhaawoesMKMZpy3eiqa+
         WCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731944619; x=1732549419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpFUDVrt0XeMTi+HuH1IPRtMoXAq5gtnsQCg87HD2eA=;
        b=cskdlxwyHu4MMTJgZR0dt277Z4W6sdSfsJ6h64c53xwmQ7MuGOWakdLt0Rkl/Z89ty
         4XkDHJd3GcdCKp77kWMrRYz2ERGh6lm29WfuFOdSKt6FXICCyLDyIH4V+az4R2rmheYU
         Ood6fkGjjCCAT+dqT26+Tjgv5zGOqffTxVXtpyy9zlbjthtrjrHRWqNdqcQaY8L7zg77
         tgQu52ENYNvH2E+Y5ufDZqv8vr75YI3NmSrQPUR+tZotSJalaPGDXpipe2E90A65kM6D
         1TH5OHcxnt0J63hlRBQZ5NnsAWwX2STK6RMiiGHSG5xo2L8ST9+RYvxUVvacez05RiXC
         YZjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9+67bBPvCTebhwllYOldG5b240fTTEyzJZIdKemrJExNbIvd7dEhabMqP7g5y+2PiwBUuq1W3AAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxykII1qpVtRI3MDf+XVaXysB1YpY3icQiv9WXkegkCsCYoIjtr
	ebpSZ9yqYs/zqBe7riQocjfGxhZku54+/3ieRXaCQ9mKF1XqdfwEIVq6T2ZHRLUTVEVQxcy4aA7
	xFEDusdnXsiCBNgX1Q1WZUjYrddxeNgPaxFvT1g==
X-Google-Smtp-Source: AGHT+IEnJBi3W6J9hZ7o2iCUmeiOmIJiieff1XBsxop6dgOi2xNLrGsfXhEe13tr5HjxzNYYysu2pGuJOJ5UaRY4GFs=
X-Received: by 2002:a05:6402:2688:b0:5cf:bfab:f0ca with SMTP id
 4fb4d7f45d1cf-5cfbfabf229mr4243558a12.32.1731944617944; Mon, 18 Nov 2024
 07:43:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113055345.494856-1-neilb@suse.de> <CAPt2mGN7is0xOqBxy62WwJ_iPXQ0fjvpv2MVEEwYqxvZSFY30w@mail.gmail.com>
 <173164656863.1734440.5228838461812970848@noble.neil.brown.name>
In-Reply-To: <173164656863.1734440.5228838461812970848@noble.neil.brown.name>
From: Daire Byrne <daire@dneg.com>
Date: Mon, 18 Nov 2024 15:43:02 +0000
Message-ID: <CAPt2mGM3U0n_-TRAzC9-uwURy56xO81aLeng2uBjvPU=PNhzLA@mail.gmail.com>
Subject: Re: [PATCH 0/4 RFC] nfsd: allocate/free session-based DRC slots on demand
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 04:56, NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 13 Nov 2024, Daire Byrne wrote:
> > Neil,
> >
> > I'm curious if this work relates to:
> >
> > https://bugzilla.linux-nfs.org/show_bug.cgi?id=375
> > https://lore.kernel.org/all/CAPt2mGMZh9=Vwcqjh0J4XoTu3stOnKwswdzApL4wCA_usOFV_g@mail.gmail.com
>
> Yes, it could possibly help with that - though more work would be
> needed.
> nfsd currently has a hard limit of 160 slots per session.  That wouldn't
> be enough I suspect.  The Linux client has a hard limit of 1024.  That
> might be enough.
> Allowed nfsd to have 1024 (or more) shouldn't be too hard...

That would be cool - I'd love to be able to switch out NFSv3 for NFSv4
for our use cases. Although saying that, any changes to nfsd to
support that would likely take many years to make it into the RHEL
based storage servers we currently use.

Our re-export case is pretty unique and niche in the sense that a
single client is essentially trying to do the work of many clients.

> > We also used your "VFS: support parallel updates in the one directory"
> > patches for similar reasons up until I couldn't port it to newer
> > kernels anymore (my kernel code munging skills are not sufficient!).
>
> Yeah - I really should get back to that.  Al and Linus suggested some
> changes and I just never got around to making them.

That would also be awesome. Again, our specific niche use case (many
clients writing to the same directory via a re-export) is probably the
main beneficiary, but maybe it helps with other (more common)
workloads too.

Cheers,

Daire

> Thanks,
> NeilBrown
>
>
> >
> > Sorry to spam the thread if I am misinterpreting what this patch set
> > is all about.
> >
> > Daire
> >
> >
> > On Wed, 13 Nov 2024 at 05:54, NeilBrown <neilb@suse.de> wrote:
> > >
> > > This patch set aims to allocate session-based DRC slots on demand, and
> > > free them when not in use, or when memory is tight.
> > >
> > > I've tested with NFSD_MAX_UNUSED_SLOTS set to 1 so that freeing is
> > > overly agreesive, and with lots of printks, and it seems to do the right
> > > thing, though memory pressure has never freed anything - I think you
> > > need several clients with a non-trivial number of slots allocated before
> > > the thresholds in the shrinker code will trigger any freeing.
> > >
> > > I haven't made use of the CB_RECALL_SLOT callback.  I'm not sure how
> > > useful that is.  There are certainly cases where simply setting the
> > > target in a SEQUENCE reply might not be enough, but I doubt they are
> > > very common.  You would need a session to be completely idle, with the
> > > last request received on it indicating that lots of slots were still in
> > > use.
> > >
> > > Currently we allocate slots one at a time when the last available slot
> > > was used by the client, and only if a NOWAIT allocation can succeed.  It
> > > is possible that this isn't quite agreesive enough.  When performing a
> > > lot of writeback it can be useful to have lots of slots, but memory
> > > pressure is also likely to build up on the server so GFP_NOWAIT is likely
> > > to fail.  Maybe occasionally using a firmer request (outside the
> > > spinlock) would be justified.
> > >
> > > We free slots when the number of unused slots passes some threshold -
> > > currently 6 (because ...  why not).  Possible a hysteresis should be
> > > added so we don't free unused slots for a least N seconds.
> > >
> > > When the shrinker wants to apply presure we remove slots equally from
> > > all sessions.  Maybe there should be some proportionality but that would
> > > be more complex and I'm not sure it would gain much.  Slot 0 can never
> > > be freed of course.
> > >
> > > I'm very interested to see what people think of the over-all approach,
> > > and of the specifics of the code.
> > >
> > > Thanks,
> > > NeilBrown
> > >
> > >
> > >  [PATCH 1/4] nfsd: remove artificial limits on the session-based DRC
> > >  [PATCH 2/4] nfsd: allocate new session-based DRC slots on demand.
> > >  [PATCH 3/4] nfsd: free unused session-DRC slots
> > >  [PATCH 4/4] nfsd: add shrinker to reduce number of slots allocated
> > >
> >
>

