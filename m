Return-Path: <linux-nfs+bounces-1296-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4357683926D
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 16:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69D51F24051
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8946B60241;
	Tue, 23 Jan 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSZr6gRq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1025160240
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jan 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023043; cv=none; b=hX/HlVKY9yY6kshn0Jica2oxp+hOw11gsFEZLyTCfP6HYjTXDP2Dzwk5rZGwuypcXjSZhAFit1sOejlNWoGpWbU6FS29FlPUwW1l0/UwAK4oUMDW77Nbk5bXONlMlG72mlLAlFj3jKLvzXp+pixjlKYRPlbYDTJUnTNhu9EkFS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023043; c=relaxed/simple;
	bh=G20V4yqZ18CCUw3aReGfgvjhODOOE93InBKRTopwH7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PEEtZW4iXrx+NAAScB7g5IiHpkKvVjFXYJ7iHHn2MdrAHP/mhN5F5glj/AEwfFROs8CsBw21XDP+qQVlcPI41/YOh3WHzPOEsVVl31vXdq5YpNN2r+R2taFHVzHc3pbLt8RfCcoSziinlE6o571Y1rsMg+KdlGxYh71panN9meU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSZr6gRq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706023041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnAHo/Zyi22n8RK5TTYjysWXGCfrTUeQsyYrqRC39Lw=;
	b=OSZr6gRqGFUxhQxaV26a7MaMI2kbeWUl8P41mkbb8yaqWW5idKnuzZrIWywchbJV9byxe9
	h/RgpyxXtQyJtFDv0vztbyubpbaZ8RTzkjtV1eJd3oGCHdhbzFRNn2fvkEQOH15oFx7z0e
	zCSwKBY4UL850LAHW2ftAXi5+WOk95s=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-MsTNfGv-OzSasvTpIdoMWA-1; Tue, 23 Jan 2024 10:17:17 -0500
X-MC-Unique: MsTNfGv-OzSasvTpIdoMWA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42a48ea9891so4045421cf.0
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jan 2024 07:17:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706023037; x=1706627837;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnAHo/Zyi22n8RK5TTYjysWXGCfrTUeQsyYrqRC39Lw=;
        b=DGXU19nRqCYQUJxUbuOJZEl0KsUxWf1EdY/uM8+T2k8ba6RyyyrT23tmpFJ8JpCXMx
         fzbYUd9HFnERN3VFzcnMjjlJYHKX66kmBr2ooHo90Up6xwPoJLc18MwkEJxhPSqQ3ELp
         gx4S+n2BdJq98aIOdc/mCiH/hTLdmF8RZV22DsrtMF9Zm/LnRoOwtNt7Cn3olWFUL1cW
         4wiWHO+hRvmoIK4yZNx0aXpHxHPvjqDCGQGLpUaIM0rDp7jZ0t5EXz4xWHM4AbuUSCc6
         NaJNVEuCOGOhG0NOZpbaK7W9Y3O7dUJbLH4fIdU2yTslbjIzR4fOMPFUEAflUhN8ODy8
         sBnA==
X-Gm-Message-State: AOJu0YxAQVh2EOgr2sD3QUXICTMaW79Qd4t2SZDu/8EKe9KsuVfk0+II
	jamEAu7vFjT+l0PP0neO1L4hOA33fmGLEje9rdsJuMfBjIEX1lO+aFTS5fqhq/PVAcXLIQ2i2Pw
	2QP2MbHUHi3gtVR/i1rGmP2qSwrZQHnA8LLrgD3mMTTBf/Nwv9Xl3fbFR+rFp+7LZbA==
X-Received: by 2002:a05:622a:246:b0:42a:3387:f232 with SMTP id c6-20020a05622a024600b0042a3387f232mr10580498qtx.5.1706023036796;
        Tue, 23 Jan 2024 07:17:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVmqfpzkpxv8OiU72YEwAliGhrPQxKrUPgl86BglPmGe7fsUG5R4agxVSZHW3/ettqKwpIPw==
X-Received: by 2002:a05:622a:246:b0:42a:3387:f232 with SMTP id c6-20020a05622a024600b0042a3387f232mr10580480qtx.5.1706023036468;
        Tue, 23 Jan 2024 07:17:16 -0800 (PST)
Received: from [172.31.1.12] ([70.105.251.221])
        by smtp.gmail.com with ESMTPSA id u15-20020a05620a120f00b007836647671fsm3193442qkj.89.2024.01.23.07.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:17:16 -0800 (PST)
Message-ID: <d730e87d-90c4-48aa-8c73-585fece6130f@redhat.com>
Date: Tue, 23 Jan 2024 10:17:16 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Typos and documentation fixes
Content-Language: en-US
To: Gioele Barabucci <gioele@svario.it>, linux-nfs@vger.kernel.org
References: <20240104082528.1425699-1-gioele@svario.it>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240104082528.1425699-1-gioele@svario.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/4/24 3:25 AM, Gioele Barabucci wrote:
> Hi,
> 
> the following three patches fix a few typos detected by Debian's QA tool
> lintian. The last patch also adds Documentation= options to various
> service files.
> 
> --
> v2: rebased on top of 2.7.1-rc3, added S-o-B trailers
> 
> Regards,
> 
> Gioele Barabucci (3):
>    Fix typos in error messages
>    Fix typos in manpages
>    systemd: Add Documentation= option to service units
> 
>   support/export/export.c           | 2 +-
>   support/export/v4root.c           | 2 +-
>   systemd/nfs-blkmap.service        | 1 +
>   systemd/nfs-idmapd.service        | 1 +
>   systemd/nfs-mountd.service        | 1 +
>   systemd/nfs-server.service        | 1 +
>   systemd/nfsdcld.service           | 1 +
>   systemd/rpc-gssd.service.in       | 1 +
>   systemd/rpc-statd-notify.service  | 1 +
>   systemd/rpc-statd.service         | 1 +
>   systemd/rpc-svcgssd.service       | 1 +
>   utils/exportfs/exports.man        | 2 +-
>   utils/mount/mount_libmount.c      | 2 +-
>   utils/mount/nfs.man               | 4 ++--
>   utils/mount/nfsmount.conf.man     | 2 +-
>   utils/nfsdcld/nfsdcld.man         | 2 +-
>   utils/nfsdcltrack/nfsdcltrack.man | 2 +-
>   17 files changed, 18 insertions(+), 9 deletions(-)
> 
Thanks for doing this... sorry it too so long.

Committed... (tag: nfs-utils-2-7-1-rc4)

steved.


