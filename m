Return-Path: <linux-nfs+bounces-6072-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF689672E3
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Aug 2024 19:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CA5282E60
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Aug 2024 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F6810A3D;
	Sat, 31 Aug 2024 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSbJarvG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4E13C00
	for <linux-nfs@vger.kernel.org>; Sat, 31 Aug 2024 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725126940; cv=none; b=Kbb42AMp3aJEcSem1YlUpufBKRhGENhU1PW/9Jcqpgj8ZVZ54TTyUrv8ZSgjluVT88bMYAy8yYViYVuCQCQCw9rnENIAxtHzKhD9MX3BxBQmS+gKGNaUbznXbW5KppBQNW8wf5EaRGF4CG8y6scFh9p8jN5b+z8PuwsTZTxCRKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725126940; c=relaxed/simple;
	bh=wChhicFyyQhq06PCs52shWFMCA5VpukPNTtHO5uZ5w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSU+LVvmMu7WMuthHGCEeM8jSN0S5kdR7bIDgoPv4cR5u7n6agEFFnDKTvXHPQS7Fv84eDIXdQXntkWYKDCh43KtRYbjpvFih2QAg5b5t9G3bWV4vMwFRur2C1sNiu8Mcz/Gp3+aBBFika0CDKmwfq8sfYPL0zADeXmITofF7xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WSbJarvG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725126937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9V8AwrCH474x8smd+LGnAeJYJJIdwVWtoMrEjRZ0L2c=;
	b=WSbJarvGKV6fQuVKprfn/ocgbrWgPYNaukY/xmJkuOegdJbxpbr9NURMXCWp2KVtGiAMC+
	eHRi07Jp/7N1wBOc+8iqkHPMfa1TG5YTusWOpphRopPJiMwD0x0cv1gsynZBtva5NLUYVl
	ql+4kxix1ddgbB8ygf3BjyCt/3pu7hM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-flvTbZfNPPSgMYKfZhebkQ-1; Sat, 31 Aug 2024 13:55:36 -0400
X-MC-Unique: flvTbZfNPPSgMYKfZhebkQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a7ff78ce40so570074185a.1
        for <linux-nfs@vger.kernel.org>; Sat, 31 Aug 2024 10:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725126934; x=1725731734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9V8AwrCH474x8smd+LGnAeJYJJIdwVWtoMrEjRZ0L2c=;
        b=mUZKjAmi5QlDLpT7v/55+dOUeDun9/8QDso9Ou2pk1425qTt2DHfSpOVUbyHelu7CT
         qZoPxsyl4U9FG9O1H6fUIjCCPkEntOIgWjMAw2Dcs097sQxKBpX42lE8foATXKXK1qyi
         SOaHl7By78G7F841beVcKzPgPtuymo7VysLaoT8hPqASLRSYARpo4PfqPtC2cQmKgz/6
         ovpJnKzQk/HITyGEfRHij26u2tSGlmx2Q4kVDdiD117dG42dWPSFqbakNctfu1Gwk9S+
         FEsb8ERPNGuNtSgz7tV9aWEEaAS0I6wBVJyeduTf/xF38MjSMkBlW+7DmEk/50IuY/lf
         1F8w==
X-Forwarded-Encrypted: i=1; AJvYcCXUkCkcdvQlEiLnFurLlHZHtRnypia7qInOYQ0bNSOnvN2IP5oLwg8Um0Gbg1MMdpkp3oJ5zD9v4fk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdzmxvz0t+oDo1aXEbWl/YSXm76ONwFn3J5SZ9eSzHrL9Bn/z6
	1akw7WlfLR88eiqystN4LQaB5gXwQtm/eNqbq6lfvFCm66MfOF8OaI8p/TjT21LuZSY4wEQOW9x
	w2T4v6GdnPDqgpna44947mO2Tb82CwtlyH6CgM/1NpqZGMjIJ4CCJ8SHQFktwdJba8w==
X-Received: by 2002:a05:620a:410b:b0:79f:17d9:d86b with SMTP id af79cd13be357-7a81d64267amr548412085a.12.1725126934490;
        Sat, 31 Aug 2024 10:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwWWfRziOdsqCIM0nQBmHuLFmTjlw6hhcR7xkb5BxgeXiZ6+4sYrmDDDqdNpxHG6Joc5VrqQ==
X-Received: by 2002:a05:620a:410b:b0:79f:17d9:d86b with SMTP id af79cd13be357-7a81d64267amr548410585a.12.1725126934165;
        Sat, 31 Aug 2024 10:55:34 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.250.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c24165sm260832785a.43.2024.08.31.10.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 10:55:33 -0700 (PDT)
Message-ID: <574fc1f6-ae3e-41a4-b230-b9ddf8ce8263@redhat.com>
Date: Sat, 31 Aug 2024 13:55:32 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rpcbind 1/1] Move rpcbind.lock to /run
To: Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net, Thomas Blume
 <thomas.blume@suse.com>, Josue Ortega <josue@debian.org>,
 NeilBrown <neilb@suse.de>, Yann Leprince <yann.leprince@ylep.fr>
References: <20240830173920.88877-1-pvorel@suse.cz>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240830173920.88877-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/30/24 1:39 PM, Petr Vorel wrote:
> From: Thomas Blume <thomas.blume@suse.com>
> 
> Most of the distros have /var/run as symlink to /run.
> 
> Because /var may be a separate partition, and could even be mounted via
> NFS, having to look directly to /run help to avoid issues rpcbind
> startup early in boot when /var might not be available.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Thomas Blume <thomas.blume@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
Committed... (tag: rpcbind-1_2_8-rc1)

steved.
> ---
> NOTE: I chose opensuse patch for the simplicity, instead of Debian
> patch, which unsets _PATH_RPCBINDSOCK (libtirpc).
> 
> I'll send a separate patch for libtirpc.
> 
> Kind regards,
> Petr
> 
>   src/rpcbind.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/rpcbind.c b/src/rpcbind.c
> index ecebe97..9887b82 100644
> --- a/src/rpcbind.c
> +++ b/src/rpcbind.c
> @@ -105,7 +105,7 @@ char *nss_modules = "files";
>   /* who to suid to if -s is given */
>   #define RUN_AS  "daemon"
>   
> -#define RPCBINDDLOCK "/var/run/rpcbind.lock"
> +#define RPCBINDDLOCK "/run/rpcbind.lock"
>   
>   int runasdaemon = 0;
>   int insecure = 0;


