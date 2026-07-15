Return-Path: <linux-nfs+bounces-23322-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MHodAFJnV2obLwEAu9opvQ
	(envelope-from <linux-nfs+bounces-23322-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 12:56:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7CE75D24B
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 12:56:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=grJ3Q6Wz;
	dkim=pass header.d=redhat.com header.s=google header.b=B1uIINyT;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23322-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23322-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BC5F3010524
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 10:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965D3435A93;
	Wed, 15 Jul 2026 10:56:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E007A2BDC26
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2026 10:56:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784112975; cv=none; b=Za+XJVoIQIWVgLYdEFuQ2hNG/HC9+X+rC0omDVgVv6UfWwgu+fzcc1j/wiTxlqikj4VBLmt3SpIjwxxg12N6z8UGxS0mYwcb40a8BAGid1F4pqEbPC7Tk14fkG3nAQ/hFhIYAU8zMk6HzJlYC1SNCLIE0ScLDDK1xA03O7oOhGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784112975; c=relaxed/simple;
	bh=sfql2pNYmfNHLvWtDevbVBzOh9KaTyXkiCp6f96LL6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYDhiBOvXOlDLX2fdK8/I2Xx1VGNHl33D1TOClv5Og4f7IapFs3n6leFls9xwPtJ9VJfs9MZC5KwfcS7WXrc6cfUu6RQTimpF9F7lQyai8YmrkIka1Q79yq4LpnXJUYShGkJ5zCfIHz28ymDgAJ1do6lsIYP2UoW677iU2JzPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grJ3Q6Wz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B1uIINyT; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784112972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/a5RKLFtxcXs9RqKmSXre7pyYk3F+uzxFx0AeKOdjYE=;
	b=grJ3Q6WzYG7gpgcDOXM2ZohR1mi5Re5KPNEYRwrll8++9GJHeb283A8ZpkahKu7OvEPMk/
	qbrwKI+/gJikhuu5uFSP5P9wRz6bfcHQi+pMS2isX9bds26t/cPSoaWrDidWxYQ+5AQJEF
	ClPG/NWwTcQQRvEViU/tIg4RzyHx1JM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-KuwvHQZXM42fbfcF-uB9PA-1; Wed, 15 Jul 2026 06:56:11 -0400
X-MC-Unique: KuwvHQZXM42fbfcF-uB9PA-1
X-Mimecast-MFC-AGG-ID: KuwvHQZXM42fbfcF-uB9PA_1784112971
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92ea24a2db9so825022485a.0
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2026 03:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784112971; x=1784717771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/a5RKLFtxcXs9RqKmSXre7pyYk3F+uzxFx0AeKOdjYE=;
        b=B1uIINyTaMVHCdDktuaj4ed+2e2j8xIeMVGtX99ty3+cr21xBDGhZWOmc/xu5VijPg
         dtyouf5GTliHur3CopP57lcsiDsOrkcl+hryZuolRDraX43e/RTbXUxD972otkkjUabt
         4vb+CMRLkDdLRqK4YX55n+hWDTLHkF/PZPxa/gcdOx/l7PB37H4KWPZSKvJ4uZwhHsqT
         tlBAKNG9DrWyrhdb2YUUHsgI7irvkNs5lQk0EzTz3uO0WOkEf2OUHoapr2jIvlmoRrdi
         WY/ZPrHRWoobBLKMD9rr9LIhqOF5VF0LOSWTWy0743m6k2FCplwsFwPMLfUfn6XLxPYe
         HxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784112971; x=1784717771;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/a5RKLFtxcXs9RqKmSXre7pyYk3F+uzxFx0AeKOdjYE=;
        b=VVjMa75OvxDEUX6i0eukxpagV7d7DebhZM2DD9BmfhwwhG5f65l0XYXMtdiNvjFeMa
         q0k/QPgfwa8XGkgrOke6EwxnJzaYnkj+OeCH0x5ZQB/auD78y8xCZ54bAFbFK6dYAgaM
         ugIYPUAs8P1EPqiFq62CF5jZzuk5f4S5+JJzXmRTUbmZsKYnamWxY12fnO+lKgyHX6RG
         8+FcD8PF8nqAkkmeFheFPmaumKr0A4OHGcGtRSKEnCQrWU0qg708xTRH5i+gZIG1YmVQ
         KNS2rCHuynGFxG/CNSfxY38xmoxfPDSW1Q5+C5oTWsJ3BPW33/V2c8z8/Pc8jMd++WPB
         9g+w==
X-Gm-Message-State: AOJu0Yzx1ZMo2szm3G1qSXT5Go0ucNPEXeud9ICbDVv2oRYbns/++muA
	pLrKR8i1T8Ln6t6vxWtVH6ur5Ey9DVoi1snA8194Wk7DKfMNpe+UOuYj6ECaKe+pnrjaohLHsVZ
	LUYDD9VCUeBimC9sp9mzgcXH/UO/siaVedsfOPbDEBc0s1LfzJsuPCqnRt1+Bpw==
X-Gm-Gg: AfdE7ckFuQLCFAd4OVlmYLXN8M7fdxuSq7H6LjHit+8FCSXiiRK5bY/VcMjukmaOqls
	PxpHC0HSY/BzV/HoZ7MsAINGRgA68eekD4D/rLVTqfsyN0EJ09dGXO+kB/8FWAZv1oZrd5ql+xb
	5ZRm/WgS1zAuDBSaQxbm127wEuXainx9VL8wJMz1CKoPYkzRh8MH5JSMdBOH9XMRxVNXpf1Nn2E
	9MS7y6oFGqzs5zPH3NtT1fydCiJ1KTBmDD6Dp4qLSVDEhBBlMrooTyB14r17EtRG23Q5pm33Nsc
	JtMqzKKNcHE3huKEaOnQg6BgsnD+6vL5ALxvuATaJAd1XtTXk4iZWEEexIfPRzdf6BKEp5296N1
	OOGn2qLt4LZU=
X-Received: by 2002:a05:6214:258f:b0:8f2:1cf:c13d with SMTP id 6a1803df08f44-9074c8750bemr66301036d6.48.1784112970596;
        Wed, 15 Jul 2026 03:56:10 -0700 (PDT)
X-Received: by 2002:a05:6214:258f:b0:8f2:1cf:c13d with SMTP id 6a1803df08f44-9074c8750bemr66300716d6.48.1784112969928;
        Wed, 15 Jul 2026 03:56:09 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.248.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56bf455sm189235296d6.13.2026.07.15.03.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 03:56:08 -0700 (PDT)
Message-ID: <6498f379-c2ed-4c1c-b925-056d6462bca7@redhat.com>
Date: Wed, 15 Jul 2026 06:56:07 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] Pass ignore_hosts to export_create() in
 export_read()
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20260713202809.786079-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260713202809.786079-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23322-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C7CE75D24B



