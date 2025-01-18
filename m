Return-Path: <linux-nfs+bounces-9382-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC74A15C96
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jan 2025 13:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75739166B0A
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jan 2025 12:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC352155747;
	Sat, 18 Jan 2025 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDchjtYa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBCA2913
	for <linux-nfs@vger.kernel.org>; Sat, 18 Jan 2025 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737202141; cv=none; b=kEdpE8C7Ltd/s/gljq5kE2HQitBGg8V6I+EpoNLSqgbD1mzcunnUThfpJVgfPmEMjKrx95POsnTKSv54ExbzfEs+0ohI/UdCT5QlabMlJvYpmQ2bwp4PR6Q8jHWmPTDsUBHdi0rJAk4VEykgpD1IG+fIStYCwC8EfxHrDE3IFes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737202141; c=relaxed/simple;
	bh=bniF+x7RxHoj8+giiVwqbbAjwBa6P9KHBaS5XZetzvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3OTIV42zPkRzK1PI1ClB2s3F25mWE9lMBuUCANeI/En+yip6InhHUAAtUE94DTbKofe7oyh32SCILeRrq5SO5+aIL2tMuEgKAdCgoC7t4NZ2WDSS7zypTg80MU5YXOSi6wwd3pGY1NeIiHkOcx1vxYuRfZaMPLRvgfuiYMgwrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDchjtYa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737202138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C9raI1g/UgxgGG/x5clWO4YF2oSKgSlL9JWdAe+m5P0=;
	b=jDchjtYaxCNZyMvFAt4HZlTwWD7ff5asqXKctRpbS81UNPqQq7SAArPUzKpBTDXzLF7mf5
	1pMbFEY8uQ7ECldGVhSzuusuXWcvFZMzZfSpeNQGtPvRT24cUHekuThvV5bEQPF1CDGApN
	G7o4/abbcXL9HJ/ZKlPyIn48SdHV2Lc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-Bh85E5NPOMayK6zlvt2d6A-1; Sat, 18 Jan 2025 07:08:57 -0500
X-MC-Unique: Bh85E5NPOMayK6zlvt2d6A-1
X-Mimecast-MFC-AGG-ID: Bh85E5NPOMayK6zlvt2d6A
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-216750b679eso40682815ad.1
        for <linux-nfs@vger.kernel.org>; Sat, 18 Jan 2025 04:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737202135; x=1737806935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9raI1g/UgxgGG/x5clWO4YF2oSKgSlL9JWdAe+m5P0=;
        b=dG/ZoERBWNJ25/yA16y/acijG4Ch1cyNVGB8eI1N9Q+/AMuLTa8lzQ/Z4VdYMUZ03V
         GwsixmjbgUFUHOU2/3JykDTdSShk9iIiyfR4+EeAy8KDRNSyzba3/hoyfd/78d9MS6AF
         UEvvtmnh8ypZUj04GYxR2GOY/7Xv0qZ4GFIzAZPP6cUExa+k70jq7he9EwYjZPW6OVq4
         hLK8TNnhD9LpKGiS1Da6oZR6K3iQszWJn9W77XvM+vKvtAJTnrtcSQgT+YXONMVrHKaL
         KX/teieNvsCSHPQ5deNik20WMxLiklxk11/YxKYrubYBvzNMJ6rpMNEcD6nGQ9/HajB4
         yqMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIX7EQjZniZ+vsQ5UIUduRlkEtubCdNBOpAkbtCC4HLUTXgTc3lYmuq6vNhK7GGeugVNaSkVdmVqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzihc1YZuIPKD0B6lA9QRqv2rT8Y3sAtvGCWeTGqGr2TQk0bkWX
	llYCZ6hUFLCI7nQsTO6Z6gOsIc6hyMDh+e1dND577qZ8PuGrfayt8t/mSAE+Em5V8dYszkBdFRQ
	T+izwNreTd9GCfI7BUOVgbAWEnGqqy/vqTH0HAFJ/mhMqyVhXhdrY/xutrIjA4cc52g==
