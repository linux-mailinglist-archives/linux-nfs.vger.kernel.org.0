Return-Path: <linux-nfs+bounces-5025-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4489493A996
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 01:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68881F22CFE
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 23:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AB225760;
	Tue, 23 Jul 2024 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwBhZj5v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBC713C90C
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 23:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775988; cv=none; b=MM9rF+1HNbhk9zH6NMFYifsPMn0biRYmX9tLCmCTkCvVADcH1c9mFp82BmG+ilObuZ25OgYMC4CHnqclLbnvFYSkS1Wtp683DNgptx76K2jJtbBW0ugpQC4ywNqZ+/6ZP47eNtzo1oYEif51RS/2af5y9C07+VyqcA5pdcSjM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775988; c=relaxed/simple;
	bh=W/uA2Sb1VJ0fHrOQsPM7jx40414ParbC7xM9H/JQkC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=h42sdMMVg8wUZpSmqEznJdNu9wl/I0Jc+hQGTeImhUnkY5kBi4A78bZGDnaWpLEBXXIS5vsuYmkL6MvdPsu6CKdz/gK2vVkYxQLYSPWDDrh26aF6C3gHTtbV9lKWZHrIA5hUpt5gHs7JVNSWuGeRuhnofAyOsoSz0BreEKGJw30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwBhZj5v; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-260f81f7fb5so3128335fac.0
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 16:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721775985; x=1722380785; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/uA2Sb1VJ0fHrOQsPM7jx40414ParbC7xM9H/JQkC4=;
        b=dwBhZj5vCXzvvS+MFemMX6h/yzOb2c6Xlbsg5JlItMjIN8e/xhQY/72jdGqNwjsYf6
         g3XrvPbpT7x+CRp963xExg71lhhlYBtuaNnQTEIUvFionYiEqyrcmLW0SdcfsjU5A7L7
         lXzIZ6x4O9qhleTnRFtRBIdpEzcusUhk7Pr5CHJIPol80lkrQ72NdJca00QndiopnBqr
         AutKR3zEANSRsUoZ5s5EQnrqda/vkUcaL9aQJYLtBKbz6cGP4kn+Ls3APr9Wg9iJU2SQ
         yGkFtlRSw3aYGc2jphOuoU+OJ9WHnnfaDIHjmAbAjFRwORt68Kimz8FvoIqY4hGkf1Ji
         NtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721775985; x=1722380785;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/uA2Sb1VJ0fHrOQsPM7jx40414ParbC7xM9H/JQkC4=;
        b=V0Uz4CFTqL99S/oe+ZyFeu5jDWz/HoqUd6GjFLp03PRt5solcf9nNofO04+NXairAs
         8j9LMo1PPWQ8PEDfbV6UA+4IbktBuGYjThsUEmtjSMPjru25YG4c/a4G4OrCguw2a1OQ
         3rcZtirp8484oe1/Pl29XMIEKi+5OJt1c3b/IDqgri0eZyzHvnEcfYQ1Z3jYS/lgDact
         tdsLCLTHl4s8tqOwqIM5KrWHfCwj0jp/BfRdRcrder0DlUtGIqhf7ZltU+s4XAE6Y4bb
         22jKWg690vkqdAhCJk9sZidBh2PqqNcuH1UqXxu+V0Kc52RoKmqp4xFQeHewid7qXX8q
         Tt9A==
X-Gm-Message-State: AOJu0Yy7Axb/2+U51Y/GST4vqBWYr/BbCmD8zxYDL+x+osZI8nrYoHZw
	gNo4rC8v/l55NCIRZaC5rXSjZ9Twkj31m8ULsIQOm7PIwv19kbzs+/uYw6pu+QKBOL7mVWYK6VI
	1Nk9KRqhA+JTZM12mQ3JtVxgp5c+jm8Za
X-Google-Smtp-Source: AGHT+IGWDz1mUN9wbjnvTs6Dgg/Q3Lu77Jd3I9QjMsgGonV7QF3h9KsF7cd0jcFohm/8gYJNG6Yh+Ep/Ofh8VStEtLE=
X-Received: by 2002:a05:6870:970f:b0:261:1600:b1eb with SMTP id
 586e51a60fabf-261214eac1emr12447281fac.31.1721775985489; Tue, 23 Jul 2024
 16:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmG+FRhQquBJzFkr+BHFDCxxKky706Za2+nC9CNf8i10w@mail.gmail.com>
 <CAN-5tyG+t1Q=Tr0FtTzWhKE-=hLvWOarNn3_ArUt9VYuZ=aauQ@mail.gmail.com>
In-Reply-To: <CAN-5tyG+t1Q=Tr0FtTzWhKE-=hLvWOarNn3_ArUt9VYuZ=aauQ@mail.gmail.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Wed, 24 Jul 2024 01:05:59 +0200
Message-ID: <CAAvCNcBQK+z5=NUN3AmDG6qnEUJvwgF11479TrKwhTEC1qV-fg@mail.gmail.com>
Subject: Re: New NFSv4.2 attribute |FATTR4_TMPFILE| (sort of opposite of
 |FATTR4_OFFLINE|) ?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, ms-nfs41-client-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jul 2024 at 15:58, Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Tue, Jul 23, 2024 at 9:17=E2=80=AFAM Roland Mainz <roland.mainz@nrubsi=
g.org> wrote:
> >
> > Hi!
> >
> > ----
> >
> > [2nd attempt to send this email]
> > The Win32 API has |FILE_ATTRIBUTE_TEMPORARY| (see
> > https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-=
createfilea)
> > to optimise for short-lived/small temporary files - would it be useful
> > to reflect that in the NFSv4.2 protocol via a |FATTR4_TMPFILE|
> > attribute (sort of the opposite of |FATTR4_OFFLINE|, such a
> > |FATTR4_TMPFILE| should be ignored by HSM, and flushing to stable
> > storage should be relaxed/delayed as long as possible) ?
>
> I think a more appropriate medium for this message is an IETF NFSv4
> mailing list

Where is that list?

> as FATTR4_TMPFILE is not a spec attribute.

I think the question was what the Linux nfsd people think about such
an attribute.

But I also have a related question: Can the Linux nfsv4 client code
see the O_TMPFILE flag from openat() syscalls? If that is the case,
then O_TMPFILE ----> {FATTR4_TMPFILE, true}, and Linux nfsd can
optimise such files too.

Dan
--=20
Dan Shelton - Cluster Specialist Win/Lin/Bsd

