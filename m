Return-Path: <linux-nfs+bounces-16475-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 596FAC66852
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 00:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0464F363972
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 23:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67DA2BEC23;
	Mon, 17 Nov 2025 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YmjZq2vE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DF82F7475
	for <linux-nfs@vger.kernel.org>; Mon, 17 Nov 2025 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763420681; cv=none; b=Z+izhYZ0uATymxI65crlEFvvwFdLTQrTfvjauIiMgfE0VlFETdd+xxl0esRCzoaRL93BesOOt5XvcIO5qyQ+WfX78ZrrXjfAMbiObsG4rNgF/dzb45jZ3LMiqzBW/3jPC2Wfku8JKtgIWM5JrrGFNULbNEA4r9baX7npSGJwqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763420681; c=relaxed/simple;
	bh=i7DdhnG71ftd4i2m2G21HgRfKhN3UzNnHz1O3MhLXC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wn7T7qX/9hGkM6JFInbrsy0B6se06rLN+BPa9+hKjuH81CmneIYIh9CpWaOMont4j5uZvD2/1zmqly7G4zlly+44vdK961zml3EPUFQcMfPfYuxUMaEf8mlrkAN5f//DAq4EraJ+Bq5x3HeclScUFa+44H/2q1sFWdOVPNcotj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YmjZq2vE; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso4124645a91.2
        for <linux-nfs@vger.kernel.org>; Mon, 17 Nov 2025 15:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763420676; x=1764025476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67DqjyCI/JhVTsF1ULoiPuOUOphLY2mp3g5O7RzL6g8=;
        b=YmjZq2vEP3RrKkuynMuBECfzV/qmuCZcW2k5SrDDwNLrBwCjhC9leZeksspqC9Reg5
         7m1qs16aYUYUzMy31VgnfaRfQ925KDC/Wf0JDl3vg/7PHxxunMH/Nn6A8qpdHIeOgmKF
         SSalfOtnM6+aKcPi/R1diKoX6mzhOZoLeEgbC5txiQiK8mFtldLoRKhJhxkJw2YYx59r
         W0OtXAGkR5gvdztwjWl9g4n1k7D8tVL8dwrwiXVcU0tTMTY3u4bltrQMVL5eUp5spcvr
         GNGswPZEV3ZLiPG9FXx0fVQEcWAztc4A7KBMY/KmU8D+TNzUS8SypFep3kDas3TIZnAY
         J+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763420676; x=1764025476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67DqjyCI/JhVTsF1ULoiPuOUOphLY2mp3g5O7RzL6g8=;
        b=SpOmIM0bUHYu8RIAWd1tP4Om5mFI7SxqlMudVxKfAzqE9DGsbb0rzTCS4os2Abr0rb
         u2G4sj7uSV9wEPUt5I6mwrg7e+c6cfhGPXoncOi8sdBrbEX80mxSNIJ7IRtD2cPm3JqI
         3pBZG1woHsJV9fciHOfvUVEfkjR4lHs5YyRcLJT7uH1kvLmY0uwys2gHNJR8j2eSL2ZY
         Xb5r1rwVfjd+dcRzYFT3PNkyq/2psEvISHbVLeKcFYGFwU1Jmc8ajPcAreC7TJ6nNR32
         r/E1G2x1uQ3BwjfDEPBfFK7NM2AXEs4gAJ7YrHC0bRJYYbg5hkVvKfZFg/71JoWDt3Pv
         9I7A==
X-Forwarded-Encrypted: i=1; AJvYcCVh71r4g+mxCCif5RSAKwbraP42dkcI4GWGGc6JTpNldjOWJXGTq0IK4VwLZzh7WKmONHyJXSNoEVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgkV1Yxusxdk9XbCrxLoVXXh/XvsDz0Pv/jahGFc92s35L+HDj
	hj6/LyLmf0BRB6rH014tKDskHJWjUnqgG0t6Sp4mSp7CH1fUO1VkwnhiefePrXYfRWImcvjXtoR
	h3QlcDvaFQwLDx5xrqcHoroOd4RMgESK9vhS1Hy7/
