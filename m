Return-Path: <linux-nfs+bounces-2696-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F61289ACEA
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 22:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED894B21129
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 20:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F4A18C1F;
	Sat,  6 Apr 2024 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JY9WgQBL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF78364BE
	for <linux-nfs@vger.kernel.org>; Sat,  6 Apr 2024 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712435875; cv=none; b=AA9yRyqnAdofoxCDb3iiZq6giHYFPmnUN2uKKkRds3u5rwAIEKkp7d85PuCR9+haFu2Dmw9L468XY6alT8NzfDwTwFih8r2YiibVnkdMM6kIKLkQy81DrEpbFsTBtzqsKwvEPICd6ZMxMooduMHp5MtwvAAM4pdGpR3G4PIkquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712435875; c=relaxed/simple;
	bh=lSuWvcZxf2uFBv4QmhSmGQqoEkT7AxtTeQemEV66Pmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=synDT2DW0UuMFLNIH+iYmnijlyboqMub4LtMtPntjxN5N/Axae6pvVZ0YzQ6hTH92hWS76iK/655TCAJi6oQbtbHuJqINzfIjlNkSgAeLrQVVivr4rVyATw0UfdtdBNm6tFXitKYvX7qIgH02kj2VHwmmy6xsIx6mM8qJHQXzr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JY9WgQBL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712435871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9PIlskL+OCXnLfkwcQDLUPVJ1BBxlgjlC9T8R3yISY=;
	b=JY9WgQBL3hb4Un1etK3VOhl+jgC1f7NF6qALlMkuugPWInCzzjrFO7xn4yNmwH4ecgwPnX
	mmlIsrMGFVUyhBWByvIKcTQ9GziFrzfFoZH2uKkKioC7Gzi3uU767WuhXg6In6F3SPNMn7
	lsebS0jN+CAQL9R+bUneOndJUkRmCHk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-Dw6l_CP9M6CffayO18JI7A-1; Sat, 06 Apr 2024 16:37:50 -0400
X-MC-Unique: Dw6l_CP9M6CffayO18JI7A-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-69a01201ca0so4036526d6.0
        for <linux-nfs@vger.kernel.org>; Sat, 06 Apr 2024 13:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712435869; x=1713040669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9PIlskL+OCXnLfkwcQDLUPVJ1BBxlgjlC9T8R3yISY=;
        b=TGkeO7lkWwlQt61knAvJrKExz2eCUgrdm+BVL5F1RPEkavfEbd01sk4XmEfnQ8/uDf
         cOBaHBsAqcXSPH2KPZCmYDkLE8LynwuqzZLsE5RTOJvrAleL8E9TSzk+UwzuC7R99aIK
         tXUFyfCSJoUOd/IecXaBehmrj0auaRhi6MFr3IVX/kehKWImkTuaDsy1zQrN72VLnmM7
         oTp8yqcIM3d5xE04Vi6wl4BJUjzMHOsVsnw7urWTKcmySNAa454i23XXyHuPaM4hcBJm
         d8pYbKKd90WADMrqsGHJi1yJiAC+rSoiCUvOxDdPm6RjMZ9ImfYhtStv7c/2VCR+R4jm
         1Jxg==
X-Forwarded-Encrypted: i=1; AJvYcCXKPIF50wGTVB7Bp0n97DYjYKZI2TYHKJZH8aTD89brVQ+LqcUfqCnGA6gvLThhdjCr1NuZ62skvhS7nMod8VY+YBgQbZMlg0om
X-Gm-Message-State: AOJu0YwS/I9y2C6/WJ3UWhWOV0T6H2IGMi12ptj43fu0YbZ/HVdbPBP7
	XCTgZY7v/VTXKFX0ItNV5iv/nrRni6COHNAAcSxA/8R3umYobyXR2SnnxHzZ0jqGZAluHMIIr9K
	YICca3KJJDbw11q0euc4AumkB6I/2XB33x47T9+QjE8pTzP/K+j3ZWwQVNw==
X-Received: by 2002:a05:6214:501b:b0:699:1c43:db84 with SMTP id jo27-20020a056214501b00b006991c43db84mr5332841qvb.5.1712435868482;
        Sat, 06 Apr 2024 13:37:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7GDj+GtgnBj7UMmqiibSwaNkRHJUISYi08ILqOmQKS7ayUWWvPFEgZuOMT7LeySfWu4zNyg==
X-Received: by 2002:a05:6214:501b:b0:699:1c43:db84 with SMTP id jo27-20020a056214501b00b006991c43db84mr5332837qvb.5.1712435868202;
        Sat, 06 Apr 2024 13:37:48 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.134.36])
        by smtp.gmail.com with ESMTPSA id dz8-20020ad45888000000b006994ae11f80sm996261qvb.64.2024.04.06.13.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 13:37:47 -0700 (PDT)
Message-ID: <79c69668-4f8e-448e-9f50-6977cda662fc@redhat.com>
Date: Sat, 6 Apr 2024 16:37:46 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nfs-utils' .service files not usable with nfsv4-server.service
To: Matt Turner <mattst88@gmail.com>, linux-nfs@vger.kernel.org
References: <CAEdQ38GJgxponxNxkcv+t8mhwRPzOjan58MTBgOL8p9tY=rvTw@mail.gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <CAEdQ38GJgxponxNxkcv+t8mhwRPzOjan58MTBgOL8p9tY=rvTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 4/5/24 10:29 AM, Matt Turner wrote:
> Downstream bug: https://bugs.gentoo.org/928526
> 
> In Gentoo we allow disabling NFSv3 support, which entails nothing more
> than not installing `nfs-server.service`. This has uncovered an issue
> that many .service files reference `nfs-server.service` explicitly,
> making them unusable with `nfsv4-server.service`.
Very interesting... not supporting v3... Just curious as to why?

> 
>> server ~ # grep nfs-server.service $(qlist nfs-utils | grep service)
>> /usr/lib/systemd/system/rpc-statd-notify.service:After=nfs-server.service
>> /usr/lib/systemd/system/nfs-mountd.service:BindsTo=nfs-server.service
>> /usr/lib/systemd/system/rpc-svcgssd.service:PartOf=nfs-server.service
>> /usr/lib/systemd/system/fsidd.service:Before=nfs-mountd.service nfs-server.service
>> /usr/lib/systemd/system/fsidd.service:RequiredBy=nfs-mountd.service nfs-server.service
>> /usr/lib/systemd/system/nfs-idmapd.service:BindsTo=nfs-server.service
> 
> The only service file that depends on nfsv4-server is nfsv4-exportd:
> 
>> server ~ # grep nfsv4-server.service $(qlist nfs-utils | grep service)
>> /usr/lib/systemd/system/nfsv4-exportd.service:BindsTo=nfsv4-server.service
> 
> How should `nfsv4-server.service` be used?
The idea was to make nfs-utils have a smaller footprint for containers.
No rpcbind, lockd, statd etc.. exportd is to replace mountd
and only accept v4 mounts.

Unfortunately the idea of having a nfsv4 only server
did not go over well with upstream.

But, I will be more than willing to work with you to make it work.

steved.

> 
> Thanks,
> Matt
> 


