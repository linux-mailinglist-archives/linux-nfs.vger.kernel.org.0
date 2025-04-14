Return-Path: <linux-nfs+bounces-11135-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1811A88DB7
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Apr 2025 23:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF50E7A9059
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Apr 2025 21:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F701E5B75;
	Mon, 14 Apr 2025 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bwttBaco"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447391DF962
	for <linux-nfs@vger.kernel.org>; Mon, 14 Apr 2025 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665912; cv=none; b=eLlrT63/ImXy4mtK0YPk6O3f5X3oC62PTub/C6RYtuhhFoTAXP7MESpP7rJrmZqWLSq8Eh/jgqXGtyVAs82GgTH3bW21dTOmJt7ZrEJyNO1Q8KpNzsMFektf+Gn7adIfulWnM7q9TptN8tYp2vqtjhZwPPy1dsaP1SH5HAkeyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665912; c=relaxed/simple;
	bh=5oIbvRxF0USchrj14bSwUNNJ3s1SrhencSvPxyJGIJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dezxlJYxQtECtIoGbuelQbyr/7eqLKGDG0uED4vsfTu4d2aTGwSFXhcbOQFJ5xKxRc3KQ+qtsnj4Ud113clbOqf/3jK5XtNqBE35ubIZDQ+NAGs11nkBGi4nzmH/nKYy1ObrBe9HPTppr9nloczmF+ozL8rqyB3r6A1V+pFV0yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bwttBaco; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e6cea43bb31so3592867276.0
        for <linux-nfs@vger.kernel.org>; Mon, 14 Apr 2025 14:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744665908; x=1745270708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j27ta8bBAhn6IQi1yy9ANtDwz6vKmTPJJfYR3WIMUbQ=;
        b=bwttBacou5gU3hwI3tt2I5KA/pwt1ew1NfwSQ4vrX0JXegl1WNwUn2NArym+jITFG7
         L+kwEQpa2pbVNHYEa5VMWRxfUnLDsrH0Zu967hzVUWj67ZB7a4US2o+TUltV8IeoBGYe
         73PPoHm6wXMV+4GfC3S9QvwhLYpSjd3oraGTimgQFcIGox8OgjKtbCL8+0B3O5vqMkTZ
         K1ek42rurRiyDZTeERMEbzwTEStoCjFQSgc7zgwkC7XKidM9DQXHiWaq/GH6oAkaGe4o
         h1Sml/cw3IDgR7X4xSUN1Ill9X4DSRFiqLDvKRMyNYFRxwIKQr6eUPTkdquUbmW/M0Ic
         uxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744665908; x=1745270708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j27ta8bBAhn6IQi1yy9ANtDwz6vKmTPJJfYR3WIMUbQ=;
        b=mQQIgrwV98wOffYS6ny4aTwbXgkTUbdiIWHS0AguOf/XWrv4qzlba7/u59LMmOeTWG
         49gbBTIUPlB2DACoGJ2YAKVp8MLZgx5wjP3LbJcrWdh4NuvEqeZnraJes1h+6r4qZZ+J
         aRj/A6mIIuew+dLO6QzEAvWMcptuAAMlQUzNkBsnxjx7IEYV7jjKoD1QSsR3uF9dxkhV
         beW7SRG74DfXgBSoAtg1Dc+XPefYUksiH0ie/u20zH5pQ8Bma/ExQNj4eolaQDjAXVfV
         On207UGR/0vVC+rchwKiqXNkV+o+5Gg+6hLT1BTBuaS+eFgh54CS/9JCFDXogr4emVNm
         oFkg==
X-Forwarded-Encrypted: i=1; AJvYcCXv9jZLuLDkwIUduDdO1svbTFh58TIQZnY7itMmHRZv5h3zx474bZmZ3DzPEBzOdF6/85AiZu2trJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg+whC4iuLi6oIR5CeOO6vacefmGHSWtszgvmjiRw84YmSJTOu
	vK5ezHlX5r4/J9INRpbU2BcL/8eP8NlZw9SE2XOXGH5EJ0XKXPzL+TfaNocBoG994Xz6Nf6USxU
	+EbgtaijvNq3OXSfk5fAhFCIs5kZOGLSBZSu4
