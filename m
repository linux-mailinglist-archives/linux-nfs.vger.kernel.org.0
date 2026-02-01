Return-Path: <linux-nfs+bounces-18634-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Mx9I++Of2k9tgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18634-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:35:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FAEC6BF9
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F44F300102E
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Feb 2026 17:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFF726B955;
	Sun,  1 Feb 2026 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="di/J842x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvgrP5oI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A619B5A7
	for <linux-nfs@vger.kernel.org>; Sun,  1 Feb 2026 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769967341; cv=none; b=rbBxlCd80YHQg1YXdvPJ0ERuRn3YWZq0kWaeINmfcjNvWYUwuajGO1Bu5C7z+Eypba/2nAvgv4ramisDLpKL1LD/lRDM+q6zv7bttKOi3KBeR5liq0Ddls93glUH40PLnYJFMoX5Gmx4LmomrGPAyT9BAI1yLLjZFUNrbzLqIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769967341; c=relaxed/simple;
	bh=x5CZ5ceQlHnQUFYL+UpJWkHsA0kLQ3jyYDOZ/Xz/lBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Aba+z6WpKf5qxWJqW39JzwPRat7D21QwLpleURyFc+cHhQ0nyJiaICwtAMc1qbZ675Uh6ZpmJtCi6MkqaZWjPBmavNQCo2LFaqbeJb1C2pMNiEejojBTBozz9A4ECgCUF+eNP+Vh5myzeNi1EXTH508Z7d2EYFiR6FlFsTdCbZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=di/J842x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvgrP5oI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769967338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3q7wiY7Th8mFhEfwAeQ4QxXiFfYpPHGoB0qMZjJiNcI=;
	b=di/J842xpyqbiNa8+ljduma7HkuLW26ClzLlPmDLQDfWCovyDrQEyfcPVusoJ0nc0lrS/y
	X5LXm9qpxHL3kUTnQ5iXbtbn8dbcDI8p3Pnzp/W7k3xTSjDBGDL5Y/Bi7S+C36Lka4hKb3
	E3DHZf7kz51d7eK5W0kQ45FIwyDUir0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-J2_62bnJP7i3Um16mvl2RQ-1; Sun, 01 Feb 2026 12:35:37 -0500
X-MC-Unique: J2_62bnJP7i3Um16mvl2RQ-1
X-Mimecast-MFC-AGG-ID: J2_62bnJP7i3Um16mvl2RQ_1769967337
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c70ab7f67fso1698160085a.3
        for <linux-nfs@vger.kernel.org>; Sun, 01 Feb 2026 09:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769967337; x=1770572137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3q7wiY7Th8mFhEfwAeQ4QxXiFfYpPHGoB0qMZjJiNcI=;
        b=YvgrP5oIabkbUvsigstPTucjqzULxlRrHlF4zQm2SYUxmSjNgQ55ZL3O+9wJwHAcv4
         eFm873iC+b/4fDawtbfq6yADQRRT/1WLOi6ptm8A3D/ZM7nv6OV5gCt7aPzXD7OIhxvF
         cVwfBHyWZTRLsteyVl95x24yYjDqyJd0vrPdnxc2itwhy4mXdkOjAU9nxSZ8MCaxu9xH
         Btg/fsQhai/rJ/PmbO8HL/XYD7/zaLyTWf1Wo0goA9XmncTmyY0eKwteauh+PQwv99Ro
         tNfHA3wtMfMKxY7GhAdhloJqUNWwk261IE/SRmEcHiFlPTcaZAZR/6PBxyUQBuSiDr8Q
         P+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769967337; x=1770572137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3q7wiY7Th8mFhEfwAeQ4QxXiFfYpPHGoB0qMZjJiNcI=;
        b=FNl3hL/3jC/H39+jD3Kxsj4SNqwBsrxEL+Cm/y+2bG35suKiq7PxrZQuhLCa2A7Iyz
         ps/FVo9KP4ya39vKhXFyD+EeXDuAL4U66BH5njUsPFBZ9FOMgVMrkTIsV4qCfOWBBXOO
         oM7ABBSXodKauvyWBEu5HXQkYP6vzSjLi22z7r5wsh6KbJm7q0pE1c8PkKpeIHoOWth9
         Ny5xSrXl67bkKJOUmfRqsBrizyC3v370gAEgjPmeRoEvpUBPDvkgmoLp3cmW57EJXzey
         hxuM7AKM5DI3/CP7nhld7s2xKrmT9nlGXFnjRiE8a+/d51VUWmaSvlh/mfkKB5L5ART9
         Ge3w==
