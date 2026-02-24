Return-Path: <linux-nfs+bounces-19169-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBN/Ce6enWnwQgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19169-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 13:51:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 517141873D4
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 13:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD4173042FFF
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 12:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE1739A7E8;
	Tue, 24 Feb 2026 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2ouxBUa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgvAzbeX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8EFE555
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937506; cv=none; b=hpm1AfWbEbTQPwN96gkiSydoWBg5bKeoam9TVxkVvShMk4QZcu80E5FVeafzrZYyDlmaKJhJx0CjRTpQdesDtdV4Q36j1MLX2tTOWp1EhKQYJkpmcyPHsfJRkDd3/2iJ9N0XdvwN7KJsJ07R5kvpAu+IdqKtX/zeNFcD6d2HpY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937506; c=relaxed/simple;
	bh=uMmL1+qYrdiy9K42L2o4nVazqnruxbQ9nVegi9wuO4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgOb1h+wtPq9UX4Bbf6nfHaYCMHa2eiFzZChupArKOEdA09K9bH+9ggH74Gbbgqk9QqlNcD/VLCErVAwDKpaS2U9yzC9kAz7L0S0SQgJTvy0sykTA7i76tPwkZG0LMnLg165kX/YYcSK06NFtseR9eUvkmi9/5q6WOiDidabkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2ouxBUa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgvAzbeX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771937503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0ava7PHbpy0bjI5XfoeIKz3rLDrQzQw02LVHHRDRkQ=;
	b=A2ouxBUai4ZcTppdnJz3avcG3vtkV0h7nkOr1PtoE94+pf647P0NhrzfO7xpXzyty1xW7U
	B37ZfnHrr6CYVOQPG7d0Ts19LXbgq8SeuPsF1YLnvqlk3yxsQE0hTQCfasix4poI3v8Yyt
	iPoROI9A5D2rPnLChQkSD03mAsSk5/0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-UT7Gup8iMEiQo-MAm4CDwg-1; Tue, 24 Feb 2026 07:51:42 -0500
X-MC-Unique: UT7Gup8iMEiQo-MAm4CDwg-1
X-Mimecast-MFC-AGG-ID: UT7Gup8iMEiQo-MAm4CDwg_1771937501
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-897021ebe91so543522776d6.0
        for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 04:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771937501; x=1772542301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0ava7PHbpy0bjI5XfoeIKz3rLDrQzQw02LVHHRDRkQ=;
        b=QgvAzbeX/WLwjZUd6nOAi8/lZPoeujNQ9uId9Wcl4JGLSvyaSwa0q4Hv21kIKDUnWk
         jS3zlG0ROIHs0FGkDWHiMIR8QcvuCT/svm63RyjIgQpljzUUASsU1k8dNErhGm/8zIi5
         MB2/aM5LUfbAIk90dnThyuEvo4ufldqJUrroQkpHWR+b1aUvglwN7DHz2OZwkid5t4Qk
         Nas68qosRsfpYgcUgz/nJjtq7twrPpWoa7ReKD3qxkE47oVUFWLb3sAnGh0N5GlId8uc
         FuCFPAv5cfwz3c9JCOFP/jEzmq4KD71H/i8029QBYFE+fHdZ8TQuOiG3mbzeYc7HCF9T
         DQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771937501; x=1772542301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0ava7PHbpy0bjI5XfoeIKz3rLDrQzQw02LVHHRDRkQ=;
        b=GxffJe9xPXLJzdG5sWEVGRTkHpBq36FOvTvt643qX29PAlSsOYRxk5T8T1zKWGQflx
         ehmbhDeyQfH0+qmSlhxAlpIuWcZFE6HWwi/4TryU3PEHfRfuARtyQ81bh2fad7fXt4gI
         LtWJ234uvdzAX6CjgKyUTrxBeikpIC+BzRX+LOfTYIkTgc1dOGEmhW2i5KWoNeteajJA
         xRSXAWBtoArzLQ8CniiFnmiWubk0cqYaNHHkeNGB6aBVH9l0h9tuuyW7IjqDnNOFFQzf
         7yHwM0SApZkyrbx+zfQYpkY5ftB6C/v20e5/7ZoyE13PdwjQHngWtM+/8X4a65UVBrDO
         rWOQ==
X-Gm-Message-State: AOJu0Yy2eOTo/B29sEOuQzRJyxPZLUAaZLnZHlfLhuBi+SEZDTZxUb8Y
	dXvoo4MvrOqPOnVaRC6tErqYDornKGoKK4/Trlz072emO4nz66u7xldCYuxUrB5VQzV20LnuqCw
	ikhiOiwG1AkdEv+yzhjiabc1ev6s84PIUGJJjygSJKqSFcZH653Caz14L/ULQnw==
