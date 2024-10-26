Return-Path: <linux-nfs+bounces-7512-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 220499B19A9
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Oct 2024 17:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD45B1F21B1D
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Oct 2024 15:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CD4182D2;
	Sat, 26 Oct 2024 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXVpKY2c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFE21F95E
	for <linux-nfs@vger.kernel.org>; Sat, 26 Oct 2024 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729958182; cv=none; b=tJCTx9z/kasPAJQ+fI0Bwcl47I2fzkf+yYk/faeNS3Fs2p/N/EcGFQo3E/Rh/vnH1JlhR4i1AiMVJjV8hdfF9/FU7MAREXrsTW85MRfwVAR71D7CphKWMb1dh0fty/2nxXitKrgQ759tclNTfNI7fDI5kNl3fuP5qcVZ8DLgk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729958182; c=relaxed/simple;
	bh=MTtTD1nDbCf3QikSDQc9TKHroUxEXcVOLwR6G3/fVxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8ZH7yGVcdTX1lO0Z2jwqYXSUfPWAvmwEJitnxBsSQHkNv4H7BM2pxaGqXQb7aC5XEMBMmZ/84+hc77VxUQzSO+6hLqa7pF/SGjKaRO7GhitUmLw7iTvDOu6PmeRoNZXMVHwkBC6k9JwZxg4X8ffqvJPew65Hy1EbnGhPLAmGK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXVpKY2c; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9aa8895facso468940166b.2
        for <linux-nfs@vger.kernel.org>; Sat, 26 Oct 2024 08:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729958178; x=1730562978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30vapjy1EvStAdAoscYEqqN7vpEdB8I4JPd/vkWOEQw=;
        b=DXVpKY2cTnoh3Wa7I24iOmRtga+xPnStxwtWFLrCneztQD7Ah6iKYRckWjfYp+a6Je
         ve0RAujJP2ZNhD/og1nNB3gwb0HZZFDvBUyRWQ4FZX/U6iThxxGHx7sdq3jrjxMU1Gvz
         gZO5M2CQgBTGpB0QNq5KAKhsm3QbNJGJjU0U4tHI01GTDtviXi6U4TK4gXMcHVdhS9m3
         a2qpATjcJorFUIUqZgTZAMkmYCZoz0RalkA6XvROfKdnrO+IjRhz5SM1by+FwpczfSPl
         HcQWHnhbawGcYWV1fshQwIzedAAedsJZojzEoizoyskOXCC0+tWcNMWWpUFSAtBs5tpp
         Gu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729958178; x=1730562978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30vapjy1EvStAdAoscYEqqN7vpEdB8I4JPd/vkWOEQw=;
        b=PT8EnKrdwWCPp1zOfWTO54Zyhlu8/cTwyyq9aiy3/hU4WlW1pHCatn3sNC8BSZPcro
         NuVKbcpNZPIkp3IbsRNPNIuCO3g/WFbJbtxhANSokc5wpcc2ccKyZmeXo2CjdWSBNlNz
         0l18qHBac6+YfMv6dPEPvGGUGhq68aUB+hnfWFpo60iVvdZ/WaMUMivuKbzDJ2wuzlZN
         Zg0IF6p45oSqXwHHyG0vBVKLJwMAHnbb13CDSwmcrWRUDdp1x1azLAnVjK9mHf7uwZLi
         c/2gX3EGDkZBqo1CmmrH68ZvBIwMteSs5uTrGnszA9bfQGBBI0psDRkBKCpNkEytgm4e
         fGoA==
X-Gm-Message-State: AOJu0YzawCVF6TsJP4OQ9IFV6tML3oaadr5Tfui5NcFQdoJTUL1eTZgP
	3be8IwYchngauEGO/LfJHlLZS1gW1fTCJy/hV4EPu2SheOVxvSfrGgJlOgOH
