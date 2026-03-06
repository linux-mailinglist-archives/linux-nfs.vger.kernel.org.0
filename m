Return-Path: <linux-nfs+bounces-19855-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9qtFNu1Qq2npcAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19855-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 23:10:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1CE228366
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 23:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 294C63037143
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 22:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA95636AB61;
	Fri,  6 Mar 2026 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3fQYoLh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m+n8TZZD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91149550F
	for <linux-nfs@vger.kernel.org>; Fri,  6 Mar 2026 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835011; cv=none; b=m3IuGIsAo+/CNHWz40+x+cdz+PzF6E/vSpxKYUPsFpbCSX/vmWAfSl9UyGj2x9uVG5qbUPntQfKMb3PXPQZIo7Em19Fbkh0M8ho36lLd4K2zXWXY5OnDDC353i3JjfhU6SKXZ/xASsrg8W2QPHw4PhcQe9Q752tqqvgQExtrL8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835011; c=relaxed/simple;
	bh=7cMgMUSeAOibSx6TPHRTH5claOKEOBzhnwbvzYMEGDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTlCcvJn/2dZbRftDa/4pEZ3y/L+5O/sqd0pdT2MyiBwXEaserndzrDUMH+apAINNhCQ5N91PeEfwsQDO21qZvMm10sq4WH0NvYFwSj4frabOJxbgkFOrZoHVzXdC6/y/PLaY3f36sjGZnYqCw1SOp2QI3s7h4OXMkoRN+srPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A3fQYoLh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m+n8TZZD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772835008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JCrR8jpSHfoQKc/QXOhTgFRTsMEh1wC4RUwOlmVfb1c=;
	b=A3fQYoLhtJ6yXLFGYxWFv4+gPPDIb0Hdhtabuv/c7yRD30tp8Y/OW4Bi+MDZPIyD7ki0QR
	NbacITGgVJ7ORJhKbXHsblA+UPkwdVd3J+BnyZYJWpK+HdvdjYpmPL+rug4kl0PHnfVyts
	L5mlqD/ZxALkSRD2v6eZoegseZ3KQPM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-23yAyeZ3NbC67ND_Iw-CgQ-1; Fri, 06 Mar 2026 17:10:07 -0500
X-MC-Unique: 23yAyeZ3NbC67ND_Iw-CgQ-1
X-Mimecast-MFC-AGG-ID: 23yAyeZ3NbC67ND_Iw-CgQ_1772835006
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd767c51efso41790385a.2
        for <linux-nfs@vger.kernel.org>; Fri, 06 Mar 2026 14:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772835006; x=1773439806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCrR8jpSHfoQKc/QXOhTgFRTsMEh1wC4RUwOlmVfb1c=;
        b=m+n8TZZD7Uj4foQZStODA9SnL6HYij/7zceSvPhDqMrcTsntt5MoDJIwQAHgtrgkR0
         F+/pfF39DucDd+Lu53IqI0zcUc6jO0TcKbeRBVs0Dcuj51i2v3MnZiAkl6SIZ75GLC9A
         56WyRmlhSaUhXML/0QhVFet66Y7O5amYTAjeRiI6+vqj5Jh8ECfkl8UnNUuUmJEdahCC
         1Z5rfIRZ4KMFafgQX2koCSzu2brrWG4qwc8q1BD1CsZ3/qbV5/Fzs2Itkpm/Ed9503AL
         UBdUYsCWGhFtACLQ7Jjk1o13UK4gZu9qe6xqxiIm1827NEmoogek5zJAjmP6NhSjxMxq
         Ngaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772835006; x=1773439806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCrR8jpSHfoQKc/QXOhTgFRTsMEh1wC4RUwOlmVfb1c=;
        b=oVWx9tegRqs1/3QbRdmUsllhHR9b5xqXFle2HIuJSX+9xyBzooV7pA6eVrgPE4Nobz
         ATWOkfQGws3HVWwOi8yoXIoeReVTXu6xBsB64fVtiSBfwIutdaqn/+fMjSI/omN+0+2i
         gCeDfCw/VkgWAjxJvtPRoee1FAvTrt45OKSR06m928k9wrb8VRprpPmt4OLNSOKanNz9
         8iew5686C7j+oj2TsDbSr2xt1LewPHPePHfai9c1oBZcBRxjsErdXkiehKb4gdrLVcbv
         sQmNmcJZOAwgyMEw484uEgc+pP3LMK/wj4kfYhyAx7cFYw/eMNSS7b/UncOlWFCzsLmN
         1FJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg7+x+1rmHxVQzKDE7AH/lZ12s287VFiw5uGXT1jeNUpKdhd0jPCohtz/hD5Z2PKK7axyB68FSG+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzky0v0EV/YXSBW9epryNLyVy+BOxww71slcdRQxRA8uv/D5TDC
	CVNpHPZUNNdvS7qlnpjBNOnN+AxFdNnwi+sUhcx8wA3qmlQiWA2ZoaZaJr2uKagyrjE64xOH5f+
	lFSz1dmCrE8GqdUh4shEPhbm9OlDRRpl5CUToOTCnYB9oCV578VKSKzZWI7xlKg==
