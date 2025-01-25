Return-Path: <linux-nfs+bounces-9607-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BFAA1C45E
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Jan 2025 17:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4033A4252
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Jan 2025 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E285435973;
	Sat, 25 Jan 2025 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mk5uhUf6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446718E2A
	for <linux-nfs@vger.kernel.org>; Sat, 25 Jan 2025 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737822832; cv=none; b=U9qPpuDpwx/ZV9SSAQEN6ze49TgkQ/67n+Zh/qaBMBDts6eZspbEt2NpCVlHEBwd89VqJq1xAUBuUxNU6OnWuJsuagtIIrAMkDkhWi5GqjmMTgJd0nWvF6h0cfYBTBqJz+wi/VpZ9ORLqC/ucHTDaeN2utnoW3bjeBYZYYhilZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737822832; c=relaxed/simple;
	bh=R97Ha/dGtyCW/ji3QyTauJieM8Dh22fMrzmPCQWwWfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CkVbrZnkBhj/FX4gsd7TqkK+yEOs9M/xyxW5G+WpiDA1D0zQ9f/UZ7IQogZDUSnH7LnGubyn+cgtNnozdnss5aHV9aZBvGdENeV2jzhQrzCRKm2N4xmGXhtRdsXsdVYwbkvKQV2Clmz8d9JinrSzfKZXiTCOVURr/Gtk1f7dvqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mk5uhUf6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737822830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/LVubzVfpm251OVnCteeiUlbcYmW0EHb8eidgteBw0=;
	b=Mk5uhUf6oIQdonvI+zLfPGEePZ5+zKODulgtP6C23xaK8W+QpgoNS+sDGYlCjwTjTDNej8
	h50YiDfUuy0odWhW+PlfSofo+0Ora64L4DgPrS/Sf0MuaJ5gypMRSivUpKTwND8jqMbvrC
	IKaG16m9jDJYRxvyN3A61GC5+absQFs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-MjOCxlOiOzSCfsaSYAVeFg-1; Sat, 25 Jan 2025 11:33:48 -0500
X-MC-Unique: MjOCxlOiOzSCfsaSYAVeFg-1
X-Mimecast-MFC-AGG-ID: MjOCxlOiOzSCfsaSYAVeFg
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-467a4f0b53bso104006551cf.3
        for <linux-nfs@vger.kernel.org>; Sat, 25 Jan 2025 08:33:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737822828; x=1738427628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/LVubzVfpm251OVnCteeiUlbcYmW0EHb8eidgteBw0=;
        b=ais1GZSMIYtXGmQmNXDxaXK87AvzDw4+6V5lvkH9PGlwtx8kyp2GFZVpVOnYku3D3X
         CmFiCfFWUIgBRtT6H1SQE8KSrU/T0xHS76wqxAYzc6cD5cU2YPZ36n02/MMcu7a6asGi
         xtbU1QUyZIboFVJ4Etmot9YX8/4Dq3fTrYjp4CLx3zVEOX+BHN0WUR/MtkQVLpbcW3hp
         HeefXTqlAhtbD2yG6rW/2oIJe4PAR6a3pTyiU4o6AHaZH/UyZ+E8b4LP1jhEqDrvLDxf
         PjKLHVc4hqo2KCo1O9PaGLb2rxqp0/894Eh9iVfOkKYWVSwJwx88Hhouvugz1OU0Maoa
         qUPg==
X-Forwarded-Encrypted: i=1; AJvYcCWg9ZQGM3dveViXh/SNL/Jxv76s6BTBR+RhuFeVt5p+zDBf828sFxepLIug716JeklTUkOdTRi8hI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztQ6/eYXKYmAC1T8jz0dL6GklSYWjJhx6SlO33MORhxd0TUnx3
	dxTXcJRUOZzD/gobotzFf4UY0LZFLDuUPjzJOVWrXxwG09mIHwEpD1kdq/Io+1NxwfqvCy9HjZb
	Vn9WfsUx8a9cJOS9HIWHD3l8xFzd4jyhQRyPbtw+oB1HIJT5dq9duU4gFfQ==
X-Gm-Gg: ASbGncvDK+i0NSSShZ3l4E0ttRXgFz3uP0Ag95WoK2JwFVHdHKM6BcWZjGgqUAVcYKv
	5v4ZFQSLRhpZly67MG9NsRDAD/Kx9T5nWbWvraxva8wR/78N9au6k13qV2Rx3yjm3+erzrzLB2i
	8JZiGgdJDYTkx3Fm3vIMCxR/y0LCrG+K1sxm2pqIXMxyx7/36ev7g7BwZr0PEO6N+mwsjaH1ymC
	T3q1Be53hguRfQQJDTbCiOWcUxZub4eWbz6EPOvotbMRAJZ36OaE1qDc+1z075XXgxPPwAwExsT
	y3ve
X-Received: by 2002:a05:622a:211:b0:466:a93f:c1c9 with SMTP id d75a77b69052e-46e12ab7ce5mr435101901cf.24.1737822828256;
        Sat, 25 Jan 2025 08:33:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuANHyj0mrKF/vudvfvQspbA2zOp8x+FlwK87etdvIFaZGi+1BHHwyUTtCSMy/XXsyyVwhkQ==
X-Received: by 2002:a05:622a:211:b0:466:a93f:c1c9 with SMTP id d75a77b69052e-46e12ab7ce5mr435101661cf.24.1737822827921;
        Sat, 25 Jan 2025 08:33:47 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e668b57d0sm22115041cf.46.2025.01.25.08.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 08:33:47 -0800 (PST)
Message-ID: <8a267847-b72c-45dc-8c2e-87e5247a1d66@redhat.com>
Date: Sat, 25 Jan 2025 11:33:45 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] nfsiostat: skip argv[0] when parsing
 command-line
To: Frank Sorenson <sorenson@redhat.com>, linux-nfs@vger.kernel.org
References: <20250121190315.1498852-1-sorenson@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250121190315.1498852-1-sorenson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/21/25 2:03 PM, Frank Sorenson wrote:
> Just skip argv[0] entirely while looping through the command-line
> arguments.
> 
> Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Committed... (tag: nfs-utils-2-8-3-rc4)

steved.

> ---
>   tools/nfs-iostat/nfs-iostat.py | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
> index 85294fb9..31587370 100755
> --- a/tools/nfs-iostat/nfs-iostat.py
> +++ b/tools/nfs-iostat/nfs-iostat.py
> @@ -592,11 +592,7 @@ client are listed.
>       parser.add_option_group(displaygroup)
>   
>       (options, args) = parser.parse_args(sys.argv)
> -    for arg in args:
> -
> -        if arg == sys.argv[0]:
> -            continue
> -
> +    for arg in args[1:]:
>           if arg in mountstats:
>               origdevices += [arg]
>           elif not interval_seen:


