Return-Path: <linux-nfs+bounces-17914-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 805A9D25B4E
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 17:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 419393028DB0
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 16:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A21E2749D5;
	Thu, 15 Jan 2026 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNmOV41x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79953B8D44
	for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493783; cv=none; b=KdPOqYd6o8/a232XRcUT5GwNp+dsKx4/SOxZFvW2/zU5mnfPEyu/yk5+cLIoDy3TgP18aRaxrzvhK/d2aqVwd3fGoRsXuS78FQsmzEuRUjwkdES8dciVjcZoJZQQTNCFzJb6eHZp+zm02Qg2P4bkZzKQCBq+HX+97szfFu1JaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493783; c=relaxed/simple;
	bh=UNn2ydvYfkiSKUID8DrpM3KCZV8HMSIAUFyrAarRhow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hizr0a5L1TYTLaekZBED3E3k3/xNzdsMDnHMMaz/O2Df6EvPElYlkXnb6Eo1EGQX0x8EKLbQF9LhvQfvfp65PLXojTyOqXrS6QCZGSoRAPJb6bSu1WEY5G9xYDFL4AkwXevJHp7flEGcRNIOATjC97c2Mkey2V4vO/+nMVdgLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNmOV41x; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so13600345e9.0
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 08:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768493777; x=1769098577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x16+10wOdkDfrHWNxPOSNNOdi8uy/sv/LgMtRngkNZI=;
        b=GNmOV41xDx74Ud/fk7tJ7Tla5Uq58dkk6aKjTkE7zbCRY4y58qB82UxpqbmqBFGxka
         51cBlNYc2IdhbRmDDUPC/TB1a44rZvVALb7xNOnHrq6zn9x3ZyX9XQ+fWI5BysZtft2R
         dtixpwLZ8Ajr86a8ahg1xbEyUXy6HnSCTzZhzQqRzIWKiIiaRlGCDc1dwADQ4yNMY1L1
         s9dcEMs9Db/KvoopupaMYaVxngWzsvM5gSgDN6R+ddY2CtS7EBI82SzJ8ddFdWjjMm8m
         FDO4HHLUECbAlMs+Y745+7dvGXGijPWPnioFaqNhmhry0Gm+k/ku3b5+34vYahzmvIJL
         YZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768493777; x=1769098577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x16+10wOdkDfrHWNxPOSNNOdi8uy/sv/LgMtRngkNZI=;
        b=lEYzOft3HwPDcr66QAeOr1zRHJV6fgAxkKQe3GyE9cCFE9itliJA7ZzUE+SRp5YuDV
         oD9VlnBpJebw1yFEBxUtcDirMbeLU5hVv6GXw4R5RiKZdH3QwPtCgJTJeL6rQ3L9/pEX
         E2fPsDdDHo1upTDz/gYLxB4K+zwr4xvrzbDdLCWGKirPjKnpL87vlhr3kv3zrvylFbQI
         6ghCotTaptP2Zb2QEHtvStNOq++axvFYd/YudPEIJBvMv9EgOoy8Cvj1cboHanPex0aS
         o2JiTZOSegogUv3MFO/KQLGQq4pBygGXYSw17G8LSJboN1FBglz3zHOCkAmfg2WtNg/V
         XMfw==
X-Forwarded-Encrypted: i=1; AJvYcCWke5QQR8WP85se2t/h2WWOF9cdq33xF3WX+NiJqADkiRZLBecw1gGJtycsQpZHeVYLdj425FqjW7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDWQF7me6VWwAGAQZfshZMxLUDTNd2IZQreFeaHHmj1PpP/ypL
	f8vsEPmSdl3zgemQWXcuMswxWu4nfmCMkfw6+W8q0DFIDUS9LMh0Qgic
X-Gm-Gg: AY/fxX7vbSOStm5/QfIIFlGJBfDLN9driGHGw4dWh4ZvOxg7HYZ1GfCHfvzivKDy2TC
	Ip9FmfT3RqQ9yYbzogQz9dNVa2TPmEJDHY0ENQuNiar0eK1wIbQJ2C5f4x6sxcyGH1cv0Vnob5I
	3aVaxXfr3xgaicQnjEBGyetuzzL2WipnCshjpWAO1e8WD02jUg6mYjSvLysks5RfzUrLzSwkLtg
	eu6OgI2WRLkYAXEO+UbPEknVzqiWeUaR5Wtp6fuKvAErXudJpWmPyxIWqqOnaTjYqMSZ9igAK7X
	316TgXrEmTeFy6mDMASHJBoISNzv6mv33nSxxAVCAXhEq7W8wkgOXcmqWtXFIKtQh1wQrZR0gfk
	ZXKRm11XGa3lMiWzd2ktrr5AehdkgV0mq0JRswB5mpNjOJqQ2oVz1p6HWpJWeCaXwFL+lOcxx5h
	1Ql2tgdvU2QMDpbRQ67kQIQd9XjSEPiIO3JxBSX7y1nphi
X-Received: by 2002:a05:6000:178f:b0:432:b951:ea00 with SMTP id ffacd0b85a97d-4342c55380amr8208611f8f.51.1768493776965;
        Thu, 15 Jan 2026 08:16:16 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434a4cf4140sm7021939f8f.0.2026.01.15.08.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 08:16:15 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id CA1F3BE2EE7; Thu, 15 Jan 2026 17:16:14 +0100 (CET)
Date: Thu, 15 Jan 2026 17:16:14 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Scott Mayhew <smayhew@redhat.com>
Cc: steved@redhat.com, hch@infradead.org, linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] Rename CONFIG_NFSV41 to CONFIG_BLKMAPD and
 disable by default
Message-ID: <aWkSzjcZywqC9uc-@eldamar.lan>
References: <aWc5dO3fP4J67x0H@infradead.org>
 <20260114145435.826165-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114145435.826165-1-smayhew@redhat.com>

Hi,

On Wed, Jan 14, 2026 at 09:54:35AM -0500, Scott Mayhew wrote:
> pNFS block layout is deprecated in favor of pNFS SCSI layout, which
> doesn't require the use of blkmapd.
> 
> Since CONFIG_NFSV41 (enabled by default, but can be disabled via
> --disable-nfsv41) is only used to enable blkmapd, let's rename it to
> CONFIG_BLKMAPD and change the default to disabled.
> 
> Distributions that wish to continue to include blkmapd can do so by
> adding --enable-blkmapd to their configure script invocation.

Tested it on top of 2.8.4.

Tested-by: Salvatore Bonaccorso <carnil@debian.org>

Regards,
Salvatore

