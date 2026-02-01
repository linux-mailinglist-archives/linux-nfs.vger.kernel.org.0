Return-Path: <linux-nfs+bounces-18638-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMmPLWePf2k9tgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18638-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:37:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA70BC6C2F
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DD66300138D
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Feb 2026 17:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3939822CBF1;
	Sun,  1 Feb 2026 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSPHctvk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDBuwuSA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB819EEC2
	for <linux-nfs@vger.kernel.org>; Sun,  1 Feb 2026 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769967458; cv=none; b=qIPSQrqkVboWy+ka79wvSzcWT5WcxASdsBHMV1en57K8M2LdrKwMtRZ168Qn1gjSeRV+ZDv0qVs0fpTfXITEXrBPWpMiQrzlvI0HKI4ykDWog0e37Fx4IdfWc+JJZChSTVdFtqodaWesm5n8c13r8F19JfWypGFU5xWoTGjm4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769967458; c=relaxed/simple;
	bh=L4mq+P9BJpEIMqC4bps2MUmU9YAWFW40dLYmgyDwnu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qe2WxKKcrzUkei77Bn/zlYBaT/v1Qb9aGleuDlHXsg8LIxsBClK4gMyUMxIC6MQOuCLbE7DFJyXZ58Q0oqjx/ZjbwMmIT40K+lklB9dJUXlbW/ZqhScJOHLsw23y+LpW8bjzQSsGOjMCz77oO8/fJ3AuwfE1Q5WM63sT9Z2SKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSPHctvk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NDBuwuSA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769967455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XUEngb8JOwVx8bA5ldAkuh2HZx8s8/KoLAgVfB89MLU=;
	b=TSPHctvkdWcAe18KOxT6TmfCD7WMP26EFjGshztx099PCd5nY4wp8SjWoCjwUeH0488mcZ
	WG+dKZpZqydwF3bXpfiVit41yhv4EpbhkbHELJZuuqjnPb6cK4jEaKgzEse5/mVe/ICtOR
	JqwG5q5b3nE+eiJRTqP7hm3GT4nRvKE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-kHJ6xAhXMOmItQL_PMmh4g-1; Sun, 01 Feb 2026 12:37:34 -0500
X-MC-Unique: kHJ6xAhXMOmItQL_PMmh4g-1
X-Mimecast-MFC-AGG-ID: kHJ6xAhXMOmItQL_PMmh4g_1769967454
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-502a13e3e55so124798771cf.3
        for <linux-nfs@vger.kernel.org>; Sun, 01 Feb 2026 09:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769967454; x=1770572254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XUEngb8JOwVx8bA5ldAkuh2HZx8s8/KoLAgVfB89MLU=;
        b=NDBuwuSAeSfLpPVSNLWymKH7WbwuUpqBhFu7JFlCXiVXHX+FarV1UGnk2fYc4fzMQN
         PmvfHD1lu4e2q98Lsw1gfyUE2YfoHlBu+K89MKpkkcXvjW5rzV0c3pZhLvZG4hmSdQJM
         nuuhDZyuZrG10gw/fbYrjOLPoTNSMbvQ/gHesAU1EfVU74PnmeHUXHI331ElxldNCCax
         qwwQSqNHR+Z8R0oNW13e18KSnqpmn6kbTB6bdiDhlYcULf4XgaXWmVi4WsN7zt+6Hd5e
         3TxKD9aOsBwLSxZKsnlS2QtIDSacimk9nlPgg4ODc6hvucINY7BmrhDlqkQS5FjlOSMw
         HfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769967454; x=1770572254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUEngb8JOwVx8bA5ldAkuh2HZx8s8/KoLAgVfB89MLU=;
        b=xGK7PS/g3xL/iJIb/WOiGlpYgs4a7GOp17ELaPqthx403fBvNzTZJGo1QTxAWe5YiZ
         JKqgio5+RXqj8W3wLGbHgr1+Fg1pQeRpmaMdbz6XP2b3/lhzqpQc/qDcYrQ3rJyuHGPe
         pnU/JuYXZNerYFBdQhLc3GIN6HDgFenCwiey0XdPKBUAiPIMY/xA9l7HFRrMSqlw6Wdj
         nrDnV8HidLAFC+ejFVeK+W5eM+0i92N4vjjAsZ5/mzJ2m40isu9UcDulHlQNJEAaxtSo
         ySeI8UyiotHHAqhwc84J/bVHXEYOACo197bFT8iWahAw1X6ygQgFlxbeA4Bo052n8C5V
         Ey1A==
