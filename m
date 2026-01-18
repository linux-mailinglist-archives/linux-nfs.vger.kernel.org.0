Return-Path: <linux-nfs+bounces-18085-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D21D399A5
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Jan 2026 21:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01890300307A
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Jan 2026 20:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C012737F8;
	Sun, 18 Jan 2026 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSVN93gp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWg9NS7P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF6248873
	for <linux-nfs@vger.kernel.org>; Sun, 18 Jan 2026 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768766966; cv=none; b=q2ooEO7sCrmDB7K67AkgyHeXc84u4q2xXW7vxa1eJYxg/vVc0ScOXyUb9OF/yllBX77hQ6j/lfV4AsOIpRyrS85SWlkl5gW04QsI8crsvJeKcNQ2f8bivDC/MbcFZwoTvT01jK0oAEoz3Q47Y9jvdML2IU8QJ2mo9KpVClwfYAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768766966; c=relaxed/simple;
	bh=stjuy+szpKcJvHL2EW4Hy9tm2s8/uul5y8frETqCFBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxnGcrz9qA8pb3DzEizO3YvurP56aojkgN5Dn+XBjtmsJvlTg6GXTZGGU924SWUoRw627CkM2lDGFJuODHle3EDBzvTQgZfPngWc7I//WvGusLjG2JmBQSgSBGwXN6vsryhizsStryRAvwrhWwgapTLaGXNYiyuSPAxQ2JUe0KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hSVN93gp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWg9NS7P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768766963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEhAI8iiRlzq4HbuX4rau4oDggQV9Y1JkvO+cJTpLBs=;
	b=hSVN93gp96ECQtjzDu+cIGnLVNiF41odWyT1zqgNUEoZvv7cGVEfLlm1rppGQ30wP8To4x
	+N3+4CNRhtm8K06VlPhHIOxMq26c6NBjwlXYd7AWP4RMbxzSxWDcif4+fugDCPslLJDoE2
	dUwlkmvaDwAxXQ0JyqSLWmJ/jU9yzWs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-t1ETuipINliYp_0dXwvzOg-1; Sun, 18 Jan 2026 15:09:22 -0500
X-MC-Unique: t1ETuipINliYp_0dXwvzOg-1
X-Mimecast-MFC-AGG-ID: t1ETuipINliYp_0dXwvzOg_1768766962
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50147745917so171378811cf.3
        for <linux-nfs@vger.kernel.org>; Sun, 18 Jan 2026 12:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768766962; x=1769371762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEhAI8iiRlzq4HbuX4rau4oDggQV9Y1JkvO+cJTpLBs=;
        b=XWg9NS7PB82w3qlXYoTngDwr1fqicSOHqqeZVJlAHO5nwe4VcIm1OYDi67gU+CyWa5
         4At+8zK4TtSvmcRfhsIo1wbLjD1qFBj6lwVcMZO1GevT093QyWaKKPe5CSthvFXCTjq6
         WF8VvuT7yWEfdpYo1MiC4lDCrnTjvaBy1Sz9iAbq33xGMZv9Ji+mhnTG79RsI1LNFJHr
         B/0P2ROD1+evdGYmIHP7P8hSyQkAxY2+yPw/LAF2H1ZaVkFzRpFoJobC1FM/L6DyQfml
         HrsG2+NFjtQzoynOcX/WaOjNV/FSFrCPXgszlwi8skZ5fDtSkX9YqI9sj9qZd+UvM+J5
         S2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768766962; x=1769371762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEhAI8iiRlzq4HbuX4rau4oDggQV9Y1JkvO+cJTpLBs=;
        b=lBXdDDCQFk8wHWnlQa30ZNn6FxhaXzBgORj/BTi6+yjK79UoiM0zCvblIMF9HbeR/N
         jOXfEAO/TPiYUO/+BKsgfmTzA0hH9Bp+dqjb7rQcZcD983W1GHgKmzyMMkXXV2ZwRaqI
         VmA6ia9T7awBDQDW2sqEAcd1FO3ZdF1Aqjq/+LWtIEEawxNS8pH2PTdUBe5KCM9Pt7xR
         ML9EHLc3Gddey2wOGoc1AlpkueKngK4wDi2beJgdGLOl1LV6NZQ5/Sop1kv4HzgSZluM
         tYXb76tUqEQcoTckmm6fjeHH/uBpaTK4BA8loqsJlydE6dhRpb0js9gQsF326taZBmkV
         N3QQ==
X-Gm-Message-State: AOJu0YyyDNawU5rKZMqQ9ijuuLLIYwWiA5V8xEtDLSa7mjUgDfhPOwmu
	KIiI8funwUzXUORVQf57pl7Abl8N7tXo0++qRUCr2jS2CatktrIRXUENLfHg5A9fNA4HeFohfVR
	JefQa05ySRRVI7Ii14fZqajoputCK2g52ONnTCbvB5gUjIDi328RtJYUvppjxQQ==
