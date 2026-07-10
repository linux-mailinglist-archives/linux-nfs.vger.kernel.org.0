Return-Path: <linux-nfs+bounces-23248-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HOQ7BzxwUWrAEwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23248-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jul 2026 00:20:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9024473F7B1
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jul 2026 00:20:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=boTbH5M0;
	dmarc=pass (policy=none) header.from=paul-moore.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23248-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23248-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60D573004C59
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180B94279F3;
	Fri, 10 Jul 2026 22:20:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE723DCD9D
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2026 22:20:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722035; cv=pass; b=SYGXt2tsUsVMKBWDaMS58tVWU/SYYw1PyiKUFC96pvPcEr8Xro+PqfnHw2RCoJDzppBJuaQ9jxQvxqBrrPKBn4WIj9bJPXi5PwBEtKba8Eya430v+PVmXON9ho36HrLyVeGL4oRyraZPu0ctmIxF1KGusrb/ESVCTP2BCl3Jld0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722035; c=relaxed/simple;
	bh=peTbIugSesoabUgtl5x+W6yJhd+pDYMV6JxBWWQFiRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gT4sL6k4mz4gOv8mBmj8bcn17/cZZbKhpbu9qqh2vbUc5XfUrgFSQjiPjQtyFQUqhANur9u16vhcf0oNcMSgn6grgm068ySqg3tZhFtwV3YkyUdzUqJl6eFJDBPiwmRMyR4SaxXriCUjBXiiY8rnPRP5jBbdTluFrYsNiPG8Qqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=boTbH5M0; arc=pass smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3825c406ffeso1499047a91.0
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2026 15:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783722033; cv=none;
        d=google.com; s=arc-20260327;
        b=ld29fYpBlNCp+ovLQihjGa79na4Xp0+RY42iZ642+pKnbJcDdSNSSvjCcLvYTT5QJ0
         9AgS5sNJsFgNBvEhWzoxhVeUVOc8EB9T5XUdrC72++QktsLP+knmsM9qTezzCv/wSrKA
         H+mUc51dqViqXw3d8Fbcb+8152NDkGGhb8x/fmx/P92ciFH5aZxB990VLYuhEtbXOkbx
         5nYmVhXcYieJ+Ro5YYd4GgpLI6oKE1xvg4/pEglfMm9QzSxfCkMDs3rw+Ik602+U5uA4
         g0ugRz9sppbauyOMYGwB63aDVPVG3k6SBQiJQUqQ4+Q1xVNbo3P8bBoxasF4hFJ8+3X3
         ug/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mgQP7GucKj1zdlUsr5M4QxBEt0QmpTXk7yMhL/6wv5E=;
        fh=Bi5wtadhmhwjzD43bd94iei1L8Xd2C2w5BduCj//Nj8=;
        b=iQ15C553S4Ua9cxucu/0zrv/Btnwya/X7W3Tvdkdrq+MHldzIUtmYKG+Yyyggspj4w
         lAMjBLwVH1rayzEeucA2IGWEmAsSbG1SHq/P9xFbwcIdy2ftx4cRXfFzUKl+0ByUnYxC
         7xXzMPLfatVYGlMQGne6C9e02R9rgrUdyoAT+JjqiFgzeirWbto4MbBOKmfG0zmbgbI3
         mtTAIFgZkyKJQmKE3nC4u3JlgTdJpHC3QtbHhfLmw1Owq2HuP2N+hP2JMBN6GVgBMZQg
         fTNERcbH0YPFVxWLKv907raLvUWQPXuHx4+u1bW+4I80Cnv1M+xFJia45xXgCGmCJz6I
         YdMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783722033; x=1784326833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mgQP7GucKj1zdlUsr5M4QxBEt0QmpTXk7yMhL/6wv5E=;
        b=boTbH5M0wlUnPi2azaCptWWNYorNcdEAkTcIJ6eY6UQJ7uYROqeERMtfVBVEgAlPue
         3vZR7p/ttW5K+QbTwr1OJy0CF+FoGCI+vBxiSWiLyUsPIbaVvC+TuzG2fQuxyKUslxtU
         VvWjZ5PB47L2pGtIhfyQ1gs2VPuzmr4rbN2PuhODiB/Yh4k0kWAZOqShmxcOmslbhuh1
         aEcFJ9ZLC7whyAy2mAIs2CQwcV2GUyGDsBpFKeB4rbc8O83GL4obNeoVF3txczset9Su
         ncknbBnBA6YBrGs3tp4/ilX8MfN8m/QF1PfK4BKyFPzq0PUwiB+vQ2mdQ9lUAoeHeh47
         sTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783722033; x=1784326833;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mgQP7GucKj1zdlUsr5M4QxBEt0QmpTXk7yMhL/6wv5E=;
        b=oP2kDUKXTwTbFz/qxO+zqNfxnV/vynwI72obAwmO+u+UNrQLQ1zibPQNKeTWE5YbTI
         TlVmen7hZ+JPLzezxNhKdYCozMk8dO7QOXrQW3kwMaCHwqH2R9iq9RnKGwNUkk2uZrhk
         DcM+CNSdvuGVdy7JZ+6yphXMTR0LIobPAISIYmxHVccd2j1gwmDlV7O8WADPJ+VFHEFh
         MNqDt1uAiAqIyOn8wvjI0HA1CVYQwlHwpAkn800ST8gd0uWsD77CIIb9MA/9nl4FXve0
         BO4Xxt06XFafrpKVQRMaQPZbv2HPnN2Oe6rJkDS8bdh2hSNRpRlXEGsDS6ENkdq0pJnw
         h2Og==
