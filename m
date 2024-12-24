Return-Path: <linux-nfs+bounces-8759-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27149FBB03
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 10:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B275188528D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 09:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E9B17B502;
	Tue, 24 Dec 2024 09:16:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3372E403;
	Tue, 24 Dec 2024 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735031809; cv=none; b=PvtBGDcVOMUNKcfWRVRLwfcW8sc7ok6FkA/aTvuRszyvn3C5u2AsmI06ykKno2YyX6FK+XATQli50uhzN81b4gZ4HS4VFBnX9WwXAc1/pa+o/1i58X8TYaroLQtXXvRKvdOV9cXmYZBmka5sMYWJACFZ/4ae3iuikwe1hrbug88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735031809; c=relaxed/simple;
	bh=0OE5YFqDr7qpQh1TF97joMR6L/tsztfiYka+siNemAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWijVz13VQUzwB+huOrzpMgBGAIGLM/gs+yM6lQ14yJYcaRU73xkIlFfLQOH13UpbkPpf0ZW+4Myj8sKdfslxbV60ablq5xx7PJD0pBPG3myvJVVhXsDBsGzib5yAG6Q0JhKdL6GJSXqIDdIGhXoimrJ8FHNm2mPWhmmH7BRqQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4affbb7ef2dso3227297137.0;
        Tue, 24 Dec 2024 01:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735031805; x=1735636605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLvMqKGXOxJBOybsiv3JnqPuONUTwYGdqeD4PUbQXE0=;
        b=o7nKPwFE3Sum8WWOwO8u4kCYBGcpuiO/TRSjSOHTLK3H4yRvi9Perpb1jgLu9i1o6J
         cQYbnTPmxqvMVpP65S2ArUyCzBdMv82VU9PP+yqqaO/eBxiykYCQafuyLqp5AzOq60jc
         HKHQKpVKb7aWckOsGe9dwoBktvP/bsZWeD/7DFIyE4BrexJciJ/huI2KZqfkGncHWsNg
         nDu6D/EzxtLLU+EPpnE47lFLxM53hpVmPlX2YJ2Bi1eSq8gyrR6bNewgHitqer79AbE5
         seqFDBdFAQWGz6a+beG+WeqaO/bK/4vo9akv3C1Y7aEQDDBWxGCEDXoq6vgKzw5KxqL6
         wX1w==
X-Forwarded-Encrypted: i=1; AJvYcCUwsT9nYIufXdpQL0F/xYJmfic05AAa5eWedwWbvfcn8LUNqvtEys4efDqul7hQl0PhVdxCD4ZTbkZi@vger.kernel.org, AJvYcCWzRp4AWK8pK0BXF+faT/gBU+N9Siz7+o88QOifUiGAl7hAktlhhZs5wfFyUA5SGS5ybJ/oF25CEcMiVfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZzz0Ob8C/Ai5wIM35GJaDuuJu3RxDDNzFhWzUahSAjX+x7EUp
	vyahIzS8G9bFlqkg8Zi2zWvr0SrMwYenwxeogArXhIjS4+A6OjJjqF6FOCig
X-Gm-Gg: ASbGncvAxzv4s4utCj5pfmUwkCkvP4YLzQ8FuwCI2tg8ubUmH0r7/peRc/shDsaNUiv
	5Bdiz+/FAHdAl1vJzk7cArfJplU/ThHSQh/rTXClGFy/KJ69k46ErAriKrezR2O/Gi2gpxTC84P
	NmQnBBzLeLcUwIguGcCCdmNhmbwWW29tUnBQZAnztix+DeTO5hLAjl+D3czrWUoA2MGt7bcCL0S
	iRKKTqH8xWn0oYxw4d5RxXjqoRVDk2GXhJwLysU2IVwbCsYMsxenMZas3o7X05m0sXHgwfq6tJ9
	pEsxoFkdjM5VVm14Q/A=
