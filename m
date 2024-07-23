Return-Path: <linux-nfs+bounces-5020-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA72B93A42B
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 18:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB735B223F8
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 16:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DE1156F4D;
	Tue, 23 Jul 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiQYOd/v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D3C156F40
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750975; cv=none; b=f4VoC+/xY5pIbrszweJo5IOO2r9pssx+j5MRoEPNYWOQ+sjDXNCnZkTBJTsuAzpSlYBopHJwAN50za6ccPgOOkU6dF9299VzM3oH8SIYF4FCKxIsFOdq4DTaH6zN+vGlYMBc48o1dKd2EWu+citAk9PhF1r8P/cbumIXwcI7n8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750975; c=relaxed/simple;
	bh=4qy8ZBcAnI9dzraGgDlkTxLiVtqd3ERS3tYif//cUyo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=suvaXymCpEA8bnTpvaZfU6SRPN7JWDh/HDwhNSYQhpCfdinJj/oRzppRfhhnIHOzR8nrUkNY+uU1QkYwBX0eLsjZiswSzzGER80gD4YlwsbJE8z1OnjpkYm0gWvD/sAkJWK4B9qONvXAES24Rtb1TsQx64pWUhsD1rB8ZW7A0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eiQYOd/v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721750971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxNq8BfOTtQ08jqfWMm5N9QmG6cTevIgJrzk8banxpo=;
	b=eiQYOd/vQJKG7WS0m1XuuPe0FPShUJEPZunxuQM1CNHWLiR4TxMooPxTqsGMJHpTrIlDiX
	KUyNCRKkxBhWVkbsJNpIDAqk4EGki0Wv3Z3dNbY9ihiEho2xoPlv8vhahdRp+XK6oLUs5M
	gXVAEJcrVNWrZ2C0veazAtw8ULDLcfM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-P7BdaKRVO7KiSQ-kgYCKAg-1; Tue, 23 Jul 2024 12:09:30 -0400
X-MC-Unique: P7BdaKRVO7KiSQ-kgYCKAg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b797b6b4aeso17859576d6.0
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 09:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721750968; x=1722355768;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxNq8BfOTtQ08jqfWMm5N9QmG6cTevIgJrzk8banxpo=;
        b=rDiF1dHUl6gt5zqv+7c1jsJRuJ3HBlGT6JbqOZkSfzbmtS3GY7YVXypqOc7vqKl/7D
         vfgNxoEPc1ghtSyokjEMON23AdUYiEkeLSoQwNipsR4qiW2sJ/A5NVEj6zlWtzW+niuZ
         n/55lwrH7d4EzKF6owerF7uMgNrPVjQ5sEVZ3PM47fCEOdnnzTGEjbzwiD4jakz/urG0
         36R0/DWoaevcuwTbvj2xftsbYEkjrcHUTDThVtOlSM4gbkh76Lu8nqV+Ms5gYVFKKFll
         44AB372Vz6P+rP6UjWjLYKiBF30To7liEWE4qyWnt/7BVcVYt5PEeEUGdKtMaiMDtEqn
         82zg==
X-Gm-Message-State: AOJu0YwsLGNooH8jNmN25taTbm4lyOuZVNx+fo/Irl9/RHgqr3DdBn4m
	9+Q1Bd4t5pCz+UsYKREWuSQ55agbFSd+1wErkLrtWYvZzWdsv4QLIjDYL0ImH74NyvdkcXjTV25
	RAH26j755H00DuAVbU8XFJEpfi0lYuJAyebd95tzPr/dupHPj4+LwBJfelmb4ZpIsntURplydDu
	OTJ3zdVSZldOIeIkYOk1LQNvxzeCzMh+fSCA4lWHo=
X-Received: by 2002:a05:620a:2585:b0:7a1:5683:4aad with SMTP id af79cd13be357-7a1a13d0f8fmr849080185a.9.1721750967980;
        Tue, 23 Jul 2024 09:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjaSSQmdISTrN+qUskXaZO8bAJfSO2Dz1avu0JB1YROImeDmXqJNGwriMd2X6ixNVW6PNn7w==
X-Received: by 2002:a05:620a:2585:b0:7a1:5683:4aad with SMTP id af79cd13be357-7a1a13d0f8fmr849077585a.9.1721750967469;
        Tue, 23 Jul 2024 09:09:27 -0700 (PDT)
Received: from [10.193.21.13] ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1990743bbsm494306285a.103.2024.07.23.09.09.26
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 09:09:26 -0700 (PDT)
Message-ID: <9b2b3578-930c-48e0-bbbd-26c87ada482a@redhat.com>
Date: Tue, 23 Jul 2024 12:09:26 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsidmap: Fix a memory leak
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20240722093209.64038-1-steved@redhat.com>
Content-Language: en-US
In-Reply-To: <20240722093209.64038-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/24 5:32 AM, Steve Dickson wrote:
> Reported-by: Zhang Yaqi <zhangyaqi@kylinos.cn>
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed...

steved.
> ---
>   support/nfsidmap/umich_ldap.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/support/nfsidmap/umich_ldap.c b/support/nfsidmap/umich_ldap.c
> index 1aa2af49..0f88ba44 100644
> --- a/support/nfsidmap/umich_ldap.c
> +++ b/support/nfsidmap/umich_ldap.c
> @@ -200,6 +200,7 @@ static int set_krb5_ccname(const char *krb5_ccache_name)
>   		IDMAP_LOG(5, ("Failed to set creds cache for kerberos, err(%d)",
>   			      retval));
>   	}
> +	free(env);
>   #endif /* else HAVE_GSS_KRB5_CCACHE_NAME */
>   out:
>   	return retval;


