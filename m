Return-Path: <linux-nfs+bounces-19170-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKXGEBOfnWnwQgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19170-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 13:52:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D151873F2
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 13:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 454683051704
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 12:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5F339A81D;
	Tue, 24 Feb 2026 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bi9yidcE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/mQQt7/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC8F39A7FF
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937537; cv=none; b=I8weEBYHQ1i604kejdDLbuw2eLYvn302HHAQBA5k8m2fkuH40XgziAIlppLc22O7tSa6aqhG3KxJL43yPuJX98KwxujI9DAVdDkl2T0DrHkXf043cef28ZC+sRy771Z2olV3ENjmfojASoX40gg+qh676arSZY3oqO6HNDoiM9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937537; c=relaxed/simple;
	bh=Xu0MW6PHLv6SM2Gre5O763nqnX+HyGQsvYaPy8h74AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tyhud68PT8SEe39KL9fLzYIP+0RR7jaSFiUkQtisHt355kZdO5/Aryty/eXiq4pT2ppp39SlFzY5m/XySn+YI0o+7LX98tiEdciBhPkwu5EqoersLoxFMl7tpSeNhRX3BVAN33+RdV8cVc4haoJNOVq+UvQ8dNK+xlFExEDpzJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bi9yidcE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/mQQt7/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771937535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nunSLlrfo0aHIx2GjSNZyErxKKsKlHCvHB5gz5WdYoY=;
	b=bi9yidcEwRDfzgdAhxIxlPsMWquivK6b3nn2ifKc3c2CBEou3+XQaRQNt2a5sPuVHY9Ofq
	7RCa+hRMrva8cdrz5AtTQrazUabItez7ktDmE0nm558mVK70CPbdSpe1x3/eg+mZaxyEvN
	zWVjRTFTJ7JLIWL325k4Oj8wvhYK4Js=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-0M_Ra2u0Mr6Jcs1OQjU89g-1; Tue, 24 Feb 2026 07:52:13 -0500
X-MC-Unique: 0M_Ra2u0Mr6Jcs1OQjU89g-1
X-Mimecast-MFC-AGG-ID: 0M_Ra2u0Mr6Jcs1OQjU89g_1771937533
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50341fddb89so573609951cf.3
        for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 04:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771937532; x=1772542332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nunSLlrfo0aHIx2GjSNZyErxKKsKlHCvHB5gz5WdYoY=;
        b=J/mQQt7/atzTzfVVz2DpARGdGDxeBakO//TJrdRKiyyTfijdEtZf6x/ROOWqkfxnPt
         dOFqjzMY8v+Ss4AQXhKZp1MAAhm4WLNMOAcFlhn+fKlqWhp4G2Pj752PbetGlHS2666H
         1T8x5yOOv3ayQ3UMsiiTmhsZTULxmSYt588NQyj9IPeoquFdm0vsqMoJ0BcnRSbcB6CP
         eb4lyKCDdM9G+UFJj96jHqzQUrDduO/nWJCa+pyxx8HQWpuXeFFlwMxp2oMiidPz9b1W
         E2COhQf4devosbmLwmJcKHSmioXFMEwlaMT8FgaMVlfZRM9f8zYyJGcmffT3q9YV9u3a
         5h2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771937532; x=1772542332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nunSLlrfo0aHIx2GjSNZyErxKKsKlHCvHB5gz5WdYoY=;
        b=JGGjoBQ2h50EJgRVtORkc70ThGhDROG2/NZM3QwimzSrFgew+1+NCBhDPv4cS/mbSE
         F0Wb1Ks+eC08oIj6MnvEZrB+6DquhiprNKBSWi/cJUI2QeK/hdHZQgcimbhoy7oCEpfc
         LAtA63EqRTZO+5/fM1Gg+paeM09Fu1OrSJRh8kH6ys2F9sBCp1adU7WJ3EXoQ1WqVLTu
         ZDvdYGHYu7a+C3U6zWWNUTzRs7/22L+g616FRwk/GJIT5vvoB2kF6iaXuLeFi0ZN4Fl6
         bQsDfrgsF5+f37m9fg/EhboEstpz2/bDAIY9Y5HuJlxWX9+Bz2qvNt6UOhXC/+DfoTgn
         uzXA==
X-Forwarded-Encrypted: i=1; AJvYcCWbGX0IMbUvetP14f2p67442UOWZXHpCTptB0rv4P3tJAMZaMvNoNO8l/O3HhUThZECYaYAoVueLmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwyaVOIfxGnRxTeOTOtHiDzV1CUgjI3gtrcXC+Uw9cd/Qy5wV2
	l9grkJdX18kWTsOTOejtXAxnJ9bVTBWbbxZljAOH9mVzHBsFyYhG3B0nK5rD87b/PTqAl8E7aD1
	9wiD4woAL5nIpssogf9L7ronZUnFKeF5zvFJWaH7fTPgL7jXLf900tGKHqwvfbzKQdVBkvQ==
