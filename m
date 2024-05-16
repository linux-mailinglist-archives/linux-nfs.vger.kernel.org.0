Return-Path: <linux-nfs+bounces-3266-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD6F8C7760
	for <lists+linux-nfs@lfdr.de>; Thu, 16 May 2024 15:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C800B1F21CEA
	for <lists+linux-nfs@lfdr.de>; Thu, 16 May 2024 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3215145FE8;
	Thu, 16 May 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=poochiereds-net.20230601.gappssmtp.com header.i=@poochiereds-net.20230601.gappssmtp.com header.b="OOXGkznZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD98145FE0
	for <linux-nfs@vger.kernel.org>; Thu, 16 May 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865434; cv=none; b=FR8MMo/YwENaCdYwEHMODuKPlniXN2RsJhskB634IK/dxTxjaCt/7Yr8/7co8GxBhHL4dcG7aZNMOPfQ1/+0KUIR5nfp/7qYLc69819Ok5LddXtS6pb01CpSolgFTu4rNYf/DZ8UviaiqmWxZvJywjbeFJ/yXYTlIq5eDBrmhNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865434; c=relaxed/simple;
	bh=Bj6fnlFm3znuz3Fym3IktlJr4xXWt/0/x5TDBU/4PB8=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=W5LiI2p0cmfP3fB2Q3KUHm7yh70rsR6rln17X6Qs/s/xwmVo/IhLEq7PhuK4iWqicLmpMU3o7uV6S4+UFf/sXtVK3Tyz5GBcfxLL4LTUQPlFwN3TrjRmgitVgkPwGuuK24AMFdMng3QTS0dy1Qo171lTrmzc3zieXrthvHpFG0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poochiereds.net; spf=pass smtp.mailfrom=poochiereds.net; dkim=pass (2048-bit key) header.d=poochiereds-net.20230601.gappssmtp.com header.i=@poochiereds-net.20230601.gappssmtp.com header.b=OOXGkznZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poochiereds.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poochiereds.net
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso55336295ad.2
        for <linux-nfs@vger.kernel.org>; Thu, 16 May 2024 06:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20230601.gappssmtp.com; s=20230601; t=1715865431; x=1716470231; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l5RSRhqANn75WFCrSXRP/oiQxeJxn32slhee+WWTjJ8=;
        b=OOXGkznZ71N7pLkPspBsw7EJKMoMI75cMIE3fb7LcRCm0DwXsunPjMUVmHW3Vf5Ahz
         1Sa2D93ygcurLwP4dG7OTAR5d6YidEY5jIPZAEMZsCbRdhRPFOp0EggovT3cW+P5bpnd
         kXd+FrBSnqomEe9LWAUGI1LMWnfqiTP0U7FyLpd6cvcY/kAD87Nnqld6K3vnjRvqPDe9
         0k7jDUW1HPdzIqzfc6MlvYggbJbbLkh5f86ERtm3KQKv02UrSDdn1IHw8PGIqNAtL0fs
         Zpq2avrX/XFn/yN729foSzqyK5YZIjzdbaTk9pfif/2OZNReu5RkIHtIpBi6iklpD0cM
         L5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715865431; x=1716470231;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5RSRhqANn75WFCrSXRP/oiQxeJxn32slhee+WWTjJ8=;
        b=vrAIcWWntxJ8p0cFXiF198Ccay8WQEOVTWTPnNJ1iz132Jdo5YKNTAi6mlyJSigu9m
         Qam/DJSU1m5eObksJM6g4sjPTJpL/TNQwqcczWyC6T0z02y+qI0Q5BWSO8P7+4Ie9I+n
         5ZGS85/Q/gsiLyXmqFCu3b8s+YpWy1zjl2t96MvBqNVbSRD3F0Ql1rPgqEaH0QtZxgZI
         ie3ztyrhXV3DQzYDhrD2hGoVmf5iliH8+P0b1I8OtSKxSW8pXWsUmjYRygOPC5hR+No3
         l9XsX6eUdqUj0VUVToZo/j5uMOy0CmSoQMDsG1tjfRAO+Vx923U60RJQhCSIfnlJXjTO
         URYw==
