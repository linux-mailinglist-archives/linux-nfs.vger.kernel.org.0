Return-Path: <linux-nfs+bounces-8879-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3B69FFB71
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 17:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C47A3A1284
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 16:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAC427702;
	Thu,  2 Jan 2025 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWMH5dHC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FBE33E7
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735834657; cv=none; b=GLrUo8xVyYBxmTfdFbwLzBHXsoPTLo2oIneA1ZA7ghBVzjXu9XSYz5n2pJzqnKWWPnMMmb97kr0PwJ8ElCBaiIGsFshPRien0hJl9iAkbB8t761BC6vE9zg1RbaxYrp1HMaF8kT6YpyoYQ3kQy8egHeVrZZLkaOvN/J/tQljjfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735834657; c=relaxed/simple;
	bh=MAGtosaSMCl5VDfOb5+sEOIq9ZQFXHf3Icj/Cdg2Axg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+jxdRMstbr/QCOfph1UJHGhdWLHI3x88wMjWCWKrvLY+dFxNvANCe4UVWpp9GjoFynaPZ6DeBlebY1BPDP6jUHxL+RY5gIzLc9tS1OoOLPP7M+mSBmUL+TaUnPdpy6EsNThFD2Dm0Zp8GJh7YZej9CUGqQlqdP0OwxNVCh1ENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWMH5dHC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so110608a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 02 Jan 2025 08:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735834653; x=1736439453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAGtosaSMCl5VDfOb5+sEOIq9ZQFXHf3Icj/Cdg2Axg=;
        b=MWMH5dHCA5C8Xipld3HhsTJG8hvWo5rUlSwrS1tP9afjP8QYMFyEJw8vyboroBCn9u
         J4/WSij053S38vhZ5hyUQ4neIJtEQxEEDaFfWV8m01/d05KFY1RfI2QeEQ9R3MZMqISN
         tKG9luR/xdig+ut5HKpcbVq3zwZfDEJ1+ouTfl2mdLRjZ7LFeyWXYzEmZfMB6jAkqmg7
         p/S/prQlePfJ9uyye27eZUs8brSbjtqj5LcllXQmepZNbNwDZ7WvL1JtURQWxBGMlIIV
         Fmu1SVqJlgNF8a6RluWjgMB3YUbjVjrUGHgzGWWWsaBD2303w1hXj5naCGLAv23OOenn
         T66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735834653; x=1736439453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAGtosaSMCl5VDfOb5+sEOIq9ZQFXHf3Icj/Cdg2Axg=;
        b=ggB+zHfxQejcewvPKLT8JoHNCaczC8VEVTMm1JYBjAUfFXqMV4D6MBY9fXK532tNN6
         kW7O4q0S+38Op1aDWEkO4KGZnZD2po8gQPj9Nx11ZMvktzIk/ohpwaJxoomrv2XJXH9A
         TKjj/8KZPYrjUSovnLXkDNmFurlX6A4XE3MjVS+u+5cGnSFzjOugNAe52VaVDj2hPo7W
         vMEMP6Txhe76IrwhDQe1ROIE0kNEyAWE3VI+l6FUt3lzbFU/CHudLo37XJi6JCeAZbMF
         j2NLrwgHiMNYcPlB7TUDIMbEDF0PuL73vDMkMYBlwqEb71lFUs3Y/fCzOH09WO8Qe2dQ
         iCjg==
X-Forwarded-Encrypted: i=1; AJvYcCUjN0RAvF60z9Er0jtS7BqOdutQGeC1zyy1aZt+PLbf1qxZ8aTjcOLdecEageISch6CEaYiMcw5Ous=@vger.kernel.org
X-Gm-Message-State: AOJu0YznbcARtZeokzMH7khWpd9QlyngOvV4DmLyo0WdQbDqig+WxTzg
	XqsX/c8WIpNtkqYsyW7ZvDMpaGFbSdxUn4WePF44bhthoXmJiLR7l0FpIjxvlCdt1yDxVW0OX9K
	OoJTJ4sOgGZ9ExrBDQQYeagFUCg==
