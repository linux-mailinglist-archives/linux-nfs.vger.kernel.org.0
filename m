Return-Path: <linux-nfs+bounces-4762-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC02E92CBAD
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 09:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53871B20EC5
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 07:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4E181AC3;
	Wed, 10 Jul 2024 07:11:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E41081AB6
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595499; cv=none; b=VIO46MU0WZAJ5P5dJLHXqnOcRICA9BAPeA94liHsYXMIC5LHpau3dvSzwTLdPZlQ28ee/f2B9kfU9MaBVObblk1VryajoKlqPGjW+ljiMupmIH1DKtucHJbcFkmFcB9/2XYtykaGMwYRgowP5hvTXJiCO6zQXJHYMBkGL/SH4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595499; c=relaxed/simple;
	bh=iENuf5oUz86OlWiuNSiX5zfcExDZC6pnKYUm0K5Cz6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHB8kslMczF1hVLNDI042DYCHgthw39zgCKxdyHQZ6m5AljBFkpSxbZYOSXS0XgEnqDjDHSwKLbyHna9k4BmkWCcLEq+ggD3yH74nj5DLU5gUvT1iAo4CairftdJnv5IkYjLpsNoJk9zySUbQan7a424kO3sJiItNUm8mBfbNOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-426719e2efeso2293335e9.0
        for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 00:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720595496; x=1721200296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTBMlKUTvJ66hhjiedV7n69ZDwISZmrEDQq26n8Oq68=;
        b=TgJ6q3mWUHUlRRQEoCpw08EUvWYMid5sfo7i0kJ4uQI8pfBsHuWRs58nTRRRYSiMeB
         8Sn5Sb47sysYTYohMUb8Br5/COnLfXbL074x/wBSc3+u+yfEIZP26n8v+gfU6wmd7rS0
         UZxVVuZpPG74F9HdlhgRVHogVXuUDDO9Phd0biSvje/xfmA2wNQCFbISezYcZq8suN0m
         dgE0/Ksiha2+OE/WfR2hxinCz/jz5ZI04evmfIUAGfAiH+Scu9qynjgR0iLnf2Ks7Rdy
         2iJFfpI9LA0Y1Nu5m6znQyY7PUCxtCuiM6OtR8JSNHuF91fGCPJ32Mu/qnKeqVpe3GRi
         ML5A==
X-Forwarded-Encrypted: i=1; AJvYcCVpti1My6Zh7IsLd5vhQafek5E68G/1qIK7C9A+/T9IgkpVvr1evtoGnufhfsxOSsXt5EujhTANcXY5Wp4RZPEjr/vrUYX6UvoX
X-Gm-Message-State: AOJu0YzwL/Xjacr3axZzhfI8l3w/5yMTMQim5kTsckzJL9TqabX8NKew
	KSKk99hbWHeY+wxYzsMYAxrdxbLlQsGAggNy8JA0iQPG1H0g/fuIC2qVaOB/
X-Google-Smtp-Source: AGHT+IHzO3Jz8rrp75GkOY1ZPaNYj//tgY4ozTBjND4OtxQbRi1L3iwuwO2NBYl6QrYUVJC2//5dwg==
X-Received: by 2002:a05:600c:354c:b0:426:668f:5ed7 with SMTP id 5b1f17b1804b1-426707fad40mr31792305e9.2.1720595496266;
        Wed, 10 Jul 2024 00:11:36 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427268be96dsm40269025e9.37.2024.07.10.00.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 00:11:35 -0700 (PDT)
Message-ID: <500c22cd-b88c-48e6-8cb4-732f66f8e913@grimberg.me>
Date: Wed, 10 Jul 2024 10:11:34 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20240706224207.927978-1-sagi@grimberg.me>
 <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <9156BC30-78C3-4854-8BC3-510E586B4613@oracle.com>
 <3b4ec3b0-5359-4f95-81a3-1d558756bddd@oracle.com>
 <5a071e49-f214-41d3-b29f-aa1860b12455@grimberg.me>
 <e23bb0d4-7f83-45fd-8df1-b127e1f749db@oracle.com>
 <9b9430e9-845b-4e21-b021-cfc387cbd01e@grimberg.me>
 <53440FD0-58F1-4B92-BCC3-20CB91BB529C@oracle.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <53440FD0-58F1-4B92-BCC3-20CB91BB529C@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> Yes, as an NFSD co-maintainer, I would like to see the
> READ stateid issue addressed. We just got distracted
> by other things in the meantime.

OK, so reading the correspondence from the last time, it seems that
the breakage was the usage of anon stateid on a read. The spec says that
the client should use a stateid associated with a open/deleg to avoid
self-recall, but allowed to use the anon stateid.

I think that Dai's patch is a good starting point but needs to add 
handling of
the anon stateid case. The server should check if the client holds a 
delegation,
if so simply allow, if another client holds a deleg, it should recall?

Thoughts?

