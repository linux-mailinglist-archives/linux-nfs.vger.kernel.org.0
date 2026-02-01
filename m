Return-Path: <linux-nfs+bounces-18631-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBhKAIyOf2k9tgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18631-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:34:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5640AC6BE1
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF66930048EB
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Feb 2026 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F2326B955;
	Sun,  1 Feb 2026 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAabL35u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lxKz0XYK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E2819B5A7
	for <linux-nfs@vger.kernel.org>; Sun,  1 Feb 2026 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769967241; cv=none; b=MSDFquh48PH9s5y62AkyYSV/M86JmKafc+wAktykXFoSmAxgX2wm7UAvzd2ofNC1V0aimVWyy6QA9/Uo/N6PN4Ol/8u8VxtB6XptIGJ4LMMLM5XT3XzWhBsyKCkEvKLQ3eab1uNy3y0ddM3kBzMEtizY9MtjkIlh4M2OBNVmlU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769967241; c=relaxed/simple;
	bh=5Ns/8YzJTT4rxvBOjKH+fxVKlVFkOSmoAP10vgd6ha4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=soAZhI+u3sZTBa/C9YkdoJKNma4UUMWvvKx65MWUBW889OxUWcCJ8G/ahd58syXUDEjtfbwwiVi0ju6WDgZ+k5P9X8057mDRj7I3AXbhZ4lDAs/TC0/ehSGCEyazP2EkVnJU+Q2lU5+ZcFMkaEc1wwZGAP1GwHzcjv2VtOTowMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MAabL35u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lxKz0XYK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769967238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOscso+TZIrHQK9QQ+P9gMywZ6/wLD0hMAOhILdAieM=;
	b=MAabL35uvAI83djuOfIwMTb6vRsc+vFFCW/S2wx0TPUcx7f7BvIlv5IQoLDyQN+rttGdQM
	+D0KMQaiYgYQH4o1PiHtf01l0iPilX4AEvZSFGvQWqibXSKl8pNFn3fVwqGY6gI4S1Evmu
	JY9xeSDn64XIH4kOC+IHgztGhsb8Khg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-uH16TmX-MhOq_37Y1P5dWg-1; Sun, 01 Feb 2026 12:33:57 -0500
X-MC-Unique: uH16TmX-MhOq_37Y1P5dWg-1
X-Mimecast-MFC-AGG-ID: uH16TmX-MhOq_37Y1P5dWg_1769967236
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50335bd75bdso33078991cf.0
        for <linux-nfs@vger.kernel.org>; Sun, 01 Feb 2026 09:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769967235; x=1770572035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MOscso+TZIrHQK9QQ+P9gMywZ6/wLD0hMAOhILdAieM=;
        b=lxKz0XYK//o5afHwNBH0ZUZyP72v5mXJQNdEWPa+lYBgI01KrXu6gEQaTu6itwnnuu
         KLo/piE3RJ+c/f8JdT72WQiCb6jysuLsYWr4pZUqptEVE5PymsliwnG2autXXlhtBx11
         0TQYZcjPDgS2rvZK0t/qhdtF4fr1r4HXtu0XCwfJEOQm+un/LlsKG7L/og8f7qdlUoFs
         OlOt9zIZwqerEmvImhELdq4Z7BO4a+bVyoRL4r2mXRK3SZ2+lOXLQUS1NYCOoS9UbmKN
         b7Y506N4Q7YXkBYGvBHhDEy2Gsf4HccGrlr4tRHOpfmT/Vdl7vGeMB2b6R7VkhwTnXmK
         tG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769967235; x=1770572035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOscso+TZIrHQK9QQ+P9gMywZ6/wLD0hMAOhILdAieM=;
        b=bvBBV/o16tNCun39VwIQDtjpjz6joEiXSbpcDUr+1Igynh2CYWZVO6cpjIRMpL9qrL
         p98657bqYlK+Z3wRLgO6Ia+gpA4caq13JSKIn9FMep6ml4079sK73v+I+v/YW2erOaYH
         P7o3s+I6fu3Vl6cMlPhGXRnPl8o4dMSzb7mb/UCvGq6kwWheVmLUrckDHjuU5dCh2N2D
         9OtuMlS6Jp0vL2kUYzZArDxoC2F1TbbpMelQDugVTgw87+bgIsnhUxaViw3a/GvFioHo
         AJoMQTIUN5X+Ie9xaTcI6qxqlgDsTwKaWZjWm/BpAd0rePZdNxLKVY4uI3W8j9Vg2ZLf
         g6TA==