X-Gm-Gg: ASbGncsHqcLPXb2P8QrQKo2fkpBh5XCMZl5XaJSUvZz0dpam7Y9XkKDCwqfhjXpVsu5
	gQnTtOu5gimB1tm3dZ7rm/JEHgTzl9rvZNTbK1Ac2Sq+4G5v5EU5yf8Jf/ImiJsPjRdUhOg==
X-Google-Smtp-Source: AGHT+IFBTKmFeplsm9LEtjRQ2VLF3e9D2dJmpS/POIXfpDfd9u7r/j8Hq9aoRWKe+B+I63nYFqqJ+JzRb0Db8zrF3qc=
X-Received: by 2002:a05:6402:40d3:b0:5d3:e766:6143 with SMTP id
 4fb4d7f45d1cf-5d81de02443mr43285107a12.30.1735834652812; Thu, 02 Jan 2025
 08:17:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFEWm5DTvUucAps=SamE5OVs0uYX5n4trFf5PBasBOFbEFWAfA@mail.gmail.com>
 <e52500f98a7153822a6165d26dcf66c3d352129b.camel@kernel.org> <c65f85d0-c52a-45de-bc3f-d9bf827ce83c@oracle.com>
In-Reply-To: <c65f85d0-c52a-45de-bc3f-d9bf827ce83c@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 2 Jan 2025 08:17:22 -0800
Message-ID: <CAM5tNy7nG-dobG2qwd7jLkaO4LpTJHxVKiCN5YrYyQyPiEPWCg@mail.gmail.com>
Subject: Re: Write delegation stateid permission checks
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Shaul Tamari <shaul.tamari@vastdata.com>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 8:01=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
>
> On 1/2/25 8:41 AM, Jeff Layton wrote:
> > On Thu, 2025-01-02 at 11:08 +0200, Shaul Tamari wrote:
> >> Hi,
> >>
> >> I have a question regarding NFS4.1 write delegation stateid permission=
 checks.
> >>
> >> Is there a difference in how a server should check permissions for a
> >> write delegation stateid that was given when the file was opened with:
> >> 1. OPEN4_SHARE_ACCESS_BOTH
> >> 2. OPEN4_SHARE_ACCESS_WRITE
> >>
> >
> > (cc'ing Sagi since he was looking at this recently)
> >
> > A write delegation really should have been called a read-write
> > delegation, because the server has to allow the client to do reads as
> > well, if you hold one.
>
> Another way to put it is the write delegation is equivalent to a RW
> open. It permits the client to handle opens on this file locally without
> having to send another OPEN on the wire (as long as certain conditions
> hold true).
>
> So, therefore, the client is permitted to use that write delegation
> state ID for READ operations.
>
>
> > The Linux kernel nfs server doesn't currently give out delegations to
> > OPEN4_SHARE_ACCESS_WRITE-only opens for this reason. You have to
> > request BOTH in order to get one, because a permission check for write
> > is not sufficient to allow you to read as well.
> >
> >
> >> Should the server check permissions for read access as well when
> >> OPEN4_SHARE_ACCESS_WRITE is requested and DELEGATION_WRITE is granted
> >> ?
> >>
> >
> > Possibly? When trying to grant a write delegation, the server should
> > probably also do an opportunistic permission check for read as well,
> > and only grant the delegation if that passes. If it fails, you could
> > still allow the open and just not grant the delegation.
> >
> > ISTR that Sagi may have tried this approach though and there was a
> > problem with it?
> >
> >> or there is an assumption that the client will query the server for
> >> read access permissions ?
> >>
> >
> > The client should always do an ACCESS call to test permissions unless
> > the user's access matches the ACE that gets sent along with the
> > delegation.
>
> NFSD currently doesn't return this ACE, so the ACCESS round trip is
> still needed.
>
> Basically the ACE tells the client what set of local open(2) calls
> are allowed without having to return the write delegation.
Yes, but I am not sure why you say "return the write delegation".
I do not think that has anything to do with the ACE. The client
must return the delegation when a CBRECALL is issued to it
by the server. Otherwise, the client can DELEGRETURN whenever
it feels like it. (Doing so when doing a REMOVE or RENAME can
avoid a CBRECALL.)

My interpretation is that the ACE tells the client when it can do
local opens without bothering to do an ACCESS operation.

rick

>
>
> --
> Chuck Lever
>

