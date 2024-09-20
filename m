Return-Path: <linux-nfs+bounces-6574-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5342797D8F0
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 19:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864CA1C2146A
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 17:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2641EF1D;
	Fri, 20 Sep 2024 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjcZuI06"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D51C6BE
	for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2024 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726852654; cv=none; b=BLyg01Jdv9q0M8bZgGKPvzghpwyfStR8O9v8jzMnMkrkauyIxLVk7ReMUMPLvt7FuTKLdKyogwiipazk1caHEmTu6cuEViPpPDAl+GGnLCbg5gwuzjf7sS0e5PBGmBa3/Z1QoK/D0vb501La6QeU3rbct2M2jEC7RSpbAztFQgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726852654; c=relaxed/simple;
	bh=Zqo5GlkAVmJu9XAYcViNrg5uHmrvUIam3f9fwm8hWXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSjZU2O+jz8Nr4xOQCdyHBkCgmx+QUikXrFHURpBKXuP/qTvtQ0OU7uWetZb4pVHeKIQEUOGiLLtYQLqGVsxRo2hrBe8HFeSECuG24wxty3BELQSPGlycirZMCMcrkqNPK6arASTuZhhoUZGYU54MOJ9rpk7e3wE8AitbCA1ELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjcZuI06; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726852652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FV8uQuv3VSwTcumbGMKM3umSQD2U+KspAyk5bxHeiHE=;
	b=LjcZuI06OzaIXSMRwCi7+5OD6phgFeAEZHp4uK8ygTxivYwbc3+SSMdRGilFdghcT2D7Sc
	WrWy5g7FV2Kfwb+0n0YJGa5u7+1OVFOqAhRNf+4z0NgZb1GVu/Tg7caLgx5uMlM6llOeHF
	lFzMA6rAH8MYQEnBPi2gAtBDsmJLqvg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-X322ddiXNESVq7DhLdUZ2w-1; Fri, 20 Sep 2024 13:17:31 -0400
X-MC-Unique: X322ddiXNESVq7DhLdUZ2w-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7ac8d3dbe5bso288607385a.3
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2024 10:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726852649; x=1727457449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FV8uQuv3VSwTcumbGMKM3umSQD2U+KspAyk5bxHeiHE=;
        b=nQ1cE7WuwtQCxHmwsDSHsth72LDWc9QaD8Fk/Q0nSFxUKytriF2o3KA/FYi74uRqbh
         B8DOSf7EBmc3pn/xj1+fwO4P7d4Orh2Mn7Us4I4AyKsR6VVQycghjRIhKzQIACCpPBRZ
         sq0TjnULuUZuHmltgupRbMiTO0XiTv1HEv2XfNL/3HuxxdLlU6sNOs1MUx7OYYyWsKiW
         zEi1Qlu9byqhgIkR3yjX7QU4z6qS8JmlD4vMR1VJwItRFrujRFrXqCyH9IwlR1Oe4vDV
         wH/UGH9JSd6LxNc32LFHANxWLihaaeNZTID5822JQYVpiG4SKjCi4P1YujiWCeQjiRc/
         ktLA==
X-Gm-Message-State: AOJu0Yy0jFecqH5w+vzR4q2Y+NGXHu0HF0ZDoE++33+Vx5ve0diT26iO
	Ua53CduTesBj29RVMPSrEiGINjG8qQDvs9t/QSZSlo/GR0QUYmPqGc/cVK71gGHj4dVLIytt8TT
	exXoYtXw4ZwUj3Juin9AQIcvkclvFNFWrelVgTfMT8b6Y7tqeUfHKBEKUDZcSTU07uIHe
X-Received: by 2002:a05:620a:178b:b0:7a7:f18a:e46f with SMTP id af79cd13be357-7acb8ddba2amr512607085a.43.1726852649606;
        Fri, 20 Sep 2024 10:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL0MafvKsVt9JG4B8XJqTBx374QhZ7DLwtHnFak8MFtggYkGpQb46vJTc2af8KdnFsNdb7Ow==
X-Received: by 2002:a05:620a:178b:b0:7a7:f18a:e46f with SMTP id af79cd13be357-7acb8ddba2amr512603885a.43.1726852649183;
        Fri, 20 Sep 2024 10:17:29 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.241.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08d5549sm201112885a.103.2024.09.20.10.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 10:17:28 -0700 (PDT)
Message-ID: <47306407-a2ec-4045-b8e4-f2bfdfd19677@redhat.com>
Date: Fri, 20 Sep 2024 13:17:26 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] nfsdcld: don't send null client ids to the
 kernel
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20240905193623.408531-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240905193623.408531-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/5/24 3:36 PM, Scott Mayhew wrote:
> It's apparently possible for the sqlite database to get corrupted and
> cause one or more rows to have null in the id column.
> 
> The knfsd fix was posted here:
> https://lore.kernel.org/linux-nfs/20240903111446.659884-1-lilingfeng3@huawei.com/
> 
> nfsdcld should have a similar fix.  If we encounter a client record with
> a null id, just skip it instead of sending it to the kernel.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed... (tag: nfs-utils-2-7-2-rc1

steved
> ---
>   utils/nfsdcld/sqlite.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
> index 03016fb9..88636848 100644
> --- a/utils/nfsdcld/sqlite.c
> +++ b/utils/nfsdcld/sqlite.c
> @@ -1337,6 +1337,11 @@ sqlite_iterate_recovery(int (*cb)(struct cld_client *clnt), struct cld_client *c
>   		id_len = sqlite3_column_bytes(stmt, 0);
>   		if (id_len > NFS4_OPAQUE_LIMIT)
>   			id_len = NFS4_OPAQUE_LIMIT;
> +		if (id_len == 0) {
> +			xlog(L_ERROR, "%s: Skipping client record with null id",
> +				__func__);
> +			continue;
> +		}
>   
>   		memset(&cmsg->cm_u, 0, sizeof(cmsg->cm_u));
>   #if UPCALL_VERSION >= 2