X-Forwarded-Encrypted: i=1; AJvYcCXg75d+TULkQvaH+mqSWZygw31GSsa2sNubkGcErepoVmuhebbyvgWGfCxczRSVormMdDvMBS6NjSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhIXH9pA7NYrHqDDDS81pR4B5rf1OkMUVE2c7Yq+2m4yF+fHt/
	e3P7+Tk78r9kzhHOHXQEkwcAc1cx5YUWvytmeC2MXHMAkj7tsTnz8BmImSi+sH2XH3rXP9nmc6t
	K0Bg+baEI+u/TiT18FM1gppUQm8Xmk621sYksBeOK+PI4KnMwMed9Drd8bBK97xXw5g+NuA==
X-Gm-Gg: AZuq6aLyFMLoNjZxL4eN1Hm4lt3sTz8sgAbPnHWw9aRYW5XgPdzEJo2lxqXTmF7l/6d
	3hBWb78snG8DMCp+AcdV9MF4DoWXWSiRVwAXDVC8JdgezONldmP83qfmpOV7cq7PqAPZgqvvHYH
	OXFXUVwsXTAbxpyBy2ictSyGN0CfaWaxNO3RXpMjdI5KfxzixutBU+RmPUMekwhtb0OwrYj4j3V
	yVpakZ01nyYmk/a+4DixpzZcbELebw2FrZqWvrtEV0OFl+JCaOzk2qSAcqm3RlGVOqTbTniC7rB
	pbJKNFF6ywLYOCpVDmtBfrH+ralbAhOWKg9B4KsgktcfP++9UJzE5qqmNzpOy4+NamLAJrmtD91
	6fqKfBCB7
X-Received: by 2002:a05:6214:763:b0:894:70f6:1694 with SMTP id 6a1803df08f44-894e9fb7b19mr150711516d6.11.1769967235372;
        Sun, 01 Feb 2026 09:33:55 -0800 (PST)
X-Received: by 2002:a05:6214:763:b0:894:70f6:1694 with SMTP id 6a1803df08f44-894e9fb7b19mr150711316d6.11.1769967235009;
        Sun, 01 Feb 2026 09:33:55 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36dd1cfsm96354026d6.25.2026.02.01.09.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 09:33:53 -0800 (PST)
Message-ID: <c84d2ee5-18d6-4bb6-8bf4-17858c1dfd4a@redhat.com>
Date: Sun, 1 Feb 2026 12:33:52 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 03/10] nfsiostat: fix typos in man page
To: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>,
 "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
References: <OSZPR01MB77728284358B24417AAA1D26889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <OSZPR01MB77728284358B24417AAA1D26889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
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
	TAGGED_FROM(0.00)[bounces-18631-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 5640AC6BE1
X-Rspamd-Action: no action



On 1/29/26 3:50 AM, Seiichi Ikarashi (Fujitsu) wrote:
> Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
Committed... (tag: nfs-utils-2-8-5-rc3)

steved.

> ---
>   tools/nfs-iostat/nfsiostat.man | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/nfs-iostat/nfsiostat.man b/tools/nfs-iostat/nfsiostat.man
> index 940c0431..104c7ab4 100644
> --- a/tools/nfs-iostat/nfsiostat.man
> +++ b/tools/nfs-iostat/nfsiostat.man
> @@ -9,7 +9,7 @@ nfsiostat \- Emulate iostat for NFS mount points using /proc/self/mountstats
>   .SH DESCRIPTION
>   The
>   .B nfsiostat
> -command displays NFS client per-mount statisitics.
> +command displays NFS client per-mount statistics.
>   .TP
>   <interval>
>   specifies the amount of time in seconds between each report.
> @@ -106,7 +106,7 @@ This is the number of operations that completed with an error status (status < 0
>   .RE
>   .RE
>   .TP
> -Note that if an interval is used as argument to \fBnfsiostat\fR, then the diffrence from previous interval will be displayed, otherwise the results will be from the time that the share was mounted.
> +Note that if an interval is used as argument to \fBnfsiostat\fR, then the difference from previous interval will be displayed, otherwise the results will be from the time that the share was mounted.
>   
>   .SH OPTIONS
>   .TP


