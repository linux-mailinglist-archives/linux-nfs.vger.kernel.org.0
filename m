Return-Path: <linux-nfs+bounces-11842-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4562ABE617
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 23:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5571BC2BF8
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 21:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A1425DAE2;
	Tue, 20 May 2025 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S8qv0ptS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CE3256C9D
	for <linux-nfs@vger.kernel.org>; Tue, 20 May 2025 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747776691; cv=none; b=RNHYh4SXQNcmnIIpmRZSLdxleQeqexEcMKy9qbdP2DgEz8Z2o8wp8yK84yRFNX+YChiy6eLl0HWH53hPwdSzB6aN7iXIdG+khi9mAnbTzbdQ4uvmF/vCgfKnHjl+1sSdBMa8364Fee7j536ASteky7Hbr0nNEZWIIIkOF324MDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747776691; c=relaxed/simple;
	bh=Rp/sSKtoxvD0xDJUL1ax9jsR8XaN1Db+UrRlq03guhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfmwZC1B2TgNlyD7SMxSB+TLjRzjd/cs1tgmoIoQ8U9dVHsAsp+aqN8/rTdU97G/H7HIBQqthIfgzKJMw0SvhiTIx2vVFwPh59kW5IooPOfoLZF1dAw/v9IzexdPYvbjXeoIkAaRsKpLKkBAUKoXMziMTUWyacWt1VimE+Blw5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S8qv0ptS; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e740a09eae0so5456777276.1
        for <linux-nfs@vger.kernel.org>; Tue, 20 May 2025 14:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747776688; x=1748381488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YexwMppYcbZe/m8aCqtTjf6L6bo5b6rZLX60EXLxJJM=;
        b=S8qv0ptS+qog4CXjQizT49B9eBq/MmCkIY1IMNxSyXdIxqlk0sxQVA1BqhkK/bwIgK
         O4S/DVWObFNCdXo44Bq1/CGkjk8OijwXVuD71UnHg36INVS81QBRvD/ZjEaOiupFg/0b
         m9VEwcA/yZzDm0AeC0g6qXNG/ZUYMSA4kAR8xObmtuWeljORdLY7BciHMBc8AoOZ9n35
         E4LRowUaRBt4Vlq7fJ6/5elJpHdlvDK0r2Rq4rdWbmkFlov2umkXFENBrWg3kSculIXX
         rPZKLrW+I17nJ8OqOlj1uxiRMcPg4k15n9QuFRfLxHNbl2PVnyIJYoH7kfZvyF5W2Mfr
         HrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747776688; x=1748381488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YexwMppYcbZe/m8aCqtTjf6L6bo5b6rZLX60EXLxJJM=;
        b=jNPuuZmGPn2f+xKOKQQPkTcq/BAarwmFvF0c+06S/mO0jjdUppmHUVv0Du41XzNpvI
         kH6PI3iqIET3105Ww3MnwZak0hPPaGDjvz06M1VN6q2U1C6htpSczmI/4OkGjwxsTN96
         hhqFJrcY+0Z0Fa12Qqrfysz8H1ymdfTN32yofz4y51RXxdQoWHkUvw3JNpfI7Qk6XT/v
         hfHz9LU7Sy+OvpnVqCzSm/YiJUSN2g5tUUDhHIr/jWzy4jpuoAxRmFN9SkB0vGO8jVVt
         e4sxtS9W7i9KWi933Oo8lAfNww/dypXdcVBA2lmZLnMay9jt4xz8MugYnlYgC9L5B1Hv
         lU0w==
X-Forwarded-Encrypted: i=1; AJvYcCXUaokh8MLKonvtCL6MSDqdHQhvVGo4CCLFIkbpGQ57nn4uDfMmE1D66S3aNa1GP3lrOCD7yho2Psg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsUwvunQ2kcyb9RsanwsBtei6q2O4IzpTio29nJSGUTqY5CJWb
	RlPdpfNQ2RfS7CvmXJ3uVDxnqRpAm/nJpWbpjDvM0jsPeE73vI1AIVFAy5klIqjfUjT82b5PkuQ
	n3zWmSKdo5D+WeRV9SgbpGv+dLea4tq2qUXy4u2eK
X-Gm-Gg: ASbGncvgqFCRScQwuYfPvfQa/4Pqtx433tjceuxq9StkPwBFVvcyqGhESjx6tz1yTU1
	FG6Ji7W85W+UM0yERfmV+un9w81FyPoIOjkNALRsQLypHuIB5gkZibza/UcCWMPPC7r9Cp/MaQh
	HzKQ39pqaeekGwCmZYDEbhsA4HOdWZ4eQT
X-Google-Smtp-Source: AGHT+IGZ/rtogvtb9mmq771rmbik+el6dyUZ8s9kwWv9ZNx2CrYoN2T0d4tY5zplAYSZmSb/J7/BxKaHsq01XwQ2/QQ=
X-Received: by 2002:a05:6902:6c12:b0:e7d:585d:6aac with SMTP id
 3f1490d57ef6-e7d585d6f25mr2740629276.39.1747776688624; Tue, 20 May 2025
 14:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com> <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
In-Reply-To: <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 May 2025 17:31:17 -0400
X-Gm-Features: AX0GCFsKbQqPlLe-FjaU6xxZxNkDN5cHZfC1VDbTRZv-QCv_QCmlg4xFRTHqelQ
Message-ID: <CAHC9VhQyDX+NgWipgm5DGMewfVTBe3DkLbe_AANRiuAj40bA1w@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 7:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Update the security_inode_listsecurity() interface to allow
> > use of the xattr_list_one() helper and update the hook
> > implementations.
> >
> > Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.sma=
lley.work@gmail.com/
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > This patch is relative to the one linked above, which in theory is on
> > vfs.fixes but doesn't appear to have been pushed when I looked.
> >
> >  fs/nfs/nfs4proc.c             | 10 ++++++----
> >  fs/xattr.c                    | 19 +++++++------------
> >  include/linux/lsm_hook_defs.h |  4 ++--
> >  include/linux/security.h      |  5 +++--
> >  net/socket.c                  | 17 +++++++----------
> >  security/security.c           | 16 ++++++++--------
> >  security/selinux/hooks.c      | 10 +++-------
> >  security/smack/smack_lsm.c    | 13 ++++---------
> >  8 files changed, 40 insertions(+), 54 deletions(-)
>
> Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smack
> folks I can pull this into the LSM tree.

Gentle ping for Trond, Anna, Jakub, and Casey ... can I get some ACKs
on this patch?  It's a little late for the upcoming merge window, but
I'd like to merge this via the LSM tree after the merge window closes.

Link to the patch if you can't find it in your inbox:
https://lore.kernel.org/linux-security-module/20250428195022.24587-2-stephe=
n.smalley.work@gmail.com/

--
paul-moore.com

