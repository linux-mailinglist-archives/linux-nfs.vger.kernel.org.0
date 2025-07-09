Return-Path: <linux-nfs+bounces-12957-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E30BAFF166
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jul 2025 21:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD26189119A
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jul 2025 19:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD76D23D28E;
	Wed,  9 Jul 2025 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gNSh2cAx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8AD228C9D
	for <linux-nfs@vger.kernel.org>; Wed,  9 Jul 2025 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087888; cv=none; b=eIzTahU9SvpaNg+SK31Zaeu3Uv26+8Y/0qQQmaYFTCAzsrEHZyFfGQLIsNOAVA6lg8VXleNtV25AZTNIdI0TD+0+vBhYPX++708QrN4VwUzzLwm30csyFa9GzXLp0XVbzDon+vVMa6IoIiIbYgYMOjXXPJl4yZczwY3EDB1Pqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087888; c=relaxed/simple;
	bh=oRGJxOoY6Sb9QvNhIjZ1ZJhSnfSKCQdsXzj4pLtR8xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFpdQNqOOUX+LhbD/VhU4PwJgRK/t+yczcZNN+cBY2DuhXRO9bheYM7VOuTV6+BjPjEw1QOFgzl82HHvoF5qsjRapU6OsLlOtraMrvUbb75lcIz4wP1052v0IWan7hIfHEGuPHfTb9M8wIZuAUQGhj7GX7vS7LUi5PSorP639CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gNSh2cAx; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso234638a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 09 Jul 2025 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752087885; x=1752692685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oMoCHTAV5NeIpZMq+DMEKC+TktfxuQeI3NG81ytBeE=;
        b=gNSh2cAxDTBJoHztwizWyZZ3DiFKTi3wxKyznQsDnWmd1QbZGN06zsxFOINFhEp7IB
         yfLbtqYSVkGMDhyxZGxjcQN0jFYGzFPHVc2AZqXty9tL0Ju71UroMih9Mr3iu6qqV7nj
         lw3c1trpU/sgXaZdW46x5q3VycvC+Kx/pxnQQXN9w6q3xMS7sKadXvuhVHVnzfWr63rJ
         u3NymWMMO1a7A8hAtX4WzUdkDKBocrk80U9+CLlbQYfVpTVOE9lLlTSmGtusmKB//WrA
         AnSkmEGx+FU8/5DPnl1aVOIkMS+Pl+t1jRpA/y/1wOVURm5tvoZL7W7LiTNKp7/jsU5m
         hanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752087885; x=1752692685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oMoCHTAV5NeIpZMq+DMEKC+TktfxuQeI3NG81ytBeE=;
        b=nrbjJdCRG6BsOcsTNjgE+kS1EIxnXMlL9t5s4PJxnOyaZ+uIMmjwA+gRJGbUGppoOC
         O+qX9cmgRcbCyKyInUbKRqaBicQbNtrtxWZ4qTEbopcxt6doCg9FX+DmPIqMqiaGuFkQ
         HzacH8NKfePm0YAw0OIyC3QoxLfO3IK0eE8C889roW689knr7VngTGDkjosUoeJ/ospA
         /jCgVRHJKV2mszD/2eEBLqArWxyNY36o95jiOy8Aow3x0QafRJ98S2DZcLCK1ANLy3Tw
         xgqxCSZaJF4XouIjPgnobmIvtRihz4ZEcPxyoWTNuWSbkfT/F3nA84Xkibh8N9ZTEL/b
         22kw==
X-Forwarded-Encrypted: i=1; AJvYcCVPGYjTuW1O5SBDSgLKb1U1dFdCVZAjwqsXGFJvub1Azd2asoURe790R0prgcePaA3JiGHaNFoqcTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW7Jty69/QUdxEgCE8lJd1Qrnp4u94CCCGLtnbg1dVy9SKDYqL
	6W4ljSwV0HH9JgzhIJu0u+gsaNlZWpK3Agc3YAOo8fJvpK/TVqvWUSHsifkiJpUAdAuN60g/Yc2
	XlSvjkKYrBkP9rEyiQdxer8LKctGgTknObEpNuFq4O4pArcofu33Q77g=
X-Gm-Gg: ASbGnctX+hYQrQQ/35E9FBu5rfCPGpnq2NNFUP9wZomkQoihDyNfzHx4zu0vVt0EoMe
	5/TOmejSuZt6I7STHLVYcceo4Zfh59KaV6fefqtMIYQ43mKPI+BZHUVVlWGassEW5okukHVbY7i
	p1D82CblfVu+Vy8sKqQ01vhUZPwt/WEiieOeialwjz5slCrmTl/kNPQld8gzj/BPj1w5ncSNh2r
	aks7K3gHg==
X-Google-Smtp-Source: AGHT+IHHFatUYcYPUIaiNLDpnLA9ZJlzI11FgOes6AgoJS9tnoz2rAKkdasV4aiimfA44DVTmm7JJ+DkAfN2TlJGB04=
X-Received: by 2002:a17:906:c116:b0:ade:450a:695a with SMTP id
 a640c23a62f3a-ae6cfbea8f3mr343461166b.61.1752087884599; Wed, 09 Jul 2025
 12:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com> <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
 <2724318.1752066097@warthog.procyon.org.uk>
In-Reply-To: <2724318.1752066097@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 9 Jul 2025 21:04:31 +0200
X-Gm-Features: Ac12FXxBjj4Q8rQSAFMTvxq4Dux5Rk-Aycgaq2Qj_9vYK8pVlc0gHVgIsMegDWo
Message-ID: <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 3:01=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
> If you keep an eye on /proc/fs/netfs/requests you should be able to see a=
ny
> tasks in there that get stuck.  If one gets stuck, then:

After one got stuck, this is what I see in /proc/fs/netfs/requests:

REQUEST  OR REF FL ERR  OPS COVERAGE
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D =3D=3D=3D =3D=3D =3D=3D=3D=3D =3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D
00000065 2C   2 80002020    0   0 @0000 0/0

> Looking in /proc/fs/netfs/requests, you should be able to see the debug I=
D of
> the stuck request.  If you can try grepping the trace log for that:
>
> grep "R=3D<8-digit-hex-id>" /sys/kernel/debug/tracing/trace

   kworker/u96:4-455     [008] ...1.   107.145222: netfs_sreq:
R=3D00000065[1] WRIT PREP  f=3D00 s=3D0 0/0 s=3D0 e=3D0
   kworker/u96:4-455     [008] ...1.   107.145292: netfs_sreq:
R=3D00000065[1] WRIT SUBMT f=3D100 s=3D0 0/29e1 s=3D0 e=3D0
   kworker/u96:4-455     [008] ...1.   107.145311: netfs_sreq:
R=3D00000065[1] WRIT CA-PR f=3D100 s=3D0 0/3000 s=3D0 e=3D0
   kworker/u96:4-455     [008] ...1.   107.145457: netfs_sreq:
R=3D00000065[1] WRIT CA-WR f=3D100 s=3D0 0/3000 s=3D0 e=3D0
     kworker/8:1-437     [008] ...1.   107.149530: netfs_sreq:
R=3D00000065[1] WRIT TERM  f=3D100 s=3D0 3000/3000 s=3D2 e=3D0
     kworker/8:1-437     [008] ...1.   107.149531: netfs_rreq:
R=3D00000065 2C WAKE-Q  f=3D80002020

I can reproduce this easily - it happens every time I log out of that
machine when bash tries to write the bash_history file - the write()
always gets stuck.

(The above was 6.15.5 plus all patches in this PR.)

