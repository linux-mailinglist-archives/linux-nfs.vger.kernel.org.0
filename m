Return-Path: <linux-nfs+bounces-1580-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBA0841721
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 00:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A0B282159
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 23:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E70157056;
	Mon, 29 Jan 2024 23:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/FRMweT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CD813D51E
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 23:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571999; cv=none; b=j6KQ80P87tkIr9ATeHsouDBDlOHhLkM40MlireEV1Cng7fzuTgUt7Mii1vZN43PlKtRwy2ZqDN8CfXObMBNd6beVnHre4MjLDViwJ0DMLJGIfXDdFQ0eyt46FZGZLADb2ZpyHnvIQ03UKgvK2L4UwFYzwrFFraSwBSFIBGuH3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571999; c=relaxed/simple;
	bh=wLl1v/H/QQqKoA+Mk8l68ShVMbqRVS6dRtsqntVSaaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQInK/g6OGcBSWqHiuHNvCFFpqWtmOIhJDXAPzQMExRMbuaK+NjpCUbh7LP3pksrSlAK6ZJYZFvElsaapQQLOaar3+yJ6/M4fc+PjsNGPLvesye1Vz0EzlXWoomwugEOjveeaadM0tOtZoHuiVxN1GA6YYrqLcykNcjW+glC+eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/FRMweT; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21481a3de56so2092077fac.2
        for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 15:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706571997; x=1707176797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dy4pR2UWryS/zt3Oig/A9S4VmKjbZgARizv2g0+Hv3o=;
        b=b/FRMweT8lYlDa9ZUlxpUcpLu/R2M0m9cqufzw/aJfg/dD5+GfU5q0Y0sU5siO6ymJ
         alObvW6ZyGn73nHGXuLqiLIAHYj+0jbc/n/8mENXeSgrHjnS0DsjKpMtunVHTXGGLTPt
         4kQaZogfIEHaok5e0f3JGQ8OS1X4ktbPXWzE3x9l6BDPOI8g0tu7nQtLhJToWMOcr+62
         o15z0IIfy46HCz1B11cLFMqxNvFPLPZ2SyLD+5SwhuI5nSEIwVoWB6UXfJc6GOGpu9V2
         EwnLQjZezFMalORAT7KEMeTp1mpvihTKj0+I0iamkicy24txbfKffRDMIrztxpy/r5L2
         oUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706571997; x=1707176797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dy4pR2UWryS/zt3Oig/A9S4VmKjbZgARizv2g0+Hv3o=;
        b=FVWoA35yEyZW/rNrXfVxMTH5GdbtaL+QV4L2f7joe0BGXEk/1PtEow3TuXIs/j85HX
         ZuB+cNN9KDUxR1vnRnr4zJFE04eZASOuhual+2zwX1eLt4khySY3bPOPhulz5cRnj4iD
         RoorjvDQ1el1EkFVsZhKWizYCzzwcvvhcfpQCyKAeRzG0EdTnpSkVNEwJLyvBs1eBNis
         8kFnz/S1uRDRO6dHAOCnRMG+LWWIDAHGf2dQ1YId0cElqtNTn07aS4J/sz1qHl8rXFCc
         zr8qxnehiI17EGU93FXZma3GF5hyhA2GNnmBdKZb0x5vtY7hXWdZakuv8IhJqgdNSQee
         FUsA==
X-Gm-Message-State: AOJu0Ywpc6zxurmKlhzccm5D1mB2yGmBom4GKO0f0buHLOoo12GSIyEV
	trWU3Tx7UI4s9umfLlje0obQn1url74GU/3gAlwY/mlpMRMfeAaFstsNgODG19wMrZ8crHNtu0o
	pYAGEa6Lqin1+U5+qSvZ3iOZT88I=
X-Google-Smtp-Source: AGHT+IEfyh8ucaWxLMTdHuo4FkfdszLeDgY5YA0yXzB4sY85G/CvGU+jR5e8e5STN/wzIgDNI9dTERJP/TZ0ZFtfD5Y=
X-Received: by 2002:a05:6870:d287:b0:214:d4ce:2f26 with SMTP id
 d7-20020a056870d28700b00214d4ce2f26mr6506162oae.49.1706571997139; Mon, 29 Jan
 2024 15:46:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6Md0+56y0ZYtNj1ViF2WGYqusCmjOB6mLeu+nOtC5DPTw@mail.gmail.com>
 <DD47B60A-E188-49BC-9254-6C032BA9776E@redhat.com> <CANH4o6NzV2_u-G0dA=hPSTvOTKe+RMy357CFRk7fw-VRNc4=Og@mail.gmail.com>
 <5ED71FE7-B933-44AC-A180-C19EC426CBF8@oracle.com> <CALXu0UeZgnWbMScdW+69a_jvRxM2Aou0fPvt0PG6eBR3wHt++Q@mail.gmail.com>
 <8FCF1BB3-ECC1-4EBF-B4B4-BE6F94B3D4F5@oracle.com>
