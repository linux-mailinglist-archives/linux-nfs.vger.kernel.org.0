Return-Path: <linux-nfs+bounces-18636-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLtiLCqPf2k9tgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18636-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:36:42 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ADFC6C07
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC1D530048F9
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Feb 2026 17:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B7426B955;
	Sun,  1 Feb 2026 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyCzuJc0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ndo9PICE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988719EEC2
	for <linux-nfs@vger.kernel.org>; Sun,  1 Feb 2026 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769967399; cv=none; b=Ab6UtVM8qk3EyNAyYsMuILIoqfWYcYWMDMB8h6mNYMjhgXs8xAU8WkZeY39fYQwPZOclD4KAvKKOc0XYdOSAvxM7sNyha7yhm5A5mD6lWnMWW2y/YGedisjhk1uHIV7044a6B1YIzJ6mfCI3Rtl4Bs5jMnMSfTSL1rsTfB0RuyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769967399; c=relaxed/simple;
	bh=pxcsyWjauPvrOJLYt8/QVfRxvqwCEPaGcim9lXt3ELM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=noDDpKubhzDCTjhsqkAUrtumu4+jezEJGFCccfcb9q3D49Yh/7dveKlHpaTYrTitJxBawNHdBrnxAQP4tzgzuGFWOXLZ7IW27tuvfMNssxJnxzEt59WRCWCHENKggr+huCjj+23U4s6kQiXfMTOUR0ObBe2lSJ2dNWJg3d4MhTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyCzuJc0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ndo9PICE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769967397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsNGp+KNidFDZswDs+rLLgBGAm3a2HxoIb2i8/aXVfw=;
	b=JyCzuJc0Xr4m0iPcS9ZVUozNtW8/e0yrkRo9Skio6Nq+s3d8gx8wRhyZZnDuU4vlsPGmtR
	wKnxGGzjI3kQdtQCdzcJVziEah2OmpkN8CFhhBeoJK6LUqZeT+IQkXiabuxmDJjWQq+pW7
	XvnnuxF/ePq/kDc/Qi1oMv/CsV7TLEw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-385E8rm5MmG0rhX8fedkEQ-1; Sun, 01 Feb 2026 12:36:35 -0500
X-MC-Unique: 385E8rm5MmG0rhX8fedkEQ-1
X-Mimecast-MFC-AGG-ID: 385E8rm5MmG0rhX8fedkEQ_1769967395
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89463017976so29355206d6.2
        for <linux-nfs@vger.kernel.org>; Sun, 01 Feb 2026 09:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769967394; x=1770572194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OsNGp+KNidFDZswDs+rLLgBGAm3a2HxoIb2i8/aXVfw=;
        b=ndo9PICEKZECUAdoUkfbMtp/djWTwoX84N2pm7i3KBiEe0uEdELH19ce3EJaFo4bIN
         nCeZe6InJuAXvoneec5X0yk8WJfjv2wteO0lSF3gegocrDuXB5DjcOMlAlcpRcevxrmK
         H51A/b/MajC1c/POgN7sKdHsFp0ihf7zSp3KMeK8r134RvvdYA+cwO19dj3r1ihwaOTi
         pUZyx4/TzUEvBUJFuTjA0bnH92gnweZHK4ImhKjzbhFhPHaQM5ZjSb7APy8qaXQOacK1
         /PeNcCczBGEP08C34dbPt8/rkkgcP/Mbx81rNabYZZCY1gR4kkYoKLuwW4EZhMElepM6
         sd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769967394; x=1770572194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsNGp+KNidFDZswDs+rLLgBGAm3a2HxoIb2i8/aXVfw=;
        b=HPv1qlTbSl4t1KaoJ7mn8Ax2tBrtaQNPuS4Z0M2iINQ/sUtRkl43ezJLzyRit7932V
         BlIyASBQOvmMmjWqD0JCgb6IL+tbW06fZeP8Z5mADhknM9AmH6jiilTzD0zPs69ZnAXt
         8v/dwdsv/M4XKHJJIJdTVb3Bt1RqHsFtcHthW8Kr6vrnkp2jDPFYxQEcqiT2KUVXAm1L
         eBkqvKLno/IAQBNxq9mafU/jSKNRFEfxAv8yLCQUwj/iCMObB6YTMDzp4AeNZLE0Ocqy
         4a/yKZhT7imIVXNwdLUzq3NRjTi1qtwHaf8v6zJxnS3nr1UoN8rvN1LHE70HuJu4kGvM
         A9EA==
