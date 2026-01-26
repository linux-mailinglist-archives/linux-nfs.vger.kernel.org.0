Return-Path: <linux-nfs+bounces-18470-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNdpKMRvd2m8gAEAu9opvQ
	(envelope-from <linux-nfs+bounces-18470-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 14:44:36 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA6A89095
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 14:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C61731A1986
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30C33A6E9;
	Mon, 26 Jan 2026 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/PBHIls";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRVdypIO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B233A6FF
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769434607; cv=none; b=CTfWP4yL2hVzCPVlNmiU+GQFEvJrSSt89+T20bQX5/0XxnMHMsMB1ap6bECQ3izuf2t8yIKkbH6m0Ohj3CFO5flECsm0AZyTtJDRS7GZSpp9BUFBKBbAIanfrLHv6DsVtS3eqf/1tXavmaaacYoEIeukUrqHbmNB1vMa91DIlgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769434607; c=relaxed/simple;
	bh=WV17ibmf6PlYmvHHr+SM80Ga6j/FqWy50ZiCKXdf9Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIdkM8kimZcDljTCfgqWbzOrEERLEGVBfr7EfgD4/1/rrm0cLvseStbD/jKdv5QC5IdvCnMCF7dRQtkosakV3++47/L6vA4vDlC1WjcMCiB3iLDsVvXC7rTugTHzzSu5+dLFAaUIPvJSN3o7W9A9Vw/DgRABWeP4Xg916Io2JJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/PBHIls; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRVdypIO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769434604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KdUqo5GM781h6D83O+Ngsi+b+NmZHzE4678n5Vd9FsY=;
	b=Y/PBHIlsGYNlwEdFRAaHrfvr4zgpFBNGY2r+qAyg3OwhDKMUWTguZglpH8mHCVwDIcPt7R
	xmppXKEZdNfXE+v/8Jc8/9JlTs+pDddQegJRb5/18MAb8kFWu2FH6eIykt1Bl2IKP9B5vB
	XCK02/a879Pw9CYK8S9n61RG2M8aO7k=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-xP75ifq2MpCFEaUF1h8NfA-1; Mon, 26 Jan 2026 08:36:43 -0500
X-MC-Unique: xP75ifq2MpCFEaUF1h8NfA-1
X-Mimecast-MFC-AGG-ID: xP75ifq2MpCFEaUF1h8NfA_1769434603
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-502a8fa0a28so192863731cf.2
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 05:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769434602; x=1770039402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KdUqo5GM781h6D83O+Ngsi+b+NmZHzE4678n5Vd9FsY=;
        b=NRVdypIOYNl26HsHU/5eWe/tBS2g+cV6SVsIoB5ykIWIYoFLkvcA2SzNX53u2JCgYL
         WWjWdLrfuZERvKI9dCwj6sZ//V8Y+oZM2Jnr29A8DgaAlUherFh4uHIBdPpbTKVINbjf
         iRu+UAmID6zH/HIKTyhu5TlnnCxS2CokElrMwGYP6GdDDdd9c7+Uvo69RdA5acRoBX2s
         9L64mHrP9IiLoVge5KkDxpTOEFaiJQpGSAa4Gt17kLUCgXxvhfPYeyf4FQCV2+TsltuO
         klO7F8g72pVzesUKyLPL3fXiGFj4kG0SoPKEihirSFNC7EMA2qYLj+FYRXUOg2Xh++ss
         rkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769434602; x=1770039402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdUqo5GM781h6D83O+Ngsi+b+NmZHzE4678n5Vd9FsY=;
        b=FpqzOl2pJirqat824iQOyQPphwFqlZVOhYaQWIEha+GBrLqHycYMS/mvenCEUsA5Zm
         Ogd3ra3KZVGBArVXNM4ZXE3VYkM/YCVdXbXrJsqMwuCYcSzCTdFPTdbOP8Io7Zf5KO5q
         PN7V16mA17TGPcXTfnukSgRF3fOu1Sw5OA8Q9G8+s6xtv+F/0yt93eYynB+AB4STb9pI
         aYH3CY4wk3P+h0mjCm+0ty3TBBTabykE6OOGrU5iQ1a5/qGEIt9JhlToDz0IGQiMgxeO
         DHHHrgQ5Q/tY5Wh1q7xto9Ncyt3H7MC0LKfuhIcen2Nljzhfd474i4t6HwFLPWYY1o5L
         W4jA==
X-Gm-Message-State: AOJu0YzbeADGpf8L7bZ5sI3aOxh+0Inpncgt8PvtCRXtg1yq86/vcdH+
	vt5ONci/+r86Tl1McnZeDEAxFsLTFvnmyCy09YvI56aFgrKd2FcKuRENBkPw+2VLzoVspd7FrIW
	wE9sLaWXLVlbeLSTUwlwGWWptZ/jkeDirei568pzvt23s7fC6EXYH727I8EuGMFFJVLHvRQ==
X-Gm-Gg: AZuq6aJThbwGd9hDxp0ViWD3rpvs8v94Cd3o/+PjHuxZR7LiaOxSWe0sCABSxBQq6l1
	HUMEUDT7EP38P+CWw0P6r0VLOZ4WsPREyE44vUQBI5Sz2IePeh1SDXeQFH9f6SFXBFJfTel2xhK
	lphEiiRjdCDuZ44SChf67jnMe6MlyUy/mdqq9bqnloTkT3eIVjuiZQyt05dK/VoLc4ZfrDbccMC
	BQ6K0hlJJ8bHVbN1VLkD7zwz+gnLwQQApIcDa/R0qSWlUW239Dwv06b9bAFNuJjfAK3LiIaYF2X
	cmNjiIUO/dm8HbrixN3V1nGpSJPoCzGQlF0ZUPFnwDAHfjTdGyyJ8o0ATF/Fawnzj4/7zd6tOoI
	QNZhnFYCQ
X-Received: by 2002:ac8:7f09:0:b0:4ee:1301:ebb3 with SMTP id d75a77b69052e-50314c79b77mr58123291cf.54.1769434601721;
        Mon, 26 Jan 2026 05:36:41 -0800 (PST)
X-Received: by 2002:ac8:7f09:0:b0:4ee:1301:ebb3 with SMTP id d75a77b69052e-50314c79b77mr58123061cf.54.1769434601332;
        Mon, 26 Jan 2026 05:36:41 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7f72a0dsm82162381cf.18.2026.01.26.05.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 05:36:40 -0800 (PST)
Message-ID: <aac5629d-9da6-4e35-a27c-efdf782cdf03@redhat.com>
Date: Mon, 26 Jan 2026 08:36:39 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfs-utils: nfsdctl: ignore ipv6 listener creation
 error
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20251204204854.91431-1-okorniev@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20251204204854.91431-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-18470-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 2CA6A89095
X-Rspamd-Action: no action



On 12/4/25 3:48 PM, Olga Kornievskaia wrote:
> If ipv6 is not supported by the kernel and during the nfsd start
> we are trying to create an ipv6 listener, ignore the error (this
> restores how nfsd handled this failure).
> 
> Fixes: 8b02f0d5590e ("nfsdctl: cleanup listeners if some failed")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Committed... (tag: nfs-utils-2-8-5-rc2)

steved.
> ---
>   utils/nfsdctl/nfsdctl.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index eb0b8e7d..ecce66b5 100644
> --- a/utils/nfsdctl/nfsdctl.c
> +++ b/utils/nfsdctl/nfsdctl.c
> @@ -967,6 +967,17 @@ static void print_listeners(void)
>   	}
>   }
>   
> +static bool ipv6_is_enabled(void)
> +{
> +	int s;
> +
> +	s = socket(AF_INET6, SOCK_STREAM, 0);
> +	if (s < 0)
> +		return false;
> +	close(s);
> +	return true;
> +}
> +
>   /*
>    * Format is <+/-><netid>:<address>:port
>    *
> @@ -1081,7 +1092,8 @@ static int update_listeners(const char *str)
>   					continue;
>   			case AF_INET6:
>   				if (r6->sin6_port != l6->sin6_port ||
> -				    memcmp(&r6->sin6_addr, &l6->sin6_addr, sizeof(l6->sin6_addr)))
> +				    memcmp(&r6->sin6_addr, &l6->sin6_addr, sizeof(l6->sin6_addr)) ||
> +				    !ipv6_is_enabled())
>   					continue;
>   			default:
>   
> @@ -1127,6 +1139,11 @@ static int set_listeners(struct nl_sock *sock)
>   		struct server_socket *sock = &nfsd_sockets[i];
>   		struct nlattr *a;
>   
> +		if (sock->ss.ss_family == AF_INET6 && !ipv6_is_enabled()) {
> +			xlog(L_WARNING, "IPv6 isn't enabled, skip IPv6 "
> +					"listener\n");
> +			continue;
> +		}
>   		if (sock->ss.ss_family == 0)
>   			break;
>   


