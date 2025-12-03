Return-Path: <linux-nfs+bounces-16882-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBA4CA1284
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 19:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2A5430B7582
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 18:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B010D31329C;
	Wed,  3 Dec 2025 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exOZFkqi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA568313E01
	for <linux-nfs@vger.kernel.org>; Wed,  3 Dec 2025 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764785319; cv=none; b=HlsKkkhq5R5MpPytAzvq7B7DBowRJLYTVmglgrb1w62DFbOFWbl4hT4+ryYg0H191xLm0v6Wk84miDc02AgPEXehPobX89bP3//tTEzYjxasGIlnFjhAe9/PL0b/jRTeidjRZIOeFQuu08rZAUOT0AXQKl61JYsAKHmJLBXtFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764785319; c=relaxed/simple;
	bh=5jRrBA6CAZndQPZV3Us9+ZC5wzxN9fOkcbS0Noz1Wo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VI6bx/UD+VfDSNQ3jsEbxh+inkPE177UwA+Wy3YMCck+rgkYGQErsqiPrIVA2likQlxhBZ12G2Ji+uCFVUljjVw0udf88BN9MjuOsvMvQ2CUwGUzWBFsIWMUQ1dd0Fq2Buj2+/yx6spQ+BlWJqIRpMx6Rg01DQlk6w0q3n+qeeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exOZFkqi; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-343684a06b2so6662524a91.1
        for <linux-nfs@vger.kernel.org>; Wed, 03 Dec 2025 10:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764785317; x=1765390117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GofhpDmA3kuMABKH76nE8pV99jzh1HFP7UqmhwVcaVc=;
        b=exOZFkqiFRWcTXzfix5rHKnpg+SEnj4tlotLLzJtW81caMyBTiPdTK2TH+c9rLwt8i
         27y9sO6ZDzle6LbCvrnz+K6m/hnTqFI3F/bgn29BiqtDzNwMytrTiRLWWydfeR7sMSbr
         U5yXvhPV5+0qC60uLCJjIkN0Opyyl5zOmIOeMeMMrO1KQOWu4MoDqElRLzAsuBB4+GBV
         0Kal2yFKsL/42Sw61/7+3hDR9zl+G/gnMQnEo0j/zHSy9/zJfQUu945ktlmLfUi3wpvR
         zdmBs9OaMF2UhpYTW90YP8mzrzvXLiihYHT5ZeJtQcIpon+AFORb1ps0Ij07eUTUD7sK
         ynZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764785317; x=1765390117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GofhpDmA3kuMABKH76nE8pV99jzh1HFP7UqmhwVcaVc=;
        b=ax792tH1UQsXdtPzkLOzwqs3a8e/e7IKpM9wBwixxRGV9EES97gftk/rc1zE0NAzlZ
         r6DgEX8qdcMHZ2xVg71WyAvlBMshCbXzLvClTmHcANbg+jpkN4M4TNeOtdw1igi6sBQv
         8+p4wCbkvNdBDcTVuIL9nZzOAzncQBXLBKJx9xA8/hX5sAIn662b4WLdo0WaZhR10mt5
         zd+sBGT7TVU0uALjFA7TI0fGISQsRNMaQ1X5ATczQeUAYQKNTvbmcYQN2UjxIu78iqS6
         dpK4pSvvNLpp+KBZW8iENaNhFSNAZI9+uc3qbPeFyM/JFaTbzm8hHYmZREt6zA06rSTM
         aU+g==
X-Forwarded-Encrypted: i=1; AJvYcCXagu/KiWN0Je+Objf8bC8cRtrbdOI0M5a30Xkk6G48sY1BwO5m2Qc4s4XpRxLuAzsmt1ikGlc5CYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzigv4Rxjwk/mcXlkcK0yUN+XA/MBq5Uww7lBpj0Mdb3bGa9r60
	u39HXt0hdVnbhgxWJcNT7mrnztHvdjFdg5BjnfKXZzUxvxhWT0R0kG42ojC/WBaM+5Lo7nrr2I4
	vbhTQzzlic40bk0Q+Phsp9J8kX0DGJro=