X-Gm-Gg: AZuq6aLU7THG9AVf5DoAsaqXw23996UyoYdfrf+kGHTDGRTEVudsgsJGNkkGS9G7Ezu
	VfLW8/965Wp+9ZLqkyYWm57K+c3X6kyROj5md5FhXkN3+7y+JwHv+I7eqNYp1GHP6hVa+gsS8iI
	JH4jj3zPPbxw5tvIX70K6jqYJ2Z+4bncOqCU4uz1/ro3OwOfNeMFU/wvM+2xpCAqfYSkgrQowjA
	9LLTMsbTOlWn0oE/71MzYa3jTlr2mEQ53V8BZJxxZde0hNrp8PzWsJcLiAJ2mVN+cRuwdMRmaZE
	TX80PJHkhsVz2+ihW0KtdCsJMFjuCnwWYSibcWNvObiIzojatVWiI+TlKL1JXNqWrVHAqR8r/HK
	ckX5JeL6I8uip4j5J1BlQ
X-Received: by 2002:a05:620a:40c4:b0:8cb:4cc2:c5d3 with SMTP id af79cd13be357-8cb8ca93042mr1533755185a.73.1771937532375;
        Tue, 24 Feb 2026 04:52:12 -0800 (PST)
X-Received: by 2002:a05:620a:40c4:b0:8cb:4cc2:c5d3 with SMTP id af79cd13be357-8cb8ca93042mr1533753285a.73.1771937532000;
        Tue, 24 Feb 2026 04:52:12 -0800 (PST)
Received: from [172.31.1.12] ([70.105.240.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0461a5sm1010717685a.1.2026.02.24.04.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 04:52:11 -0800 (PST)
Message-ID: <bed68038-34eb-4b08-92d0-06c2a1f817fa@redhat.com>
Date: Tue, 24 Feb 2026 07:52:10 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nfs-utils: mount.nfs: fix discards const from pointer
 target
To: Rudi Heitbaum <rudi@heitbaum.com>, linux-nfs@vger.kernel.org
References: <aZFwJmiqqLgWYSl6@1eac07209f0d>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <aZFwJmiqqLgWYSl6@1eac07209f0d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19170-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7D151873F2
X-Rspamd-Action: no action



On 2/15/26 2:05 AM, Rudi Heitbaum wrote:
> dev is passed by nfs_parse_devname to nfs_parse_... as a copy of the
> device name, the parser destructively modifies dev, so pass as non const
> so that it can be modified without warning.
> 
> fixes:
>      parse_dev.c: In function 'nfs_parse_simple_hostname':
>      parse_dev.c:89:15: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>         89 |         colon = strchr(dev, ':');
>            |               ^
>      parse_dev.c:100:15: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>        100 |         comma = strchr(dev, ',');
>            |               ^
>      parse_dev.c: In function 'nfs_parse_square_bracket':
>      parse_dev.c:146:16: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>        146 |         cbrace = strchr(dev, ']');
>            |                ^
> 
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
Committed... (tag: nfs-utils-2-8-6-rc2)

steved.
> ---
>   utils/mount/parse_dev.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/utils/mount/parse_dev.c b/utils/mount/parse_dev.c
> index 2ade5d5d..a6354bba 100644
> --- a/utils/mount/parse_dev.c
> +++ b/utils/mount/parse_dev.c
> @@ -79,7 +79,7 @@ static int nfs_pdn_missing_brace_err(void)
>   /*
>    * Standard hostname:path format
>    */
> -static int nfs_parse_simple_hostname(const char *dev,
> +static int nfs_parse_simple_hostname(char *dev,
>   				     char **hostname, char **pathname)
>   {
>   	size_t host_len, path_len;
> @@ -134,7 +134,7 @@ static int nfs_parse_simple_hostname(const char *dev,
>    * There could be anything in between the brackets, but we'll
>    * let DNS resolution sort it out later.
>    */
> -static int nfs_parse_square_bracket(const char *dev,
> +static int nfs_parse_square_bracket(char *dev,
>   				    char **hostname, char **pathname)
>   {
>   	size_t host_len, path_len;
> @@ -185,7 +185,7 @@ static int nfs_parse_square_bracket(const char *dev,
>    * with the mount request and failing with a cryptic error message
>    * later.
>    */
> -static int nfs_parse_nfs_url(__attribute__((unused)) const char *dev,
> +static int nfs_parse_nfs_url(__attribute__((unused)) char *dev,
>   			     __attribute__((unused)) char **hostname,
>   			     __attribute__((unused)) char **pathname)
>   {


