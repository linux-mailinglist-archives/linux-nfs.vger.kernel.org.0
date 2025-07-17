Return-Path: <linux-nfs+bounces-13129-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271D6B089CA
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 11:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D1B565C28
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27535291C29;
	Thu, 17 Jul 2025 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ejkt5jv3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62663291C24
	for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745889; cv=none; b=brjYyNeW3MFzMufxMRuKXgtT2yG3hStEGvVCnCHBNw6ty7EGgvTnTrsxrtmOUUaFb77ImsTV+ItrU3vMXeR/uEze8xK+VtkMxy/spF7QKI9peYZXV5vg3Paz+dmb9QvKgEon4pjOrmgt9vVj89AlLI3QaLUThiUTb3uupdAPmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745889; c=relaxed/simple;
	bh=xGjj6rCV39Lcnnvi/1LW9lZJrXMy3MTtRSwImv99cYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMwHvteIJvB1rgjfzeEtPyLpmc/hE8tyM2ln99f6AiF1EVQhqjFp/XIpEwWg2LwB1IJur/B7HnLKqQbYAY79TMXNq++l4Vdb95lyPYLtQRqNCwpZGucthpfFbAvRaIjh47SX14qkDYzYG7qC8biM0vzsR1TR3uosR4Zy6F5F9BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ejkt5jv3; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55a10c74f31so827392e87.1
        for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752745885; x=1753350685; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGjj6rCV39Lcnnvi/1LW9lZJrXMy3MTtRSwImv99cYQ=;
        b=Ejkt5jv3E5C1CchJvfQcHSQV739DsUwsyqOat4kTxQRhucm3apllEVZz3b1L3CZJLd
         OpGpVtnzrsFNoBTM1I0Oo6mEeH4WPCsqXviUweBRb76w31iGJXADigGSGL+MbAzkdA+w
         DJLU35XfD5ghh9ebBg3V03A37gd3FbdA7x0Qo1CLpLlzvzznfWxTSgoIBceFL/Nx14h0
         v83m15Rkceg/aVf2NxfkQlmdvR3aYeMmVhdvICyErzmU20qTXPjFILCD2gDCDIot5zRD
         33NymD8CmsnK/jIkXMx9XQz9X8lRXgOa7RarbITO9yl0g+utpARFcCPkg0IIqiZ8U5kO
         ZLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752745885; x=1753350685;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGjj6rCV39Lcnnvi/1LW9lZJrXMy3MTtRSwImv99cYQ=;
        b=d5/OpWRNbKrwP5pxlPZmlBSDRvhFghDymcuSG5hIdjnBRDPCAbqC0DaNIGKMnczD3K
         AzKl6fF0itK4zK7ThikkGqFM0rNFRsMY3fU/Y46HDKBTER5kadZ3MRRv4EVtwmrJqTIz
         oztgfsJ9F9V47PUAfRIK1aFKfo+eEbYqwGzyzL2Z8c2ii39UmisBllX6jCmQVdbU+TSe
         VizyrT97cbo+ZVxWqzwXALFl54x5ZAkb1icQ+bJUb+++RorWyDGIe/CUUbb/JAUjsnjW
         GkP+OnlzUyW461S3/y2H0XzNuLvi7DOC9lKAI7MoTRgdy7lUyJDYtnK/Px5xf7CiyuMW
         VHMg==
X-Gm-Message-State: AOJu0Yz7A7bLYG2Pwf7S2Jydz5OmafOMe5FVrKwKjrBcoqmXPKUlamxc
	B93/iyXIU84trfJYLJ0D+7mNjnfFbRezhLOFbEPZF8mbF8zn2DHK2QgF
X-Gm-Gg: ASbGncsFQEaBqRrmA6snmr/IUKuOT+6nusdGwbAwotWSSktz3XHCNqy9GwUeBt8wLMa
	mQwjIm/ouEP6XVsserL2sTRU4Tn1ZXDYo/gdkciYwnmFQcJEW36nSxCNqUUOdGZ0ggfQwzZPE4B
	NweWC4aMF0LSgc/MFTmTrmMewaNbVdGsMXECo+mxZZKVn5YoCI86aujinvta9QondNdmETh2+Ac
	yDbEqdbrBL+e/wP6sq0r0jRmOXJLjDmDg+AjujpLejTYKH5w3clcPwZxt/ztTtwYeucyHFVS+RC
	2wpKk9zkYBuB96tnMbY3xe7+7ViBFp0DQhNmr0FzfCE4QmAoOHPgctgB6wmN5UaR5wz3/hugTNz
	KeobVn5dsHxtCEjp3TpuAKHJNrjDfW7MkNdgnJj5DVn23T1KP6m4=
X-Google-Smtp-Source: AGHT+IFUgb8oizWf0J2qlJ0rgWA0DpQF8kTh3UcUsq5IssI5FN8eZgxoo8AOC2oyuaOQ9hWxg9OFCQ==
X-Received: by 2002:a05:6512:3c99:b0:553:268e:5019 with SMTP id 2adb3069b0e04-55a23edf97emr1644893e87.11.1752745885067;
        Thu, 17 Jul 2025 02:51:25 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([85.174.192.104])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b635ecsm2956441e87.166.2025.07.17.02.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 02:51:24 -0700 (PDT)
Date: Thu, 17 Jul 2025 12:51:23 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-nfs@vger.kernel.org, Sergey Bashirov <sergeybashirov@gmail.com>
Subject: Re: [bug report] nfsd: Implement large extent array support in pNFS
Message-ID: <pvhfeuelzkpm4xektlzsels4t2x4p62sjh4q7l2ccfwok6wmdh@r43hmsbvke4t>
References: <9892f785-e9f5-4a29-9ff7-fd89dbf7e474@sabinyo.mountain>
 <34905201-eec8-4fd9-ad3e-40a9a3cdf03c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34905201-eec8-4fd9-ad3e-40a9a3cdf03c@oracle.com>
User-Agent: NeoMutt/20231103

Hi Chuck, Dan,

On Wed, Jul 16, 2025 at 04:31:49PM -0400, Chuck Lever wrote:
> On 7/16/25 3:40 PM, Dan Carpenter wrote:
> > #4: Change xdr_stream_decode_opaque_fixed() to return zero on success.
> > This is the best fix.
>
> Since the XDR field is fixed in size, the caller already knows how many
> bytes were decoded, on success. Thus, xdr_stream_decode_opaque_fixed()
> doesn't need to return that value. And, xdr_stream_decode_u32 and _u64
> both return zero on success.
>
> Since there is only one other caller, modifying the set of return values
> of xdr_stream_decode_opaque_fixed() seems sensible to me.

I like this solution too, will send patches to fix.

--
Sergey Bashirov

