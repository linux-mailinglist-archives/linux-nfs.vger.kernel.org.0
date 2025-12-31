Return-Path: <linux-nfs+bounces-17386-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2965CEB1C9
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B485C3011A53
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE7426FD9B;
	Wed, 31 Dec 2025 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM+OQPu6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483751A9F9B
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767149398; cv=none; b=TdfzTlNHMwc9FC9ICGd69OzcyJc8qLB8ClIkVyY8RKqrMGKBhpaG/I3pjc6pw3MhI+R+5mz1kV+n9iLJNOaiy1Uul+k1F8FqKjiAgFi8mMNNLvqAXO3GPOma6SuA1zsxL8kzn1VlK1T4bw1kpFuQawN9HVUEWc+WxaFiNQKGzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767149398; c=relaxed/simple;
	bh=kiR0ra2Fo0MyqOYHW3Cp3biFqPXfmLKNm7sCJYZYCzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWIFnOpwXiWlZq87M987jOXnYjfCL0YG+rUM5wBiOy6Qcn4WjK6X3Yzgi3cfifZEFQCq1AeU1uqSGdgIOyW5QMBZgJg+14IYNbZ0RUb1yFs0+REwS2esQzcizmlAESPwsWvGDKopOLtnoqDrG0m6dXPQplmOm0Gm0LKDGqyvNRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dM+OQPu6; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so12415687a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767149394; x=1767754194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HQBnMy8Q0WWa66mNM6f/gqyp0Kh3qR7JY8/CYMvl94=;
        b=dM+OQPu6kaf+nHD6Zj/M8Zgw0lefIPrdGQVlDj1QvGdS5FpUoqNmsRn33SSBMUjFGQ
         s16mQhEJu+Rqh+tERcv432ZVcjzUhws/dObx48uVSkubSZQp/ixE7bUYsgFU8+af3ZD3
         QATmOowY7FGxVCKBBgI/9i4hX2HjYJHtpmZWtuUxfHEU9/iDx7tJqvoxIqUKZHmXVpjD
         8tPFLFpZIV1AbLzDwHdoEaxLx8g4z1/faRtIO2D33LasOjBt709q8Iss858KjaxCydUa
         xB62agJ8ybgJHPWa2bEgxtbLi6a/yxqq1GXEhK9kijkWw4/IjN36qpUqieXMxWeL8AhO
         OakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767149394; x=1767754194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0HQBnMy8Q0WWa66mNM6f/gqyp0Kh3qR7JY8/CYMvl94=;
        b=jAUeCt4XBjTR7e5FgviMvtlcMzcKfKgeFIt3jmBUf8FqZw0D5rr3cShWnIV+TEZi2K
         +FQxZkAFuFcMaZQ9Dr0e6FKULkU3hvIjPQqdPe9eCvQLASSJSmuzngdnkXbRuKx3NFmE
         DBqtwZsIkSChNUE+VzxBYRGZfHbj5u9d8GMUsjDGByGbk3ZYd7SLil160Yi0mBL4UHgJ
         K23ftbjfM8KEpSI1vv1i1fQgSwhI/LJLsTTbSNIz/nadjkDDI06LDM9fKqzUC/8kBl1r
         WEIzyeOY5r0HHsV7AKCxc0pIlZkBp7fjF6gopH4XR2s08Hr8cJsjwhEtSmh8sHvUXJY5
         6gLw==
X-Gm-Message-State: AOJu0Yy+JuYTvJpTpA3reWa/9Hsyt/VjLRBn536z5/djl9l8NaAgfi4w
	1tCsXdxdUVcIFxsj7sf18r6m3aP27lLtHYtdqLLoBD0CIATz8n3PYe0nLse4CoBLYjFYn18gBSY
	diBKoG34UkhQo7LC8QxkwLb/g9WQpvAsgrW4=
X-Gm-Gg: AY/fxX6ijm/JOomkBXsC9jRDntrJOu6+LCdyPDysa4UgAoiI0bKa93mGhqWJOn8sst6
	1g6UrEN0vm4BD98ZFLISbsKEjUAvzp/tIXsFSTkaJBr/tJCB/7NCoLsnurT3l+mwTJCBDSIwSEV
	cldgWxaAg1k7Oxlvhm61f4cEip5GZugmGjlc+omO0hT/MFgOERJYwZazPo3j9B9QO7/p2QF7Uvd
	4a65TGeoXfnQPFsiQPGwosfSPxtly/lESczF6w/y2tLv/aMRJz1KruYirxNKHc6HQtHnfqc+zQp
	ESsQskihisK9gvQuV6EZgiuxMg==