On 7/13/26 4:28 PM, Scott Mayhew wrote:
> Commit 8f3d12ce ("nfs-server-generator: avoid using external services.")
> added the 'ignore_hosts' flag to export_read() so nfs-server-generator
> can bypass DNS queries when calling it.  If the export doesn't
> already exist, export_read() calls export_create() with the 'canonical'
> argument hard-coded to 0, triggering a DNS query in client_lookup().
> An unresponsive DNS server can cause delays in nfs-server-generator and
> can even lead to 'systemctl daemon-reload' timing out, leading to
> further administrative issues.
> 
> nfs-server-generator only cares about *what* is exported, so it can
> create the order-with-mounts.conf config drop-in.  It doesn't need to
> know *who* those filesystems are exported to, so it has no need to
> perform DNS queries.
> 
> Pass the 'ignore_hosts' flag from export_read() to export_create() to
> avoid the unnecessary DNS queries.
> 
> Fixes: 8f3d12ce ("nfs-server-generator: avoid using external services.")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed...

steved.

> ---
>   support/export/export.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/support/export/export.c b/support/export/export.c
> index 2c8c3335..3caee043 100644
> --- a/support/export/export.c
> +++ b/support/export/export.c
> @@ -122,7 +122,7 @@ export_read(char *fname, int ignore_hosts)
>   	while ((eep = getexportent(0)) != NULL) {
>   		exp = export_lookup(eep->e_hostname, eep->e_path, ignore_hosts);
>   		if (!exp) {
> -			if (export_create(eep, 0))
> +			if (export_create(eep, ignore_hosts))
>   				/* possible complaints already logged */
>   				volumes++;
>   		}


