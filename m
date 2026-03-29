Return-Path: <linux-nfs+bounces-20511-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC58ERORyWmUzQUAu9opvQ
	(envelope-from <linux-nfs+bounces-20511-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 22:52:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1BF35413D
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 22:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33A8E300AB3E
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 20:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAA635F8C9;
	Sun, 29 Mar 2026 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uwwm0NcU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j/VdsOne"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F32E06E6
	for <linux-nfs@vger.kernel.org>; Sun, 29 Mar 2026 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774817538; cv=none; b=fweIzqAUT6x8Z4ApGGRu2dDkPROnkJF46GT3pXJbcJfNPFViQM5wmyRpc5X1c1XHoP4SFCK3PN51NfuOT1DawEP+oaRv3/Xi7Yd3aGB1EHgEbyHZQN34fFaadxh9x0L0AP20NJ8BaajyNIYA/JtNWuU4ajsZqEGpRC5ksGVaTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774817538; c=relaxed/simple;
	bh=Chw54ZJfGXj0UJJZ0eTkqQFJxMcrjfYR4RreaoDULhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZOJYcyyDu9EdWnKDiQnDxa+eDPUqirUZlNL385iCtdJT5zvy4MfVYwm9y4bhMNm6BJwtsvU2lCWH5s/4EZAvJLxhxSf/UZkGquRnFvswROoqq9IwTg1OdqXjAdzDttnxd9pC8a5SY9qRewfglRW0J9aVn1zEY4tIVUtaA1naPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uwwm0NcU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j/VdsOne; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774817536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9TRGE1WH33pywZw43U4M/hBoyDcK1ApWlAHEGwl6CM=;
	b=Uwwm0NcUoA4+bAQgRySpJIk7pVJTfmlzzmqD5MzmRwemI1Te3h2NR29oCZoEocf7fjEFLL
	JzQr5BDoAA1w2T+ElZKXZDGTMMeaqSfoGoZ6HyhwLdx2UL1va0e5TRhES+lnC+KyEQN2BR
	SND5wqJS6zDx5y+xFo7yHqkJdmrYLfo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-5KMp1wiIPFui9zF7CAgpJg-1; Sun, 29 Mar 2026 16:52:14 -0400
X-MC-Unique: 5KMp1wiIPFui9zF7CAgpJg-1
X-Mimecast-MFC-AGG-ID: 5KMp1wiIPFui9zF7CAgpJg_1774817534
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cfc5df1dccso946551985a.1
        for <linux-nfs@vger.kernel.org>; Sun, 29 Mar 2026 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774817532; x=1775422332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9TRGE1WH33pywZw43U4M/hBoyDcK1ApWlAHEGwl6CM=;
        b=j/VdsOneDTQ4GNtuXXhB7x6z/Kj1S7p9hFb2E9fUQ+OxsdrZlRRMznHEyzH1zZJqrY
         wX/TBzsv6iEA5I0SLK1vk4IBZcOZ0Ag2JB0tnMQY8Jmfsr7IXmuTw1qtdo8z8S2Shf+0
         LGxNMppLNkpmkA2IJwYWIN2d2U+j7zVX5q8FYn6B3UJDzLjwmx7+uWmR/Z8COfFjUy3w
         7TGFbK+JpZxUGw4Rk/vHQ1iQ94bEIpqoJTarzIJUvCMUL4dZov5kzAk4bz8RKqzNr/uG
         09luE/xuq6u6AqHV2m8bwvMBsTpRBawi1CmVbCaDOpvr/v/9/TenCsBvnyDbQ+SFQhp4
         nEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774817532; x=1775422332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9TRGE1WH33pywZw43U4M/hBoyDcK1ApWlAHEGwl6CM=;
        b=nJl3nPIYHl1tSRPB/5JXGO3nFhfzCUyyOiJAou4llcRhOXJzV3ACR/uiMrvQi0eUMW
         /gcGkqIpkPhjaUvtk9DGNiT6WrIC4G5ZcRykr68XjUum8x0iWaTWCxCBgiZOatc3iaUD
         h21fQMT2XNrSbEXviZopBr0Iaha/xt+sw0/giO+1IvDIjHPamH596V5kRFSKsAmUhlES
         R3nG6S+wYJYbUPzGuzn+9BGWhixboLWa2XL7lMChPwx5v0oM6DkMQx0eCAe9r0wIQGnW
         5ZgSLZvQ+jk79Lc1rCxNikfoNcGJmEzbYj6fggatbL0KjDfM2uXDVJQ+2bcxHqBoHVUL
         YnIQ==
X-Gm-Message-State: AOJu0YyIkFW7YgZT8dLB54nasjboKIQzImRJ8HrCSVyPk6wPS2agOgX0
	WX1fPA/Z5CXn2925iH9h7CNofJmsLOoQsMfn19KCF3HwFyMgfG4Hi+VawtPdPeKUvVEfW/zeduc
	d/evUnsfVNOVI5rBrSdLuM9TC9HcEXT+fyyPU7fpZPP7Mho26so+l8hDR8W9EHJQMbkTq6w==
X-Gm-Gg: ATEYQzyRtV8JerOC6YGAkFR14k9LwLKqceUcAjgGJSh2Yjxox8s2YaU0LGOLhtv97XT
	sUIqU29obmHwimD/+Zlg/+nx+h8vtDcIMW/k2r6ow1yC5N8pljKf5ctKLTZRUoNjnvoSd07W6t/
	2G2pqC8onN7pHwOV5jIv2NYyfFmv+Gf1P5t0rB6SQFLtKk0IC+at5IIS71Hi0Sx0REkUId5P91i
	0zzG7J8P5YeOfYR6pBlxogjcNaJwND0DiyjxQyHIQ217uU66BDjWv1LXItJke326SG3sAY0ubSA
	2uDpMVFykH+nrNxnotkBtYev/3pxwTZfm0p78NIHQFYO6Oy1UBYho1AV6M67sCf1UdWH+hqXonC
	MtzHcgKAtHyZ0WeZr/8jc
X-Received: by 2002:a05:620a:1a29:b0:8cf:d804:4567 with SMTP id af79cd13be357-8d01c65bc4fmr1319991885a.23.1774817532316;
        Sun, 29 Mar 2026 13:52:12 -0700 (PDT)
X-Received: by 2002:a05:620a:1a29:b0:8cf:d804:4567 with SMTP id af79cd13be357-8d01c65bc4fmr1319989685a.23.1774817531596;
        Sun, 29 Mar 2026 13:52:11 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.240.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d028075135sm443847285a.38.2026.03.29.13.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 13:52:10 -0700 (PDT)
Message-ID: <3dc18fa8-31f1-4aa4-a566-b6e141184303@redhat.com>
Date: Sun, 29 Mar 2026 16:52:08 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nfsdctl: check for listeners before starting
 threads
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20260323203710.83237-1-okorniev@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260323203710.83237-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20511-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD1BF35413D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/23/26 4:37 PM, Olga Kornievskaia wrote:
> When a thread command is executed and yet no listeners have been
> added prior to it, instead of failing with EIO error print an
> informative error. Also, "thread 0" command should not error
> regardless of the listener status.
> 
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Committed... (tag: nfs-utils-2-9-1-rc2)

steved.
> ---
>   utils/nfsdctl/nfsdctl.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index 6a20d180..ac23e753 100644
> --- a/utils/nfsdctl/nfsdctl.c
> +++ b/utils/nfsdctl/nfsdctl.c
> @@ -162,6 +162,8 @@ static const char *nfsd4_ops[] = {
>   	[OP_REMOVEXATTR]	= "OP_REMOVEXATTR",
>   };
>   
> +static int fetch_current_listeners(struct nl_sock *sock);
> +
>   static int error_handler(struct sockaddr_nl *nla, struct nlmsgerr *err,
>   			 void *arg)
>   {
> @@ -721,6 +723,7 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
>   	int *pool_threads = NULL;
>   	int minthreads = -1;
>   	int opt, pools = 0;
> +	bool zero_threads = false;
>   
>   	optind = 1;
>   	while ((opt = getopt_long(argc, argv, "hm:", threads_options, NULL)) != -1) {
> @@ -762,12 +765,31 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
>   			}
>   
>   			pool_threads[i] = strtol(targv[i], &endptr, 0);
> +			if (!pool_threads[i])
> +				zero_threads = true;
>   			if (!endptr || *endptr != '\0') {
>   				xlog(L_ERROR, "Invalid threads value %s.", argv[1]);
>   				return 1;
>   			}
>   		}
>   	}
> +	/* check if there are active listeners added */
> +	if (fetch_current_listeners(sock)) {
> +		xlog(L_ERROR, "Unable to determine if listeners were added");
> +		return 1;
> +	}
> +	if (!nfsd_socket_count) {
> +		if (zero_threads) {
> +			/* Note: we can never have a server with threads and no
> +			 * listener. If we ever add functionality to remove
> +			 * listeners on an active server, we need to revisit this.
> +			 */
> +			return 0;
> +		}
> +		xlog(L_ERROR, "No active listeners added, not starting threads");
> +		return 1;
> +	}
> +
>   	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL, minthreads);
>   }
>   


