Return-Path: <linux-nfs+bounces-2697-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B2C89AD8B
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Apr 2024 00:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FEC4281B3B
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 22:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDBC4EB29;
	Sat,  6 Apr 2024 22:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6JkNvte"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C708F54
	for <linux-nfs@vger.kernel.org>; Sat,  6 Apr 2024 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712442388; cv=none; b=TemO/7c4Wj0dRi0d0MOScDSIrg1I60x0GyORMSVG34xQRZQbnRT6L7KyEFjsKjyQSVp4Dd6IjORIxM7BJN2v65QULyTFpZfHPmFP1xjifZzLh1JNlLpn0myXTYOIGGDKsvJ4cqARTTziR33CHhvy2Z+5GuzXISlwKTjB2feiEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712442388; c=relaxed/simple;
	bh=jIhAN0Qr/xHcrbPdCob9fd/eBg3WY65M6PLS9m87KYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdLRCMMFw6pezpaG/jhy4yw+SkTlBeqTcBGlDpFPPd6IAhu7fE1/x4zX8arIpysUukYfkmXuExie4lrpMqFMOOH5XzD3SsB1Nma8xoXV4L2RW1QfGYHAckAbJ0et+oicyF+4BrSs2vnvgD8hHHeICswf8UiBMVCCUyR4Gb0z+EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6JkNvte; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so44304401fa.0
        for <linux-nfs@vger.kernel.org>; Sat, 06 Apr 2024 15:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712442384; x=1713047184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIhAN0Qr/xHcrbPdCob9fd/eBg3WY65M6PLS9m87KYg=;
        b=C6JkNvte1Ec0hX7jo7cr3E/JA+VbPGA+AEOPNQGaHfBwQiLLoULBlI/rhNku3RRZga
         6VkPCUtwwG05UgSwHZ96R3osvd36rzFai2TscgXdytOmtX1kHrs9/evyh41JGXSyw947
         GIqzpHFnUivgwvPHL50rPT1Q79IKJDMmQBL/ayumsztFOUc/QVj6Ixs3Op0BYkV3Jfw8
         YOkR6ALLDxgvetH/jNa/lDXAGSHe6wL0egIpKNG8UnvQXW27wiZIPhbpZ8Kb21ADD3Xc
         8+OkxvXeVdnthulrnSwg3AgzHcX9qPgh/Glt21tY26Hc0caveJL0oVwKmYzKT8BpcwsE
         Ds5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712442384; x=1713047184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIhAN0Qr/xHcrbPdCob9fd/eBg3WY65M6PLS9m87KYg=;
        b=o0UfOJDg4JKpnUthrS0jeEq9HEBLj8a/85IltftA+iodKUGJsLQAs1wvXDETYpiB83
         e2d5/yVhFRdByFbpy4morHF3nG4XoSQNxfGUf3WbYpL/95vgXxgh9mp7K04noRLQ2J4W
         +JUFhOSlGaBCmQRV8tJAoASOEHRizlt7gOEt12/045PRNWXnejE9wpp4d+bfzEZ5fiG7
         Q3Q39iK9c1NhjXnieFsiD4WEpRkAtxhNVy5YBmUbNj9YREqqPf3qelQxj03WQQ7o3EO9
         Fy1J9erT75vyrtHeflxOqd/1Qtu8XR+18QjXo2NnJtR5eos1YerXoImLQjc+IdlNoJD8
         AITg==
X-Gm-Message-State: AOJu0YyQ4ftp2gjdrZk+v0dUXe8RtDDFkz9XZF6MLziwjBny5FFKrq6Z
	Op1l7ohskZ2ppHd6aN2aeiBV7kFyY56YwXghlit9O5NIAVpDCnV7DbhmaU7bTimj0qLDi00kx04
	5vfuu7mjgkYUzF0GPli/EwlcNdCEcEpB9/cc=
X-Google-Smtp-Source: AGHT+IEeDBLA6hT98ximOTZTREcehyIFVclI8/5gfOIXmoT9YZ9759LL2hw+enUHf9IFdxkHGL4G/wkTRQUZspkKEaY=
X-Received: by 2002:a19:434b:0:b0:513:dac5:ee1a with SMTP id
 m11-20020a19434b000000b00513dac5ee1amr3088908lfj.25.1712442383908; Sat, 06
 Apr 2024 15:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEdQ38GJgxponxNxkcv+t8mhwRPzOjan58MTBgOL8p9tY=rvTw@mail.gmail.com>
 <79c69668-4f8e-448e-9f50-6977cda662fc@redhat.com>
In-Reply-To: <79c69668-4f8e-448e-9f50-6977cda662fc@redhat.com>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 6 Apr 2024 18:26:10 -0400
Message-ID: <CAEdQ38FOP0_g0FK5DYz954OwfJjLUf2pjQL1CX=VNC60kd8HEw@mail.gmail.com>
Subject: Re: nfs-utils' .service files not usable with nfsv4-server.service
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 4:37=E2=80=AFPM Steve Dickson <steved@redhat.com> wr=
ote:
>
> Hello,
>
> On 4/5/24 10:29 AM, Matt Turner wrote:
> > Downstream bug: https://bugs.gentoo.org/928526
> >
> > In Gentoo we allow disabling NFSv3 support, which entails nothing more
> > than not installing `nfs-server.service`. This has uncovered an issue
> > that many .service files reference `nfs-server.service` explicitly,
> > making them unusable with `nfsv4-server.service`.
> Very interesting... not supporting v3... Just curious as to why?

I don't think there's a particularly compelling reason. I guess it
lets you avoid a dependency on rpcbind.

> >> server ~ # grep nfs-server.service $(qlist nfs-utils | grep service)
> >> /usr/lib/systemd/system/rpc-statd-notify.service:After=3Dnfs-server.se=
rvice
> >> /usr/lib/systemd/system/nfs-mountd.service:BindsTo=3Dnfs-server.servic=
e
> >> /usr/lib/systemd/system/rpc-svcgssd.service:PartOf=3Dnfs-server.servic=
e
> >> /usr/lib/systemd/system/fsidd.service:Before=3Dnfs-mountd.service nfs-=
server.service
> >> /usr/lib/systemd/system/fsidd.service:RequiredBy=3Dnfs-mountd.service =
nfs-server.service
> >> /usr/lib/systemd/system/nfs-idmapd.service:BindsTo=3Dnfs-server.servic=
e
> >
> > The only service file that depends on nfsv4-server is nfsv4-exportd:
> >
> >> server ~ # grep nfsv4-server.service $(qlist nfs-utils | grep service)
> >> /usr/lib/systemd/system/nfsv4-exportd.service:BindsTo=3Dnfsv4-server.s=
ervice
> >
> > How should `nfsv4-server.service` be used?
> The idea was to make nfs-utils have a smaller footprint for containers.
> No rpcbind, lockd, statd etc.. exportd is to replace mountd
> and only accept v4 mounts.

Seems like we would just need to modify the build system to not
install `nfs-server.service` and other NFSv3-only service files and
modify the remaining service files to reference nfsv4-server.service
instead?

> Unfortunately the idea of having a nfsv4 only server
> did not go over well with upstream.

Which upstream do you mean? nfs-utils, Linux kernel?

> But, I will be more than willing to work with you to make it work.

Thanks!

