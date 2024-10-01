Return-Path: <linux-nfs+bounces-6746-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F8698B6DD
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 10:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811731C22116
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 08:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4711719AD93;
	Tue,  1 Oct 2024 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="k7HGkDJN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14019AA75;
	Tue,  1 Oct 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771109; cv=none; b=tsuY38GsOniKh8YO1snaYfaHEZGX3LHtdZjbM8BwZ6bnQB1DEqkCmtWmKF2K/6Nl4YXbrppHBoQGOtmZcnyfhTNL1KCvBVaT/E/r0DfzB70jnYQ+ENV3tRqEGiH3SLRsqnEA7Yv1c6q4T5ILtoth5AfhJukYfRI2WLz/dbNfmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771109; c=relaxed/simple;
	bh=DDHzI7kb/2RcBFYnrDawxQR2TuGUGxI67S6MLCbIVwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YnKGTZ8uU069wtqsR2Jo7+Dnuse5uQvfdFQgkAmo0RXsyIQwpLUGB9Ege8vUOag8stgmZZe9ZtG0htHtTyk3nI4v5u2lWi4GV8mkpEK+3X2+IIp9hDpIkNc0jpfLqPQ5Y/KtXSigNu4SyM8Hrr5/myWN3ckyyyIC5xo1kqXzdQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=k7HGkDJN; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727771086; x=1728375886; i=markus.elfring@web.de;
	bh=DDHzI7kb/2RcBFYnrDawxQR2TuGUGxI67S6MLCbIVwM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k7HGkDJNQpCX0vQp92qZjBp5JFmM5wszBrcE1MaNSE/sU2OpJSqFHsacaAKt8eKL
	 eGZ31Ks18sFg/nRa3i1pM/BHG/G8zCpatmjt6SCIdm5Rn4l2EVGU6hT11xqtgfqq/
	 +i5W4CxvvHJ8GWLyy/vIrVbGB5d0NGwiQ4N2hIoocQPCLFjt2+xpJLisTQYtLWAVt
	 3BxMO61KIkhI5I01bx30pD9mGLGbkglrv2/7caTNa7fc8lggQLLoaC6Frk5Tnm4ji
	 wSpp0G2ztkzlOKn7pRu+y74/yq9bwEILqxagT2LwEF4le13/WHYTEzlsyV+J6e+T1
	 LX7Fuku30KLe9f5jfA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNwfU-1sXPb40ITA-00PsoT; Tue, 01
 Oct 2024 10:24:46 +0200
Message-ID: <15f48370-318c-48d0-8eeb-956f0efb0142@web.de>
Date: Tue, 1 Oct 2024 10:24:44 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] NFSv4: Prevent NULL-pointer dereference in
 nfs42_complete_copies()
To: Yanjun Zhang <zhangyanjun@cestc.cn>, linux-nfs@vger.kernel.org,
 Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Trond Myklebust <trond.myklebust@hammerspace.com>
References: <20241001080806.3874-1-zhangyanjun@cestc.cn>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241001080806.3874-1-zhangyanjun@cestc.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gGOnuFyy5Z4F8PwVhe3We7pBMCWb5UCP7UzlO7wEXVai/7PcmTu
 tOHwfjGlxahNt6psajsdfsOnrd+0FZ7OZ9O28O31AcVUIptEUPPb6dtonA9EHqm/11GjoNH
 9AEjS91OHCNqyPEpH1DciRfsGcReluDbXHZ/FA/Hm71NLhu+CT2W+AAfB4UL0SC8U07eO7O
 MFAPEv1w4ctRV2izRK5vg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RTmdvTOBiHk=;YF3fyHS+USjm5MBW+86YGEhtx64
 vypu++VpB/6NUBIR9n2l1zDhv8HaX27LcUvTxdK37OtWo1qob+YEOUcxz+BAJGioGniULGagR
 bdiRD6Ab43iY7ykQ//czWq0wudPeGwvnF2TEuDrxq5bC0s8hHc9I30KonKZ7qUmYnoNOQceEC
 rzsCyL+2fVaLsb4udXfJ3dUvccFJBjd4s4PYeqF08RBPGH3tZbDcH+4P3mEOTlmD1HdYxkkEr
 wkexH5hr00jRQkk7ThE61ycHYqYMpFnTvYTU/8b1PIVm6as3Y0xpfaApZY6cA76NAhgS9GlIu
 sW2yjyWJFEbHlkD1fqtAF/Fi4OTGzPvtXdtcnZHJfg/hYu7DSakone638mfrDRLoT1l9FbzTr
 nGFSbuPF07EiYU4ZT276FYFk5hrSx1XUYm+Yk7vsxD886MLVqZvmx+GTqviurf7OiHFg1ZEr/
 gjawBHTWJB0vqLFbZbWsFKZ6Ky8TRMFEX7uMBHkZwvOhGAp/0JMGdgPBRLCTxTphrw881VMOo
 hQElxYOU15VXVT0e1LnuRN58TGsDS3V2OG9okd14S2SFIwfxfjQiAPwQi3+vO3DdtulkZfTjN
 LMq+jFCOTNJHvjjaQ/LGOVDRh9hFN29MBNjEyxEU1icYGP/5MzBR7k0klcFLgxeSuRFSGQ8M9
 A1OJJcNCi6na5p54zosDgl9U/GfRsY1/i6whD2XaBh2efTBCZPe0NQywcnGDbaWbLGpMZPAQV
 HHH5nKys3h40fy8s55JiR00qndrbIUGsNXFSq6J02oUzXuAVWDZHYCE3a/jS2IU8l6bZpHB13
 MBI0/2nXZ4XsrLBSobpGkb5w==

> On the node of an NFS client, some files saved in the mountpoint of the
> NFS server were copying data within the same server. =E2=80=A6

Are data copied for selected files?

Regards,
Markus

