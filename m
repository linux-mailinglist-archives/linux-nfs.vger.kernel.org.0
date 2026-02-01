Return-Path: <linux-nfs+bounces-18633-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJy9CMqOf2k9tgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18633-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:35:06 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A27C6BF0
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF92D30048F8
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Feb 2026 17:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D0B26B955;
	Sun,  1 Feb 2026 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDHvcb51";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kxnm+3hz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AB619B5A7
	for <linux-nfs@vger.kernel.org>; Sun,  1 Feb 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769967301; cv=none; b=jmGFKI3vf+AR3hovn/cF/92NVQOQ7PJqYcF6Rbgzmuo1FebvDKazf9ffXba2J1Hih45PQZexPrqO/fGUf2j5C4YDaBK1Mg3A0BvHSd/me21KKhE7JgP1tBA4wabrY3AaLWZU5EYJPH3+fm2twGwoz+igeT6cNWkhA0E2agEIW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769967301; c=relaxed/simple;
	bh=1hVOyfZ1vZUO2ib+6Rx0/1VvysWftswNrhUURKDfLJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jYoE3tuBP3dbericGNL8K3vW75vVmsITGs/g+RD/I7rse+f4x/TPjrXo3Jsnp7aiWPt9wd3RLu6no141JFyy+uTYg42I6Ob//FdjhAFZZ95OrXoSlzyqeslOZgOIbXshpFdv6JjACaQFpsoVHsBWq67je50WBkviCVN/V/DeHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDHvcb51; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kxnm+3hz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769967299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACILNk5cOUILpWbvVjdSLDpQ1X53gzuexNfm1AQWHoE=;
	b=gDHvcb513BltPjy/GVF20x+xg6CtUCNqBu3hmv/YLu/smwdjdGtxioGAoGwdjTuFcgJyqj
	aCC/3Ou3J6sXaNIbJ4mcYIG6K+TBlk/OH/b/eSZtk0SXf0G9WMiXZ+Eg84BfgHbXWJU3RK
	Rpd45bDk4gFsmgw5S7cH0uX0YIAm8ng=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-_LI_cWqtN4CBJF9kNMw26w-1; Sun, 01 Feb 2026 12:34:58 -0500
X-MC-Unique: _LI_cWqtN4CBJF9kNMw26w-1
X-Mimecast-MFC-AGG-ID: _LI_cWqtN4CBJF9kNMw26w_1769967298
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8905883e793so119246056d6.2
        for <linux-nfs@vger.kernel.org>; Sun, 01 Feb 2026 09:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769967297; x=1770572097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ACILNk5cOUILpWbvVjdSLDpQ1X53gzuexNfm1AQWHoE=;
        b=Kxnm+3hzaJ23wwW8qQhCscaf+in5wylm3Qc2h9UYaaCN2yz8QS/SEht0zKZIN2T5Gw
         YGhETHnOcgzkyOt8I7RzHhOo8koat74n1L6HmeWNme2N6XiVj5n7v+/iypctxmXjv0GQ
         N82AoiJ4helq07ZIo6jKGQGgAhZdI8Anx2MqM6krOiNZnCmyBM4y2ie8J2ZZYIIxJGyo
         bmfH12hNSOM3wWKZNVFRxX5p+F5Xs6PuRwbls1+LBRLtXdvlcmOd1v+CAbNZ680LXT/j
         lg+/C0qejJS7CQZ3am6FasoMC6s49bQykaJmAJQ7WE2/k2cWwA/hZP8VLlBrwPFWaCGn
         5+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769967297; x=1770572097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACILNk5cOUILpWbvVjdSLDpQ1X53gzuexNfm1AQWHoE=;
        b=fIvF9KeT0Ec9UQwy5gicH2aFxsqCPxdvPU9+5RGe14QbI61DbshD7rouzC1UWI1/Ad
         h/5qCNEEWz9HeHr9oUuSwOgfQA1HmIZiFW7Sfp09Jo1s5PASLXSAu/HoxSviR84/1IVw
         IAtN+mdgFruBE6pp9XlfGapbrpDh3qdV3R7yMZT+8VIlroyOU3M19VQTDQ1O/rWm8PVz
         CNYhkM+jiIosW6D1FzWZntVSSWSsawmc8PccBilelLC6fxJhGBVOFFMGBF51PYWpc6TS
         iT4i2oGESF0IT9qVvbHCO9PpaZzW9HFUobI1Uw3Mj6tbwEdt9gMylLOTv0cRPxJllgCa
         Jqsg==
