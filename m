Return-Path: <linux-nfs+bounces-17302-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F4BCDE128
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Dec 2025 21:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E1A23000B25
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Dec 2025 20:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2707081E;
	Thu, 25 Dec 2025 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSDlEwX2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD0236437
	for <linux-nfs@vger.kernel.org>; Thu, 25 Dec 2025 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766694406; cv=none; b=mX5bE/Krn2dI2XNT9SthO3nFfaoF8W2tFueOHdlJGwF0aEk/L+MvAhT/Y6lIYwUQj1c4D9mX5CfQEi2KGHJTpcR63z9ctZkKaeTU+WoLhJSeSd4RcprWTdEyA4cun0rgxlD0Xwu+TM+q9XVCIWLSQiM5MeZWAFXzvJZm2iSIRb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766694406; c=relaxed/simple;
	bh=f/pWxDsGm6iNL+tzvN4w/u58nrIH65DmufAfSXJaKL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbiYWgppL+SGl8s4rdu9iUnA4ksJqMQo5Q8n7f8J+wVpBc6FbUcKk7z2hHIdqj+h36Xd6a5ub2sJBcsjbTme9amoD1QY4EdvU5uyN9OKGU7B8mNERy1xDcFkMnG05PVxQna9cS2k4uW5xgRqePR3xVxSaYqu/fW9Ox94CS5sXp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSDlEwX2; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8886fdf674bso84280456d6.2
        for <linux-nfs@vger.kernel.org>; Thu, 25 Dec 2025 12:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766694403; x=1767299203; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/pWxDsGm6iNL+tzvN4w/u58nrIH65DmufAfSXJaKL4=;
        b=nSDlEwX2zVMxJ8KQvZ64+kVegO9lTQFWeBA7CdNwWs9pKQgbbHnw9SrfXUA6gtmPpp
         sHkENNMDKrMeNC2BDYuXyZk3cSlBViRUd99P0GndkMcqOby2odRK3TFTk4gj/ynahIpq
         oD2uxBcF8wRbnHGgqkCpHVdpIBFZwIzw1aAS6DYxP8dk96R+3l/2Ly/AigNdDW7r+agF
         FSWpPlyb47KcGdXyacqBR67pwN9yAaK+kTrT8hz7Y/DuNzlukb+jUZwv7OFlBGMnHeil
         wGnZgJMw33cW/Flk7TbgUcNZTuvKUVyoTGDAY+3cLZmo4LL8Ln9I0CiknQRr0nP0WuSU
         uTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766694403; x=1767299203;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f/pWxDsGm6iNL+tzvN4w/u58nrIH65DmufAfSXJaKL4=;
        b=mSvU1sHoqUnHRH9gXMOmqCqoJdpjKo896xSF+5rQaU8FzMW28sR/gRRDipz1QO8Ci8
         Bb91YSK+NY5dhrueDDT1OVpxfn6D0LgVORSNLxDySoP2gJWPcPDP5dF63iK/lsDlcXPf
         Lv0srYx3UdUkWpnZ2GJqY6BBpDhSaijh6IdUhzaqkedKmx2mhnhrc9F3SFWMOwhMto9I
         R8n36xUwbT7uDFa3gslZ0G0K094MlCJQ/8j47T9hKYqhRlCGtmKoGzhLNe+O0dC9m11H
         LzX/wZrAIdhoaDtqUSJDGEwV/IzxziFBkHfEbmOrq0WHEZhSF1g/Hq/+BjxUymM26Dhr
         vlgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3iP5uFGaDEiILFU6xzric7qCB4N+W7bEq6ZEKUFjbLa/P0n0w0VaP5lHwM2/dkjA3FGHRw05tXoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YysMcJVSMaZfWqwPDCYR5ORUmfq3iTQtk3bcNTIVnCr8+5F7FNm
	dHc2uwi/TbFlAl4+WtixE28Y67iODt0vcdZhSlPuS4+iBj/zc/1XV+qH
X-Gm-Gg: AY/fxX5fkbvNiW5xSgswyAtv6pqNVmlFDctVGS+/HvxUMl5hY3+3dCdvyOsK2lNrTj8
	oe5ktPWflkSNcUvAjTAYkhpk2q+Rpo1K4meAo47Z4Jzqx1N6eAxfmKCdhB7usyWCkP1Aa7/k5Q5
	msbK0+mBh+01vITXoO6OhrE8hskIXmADniDFUTjclseN/WS09gsap/z0jXZdH1Gq7l4oDj1d5XV
	kG6HXSGC/Jbafr5lqAJW3KOChxKeJ+OLZPAEI790s1ls63ZCnCuLK5XcfJldWLXWlQqX6dplAsZ
	uG5r1d4RuB7XIBN6665932XH+6jykOaGIS9WyhBI+wLw5ll4s0g+VWgfAaOKA+7c1JK+GfCMGQa
	EV5+8Ith44DZv46G1lrzhHAclcFsuTcjTD5LJdRTyFCunlIN/ifDULSgq1JN+9SQxVgpGRD4Iny
	KgxYt3o+74V2vMCvocV5qRtxjnaagjlvHp9iOdSKQ=
X-Google-Smtp-Source: AGHT+IHVgLBGKwwQwCHEWfVlR6NAjCURiSaDjCuFE/WFatXxz9p/ecEzeL64AEWyk03SUzWaheJy7w==
X-Received: by 2002:a05:6214:5d0e:b0:88a:246a:53be with SMTP id 6a1803df08f44-88f0c3d6261mr292997566d6.36.1766694403482;
        Thu, 25 Dec 2025 12:26:43 -0800 (PST)
Received: from SC-WS-02452.corp.sbercloud.ru ([5.138.214.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997aeef5sm157787416d6.27.2025.12.25.12.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 12:26:42 -0800 (PST)
Date: Thu, 25 Dec 2025 23:26:39 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Zilin Guan <zilin@seu.edu.cn>, Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] pnfs/blocklayout: Fix memory leak in bl_parse_scsi()
Message-ID: <eqm3olauhhzkg56aasaqjeb45g6kqfgvjvu55btvgd3nzreiq4@ooarvcqhbhub>
References: <20251225084526.903656-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251225084526.903656-1-zilin@seu.edu.cn>
User-Agent: NeoMutt/20231103

The fix looks correct to me.

--
Sergey Bashirov

