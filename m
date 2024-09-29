Return-Path: <linux-nfs+bounces-6692-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6C0989468
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Sep 2024 11:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3013285DB5
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Sep 2024 09:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFF113B286;
	Sun, 29 Sep 2024 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Ezwybi7f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB922092;
	Sun, 29 Sep 2024 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727601602; cv=none; b=Zo6eF9uOplbl3NyvA5b3vDVcMFDB9MQUQtiPhLzGZQWmI+XBPZkWbGFqSPhBirVatMaaJKCYSDnNXFJKAmplBBbnYzUwFnz0Og/mX2jdqQzj2UqSPLhdmyKY8qC1E8jUv84Md3mfII661EGLjFzrCe6cRFkeEpX74y9EL04l2gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727601602; c=relaxed/simple;
	bh=NOlP0uEbJArlOkiWpUyGpd7tDRRkDAxP1mFI/WCzZug=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=hxppNe7GbZfvq3v6i9JhBkgHUQgN12cQ8v4H0qoNyE004nijQt763NdGYe+tYuLA1fAytkmcBzKWYAkHwQ7k3FmEKaRZZoLmmBDP3+NlSIm623nzTBPttb4aAmd5pE7X616ebUGKcHRs8ZGwQ/KxIGFoqfd8joyj3gIGNvoGmQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Ezwybi7f; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727601570; x=1728206370; i=markus.elfring@web.de;
	bh=NOlP0uEbJArlOkiWpUyGpd7tDRRkDAxP1mFI/WCzZug=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ezwybi7fu8sxcxzaBVomY+AGdW/RNDXwSgud++uWZL1idvWeePtWwbo2WChIxSR7
	 E/cftPjDtiuqTHbNhm+OUZbGyXldILhw/uDtT6kcS21tsUB45Q9YoKjviPCUcABI7
	 d/0MZ/lL2QelQX2HfS+X0Vud/+earnLRCzKiXugOnzvrx8L4tu6o68ofZ4VWRM+6D
	 woWKE2cuKATxkDAabK0bJfr3BSzyOpWeTolKXneWZcfK8Rg8aEzolwm0PJlMoYq4T
	 a/4xNx22zFVF5Uj+r/8s2DZNSilnL/Sc+22XjyDIwtEm4q4pPfN9dKk6P6pGPgWvR
	 QEmL1jMlwqJQhvPieA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1aIB-1ssu0v3P7D-003hAV; Sun, 29
 Sep 2024 11:19:30 +0200
Message-ID: <60f7626d-66c6-4ae4-bd40-03852fe2aee5@web.de>
Date: Sun, 29 Sep 2024 11:19:21 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yanjun Zhang <zhangyanjun@cestc.cn>, linux-nfs@vger.kernel.org,
 Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240927042500.205967-1-zhangyanjun@cestc.cn>
Subject: Re: [PATCH v2] NFSv4: fix possible NULL-pointer dereference in
 nfs42_complete_copies after state recovery failed
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240927042500.205967-1-zhangyanjun@cestc.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vsXL+w0DN2Q54ykYt+OdBYAK6YAJK44UfnNh+Nsg3ZW+SCkS+Dl
 qj/LZaHrWm/8iHGZ3gc0meEUbnPpaYGtluyUsBumUo0cm/VLPZMwEVFeM3B9hv/v+78690S
 7k6Qw23YPwsJSUuwP8NmdbqDbbwjOhR02hJC/ayBCGQSEwIdyZtu1f3OfdjLt8pm48Yh/yx
 nwiNkhFfpmV6cBhoDLy0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yfYv9T+6NRs=;uni9LNuNYLTkxn82LnTyom8A3XE
 zOQS3ycp8JEprgapusIVQsykMvVHgSNyqhZvHczSpzuzEYxo93tZqSU56B4JVaujC3jOLes7v
 eUxAm2xxNv0TikupvvqRYKg2+4d6GajIeOzuUJMwN8OZUO26vfXdwH9UaIeWRmNlq9n4R5Ulq
 RTQtHEbsd1ae098cs04lUQj7GejIQ1Lt6eXgKcEPnr61sUlORpBdIeFG9Wmle5GJwpdGGeHc5
 3axD/LN5jK8tpOyfWWtWIrGpyr77Ok36ck/2lxTONPNvXSujAYnc/op3t+D42aFbodIhKvEaU
 yZo2sY78QBSu4VOGEhNt6ZkW6gE6daMMagtMHOVUoyxFnTRo+yq+/jbkjp2AmuTk/1uaEfppJ
 MSXgAPrG8GItErtjThTvPoV1FQcPpvpFzcQ6cynqLa985SIgOvtdmSu9uZ7H6h3pV3DSYjOwj
 soi6Ddhh76vXJD1+YHOkyWzIFsIUqMfmiuDI5CC98+I9Yxw7eALg17qb9ykO9phuzV9f5QG91
 aMLAgENKMtAZyJ380BmUZvnNEtCbAG3vMH4hTTF0KcyaJRSY1SxU8E7QeyZ8rSDhz9b8ByO2j
 cE1ib794UhUuqMFs2JMS+znq9gr7x81kZzuC2AzuzHX6RdyhG93HD/vQrC+Uhf8uyaWOwOqGc
 tRetsUtxJ+X9o7CA2PVKPlftpcEtUlRvK5L75wrqCdK8fMvrZCSvKq9OIUxI+zUUl8CKHUnTE
 n6sKP4ixohABCv6QGtuLn009WsF4G8hhiubDvbvgAqnSP7m3RlARqOMi/ZtUrsnYmjgr9WAJ5
 nm7eSyl4sOMI2DDY9M+nJLUA==

=E2=80=A6
> We found that the NULL-pointer dereference was due to nfs42_complete_cop=
ies list the nfs_server->ss_copies by
> the field ss_copies of nfs4_copy_state. So the nfs4_copy_state address f=
fff0100f98fa3f0 is offset by 0x10 and
=E2=80=A6

* Would smaller line lengths be preferred for such a change description?

* How do you think about to append parentheses to any function names?

Regards,
Markus

