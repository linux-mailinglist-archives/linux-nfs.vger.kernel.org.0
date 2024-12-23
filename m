Return-Path: <linux-nfs+bounces-8748-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B685E9FB1A1
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 17:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A8A16713A
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D0F1B413E;
	Mon, 23 Dec 2024 16:07:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D42188733;
	Mon, 23 Dec 2024 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970030; cv=none; b=cPuKbAMJUeQiVAXFSr5gSCBpsDSV/LH9eWNapKCy52AjVPRHXyJTy4V6vFsKVfR20YIo+uC8TpP/NLlQcm/TnzIGILZr1nj/e/bnKNwm2J+7Fc1M9wc4RXL2lf+psd/GxrrGWu0KfgClb+mN1n+xhouLk/RezayOkzPGtn/j9fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970030; c=relaxed/simple;
	bh=HHZXhkYG4F7D21M+DMwkhHNvyQT90RJwlWXnr8ZpiyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdzZHMbUaYreFzaXyhJaywd34GTyS/9DCEF0Mvw87/EQ2HkFBhCZSAE0l2mI6040iw5Y+IDebeMxmjoffogjnHhG32WH/nIipP+BHINaKUuUAXGLXUM7G1TC74fRw2Kp+FE5LmBJNUOoNqYysHQCvmZzpjLbJHhwr5iwcl1162k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b1601e853eso361574285a.2;
        Mon, 23 Dec 2024 08:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734970026; x=1735574826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQEfVQloeGOXIcWhUnDCRmGoxfZNeTcTW9uBgOyKh4g=;
        b=WCa/82Ciyg0L7wq3BLwIaJ3TxQUAmcjK85J6xcpSA734a7GhV4fk4Mt+uHNw35wpsP
         g3Y7r8zxSIDixL/cKQMwCkH9EtrlFcuErilw8iaHQ4UFJ+Dx6gvp447kR3xzOS9NFWNl
         2PlcrEFo3M7htvbwyg3du4myIapfjagk3k082dfkfM7Xr20dig0VltuXJprSvvl/IXOu
         lwKidHdPvjEY47lSSsPBa9GFvhLa+j1lylahLmkMNdHlRQQ0pZC9TIhez6b/fQhUTV0D
         9BD2hNtYr5bCYr635HKW0Cux69kvj6XT0I9TSXyYUztEliGm4fBP8xZIOMMC1z5DKtfO
         0OlA==
X-Forwarded-Encrypted: i=1; AJvYcCU+L+CkfwWmRJD1afegeVGf1f5DBugNvn/QEF+1w6gnN8yE+TJW0m9I7aMbZyRuZvkdZTIhiXYdlfSF@vger.kernel.org, AJvYcCVRa+CwqL9njTiay05H4LNEMBdhFMakbIdZYMtU3NH4gQK6bdpHefnGMAApDBaiY2jNl8PQ5AJRI5EhMtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWjhQX3e0mKdDFcV1uE3LzcAed+OdIUeBMlv8MmLinXEeYEaOV
	+5r6k5n/52yBqcLGcYTR5zwOM+iOAFjIVY9UM28WK+/TF6AUHDKEed3h6ymW
X-Gm-Gg: ASbGnctzKyk2ME0+DphTJWSmZItp83kkhA1CIqs9zyi/kAd6jyCWvbGnvpScaqUHmFT
	GEu6jPLuiGEe6N/XgCuGY2qQjlQpfZXqHvS2oExiixXNE6FDlgMIxevotQTUZQFtJnwRYhobgru
	y/Cs7pFFTVqZhPy+f8dhLfDnv/dioDIAR/fyC1DJP0ErI9UY74sYMueGMSco1meCAx2rTsSr8Nn
	V70YP76MWoFt18ou5k9ctEBLY3r8Bss9gHiB//uDsEyRddpjET6s2IY3hXCHLt5KjyElDyfBlEo
	99OtdHd8Um8VpmKZvEQKXCA=
