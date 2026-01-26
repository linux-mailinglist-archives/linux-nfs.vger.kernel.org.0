Return-Path: <linux-nfs+bounces-18471-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJGzMtlvd2m8gAEAu9opvQ
	(envelope-from <linux-nfs+bounces-18471-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 14:44:57 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B993890B3
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 14:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6CDF30707AC
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEE51E47C5;
	Mon, 26 Jan 2026 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwU9zjJQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rSuyoEJ5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6306C33B6CA
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769434621; cv=none; b=IqK+6GS6mhLk87Lbbaomfw28hZWsS5ZAYWftpCcI1rlQ4vDP8jNvbjxmEZu2PWUaSVednbDO/oHlpMWJQlUoSbh2EGn4MV09Dw22eMvW7u2Jy11nuik09qkVlh1D4AYOE4CcxFQG5E59gU5xaVu58x2Xka/ekxR4+CqMKg+b/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769434621; c=relaxed/simple;
	bh=GCL/E6HqfBGJ67+tt5CSebFP9SFDzJyr0sUt6LtHgGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c8xhHRd+zXgT2uuVGLAS7SVz1PSj6fyKwBZRXlfSalZ9IFTGuRHoq0zIa0c4ReTbGYqfAuPHEOnYgYX7G2uB5Nw1B3ALZXkkJqiZWhxo3bVyy5DjrZQRjXds7d3E8dstqLrkPSLhYKu3DIyZeB5tTRU3Aw8dswUETIItDplPLKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwU9zjJQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rSuyoEJ5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769434619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlXG7zrpXTv/UnzzGYGQKYHpvzM9Av2htGVIAV26Yjg=;
	b=JwU9zjJQ3TBao/ID6hQqs6fmMVnx5KneZzMEkxTCr2GpdY39gP5cRuxRaeHRPfeboZf75X
	+ligvZITK0HauRtf5a3e5bv+IU6nW1b+PYPYxvUIKVVlo9Ti78vXsHL1GhyqmOC5Ori1t+
	Puk3DbX/Esn/thXNVP3rtfKoHmkLoHM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-k67W9bZIO2OyBdU_ICb_Fw-1; Mon, 26 Jan 2026 08:36:58 -0500
X-MC-Unique: k67W9bZIO2OyBdU_ICb_Fw-1
X-Mimecast-MFC-AGG-ID: k67W9bZIO2OyBdU_ICb_Fw_1769434617
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5014ad65e3eso153041141cf.1
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 05:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769434617; x=1770039417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AlXG7zrpXTv/UnzzGYGQKYHpvzM9Av2htGVIAV26Yjg=;
        b=rSuyoEJ5CR1NqMh5erticSQM9yiTrHu1KYGVVTM3Elsm/rIPWAa4Of9uXCiZeqpMsf
         SNgdMmTiRLYYGXJHSvWEgv66jnGx1aapc/CTNRNSC/o5dafcCf0aPh0RkLP9RQyb94B0
         SeiNIQ3PfznQXVjbL1hwIDVKngxcU/YabbUZ+AfLdKIw6jwrQMXriwT//jQcqIvKcwav
         gfGS1EKIF9yq/c376s7WIP2dlkKPtfZCcWvCwaqlRIYkZ4aPyvkMsZB7yceK56aIXLnD
         oFfBLa8VBfuLJsr0Gu+ZTL5pyR+a4qr9ilA9siAkIFG2AoHYCgxhHDcBzrwrxJrD3yWT
         n+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769434617; x=1770039417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlXG7zrpXTv/UnzzGYGQKYHpvzM9Av2htGVIAV26Yjg=;
        b=GKGW+Jl6RiuJYdTaacdMR9g3d4TP1EAH0JmcHDxHfLLRRHXhQAYsVdWGW5TkBFT2df
         ITucg/U5oPQ4Q0t4zbmqLqIuLwI7M4iZuHCicV6AssAEEqo/86MDBsfvNASXHBajL5/n
         OokJ5Uj1HsA7JY9K7mLduawrQTYzoynYnFPxVvzSRiNHxFamLn0GDB93Sm2xfYSYF4hK
         +BdKf0OSbTDwRoGfMUo/E1XNmNprv16L/qVpKTz8OL5O+pBusnoPS2EIWsTcsVyWLtBd
         0UdKMKEGGtU4PlqFJz2dfVX6hHUo82dO9PVfNxkJDUqM00/yF/c/YFdCBUbSGuY8G1Mh
         tlmA==
X-Forwarded-Encrypted: i=1; AJvYcCUgDRLF5icTb9dr2QptOfOj+AeoQd5SrhFrkVzolCR2I8GSVZHdEwFRig5bJ8M0M1CPSV8faM95UC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+JAXsM575ijf6oHZTFiv6f62nygoCgJ4kGyuQHV1bt5SyY9x
	Tc3byEdPOk9LCw8Mpl7oV0tjtM1zjv/jQn7LYXEZurO9MGVfTVkBKLjmBNQBcrQTGdcgVfZCW0k
	0+8aNcYRxRznPdxUaNKTO4mrAu6+hxfN5/edIRZKk+ZgAA+Y+/O1DMcBRHeWJ4g==
X-Gm-Gg: AZuq6aIm/0guoKhBwKJwQgso7PIjCT3cTRykI/OhDruPDFlKCo53aKesGhHEJJgaJq4
	iq14eTzvKVcUgfL7IPbXRpLLyPMuO2xXMc37YWz8U2KH1idrLcTPGwClfaAEttoeIk6+yD8V47t
	asgDm88iDYzD8nkJk7GXGdhGsMorqoHLBGXqF/DgzlO/QD3aNFpxJ900sq3JT1WlgLy2nb/9NNr
	Oog7przc1AqZ9bic8sNEXblh7//vK1LKGAChkHLR73PZC7MV2zwo0O8EQUoNat6YGzQ+mvnu9k1
	xWEgTu7aeCZJFJM3bkDXwPBWcBPs4H5bGjgObgWsfMowLxhOJgdtJahGDbqal9ptI7c/A9vCCSS
	k+YOt/Eec
X-Received: by 2002:a05:622a:59c5:b0:4ee:191e:adea with SMTP id d75a77b69052e-50327536bd4mr10404031cf.35.1769434617640;
        Mon, 26 Jan 2026 05:36:57 -0800 (PST)
X-Received: by 2002:a05:622a:59c5:b0:4ee:191e:adea with SMTP id d75a77b69052e-50327536bd4mr10403701cf.35.1769434617220;
        Mon, 26 Jan 2026 05:36:57 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7e9c97csm89741291cf.7.2026.01.26.05.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 05:36:56 -0800 (PST)
Message-ID: <deee43a9-dc5b-4b9f-ba04-0ef2dbf0a452@redhat.com>
Date: Mon, 26 Jan 2026 08:36:55 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] nfsiostat: normalize the mountpoints passed in
 from the command line
To: Scott Mayhew <smayhew@redhat.com>, linux-nfs@vger.kernel.org
References: <20260122170358.1121341-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260122170358.1121341-1-smayhew@redhat.com>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18471-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B993890B3
X-Rspamd-Action: no action



On 1/22/26 12:03 PM, Scott Mayhew wrote:
> If the mountpoint passed in from the command line contains a trailing
> '/' character, then nfsiostat winds up printing statistics for all
> mounts instead of printing statistics for the specific mount that was
> requested.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed... (tag: nfs-utils-2-8-5-rc2)

steved.

> ---
>   tools/nfs-iostat/nfs-iostat.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
> index e46b1a83..69d24a11 100755
> --- a/tools/nfs-iostat/nfs-iostat.py
> +++ b/tools/nfs-iostat/nfs-iostat.py
> @@ -589,8 +589,8 @@ client are listed.
>   
>       (options, args) = parser.parse_args(sys.argv)
>       for arg in args[1:]:
> -        if arg in mountstats:
> -            origdevices += [arg]
> +        if os.path.normpath(arg) in mountstats:
> +            origdevices += [os.path.normpath(arg)]
>           elif not interval_seen:
>               try:
>                   interval = int(arg)


