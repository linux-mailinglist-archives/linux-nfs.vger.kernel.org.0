Return-Path: <linux-nfs+bounces-18632-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N50Fq2Of2k9tgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18632-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:34:37 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F53C6BE8
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A36E30048F2
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Feb 2026 17:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4ED26B955;
	Sun,  1 Feb 2026 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImSnZn9g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ea0Su7Q0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFBC19B5A7
	for <linux-nfs@vger.kernel.org>; Sun,  1 Feb 2026 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769967273; cv=none; b=mQw9Z/GY+/QOGjB2j4njLncas+oeruYozuh42agLm2ggwnLpKPvI5F3g02gnyTqmMA/xwYRrPGPBLta72k116Mixqsy5J/UaXEcCD/fZ9Y6J28e4mLTtsaiJ2HPBAib8XF5IZF7Z6hWOCsaZYJpuJaXhRPsjSXFncp0sanaen+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769967273; c=relaxed/simple;
	bh=mn58iUW6q6XEJtJnyjYgP+iOI9vO941juIeIo4Wqwok=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m+FTb68n6wI/B0SbaPcXPptBGsbL+pewLZk00TuIiIu/UOWBF0EuBlRzIkeEAuqquIsAdsOr99+0M0pzCwYxkWkqLUn8SQiuLTTbRh/PkPtmtZ7YrFI/Yy0I1Gjks5m8ozCn4M+R3zCPuYRhOosjLc1UseRcmmPty9A4c5uzj0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ImSnZn9g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ea0Su7Q0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769967271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRV9XrJYXkqO6RiYw4CRsDKzNDfZMQ28rhaj3AYdBOI=;
	b=ImSnZn9gG9G5vJgVF+UhChvmZkpQwfIPprPVoDLaei7TpCtiSKVaUHbIahLeIJdHbpVg+o
	u2ZeS3xk5+hXPB6oLGvcFj/jAFa8/v8NxtmgONmqqdMW4gwRyBJKOF4xWvnsHcUopBOQsV
	BJnV2B8t2pF4X4t3/1MjJh+cmTXYcTs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-TEaVJ-EsPfu-LURZhgE_Jg-1; Sun, 01 Feb 2026 12:34:30 -0500
X-MC-Unique: TEaVJ-EsPfu-LURZhgE_Jg-1
X-Mimecast-MFC-AGG-ID: TEaVJ-EsPfu-LURZhgE_Jg_1769967270
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8823f4666abso26713716d6.0
        for <linux-nfs@vger.kernel.org>; Sun, 01 Feb 2026 09:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769967270; x=1770572070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tRV9XrJYXkqO6RiYw4CRsDKzNDfZMQ28rhaj3AYdBOI=;
        b=ea0Su7Q0uE/bUoDeg5IwRLWZg4iXOo8uQKeGPoAwLSV9qW3gNN6t3ig8GKsQ8xbfDI
         kjuHVUNwfpB3gBI4SHL/cS6/+aHMF8lbXoDYtR9aassqaSQffwAdrkw2EKCQNuHI8DlN
         qOkArAw+zlx5wQnJnudbLUpJJr4b8aTrDTQ4xeLM8NUJ2LuRzdtd7puyhZjRTq0GGUOr
         BMYEuHv+Bo+6Cm9++FnDH93Dyc/ICW5TCps7ZvLgZa0uQv0RK6GRfM1Kxt5F7AHliMyy
         C94VxuHSzWEJV4T1GIGr/dZM2jFaAKLVYnGonvj7HKJzqgtKDdj0wdRm6nbXnNfxSuLY
         nNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769967270; x=1770572070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRV9XrJYXkqO6RiYw4CRsDKzNDfZMQ28rhaj3AYdBOI=;
        b=L3UxNTT/+4GVYzs0OPM2c1YvzknGpiPYh1M+VMRYt0HB8lJ8UtzhhMzbu0kTyV4hod
         Yt0D9jL3z/gvnjy/KzEh4FBj+kRZm/I828hbilEd6z8+w60nqhVFJw9MNZglbxv758vI
         HxCjJf/gnV6AdajiRiQ8MFL9tWz0A4kKThji4edKXOf1BbKEpKdL4GVyQv7xHZQ0EKAP
         wuTZbfzyh4ODqb//pNCAVBoja52664Ym4gpHpDdYS+iKT5MssOOoAFcPEXmpg12guy/8
         2Us9Jy/rdEYaAsrmNtr/PWePuwWaZINfM7u+TzPOfp65lrvOpi0A+aXiNz0iFmqjpzFe
         miqw==