X-Gm-Gg: ASbGncsaXp/1goRQ1sdqMZJ3yX8kZm321mvBy9XCVcaRFnwOLItPW3Cf1Vcpmj4+7iq
	R+gb7W3LmNCfV9DkbEGPhHkaaBEqYDr91XXtYCC5ETP7R3l9BmBVmKXeabz2rFmxPTro0p6LMms
	hor1P9Yq6qmaQBbC5UmEGZ5pU+kYTAatGpMtBiI1rSYuM9Yj2SOoc/oBVj/qAiguOeGI/f+vF7e
	NyUAyXw/jYFl5GBu4YpC7nBra45cmzEm3IJScaTnR1YVQ/ZGKZBiUjwgabcFK6BliYNMkc=
X-Google-Smtp-Source: AGHT+IHGznhelPwKgdPOtpIE7u08vw3jm14atDXVn66Erhhaksa/6LYDtrqkXqGm7zWDplH+0e5xN6Ib8bNcjdNIzPk=
X-Received: by 2002:a17:90b:53c4:b0:340:d1a1:af8e with SMTP id
 98e67ed59e1d1-3491270ef84mr3755821a91.37.1764785316786; Wed, 03 Dec 2025
 10:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
 <CAHC9VhQyDX+NgWipgm5DGMewfVTBe3DkLbe_AANRiuAj40bA1w@mail.gmail.com>
 <6797b694-6c40-4806-9541-05ce6a0b07fc@oracle.com> <CAHC9VhQsK_XpJ-bbt6AXM4fk30huhrPvvMSEuHHTPb=eJZwoUA@mail.gmail.com>
 <CAHC9VhQnR6TKzzzpE9XQqiFivV0ECbVx7GH+1fQmz917-MAhsw@mail.gmail.com>
 <CAEjxPJ7_7_Uru3dwXzNLSj5GdBTzdPDQr5RwXtdjvDv9GjmVAQ@mail.gmail.com> <CAHC9VhQDHTNkrB4YuNoafM0bhAav=CP5Ux6ZZGY9+WF0+0_9ww@mail.gmail.com>
