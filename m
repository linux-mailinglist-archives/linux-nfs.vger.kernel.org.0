Return-Path: <linux-nfs+bounces-23121-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3/ArNUwkTGo3gwEAu9opvQ
	(envelope-from <linux-nfs+bounces-23121-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 23:55:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6836B715DA0
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 23:55:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=ZzwxL3BR;
	dmarc=pass (policy=none) header.from=paul-moore.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23121-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23121-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0355300E038
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 21:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6A3430CC1;
	Mon,  6 Jul 2026 21:55:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65D747D920
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 21:55:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374920; cv=pass; b=lqf/li6zu5aVcDX0bgcB/mSTc51VvJAGOx2cq4AmM1RT1ZDK4yrmK6E0LJAITQK2RscUK0b8tXHwXDcJHFWVzrDme+7nNV3wVcfB5oC/cLg+MvbpF1b3+FOhSpkX41w/2PR5wW/GKLRKYB+fQx69lBt/8egDcH67xJTO3h4GfPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374920; c=relaxed/simple;
	bh=odrO7M8liGijxQUSrY/BCV5Z5RqzJR3cXw7eAtF/4Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2InJ8NQvggn8gkBZFeV9w0czLX83PD+oqG4LKtYa3UrRdakdfAMMQuZwiSPzc8Vk0zIRXP2WPsf5sn6uG7aeCnvu/DJri7jvqXQn/aDnrAe5uXHEcajgUyZJG9C58ANlzmQDQ9cSbX4Tpa9uFHIX438pVgBRrJsvBG97dxPv2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZzwxL3BR; arc=pass smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84347ad88edso4780400b3a.1
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jul 2026 14:55:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783374916; cv=none;
        d=google.com; s=arc-20260327;
        b=g5gFybXfD/Ht9E179ilV6IR2tKBq7fT8FpWAml3hHsoAHZrc2a2cCyimHdL+tdhnLc
         Wu3xVmpRt8e8Hmls7GSGy5Q0X/XIXCN+B4kf/5946i1cQJEpK41XHbTZ+q7aOFgvUX4L
         yR3vNPIhFWqlf0UNkTjsOanaDFb/7mrsOuYEpYUPD1AagPJ7zvHGIZlrG+bUAqnofBdo
         Haj36zWovOeWZUpM54WLTYMGserMVoIA+Opui/O14wwItgMCXrOaPkpWdiTXm47u6SXW
         IGPYr/vjyrshCcBaY+YxRT+a5fNxWvrOSSY6hX2IqIU439D9yHEP7TIkCPpr+QC3+RmS
         xI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OzAtCoECdCJuiF0l9B8iruulf2cJzktwdffOADKIn7k=;
        fh=1uVS9DUJoQ8Q/n8c/7wn+43hzbztw0Y0rEfG4ERgV2A=;
        b=H6Kp4J+SpYDGp5/Jk6C5jXp53GY8ITLSw+d0X7AuwsOEHX25KkZGoXKgluT/SXfLh2
         1Azy0cb1FKkZzMD68b3gzwivUmaxFJLyve/BWGYcMOlgwyidKY5MKTMomudp/zjTeaiz
         +B2U/dZ6yCo16qYG6YMS5U06VQRqjjrStJKs2WswUQb7DBUrrA5DErhO9v2DEPy+e8uj
         /lcGLlF6yrhhfgYOWv86eW4Rttj9hmYYBxDSaXfIoyNmj32YtgBc0VSKPZdIbiqbaWlv
         rnCy7QD5HUP+LP/MwW1i0xu6oB4Ns8prBeG6KBtnFuKn5jOUr+0nzQCYodSNV8oTISvI
         apOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783374916; x=1783979716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OzAtCoECdCJuiF0l9B8iruulf2cJzktwdffOADKIn7k=;
        b=ZzwxL3BRWzD6ucwYZj76EXXh5LTHigudVEmaf8pmh7Mw1hg5UuG3nHSSKzM2M/yWU/
         CkIcm+KGMY5BSdMKLL7bbc0mKNFoibg+QL9kQoRUsWgGtyV2yn8XlOb2n39b68ahk7Mb
         d/ZxqJR488YAM8DhorM63oWNatS4DthUCvBKZhmz5BukX6btRJ0HxyALoZeWpQEBk5FT
         lcaT1hwAXAEsu7tOHoc5lDmFFAREewB9vYS3U/v9c4tWzrbYyoobNtC17btDlXYkc7W+
         xVs2JaHHXoQmq7sJZ8HHQWSLDSKGrK84C8kHBQhPAusotSre9PJMXSOJsLh+VmYrmBfM
         80hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374916; x=1783979716;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OzAtCoECdCJuiF0l9B8iruulf2cJzktwdffOADKIn7k=;
        b=WccaBAxHdlOFGsF5UTPkWSCkg8qImB6p6j7O8mTesZYPjW3cT9W11vabTE+ajfJT2y
         gWGOlSpQs8L75LQEhLrD/+++VprqB6Y0TRhjmV3WjBR6IvtAUeCF8Iidfe0FsQBgUcGa
         DRFrt/wEtiB1fmaGalHNcIn/UIMHOh9T+3o6C24BRlY7Ytmyub7/E0RY5L3Slae/sXpO
         3KeXYSovJ0qQwkV3wYyfr/DAoF8N5TVy2OyWrhyBGO8RHd1ZmLeBO8FA5615ZUdSzbIE
         ctKtGrK5v8n34CcakPD9v4X+2AqB7z33jEf5I0bO3kOHOuLdPLHdrM0mDhjNS/+oU16h
         5ISg==
X-Forwarded-Encrypted: i=1; AHgh+RrZqe9MH+cSCgEZY3gbBDBfFL6GpKiNph7qjbj+0yFkbl50sexsIGm36MQt+396jdQF6Xvjh7Rklgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbVWMeHN45G7cmkRzhWcVXxljvIdHaPnUgtLZq3Teo1vBMHBn7
	c6752ST1mgu333jAXwFIIfGY8aHV+UiuJ1KrCJEFJv+wbKIDKEbt7mzgBrV0K00oQmQyC3ff2EE
	Ob7NxkPa6orsAKkWuh3ek20rqk+WxMUsL79GZ7/lE
X-Gm-Gg: AfdE7cm+VWXbogiphTOVk6+k6Q3MW2eUfNtiJfI/XiKcGHpm3TMFyHF46JLt+WRtYm8
	A4qLtCOCmo++ktafVDhsvNkrQ27UhPdDiWnVlU/r3cVs0lsGWAnKI8SBjzw1rz01KqGu4ClmkUj
	hmk0LZoYqThA3jvbTsNAYq3J40EdjfcRxaaF9v2GsV1eMNcZRHnPx1MUjBJtnIB9Ar4y4o8mM4k
	oBRonW79A2jN/bPU5BHhRq9XGK6CC7GQWYTUOWO9qF2lUjxgVP/2eeyOiZEewch9Gf+OLXU
X-Received: by 2002:a05:6a00:66da:b0:848:2f77:e2e4 with SMTP id
 d2e1a72fcca58-8482f77f2bfmr23552b3a.77.1783374916009; Mon, 06 Jul 2026
 14:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102759.9626-1-achillesgaikwad@gmail.com>
In-Reply-To: <20260703102759.9626-1-achillesgaikwad@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 Jul 2026 17:55:04 -0400
X-Gm-Features: AVVi8CfKZuFUvj5WJxMuh8aeVfxDT3qMo2MTOwRdy2G0wEJGkvythY4spfI5-KI
Message-ID: <CAHC9VhS3_NCZm_GmF-nxPxJ_EPCsScEa+=y8vBqqneq-M00=uA@mail.gmail.com>
Subject: Re: [PATCH] NFSv4.2: fix nfs4_listxattr NULL pointer dereference
To: Achilles Gaikwad <achillesgaikwad@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:achillesgaikwad@gmail.com,m:trondmy@kernel.org,m:anna@kernel.org,m:stephen.smalley.work@gmail.com,m:linux-nfs@vger.kernel.org,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23121-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,paul-moore.com:from_mime,paul-moore.com:url,paul-moore.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6836B715DA0

On Fri, Jul 3, 2026 at 6:28=E2=80=AFAM Achilles Gaikwad
<achillesgaikwad@gmail.com> wrote:
>
> A call to listxattr() with a buffer size =3D 0 returns the actual
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
> security_inode_listsecurity() now decrements the remaining size
> even when the buffer is NULL, so in the size-query case 'left'
> underflows to a huge size_t value and nfs4_listxattr_nfs4_user()
> treats the NULL buffer as real, ending in a NULL dereference in
> _copy_from_pages().
>
> Declare 'left' as ssize_t and pass a zero length to
> nfs4_listxattr_nfs4_user() when the buffer is NULL.
>
> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode_listsecu=
rity() interface")
> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> ---
>  fs/nfs/nfs4proc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks for reporting this, one thought below ...

> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 1360409d8de9..4859c2c96c78 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -10585,7 +10585,7 @@ const struct nfs4_minor_version_ops *nfs_v4_minor=
_ops[] =3D {
>  static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t =
size)
>  {
>         ssize_t error, error2, error3;
> -       size_t left =3D size;
> +       ssize_t left =3D size;
>
>         error =3D generic_listxattr(dentry, list, left);
>         if (error < 0)
> @@ -10600,7 +10600,8 @@ static ssize_t nfs4_listxattr(struct dentry *dent=
ry, char *list, size_t size)
>                 return error2;
>         error2 =3D size - error - left;

I wonder if it would be better associate the handling code with the
security_inode_listsecurity() call a bit more closely?  Thinking about
it quickly, would something like what's below work?

  left2 =3D left;
  error2 =3D security_inode_listsecurity(..., &list, &left2);
  if (error2 < 0)
    return error2;
  error2 =3D left - left2;
  if (list)
    left -=3D error2;

> -       error3 =3D nfs4_listxattr_nfs4_user(d_inode(dentry), list, left);
> +       error3 =3D nfs4_listxattr_nfs4_user(d_inode(dentry), list,
> +                                         list ? left : 0);
>         if (error3 < 0)
>                 return error3;
>
>
> base-commit: 6eb8711ece2ce27e52e327a5b7a628ed39b97f45
> --
> 2.55.0

--=20
paul-moore.com

