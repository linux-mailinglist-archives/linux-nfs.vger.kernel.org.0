Return-Path: <linux-nfs+bounces-23247-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8yVCHUJsUWpZEgMAu9opvQ
	(envelope-from <linux-nfs+bounces-23247-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jul 2026 00:03:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA26373F509
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jul 2026 00:03:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b="DapG6S/H";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23247-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23247-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EF3C30607FE
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 21:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124A43BBA0B;
	Fri, 10 Jul 2026 21:55:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A3D3955FF
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2026 21:55:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720558; cv=pass; b=DWbQKY++hDBbXpfa5T76wfVUvV1Wf9KWdI+JLvqk762EejHIHK+WZqgOUtUiLwbNVvAefd4JLY0soXDj8xmEaRVDN22SA5g5APc01dV2UEEE3usiOCPoEhBTU4x1RgH1j0G0bzp562Y4FmPG0I/uh6TTB2kIEYduFy15jvoNJDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720558; c=relaxed/simple;
	bh=CpBTlve58c00BbzjM0b8zgecVzKqAVP6/zTAcKxUqpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4knpTsW9pYELo+sC/KOIl5B3g4n21gRItYscYfS0qPG4K/76TkoNFFfJpGYQOOtvpPdGnPPPQl9YabqfA/OsxjIwqnznurFA+0f6QfzQAJS6h/5YQMYW/bTkO7MTcZWaWs3FrmsqjfpvDvJPBDNSp0vJ7k6qJGZQWh2Q9JL/8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DapG6S/H; arc=pass smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cca0c5799eso13583015ad.0
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2026 14:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783720557; cv=none;
        d=google.com; s=arc-20260327;
        b=fPs/jW2wxfFB16MilPykRSQpx/U1c5pAOZ4AsOHfi11JCAXuK7EIbDh7Pd3SDNG2dt
         lWqsBrHk8OsBtERo+TWQ+CSVhMS4IYX23DCKGfCKrXakmJ8xWcC9pH0Db7GJGzwMFJBZ
         l9L+AXe4wEK1n1Gf0y9F0FBwcr0joYx9DhmK6NKrz317vy34OW7MchETn1nPcxsp168s
         7X+rgWAp578tJ/3HBhs0cDE5r4eYu8cAyWOEnCfC+5DZFHsLMsMD4AFdbq0bIRVewyRO
         j1kP158ed1G9X44JQ3fwcK3BBH5sg1FfvIE09itbIMXDaWOlv0ChV7REnTWcDMOFybib
         SboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6nW9bDyOYHp4zq5N/lxHsUJ94wjBO7jwW7eDg4ejnfg=;
        fh=eLZQN65DuQiS3JKfD1H6kVv6ke7B5f4v8y6k7QZLgKY=;
        b=IA6aQx8l6+ewlT1hK+oe/l4qdbXWLldNYtb+y1aPBuGs4cbQ2kFQHQn639xLVzSLFG
         gPBO2TdUOemssfJD7DN+BZkES8vgUyM+LGg3SFA6YGtG4HMYhINKq0pfaFF41qHMxv3I
         Ezrx4PzKFu85e6dQafRVf8+aoFjgE+Tg8NJrBSL/XlJtl5A0DknFB+ek6wrWhLfASxmx
         o8ZQRHPmopMGxvffpstxkgSoUjvRJwgJqCi9x1T2e/5sA+QLo+keLTUUhU3ROOCbOm7f
         Kir6GgSbgUUibCJQy0mXalE1+YOv3peFpVRKZr3UiTfKfSedEkIESanvP3TlhdGxG681
         Po1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783720557; x=1784325357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6nW9bDyOYHp4zq5N/lxHsUJ94wjBO7jwW7eDg4ejnfg=;
        b=DapG6S/HsoQjSDy2bdJEbgxhfqOQRGYa6eb+fOMxWXrIOkLm3BoP25qN6D352GxLQM
         k1zA6e6yGAK4QBwmplxJJ6sjFqZ7LiIxjsP+ei2asL4TpLjav7hsp52Dkg4nUhsS3hDr
         4sS1X4TA4uOoyvvirJpNiGOJaGgumPpTXmTof9sTYK+zBZG/LKfzshMOFBrCemRc78Vc
         LUCR3AEqxP8XqL2xwMkn1OuLMZlP0zX+DLXTG0HBSpnXvlFICLA9QDwI3vglrbDFqBIY
         o2PAdWPZ8ZeoxngIqyqkBI5G7DkLEsSpaudjtZL55IaaH23meWwfsfSfkS/+ThGg4LRS
         BNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783720557; x=1784325357;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6nW9bDyOYHp4zq5N/lxHsUJ94wjBO7jwW7eDg4ejnfg=;
        b=pDhS+oD13tHzwFvER3LOd0bRJNNIU0HzhhUdts8C07lMS/vD25JmBrYqv5nyj9COIR
         lVLb2XaR3mrHzrsThGP4V69lZwLqHSdzVdbvMsbhIcqye1Z799nwQBKm1Gw1I78oGp5e
         YoR0Dvdr8iJrwNkrjZKQHuWhiHbNFT2yX0rZ4eZt7jHNRnAsCA2mMNKn/hvGEOEl1vMW
         JKauJA4/bublsqTz68MDrkSbsCgpIIcjno4PUyWOo6kE1ErdJqLtullxjXQKu1OMcA5d
         h/Mjq0y2Qjo9U+nmCfRwkOLvuzvEnnxVU9BVdctwL7+2vX7J+npHAKTPQl8tinlEAm5c
         a98Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr9iBKUAbaBg7un3ZW+TT4V2XpJJzhSmbArhFyKF5SBgC5lttXJaSnyfh/j5xBSFnN52Yr4xqy3hSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTBApW3NBle2YL7SiQlf2v3osPGuI0g848cJVQfbBxDbGEjfJj
	ZkiR+oXfGwdOR1gyUuWq5KnZp15R5uWNHj4B47wCbihhHoUNZT0alzzK9U58onMFfLqsL3jS5XF
	K9iAoZo2JW5rS8k4xR1c0Yv7p6KkmLQB80LeJ1Zrc
X-Gm-Gg: AfdE7cn65RdcRm66jAdhk++1TJznOBFGtvXKA+od4VrbHeMuVdOg/i7NEznXJCClIFx
	q4H6N2r9uu63iVP/zUzIhas7okr8DBXaIBq1xhmqUiLDzU5zIXa7rxHVrpvaU+Ck8z1ZrOvDZLs
	mhQYwizOBzBhQDlyqkoxKpv/GKWw/jhxnRstWJp+9K1MKKTEtLe/1MsJ5wOTl+5FI0hW3oN45Ew
	NbExxCOD4flh3SYfT8YhiHLNQcHAXzMdBQmhB56OscHkb110pVAPJBEWk0PNFe0GmTd3QHsF3J8
	QyNn+y0=
X-Received: by 2002:a17:902:c946:b0:2c9:97a8:aff0 with SMTP id
 d9443c01a7336-2ce9f3d32f3mr7347585ad.41.1783720556784; Fri, 10 Jul 2026
 14:55:56 -0700 (PDT)
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
 <CAHC9VhSyCuiPBRWz_vUbx7+L5yLiXkjKX+7UyCLr82-_gAj2NQ@mail.gmail.com>
 <CAEjxPJ4+wgUDY3YxajZ=2D3WLzgat_Mqvr05VtJ4KrXW7_kuXA@mail.gmail.com> <CAHC9VhSxpAx+G35fbcMjJ1PfqJxDZYpTEu=qpO+0PQe=nkX5-g@mail.gmail.com>
In-Reply-To: <CAHC9VhSxpAx+G35fbcMjJ1PfqJxDZYpTEu=qpO+0PQe=nkX5-g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Jul 2026 17:55:45 -0400
X-Gm-Features: AVVi8CcRGJaw79Fwkeco2JWCt0FgBIV6FkEdFiwKcVM1JtfPwuXxarWAiXeQC18
Message-ID: <CAHC9VhRq+Vth-4D4OHFAY_6hXqmj=MgTc_2G=3Ehr6bAQzp26Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23247-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stephen.smalley.work@gmail.com,m:anna@kernel.org,m:achillesgaikwad@gmail.com,m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,paul-moore.com:from_mime,paul-moore.com:email,paul-moore.com:url,paul-moore.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA26373F509

On Fri, Jul 10, 2026 at 5:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Jul 9, 2026 at 8:33=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Jul 8, 2026 at 4:11=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Wed, Jul 8, 2026 at 2:54=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Tue, Jul 7, 2026 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > >
> > > > > On Tue, Jul 7, 2026 at 3:12=E2=80=AFPM Anna Schumaker <anna@kerne=
l.org> wrote:
> > > > > > On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> > > > > > > On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> > > > > > > <achillesgaikwad@gmail.com> wrote:
> > > > > > >>
> > > > > > >> A call to listxattr() with a buffer size of 0 returns the ac=
tual
> > > > > > >> size of the buffer needed for a subsequent call. On an NFSv4=
.2
> > > > > > >> mount this triggers the following oops:
> > > > > > >>
> > > > > > >>   [  399.768687] BUG: kernel NULL pointer dereference, addre=
ss: 0000000000000000
> > > > > > >>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
> > > > > > >>   [  399.768722] Call Trace:
> > > > > > >>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
> > > > > > >>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
> > > > > > >>   [  399.768731]  nfs4_listxattr+0x21f/0x250
> > > > > > >>   [  399.768733]  vfs_listxattr+0x55/0xa0
> > > > > > >>   [  399.768736]  listxattr+0x23/0x160
> > > > > > >>   [  399.768737]  path_listxattrat+0xba/0x1e0
> > > > > > >>   [  399.768739]  do_syscall_64+0xe2/0x680
> > > > > > >>
> > > > > > >> security_inode_listsecurity() (via the xattr_list_one() help=
er) now
> > > > > > >> decrements the remaining size even when the buffer pointer i=
s NULL, so
> > > > > > >> in the size-query case, 'left' underflows to a huge size_t v=
alue. As a
> > > > > > >> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as=
 a real one,
> > > > > > >> leading to a NULL pointer dereference in _copy_from_pages().
> > > > > > >>
> > > > > > >> security_inode_listsecurity() does not return the number of =
bytes
> > > > > > >> it added to the list, so the code derived it as
> > > > > > >> 'size - error - left'. That is also wrong in the size-query =
case:
> > > > > > >> the generic_listxattr() contribution is only subtracted from=
 'left'
> > > > > > >> when a buffer is present. Thus, the query result comes up sh=
ort by
> > > > > > >> exactly that contribution (e.g., "system.nfs4_acl" on a moun=
t with
> > > > > > >> ACL support), and a caller that allocates the returned size =
gets
> > > > > > >> -ERANGE on the subsequent call.
> > > > > > >>
> > > > > > >> Declare 'left' as ssize_t, use a scratch copy to measure sec=
urity
> > > > > > >> hook consumption, and only decrement 'left' if a buffer is p=
resent.
> > > > > > >>
> > > > > > >> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_i=
node_listsecurity() interface")
> > > > > > >> Suggested-by: Paul Moore <paul@paul-moore.com>
> > > > > > >> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> > > > > > >> ---
> > > > > > >> Changes in v2:
> > > > > > >>  - Use a scratch variable to track security label size direc=
tly,
> > > > > > >>    replacing the old formula that undercounted the size-quer=
y case.
> > > > > > >>  - Drop the now-unneeded NULL-buffer special case for
> > > > > > >>    nfs4_listxattr_nfs4_user().
> > > > > > >>  - Retitled from "fix nfs4_listxattr NULL pointer dereferenc=
e"
> > > > > > >>    (the same accounting bug caused both the oops and the und=
ercount).
> > > > > > >> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-=
achillesgaikwad@gmail.com/
> > > > > > >>  fs/nfs/nfs4proc.c | 10 +++++++---
> > > > > > >>  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > [CC'd the LSM and SELinux lists for visibility]
> > > > > > >
> > > > > > > Unfortunately my testing was unsuccessful due to an NFS probl=
em that
> > > > > > > started with the v7.2 merge window that I haven't had the tim=
e to
> > > > > > > bisect yet.  Assuming the NFS folks are okay with this change=
, I
> > > > > > > figure they will want to send it up to Linus via their tree, =
if not
> > > > > > > let me know and I can send this up via the LSM tree.
> > > > > >
> > > > > > Yeah, we'll send it through the NFS tree.
> > > > >
> > > > > Thanks Anna.
> > > > >
> > > > > > I'll be curious to hear
> > > > > > what problem you're hitting, and what patch is the culprit once=
 you
> > > > > > do that bisect!
> > > > >
> > > > > Yes, me too :)
> > > > >
> > > > > I'm still working through a review backlog so it might be a bit b=
efore
> > > > > I have a chance, but in case anyone wants to test it out, it's ea=
sily
> > > > > reproduced using the selinux-testsuite and the NFS tests:
> > > > >
> > > > > https://github.com/SELinuxProject/selinux-testsuite#nfs
> > > >
> > > > They seem to pass for me with and without the patch (they don't
> > > > exercise listxattr AFAIK).
> > > > This was on the current selinux/dev branch, v7.2-rc1 based.
> > >
> > > They work for me on vanilla v7.1 and fail somewhere before vanilla
> > > v7.2-rc1 (still bisecting).
> > >
> > > I wonder if there is an interaction problem with a recent userspace
> > > update.  What distro/userspace are you running for your tests?  I'm
> > > doing my testing on a relatively recent Rawhide.
> >
> > I was on F44, so yes, it could be a difference in e.g. coreutils or
> > other userspace on rawhide that is tickling this particular bug.
>
> I haven't had a chance to look into this yet, but the git bisect just
> produced the commit below as the offending commit:
>
>    commit 01c2305795a3b6b164df48e72b12022a68fd60c1
>    Author: Jeff Layton <jlayton@kernel.org>
>    Date:   Wed Mar 25 10:40:32 2026 -0400

Ooops, nevermind, scratch that - I still have one more kernel to test.

--=20
paul-moore.com

