Return-Path: <linux-nfs+bounces-18259-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Hq1LDcYcWmodQAAu9opvQ
	(envelope-from <linux-nfs+bounces-18259-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 19:17:27 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 874F35B280
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 19:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31AA6709B81
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 15:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C58E48C3EF;
	Wed, 21 Jan 2026 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHZwElVh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pR3qJWua"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170F748C8DF
	for <linux-nfs@vger.kernel.org>; Wed, 21 Jan 2026 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769009105; cv=none; b=rJhAqpHej3nQ9sdEg/+K6hdqbk/0YgnKPAXcCNjZgMliG0PhYiif+XjdeK8xgrcWTyobR4vLBykBwvd+vI549wmDtZyASwmvyNQ2RrMBeOkW5qpkV7cRxivraGzTrK3Elzoby2U3+e8AqQR8i46mMne25lOUACHlqXSiqebFMpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769009105; c=relaxed/simple;
	bh=b+rfCH3LUh2ZOaM6Pdy47Ox4FsWSJWRE/TGatfw3Eu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpqZTeczpNsaE62x34JxtNUlE9dC28DH4JfvDCciZ94aJX/mndFrPL87bo6d2UtOYo9u8bwKfaQj9KpsuepYR1cOSzJCqI/WiPrtrs835IQculAkwR49NtkWEVb9JYVch1IHyyI/+OMIo+X+6xvRjhKg/2Ijrj+b9RI8h6y1W/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHZwElVh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pR3qJWua; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769009103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nUxx0GylF2bV4/7LjnaMCcrV7fK4KQkSCoDNaHdqWvQ=;
	b=NHZwElVhl/9nSTLQNZNpP94IYheXoWRIuB92HjcRnDwOPCDrhMTSNkPfbyV5EOuIepUKSk
	R5mvCzlyRc4PaG1kCj0azAmpC+e9u8e+rbfV/LQLBPK4wV3pkHLCx8z+9nD7K5gHYVlrbw
	nijD253GDKA9MZg/2gyv6ue2S32n9Jo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-E09bvwNUN9i8Ll9bfJ54tw-1; Wed, 21 Jan 2026 10:25:01 -0500
X-MC-Unique: E09bvwNUN9i8Ll9bfJ54tw-1
X-Mimecast-MFC-AGG-ID: E09bvwNUN9i8Ll9bfJ54tw_1769009101
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6a0ec2496so1298605085a.1
        for <linux-nfs@vger.kernel.org>; Wed, 21 Jan 2026 07:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769009101; x=1769613901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUxx0GylF2bV4/7LjnaMCcrV7fK4KQkSCoDNaHdqWvQ=;
        b=pR3qJWuagdTYD3JXwoB4BFuGaz9kXTO6HORZv+3rYGcZdKk821eC7IrKrl9Pv3mX0M
         glhlVwtJRBlnAuXiB3a0/TiBgIsTV0f8Taexdyuv/hwqEt+aZ/5aDKJPW7HIe3bPFz3K
         PLshQzDQw8XCp/92nBM5nPqQ6ESE1riW+jOjUHe17wd9zPxMrtltxkusaHkhwb9vYDXs
         Lfw8+Q8s/+YtfH+tjj7qoxr3rqZyHlDGtaGyDuZNruOzG13REGg3DhrzUWXyHz9PZxRM
         UFnxNUp9Z66r1Ec6PH/phPPsZtEEyCyhfiy75/pe2cjrB+Mj8V1vimEcPcOEn4/F7EWg
         EJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769009101; x=1769613901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUxx0GylF2bV4/7LjnaMCcrV7fK4KQkSCoDNaHdqWvQ=;
        b=gGH6wCh6Wcf+2gYDne5Qp2EHM2XX9wzMfdQb7Fyl2n/0L1CXSbustgiD3DHqC7N5/J
         9AdSTm1WjVpq+Mn+6Eb4Z3hUEchnG6oComupd4T4W2u1w+qBtRVhoSbsCKu1EFBdAinN
         WNuiw5D0dwcjqrjv0vicfeV+C+JzBc8yvhjFoEsRFSDvjv//XM9nOVaYre6R4+SeQ5bw
         Qxf2qUS4m+vZJMdYq46w2Ht5GGi6rgawjrZddFRj4zOeweB+8tKlsk5rj1BvV7he6JpR
         ZqKNO6ddfC5UysE4Kd+5nfTpFShLmTlgGFTgoD2odlYBsT1QnYbUQ62MI6eTtwbP9RiE
         QTig==
X-Gm-Message-State: AOJu0YxwnKqY3NRQZYdv0uN/JIoRCPRBPHWiWHk1IDNfdubjXZYRUs6T
	m8nf3X0vrtgvG30L8v/eJt1s6g/nfVBTQFB84T+MYCTJRmwg+W5HRZ47iwV6Lp9bu1MdCdfu9cb
	xmjGyk90IipQr6N+p20SULfnC1TDGk5v53m7dIxLQYPkgd3Yk9imdEqBVktKqSA==
X-Gm-Gg: AZuq6aIuAyhdC5WaacWJDKBWCUDa1YaoUU6/wskfGGU02UxG5oOmQMWLnhQ7riFW1AO
	Ak+xvmfk2nUKQU3R9hAE84fEPH+ab61RKu7hG/n2GOA8gWjC3JxNS9OygDJ7dGY6QGI8EECFhH/
	eTc+aOZX+JN3Z0+R8q0h73ROp56j3k4DpbH51PVAfyORBTFh1Iu9iAUnPfY5472sNHUKFYL64V/
	oO2tVAQ/wiTUY+yZWxFGA+UscbNh30S40bf+VHt1T4Mo2qO4AP+LDOGwFXbfY7fkVxmbjJYpeH/
	TZ3wBosGyiq1gOwzEWEruvbN3mpO0dFxCgBG1LE/Ia9gV3ucNkTVq/+RlUJwoMuoTT9fpSWgHqO
	ynfxAvDP6Hg==
X-Received: by 2002:a05:620a:45a8:b0:8b2:e9d2:9c69 with SMTP id af79cd13be357-8c6a66f39f5mr2525226185a.22.1769009101045;
        Wed, 21 Jan 2026 07:25:01 -0800 (PST)
X-Received: by 2002:a05:620a:45a8:b0:8b2:e9d2:9c69 with SMTP id af79cd13be357-8c6a66f39f5mr2525222785a.22.1769009100552;
        Wed, 21 Jan 2026 07:25:00 -0800 (PST)
Received: from [172.31.1.175] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ac960sm1236278685a.4.2026.01.21.07.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 07:24:59 -0800 (PST)
Message-ID: <f2c8d058-7a9b-49ab-bc69-c2b7c58f4b89@redhat.com>
Date: Wed, 21 Jan 2026 10:24:58 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] nfsdctl/rpc.nfsd: Add support for passing
 encrypted filehandle key
