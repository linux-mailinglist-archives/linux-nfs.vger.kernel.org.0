Return-Path: <linux-nfs+bounces-18637-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKKlKkuPf2k9tgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18637-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:37:15 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B7C6C0F
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B82743004C49
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Feb 2026 17:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529C722CBF1;
	Sun,  1 Feb 2026 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvC/PD5B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TD9O93zR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92A219EEC2
	for <linux-nfs@vger.kernel.org>; Sun,  1 Feb 2026 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769967433; cv=none; b=E0bj/Ly3R1NXLSC+SQ4cjd+k4p/stR3VF56M5c2ZhPmTauuX/l6gnDnNeT7QFL+7Y6T/QU/lQ6nc110B5PNo8kNpbJc+1QGnogoZjcfzisQZt47PoRSbCn88F7zPN7B05zvFM03QG8fTzb1UE74IyKeJmD/b1s2KaFNY0wP56d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769967433; c=relaxed/simple;
	bh=JbMZ8JiQLaQ0farBHJ/x35eraEWskvLUzqWJLqT9pb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VG5SfaRuxuPqck8Q2dJSxM1OeRsjCpZ+QYHobAEtUXIxsnS2IEHItDCPgSIBU7EQkUUd2I07vIRVDjAQuRUp5h/Io53qoYxrcBj4cR3l/FVkdeCpugs4A+EU/rBc+6YiviimA4GXxYppRD8urNOXJtrjsHlXbXvRx3NorjWTzHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZvC/PD5B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TD9O93zR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769967430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=669oSvnCo7OAJ9yQVfeZ8KuRpf7TzeBoDom88kj5NUM=;
	b=ZvC/PD5BV2L2wipnBi8S5s7cfX+56KG85PbL1YRq33SqBZAaAU73WAx7CjP0qxyEWTJhFg
	f2/aq+KhLTqk2APIVWYoFz+b3hWmx9bjeJgFHwBEK0jKxmx5WrRCTY60QsRHbnfInMZgww
	n88c2cYsHFJJymVQHVandreavP8i6bc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-DBDHkyzoNaaDUUZjJUUjqg-1; Sun, 01 Feb 2026 12:37:09 -0500
X-MC-Unique: DBDHkyzoNaaDUUZjJUUjqg-1
X-Mimecast-MFC-AGG-ID: DBDHkyzoNaaDUUZjJUUjqg_1769967429
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5019f8a18cdso124627191cf.2
        for <linux-nfs@vger.kernel.org>; Sun, 01 Feb 2026 09:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769967428; x=1770572228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=669oSvnCo7OAJ9yQVfeZ8KuRpf7TzeBoDom88kj5NUM=;
        b=TD9O93zRGQML9v8WnfkChf6HqnmGByiFi3tqwGmIBk02gordH4Nqw/nrpEi5RAcrGL
         H4KUIs+ltOA2Cg22nKLAB9ZGjquw7wqMkEO70w+a76/47XQzBkhKK7xUNOPEXaKscmHp
         BuZLTU/sGM2j4/O27JP+RdaM+hnSB6VH8aqLXuhLwq3ty5RyRQFruLIb9Y8+dUyWRdVw
         FY83QAdPNnF6BfYPIzWfEagIOcjnj1MEU7WbcNrVThGHobc0bF4gO+b+wR/+zWenMdba
         WceKVD0LEf6l8AZ8JwvIWolN5r86TJkVCIXxxX5x6YazJvV/hAVP+vpdR67Gl1FIPCat
         Llrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769967428; x=1770572228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=669oSvnCo7OAJ9yQVfeZ8KuRpf7TzeBoDom88kj5NUM=;
        b=rAMp4jE8Mb+yD6grwUTIEe5B4/3qQC9KXAN0CQzCzWODluvfSoU/vRU8jKdfmwqsL2
         Njt28lN0H01m6hEyhO/oqklHh2vz+9lLufl+Ts9Z09n5fOx09zl0EuKkbXbRtBKU4ZJo
         FQaXkMWu3jJmj2d8uT3529HxNjeA3T7jvLmgyYrgyNhh+7AJ7ZZD2gA1DMkG88T6JHtM
         wZaJLuS5T7KnamIcVbmhI4PH9VGFWrvKUz+4fkHttOyo6Bl326z8oBxEqCr56tmchPt4
         0exmX/WIGzruAM9Y2geHtjepGl23xnAQeXuD+DvRtExpPQtmekfpz8A3xadzMac4qjh5
         4QcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtOULwvKndnrVxg0FB4TTJA2MvOxOzHtB+Sh1ExpDf2nOamJDEqBh6A04FgjtLLEKM2Frbxax9nxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP7Q9j3YULm6T2qdbaUU0Bt2EDhIyyZ8+qABNRV1X/7N/nRe6N
	yfcDKfSsJuIZeST2MmKE4VsB6+CeiGQgYnSPY1R4CjZusG2d7gyshX+1/dtrp/6JxrdzfdK5chS
	00aiI4LRxvIF3q4KemkpU/gzi0xyCkbtoQ7Eyqyv/W4Xd0HO8HTxHdr0qqAUQJQk1A+QEeQ==
