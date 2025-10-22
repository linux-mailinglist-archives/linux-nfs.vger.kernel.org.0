Return-Path: <linux-nfs+bounces-15500-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A811ABFA9A5
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 09:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F633B27B1
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 07:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F0D2FB09A;
	Wed, 22 Oct 2025 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eph8PPfN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F2A2F616F
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118618; cv=none; b=tVyayIUXyUKjnJRf04wvYp+nTMy5234hjzlwiZ3Qfoaw68+6YrDql7VGYCSNwqlx601m5owVuDdkQGuEb9tsppjkuKaiXnNTK1PqNiAPwvZkscwNJM8mq6B39tGOLwgaIiUFR1Z+b729AgZENUC7w5oWBGG9o8LUwe5UxvcimPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118618; c=relaxed/simple;
	bh=4tO1WXj6WgZlOPA0xz+u1lIl6OAiRpneHrXjRc8x+ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErDYr3tDPlNsioIU1Mul/PsNw4k0tA7PYr/CPn8L9iQF2a3UEGqyUCsiIHVYUrInxW1c5M3y4PbI68+NU5LUZvUXr6B3UNa0zcHX8d+MJCVpFcSFsbnPyjWwcP9b/wwp3PRWpQ7nviMLig8NevN0NstizCVFhYLx4iSXxDgi77Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eph8PPfN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-426ff4f3ad4so3514664f8f.0
        for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 00:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761118614; x=1761723414; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mYRODrAioifNQsfmynSYmORQ4CX7Cpc9gXZU06Vn+0w=;
        b=eph8PPfNeP3TLxPQyS9dvxqx1NtpioA81JfW9GOlmGQZtEjmY1MhTH2Q3y4AHMxZV7
         gv2rwEJmvEc7LSqMpQkLlZb0pjHPpTGx0nrOKIVErKQ7XJ8fBybgNsbxUOx5G41ZeZVV
         YjxHF6+BuwqW++pCMKwHY8SXA7ODHgGtssdaabiv9KybiOjbcoMdB4cg7RnpFMcNgl09
         mrrGmfZBKwLE3NOcWIp+rHe+H9XcFQE+aTUGL6WLFE6dG2D7WsQLq0KdhEjWubNkhyeW
         M8cmMSopQHziDbpgP8y+ayPyz+V6gMPPCQv14bbF4MJLy6PnX+rQXF0k2ahDkjmax9AC
         YUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761118614; x=1761723414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYRODrAioifNQsfmynSYmORQ4CX7Cpc9gXZU06Vn+0w=;
        b=ihxChNMHjDkE8nybWrEtT8MqUpUHAWpJ83SZVApBtYyOkdSZdYFIZ4Zu4IY9whOp4x
         w+SZsk1/hUFuInFF+4Z5fEwdt4kDzaZZGERg06fnh+RwxVo7NH4trQ2vfiQP3mYfpPBb
         mNnq+qMv4Iz7Le46z5F3DRIxkjXgtFJkb9QDmXb8DKmFdN0t1sE8gK9mfa4i2E6sPyPb
         tVT8yBvAynAxFIklP/Mvk0kGbkEdpuCc+DMJrgrOHnmMays/tVRvq3WWNO5ObEIBHZ+o
         o6MUC9doY7hGZ/o6knhwny5nfPHrB3uFwOF3nEWaWHltMqG9TOc2sQD9QU4spPDsn4pr
         meJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK+IoEVqoXye5C4+OpatpxLYKy/N9kCZ84ftRfnrhKW669LORf6HL31klzBUA9eKX42gNHSsbeCxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA7dv6LB5GuSxlUThJ9rPYwyr6YK+Gy9kPVg4mTfyr9uFxZkUq
	AAUL1kfcBfMbN3OW0afO63Uioc7GDDcoQclnJp+Bokj/4Lee9kOuWUmlRH28Mmy9pto=
