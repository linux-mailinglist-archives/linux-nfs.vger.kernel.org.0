Return-Path: <linux-nfs+bounces-15575-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1C4C01EA5
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 16:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90FB34E1139
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4E72D3EDB;
	Thu, 23 Oct 2025 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="d2vIBe0/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612F14C85
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231354; cv=none; b=CSnK6AXLCKh9VhuYGXNv1AFRDaff/Ur0WxvxJrnvqPFljRWe8T+nBazZO2VKHpt6LxaBWAtmvW5FPH5iV8Hny1D50svKS4SZy/lwXhXbUj3LMmCBPvdSZ7/ue6jIhWVwsXz7JrEYWzfCQwS5VB0OxTLUc2wzhEsPDevLnH4CP7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231354; c=relaxed/simple;
	bh=fckI+Q7DS2N4rHz4rtQGTjHJGTWFeJkt7SWVEEkmQzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtUS6HjYkmWuFR4V8TCVauuKIs56L5Mt8sCA7TVPIuHjLYWw3OYn5XJ3G5IzQREm3VeW0eyKjFttAZDYK+se3ngLKjlDLJv1NxjgGgAjHLsIHIBaTB0Ar3uh7PkSKMvTUqiq93sNIHUHnMKs+t2QfRN+DA+KVqfVu5Z+8A3OTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=d2vIBe0/; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-373a56498b9so26175391fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1761231350; x=1761836150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gxlsrjgm4PC2g16tiNJ5ICA4pW7TYOURjhwQ/9ozaqc=;
        b=d2vIBe0/aggYWgxO2Ru2LNXdDsWBNv3eQXB3/Nnf/M23SEiVvuL6zpRpykUCwD6yzG
         zj6jfYU2PYl1zxXKQO3MTZOUBwNOihaqp4a65ZHb8YU7Quxw2KLaXWIm6tMoc/mC4WAG
         IncgFYpZMhW3wGsVCxQ60lQv3EFZ2EgQFjEQVJeWD3HkK3lPJt8nsvb100PWrZgfhfVK
         iWJC0IMPm8OCQ2XK6OOnzGl/y1YFlnC2qTpxGDS+XkhcB3m8dIAYBgZeihoayMVEsNPh
         WddcC4xh3N3JSnr6JEjEXZMyua2EnHAoKFVkV9XWFQxbH7WwrJXoiQMgGnfKxo81EuIi
         wxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231350; x=1761836150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gxlsrjgm4PC2g16tiNJ5ICA4pW7TYOURjhwQ/9ozaqc=;
        b=VqU9GQL7OtCasecot39xepQo0o1MwiNH+YiAqH+VPw7+34Ud8AOB6q3Q1OHu6XfItP
         lhkxQh/buWcTqhdYOUfXU1McJibwXcM7ZaAlfgdVhFBpSBzxyCsT2cwGj6Innk80rJTx
         gXM4CsH6hW1V9X3yc6YVFlnmaKYrWqDFa7MU/bBMCSauRlYhTooSQHTa9SerbxZJ9QjE
         9RHyZ95hAyMkqpzmJv9aFQ9iP8otm3X3HvVW5teV3yk1y8s9pY1h1jHb37/9ohznaE5E
         ecD+sDp6NTV+p/XfRLBe2dIXJ1g7PmQbkZ9Wwyjs9bGg5ulMms7ox2c1trOxwDZortRc
         NgQg==
X-Forwarded-Encrypted: i=1; AJvYcCXO1xi2wTmRSCqns4rWNp+SNFmcl2RJuIlCwYhs21L7ZM+boRDUXfARWQeMfF6yuKIluvM9cHGoCbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp4I2hQ7Y6X/qtmdZgl6S+wMSZson6EzCiVKTyPo35ThkIWqY2
	f6BfcoNYMCrtLgZYFYYuEwzVjCvCc6im4EyC/1Dj/OJ9OI3lNI5MtDi0MDmn2E3aBuL/b2L9nzR
	QdKIpoNprVQY+6wS6IjQ0ceNLkslV6c8=