To: NeilBrown <neil@brown.name>,
 Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>
References: <cover.1768586942.git.bcodding@hammerspace.com>
 <90fad47b2b34117ae30373569a5e5a87ef63cec7.1768586942.git.bcodding@hammerspace.com>
 <176868679725.16766.14739276568986177664@noble.neil.brown.name>
 <8328B53F-21DE-4237-AF79-5DE88D53D8B9@hammerspace.com>
 <176877755694.16766.8795981876133751749@noble.neil.brown.name>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <176877755694.16766.8795981876133751749@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-18259-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 874F35B280
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On 1/18/26 6:05 PM, NeilBrown wrote:
> On Mon, 19 Jan 2026, Benjamin Coddington wrote:
>> On 17 Jan 2026, at 16:53, NeilBrown wrote:
>>
>>> On Sat, 17 Jan 2026, Benjamin Coddington wrote:
>>>> If fh-key-file=<path> is set in nfs.conf, the "nfsdctl autostart" command
>>>
>>> ... is set in THE NFSD SECTION OF nfs.conf
>>>
>>>
>>>> will hash the contents of the file with libuuid's uuid_generate_sha1 and
>>>> send the first 16 bytes into the kernel via NFSD_CMD_FH_KEY_SET.
>>>
>>> This patch adds no code that uses uuid_generate_sha1(), and doesn't
>>> provide any code for hash_fh_key_file()...
>>
>> I forgot to add the hash function after moving it into libnfs to make it
>> available to both rpc.nfsd and nfsdctl -- here it is, will fix on v2:
>>
>> diff --git a/support/nfs/fh_key_file.c b/support/nfs/fh_key_file.c
>> new file mode 100644
>> index 000000000000..350d36bf8649
>> --- /dev/null
>> +++ b/support/nfs/fh_key_file.c
>> @@ -0,0 +1,83 @@
>> +/*
>> + * Copyright (c) 2025 Benjamin Coddington <bcodding@hammerspace.com>
>> + * All rights reserved.
>> + *
>> + * Redistribution and use in source and binary forms, with or without
>> + * modification, are permitted provided that the following conditions
>> + * are met:
>> + * 1. Redistributions of source code must retain the above copyright
>> + *    notice, this list of conditions and the following disclaimer.
>> + * 2. Redistributions in binary form must reproduce the above copyright
>> + *    notice, this list of conditions and the following disclaimer in the
>> + *    documentation and/or other materials provided with the distribution.
>> + *
>> + * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
>> + * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
>> + * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
>> + * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
>> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
>> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
>> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
>> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
>> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>> + */
> 
> I wonder if it is time to stop putting this boilerplate in nfs-utils and
> start using SPDX like the kernel does.
Would there be legal ramifications to do this?