X-Forwarded-Encrypted: i=1; AJvYcCUbiH6F74H5eJ9RcnLILltnF1mYV4EEJqTrMm96SDT+74uIJnuw4LNroPMyT/xo/7ENX2AKkF83n/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyutZc78F7aOR3E9xjP5pEgtJnQARkR2VtqkoxChW1e6id/cG/P
	XuknAs0yKI/nplyA1BDeVcYsYIFhybGwzmkBzytQk5LrwCe/pPHyM4W9vWhFn19cit6Un0Iff+5
	dtJZjpzJzEwm0dj8FKDAzJZN/5wsqsHfLpN6LUBNp1eNIamQrtl4Z2o+7mt5H/w==
X-Gm-Gg: AZuq6aIebvq565lV0GCJEJ9qLFwQCCB5AHZ5TtSKWJCm1mXLP8/Ipl9bNigyebOUofR
	nlvdqpTrnmiopAb/9z6h2nNefX+bsw+rh6A0BziuIn7zkXxIuzxBQxx7HRbYE+XSkUDBHfvp3qC
	r9tHaCEfP8L2BpnPyzh/m7wlRZg+qVYGD0HiGvkAIFvzQSC4TDdJ7YRpmVESnQ5F9Lw/lFizYz1
	UzAxDm9bFeJdpHmgXyLMzdrVDR12muQtkMCc319Z8tEcXPzFYeoQRCmjl/1kzATefMYerNWWFOE
	iIViejpcJD+Bwx4FPBnBvkNzNRNtxS9u1u7/cZeyae8O6bNZR8YMMcUdE8HkY10p5vvfbpH5zTE
	joY3qI0F8
X-Received: by 2002:a05:6214:f09:b0:882:4a63:63a7 with SMTP id 6a1803df08f44-894ea16a331mr132228116d6.60.1769967270126;
        Sun, 01 Feb 2026 09:34:30 -0800 (PST)
X-Received: by 2002:a05:6214:f09:b0:882:4a63:63a7 with SMTP id 6a1803df08f44-894ea16a331mr132227946d6.60.1769967269726;
        Sun, 01 Feb 2026 09:34:29 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36a997esm99964156d6.3.2026.02.01.09.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 09:34:29 -0800 (PST)
Message-ID: <b8a86026-8e4d-430d-8abe-ae1ff32ea70f@redhat.com>
Date: Sun, 1 Feb 2026 12:34:28 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 04/10] rpcctl: fix a typo in man page
To: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>,
 "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
References: <OSZPR01MB7772F1D427EBD315AE2A855D889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <OSZPR01MB7772F1D427EBD315AE2A855D889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
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
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18632-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0F53C6BE8
X-Rspamd-Action: no action



On 1/29/26 3:50 AM, Seiichi Ikarashi (Fujitsu) wrote:
> Signed-off-by: Seiichi Ikarashi<s.ikarashi@fujitsu.com>
Committed... (tag: nfs-utils-2-8-5-rc3)

steved.

> ---
>   tools/rpcctl/rpcctl.man | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/rpcctl/rpcctl.man b/tools/rpcctl/rpcctl.man
> index 2ee168c8..205cde77 100644
> --- a/tools/rpcctl/rpcctl.man
> +++ b/tools/rpcctl/rpcctl.man
> @@ -31,7 +31,7 @@ If \fICLIENT \fRwas provided, then only show information about a single RPC clie
>   .P
>   .SS rpcctl switch \fR- \fBCommands operating on groups of transports
>   .IP "\fBadd-xprt \fISWITCH"
> -Add an aditional transport to the \fISWITCH\fR.
> +Add an additional transport to the \fISWITCH\fR.
>   Note that the new transport will take its values from the "main" transport.
>   .IP "\fBset \fISWITCH \fBdstaddr \fINEWADDR"
>   Change the destination address of all transports in the \fISWITCH \fRto \fINEWADDR\fR.
> -- 2.47.3
> 