X-Gm-Gg: ASbGnctKlePshWy96ZBMIsqrQd9QIdZs/eBYJQzY5yn4XyXBvi5xew/ZpKy/kXrMXqT
	tPvoOy87Py/e6Hq41JfP9zn73sHZo1QwjE3/vkEGVDJ+5NckLrxPc+8jzVtnKWRdo+Zq9r/7vdW
	Y6SSYVr1zSkDTxi8YEuURML5Nq6zkh3bN3ChcwMiCenOOQsuPlWje7ZI7nlRCTyL6KQJNGF0w39
	RpziDmcEqz5+8uQ3PXhQtZFVfjlyPWtEymysBm4fP73yu6wskNJp1HaQExdQ+uS4zWdRw==
X-Received: by 2002:a05:6a20:6a0a:b0:1e0:d87a:f67 with SMTP id adf61e73a8af0-1eb21485364mr9384060637.13.1737202135257;
        Sat, 18 Jan 2025 04:08:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEQmoYNGrwopGoyTGfiVSAkif+/7rPe7e3Df+LaBITOQvnBLTNgq7V/S5Wlq6idRu22bzhCA==
X-Received: by 2002:a05:6a20:6a0a:b0:1e0:d87a:f67 with SMTP id adf61e73a8af0-1eb21485364mr9384035637.13.1737202134912;
        Sat, 18 Jan 2025 04:08:54 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bcaa3a5a4sm3003125a12.16.2025.01.18.04.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2025 04:08:54 -0800 (PST)
Message-ID: <52431baf-7df8-4437-813d-b4914c415fa9@redhat.com>
Date: Sat, 18 Jan 2025 07:08:52 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH v3 0/3] version handling fixes for nfsdctl and
 rpc.nfsd
To: Scott Mayhew <smayhew@redhat.com>
Cc: jlayton@kernel.org, yoyang@redhat.com, linux-nfs@vger.kernel.org
References: <20250113231319.951885-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250113231319.951885-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/13/25 6:13 PM, Scott Mayhew wrote:
> Two changes in how nfsdctl does version handling and one for rpc.nfsd.
> 
> The first patch makes the 'nfsdctl version' command behave according to
> the man page for w.r.t handling +4/-4, e.g.
> 
> # utils/nfsdctl/nfsdctl
> nfsdctl> threads 0
> nfsdctl> version
> +3.0 +4.0 +4.1 +4.2
> nfsdctl> version -4
> nfsdctl> version
> +3.0 -4.0 -4.1 -4.2
> nfsdctl> version +4
> nfsdctl> version
> +3.0 +4.0 +4.1 +4.2
> nfsdctl> version -4 +4.2
> nfsdctl> version
> +3.0 -4.0 -4.1 +4.2
> nfsdctl> ^D
> 
> The second patch makes nfsdctl's handling of the nfsd version options in
> nfs.conf behave like rpc.nfsd's.  This is important since the systemd
> service file will fall back to rpc.nfsd if nfsdctl fails.  Note that the
> v3 version of this patch also makes 'nfsdctl autostart' fail with an
> error if no versions and no minor versions are enabled in nfs.conf.
> 
> The third patch (also new in this v3 posting) makes rpc.nfsd consider
> the 'minorvers' bit field when determining whether any versions have
> been enabled.  This takes care of two scenarios:
> 1) When vers4=y but vers4.0=vers4.1=vers4.2=n
> 2) When vers2=vers3=vers4=n but any of vers4.0/vers4.1/vers4.2=y
> 
> -Scott
> 
> Scott Mayhew (3):
>    nfsdctl: tweak the version subcommand behavior
>    nfsdctl: tweak the nfs.conf version handling
>    nfsd: fix version sanity check
> 
>   utils/nfsd/nfsd.c       | 29 +++++++++++---
>   utils/nfsdctl/nfsdctl.c | 86 +++++++++++++++++++++++++++++++++++------
>   2 files changed, 98 insertions(+), 17 deletions(-)
> 
All 3 patches are committed... (tag: nfs-utils-2-8-3-rc3)

Note: the nfsdctl nlm patch apply cleanly to these
patches so when the kernel patch reaches a public
kernel... we will be good to go.

steved.