X-Google-Smtp-Source: AGHT+IGGq1jjjrxUJ2prTJDoTcDUwdFvDd8DuTWfWC2klselRSJQ4pUGuuVuHA+q7vYDAvOlGrtIOg==
X-Received: by 2002:a05:620a:4452:b0:7b6:785e:ce1a with SMTP id af79cd13be357-7b9ba7168afmr1773359185a.4.1734970025773;
        Mon, 23 Dec 2024 08:07:05 -0800 (PST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac4ce59csm394990485a.114.2024.12.23.08.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 08:07:05 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b1601e853eso361570985a.2;
        Mon, 23 Dec 2024 08:07:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmLA9B3yCPOjz1shjtsloPRbm8K3ftvEmg67H+z+ReKc/hS7lpQ3NSvlIcVBVfNeeHUIeRVT6Zz5vzNEc=@vger.kernel.org, AJvYcCVB/qUYFyib5PeFYVZsg0IomUPEHKDdgbhdHGMXopyA/1uH547fLIBkK8dHOt1FMcWSdPdqc6pkjE0E@vger.kernel.org
X-Received: by 2002:a05:620a:24ce:b0:7b7:5d6:37fa with SMTP id
 af79cd13be357-7b9ba7ec006mr2190114885a.41.1734970025174; Mon, 23 Dec 2024
 08:07:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-nfs4state_fix-v1-1-7a66819c60f0@wanadoo.fr> <6c287aa1-9d94-467e-a85a-7b7076fc080c@oracle.com>
In-Reply-To: <6c287aa1-9d94-467e-a85a-7b7076fc080c@oracle.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Dec 2024 17:06:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXSWmkK-SDPxGGX5qJtakSTiQCUzKCJ4awtVxFxNCtr6A@mail.gmail.com>
Message-ID: <CAMuHMdXSWmkK-SDPxGGX5qJtakSTiQCUzKCJ4awtVxFxNCtr6A@mail.gmail.com>
Subject: Re: [PATCH] nfsd: fix incorrect high limit in clamp() on over-allocation
To: Chuck Lever <chuck.lever@oracle.com>
Cc: mailhol.vincent@wanadoo.fr, NeilBrown <neilb@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, "J. Bruce Fields" <bfields@fieldses.org>, 
	David Laight <David.Laight@aculab.com>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chuck,

On Mon, Dec 9, 2024 at 3:48=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
> On 12/9/24 7:25 AM, Vincent Mailhol via B4 Relay wrote:
> > From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >
> > If over allocation occurs in nfsd4_get_drc_mem(), total_avail is set
> > to zero. Consequently,
> >
> >    clamp_t(unsigned long, avail, slotsize, total_avail/scale_factor);
> >
> > gives:
> >
> >    clamp_t(unsigned long, avail, slotsize, 0);
> >
> > resulting in a clamp() call where the high limit is smaller than the
> > low limit, which is undefined: the result could be either slotsize or
> > zero depending on the order of evaluation.
> >
> > Luckily, the two instructions just below the clamp() recover the
> > undefined behaviour:
> >
> >    num =3D min_t(int, num, avail / slotsize);
> >    num =3D max_t(int, num, 1);
> >
> > If avail =3D slotsize, the min_t() sets it back to 1. If avail =3D 0, t=
he
> > max_t() sets it back to 1.
> >
> > So this undefined behaviour has no visible effect.
> >
> > Anyway, remove the undefined behaviour in clamp() by only calling it
> > and only doing the calculation of num if memory is still available.
> > Otherwise, if over-allocation occurred, directly set num to 1 as
> > intended by the author.
> >
> > While at it, apply below checkpatch fix:
> >
> >    WARNING: min() should probably be min_t(unsigned long, NFSD_MAX_MEM_=
PER_SESSION, total_avail)
> >    #100: FILE: fs/nfsd/nfs4state.c:1954:
> >    +          avail =3D min((unsigned long)NFSD_MAX_MEM_PER_SESSION, to=
tal_avail);
> >
> > Fixes: 7f49fd5d7acd ("nfsd: handle drc over-allocation gracefully.")
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> > Found by applying below patch from David:
> >
> >    https://lore.kernel.org/all/34d53778977747f19cce2abb287bb3e6@AcuMS.a=
culab.com/
> >
> > Doing so yield this report:
> >
> >    In function =E2=80=98nfsd4_get_drc_mem=E2=80=99,
> >        inlined from =E2=80=98check_forechannel_attrs=E2=80=99 at fs/nfs=
d/nfs4state.c:3791:16,
> >        inlined from =E2=80=98nfsd4_create_session=E2=80=99 at fs/nfsd/n=
fs4state.c:3864:11:
> >    ././include/linux/compiler_types.h:542:38: error: call to =E2=80=98_=
_compiletime_assert_3707=E2=80=99 declared with attribute error: clamp() lo=
w limit (unsigned long)(slotsize) greater than high limit (unsigned long)(t=
otal_avail/scale_factor)
> >      542 |  _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
> >          |                                      ^
> >    ././include/linux/compiler_types.h:523:4: note: in definition of mac=
ro =E2=80=98__compiletime_assert=E2=80=99
> >      523 |    prefix ## suffix();    \
> >          |    ^~~~~~
> >    ././include/linux/compiler_types.h:542:2: note: in expansion of macr=
o =E2=80=98_compiletime_assert=E2=80=99
> >      542 |  _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
> >          |  ^~~~~~~~~~~~~~~~~~~
> >    ./include/linux/build_bug.h:39:37: note: in expansion of macro =E2=
=80=98compiletime_assert=E2=80=99
> >       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(con=
d), msg)
> >          |                                     ^~~~~~~~~~~~~~~~~~
> >    ./include/linux/minmax.h:114:2: note: in expansion of macro =E2=80=
=98BUILD_BUG_ON_MSG=E2=80=99
> >      114 |  BUILD_BUG_ON_MSG(statically_true(ulo > uhi),    \
> >          |  ^~~~~~~~~~~~~~~~
> >    ./include/linux/minmax.h:121:2: note: in expansion of macro =E2=80=
=98__clamp_once=E2=80=99
> >      121 |  __clamp_once(val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_),=
 __UNIQUE_ID(h_))
