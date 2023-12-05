Return-Path: <linux-nfs+bounces-344-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE57805FA7
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 21:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10ED11C20860
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 20:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4431E6A00F;
	Tue,  5 Dec 2023 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="nYCgfvX7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227DA129
	for <linux-nfs@vger.kernel.org>; Tue,  5 Dec 2023 12:43:30 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9f575d4b2so9367881fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 05 Dec 2023 12:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1701809008; x=1702413808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InyijHq0vl3bIf3RG7ZayejDFiDNLscgRsJ/9AJ4BtU=;
        b=nYCgfvX7aRpTwoNK9ax9dNuZhj738dNvB4rBcgP2UdD/0Vv+rrIrjkDQqDfFS7Z2fb
         gt1W09CUAH7sd7gtiHngvCyn+RyGKn5/BC0pT9PkSwT/XAm/5FNhlvdA5YRFCrHUBK/e
         Cie2Wk4OCOZZyz229u1G3kt8hEpiy4+/LvH+sS0YYH2zbhTBVJs/sgQtImfIXDd9N/QR
         Nn+xRRVy0u48FGddK07pzM9+FCU3gTg2hWrm70KGIC+jZpUlkYQpmP+M5ygXS1hqIEDL
         mSv0v9qKmVJxjh65gq0yyxugyderOmbCk0tzMa4mYl7sMs6mxTnahf0QsEkdfJhtveaj
         L+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701809008; x=1702413808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InyijHq0vl3bIf3RG7ZayejDFiDNLscgRsJ/9AJ4BtU=;
        b=eDDSaEJN1sRxuQ7UZJ+/jyGjh7xf1AdUoN8wlUAivHTm3/U1MWF1X7T8sGmVdVcw9B
         XzIDzv35fueHuIlTIxcX8VhnQEWY/CdYUmnlzCvgYIVm9xj72c++3FeeAFSF+KqKbFEX
         ly4Bq1IZ9hQvAFv6qzpNofz/Axr2dV+NeT+x0+lTB70WkhxyqDXM4sAvjFf/ZSkpQaN/
         pDegdePv1Nqg0Z/flfXCGG/zSmg3OLRWOkAU3kiGzIPWvRMRfhqMSWwffvHOX1lB80Wc
         UdTt+x0ppg05Xnb8LNp3yLlrzDLsGNFbEewk7wJQnghUQtScIjsC7HwUpKc0kBhiDOnU
         T1+g==
X-Gm-Message-State: AOJu0YzKx70c4/GuY1jjyYdVK/SQ//k0/kn/iQO/VBZiOym0aN8g9HQv
	AKP/fkTbtBLhNl2EavBjemCWDQxDeCl22RjASfo=
X-Google-Smtp-Source: AGHT+IHpgWA3o9lxkludSz1zSDVdYk70dwn7Y0U7IySLigegRTA5JFDQBRTLiriCY2k5RMvIhoP/q0GC0TttiFpf8h8=
X-Received: by 2002:a2e:5350:0:b0:2c9:e9a0:581 with SMTP id
 t16-20020a2e5350000000b002c9e9a00581mr7287156ljd.4.1701809008016; Tue, 05 Dec
 2023 12:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97AE695C-8F9F-4E9C-9460-427C284FBD32@oracle.com>
 <CAN-5tyHxvTevgM38q94W4e+rBzYu7tWqDHVMNcFQ5GT3uNArCw@mail.gmail.com>
 <6F0CCBAF-29E1-4720-A7DC-9F43751B56E7@oracle.com> <CAN-5tyGqSXyeu+LXWVu_J=A8CLW01c2wDKSfBeqFaaWLxnOAyw@mail.gmail.com>
 <ZWU/BvRX6BcnSQPj@tissot.1015granger.net>
In-Reply-To: <ZWU/BvRX6BcnSQPj@tissot.1015granger.net>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 5 Dec 2023 15:43:16 -0500
Message-ID: <CAN-5tyHi8app4K9aRj1paF=zG6PHLs3w8=C6iH4mZgduxvaAbA@mail.gmail.com>
Subject: Re: changes to struct rpc_gss_sec
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <kolga@netapp.com>, Steve Dickson <SteveD@redhat.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 8:15=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On Mon, Nov 27, 2023 at 11:42:08AM -1000, Olga Kornievskaia wrote:
> > Hi Chuck,
> >
> > Given that rpc_gss_secreate() was written by you I hope you dont mind
> > questions. I believe gssd can't use the new api because it is
> > insufficient. Specifically, authgss_create_default() takes in a
> > structure which is populated with the correct (kerberos) credential we
> > need to be using for the gss context establishment.
> > rpc_gss_seccreate() sets the sec.cred =3D GSS_C_NO_CREDENTIAL. If you
> > believe I'm incorrect in my assessment that rpc_gss_secreate please
> > let me know.
>
> Caller can pass its preferred credential in via the *req parameter
> (parameter 6). Then rpc_gss_seccreate(3t) does this:
>
> 846         if (req) {
> 847                 sec.req_flags =3D req->req_flags;
> 848                 gd->time_req =3D req->time_req;
> 849                 sec.cred =3D req->my_cred;
> 850                 gd->icb =3D req->input_channel_bindings;
> 851         }
>
> Wouldn't that work?

