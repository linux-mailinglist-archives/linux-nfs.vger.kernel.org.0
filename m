Return-Path: <linux-nfs+bounces-20801-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LfNDiL112mrVAgAu9opvQ
	(envelope-from <linux-nfs+bounces-20801-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 20:51:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F6B3CEDB5
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 20:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B46763007512
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2026 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC47314A90;
	Thu,  9 Apr 2026 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="fhr/NvyQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D22EBB89
	for <linux-nfs@vger.kernel.org>; Thu,  9 Apr 2026 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760671; cv=pass; b=Mvwe/0jlZ3/nDSFSUB0TpooakJKVzwM6fvSINsmqa5Jj1pdvpZTvGNlfCZ2qLBz5tlodCy3ZYWYgW47ibMO0CNXZScokvSAWOYMvJjZMJl7ZBmAO2jg265Q4w+MynrNB/xtP+oV60KaA3S0YlKWNSWUSaE7i/2BJAFyrRsFfAjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760671; c=relaxed/simple;
	bh=LK7p/QyMmdvdjMrjPbQiDTo+Cu9ufkG5Ex6Uu+D0CvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4Brs0Aw1TB4vcVi9MYOazlP4Kd2GfEYQhnSC/ob5J848bzqD7g82wdnJ8ibEarJpn7OQxqK4GXlMJtdXdd29Fftz7zs7x5LBrpeMuqKjNtqDCq2XRXNyarEuP1nKVOQk9A0XTUvaBMY3m/rQ4etFr+SDTVcRR/Ehs9RAQ9j79k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=fhr/NvyQ; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38e09b14102so10891081fa.0
        for <linux-nfs@vger.kernel.org>; Thu, 09 Apr 2026 11:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775760667; cv=none;
        d=google.com; s=arc-20240605;
        b=efb9FuNqt0nawhaqwMDfShhrBziMO8K6z0AXmYpY+zs6uFNvYlqQ+gilOZnLFJ3dRW
         qnPDosKExKEbiOGuchrcvRbytcT/vVlmX3+dl3/2JIbSkSi5Kxz4Tbm2kdXZMsMBaKu6
         AHc068yX6Y93EvXBKByod6tS80H/+/TPqeHkfNKgpcN6QEQy8fQUC4gIzebJYQBZ3cxf
         RtsR9THpMziaVTP2cpm9tsGj/nolXcAgDVrzTHdSUKLj4udVpHXFtY4UF0M1P/0Nz6W0
         ufGYLJ6QHe4v1ur1I0WW+QAtJLFkMDmyDa1MXhG+Ap1z3ucZ4AurACifOLLzw4HrWwn5
         RPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nxzmQRJ5s5sK5b5gX4hEOl/tdNIB6drrqlSOOMjwlTk=;
        fh=DsquSlI1WCwaUUjcxwysGJ4ZH6zLXys21bLCdokfBg8=;
        b=hP/CA/Nq88EO3HG6w1hwVNWel90g41UTz4ddqfyT0h8c2HoaFTfM8U06QmO4iF/sJz
         WYbSBDeq7GSdjNWRugYiF066D4lIWoMZwUxF88/LkI55MzAQbyDf79N5tPDkxp7jAucZ
         qPSXZsgwtm5KKXaz0d5fMB2FXI+LzVSwjrmZyz4cWAk8FDjOSdJR+KIMleiRojeKlooL
         xWtffBHngYCXRuOc7teTq8gZdwGzsma++5AKRTcsrrzZP2Ae+REo7vKbGzY7N9Y0SAAe
         4gRzT+7GeUzeusiYdATjT/FpV8IwBNOiTRYkMsmADQlMT6XBk7x/uVgqHQefLpRinMq3
         qzhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1775760667; x=1776365467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxzmQRJ5s5sK5b5gX4hEOl/tdNIB6drrqlSOOMjwlTk=;
        b=fhr/NvyQQC8wHrpP+S3idCNlUbWrrvWWd/c4MBvPYOsPdYDefGUqbS8W6KGpnBvcIn
         YDssi93Dzox/FFOwh8Pg1g/VTR+yOmQwSUo0sTuQ+AQTu7gF2DGExPHJMngZH0GRl528
         ijCvhd85pdbVx/2eMwhL3RRcf3UuOaWZC2qKhnBWl5REtlMv9UwI6uBnUkZKmOya1GxG
         w6lKmQteUn1LPIxj62IkSvz0/QiM7GzMK4bVi9TscnBM8mdkrV9InwXLFH8Nj+t/gEPZ
         ECykQfbZAdKVMVa9rUTMoXk2C3qmSLxG/30s6Ryz1yXi0eUzFWrkrZth0IoXZt/gRtjh
         OorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760667; x=1776365467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nxzmQRJ5s5sK5b5gX4hEOl/tdNIB6drrqlSOOMjwlTk=;
        b=oKYJ4Vju4n3sZnBeJSNmqhsyGRH9qYjU6bZQmtZwj7bL/AMl4dP0QTzlIXQPdnMQca
         GNjXVMMfgy78Qhy3Y5M+7AkN1NjIzbUbowyb7EAOdD+w0KfaZD8NoMy8p109Yzf7Anbm
         J29+RBpOnoxDjnrfWR3xam0Tn4qaFON3/TsgAgc0LKCKA8/wZTNFeyFYngMD310KPqyT
         7n6CTzTzGbPV8FixIxrr5Jp6MKq+uiKgUEDdKE91XKMWYKyTA1+7txpb48TkE8Fl2Nru
         xAz236XQ13p2mgT8uI6/N8VpUpCFtVwSLsMpp0hKS0WKb6DBJ2ckrEMZ8SHXh8eCCXF/
         HPVA==
X-Forwarded-Encrypted: i=1; AJvYcCVm1tPDUi5BbDXmcFeABoMeJfyU8307mTUW4r60kauyoE5J8EyV5we2QAgcytRvly2Mo7/raIFKnwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUzgbHoSushO9M3d2WLCS/7SGO2JrK2TjkX6fs0eIWqodrwWmr
	z9mv8gqFMptnNgZBfWsSKJKq2CQjAD4kMkZfbZpvsHQ5NfLlTe7ewAB/FNM8Rkqsmh5XFEzE5Zo
	Ac7a9a9CRNTVBQKYRcMjj0KsnJtiwkq4=
X-Gm-Gg: AeBDietlSm7MsdduenWpMDAPhWafI/PvAgcs72MfT9HSTJGRKdb5u6Q1wPJHHWGFRwv
	roh5S8b3Sqltx+l6Njo5rktp4nctqcRAw7hC79KjjAjlc2SRy8zJhKsNfYceCMSljj24Ev9ulg4
	DrBQvXSAesH3gEdCgK0ghcMiEjvosNTvVoGiMnzfAwFY1s63jj1h27xP2LV0bjQAUkEyGMjappU
	jEve5aNx6/buH31a8tHRgTDqQRt3SkNA59y39EjXFOCRiXKxkpEqxnkQ01Ov3cVs0h5Rx8SaFxW
	YTqegrgvoEBeXM0hu+V4bfRrcexCPsIlmAtjZWdhpw==
X-Received: by 2002:a05:651c:400a:b0:38e:21bb:b2dc with SMTP id
 38308e7fff4ca-38e336ce9c2mr10700721fa.32.1775760666880; Thu, 09 Apr 2026
 11:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409164316.19748-1-okorniev@redhat.com> <20260409164316.19748-3-okorniev@redhat.com>
 <DHOUCAZKI2KW.3PU9H7KPOE2H7@kernel.org>
In-Reply-To: <DHOUCAZKI2KW.3PU9H7KPOE2H7@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 9 Apr 2026 14:50:54 -0400
X-Gm-Features: AQROBzDyQHTHg92F-KKaBvc4-W0kFc2wj33eQx2Fl1Uv3xstmrxmdxgACfNXEmg
Message-ID: <CAN-5tyHoeHbrstyCAMWssOX1SH+ztzech726SXTfUsUbj26OsA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] nfsd: update mtime/ctime on COPY in presence of
 delegated attributes
