Return-Path: <linux-nfs+bounces-12105-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B570AACE451
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 20:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42081890065
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 18:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE23171A1;
	Wed,  4 Jun 2025 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjGdxvMQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89441FECAF
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749061601; cv=none; b=oxQErY2gfDZBmU4skhaYqkF3itorrA++MDP9st0qr4Wf51GqGjx2O+miX9tUILmMfs/4w3z8AZYyRk1xgMa4lmSgD+ntNPmUF+AKGv2dsydQlhI7ibWy6hOvY8vusJI1ktfvHJYI4Ud+bjODnVB4nvHj/BZbwpJwaPdLfokT6nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749061601; c=relaxed/simple;
	bh=W3QrunMFWVkfiMa1DeOo0Z+Zw6O8cV4lkmlvi5P+G5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiuuTo/WG19/D1BId87RPP8rI507BdaliQKHcY7rdTv14N+37siH7cFN4wnI6seNsRwRRXneJUzREsSw1Ybjbmr0jmmEu8GyuJmpfkSg2K6AVXZqO8ZXmjQLAF+/cTsnxR/TDIQS3F4lmaJ9Ez0tBAU+C+m6zZ/s8AAOG5S3xxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjGdxvMQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749061598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vD62RXP11gJFzBmHg/FQLGL9T7uWuzQyd3DlPXEtQ1E=;
	b=JjGdxvMQYiBjaHFNn6OOktQHxs1qT1csqxUOmWmga1QIMlEweGO82houl8BClRNMd9X7zw
	V5kb9183yES85zf+G8hWfKOAKLy3dFDUpIJyA3D4UQhl+Wi7tQGwx4JpPu5myQmVJFm2iY
	ufuIMpB2wKMKasAkItAcuSldHeziPhE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-7wtM461bMb6LCDvywpQ3jg-1; Wed, 04 Jun 2025 14:26:37 -0400
X-MC-Unique: 7wtM461bMb6LCDvywpQ3jg-1
X-Mimecast-MFC-AGG-ID: 7wtM461bMb6LCDvywpQ3jg_1749061597
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6facf4cf5e1so2685666d6.2
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jun 2025 11:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749061596; x=1749666396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vD62RXP11gJFzBmHg/FQLGL9T7uWuzQyd3DlPXEtQ1E=;
        b=Ek+OMErbXYx2lk1X3mhhHveK1CKqFOgyhAjy6idF7qpWlUM+4T+n3JYzw7+wCnoiET
         x+XgxUdO8ThMRXsnmJrhRR5Zqc3AEYV/8/mDQrH1zQODJm93VkwiYXjOsoAUI3yXMdpT
         HP5/0Hm163zfX0O95x+wufS93SF4briiRaltR8OEAef+PvHf7LmHSNOiy1UprHKeIpl+
         IcPa7AdtKtPnSut+Rlb9NzqwRHE7II5Vonam+y7OzhQD3mAH/3DBrsk73FblBKKZX8fr
         pkHGHxyxvnjM4ycTBhV5mThzLyMgmGabK5nPoFYF/bqMCZwVm0cW77uaapq2yRLWAB1d
         KTpw==
X-Forwarded-Encrypted: i=1; AJvYcCV6z7V+q5Mak9mplk+icTBenavW+9knqZcQL7zMUqLiFTvYIRp/fiKBvU9DFuJkCLprIDUe65nLquc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy38uRGlzZZfhFHSrJD4u01updERjE+Za1OU9Ci0ZniKG7QxjMi
	2CsXwyolns+ir/QWOXv3wt8hPOL8hNfxQ1IxMhfiL17Q2SefWgv7p7NNN1zLjjBO4qcX29RzQVU
	hBOm6GhgZK7+AbJOs60lQxfbPiQB4vI64rhVEuscqRuX8mD1xMysNbATX2oaCpWkdCEvqOA==
X-Gm-Gg: ASbGncvZs/5nNpp2prTA+tDZvPnsPXbl22/HLDBqR3Mq51JyftiiSWKuhMyqxqkEgoS
	4XGOK/N/HnRmDLPUMxFPO3R7RmqaOBM0jRq9SO69VDb8C6l4SYrfkvkQYqd0hPPbNar26R5cFva
	Dkxrg/eY7oyQon5dNVp0WvHc/dYtsrLZeMHt7JAa6CirHkShPPJyDaMPXa6LCfHzaeGZjUKxZat
	RJ+5IS9FLurzvThg89yEFHW1hfBpUntE9WPKEEVN6fxFDkpnEpGM+cZ5eV537r6SB3vNI9q/6G+
	HzIhK4wrrKk=
