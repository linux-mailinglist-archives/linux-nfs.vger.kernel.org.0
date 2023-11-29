Return-Path: <linux-nfs+bounces-163-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5467FD6CE
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 13:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675771C2116B
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A5D1DDEE;
	Wed, 29 Nov 2023 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ffq39r5W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0E710D4
	for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 04:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701261178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwCqOTf3dEX+ns8utCOAM3X7WuFZpTgJfDMGymXxBec=;
	b=Ffq39r5WCJK2d96fhxfNHbXE6BI2S8YL8+5iwi8fZWdfHKMQGcQGXFS0rC/DQRoNhtuCvt
	lLL77Jop1lXjGvXcuROUGmf6rfj53BbOyOpHC9Op6RdSveM/XdnCbUDC6O2dKxiIC3yK16
	XUutOTc2lGurE15i74Yx5yXoV+FL/A4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-KDv3ErCIN-OjHypyZMSlWQ-1; Wed, 29 Nov 2023 07:32:56 -0500
X-MC-Unique: KDv3ErCIN-OjHypyZMSlWQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67a0921b293so17116146d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 04:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701261176; x=1701865976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwCqOTf3dEX+ns8utCOAM3X7WuFZpTgJfDMGymXxBec=;
        b=eTr93Fuxqz3OSyA4dRheEFw+jKLjx0C1I8XvS4CGCd8iQb9omT9HZ2Dv34waeQueuX
         HVTyAp8fQ0C+WyS8yCNbIHE5v5SM3o7L2fZ/sg4ovvQclhuc7GuFIjDB4Qr2lrj1BmNw
         IDOwfefqc3fQkrIfzGYyW+md4K9tGvTVNTOf1IjmRbFlZIkYH4Hm1GIrktmfqUYpN1oB
         VsoUicPeEZGxgdnx+i0gEcTKyW1C6/JkTAYVomMHuHpPKgQd4J+RiW8btAYrX739XEsl
         vzvmcekYyiDGSSN6u2SzMzBU4rP9sQTUcbRh8mPvdFFuwsIezMr9MTRrD+BKNXQlYO0f
         EHIw==
X-Gm-Message-State: AOJu0YwTEnt6UC4gKbbFWKyWbCRv10eq1VUfpQrBHCyJrEEvc9B4hZFZ
	psT3hkZLDltBEhoQfg0RW9tMcvfAgyaMnXWUPJIXwtIjemgz1YVGvL5722tx7XvThsN/lRFZbnm
	WuDIJXzj3b63J88ee2jhVNPXuDqvy
X-Received: by 2002:a05:6214:2f02:b0:67a:1458:aacd with SMTP id od2-20020a0562142f0200b0067a1458aacdmr18851309qvb.1.1701261176299;
        Wed, 29 Nov 2023 04:32:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW3gLvMJ8BAE58PJtXHIFugBFFAyHudzkmngz07O2tEVRsLo7tig6Y5mV7hRcqnXGsMBx4ZA==
X-Received: by 2002:a05:6214:2f02:b0:67a:1458:aacd with SMTP id od2-20020a0562142f0200b0067a1458aacdmr18851295qvb.1.1701261176043;
        Wed, 29 Nov 2023 04:32:56 -0800 (PST)
Received: from [172.31.1.12] ([70.109.186.209])
        by smtp.gmail.com with ESMTPSA id z20-20020a0cda94000000b0067266b7b903sm6098546qvj.5.2023.11.29.04.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 04:32:55 -0800 (PST)
Message-ID: <b3cb8631-97ca-4ca3-ac15-b499d6768eaa@redhat.com>
Date: Wed, 29 Nov 2023 07:32:54 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2 nfs-utils] conffile: use /usr/etc aswell
Content-Language: en-US
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org
References: <20231120025354.17511-1-neilb@suse.de>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20231120025354.17511-1-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/19/23 9:52 PM, NeilBrown wrote:
> The first patch it just a little cleanup.
> The second is the important one.  It follows a trend of deprecating / in favour of /usr
> 
> NeilBrown
> 
>   [PATCH 1/2] conffile: don't report error from conf_init_file()
>   [PATCH 2/2] conffile: allow /usr/etc to provide any config files
> 
Committed... (tag: nfs-utils-2-7-1-rc1)

steved


