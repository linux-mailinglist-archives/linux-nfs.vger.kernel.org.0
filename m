Return-Path: <linux-nfs+bounces-110-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D886A7FACB4
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 22:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E621C20B7D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 21:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717EE4644B;
	Mon, 27 Nov 2023 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="lOqfYwr2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9380010E6
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 13:42:21 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c87acba73fso9983791fa.1
        for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 13:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1701121340; x=1701726140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOFXhZdzaB6KiLH9zP3fxZacibeihuFcTAirqutJ1lM=;
        b=lOqfYwr2sQX1Co4knN8Hmh29C3rP4jkkKfKEOV058R+V/SczRZvCEwMqAE09kyWadC
         gv1gFDJAaT54VXZI6gg9//ghWe4wMUJEUTSo67g+HXV0pNqEh+psBBNRUz+BVabIVn9j
         Cpy3LS16vWBzOwh0pMxc0xl585Fv6UEEI3TiD87YM851JzCk91ld9UG0N6Fb8DTS9rJG
         Rz83UNMPrG8HAp72aMI7G2U3Qr1fJlAtUTRaJXUXYz5KOSZJBrsKemBQ3LowNW0YqAGE
         Mp/L2jFg2tQ/0pkrBaKzyuyXxemFNPVY1/UgE9JIUgCw3ZCGZjZ+XwM8d2qQ/j2OSF6y
         sO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701121340; x=1701726140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOFXhZdzaB6KiLH9zP3fxZacibeihuFcTAirqutJ1lM=;
        b=vmumeWmnzEmNbCspgUTu8DGl7ND7HSk9DmBK68oeaRpcuWkmZDjSabXUhgienpuNg5
         bORs9AEEqfnDQVkhrS0/6A+9+VYmQ3ZA0byPe3Go7I8ULg4HS2WbBZgQ3337lYz+6esE
         S+/EoCgQqvz1BGjijX4D4c5W8FgcMQuZbOXSWTuitHNRlMcJSeFL7bNIOlVkTyVkgHPP
         TCGynneyd+2lUsGwndaK6naGYN3hSysrHuQhIvC85i2YgmQbHWirONdOT3RcrIWDNkpG
         3qel0APTFmN7RUB5t8CZfhuzMjkjP/8bI0LSK6WPV8EflqXNxXqS5rD7MBl0B9of5d6l
         1WzA==
X-Gm-Message-State: AOJu0YxA2kF2ajaFrNGi+ik5UUwv1IuNJcvYMKpoSPq6hArr6eW1vUe/
	5dIGNd5mdce/IyQ5UsU1k21az4WZKcbo9bwvgI5oTsaE+ic=
X-Google-Smtp-Source: AGHT+IH6hRojZ2Ot0RNEnvDcIobGwcQTU42s9EhqQKwod7caC4JeV/sq6I16qPKnvmjtotV4neIq80yFO5DGXi0lbvc=
X-Received: by 2002:a2e:5301:0:b0:2c6:f97c:cf21 with SMTP id
 h1-20020a2e5301000000b002c6f97ccf21mr7505224ljb.2.1701121339563; Mon, 27 Nov
 2023 13:42:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97AE695C-8F9F-4E9C-9460-427C284FBD32@oracle.com>
 <CAN-5tyHxvTevgM38q94W4e+rBzYu7tWqDHVMNcFQ5GT3uNArCw@mail.gmail.com> <6F0CCBAF-29E1-4720-A7DC-9F43751B56E7@oracle.com>
In-Reply-To: <6F0CCBAF-29E1-4720-A7DC-9F43751B56E7@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 27 Nov 2023 11:42:08 -1000
Message-ID: <CAN-5tyGqSXyeu+LXWVu_J=A8CLW01c2wDKSfBeqFaaWLxnOAyw@mail.gmail.com>
Subject: Re: changes to struct rpc_gss_sec
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <kolga@netapp.com>, Steve Dickson <SteveD@redhat.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chuck,

Given that rpc_gss_secreate() was written by you I hope you dont mind
questions. I believe gssd can't use the new api because it is
insufficient. Specifically, authgss_create_default() takes in a
structure which is populated with the correct (kerberos) credential we
need to be using for the gss context establishment.
rpc_gss_seccreate() sets the sec.cred =3D GSS_C_NO_CREDENTIAL. If you
believe I'm incorrect in my assessment that rpc_gss_secreate please
let me know.

As far as I can see, current libtirpc needs to be modified no matter
what. Perhaps there needs to be some config magic to demand the use of
higher version of libtirpc for the new code but it would be just a
different way an upstream nfs-utils won't build without an appropriate
libtirpc version. I would imagine distros would build matching
libtirpc and nfs-utils that would either both not have the fix or have
the fix.


On Wed, Nov 22, 2023 at 4:31=E2=80=AFAM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
> Possibly because authgss_create_default() was the API
> available to gssd back in the day. rpc_gss_seccreate(3t)
> is newer. That would be my guess.
>
>
> > On Nov 22, 2023, at 1:07=E2=80=AFAM, Olga Kornievskaia <aglo@umich.edu>=
 wrote:
> >
> > Hi Chuck,
> >
> > A quick reply as I'm on vacation but I can take a look when I get
> > back. I'm just thinking there must be a reason why gssd is using the
> > authgss api and not calling the rpc_gss one.
> >
> > On Tue, Nov 21, 2023 at 6:59=E2=80=AFAM Chuck Lever III <chuck.lever@or=
acle.com> wrote:
> >>
> >> Hey Olga-
> >>
> >> I see that f5b6e6fdb1e6 ("gss-api: expose gss major/minor error in
> >> authgss_refresh()") added a couple of fields in structure rpc_gss_sec.
> >> Later, there are some nfs-utils changes that start using those fields.
> >>
> >> That breaks building the latest upstream nfs-utils on Fedora 38, whose
> >> current libtirpc doesn't have those new fields.
> >>
> >> IMO struct rpc_gss_sec is part of the libtirpc API/ABI, thus we really
> >> shouldn't change it.
> >>
> >> Instead, if gssd needs GSS status codes, can't it call
> >> rpc_gss_seccreate(3), which explicitly takes a struct
> >> rpc_gss_options_ret_t * argument?
> >>
> >> ie, just replace the authgss_create_default() call with a call to
> >> rpc_gss_seccreate(3) ....
> >>
> >>
> >> --
> >> Chuck Lever
> >>
> >>
> >>
>
> --
> Chuck Lever
>
>