X-Received: by 2002:a05:6214:2507:b0:6f8:b7cd:984f with SMTP id 6a1803df08f44-6faf7023e52mr54391146d6.30.1749061596121;
        Wed, 04 Jun 2025 11:26:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb8W4Pga49rV6gFLmr28JLMLSnAuw/HcSfZPPutAN/8rN+X0ShuZKjKOcVaNeJZbmu/AUObg==
X-Received: by 2002:a05:6214:2507:b0:6f8:b7cd:984f with SMTP id 6a1803df08f44-6faf7023e52mr54390756d6.30.1749061595706;
        Wed, 04 Jun 2025 11:26:35 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.242.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d4c7d8sm103904226d6.36.2025.06.04.11.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 11:26:35 -0700 (PDT)
Message-ID: <7bbb789d-b3ae-4258-bebf-40ed87587576@redhat.com>
Date: Wed, 4 Jun 2025 14:26:34 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: Jeff Layton <jlayton@kernel.org>
Cc: Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
References: <20250513-master-v1-1-e845fe412715@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250513-master-v1-1-e845fe412715@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

On 5/13/25 9:50 AM, Jeff Layton wrote:
> Back in the 80's someone thought it was a good idea to carve out a set
> of ports that only privileged users could use. When NFS was originally
> conceived, Sun made its server require that clients use low ports.
> Since Linux was following suit with Sun in those days, exportfs has
> always defaulted to requiring connections from low ports.
> 
> These days, anyone can be root on their laptop, so limiting connections
> to low source ports is of little value.
> 
> Make the default be "insecure" when creating exports.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> In discussion at the Bake-a-thon, we decided to just go for making
> "insecure" the default for all exports.
> ---
>   support/nfs/exports.c      | 7 +++++--
>   utils/exportfs/exports.man | 4 ++--
>   2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> index 21ec6486ba3d3945df0800972ba1dfd03bd65375..69f8ca8b5e2ed50b837ef287ca0685af3e70ed0b 100644
> --- a/support/nfs/exports.c
> +++ b/support/nfs/exports.c
> @@ -34,8 +34,11 @@
>   #include "reexport.h"
>   #include "nfsd_path.h"
>   
> -#define EXPORT_DEFAULT_FLAGS	\
> -  (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTREECHECK)
> +#define EXPORT_DEFAULT_FLAGS	(NFSEXP_READONLY |	\
> +				 NFSEXP_ROOTSQUASH |	\
> +				 NFSEXP_GATHERED_WRITES |\
> +				 NFSEXP_NOSUBTREECHECK | \
> +				 NFSEXP_INSECURE_PORT)
>   
>   struct flav_info flav_map[] = {
>   	{ "krb5",	RPC_AUTH_GSS_KRB5,	1},
> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> index 39dc30fb8290213990ca7a14b1b3971140b0d120..0b62bb3a82b0e74bc2a7eb84301c4ec97b14d003 100644
> --- a/utils/exportfs/exports.man
> +++ b/utils/exportfs/exports.man
> @@ -180,8 +180,8 @@ understands the following export options:
>   .TP
>   .IR secure
>   This option requires that requests not using gss originate on an
> -Internet port less than IPPORT_RESERVED (1024). This option is on by default.
> -To turn it off, specify
> +Internet port less than IPPORT_RESERVED (1024). This option is off by default
> +but can be explicitly disabled by specifying
>   .IR insecure .
>   (NOTE: older kernels (before upstream kernel version 4.17) enforced this
>   requirement on gss requests as well.)
> 
> ---
> base-commit: 2cf015ea4312f37598efe9733fef3232ab67f784
> change-id: 20250513-master-89974087bb04
> 
> Best regards,
My apologies but I got a bit lost in the fairly large thread
What as is consensus on this patch? Thumbs up or down.
Will there be a V2?

I'm wondering what type documentation impact this would
have on all docs out there that say one has to be root
to do the mount.

I guess I'm not against the patch but as Neil pointed
out making things insecure is a different direction
that the rest of the world is going.

my two cents,

steved.