X-Gm-Gg: AZuq6aKiQGyJWOQuKdX2VifXHg36otWCDF2zwyxSenKaTM/OFPIL02GEnemLYiCnmx9
	OD6hkHxEUUv8VqvcrTW24jJvrLF4+5j/lasah4Bq/f0UXpax4M8kaPHwgf04sCZAHFTDszvibew
	rEE6haueSJmZdWwR0KSOGO7jZ1l6m2kqc//RsJmv86lKfVgE2rZ1STxpM1D+UAGHSlVZjakCTj6
	Gp0OygNeGIHjl0z3LIoksW4eWLCnSR2FvyG+zPypPQUsM7ExsNCAwllzokF+wuzeJ17MGGNojB7
	eOEo4YyWFQlt/8SAzTeVI2FEsT4AvRXMnDjPtK8pdgJoXUy4USNMlmO9RpmHqe4lZRkFafz41vh
	FRbdg2Yh6
X-Received: by 2002:ac8:57c6:0:b0:4ed:680e:29d2 with SMTP id d75a77b69052e-505d2264091mr128713091cf.44.1769967428332;
        Sun, 01 Feb 2026 09:37:08 -0800 (PST)
X-Received: by 2002:ac8:57c6:0:b0:4ed:680e:29d2 with SMTP id d75a77b69052e-505d2264091mr128712941cf.44.1769967427984;
        Sun, 01 Feb 2026 09:37:07 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d5c34asm1049716785a.50.2026.02.01.09.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 09:37:06 -0800 (PST)
Message-ID: <9cd0b0cc-feb8-4246-9c51-6eb4e19bf0d7@redhat.com>
Date: Sun, 1 Feb 2026 12:37:05 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 09/10] nfsd: fix a typo in man page
To: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>,
 "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
References: <OSZPR01MB77728AE530C27FA2DADE411C889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <OSZPR01MB77728AE530C27FA2DADE411C889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
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
	TAGGED_FROM(0.00)[bounces-18637-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 0C0B7C6C0F
X-Rspamd-Action: no action



On 1/29/26 3:51 AM, Seiichi Ikarashi (Fujitsu) wrote:
> Signed-off-by: Seiichi Ikarashi<s.ikarashi@fujitsu.com>
Committed... (tag: nfs-utils-2-8-5-rc3)

steved.

> ---
>   utils/nfsd/nfsd.man | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
> index 6f4fc1df..26eef607 100644
> --- a/utils/nfsd/nfsd.man
> +++ b/utils/nfsd/nfsd.man
> @@ -43,7 +43,7 @@ NFSv4.1 and later require the server to report a "scope" which is used
>   by the clients to detect if two connections are to the same server.
>   By default Linux NFSD uses the host name as the scope.
>   .sp
> -It is particularly important for high-availablity configurations to ensure
> +It is particularly important for high-availability configurations to ensure
>   that all potential server nodes report the same server scope.
>   .TP
>   .B \-p " or " \-\-port  port
> -- 2.47.3
> 


