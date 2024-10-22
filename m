Return-Path: <linux-nfs+bounces-7363-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7409AB3EA
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 18:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8BBB23396
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 16:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591A21BC06E;
	Tue, 22 Oct 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Sm/BRd7m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7904A1BB6B3
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614350; cv=none; b=QuWSphm1OyR8ghT+gPZR70y4OPQBfTpz4kU4Pq3WGPxnHhBo0hIFUUKGyJa7jz5e/oUaAearSVYzbaZG8pT3rG/bjW6cQl4vLjjxGDpGVc6KvSVb1OljmEKolpxDV2PtZJ8G9AMzcE8RazIVrLEWvu+LZrGvejKW0L9rLAuMKTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614350; c=relaxed/simple;
	bh=x/EpTFWcpafdx4yQZpuOCX0QNjRr/XNDp+88mspQTb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyrCkWqMoVMwVxpAouzcx787i68J5GsFDrFl9XChscVjlTWmyXB1n82h4nrNi8yE/RuE6nHghgfoCtr2WzcuUWr5mWvBkx9+yKwg1f6OmEB/uLG6NaSAKatkMzgsY7XKxhEUKrxtJZn7uVyLUdz6YeZ/5oR9VTN3diuXoEgiPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Sm/BRd7m; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso5477306276.3
        for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 09:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729614346; x=1730219146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FcFULehhwAxlgpbjAQH5GvQbdOX1Yt9+//ukehIaF4=;
        b=Sm/BRd7mkh6HX69sr8olD+37sceM+80v6PrS5EcixOUU4a2KrTmJLi8DNJWSaQbDrz
         s/qt43XcXrFCV1qws3+Me8WMWnv38bMJDU5osONzZSMte+FicqIxbDlgZuj8wG8P+ow9
         b7I3Gjg9B5548gxue+hXFQ1TE1hNJ0f3YlSKG1A/K0InLhxyJ47C3oMertlGIipoiHK0
         FB5Yqk/upwwqdyQIbYwLr/UzzzJ9f47VMYFd8PRHjqkVxzNg1/PbbILBtXNcdht7xLsO
         RX3l04zioRt8zZa4MhTRybqfw6l92WMtcvRGBFSYb3jHfTQETBw//8qDBeqv2hv6M7bZ
         c3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614346; x=1730219146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FcFULehhwAxlgpbjAQH5GvQbdOX1Yt9+//ukehIaF4=;
        b=a4S+Yp2C/XNCnhH81MMz0LvZxyaRlp7EbGIB/rP5bYZMsW7qOhaPojqIs4G2txEs/Q
         P+9CLfvcKb2HR0lBAFSb3SzzdtNHvFOGgL8gVDAAFkKfTWufsctykkrlzmwzf5rjeY/P
         4HF3RJPo/iM+ncEiOqzDAHH1Xl9QfpqY9uueyTZy9HpfOJGKqJNbBuPjUuIOUyO6U9i3
         qqpNRjnK1xWNML4HLebn7kBMIuQnxvbQTCpZqLI6DwIql0mVfYEQSbhcasNEUHz8w7NM
         nczQdf8l2rf65jQOqlin2W/y+FJxZrOK+QSOD7oa6t94yBNO+7NNO+4IwP3a9YoSG4oB
         5Z1g==
X-Forwarded-Encrypted: i=1; AJvYcCUPRz51A/1ZaD1BYabW9CQZod/RgYloANvykL7PqEFRm22keo5M606gfeBFQ8BSHwXHW8PuHkUowYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHsZSJfDgJtmbW+V32gutbWt+2dY8eUwcBxkEOEMic9COf+LgJ
	4WNDU/0jNhSIPQRYm0+5MSrJ8RiEerqqQWUqHdt9dvPtdcoIgjMDHDFvTOMZaKsNd2/UtmHSSW4
	hw0bEA6GX5gAi5S2XtWgh8IK8pIUcpngKhu8B
X-Google-Smtp-Source: AGHT+IHmXg9dtHAkm/7oEMwvTrSAmrcx0Tkk5Vpql4w7fIuSXGrdcLHvVQoR+ZoH/iPhezQ76TFTXoN23QB1mIW32CM=
X-Received: by 2002:a05:6902:2603:b0:e29:2ab7:6c03 with SMTP id
 3f1490d57ef6-e2e271bb480mr2927136276.33.1729614346507; Tue, 22 Oct 2024
 09:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014151450.73674-2-casey@schaufler-ca.com>
 <dad74779768e7c00d2a3c9bf8c60045d@paul-moore.com> <bab1de2e-0205-40dd-af3e-5956ff349948@schaufler-ca.com>
