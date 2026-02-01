Return-Path: <linux-nfs+bounces-18628-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAjGETGOf2k9tgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18628-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:32:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A1AC6BCA
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3647B3001033
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Feb 2026 17:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EEC274FDB;
	Sun,  1 Feb 2026 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apelSEPE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+gKSlzm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AAB19B5A7
	for <linux-nfs@vger.kernel.org>; Sun,  1 Feb 2026 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769967151; cv=none; b=vGMP2d0EY3srWoLS6eC0n5eyKHuBsxD/7ZCRLiG/KI0mqSFJhv2RkaFqsv0aRiULL+DvEAFpF24eDNQ/GrS9bmDAx3zjHFxvRjuoH3sMyp4dHuU1C9tiubi1b+8hfBGvAk4wKp5HmYnR/XbQYR1sp85+bUiWrnTd4fHJ3HufInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769967151; c=relaxed/simple;
	bh=xR2YQxcHvX92MlTSnPErI5xlYzIpnnvn8/oPJQo4rZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ctB5UUEsJPtDAhxsUXeAP1xxNyRtIooCK7AFq8k+GasOyqvEz+tiTdGQ2Itk9WuAqBl5ej9kkGnDyTUNyG2qPHLKpyuez1jfBiRiyc9HDJisc8GA1Wm32/bSFyDAAmLluhIX+XVLkWh/FutUbQNbtn/gp4E8euHDwNHGY8WAzIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apelSEPE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+gKSlzm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769967148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESmAIAVSCg/XSvW/tc6YAjxYi+bWCOOJ8/ZOYCujC5M=;
	b=apelSEPE49AyEM9xRr1khF2aiyF6MiiH5BdGsooXil2kIr9+TPT5zTa8NnQJVxJO5k6tSr
	ul6D388c2tLgxl5OHrIAdAddxB8V/rIaS2uTN5iNkM7xB16OqKyLS3xqUNQr6mgc/o+GUK
	/g260EgAISgt07Z8zKz0BR+0H6djNnU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-To8h4ZzAPjGNuzS2FlbjrQ-1; Sun, 01 Feb 2026 12:32:27 -0500
X-MC-Unique: To8h4ZzAPjGNuzS2FlbjrQ-1
X-Mimecast-MFC-AGG-ID: To8h4ZzAPjGNuzS2FlbjrQ_1769967147
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89471437f64so145218626d6.3
        for <linux-nfs@vger.kernel.org>; Sun, 01 Feb 2026 09:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769967145; x=1770571945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ESmAIAVSCg/XSvW/tc6YAjxYi+bWCOOJ8/ZOYCujC5M=;
        b=D+gKSlzmsQ60WO+aklTNYWeUu0cYca1hfNLr+64nEAcYMoVbPu+6I+JOZLCmTypKkY
         3DJWrOZP4cWSR0xob1DfRXXQ72Svu2qFy//NNJa7//YQ9JiP6kLmrbc01ibXimIxWX0S
         hHFl5IFuEXCPn6uOy8g2h4/tkR0u6Gn7FQBtd7TWNg6+1entuiIiwDVAdzc1yt/Bl2ui
         UR5TwFe1oup0DjrWJ34uexaPpEmB4Dot5YvsLCagKtlhK8pKIX51AHHg/iwUnt2gKcle
         C7MGWzgc3vlT1mGYWTkJiLW14Ozb1z3aWEmRVbUJQQGhrHqg10fvlqq7MLLPdf16KJk+
         V86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769967145; x=1770571945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESmAIAVSCg/XSvW/tc6YAjxYi+bWCOOJ8/ZOYCujC5M=;
        b=q8dDzyJ4PpqdyGQT7/myBEXwK6MoocaxV1TupWt01jE7KUTZL4ufgSbj1GlTBBJcB5
         A3/IVtsgZGF3bXKw+ZsT9aVd6nBmw21JCVKHp5yb/GRtKjS0iiGYRKvkqgxhVWx1TN6y
         RCmpJ3gaD+HsADleUIgDmA6JGfqs11KNl4GihMcGiae7hYhca9dzgf61ezEzDJf+YidG
         AKeMPeCci2vgV+CUH05mfXsIOTGejRrXQlWUvUa7AMEd+s506hvXSOIw0O8ZaGU1UcA7
         W6eyGNt9cQa+Uhg/UuPOWfXK4+nApdFBI3QLohvosmJ0SNusOpoyJmtXS1PVc/tiSI2x
         CTdw==
