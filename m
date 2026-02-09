Return-Path: <linux-nfs+bounces-18813-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPefGePaiWlFCgAAu9opvQ
	(envelope-from <linux-nfs+bounces-18813-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Feb 2026 14:02:27 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAB110F549
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Feb 2026 14:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0193F3013D5D
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Feb 2026 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D8D2EE607;
	Mon,  9 Feb 2026 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADqao1DO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6326E71F
	for <linux-nfs@vger.kernel.org>; Mon,  9 Feb 2026 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642020; cv=pass; b=aXtvHvloYNC+xKqnDSwcxtgJ2Z/pPEyZf6qa2MkUPjCDFpF0CO2jX6X2+I8LD1Y7qyNel2DkphFIaj5IGHKOQhaNEgVaD+Td2Vw9/aGhaQL9flf7YhwJO/HueSgYs/YrbDLQrMQEqxDiQKEflIWMevVEnnvaqFHrDs8TaxgjGo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642020; c=relaxed/simple;
	bh=sQZ61J8kyTcO7Pvl9RxElT6zq26ZZeTJV1I2FVx8Ols=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNIvTfkmFDip+Rh/y3tCKdG92Di126QH6L5RiT3h+HKNCAxA2rCTaiCMwaJwH73pr9P6NRpicEAOUnWzK/GrneQVgPnxw9KWHnznaVOozL3QdlPmp/O9R8gswapvFu93WFiISKNiagW6Y9+0XZH9MqBBo/psoO9IH9+ssWTgbII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADqao1DO; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-658ad86082dso4125150a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Feb 2026 05:00:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770642018; cv=none;
        d=google.com; s=arc-20240605;
        b=e9TMDqgvNdO7rN6RDoEdMkYFRgJT0pC1kv5NNMN1zCA2HLJhnyCXjdZ1bBaBfZ4ng2
         SZSMVsZBTzK5wCZPYI4MV/hRwANHdhjPTUpXkkOYICkdfK/40E77QdWXJttCj8IC1Iwt
         N01tdTvHwp8unByQFJCqfOAikNpS+9cKBQS/GTnQ0Jdv8NugeXC5SH9kUeAuuNwimrdl
         ogljCuNdAFyNv8P/p+yIx4wwz74/qQJiVKCinw1iBd4zWhaIfyIYMg03DO4Q/BAA0Ung
         BLQzeXWurOldH05itCM+qW6+jUSxgpltT60NE5nA3JP0PxeTax0g+l3znwqqr7a9akvG
         blcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hMoZ6wY07SqYnHy0ueNWtNj0fVRmA7qbraA0+zshIW8=;
        fh=N80Sr28heA+VtVaTMbW03dC1z2M4ICPxX+cqoX6ghm8=;
        b=LCzpgu3S2gSUdlA/8Zz7BB4KzIqS+d+hXlq2R+OaEGG0DbKTN941d+rr40W7zD9GjZ
         apFcsdQJNZqNDn9D1m/pLWsopKELlCQ2i6fF/gzVHnR2mIuRHrdO4ANsmjc+6UiMbvxK
         Z82coki3D4I0/YFSJP+2A1mXY4xeMV06aXrmGLTA9fnWIdItzZw9kTX4hBeEBBkE40Eh
         jTwOB8RpA4ZdlsiR31zDDgPoTtU2xw7v7+Lf+edr0Jn/nLIeEK/3cNrnQHrZq/tvqEYg
         r7mnWBEjz6osndTHeUNe03DFIBawFIkDu+AdKEeMvcyTTAoal/ORmbvKAj5OpChGDTYE
         X1cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770642018; x=1771246818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMoZ6wY07SqYnHy0ueNWtNj0fVRmA7qbraA0+zshIW8=;
        b=ADqao1DOwUHVqhDUeGqnQRxUGH/JfXhGISCrOFgh2ZuYA+U3HHAMbBoxrk+BnEZtSK
         JNZGvlnTBUF+zI1uR/RiX05E7ZzqfmH1s4jMDcQSFEhG1qXoyI1lvy9MspM8O73SNAcT
         yLP2O6qOta16tA6aEqaMlPrSEDSf29iEsfhaNbPbYK8IdUisDcemZMhEVd8PXLPeN9tx
         ZHdIcQ+Rmliem/0BbHdmrDsm3OEegLFpVWv7vOdddf3pz6vh7xCQRBNC9Yn4yQMtU8/g
         svlsxUZUKwXRzXKy5BFRGQRVbsDNI5Z0K89v1MpQGDlrqLUqzNCxwjtlOYaQV8H3HEWL
         jD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770642018; x=1771246818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hMoZ6wY07SqYnHy0ueNWtNj0fVRmA7qbraA0+zshIW8=;
        b=Eqmkxa1I8EsNdIk1n2+NkHsRk2S4jnIBLP967nNaJfmHZWAgR/3EofGFrG7Npn729C
         JcjnxUvbGtWKTpjol6Ibn9tnHtBPC2Fx4WckJdMoKVgQa4yoqN+7PLlwz4akWdgNxfRt
         HYN5+OzO3PTsX5jypvItAOT0MmBwB9+DEvL9nfpiEhibxJr2y/s+MbXos6c73/Ek+G1P
         ji+luT7vQ30yl0132DRtwlsxGX1JacTsoy2hL5task7QXveIu33eNl4YgDD5HyFpq9pS
         vxvbBGU0rfLSTyvnzDN86lvd3UktGDiAcmPqoo/Iro3bIB2ynvTPN9DzW1I++WnmNlW5
         PznQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVrzFmeTLaY/csZOvaKX5cDCJbGI5/4iQKRWt4BkUSert0yyHaAi7pbQvh5TQxcv6OfX43EqTLT0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjkviLksiixVaOVL3pTyfjSl75gW8Y5vgYVD3IPOlim2l4kB0y
	bZvH7Nl3S3Fk9p/qxBF+Llcq0sNf+/BhtiFwPSSPtXc8biUJ9ulu0bYgeP3skEbrZLin/ZNB7Tw
	PENE0BgQBYs9tcBWxspPzjotdyRzIZSY=
X-Gm-Gg: AZuq6aJcy0trRmTquchwQgbTF4eG50e1vJwTe5cLnwI74E47krkeOk1r4IGE+Up+dvr
	K8raGjtz4wonHsWMP8l4/n4caWEB2MSa3WRlL1eTmUC+CSfQcDdi8k7iTpZl04ExGVY+oTO/IqE
	w77+3pYPdxqmK8/DGq+EkOMuoEClsFcLzc8B07rTfaymAXamfSOdqBlRJDmhw+067nkU08Jvsi2
	CpziDRNrUIuw7Z6aV861LQJ2CEqWy4MZ/9vbaisX2MgQKSg9VkMkBcIum0sFI5JlW9ZD/6WSJA0
	tonpe+ErYsQARN2/L15YddmFIW0s
X-Received: by 2002:a05:6402:1ed5:b0:64b:73d5:e2b4 with SMTP id
 4fb4d7f45d1cf-6598413b2b8mr5679265a12.5.1770642017891; Mon, 09 Feb 2026
 05:00:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegu0PrfCemFdimcvDfw6BZ2R5=kaZ=Zrt6U5T37W=mfEAw@mail.gmail.com>
 <z24xrtha2ha4ppxomzcqzdkevgtpoiazwb2aehfocyfqwnhkoe@clrijunqda67>
 <CAJfpegvjEzu_mgDaKgNQcnpES8vNu0d+UniS65UFQMsKcaH55w@mail.gmail.com> <jejqzlpcrvn256yfultni2twn5nzehvbelw7ukairf5ntdqcs2@j44pqhuze6rq>
In-Reply-To: <jejqzlpcrvn256yfultni2twn5nzehvbelw7ukairf5ntdqcs2@j44pqhuze6rq>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 9 Feb 2026 14:00:06 +0100
X-Gm-Features: AZwV_QibEBUpjI2OQfkEnrsDVHQyVca9YGwv7pmjuQ4qELt1P1AGMN6OPVMLFKA
Message-ID: <CAOQ4uxgGKKN59P5w4-yLrDX-abWT4qjt7yP9=oUp8op7nJ6wPg@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] xattr caching
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, lsf-pc <lsf-pc@lists.linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, Linux NFS list <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18813-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5DAB110F549
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 1:40=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 09-02-26 13:26:54, Miklos Szeredi wrote:
> > On Mon, 9 Feb 2026 at 12:28, Jan Kara <jack@suse.cz> wrote:
> >
> > > As you write below, accessing xattrs is relatively rare.
> >
> > I was referring to large xattrs.   Small (<1k) sized xattrs are quite
> > common I think.
> >
> > > Also frequently
> > > accessed information stored in xattrs (such as ACLs) are generally ca=
ched
> > > in the layer handling them.
> >
> > Yes, that's true of most system.* xattrs.  But user (and trusted)
> > xattrs are generally not cached.
>
> Right.
>
> > > Finally, e.g. ext4 ends up caching xattrs in
> > > the buffer cache / page cache as any other metadata. So I guess the
> > > practical gains from such layer won't be generally big?
> >
> > For network fs and userspace fs caching would be a clear win.,
> >
> > For local fs I guess it depends on a number of factors.  I'll do an
> > xattr benchmark.
>
> I agree and frankly I have no doubts you can speed up xattr fetching with
> targetted caching layer even for local fs. Just I don't see a realistic
> workload where the gain would matter... But maybe I just lack imagination
> :).
>

We have production workloads of Samba server which gets user.DOSATTRIB
for every file during readdir (for the Archive/Hidden bits and Creation tim=
e).
The numbers are quite bad.
ksmbd has the same workload of course.

On XFS there is buffer cache that helps xattr read, but it's quite costly
to keep a 4K page just for a 32 bytes xattr blob, so with a large number of
files on a file server, those caches are often not kept for too long.

If there would be a generic xattr cache layer, it would have been very usef=
ul
for this workload.

But IMO the knowledge of which xattr are cost effective to cache is applica=
tion
knowledge, so I think that caching a user or trusted xattr on local fs woul=
d
require some sort of application opt-in, e.g.:
getxattrat(...,AT_GETXATTR_CACHE..) and a vfs flag for ksmbd.

Thanks,
Amir.

