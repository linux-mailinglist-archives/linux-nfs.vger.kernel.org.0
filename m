Return-Path: <linux-nfs+bounces-23188-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FuGvKYWWT2ohkQIAu9opvQ
	(envelope-from <linux-nfs+bounces-23188-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 14:39:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F829731132
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 14:39:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HN20nwGU;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23188-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23188-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E434F3091E81
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 12:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D0C3BED63;
	Thu,  9 Jul 2026 12:33:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910D142378A
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 12:33:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600392; cv=pass; b=njdx2LhOnWhMCpUSo192XWkQwXDzBsEN4Y+yzV37g7nNWWp4lMOoO/0/0ckKyBunyjEt+AZo/uy3DB9YLdTT9dRniHfmhwBAHxoj8ZX4mszpdvFCWOMitTO3MlNkGvkQVzqSW+oE6nvRROJi1b1NWYhJJ5VxwQ1vx3wHPJnZJ8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600392; c=relaxed/simple;
	bh=TZ4/MUsld9BeNU5QPGcKumrNi2uJrTMz7CYtcX2ZYPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvlIMRvWFVCpx3uY0ASwpV4QzilaISJb3zqW+SmgoZ9QtRFdptwTKvScKW0KpVbkA4yPAue2XZHxXgX1p1NwNMlSqsxNUJF5jMWuJT8IMe/EZuXrnz8VmCice6F03R9YHehluL2C65gfPiuGEaMMrKai56+S6P0LOTlfoVK98VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN20nwGU; arc=pass smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso17568035ad.2
        for <linux-nfs@vger.kernel.org>; Thu, 09 Jul 2026 05:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783600389; cv=none;
        d=google.com; s=arc-20260327;
        b=SfKKlZwt0srBz+KryIPh/3BQr9vLtsZcG1zcfaWumcAk77F2gzFdqNcoLwFjF6WKNt
         4LH0nCUalfNb35WpyDoIQF94DMfcwiHNS1+kNZajRFn+i7BXDqA8Pi5Lnt+PLpUoZUnF
         x25XExOxrWMLar5FAjPSI9ugt+ixwd160InBPsEfBh3vXc2r4YwHypoj2Sux+nB30v0A
         UuRIuQrhE5Onh5RGhoIA6SNA1F20qAys8y1TwMGIzjT3dyQZw3DCdDMW2l4IM0bPfnqK
         tX3ULVluLFb7gNETvHG8ZD7I53n5ptQDz3NVisJxEXiQnSBK/ANGGcj/5U6J0yo0gJYA
         kg0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wEznrTgLikCU91TRmqiWgIn6d7+4evlXZ/ukCLbpHQY=;
        fh=KNISephoOrYmBIxEiK6Og3bnUSwegZIfekPKvcS7FpU=;
        b=ORD6dZNo8vqEEQ1tu7H1ZpHMXiuy2ypDleQiQwHdaVGbn7T2ZKSI3XJ4mX0BUYC1qW
         A/NJ0k4LFj8145CWyXYuJdHgyrj7dIzGiVLh9Pe5QgLvlcf3tXDVPVC3Va53ulHl9gVp
         TYhWKCSJ+sPMJEw9QUeus67Qrw5PN9+jgSoChgNkgehkXnOvJ7l273Y0spl+31a5Ao9j
         lOiZhhdQZoo4mOpDCodxjXirP7AfJJc1NwexIaEU2xwXsaEViCb13+axFeiUBn45tQDG
         sV3kp0dgOZBeDDk0skpHWYpkmi7u7rx0JIdR4u17o1JtayDgxc0YiqrmNiVbPaM0McSh
         Z8IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783600389; x=1784205189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wEznrTgLikCU91TRmqiWgIn6d7+4evlXZ/ukCLbpHQY=;
        b=HN20nwGUQhAlIoFLQB2Y24qqbP6XBylsYfXwv5i/Gq6nh362O9PoY07rXep5aiX4Ja
         A/e5/TLrPEry5ib+HqsNe+m3DTGh2P5PTardH7W8Fg1dWyKoewyzajmz/mvRmOy4uK7v
         IHFLHt2w64+PgFbQj/D4O79bDHxCcv26+AlzLg5XPaGg6A5g6dOM5ipc0dyOGhouczqB
         hAi0ljDFpeMzjj6fg+4Eyw2mCY62fDYeJB9K0V6HRDyfkDbKyGzu7A9UX4evukNTzwuh
         YhqNEgD2bT5xirBqw+jC2+8lEBZx3jCxiLoCFCE0fRgAmz9I2MxGWFC6el6oCjGItdvP
         CJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600389; x=1784205189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wEznrTgLikCU91TRmqiWgIn6d7+4evlXZ/ukCLbpHQY=;
        b=cRBGp7KcMpT2CrTLo/kiUDshBmpvTHdcAD1KQyQ5GchumRgcVkr+jNRRp3wDK8TVTt
         31TYAsBhKWsreZVAQoLkMlAFY/eBnGU2NVEIBYQJ6hHuk4t+Q/lDuhqaNY0hP7miE6kG
         fOXr1a2G17riZU0eyAf6RMiD9GSJ/Yf+rM8l4PPl74QKZmHELH+Z/L9aKAYeOFPL2UXB
         BYfrWTlkNR/vX9/SE3c8+rT/ssk8y0ReZDhmFqIs52rDDwmUiFMWzUo1jiIp9iXHDSS4
         mjA7WYaov0uNOKVQlvbMDG3l9R+dt8jSwgSOqKfIQqA7Yt6raTDoRJ2cGjJU1NP5Ud6W
         QI9w==
X-Forwarded-Encrypted: i=1; AHgh+RoqmoCd6o00bm+wJ46VE+IkZXGqvrhUY2GawQbGptqfaB6U3bi0pfno5evBZz5pTqzRiQpvs3FQSUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeHn4fsty0yBhqTvnBmzJuJwmuC9IZGvgWRQ74+ek510bd97oG
	yJAwbNSVd6pvnv/0Ia659hZn+OxoAIr9wWlOHbGmTg2OF62egIEE8yykJuocZvrgqVL6G8J4AP3
	c9y/Wr9erObNDHH0sLZsWQzEJXXrHoTo=
X-Gm-Gg: AfdE7cmXh8F+k/+vr3oTBg3ZCf6QetE4wDku2ETA1JGZrRqfliq2JHx9enHEmOmUkLR
	NEF5Qy49yvsWCznRplyhVFutmExrWXCFVnpr44kGlEZOdmWV2/wa//+X1dCw2UcLusPEXob4oer
	a2pl6chDeOXEQ2mDD6dTqyCJdx7kWBCUjS+6FwhPL0ESbUroRyGvKAxmZfzYH1KflOSkw8dwgWS
	qEcc/R3UAHq2N114IoyLaKDB+vVWWCRKfCJWWlCxt1g8bEv6cxhPekRUYUDgr7Y8nHXMBqY
X-Received: by 2002:a17:902:fb0d:b0:2ca:f21a:a6c5 with SMTP id
 d9443c01a7336-2ccea34857fmr53376045ad.1.1783600388853; Thu, 09 Jul 2026
 05:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102759.9626-1-achillesgaikwad@gmail.com>
 <20260707152305.15324-1-achillesgaikwad@gmail.com> <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
 <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com> <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
 <CAEjxPJ7dttPDxQDa_xXFd1H-QT_vkUwjtnH+=3cmG5dhSiaAXw@mail.gmail.com> <CAHC9VhSyCuiPBRWz_vUbx7+L5yLiXkjKX+7UyCLr82-_gAj2NQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSyCuiPBRWz_vUbx7+L5yLiXkjKX+7UyCLr82-_gAj2NQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 9 Jul 2026 08:32:57 -0400
X-Gm-Features: AVVi8Cd4uZMDN1rLABDX_bWMI0FuplRTPn2H59VH4Frrquyfh8DPbM0M13o1E7I
Message-ID: <CAEjxPJ4+wgUDY3YxajZ=2D3WLzgat_Mqvr05VtJ4KrXW7_kuXA@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: Paul Moore <paul@paul-moore.com>
Cc: Anna Schumaker <anna@kernel.org>, Achilles Gaikwad <achillesgaikwad@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:anna@kernel.org,m:achillesgaikwad@gmail.com,m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23188-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[stephensmalleywork@gmail.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephensmalleywork@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,paul-moore.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F829731132

On Wed, Jul 8, 2026 at 4:11=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Wed, Jul 8, 2026 at 2:54=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Jul 7, 2026 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > >
> > > On Tue, Jul 7, 2026 at 3:12=E2=80=AFPM Anna Schumaker <anna@kernel.or=
g> wrote:
> > > > On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> > > > > On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> > > > > <achillesgaikwad@gmail.com> wrote:
> > > > >>
> > > > >> A call to listxattr() with a buffer size of 0 returns the actual
> > > > >> size of the buffer needed for a subsequent call. On an NFSv4.2
> > > > >> mount this triggers the following oops:
> > > > >>
> > > > >>   [  399.768687] BUG: kernel NULL pointer dereference, address: =
0000000000000000
> > > > >>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
> > > > >>   [  399.768722] Call Trace:
> > > > >>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
> > > > >>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
> > > > >>   [  399.768731]  nfs4_listxattr+0x21f/0x250
> > > > >>   [  399.768733]  vfs_listxattr+0x55/0xa0
> > > > >>   [  399.768736]  listxattr+0x23/0x160
> > > > >>   [  399.768737]  path_listxattrat+0xba/0x1e0
> > > > >>   [  399.768739]  do_syscall_64+0xe2/0x680
> > > > >>
> > > > >> security_inode_listsecurity() (via the xattr_list_one() helper) =
now
> > > > >> decrements the remaining size even when the buffer pointer is NU=
LL, so
> > > > >> in the size-query case, 'left' underflows to a huge size_t value=
. As a
> > > > >> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a r=
eal one,
> > > > >> leading to a NULL pointer dereference in _copy_from_pages().
> > > > >>
> > > > >> security_inode_listsecurity() does not return the number of byte=
s
> > > > >> it added to the list, so the code derived it as
> > > > >> 'size - error - left'. That is also wrong in the size-query case=
:
> > > > >> the generic_listxattr() contribution is only subtracted from 'le=
ft'
> > > > >> when a buffer is present. Thus, the query result comes up short =
by
> > > > >> exactly that contribution (e.g., "system.nfs4_acl" on a mount wi=
th
> > > > >> ACL support), and a caller that allocates the returned size gets
> > > > >> -ERANGE on the subsequent call.
> > > > >>
> > > > >> Declare 'left' as ssize_t, use a scratch copy to measure securit=
y
> > > > >> hook consumption, and only decrement 'left' if a buffer is prese=
nt.
> > > > >>
> > > > >> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode=
_listsecurity() interface")
> > > > >> Suggested-by: Paul Moore <paul@paul-moore.com>
> > > > >> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> > > > >> ---
> > > > >> Changes in v2:
> > > > >>  - Use a scratch variable to track security label size directly,
> > > > >>    replacing the old formula that undercounted the size-query ca=
se.
> > > > >>  - Drop the now-unneeded NULL-buffer special case for
> > > > >>    nfs4_listxattr_nfs4_user().
> > > > >>  - Retitled from "fix nfs4_listxattr NULL pointer dereference"
> > > > >>    (the same accounting bug caused both the oops and the underco=
unt).
> > > > >> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-achi=
llesgaikwad@gmail.com/
> > > > >>  fs/nfs/nfs4proc.c | 10 +++++++---
> > > > >>  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > >
> > > > > [CC'd the LSM and SELinux lists for visibility]
> > > > >
> > > > > Unfortunately my testing was unsuccessful due to an NFS problem t=
hat
> > > > > started with the v7.2 merge window that I haven't had the time to
> > > > > bisect yet.  Assuming the NFS folks are okay with this change, I
> > > > > figure they will want to send it up to Linus via their tree, if n=
ot
> > > > > let me know and I can send this up via the LSM tree.
> > > >
> > > > Yeah, we'll send it through the NFS tree.
> > >
> > > Thanks Anna.
> > >
> > > > I'll be curious to hear
> > > > what problem you're hitting, and what patch is the culprit once you
> > > > do that bisect!
> > >
> > > Yes, me too :)
> > >
> > > I'm still working through a review backlog so it might be a bit befor=
e
> > > I have a chance, but in case anyone wants to test it out, it's easily
> > > reproduced using the selinux-testsuite and the NFS tests:
> > >
> > > https://github.com/SELinuxProject/selinux-testsuite#nfs
> >
> > They seem to pass for me with and without the patch (they don't
> > exercise listxattr AFAIK).
> > This was on the current selinux/dev branch, v7.2-rc1 based.
>
> They work for me on vanilla v7.1 and fail somewhere before vanilla
> v7.2-rc1 (still bisecting).
>
> I wonder if there is an interaction problem with a recent userspace
> update.  What distro/userspace are you running for your tests?  I'm
> doing my testing on a relatively recent Rawhide.

I was on F44, so yes, it could be a difference in e.g. coreutils or
other userspace on rawhide that is tickling this particular bug.

