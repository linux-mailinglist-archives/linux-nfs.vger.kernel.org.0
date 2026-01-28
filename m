Return-Path: <linux-nfs+bounces-18563-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOM0ICL4eWkE1QEAu9opvQ
	(envelope-from <linux-nfs+bounces-18563-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 12:50:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACABA0D62
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 12:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 260AC3020A65
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A4B33F8B7;
	Wed, 28 Jan 2026 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR8mdWDW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8286D242D6C
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769601001; cv=pass; b=GezvXX3hf6DrTMIFAdJkchqHHq7DEwhFRCHSq1vF8dzqUbbapg9A6QDTWanwt8O04CAc3y+j8uktAuZ4ynl3HUHL+5RFSVAmm5gkbu6TJi0nYVF6VY2nP+IVhW6KsS9kL05GG7UI69lu39FYWtx2yRIo8LoC7Fuuh69Ne4RchYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769601001; c=relaxed/simple;
	bh=hSMXOh0Oo+nPWIXGNy6Xy2ffhiMjw7bfObWyXyyTRFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p98cJlynBQFcnBzEo/t2uZC6OcO0rLhBQrXwKxpzfHBocq3dfCsHLHxuYr8lvP3t7kiEr7oO3O3ffPV4UgkbcPUwy7CpFbeJIz11Ze08TxyY5R2hURyyM1+ifBYBnB94XvEiKAwsItqls37EaJw/ZvUOXjbAFHcj8zEmO+M3rDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR8mdWDW; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-658b9e95990so931970a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 03:49:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769600998; cv=none;
        d=google.com; s=arc-20240605;
        b=LDYIimz1HsUgYjAeM2/N5NI/S7SPL+VKpjkdQx1UvVFeVyHa0K2QUnoxsyW0tArNfW
         rDnJZtmLPPj5DD91CqfX4h3y/TRLEKHWNNawuWXxL/VZnB04gby4hoRl1dxUlgfXiB4O
         EvdxqzAS3TC4JpMaX7yciYcjL7au6VAxgTHGEmT78kUcWPvBJ3aiz/HbFjbfJBX8z7A3
         /uDAxyn0qPhKiJkejRcpy0FpJepxmLFKbzz0kTgO2E8UY3cxGy3Q0Xwo2OqyrrQylwHx
         MjEnQSh5rmiF4q87dbxtPrXaTunytehkouyyvUJvQQTSDYUs+L4wHb4aeHAApL5lMh0S
         eKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OOBXUmD9goqwIlvz3iQRg+SdG5i2nFccs0lUKwf+dUE=;
        fh=g6Cy1XYVKOVsufcHPPxYfehcW2hw4GQW3WBZWxAVIEk=;
        b=IIRNjqsFXqbNNqe6ATn0JHqvvwrnN9uvHn6ojCr7Ju1MeD28oQb0pTDMlDpEOSJ0E2
         IwJBQ6hzuiUVyaH71RTbV51jufRWB/5gRSZ9nAQEtcI0ivqzFtDbCSe2PglZJzkfv+oe
         sb6xhaibByss+6vbDeiAnl+X7blc/NJeWW42Tt61Oe4CiDFQA4rRUezLS6t+l1/UZA4j
         +Dsz+RzCdYgdoHHTLwDT27PTjFiON1zaAtgKS757uUaZFBXWLmYEOlI9Wbrxbj5iZcsb
         Np62g+5wOhuWU2Yyj+MvX6iDgv5n2nCCsGHxDguVi2L91/7L6Vnd1yWm3kamf/Ehs9HR
         gGhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769600998; x=1770205798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOBXUmD9goqwIlvz3iQRg+SdG5i2nFccs0lUKwf+dUE=;
        b=FR8mdWDWBW61A+py/5HoKRuev9mIZIpSmqKtTdkiRzhJx4yurwTyHJqiayDAei1JJV
         D8rE15bAbp4yruitOxN9ghocp5wUSHwvtzUpipos6frHL91+9nHe4nsGR8VxAuGxJkQY
         tnIovD3EuXHOfvTUV81DwMwIcNnJFeO2rPKJTX5gK5nMutc6lAxKlRsr0kF9eQb13l1F
         xQMfKXrVAS1lxlIvk+4hGHrRSlVu7uUqk3G2YfvExfFWKiyZE0qMJQgnaSXieYTrDUCR
         0hHT05bTTVJeGqZ/a5iyA5Rp/Ex6gwYwk1F7BGNNHEbliXytUdSPaj5GtEEG8G+yy+Bx
         714w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769600998; x=1770205798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOBXUmD9goqwIlvz3iQRg+SdG5i2nFccs0lUKwf+dUE=;
        b=ByD+Q0OzXgiSNZelEZWkJtIQexGY00SRamomaP3LF0b3Z4R00tp9IfLhvohaRpb3Q5
         Md4BqFsk+q2Gk/995dCq0tDA5FJhQZNwnVdnVOtg0/ltKZhp+PnAxQGRU5aJDGB03Mjj
         D2SZfVQRVfZOL73zzQguwsUMnytBqnyu2UfoxJMt44hCQe9uvI4jrNe0SexhB4RYNAcR
         8DQ9W6W18U5Y2PbYvu5qfnE5Xx4qXjpeNrLVa6+0rZ8TryUVAU92GiUvD5tbW41ZuW/h
         ksW6THqz3CKuxE1oVcpLFRHNOWNYJL+ibd7tqEWoRzefmQUbXIETJZBkoYSCNZ8drPvH
         mMvw==
X-Forwarded-Encrypted: i=1; AJvYcCVme2C29nv6bE849cMzgG5ySr+2Hi91N/Z1jR7UggUdjFsTDc4Kl+UA6tZA5hsFymyfR3MlLafVT0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCkthWo3mA4iqBWaIIWOM/T3SOxoRJLdy1FcBSUbTNWTS7gmgG
	ch7ibjQMGB4J3xceYg+CaqWMb3TjARyIgA1LRT+twuILBLtaWbmp+CNg1lkVHSdPm+8UvuabOhR
	fdgDx9f+ngkavdXefnZPfD+JPGmcrsKM=
X-Gm-Gg: AZuq6aKYkeRE8mrBk2cdlLBo2+9SI4QQBVzT51GizbWqKfq4jZTn6UJYw1ZDMYsvn3r
	4ibl4wU89mQe4Dej0ejY+lZgkH+e5ay9iso3/Z8APc648Yq2YI2RMw5kl//EL1CYKDUmZmFQzu4
	015n69+USv1w6Bj6sdn06uzYSUqudUpI1aLxC38WO4jijWy8Y/7m0sYpah0094RK9LZ7irQdcuL
	dQfnv4o/ROgAZ8KKK9zE0Sn738XmobOR3YWh1pRJ3PaHZVJa8C+hl4LWbxeoOZFxvW6Qsnxhfqj
	K8YZL88ii8ozCdoVbeV1eFvdgMruug==
X-Received: by 2002:a05:6402:35c1:b0:658:2fd1:b0ab with SMTP id
 4fb4d7f45d1cf-658a60b78d2mr2846925a12.29.1769600997470; Wed, 28 Jan 2026
 03:49:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
 <20260114062608.GB10805@lst.de> <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
 <20260115062944.GA9590@lst.de> <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
 <20260115072311.GA10352@lst.de> <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
 <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com>
 <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com> <CAOQ4uxi988PutUi=Owm5zf6NaCm90PUCJLu7dw8firH8305w-A@mail.gmail.com>
 <33c1ccbd-abbe-4278-8ab1-d7d645c8b6e8@igalia.com> <CAOQ4uxgCM=q29Vs+35y-2K9k7GP2A2NfPkuqCrUiMUHW+KhbWw@mail.gmail.com>
 <75a9247a-12f4-4066-9712-c70ab41c274f@igalia.com> <CAOQ4uxig==FAd=2hO0B_CVBDSuBwdqL-zaXkpf-QXn5iEL364g@mail.gmail.com>
 <CAOQ4uxg6dKr4XB3yAkfGd_ehZkBMcoNHiF5CeB9=3aca44yHRg@mail.gmail.com>
 <ee38734b-c4c3-4b96-8ff2-b4ce5730b57c@igalia.com> <8ab387b1-c4aa-40a5-946f-f4510d8afd02@igalia.com>
 <CAOQ4uxiRpwuyfj_Wy3Zj+HAi+jgQOq8nPQK8wmn6Hgsz-9i1fw@mail.gmail.com>
In-Reply-To: <CAOQ4uxiRpwuyfj_Wy3Zj+HAi+jgQOq8nPQK8wmn6Hgsz-9i1fw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Jan 2026 12:49:45 +0100
X-Gm-Features: AZwV_QiAes4F6-nhL9J4dFPbEOm7D7xrxYRKJxjry6rXeIbQy7RViH-qtuWr0fQ
Message-ID: <CAOQ4uxhHFvYNAgES9wpM_C-7GvfwXC2xet1ensfeQOyPJRAuNQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	kernel-dev@igalia.com, vivek@collabora.com, 
	Ludovico de Nittis <ludovico.denittis@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18563-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0ACABA0D62
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 11:45=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Fri, Jan 23, 2026 at 9:08=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@i=
galia.com> wrote:
> >
> > Em 23/01/2026 10:24, Andr=C3=A9 Almeida escreveu:
> > >
> > > Em 22/01/2026 17:07, Amir Goldstein escreveu:
> > >> On Tue, Jan 20, 2026 at 4:12=E2=80=AFPM Amir Goldstein <amir73il@gma=
il.com>
> > >> wrote:
> > >>>
> > >>> On Mon, Jan 19, 2026 at 5:56=E2=80=AFPM Andr=C3=A9 Almeida
> > >>> <andrealmeid@igalia.com> wrote:
> > >>>>
> > >> ...
> > >>>> Actually they are not in the same fs, upper and lower are coming f=
rom
> > >>>> different fs', so when trying to mount I get the fallback to
> > >>>> `uuid=3Dnull`. A quick hack circumventing this check makes the mou=
nt
> > >>>> work.
> > >>>>
> > >>>> If you think this is the best way to solve this issue (rather than
> > >>>> following the VFS helper path for instance),
> > >>>
> > >>> That's up to you if you want to solve the "all lower layers on same=
 fs"
> > >>> or want to also allow lower layers on different fs.
> > >>> The former could be solved by relaxing the ovl rules.
> > >>>
> > >>>> please let me know how can
> > >>>> I safely lift this restriction, like maybe adding a new flag for t=
his?
> > >>>
> > >>> I think the attached patch should work for you and should not
> > >>> break anything.
> > >>>
> > >>> It's only sanity tested and will need to write tests to verify it.
> > >>>
> > >>
> > >> Andre,
> > >>
> > >> I tested the patch and it looks good on my side.
> > >> If you want me to queue this patch for 7.0,
> > >> please let me know if it addresses your use case.
> > >>
> > >
> > > Hi Amir,
> > >
> > > I'm still testing it to make sure it works my case, I will return to =
you
> > > ASAP. Thanks for the help!
> > >
> >
> > So, your patch wasn't initially working in my setup here, and after som=
e
> > debugging it turns out that on ovl_verify_fh() *fh would have a NULL
> > UUID, but *ofh would have a valid UUID, so the compare would then fail.
> >
> > Adding this line at ovl_get_fh() fixed the issue for me and made the
> > patch work as I was expecting:
> >
> > +       if (!ovl_origin_uuid(ofs))
> > +               fh->fb.uuid =3D uuid_null;
> > +
> >          return fh;
> >
> > Please let me know if that makes sense to you.
>
> It does not make sense to me.
> I think you may be using the uuid=3Doff feature in the wrong way.
> What you did was to change the stored UUID, but this NOT the
> purpose of uuid=3Doff.
>
> The purpose of uuid=3Doff is NOT to allow mounting an overlayfs
> that was previously using a different lower UUID.
> The purpose is to mount overlayfs the from the FIRST time with
> uuid=3Doff so that ovl_verify_origin_fh() gets null uuid from the
> first call that sets the ORIGIN xattr.
>
> IOW, if user want to be able to change underlying later UUID
> user needs to declare from the first overlayfs mount that this
> is expected to happen, otherwise, overlayfs will assume that
> an unintentional wrong configuration was used.
>
> I updated the documentation to try to explain this better:
>
> Is my understanding of the problems you had correct?
> Is my solution understood and applicable to your use case?
>

Hi Andre,

Sorry to nag you, but if you'd like me to queue the suggested change to 7.0=
,
I would need your feedback soon.

FWIW, I think that this change of restrictions for uuid=3Dnull could be bac=
kported
to stable kernels, but I am not going to mark it for auto select, because
I'd rather see if anyone shouts with upstream kernel first when (if) we mak=
e
this change and manually backport later per demand.

Thanks,
Amir.

