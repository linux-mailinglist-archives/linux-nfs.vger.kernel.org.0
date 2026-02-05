Return-Path: <linux-nfs+bounces-18733-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H96N2NlhGkh2wMAu9opvQ
	(envelope-from <linux-nfs+bounces-18733-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 10:39:47 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18212F0EB0
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 10:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20A443021EA2
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Feb 2026 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035CC3A0B17;
	Thu,  5 Feb 2026 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjUGTiXw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E0E39E6E1
	for <linux-nfs@vger.kernel.org>; Thu,  5 Feb 2026 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284251; cv=pass; b=Sst06WJoqui4NOit2uB5OKb1wWbGz5UBYJl8d55hy/qcwlQx/T16/srNJL/M5Ttv9cqfE7QlE+7NUJbZ+N4zW0Yv9jl2TRJaBEBGzLM7AUi/a9RzYVIi/TA+UF8QA+cWpEbcyTAlEkgckUDSGtEhs6n4OeffSmiHFl7euYlbZSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284251; c=relaxed/simple;
	bh=O3zjcpb1gIgdrnZIOWkOIcCmTAMhdJCAtczZfkl8Mgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAzYR/ZgXqDUhQfl0FcWGaky8U5CYVpZtKdwoWWc0pXwiOqhxQUKA72zFm5xTrEgiS9Z6t0FrhTrjwSpcsqBmHXn+gTRucJ192H+l76+PGFfVcj0nELJ96/zEv4ceKfwKxpJjQSwZQ04l4ksDArzNMn2EdYxI9FzfLjxvniLD/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjUGTiXw; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-658078d6655so1221960a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 05 Feb 2026 01:37:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770284250; cv=none;
        d=google.com; s=arc-20240605;
        b=hiOz/dma9yfYpGNRQUtVaU4Ok/2SvAXhPo66uvq32D6nEsoZWuevwbP8+8c4ooQ+5D
         GVgUJ4e6PdWismLbcENqw7KiX6ZkCQ90eNPwjk6mNHihACYYuWYlH+vi+nvnFHmSMpdn
         uuI1WgTCIxHXodKm7NoEJ+gx+8cONA32j3o+cVUK2lrl1jd/HjTFRyTunxYdgcjknZ++
         msRHMqUB0IxtYdMC7wSP6dn/G9nI6LnS4WS61FdbBYGiV94X9+KmRlfM+XoFF4XCBDXI
         +ezL8D46h7cQI2Gur7HAWVHEAj76SWMz43UtjLOXQ42ERmuQXmr2+7aNgNswudeTPYVE
         WhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ts7BIpqOHUIYO1yz8UgL/PwCOZwIbnvcvFeQ/hBIaCk=;
        fh=bFgBesHwwRq45cs4C0PwUlRDJwxdk/0zYlhrcjAKxLY=;
        b=cuD7gfr/5obqEHiUVGkNDm2C+tpoJ9GTs45mIyUwGkEVxUzceQK4v4mEBzVfPT5W/+
         ltHu4tfRQKqS113jR5tH4trt06ihhVOxz7g1jR0HebKRX1uUAK3z3ISpz5kUx7KBQEuH
         tWoAqn7wDxl5YRiATiYGWl0o4wgq4nbnpnjrWOkeGNeKallYlnYMj2twCikmlINVs7lW
         acKlit8616MW5H2j4NpbIyJGfNQnTue9+UCH1YIQPGSqjhRuwJmpj3KRILHaxt0/DZh5
         SoUUGHnuYHp06ii2iAnk3l5bpq1kBPrcP5/Q8MM3yRrmbydm8LE0vIKqFrOEkXvDUNK7
         Ejsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770284250; x=1770889050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ts7BIpqOHUIYO1yz8UgL/PwCOZwIbnvcvFeQ/hBIaCk=;
        b=FjUGTiXw2YWjuQ7I+GqvszU9ONy2XE3+0JTAxPXHkvt5eZPZz+J5Ufml3pqOgP8T2L
         rGpjc6btwhogLQMha/Jf6R6/yMMHusEbVvvB9GvauRcrLVSE37m/5NRzEmxkn7UFT56a
         iuPSJZkpndM52iukwsc73xY8GdCH4GozIXR7BrzDyyEcwiI2UfOmNraXaq/qo6qKWX5v
         Js4guz62jAPbbEGBBruoJBw9nESFq2rhHfK5hAw/E3v3AMLBniyg3HEQD/EO70aNkSpl
         fnmqT9r0YmS9KqEzDR/y8yvYgP0e5gBj2781l3djCI2R2Qr30Ey5NTf0YpiUPWKYhCsR
         bKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770284250; x=1770889050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ts7BIpqOHUIYO1yz8UgL/PwCOZwIbnvcvFeQ/hBIaCk=;
        b=Q3oo7RPAkcn1QxFVTVJrMxpGTa3XOyx5d8r8Xr1Xkw65kmpJfXikhpwjKs+ToCRAXv
         Vkjft53B8NK8YVUC8IV/WjI74Tu9H6UHCYehCc0KOLHGGP5u4cxy3bcDYN4rEQC7jVok
         dRohZTIp/HXcu2gTSzlj45yX9JhoRDShU3e/WKjAvbzFMAJrnXH+96NbrWkUHNwW3RSF
         KY6XBGvxpbOf3XMpu1uWh8/a7srthCMdeg2UfhKybiRpbWxzKgQGq7+CnJ+GkkS8ryY0
         WWJn6dRv3R3c4gGHQnd5j013T1CqIrRUcjg3i3vQSBYKwbtvs7adbmqXlcYsmaMJdzJl
         OeWg==
X-Forwarded-Encrypted: i=1; AJvYcCUXCdpvWhSgp6qI3Or4dLc8PE/vYwv2jmYQdSlDq7GZYreq3kqOJ19BxxINB1s7QgowWzBrVV2t0q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr4bF71oWogINRJQKAgMecSyTGn2q8GAadgyGXC0l/dkz/awc5
	BnwHkeDOpZSfvZ5qasDBhpCENDnXNKGdbFvIC+hKMuXW8V/9k7QDVy5LyUgypjqxYGMhzxR+WFY
	qufExCF1V30D9WnrEtGBJX3OMDXm0UIQ=
X-Gm-Gg: AZuq6aKvqvA3rjQW3uJZJEgfnKNqy/x+mDuua7tOvyewpRkjJNwrSaM0wp5YMM92L8Y
	mBwwMQgfDnS3FKi5LNaU+0rokr+gcXxNm0kFqS6vloGkgYuL482Zsv6GVWrT4Kf1Atg0AOFtTPL
	YSg1XHN6lcHC/UP+fSWPWnp/7IEcMJhokAFNfVP+YXyNfZIgD3+B7Hq6rIzKLnNTPDeOPmTCWq6
	2xx+VeJxLVK0G/ZJfAhnyJVs3AHUBeSl9TbzKFdwEgW8pIogNTTeKBUb2X8CtuX8UFSG5A7mYS3
	qRCRD55JCzvvJkLXWYpqdP8+Sf79XA==
X-Received: by 2002:a05:6402:2688:b0:658:cf28:90ed with SMTP id
 4fb4d7f45d1cf-65949cc1e5emr3920680a12.15.1770284249654; Thu, 05 Feb 2026
 01:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-12-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-12-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 10:37:18 +0100
X-Gm-Features: AZwV_QjDs8XEOiRuWGAHzisKUrokVjcatEGo5N0FYjLzK48UQXH5p374RE5BkHo
Message-ID: <CAOQ4uxiYUTi=8BjRFbY_GdBZR_5CuP6680me=_xQaPcQk7EFuQ@mail.gmail.com>
Subject: Re: [PATCH 11/13] ovl: use is_subdir() for testing if one thing is a
 subdir of another
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18733-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,canonical.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 18212F0EB0
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> Rather than using lock_rename(), use the more obvious is_subdir() for
> ensuring that neither upper nor workdir contain the other.
> Also be explicit in the comment that the two directories cannot be the
> same.
>
> As this is a point-it-time sanity check and does not provide any
> on-going guarantees, the removal of locking does not introduce any
> interesting races.
>
> Signed-off-by: NeilBrown <neil@brown.name>

Looks reasonable

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index ba9146f22a2c..2fd3e0aee50e 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -451,18 +451,13 @@ static int ovl_lower_dir(const char *name, const st=
ruct path *path,
>         return 0;
>  }
>
> -/* Workdir should not be subdir of upperdir and vice versa */
> +/*
> + * Workdir should not be subdir of upperdir and vice versa, and
> + * they should not be the same.
> + */
>  static bool ovl_workdir_ok(struct dentry *workdir, struct dentry *upperd=
ir)
>  {
> -       bool ok =3D false;
> -
> -       if (workdir !=3D upperdir) {
> -               struct dentry *trap =3D lock_rename(workdir, upperdir);
> -               if (!IS_ERR(trap))
> -                       unlock_rename(workdir, upperdir);
> -               ok =3D (trap =3D=3D NULL);
> -       }
> -       return ok;
> +       return !is_subdir(workdir, upperdir) && !is_subdir(upperdir, work=
dir);
>  }
>
>  static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
> --
> 2.50.0.107.gf914562f5916.dirty
>