> >          |  ^~~~~~~~~~~~
> >    ./include/linux/minmax.h:275:36: note: in expansion of macro =E2=80=
=98__careful_clamp=E2=80=99
> >      275 | #define clamp_t(type, val, lo, hi) __careful_clamp((type)(va=
l), (type)(lo), (type)(hi))
> >          |                                    ^~~~~~~~~~~~~~~
> >    fs/nfsd/nfs4state.c:1972:10: note: in expansion of macro =E2=80=98cl=
amp_t=E2=80=99
> >     1972 |  avail =3D clamp_t(unsigned long, avail, slotsize,
> >          |          ^~~~~~~
> >
> > Because David's patch is targetting Andrew's mm tree, I would suggest
> > that my patch also goes to that tree.
> > ---
> >   fs/nfsd/nfs4state.c | 46 +++++++++++++++++++++++++-------------------=
--
> >   1 file changed, 25 insertions(+), 21 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 741b9449f727defc794347f1b116c955d715e691..eb91460c434e30f6df70f66=
d937f8c0f334b8e1b 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1944,35 +1944,39 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_chann=
el_attrs *ca, struct nfsd_net *nn
> >   {
> >       u32 slotsize =3D slot_bytes(ca);
> >       u32 num =3D ca->maxreqs;
> > -     unsigned long avail, total_avail;
> > -     unsigned int scale_factor;
> >
> >       spin_lock(&nfsd_drc_lock);
> > -     if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> > +     if (nfsd_drc_max_mem > nfsd_drc_mem_used) {
> > +             unsigned long avail, total_avail;
> > +             unsigned int scale_factor;
> > +
> >               total_avail =3D nfsd_drc_max_mem - nfsd_drc_mem_used;
> > -     else
> > +             avail =3D min_t(unsigned long,
> > +                           NFSD_MAX_MEM_PER_SESSION, total_avail);
> > +             /*
> > +              * Never use more than a fraction of the remaining memory=
,
> > +              * unless it's the only way to give this client a slot.
> > +              * The chosen fraction is either 1/8 or 1/number of threa=
ds,
> > +              * whichever is smaller.  This ensures there are adequate
> > +              * slots to support multiple clients per thread.
> > +              * Give the client one slot even if that would require
> > +              * over-allocation--it is better than failure.
> > +              */
> > +             scale_factor =3D max_t(unsigned int,
> > +                                  8, nn->nfsd_serv->sv_nrthreads);
> > +
> > +             avail =3D clamp_t(unsigned long, avail, slotsize,
> > +                             total_avail/scale_factor);
> > +             num =3D min_t(int, num, avail / slotsize);
> > +             num =3D max_t(int, num, 1);
> > +     } else {
> >               /* We have handed out more space than we chose in
> >                * set_max_drc() to allow.  That isn't really a
> >                * problem as long as that doesn't make us think we
> >                * have lots more due to integer overflow.
> >                */
> > -             total_avail =3D 0;
> > -     avail =3D min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avai=
l);
> > -     /*
> > -      * Never use more than a fraction of the remaining memory,
> > -      * unless it's the only way to give this client a slot.
> > -      * The chosen fraction is either 1/8 or 1/number of threads,
> > -      * whichever is smaller.  This ensures there are adequate
> > -      * slots to support multiple clients per thread.
> > -      * Give the client one slot even if that would require
> > -      * over-allocation--it is better than failure.
> > -      */
> > -     scale_factor =3D max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthrea=
ds);
> > -
> > -     avail =3D clamp_t(unsigned long, avail, slotsize,
> > -                     total_avail/scale_factor);
> > -     num =3D min_t(int, num, avail / slotsize);
> > -     num =3D max_t(int, num, 1);
> > +             num =3D 1;
> > +     }
> >       nfsd_drc_mem_used +=3D num * slotsize;
> >       spin_unlock(&nfsd_drc_lock);
> >
> >
> > ---
> > base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> > change-id: 20241209-nfs4state_fix-bc6f1c1fc1d1

> We're replacing this code wholesale in 6.14. See:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=
=3Dnfsd-testing&id=3D8233f78fbd970cbfcb9f78c719ac5a3aac4ea053

Bad commit reference?

And hence this is still failing in next-20241220...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

