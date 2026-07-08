Return-Path: <linux-nfs+bounces-23176-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rOOiKw6dTmrIQgIAu9opvQ
	(envelope-from <linux-nfs+bounces-23176-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 20:55:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22365729BD7
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 20:55:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Sa8s5DZH;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23176-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23176-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B8DB300D9D9
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2026 18:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494373C3453;
	Wed,  8 Jul 2026 18:54:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59E23264D5
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2026 18:54:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536892; cv=pass; b=utUbjXDr2F12WODUWHeJTpZtN0nv+/zaMzwJtDhwX1EucxqlvpCM9VtEY61b47+YxXZZ9+QCZ5USoiHxT9MrTQlG/4GSkA8mgj+SOgKwo24Hyp5DvOedUyjPMBmdPgLA+qGJWVhrRAksV5I7jPP2wVDS57ABO7bxTFse+rjEQZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536892; c=relaxed/simple;
	bh=HIp2gn9sh7sB0Bb61etjWKhYAyLkUkA04rRyBq8mqLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrM/Y0soNdsZ9nejobqdg9zbgsVqHTNjrO7oIvc61L/PuwGfN21U28H6sNP3AJDGODNOWXmilIsbGe+XxyNvhwmzu2MZ1FfGXzbablL4Eys/y5dDlDiKiKuoy/+eicL4m6rEsFj9Eh8b69we0gvwXaF43Vyjla0LFf0jFU6Exlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa8s5DZH; arc=pass smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caed617615so10808925ad.3
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2026 11:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783536890; cv=none;
        d=google.com; s=arc-20260327;
        b=MEQjsZM3tNszTNnhcTQoE8tMTM6WpfzWEfxXiI3zXEnkmtr7H7S1WzdjjoJh1TeFj6
         l0aOhX+bLrfZMbeF2MjzBQIvVEwBAeAXKIojrahFr9qpN0BDy4XtRChBFvLZFS6aCTZP
         CWT6Vz4CcTr8GDKJH8AQwIzvSAIEzNKDU50dmEirFVhWq+f7Eu9MkXEYJcKsoFSV/SZh
         y0MmJwRLgrVoanShMRxuntonvFvGQj5aIZ1sWeOh5L7LoJICsfrT/yjKL24qljd9v9dD
         17kbVybwSpvfB42EN/zvzSNHHRep9VyodnvG/U7cmSluWxX9pXhFAR8nYBIT7tijVMm3
         Tbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7lKMvsHAdlcJL6bttrObkjfzU3lsz5RawqcSntxvxnU=;
        fh=ycpfPNoM+1vkL2XqCCxP+tiUBx9roIoMQmPRpsptprY=;
        b=VM44UlBCSazb1x++nuq5k8UrmInTbQjKw55p8b2qz7MQFbtlSw0++BeamyLJ4eGQb/
         DPEcaIMAak/BzcLvONmEKBi+G4P+ZreYrdRQTEGLfASUBUA9yA5xwrGFQ1i1yo+2lnIw
         TiJfoVk8lRDqDbVHuGO1rU31FTkrYK3u2el7VHDAuzMGA2+XaoM6ECL2al2B5eCDssT9
         r7eNXMSXl26F05E0KHwMyr7r8Eio0Lb7ndoksm7xFuv0pRum7bYmLkREyJNvlUQWT+TF
         887nBgNOD/223Y5CluoaMi6F+SX2apFJ9rURhkWiffUdw+AlXYygkcRVCy5rxZ5a956m
         7eug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783536890; x=1784141690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7lKMvsHAdlcJL6bttrObkjfzU3lsz5RawqcSntxvxnU=;
        b=Sa8s5DZH6SObVhV9JF7GuREEHXd5fbZYLVFJ8WqJnwmPCZ9+YplxU1p2KNE9//wFgp
         LibaQT/mjE67u4DIEVIBNosAXw4A67HSDgtsI7Xwh1+D7x2y6UBL5dcLTIfsGEq1g2WK
         5pwLtEU/xFAgaRLhkD9fLns2J37SYjQndn5RzgoUp3WjNwzYFIGjrj8aveJePf2ECTnl
         FimhM/vM4RvoqmVaGFjLAciFC/HkRkRjQtxbZ9CES+n0CeGcZjshH+FBu2gGwHAf1RgG
         6AOrrF0wYYSYqkPQd0TlvxxbBONV2JW02Hzbyec95kRYulxl1mvRV2bH0jevmZHsT+y7
         vMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783536890; x=1784141690;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7lKMvsHAdlcJL6bttrObkjfzU3lsz5RawqcSntxvxnU=;
        b=HN6+fK5h3dJltcezWpcywx/Kz1YQtJ1D1cep/CoCiQojjvN1oStOijG5rXlvhKO7u4
         MRFQWHYsp/0AV1Gx56i89UyQ2Y0FwZEXsdcfUf0EjJmcnxN9z7S8h0/mUaoi1tNzNorW
         nCVQAlkg8geV/WUYTXRDanh/baU1dz5NAwoLpSpV/oeO+G9HasR+GnK1QrHPm/MCg2pQ
         gjoEtSuFiXzP7Bh3ybV7M04gE7IvXEi/lvePBCoAYpgIcash2thNc8gJ07KAXRLnCyw4
         HxwPK5n6jeRzs+dunohoHZAlWWVPq6BNnFo7XH+XfxU2fkICors8p6243GdA2MiHxzXW
         eWdg==
X-Forwarded-Encrypted: i=1; AHgh+RopLIlN2A++kE7MzCdOy1mXl6W4+MXiRhZGvOx+p8I75krEQaV0pFYFWptrwWislNQPLtRvTjJNYHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZ4NtyeSTcmsbtLoUQD3lyG70Hbo6+uhOc6RmrFR0hJHU98g0
	gd44SrXP6FIsfZCIxBBPoW6D3wx3K/neg7dQe83ef7pVu9yZm5H/UinHXfjNbCUKByTmevkkuc0
	cODIOHpH2vPeYtsb28EbTBSIbbWxpY9w=
X-Gm-Gg: AfdE7ckBAitWQ/4bFmdLDCAFz2sccQELK/tmD1lRsCgM+GOXoVMN9hi9YYaA9+NRIAu
	L1nZ3DgTcCK4bhF7SE1oxaHgcVRzHrNcCHmKTTz3+k1lGAdClEvsZSZU/b90OJI2tqm4BFr9w1C
	VcqT0FRzXuV+OUO7uDuNi1yJiQigUQd6P/KikrarhQUSU9BKLii5sR1QCuQyITmDnYa3F3EZJ1w
	3t7Z2VGKPYFFMF5c9BFw6Joh31lHkv0d0zLBCs/deq4fnpjMppcHmi5ILBohgPyKmEh3Dh6
X-Received: by 2002:a05:6a20:2591:b0:3c0:9c19:6598 with SMTP id
 adf61e73a8af0-3c0bd1b0c2emr4467346637.64.1783536890086; Wed, 08 Jul 2026
 11:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102759.9626-1-achillesgaikwad@gmail.com>
 <20260707152305.15324-1-achillesgaikwad@gmail.com> <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
 <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com> <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
In-Reply-To: <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 8 Jul 2026 14:54:39 -0400
X-Gm-Features: AVVi8CeDAYkaxOnVyk4GN4AJWFNgHCAUe8gsZ6CyBP4XvVdF15boW7cTak8LeSY
Message-ID: <CAEjxPJ7dttPDxQDa_xXFd1H-QT_vkUwjtnH+=3cmG5dhSiaAXw@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-23176-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:anna@kernel.org,m:achillesgaikwad@gmail.com,m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[stephensmalleywork@gmail.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephensmalleywork@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22365729BD7

On Tue, Jul 7, 2026 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Jul 7, 2026 at 3:12=E2=80=AFPM Anna Schumaker <anna@kernel.org> w=
rote:
> > On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> > > On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> > > <achillesgaikwad@gmail.com> wrote:
> > >>
> > >> A call to listxattr() with a buffer size of 0 returns the actual
> > >> size of the buffer needed for a subsequent call. On an NFSv4.2
> > >> mount this triggers the following oops:
> > >>
> > >>   [  399.768687] BUG: kernel NULL pointer dereference, address: 0000=
000000000000
> > >>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
> > >>   [  399.768722] Call Trace:
> > >>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
> > >>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
> > >>   [  399.768731]  nfs4_listxattr+0x21f/0x250
> > >>   [  399.768733]  vfs_listxattr+0x55/0xa0
> > >>   [  399.768736]  listxattr+0x23/0x160
> > >>   [  399.768737]  path_listxattrat+0xba/0x1e0
> > >>   [  399.768739]  do_syscall_64+0xe2/0x680
> > >>
> > >> security_inode_listsecurity() (via the xattr_list_one() helper) now
> > >> decrements the remaining size even when the buffer pointer is NULL, =
so
> > >> in the size-query case, 'left' underflows to a huge size_t value. As=
 a
> > >> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a real =
one,
> > >> leading to a NULL pointer dereference in _copy_from_pages().
> > >>
> > >> security_inode_listsecurity() does not return the number of bytes
> > >> it added to the list, so the code derived it as
> > >> 'size - error - left'. That is also wrong in the size-query case:
> > >> the generic_listxattr() contribution is only subtracted from 'left'
> > >> when a buffer is present. Thus, the query result comes up short by
> > >> exactly that contribution (e.g., "system.nfs4_acl" on a mount with
> > >> ACL support), and a caller that allocates the returned size gets
> > >> -ERANGE on the subsequent call.
> > >>
> > >> Declare 'left' as ssize_t, use a scratch copy to measure security
> > >> hook consumption, and only decrement 'left' if a buffer is present.
> > >>
> > >> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode_lis=
tsecurity() interface")
> > >> Suggested-by: Paul Moore <paul@paul-moore.com>
> > >> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> > >> ---
> > >> Changes in v2:
> > >>  - Use a scratch variable to track security label size directly,
> > >>    replacing the old formula that undercounted the size-query case.
> > >>  - Drop the now-unneeded NULL-buffer special case for
> > >>    nfs4_listxattr_nfs4_user().
> > >>  - Retitled from "fix nfs4_listxattr NULL pointer dereference"
> > >>    (the same accounting bug caused both the oops and the undercount)=
.
> > >> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-achilles=
gaikwad@gmail.com/
> > >>  fs/nfs/nfs4proc.c | 10 +++++++---
> > >>  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > [CC'd the LSM and SELinux lists for visibility]
> > >
> > > Unfortunately my testing was unsuccessful due to an NFS problem that
> > > started with the v7.2 merge window that I haven't had the time to
> > > bisect yet.  Assuming the NFS folks are okay with this change, I
> > > figure they will want to send it up to Linus via their tree, if not
> > > let me know and I can send this up via the LSM tree.
> >
> > Yeah, we'll send it through the NFS tree.
>
> Thanks Anna.
>
> > I'll be curious to hear
> > what problem you're hitting, and what patch is the culprit once you
> > do that bisect!
>
> Yes, me too :)
>
> I'm still working through a review backlog so it might be a bit before
> I have a chance, but in case anyone wants to test it out, it's easily
> reproduced using the selinux-testsuite and the NFS tests:
>
> https://github.com/SELinuxProject/selinux-testsuite#nfs

They seem to pass for me with and without the patch (they don't
exercise listxattr AFAIK).
This was on the current selinux/dev branch, v7.2-rc1 based.

