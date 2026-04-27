Return-Path: <linux-nfs+bounces-21164-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPneLwgo72lE8AAAu9opvQ
	(envelope-from <linux-nfs+bounces-21164-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 11:10:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C1A46F994
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 11:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9752C303131F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6793AF642;
	Mon, 27 Apr 2026 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeVsCtH9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C233AEF4C
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280717; cv=pass; b=bu7GG5zuL12TzYl9Uw3lS0kfvUPqANp1UvrhY/uCx6CPduyvSp6LQv6Ri+EeU7D74PVpts9Vy0sRprkUqSRAtVStbvCHCC/X8f4QDS5RaUuNfDgZwotzRayChd6+FBQVf2LWjFTgNSbX8JzWAZiF8YqSwUNyEkf/UwBU+4KwXzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280717; c=relaxed/simple;
	bh=a5WlGur2x+nU1ZXEt1S7Pr3BhzTo07kXxugDtAVEEhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCghcW+JZkorkpoo5elOxmpwwZ0gd6oNpwWdDF1adA+s+phTbmoNRPKmlFGgo+IHtPBXr0VhcEQT5URsWA9m3pw9+RC7MqU2KNazS+FUupTti8S6Vsrfcq9AQH6I04lZBjVEwbq0MAQPdj+07jUMtY6+gaXs+pFRHIWlUesyQwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeVsCtH9; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ba67b332bbaso1147643966b.0
        for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 02:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777280714; cv=none;
        d=google.com; s=arc-20240605;
        b=GZO5q/nDPA4N2+DdOnP2AVC3GpL+ysLAyykdjFCgSNOhZWnSXtlZbgC25zGt7DZSRW
         FtKJbnJuMwXj/FKswwhh9KL2EEOGZ+4IKzI6CWlpsn2dy2gdkKy7JQZeb0TOcSuUa57j
         kHumgLncutq1kzqVuy62LEcTDZZ4Cqmcuc34y0FDkYso5lw7V+doTQHouWUtb6XaaPfS
         1ZruoztS9PE5XJ0BsoyToUdNi74AypNytBllD9Y3isrDwBR2mMp6aT8eUBhC4P2zeFeS
         UMkSZeRqNCKMgYiTp9scZNtDwsvUyWXVcOK37/Av03ZZCh9rmBSkaYI/sUeCJ6+8dlvL
         2ifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BGupVN5az5s8pFT8H0NZ4pHuG9HKT10qjTmw5QNkxIM=;
        fh=jf714rbLE9aAs2mMuWNJ5Pp1+p9363iGmV7ksd6tu9I=;
        b=TaJbwaUqETNzApNP8vzGlp7vG6EVHfiVfp3GgwCOlT3mF6j0UjgZvcRzFhM1DSF0X2
         5K04c+jXjtaDLyruUlQvFYxCP3zapQY4O47gqav/jO3lS+AKepnkbLWg6TarOxelOfs5
         2lBR4lTNeuSNvMpFgieqRVqK5y1ENr7s2K4NJaiKflhZppfvICfmK2iq943XmwK6vpZc
         wj5ltaaTu3+gOATa34a75HnfujCbachWTK5ll+D0nCA8liIleUkm6n4KbCIylTBvXYgj
         GnyveUHap4duJI2zFRBkJo8n0vDXLjYshfNz7fiQY8ApwihDJBe4a0L58BEKdcsanbGA
         6xnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777280714; x=1777885514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGupVN5az5s8pFT8H0NZ4pHuG9HKT10qjTmw5QNkxIM=;
        b=FeVsCtH9PneHPhOEcOJCpacTtqhXnJHPtiJ4+PawigBG+gw6FpulourYIBqe7RbI2E
         QaBFIqQPJ+GtuyXwafgn8USJGEwOpU5XkKvFghsDHa5FV1PlkvFMesDHwbR4rGJzjVKM
         UVb/q2WRcAyFA4NShDXS9Qbcsgm4b8L90wheIVFcTIIt7quepxV5GvYIJUTgXM5s7lAf
         qkKxHJ9RU8YsMvPbFyDpfb6y6x9x6cIcgZ7KSB89hDAbe0ZYluKs/GrQEki46kHwhhNo
         +/oqHS2wFahQO5WlgIaBujyRMgbEaxxanXNdLDWiPfDqVJewL5TxJgE4hdtw5t8ulwQ2
         M04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777280714; x=1777885514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BGupVN5az5s8pFT8H0NZ4pHuG9HKT10qjTmw5QNkxIM=;
        b=XcjPTNBGK5tMRaVadD7END2x27SN7nwUiD00pFC/qVaCvaJSIRexXmnG5jaIpgXCaQ
         Sv09zc+vWevHA5KC3/aY4RyyboKW2y1jsP3a/rCwwB63OY7GiZW3nLlsdwT7R5kA7R6/
         n8cA4E42eWMKaI//2cXnGsgCDlj+q5A666GU/gaxxEcf7dVQ1glHz2xlQYdW+24oODO3
         QeUqGv1lCzpdJhHb4nzmmixzH8ll/Ddf5PrFhlkiHgmnpHcWSnEKlO+NOA2eiT+GqRiO
         4jDvTSJ5ThiPYHAmJ8wdPvSgGJL2IZttnWO43feHurjAQcSckxuNmDOtC4iKaspCUhFi
         ds5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/4s2/Ybpe9c8MX0Nd5K5Z2JmxdWSvwZ1+BqGdl88IA1pYBHDYKd71dP+rEM9oJk/VBtJczzJ1gLR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiIXrGyxYB0CtLU4etvcu/eVMu1Le2GCS59PDcSJg91/tChcTl
	cUro0l5wrnsQSkPOlyB+4NdUuKdMjApmHFoH8SBO9b7G5qVFlP5Y3P0yfPqlRMK6JyvJ1f4t7zT
	jXeqx03ESo2jCxyh2gX+aRtwiIWtQ8Ew=
X-Gm-Gg: AeBDies2HkXzMro3SQj50Dv8N3uLrTplNLP/bG/IGYW7j7iHV2vmY/fluP1YyBUID6b
	xyUZQfqQqAu7JEYxa2pAAWKtcImtlURqEqWOpXgFbozKc8xx3/fXWQJ/KVbtxboMKMWjwrixQ7Z
	HtezRDp7IkdvMcLteFgOa40wRTJrtGJ7sBT5lsnZqWIhSpkkACFR+MHaLt4VbwRcr9MufDMOGgB
	YK3a/d6r8+qniS51aApU6EzsqEYJBsR09pr4KYt0cr3W390i+ovh07BnEryl/FWiAN8HgYetxA7
	JUxBU1PMHmZXDpmE842j/6zTlItDPCpUO2A1R/1NXhLGabSIAvJEO3520ONAAmc=
X-Received: by 2002:a17:907:97cc:b0:bac:75ae:ef3d with SMTP id
 a640c23a62f3a-bac75aefeedmr894007366b.0.1777280713694; Mon, 27 Apr 2026
 02:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427040517.828226-1-neilb@ownmail.net> <20260427040517.828226-8-neilb@ownmail.net>
 <CAOQ4uxi8rqkbhK4=8N1ncfU1m6bjdHLbinSf=j3k0oVEaSa-wA@mail.gmail.com> <177727962988.1474915.2841674553452335690@noble.neil.brown.name>
In-Reply-To: <177727962988.1474915.2841674553452335690@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 27 Apr 2026 11:05:02 +0200
X-Gm-Features: AVHnY4KY3DGiJbeLpxnNIOueb0cG8ugd69Mb3NfCiVfs_OCISzp2jPWuCU1oOMA
Message-ID: <CAOQ4uxiMUKHuGwpSkD=M4Z_QLxHn7Os9vaaWqAWd36HdfDRYuQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/19] VFS: Add LOOKUP_SHARED flag.
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 60C1A46F994
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21164-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]

