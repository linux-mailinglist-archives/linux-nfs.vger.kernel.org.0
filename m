Return-Path: <linux-nfs+bounces-20760-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IxDM3l51mnxFggAu9opvQ
	(envelope-from <linux-nfs+bounces-20760-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 17:51:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED35B3BE80A
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 17:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DEE43073108
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 15:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF4C3AE1A2;
	Wed,  8 Apr 2026 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="rXiloC2E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551A03B0AD4
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663043; cv=pass; b=Zg5DyLS1kKNZk5hMXI7iFal8buLedIpzEFoQM+YQWgGLjP7tTxoSvypP8m+FWVfmEWItXFKTe/gXfs20dAEv1fklnpBh/xl09jlR9AD2YVMy5iY/jVSllPTkSMEGWq4+4Z+KRsETAC/MyOKj7Q5RPOF3IQsZkcaZApSxS9wNEqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663043; c=relaxed/simple;
	bh=thG+Hbavm2FoM+ZlAnIZ0OUGl0bmxURzgAf86pAMZ2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ho9gZ1f+GPbkbjyLJV03e2AKHnZYSvaxuXsJAwK7ikDPpnNTjg7HtuVETBFRjwzI+f4Lr6pfE4O3flJriSN7JlTua9JWfJmr6nav4/LbT4yQhcYq/lhZF/4QnoZX2NjXi9H8zAb3hY3Q1YX5wQuZfIf6U61v2jo0UUrh6IQgpP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=rXiloC2E; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38704f70ea3so382251fa.2
        for <linux-nfs@vger.kernel.org>; Wed, 08 Apr 2026 08:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775663039; cv=none;
        d=google.com; s=arc-20240605;
        b=h0U3DXszFDMPldoiQLihoTXhIEZSTew23h1hcsh5rxsb4NihhOYKj+gtpDn+xbWtcd
         RkzCSTQgpe1GE670KiTbPzXtBXCrqdTaASoXeiJnC7nvGe7mB4u8Kg0cHPqRTQQU/znz
         JfliDT4eZ7XHfOGMYZHDRWMb/qwQrB/yhrEXenRkOKHBqXm7yClkWsl/bvg8hECh4s/K
         wjHBglAIwqKYOSW7DwWfU4aLWHFbcDvX88TkH1pWtKdJ72Jcyp8T0E5bBtLzpljJ8cRk
         xSojyO0y5Jg2jZ4qLPMXsPhcCmzVdNL4rShKxA/U0vMBQMc5uLvzBJeXxTv+Nm3aI0VZ
         q/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8R205rR9c37ax4cG1eZ+775wmPHxAxlOnfVeNJFlZEU=;
        fh=j+1i1sobWnd+31lPit2vE8izCtOaslCkLOngD/6IWHk=;
        b=KCXVGCjdM/1Gf30eQH7vlsKLRheo+3SyKXcPCeWTdM4rwKDxh2HaTQCNDuKEMr93GH
         xpmh4Zwdcn4q4oNp2fYMTcEf515riWuMS3edyyq11awprOo+ecFBvaubaDsgQkZubXMQ
         zxjP1A+rRbIHcxj1Zngy8/qwa1z6IARSPswXK+U8dPCZe0EF4ycapS83oPZ5Mcdn3YPU
         GvE/iR0vBrfZ2xL5Qyp1P/Al8JsahKuOSsVKDMmlfEoL6YNjKsB+L72cxltQx+QPM5xs
         O4ZU/dwZfm0Z/OTnPrhxUq2E1cNhr+BZV2OoWrbxFPcwGp2qW25zbw0SSc139W+qZ7Hz
         +9vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1775663039; x=1776267839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R205rR9c37ax4cG1eZ+775wmPHxAxlOnfVeNJFlZEU=;
        b=rXiloC2EKRZdi2wIJoS0pmCTpZVciWSDStdyRjkU9nv5uHFYCgJa+HQF0GY0TmitJi
         WrT3eMZg5/Shj+7oa3FpIouUWgFMu5slLjYH/4h5M69kyl9OfH317SisEzHOph/XWqZ2
         9anKEomTwixDzNVtKSxw/XFd+gbiTwdkkwymXrq8Ik8xmclY/6IoWrqa1y6MjdkdmF1c
         oajF5KsRrDsNh1o+6+H1dRXgsQqKPcGSecN2uZ0JVMURbiwcHi+Y1MNa/qK+MQcF8+vN
         eXkaH+3YlTS/1FU5BrJ8Mg5XvdBqAlu7bkD6lQZnRMHOwuwq88ltELn8XyzxBp2K+wgd
         sj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775663039; x=1776267839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8R205rR9c37ax4cG1eZ+775wmPHxAxlOnfVeNJFlZEU=;
        b=rbQksbIAwpd40hFfNHk/+leXLMxPBIoz+tX2/s2+5UKhfooslXlYbDZHd8S1cnbtZn
         hb6JLfZu2sssckfDF5Jo6QP6XqPhgEfqISlDNzdQjCs/dzuJKbspUJC2slQRFlZkvCk8
         sEnWGCVG81Icf562SvXUJjm7xXoGJhP3qD7qFSDO+d1G4o2MqnEf5PiU2oCMzis3+IPI
         s80pj7h6ijO4KlcRpXS1J1Ew/BOZIJ0b9bucECnUJOBW1zOuI0pkRq00vDo57xdGkDp2
         jHihr1i8yWn6nNtBZz7SlezJy+glaOPRpZ0UaofYmqV5m+1FbfSMN/LJ+lS7d3Rrqa97
         AprA==
X-Forwarded-Encrypted: i=1; AJvYcCWuWF6aiaEYxxGppRwuW2JUwnycvbk/2/p8YbyiYrUx/8GhqyooIBfJrdaVRRh2IRVWjjnbhu6ji04=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpuuz9SMEDPCIFDa5Dzt7T0z8D6tFO/Ye+ModF1h/l2t4Vq/SQ
	Hjd2cGOOAuwwREMlwJy9ZFEyBYKTe2yPvIwmoDUw4UK1l+SgEqhy90ASOHEjDlIy2rPp3YXH/6n
	W6RvvsM6UAlwKWCd+Fp8qWsiFHDZ/VFcI5Opg
X-Gm-Gg: AeBDietlQRQLqS8hglnh8YcpcJj1OQ+IYN7//2jG6GW6oyqFKs9qHjw495/i5epdJWT
	ffxRlfyRzo0HqX5YasoX9OcfytkSnvWQLdfurYZXKQ2d1ax0prodxtdti8UbV0ANesLCc0dRD75
	gh5aBKisMUS1YO8YCQ0Jr/rib5NyHcWftps2h5kj/5s0PB74LTn22QSYfbTvYqfVy2TJ3WBrUiL
	RcTabEMKZMT8dWt4aa8Mm7wNXIvSgSlIwWpbOSD7b/76OkVme+46pwb5ItnnA4mV4BgUVAUq/PM
	NRfem411MSRUIb78krT9yBnZz15vlSF3wbTFeIygCA==
X-Received: by 2002:a05:651c:1b06:b0:38c:d039:46c1 with SMTP id
 38308e7fff4ca-38d91c1a5c7mr66571131fa.18.1775663039091; Wed, 08 Apr 2026
 08:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407235038.55749-1-okorniev@redhat.com> <20260407235038.55749-4-okorniev@redhat.com>
 <937c9434-07b1-408a-95e1-a5db7962c504@app.fastmail.com>
In-Reply-To: <937c9434-07b1-408a-95e1-a5db7962c504@app.fastmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 8 Apr 2026 11:43:46 -0400
X-Gm-Features: AQROBzB50JD0Ggb3fuu6BeEZgJ87lZPTIspRvpMRg0cuxr9fjYjPrZDsTotMl34
Message-ID: <CAN-5tyEjhiD1=K=ShJxGXfkvs+KARC_j0WZSqgHRBDm_d7Xcpw@mail.gmail.com>
Subject: Re: [PATCH 3/3] nfsd: update mtime/ctime on asynchronous COPY with
 delegated attributes
To: Chuck Lever <cel@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, neilb@brown.name, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-20760-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[umich.edu:+]
X-Rspamd-Queue-Id: ED35B3BE80A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 10:10=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Tue, Apr 7, 2026, at 7:50 PM, Olga Kornievskaia wrote:
> > Asynchronous COPY should update destination file's mtime/ctime upon
> > completion of copy work (not COPY compound processing).
> >
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/nfs4proc.c | 21 ++++++++++++++++++++-
> >  fs/nfsd/xdr4.h     |  1 +
> >  2 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 04d8d0d1ca7d..d858a5b58a24 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
>
> > @@ -2134,6 +2134,16 @@ static int nfsd4_do_async_copy(void *data)
> >       nfsd4_send_cb_offload(copy);
> >       atomic_dec(&copy->cp_nn->pending_async_copies);
> > +     /* choosing to check for existence of set dentry pointer to indic=
ate
> > +      * that we need to update the attributes and do a dput because th=
e
> > +      * file flag could be cleared by a DELEGRETURN and then we'd lose
> > +      * that copy was started with file opened with NOCMTIME and we go=
tten
> > +      * a reference on the dentry.
> > +      */
>
> Nit: "we gotten" might instead be "we had gotten" or "we got".
> And let's stick with "/*" on a separate line to introduce
> comment blocks in NFSD.

Will fix. Thanks.

>
> > +     if (copy->d_dst) {
> > +             nfsd_update_cmtime_attr(copy->d_dst);
> > +             dput(copy->d_dst);
> > +     }
>
> Jeff earlier suggested that the timestamp update should happen
> before sending CB_OFFLOAD, so that a client issuing GETATTR in
> response to the callback sees the updated timestamps. Should
> nfsd_update_cmtime_attr be moved above nfsd4_send_cb_offload?

I'll move it up. I thought that since nfsd4_send_cb_offload just
schedules the CB_OFFLOAD and returns, then placement of
nfsd_update_cmtime_attr isn't so critical.

> > @@ -2193,6 +2203,11 @@ nfsd4_copy(struct svc_rqst *rqstp, struct
> > nfsd4_compound_state *cstate,
> >               memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
> >                       sizeof(result->cb_stateid));
> >               dup_copy_fields(copy, async_copy);
> > +             if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
> > +                            FMODE_NOCMTIME) !=3D 0) {
> > +                     async_copy->d_dst =3D cstate->current_fh.fh_dentr=
y;
> > +                     dget(cstate->current_fh.fh_dentry);
> > +             }
> >               memcpy(async_copy->cp_cb_offload.co_referring_sessionid.d=
ata,
> >                      cstate->session->se_sessionid.data,
> >                      NFS4_MAX_SESSIONID_LEN);
>
> The error path checks FMODE_NOCMTIME to decide whether to dput,
> but three gotos reach out_dec_async_copy_err before the dget:
>
> nfsd4_copy() {
>     ...
>     if (atomic_inc_return(...) > sp_nrthreads)
>         goto out_dec_async_copy_err;    /* before dget */
>     async_copy->cp_src =3D kmalloc_obj(...);
>     if (!async_copy->cp_src)
>         goto out_dec_async_copy_err;    /* before dget */
>     if (!nfs4_init_copy_state(nn, copy))
>         goto out_dec_async_copy_err;    /* before dget */
>     ...
>     dget(cstate->current_fh.fh_dentry); /* dget is here */
>     ...
>     if (IS_ERR(async_copy->copy_task))
>         goto out_dec_async_copy_err;    /* after dget */
> }
>
> If FMODE_NOCMTIME happens to be set when one of the early gotos
> fires, this calls dput without a matching dget, resulting in a
> dentry refcount underflow.

I will attempt to correct my error handling dput() in v2! Thanks.

> Additionally, the comment in nfsd4_do_async_copy explains that
> FMODE_NOCMTIME can be cleared by a concurrent DELEGRETURN, which
> is why the thread checks copy->d_dst instead. The same reasoning
> applies here: a concurrent DELEGRETURN between the dget and a
> kthread_create failure would cause the error path to skip the
> dput, leaking the dentry reference.
>
> Would it be simpler to check async_copy->d_dst here instead of
> re-reading FMODE_NOCMTIME? That field is NULL before the dget
> and non-NULL after, which handles both cases correctly:
>
>     if (async_copy->d_dst)
>         dput(async_copy->d_dst);

Will fix. Thanks.

>
>
> --
> Chuck Lever
>