Actually this does not work. However, this does:
        if (req) {
                sec.req_flags =3D req->req_flags;
                gd->time_req =3D req->time_req;
                gd->sec.cred =3D req->my_cred;
                gd->icb =3D req->input_channel_bindings;
        }

Existing code is such that cred in gd->sec.cred is always null. I'm
100% certain of that but I can't explain why sec.cred=3Dreq->my_cred is
not working. This is current code:
in authgss_refresh()
rpc_gss_sec:
     mechanism_OID: { 1 2 134 72 134 247 18 1 2 2 }
     qop: 0
     service: 1
     cred: (nil)

Fixed libtirpc code as above (or code using authgss_create_default()):
in authgss_refresh()
rpc_gss_sec:
     mechanism_OID: { 1 2 134 72 134 247 18 1 2 2 }
     qop: 0
     service: 1
     cred: 0xffff9002e000

If I were to fix the libtirpc this way, then I can use
rpc_gss_seccreate from gssd and not use my previous changes. But it
still requires changes to libtirpc. How is that not different from
what's already there (as in committed)?

> > As far as I can see, current libtirpc needs to be modified no matter
> > what.
>
> I'm not convinced of that yet.

See above?

> > Perhaps there needs to be some config magic to demand the use of
> > higher version of libtirpc for the new code but it would be just a
> > different way an upstream nfs-utils won't build without an appropriate
> > libtirpc version.
>
> Agreed, 4b272471937d ("gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for
> machine credentials") should have added some config magic.
>
> If the libtirpc version is too low, then the new GSS status checking
> logic you added can't be used, and it should fall back to the old
> logic via #ifdef.
>
>
> > I would imagine distros would build matching
> > libtirpc and nfs-utils that would either both not have the fix or have
> > the fix.
>
> I don't think distros work that way unless they are forced to.
> There doesn't seem to be a reason why the nfs-utils change has
> to break things -- we can do this without the ABI disruption.
>
> The change to struct rpc_gss_sec can't remain. IMO both
>
>   f5b6e6fdb1e6 ("gss-api: expose gss major/minor error in authgss_refresh=
()")
>
> and
>
>   4b272471937d ("gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine crede=
ntials")
>
> need to be reverted first.
>
> Then a patch that replaces the authgss_create_default(3) call with
> rpc_gss_seccreate(3t) can be applied, as long as it contains new
> configure.ac logic to fall back to using authgss_create_default(3)
> if rpc_gss_seccreate(3t) is not available in libtirpc.
>
> That should enable nfs-utils to be built no matter what version of
> libtirpc is available in the build environment.
>
>
> > On Wed, Nov 22, 2023 at 4:31=E2=80=AFAM Chuck Lever III <chuck.lever@or=
acle.com> wrote:
> > >
> > > Possibly because authgss_create_default() was the API
> > > available to gssd back in the day. rpc_gss_seccreate(3t)
> > > is newer. That would be my guess.
> > >
> > >
> > > > On Nov 22, 2023, at 1:07=E2=80=AFAM, Olga Kornievskaia <aglo@umich.=
edu> wrote:
> > > >
> > > > Hi Chuck,
> > > >
> > > > A quick reply as I'm on vacation but I can take a look when I get
> > > > back. I'm just thinking there must be a reason why gssd is using th=
e
> > > > authgss api and not calling the rpc_gss one.
> > > >
> > > > On Tue, Nov 21, 2023 at 6:59=E2=80=AFAM Chuck Lever III <chuck.leve=
r@oracle.com> wrote:
> > > >>
> > > >> Hey Olga-
> > > >>
> > > >> I see that f5b6e6fdb1e6 ("gss-api: expose gss major/minor error in
> > > >> authgss_refresh()") added a couple of fields in structure rpc_gss_=
sec.
> > > >> Later, there are some nfs-utils changes that start using those fie=
lds.
> > > >>
> > > >> That breaks building the latest upstream nfs-utils on Fedora 38, w=
hose
> > > >> current libtirpc doesn't have those new fields.
> > > >>
> > > >> IMO struct rpc_gss_sec is part of the libtirpc API/ABI, thus we re=
ally
> > > >> shouldn't change it.
> > > >>
> > > >> Instead, if gssd needs GSS status codes, can't it call
> > > >> rpc_gss_seccreate(3), which explicitly takes a struct
> > > >> rpc_gss_options_ret_t * argument?
> > > >>
> > > >> ie, just replace the authgss_create_default() call with a call to
> > > >> rpc_gss_seccreate(3) ....
> > > >>
> > > >>
> > > >> --
> > > >> Chuck Lever
> > > >>
> > > >>
> > > >>
> > >
> > > --
> > > Chuck Lever
> > >
> > >
>
> --
> Chuck Lever