X-Gm-Gg: ASbGncs+W7IgXDiI3VSfp+u20L6vPd2psNoCs+ZoiY6NS3/jUo/oZs6koBzrHtSpdU8
	7iPBH6C3vcFHgr8011LXCwgWOOEjTkQ7oGMSC4hgK061jRGTj7C5yV0d68+2vdmCKALIbNjWwe5
	LeAaiJl0eAg2QwfZz0T1qdpfB9zKiShOaoVB2cjcYgtof/7LjjI51fCPyICpCmiKrEA/ouQ3Z08
	xdqe0GeQdMkPxt/+VH43xNNFNpNTtT3eRDGWLLaV4mrHkXY0QpHZVintYD8fu+nga535intmcUU
	gdmKjAIydauomDG2vQZYlCsPC8rJWTpWsqGkInFPMhCoqb3+8t3ZECMWXZCRNplNd0l488TzQRa
	gDRp2ltCUS+FSxmZXGeRKqm0ssqsfBz+Djbyx05RA9NFSQDIvtePb67ArrGc8zQ5W+9yCw5Y1AZ
	nlEAob6/ljDpUFn3CX
X-Google-Smtp-Source: AGHT+IF6JCuxEZc9y0QYtoe+lnLLK/6b+Owh6L1ix6z7q6TGMdRyMUdjp+zdpzoyT5DFMBxv/91G6Q==
X-Received: by 2002:a05:6000:2485:b0:426:f40a:7179 with SMTP id ffacd0b85a97d-42704d8f12emr14823720f8f.26.1761118614244;
        Wed, 22 Oct 2025 00:36:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427e1be5d6csm23610769f8f.0.2025.10.22.00.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:36:53 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:36:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: liubaolin <liubaolin12138@163.com>, anna@kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1] NFS: Fix possible NULL pointer dereference in
 nfs_inode_remove_request()
Message-ID: <aPiJkhNJ4dgOlMIj@stanley.mountain>
References: <20251012083957.532330-1-liubaolin12138@163.com>
 <5f1eb044728420769c5482ea95240717c0748f46.camel@kernel.org>
 <9243fe19-8e38-43e4-8ea4-077fa4512395@163.com>
 <a0accbb0e4ea7ad101dcaecf6ded576fc0c43a56.camel@kernel.org>
 <b928fe1b-77ba-4189-8f75-56106e9fac19@163.com>
 <ee0bb5eec4b43328749735150c5505f02e7a1842.camel@kernel.org>
 <aPiJIBTsQit5jyUg@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPiJIBTsQit5jyUg@stanley.mountain>

On Wed, Oct 22, 2025 at 10:34:56AM +0300, Dan Carpenter wrote:
> On Tue, Oct 21, 2025 at 11:15:21PM -0400, Trond Myklebust wrote:
> > On Wed, 2025-10-22 at 10:44 +0800, liubaolin wrote:
> > > > Sorry, I didn’t actually see any case where req->wb_head == NULL. 
> > > > I found this through a smatch warning that pointed out a potential
> > > > null pointer dereference. 
> > > > Instead of removing the NULL folio check, I prefer to keep it to
> > > > prevent this potential issue. Checking pointer validity before use
> > > > is a good practice. 
> > > > From a maintenance perspective, we can’t rule out the possibility
> > > > that future changes might introduce a req->wb_head == NULL case, so
> > > > I suggest keeping the NULL folio check.
> > > 
> > 
> > I think you need to look at how smatch works in these situations. It is
> > not looking at the call chain, but is rather looking at how the
> > function is structured.
> > Specifically, as I understand it, smatch looks at whether a test for a
> > NULL pointer exists, and whether it is placed before or after the
> > pointer is dereferenced. So it has nothing to say about whether the
> > check is needed; all it says is that *if* the check is needed, then it
> > should be placed differently.
> > Dan Carpenter, please correct me if my information above is outdated...
> 
> Yes.  That's the gist of it.
> 
> However Smatch can tell that the check is not needed then the warning
> won't be printed.

However IF Smatch...

Gar.

regards,
dan carpenter


