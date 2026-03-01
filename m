Return-Path: <linux-nfs+bounces-19476-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM6iOShYpGn8eQUAu9opvQ
	(envelope-from <linux-nfs+bounces-19476-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 16:15:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F01A1D05DB
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 16:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3E0B3012C44
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2026 15:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99778317173;
	Sun,  1 Mar 2026 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6Tb4UsC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062FD221723
	for <linux-nfs@vger.kernel.org>; Sun,  1 Mar 2026 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772378146; cv=pass; b=dHAYKrcXY4coRMGL+ykfbdE5Jug1VeVDParfUQlN0zW/34YWvtJ3Qv0o1LtlLAgF/G8TTfcI3P0ERY17xVj7HzKRkOvX55GxFRxB9d34ZXrAYyt/s6XXk80+bxGHx/DVc6F7wme3F6Ls6OASqJP0KSq7of7jDnkPbQnGLmgfKxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772378146; c=relaxed/simple;
	bh=dK8JGyYdEozW0hh/3EWXgMcj1Vr2HLjTATqqOgadHrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZtFR0Ly+JdDQ6gLLezS92gC/Cpc+0Rgr2VqShZhO9yqGp92p+yhSx7730SLg8efbvkjBgOmqt1EQg7YhoQkMQdOPEr+2fyyyUHNMu7UO1CcwNvE2caQd090LKAifPrajTEwwc94hEJlLm5EbghBOb0E33QOg3/+upOrJ6P6XJ5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6Tb4UsC; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5688c221fd3so1566229e0c.2
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2026 07:15:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772378144; cv=none;
        d=google.com; s=arc-20240605;
        b=btoDxJaWWo7B68XuDo0ZABwBtjzAHSk+X0SWbaJ2LncAOjH89VgSTcw6hD77VcW7q5
         cKPvniMuB7uI6Jl0pXkI+M2h4pQa69A1k3mNF5vFSOTAasbvjReW87rGgZCiJGgi9DLH
         6J7KZPQ0QTgBbGmTrJaXyrhLzALP9i3zrv6Yzxqlb6Gj6/M8C3Yi5LDtKvlS751je38y
         AzWbw6bJz17fuQPbrAxZff6LmrmebdHEUGqhfU0ncjbkxEnG3nvdYSqq1jWwdhAci8IU
         AyeYgKv1gljhts0u2dIKdq3mhHFfF6+s2S+VHEnjQtrv5fNYnOc+oKtOANLUgiuN1HdQ
         ReWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c1nkyX5w5KMhDfO8wL4au5byg+U9cvBh7Yz6qo0nwRk=;
        fh=l+6j/SSHszt6D1kYWhpAWotu19HVgLTKR49X4Z7aUpg=;
        b=M2Obrb+CMEzrk3FEe/NHUF6/8hr1uDe3xW/JSUSXw4x+85wVWEfW3cKJ7up+GFdsOQ
         8mNW1wZMe4vWaFDeDPNRtu9Q37ufahqO6iRK7pvQJ5jwNmdHUKcmyGsbBwDD5HQldGVC
         EJyfW3GgHRdnu4YmoK6odIIpfblp+3EY4juLp4E1CaFjgbmyAyurscaKv/B2rOdd5egM
         Z0xHR8aaDmxPQ5ZViXOm8Bhoa2aBCR71k+//AngBSvD/oqvjAj9qhVLSYprmPAv3tln6
         2hVb/MMuWrKnNhPF7lJLwjzvoh8Z+xWzWNya/vRg05QxLEyYgkAz1JoI1+0mhsXwCzkF
         QetQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772378144; x=1772982944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1nkyX5w5KMhDfO8wL4au5byg+U9cvBh7Yz6qo0nwRk=;
        b=T6Tb4UsCBoKaXSHjraGm45GXkEbObFYk+ph1wdlfQG/LFBYZt1SeUHXhWo20D16PfS
         9FUbmKVnYP0TZZuQvHGOotnJqb1Uzqa+KsQ3wCele0oIm1SmGjaZ1eztDH0mZMJ1hHRl
         OS71zKgcfzFmR/jfg/iD0Uy9Kpvdwsz4942RiVMq3jbla1ZeQogzLCY4pGylggZaiWo6
         qYIp/8A0K6/+xbCygtkhl6WnOfFWJstxDbCGGiSN1G4e5+HJmQQxW0XqTYnX02RNy2Kn
         +nEJYesrU9Vx+UgQAeh0a6WeDKqoh7lWHltB8sLKZx56O/x2SiYGZJNvY4P32M1sywjw
         7gDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772378144; x=1772982944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1nkyX5w5KMhDfO8wL4au5byg+U9cvBh7Yz6qo0nwRk=;
        b=YQqZ02f6ww18RsxKANhf5KSehhlW6NlEtjKf0O2qZyK7DpJn/veqXtPDaf6HmgZNcE
         3AfvhqX820jCQfzspY7EGms0nd7TDq4+R5+U+kt+GH6LTwcsPVNoM3sszD7wKsHLSYnh
         ykpeTWgu+1zL+WxX84hg4q6nkpq+fga5KuewOAmPNL4EhmQxeanpkEju0xt73beantpr
         ffDpCL9u+0oUjzQ+lJd8iXscFbAPNoX+1uptdQsPG1jJJ5MMCgSFmr/8wPnNd+iJv74m
         xuk7+nFfoMcHnivPx+AqTcRsMC7wjTnLBDQ0cX7++PLUc/Lq8mMcvqRRWIlCFcj1e8wX
         Kw1w==
X-Forwarded-Encrypted: i=1; AJvYcCXG/cKFAPv9N0ngMvcbirWpeXJbxB2bmptEWxafS+Z7Er7GY7vg55f3r/4puHBWaX1dOrsfgmwjLe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3iDQSKnDzQmW6X+Aauk4BcJXUmCy7PXUjqf7duF7102ogxfLr
	zaAPvrrRp8xk1MeYBLPUXO2iD+7t6r5++kpeXYY1su92HcN/0VdlT9pwZhvWhJCQk/8IFQ5U2cx
	WisLO6hlTYrHrS9LeCwvbYFBdoE7FE8s=
X-Gm-Gg: ATEYQzyWh6ENAlozbf2dgqFC5RlFIUt2gjoWK7qZRiRxQHhoYu7cnSDLowL3GA9UkIt
	H26+gAOTPRzvPK+kqG2hOLXX3tOJFSoxr6NoZqk85MK/bvslVt/ZL1ZMuSedM66nJ1eFjlBEb81
	iV2qy7t840aGviBmtkDl8/VeZVNrB2IUH33uNwJTVNa5EgMHU5UZaNhwNZERf1Ov3Qp4JM/aEcO
	8rXZHO+4PMsRP269Z7lQ9ReDbz0fC13W7KJRJrGdicrLgUTwrT3JHZXms56OVlLurgDPdFpSQWU
	3AhjdX2z1J1412eh53pXeAQ+NccuBKk8h00l5rsvPg==
X-Received: by 2002:a05:6102:510f:b0:5fd:efb0:8563 with SMTP id
 ada2fe7eead31-5ff324dc589mr3714118137.26.1772378143761; Sun, 01 Mar 2026
 07:15:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
 <20260221145915.81749-2-dorjoychy111@gmail.com> <2f430eb613d4f6f6564f83d06f802ff47adea230.camel@kernel.org>
 <CAFfO_h7i86qdKZObdFpWd8Mh+8VXVMFYoGgYBgzomzhGJJFnEQ@mail.gmail.com>
 <ed5aeaa81ad9b87926fa7ebee0308aeb8df9f0ac.camel@kernel.org>
 <CAFfO_h5za6gV99TQS3pwHnf7zyCeVySn3CdRyV+_jFqjovGBqA@mail.gmail.com> <beead8bbff344ddfc279e0fc86db0dd5dd98562b.camel@kernel.org>
In-Reply-To: <beead8bbff344ddfc279e0fc86db0dd5dd98562b.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 21:15:32 +0600
X-Gm-Features: AaiRm51uGb22GXl5p3FqZ7NC0pcEYjsHHjv8pL49Bl-0u37YWrXpqgAvLnlZ9vg
Message-ID: <CAFfO_h4brg90tMNp6VAzs5Lo8Lbu=DK2csjDqr2zspOygKEFCg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19476-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F01A1D05DB
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 9:10=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sun, 2026-03-01 at 21:01 +0600, Dorjoy Chowdhury wrote:
> > On Sun, Mar 1, 2026 at 8:47=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > On Sun, 2026-03-01 at 20:16 +0600, Dorjoy Chowdhury wrote:
> > > > On Sun, Mar 1, 2026 at 6:44=E2=80=AFPM Jeff Layton <jlayton@kernel.=
org> wrote:
> > > > >
> > > > > On Sat, 2026-02-21 at 20:45 +0600, Dorjoy Chowdhury wrote:
> > > > > > This flag indicates the path should be opened if it's a regular=
 file.
> > > > > > This is useful to write secure programs that want to avoid bein=
g
> > > > > > tricked into opening device nodes with special semantics while =
thinking
> > > > > > they operate on regular files. This is a requested feature from=
 the
> > > > > > uapi-group[1].
> > > > > >
> > > > > > A corresponding error code EFTYPE has been introduced. For exam=
ple, if
> > > > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the=
 flag
> > > > > > param, it will return -EFTYPE.
> > > > > >
> > > > > > When used in combination with O_CREAT, either the regular file =
is
> > > > > > created, or if the path already exists, it is opened if it's a =
regular
> > > > > > file. Otherwise, -EFTYPE is returned.
> > > > > >
> > > > >
> > > > > It would be good to mention that EFTYPE has precedent in BSD/Darw=
in.
> > > > > When an error code is already supported in another UNIX-y OS, the=
n it
> > > > > bolsters the case for adding it here.
> > > > >
> > > >
> > > > Good suggestion. Yes, I can include this information in the commit
> > > > message during the next posting.
> > > >
> > > > > Your cover letter mentions that you only tested this on btrfs. At=
 the
> > > > > very least, you should test NFS and SMB. It should be fairly easy=
 to
> > > > > set up mounts over loopback for those cases.
> > > > >
> > > >
> > > > I used virtme-ng (which I think reuses the host's filesystem) to ru=
n
> > > > the compiled bzImage and ran the openat2 kselftests there to verify
> > > > it's working. Is there a similar way I can test NFS/SMB by adding
> > > > kselftests? Or would I need to setup NFS/SMB inside a full VM distr=
o
> > > > with a modified kernel to test this? I would appreciate any suggest=
ion
> > > > on this.
> > > >
> > >
> > > I imagine virtme would need some configuration to set up for nfs or
> > > cifs, but maybe it's possible. I mostly use kdevops for this sort of
> > > testing.
> > >
> >
> > Got it. I will try to figure this out and do some testing for NFS/SMB. =
Thanks.
> >
> > > > > There are some places where it doesn't seem like -EFTYPE will be
> > > > > returned. It looks like it can send back -EISDIR and -ENOTDIR in =
some
> > > > > cases as well. With a new API like this, I think we ought to stri=
ve for
> > > > > consistency.
> > > > >
> > > >
> > > > Good point. There was a comment in a previous posting of this patch
> > > > series "The most useful behavior would indicate what was found (e.g=
.,
> > > > a pipe)."
> > > > (ref: https://lore.kernel.org/linux-fsdevel/vhq3osjqs3nn764wrp2lxp6=
6b4dxpb3n5x3dijhe2yr53qfgy3@tfswbjskc3y6/
> > > > )
> > > > So I thought maybe it would be useful to return -EISDIR where it wa=
s
> > > > already doing that. But it is a good point about consistency that w=
e
> > > > won't be doing this for other different types so I guess it's bette=
r
> > > > to return -EFTYPE for all the cases anyway as you mention. Any
> > > > thoughts?
> > > >
> > >
> > > There is a case to be made for either. The big question is whether yo=
u
> > > can consistently return the same error codes in the same situations.
> > >
> > > For instance, you can return -EISDIR on NFS when the target is a
> > > directory, but can you do the same on btrfs or ceph? If not, then we
> > > have a situation where we have to deal with the possibility of two
> > > different error codes.
> > >
> > > In general, I think returning EFTYPE for everything is simplest and
> > > therefore best. Sure, EISDIR tells you a bit more about the target, b=
ut
> > > that info is probably not that helpful if you were expecting it to be=
 a
> > > regular file.
> > >
> >
> > Good point. I agree. I will fix this and return -EFTYPE for everything
> > in the next posting.
> >
> > > >
> > > > > Should this API return -EFTYPE for all cases where it's not S_IFR=
EG? If
> > > > > not, then what other errors are allowed? Bear in mind that you'll=
 need
> > > > > to document this in the manpages too.
> > > > >
> > > >
> > > > Are the manpages in the kernel git repository or in a separate
> > > > repository? Do I make separate patch series for that? Sorry I don't
> > > > know about this in detail.
> > > >
> > >
> > > Separate repo and mailing list: https://www.kernel.org/doc/man-pages/
> > >
> > > ...come to think of it, you should also cc the linux-api mailing list
> > > when you send the next version:
> > >
> > >     https://www.kernel.org/doc/man-pages/linux-api-ml.html
> > >
> > > This one is fairly straightforward, but once a new API is in a releas=
ed
> > > kernel, it's hard to change things, so we'll want to make sure we get
> > > this right.
> > >
> >
> > I did not know about this. I will cc linux-api mailing list from the
> > next posting.
> >
> > > I should also ask you about testcases here. You should add some tests
> > > to fstests for O_REGULAR if you haven't already:
> > >
> > >     https://www.kernel.org/doc/man-pages/linux-api-ml.html
> > >
> >
> > I only added a kselftest for the new flag in
> > tools/testing/selftests/openat2/openat2_test.c in my second commit in
> > this patch series. Where are the fstests that I should add tests? I
> > think you added the wrong URL above, probably a typo.
> >
> >
>
> I did indeed, sorry. They're here:
>
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>

Thanks! This is a separate git repository, so I guess for both
manpages and fstests I need to submit separate patch series for
O_REGULAR. Do I need to wait first for this patch series to be merged?
How does it work?

Regards,
Dorjoy