X-Gm-Gg: ASbGnctkymEeYLAaNIZ1GfwQ5hKg27LwYP9twvcznaNzB3sZ72UAP0A2d9mTb0wE3qx
	seUE+MRZWlkzjk4qUa/OOl/MLLi2kNFLRk3wMN0I3eFs7y64RXNVQk8wPlnmCptbrnLkwQXzrL/
	rnwv9K+WdcZfKGJni+0IGX9zQrA1UvCeOEIb1rjYkNsapUUWqs5TpiAN/KUr6+NjOxi5x/H59z6
	xczRXUieZTeJ0s0JRRSoq1qMmSAb6ZIZFqVqYxRn2S8SOX7E0lKL9GZAQupPKz+wkZMWpmkGMCc
	FeZuHdn/Ed5JLqKnCw==
X-Google-Smtp-Source: AGHT+IHXnIokQ+R7CdSwGS6TUuEAPAOHvARtHRCEdL/oveIcDAPOIRN5mlaIaOV38HuK+c7mcNyNTlIGGILFF8Dg1zg=
X-Received: by 2002:a05:651c:1604:b0:378:dfa3:ffd1 with SMTP id
 38308e7fff4ca-378dfa400c6mr3534051fa.11.1761231350312; Thu, 23 Oct 2025
 07:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021130506.45065-1-okorniev@redhat.com> <33ba39d2ff01eb0e52c80aa7015d27e34dde7fd2.camel@kernel.org>
 <CAN-5tyEuV2UO17w97b8weJUQR7hgqX=jz-kvGR9Sr_m3NZp8ww@mail.gmail.com>
 <d0a1a1ccec73ee56e614b91c4a75941f557398b8.camel@kernel.org>
 <CAN-5tyGK4MHgYaN1SqpygtvWM8BFrapT-rXY_y9msVfnRjN1Jw@mail.gmail.com>
 <ff353db93ca47b8fae530695ea44c0a34cd40af8.camel@kernel.org>
 <fe1489b3c55bdb32cd7ad460a2403bc23abdde81.camel@kernel.org>
 <f61025a96df19c64ba372cdcab8b12f3fa2fff9e.camel@kernel.org>
 <CAN-5tyFWvP2ZTeYFN6ybGoxvsAw=TKFJAo0dVLU_=s_5t=LCGg@mail.gmail.com>
 <f5073caf3e3db05702ed196042053fc864645750.camel@kernel.org> <176116947850.1793333.1787478761707441526@noble.neil.brown.name>
In-Reply-To: <176116947850.1793333.1787478761707441526@noble.neil.brown.name>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 23 Oct 2025 10:55:38 -0400
X-Gm-Features: AWmQ_bkiwzC-emsCcwIwGyfXPXfVQegslS6jNDhtUcvCGpcVwHJl8UGBxyeLZTI
Message-ID: <CAN-5tyHxvKoD651VEZr7kVoyHa2=pxRQXqQ6huUzRairAP2jqw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] lockd: prevent UAF in nlm4svc_proc_test in
 reexport NLM
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, 
	linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com, 
	tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 5:44=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote=