X-Gm-Gg: ASbGncvoidCtSk0PVF9SEHAMYP+rB5dL9+mOT94Hmg6rExhiutqmT2MxV2kYRp06keh
	Ar59mtI8wySx27PTgppJBtcrOL64H8yqKWHq4B9TzXTslw3URfsEiZTGj4dRd+ylnJsGOCs91X2
	4w7l6rO8ynO7Np2rgZ1lZDz28SmHDXsROEGuEaf8pAT/pbYsmlpMLGIh/At0GA0SV4GZFLbyK9v
	kQ8zJreZt/L4ry4mK6e4Gz4o5eTfWQTRIUut4gYMsTA+hBtqp7u6w0SFZxsIftuDyCSnVNzLQ7X
	XzMk3w==
X-Google-Smtp-Source: AGHT+IEvNsvH0S9IPXXRMbbmgzHTccG9PPI2nYN0bRiYDZkjLr7eZa3zFcl2Aq+G2oZCl+9tdbOi4J//UzL45yvj1Lw=
X-Received: by 2002:a17:90b:3a45:b0:341:2141:d809 with SMTP id
 98e67ed59e1d1-343fa74b235mr16121302a91.26.1763420676475; Mon, 17 Nov 2025
 15:04:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113002050.676694-1-neilb@ownmail.net> <20251113002050.676694-13-neilb@ownmail.net>
In-Reply-To: <20251113002050.676694-13-neilb@ownmail.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 17 Nov 2025 18:04:25 -0500
X-Gm-Features: AWmQ_blmwKtGFLQfMeJ-bOJqBB1-xlrqHYzasnjIoux8218WIXniQF0qawaCUpA
Message-ID: <CAHC9VhQERRrabQhMUd3DHRg+TqV6Ztoo0kqwK_tn5u--in-f4Q@mail.gmail.com>
Subject: Re: [PATCH v6 12/15] Add start_renaming_two_dentries()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	David Howells <dhowells@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Chuck Lever <chuck.lever@oracle.com>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 7:42=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> A few callers want to lock for a rename and already have both dentries.
> Also debugfs does want to perform a lookup but doesn't want permission
> checking, so start_renaming_dentry() cannot be used.
>
> This patch introduces start_renaming_two_dentries() which is given both
> dentries.  debugfs performs one lookup itself.  As it will only continue
> with a negative dentry and as those cannot be renamed or unlinked, it is
> safe to do the lookup before getting the rename locks.
>
> overlayfs uses start_renaming_two_dentries() in three places and  selinux
> uses it twice in sel_make_policy_nodes().
>
> In sel_make_policy_nodes() we now lock for rename twice instead of just
> once so the combined operation is no longer atomic w.r.t the parent
> directory locks.  As selinux_state.policy_mutex is held across the whole
> operation this does not open up any interesting races.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neil@brown.name>
>
> ---
> changes since v5:
>  - sel_make_policy_nodes now uses "goto out" on error from start_renaming=
_two_dentries()
>
> changes since v3:
>  added missing assignment to rd.mnt_idmap in ovl_cleanup_and_whiteout
> ---
>  fs/debugfs/inode.c           | 48 ++++++++++++--------------
>  fs/namei.c                   | 65 ++++++++++++++++++++++++++++++++++++
>  fs/overlayfs/dir.c           | 43 ++++++++++++++++--------
>  include/linux/namei.h        |  2 ++
>  security/selinux/selinuxfs.c | 15 +++++++--
>  5 files changed, 131 insertions(+), 42 deletions(-)

...

> diff --git a/fs/namei.c b/fs/namei.c
> index 4b740048df97..7f0384ceb976 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3877,6 +3877,71 @@ int start_renaming_dentry(struct renamedata *rd, i=
nt lookup_flags,
>  }
>  EXPORT_SYMBOL(start_renaming_dentry);
>
> +/**
> + * start_renaming_two_dentries - Lock to dentries in given parents for r=
ename

I'm guessing you meant this to read "Lock *two* dentries ...".

Otherwise the SELinux changes look fine to me.

Acked-by: Paul Moore <paul@paul-moore.com> (SELinux)

> + * @rd:           rename data containing parent
> + * @old_dentry:   dentry of name to move
> + * @new_dentry:   dentry to move to
> + *
> + * Ensure locks are in place for rename and check parentage is still cor=
rect.
> + *
> + * On success the two dentries are stored in @rd.old_dentry and
> + * @rd.new_dentry and @rd.old_parent and @rd.new_parent are confirmed to
> + * be the parents of the dentries.
> + *
> + * References and the lock can be dropped with end_renaming()
> + *
> + * Returns: zero or an error.
> + */

--=20
paul-moore.com

