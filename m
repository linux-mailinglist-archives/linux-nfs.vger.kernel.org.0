Return-Path: <linux-nfs+bounces-10529-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B4AA56F08
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Mar 2025 18:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812A117109E
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Mar 2025 17:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E53721A44A;
	Fri,  7 Mar 2025 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dG3MOep0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A215F23FC68;
	Fri,  7 Mar 2025 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368550; cv=none; b=aB0675jqaLtSw4+1ueT5oXTnRVHMme5zIUlzL9BUn0HPm6DPKLybBXnI2tDDe3ez43vDUyCFiDwhGDQOF8hBwIKSqZ2BCGj5YFxvNlelh6Uvm5jz6v9ZhTCoieWpLrN3hwEXfsoz7TT3Elq9K4wkq8YGtgNVob8zdHhA0m4PxBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368550; c=relaxed/simple;
	bh=pAXk9nplQXMo4PaQGK2RiTm1NJNkWQ9qJnNQm1qjKCo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XqkB3XBYv9HkaN4NVLxW4ZVoYmkPbfaKdbPooPlYIcfThCl/77Ih7b0tN/RsCKaboMrkCdusDK+rUELjhrPUg21rnsmF3DhLDXnQ0shR22OWg25K1g89HAECovgnTi6TH4yTbaXuglUUmgDqrpRFM9q6ZjhjNeGmem47DOx+JtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dG3MOep0; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741368545; x=1741973345; i=markus.elfring@web.de;
	bh=9mK+OlGiVmRDcs0Jmovne1s6idfZ5q2umrUN0yXPCNc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dG3MOep0kSdHLtgbLbH1gwJD7jia4EM1iTw/+4U3WftPFnmQ2GfcaNao3/oYHmai
	 qO4Bd4DixkzvIABvIoWkJOqUxaG5ciGM4+LnOFJr/CVi2SP8jchZ8PW6VM4X7Vfxz
	 OA/Cq9q6aFmplq0QQbETkvT7mSOhA2eCqMZClIZij0dAjva9oplFDs9TppWt3d2lS
	 a94RdMQPxwWJGFFw6p2+dj1fZatmX6keFqPStem3c22EIVZH1XIE3MwA0qVLPIt3n
	 289JOT242ZrPOvL8QZOGSxj8/EoexG3loiQGP/w2EIJGVNdupseMKcroNUGBU4srw
	 bcj+/QSpyEWG1HWfLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.70]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8T7E-1tv1MH1vHM-000rvy; Fri, 07
 Mar 2025 18:29:05 +0100
Message-ID: <03bc1b71-6b53-428e-8b2e-4f3a434087b1@web.de>
Date: Fri, 7 Mar 2025 18:29:02 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, linux-nfs@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Anna Schumaker <anna@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>
References: <20250303140314.1650-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] NFS: handle wait_on_bit_action() errors in
 nfs_vm_page_mkwrite()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250303140314.1650-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YWnTnJ2Fxc4XORGjPMBmYYOBrRGjG7e8Oq/hxJpYzBc8eCRPzud
 R5sx/ob+f76LUi6gcRbEhhgOeZZnwVqJ7UWzJJSDJjeD69dvQOEnDm52cRqB+w7dVSY3IPL
 4zLOuql/uVlNMF29wmxIqupzBzv3nml5DaiF5ve2tvreDh+VutVzTE13R2/gP9sNonJcBHB
 /Mlj7l51/tEPTUbGEhE4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1EK34QZ6akg=;adCjeFb0z1LeRI04IrU5yu6lNrm
 Q0jJOCbYUBELkUxy0Jlo2RP/j9fAQRatZ5+YKZtYDgoNMuenZ9iLcOBxGqahlsTO0lMShmG/H
 NGkdcPjMUxrkIofsyrigdV5SbihO049OqJdSnkFxov+X0wR8sZGfmEXW3AzJ1Ph0/bAeon1ox
 AlFu0nDhBk2uiYIWlIBkg5cGGa8Zrt7niqYhv8c5C0CPMvEbxGdW+Hf/nqzbYSXNhBHx9/9I2
 ak2Q6PdeYgUUnGRkQAmRvFK6iOY7nMDKNVuBXeKjD67cV/SmKaD5dD2GPfe5e2QQERvZqSScA
 R24zP+/gg8+Yf7dcmSiGPtlzKb7lv9nawO/xEW6pHDCQwRygm1vJ3kZXcWCz2qwq+bnhxs1Xi
 oNfa76XmVDDm0zKJxiA6Yvlqcy7t6HHoRidcam3MWd52nqiW+yC/GY+3cNWhhOygPyBY7lm98
 gzqVMSHDiCzHZvztaa8nZnviP1f1KoVT7G0jpZhGUI0Maf0kS49MaZrv5ErnnkMpy6QxWnVN3
 04E0JQ5w5twEtFNrk9IkQrlEmQMaVjzIQLvpVvIXzIg1m7Xq5hNC2+AZWlnNU9RQnLW6kRt3i
 rkCPHr2a+ncDBRE7m1sHuPWL9A4TS/+NRVjWo29uZiaYoaA5mZdBsrpd2NjBMu4kAhOhQPEQ5
 zp3hFack2X4hsTGa+rlx3ki64lSMl9i8kEbLK5+q+hjV/JYKOAoEjSOlcMrFfHU2Qn8DdwWHV
 uuUW2pxMqoQPGW4LsNYBvnDFZudxYVG1SaD92NrOKb04Z2Rh5uN/ph3gArcpWplmDiqkimtXK
 WmuEu9Xg513iIgfOuN3wQZqDlioaSuW5EsSJsCKYfBwHAkPP2aOkm5oN0tmTfWo6d3sMg2NRU
 jIo7r21NAVuCt55oNbRfFlzy+IRtO5TgUpCXJmQt3k2D8eyHPvxy8AJuTqMfACC0pRtJR7uMx
 UVkxONOgFNHcAJ0prbr4va0F/n6ARU4epXkGz/nWjo7HvLah+ZFsjMtx9GAatdQyEUvpVE/Ah
 VZo1Iy7rAufva8w/pRAFobzx4Rnp6x6NRBKitNHTWzsMOazwjLN32vfw21KjmnjyQ4LbK2xlM
 RlVDdmiYfcEgNlgz6Ubu1/Ga4AveGwfJ1afSYPIJwKpvvbydN53/m/1tP13FvdZiO0XHDvsvs
 qDTVNIgO6Z9ClCeue4gmnR3sGoG+yTqAo+lPi1IxNZ0ikDcc6Eacd3MYDV1IAwvniJbQHgCCU
 zB4cfPp4Ei9fe1a61Y4A6l06NAiRG2KJowhsSiVIi3DdbWQahg7n/02BGNmwx8itIBKE92a9O
 bkndwVgR3oq1hEJqYGNQhaCCg4WBXopqXGEsb0ySdCco1imV2M4cBVZng801s3IgsQfBxlFut
 Y8fPRSGsqXhaq4lCID7kAqsFoG4ZPIDcmT9qUoc3mpCGfcXpcmewaZUqTd030BD3fCDdbSNG9
 D+flVeKulZ1bqFIzQZMWp/sEtrho=

> Add error handling for wait_on_bit_action() failures in the page
> fault path. Return VM_FAULT_SIGBUS instead of proceeding with
> folio operations when wait_on_bit_action() fails.

                                             call failed?

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14-rc5#n145

Regards,
Markus

