Return-Path: <linux-nfs+bounces-15153-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA507BD0139
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 13:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75AE1894CAC
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 11:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF972566F2;
	Sun, 12 Oct 2025 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GcXCQQar"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9022033997;
	Sun, 12 Oct 2025 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760268106; cv=none; b=nY9oJ3WEV4CcL3A3r1hc6tKkq2wwZoos32NQHZ+QFBavu9xW5xaFbOXCSVlASRjnDJRSetVKOiui5J+D/pcXROcBBH5lnxl42yfqwfza/G0+ELd5eVhDhsIL71IFrGycaXv2+DawcU9pEqeTovJKcvjBNVY1K35xgvilBUGsThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760268106; c=relaxed/simple;
	bh=YfpC+a4Dff0vR7Ch7T3ozqz7no80II+OsKF8d5lxzks=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kLwZPZt1WgVs/r/XfhKSCULR17EMP/FcYf4pDpxWXVpaIMxfJz5Ucs49FAj/+9uutTN+9yZBQxfSCLIFKzXBWpMOeAXdL4SvDrIumjw57TUXQiduVbeXbmAKaznF98mQgajMD8XxWezgJ3B7eV2HBy1MPztwiX+VlRHX8oAPF+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GcXCQQar; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760268088; x=1760872888; i=markus.elfring@web.de;
	bh=aUOzrzjwZqa5izViXxsF+ytFq5IlIakuG+i3WAMC1l8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GcXCQQarj/Z6CYX4RcV6hgEeRQekCGf9S6NaKkmhfHz2Ub0d7iEFSBeqzNHWgY3d
	 xfLqO2UnaKoiOWpmwLuYIS2qdtyqxY2yRIfhw1KKyCWYVBiP3SEcaOngYfuOB+Bsd
	 GNyXZVxSkjlNEx0qzRpiFmEbcjI+qMVJ+kCPCCuHrGGTFTQQQq6PIg6jOl2zREXcI
	 3D7zcyQ7x5f0cLJMVQGkrJZmLnttumzjzo/z2QwDMqH2ghIar9PtOunX/5rmHsdIr
	 ZPbIJQdUv0sy1j7cvidQVsFsiQqY7yVhni8U/3hOePt7g+aokBUUdohGHdcLkyElt
	 nKO4TKrcnxIvdZRJKg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwR4R-1uHrLx1337-0105rJ; Sun, 12
 Oct 2025 13:21:28 +0200
Message-ID: <27a45b25-98ba-4229-a257-2d29c88d975c@web.de>
Date: Sun, 12 Oct 2025 13:21:23 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Baolin Liu <liubaolin@kylinos.cn>, linux-nfs@vger.kernel.org,
 Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@kernel.org>
Cc: Baolin Liu <liubaolin12138@163.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <20251012083957.532330-1-liubaolin12138@163.com>
Subject: Re: [PATCH] NFS: Fix possible NULL pointer dereference in
 nfs_inode_remove_request()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251012083957.532330-1-liubaolin12138@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yBC/qJx23cexGqClviB4d1DrcRagOSR1t06ZR+vq4G7lwNyzZ8i
 0fONvgWlixWjdARqVWdAx400xMrV/DGduQNFB4dc2hQGS81KhulLSo0oa2jD3WedmgvWCnZ
 RJjIbpiY2RO0i9not5ILLos8sTLxEfP6We8p1JsojsOvgHV/AZ6KFrWyBde8L4vzy9nPD6V
 xdhb22XYS2UQSApVeq/Sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mHhsOVlrdQ0=;TUVMJfH52BdJwt6UUKCJLb9VqJb
 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

=E2=80=A6
> Fix this by checking folio before using it or calling
> folio_end_dropbehind().

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17#n145


=E2=80=A6
> ---
>  fs/nfs/write.c | 11 ++++++-----
=E2=80=A6

Can a summary phrase like =E2=80=9CPrevent null pointer dereference in nfs=
_inode_remove_request()=E2=80=9D
be nicer?


Will development interests grow for the application of scope-based resourc=
e management?
https://elixir.bootlin.com/linux/v6.17.1/source/include/linux/spinlock.h#L=
565-L567

Regards,
Markus

