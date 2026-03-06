Return-Path: <linux-nfs+bounces-19856-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BI7FSRRq2nZcAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19856-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 23:11:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F148228384
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 23:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E7F8302F981
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 22:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2C1494A18;
	Fri,  6 Mar 2026 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fU1S7qaD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWpJK+DH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1695495505
	for <linux-nfs@vger.kernel.org>; Fri,  6 Mar 2026 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835048; cv=none; b=Iy/Ehr1q48RBVQHAc5VBPJSdTIfd+WPun6quqKnSowYid7MaI3Kfcx0KWLecVi3iRn8YXyuIDMx08rFqFYq8snJMM9Gj0nH26U36lgjfraZu1pQGgVae8pkxaFOYPD6t+ZCrp8SFwm6VeuiptJmQC9O5dx9H34IKGKejDkg7vQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835048; c=relaxed/simple;
	bh=OLEsUMd55ULBwcDyZRHpBO1YQO7L6tbFQ+0atX0vSEE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=B0Yh2gF3ZWK8INCaB4RgvyuIEAD0RLXQV6Z1T2yMhyP4eQcG2ejVPXpJl6JZkblYs1iad8MRAAbIAWZ02534otjTkzqpyLX9PcUAe1sw8FIeBp39jOH5/s8Nk8g2Ff45Q3C5eYZ7/hJXG3q7QOfEUXxaFb7u4v/8eAsfSAtd0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fU1S7qaD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWpJK+DH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772835045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxEDbjwnH91/X9ML2Cl4u2znqX6HdY3EI0qhMGi6SBM=;
	b=fU1S7qaDeIdUbeQQA0C1f5zoCaBjU+x+s8KFsuA2cP2O+RZBWJQFAW4Zej0T5TcAZabHyB
	/1lMjIP8IXfp7ogRKz+zjAG01MWfXlSDDQDpGkqUvNTdj4ieQeUooM96OUk8hUMG8U5wEQ
	P1QJTfo3fq6xXm95PvOmCCHl0We/RY0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-qeFwsMKcPoKKbY0zitgmqA-1; Fri, 06 Mar 2026 17:10:44 -0500
X-MC-Unique: qeFwsMKcPoKKbY0zitgmqA-1
X-Mimecast-MFC-AGG-ID: qeFwsMKcPoKKbY0zitgmqA_1772835044
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89a174bd442so233954996d6.2
        for <linux-nfs@vger.kernel.org>; Fri, 06 Mar 2026 14:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772835042; x=1773439842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxEDbjwnH91/X9ML2Cl4u2znqX6HdY3EI0qhMGi6SBM=;
        b=CWpJK+DHdV5gi5Qjfg9Wkvhv2SlPe7Pifsr4jlvsX2UeIB7MUs0wi/XaPJ6MPcUcwM
         8nLNF8+SDDW5WzAbbZ+iukrb6H+00xhqNRqWpZj8+xTazoMzXj6kIB6sAb853CNMXsT5
         eP/jG4cnotu9s9ZWUKjTwJTYAv7kTyRtXd9AHZwn1M26AKw3IgcGqLNswEmT6Tm0qNXJ
         ZfTaZ583Ft5Py5wIDrlM5+gLFgTFWwOX4nVPhNk0ckm8zUgZ8Km9ww3c5KFyszgKCXdj
         39fQSSfmlZ3Qtet+B2b3rROExj9v4OdQqRcfigY5HSsOhPHhgbnfQ05k46eux0U7oHxn
         6MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772835042; x=1773439842;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxEDbjwnH91/X9ML2Cl4u2znqX6HdY3EI0qhMGi6SBM=;
        b=c56/67IMIBKIuepCYn76Zif4Sz54Vfp4D7uAGvMWcAFfHvG1NrL/yzJdprfxf5nFMk
         UJiRZ/EtNtiPg/fEDunqStG0IR9QOUr+euyxGrbI1i2zn6UmGsrVKu058CV2y15qvnsQ
         aSaMb0xHiXoIcT6+bF9+2Ua4xmkLZjv0UtfZvzKEltVWV/ngCZb8J0zwX9eHncZTj5eo
         Y4tfpCCoVmGwmbWoWFE267q5UawZ+RLfV14U5fGXIeO5Q7HE4HnqcJC7EoLuKQqmWoRZ
         eJiYOal+slohs4CcgViac/dXJzq/33ZLB2+Vp2zbK3lFDdbESDIFbwFZFj/da//2cox5
         K9pQ==