I remember a time when our legal department was
not happy with the copyright verbiage we were using.
>
>> +
>> +#include <sys/types.h>
>> +#include <unistd.h>
>> +#include <errno.h>
>> +#include <uuid/uuid.h>
>> +
>> +#include "nfslib.h"
>> +
>> +#define HASH_BLOCKSIZE  256
>> +int hash_fh_key_file(const char *fh_key_file, uuid_t uuid)
>> +{
>> +	const char seed_s[] = "8fc57f1b-1a6f-482f-af92-d2e007c1ae58";
>> +	FILE *sfile = NULL;
>> +	char *buf = malloc(HASH_BLOCKSIZE);
> 
> Can this be
>     char buf[HASH_BLOCKSIZE];
> ??
Isn't better to keep things off the stack? But is only
256... so it is probably not that big of a deal.

> 
>> +	size_t pos;
>> +	int ret = 0;
>> +
>> +	if (!buf)
>> +		goto out;
>> +
>> +	sfile = fopen(fh_key_file, "r");
>> +	if (!sfile) {
>> +		ret = errno;
>> +		xlog(L_ERROR, "Unable to read fh-key-file %s: %s", fh_key_file, strerror(errno));
>> +		goto out;
>> +	}
>> +
>> +	uuid_parse(seed_s, uuid);
>> +	while (1) {
>> +		size_t sread;
>> +		pos = 0;
>> +
>> +		while (1) {
>> +			if (feof(sfile))
>> +				goto finish_block;
>> +
>> +			sread = fread(buf + pos, 1, HASH_BLOCKSIZE - pos, sfile);
>> +			pos += sread;
>> +
>> +			if (pos == HASH_BLOCKSIZE)
>> +				break;
>> +
>> +			if (sread == 0) {
>> +				if (ferror(sfile))
>> +					goto out;
>> +				goto finish_block;
>> +			}
>> +		}
> 
> I think this inner look is not needed or wanted.
> fread() will loop as needed until EOF or an error, and we don't want to
> continue on an error.
Good call! Having nested infinite is a bit worrisome...

steved.

> 
>> +		uuid_generate_sha1(uuid, uuid, buf, HASH_BLOCKSIZE);
>> +	}
>> +finish_block:
>> +	if (pos)
>> +		uuid_generate_sha1(uuid, uuid, buf, pos);
>> +out:
>> +	if (sfile)
>> +		fclose(sfile);
>> +	free(buf);
>> +	return ret;
>> +}
>>
> 
> Thanks,
> NeilBrown
> 


