Return-Path: <linux-nfs+bounces-20758-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBaCLIFw1ml2FQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20758-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 17:13:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A41CB3BE072
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 17:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6F3130BAD47
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BC83D47DE;
	Wed,  8 Apr 2026 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="hmVwQX3H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE403B6C07
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775660933; cv=pass; b=F0o7KNLGmGYttysWmh44nSOL+bHPaaHstDFxIAYtyaCMOqteSvwL0wP0Sn+qu6t2bx916x4WAeWADczjcVCr5fJeQBl59FhJmboZib3mQUSQMfmLhjiJudOHHkkIr5iLrPnFeyUiEUFFGnhyH7TXZ1HDDg00ksu29XM2mTrKK+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775660933; c=relaxed/simple;
	bh=KElmK+VVxxwJGJeJaNqk5EvW/9/j/l56fz2pIYn7SeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aETfuaYk4/EdS1zZ61I1QD/zYaomWYiGzj9JVrRIIjoNb4KjSJ7bSsnWN/bPo7pTLtjTbC/5Ui34comzTu+2vj4b/f7DVsGkqytuucWmrg089hYow0B2qRmDOVuBCPWxf1phPQe3kolsiWW9WdtpeT7lgRlZyoraMxuGtOSEd70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=hmVwQX3H; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38dd9f0fdc6so11167481fa.0
        for <linux-nfs@vger.kernel.org>; Wed, 08 Apr 2026 08:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775660929; cv=none;
        d=google.com; s=arc-20240605;
        b=FtylDYgM50e/KpDidNZ6VMjWWMaS4MaLfOcD0RohPVUSOFa+JoiCVSWocGkyvEdh62
         /4l1HekamYDMzdH2JEPOPFOe268AwvV6uNinCODWP61f/2iUS8dyaeMrXBmXyTjJcEqk
         x4raYhSBo4wLmBH1VO/ANxRUyMJQ5DwNlqzhW8zcEhq8rUJ0+VsaCgUHAc+iXyaoUdmo
         Im1HnleCTFOtXg9a0YkQ8maXm+VP3dijGLvZSfQ1cTW4harvSUJVYZtH6lzr7TTUEbhk
         xcP/BifoMsger8tdzztWcvUKPdEQF25Ewsl3toQhZarj+a/+ABbj9KktGc0szDuM7DBy
         L58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=csL7zqlm9DIsUy6yR51KykBt3Qg1ZcCEQXbyz0Vw3PA=;
        fh=xaQBnaybrjujbEW/GUsi9rO7NpuDpWqolJa1sMAc8e0=;
        b=WIIX1/YKEWE5hFK1F4AT1CQr+m5kc7xVusDStOuk1cSAOy/odj/7KEIfdqpTCy/6p9
         hBHShP2tJYlbjshOyPZNyuSHcQ9LXwJKldD3ZprDIPZybDDke4doQPOjz3wJlYCHHv1/
         2EF8Z3BbQQIFXQ68pnssEysks1sOfS0JU7J1HC/kXM33/4Q5nfxsz3/HVAicJQT/tw+8
         eBgJK1ZoDd1/gGN4YRus8jDOfA5Dez8poC16m2SyFv+R6A0F1nU4T9rIZz5CtFDYp8S3
         +XxZW/COpTTco9Tye5ujadRKUMnU+msUMDyTEEG7fIPi0G/JU2ScoyU7R/SWOqvJDvIT
         JY5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1775660929; x=1776265729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csL7zqlm9DIsUy6yR51KykBt3Qg1ZcCEQXbyz0Vw3PA=;
        b=hmVwQX3H9Wg1j5xfm7sx6FxZroAveXCkrAVJcaokvFVAS3fZcqu1IRqg5T6gWtsB+b
         0yLIOmkDsTGi6eF6LnZmJfz0rA3ovCCkstUkMIoCmevzS5FQrNhyEP+iHwKFXJ1e+P6e
         7viTaGNNerDV1Bbl+03EAb+5qKwSiyN1MffGU0I9/xceiqS70K7SmSyBbm7jIgZj5h7S
         eJJJGDXrLYnCqftrSJ19stpPpGNpTGeRJpKItpcUE8tC6H0ZjjqNjjI/9uTlF1al3C4e
         A87SJKTQhsQeQJzq4HKlAhAWP5udG3xpdKwcb87BvKe8P6UqzGVp3WWauhBiO7YJFHVj
         HXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775660929; x=1776265729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=csL7zqlm9DIsUy6yR51KykBt3Qg1ZcCEQXbyz0Vw3PA=;
        b=HpIQQAXTpgLMQ5Zdz+P2JM/88fsZAcEHI7mocCkva/aiIl53ZEi6YiEjGblywg0act
         WWrpl+u90wzbr89fn4GjLrLS/CR7vlXW1XDBzIuBNx8XpaTgez2Ip7elPPCwhOMxHmvQ
         kAKsp0oicvWMCYlWvc1tqrMbHJdxkDu/xIWKaTw0qeQDyL/+P2+pa67X3pu/kpOgk2Ni
         pxx+0h73k6846H6Np8pDPs/2qcZNMaRvRbuaROhoZPfcdMQS2CiVoR9cxVwAFRgh3r4r
         0/92qrN73Jhd8bmWc78sSrXqSXSGviQquJBpTks8pD6fkMHJBMS8dCSsOIo03AbB9UjD
         G8Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVtjgcgRFNsrn9aH3M95DDnrRxzKWqFpP3lX06L+azRD8NTCzKJpYgiyn/2cLE3LEqzz1vt6RbyTuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqrcf+F0k5xxqbJyjtvKUWIqBMyJE/ENw1jqoNCMm4MsduQOLq
	7725hrE/8Oz5iwMh5JF5hCmDzCM+YWWmCiuddOUFpczfyQiSr2ZQxTrmyRBelOkXFaHgGK1FJxX
	PhMVJYXkHXvDZBO68ChRouwlQokZ/wNg=