In-Reply-To: <CAHC9VhQDHTNkrB4YuNoafM0bhAav=CP5Ux6ZZGY9+WF0+0_9ww@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 3 Dec 2025 13:08:24 -0500
X-Gm-Features: AWmQ_bk8AJKB1D_utiPsmnzq48mAqxnxmRMWIq7jwXCZe5n9tvCfux9dhWFG1TQ
Message-ID: <CAEjxPJ6e8z__=MP5NfdUxkOMQ=EnUFSjWFofP4YPwHqK=Ki5nw@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Paul Moore <paul@paul-moore.com>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 10:55=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Dec 3, 2025 at 10:35=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Jul 23, 2025 at 10:10=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > On Thu, Jun 19, 2025 at 5:18=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Tue, May 27, 2025 at 5:03=E2=80=AFPM Anna Schumaker
> > > > <anna.schumaker@oracle.com> wrote:
> > > > > On 5/20/25 5:31 PM, Paul Moore wrote:
> > > > > > On Tue, Apr 29, 2025 at 7:34=E2=80=AFPM Paul Moore <paul@paul-m=
oore.com> wrote:
> > > > > >> On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
> > > > > >> <stephen.smalley.work@gmail.com> wrote:
> > > > > >>>
> > > > > >>> Update the security_inode_listsecurity() interface to allow
> > > > > >>> use of the xattr_list_one() helper and update the hook
> > > > > >>> implementations.
> > > > > >>>
> > > > > >>> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-s=
tephen.smalley.work@gmail.com/
> > > > > >>>
> > > > > >>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.co=
m>
> > > > > >>> ---
> > > > > >>> This patch is relative to the one linked above, which in theo=
ry is on
> > > > > >>> vfs.fixes but doesn't appear to have been pushed when I looke=
d.
> > > > > >>>
> > > > > >>>  fs/nfs/nfs4proc.c             | 10 ++++++----
> > > > > >>>  fs/xattr.c                    | 19 +++++++------------
> > > > > >>>  include/linux/lsm_hook_defs.h |  4 ++--
> > > > > >>>  include/linux/security.h      |  5 +++--
> > > > > >>>  net/socket.c                  | 17 +++++++----------
> > > > > >>>  security/security.c           | 16 ++++++++--------
> > > > > >>>  security/selinux/hooks.c      | 10 +++-------
> > > > > >>>  security/smack/smack_lsm.c    | 13 ++++---------
> > > > > >>>  8 files changed, 40 insertions(+), 54 deletions(-)
> > > > > >>
> > > > > >> Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Sm=
ack
> > > > > >> folks I can pull this into the LSM tree.
> > > > > >
> > > > > > Gentle ping for Trond, Anna, Jakub, and Casey ... can I get som=
e ACKs
> > > > > > on this patch?  It's a little late for the upcoming merge windo=
w, but
> > > > > > I'd like to merge this via the LSM tree after the merge window =
closes.
> > > > >
> > > > > For the NFS change:
> > > > >     Acked-by: Anna Schumaker <anna.schumaker@oracle.com>
> > > >
> > > > Hi Anna,
> > > >
> > > > Thanks for reviewing the patch.  Unfortunately when merging the pat=
ch
> > > > today and fixing up some merge conflicts I bumped into an odd case =
in
> > > > the NFS space and I wanted to check with you on how you would like =
to
> > > > resolve it.
> > > >
> > > > Commit 243fea134633 ("NFSv4.2: fix listxattr to return selinux
> > > > security label")[1] adds a direct call to
> > > > security_inode_listsecurity() in nfs4_listxattr(), despite the
> > > > existing nfs4_listxattr_nfs4_label() call which calls into the same
> > > > LSM hook, although that call is conditional on the server supportin=
g
> > > > NFS_CAP_SECURITY_LABEL.  Based on a quick search, it appears the on=
ly
> > > > caller for nfs4_listxattr_nfs4_label() is nfs4_listxattr() so I'm
> > > > wondering if there isn't some room for improvement here.
> > > >
> > > > I think there are two obvious options, and I'm curious about your
> > > > thoughts on which of these you would prefer, or if there is another
> > > > third option that you would like to see merged.
> > > >
> > > > Option #1:
> > > > Essentially back out commit 243fea134633, removing the direct LSM c=
all
> > > > in nfs4_listxattr() and relying on the nfs4_listxattr_nfs4_label() =
for
> > > > the LSM/SELinux xattrs.  I think we would want to remove the
> > > > NFS_CAP_SECURITY_LABEL check and build nfs4_listxattr_nfs4_label()
> > > > regardless of CONFIG_NFS_V4_SECURITY_LABEL.
> > > >
> > > > Option #2:
> > > > Remove nfs4_listxattr_nfs4_label() entirely and keep the direct LSM
> > > > call in nfs4_listxattr(), with the required changes for this patch.
> > > >
> > > > Thoughts?
> > > >
> > > > [1] https://lore.kernel.org/all/20250425180921.86702-1-okorniev@red=
hat.com/
> > >
> > > A gentle ping on the question above for the NFS folks.  If I don't
> > > hear anything I'll hack up something and send it out for review, but =
I
> > > thought it would nice if we could sort out the proper fix first.
> >
> > Raising this thread back up again to see if the NFS folks have a
> > preference on option #1 or #2 above, or
> > something else altogether. Should returning of the security.selinux
> > xattr name from listxattr() be dependent on
> > NFS_CAP_SECURITY_LABEL being set by the server and should it be
> > dependent on CONFIG_NFS_V4_SECURITY_LABEL?
>
> Thanks for bringing this back up Stephen, it would be good to get this re=
solved.

On second look, I realized that commit 243fea134633 ("NFSv4.2: fix
listxattr to return selinux security label") was likely motivated by
the same issue as commit 8b0ba61df5a1c44e2b3cf6 ("fs/xattr.c: fix
simple_xattr_list to always include security.* xattrs"), i.e. the
coreutils change that switched ls -Z from unconditionally calling
getxattr("security.selinux") (via libselinux getfilecon(3)) to only
doing so if listxattr() returns the "security.selinux" xattr name.
Hence, we want the call to security_inode_listsecurity() to be
unconditional, which favors option #2. My only residual question
though is that commit 243fea134633 put the call _after_ fetching the
user.* xattr names, whereas the nfs4_listxattr_nfs4_label() returns it
_before_ any user.* xattrs are appended. I'd be inclined to move up
the security_inode_listsecurity() call to replace the
nfs4_listxattr_nfs4_label() call along with option #2.

