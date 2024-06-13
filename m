Return-Path: <linux-nfs+bounces-3748-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BEC90684B
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 11:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519E4283EF2
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 09:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA2529AB;
	Thu, 13 Jun 2024 09:17:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0029C13698F
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270245; cv=none; b=QARUw29FthTgDVkB3uYT6JnfbOKweiGlFVoI3zMHeZdliBAp/t7QKRWADxpc17EZqv3PZKhm1iEnF24Teq4GS7dg/qtjDLB5QWnKk9PmNAZv7oIkTfc0daU4bQ6f5JhC+YvHhtmXGApcM+mrfbQUk8qtxadONxon9TAnOeyELhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270245; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goUmu8KRsCeNC43q6f9n2ByGYsG/kvYUZKKz0Hr/UoE8vEFN5pr3qQYCKb5yGtsPVsj6qIKj35Fmk7iIAWt96gc9OVNDK8aZOBW05GhaNRDwUIz2k+LgZsNxuEzoPnHTMmCsGEQNkChWRwN9zA9NyK9TNQLbhHP8oBKnQgIjieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebfb526d49so522971fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 02:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718270242; x=1718875042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=vRLoj/N8Xg/jiBLAsjtLndMoOVpO1X82i1732FaFe9kSFEwdfRj1usQf7OzfJTAlcv
         K2uFknhSuxLKGiv0BaH0IZpbqsyiyybIpVXIzXacl6RHl2K/GGZlcP2kmaZBP5s9fvvd
         k9SlXJMZRuC7jvWCUrRJSj1gaQHLrypLesjloxgGN91DKFW5KhjRGKI2gg2IDU2RGi2Q
         ZNRNHyiQr6J3ak+1rjaJQ1Ju9Cvg0vvI7/zfzjGsNeBpg+3vB5E5PuU1JeKCbYBXjbUg
         Pit3s0RWrs9NXIS1zsqi/2WTclqvFMB4bKOlMLADfc+tuJKZdleB/C8EFI/ck3fjhgif
         5oGQ==
X-Gm-Message-State: AOJu0YxG/jJlzUCdTUL5T0rKs7rvJj9NVhJTS0l4/pQ54c4+lP+ne1K9
	HXIJo2eeNGbU9H4ny3NY6YB30GYvqXgJug0UsHfr+MMBKuZtYHmD
X-Google-Smtp-Source: AGHT+IGIL/v/xzVP+cSfIvHTTs3ZU+ql+Dru1R3+jTOvrShx1PBykUre/3ayLbV1f3QWF2FkPH/FIg==
X-Received: by 2002:a2e:2284:0:b0:2ec:2f8:f4ae with SMTP id 38308e7fff4ca-2ec02f8f6eamr11179871fa.0.1718270241841;
        Thu, 13 Jun 2024 02:17:21 -0700 (PDT)
Received: from [10.100.102.74] (46-117-188-129.bb.netvision.net.il. [46.117.188.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad20bsm1091692f8f.54.2024.06.13.02.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 02:17:21 -0700 (PDT)
Message-ID: <4e89b4de-66b5-4eae-9695-fae5ced0d75e@grimberg.me>
Date: Thu, 13 Jun 2024 12:17:20 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nfs: Drop pointless check from
 nfs_commit_release_pages()
To: Jan Kara <jack@suse.cz>, Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>
References: <20240612153022.25454-1-jack@suse.cz>
 <20240613082821.849-1-jack@suse.cz>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240613082821.849-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