X-Google-Smtp-Source: AGHT+IH3UVyFFuHgxnauMPKxG3Q9czX027kaRh+VDjwQHmanF/ZStDjlRyiLvQssa2N6ObKwrAARGw==
X-Received: by 2002:a17:907:728d:b0:a8d:4631:83b0 with SMTP id a640c23a62f3a-a9de5d65a91mr309874566b.5.1729958178347;
        Sat, 26 Oct 2024 08:56:18 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec8100sm185761266b.6.2024.10.26.08.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 08:56:17 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 0A2CFBE2DE0; Sat, 26 Oct 2024 17:56:17 +0200 (CEST)
Date: Sat, 26 Oct 2024 17:56:17 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: NFSv4 referrals broken when not enabling junction support
Message-ID: <Zx0RIWKfiI-aRahd@eldamar.lan>
References: <Zv7NRNXeUtzpfbJg@eldamar.lan>
 <e7341203-c53c-4005-9d70-239073352b2b@redhat.com>
 <ZxUVlpd0Ec5NaWF1@eldamar.lan>
 <Zxv8GLvNT2sjB2Pn@eldamar.lan>
 <1fc7de18-eaf0-4a1e-bd41-e6072b0f3d7f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fc7de18-eaf0-4a1e-bd41-e6072b0f3d7f@redhat.com>

Hi Steve,

On Sat, Oct 26, 2024 at 09:04:01AM -0400, Steve Dickson wrote:
> 
> 
> On 10/25/24 4:14 PM, Salvatore Bonaccorso wrote:
> > Hi Steve,
> > 
> > On Sun, Oct 20, 2024 at 04:37:10PM +0200, Salvatore Bonaccorso wrote:
> > > Hi Steve,
> > > 
> > > On Tue, Oct 08, 2024 at 06:12:58AM -0400, Steve Dickson wrote:
> > > > 
> > > > 
> > > > On 10/3/24 12:58 PM, Salvatore Bonaccorso wrote:
> > > > > Hi Steve, hi linux-nfs people,
> > > > > 
> > > > > it got reported twice in Debian that  NFSv4 referrals are broken when
> > > > > junction support is disabled. The two reports are at:
> > > > > 
> > > > > https://bugs.debian.org/1035908
> > > > > https://bugs.debian.org/1083098
> > > > > 
> > > > > While arguably having junction support seems to be the preferred
> > > > > option, the bug (or maybe unintended behaviour) arises when junction
> > > > > support is not enabled (this for instance is the case in the Debian
> > > > > stable/bookworm version, as we cannot simply do such changes in a
> > > > > stable release; note later relases will have it enabled).
> > > > > 
> > > > > The "breakage" seems to be introduced with 15dc0bead10d ("exportd:
> > > > > Moved cache upcalls routines  into libexport.a"), so
> > > > > nfs-utils-2-5-3-rc6 as this will mask behind the #ifdef
> > > > > HAVE_JUNCTION_SUPPORT's code which seems needed to support the refer=
> > > > > in /etc/exports.
> > > > > 
> > > > > I had a quick conversation with Cuck offliste about this, and I can
> > > > > hopefully state with his word, that yes, while nfsref is the direction
> > > > > we want to go, we do not want to actually disable refer= in
> > > > > /etc/exports.
> > > > +1
> > > > 
> > > > > 
> > > > > Steve, what do you think? I'm not sure on the best patch for this,
> > > > > maybe reverting the parts masking behind #ifdef HAVE_JUNCTION_SUPPORT
> > > > > which are touched in 15dc0bead10d would be enough?
> > > > Yeah there is a lot of change with 15dc0bead10d
> > > > 
> > > > Let me look into this... At the up coming Bake-a-ton [1]
> > > 
> > > Thanks a lot for that, looking forward then to a fix which we might
> > > backport in Debian to the older version as well.
> > 
> > Hope the Bake-a-ton was productive :)
> > 
> > Did you had a chance to look at this issue beeing there?
> Yes I did... and we did talk about the problem.... still looking into it.

Many thanks for the update!

Regards,
Salvatore