X-Forwarded-Encrypted: i=1; AJvYcCVUEdAUKMwrGNv+8XlQBuT7EQQ6j3PAf3h72Zng5gawELbtlq6huatUw6WS8Zat72z2bCCZfWeqD0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5uLL0RSyo3uOHQ12cJp+e9Cz8NylRvfWd5wYpiG5kieJY83E9
	IceUaRZzIE2PAVFgad2BX6MpRvcVYDGX7fMUpWh5FHhgkt2JhFJa9zpEZQEgojsGqo2/j/686Bu
	7vyjvQTmqs3Wl/t6sSaRMI3sOw0lzFvv1Jw9XTLp+IsXwxPrwN2KeAmHHtDX4dGxnWO0lBQ==
X-Gm-Gg: AZuq6aLX82iFNEMGlNu8/yK0tnETmJnaYLEsvwjQdzaIKg8VFc/tRMo4jX4RwDVU/AE
	WvVCAN6xLyI5F6oj5ex9j7l4P5VMZprnqZKH1gC2nz/zURgrRt8tMXyoqzPQ0eTlB1/U0ctmwcD
	+/AOz1C+xHvjobaTwYa4ZhwAQSsLo7jKHQM+vPUYI4OlJ2bpmEp86IcPoof6fTZZ9jCXcrIY4Jb
	8iI2MNyMxqIL/koYvPA0hw/kZlt1mjtHoZQfkuWNjrmXDEu2AAOSSfZOUfHlr+Fcz5s/uyzTktv
	4aJKqQ2zDTY2bN9nCSQsoFNDkQlTlg8TSz5Imk/m+HSH6xnpzAofRjSD74JkV7tRHohkNRbZSl5
	8/Tfd0Lu2
X-Received: by 2002:a05:622a:48f:b0:4e8:a6f8:e3c1 with SMTP id d75a77b69052e-505d21854f5mr120931091cf.18.1769967145406;
        Sun, 01 Feb 2026 09:32:25 -0800 (PST)
X-Received: by 2002:a05:622a:48f:b0:4e8:a6f8:e3c1 with SMTP id d75a77b69052e-505d21854f5mr120930871cf.18.1769967145049;
        Sun, 01 Feb 2026 09:32:25 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894dae83f1fsm86007716d6.38.2026.02.01.09.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 09:32:24 -0800 (PST)
Message-ID: <ebd1c324-704e-4f39-bae1-9a3c3e2f728b@redhat.com>
Date: Sun, 1 Feb 2026 12:32:23 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] systemd: drop Wants=network-online.target for
 rpc-statd-notify
To: Dusty Mabe <dusty@dustymabe.com>,
 Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20260123143503.1342968-1-dusty@dustymabe.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260123143503.1342968-1-dusty@dustymabe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18628-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nfs-client.target:url,systemd.io:url,nss-lookup.target:url,network-online.target:url]
X-Rspamd-Queue-Id: D9A1AC6BCA
X-Rspamd-Action: no action



On 1/23/26 9:35 AM, Dusty Mabe wrote:
> Pulling in network-online.target by default is generally discouraged.
>  From [1]:
> 
>> It is strongly recommended not to make use of this target too liberally:
>> for example network server software should generally not pull this in
>> (since server software generally is happy to accept local connections
>> even before any routable network interface is up). Its primary purpose
>> is network client software that cannot operate without network.
> 
> On systems where nfs-client.target is enabled by default via presets
> (this is the case on Fedora today) then nfs-client.target will pull in
> rpc-statd-notify.service which will pull in network-online.target. This
> is the case even if the user hasn't configured any NFS mounts.
> 
> The man page for sm-notify already mentions:
> 
>> Notifications are retried if sending fails, the remote does not respond,
>> the remote's NSM service is not registered, or if there is a DNS failure
>> which prevents the remote's mon_name from being resolved to an address.
> 
> So I would think it would be able to cope with a short period of time if
> it were to start before Networking were fully online.
> 
> Making this change means if you are in an offline scenario (one example
> is an install environment) then you won't have to wait for network-online.target
> to timeout before the system comes up fully.
> 
> We originally discussed this problem over in [2], [3].
> 
> [1] https://systemd.io/NETWORK_ONLINE/
> [2] https://github.com/coreos/fedora-coreos-config/pull/3530
> [3] https://bugzilla.redhat.com/show_bug.cgi?id=2383585
> 
> Signed-off-by: Dusty Mabe <dusty@dustymabe.com>
Committed... (tag: nfs-utils-2-8-5-rc3)

steved.

> ---
>   systemd/rpc-statd-notify.service | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/systemd/rpc-statd-notify.service b/systemd/rpc-statd-notify.service
> index 962f18b2..821d4ea8 100644
> --- a/systemd/rpc-statd-notify.service
> +++ b/systemd/rpc-statd-notify.service
> @@ -2,7 +2,6 @@
>   Description=Notify NFS peers of a restart
>   Documentation=man:sm-notify(8) man:rpc.statd(8)
>   DefaultDependencies=no
> -Wants=network-online.target
>   After=local-fs.target network-online.target nss-lookup.target
>   
>   # if we run an nfs server, it needs to be running before we