X-Forwarded-Encrypted: i=1; AHgh+Rre9lwvtOjEooWCFMKFJWHs6ZNJPRXBCAfDhPw6l/zaSjY1lTS0h9MLX9gskbMeRtwwFDVMEBpEz7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyugSWD2z5DPX+2+H8WnqLm2QTHWwXkI6zYcFyH0iHsej4Pxqmg
	Vy2lreMqDLE8UGyZNxKeLfeuu7Z424RuZSesxzlt/AwNueLwbCRUDW7aSVtAZhmbN4EJZu+23uU
	fDihHH3l7NkiUSsUTmDBYdGqX25uEE/LJeG9T8MlwdfudCw2h8DZTFOgo
X-Gm-Gg: AfdE7clBbkRglaU4UIpNH//m5yRlfFxin1z8WH02+W6GwPLNHdsMNQ26g9q9A8LCdDo
	jxDmAiZrP+jQjI072TfXZw2167GYqm6fbWr2EqtI/pLQzQAUlekR/E7bVR5nfP0Tsf7elqja431
	rZlKiekAlT4nWjv/h4qw5795Dq+3gYg7/LtWilVyexn/L3avhvaVXPqnNGpQJcqdAk4dm6hPaXK
	vVVHnYD9FxThR4xfS0IWd9Z9P9OXqw0SloxzprkFS+lxFHyHKG+m4n6Jt6BIpEXiJchOh6d4jRs
	//15L1s=
X-Received: by 2002:a17:90b:3c8a:b0:38d:858c:834d with SMTP id
 98e67ed59e1d1-38dc7605fd3mr697442a91.17.1783722032972; Fri, 10 Jul 2026
 15:20:32 -0700 (PDT)
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
 <CAEjxPJ4+wgUDY3YxajZ=2D3WLzgat_Mqvr05VtJ4KrXW7_kuXA@mail.gmail.com>
 <CAHC9VhSxpAx+G35fbcMjJ1PfqJxDZYpTEu=qpO+0PQe=nkX5-g@mail.gmail.com> <CAHC9VhRq+Vth-4D4OHFAY_6hXqmj=MgTc_2G=3Ehr6bAQzp26Q@mail.gmail.com>
In-Reply-To: <CAHC9VhRq+Vth-4D4OHFAY_6hXqmj=MgTc_2G=3Ehr6bAQzp26Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Jul 2026 18:20:21 -0400
X-Gm-Features: AVVi8Ccfp85GscEXVGsAcj5RDtBZU4z6Sb8dTlrFZvfRA_U_suUSeMN4GXru7ag
Message-ID: <CAHC9VhQy4LOgQg0mk+s5sjHOzMe1sxPUgJ2W7vRT8ms4znZp+Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23248-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oracle.com:email,paul-moore.com:from_mime,paul-moore.com:email,paul-moore.com:url,paul-moore.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9024473F7B1

On Fri, Jul 10, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Jul 10, 2026 at 5:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Jul 9, 2026 at 8:33=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Wed, Jul 8, 2026 at 4:11=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Wed, Jul 8, 2026 at 2:54=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > On Tue, Jul 7, 2026 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moor=
e.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 7, 2026 at 3:12=E2=80=AFPM Anna Schumaker <anna@ker=
nel.org> wrote:
> > > > > > > On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> > > > > > > > On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> > > > > > > > <achillesgaikwad@gmail.com> wrote:
> > > > > > > >>
> > > > > > > >> A call to listxattr() with a buffer size of 0 returns the =
actual
> > > > > > > >> size of the buffer needed for a subsequent call. On an NFS=
v4.2
> > > > > > > >> mount this triggers the following oops:
> > > > > > > >>
> > > > > > > >>   [  399.768687] BUG: kernel NULL pointer dereference, add=
ress: 0000000000000000
> > > > > > > >>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
> > > > > > > >>   [  399.768722] Call Trace:
> > > > > > > >>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
> > > > > > > >>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
> > > > > > > >>   [  399.768731]  nfs4_listxattr+0x21f/0x250
> > > > > > > >>   [  399.768733]  vfs_listxattr+0x55/0xa0
> > > > > > > >>   [  399.768736]  listxattr+0x23/0x160
> > > > > > > >>   [  399.768737]  path_listxattrat+0xba/0x1e0
> > > > > > > >>   [  399.768739]  do_syscall_64+0xe2/0x680
> > > > > > > >>
> > > > > > > >> security_inode_listsecurity() (via the xattr_list_one() he=
lper) now
> > > > > > > >> decrements the remaining size even when the buffer pointer=
 is NULL, so
