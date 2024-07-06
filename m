Return-Path: <linux-nfs+bounces-4687-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63359929543
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 23:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DF2281DEC
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 21:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8B01CD31;
	Sat,  6 Jul 2024 21:41:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3603818C22
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jul 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720302099; cv=none; b=WfDFZgFac1mQMw3Y7ggSIrh9F5k0me5zXQhtMa1wgZsicjvWcLTA6aJKkdrq2Y9GhFdbK6My1QzJfnsnTIOlNvj1jMDEVjEOMfdVIrbneOwwdWN79Covn8YgLW2iDnj5lQauDMR3Va6+w9/k+GDZb+vc6w2ZhopPBFLjKjTbEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720302099; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTvGKZB9PP072Mu0dJ2OKPpc9K6cRImPH4ktWh/ebPLg8wBzg01bubMA1RNa5onoA+g55rApgkyQNVYK/ehj31nSSZYUrW0pxGtUeGTHbgy73cMJXR8xVIYqAF4ZEo2OglV0m2nO6Xx4cSqUbqgpUsVu9DFqtPtjx8yNAemuZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4265267db01so1364855e9.3
        for <linux-nfs@vger.kernel.org>; Sat, 06 Jul 2024 14:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720302096; x=1720906896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=JLJbo8dQ4mPN58B7cLyIQZFJ2ArYKhpgHKowqtMJ+KCDnCtXwQWCehHJA6x6cMtMOM
         KI43/NpgCxbIzeeubQO9BzdT28CGAghu6vautV2lAWF1dKgXk+qp7VqtV69J6rKSNEiJ
         5Ut6q6mlgpkMvkYdxGmoxSQMDolDvHw/ENnu9IpUlT0AkMHCEdaoJZRS0EA/QJnfgmvS
         vJ1mSAOE7AdfsnWbLOyvwmStDHPghZRRfxZGSboTKNanhfmC92w7MqIWY+XavJWqftf8
         Lvam/+Y99aq5lr2CtiKsiXOo09nv6cMkCcaY3VuiE4NDCHrrlw+t1L/0O9iZuILRzbor
         er5Q==
X-Gm-Message-State: AOJu0YwokwMcwEctwe98y5mz7WmJsEDPRRf4+pHbgJ0R0CsuJmE4BE8b
	/vdedVIBr6u5Gn4q+bhYbiQfuev1IzOkmX2E3RLhGIMERMr/XqCi
X-Google-Smtp-Source: AGHT+IFBzb/ro0bwC9GnFLj5oI50p3DPXY3EGckDnRk8SlqqqzBHsCIl77X1dbzzL6EoPnMxXplnTg==
X-Received: by 2002:a05:600c:4203:b0:426:5dd5:f245 with SMTP id 5b1f17b1804b1-4265dd5f40dmr21271275e9.2.1720302096147;
        Sat, 06 Jul 2024 14:41:36 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42650b26c48sm74289155e9.17.2024.07.06.14.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 14:41:35 -0700 (PDT)
Message-ID: <ca899d05-3f90-41c7-baf2-56370fc7f5e5@grimberg.me>
Date: Sun, 7 Jul 2024 00:41:34 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: do not extent writes to the entire folio
To: Christoph Hellwig <hch@lst.de>, trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <20240705054251.2043864-1-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240705054251.2043864-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

