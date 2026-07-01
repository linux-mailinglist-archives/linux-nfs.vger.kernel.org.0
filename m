Return-Path: <linux-nfs+bounces-22908-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XEwBCQQ0RWqL8goAu9opvQ
	(envelope-from <linux-nfs+bounces-22908-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 17:36:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FADE6EF4F7
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 17:36:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=VUtllnV0;
	dkim=pass header.d=redhat.com header.s=google header.b=jja2OHzp;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22908-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22908-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E261300829F
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32092DC767;
	Wed,  1 Jul 2026 15:36:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA31FC110
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jul 2026 15:36:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920193; cv=none; b=QrxbEOMdXep8xIXpbk0YYsnoHft54ak5Sh5fR99Y3zNPCW/1h1Xu4WAIPwj74cQZmeJxPefVXXIjn7JQ6IVMDvkMRxatXpVdHmDYl4rnXJNHblZ+BMMkgN03tIc8CBZr4gIIAOF2J+httl8COKBiB+JQDTQ58y4CL/hZrLlkYm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920193; c=relaxed/simple;
	bh=l9WWJg9Ujtby7zGR3KODrRu+J4w5DoFtaB4s6p7ZRlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pw69nlYnjQT9geccUA1gXcx3Rz+oX/rBcwgGGg7GxPZLHQXxzhOEMS/g8tTXNY3j8Uf1M5y2RKejXtO8ZY64OQoAmCoc2/sE0uOPMIrjS4cpT0mdMNK7qdiSivwswm6RiKHpQXh/JUiz0RqH2A1UDKuUWRIbaDnz4JOC7wmqYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VUtllnV0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jja2OHzp; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782920191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCPTqC9P3Eiq7AUl3G+xVx8nZoLCTAFDVHofZYbub4U=;
	b=VUtllnV0yocIhYhblitGpi03xO4zJkb+c721E+vxnvDyU3TUCRdTj0Eg6SqoVkwOP65gQD
	sYeJ08vyvfJVnmC8L7d50USH34BGYPlFxzOdzt06WXadrNiPT4g4dtfJbXNldD1+wl35Ii
	Lq9dZSUZpfaWoFJcU4pqeYqDWHaEd4s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-uz9GmmWJOP6hwHLrGJZK_Q-1; Wed, 01 Jul 2026 11:36:30 -0400
X-MC-Unique: uz9GmmWJOP6hwHLrGJZK_Q-1
X-Mimecast-MFC-AGG-ID: uz9GmmWJOP6hwHLrGJZK_Q_1782920190
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e632390d2so161447585a.3
        for <linux-nfs@vger.kernel.org>; Wed, 01 Jul 2026 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782920190; x=1783524990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aCPTqC9P3Eiq7AUl3G+xVx8nZoLCTAFDVHofZYbub4U=;
        b=jja2OHzpQOxMqnukmJvbgq9akTFqvdUVyHZK0gz4vhg9SAYHmP1oDuYAEwhq96wxxI
         lI2MZO3vm7SOyjKp5OHaFJHdsAnKbDdFe7bk8UJa70EN388PrsrqHZh9iEMfIXMWgri7
         F+0IUeV8x1BKT2oQnXfZtYUIXMdNoHUQhRlkBxev01kX7Hyav7zXKJS1lBnNEZnjlfbN
         ajPmgZ0tfhZVF+3fBXwwoQ+HCbPTjdlwBK9X+dq74+NN1CKNuxFD/wjU0gWv7r2G1oSz
         PQ/q1V6Lnjh+SG/VO9bPbTf5CfE53aP9xMKeH47CcTEeYNQzkjV1Bpc3WEl8ac3F+KSo
         +zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782920190; x=1783524990;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aCPTqC9P3Eiq7AUl3G+xVx8nZoLCTAFDVHofZYbub4U=;
        b=SB001JpDoZey6RqN1DxV+5TMz1GQNvBVtHfNs2m3fMfpse3yijAnqn/GhYjgbbR+JX
         gBRt4ptV8tDMUwmCczHAEenuv+2yAguymB65dhTWBiQl3OH9Viz2/SrtRvStGtSWZksH
         Ewlp3Hcn0FZ3uXWTykqjHfEAH9nMZrZjqPottNXLK03c1DGpRVeDwVM/75vTTg0Hwlol
         cdTK1j05khK3m5qu9z1DeLP0miHuArD4hHOXJCTj3FSufO0uesnvdOma/8TGt+q/ImAw
         B88/qIklA+E+A0byheSFb8MupVEk+PfMRHnE9x1IaJUscG3kLGbSiQcqzOH8jHNiDvqs
         L7bg==
X-Gm-Message-State: AOJu0Yy6H/NjHYxnKC+iNyfc+YKVUzzO6GZB4kEBqxUgG2sQqK2hUxIH
	LaZBotSG8OMs9ASQ44U8IiS+qLENZNZydHbLAxP6h3MEf4rQBibD9/tCpqB2NXlqjwDts0uJlqU
	EuHwwYgabNK3ioA6D/jZC1zy+zUN/bsyPLreOEzQZiZgDwS64BepfuwGu9VjGXxDciNomBw==
X-Gm-Gg: AfdE7cm7CboY4JEYCQka68DTPYWqxzCclrE5LT3NWFD4A4D7v2zqdevlYkKX9NzDGd1
	C4cR7UOEzLJOV/ssjhvsdxoiKbV1t4H+PgXVx9gKkugo/4oIDbTBaEyvBjNoOtUOZpvRW11YhcP
	oDa7bUbATkyAcrjrIPCm+/5a5nRZNTRAPq3u0flzrES6rLSiishJFxAj1+TeUFDgVCxFz6FNg4T
	XlfyS1RN6Nyo50BabEpEhWYqD8p9HqtyiQFisfRIe1Mld2V/QOv+hzgEbcLuKXmZukkubMLGOUT
	VUZNhwUPJ8J3JQPvZfnMnndk/LrzZyFt9t+7fekF4VfkeZU+hW6swYb16OlNCbc/PKsGVVtj5uu
	heapVJEaxCWs=
X-Received: by 2002:a05:620a:628b:b0:92e:4727:924c with SMTP id af79cd13be357-92e7b01ed76mr213717285a.33.1782920189545;
        Wed, 01 Jul 2026 08:36:29 -0700 (PDT)
X-Received: by 2002:a05:620a:628b:b0:92e:4727:924c with SMTP id af79cd13be357-92e7b01ed76mr213712085a.33.1782920189089;
        Wed, 01 Jul 2026 08:36:29 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.244.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f3611ddea1sm23802766d6.25.2026.07.01.08.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 08:36:27 -0700 (PDT)
Message-ID: <be3368ef-0708-4789-842a-1286a8143dd1@redhat.com>
Date: Wed, 1 Jul 2026 11:36:27 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rpcbind: fix leak of nconf in main()
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20260630161358.133351-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260630161358.133351-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22908-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:smayhew@redhat.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FADE6EF4F7



On 6/30/26 12:13 PM, Scott Mayhew wrote:
> Before reusing nconf in the getnetconfig() loop, we need to free the
> memory that was previously allocated via getnetconfigent().  Fixes the
> following leak reported by valgrind:
> 
> ==9031== 1,136 (136 direct, 1,000 indirect) bytes in 1 blocks are definitely lost in loss record 63 of 67
> ==9031==    at 0x485183E: malloc (vg_replace_malloc.c:447)
> ==9031==    by 0x4879D1F: getnetconfigent (in /usr/lib64/libtirpc.so.3.0.0)
> ==9031==    by 0x4004336: main (rpcbind.c:271)
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed...

steved.> ---
>   src/rpcbind.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/src/rpcbind.c b/src/rpcbind.c
> index 4212377..c39df97 100644
> --- a/src/rpcbind.c
> +++ b/src/rpcbind.c
> @@ -282,6 +282,7 @@ main(int argc, char *argv[])
>   	rpc_control(RPC_SVC_CONNMAXREC_SET, &maxrec);
>   
>   	init_transport(nconf);
> +	freenetconfigent(nconf);
>   
>   	while ((nconf = getnetconfig(nc_handle))) {
>   		if (nconf->nc_flag & NC_VISIBLE)


