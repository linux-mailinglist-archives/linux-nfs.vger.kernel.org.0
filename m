Return-Path: <linux-nfs+bounces-16090-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9E5C37AD8
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 21:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C2B3BD386
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 20:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5EE1B0F23;
	Wed,  5 Nov 2025 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgQeDD0g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E532F28FC
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373897; cv=none; b=J0cdkQ1MqDfxkPe2mFAmXuV9XaPCdiyT0gHta7O9Zvo41Gl5seUyj9bJ3yKAhX41kbrRYcJAmmCdyprsTvpFcXW1gDGIrZ8pOrx5oPYmmdXtUuCJ5L7iJA+KkbUD1XECdAk+yyaOtu7xBzP499nkFIVuPyi5JAkp0H0CyjCym8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373897; c=relaxed/simple;
	bh=MJLMYXpbQXqd688+m7oAU/mukFcosR8BK/rr4Wez+L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WemHpF4oMJD+kIbN1h37PJLMRRVerBEnPdb0PXWWqGUqFSOCcN0j38J1x8EqdiwPGmwszxFYAmN+hyfwJj7Zk24/p/6LUVScPwY/1gyAXNFBiSCYkR/KX+1AFIt/qG0XYnIOhp4altXuQL/YIuxl+MEFxCUurhjegyBtTdHu06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgQeDD0g; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso355741a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 05 Nov 2025 12:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762373894; x=1762978694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTGwTwMOT9NPI3Ok6McKCWgg2eIll847QhgHWqlAHSw=;
        b=XgQeDD0gHA4HBKnIE1/WRmJmmMfBrnEkgq2elmdTrPxwRa908NHpVPHxN76dxc9zBD
         efXd+Mif7rQfMbqwyKB7FQK72rlrrquFF+QcFpInSR3RU7TXR/JQmTc1XvQ5A1PDCfbW
         JJYy51aM15y/bpqqbONjuHeYLkHN77w254wDaU64TEAqRv6GQ45DD0g9eDx7MxORLL8G
         2ViU5uC9fnei6Kgths4OYC2ERDAMrJ/kbpFzv26dI0m5sdLaSbvLPWJpN/JWxew1GMpf
         5Q/T8aBpBtPTVR3pmGwGQLHoCOQr8JOZIgnxokn7O+oZdvczZ6hiAsY23yQcX0x7c/dF
         539w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373894; x=1762978694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTGwTwMOT9NPI3Ok6McKCWgg2eIll847QhgHWqlAHSw=;
        b=LdXnQfZpxzO6l8qyIYk5lkVdKUspykRonK/1N7Xtv5XFsH8qbAsL90S5DE6Qe38l1V
         UnDl043HTcp6QIMSkXLAco1GpPrUAouPrgiePwpW8VnSvpVPVrb5ghkYnfLXwvTP/MH5
         4lREwHR+lVlqH6QLDotlrxVFXSCYVGM3PWnanY1J8lcT5cuO+5E3m3XY58kBhLe/7mFA
         afputDpAzmutgXwFys8WBJ2ht+PTHgiUM/8pqykfZlCn7Gagd+q280c3o3gfF7nyjUCT
         AV2diNHtNnrJTcnMmw5zwXhsAGihmLb+15moUCryfhTVW6xMc/BR2O0YBv42ph7x8pIO
         EcJg==
X-Forwarded-Encrypted: i=1; AJvYcCVFfMbHtZ6LcNzsMkm4fXLy/+qz80wK0OEVM6Nw7sqcqkDddYEkO0OMefrXI9BRM9jdxLtLcazQ2bY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhTdnO+yXy/R3VR8GcVQvcogGMAz+yafIjVyVrOKeTpM1fUkpa
	+Nybslfp55hDiebAz0W9pJKtOXltW8iUAKzvBmgLe/iEuEz+zdUnhcjz9FJpGzkE9eat8jXD5lk
	e82O6g7kQW8jKLkUjQzqupP0OupxLIQ==
X-Gm-Gg: ASbGncujS8gUz7smmZn8fDIsvql6WZf5HLuKWLArY/amb59nsAd7LXCXCL6/k2HD+F2
	CEOZUOTf+UtvWbCIGxKTT1Cir/lwRh9iPQaz7G6T8pLn3anME4SrjHvPw/YDkq9S+7B0NWHv5px
	03Xylp65UL76fC4gRidawFkijxhCs2x/Yzaw4SNb73Dybfw7DHuwbIjAfAtUBjRs78oHrcXXnS0
	gE33IDAJyA8oclZTc/42kgss27aDMnSshNiLp7k1qCKt/NWl3xKUY/jCit1Bel3/mG+j+X57wBJ
	m16ReBxGdiUzpyFUyI6sFLW7pmM=
X-Google-Smtp-Source: AGHT+IFnPMF2eZZnh+E4zIljGlV10bHjgVqbBGNUGq3HYRDoLyYRZfbZz9v5EqvuNlIGXbSGfIO/Lt6uGU+wtSBRmrA=
X-Received: by 2002:a05:6402:5110:b0:640:b044:d9b9 with SMTP id
 4fb4d7f45d1cf-64105a44ae0mr4028095a12.20.1762373893700; Wed, 05 Nov 2025
 12:18:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DM4PR15MB62545DA30C0BB065DE454D9E9AFBA@DM4PR15MB6254.namprd15.prod.outlook.com>
 <b1451224bfa93fc8a6f94e4da2fe327fe366cd0f.camel@poochiereds.net>