X-Gm-Gg: AY/fxX57+XvFw1oQQhYmN5zTMCPDZRNmN6CBVNHv9lVozj139/IIqMZUWFhUvsH78x2
	IahPSD4oGTAhASmurJBlf0LUxYO1w+0OlKEky8AH+U51KyR/GmMJDCcru11xB3LFOf5HBHU8PqA
	dOXkhCW1B02OpDXJgriMLZFaCat4Dhk3lGT9KCh4ErQ1TKv1y9C4vdFwBGBBK3xyO8F7j5JQxOQ
	ao4nepEhvEiWsMmWgVLWuHjdg9WMEEL3aCj71YxXpmKV1DVo2dovbv1Uij7i2QUzsdDyXX3QoJt
	xWmmc62VKZIMCxDorHOZgQ0222XeFrms+otZiFU1iMoaTWN6TWJXAIhkBwwvDBbxbjix5UbZTON
	+V8RXOOAY
X-Received: by 2002:ac8:7d96:0:b0:4ee:4128:beb7 with SMTP id d75a77b69052e-502a1f99513mr122452761cf.69.1768766962069;
        Sun, 18 Jan 2026 12:09:22 -0800 (PST)
X-Received: by 2002:ac8:7d96:0:b0:4ee:4128:beb7 with SMTP id d75a77b69052e-502a1f99513mr122452551cf.69.1768766961692;
        Sun, 18 Jan 2026 12:09:21 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1f1b87fsm60622671cf.32.2026.01.18.12.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 12:09:20 -0800 (PST)
Message-ID: <b8a5e632-2f23-4706-9daa-8e25133d1f8c@redhat.com>
Date: Sun, 18 Jan 2026 15:09:18 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] nfsdctl/rpc.nfsd: Add support for passing
 encrypted filehandle key
To: Benjamin Coddington <bcodding@hammerspace.com>,
 NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>
References: <cover.1768586942.git.bcodding@hammerspace.com>
 <90fad47b2b34117ae30373569a5e5a87ef63cec7.1768586942.git.bcodding@hammerspace.com>
 <176868679725.16766.14739276568986177664@noble.neil.brown.name>
 <8328B53F-21DE-4237-AF79-5DE88D53D8B9@hammerspace.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <8328B53F-21DE-4237-AF79-5DE88D53D8B9@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/18/26 11:59 AM, Benjamin Coddington wrote:
> On 17 Jan 2026, at 16:53, NeilBrown wrote:
> 
>> On Sat, 17 Jan 2026, Benjamin Coddington wrote:
>>> If fh-key-file=<path> is set in nfs.conf, the "nfsdctl autostart" command
>>
>> ... is set in THE NFSD SECTION OF nfs.conf
>>
>>
>>> will hash the contents of the file with libuuid's uuid_generate_sha1 and
>>> send the first 16 bytes into the kernel via NFSD_CMD_FH_KEY_SET.
>>
>> This patch adds no code that uses uuid_generate_sha1(), and doesn't
>> provide any code for hash_fh_key_file()...
> 
> I forgot to add the hash function after moving it into libnfs to make it
> available to both rpc.nfsd and nfsdctl -- here it is, will fix on v2:
I'm a bit confused... This patch conflicts with the
"nfsdctl: Add support for passing encrypted filehandle key" patch.

So which patches should I take and which patches are tested ;-)

steved.

> 
> diff --git a/support/nfs/fh_key_file.c b/support/nfs/fh_key_file.c
> new file mode 100644
> index 000000000000..350d36bf8649
> --- /dev/null
> +++ b/support/nfs/fh_key_file.c
> @@ -0,0 +1,83 @@
> +/*
> + * Copyright (c) 2025 Benjamin Coddington <bcodding@hammerspace.com>
> + * All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
> + * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
> + * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
> + * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <uuid/uuid.h>
> +
> +#include "nfslib.h"
> +
> +#define HASH_BLOCKSIZE  256
> +int hash_fh_key_file(const char *fh_key_file, uuid_t uuid)
> +{
> +	const char seed_s[] = "8fc57f1b-1a6f-482f-af92-d2e007c1ae58";
> +	FILE *sfile = NULL;
> +	char *buf = malloc(HASH_BLOCKSIZE);
> +	size_t pos;
> +	int ret = 0;
> +
> +	if (!buf)
> +		goto out;
> +
> +	sfile = fopen(fh_key_file, "r");
> +	if (!sfile) {
> +		ret = errno;
> +		xlog(L_ERROR, "Unable to read fh-key-file %s: %s", fh_key_file, strerror(errno));
> +		goto out;
> +	}
> +
> +	uuid_parse(seed_s, uuid);
> +	while (1) {
> +		size_t sread;
> +		pos = 0;
> +
> +		while (1) {
> +			if (feof(sfile))
> +				goto finish_block;
> +
> +			sread = fread(buf + pos, 1, HASH_BLOCKSIZE - pos, sfile);
> +			pos += sread;
> +
> +			if (pos == HASH_BLOCKSIZE)
> +				break;
> +
> +			if (sread == 0) {
> +				if (ferror(sfile))
> +					goto out;
> +				goto finish_block;
> +			}
> +		}
> +		uuid_generate_sha1(uuid, uuid, buf, HASH_BLOCKSIZE);
> +	}
> +finish_block:
> +	if (pos)
> +		uuid_generate_sha1(uuid, uuid, buf, pos);
> +out:
> +	if (sfile)
> +		fclose(sfile);
> +	free(buf);
> +	return ret;
> +}
> 