:
>
> On Thu, 23 Oct 2025, Jeff Layton wrote:
> >
> > Longer term, I think Neil is right and we probably need to fix
> > vfs_test_lock and the lock inode_operation to take a separate conflock
> > for testlock purposes. That's a bigger change though (particularly the
> > ->lock operations).
>
> Thanks.  But in the shorter term I'd like to suggest this.
> I haven't tested, but I think it should fix the lockd issue and make the
> code cleaner too.
> Sorry - I haven't written a commit description yet :-(
> As nlmsvc_testlock() is being passed a conflock, use that directly to
> hold the found lock, and initialise it from 'lock' before, rather than
> copying results the from lock after.
>
> NeilBrown
>
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 109e5caae8c7..4b6f18d97734 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -97,7 +97,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_=
res *resp)
>         struct nlm_args *argp =3D rqstp->rq_argp;
>         struct nlm_host *host;
>         struct nlm_file *file;
> -       struct nlm_lockowner *test_owner;
>         __be32 rc =3D rpc_success;
>
>         dprintk("lockd: TEST4        called\n");
> @@ -107,7 +106,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nl=
m_res *resp)
>         if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, &=
file)))
>                 return resp->status =3D=3D nlm_drop_reply ? rpc_drop_repl=
y :rpc_success;
>
> -       test_owner =3D argp->lock.fl.c.flc_owner;
>         /* Now check for conflicting locks */
>         resp->status =3D nlmsvc_testlock(rqstp, file, host, &argp->lock,
>                                        &resp->lock);
> @@ -116,7 +114,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nl=
m_res *resp)
>         else
>                 dprintk("lockd: TEST4        status %d\n", ntohl(resp->st=
atus));
>
> -       nlmsvc_put_lockowner(test_owner);
> +       nlmsvc_release_lockowner(&argp->lock);
>         nlmsvc_release_host(host);
>         nlm_release_file(file);
>         return rc;
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index a31dc9588eb8..381b837a8c18 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -627,7 +627,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_f=
ile *file,
>         }
>
>         mode =3D lock_to_openmode(&lock->fl);
> -       error =3D vfs_test_lock(file->f_file[mode], &lock->fl);
> +       locks_init_lock(&conflock->fl);
> +       /* vfs_test_lock only uses start, end, and owner, but tests flc_f=
ile */
> +       conflock->fl.c.flc_file =3D lock->fl.c.flc_file;
> +       conflock->fl.fl_start =3D lock->fl.fl_start;
> +       conflock->fl.fl_end =3D lock->fl.fl_end;
> +       conflock->fl.c.flc_owner =3D lock->fl.c.flc_owner;
> +       error =3D vfs_test_lock(file->f_file[mode], &conflock->fl);
>         if (error) {
>                 /* We can't currently deal with deferred test requests */
>                 if (error =3D=3D FILE_LOCK_DEFERRED)
> @@ -648,11 +654,8 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_f=
ile *file,
>         conflock->caller =3D "somehost";  /* FIXME */
>         conflock->len =3D strlen(conflock->caller);
>         conflock->oh.len =3D 0;           /* don't return OH info */
> -       conflock->svid =3D lock->fl.c.flc_pid;
> -       conflock->fl.c.flc_type =3D lock->fl.c.flc_type;
> -       conflock->fl.fl_start =3D lock->fl.fl_start;
> -       conflock->fl.fl_end =3D lock->fl.fl_end;
> -       locks_release_private(&lock->fl);
> +       conflock->svid =3D conflock->fl.c.flc_pid;
> +       locks_release_private(&conflock->fl);
>
>         ret =3D nlm_lck_denied;
>  out:
> diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> index f53d5177f267..5817ef272332 100644
> --- a/fs/lockd/svcproc.c
> +++ b/fs/lockd/svcproc.c
> @@ -117,7 +117,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm=
_res *resp)
>         struct nlm_args *argp =3D rqstp->rq_argp;
>         struct nlm_host *host;
>         struct nlm_file *file;
> -       struct nlm_lockowner *test_owner;
>         __be32 rc =3D rpc_success;
>
>         dprintk("lockd: TEST          called\n");
> @@ -127,8 +126,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm=
_res *resp)
>         if ((resp->status =3D nlmsvc_retrieve_args(rqstp, argp, &host, &f=
ile)))
>                 return resp->status =3D=3D nlm_drop_reply ? rpc_drop_repl=
y :rpc_success;
>
> -       test_owner =3D argp->lock.fl.c.flc_owner;
> -
>         /* Now check for conflicting locks */
>         resp->status =3D cast_status(nlmsvc_testlock(rqstp, file, host,
>                                                    &argp->lock, &resp->lo=
ck));
> @@ -138,7 +135,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm=
_res *resp)
>                 dprintk("lockd: TEST          status %d vers %d\n",
>                         ntohl(resp->status), rqstp->rq_vers);
>
> -       nlmsvc_put_lockowner(test_owner);
> +       nlmsvc_release_lockowner(&argp->lock);
>         nlmsvc_release_host(host);
>         nlm_release_file(file);
>         return rc;
>

No crash with this patch.

