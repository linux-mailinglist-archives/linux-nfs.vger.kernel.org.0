Return-Path: <linux-nfs+bounces-12141-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCD9ACF67B
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 20:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D607B3AD6A5
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 18:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B926C278E5D;
	Thu,  5 Jun 2025 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U2KQRF9g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B751EF37C
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749147871; cv=none; b=oom15EsP2jwZBhRMS9oOHo8GitboDEZ/uXM9vcFwwnffyP5HWdwjzyK5pSyboREYpOp/R1I6TH3Md1lBppEKqmahRTyHhrm8r1T7KZ3ouUfQkPmPo8miV+7mUTtChLsDHAw6EPkmIijQKsvjxMG/0HeRcpsZ2dZvglBpUHfJzyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749147871; c=relaxed/simple;
	bh=tGKIDGZtqQueasd3JtRGIJZMx5ylZw1zITKz99GjUn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsII6E6oUflvzFC1stMFtbuLAiCyypdd1B3eaYT3lnpxb1g9y3JmlZoXIei8hchgii/JzY1hJz4XqKxr0Wk2eO0zHCag1hwCVHfecLikQa14Ks+K6GpmCULEJXIFGcCprVmQ5ogsbPer9a9hsikPLrwJCHCJd8M/st4ZTd0T7/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U2KQRF9g; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70df67e1b17so13047637b3.1
        for <linux-nfs@vger.kernel.org>; Thu, 05 Jun 2025 11:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749147869; x=1749752669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loafhdCi9dc6Ve3gPnUX+aj3YHhuwxH1+gMF2DvUoxU=;
        b=U2KQRF9gMVWpoiDT+DpknCR4fAngrfwzYAU10s8OXIJ10Nvu2yyS/0lOfm63hfEre0
         GWe25EIo+Qn/LRHB5MpXAXmy7BImT394yzujhQk+2EpNC3tnOaY9h3XlkFd/zwJa3WJ/
         snSTTq6kS9RAGYK0+ZByv4GDlwdvqaJjreRowTJaZarRKllMYY9Xh0PdOv3OiaSUR03A
         F9JUrXfu1YLjn6e5sjBFJWQl3FGh15KIgQVCRaN1nAuIiak103wqNrqz+qNk6/QBK+uK
         Y8T/DLEHqxuDHd48q8UVPF1p6kgB1BUe5hgJXAhDvfDTKp0nCsuZ6A3X3eRheCz9X7LN
         XIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749147869; x=1749752669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loafhdCi9dc6Ve3gPnUX+aj3YHhuwxH1+gMF2DvUoxU=;
        b=vVL4119yE/Ts3AowNZuH5g5MIjGFN/n36dJttTO3r5fTy8lic+48wQOGmxycHiPEUB
         zxEwFimRs+NKUI1IgvP1tX9vwcvOws0dfX1Ob4cLnaKKpxMyHITqfz3pEBOu4VyJGHrI
         aBl9vQ6ICMK+l+tQy4B9Qok1onU9fGUv/nUajvZE7nfABA84k7QePC1SYOPjP1De92iB
         3SboEP49FTEb5N85sNQtFDIkZcsu2BhVdidq8GVAnGLnESdeNEK4CUN+R1k5xwEnjncI
         ocDvJyUjfKXyjDUr9giUCxNdmosAg2Gh7mf9M6JeLQpmmoFL68xtzxhZWUI+eGISnZdH
         GhYw==
X-Forwarded-Encrypted: i=1; AJvYcCXv/hoibaVC8WEiLE4JDcxvYpJq6Iaj33pCNjOF0TboObV1EiAp7XGyZG/PMpmUUDYiat5UVjtBK3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVqW+JO3CFxbakqTpwYUuzpCac4QQYptNX89BsI0nQH0UhcmEA
	bpqGga/Iwq8g769AqLzfXUxxKkllwACE0uxtXgnC0TYv3mkVMUewclT9PGT1NX+bZqJg6PsDTP3
	vYcQfR+SxDfBqZImlb5oIzG9RiD7Z4MsBV53JJJxD
X-Gm-Gg: ASbGncvyOQhvyce8kO1nHKl3Csbs1H3LsLt7abMRtWMEuzLldNBIzBZ+sgLBfVjU5y6
	Cxdqgzkml3EjwpC8oHxVuy8flpsLoXZ0d/sxOe1RVcJkEcl3Jt4b2hi7nh0jKfcJ7qW5Q7XdhwE
	KatMEF5kltn2Ou9kN+IM62cOgMh2ANkd+ruvML0elgoKs=
X-Google-Smtp-Source: AGHT+IGxHcLyr5CUfj8Adk1qnJ7rv9uM6qFjbiSCZGbhPb0Z0+PCihp8dprkPhkh0xIW808Di0xugMW90I47iMKtMCg=
X-Received: by 2002:a05:690c:6405:b0:70e:18c0:daba with SMTP id
 00721157ae682-710f7702170mr6558677b3.25.1749147869072; Thu, 05 Jun 2025
 11:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com> <CAEjxPJ5CSUEsXGT5e9KKXvdWpetm=v8iWc9jKvUMFub30w9KqA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5CSUEsXGT5e9KKXvdWpetm=v8iWc9jKvUMFub30w9KqA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Jun 2025 14:24:18 -0400
X-Gm-Features: AX0GCFsZ19Ez_LuqMFg5B8ZMjt620X-7zdb1BXMpiC6FnE_cwm04AN2nSkRV4iM
Message-ID: <CAHC9VhQ=oDeMnzrp5oERzKi8Q_o70bfTqO=LA4nuv_UV+5ApoQ@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 2:09=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Apr 29, 2025 at 7:35=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > Update the security_inode_listsecurity() interface to allow
> > > use of the xattr_list_one() helper and update the hook
> > > implementations.
> > >
> > > Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.s=
malley.work@gmail.com/
> > >
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > > This patch is relative to the one linked above, which in theory is on
> > > vfs.fixes but doesn't appear to have been pushed when I looked.
> > >
> > >  fs/nfs/nfs4proc.c             | 10 ++++++----
> > >  fs/xattr.c                    | 19 +++++++------------
> > >  include/linux/lsm_hook_defs.h |  4 ++--
> > >  include/linux/security.h      |  5 +++--
> > >  net/socket.c                  | 17 +++++++----------
> > >  security/security.c           | 16 ++++++++--------
> > >  security/selinux/hooks.c      | 10 +++-------
> > >  security/smack/smack_lsm.c    | 13 ++++---------
> > >  8 files changed, 40 insertions(+), 54 deletions(-)
> >
> > Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smack
> > folks I can pull this into the LSM tree.
>
> Note that this will need to have a conflict resolved with:
> https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.smalley.wor=
k@gmail.com/
>
> Fortunately it should be straightforward - just delete the line added
> by that patch since this patch fixes the security_inode_listsecurity()
> hook interface to return 0 or -errno itself.

Yep, I'm pretty much just waiting on -rc1 right now.

--=20
paul-moore.com

