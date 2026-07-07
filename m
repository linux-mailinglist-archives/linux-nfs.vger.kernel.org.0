Return-Path: <linux-nfs+bounces-23141-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6exoGf9KTWogxwEAu9opvQ
	(envelope-from <linux-nfs+bounces-23141-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 20:52:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F3171EC1B
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 20:52:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=SbMX+V34;
	dmarc=pass (policy=none) header.from=paul-moore.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23141-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23141-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A7DB301BA74
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 18:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F257330676E;
	Tue,  7 Jul 2026 18:48:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B7F2F6577
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 18:48:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450108; cv=pass; b=tPq29ok8iLgQ94iMsQdUqBzWQ8d4f5OkSzOdVnaEeUobYLh9g9U41+8d7nqFUyDA62Jgx/p9vZZ1mi/yx7XAUByDHKZTZJK0SQFZb1WkPPoVmWssR87gRTsMKoEq8Y3C1a8il7X4i4cWj4IYzjymqs+wtVD4I/LLQOycEpGMtkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450108; c=relaxed/simple;
	bh=rtUYFok+ac4p2ylgzUh1Lf6iBK/D4Y6w6h4iMqSOFVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ls8uCzeIk7dutnhRx4hhFt8L1/SKn7TK5Q+0hvXdVjteckvGXft0ayfrTm2hwMyg+YY0YKYdwOJLs3GlWLHxFH5vp7qcKtx85RIYXuY10v1780+oRZQRw7Zobc7z1X3kT7IEG6yEh8IrYmtFQW4DUBqBkXSj33PfEE43TUZ31GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SbMX+V34; arc=pass smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8482074a000so1854326b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jul 2026 11:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783450106; cv=none;
        d=google.com; s=arc-20260327;
        b=dnPu6dTucZLv6gHhJMs19n7MA11/9zjEEF3rF/6/EBrE1Fvmg/I01iTPstaqtViLCf
         KwzJ/6FvGZ9262quI5g7mnc+jsprfV7jcOtd4gUnxDwxA5OBJSFClMRcHrbg+SFdxAVH
         hjfYqDmQNy0wkgPeiuWHzpsh6rKPW6t+/8hLY9ckX9wpEoBHVIOG7ndUUYbAeQtVYWqG
         gipF2w69CnueVjFpWHLWyowUDnpF/3/XjQ4zWz9yVI83+R/mrG+/3KQb3cjEfOp2hMqg
         gZXkXwKSNiyF5s0ek1S/D+ZdmQ+9HtujuVFy8+Fz37ksPkEinjdGjPB+najlXXI3C5X4
         U+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8I9REEDFjv8luH00AFfyJaYS+M1fVOulSubRZfE4umw=;
        fh=JBlC7vWYlwmf2Ys+TWLYnKfkWXBLwndcDm5W2fzvXKM=;
        b=m3lQeHIwEhi+jZ3YkFvTmmodNZAUEFBfy/V/k6YVl5BT+JeGP4NGDilHk4KEry/3ab
         fP0GdNjwffdC6M8julPVbiCpVAg/YwhOggz3EXXU7aGWtuErxaG11o+t8z7T0Gp1A3GV
         wKpnh7V4BfliNhFbRfCyuMXajjREyIyNuY18fjvceUFoMjqc583jLSr9kT1ot0Q+EhOK
         XqEWibooQMWB4lN1AW9m6eF2EOyZV9pF1om+p2abLbWwhHGNRUAUtL+O6rZxHEdVqiOH
         l3qkfa/JYb9dNj/iGZ2WpFVrdGzsTwNMEhGPaiYD/usWSUvMZ8phGcynt4X0mXtrBMp7
         t3Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783450106; x=1784054906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8I9REEDFjv8luH00AFfyJaYS+M1fVOulSubRZfE4umw=;
        b=SbMX+V34pw/hGfQ0jnLozavu15GqajgcD97kN5tE//24eM2oDng7uW+jrveBE2sbxK
         tZTPV92Y4ojWtDbDyvUZ9WkdvI83qrY77fq75dG38w28Hsydr5dE4pFB/K/eGOrrXGOZ
         cCxyQO797x+cLoZVx6j94OupGttLEmYFoGVAmmWGmlUIlPGeNCCOg5u6TA4/jNZNkp5j
         QYQteDNGQxsejvwn9uedvY9deXsOqzkB5halz9dN0YYkB//9iBbSoiJGQYsTMCHoZqh/
         rynsuxKD+dwhrX6qImgPC57EIo52r5OPYDMAcAPlNY2TI9KYlL5h1d0JAsSHe+3+xbyv
         xk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783450106; x=1784054906;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8I9REEDFjv8luH00AFfyJaYS+M1fVOulSubRZfE4umw=;
        b=k7qIvkbRkPamgMAKDW6PMmpOl9Sf+T5nUshRYL/unV7tTHyJbwWCnl6RQfrbH41yN9
         4AuRQICQGWZIko90+rBq3KRfiAzPVw+2KWi4EIf6Ucu96S9cKxdrTZLRnWXSrZS+MeA2
         kMp3JK6aUIuVBhnauYv0RMR1/O9q+q7ztUMNCXNFOchJqXfewwxQj2w+R/Keh01L9dOe
         rAlTwD2N6tNxnGqOrToLtBpZaRfohwAKJQx1HyYCy8nh1QjOAwn19dNcQyKAg3C9vmb3
         lRW0qeQSwtFrIxqFK2HctSxphdScfdlv+h4tn0oB3TilIOOOlpuJBUMMUqwOWB/OWVm2
         7ZSA==
X-Forwarded-Encrypted: i=1; AHgh+RpToXTYvu3S9cXgIdr5AadMYf051o0cqFnmkFDA3LXsrZjwX27xXnEOZ8HVT3Ob01jYTG7GEuyLHFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu+j5qd6k3bUYrAQgZzWp5drjs+n8Y71BWwgxnHrefwgJ/3iHc
	5q0bYqEys8PZfgbsx2vkqCSrWjXBGZ03kH6AzSB/UrbC5ur4Nh5u+wpq0SzkQ7OGGUYRKFItTMu
	u575gO5ZagqFsP9sdoP8g5v/KMTnt9jsuTWTWxptS
X-Gm-Gg: AfdE7cnEnXL5/KpBtbSVgk/it9Jpqm+Ct9iCWW4ICYTgOBY2TGVy2vSULd/OP0nw0Xg
	ZQ2d8UE72ysvd407oStOe6Qlch7/ZvzWd+NF71H9tI09t7FGvqwXdt9spjKJNW+BDQoeZ4dVnYy
	G1WGFbsBJksAiSbKSBALrEmwmu83IK++febUaBJeG2eVBC4ZS5c6V6V3s8OuZkD2BahvLzmPD53
	bszPCu4/C/N/AgM2jsOhPl1QMNgLTGMaC/F+82V0PgiSLpTwijnGz7i2GFoXGTcL6PHcBJ3
X-Received: by 2002:a05:6a00:2e08:b0:845:e04b:565f with SMTP id
 d2e1a72fcca58-84826cc57damr5655333b3a.14.1783450106203; Tue, 07 Jul 2026
 11:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102759.9626-1-achillesgaikwad@gmail.com> <20260707152305.15324-1-achillesgaikwad@gmail.com>
In-Reply-To: <20260707152305.15324-1-achillesgaikwad@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Jul 2026 14:48:12 -0400
X-Gm-Features: AVVi8CeBLkSCcvz0jk-hyXd4ntJNDWvRa9ubZXqmixAE9m7kjk45u_XN0jbOBFs
Message-ID: <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: Achilles Gaikwad <achillesgaikwad@gmail.com>
Cc: trondmy@kernel.org, anna@kernel.org, stephen.smalley.work@gmail.com, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-23141-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:achillesgaikwad@gmail.com,m:trondmy@kernel.org,m:anna@kernel.org,m:stephen.smalley.work@gmail.com,m:linux-nfs@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,paul-moore.com:from_mime,paul-moore.com:email,paul-moore.com:url,paul-moore.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2F3171EC1B

On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
<achillesgaikwad@gmail.com> wrote:
>
> A call to listxattr() with a buffer size of 0 returns the actual
> size of the buffer needed for a subsequent call. On an NFSv4.2
> mount this triggers the following oops:
>
>   [  399.768687] BUG: kernel NULL pointer dereference, address: 000000000=
0000000
>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
>   [  399.768722] Call Trace:
>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
>   [  399.768731]  nfs4_listxattr+0x21f/0x250
>   [  399.768733]  vfs_listxattr+0x55/0xa0
>   [  399.768736]  listxattr+0x23/0x160
>   [  399.768737]  path_listxattrat+0xba/0x1e0
>   [  399.768739]  do_syscall_64+0xe2/0x680
>
> security_inode_listsecurity() (via the xattr_list_one() helper) now
> decrements the remaining size even when the buffer pointer is NULL, so
> in the size-query case, 'left' underflows to a huge size_t value. As a
> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a real one,
> leading to a NULL pointer dereference in _copy_from_pages().
>
> security_inode_listsecurity() does not return the number of bytes
> it added to the list, so the code derived it as
> 'size - error - left'. That is also wrong in the size-query case:
> the generic_listxattr() contribution is only subtracted from 'left'
> when a buffer is present. Thus, the query result comes up short by
> exactly that contribution (e.g., "system.nfs4_acl" on a mount with
> ACL support), and a caller that allocates the returned size gets
> -ERANGE on the subsequent call.
>
> Declare 'left' as ssize_t, use a scratch copy to measure security
> hook consumption, and only decrement 'left' if a buffer is present.
>
> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode_listsecu=
rity() interface")
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> ---
> Changes in v2:
>  - Use a scratch variable to track security label size directly,
>    replacing the old formula that undercounted the size-query case.
>  - Drop the now-unneeded NULL-buffer special case for
>    nfs4_listxattr_nfs4_user().
>  - Retitled from "fix nfs4_listxattr NULL pointer dereference"
>    (the same accounting bug caused both the oops and the undercount).
> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-achillesgaikw=
ad@gmail.com/
>  fs/nfs/nfs4proc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

[CC'd the LSM and SELinux lists for visibility]

Unfortunately my testing was unsuccessful due to an NFS problem that
started with the v7.2 merge window that I haven't had the time to
bisect yet.  Assuming the NFS folks are okay with this change, I
figure they will want to send it up to Linus via their tree, if not
let me know and I can send this up via the LSM tree.

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 1360409d8de9..a3415082d610 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -10585,7 +10585,8 @@ const struct nfs4_minor_version_ops *nfs_v4_minor=
_ops[] =3D {
>  static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t =
size)
>  {
>         ssize_t error, error2, error3;
> -       size_t left =3D size;
> +       ssize_t left =3D size;
> +       ssize_t left2;
>
>         error =3D generic_listxattr(dentry, list, left);
>         if (error < 0)
> @@ -10595,10 +10596,13 @@ static ssize_t nfs4_listxattr(struct dentry *de=
ntry, char *list, size_t size)
>                 left -=3D error;
>         }
>
> -       error2 =3D security_inode_listsecurity(d_inode(dentry), &list, &l=
eft);
> +       left2 =3D left;
> +       error2 =3D security_inode_listsecurity(d_inode(dentry), &list, &l=
eft2);
>         if (error2 < 0)
>                 return error2;
> -       error2 =3D size - error - left;
> +       error2 =3D left - left2;
> +       if (list)
> +               left -=3D error2;
>
>         error3 =3D nfs4_listxattr_nfs4_user(d_inode(dentry), list, left);
>         if (error3 < 0)
>
> base-commit: 6eb8711ece2ce27e52e327a5b7a628ed39b97f45
> --
> 2.55.0

--=20
paul-moore.com