X-Forwarded-Encrypted: i=1; AJvYcCUwm5fBjN1sZ1B79G/sSD+T/J+/+CmZ8IHH3ccRYJSv9tIWzMaxGiTPgSUXrkVQ1o3bLbljSvUalz6OB2f6Tt1o/2aDDrq9heIb
X-Gm-Message-State: AOJu0Yzmo7ctBynuxdGOBf/V2JKn2Oad2LRCNbMNh/daw80SC6BuEtyH
	0lsVPu6qoUTJWRPUFZz9e9Ch34s9BEnh04HLXUBJZ6fWH6O8xDliq3900WdUuLk=
X-Google-Smtp-Source: AGHT+IFY6KcoJCcf8lb6B7nc3f1VK2djp+1E871z/7JV2cLIK03mGcuiD8M0N7vJMEtsT7pmWHwGhA==
X-Received: by 2002:a17:903:228f:b0:1ed:36dc:a570 with SMTP id d9443c01a7336-1ef44050742mr221259205ad.49.1715865431186;
        Thu, 16 May 2024 06:17:11 -0700 (PDT)
Received: from [172.21.18.22] ([50.204.89.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31da2sm141134835ad.165.2024.05.16.06.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 06:17:10 -0700 (PDT)
Message-ID: <a40089cd2c7d492859dec6a7ef134d8f68aa761d.camel@poochiereds.net>
Subject: usage of inotify in nfs-utils
From: Jeff Layton <jlayton@poochiereds.net>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date: Thu, 16 May 2024 07:17:08 -0600
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Al was asking about inotify usage in the rpc_pipefs dir.  If you want
to check further, all the binaries that operate under there are in
nfs-utils:

     http://git.linux-nfs.org/?p=3Dsteved/nfs-utils.git;a=3Dsummary

I took a quick look, and cscope shows these watches being added (with a
little annotation):

mountd and exportd watch creates and deletes in the nfsdfs clients dir:

    0 support/export/v4clients.c        40 if (inotify_add_watch(clients_fd=
, "/proc/fs/nfsd/clients", IN_CREATE | IN_DELETE) < 0) {

...if one of those directories is created, it watches for modifications
to the "info" file in there:

    1 support/export/v4clients.c	   117 key->wid =3D inotify_add_watch(clie=
nts_fd, path, IN_MODIFY);

...blkmapd watches for directories to show up in rpc_pipefs and in the
"nfs" directory below that:

    2 utils/blkmapd/device-discovery.c 358 *wd =3D inotify_add_watch(bl_wat=
ch_fd, dir, IN_CREATE|IN_DELETE);

...gssd has a pretty complex set of watches. There is a comment at the
top of gssd.c that explains them, but it watches for directories to
show up under rpc_pipefs, and then sets watches on the files under
those dirs (I think):

    3 utils/gssd/gssd.c                656 clp->wd =3D inotify_add_watch(in=
otify_fd, clp->relpath, IN_CREATE | IN_DELETE);
    4 utils/gssd/gssd.c                765 tdi->wd =3D inotify_add_watch(in=
otify_fd, name, IN_CREATE);

idmapd watches for dirs to show up in rpc_pipefs/nfs, and then watches
for directories under that to be created:

    5 utils/idmapd/idmapd.c            410 wd =3D inotify_add_watch(inotify=
_fd, pipefsdir, IN_CREATE | IN_DELETE);
    6 utils/idmapd/idmapd.c            930 inotify_add_watch(inotify_fd, ic=
->ic_path, IN_CREATE | IN_ONLYDIR | IN_ONESHOT);

nfsdcld watches for entries to show up in rpc_pipefs/nfsd/cld:

    7 utils/nfsdcld/nfsdcld.c          276 ret =3D inotify_add_watch(inotif=
y_fd, dname, IN_CREATE);

Al, Let me know if you have more questions, but it may be simpler to
just look in the nfs-utils tree.

Cheers,
--=20
Jeff Layton <jlayton@poochiereds.net>

