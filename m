Return-Path: <linux-nfs+bounces-18635-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBqvLA6Pf2k9tgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18635-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:36:14 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B0FC6C00
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3209530048F6
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Feb 2026 17:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B997C26B955;
	Sun,  1 Feb 2026 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgGsX6cb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WO1FvGC1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489519B5A7
	for <linux-nfs@vger.kernel.org>; Sun,  1 Feb 2026 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769967371; cv=none; b=OZOAbtnkg0k/H1y8br36W7K3hZY7VtDcMb/CSGy1l+G7G3KLxMdFE5vSVNjtCUCFoYYTwI6tXfPlCfnSZSS2WTi80nYRtrHlA4cZg3i7U68ljVtO8IfgeE1cYN4zSbtPICSZytDW2bi0J+2X+9svzB5t1Zb7WTyb94c6RhIXoC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769967371; c=relaxed/simple;
	bh=qnoKjULasIJzN4sEPhDtVyrVYIKqXYmsBILckV5EXFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m76KzNiftTaWBuyXccjnKn/Xfk2TSHVzQ1qfa5Ys0r2ZerqBQplCPYclOnNqUfpfFpQjgtvUifnAy+6fOYMGjgj20YyRO5JxgSJsrbs6HI+5GJwPkHILLlv3g9jDAldP/4AgGjzn7e1mi7qyCsGq0gwgTINR0kp/w1ahkirfxu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FgGsX6cb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WO1FvGC1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769967369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7F19pYJiRWTNPB9oNoCudWoajIWOXDcFEQPvqE6CMAc=;
	b=FgGsX6cbNKDWssy3WFSXpGCJ/gLd9wJmGdXAhQi0R5xKzQW8H9vdBZIPZVK5cw1cGXqt5N
	rXADQ3ZxJC8NU5rNzllpFoDzmmVD0dHWSSR4xBF0IqEmCzCFjC2OLTKve53g2CNt6qT4vz
	c2bwa5UreP3Re7KBaQmalPZoj3l7Q/w=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-lC4yb97wPyG8rS6_HyzLKQ-1; Sun, 01 Feb 2026 12:36:08 -0500
X-MC-Unique: lC4yb97wPyG8rS6_HyzLKQ-1
X-Mimecast-MFC-AGG-ID: lC4yb97wPyG8rS6_HyzLKQ_1769967368
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-501473ee94fso192323901cf.3
        for <linux-nfs@vger.kernel.org>; Sun, 01 Feb 2026 09:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769967368; x=1770572168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7F19pYJiRWTNPB9oNoCudWoajIWOXDcFEQPvqE6CMAc=;
        b=WO1FvGC1S0CnDFWqGoezFhsC0zusRRKSf8EUOBg8kEkf6Qcu4a8k56hFJHR/QW+F8V
         NqXexDMWDZm8vNZlQNklhVKExizHejda5QUd2kDuOyOnwBJAFDPQqceQ7OgYqXhUKD9L
         7DdqCuzkwMXEkHjhLXsBGDd2JC0xp5Rj+iS1SdrAM48Z8NFCU+u2mIHmRmq1i+3rfHRF
         9qYj1eyPqIrERktpWOwj4c9p9VV+fxrfWgkFubQdLkjXw33NTBz9fPgEqUitvFhj7wJJ
         yxCi6ktOFE4YP3mAmR9vfve+4t6I6yXR6E6rJDzRF9cUV/YVXl2mMU6W2Gm9eVQD1Xok
         xU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769967368; x=1770572168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7F19pYJiRWTNPB9oNoCudWoajIWOXDcFEQPvqE6CMAc=;
        b=GzlSoRcgeXgNDwDhFCIgmJTZSSJDXGIrQCcJKHLBgojATpngyW1vezwvJErecKkieL
         3vjKzciasy8wfbuUQkiONVtrk5XzyFa7dn1Dey9tVPYiuMF/iA6zzgy+WOoWMJ4i5SW+
         CuxvKrrrLuq6qE66PpQR7IkObePe0WNIhoHG48wXaACHtVaupgnuLESLJMNfBRKD6lxY
         bTvdM0yFz3eWIaQqx6u8wQKr9uNecq8MtASkpHNkemcZq0CZbvdXVrYhAfC+ENgQQXNJ
         d0u6zrCh0oSRG1srzgH/IIRfFq56+oP8Z4Fil1ScVYnZ1+fHNm03ElAMDEIUczkHNXVK
         buyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHeJ08NCEx1gymEK71e4ZuBD2WTNehwc/UVqUbfEGHxeVt0qn7vyP7zDRkVQc3GzxtbYdwyi+Bn68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqUFVLRQYsysazQ7lRynmRQ94DR7dvhQ5b9QNEX2wshwBfsnis
	KVLAZ2dkVyytqDKvFs1/v9lbvrBQXZpBmmxzpveuzvdjkHOhM5bJy8lVJeeMLkusJ109Jm65ptv
	LgJf18avy69ExjRXElpIMDTpRasshmDSEFrydLajJ2320qAWjB6AXzXMo5WuGQA==