X-Forwarded-Encrypted: i=1; AJvYcCV0rGaxMduyH14pVEpiiAHRiQKJIgAEw4R2Rsw3ubZv/TvdtQNeP03odTnOk1fRzj4H4Cnf+EzsYgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4yPn25YGXv/9NhaLMUIJb/tPbYpW7U8ELIgY1AJDVmBDgmtru
	/hhq2ud1Ei5L0aiHUDZT9fztq+biFo+zamIn4hS885roUrKXfTXNDx7q5weCe/1HpTYrrFZ3xuz
	6l06Xc5T+MhnWBxZbLJR1xuXDbsI9q0g7Atuz04qb7YMn13IkhY4RU57VfjsyPQ==
X-Gm-Gg: AZuq6aIV5Sy2At/T4NGn3sHrH1iZxthZoiZKxMvTmccVOp7X+ePSqPY+vA/0y8yFMvj
	7VpiBSW2+ApcxWe+Vew4jqISck8LG0MtjBlPa4yA2XFmHqbqmPve6C2PZfcVm1IOuNKAYLneJtP
	kAGdxomz1Y2BAllIifKU3ojyE/DUhqiFcVST/Mdo5XLB3Cb8bBgW5qWVH3hq1K1m76MErOGgssY
	tSrE4N2jJ+UU/GLJBdFHu+pxtIFFj8i15yKUchuMlFrgWuKphmRLSFv08loj68/CB4FIAUzQp/e
	PN/47kMg9tJV+nsJEKehoL1De9nW2Q9x1RooWVrxQ4DtXsl4rETKtp95aiUSpdZw/vdi4iAP/eF
	w3HqWtZI5
X-Received: by 2002:ac8:588e:0:b0:4ec:f697:2c00 with SMTP id d75a77b69052e-505d225efc9mr138859671cf.42.1769967454014;
        Sun, 01 Feb 2026 09:37:34 -0800 (PST)
X-Received: by 2002:ac8:588e:0:b0:4ec:f697:2c00 with SMTP id d75a77b69052e-505d225efc9mr138859531cf.42.1769967453678;
        Sun, 01 Feb 2026 09:37:33 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033746eec5sm96123191cf.9.2026.02.01.09.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 09:37:32 -0800 (PST)
Message-ID: <76122032-7464-4a7b-97f6-aa66095f35aa@redhat.com>
Date: Sun, 1 Feb 2026 12:37:31 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 10/10] statd: fix a typo in a debug message
To: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>,
 "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
References: <OSZPR01MB77721C055507EC2251B6FD47889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <OSZPR01MB77721C055507EC2251B6FD47889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-18638-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: CA70BC6C2F
X-Rspamd-Action: no action



On 1/29/26 3:51 AM, Seiichi Ikarashi (Fujitsu) wrote:
> Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
Committed... (tag: nfs-utils-2-8-5-rc3)

steved.

> ---
>   utils/statd/simulate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/statd/simulate.c b/utils/statd/simulate.c
> index 4ed1468e..4ff21698 100644
> --- a/utils/statd/simulate.c
> +++ b/utils/statd/simulate.c
> @@ -219,7 +219,7 @@ sim_sm_mon_1_svc (struct status *argp, struct svc_req *rqstp)
>   {
>     static char *result;
>   
> -  xlog (D_GENERAL, "Recieved state %d for mon_name %s (opaque \"%s\")",
> +  xlog (D_GENERAL, "Received state %d for mon_name %s (opaque \"%s\")",
>   	   argp->state, argp->mon_name, argp->priv);
>     svc_exit ();
>     return ((void *)&result);


