Return-Path: <linux-nfs+bounces-23177-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MlnGHeeuTmpkSQIAu9opvQ
	(envelope-from <linux-nfs+bounces-23177-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 22:11:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0910D72A1D8
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 22:11:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=Z4Uw7QTh;
	dmarc=pass (policy=none) header.from=paul-moore.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23177-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23177-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7786E3004DCA
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2026 20:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132453B8BA4;
	Wed,  8 Jul 2026 20:11:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF23E5EF8
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2026 20:11:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541476; cv=pass; b=nAIr1PsmkqplyjhcEFTUCVBwgqDZZqxB5kPZT/5aqLa/SnWcWr74+Hr+TVO8CHpzReV2Nj1VZ0LyE4g029+0MIa9ukenVqo6K0U4Z//DcbJodOY5VZyYhsl87y970MsZzfQUju/V4dAo6ywx0z+vdA6Mnc9aub2/5d5U8kIzLt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541476; c=relaxed/simple;
	bh=Fy6qHwAxMBKgI4ys2Q4APPGANBPucrsGbSz4jBFobcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/BOUFRHwr7vbUhMmeAZW7cs9hnQyMG3lz0oQ63Uy0ql8vIywKfCGiPFW0jwY1Wetxy/zlpdITIliXTYrQ5CYcJY4nmAWDEB22vd9U8IhrNKorKN+Ats1/yGpvZS5wcjOGpJql8yLU6VBS8y6HIxT/PKryzyT3e5gkaH8Fcrk54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z4Uw7QTh; arc=pass smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc73e322dbso11008715ad.1
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2026 13:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783541468; cv=none;
        d=google.com; s=arc-20260327;
        b=FX0hFLVwromwUOrI/kNvY4J5Jj4BCHG9HIdw54qkHXq/xBXabvBqYx+OHaQh9s3Iu1
         ksyLjfKkIA0a4cimkQVnyLqUwiO5VxMOpP8khKb3X4ii4jxaoH0OtBKa5yyA4JAGKZ5X
         KvwIzKiCOE6R//NebKaJZ6WB9m5gfckrtDQBNp6VADeQt2d+RQk14IL4RobgN6G6Rr1R
         fUmGhTtZN9wKx1b4FRLDyMouQQXwjb11eX5lAq/xonL5QDrDjSNjh+s7oektlAJRdhvD
         LZ9ts4EbgOXgBqnSZqTMfMY/47WJI4u63ufnXRpWpwa1ze6n8yrSHpB1tVhzyqoWHaBM
         A+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SX6q4fztsZP6iSk58v5T5RdgQrRxRC3vIHoyseYXr/w=;
        fh=2mYGkf3nqT7CjFHC0PC7ptv47ii9Qlj47szh0ZxM23A=;
        b=TNq7QjPKQP93yoO3oSOjlYD+4pthtTVg8qBEdjwvu2IEPfCX3uXwDDuBQqoTvFqINt
         WITtJWhcIVcOv9ys8nftIbRl/eE0JS/2YaPNK3oCx+yQWtn6VWGOtQeiB4f/XYgE5eGV
         W5vovXmSlZ/9QdoJVtrfcrgfjVZ57WC5ckCRaJvurgdAdLGR2W66GBD11buN3g12kMMK
         rbk5RbVmpbz0x74pIYxmKub8/UJxzx5GcbKzS8m9Z9S/z/z8rTo0MpwQa0Ra9TOPriS7
         HlawE3iNMnGiT2WENHAuc7whSHl2+9YJvsYORcTb29PRumBcjI1G0HWPPzw0CVGGfv4k
         D6SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783541468; x=1784146268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SX6q4fztsZP6iSk58v5T5RdgQrRxRC3vIHoyseYXr/w=;
        b=Z4Uw7QThiTeLmGGlWNX9W5FqapTdXmaSETNDj1euK/4eD+uHj0wF+eJ7QiN+Z9Zb2n
         NklKrHPmx95uaXG2dMJzd6/wLBTcE48GXp8e8wEhjurUdaF2di8b8a1sNz636/+2ZZU5
         lXxbUSQRdvpvAqa4MDFpM2ZScMaVOwu7pDCZegINDpA60wtt2sxzY+6r1zW0EDjis3Zv
         7twndEUexWygWWqdo8PDnjz2v81gxchpJ9gE7asxoGmMxvUWwGc/Gs5zKs7+EsJG8b2E
         9rqIxygMv4BhV2W1dDC7hFH8qi1nZv0kEiaJkvHVY7iZrY902kd34zRyvjiyvRWY9nxC
         Ymyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783541468; x=1784146268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SX6q4fztsZP6iSk58v5T5RdgQrRxRC3vIHoyseYXr/w=;
        b=UB7pN9nTvxdw/h0FMFl6yzKinyRjp1CDuhrt4P9u66IXh1A1o+4Mg8PAmej1ZloSCO
         qVAGh3pBWOIgCYBbrtInKJD58q0oWw35YzjwLvjMX9GYAgmtWWXBw483eijrL895W/nV
         oYb9dF6A1VZaFD5sP1JnkDYH4R5oGFtxTzzruEsHEXPH+A/56etncRNjNsHAfdYEphOG
         iFY9vnO3OSQqWOiNF7bZGJIiZqZb3P1tHktqkSEW79igehqbEX1/10jOtc7SjNb+TpXt
         5VI9VMRkqDqykiIqLyXoQXoDAjySbDgL8S3wx0rRYAGyfRaa+lFoabKeDzEzQyLOKEaQ
         RCyA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2iP6gbqgRAS/5DmMm52vBSpnppAMT6oXEzppWRmq/dUEH6+VAaKGUbVS+doJcivhSiPv1tfY3ayI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx5Lh03iHLElq1rg9/+j8t4NlcKYYUOQIAljrc1zlR2EAXSyM2
	IgrHNMRNADbzoFGACjSIU01jJLSrxKX867wLk83Yt1xlvpNNmOaCmaenQfQi7DSli96zS1OMqW8
	qkgpFKIol7JWBkJpTtX5K8QEIaUV8DmgpWOv1PIUX
X-Gm-Gg: AfdE7ckuFhd24nsft70cH64haRsKjeIw8GfRQBeOnR4U1AKvbUVbavFmz2CkFCJA7ty
	+PiM0y33HCbE+mEhmipXTt9Jl5+DFNGcEL/08UI9Hv50oce9nFb+ekB8b5vCfNUWHBBYuQesbFp
	EQI/8HMx4dfKAUF50U/qzUngoDnzr79CLxtWw3wJGKT4fOSqzUl+Knl/88TPZR+nK9CjNVNkJtD
	W3TrUDmQywgUaCewgWlHx5cYx4EzpRrdZflZhlc+ibhWueDFwKhvWvr2ikCm4NXQ3KDe564
X-Received: by 2002:a17:902:eccb:b0:2ca:d7a0:1318 with SMTP id
 d9443c01a7336-2ccea3ab636mr36736505ad.11.1783541467977; Wed, 08 Jul 2026
 13:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102759.9626-1-achillesgaikwad@gmail.com>
 <20260707152305.15324-1-achillesgaikwad@gmail.com> <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
 <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com> <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
 <CAEjxPJ7dttPDxQDa_xXFd1H-QT_vkUwjtnH+=3cmG5dhSiaAXw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7dttPDxQDa_xXFd1H-QT_vkUwjtnH+=3cmG5dhSiaAXw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 8 Jul 2026 16:10:55 -0400
X-Gm-Features: AVVi8Cd4qoj8FowNXz9SQ-0VNk5KpjXCV9um-QDkJOYlORaYRve8VAb1A0UZ88M
Message-ID: <CAHC9VhSyCuiPBRWz_vUbx7+L5yLiXkjKX+7UyCLr82-_gAj2NQ@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Anna Schumaker <anna@kernel.org>, Achilles Gaikwad <achillesgaikwad@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23177-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stephen.smalley.work@gmail.com,m:anna@kernel.org,m:achillesgaikwad@gmail.com,m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,paul-moore.com:from_mime,paul-moore.com:email,paul-moore.com:url,paul-moore.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0910D72A1D8

On Wed, Jul 8, 2026 at 2:54=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Jul 7, 2026 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > On Tue, Jul 7, 2026 at 3:12=E2=80=AFPM Anna Schumaker <anna@kernel.org>=
 wrote:
> > > On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> > > > On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> > > > <achillesgaikwad@gmail.com> wrote:
> > > >>
> > > >> A call to listxattr() with a buffer size of 0 returns the actual
> > > >> size of the buffer needed for a subsequent call. On an NFSv4.2
> > > >> mount this triggers the following oops:
> > > >>
> > > >>   [  399.768687] BUG: kernel NULL pointer dereference, address: 00=
00000000000000
> > > >>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
> > > >>   [  399.768722] Call Trace:
> > > >>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
> > > >>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
> > > >>   [  399.768731]  nfs4_listxattr+0x21f/0x250
> > > >>   [  399.768733]  vfs_listxattr+0x55/0xa0
> > > >>   [  399.768736]  listxattr+0x23/0x160
> > > >>   [  399.768737]  path_listxattrat+0xba/0x1e0
> > > >>   [  399.768739]  do_syscall_64+0xe2/0x680
> > > >>
> > > >> security_inode_listsecurity() (via the xattr_list_one() helper) no=
w
> > > >> decrements the remaining size even when the buffer pointer is NULL=
, so
> > > >> in the size-query case, 'left' underflows to a huge size_t value. =
As a
> > > >> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a rea=
l one,
> > > >> leading to a NULL pointer dereference in _copy_from_pages().
> > > >>
> > > >> security_inode_listsecurity() does not return the number of bytes
> > > >> it added to the list, so the code derived it as
> > > >> 'size - error - left'. That is also wrong in the size-query case:
> > > >> the generic_listxattr() contribution is only subtracted from 'left=
'
> > > >> when a buffer is present. Thus, the query result comes up short by
> > > >> exactly that contribution (e.g., "system.nfs4_acl" on a mount with
> > > >> ACL support), and a caller that allocates the returned size gets
> > > >> -ERANGE on the subsequent call.
> > > >>
> > > >> Declare 'left' as ssize_t, use a scratch copy to measure security
> > > >> hook consumption, and only decrement 'left' if a buffer is present=
.
> > > >>
> > > >> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode_l=
istsecurity() interface")
> > > >> Suggested-by: Paul Moore <paul@paul-moore.com>
> > > >> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> > > >> ---
> > > >> Changes in v2:
> > > >>  - Use a scratch variable to track security label size directly,
> > > >>    replacing the old formula that undercounted the size-query case=
.
> > > >>  - Drop the now-unneeded NULL-buffer special case for
> > > >>    nfs4_listxattr_nfs4_user().
> > > >>  - Retitled from "fix nfs4_listxattr NULL pointer dereference"
> > > >>    (the same accounting bug caused both the oops and the undercoun=
t).
> > > >> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-achill=
esgaikwad@gmail.com/
> > > >>  fs/nfs/nfs4proc.c | 10 +++++++---
> > > >>  1 file changed, 7 insertions(+), 3 deletions(-)
> > > >
> > > > [CC'd the LSM and SELinux lists for visibility]
> > > >
> > > > Unfortunately my testing was unsuccessful due to an NFS problem tha=
t
> > > > started with the v7.2 merge window that I haven't had the time to
> > > > bisect yet.  Assuming the NFS folks are okay with this change, I
> > > > figure they will want to send it up to Linus via their tree, if not
> > > > let me know and I can send this up via the LSM tree.
> > >
> > > Yeah, we'll send it through the NFS tree.
> >
> > Thanks Anna.
> >
> > > I'll be curious to hear
> > > what problem you're hitting, and what patch is the culprit once you
> > > do that bisect!
> >
> > Yes, me too :)
> >
> > I'm still working through a review backlog so it might be a bit before
> > I have a chance, but in case anyone wants to test it out, it's easily
> > reproduced using the selinux-testsuite and the NFS tests:
> >
> > https://github.com/SELinuxProject/selinux-testsuite#nfs
>
> They seem to pass for me with and without the patch (they don't
> exercise listxattr AFAIK).
> This was on the current selinux/dev branch, v7.2-rc1 based.

They work for me on vanilla v7.1 and fail somewhere before vanilla
v7.2-rc1 (still bisecting).

I wonder if there is an interaction problem with a recent userspace
update.  What distro/userspace are you running for your tests?  I'm
doing my testing on a relatively recent Rawhide.

--=20
paul-moore.com