To: Chuck Lever <cel@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com, 
	tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20801-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[umich.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,umich.edu:dkim]
X-Rspamd-Queue-Id: 56F6B3CEDB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 2:38=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On Thu Apr 9, 2026 at 12:43 PM EDT, Olga Kornievskaia wrote:
> > COPY should update destination file's mtime/ctime upon completion.
>
> Let's provide similar rationale here as was done in v3 1/2.
>
>
> > Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRI=
TE_ATTRS delegation")
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/nfs4proc.c | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 5091527a6dc7..4418e71c8458 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2124,8 +2124,22 @@ static int nfsd4_do_async_copy(void *data)
> >
> >       set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
> >       trace_nfsd_copy_async_done(copy);
> > -     nfsd4_send_cb_offload(copy);
> >       atomic_dec(&copy->cp_nn->pending_async_copies);
> > +     /*
> > +      * choosing to check for existence of set dentry pointer to indic=
ate
> > +      * that we need to update the attributes and do a dput because th=
e
> > +      * file flag could be cleared by a DELEGRETURN and then we'd lose
> > +      * that copy was started with file opened with NOCMTIME and we go=
t
> > +      * a reference on the dentry.
> > +      */
>
> Now that you're not dealing with dget/dput, this new comment is
> perhaps stale.

Missed that. Will fix.

> > +     if (copy->cp_res.wr_bytes_written > 0) {
>
> Don't you need the FMODE_NOCTIME guard here too?

Yeah I realized that now checking for the flag might mean that if the
flag gets cleared we won't do the update. To handle that case, we
again need to add something to nfsd4_copy to say do-the-update by
checking the flag in nfsd4_copy(). Alternatively, I thought it would
not be harmful to always update the c/mtime upon completion regardless
of the delegation?

Do you want me to add the do-the-update flag instead?

> > +             struct iattr ia =3D {
> > +                     .ia_valid =3D ATTR_CTIME | ATTR_MTIME | ATTR_DELE=
G,
> > +             };
> > +
> > +             nfsd_update_cmtime_attr(copy->nf_dst->nf_file, &ia);
> > +     }
> > +     nfsd4_send_cb_offload(copy);
> >       return 0;
> >  }
> >
> > @@ -2201,8 +2215,16 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
> >               wake_up_process(async_copy->copy_task);
> >               status =3D nfs_ok;
> >       } else {
> > +             struct iattr ia =3D {
> > +                     .ia_valid =3D ATTR_CTIME | ATTR_MTIME | ATTR_DELE=
G,
> > +             };
>
> You could move "struct iattr ia" into the helper, and just pass a "0"
> at these call sites and "ATTR_ATIME" at the
> nfsd4_finalize_deleg_timestamps() call site.

Will do. Thanks.

>
>
> > +
> >               status =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
> >                                      copy->nf_dst->nf_file, true);
> > +             if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
> > +                            FMODE_NOCMTIME) !=3D 0 &&
> > +                             copy->cp_res.wr_bytes_written > 0)
> > +                     nfsd_update_cmtime_attr(copy->nf_dst->nf_file, &i=
a);
> >       }
> >  out:
> >       trace_nfsd_copy_done(copy, status);
>
>
> --
> Chuck Lever
>
>