X-Gm-Gg: ATEYQzxTOpwQmDUd2Rq/UURku9wTuwk+6ejC79qEhmLnONrKd9h9c3SSRKIzRTQ8G+M
	6d+f/HnPa2Q5EFYFKSgBCwgatfAZvJH9dMd+1KUZF1Q6eEOJZoY/d9yPeorHquUG4meKYJGP5yg
	+uHMUjJhUJSbYT6lnDTZeAbyCWa3p0V47hnkLQIr26nboHtLjO8S+jGL8zKVCzLHkzhk9PTCJB4
	zR8XDB2chh0cnaEFASjM0w12KAfF622JqqlIDn+7rHHAhLoy0cNSw4/945EMXJd9EBeRK74lw/c
	K3o3lb/8tqWom+POa3MaAhjUIia9YjeZhJxETxOcr5JJbUOc5KYvr/RMey36RQ1zlK55Qs/Dr97
	G1pEkgN2eSIqVZLZzOqOh
X-Received: by 2002:a05:6214:1245:b0:88e:6db7:f999 with SMTP id 6a1803df08f44-89979c561c9mr175290956d6.6.1771937501401;
        Tue, 24 Feb 2026 04:51:41 -0800 (PST)
X-Received: by 2002:a05:6214:1245:b0:88e:6db7:f999 with SMTP id 6a1803df08f44-89979c561c9mr175290546d6.6.1771937500805;
        Tue, 24 Feb 2026 04:51:40 -0800 (PST)
Received: from [172.31.1.12] ([70.105.240.20])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d54000fsm96108981cf.10.2026.02.24.04.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 04:51:39 -0800 (PST)
Message-ID: <abcff839-6bf9-4ab9-916b-54e407ddbb19@redhat.com>
Date: Tue, 24 Feb 2026 07:51:37 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsrahead: enable event-driven mountinfo monitoring
To: Aaron Tomlin <atomlin@atomlin.com>, tbecker@redhat.com
Cc: linux-nfs@vger.kernel.org
References: <20260211190122.3878196-1-atomlin@atomlin.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260211190122.3878196-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19169-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 517141873D4
X-Rspamd-Action: no action



On 2/11/26 2:01 PM, Aaron Tomlin wrote:
> The nfsrahead utility relies on parsing "/proc/self/mountinfo" to
> correlate a device number with a specific NFS mount point. However, due
> to the asynchronous nature of system initialisation, the relevant entry
> in mountinfo may not be immediately available when the tool is executed.
> 
> Currently, the utility employs a naive polling mechanism, retrying the
> search five times with a fixed 50ms delay (totalling 250ms). This
> approach proves brittle on systems under high load or during
> distinctively slow boot sequences, where the population of the mount
> table may exceed this brief window. Consequently, nfsrahead fails to
> configure the readahead value.
> 
> To mitigate this race condition and improve robustness, update
> get_device_info() to utilise the libmount monitoring API.
> 
> The new implementation:
> 
>      1.	Initialises a monitor on /proc/self/mountinfo using
> 	mnt_new_monitor().
> 
>      2.	Replaces the fixed polling loop with mnt_monitor_wait(),
> 	allowing the process to sleep until the Linux kernel notifies
> 	userspace of a change to the mount table.
> 
>      3.	Increases the maximum wait time to 10 seconds (MNT_NM_TIMEOUT),
> 	significantly reducing the likelihood of a timeout failure
> 	whilst ensuring the tool returns immediately once the mount
> 	appears.
> 
>      4.	Retains the original polling logic as a fallback mechanism
> 	should the monitor fail to initialise.
> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
Committed... (tag: nfs-utils-2-8-6-rc2)

steved.
> ---
>   tools/nfsrahead/main.c | 35 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
> index b7b889ff..64953346 100644
> --- a/tools/nfsrahead/main.c
> +++ b/tools/nfsrahead/main.c
> @@ -16,6 +16,7 @@
>   
>   #define CONF_NAME "nfsrahead"
>   #define NFS_DEFAULT_READAHEAD 128
> +#define MNT_NM_TIMEOUT 10000
>   
>   /* Device information from the system */
>   struct device_info {
> @@ -117,7 +118,39 @@ out_free_device_info:
>   
>   static int get_device_info(const char *device_number, struct device_info *device_info)
>   {
> -	int ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
> +	int ret;
> +	struct libmnt_monitor *mn = NULL;
> +	int timeout_ms = MNT_NM_TIMEOUT;
> +
> +	ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
> +	if (ret == 0)
> +		return 0;
> +
> +	mn = mnt_new_monitor();
> +	if (!mn)
> +		goto fallback;
> +
> +	if (mnt_monitor_enable_kernel(mn, 1) < 0) {
> +		mnt_unref_monitor(mn);
> +		goto fallback;
> +	}
> +
> +	while (timeout_ms > 0) {
> +		int rc = mnt_monitor_wait(mn, timeout_ms);
> +		if (rc > 0) {
> +			ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
> +			if (ret == 0) {
> +				mnt_unref_monitor(mn);
> +				return 0;
> +			}
> +		} else {
> +			break;
> +		}
> +	}
> +	mnt_unref_monitor(mn);
> +	return ret;
> +
> +fallback:
>   	for (int retry_count = 0; retry_count < 5 && ret != 0; retry_count++) {
>   		usleep(50000);
>   		ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);


