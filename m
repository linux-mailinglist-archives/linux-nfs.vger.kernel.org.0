Return-Path: <linux-nfs+bounces-10783-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A84A6E47C
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 21:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076463B4F2E
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 20:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69E413B2A9;
	Mon, 24 Mar 2025 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDz+f2DM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0365B2E336D
	for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742848265; cv=none; b=DHAuFVMajjziwo48vdXcI7VxvkEbCd0B8sR0QkTIJ/D1AtPW/7VCyLncZwQ8oV48sqrAAkGPqbz08ddkDT4+i9sAcia7wCkDXxU/rxGOYBuTZsx2xnsStUJWvcmU72N74SOFDJwvRgK4XNawqJlC22oWjaQ0UtIbEIZO0tR1Kss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742848265; c=relaxed/simple;
	bh=anLxBF9Hk2WtOBVv17ynaOfSYeFusNjfHusJXupjiqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBxmc1hfHq2vepuVZQKhdYmTNj/7a4wtPzDNlBgO/Kc1A1zq32uMA79HJbi8n9P/MQrZ2OxXLXxyXcFQaTmnyXs4akH1O9ROlOU/Uv+/0/fVcgCX6Ha/xuIGaWobbWAJ541qfioNNR1JJ1W0TCVXYYvVp/pPHPZqDntSQ4PuoKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDz+f2DM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742848262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNpW6G12Ez1uQZ5lWOETSh0XiqiuEvRmmJkAi9OaBKk=;
	b=BDz+f2DMvA7386GbtACygqJi1Xi0yu8VUO+MXjMhfenRCG9G5DdswZABWCUJ6IBG3j0evO
	oDXzR5gHENOdfbYbe4Ma9O/2bwtHnwNjFjl8KLwPn3AuZvWpmhDV0m1hJ8t4Uc0dBQljd/
	NcJ8WiRbqFKdn9gVhU7ft1IqZoJKNHI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-2mAzSBnuPsC-Rh0tzjgysw-1; Mon, 24 Mar 2025 16:30:33 -0400
X-MC-Unique: 2mAzSBnuPsC-Rh0tzjgysw-1
X-Mimecast-MFC-AGG-ID: 2mAzSBnuPsC-Rh0tzjgysw_1742848232
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c572339444so765120385a.3
        for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 13:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742848232; x=1743453032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNpW6G12Ez1uQZ5lWOETSh0XiqiuEvRmmJkAi9OaBKk=;
        b=Gqowzq8CFN7I5g/UdP8Hw3fhdxTY4XRm1a35YXOE563Nco5M/w4Q4UWh+ftooehpMt
         xCUaMajdTm1ZFetdkAKGJ374DLhBBIrmgSc8oPprz3oI2a6+w5BcyfxZzdnn5E4dpswO
         QuW6zqNRvk1zgWzRDVFxdwjkJJcbAbxK43XTLcHK0TxrkiK4mQ+fWY/1JLUaew3oZ9z0
         VbrvAUBj8YbOUKP4e7XetPHSCek2Rzn7TK6p6q7XMCR+8Az2gX7K5RLcCAJWUVuMuZoV
         guC5v7T+DmGc5GV7WZfA0JbTpe2gYhPrlMmfHCKzGUXJ2OBKiJm2rFfKKFCuLvC9kzk7
         6ZgQ==
X-Gm-Message-State: AOJu0Ywd19ApYa20FxsFmVfRcqWldTzsjN3PY4lWVLgkASLRrCa0Lv0D
	oIxfkfG8RfcdQfWn2y0DtaLkL6tN5ILzeYF7kWXAUsiz1mRfyXUpcw8nOh+2UXlzEQN8rlo0HpQ
	uuKMvntzlXTGh7fM6e6ZKIO6y5XEjAgBcx6HbM1e6G8MAk7J3226MVyCIzKooz58/5Dt9
X-Gm-Gg: ASbGncucrmIAoOmQcv2/VPUBBtCzAT2C8dkvjLMrGDMVHMkozUIsnnFXCFUay4UxqQC
	TWIUaNoN9ZKH0FUWbyq3LIslpJQnUyfcbp2VEArhpQ2v8UkWvJ6gq2EqDl1XUv/1Sq14JwVcJ7l
	UruOPrM+X0If4cWw5xxeCu8UJDmnAg+Q8MSDSDIVVqV+zuow0XgThDiFuARJ76LD2yCeF9+r6NU
	83g/Xy0JSGvDnBWrzHdNsb2qYmJhKIpIgIqfjJlWxVZb5bF1ZEy5fXQwJdod8r0JpfcPIKJD5+P
	RkpSp5S6hplVCTQ=
X-Received: by 2002:a05:620a:244b:b0:7c5:79c6:645d with SMTP id af79cd13be357-7c5ba13ab4emr1698823485a.11.1742848231681;
        Mon, 24 Mar 2025 13:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2UcOYVwWyoUUhjRmv70EdUoSg7v6i91bCNzmtJtQ4N0NeZ33GM+PqkLl4PFAM/vRKdOjp9g==
X-Received: by 2002:a05:620a:244b:b0:7c5:79c6:645d with SMTP id af79cd13be357-7c5ba13ab4emr1698818185a.11.1742848231117;
        Mon, 24 Mar 2025 13:30:31 -0700 (PDT)
Received: from [172.31.1.159] ([70.105.244.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92b932dsm552567085a.4.2025.03.24.13.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 13:30:30 -0700 (PDT)
Message-ID: <d099ed2a-f202-4fa2-9279-0e57826d0a69@redhat.com>
Date: Mon, 24 Mar 2025 16:30:29 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs(5): Add new rdirplus functionality, clarify
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <A89FDC8D-114F-4D0E-B898-EC0FB4D747E1@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <A89FDC8D-114F-4D0E-B898-EC0FB4D747E1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/24/25 1:47 PM, Benjamin Coddington wrote:
> The proposed kernel [patch][1] will modify the rdirplus mount option to
> accept optional string values of "none" and "force".  Update the man page
> to reflect these changes and clarify the current client's behavior for the
> default.
> 
> [1]: https://lore.kernel.org/linux-nfs/8c33cd92be52255b0dd0a7489c9e5cc35434ec95.1741876784.git.bcodding@redhat.com/T/#u
> 
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Committed... (tag: nfs-utils-2-8-3-rc8)

steved.
> ---
>   utils/mount/nfs.man | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index eab4692a87de..91fc508de280 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -434,11 +434,16 @@ option may also be used by some pNFS drivers to decide how many
>   connections to set up to the data servers.
>   .TP 1.5i
>   .BR rdirplus " / " nordirplus
> -Selects whether to use NFS v3 or v4 READDIRPLUS requests.
> -If this option is not specified, the NFS client uses READDIRPLUS requests
> -on NFS v3 or v4 mounts to read small directories.
> -Some applications perform better if the client uses only READDIR requests
> -for all directories.
> +Selects whether to use NFS v3 or v4 READDIRPLUS requests.  If this option is
> +not specified, the NFS client uses a heuristic to optimize performance by
> +choosing READDIR vs READDIRPLUS based on how often the calling process uses
> +the additional attributes returned from READDIRPLUS.  Some applications
> +perform better if the client uses only READDIR requests for all directories.
> +.TP 1.5i
> +.BR rdirplus={none|force}
> +If set to "force", the NFS client always attempts to use READDIRPLUS
> +requests.  If set to "none", the behavior is the same as
> +.B nordirplus.
>   .TP 1.5i
>   .BI retry= n
>   The number of minutes that the