X-Gm-Gg: ATEYQzzkywnYSt3m5AfAl6ma97FMWxrbXimiJhNadhmCRdWaEUYRxfBDELDHZm9EhwA
	GLL48w6Q9DdOpu1YRZf0UDUZS/jvESzC2SwBzSqrcCi1IXxi6JXCeVNQVd1paWylOBzyayciCQQ
	wD9eE9iMvCV9e2N0to7+d47UQuXz1ntwjJXbJcDcpUKsUFi0DDh68cVdiKOgA/V2m6rqZLCNA9+
	PP3Gzo9H7GywKQ1ZM8pMyvm5AJD3efLo4HDPNSJNDbB4YhGGgXn3lpKNP3rxKKZL1m4xRLHfcGJ
	KlvXASY2csf5PafAiJ2vhb+ny1pfjNqw/JPOkFpPVy1erdwMHpJZraj9Zc50kIKfy6MxtYk794s
	AVvR+lCmSr+U8OtWXLx+u
X-Received: by 2002:a05:620a:f07:b0:8c9:e989:9d97 with SMTP id af79cd13be357-8cd6d469a4amr472880485a.68.1772835006116;
        Fri, 06 Mar 2026 14:10:06 -0800 (PST)
X-Received: by 2002:a05:620a:f07:b0:8c9:e989:9d97 with SMTP id af79cd13be357-8cd6d469a4amr472877885a.68.1772835005621;
        Fri, 06 Mar 2026 14:10:05 -0800 (PST)
Received: from [172.31.1.12] ([70.105.240.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f4a2fdasm194436085a.17.2026.03.06.14.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 14:10:05 -0800 (PST)
Message-ID: <ea495f1d-1464-4f9d-91de-dd3fe828fcff@redhat.com>
Date: Fri, 6 Mar 2026 17:10:03 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsrahead: enable event-driven mountinfo monitoring and
 skip non-NFS devices
To: Aaron Tomlin <atomlin@atomlin.com>, tbecker@redhat.com
Cc: yi.zhang@redhat.com, linux-nfs@vger.kernel.org
References: <20260306161929.4148128-1-atomlin@atomlin.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260306161929.4148128-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0C1CE228366
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
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19855-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.965];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,atomlin.com:email]
X-Rspamd-Action: no action



