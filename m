Return-Path: <linux-nfs+bounces-22093-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHV0EQocGmo+1ggAu9opvQ
	(envelope-from <linux-nfs+bounces-22093-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 01:06:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 967E46099B5
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 01:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 526D5300EAA3
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 23:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3939371CEA;
	Fri, 29 May 2026 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGeu2xcB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E80A3624D3
	for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780095897; cv=pass; b=Kn2tMt+kRVQuChXQ7H8fp/UCIRISsRnO+Cr2+g09p414k0adkw5reyhl24e8kPr+GMXJ+Q6Rjq4ru6UWYuyRRfwZyUh8P0km0ZnSapKbRjU4DEq4/ygOfk0OH5RPaLoHkpAxBjrOxN9SxIsHTYcPI4m7eR4rFu3BuNFxItzZp7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780095897; c=relaxed/simple;
	bh=mTqLklcpALMfF0gSjq/iHsfiz5uqTjr5ZXDoo81YwEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AA81GJSOyTWheRVjcBtK6kqhyuVaQa7ZZxge9hgaut2klQo7Q7oiHaL2sVWbvo8ETs9kMs+hPTTbex/z5O45QxWMwzyl3tQ/gWxYR3sPznKQc7PrrfU4Zy75TCeBOXRjTO+LaJUc3954rP5ZkEdlV1j2IJ+qfFUOT0TrHWWTL8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGeu2xcB; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68852a4fc68so12320606a12.3
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 16:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780095895; cv=none;
        d=google.com; s=arc-20240605;
        b=EEAtNvgLGOVrW+6f1s4hwwVw7vP5DWzm9Wyig+ieXLuMICuKWmVhEaJXo15CPOjEjm
         CIbwG/zIJqLqJbIR/SoC3/PD6HL0jpF5AkrOkXJpp+oWTGTWnxQsSBWWQT2pn7MFgkWD
         5vmXUN0A64N1PKr5qqcFdKuLTYZ5RpOiX1ynxa+eL4JqNUIzbSjDiSuBvVPkjbD81HvG
         uTaFs24GJ1j7zK4ssL1BuaHPIOYsoRT25j2UcHthMH7Gz176qXxDPuVKbHFvKtcCXqA5
         CSHFNbtPyHvAZ98awSmX9nih6Me2dADsEjUB492TBheluVVZ+HU8hlae/1T9IWwYXCk3
         3tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tFyJ3aQsRibN8gOLPvjv6Sxrf7IXBUlKsJ/Dk50nfK8=;
        fh=Hm+IbhMptZP7CtK3Bbg3X2mT7GHqq5Z7gsSe0zwTs/E=;
        b=GBIYD2gz19k03DyhgmC2VWzhyVg6JlkSYjEH6CqR/fPNg9YnIIgqtBtlb5fmE5Zpmg
         YNXE22tzI/3QCRkcvCIpNyTNLVmnbkoc02qGm3X+PxPNrEt/DYtS4rrEU6InE7DRS2a3
         IwZLE4mLuIa6Z2Qf/IqnkDVs/zn+7SYv8V9Uxs09qe1+pVYV/hs4faah+G6JOKyIktxO
         yiZ7lPyC/tJ3QXKO0Ex9dZKwO5XVSc0ZTZddanO6ZrY8iet7It2SUr0jFi38z/mmsUQX
         I/Kd+0pGsuRQ6Edx3fxR5KM9yWvovNPJ95YZW+tlIkfSy6hWxajwlzFmhgx1EDxDlJmh
         NOMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780095895; x=1780700695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFyJ3aQsRibN8gOLPvjv6Sxrf7IXBUlKsJ/Dk50nfK8=;
        b=iGeu2xcBIsjRSO87Jml3J1HefPxrpjLVzLEhFMnYDVGBX/0GQ7sdeIGO2FA3lah972
         dEVrHks8IjSzQ44Hb1dg7USilYT59yI91lSw3Z3g2SnviItCRKfjgza/bYmEfMv0a5eQ
         LE3qyo42Z8Dh06ywVB75NEjkTkdbaw28V1IaEp/ndjoZ3qxKMWQYyg8p1pmuQpTGue9l
         hg38Kth8n85vX0CuKEVAiTF2x1l/GakyRR/hnA0S9NS1j0HXdeiIcZU1+FL39RO03Yfw
         E9LR2LCgpWMGwOBriX8su18U3ZegHF3lwQR9ToVtUjjzwq4TcwyfBXk9bL5H1JL2uuJn
         RmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780095895; x=1780700695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tFyJ3aQsRibN8gOLPvjv6Sxrf7IXBUlKsJ/Dk50nfK8=;
        b=pSQ0YdY22zNY1UUjOyBSQ+YajC4fOIAaG39dUf/VWCpGg74XupMBb7nTXmnnYDi9E0
         2Yl7qi1ruwRg9TqbTLxR3kIF6pEJqK3WyGzZZQrmte9HJDXeJWYekxpBt7pE+p0rkf1B
         9/TCCrqO95ZSuqTUSptXljjKYmd7RCI4psv80RtMdISw4+/gdbZXUS5GJ545o9Vir8H2
         0/mgsnBucugAqkgxCffdJIsTmQs06QJypv0nE0XFVpJOg2ZWIVPNLTeEuXjv0D5sR1OE
         jfWDdKZXLUK33rXCHARQzoI4Ip5TRq9Vh/iaVp0KU6SHI9ahNV432kauyBDoVMF9DeRg
         VkRA==
X-Forwarded-Encrypted: i=1; AFNElJ+qOgZt+STvEtc/ArAVlGVxiVi4t5kU4hDbC5YnhVdf5MG2YP/HFW8tfhXixSKHnTzdDuXOwH3UK3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3YY/8+CsqkOg5YUUH+du2j03Wvntuy46T5xH7beCLF30VXUrn
	z/GCBS83DmdJnn/zHm0MvevAODp5Iyy1adHwojwSIfCfQuBhtf87iHi9cyMTRs7GmhGVn4BxLHq
	lhrz245qi2VV4CiqIoDK17Sm7eabodw==
X-Gm-Gg: Acq92OEy+VqfBzLoxWYJde4YneOuf1YMHj5cGlxJsYlzgldLFqD52hMHeOdYQjHgFBc
	7f6ft5Hf1uMtWbLbIhm6M6/s90pHiRRun8HiOqlNBIUOlH5KarHMQYhxWYiSdHSznZw8kcC5bAo
	aXrZ/9d8u51nxWeBq3DHVTCG3HxOCzPxpbRprMtKmsyvuPhrSsh13vs7oHqapziWqwGjTx2I6dn
	xl7qlXCxxHEVJUCmDQ+SR8DZYgdkeyOP5Iq58Zu1+6SkN4w1on4qzCfmAviqN01JcBwzQcDptEX
	s4KpfhsvMyOgYZPR3pB+XUwXC9/dZeIJZu/VP6OfM3jIsECHgw==
X-Received: by 2002:a17:907:770b:b0:bea:dfa2:cd82 with SMTP id
 a640c23a62f3a-beadfb21243mr33624066b.26.1780095894359; Fri, 29 May 2026
 16:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
 <20260528-nfsd-fixes-v1-9-e78708eff77d@kernel.org> <d1d41aef-0add-44d6-ac53-b78334b885a3@app.fastmail.com>
In-Reply-To: <d1d41aef-0add-44d6-ac53-b78334b885a3@app.fastmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 29 May 2026 16:04:42 -0700
X-Gm-Features: AVHnY4L0OMWHeeI5bKTl1ZSdw6AAZSstM9bpcR3hbJjAsRmizLI6tvWPtmJIOtw
Message-ID: <CAM5tNy7jHYEjaJk5t5sjr+2BZfiiVGgNqcQf1J1+1ad6WhUP0Q@mail.gmail.com>
Subject: Re: [PATCH 09/10] nfsd: cap decoded POSIX ACL count to bound sort cost
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, Scott Mayhew <smayhew@redhat.com>, 
	Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>, Rick Macklem <rmacklem@uoguelph.ca>, 
	Trond Myklebust <trondmy@kernel.org>, Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22093-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rickmacklem@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 967E46099B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 11:34=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote=
:
>
> [ replaced broken email address for Trond ]
>
> On Thu, May 28, 2026, at 5:55 PM, Jeff Layton wrote:
>
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index c6c50c376b23..5469c6c207ba 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -448,6 +448,8 @@ nfsd4_decode_posixacl(struct nfsd4_compoundargs
> > *argp, struct posix_acl **acl)
> >
> >       if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
> >               return nfserr_bad_xdr;
> > +     if (count > NFS_ACL_MAX_ENTRIES)
> > +             return nfserr_resource;
>
> nfserr_resource is consistent with other fattr4 decoders, but
> does not make sense here, IMO. A better choice is nfserr_inval.
>
> Rick, any opinion?
My understanding is the NFS4ERR_RESOURCE is a NFSv4.0 only
error.

Looking at Table 12 in RFC8881, NFS4ERR_INVAL seems the
best fit for SETATTR, although I didn't specify that in my draft.
(It's a bit unfortunate
that there is no other error values, since NFS4ERR_INVAL gets
used for everything else, but??)

Maybe I should add that to the draft?

rick


>
>
> >       *acl =3D posix_acl_alloc(count, GFP_KERNEL);
> >       if (*acl =3D=3D NULL)
> >
> > --
> > 2.54.0
>
> --
> Chuck Lever
>

