Return-Path: <linux-nfs+bounces-6711-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6761989E81
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 11:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB094288175
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 09:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E601D18A6C6;
	Mon, 30 Sep 2024 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HRp+BQCF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863F41885A4;
	Mon, 30 Sep 2024 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688837; cv=none; b=B8yxxhP4xyvTThPeNc76Ldg3o5rqRfh8qmVmdnq+1F0DtSE32yNtb6q/ZNvlzIsC3sAy6dSFLJMjUKnHMqDQ9f5MVYV0lb/B58t7dYuldU79nHK5Pswxyb4Eoj/mq0WrnJNybNFvtZjf1M8t4SWZRamzadRjwu6s5zUGoSglEq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688837; c=relaxed/simple;
	bh=qVSs++YRfZwSqF14uZ0Soh8/UalvL0qVzF/7jg0c4nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IU5MXoLesiUEAVKedvlFjpTSCsTnKQKjvfeLWSNbRTc2ziPAk70OigOa4Zr2AMXhJ14P6bwjhK7fwuUnvb18Yp+aeChkT7f+COPzxU5d3PT1yJDbNI5kggdrzGzewhaGC39uZNsotcd9SHfAgo8fQIPoOVWHexbyfSqxTEYZNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HRp+BQCF; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727688812; x=1728293612; i=markus.elfring@web.de;
	bh=CCrvVxxN3qsk5zzm8SFVw4tjG06AOm+f+aIamzo6ZPg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HRp+BQCFXW+7aQ3lnarOOlQWtTZif4U6ofQcKvYEcFHBB0P5M+uayCSknX3q2jQq
	 XBnT+CF0By+npLWXi7sO7WDQ3C9qfFaF98bB2xYAAht3gZakR4NqihcS42nCQddg8
	 J3SGNCXN5vAsEo5WCbWf5dbuh0s1u1M/FgogxA6yLDMuZJ50qk7g/OF262LrEKUoE
	 kYKtNI1fVpcqKCHdIZOINn7SkjH2NH287zRZ+JOZ7b8GT+0HGFUF++cS9tK0+/XVl
	 cwgvK/6y7GYqakXHzj1EFm8XkmOW1z6CkdVPVmTcmDALraMizvg+GGdrpg5pTeAV/
	 +S+cDO83/qH/UkBLHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4KJR-1svTtl2y4f-004SQn; Mon, 30
 Sep 2024 11:33:32 +0200
Message-ID: <5c81ba53-2966-4922-9a59-ca7de489db76@web.de>
Date: Mon, 30 Sep 2024 11:33:28 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] NFSv4: fix possible NULL-pointer dereference in
 nfs42_complete_copies()
To: Yanjun Zhang <zhangyanjun@cestc.cn>, linux-nfs@vger.kernel.org,
 Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240930090115.463284-1-zhangyanjun@cestc.cn>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240930090115.463284-1-zhangyanjun@cestc.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HYcfpqnc1/9XgceyOoIIbWMvRCOVaoMFTMuNUpDRzB+fapwVE+j
 1TyA+0s4EzWtjFnYif2FxeY3S3z+nd59HJGJWNnkWVMn43q3A3P6iV9Dkyd3+zbS74o5+CQ
 HrzrOoJuyGW87NlyKUOOYoSh3r7vWgSTbMjICga+K0N8tFjEyUJxb3Z0q9oBqZfODk4YKMy
 k30499GnMtDf9m2kcWIGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qE+/nniAaHk=;3pZPuxbtUHDLA/z+C0fb6Btp0YQ
 IGD2Q93Z4j5nPeJcFxZ6ixDe3CM2LoPjJpNA15haaOEyu+oGX4+4/ucPyYnS+y4AyxXkYPMnW
 hnZOGQDOYGrbt65FycHnLO22/DAC0yH6Yl/4pkiu1X3ShL9QOA3yv3g3XvUha7SY3hsYFXuJl
 l3YQhSx5AKnMEiuzB91Q27oZXc498WLdSINSs4UJpPGAdOqY3sjY23tRFrV/yXdY/RDa75/h/
 6e5suY9Z+qNMSDX9wV3zNW7iKLn4vp03LA265lRk2RV2ZMsZFBnjVwGtBnr/P7Vp9KWBQMemG
 pGG8ReRSRz0tOyVZjv8hZTFLwdqCpvRIdadhQwP6csspbi3a8Z/9rX1cnAO6FNnnN9UOI31sm
 gZphDWHbJrC8FFJ6bFEEQaFSXX6ep76dNVHYxe4IkAVZKjz51X/gx1NaQR4032W6mgdyIc88u
 XjXxQ/iPaOE4AyeA7sTE30Z9Ah9JIF33bqoXEzLw25HdS7mwnajhm6PbPChTQ8edXRPPQk6e+
 Ic4bEyXphF8zd5yjdIksu5eylQMWMj7SN37h9driGBesRj1xGFgIVVb70ROIDGvsy3LyoAUag
 zcQGIkOvByIvzwLpbelq3o06HGJY5brIeU/Z7mM3lmAHpRKEHQYficqKQJwOQHy60In7jQ0bT
 tQpki2UBIIUn2NoGTQ+Ale330+/4bEkCLPNeIt0k1R3DGOM2Khalm5mN7EnBEvAapBeezJWkD
 BAesLUqSx6flBysHr1LMirWPQsVoy5Q38iwxHPEYjIAo0z1R9lM470hZaIOhstfCuipSjW8fV
 VXvo/Xp2tw3PmHfaQpBsnTww==

> On the node of an nfs client, some files saved in the mountpoint of the

                    NFS?


> nfs server were coping within the same nfs server. Accidentally, the

                  copying data?


> nfs42_complete_copies() get =E2=80=A6


Would any further adjustments become helpful for this patch?

Regards,
Markus