In-Reply-To: <8FCF1BB3-ECC1-4EBF-B4B4-BE6F94B3D4F5@oracle.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Tue, 30 Jan 2024 00:46:26 +0100
Message-ID: <CANH4o6P2S1mOXAbQb9d4OgtkvUTVPwdyb8M0nn71rygURGSkxQ@mail.gmail.com>
Subject: Re: NFSv4 referrals - custom (non-2049) port numbers in fs_locations?
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Cedric Blancher <cedric.blancher@gmail.com>, Benjamin Coddington <bcodding@redhat.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 3:07=E2=80=AFAM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
> > On Nov 13, 2023, at 5:57=E2=80=AFPM, Cedric Blancher <cedric.blancher@g=
mail.com> wrote:
> >
> > On Mon, 13 Nov 2023 at 17:19, Chuck Lever III <chuck.lever@oracle.com> =
wrote:
> >>
> >>
> >>> On Nov 10, 2023, at 2:54=E2=80=AFAM, Martin Wege <martin.l.wege@gmail=
.com> wrote:
> >>>
> >>> On Wed, Nov 1, 2023 at 3:42=E2=80=AFPM Benjamin Coddington <bcodding@=
redhat.com> wrote:
> >>>>
> >>>> On 1 Nov 2023, at 5:06, Martin Wege wrote:
> >>>>
> >>>>> Good morning!
> >>>>>
> >>>>> We have questions about NFSv4 referrals:
> >>>>> 1. Is there a way to test them in Debian Linux?
> >>>>>
> >>>>> 2. How does a fs_locations attribute look like when a nonstandard p=
ort
> >>>>> like 6666 is used?
> >>>>> RFC5661 says this:
> >>>>>
> >>>>> * http://tools.ietf.org/html/rfc5661#section-11.9
> >>>>> * 11.9. The Attribute fs_locations
> >>>>> * An entry in the server array is a UTF-8 string and represents one=
 of a
> >>>>> * traditional DNS host name, IPv4 address, IPv6 address, or a zero-=
length
> >>>>> * string.  An IPv4 or IPv6 address is represented as a universal ad=
dress
> >>>>> * (see Section 3.3.9 and [15]), minus the netid, and either with or=
 without
> >>>>> * the trailing ".p1.p2" suffix that represents the port number.  If=
 the
> >>>>> * suffix is omitted, then the default port, 2049, SHOULD be assumed=
.  A
> >>>>> * zero-length string SHOULD be used to indicate the current address=
 being
> >>>>> * used for the RPC call.
> >>>>>
> >>>>> Does anyone have an example of how the content of fs_locations shou=
ld
> >>>>> look like with a custom port number?
> >>>>
> >>>> If you keep following the references, you end up with the example in
> >>>> rfc5665, which gives an example for IPv4:
> >>>>
> >>>> https://datatracker.ietf.org/doc/html/rfc5665#section-5.2.3.3
> >>>
> >>> So just <address>.<upper-byte-of-port-number>.<lower-byte-of-port-num=
ber>?
> >>
> >>> How can I test that with the refer=3D option in /etc/exports? nfsref
> >>> does not seem to have a ports option...
> >>
> >> Neither refer=3D nor nfsref support alternate ports for exactly the
> >> same reason: The mountd upcall/downcall, which is how the kernel
> >> learns of referral target locations, needs to be fixed first. Then
> >> support for alternate ports can be implemented in both refer=3D and
> >> nfsref.
> >
> > Just turn "hostname" into "hostport", i.e. the "hostname" string in
> > the mountd protocol gets the port number encoded into it. Problem
> > done. This is seriously a non-brainer,
>
> It's not as simple as you think.
>
> As far as I can tell, the mountd upcall/downcall already uses the "@"
> character in the refer=3D value for another purpose. It has the same
> problem as using ":" -- it would overload the meaning of the character
> and make the refer=3D value ambiguous and unparsable.
>
> NFSD supports IPv4 addresses, IPv6 addresses, and DNS labels as the
> hostname part of each fs_locations entry. DNS label support is one
> reason we might have some difficulty using a universal address in
> this interface -- the dot notation for the port number bytes looks
> no different than the dot notation for subdomains, and we want to
> enable alternate ports for both raw IP addresses and DNS labels.

Which syntax does a DNS label have?

Thanks,
Martin

