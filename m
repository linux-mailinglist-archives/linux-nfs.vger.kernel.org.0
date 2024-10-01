Return-Path: <linux-nfs+bounces-6743-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72E398B5ED
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 09:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79071281446
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 07:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB2C1BD009;
	Tue,  1 Oct 2024 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RvkPK7n1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2BC1BDA85;
	Tue,  1 Oct 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768594; cv=none; b=baaT9Zf7FMbJRMXrYmesr6CGfY0JDjVYxaav1rEUoGIilqMpxpP5xwvHK9GeY3i33Z7PFhGeTvPp25iiwYKwX9/JJacnW9KY+Y4IDTGGSuvN8Kk66sx8ag+kl6ocleBDJGL95OA77/BHUj/swNBFibG7rQ4v5c/Mvvj2JBTDXWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768594; c=relaxed/simple;
	bh=Xfl8HvpybiHnMLDdfd/dIquxPinyd3O3pqXxMlAQRaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebqy5XWbV8wF5d6pQ63uW0X8HutiOXw/p0kT7xFXEoY3vKniCZn0ZbCgN32vD02xx47e7RSzMkLvs2rq4hC9Cv0lNGD5rno5VEnbhpfA+3ExFqwmuVZx5VWDrKWSLuk1r2jG9t483vco0hYRZSzXPKD1kr1GN3pb+xhQLF5+C/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RvkPK7n1; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727768572; x=1728373372; i=markus.elfring@web.de;
	bh=UdT9g1ovU+qdxsslet0dAqvKxhyHczuTqqPZ83kYvCo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RvkPK7n1OfxMo45bv551DhB2VB1EumkzaXq81Iqi9boewczh4fStujcRLvw/Q0MF
	 KQg8IvHWMfNVrteI1vca9bvelL3hJsKGho9GvrFPM86k37rSVd/00bBzFiZ/F1Aox
	 BTltc5feIhniNivAnvlGfkJicFGKxj+MAcwH0jfYPE8Du0QHdY2ub73L6Xk0JMm1H
	 9qnmUqvtxq61QVQP/1Y9GilN5Vlyo99zqGig3ohefdlY9J9EZhAHFm/FYDLJFOUiv
	 juYHGGGc3aklW/fcBv6ifmQ7AQE3+uwkcDqLraWXAScVz60NJWL/FFyN3MH/O94Ao
	 GIosFdbQ5HFCtAbyow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2xrq-1suRbE1Sm4-000ZMG; Tue, 01
 Oct 2024 09:42:52 +0200
Message-ID: <5d1f95de-e65b-4121-83cc-b5508e7a67bc@web.de>
Date: Tue, 1 Oct 2024 09:42:48 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] NFSv4: fix possible NULL-pointer dereference in
 nfs42_complete_copies()
To: Yanjun Zhang <zhangyanjun@cestc.cn>, linux-nfs@vger.kernel.org,
 Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Trond Myklebust <trond.myklebust@hammerspace.com>
References: <20241001072101.3556-1-zhangyanjun@cestc.cn>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241001072101.3556-1-zhangyanjun@cestc.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MA4RRtui1yfnXCF14VbwGlGgLvooefIlxxB6j8cXcdY6m0ljrh0
 ipTpSVcBnQv5XW+oUbcobYNjDKPw6aPIdJ+tL6dW7CMZbvK+wkoyEnbV188zfnEZW1h45Ao
 WyyplrjZGn83JLtnzThOstkc4j9NXdMlWpNSV6L8bAw9uIDJpGmgNrqdH6TCGuE6PMSyYXr
 lEe9AGy8UhagwGQg0PyvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UtUch2xGzTU=;JHW098qdJZzzy3JarCSb5++8Lb9
 TeoAkIlW0RQCIVSseMkKsTzzGB/K54I9ZKbFmqdqpdJlf1qW/g5ALP7pYGhbcttNsPES8Nng+
 vrq7bAkQtSl2HO0RAkcR34270TfsSxiu7VG38nHkJUvbiXMZGQrkK0NFwBGDDKdoZcZzGOsm0
 GYHtq/JFYN71vRD8yb3NcYxgvNbIU+jotKGNX29Ib3khbG+li1Nefb6aV2k1gIJ2IFdk5Xl7t
 ZLD/TejOT+tzVMfJA5EtUshfsZXAf1rig8EN7wsCkIXQEjSqSjI/LeF9HJyF9KPDqYghSnlWG
 9aHZLyRPTWlPtr4i9bDoUpbhTrO1nq194ACaDPDyPLEgAZaOwy8q/DmC/Mhj/2dag2Pujqd9K
 TtAGno4Hq4roqCL76hsSfUOhG1WKU2UsROIbUX3oUCsvu5aJO5kpepca94if9gBcT9rSoD3Ik
 wa1Gscett8Erbc6rzUfUXUr9jA66wPzrL1EwArbO3/sNwcKhuEPyCx6Ss1gFNOdsL8k9l2wgh
 xufyZDll6ucDgJo+jpoa552WjSNpCpic2tIptEQhdnQdOJTmwGoUWB72a6K3WonfZWZchXAQp
 mq5Ot57ZOGTQnbbcogFlsF59lMQMgCIjTISOUyWtT0v5VshkbvmHVWfhD53QQ4WDz1PdML9tP
 3VCiwr4JPq+n+QUxE+tD0/OeB2h2cb/kB2EmYVsKMiC8IFE1otKqZn7xsNDaCERXrt3CuiDCk
 zlwK0GpdiY98VWRGytJSVrEnY75zfB/edmWt6RTuTfCptH6u/QfsS5O9mn0B/VneeIJDrHW8E
 pDyvxcLiKBKAPCbeje2Tvdww==

=E2=80=A6
> NFS server were coping data within the same server. Accidentally, the

                  copying?


> nfs42_complete_copies() got =E2=80=A6

How do you think about to use the word =E2=80=9CPrevent=E2=80=9D instead o=
f =E2=80=9Cfix possible=E2=80=9D
in the summary phrase?

Regards,
Markus

