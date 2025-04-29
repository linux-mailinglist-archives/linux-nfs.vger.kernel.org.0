Return-Path: <linux-nfs+bounces-11360-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B732AA3C55
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 01:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDC717EC10
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 23:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996172DCB5A;
	Tue, 29 Apr 2025 23:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QDm1WH5a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C329E042
	for <linux-nfs@vger.kernel.org>; Tue, 29 Apr 2025 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969711; cv=none; b=lQF0QwrOApthd7uysuVkNbZOvZMrBFMgyqWjknepzNpYWyDeO+O6nqr6+amat1x184L+WkRWwsoq2h/QVH/JIIerVkBW1UDfZ1v2+nlWgEAcl89cPg/qSF8k4I3cDhN9qUNH0T9DojrZ/+nGaWONM4Y0/24cDTqVAQoB6wer+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969711; c=relaxed/simple;
	bh=rsEl9UaP3K3oS3AXEGJ4//+d9JcVZzKygP7EoztCreI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWCP8odC2xhb+W5y4RVud/OHkd7ZdinT4oxl20hKEYmrGHvXNumaVqWAkfez4sYR/LbIf9d4sfMdHyW6noUKxxR0pNdFQeR7YsqKWcupDHlLDzwTSxfU49azRELv6CVnwQT0kCPfp/p0hVLTYxSnQNEyhL0/EKyK9qGhd1oluhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QDm1WH5a; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e589c258663so5973416276.1
        for <linux-nfs@vger.kernel.org>; Tue, 29 Apr 2025 16:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745969708; x=1746574508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmnUMSIYfYwpn2HyiLKQyNsn7KSrfP3LbpSrKf+5Aoo=;
        b=QDm1WH5aDX3S3onHkINlqKhU3r9HLrw9D1iA4hyEWhENRuaD2NoLbOYORnp9+t083B
         2ZEG+KjLVuRtm8hoXk4HbUQXHgx+8/3YuC1MUHB0OOR8YumhPW3x93lR3uV7dh6TAJ1C
         Cg4Z53TupJMN7ljgn/spNJm2j6L6EQV2CMOHBEoDRkHyXWg8IADMRpxcZ1Q/6YcaWszZ
         xQQ8xpM3l//Dvo1h8453Bv0azTO8mUYPBv3lktXIg75qLusprpBitm76RUHAREgu2bHP
         RAr2MZ4YMrOhy3JzoxkSDgZ38hXSb0YTYXcIWZBqWyfh3MgB3P1ll09FlnC3C4fZqfNm
         rVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969708; x=1746574508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmnUMSIYfYwpn2HyiLKQyNsn7KSrfP3LbpSrKf+5Aoo=;
        b=rFy+PZjcLpxw5BwSIhn0rj3bO7DH6VTW0SHpHSGoKR8RXf1hyUe4GsPg+YiVHq2Mnt
         zYWdfsIT2sJ9/PNl77B/Qm+ODn04qziAiEi3zfuUMsW2YugxA/7Qe+W3DK4UU3ik4ArP
         LMyNPSttSTyehB2C+JJDv40x4T9nBe6or+70sD2Iz4xzIuJWpyWUl/DHvvNJ8dmrj2As
         M2ZFBb/4To2b1ydYEBkpsjX5/FGaEF9fZd2lIZ4C80kNYRf/SX3nodqP2+qd8SgPOP70
         i7mUHiXquLJjGoi4kct0oxxK0XIGsngXFD675eKu6gBhWhdYG9nrPV7ukAJ4fWm6o+IG
         J3QA==
X-Forwarded-Encrypted: i=1; AJvYcCVu/aomRTqWF3tCTovlVR1IM81+s93Wwz0QkQ5dJWUjaGjEIsXvmyZ0mXnJ7R/NHbyrqNdPeXT8g8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR0PgZj3l13YO2VLgXNaAWtEYTVt43rIOxU7le1+WCbRqxs4hY
	QMIQzlXE5podtq+3TUNAWYJ2LidA3Aain0GC6RDKoxIuDIDKtfG+59kJOUzsgryIHd56zBv0wts
	eqXfALW3J+pf9Y6ZY5QoMEf9eiRK/c4ahpxAi
X-Gm-Gg: ASbGncvxezLcPue8MafXz67ksg++Jk5Wd9ENvBGK4C7KekFnmS1oZQa8vry+n1QQmBN
	v5DnhrKODXM5c/a6rmlPtOq64/nLbeODc27hGW9p4br3h9PPpKGGbvMGCKL5onHT4Mv/pallwgO
	GFw75egks5PkkeUFwfETGy+A==
X-Google-Smtp-Source: AGHT+IF/PA17pzv+wdeYWaRIlp9MG3hOQmLeL81RAcqY50BbqvkWNnzjIoFkoR7L0ftuH1lvEReltyIjrUvBDvzq1Oo=
X-Received: by 2002:a05:6902:18d0:b0:e6d:d996:d8e2 with SMTP id
 3f1490d57ef6-e73ea8e46c4mr1522551276.14.1745969708362; Tue, 29 Apr 2025
 16:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Apr 2025 19:34:57 -0400
X-Gm-Features: ATxdqUErdvmLNdYZ_wWU2pMeCgVPQbMkXZvEOfiOk_QLBFdZZaZpYQrTWKeaZ3k
Message-ID: <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
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

On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Update the security_inode_listsecurity() interface to allow
> use of the xattr_list_one() helper and update the hook
> implementations.
>
> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.small=
ey.work@gmail.com/
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> This patch is relative to the one linked above, which in theory is on
> vfs.fixes but doesn't appear to have been pushed when I looked.
>
>  fs/nfs/nfs4proc.c             | 10 ++++++----
>  fs/xattr.c                    | 19 +++++++------------
>  include/linux/lsm_hook_defs.h |  4 ++--
>  include/linux/security.h      |  5 +++--
>  net/socket.c                  | 17 +++++++----------
>  security/security.c           | 16 ++++++++--------
>  security/selinux/hooks.c      | 10 +++-------
>  security/smack/smack_lsm.c    | 13 ++++---------
>  8 files changed, 40 insertions(+), 54 deletions(-)

Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smack
folks I can pull this into the LSM tree.

--=20
paul-moore.com

