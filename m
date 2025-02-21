Return-Path: <linux-nfs+bounces-10281-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B56A40140
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 21:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4C4861A21
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 20:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAE01FECA0;
	Fri, 21 Feb 2025 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIO768xG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD78D1DC985;
	Fri, 21 Feb 2025 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170539; cv=none; b=eFg6dwnEy7aGcAyqOBjAa9RIpzAHOX6nHf9rArupygElwCLdquWT0rFm8KEXEke9tr4Q6WitKe07OdB0hGY9UMMJY5i6mZpCQz+qD4mt0jlfLl5ReV5hJ2U3hojIFB0jslemTLneWFD3toKp9tTaTnULeuGp2iMNuleneKQOnBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170539; c=relaxed/simple;
	bh=U5rTMVi1++gsFlceeyJdnEXUJdRalutcOE7pJe2jVIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NM40CP7QmhfHl2Pp23d1zRfK2ve7/mIgCWtHZbs93reKT2R//A8m0tGWo3gqq2FiZ7nbnQG8wyx9lfIVRUmOxd9LACVFti6HHnpI/d1qrnrgtqe4PjZer2/nZZ3Ox9fNG20i3ToqJD1TA7JLyTGAFR+ZOX7JwRFPMY1OCcFDWYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIO768xG; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc0026eb79so5215840a91.0;
        Fri, 21 Feb 2025 12:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740170537; x=1740775337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SaH7fEvbfAsSnAocvgMudzoHP2p7qAMoKD/g3l3MNI=;
        b=SIO768xGlKcB67Tfj4+Nv0Lc9YO+myWQ+x2q8/czZagZEBrOB+sET/dV3ll7xY/22y
         DXayNeCbGG9gAzt1N0BrE4FSLYtjy59Rs2j5sWlshsaT2wszsIBuCSdEOs6lmie0IZNX
         PVODEYNqkkNSsPKsp3I/NbdL7Ryhdl3GkcgRXWyUhxucBvWI17F9wmykXvanU7sQAQ38
         VTmbIwHqxMsx4lVK0wzrMqGVgbanVkYxXthgWMsGJ1DoTdbuCQqcOunQ7FifQu5MUxLs
         7W+36KuRbCpprp8nDBZqoCGTbvhDZ19SphavzXD7feHhRAdPfIuBZrnBLhrhuTRsAleW
         Chog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740170537; x=1740775337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SaH7fEvbfAsSnAocvgMudzoHP2p7qAMoKD/g3l3MNI=;
        b=L11u70UEvfMnvRD1yNzl19Tfaf/LKVV2Lk075VsvVLG5ogPT2/6cjU9/hsojZlt2Wc
         U8TowSuHqFfe8wNCosBQ16SNpDcKH14ZMeRpS5+A/U0j0v0Wq3YlO7nxzj0zkIz0aoGv
         gJ4/pU6m6nncDVL5RHMoCATZpKn6OGsWxtINmiXBECC3UrqxljYSb6w4aYTOsRKHMda8
         iS+UrCY81/8x8KpF8G89/AlTTTLH0/tW0Qm1EaWLyls24TMUnCy+/THeoa87//kOiLlc
         WDio6P7hx/p4SaYQwPpw94lM56hc5Hqb/RnfgeTwdeZ+4eQ7KIcmW+5phWAeY0ryGTfy
         R9uA==
X-Forwarded-Encrypted: i=1; AJvYcCUIkfxQhbYSywQs630ZybmyUWQVhW0KtHa0+GHk2oqlq6VwNzfluVJWTA6ZOsHFs0mvoidb3eBJihDiIlXdo34bWboX9Y0P@vger.kernel.org, AJvYcCXJoV60VmfdVGRtMk4IstYwB4hHuz0WRnwaD27S71gXK/9mzZbSkUx8yrZYx91e2InXBVOWNUAlaUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEWw36pC0YDKHFx5a5K2NQ9ZVIixEJ9d9NDsewoEYlFNsAgXd7
	RehxpaO3Yzc+TH/7sKQHI3hGkIeVSFSElQ5N2iR7MxJ39XWlf/rZ19/UoYReG0BtNqTj1FDDKzn
	VLsKNvRgDUY/ShNd0Auq87JKUNuU=
X-Gm-Gg: ASbGncvzVpwI1y278WocQTwvuI6pb9RjGbeKemUbfUol7PcwaUjPEWPBhV2zJou1ODR
	xIMCyUxqVrNtiOq46ZbgxKLDDPuoYP5P6miAzpQaYiMM43ClQHeaUMpSC1xZ7sv9MJRcW8oma/f
	vyzzdqjkw=
X-Google-Smtp-Source: AGHT+IE4sg1dmuq68vSacDnEDZeAAbSN8pAfF/ZywLJZq1ENGFFze+ltsFnjWO8eb9qay6NRGvbZzz+kH3FpQ2K2R7w=
X-Received: by 2002:a17:90b:4b01:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-2fce77a01b4mr6988704a91.6.1740170537012; Fri, 21 Feb 2025
 12:42:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220192935.9014-2-stephen.smalley.work@gmail.com>
 <CAHC9VhTXzweNA+h37ZBMjymbuar32tmr4aa9Qphk8JM4ya+y0A@mail.gmail.com> <71543c38-0103-4256-9553-04320b3403d4@schaufler-ca.com>
In-Reply-To: <71543c38-0103-4256-9553-04320b3403d4@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 21 Feb 2025 15:42:05 -0500
X-Gm-Features: AWEUYZmwYge9BS1xqWLZoVzxtgRdKIBDz8YLv8iSI4Lr3hNxpPF68Yi-f7KGhoc
Message-ID: <CAEjxPJ4+0HvbvBx6=XfMzD4uo1T2WHEFCZfGzt89X6CHB3DdcQ@mail.gmail.com>
Subject: Re: [PATCH] lsm,nfs: fix memory leak of lsm_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 3:26=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 2/21/2025 12:10 PM, Paul Moore wrote:
> > On Thu, Feb 20, 2025 at 2:30=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >> commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_securit=
y")
> >> did not preserve the lsm id for subsequent release calls, which result=
s
> >> in a memory leak. Fix it by saving the lsm id in the nfs4_label and
> >> providing it on the subsequent release call.
> >>
> >> Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_securit=
y")
> >> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >> ---
> >>  fs/nfs/nfs4proc.c    | 7 ++++---
> >>  include/linux/nfs4.h | 1 +
> >>  2 files changed, 5 insertions(+), 3 deletions(-)
> > Now that we've seen Casey's patch, I believe this patch is the better
> > solution and we should get this up to Linus during the v6.14-rcX
> > phase.  I've got one minor nitpick (below), but how would you like to
> > handle this patch NFS folks?  I'm guessing you would prefer to pull
> > this via the NFS tree, but if not let me know and I can pull it via
> > the LSM tree (an ACK would be appreciated).
> >
> > Acked-by: Paul Moore <paul@paul-moore.com>
>
> If you like that approach better it should use a lsm_context struct for
> the nfs data rather than adding a lsm_id. Would you entertain that change=
?

I had considered that approach but doing so would require changing
every user of nfs4_label to use the lsm_context fields instead of the
current label/len fields (unless you are going to duplicate/alias
them). And not all of these originate from an lsm_context IIUC.