X-Gm-Message-State: AOJu0YwtXl4eh3EuJZy3MEYv4xwC5ApYGfIV1BA42KHGoA4BqdzCpIjl
	5yMdGUhO+dY3W6J4sHnVi8BVrY+qAztL2jAKztZ//gR44QHrftVMy9JyWCcdOidDYZEoiU++fX7
	QExTBrDNwqikriyEYdCNp3sTGmmxtEGZrK4HpzQ2mtDPxjvK7Cq7iB2ujAKXgsT7PHBGtBRsF4Z
	nWKhbZPA6SKuczs7R8aQWGWX1IwkSQf9yBUGX7AprkzLY=
X-Gm-Gg: ATEYQzxgw8DArdMNlQfT542ls/h74r/QFnnktyehhpROrzCmYX4+Xx7ZucvjOy903hw
	c+BDZxtXl8duM6lSLFwOuqs7fu+GkAZnwbWtTDVxiFBbtTLxqV05qbdX42ZBpDF4i8dlitS7Uhc
	5lzfb8YELxt6cRLYx2IED0CtmGQ1TlhZgpTQxqCwE4VrzxOd7HmfFUm3O7u2xnYsuZ1sAAhDdNk
	slxyCwMVeMdx2tiMbImGSyumZvELQT2FAlmzO/V6NUfRAgRMA9DB9pxyMiHicD6iq/+4wbJh7Sk
	v8gczi+3Lztwzo9SiLSztg1r6GA2koF8c9ctkZqsZoatg9gOfs9JayGOebt0m7e/W6MKagc1/Cs
	/O+uUBoSkfHg8w1BsDth2
X-Received: by 2002:a05:6214:c4a:b0:899:f6b6:543c with SMTP id 6a1803df08f44-89a30ad1bebmr54619026d6.47.1772835042661;
        Fri, 06 Mar 2026 14:10:42 -0800 (PST)
X-Received: by 2002:a05:6214:c4a:b0:899:f6b6:543c with SMTP id 6a1803df08f44-89a30ad1bebmr54618596d6.47.1772835042217;
        Fri, 06 Mar 2026 14:10:42 -0800 (PST)
Received: from [172.31.1.12] ([70.105.240.20])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a3140dbb8sm20921296d6.3.2026.03.06.14.10.41
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 14:10:41 -0800 (PST)
Message-ID: <fce3329f-45ca-4be7-b493-847a32ca7c2f@redhat.com>
Date: Fri, 6 Mar 2026 17:10:40 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "nfsrahead: enable event-driven mountinfo
 monitoring"
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20260306215254.18764-1-steved@redhat.com>
Content-Language: en-US
In-Reply-To: <20260306215254.18764-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9F148228384
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19856-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/6/26 4:52 PM, Steve Dickson wrote:
> This reverts commit 2b62ac4c273a647df07400dc1126fceb76ad96c0.
> 
> Most blktests block/ failed with "Timed out while waiting for
> udev queue to empty." [1]
> 
> [1] https://lore.kernel.org/linux-block/CAHj4cs8URj2fJ7KyP9ViAm6npVOaMiAErnw2uFyPYEU2wb7G_w@mail.gmail.com/T/#t

Committed... (tag: nfs-utils-2-8-6-rc4)

steved.
> ---
>   tools/nfsrahead/main.c | 35 +----------------------------------
>   1 file changed, 1 insertion(+), 34 deletions(-)
> 
> diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
> index 64953346..b7b889ff 100644
> --- a/tools/nfsrahead/main.c
> +++ b/tools/nfsrahead/main.c
> @@ -16,7 +16,6 @@
>   
>   #define CONF_NAME "nfsrahead"
>   #define NFS_DEFAULT_READAHEAD 128
> -#define MNT_NM_TIMEOUT 10000
>   
>   /* Device information from the system */
>   struct device_info {
> @@ -118,39 +117,7 @@ out_free_device_info:
>   
>   static int get_device_info(const char *device_number, struct device_info *device_info)
>   {
> -	int ret;
> -	struct libmnt_monitor *mn = NULL;
> -	int timeout_ms = MNT_NM_TIMEOUT;
> -
> -	ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
> -	if (ret == 0)
> -		return 0;
> -
> -	mn = mnt_new_monitor();
> -	if (!mn)
> -		goto fallback;
> -
> -	if (mnt_monitor_enable_kernel(mn, 1) < 0) {
> -		mnt_unref_monitor(mn);
> -		goto fallback;
> -	}
> -
> -	while (timeout_ms > 0) {
> -		int rc = mnt_monitor_wait(mn, timeout_ms);
> -		if (rc > 0) {
> -			ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
> -			if (ret == 0) {
> -				mnt_unref_monitor(mn);
> -				return 0;
> -			}
> -		} else {
> -			break;
> -		}
> -	}
> -	mnt_unref_monitor(mn);
> -	return ret;
> -
> -fallback:
> +	int ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
>   	for (int retry_count = 0; retry_count < 5 && ret != 0; retry_count++) {
>   		usleep(50000);
>   		ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);


