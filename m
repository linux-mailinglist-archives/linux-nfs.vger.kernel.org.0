Return-Path: <linux-nfs+bounces-23252-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SOLZACBtUmq3PgMAu9opvQ
	(envelope-from <linux-nfs+bounces-23252-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jul 2026 18:19:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 422B874226F
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jul 2026 18:19:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=MOYYuZ99;
	dkim=pass header.d=redhat.com header.s=google header.b=i3IFGWNx;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23252-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23252-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEA5D30115A6
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jul 2026 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403ED286881;
	Sat, 11 Jul 2026 16:19:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D376D1D7E41
	for <linux-nfs@vger.kernel.org>; Sat, 11 Jul 2026 16:19:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783786781; cv=none; b=MrMY0DBiGNHJuuPf6LI2sQ/LK0rT1J6yJtO/eHRWnIEDiIudQFNENEf/GfsL3Hp92+XcevZtu4433+b2s/M0TuLTQr9xgnPw0ZZN3cInsQbzL035wrx7QINn7smpdS/HUaD05lzDwxgVKGMioTUtqLATyQkBF7p2FvlkycmLQx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783786781; c=relaxed/simple;
	bh=fWWyJx1Yxeaep1aqfI7osgA/FLAg2k8ugV+allwzu4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ED9QNaSsRKrtWBbwxiL5HgZgORHFCkWMLx3lwdVEWvmhZwZlZMRMuw7CbYNC/OLaX7UIxnJFFZqUExdsY+PbAxfua5M40/WN7ZnUDhDZ3ojgcMXnSqQoswvOlfxJVuSnvPUeilMaXXUz3/DksZ8lYlpbMjcpiBUb56Oc2Y6bZRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOYYuZ99; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i3IFGWNx; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783786778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VF71vXYal9txC/KQAjuDIXWoDSLbq9Upx+fbApb6ZKc=;
	b=MOYYuZ99iyOp1y3gBLdot4XlTmBpth9G/GazlBuoN4zOy60j8WLXY2kEZZwOrJ5gZEFkJT
	BQk9Wj0l37A1ED41KIdQnD+WMb2E1+IVcIPa5bAdX2OXNnjZMuBS6LG8cVQdzxgUCGRaoF
	oRuLcJ+2ufBTJU0CMksSL+gTvZE0vaU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-u61nWkKNM0Cil3_RXfcKKg-1; Sat, 11 Jul 2026 12:19:37 -0400
X-MC-Unique: u61nWkKNM0Cil3_RXfcKKg-1
X-Mimecast-MFC-AGG-ID: u61nWkKNM0Cil3_RXfcKKg_1783786777
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f000e221d7so25064336d6.0
        for <linux-nfs@vger.kernel.org>; Sat, 11 Jul 2026 09:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783786777; x=1784391577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VF71vXYal9txC/KQAjuDIXWoDSLbq9Upx+fbApb6ZKc=;
        b=i3IFGWNxQXGldxuCV78qknmCpJHwlEJ9nY671io1JoqF+vB8t+iwQsncvFCDBxFom3
         Rwv4Ruu89ivAdF514t41CCNJ3EpgHMnBcf7iiau2YXdAU6ym2reb5Ao8frPSxJHsZGgi
         LTuCmlSEqZXlTsqBZ2U1epoFr5wi9GXv7N2HwmKmQxMJRu86TG5rj54cSJ5Vk7mp8JSa
         Pl8GpuMcbFkNp/3ZeGfhfwQKTbWK4qEfGvQ8S46rVB+vJUKTl1qgIOHI63GKMGMr/b9V
         f420Ct+biCzRxQI19lm8WYi6cuA2PzJCggXONy7JJbrdEFJJd1aK0Ttp1bV5nSH1IgGX
         LbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783786777; x=1784391577;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VF71vXYal9txC/KQAjuDIXWoDSLbq9Upx+fbApb6ZKc=;
        b=i71VS2LCQNKGZRQKNrscO4criCli0rcW/zNRCLFSs/YSjrsKv3qivs2Ew+Pcpn5wQd
         XIcb+2MLumjy0R9ieYfiT0ReLXmRCD90FCPlHHoyhNVlze2JniibrOT67WhNgLZv5u39
         9kHNorgThFUd7cvQcuS45h6ek9QSp5dyC5gLc4wXDt0yM0+FgSMuqaXbo5zhR5UoX0QZ
         5ZiZTgS/VKRMUu+70h6/sEeW7r7f6Q0l/c1qXlRjOgT75rsBk0X62MHM4oBLle0+glvH
         DNg9w+RvwEXnZyRC6L/bkCQota+2ETKaC5tkFjilZ3uVjpY8FAO0Faz/QtmHvNwMARUS
         5UoQ==
X-Forwarded-Encrypted: i=1; AHgh+RorlExXcCRhPm+U6gdnILUhD3zOHZtK7CEZufr4fr/KvgCIEOLZquOme4o5NHqo20ZHX8HcIf1L+Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSIwnKM8pEDGxrk9RuG+hA9J7x/DmI1L/Mq15R2HXvh4WSsBxM
	iglVJOzXrOnrtG2SOV1vEtyi7tv5KV7gpwvLbG9dKniP1I4hO6ChEvgTV0lDrp0H15yhft7BTS6
	p0TVIbWsRPRjxoomkK+pZxPzdb5ZbGcef4TjNHcTHUx98mSGm9Qp3Ti5HrKLrxA==
X-Gm-Gg: AfdE7cmkasgm68BNDKQVWgCG33fKtDUef9QnSImFM3algg3T6OZdKFm5qesrBmQArVu
	O4JKydI3seR8Vow+0orVcNIGu5dyozNlMijcmSFC9v6m+9arHef+Mlf7oCkC7A+I7FI/D2Z4Y2G
	ww/A/4sbxptiqWzPWOzCXNIRscbqMDwqkn9m8loYCa/vYtSfEwIosr32ZgIHq0ueIYU7PenxGd0
	fF7OQr5HiY7RSmDc/yHPDSTwjTlOx3dYJ2/wAfMvprO+D5mcs7FJnw+EN1FwUCEoCQxg250cPwc
	cOMaF8AvX10R1rxXTuTQud6C8kY8hWradJj379ENCHmq72Q35y6Q+xhSnnFuMd3W0QrW2VprsS1
	H8sswd0+jSw0=
X-Received: by 2002:ac8:5a0b:0:b0:51a:ee21:d342 with SMTP id d75a77b69052e-51cbf1d0bbbmr29406561cf.20.1783786776823;
        Sat, 11 Jul 2026 09:19:36 -0700 (PDT)
X-Received: by 2002:ac8:5a0b:0:b0:51a:ee21:d342 with SMTP id d75a77b69052e-51cbf1d0bbbmr29406311cf.20.1783786776451;
        Sat, 11 Jul 2026 09:19:36 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.248.123])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf621e6sm37969431cf.24.2026.07.11.09.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 09:19:34 -0700 (PDT)
Message-ID: <9d47029a-ab46-487e-adc1-bdd301b46cf2@redhat.com>
Date: Sat, 11 Jul 2026 12:19:33 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 0/3] mountd netlink fixes
To: Scott Mayhew <smayhew@redhat.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
References: <20260707205752.313031-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260707205752.313031-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23252-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:smayhew@redhat.com,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,configure.ac:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 422B874226F



On 7/7/26 4:57 PM, Scott Mayhew wrote:
> A handful of fixes for some issues I ran into on Fedora Rawhide.
> 
> Scott Mayhew (3):
>    configure: update check of system netlink headers
>    nfs.conf: add no-netlink option to exportd and mountd stanzas
>    mountd/exportd: disable netlink when falling back to /proc
> 
>   configure.ac                 | 4 ++--
>   nfs.conf                     | 3 +++
>   support/export/cache.c       | 7 +++++++
>   support/export/cache_flush.c | 1 +
>   4 files changed, 13 insertions(+), 2 deletions(-)
> 
Committed... (tag: nfs-utils-2-9-2-rc5)

steved.


