Return-Path: <linux-nfs+bounces-3560-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E6A8FC6D0
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 10:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A784D1C20C36
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 08:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B431946BE;
	Wed,  5 Jun 2024 08:43:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880211946C3
	for <linux-nfs@vger.kernel.org>; Wed,  5 Jun 2024 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577034; cv=none; b=rhVfmQlK7gWbGREq/NIf+NJJeTzTjYElrhEE/5rw+mB/df0UNQFBaT9p/OTZ4ve8gNQtuVdP1tj5vBazwVEnwzJYUiVxGz+0hijsXwFSgiYFsQFd5JnZ3jPdClniUEEctsHK7dvnkkDBZo1Z1YXvc0DPmVK4I4NR5A6K2457Yys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577034; c=relaxed/simple;
	bh=ckiUV8HeIYQ/rsOxCbMNm/VjxU8EUESI63njQcctYnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgIMgW9ug4nID9tn1yEjzTIh3kTSnzEGaxv4/QSwG8G9rcDfMVJD7IX3e5FbPL5VyjQav2QBcBD4Pv2Aq9M7SORMlkT6kvf89LMjGl1f5gHxAyoyPp+GUgm3sg89dXO6qJeDbaClupEYn6qIMZAskkf52Zb6Og+Fmm7+H/nsMmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3590b63f659so553097f8f.1
        for <linux-nfs@vger.kernel.org>; Wed, 05 Jun 2024 01:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717577031; x=1718181831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckiUV8HeIYQ/rsOxCbMNm/VjxU8EUESI63njQcctYnQ=;
        b=p8Je1v+0cbmZFEW5UCyg6etUg1WCTuTgQtThS2MB16U+vw00DQzH3f1INHDYxXVQyt
         SDrEYegOZaUmjoPpjUznroJAWJTwJ3E+dyWqk/nxXyJRAPn8MtBgOwVVFzosN6M7QuCr
         29Ye5jxFckG1ge37BYzTEmDSvsyP4sUhiV4niwngeFKAO0t53zVCBLC79qjJwRSdhvWv
         3W7ztQU/sxURJV8FceeqXBDSVGV5RL5P57wCWnMnJNR+8/rfonqeGJxtIYU8ebjjRSEI
         kpQ+6nEm6T5QafcJGhroGuS/L2dnCLOCGz45r1ij8t7vjjWv5QLQZ9FI4tLtv36X3niS
         K94w==
X-Gm-Message-State: AOJu0Yw3VJUO4qLCVncSxDLQPvkIK6ZGP+9FDiFTwRI7tM3W57/Ufbg+
	JFFbVjlpW6pQNpvI55py8xQ3DXUbtCE5FUbAaRUtoifXrTNfYaoCH3OJSi67
X-Google-Smtp-Source: AGHT+IHlwSAa1XZBA40QJbv3MSpkKslifCC3jyhNddabb4kABCGC2GXY10QiZs0spdvI4pplGa4l5g==
X-Received: by 2002:adf:fe0d:0:b0:358:d0c:b9a0 with SMTP id ffacd0b85a97d-35e8405825bmr1170612f8f.1.1717577030692;
        Wed, 05 Jun 2024 01:43:50 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd066d74dsm13729504f8f.114.2024.06.05.01.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 01:43:50 -0700 (PDT)
Message-ID: <237fa034-dfae-4adb-8382-fa674df3ec32@grimberg.me>
Date: Wed, 5 Jun 2024 11:43:49 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] rpcrdma: Implement generic device removal
To: cel@kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20240604194522.10390-6-cel@kernel.org>
 <20240604194522.10390-7-cel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240604194522.10390-7-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

