Return-Path: <linux-nfs+bounces-6948-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 082649955CB
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 19:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A36E1C252CF
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 17:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A297F13BC2F;
	Tue,  8 Oct 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqS+sJ+X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDD920A5FF
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409019; cv=none; b=ZwXImaqgEVq0+52R951T0zsAhj0UdU7DZ/GxzlEAczGEd1FRMGe3gEw/B5OEiUKzPV/2T0kZCcusFSxn3wi6GAA1nQE/ufvSXJsWpxw4boI64uoyUHDAOUWfSYR305ddZ3rDi6/E9+MdYALUNYVI4DHMPv9i4R11W0/eXrNv4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409019; c=relaxed/simple;
	bh=MEAowTIs9B6ucEs2WWgxfjYvBWfoswPfIgFCG+Z+mJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgeakvN0T1QjbMMCkp9EGY93CIXhYt5mPxj7sATV7ta4D1Y7edsxvT5vmJtQNrYZaFlhgcroVC2YBXC5qeaXDbia2j+SmvFYxhEc35K7d12n9L0BEWMnN8S2Jl/GRE4qNhgIuqJ4bFJJBFc2UjyFL5DGOKsROpNGq35JGjuDElM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqS+sJ+X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728409017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MEAowTIs9B6ucEs2WWgxfjYvBWfoswPfIgFCG+Z+mJk=;
	b=fqS+sJ+X7S3dRbkdHrt9KrZ+/BxYM2NgY3ozwzqEQwyRqVXoBeV6BWVvxvkXNaQYkLAOsb
	KB6QH0dEr+SXOWnVYMsEMZozQ3qICP1x65xO6IDyKxOhtZRFwe+cAXuMOi4PGAaz9eeF5J
	EGDb3xb3Bu85RvJJKW72+KmEFn87wqU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-fOwT_T1mMgSmvbzgywlb4w-1; Tue, 08 Oct 2024 13:36:55 -0400
X-MC-Unique: fOwT_T1mMgSmvbzgywlb4w-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2fabdf87c02so44431231fa.3
        for <linux-nfs@vger.kernel.org>; Tue, 08 Oct 2024 10:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728409014; x=1729013814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEAowTIs9B6ucEs2WWgxfjYvBWfoswPfIgFCG+Z+mJk=;
        b=k+IP84pzu1vo+RGkOnxQFjX0HnceaaliDjMKvDwTQmAEu4BThc5XSxuu6ov4vY/dj8
         RWscCzfg4iKIw7kwyM3eqjEGNXt2ShoCd5fIhq6e9UChxinN88YRQi56aR7V/Z+F5h+Q
         1BawI+I1qa0hMVYEMOr09c6+6pW1Qpn6j0CCLWNyLWl8FiiAJqR0i1dUDxdIz2LGWPbh
         8VaZegN8LSrXWDRq0gdLa/o+Ba4nL+HT6m0aMRD/uRXVfQDXJ6aKyK1hXnFg53vdyOri
         R/mSjQZOY6nRWf6sx0FfdByl0hv/zr5UyNRqY3uEutBFwUID3OMjs/tRisiV07312/XH
         SFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMvscgX4QC7qjDmzTPS9Rr15mSH2DGvGQ/jWPMUJnm2XxaBTfcrjr5PPYXbEfpzL5PPayJnoPuslo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXT8PvKe0zWq8f7Dy4q2Z4N9TCQxg8dTeG+n/ZO+Fp4d9ZHdZf
	XJAyDox3ZjePSlOSif5oBWBcXEdOxJxn8RmHscMD9lPaw/cpO2HUiw4RwRjBMfjOzniJI1n8kcy
	1ZmGWzEjGzQ/VaYyvqkmTtMSWF1F4Tn1Wx1qlewihrzABQ6MOd3xvb9uXW8PGrIyVCg39HZ0gKd
	b6GtubJKZ5ldBFDCSOiS4dcuGRLPAM4TiA
X-Received: by 2002:a05:651c:4cb:b0:2fb:51a:d22 with SMTP id 38308e7fff4ca-2fb051a0f84mr41785851fa.23.1728409014235;
        Tue, 08 Oct 2024 10:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyxvYUsWDXwuq1qgj9KeuoeJvQZvdLhpB95VL+Hxq4QwXy+WT778qu25XObcmaxbqJ8/S99KWvEgS8Zzxmmi0=
X-Received: by 2002:a05:651c:4cb:b0:2fb:51a:d22 with SMTP id
 38308e7fff4ca-2fb051a0f84mr41785681fa.23.1728409013810; Tue, 08 Oct 2024
 10:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003151435.3753959-1-aahringo@redhat.com>
In-Reply-To: <20241003151435.3753959-1-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 8 Oct 2024 13:36:42 -0400
Message-ID: <CAK-6q+imtq3=pcM-gEnAYyyA_uYZsBpPbirCOh5yiDs9fr326Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] nfs: kobject: use generic helpers and ownership
To: trondmy@kernel.org
Cc: anna@kernel.org, bcodding@redhat.com, gregkh@linuxfoundation.org, 
	rafael@kernel.org, akpm@linux-foundation.org, linux-nfs@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear nfs tree maintainers,

On Thu, Oct 3, 2024 at 11:15=E2=80=AFAM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> Hi,
>
> I currently have pending patches for fs/dlm (Distributed Lock Manager)
> subsystem to introduce some helpers to udev. However, it seems it takes
> more time that I can bring those changes upstream. I put those out now
> and already figured out that nfs can also take advantage of those changes=
.
>
> With this patch-series I try to try to reduce my patch-series for DLM
> and already bring part of it upstream and nfs will be a user of it.
>
> The ownership callback, I think it should be set as the
> kset_create_and_add() sets this callback as default. I never had any
> issues with it, but there might be container corner cases that requires
> those changes?
>
> - Alex
>

Can we have those patches applied to the nfs tree? According to the
udev/kobject maintainer it is fine to take this in any tree that it
needs to go through. [0]
I made nfs as a first user of these new udev helpers functionality, so
it should go through the nfs tree if there are no other issues with
this series?

Thanks.

- Alex

[0] https://lore.kernel.org/gfs2/2024081519-caddy-monstrous-b37d@gregkh/