X-Gm-Gg: ASbGnctlOhkKWqNKKeFdxKc+txp8DVmLqrfn0yjOKbcuVe+iZrX/UlRYWav4dyhbVRd
	fVKGjO1sJ7FmqeBAF3Zd9kykOqYGFfQ85yXWcQ29QcH4wrObT0qbeeysw7uiUhKDkrKxGs4eO6X
	EkXUpmy7LCud3TSA8IXIdmHg==
X-Google-Smtp-Source: AGHT+IGl0TdqXW0b16XAp2chkawzwUgS7LaydCbIQklO9Q69WEz9Pb8N/MtkKMA2xzmwH4bTr27SA72y9m+KihNXjsc=
X-Received: by 2002:a05:6902:4888:b0:e69:192f:c778 with SMTP id
 3f1490d57ef6-e704de88c96mr22047504276.12.1744665908154; Mon, 14 Apr 2025
 14:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
 <8cf7d044-bedd-4516-957f-309f93b95f5a@oracle.com>
In-Reply-To: <8cf7d044-bedd-4516-957f-309f93b95f5a@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Apr 2025 17:24:57 -0400
X-Gm-Features: ATxdqUGEI0KraLnSMoBGg6LYbgdeYqRmKIaQ0UoYbAOiVmAQJDzx1Awjqxw_gBU
Message-ID: <CAHC9VhQy55d4Uptvs-6y1y9BvFA9zksvJkRH2BHk9QSo=T+-kQ@mail.gmail.com>
Subject: Re: NFS/SELinux regression caused by commit fc2a169c56de ("sunrpc:
 clean cache_detail immediately when flush is written frequently")
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Li Lingfeng <lilingfeng3@huawei.com>, 
	SElinux list <selinux@vger.kernel.org>, linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 4:09=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 4/14/25 6:53 AM, Ondrej Mosnacek wrote:
> > Hello,
> >
> > I noticed that the selinux-testsuite
> > (https://github.com/SELinuxProject/selinux-testsuite) nfs_filesystem
> > test recently started to spuriously fail on latest mainline-based
> > kernels (the root directory didn't have the expected SELinux label
> > after a specific sequence of exports/unexports + mounts/unmounts).
> >
> > I bisected (and revert-tested) the regression to:
> >
> >     commit fc2a169c56de0860ea7599ea6f67ad5fc451bde1
> >     Author: Li Lingfeng <lilingfeng3@huawei.com>
> >     Date:   Fri Dec 27 16:33:53 2024 +0800
> >
> >        sunrpc: clean cache_detail immediately when flush is written fre=
quently
> >
> > It's not immediately obvious to me what the bug is, so I'm posting
> > this to relevant people/lists in the hope they can debug and fix this
> > better than I could.
> >
> > I'm attaching a simplified reproducer.
>
> It looks like the attachment did not make it through.

It did for me, here is the script:

>>>>>
#!/bin/bash

set -e

systemctl start nfs-server

for (( i =3D 0; i < 50; i++ )); do
    exportfs -o rw,no_root_squash,security_label localhost:/var
    mount -t nfs -o
nfsvers=3D4.2,proto=3Dtcp,clientaddr=3D127.0.0.1,addr=3D127.0.0.1,context=
=3Dsystem_u:object_r:etc_t:s0
localhost:/var/lib /mnt
    secon -t -f /mnt
    umount /mnt

    exportfs -u localhost:/var
    exportfs -o rw,no_root_squash localhost:/var

    mount -t nfs -o
nfsvers=3D4.2,proto=3Dtcp,clientaddr=3D127.0.0.1,addr=3D127.0.0.1,context=
=3Dsystem_u:object_r:etc_t:s0
localhost:/var/lib /mnt
    secon -t -f /mnt
    umount /mnt

    mount -t nfs -o
nfsvers=3D4.2,proto=3Dtcp,clientaddr=3D127.0.0.1,addr=3D127.0.0.1
localhost:/var/lib /mnt
    secon -t -f /mnt
    label=3D"$(secon -t -f /mnt)"
    umount /mnt

    exportfs -u localhost:/var

    [ "$label" =3D "nfs_t" ] || exit 1
done
exit 0
>>>>>

--=20
paul-moore.com