X-Forwarded-Encrypted: i=1; AJvYcCWHZ39GEW7tWq0OOBgszrc6yudr6nbYkutYwBdtLxx5QSEmB9jKPH6xYJtLbwlMqmVCdXwdXcKz1LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymHfE/BeIAvJdch290++8hIo7vOLeYZKm6DDdXTeeUZQ0LoXKs
	LPeiML0V/6Lsbdgwtk+uJlAzivmOOQVecBf70xo3R1pF0Sh62vLfPKEEnCLMtvEDUP1Wtu2Tgsc
	15bLCsmTnylp12oSaDThh/1gUFT0u+E8DeiYaWWOHJhPSU0TITe6GgVHhVAe9Gg==
X-Gm-Gg: AZuq6aLQRdhcRV6tFfDhxwLeeTuTkvht3O/7ARS+Rfl4X1ynWZzY/nwN7wmbnmSgey1
	mp8fbpScudm/U7b/GWqBeFdehwR/jaxYUDz8EeR1EhNqfm9K+Lxb4bPF7lILSeExbtSI/rDtbJ3
	16D9DZyykkKbrwbtekIZKYPr/Tb8cBmkPuTOI9IX10HX5aUlm3D+TIJv50jI2xqJsK3uyVIQ7tz
	fwyYPiep1LgHZfiiwE31YRyYAT8S+ltE4vYAsRy1NN+hd6x5c9XKcraUJ+7ik8rKjClyBJbFoZH
	l5XZFTFmCiAQcPgQrtJ5ZDyBKqLbpuc+1QsjUhi+LRt6eCjj6vCG2MkwwPXjtPUMZZjbm6qKGyT
	9Ow45IVR1
X-Received: by 2002:a05:620a:25d1:b0:8b1:1585:2252 with SMTP id af79cd13be357-8c9eb1e6af3mr1233617785a.1.1769967337109;
        Sun, 01 Feb 2026 09:35:37 -0800 (PST)
X-Received: by 2002:a05:620a:25d1:b0:8b1:1585:2252 with SMTP id af79cd13be357-8c9eb1e6af3mr1233616185a.1.1769967336754;
        Sun, 01 Feb 2026 09:35:36 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c443fsm100769146d6.18.2026.02.01.09.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 09:35:35 -0800 (PST)
Message-ID: <be9f663f-aaec-4fff-8e22-7fa0ca340d36@redhat.com>
Date: Sun, 1 Feb 2026 12:35:34 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 06/10] gssd: fix typos in man page
To: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>,
 "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
References: <OSZPR01MB7772E5C0868DAFB0156521FD889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <OSZPR01MB7772E5C0868DAFB0156521FD889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-18634-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 35FAEC6BF9
X-Rspamd-Action: no action



On 1/29/26 3:51 AM, Seiichi Ikarashi (Fujitsu) wrote:
> Signed-off-by: Seiichi Ikarashi<s.ikarashi@fujitsu.com>
Committed... (tag: nfs-utils-2-8-5-rc3)

steved.

> ---
>   utils/gssd/gssd.man | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/utils/gssd/gssd.man b/utils/gssd/gssd.man
> index 4a75b056..f81b24cd 100644
> --- a/utils/gssd/gssd.man
> +++ b/utils/gssd/gssd.man
> @@ -190,7 +190,7 @@ name exactly as requested.  e.g. for NFS
>   it is the server name in the "servername:/path" mount request.  Only if this
>   servername appears to be an IP address (IPv4 or IPv6) or an
>   unqualified name (no dots) will a reverse DNS lookup
> -will be performed to get the canoncial server name.
> +will be performed to get the canonical server name.
>   
>   If
>   .B \-D
> @@ -244,7 +244,7 @@ This option specifies a colon separated list of directories that
>   .B rpc.gssd
>   searches for credential files.  The default value is
>   .IR/tmp:/run/user/%U .
> -The literal sequence "%U" can be specified to substitue the UID
> +The literal sequence "%U" can be specified to substitute the UID
>   of the user for whom credentials are being searched.
>   .TP
>   .B -M
> @@ -404,7 +404,7 @@ Note that this is unrelated to the functionality that
>   provides on behalf of the NFS server.  For more information, see
>   .BRhttps://github.com/gssapi/gssproxy/blob/main/docs/NFS.md#nfs-client .
>   .P
> -In addtion, the following value is recognized from the
> +In addition, the following value is recognized from the
>   .B [general]
>   section:
>   .TP
> -- 2.47.3
> 


