Return-Path: <linux-nfs+bounces-23153-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8UizJEFbTWpmywEAu9opvQ
	(envelope-from <linux-nfs+bounces-23153-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 22:02:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 055E571F768
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 22:02:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=Rzy56A06;
	dmarc=pass (policy=none) header.from=paul-moore.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23153-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23153-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06A023011862
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 20:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD163D3D07;
	Tue,  7 Jul 2026 20:01:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD833D090E
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 20:01:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783454517; cv=pass; b=OCzLrwmR5NFMlDMdVi99OTyyusU47qgiCn5kqkZ32OofZpGIkKmkfiBD96hkq7usHsum0x7vvFP5tIxjVZdi2gKgKyBIjLoKis8zJW0goo0Fg1RDTfgyWKMIT/6FBZ8nczuiKKZTqbeu+HPUhyFYkzOSgD9WvYjzSp+e+p1X9sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783454517; c=relaxed/simple;
	bh=CQw7pbBPSsQXtU1Uj2PUzAdATT3DC/fTZSmkVK5/zlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOxuH+vRO6tijZsfQrVi+AX1n4uTRDItA390jJ1W21/FCz4CC5F8YzJCNmXMZsIA7cHXUUh6Wj4IxVXtFtt9Nbx393GSAfiT9e92EQ92VI7Tco56+MTyG2Mp83y0qKDH+Os2gw2hey5Qn3mOqvIVVhQG1xz3GB1BIfOth8S9VpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rzy56A06; arc=pass smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1479694a91.2
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jul 2026 13:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783454515; cv=none;
        d=google.com; s=arc-20260327;
        b=FMiwd9oZnY58qOnvdjoGvkcb6RBwE6Llub2jq5leaeGbQB9thEEsA7XZhG3l7wtgKP
         Q0VV4bXsrHFeXFU89g68psTDgYSkR+bgN+7G38TmGoNdl8oGdu8pNY0+hCM6UbBOllkf
         pWmfzBYQAcSvOgGhmfGEPdjL/B//qccSqj2kwLTQHO/WaaXBl40W3MLQ/aZDDJ3mEQBZ
         sP/Y/znyyc+XU1Il5LnBhqCQE4j1VlwaLq50TobUgAGVR+bB4J8srRP2QAH/KFCVnK+g
         1srmntTJGgfjHTq82pdwvQ1jOTw+Iirm1/1xV0iUFYvu4ghFyOnopNggpsQ2IRoC1PPG
         fpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKHaKGkq7zit82xHzq3cQSvjgYMyfS0+fVrI7chNkuQ=;
        fh=1ZtQAyJIdhHhgTq/IzSLPuZCq3lF0MbJ/jFfQvhSZiI=;
        b=T7yLnnw1AFN5s1OUsxzvswFNTag8r/kz+AxDmTT9uDJK3yLjYTUy7t0URu5DgJ7Xzp
         4LuylWfb37o/myUTWGNszielbPhmtAovBQIlQH24RZGz1UPZqctVwYssXDQr79KS932k
         UVCkmU2tvk6YwNf9CSYwA/D86NUlQ+PRavhJl1cB2/+xCt5T6Qz1BDxd5PIz88VqcWMX
         fJPw4D2Gp9TBlO2+pXCYOF84t8PVCDMyE6hQUkMCETYu7A/ebCOmy9S9RYY1rbpJwiXg
         XQCzGI5wehrBs8T0MHd2SH2eEObEpHNQQVIi7RRB5mZxnJDS6notcGvgKjwEW3AOglMI
         45uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783454515; x=1784059315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKHaKGkq7zit82xHzq3cQSvjgYMyfS0+fVrI7chNkuQ=;
        b=Rzy56A06EuG/557lKXbZj5FzisJs/VspFSC0lA9XwefOL1CiMcLL092fxKJxi8vel5
         q6uFqfoyiy9cS5EmZlVctMrdZt/IlrZKXzLTm6hGDQgfuG01NEI5CPqRE/mjiCEyKHOY
         lyCEYFc1GVDoVD7BNn9nGYhmmIVkW65A5E8e0uXTcCm911FASOXz1nupXw4CHxUkECDS
         xAsQ2XLCzsVeWjzEGnVWn/iiTfMSJr5HygLH8e7S4P3Ty3BxyZJH3qwih3y/ZBLuViRY
         BQmqmu0IlIp6+o0ngXd1D1sL30x9CRmVA88OZSK9UnudGv5km6dBExhAS1GurTUlZMNt
         RqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783454515; x=1784059315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKHaKGkq7zit82xHzq3cQSvjgYMyfS0+fVrI7chNkuQ=;
        b=i+sxvOpbNgeOVunLgeSRAq7D9iDhEtY0/lzcFBnqDHvDx/QhOpchsOH73ml1hDKok2
         mCJazS3haRs3JVjgSt+Yah2tveI2wUKMV1dB/ClhaBAoTukcY4Y9XDTXI+WpSjIg37KG
         DyrnPXIXDT87kyddr4fTruKI2IEhjP7ubc3IM09wczaTGIAygqxHZqdFtYRDUZDBHYzy
         GxDY9HLdH0U6oP3H3r7gMRlg1HcmAFJf4m6sHTFpD2rNjvm7BEFBsg3ihv47b+aeFFw3
         h6XA4zqLyUTSbxrL5C1Js+hXD6xCkzTWaPl1LFdSGtX0VF+lRFubQYgzYxmUyIOh/XWb
         wyUQ==
X-Forwarded-Encrypted: i=1; AHgh+RrdHMfip7GujBK/8IgG5yzFSI31Cq/DZw8GrHqUbhYxg9u+hDJcJAxZIxP2beMU/45qL33EQKHhMZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx72dNgrzs2//TLYtGBneysm3UlXDSRinlqT3IVnGSwxAtqjHF
	rxdl1dovzmVeUx9FN42IHjrVjOLENLxoiaOmn8Rnc04D4c48NVoHWYcBIMoQfWh3GFYBr9uO5+F
	hiTzNIcEjcE5ucaWgLadHdoHIab1DUTc23vPl9PYy
X-Gm-Gg: AfdE7clh46b/CXpPv6U5tcLPooQt8ZudgV+zBEjdgyWSwrcDU8/NtW40WAlejpR+m6r
	gzIBQZXMpT7V/L2UVZq9Dm66nL5rq1tGslsv6ejL60aWbknnv9QetBrDlxAw59qxFkUwHWZfTgj
	sjuFPDf7H13bRzr0Cx41igJobPGbV5oLYl/K75pSLVBd7i+XUj3ZFN4/IFoz2XB5hCT28x1UB45
	FMVXZ2ocD8WGaE/QGNR4ynUDcF0IxC4MYOL4IUcEVSaiMTu1k1oFEakPgwMLDkgzjMNpzfP
X-Received: by 2002:a17:90a:b108:b0:381:5ede:1296 with SMTP id
 98e67ed59e1d1-3875547805amr4916450a91.11.1783454514983; Tue, 07 Jul 2026
 13:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102759.9626-1-achillesgaikwad@gmail.com>
 <20260707152305.15324-1-achillesgaikwad@gmail.com> <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
 <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com>
In-Reply-To: <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Jul 2026 16:01:42 -0400
X-Gm-Features: AVVi8Cc7whlyPeGuIcUVaMUhLCElVCGHeTQu6aN6Xlm0ZbpD5vFbi_OphdfvdLo
Message-ID: <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: Anna Schumaker <anna@kernel.org>
Cc: Achilles Gaikwad <achillesgaikwad@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	stephen.smalley.work@gmail.com, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-23153-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:achillesgaikwad@gmail.com,m:trondmy@kernel.org,m:stephen.smalley.work@gmail.com,m:linux-nfs@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 055E571F768

On Tue, Jul 7, 2026 at 3:12=E2=80=AFPM Anna Schumaker <anna@kernel.org> wro=
te:
> On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> > On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> > <achillesgaikwad@gmail.com> wrote:
> >>
> >> A call to listxattr() with a buffer size of 0 returns the actual
> >> size of the buffer needed for a subsequent call. On an NFSv4.2
> >> mount this triggers the following oops:
> >>
> >>   [  399.768687] BUG: kernel NULL pointer dereference, address: 000000=
0000000000
> >>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
> >>   [  399.768722] Call Trace:
> >>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
> >>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
> >>   [  399.768731]  nfs4_listxattr+0x21f/0x250
> >>   [  399.768733]  vfs_listxattr+0x55/0xa0
> >>   [  399.768736]  listxattr+0x23/0x160
> >>   [  399.768737]  path_listxattrat+0xba/0x1e0
> >>   [  399.768739]  do_syscall_64+0xe2/0x680
> >>
> >> security_inode_listsecurity() (via the xattr_list_one() helper) now
> >> decrements the remaining size even when the buffer pointer is NULL, so
> >> in the size-query case, 'left' underflows to a huge size_t value. As a
> >> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a real on=
e,
> >> leading to a NULL pointer dereference in _copy_from_pages().
> >>
> >> security_inode_listsecurity() does not return the number of bytes
> >> it added to the list, so the code derived it as
> >> 'size - error - left'. That is also wrong in the size-query case:
> >> the generic_listxattr() contribution is only subtracted from 'left'
> >> when a buffer is present. Thus, the query result comes up short by
> >> exactly that contribution (e.g., "system.nfs4_acl" on a mount with
> >> ACL support), and a caller that allocates the returned size gets
> >> -ERANGE on the subsequent call.
> >>
> >> Declare 'left' as ssize_t, use a scratch copy to measure security
> >> hook consumption, and only decrement 'left' if a buffer is present.
> >>
> >> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode_lists=
ecurity() interface")
> >> Suggested-by: Paul Moore <paul@paul-moore.com>
> >> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> >> ---
> >> Changes in v2:
> >>  - Use a scratch variable to track security label size directly,
> >>    replacing the old formula that undercounted the size-query case.
> >>  - Drop the now-unneeded NULL-buffer special case for
> >>    nfs4_listxattr_nfs4_user().
> >>  - Retitled from "fix nfs4_listxattr NULL pointer dereference"
> >>    (the same accounting bug caused both the oops and the undercount).
> >> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-achillesga=
ikwad@gmail.com/
> >>  fs/nfs/nfs4proc.c | 10 +++++++---
> >>  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > [CC'd the LSM and SELinux lists for visibility]
> >
> > Unfortunately my testing was unsuccessful due to an NFS problem that
> > started with the v7.2 merge window that I haven't had the time to
> > bisect yet.  Assuming the NFS folks are okay with this change, I
> > figure they will want to send it up to Linus via their tree, if not
> > let me know and I can send this up via the LSM tree.
>
> Yeah, we'll send it through the NFS tree.

Thanks Anna.

> I'll be curious to hear
> what problem you're hitting, and what patch is the culprit once you
> do that bisect!

Yes, me too :)

I'm still working through a review backlog so it might be a bit before
I have a chance, but in case anyone wants to test it out, it's easily
reproduced using the selinux-testsuite and the NFS tests:

https://github.com/SELinuxProject/selinux-testsuite#nfs

--=20
paul-moore.com

