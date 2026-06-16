Return-Path: <linux-nfs+bounces-22601-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DUF1Ag46MWrUeQUAu9opvQ
	(envelope-from <linux-nfs+bounces-22601-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 13:57:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 939E568F031
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 13:57:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=V9bWwwBe;
	dkim=pass header.d=redhat.com header.s=google header.b=MqSvICL8;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22601-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22601-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 212E630B1129
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 11:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A078043D500;
	Tue, 16 Jun 2026 11:52:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF5643D4ED
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 11:52:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610758; cv=none; b=frBQBLvxuLbJEPAOt3H9UB6guk0/Kkv/ys7RmWbSI5P/USFy+RoyHzx7CE9O2ynQBQyIEcuW6vmb2MTEb4aLkKXuqJbhFzYCRixQ9A656y5RV26B8RszwH+Y+4Jc1yFYgLP9LbmrYelq0o1q7F9J2vkeBUby/WmAoWaCQ86CkRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610758; c=relaxed/simple;
	bh=X4lgEBwMZyQs8z8CfHu1Omuvvb7bsgvEneDvh5qb8K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a96uOh2tVenpEpIonXboc5gK0eal5fiU8XWJcCj56zYDQwNGjfK1E1Pf2BYIe/rDVPn5660ERlRSmXoHWgZHW3TAZbnndg938fvh4AeKUvdg/A6ZFatQuuSJFBW4Qe8GSKXutB2QjUOPhSZAvsK4/xqjWuA36X50is4QwfD2Pk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9bWwwBe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqSvICL8; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781610756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oN8Btr+aUG0NrlG+ZSh2e5HFfjL5pxW4VeD5qFzifXU=;
	b=V9bWwwBe8DaZYB4v51LXaDG/jlA0MGZ2eVPhqOHPJrf4ChYncOsG2M+PM/9jxx6Sst2uR1
	A81//F3RBjGgDzvzszbVvYM7u/vMIGSz3JqntYm4XK0MDfsl//oOYA+yh0yw+PPkF1fxJA
	KhrqOisWErnADYxpMEt8U/9awg9/Ni8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-G-T6Rd-FNbW_tQt_YJjflw-1; Tue, 16 Jun 2026 07:52:35 -0400
X-MC-Unique: G-T6Rd-FNbW_tQt_YJjflw-1
X-Mimecast-MFC-AGG-ID: G-T6Rd-FNbW_tQt_YJjflw_1781610755
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9156cb14b1cso446476785a.1
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 04:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781610754; x=1782215554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oN8Btr+aUG0NrlG+ZSh2e5HFfjL5pxW4VeD5qFzifXU=;
        b=MqSvICL8p0/pct9jnCbnmr2G1E9fdZcEyNiHyCdqjctW6Ds3Ylzrv73efnjlI4nqoh
         5ICRPu7AfgpO3+Wp2jfW0Z5eRTjIz/UfasCYzE/GeLnTx8tyl0IzZ1lOn8E9hHLDRyZq
         Zg+yICH7wM2PN9tmpxINNJ1OJeXaHflAjksJzQanQrU2rUshbplnOjAx05cFO4tfVPCI
         d950sD/VHo+r85nCJC3WskpW94GZYGcMgM/DeB9+Jw9Ofv6EelV58IuGL392V1GNQflz
         Nl6YlgGaZkRGmu72XXhMwAhhBB5URDsIcpEDZ6BREn5iM9rrRb8uIUeRiyu5uGCEQR1f
         hpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781610754; x=1782215554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oN8Btr+aUG0NrlG+ZSh2e5HFfjL5pxW4VeD5qFzifXU=;
        b=n8iN/SE8gjPnoICecywpLxB/h6TDNgyDFpqSecrp5OZ3KFqZT06oxf452VR2v+s8dF
         wFWYRXOQs4PjD37kM/U2aj1lkAQ8aaMXOdddnp6RL0BCuO/qk5e9ohOhXMcSBDI/VKkT
         4YvmHuzmtWDHz7vT6x4+TP4Ywz0vtex8FPvJMGVeq8QWMJ7EqeVO3IgY11YQJu4J6mt3
         HmqY7x/Qoj8ecI9JuE4qLXr//YEwUDscmHHpE9hkt1iS5vPVCvKi/g7z5tQBhB5O5Q/u
         tpoPZqefldEMKWVdivyxe4PvdTxsMrwpIS+6z8pQJsUQ5f5fZqLdXUnQgGlcSFDh9E1W
         nVMg==
X-Gm-Message-State: AOJu0YzPx4O8hyTIQkt466b1/5wlzdF0N4JBJsbzRwh0kCM6MW3o8rXD
	BPbZdxHhF8P4YRRd+RCgX+WJ4qeWKrTpot9F5MXN/GI0En7UfNTw8zQnP+jkTBFHDclRbTYyRp1
	YbT61QKqhmb7NlYs51y77oNnnLUDsXbF6oeylSVF9/BZ22aM9Vr5OXAl1BjZqaDnGMwZJXg==
X-Gm-Gg: Acq92OGMOpuFnZBha6T6d6RFeZHiYP7zM0K8PAIvKaeXNky0DeENbqMP3MMy+VSL4hx
	JmcPhQ14ii8EUHKKIUYkIJWj8VtP8HbHQ5FEPU+rPpBb48d/9FrF4xyctbv4IRgoO09h9c2OJmc
	LWpgxeHIywpeE5SP+iz9viCa1o646CTQa7S2YB6nfxawxQgYpNOu0kKH2CfHcVNtoGcijIMZJgw
	ij4uc8Nqk03tSLHtDGP3vxbOcwx2uUKTnq04/wG+ZRO2ynzgHE20kL2orUdQyvL1QSJQ58nKNpK
	9i5LPK4fJBjhOTKJgFTA70nLOKlgAxwbe2A6XuZ4GcMad6vCG1bto1kZc66SG8SsoKrOKvtlh84
	8PqIMQg1DTHGnwk2ikLkL
X-Received: by 2002:a05:620a:262a:b0:916:469:5455 with SMTP id af79cd13be357-917f08a05aemr2307891785a.32.1781610754656;
        Tue, 16 Jun 2026 04:52:34 -0700 (PDT)
X-Received: by 2002:a05:620a:262a:b0:916:469:5455 with SMTP id af79cd13be357-917f08a05aemr2307888985a.32.1781610754261;
        Tue, 16 Jun 2026 04:52:34 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.242.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a06367dsm1436339885a.43.2026.06.16.04.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 04:52:33 -0700 (PDT)
Message-ID: <4b815f0f-6bc1-4781-84dd-d998d6fedee8@redhat.com>
Date: Tue, 16 Jun 2026 07:52:32 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] nfsd: don't assume service is running when
 setting thread count to 0
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20260608131351.95211-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260608131351.95211-1-smayhew@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-22601-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 939E568F031



On 6/8/26 9:13 AM, Scott Mayhew wrote:
> Newer kernels return -EIO if you try to write to /proc/fs/nfsd/threads
> and there are no active listeners.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed...

steved.
> ---
>   utils/nfsd/nfsd.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
> index 365e145d..c95d32f4 100644
> --- a/utils/nfsd/nfsd.c
> +++ b/utils/nfsd/nfsd.c
> @@ -311,12 +311,16 @@ main(int argc, char **argv)
>   				argv[0], count);
>   			count = 1;
>   		} else if (count == 0) {
> -			/*
> -			 * don't bother setting anything else if the threads
> -			 * are coming down anyway.
> -			 */
> -			socket_up = 1;
> -			goto set_threads;
> +			if (nfssvc_inuse()) {
> +				/*
> +				 * don't bother setting anything else if the threads
> +				 * are coming down anyway.
> +				 */
> +				socket_up = 1;
> +				goto set_threads;
> +			} else {
> +				goto out;
> +			}
>   		}
>   	}
>   