X-Forwarded-Encrypted: i=1; AJvYcCUtMB7lMFH/73CDBXYgVEvnlIQYnanw68gILbi8cXDFaR+CsD5+dhwRZLB+hiEzrQUm5uq1QAli82Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5nb/fzRxB/Yb1OPrJA1gUBPrwh0NXMs8gxFT7G6eENqtTI0Cw
	Rv+JO11kNFbvu6zDEfvhBGICkOhDnSCadFBnEGsPaYyFR5M8gI8Y6bTaL/C0SOtOWet+NYtoBIZ
	7ociJBrqy2WmU2iMozb8vh94jbuWasm82OdHlJ0hlU1sXo82G+S0DBpXLLnmkDVIZs+BOGg==
X-Gm-Gg: AZuq6aJcdV0+qgiLC1GZLcwTE/6xZD4r0XvQo0SK92E1h0GDHO46vpqfhy7xPofus9r
	b+fcSN3HQs3mnAkY2kRDZHbKXU7aj7YZLXa+D5YUHQumO8BW4ppg2+bP2fpRo7+YHmZrBV+Yc0g
	WFZhr0d9mfcrg0x7rf/jg5iRiLKtZlu0Aj1FxWrvCtXTWAHPETqDtiTFjU2YfgBGHyI9pyqgYKb
	W01KU03nxi5GO24uIFS3u5GweyAGMmViOlYZbYgoL5lhLzyjqhh7c9DUsMPznI9H+E3s+VcfpZ0
	E5jqzg9BhObGVMX0FzKyIkmGlNhxjBar3Bsy4JCzGcCZrRgiB6IVRzd84SbbzTJO7HmAsublzP0
	kMhT9MH0i
X-Received: by 2002:ad4:594f:0:b0:894:687e:3fce with SMTP id 6a1803df08f44-894e9fb740dmr136744036d6.3.1769967394213;
        Sun, 01 Feb 2026 09:36:34 -0800 (PST)
X-Received: by 2002:ad4:594f:0:b0:894:687e:3fce with SMTP id 6a1803df08f44-894e9fb740dmr136743856d6.3.1769967393838;
        Sun, 01 Feb 2026 09:36:33 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c515bsm96674926d6.19.2026.02.01.09.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 09:36:32 -0800 (PST)
Message-ID: <d6f1fe23-786f-427e-bdb9-42a12cae0e4d@redhat.com>
Date: Sun, 1 Feb 2026 12:36:31 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 08/10] mountd: fix a typo in man page
To: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>,
 "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
References: <OSZPR01MB77728D1012A50962587D425B889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <OSZPR01MB77728D1012A50962587D425B889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
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
	TAGGED_FROM(0.00)[bounces-18636-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 35ADFC6C07
X-Rspamd-Action: no action



On 1/29/26 3:51 AM, Seiichi Ikarashi (Fujitsu) wrote:
> Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
Committed... (tag: nfs-utils-2-8-5-rc3)

steved.

> ---
>   utils/mountd/mountd.man | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/mountd/mountd.man b/utils/mountd/mountd.man
> index a206a3e2..d14c7697 100644
> --- a/utils/mountd/mountd.man
> +++ b/utils/mountd/mountd.man
> @@ -55,7 +55,7 @@ The
>   daemon registers every successful MNT request by adding an entry to the
>   .I /var/lib/nfs/rmtab
>   file.
> -When receivng a UMNT request from an NFS client,
> +When receiving a UMNT request from an NFS client,
>   .B rpc.mountd
>   simply removes the matching entry from
>   .IR /var/lib/nfs/rmtab ,