On Mon, Apr 27, 2026 at 10:47=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrot=
e:
>
> On Mon, 27 Apr 2026, Amir Goldstein wrote:
> > On Mon, Apr 27, 2026 at 6:06=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > Some ->lookup handlers will need to drop and retake the parent lock, =
so
> > > they can safely use d_alloc_parallel().
> > >
> > > ->lookup can be called with the parent lock either exclusive or share=
d.
> > >
> > > A new flag, LOOKUP_SHARED, tells ->lookup how the parent is locked.
> > >
> > > This is rather ugly, but will be gone soon after we move
> > > d_alloc_parallel() out of the directory lock as ->lookup() will *alwa=
ys*
> > > called with a shared lock on the parent.
> >
> > Neil,
> >
> > Forgive me for being skeptical about the *always* part.
>
> Scepticism should always be encouraged.
>
> >
> > How long ago did we add ->iterate_shared()?
> >
> > It's true that Linus eventually got rid of ->iterate(), but we did not
> > get rid of the assumption that iterate_shared() might be upgraded
> > to exclusive lock.
> >
> > The obvious reason is that *someone* needs to do this work for
> > old filesystems, which are also hard to test and nobody wants to
> > touch them.
> >
> > I have nothing against this patch, but I think it is more realistic
> > to state that LOOKUP_SHARED is here to stay, so if you think it
> > is too ugly, maybe there is something to be done about it.
> > Personally, I do not see the ugliness though.
> >
> > Am I misjudging the situation of shared lookup wrt old filesystems?
>
> Yes.
> All filesystems must support ->lookup with a shared lock because it is
> already the case that with a simple lookup only a shared lock is provided=
.
> A filesystem *could* examine the lookup_flags and deduce if the lock is
> actually exclusive (e.g.  if LOOKUP_CREATE is set) and misbehave
> accordingly, but a vanishing small number of filesystems  (NFS and ....
> I can't think of any others) ever look at the lookup_flags and I'm
> certain none do anything so ... creative.
>
> So I'm certain that it is safe from the filesystem's perspective to alway=
s
> call with only a shared lock.  All that is needed is to change the VFS
> to only ever do that.  That means separating the lock for lookup from
> the lock for create/remove/move in directory ops, and one way to view
> the current patch set (the complete one, not just this initial set) is
> that it does exactly that.
>

I see.
I will remain skeptical, because there is always *something* with some
special filesystems - think fuse servers (not under your control) which
have grown to rely on the kernel to serialize atomic_open() on the director=
y -
but the level of skepticism is lower now ;)

I mean it would suck pretty badly if locking order would be fs_type dependa=
pt,
but honestly, I do not think we will be able to avoid that, so we need to
make sure that humans and lockdep are able to understand the different
scopes of vfs locking at least per filesystem type.

Thanks,
Amir.

