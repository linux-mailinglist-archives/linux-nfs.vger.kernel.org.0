Return-Path: <linux-nfs+bounces-5898-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E94D2963550
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 01:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF92F286A14
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 23:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DA11AC8AC;
	Wed, 28 Aug 2024 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Wkg3O8/j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECDB146A63
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 23:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887207; cv=none; b=XXEmjeIgZPImFIy8GHPqmtsj7yOxsyA4EzkPASLZzjVI8spI0aP0tFdojL5TLzMQIkVBUQ2apT8sHy6Lx+JKiKIOThz5vRwDUXrBOueCegEbcCM7lnsGkVagegCra2DyV3SCjZAhPaTiM4XEnpusD06FyTTyG1A2WO8X1Cv3bXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887207; c=relaxed/simple;
	bh=kn0vkO6V0PAPRFVsWe6I8iEFogeh2x764hmLrJ6swXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyO9lDnTOPtNd2ZY7iX9X3mYPjvbNSj5nCy/uSpUNSgL9IrnK77QIib9Hcnix4XlLJx0T8+kNfukIhS2spKEMqPcLI7SbdfDYszY6QAZS6wd6NewamHeIMZk3m1oyC36Yx4rjR9LZm4ti9kf1raqBFz489uWyZAC2QW/AVoCsoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Wkg3O8/j; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e04196b7603so89038276.0
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 16:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724887203; x=1725492003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FQJFjR5hrgZrSv5sKul5TVDs0oQUVlu7JZ5n/2LwSc=;
        b=Wkg3O8/j8AxsWaKecwx23DCVzLYelvCEErdKR4gyiUE0R1DrQsAwAYHAfl0us2sBVz
         pGcQoJi7ePZUxFHRjLLCHXP6QEFNrCE5dnjCNar17mm5Uq5F/HcCyVpvviFTEh180/FU
         mjso8uGjH4aOP0rwG+b6f0jZohI9TA/OkBlA/YZ1vLp5X1MVdCUkFhPJ6tUd5HzecsIM
         8qulXL2oSOvW+afWmThXHsTEh0PM0S7K9ehx1QpNBr9pTx8f8bkUjBHcA8s6OnGRwvvU
         UvyCiZ+5+f+2Dhzmj2+5Zwb4jRhg3p4ubWcyWy23LQoW1BASw7YzE9F0Dea0w3yR3iXb
         1u3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724887203; x=1725492003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FQJFjR5hrgZrSv5sKul5TVDs0oQUVlu7JZ5n/2LwSc=;
        b=pKznL0U0os6rkgaG0NefahCpF8LSPtq1nFswceHhgig8/oquctwTFEQaRpekmfnipG
         DqHNRcjER8QQ/2Lf5X8S5M832hWHj4685nt67YnYglcB5hC1uqHLK1dWo0IhNhLdfl/V
         KVXaC3eMU5os4cDXhcG4ZGswV8+JyAaQeTzTfrCDZmcqMiBFNmBNtAfNpPsvEVE3yNsV
         /YqD/gE+LMsh+6fHxxyyzs2wWfr2qO+hlxH/6pfBggnCDC/Gq8v86+Tx+9GNgby0WSzE
         Bb27x6kbXjRNjNSLB3wiGeOG6Ih/aI4ZblhRkVO71/d9v6zd6BPJ8JEtphH/BvtYUA5X
         2Ptg==
X-Forwarded-Encrypted: i=1; AJvYcCVI870C0ZTkocFupC6rVXRgY1Z6iY98tBAGI0FPH/vagYEDCl2QNE6GBhSyxWdyyvm1spas3tFG3bY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/IXdtKsXQMUtH6f+paDpbThJntnp2wSjMtUJpSi5YRj+50iZY
	6Rh8QlqIVC2lMswf8RXJxBx0dQpFg/KBZJxplU2X0MD2zgoSk4f0ya/8y8HRElB2/gfZ6EtUMNU
	9mlT2Vr9T67y5PGq+gsFUB/PnOge1ZCQ0rgvB
X-Google-Smtp-Source: AGHT+IFTYOW5VOGD9GZcL5lo+hU1JqOamlTTFi1bkFvo5uclhKL5TqbrY6TwGw8Lq/BKnuNDGUftuQSoC+tKeGjga1g=
X-Received: by 2002:a05:6902:10cb:b0:e13:cef0:2b7e with SMTP id
 3f1490d57ef6-e1a5af18173mr1127421276.54.1724887203338; Wed, 28 Aug 2024
 16:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828195129.223395-1-smayhew@redhat.com> <20240828195129.223395-2-smayhew@redhat.com>
 <CAHC9VhTCpm0=QrvBq_rHaRXNqu7iRcW7kqxjL8Jq9g=ZypfzsQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTCpm0=QrvBq_rHaRXNqu7iRcW7kqxjL8Jq9g=ZypfzsQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 28 Aug 2024 19:19:52 -0400
Message-ID: <CAHC9VhS3yhOxZYD1gZ-HF5XkGq0Qr8h4n+XrttUBsHL4cg0Xww@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux,smack: don't bypass permissions check in
 inode_setsecctx hook
To: Scott Mayhew <smayhew@redhat.com>
Cc: stephen.smalley.work@gmail.com, casey@schaufler-ca.com, 
	chuck.lever@oracle.com, marek.gresko@protonmail.com, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 5:05=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Aug 28, 2024 at 3:51=E2=80=AFPM Scott Mayhew <smayhew@redhat.com>=
 wrote:
> >
> > Marek Gresko reports that the root user on an NFS client is able to
> > change the security labels on files on an NFS filesystem that is
> > exported with root squashing enabled.
> >
> > The end of the kerneldoc comment for __vfs_setxattr_noperm() states:
> >
> >  *  This function requires the caller to lock the inode's i_mutex befor=
e it
> >  *  is executed. It also assumes that the caller will make the appropri=
ate
> >  *  permission checks.
> >
> > nfsd_setattr() does do permissions checking via fh_verify() and
> > nfsd_permission(), but those don't do all the same permissions checks
> > that are done by security_inode_setxattr() and its related LSM hooks do=
.
> >
> > Since nfsd_setattr() is the only consumer of security_inode_setsecctx()=
,
> > simplest solution appears to be to replace the call to
> > __vfs_setxattr_noperm() with a call to __vfs_setxattr_locked().  This
> > fixes the above issue and has the added benefit of causing nfsd to
> > recall conflicting delegations on a file when a client tries to change
> > its security label.
> >
> > Reported-by: Marek Gresko <marek.gresko@protonmail.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218809
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  security/selinux/hooks.c   | 4 ++--
> >  security/smack/smack_lsm.c | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
>
> Thanks Scott, this looks good to me, but since it touches Smack too
> I'd also like to get Casey's ACK on this patch; if for some reason we
> don't hear from Casey after a bit I'll go ahead and merge it.
> Speaking of merging, since this touches both SELinux and Smack I'll
> likely pull this in via the LSM tree, with a marking for the stable
> kernels, if anyone has any objections to that please let me know.

Merged into lsm/stable-6.11 so we can get this into linux-next and the
automated SELinux testing, assuming all goes we'll I'll send this up
to Linus later this week.  Thanks all!

--=20
paul-moore.com