X-Forwarded-Encrypted: i=1; AJvYcCVAoMD8qR6x2U5xtL7exkGQLjiXcXVvhd9Va8HDq7zMtmUf/06m4AQ/4GBby2xrB9teS1t9yS7rdFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP+SWVfvY53V9T9UPKSU3uoYk5HjRPkP3aYE8fimBRuXeTSXSg
	KYOjRSRdNlDhYXHxJecq6Kocj7jOVFBPg0MiJfKURdAXhvVzbAD8Nk7eVyoqaf4vJWmytbBE/Qo
	pX7CDldWxXmC7FIHr3quqLHHjwiRJO2GdrxpCerFXs6mizGe/pqEG6c1cXnFGMsWlT4MPcA==
X-Gm-Gg: AZuq6aJqE9ZkQvhbxPxmFO+hVmw8M+tkwH2LVc950ojM68VoKfwcD9Bfvxx3qUHPiBw
	VREH/yZiLG19W3LGB9WHyGyXx1ExAL+tTEnBPLQ2xHqDiumnDB04tOwyy+6VE0zbucm7OaQ7G3P
	5IghXlnwHX+SEWcJ40ffT07AeCc8bXIHWOw7nZrRj9u00walKJ2BVNhRKGr8SlEIUBPhjjYWL9a
	RGgvfb5W02eBYsBxCqnMuaknLKsVncJ2+puvN2Qtr9P0mbgNEWuje5VUHfKBT22/Lr8ozirTayN
	4f/g9pKciVTPpLoM6JSvaHOSX2heA+KQGcMwnJHCjoQrDg4bp74PuGNKSDdHAZEnwLS5QnY3jSX
	BQ0OVgZ00
X-Received: by 2002:a05:620a:25c9:b0:8b2:f269:f897 with SMTP id af79cd13be357-8c9eb2ef7d4mr1106931185a.41.1769967297157;
        Sun, 01 Feb 2026 09:34:57 -0800 (PST)
X-Received: by 2002:a05:620a:25c9:b0:8b2:f269:f897 with SMTP id af79cd13be357-8c9eb2ef7d4mr1106929785a.41.1769967296746;
        Sun, 01 Feb 2026 09:34:56 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d28c71sm1106463785a.33.2026.02.01.09.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 09:34:56 -0800 (PST)
Message-ID: <9c4e658b-c01a-4a6e-ade2-d1df812a1c06@redhat.com>
Date: Sun, 1 Feb 2026 12:34:55 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 05/10] exports: fix a typo in man page
To: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>,
 "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
References: <OSZPR01MB77727A02A5B4351AD06FEE0B889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <OSZPR01MB77727A02A5B4351AD06FEE0B889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-18633-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 79A27C6BF0
X-Rspamd-Action: no action



On 1/29/26 3:50 AM, Seiichi Ikarashi (Fujitsu) wrote:
> Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
Committed... (tag: nfs-utils-2-8-5-rc3)

steved.

> ---
>   utils/exportfs/exports.man | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> index 39dc30fb..efbc6ef6 100644
> --- a/utils/exportfs/exports.man
> +++ b/utils/exportfs/exports.man
> @@ -488,7 +488,7 @@ option becomes handy. It will automatically assign a numerical fsid
>   to exported NFS shares. The fsid and path relations are stored in a SQLite
>   database. If
>   .IR auto-fsidnum
> -is selected, the fsid is also autmatically allocated.
> +is selected, the fsid is also automatically allocated.
>   .IR predefined-fsidnum
>   assumes pre-allocated fsid numbers and will just look them up.
>   This option depends also on the kernel, you will need at least kernel version