> > > > > > > >> in the size-query case, 'left' underflows to a huge size_t=
 value. As a
> > > > > > > >> result, nfs4_listxattr_nfs4_user() treats the NULL buffer =
as a real one,
> > > > > > > >> leading to a NULL pointer dereference in _copy_from_pages(=
).
> > > > > > > >>
> > > > > > > >> security_inode_listsecurity() does not return the number o=
f bytes
> > > > > > > >> it added to the list, so the code derived it as
> > > > > > > >> 'size - error - left'. That is also wrong in the size-quer=
y case:
> > > > > > > >> the generic_listxattr() contribution is only subtracted fr=
om 'left'
> > > > > > > >> when a buffer is present. Thus, the query result comes up =
short by
> > > > > > > >> exactly that contribution (e.g., "system.nfs4_acl" on a mo=
unt with
> > > > > > > >> ACL support), and a caller that allocates the returned siz=
e gets
> > > > > > > >> -ERANGE on the subsequent call.
> > > > > > > >>
> > > > > > > >> Declare 'left' as ssize_t, use a scratch copy to measure s=
ecurity
> > > > > > > >> hook consumption, and only decrement 'left' if a buffer is=
 present.
> > > > > > > >>
> > > > > > > >> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security=
_inode_listsecurity() interface")
> > > > > > > >> Suggested-by: Paul Moore <paul@paul-moore.com>
> > > > > > > >> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com=
>
> > > > > > > >> ---
> > > > > > > >> Changes in v2:
> > > > > > > >>  - Use a scratch variable to track security label size dir=
ectly,
> > > > > > > >>    replacing the old formula that undercounted the size-qu=
ery case.
> > > > > > > >>  - Drop the now-unneeded NULL-buffer special case for
> > > > > > > >>    nfs4_listxattr_nfs4_user().
> > > > > > > >>  - Retitled from "fix nfs4_listxattr NULL pointer derefere=
nce"
> > > > > > > >>    (the same accounting bug caused both the oops and the u=
ndercount).
> > > > > > > >> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-=
1-achillesgaikwad@gmail.com/
> > > > > > > >>  fs/nfs/nfs4proc.c | 10 +++++++---
> > > > > > > >>  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > > > > >
> > > > > > > > [CC'd the LSM and SELinux lists for visibility]
> > > > > > > >
> > > > > > > > Unfortunately my testing was unsuccessful due to an NFS pro=
blem that
> > > > > > > > started with the v7.2 merge window that I haven't had the t=
ime to
> > > > > > > > bisect yet.  Assuming the NFS folks are okay with this chan=
ge, I
> > > > > > > > figure they will want to send it up to Linus via their tree=
, if not
> > > > > > > > let me know and I can send this up via the LSM tree.
> > > > > > >
> > > > > > > Yeah, we'll send it through the NFS tree.
> > > > > >
> > > > > > Thanks Anna.
> > > > > >
> > > > > > > I'll be curious to hear
> > > > > > > what problem you're hitting, and what patch is the culprit on=
ce you
> > > > > > > do that bisect!
> > > > > >
> > > > > > Yes, me too :)
> > > > > >
> > > > > > I'm still working through a review backlog so it might be a bit=
 before
> > > > > > I have a chance, but in case anyone wants to test it out, it's =
easily
> > > > > > reproduced using the selinux-testsuite and the NFS tests:
> > > > > >
> > > > > > https://github.com/SELinuxProject/selinux-testsuite#nfs
> > > > >
> > > > > They seem to pass for me with and without the patch (they don't
> > > > > exercise listxattr AFAIK).
> > > > > This was on the current selinux/dev branch, v7.2-rc1 based.
> > > >
> > > > They work for me on vanilla v7.1 and fail somewhere before vanilla
> > > > v7.2-rc1 (still bisecting).
> > > >
> > > > I wonder if there is an interaction problem with a recent userspace
> > > > update.  What distro/userspace are you running for your tests?  I'm
> > > > doing my testing on a relatively recent Rawhide.
> > >
> > > I was on F44, so yes, it could be a difference in e.g. coreutils or
> > > other userspace on rawhide that is tickling this particular bug.
> >
> > I haven't had a chance to look into this yet, but the git bisect just
> > produced the commit below as the offending commit:
> >
> >    commit 01c2305795a3b6b164df48e72b12022a68fd60c1
> >    Author: Jeff Layton <jlayton@kernel.org>
> >    Date:   Wed Mar 25 10:40:32 2026 -0400
>
> Ooops, nevermind, scratch that - I still have one more kernel to test.

... and scratch that, the offending commit was that one.

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

