Return-Path: <linux-nfs+bounces-19474-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHIZMAVVpGmKeAUAu9opvQ
	(envelope-from <linux-nfs+bounces-19474-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 16:02:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 157B51D0517
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 16:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98C3B30125D3
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2026 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CC02D0C7E;
	Sun,  1 Mar 2026 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMBPcvuu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5331B13B
	for <linux-nfs@vger.kernel.org>; Sun,  1 Mar 2026 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772377332; cv=pass; b=abPUrUZVWu+GOQiOs0ofTouJb2Do1VwTU8Pvm69UjJUPOBTQlYPsl4YeEaB75ywIrYZQN/UYUGhyN1fXwUl1pvuqhin2koxEWGoXDsvAWaGoz1YWAiXOJZZxnLLsSetDS1Cl75RNuvuywf3A7EoRtZ4prGV/8a70mKo206ypzCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772377332; c=relaxed/simple;
	bh=V37CR9us1N0esOdbbifQtaXVD0Ciudjbj+QVzwLv+pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5qEEENBmtdvjCYvRKwpgrWN6bqc4f4j46u2E2PEedNGjPOUrJN3NU1N1CASrALb1IIwl7I/Ev+VHjwYXd4ir5jILWkiPRpYcmC9ZWBxSWaYC9RC68YBsvbcEqHGUQGe10gM3L3YA2fgUrknVawt95pDJJZJzSh2Eknv1yKrqRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMBPcvuu; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5ff1703cb94so2338594137.3
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2026 07:02:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772377330; cv=none;
        d=google.com; s=arc-20240605;
        b=YV0fpPx63G7PAXrSGHeXwnt/XMZDZ+8iY7DplMg9DGweKu81/uJbxYqqVrd+vpx3tb
         WbWnBM/6pbjVIuyKAYwPzPjioVSwi9+lG+3A1JAucPJogiqxP+jeLuVCak+a6NWtdICA
         l7oJLrHwX8wP5mdS129VOnzG2O3eNPzQipBUrfDTRs0d1Yf75+nXMvVKcZ6GfnKkI033
         LUcvUiYlDe5VCkIzASqjs/sk+hJlqw1c5HsGuAuyLGqnhQuiNJxgUNTv7blOOEdqfvCI
         nD0MtOsu6UT0C5+k8K/U08xD7U+6KobV/ap/ggpVIXOHJbJ6571YvewQryqHteNjZJxt
         pRZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2DEbj6UlaLHWTSmc9tFmxEh3Nd0lpNrPuON3F9X96hM=;
        fh=yV9nF59dOpf6OMqlGuNqcKFqc5I6TTGyQNr2mgEyS4U=;
        b=hnkp9t+xMylGOfOFtJfoolTWLMBd85s6S0icyLk+eQwzvIuk0LrRYqvclIgCMrCn16
         cUMHmcQyZFaFHes9kF39e+iSPAOZHApJ6EXkb7OBDRHA9C9TH3B0xxapySbMXSORnldp
         SRc9X/HwcvrRTWORwgj/3ahF4ee0e8P5TV0r0oZnbCx8F9zb/hJpi9M1lyLtlUVevjAZ
         cgHyykniXToIjYYAk7UWKZunF2Jvl1ELhW6eJf2vq1i0kRFba9WFgb9cIP71AghiNvVQ
         vRT+FFg1vrulLKn09Qu4G12ObWrAOL5XJ14EdDLQQdV3DjyDHgjnwk2/hMGNJYDc5wht
         N8CQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772377330; x=1772982130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DEbj6UlaLHWTSmc9tFmxEh3Nd0lpNrPuON3F9X96hM=;
        b=mMBPcvuuF06lWTN+/TyD56IA4ZxnV47aeOImyEfUxIhwJ8ARyQhMXNydHupIySiwKo
         3B4GrMVPoNudjz+R81qvW4zSrF+Kw/fQXKoE7x4eI2QD8v78T0YAjvQyyOqBukk3G9m/
         5hsmJm4bWhUFIuBmfeCtGcxJr/dNshVdKduoNXeFOQGX+Riq6k7FhXmdMiBAuPnU0LbV
         TU5gBV+m17qa2RRhmXg3iI4QOAYwHd+GG5MUuYQVxFwJkAWUAmy+yJa3WnouUGwW7wyj
         Nl+T+4tLUifJ6fmu976xdHtvP4nQhkkjPAwckmLn6Z4J+C+JWryxLiZ49no7EqpMmu/+
         LTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772377330; x=1772982130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2DEbj6UlaLHWTSmc9tFmxEh3Nd0lpNrPuON3F9X96hM=;
        b=RAh8hejPvJKrriUu/Y4LBT6fbv93FtU9EYRji5/FU9drlRsuMNKCooovfGUS/oAOQC
         e0BZkSoMMV34U7ApyBt4oEHHOJYK0xNOlikPp06WrJRPK61EtJxTB3iiH9JQaGb1yyV9
         FxXTivjef/mTt0QSLVirx4m7T8x7wPAfuWaYcxa31iAiVxnXlL3flLkAPUnq7BTl1leG
         fA3EhJEA6AtVysubTJV0y/xsHgaAjXVPur3GpcF0iFM0zK7roKUOnq90EqJY6eJ30SVf
         II3KaYumDF/bPLpDOsiR8faL7xvm8f3jJqdJeGo/NHaEQsoj50GkXrKs8YK6CSi9FDJt
         nhhg==
X-Forwarded-Encrypted: i=1; AJvYcCVZGxPqG+sT1G/Y2h0bo2H3D5G7pbWVORmSp52CGu4aYDdTewBPcCgQhTXDjjps/+Fk8z2NaG0S+Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrmX/1dRSxyqs3MNj+Q9r9rTuh3qXW2sYSTjFN0zgmoprXCSw+
	mZWlSv+wn5trj3oEYyctlzAURL7VgkWrQE+VBmlomC/WodFrA/9oRQNFyx7SJ5lxw0Xp3fT1Q7x
	p+QsVzTUjY69ay3jjpAxKjUfEGuvQ9n8=
X-Gm-Gg: ATEYQzwwCSDGWMcYpNKS9wLBiJN8poOKo8+ULbC2omRfpTo33F9kcjlEYWENz9eHbL8
	v5jS1J6nQaSMctRzsPrAseqtoUV+3vFP1B7sMWdNK6zYiw+WmBwZwTiEfYEDlxRytccWQgh6MY8
	Bea5aKFKc4UAkJXQu3MobIW668tugKa4UObv6bJhO9+wOjX+0BBbZmze8zNAno+ko7gogzl5xFO
	uv8Ey0J3z8rY67TDKeYLYgBAd135fqQQ0W1nKAmw6ojRCcbTTqW2HZcQpGkSC5QxglZK4rxn4yN
	LS6mTrCJqhiSiEf/w7VVl9byOH8G74zvkIWjgHw00A==
X-Received: by 2002:a05:6102:cc6:b0:5ff:1445:88ff with SMTP id
 ada2fe7eead31-5ff322714abmr4377922137.7.1772377329579; Sun, 01 Mar 2026
 07:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
 <20260221145915.81749-2-dorjoychy111@gmail.com> <2f430eb613d4f6f6564f83d06f802ff47adea230.camel@kernel.org>
 <CAFfO_h7i86qdKZObdFpWd8Mh+8VXVMFYoGgYBgzomzhGJJFnEQ@mail.gmail.com> <ed5aeaa81ad9b87926fa7ebee0308aeb8df9f0ac.camel@kernel.org>
In-Reply-To: <ed5aeaa81ad9b87926fa7ebee0308aeb8df9f0ac.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 21:01:58 +0600
X-Gm-Features: AaiRm50b25Ilp0U_HqmXYGEDuiLaRPqAldbyxEp-tlfkTSKlimm7-yBVSXDXKJs
Message-ID: <CAFfO_h5za6gV99TQS3pwHnf7zyCeVySn3CdRyV+_jFqjovGBqA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19474-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 157B51D0517
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 8:47=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sun, 2026-03-01 at 20:16 +0600, Dorjoy Chowdhury wrote:
> > On Sun, Mar 1, 2026 at 6:44=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > On Sat, 2026-02-21 at 20:45 +0600, Dorjoy Chowdhury wrote:
> > > > This flag indicates the path should be opened if it's a regular fil=
e.
> > > > This is useful to write secure programs that want to avoid being
> > > > tricked into opening device nodes with special semantics while thin=
king
> > > > they operate on regular files. This is a requested feature from the
> > > > uapi-group[1].
> > > >
> > > > A corresponding error code EFTYPE has been introduced. For example,=
 if
> > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the fla=
g
> > > > param, it will return -EFTYPE.
> > > >
> > > > When used in combination with O_CREAT, either the regular file is
> > > > created, or if the path already exists, it is opened if it's a regu=
lar
> > > > file. Otherwise, -EFTYPE is returned.
> > > >
> > >
> > > It would be good to mention that EFTYPE has precedent in BSD/Darwin.
> > > When an error code is already supported in another UNIX-y OS, then it
> > > bolsters the case for adding it here.
> > >
> >
> > Good suggestion. Yes, I can include this information in the commit
> > message during the next posting.
> >
> > > Your cover letter mentions that you only tested this on btrfs. At the
> > > very least, you should test NFS and SMB. It should be fairly easy to
> > > set up mounts over loopback for those cases.
> > >
> >
> > I used virtme-ng (which I think reuses the host's filesystem) to run
> > the compiled bzImage and ran the openat2 kselftests there to verify
> > it's working. Is there a similar way I can test NFS/SMB by adding
> > kselftests? Or would I need to setup NFS/SMB inside a full VM distro
> > with a modified kernel to test this? I would appreciate any suggestion
> > on this.
> >
>
> I imagine virtme would need some configuration to set up for nfs or
> cifs, but maybe it's possible. I mostly use kdevops for this sort of
> testing.
>

Got it. I will try to figure this out and do some testing for NFS/SMB. Than=
ks.

> > > There are some places where it doesn't seem like -EFTYPE will be
> > > returned. It looks like it can send back -EISDIR and -ENOTDIR in some
> > > cases as well. With a new API like this, I think we ought to strive f=
or
> > > consistency.
> > >
> >
> > Good point. There was a comment in a previous posting of this patch
> > series "The most useful behavior would indicate what was found (e.g.,
> > a pipe)."
> > (ref: https://lore.kernel.org/linux-fsdevel/vhq3osjqs3nn764wrp2lxp66b4d=
xpb3n5x3dijhe2yr53qfgy3@tfswbjskc3y6/
> > )
> > So I thought maybe it would be useful to return -EISDIR where it was
> > already doing that. But it is a good point about consistency that we
> > won't be doing this for other different types so I guess it's better
> > to return -EFTYPE for all the cases anyway as you mention. Any
> > thoughts?
> >
>
> There is a case to be made for either. The big question is whether you
> can consistently return the same error codes in the same situations.
>
> For instance, you can return -EISDIR on NFS when the target is a
> directory, but can you do the same on btrfs or ceph? If not, then we
> have a situation where we have to deal with the possibility of two
> different error codes.
>
> In general, I think returning EFTYPE for everything is simplest and
> therefore best. Sure, EISDIR tells you a bit more about the target, but
> that info is probably not that helpful if you were expecting it to be a
> regular file.
>

Good point. I agree. I will fix this and return -EFTYPE for everything
in the next posting.

> >
> > > Should this API return -EFTYPE for all cases where it's not S_IFREG? =
If
> > > not, then what other errors are allowed? Bear in mind that you'll nee=
d
> > > to document this in the manpages too.
> > >
> >
> > Are the manpages in the kernel git repository or in a separate
> > repository? Do I make separate patch series for that? Sorry I don't
> > know about this in detail.
> >
>
> Separate repo and mailing list: https://www.kernel.org/doc/man-pages/
>
> ...come to think of it, you should also cc the linux-api mailing list
> when you send the next version:
>
>     https://www.kernel.org/doc/man-pages/linux-api-ml.html
>
> This one is fairly straightforward, but once a new API is in a released
> kernel, it's hard to change things, so we'll want to make sure we get
> this right.
>

I did not know about this. I will cc linux-api mailing list from the
next posting.

> I should also ask you about testcases here. You should add some tests
> to fstests for O_REGULAR if you haven't already:
>
>     https://www.kernel.org/doc/man-pages/linux-api-ml.html
>

I only added a kselftest for the new flag in
tools/testing/selftests/openat2/openat2_test.c in my second commit in
this patch series. Where are the fstests that I should add tests? I
think you added the wrong URL above, probably a typo.

Regards,
Dorjoy