X-Google-Smtp-Source: AGHT+IEyiErgreFvPaZtn+nK5He6AD6AyPM3YkRe0CaJFpn2/lCPkAnoyj1yqa8ZTp/wIKepCyIC2TdsNg51/DAH9p4=
X-Received: by 2002:a05:6402:1474:b0:64b:588b:4375 with SMTP id
 4fb4d7f45d1cf-64b8eb62574mr33894690a12.2.1767149394397; Tue, 30 Dec 2025
 18:49:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231022119.1714-1-rick.macklem@gmail.com> <5045ae28-4f2d-4d57-b6c3-523e8bbd99cd@app.fastmail.com>
In-Reply-To: <5045ae28-4f2d-4d57-b6c3-523e8bbd99cd@app.fastmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 30 Dec 2025 18:49:43 -0800
X-Gm-Features: AQt7F2qRMOy6Hl-ZpsFEWHs8uKIpteAxi1NwBIqQq06ee6tPBWg0UOv1ORA1OA8
Message-ID: <CAM5tNy48Q7+a+nBx+OBMJs9ndEnaGFrkjAxqa_zBqAUt0gHKXg@mail.gmail.com>
Subject: Re: [PATCH v1 00/17] Add NFSv4.2 POSIX ACL support
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, Rick Macklem <rmacklem@uoguelph.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 6:48=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Tue, Dec 30, 2025, at 9:21 PM, rick.macklem@gmail.com wrote:
> > From: Rick Macklem <rmacklem@uoguelph.ca>
> >
> > The Internet draft "POSIX Draft ACL support for
> > Network File System Version 4, Minor Version2"
> > https://datatracker.ietf.org/doc/draft-ietf-nfsv4-posix-acls/
> > describes an extension to NFSv4.2 so that POSIX
> > draft ACLs can get acquired and set directly,
> > without using the loosey NFSv4->POSIX draft mapping
> > algorith.  It extends the protocol with four new
> > attributes.
> >
> > This patch series implements the server side of
> > this extension for the knfsd.  It is analogous
> > to the NFSACL protocol used as a sideband protocol
> > for NFSv3 and allows the ACLs to be acquired/set
> > be getfacl(1)/setfacl(1).
> >
> > The current implementation does not support the
> > "per file" scope, where individual file objects
> > store/use either an NFSv4 ACL or POSIX draft ACL
> > and assumes POSIX draft ACLs are supported for an
> > entire file system, if support for POSIX draft ACLs
> > is indicated.
> >
> > Rick Macklem (17):
> >   Add definitions for the POSIX draft ACL attributes
> >   Add a new function to acquire the POSIX draft ACLs
> >   Add a function to set POSIX ACLs
> >   Add support for encoding/decoding POSIX draft ACLs
> >   Add a check for both POSIX and NFSv4 ACLs being set
> >   Add na_dpaclerr and na_paclerr for file creation
> >   Add support for POSIX draft ACLs for file creation
> >   Add the arguments for decoding of POSIX ACLs
> >   Fix a couple of bugs in POSIX ACL decoding
> >   Improve correctness for the ACL_TRUEFORM attribute
> >   Make sort_pacl_range() global
> >   Call sort_pacl_range() for decoded POSIX draft ACLs
> >   Fix handling of POSIX ACLs with zero ACEs
> >   Fix handling of zero length ACLs for file creation
> >   Do not allow (N)VERIFY to check POSIX ACL attributes
> >   Set the POSIX ACL attributes supported
> >   Change a bunch of function prefixes to nfsd42_
> >
> >  fs/nfsd/acl.h        |   3 +
> >  fs/nfsd/nfs4acl.c    |  35 ++++-
> >  fs/nfsd/nfs4proc.c   | 126 +++++++++++++++--
> >  fs/nfsd/nfs4xdr.c    | 312 ++++++++++++++++++++++++++++++++++++++++++-
> >  fs/nfsd/nfsd.h       |   8 +-
> >  fs/nfsd/vfs.c        |  34 ++++-
> >  fs/nfsd/vfs.h        |   2 +
> >  fs/nfsd/xdr4.h       |   6 +
> >  include/linux/nfs4.h |  37 +++++
> >  9 files changed, 536 insertions(+), 27 deletions(-)
> >
> > --
> > 2.49.0
>
> Thanks for posting, Rick!  What branch/tree/commit did you base this seri=
es on?
It's against your nfsd-testing branch of a few days ago.

rick

>
>
> --
> Chuck Lever

