Return-Path: <linux-nfs+bounces-2059-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF4C8613A4
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Feb 2024 15:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144C3281A82
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Feb 2024 14:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDBE7EF1E;
	Fri, 23 Feb 2024 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="ALvdoC1n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D57F7CE;
	Fri, 23 Feb 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697424; cv=none; b=mElLGR2+ZWdIPbUSwY/BWMefasntOxNXhAK4lsojRvyAKdq/c3u+zRMYN/skPA7T4iS1O0xehbgMGGDwk/WCJ8xgEQ5UICVTgAIPRTO3YVOXarAKD7FQyFSjVUWxUZJmFNbAs5Q5HlDqWcJSFaQFi3Lb9E+eCNsxzJn1cK1ZR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697424; c=relaxed/simple;
	bh=DdomKR0wDWtw1msIsHKsZbMqZerkBGz5yzEdAw5eRNc=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=Q9xzCE1xYvQTsKtT1ZxTFofr6ezbIw6YF4SkvAX3n8gV+ldsqdlQ6u/CiRPJQOtEljgGHO7Kj4OqBwa2j5JjqfG1y5r0i56Q1/X+PNVKM3VJCFkZ5v28/Elsh1xzmHKIVvKOzMsHIdca+Ug7ApROwgUsSgZSpV3tBPeq/7wVIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=ALvdoC1n; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
From: Christian Theune <ct@flyingcircus.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1708696810;
	bh=DdomKR0wDWtw1msIsHKsZbMqZerkBGz5yzEdAw5eRNc=;
	h=From:Subject:Date:Cc:To;
	b=ALvdoC1nl9f5fZXz6p4s8YOYNDvrNmlsf9Ola4oIjj8QSIjlTw6nsmCsfAJE+CYV6
	 xJd2kBCgZerrVJ35S0dZ43n81AmI0u3xBlOwXoEvWMpm2sAa0CpTEqIY/Gq5TL0FSJ
	 xM1D5KqgyChsHdBxVfh3mXXZzKHdeBLuGN0MdeLY=
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: nfs4_schedule_state_manager stuck in tight loop
Message-Id: <8B04DA70-ABEF-44A4-BBA7-60968E6CFA10@flyingcircus.io>
Date: Fri, 23 Feb 2024 14:59:49 +0100
Cc: linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>
To: linux-nfs@vger.kernel.org,
 chuck.lever@oracle.com,
 jlayton@kernel.org

Hi,

unfortunately I=E2=80=99m a bit light on details, but willing to provide =
better diagnostics as this moves along.

We=E2=80=99ve had two instances of NFS clients getting stuck with a =
kernel thread spinning around `nfs4_schedule_state_manager` AFAICT:

The first instance of this was last September on a Qemu VM running a =
6.1.45 guest:

root 315344 44.5 0.0 0 0 ? D Sep05 781:38 \_ [172.22.56.83-manager]

It happened a second time in last December on another VM that was likely =
running 5.15.139. (We downgraded our fleet due to other stability issues =
from 6.1 to 5.15 in between those two incidents.)

My colleagues told me that no issues were visible in the logs at that =
time, the systems were generally usable but interacting with anything on =
NFS was (obviously) stuck. So apparently no (soft-) lock ups and no =
stalls were recorded, but I=E2=80=99ll ask my colleagues to either alert =
me or provide all of the logging they can get the next time this =
happens.

Cheers,
Christian

PS: I=E2=80=99ve also recorded this in =
https://bugzilla.kernel.org/show_bug.cgi?id=3D217877 but switching to =
mail-based workflow now.

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


