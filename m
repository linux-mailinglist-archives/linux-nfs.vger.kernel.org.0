Return-Path: <linux-nfs+bounces-23246-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SfzCD61sUWqPEgMAu9opvQ
	(envelope-from <linux-nfs+bounces-23246-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jul 2026 00:05:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B91E73F52C
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jul 2026 00:05:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b="FI/MELPu";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23246-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23246-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66CDB301BC0D
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 21:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6BB3EB0FF;
	Fri, 10 Jul 2026 21:55:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585F3E7BA8
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2026 21:55:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720513; cv=pass; b=r3kXhuE2/l5sFUwZHThw4NRNLnRGC+rQNUQy1c3wkR+OhpRfSoNQJBZCElr/63XapJaJ/641wMdu4MUgI5OHyxDU+jx89SUmNf/twltN5skSw0JkM+ZN3eOt3puFOFPn5SXucqH/031Lh/FoHbm9FEl0D9aaI3yTQNLu5MLXCxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720513; c=relaxed/simple;
	bh=XtQaNN92G4Sy5XjgYZ7PtznLtjfPFcMPMPm+5XwS9R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+kWUznxfs3gtNynOpAgc4wJ0zoBGZpIUsIiPQ684BpRjzHq4A2l2Q1ATxa/IRw97FSz178LFhXeAfGChbqcgxWjtNjlIHJTohYGD9PwPjqRNvPmIn10uVDunVabbpVHgMYbd8v206j3K/fNoxXX663ouqivBzVJ6qFYwmk1U0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FI/MELPu; arc=pass smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-384c94c9414so1451575a91.3
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2026 14:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783720510; cv=none;
        d=google.com; s=arc-20260327;
        b=O+1HBETyuCLVen48gmDGQTplSMOqvzwchx/JXvjwilK/x/BXWBm9Tt78rJgeT2IDlt
         ADeJwRiIaxPj+Wr+DnMs/XXVfyVhnbSjJC17rIWWGhOe5PSg+XYkUa9eUjUnI2U7/rM0
         1YjtbDVMT7eoVriOCUEZNvQqZ7tANPhw6tx0wEXo+s9g+ghVr637ZRY8YImYip2h01Ah
         4pMyZ3rPlj0KYGznPzzZ3JJ7PoC7Fqd4SWyVBQybqp2/o+D9jWrZB5m/2XSwDyQkTYzn
         aIKqGdc86sVnJHa8sSasgPbfxSZaBLr2xgpSNd0COkx621/XKHk7LTRep7sVSNH/ZdVf
         b/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6XeOo/ULnXcigTrjbn+2fwnIM1ZI1Z5B9LAbPypSswc=;
        fh=pq4RY0I4XWm5k4D2Rd75X1om/CdiLZoiq16QL0mGimk=;
        b=PO471T2nom4hczEEDoerUdKMxRymzY3PVfES6hKj6yuN7FLKQyNMK6WCVT+o1RYcRJ
         zUGirBLd22DWqoFr8VyQsFkkCPticxsZMfIFX2/hyhy3/2RcyWEF4Zz14M/ykNksFIEo
         3bcde+S3QP3qcbF44neS2cGidL83drTDF+EbDE+R3ztpWFUkOdHUaNXs02K/MifCxEO9
         UDGXTsO8DsLeDGrZVQFRGqAcwEXyzLqj2qAgVpMuXHfTEnvnDYKzSdgfXnD5odL4hGPd
         qfiJ40WJpAPaIH17NRXh8crCKqCPbvLAJm4qXU7o3fhHwSL1epyZ40TdlvY4cmTaYiVw
         2l2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783720510; x=1784325310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6XeOo/ULnXcigTrjbn+2fwnIM1ZI1Z5B9LAbPypSswc=;
        b=FI/MELPuvbsA1fG989djyLNjUqJc3PlF0fZ1oPQktcwCjeDXAg9UjP1eSdhVEsGQgU
         dlV9yAtCAxvJjj9ZCmY/uUXyenX7q4T/+htznt0c/KXs2bemmUazkAjxmeXETWtSRHdu
         Ehdonvz5GUg2cx3MBNZlXS7WWH+eBuaDomuXzsBMWxlJ5/uOXsugA53vfjXc88AKIaqa
         8fNeNAJh6FMI4aweHxnWTPulLhe2gqTKFRiAfT+IkBjkx03ItSUQGqDPEYhBgyr7qGaI
         /18I7QLn4qmfI/el1RoZw6DTYWgB26J4aHYXSeWflcPrVRgvU4eslZ1ht+hWZ5erwbad
         BuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783720510; x=1784325310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6XeOo/ULnXcigTrjbn+2fwnIM1ZI1Z5B9LAbPypSswc=;
        b=q+3e/bOGWK9AoxLdBB75GMg0GVIEf2H0noQ6sk2HKcyfPL4ZfUhUhUUyigZ4hwNZMf
         rtblqz+ThAa62rTcbTJuDtmEeltFDT+8CShCbvTtI4TcXaEjnjkTBAUDxIE24Q9QqP5v
         zp6/CNG4rEVEC7I4ckq6EZhaVTu/9s/CFOSfwMQXItrXJ09N5LfbSRwSuYHQUxNZqaE5
         +xTBvukaNU5AGEMXgO2CLkX2HRumvct/0ghQSBWl89E2k9iX/oM3unwWJTEIYNNF5Abm
         jusa1xlz3JRXKfLSI76SfswAJCTl0jeDzJjY1O1qlsn6mGmb4pTyaIpJCJ5weafPtYWg
         rTIQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrsT3RUMlcUMQmVkGYXgxJaOHk3jjpBx1viX+CuNEbLpg42u9vAI4WV9PEHPZmIv9w7xGu3UwhcVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH3KHVSISoZriCJnyVO9H7CPdwtpV+Kzht0moXcvYBgeZIJYlp
	B9gnJKmys3bqu/0myfvYG3/jvLGm7i4tst4TFGuKOxyFskf5uagrD1IrWoOGMfgBP6YAEuANE53
	KEuNfliY05MInaY2D9w1LXR5Bb9CM6XDHtCgSn+eJ
X-Gm-Gg: AfdE7ck4NlMNd9a+zYTq6Z2Z23aJQsbJJUiNE3kxdsPh8ruxVb7uRfbOuVBz5+EeSiT
	7qz8AJPDLBmYOv1PP0mF2l5Hhe9JLewsSkWRHMB1Saxo+Uoh0Nwwnl66vssgIIMcCmRdd3Lirmm
	s2CgD/B/NrTF9mOJugg1bxyNkJvnS0gwC1b6Q1dcMDyQoZZVRFWBo8sivpJQzuc5rZIjpaPhtAk
	46oTE23bs2FyBp5TCDnZHBJl3TtCr4yHDhM2+RibUtNFPVCvP3UOIhBPo0I9DvtSE/plwo7
X-Received: by 2002:a17:90b:3d89:b0:381:2811:e8ad with SMTP id
 98e67ed59e1d1-38dc7777abcmr646036a91.23.1783720509556; Fri, 10 Jul 2026
 14:55:09 -0700 (PDT)
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
 <CAHC9VhSyCuiPBRWz_vUbx7+L5yLiXkjKX+7UyCLr82-_gAj2NQ@mail.gmail.com> <CAEjxPJ4+wgUDY3YxajZ=2D3WLzgat_Mqvr05VtJ4KrXW7_kuXA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4+wgUDY3YxajZ=2D3WLzgat_Mqvr05VtJ4KrXW7_kuXA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Jul 2026 17:54:57 -0400
X-Gm-Features: AVVi8CeXE7oLDsWTKiw8a4raGtdwgg-BRS7l6ETRD_v0qIyJINJnj45P77RcbOM
Message-ID: <CAHC9VhSxpAx+G35fbcMjJ1PfqJxDZYpTEu=qpO+0PQe=nkX5-g@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-23246-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:from_mime,paul-moore.com:email,paul-moore.com:url,paul-moore.com:dkim,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B91E73F52C

On Thu, Jul 9, 2026 at 8:33=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Jul 8, 2026 at 4:11=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Wed, Jul 8, 2026 at 2:54=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Tue, Jul 7, 2026 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > >
> > > > On Tue, Jul 7, 2026 at 3:12=E2=80=AFPM Anna Schumaker <anna@kernel.=
org> wrote:
> > > > > On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> > > > > > On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> > > > > > <achillesgaikwad@gmail.com> wrote:
> > > > > >>
> > > > > >> A call to listxattr() with a buffer size of 0 returns the actu=
al
> > > > > >> size of the buffer needed for a subsequent call. On an NFSv4.2
> > > > > >> mount this triggers the following oops:
> > > > > >>
> > > > > >>   [  399.768687] BUG: kernel NULL pointer dereference, address=
: 0000000000000000
> > > > > >>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
> > > > > >>   [  399.768722] Call Trace:
> > > > > >>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
> > > > > >>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
> > > > > >>   [  399.768731]  nfs4_listxattr+0x21f/0x250
> > > > > >>   [  399.768733]  vfs_listxattr+0x55/0xa0
> > > > > >>   [  399.768736]  listxattr+0x23/0x160
> > > > > >>   [  399.768737]  path_listxattrat+0xba/0x1e0
> > > > > >>   [  399.768739]  do_syscall_64+0xe2/0x680
> > > > > >>
> > > > > >> security_inode_listsecurity() (via the xattr_list_one() helper=
) now
> > > > > >> decrements the remaining size even when the buffer pointer is =
NULL, so
> > > > > >> in the size-query case, 'left' underflows to a huge size_t val=
ue. As a
> > > > > >> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a=
 real one,
> > > > > >> leading to a NULL pointer dereference in _copy_from_pages().
> > > > > >>
> > > > > >> security_inode_listsecurity() does not return the number of by=
tes
> > > > > >> it added to the list, so the code derived it as
> > > > > >> 'size - error - left'. That is also wrong in the size-query ca=
se:
> > > > > >> the generic_listxattr() contribution is only subtracted from '=
left'
> > > > > >> when a buffer is present. Thus, the query result comes up shor=
t by
> > > > > >> exactly that contribution (e.g., "system.nfs4_acl" on a mount =
with
> > > > > >> ACL support), and a caller that allocates the returned size ge=
ts
> > > > > >> -ERANGE on the subsequent call.
> > > > > >>
> > > > > >> Declare 'left' as ssize_t, use a scratch copy to measure secur=
ity
> > > > > >> hook consumption, and only decrement 'left' if a buffer is pre=
sent.
> > > > > >>
> > > > > >> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_ino=
de_listsecurity() interface")
> > > > > >> Suggested-by: Paul Moore <paul@paul-moore.com>
> > > > > >> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> > > > > >> ---
> > > > > >> Changes in v2:
> > > > > >>  - Use a scratch variable to track security label size directl=
y,
> > > > > >>    replacing the old formula that undercounted the size-query =
case.
> > > > > >>  - Drop the now-unneeded NULL-buffer special case for
> > > > > >>    nfs4_listxattr_nfs4_user().
> > > > > >>  - Retitled from "fix nfs4_listxattr NULL pointer dereference"
> > > > > >>    (the same accounting bug caused both the oops and the under=
count).
> > > > > >> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-ac=
hillesgaikwad@gmail.com/
> > > > > >>  fs/nfs/nfs4proc.c | 10 +++++++---
> > > > > >>  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > [CC'd the LSM and SELinux lists for visibility]
> > > > > >
> > > > > > Unfortunately my testing was unsuccessful due to an NFS problem=
 that
> > > > > > started with the v7.2 merge window that I haven't had the time =
to
> > > > > > bisect yet.  Assuming the NFS folks are okay with this change, =
I
> > > > > > figure they will want to send it up to Linus via their tree, if=
 not
> > > > > > let me know and I can send this up via the LSM tree.
> > > > >
> > > > > Yeah, we'll send it through the NFS tree.
> > > >
> > > > Thanks Anna.
> > > >
> > > > > I'll be curious to hear
> > > > > what problem you're hitting, and what patch is the culprit once y=
ou
> > > > > do that bisect!
> > > >
> > > > Yes, me too :)
> > > >
> > > > I'm still working through a review backlog so it might be a bit bef=
ore
> > > > I have a chance, but in case anyone wants to test it out, it's easi=
ly
> > > > reproduced using the selinux-testsuite and the NFS tests:
> > > >
> > > > https://github.com/SELinuxProject/selinux-testsuite#nfs
> > >
> > > They seem to pass for me with and without the patch (they don't
> > > exercise listxattr AFAIK).
> > > This was on the current selinux/dev branch, v7.2-rc1 based.
> >
> > They work for me on vanilla v7.1 and fail somewhere before vanilla
> > v7.2-rc1 (still bisecting).
> >
> > I wonder if there is an interaction problem with a recent userspace
> > update.  What distro/userspace are you running for your tests?  I'm
> > doing my testing on a relatively recent Rawhide.
>
> I was on F44, so yes, it could be a difference in e.g. coreutils or
> other userspace on rawhide that is tickling this particular bug.

I haven't had a chance to look into this yet, but the git bisect just
produced the commit below as the offending commit:

   commit 01c2305795a3b6b164df48e72b12022a68fd60c1
   Author: Jeff Layton <jlayton@kernel.org>
   Date:   Wed Mar 25 10:40:32 2026 -0400

   nfsd: add netlink upcall for the nfsd.fh cache

   Add netlink-based cache upcall support for the expkey (nfsd.fh) cache,
   following the same pattern as the existing svc_export netlink support.

   Add expkey to the cache-type enum, a new expkey attribute-set with
   client, fsidtype, fsid, negative, expiry, and path fields, and the
   expkey-get-reqs / expkey-set-reqs operations to the nfsd YAML spec
   and generated headers.

   Implement nfsd_nl_expkey_get_reqs_dumpit() which snapshots pending
   expkey cache requests and sends each entry's seqno, client name,
   fsidtype, and fsid over netlink.

   Implement nfsd_nl_expkey_set_reqs_doit() which parses expkey cache
   responses from userspace (client, fsidtype, fsid, expiry, and path
   or negative flag) and updates the cache via svc_expkey_lookup() /
   svc_expkey_update().

   Wire up the expkey_notify() callback in svc_expkey_cache_template
   so cache misses trigger NFSD_CMD_CACHE_NOTIFY multicast events with
   NFSD_CACHE_TYPE_EXPKEY.

   Signed-off-by: Jeff Layton <jlayton@kernel.org>
   Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

--=20
paul-moore.com