X-Google-Smtp-Source: AGHT+IFBa7Fy6gshJ7MAxCB3bg851Gzus2QX/tgn/DusWLeu7917UoVqendN37kgvy3lXRFyiWQuRA==
X-Received: by 2002:a05:6102:5127:b0:4b2:77df:4660 with SMTP id ada2fe7eead31-4b2cc3225demr14133601137.4.1735031804703;
        Tue, 24 Dec 2024 01:16:44 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8610ac6d815sm1879725241.20.2024.12.24.01.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 01:16:44 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85bc7d126b2so1984118241.1;
        Tue, 24 Dec 2024 01:16:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOzf8Zr+XBBw/JoqWmTChZ4LKFsQE+7JXScKut3y3tCiJMbYnCd20zyEgzZR2mKiaRBixEWySD2pHI@vger.kernel.org, AJvYcCWD8PjDBxq7nVXj+fe0WBDRsHNauhgURDfkZyiPYIyPzU/hAS8CZ+zwVvpeyiZANlaHDU+cNTjV3SoTkxs=@vger.kernel.org
X-Received: by 2002:a05:6102:548f:b0:4b2:ae3e:3ff with SMTP id
 ada2fe7eead31-4b2cc48a5eemr13697779137.27.1735031804107; Tue, 24 Dec 2024
 01:16:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-nfs4state_fix-v1-1-7a66819c60f0@wanadoo.fr>
 <6c287aa1-9d94-467e-a85a-7b7076fc080c@oracle.com> <CAMuHMdXSWmkK-SDPxGGX5qJtakSTiQCUzKCJ4awtVxFxNCtr6A@mail.gmail.com>
 <d4f9d5c2-6919-421f-b1f3-bda6986e878a@oracle.com>
In-Reply-To: <d4f9d5c2-6919-421f-b1f3-bda6986e878a@oracle.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Dec 2024 10:16:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVZFT2LPNSS71UyNnQnh8errW40TOJTtwTXpZe5u7FnXA@mail.gmail.com>
Message-ID: <CAMuHMdVZFT2LPNSS71UyNnQnh8errW40TOJTtwTXpZe5u7FnXA@mail.gmail.com>
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

On Mon, Dec 23, 2024 at 6:49=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
> On 12/23/24 11:06 AM, Geert Uytterhoeven wrote:
> > On Mon, Dec 9, 2024 at 3:48=E2=80=AFPM Chuck Lever <chuck.lever@oracle.=
com> wrote:
> >> On 12/9/24 7:25 AM, Vincent Mailhol via B4 Relay wrote:
> >>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >>>
> >>> If over allocation occurs in nfsd4_get_drc_mem(), total_avail is set
> >>> to zero. Consequently,
> >>>
> >>>     clamp_t(unsigned long, avail, slotsize, total_avail/scale_factor)=
;
> >>>
> >>> gives:
> >>>
> >>>     clamp_t(unsigned long, avail, slotsize, 0);
> >>>
> >>> resulting in a clamp() call where the high limit is smaller than the
> >>> low limit, which is undefined: the result could be either slotsize or
> >>> zero depending on the order of evaluation.
> >>>
> >>> Luckily, the two instructions just below the clamp() recover the
> >>> undefined behaviour:
> >>>
> >>>     num =3D min_t(int, num, avail / slotsize);
> >>>     num =3D max_t(int, num, 1);
> >>>
> >>> If avail =3D slotsize, the min_t() sets it back to 1. If avail =3D 0,=
 the
> >>> max_t() sets it back to 1.
> >>>
> >>> So this undefined behaviour has no visible effect.
> >>>
> >>> Anyway, remove the undefined behaviour in clamp() by only calling it
> >>> and only doing the calculation of num if memory is still available.
> >>> Otherwise, if over-allocation occurred, directly set num to 1 as
> >>> intended by the author.
> >>>
> >>> While at it, apply below checkpatch fix:
> >>>
> >>>     WARNING: min() should probably be min_t(unsigned long, NFSD_MAX_M=
EM_PER_SESSION, total_avail)
> >>>     #100: FILE: fs/nfsd/nfs4state.c:1954:
> >>>     +          avail =3D min((unsigned long)NFSD_MAX_MEM_PER_SESSION,=
 total_avail);