In-Reply-To: <bab1de2e-0205-40dd-af3e-5956ff349948@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Oct 2024 12:25:35 -0400
Message-ID: <CAHC9VhQ0mBKz-y33+xV-de+hjA-wMbcv9+VmBXWiPjk5Ygz2eQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] LSM: Ensure the correct LSM context releaser
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	linux-integrity@vger.kernel.org, netdev@vger.kernel.org, 
	audit@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 7:58=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 10/21/2024 4:39 PM, Paul Moore wrote:
> > On Oct 14, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Add a new lsm_context data structure to hold all the information about=
 a
> >> "security context", including the string, its size and which LSM alloc=
ated
> >> the string. The allocation information is necessary because LSMs have
> >> different policies regarding the lifecycle of these strings. SELinux
> >> allocates and destroys them on each use, whereas Smack provides a poin=
ter
> >> to an entry in a list that never goes away.
> >>
> >> Update security_release_secctx() to use the lsm_context instead of a
> >> (char *, len) pair. Change its callers to do likewise.  The LSMs
> >> supporting this hook have had comments added to remind the developer
> >> that there is more work to be done.
> >>
> >> The BPF security module provides all LSM hooks. While there has yet to
> >> be a known instance of a BPF configuration that uses security contexts=
,
> >> the possibility is real. In the existing implementation there is
> >> potential for multiple frees in that case.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> Cc: linux-integrity@vger.kernel.org
> >> Cc: netdev@vger.kernel.org
> >> Cc: audit@vger.kernel.org
> >> Cc: netfilter-devel@vger.kernel.org
> >> To: Pablo Neira Ayuso <pablo@netfilter.org>
> >> Cc: linux-nfs@vger.kernel.org
> >> Cc: Todd Kjos <tkjos@google.com>
> >> Reviewed-by: Serge Hallyn <sergeh@kernel.org>
> >> ---
> >>  drivers/android/binder.c                | 24 ++++++-------
> >>  fs/ceph/xattr.c                         |  6 +++-
> >>  fs/nfs/nfs4proc.c                       |  8 +++--
> >>  fs/nfsd/nfs4xdr.c                       |  8 +++--
> >>  include/linux/lsm_hook_defs.h           |  2 +-
> >>  include/linux/security.h                | 35 +++++++++++++++++--
> >>  include/net/scm.h                       | 11 +++---
> >>  kernel/audit.c                          | 30 ++++++++---------
> >>  kernel/auditsc.c                        | 23 +++++++------
> >>  net/ipv4/ip_sockglue.c                  | 10 +++---
> >>  net/netfilter/nf_conntrack_netlink.c    | 10 +++---
> >>  net/netfilter/nf_conntrack_standalone.c |  9 +++--
> >>  net/netfilter/nfnetlink_queue.c         | 13 ++++---
> >>  net/netlabel/netlabel_unlabeled.c       | 45 +++++++++++-------------=
-
> >>  net/netlabel/netlabel_user.c            | 11 +++---
> >>  security/apparmor/include/secid.h       |  2 +-
> >>  security/apparmor/secid.c               | 11 ++++--
> >>  security/security.c                     |  8 ++---
> >>  security/selinux/hooks.c                | 11 ++++--
> >>  19 files changed, 167 insertions(+), 110 deletions(-)
> > ..
> >
> >> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel=
_unlabeled.c
> >> index 1bc2d0890a9f..8303bbcfc543 100644
> >> --- a/net/netlabel/netlabel_unlabeled.c
> >> +++ b/net/netlabel/netlabel_unlabeled.c
> >> @@ -1127,14 +1122,14 @@ static int netlbl_unlabel_staticlist_gen(u32 c=
md,
> >>              secid =3D addr6->secid;
> >>      }
> >>
> >> -    ret_val =3D security_secid_to_secctx(secid, &secctx, &secctx_len)=
;
> >> +    ret_val =3D security_secid_to_secctx(secid, &ctx.context, &ctx.le=
n);
> >>      if (ret_val !=3D 0)
> >>              goto list_cb_failure;
> >>      ret_val =3D nla_put(cb_arg->skb,
> >>                        NLBL_UNLABEL_A_SECCTX,
> >> -                      secctx_len,
> >> -                      secctx);
> >> -    security_release_secctx(secctx, secctx_len);
> >> +                      ctx.len,
> >> +                      ctx.context);
> > Nitpicky alignment issue; please keep the arguments aligned as they
> > are currently.
>
> Not a problem, although it looks like it's correct to me. I'll check to m=
ake sure.

Thanks.  It's likely just an oddity due to tabs rendering a bit odd in
the diff, I usually check that but maybe I didn't/forgot here.  Not a
major problem either way, I only mentioned it because I was commenting
on other patches in the series.

--=20
paul-moore.com