X-Gm-Gg: AZuq6aJCxK794qHTsemxYO0Z+My03oJuXD8itKTaWfSEc07LMSEdX5svOcdypc1G56V
	PDkueJmT4y8K1i+L4ySReg3BXKYsXk+g6/X7XzXQaRbt3ErPodkwqTzjvftG7cUdvo81mYr6mjE
	/oiEpDuZq7VzcVg5PAqYeXgOtz+NHm2yvs3B9SUlyqS2E4nB1bArS/72TlE/7xWB8y5cAR1yeLE
	2QX5F6UkuyBO2GUxmRU5o+miCpQYpbXPU4xghSE9IhWkNFjPb4ai9cQl8efid/3F4TGYDSd1oml
	UhQqSedJh8KZY3btUntbCmXb/M9Qn49SAJXEVUt783k9QJdqUgcADCLrvMO6KxL0V6yXU2owZYS
	Yykx2+vt7
X-Received: by 2002:a05:622a:282:b0:4ee:1e82:e3f4 with SMTP id d75a77b69052e-505d22c33fdmr114392741cf.64.1769967367852;
        Sun, 01 Feb 2026 09:36:07 -0800 (PST)
X-Received: by 2002:a05:622a:282:b0:4ee:1e82:e3f4 with SMTP id d75a77b69052e-505d22c33fdmr114392581cf.64.1769967367512;
        Sun, 01 Feb 2026 09:36:07 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033f0a8466sm82173341cf.18.2026.02.01.09.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 09:36:06 -0800 (PST)
Message-ID: <adec1599-ddef-464e-9cb6-5aec4c8e822b@redhat.com>
Date: Sun, 1 Feb 2026 12:36:05 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 07/10] nfs.man: fix a typo in man page
To: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>,
 "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
References: <OSZPR01MB777218E8A381E36AFFA041AF889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <OSZPR01MB777218E8A381E36AFFA041AF889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-18635-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 14B0FC6C00
X-Rspamd-Action: no action



On 1/29/26 3:51 AM, Seiichi Ikarashi (Fujitsu) wrote:
> Signed-off-by: Seiichi Ikarashi<s.ikarashi@fujitsu.com>
Committed... (tag: nfs-utils-2-8-5-rc3)

steved.

> ---
>   utils/mount/nfs.man | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index 94dc29d4..9a461579 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -557,7 +557,7 @@ If
>   .BR pos " or " positive
>   is specified, the client assumes positive entries are valid
>   until their parent directory's cached attributes expire, but
> -always revalidates negative entires before an application
> +always revalidates negative entries before an application
>   can use them.
>   .IP
>   If
> -- 2.47.3
> 