On 3/6/26 11:19 AM, Aaron Tomlin wrote:
> The nfsrahead utility relies on parsing "/proc/self/mountinfo" to
> correlate a device number with a specific NFS mount point. However, due
> to the asynchronous nature of system initialisation, the relevant entry
> in mountinfo may not be immediately available when the tool is executed.
> 
> Currently, the utility employs a naive polling mechanism, retrying the
> search five times with a fixed 50ms delay (totalling 250ms). This
> approach proves brittle on systems under heavy load or during
> distinctively slow boot sequences.
> 
> To mitigate this race condition and improve robustness, update
> get_device_info() to utilise the libmount monitoring API.
> 
> The new implementation introduces the following logic:
> 
>      1.  Initialises a monitor on /proc/self/mountinfo using
>          mnt_new_monitor().
> 
>      2.  Replaces the fixed polling loop with mnt_monitor_wait().
> 
>      3.  Increases the maximum wait time to 10 seconds (MNT_NM_TIMEOUT).
> 
>      4.  Introduces a fast-path rejection mechanism. NFS backing devices are
>          allocated from the kernel's unnamed block device pool (major number
>          0). While some local multi-device filesystems (such as Btrfs) also
>          utilise anonymous device numbers, physical hardware block devices
>          (e.g., sda, nvme) always possess specific, non-zero major numbers.
>          By instantly exiting with -ENODEV for any device string not
>          beginning with "0:", we safely bypass the monitor for physical
>          drives, preventing the exhaustion of udev worker threads.
>          See set_anon_super() and get_anon_bdev().
> 
>      5.  Implements strict monotonic deadline tracking within the monitor
>          loop to prevent indefinite blocking.
> 
> Fixes: 2b62ac4c ("nfsrahead: enable event-driven mountinfo monitoring")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Link: https://lore.kernel.org/linux-block/CAHj4cs8URj2fJ7KyP9ViAm6npVOaMiAErnw2uFyPYEU2wb7G_w@mail.gmail.com/T/#t
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
Committed... (tag: nfs-utils-2-8-6-rc4)

steved.
> ---
> 
> Hi Steve,
> 
> This patch should resolve the udev worker exhaustion issue reported by
> Yi. It applies cleanly on top of the current nfs-utils tree, after your
> revert [1].
> 
> Thank you.
> 
> [1]: https://lore.kernel.org/linux-nfs/20260305124221.55407-1-steved@redhat.com/
> 
> 
>   tools/nfsrahead/main.c | 55 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
> index b7b889ff..78cd2581 100644
> --- a/tools/nfsrahead/main.c
> +++ b/tools/nfsrahead/main.c
> @@ -3,6 +3,7 @@
>   #include <stdlib.h>
>   #include <errno.h>
>   #include <unistd.h>
> +#include <time.h>
>   
>   #include <libmount/libmount.h>
>   #include <sys/sysmacros.h>
> @@ -17,6 +18,8 @@
>   #define CONF_NAME "nfsrahead"
>   #define NFS_DEFAULT_READAHEAD 128
>   
> +#define MNT_NM_TIMEOUT 10000
> +
>   /* Device information from the system */
>   struct device_info {
>   	char *device_number;
> @@ -117,7 +120,57 @@ out_free_device_info:
>   
>   static int get_device_info(const char *device_number, struct device_info *device_info)
>   {
> -	int ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
> +	int ret;
> +	struct libmnt_monitor *mn = NULL;
> +	struct timespec start, now;
> +	int remaining_ms = MNT_NM_TIMEOUT;
> +
> +	/*
> +	 * Fast-path rejection:
> +	 * NFS backing devices always use the anonymous block device major number (0).
> +	 * If the device number does not start with "0:", it is a physical block device
> +	 * and will never be an NFS mount. Exit immediately to prevent blocking udev.
> +	 */
> +	if (strncmp(device_number, "0:", 2) != 0)
> +		return -ENODEV;
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
> +	clock_gettime(CLOCK_MONOTONIC, &start);
> +
> +	while (remaining_ms > 0) {
> +		int rc = mnt_monitor_wait(mn, remaining_ms);
> +		if (rc > 0) {
> +			ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
> +			if (ret == 0) {
> +				mnt_unref_monitor(mn);
> +				return 0;
> +			}
> +		} else {
> +			break;
> +		}
> +
> +		clock_gettime(CLOCK_MONOTONIC, &now);
> +		long elapsed_ms = (now.tv_sec - start.tv_sec) * 1000 +
> +				  (now.tv_nsec - start.tv_nsec) / 1000000;
> +		remaining_ms = MNT_NM_TIMEOUT - elapsed_ms;
> +	}
> +
> +	mnt_unref_monitor(mn);
> +	return ret;
> +
> +fallback:
>   	for (int retry_count = 0; retry_count < 5 && ret != 0; retry_count++) {
>   		usleep(50000);
>   		ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);