X-Gm-Gg: AeBDietb/Vn+peW4p6pJmE8G51GcG290unByFsC5daQDOli0nnk2hkc7icFzEK/P0Fy
	nuoMguvU2F0I8DeHd3j3MwmMJmqw6qhIIuspx7BjlEv80QS6TLQs7sW58ShQ0jj6CcQWiUsgyU2
	C8MzUSdxycmeu8G+szL1awTkXyu314PFyNMGuDyhW4/ujvNVGTVIX9dhQCMBjmOveeq9MbsUqwv
	w25YEZGlVL3+bWvmlQZZFUk5pIvci7xkZDKjMqdWEy3dn01vQZf/nUzJU3X+zp3G7LNACNl1sXc
	NpfCEGC+TL4uMUHoNqY4blBfOgTgA3UBzqio5TAseQ==
X-Received: by 2002:a05:6512:4894:b0:5a3:4c32:a960 with SMTP id
 2adb3069b0e04-5a34c32a99cmr5980580e87.7.1775660928902; Wed, 08 Apr 2026
 08:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407235038.55749-1-okorniev@redhat.com> <20260407235038.55749-2-okorniev@redhat.com>
 <9a8cdd25-a3e6-4e4c-bfb3-bd8a7f90b077@app.fastmail.com>
In-Reply-To: <9a8cdd25-a3e6-4e4c-bfb3-bd8a7f90b077@app.fastmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 8 Apr 2026 11:08:37 -0400
X-Gm-Features: AQROBzBJg6uY5aR8PFehs-ASA0CpYqLrNoGiKho4TscLZk0Cx2q8iyXp8KTfM-M
Message-ID: <CAN-5tyHNsZvoo+QB8Ug2Sbgq7asUUtr-RYDMM8MxuQGgfySnPw@mail.gmail.com>
Subject: Re: [PATCH 1/3] nfsd: update mtime/ctime on CLONE in presense of
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20758-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[umich.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A41CB3BE072
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 9:53=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
>
> On Tue, Apr 7, 2026, at 7:50 PM, Olga Kornievskaia wrote:
> > When delegated attributes are given on open the file is opened with NOC=
MTIME
> > and modifying operations do not update mtime/ctime as to not get out-of=
-sync
> > with the client's delegated view. However, for CLONE operation, the ser=
ver
> > should update its view of mtime/ctime and reflect that in any GETATTR q=
ueries.
> >
> > Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding
> > WRITE_ATTRS delegation")
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/nfs4proc.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 99b44b6ec056..fb891e35ebe9 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1396,6 +1396,17 @@ nfsd4_verify_copy(struct svc_rqst *rqstp, struct
> > nfsd4_compound_state *cstate,
> >       goto out;
> >  }
> >
> > +static void nfsd_update_cmtime_attr(struct dentry *dentry)
> > +{
> > +     struct iattr attr =3D {
> > +             .ia_valid =3D ATTR_CTIME | ATTR_MTIME,
> > +     };
> > +
> > +     inode_lock(d_inode(dentry));
> > +     notify_change(&nop_mnt_idmap, dentry, &attr, NULL);
> > +     inode_unlock(d_inode(dentry));
> > +}
>
> I think there is an active delegation here. Without ATTR_DELEG,
> notify_change() calls try_break_deleg(), which will return
> -EWOULDBLOCK, causing the setattr to be silently skipped.
> Wouldn't it also initiate a CB_RECALL as well?

Destination file is opened for write (and has a write (attribute)
delegation) so there shouldn't be any conflicts. I don't see any
delegation recall triggered while testing CLONE. However, looking at
the code I now see that it does make sense to set ATTR_DELEG so that
the code under "if (!(ia_valid & ATTR_DELEG))" is not evaluated.

> > @@ -1413,6 +1424,9 @@ nfsd4_clone(struct svc_rqst *rqstp, struct
> > nfsd4_compound_state *cstate,
> >                       dst, clone->cl_dst_pos, clone->cl_count,
> >                       EX_ISSYNC(cstate->current_fh.fh_export));
> >
> > +     if ((READ_ONCE(dst->nf_file->f_mode) & FMODE_NOCMTIME) !=3D 0)
> > +             nfsd_update_cmtime_attr(cstate->current_fh.fh_dentry);
> > +
> >       nfsd_file_put(dst);
> >       nfsd_file_put(src);
> >  out:
>
> Should this check whether nfsd4_clone_file_range() succeeded before
> updating timestamps?  If the clone fails, the file content is not
> modified, so a timestamp update would be incorrect.

I thought about doing it only if (!status) but didn't know if there
were some errors where the file was modified but an error occurred.
Sounds like a v2 is needed when it's only done for success.

> --
> Chuck Lever
>