> >>>
> >>> Fixes: 7f49fd5d7acd ("nfsd: handle drc over-allocation gracefully.")
> >>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >>> ---
> >>> Found by applying below patch from David:
> >>>
> >>>     https://lore.kernel.org/all/34d53778977747f19cce2abb287bb3e6@AcuM=
S.aculab.com/
> >>>
> >>> Doing so yield this report:
> >>>
> >>>     In function =E2=80=98nfsd4_get_drc_mem=E2=80=99,
> >>>         inlined from =E2=80=98check_forechannel_attrs=E2=80=99 at fs/=
nfsd/nfs4state.c:3791:16,
> >>>         inlined from =E2=80=98nfsd4_create_session=E2=80=99 at fs/nfs=
d/nfs4state.c:3864:11:
> >>>     ././include/linux/compiler_types.h:542:38: error: call to =E2=80=
=98__compiletime_assert_3707=E2=80=99 declared with attribute error: clamp(=
) low limit (unsigned long)(slotsize) greater than high limit (unsigned lon=
g)(total_avail/scale_factor)
> >>>       542 |  _compiletime_assert(condition, msg, __compiletime_assert=
_, __COUNTER__)
> >>>           |                                      ^
> >>>     ././include/linux/compiler_types.h:523:4: note: in definition of =
macro =E2=80=98__compiletime_assert=E2=80=99
> >>>       523 |    prefix ## suffix();    \
> >>>           |    ^~~~~~
> >>>     ././include/linux/compiler_types.h:542:2: note: in expansion of m=
acro =E2=80=98_compiletime_assert=E2=80=99
> >>>       542 |  _compiletime_assert(condition, msg, __compiletime_assert=
_, __COUNTER__)
> >>>           |  ^~~~~~~~~~~~~~~~~~~
> >>>     ./include/linux/build_bug.h:39:37: note: in expansion of macro =
=E2=80=98compiletime_assert=E2=80=99
> >>>        39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(=
cond), msg)
> >>>           |                                     ^~~~~~~~~~~~~~~~~~
> >>>     ./include/linux/minmax.h:114:2: note: in expansion of macro =E2=
=80=98BUILD_BUG_ON_MSG=E2=80=99
> >>>       114 |  BUILD_BUG_ON_MSG(statically_true(ulo > uhi),    \
> >>>           |  ^~~~~~~~~~~~~~~~
> >>>     ./include/linux/minmax.h:121:2: note: in expansion of macro =E2=
=80=98__clamp_once=E2=80=99
> >>>       121 |  __clamp_once(val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l=
_), __UNIQUE_ID(h_))
> >>>           |  ^~~~~~~~~~~~
> >>>     ./include/linux/minmax.h:275:36: note: in expansion of macro =E2=
=80=98__careful_clamp=E2=80=99
> >>>       275 | #define clamp_t(type, val, lo, hi) __careful_clamp((type)=
(val), (type)(lo), (type)(hi))
> >>>           |                                    ^~~~~~~~~~~~~~~
> >>>     fs/nfsd/nfs4state.c:1972:10: note: in expansion of macro =E2=80=
=98clamp_t=E2=80=99
> >>>      1972 |  avail =3D clamp_t(unsigned long, avail, slotsize,
> >>>           |          ^~~~~~~
> >>>
> >>> Because David's patch is targetting Andrew's mm tree, I would suggest
> >>> that my patch also goes to that tree.
> >>> ---
> >>>    fs/nfsd/nfs4state.c | 46 +++++++++++++++++++++++++----------------=
-----
> >>>    1 file changed, 25 insertions(+), 21 deletions(-)
> >>>
> >>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >>> index 741b9449f727defc794347f1b116c955d715e691..eb91460c434e30f6df70f=
66d937f8c0f334b8e1b 100644
> >>> --- a/fs/nfsd/nfs4state.c
> >>> +++ b/fs/nfsd/nfs4state.c
> >>> @@ -1944,35 +1944,39 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_cha=
nnel_attrs *ca, struct nfsd_net *nn
> >>>    {
> >>>        u32 slotsize =3D slot_bytes(ca);
> >>>        u32 num =3D ca->maxreqs;
> >>> -     unsigned long avail, total_avail;
> >>> -     unsigned int scale_factor;
> >>>
> >>>        spin_lock(&nfsd_drc_lock);
> >>> -     if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> >>> +     if (nfsd_drc_max_mem > nfsd_drc_mem_used) {
> >>> +             unsigned long avail, total_avail;
> >>> +             unsigned int scale_factor;
> >>> +
> >>>                total_avail =3D nfsd_drc_max_mem - nfsd_drc_mem_used;
> >>> -     else
> >>> +             avail =3D min_t(unsigned long,
> >>> +                           NFSD_MAX_MEM_PER_SESSION, total_avail);
> >>> +             /*
> >>> +              * Never use more than a fraction of the remaining memo=
ry,
> >>> +              * unless it's the only way to give this client a slot.
> >>> +              * The chosen fraction is either 1/8 or 1/number of thr=
eads,
> >>> +              * whichever is smaller.  This ensures there are adequa=
te
> >>> +              * slots to support multiple clients per thread.
> >>> +              * Give the client one slot even if that would require
> >>> +              * over-allocation--it is better than failure.
> >>> +              */
> >>> +             scale_factor =3D max_t(unsigned int,
> >>> +                                  8, nn->nfsd_serv->sv_nrthreads);
> >>> +
> >>> +             avail =3D clamp_t(unsigned long, avail, slotsize,
> >>> +                             total_avail/scale_factor);
> >>> +             num =3D min_t(int, num, avail / slotsize);
> >>> +             num =3D max_t(int, num, 1);
> >>> +     } else {
> >>>                /* We have handed out more space than we chose in
> >>>                 * set_max_drc() to allow.  That isn't really a
> >>>                 * problem as long as that doesn't make us think we
> >>>                 * have lots more due to integer overflow.
> >>>                 */
> >>> -             total_avail =3D 0;
> >>> -     avail =3D min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_av=
ail);
> >>> -     /*
> >>> -      * Never use more than a fraction of the remaining memory,
> >>> -      * unless it's the only way to give this client a slot.
> >>> -      * The chosen fraction is either 1/8 or 1/number of threads,
> >>> -      * whichever is smaller.  This ensures there are adequate
> >>> -      * slots to support multiple clients per thread.
> >>> -      * Give the client one slot even if that would require
> >>> -      * over-allocation--it is better than failure.
> >>> -      */
> >>> -     scale_factor =3D max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthr=
eads);
> >>> -
> >>> -     avail =3D clamp_t(unsigned long, avail, slotsize,
> >>> -                     total_avail/scale_factor);
> >>> -     num =3D min_t(int, num, avail / slotsize);
> >>> -     num =3D max_t(int, num, 1);
> >>> +             num =3D 1;
> >>> +     }
> >>>        nfsd_drc_mem_used +=3D num * slotsize;
> >>>        spin_unlock(&nfsd_drc_lock);
> >>>
> >>>
> >>> ---
> >>> base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> >>> change-id: 20241209-nfs4state_fix-bc6f1c1fc1d1
> >
> >> We're replacing this code wholesale in 6.14. See:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?=
h=3Dnfsd-testing&id=3D8233f78fbd970cbfcb9f78c719ac5a3aac4ea053
> >
> > Bad commit reference?
>
> Expired commit reference. That commit lives in a testing branch, which
> has subsequently been rebased. The current reference is:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=
=3Dnfsd-testing&id=3D94af736b97fbd8d02d66b3a0271f9c618f446bf0
>
> > And hence this is still failing in next-20241220...
>
> I haven't moved these commits to the nfsd-next branch yet.
>
> Is there an urgency for this fix? Is this a problem in LTS kernels

Currently there are build failures in linux-next due to this, possibly
hiding other issues.

> that might need a backport? 94af736 is not intended to be backported.

We'll see if the issue ever shows up in stable.
I understand it is exposed by stricter checking in the min/max macros.

Thanks!

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