In-Reply-To: <b1451224bfa93fc8a6f94e4da2fe327fe366cd0f.camel@poochiereds.net>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 5 Nov 2025 12:18:00 -0800
X-Gm-Features: AWmQ_bnSxY7USP9lSBuzBTkL_VuDqDrPjpPvjy4LZv_XD2bHy_v5pIEZf_4Pl74
Message-ID: <CAM5tNy7oO32h1pW+Gcyno65WRGUR5tAVwsFF+f4WRBqBKG9ZxQ@mail.gmail.com>
Subject: Re: [nfsv4] Re: [NFS-Ganesha-Devel] Clarification on delegation
 behavior for same-client conflicting OPEN
To: Jeff Layton <jlayton@poochiereds.net>
Cc: Suhas Athani <Suhas.Athani@ibm.com>, 
	"devel@lists.nfs-ganesha.org" <devel@lists.nfs-ganesha.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "nfsv4@ietf.org" <nfsv4@ietf.org>, 
	Kaleb KEITHLEY <kkeithle@ibm.com>, Frank Filz <ffilz@ibm.com>, Rajesh Prasad <Rajesh.Prasad3@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 7:29=E2=80=AFAM Jeff Layton <jlayton@poochiereds.ne=
t> wrote:
>
> On Thu, 2025-10-30 at 17:35 +0000, Suhas Athani via Devel wrote:
> >
> > Hello NFS community,
> >
> > We=E2=80=99re seeking clarification on server behavior for OPEN delegat=
ions when the same client issues a potentially conflicting OPEN on a file f=
or which it already holds a delegation.
> >
> > Context and RFC references
> >
> >  *
> >    RFC 8881(10.4 Open Delegation)
> >     -
> >       =E2=80=9CThere must be no current OPEN conflicting with the reque=
sted delegation.=E2=80=9D
> >     -
> >       =E2=80=9CThere should be no current delegation that conflicts wit=
h the delegation being requested.=E2=80=9D
> >
> >  *
> >    RFC 8881(10.4.1 Open Delegation and Data Caching)
> >     -
> >       For delegation handling, READs/WRITEs without OPEN are treated as=
 the functional equivalents of a corresponding type of OPEN, and the server=
 =E2=80=9Ccan use the client ID associated with the current session to dete=
rmine if the operation has been done by the holder of the delegation (in wh=
ich case, no recall is necessary) or by another client (in which case, the =
delegation must be recalled and I/O not proceed until the delegation is ret=
urned or revoked).=E2=80=9D
> >
> >  *
> >    Historical reference: RFC 5661 (obsoleted by RFC 8881) carries the s=
ame sections 10.4 and 10.4.1
> > Questions
> > 1) Same-client conflicting OPEN:
> >
> >  *
> >    If a client holds an OPEN_DELEGATE_READ on a file and then the same =
client issues an OPEN that requires write access (or otherwise conflicts), =
should the server:
> >  *
> >
> >
> >
> >
> >     -
> >       Allow the OPEN to complete immediately without recalling the dele=
gation (i.e., no recall necessary for same-client), per RFC 8881 10.4.1; or
> >
> >  *
> >    Recall the delegation anyway and delay the operation until DELEGRETU=
RN?
The only thing I'll add to what Jeff said is.. for the case of
CLAIM_DELEGATE_CUR
or CLAIM_DELEG_CUR_FH you do not want to recall and wait for a DELEGRETURN,
since these Opens need to be done before the client can DELEGRETURN.

Also, a client is being dumb if it does any Opens on the FH other than the
above 2 Claim types while it holds a Write delegation. However, I don't
the the RFC forbids it, so I'd say just do it. (A Write delegation allows
Reading/Writing, opening for any acces/deny case locally in the client.
The server recalls the write delegation when another client requests any
Open for the FH.

rick
>
> The Linux NFS server allows the open to complete, which I think has
> been the consensus around this point in earlier discussions. Basically,
> activity from the holder of a delegation is not considered
> "conflicting". That client presumably knows about any changes and can
> update its cache accordingly, so we don't need to recall the delegation
> in this case.
>
> > 2) OPEN_DELEGATE_WRITE symmetry:
> >
> >  *
> >    If a client holds an OPEN_DELEGATE_WRITE and then the same client is=
sues an OPEN that requires read access (or otherwise changes share access/d=
eny modes), should the server similarly allow the operation to proceed with=
out recall, or recall and delay?
>
> WRITE delegations should probably have been called READ_WRITE. The
> Linux NFS server and the spec treat them as a superset of a READ
> delegation. So, opening the file for READ when you hold a WRITE deleg
> is not considered conflicting activity.
>
> > 3) Any updates since RFC 5661:
> >
> >  *
> >    Are there clarifications or consensus updates in RFC 8881 (vs. RFC 5=
661) or later documents that alter expected behavior in the same-client cas=
e?
> >
> >
> > Thank you in advance for your time and insights. Looking forward to you=
r guidance and clarification on these points.
> >
> > Regards,
> > Suhas Athani
> > NFS-ganesha Team
> >
> >
> >
> >
> > _______________________________________________
> > Devel mailing list -- devel@lists.nfs-ganesha.org
> > To unsubscribe send an email to devel-leave@lists.nfs-ganesha.org
>
> --
> Jeff Layton <jlayton@poochiereds.net>
>
> _______________________________________________
> nfsv4 mailing list -- nfsv4@ietf.org
> To unsubscribe send an email to nfsv4-leave@ietf.org

