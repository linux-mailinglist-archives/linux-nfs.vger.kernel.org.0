Return-Path: <linux-nfs+bounces-6710-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722A6989DE0
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 11:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E101C20981
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4DF18D63F;
	Mon, 30 Sep 2024 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lEvlYdAE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F1D18CC0D;
	Mon, 30 Sep 2024 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687778; cv=none; b=DcY6tsMl1Olhfn/OTRMs4J0Tr/xCsjSKcjib2OHdDXFgBKH76BwZhBi9MOjdbYsN6q1PgX+c8Wa6NBe9wXfg2sEeImarDzcf39PtmmxrrFd5jANYE4nQw0AbAFHTtdL/gn8EufuuBOrasrZnbcztgrV7a3RLc5+jRWYyKlDl01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687778; c=relaxed/simple;
	bh=3ZaS5ci2O/iXzesvxtnx5ZTTVXJ8/KT4uu0R/JeWq5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQGjEVXESkhMT8ntezyES1VoZDA9R8h5NVvxBb6uLJcEJGNa7YpTIIQvP2bP0bqvn16OFdNW5QEiS5Iq9AnKkNCvES8oLf+7dc5tWYQy0pOAZINgDohN5xHngvqWh220ZNp7s2BvAbcMk/vOXtcWi6GqZp7uHYGSC2a/+lmkSVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lEvlYdAE; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727687750; x=1728292550; i=markus.elfring@web.de;
	bh=uwTjh6i3049CPUq0sWZShkHXqlpCPCZ6b0JNmqkVCF8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lEvlYdAEodHS/FN+K11XryRwIDny5ZHJZQWEnUofWNwZQIo48oOnyHkDgejwpcgL
	 st4Plwag7eG947raSTc8DdZPMYcmhdeeBNlpn9oSiqawCbD6jtQNrKRZtnWR+wkQf
	 IJtHNLwNoOEYoSdPMXl0qp/H/kA27VBNb441f476uV/mOWkCTjwNyfXmdSIudkkO4
	 EGwCtApR6XV2GzPJofA//d0iccynJXYUhJGRqFI8o37WKkFX6zQTvp8+MaJvHx0Xe
	 WbQiRO7MiDWj0z7xwVvvQ6FvBo0FgVD4Dtc+WKFfDGpEzWahVvg+iwakKQ2CgRQKb
	 DStrEbXyaJ94tFdEpA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mkmzr-1sBvGz2wWN-00khad; Mon, 30
 Sep 2024 11:15:50 +0200
Message-ID: <092af1e5-0d36-4f9f-94f1-083f0d61f63b@web.de>
Date: Mon, 30 Sep 2024 11:15:42 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] NFSv4: fix possible NULL-pointer dereference in
 nfs42_complete_copies()
To: Yanjun Zhang <zhangyanjun@cestc.cn>, linux-nfs@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Anna Schumaker <anna@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>
References: <20240930090115.463284-1-zhangyanjun@cestc.cn>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240930090115.463284-1-zhangyanjun@cestc.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L/VeQR3V/XY+olTzSE6cZ79rl/AcJeh9uFl3GC/NmfJdu9Y2yjM
 9ojNsnnyGxx9z4ymm/98iON/6xdPEr8d/VSldwFJahf4UoyJ0KdP7xslqNAP8/Eq3ktWGPN
 bU9+RgHUHTUx+e7BSdpBhYUntX86zD64g9yl4puYyLm3ee38f1eV76hhiRcZoJz4+fnYRW7
 ECsJl9HuuUHAUvBEfQkXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6Hmd6C3Vcoo=;q1FF7MjhdqacCiCgp6/lkVR5ftc
 FipYr4RbF5oXlAK6AHPX+p+ZS8smZ+mQlv69Kw5U03iIMCWTyMwrJMvmfg2EZJX92xc2nlDZy
 y0ao7Qpv+E5ZHmZ7ImPiig5YrwqWENm9rKNkmfcBlsPd0uNR0gErHZwVQBD1cq/En5gphlpVz
 oF/yGsX9AIRW7nynxInrmP5UawtJ/lnAydNZiY8NJBUMU9lYLfMfJdyH81Cwa2vEr4ggcw4/y
 /2gk8JLGOJ+kOg27J+eXj1lHupeFsUBPF6u+JIKMebRhSSeENHlZdYLpnsztWBADOagi5If5G
 UbBW1GQupR5nBUgPerwVDFECzSSWziYTKTNtaEgLNKDz2cSvojpDxrMBEspjbki8KyZegrkA/
 QT8U+rGs++2qkmqeyigWgLkbV6eqXAY78ntx81JQhf2W/g2HlaxNsAgFMNn1YDJMT6lv8cK6/
 148VzkG9zr8+/OsCTbYtixTJhjtJovwxBeI3hsM2XDk0q5QW+qDmwDBCN43knNTEkajM9D3QM
 3w0kfKj9vVOPQdFKZuHvtmBCGxiT4/EztToT/+0kwaQKOl+qDCT7NotoNy+zi6Q4+7SOvHEMc
 W1JThMiIX4eJ/8/wgRMQiQONs1P617IocHcUkZuIc7PPf/i0EAzW9JQNvFTFc35D+wDysdB1T
 FhDza2/ejQ0QIXrNRWpFtreA5lU3Vj8LYev+Jxuroih8+s7HafBlIjaMrNa0gsyrNarpm3UsO
 ovPwTM9sgc0o19Rh6eU4OKY1TSn74KUZyA03kO08IIh6/OeQmaLQwPNv55WZZafBdeLd6JI/4
 grNfTrSXrTjyWDfa7v90Py7w==

> On the node of an nfs client, some files saved in the mountpoint of the
> nfs server were coping within the same nfs server. Accidentally, the
> nfs42_complete_copies() get a NULL-pointer dereference crash, as can be
> seen in following syslog:
=E2=80=A6
> Fixes: 0e65a32c8a56 ("NFS: handle source server reboot")
> Signed-off-by: Yanjun Zhang <zhangyanjun@cestc.cn>
> ---
>  fs/nfs/client.c           | 1 +
=E2=80=A6

Thanks for your patch adjustment.
Would you like to present any version descriptions accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.11#n310

Regards,
Markus

