Return-Path: <linux-nfs+bounces-2205-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35E08715BC
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 07:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214471C209F9
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 06:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B34146521;
	Tue,  5 Mar 2024 06:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="QBOeYQWj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBF9FC1C;
	Tue,  5 Mar 2024 06:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619331; cv=none; b=WvpmEPTA17UwbU+Y2OXSQnfjrAQ3uod8buOkqJ/V07qgLCdRJ87mEXVqkbuBqOF79utd75gjsPEg1ocvGKSTuByEMBsga1vMbIjoML978YsEtwYHDcUIMFOuQxFLbmci3/06U9VHhwBinM/2kU+NDhYgzzDplLrE7cgWpErS+QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619331; c=relaxed/simple;
	bh=k0S++Cu8Iyr6uXBN6ACI05p0wIHJD7IqUIi1EDWRXX0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eZVnPMNZIHHK4+XKEXiPz2i3joHpkb69Vxk3nUOU6pAE+3tyaigjqd7Rxpsk5ag+YNCRqIgw19Mtuh4lIyrY/pcCrJL4Wmb3HtapBe2SuDbMpwgA3yiJGjuJ5f4Qn2CawC++8kzkcveMwEXCEcIAJkMdhCTG+BYoma2Q9k4nNx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=QBOeYQWj; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1709618979;
	bh=k0S++Cu8Iyr6uXBN6ACI05p0wIHJD7IqUIi1EDWRXX0=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=QBOeYQWjPjcVLq2dQ5HyXh22PMZs7KuESHcPaGtHEHmWgwM115uQLZdf4M0c48GBi
	 ovEehHg1WSiwOjpDCXFmFJy7F+yOQpUPAthHdGOkOmNbbHebQ2hTKr7MIMjXZJQWnT
	 lBL4chzEwOh1OHe4bq0TvoSNd+lkl725lOsu4NkM=
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: nfs4_schedule_state_manager stuck in tight loop
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <ZdisssP88_9o0BXn@manet.1015granger.net>
Date: Tue, 5 Mar 2024 07:09:19 +0100
Cc: linux-nfs@vger.kernel.org,
 jlayton@kernel.org,
 linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 trondmy@hammerspace.com,
 anna@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3404A3C2-31BE-4D39-A256-E3A1FB48ACFB@flyingcircus.io>
References: <8B04DA70-ABEF-44A4-BBA7-60968E6CFA10@flyingcircus.io>
 <ZdisssP88_9o0BXn@manet.1015granger.net>
To: Chuck Lever <chuck.lever@oracle.com>

Hi,

not sure whether I may have missed a response that didn=E2=80=99t make =
it back to me or any of the lists.

Just in case, because the CC didn=E2=80=99t include the original =
addendum I made to my report:

Addendum:

I=E2=80=99ve checked kernel changelogs since then but didn=E2=80=99t =
find anything that I could relate to this aside from *maybe* =
dfda2a5eb66a685aa6d0b81c0cef1cf8bfe0b3c4 (rename(): fix the locking of =
subdirectories) which mentions NFS but doesn=E2=80=99t describe the =
potential impact.

We=E2=80=99re running 5.15.148 now and as it=E2=80=99s been another 2 =
months there might be the chance of another lockup in the near future ;)

If anyone has ideas on how to debug/approach a reproducer I=E2=80=99d be =
more than happy to help and try to provide more data.

Cheers,
Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


