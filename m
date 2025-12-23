Return-Path: <linux-nfs+bounces-17282-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A678CD8328
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 06:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4EE530223C1
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 05:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E612F6577;
	Tue, 23 Dec 2025 05:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/39yZPJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A272BE034
	for <linux-nfs@vger.kernel.org>; Tue, 23 Dec 2025 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468315; cv=none; b=LvBPjpheMcetOWG86/eWv+li0DaXqQJWuxjdXC8yF7jR/SP/afZA5X0NN9XFc70Cspc0HNle1EScaJCCesSnbMpDbkwxY1SDfur30yeyLNNFsFN2MWDc/hWHcel5yoz7xZc4rB7rijiBU0Wa6EFdtsF8tGkxejT91LPtn7FnPUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468315; c=relaxed/simple;
	bh=zTV5Fl6uJEq6bikfRl+2GZKAfKdgBpPPlmOrmzDQ1Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csF18TT/X/TyqiyMGS8sP8ROdsnixTwNwYSyNoicU1keIg5za/lnyDwGQTCrbeX88LMmknKbSC3s99fXaEnyk120DPPKmJwV2GAQgyVccMHK4On/9hVmP0ztZKzA3Ls53JMvAaK7g8URjR4quBsihX6XP32mIi8/adfAC6gC1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/39yZPJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so4994122b3a.1
        for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 21:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468311; x=1767073111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2eUzqzQcRAv7TL9i3u7rXqYthkznBqBfs67/HNYTk8I=;
        b=k/39yZPJRd/lUcRJkV7mXQEWc1+ntOQZ3mgr8kFI765nq8VXzciXpYKgKPQG/tmkAM
         owjPUkIe3CFME/oQ1dh1e+schfxGr1GebTc60fpUHpvMD21xSXHx1R6rHRmQnGi7e77b
         K8gWq0Odf6lE5z7xabI1OfkODM0SiBVhCyDtkdpfiQCqP28IV5iuZ3X2EFOvRV2Gg7UZ
         OwnNQdnzXvu1PxMtIuBAX2FJOYDAFMzk3ZDVkCoSbErCXRMukkSvcsMp9nWx55EwuwEJ
         7Pdlo1cgbWzgOgds7F9Lpvihye3j+92iv8K2QF0XqTlcbb/5O/MwGRalD5ldn/b0XsSo
         WZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468311; x=1767073111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eUzqzQcRAv7TL9i3u7rXqYthkznBqBfs67/HNYTk8I=;
        b=vsFBLxgy4lgvVNGS2/9mP/ie++tjLqZQSSbVo3cUmLst7ZQMAxUHaZ88E3nD91QuY+
         hsqri6z41AXRqsUnpDnbHUY0DPJWhHJaeKJg4f7MgPIqeSpWX+OyGlf7o8zw31NhFe/6
         I8yVxmzsj8NhYb9xpSWlJubFtFR89y47EjBDmqk5xwl6Vz85GuN62pV2v6bX/pWjr2Gf
         0b3rIJopuLOxXDml5mrRMiJW3Q/DTGCw4GZ4JZiCXzXXd2HsVQ8ITJRo1FRYSpiMmDkM
         kGPgNjFmUqW5XZ/j2DncrQaMT+Exh4UNMkeHZ0E52L0G2SBFfdMCAZveF2ehkAVRP5E2
         4NBA==
X-Forwarded-Encrypted: i=1; AJvYcCWUcxRPD9NF9CpAYMYl0sJVYPq3PmVi810l5bgHBtKbheqyFYs1u5aCwGzGYPb5kxBfwMUxFa67UV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqi/IP9W9ZaKi584H5CnzAHV3qO5rlJ3UtmDlMcAHdWEgfX58P
	4EMM49fJMgJXC/OhDIJWFMtjhTG5IN+xSOeuk4lT4+5kgdn12zAiETs/
X-Gm-Gg: AY/fxX4UZyBj/t7ettp6qii8jHe8yYARjig7wJebpVryVQeCSce05O2KLcftShhnX1t
	IMRCpa0aY6D0Hab+RI066KDD6aE7MZEoLI0l2ODW8Zb4J5Low446FMDFELheH6RAkFCCu3+U6rr
	a6cTE5ZCX7wQK/h5U1dKTHTHGb050M3cCkHb9+c5XSa1zqA6DSOSmolFT+432Lh24Y5sL6ON+Ue
	TKio9+PlHl80rIGF283W9oRpDNf/2GMedoeqis/QgS8lBhUnjV6ZP+jhNxJcDd8ztCAAogQLAh8
	pFhLR7UyyRLsBv4ogtMqaJ57yi+AOCI7esC8mrycf+4UQZc+zQxO8OVn1u8NcqBpGv5aeU234a8
	yUkfcOuS+TTxM9G3PNiXA14m9Cjkdo2a6Eiw9jy5sXCGq3vku72pNGCIjPNyaByATGxfWrh3U9z
	lwuE4PAgy20YUOz1klfddkTrLw0O/+5Ab91wrqTilY0cRLnNhjnLj0ltji3jsdWeM2wCQWn+Dnz
	E4=
X-Google-Smtp-Source: AGHT+IFwAZOrVWcdz0GU+cDO+t7ewKrgjzgkHtOiGD0/poJQvRMMxSdMeBecD46MhF4AsSDjM1RyIA==
X-Received: by 2002:a05:7022:799:b0:119:e56b:957e with SMTP id a92af1059eb24-121722ac244mr18354800c88.3.1766468311123;
        Mon, 22 Dec 2025 21:38:31 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254d369sm56187439c88.16.2025.12.22.21.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:38:30 -0800 (PST)
Message-ID: <37febb65-038e-47a7-9a5b-3b4c2773994f@gmail.com>
Date: Mon, 22 Dec 2025 21:38:29 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] fs: add support for non-blocking timestamp updates
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Carlos Maiolino <cem@kernel.org>,
 Stefan Roesch <shr@fb.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 io-uring@vger.kernel.org, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251223003756.409543-1-hch@lst.de>
 <20251223003756.409543-9-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Currently file_update_time_flags unconditionally returns -EAGAIN if any
> timestamp needs to be updated and IOCB_NOWAIT is passed.  This makes
> non-blocking direct writes impossible on file systems with granular
> enough timestamps.
>
> Add a S_NOWAIT to ask for timestamps to not block, and return -EAGAIN in
> all methods for now.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



