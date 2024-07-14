Return-Path: <linux-nfs+bounces-4883-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB124930A0E
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jul 2024 15:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40371C208A5
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jul 2024 13:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA74E7346C;
	Sun, 14 Jul 2024 13:26:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3626AE6
	for <linux-nfs@vger.kernel.org>; Sun, 14 Jul 2024 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720963615; cv=none; b=Dc1b79TPrcyd0+xyxCngQyG9BGj9ckeYduvlf24PONB+TYPHGjH2At6c+roAHAH0UtJ8YNRFa2vkygqwzK5/EGVn7n28MfK3bjHt7a+kMRSRzBPVMhTMrPbXOxpmY7dUmPfMI9bmg4C/xMG5r3WVtrE4mnETdKS0NxHI13zCeGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720963615; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iaYJHS9r1LLKihnWqM0eCozyI6FZZhTdWug47Akq52TXEOwHHW2w6WH7zLhQHfof0SbO8rlYfvRRL/PKEPvkDiycWfHqIZ0AJVxj20xXiX2fqKy9P7EZ/uM/vtlL1w0iF7v3X+2r8e7lp5vkxkJjW6LlhTEZIC7WFmPtoDkes4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367ad05c7c7so257256f8f.3
        for <linux-nfs@vger.kernel.org>; Sun, 14 Jul 2024 06:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720963612; x=1721568412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=vMyJqytwa52wduagHJpnmI4SCaFF29hQKF4yhGSOne7ANuzARANuIDSQkntCZSbuzU
         UIT+l4a+d6W+aV2rGAr4fz7XOq9EOmtUCE5BGm/SzL3qyTzJNG4HHvnU90aSZynj6zxi
         ERqX9IES/dAsSBBM0DBWybIsWJPjBU6Vj6aGwt2vKPjfHDBm2mZJAPifKQ4/+z9vVOYE
         a1quWe+N6x4QM1SVLFvjTNeL4Jv2r/SzD5EGzTn+366nrfY8PWOBjheo1gh27DSWsz0h
         t4goyXxsf3z7uvJFLCDBvmzV/tiqxWUIH0BkVJGGCAaS773Or+KgQ1pRP7rXSzJaEzhJ
         I3IQ==
X-Gm-Message-State: AOJu0Yx9hx8u1G0MVXEYvaIcqX3g+tJTEJ4N6ZEVcIqZfbd+c1mNU4b7
	YgVn/Ilryp135kzrh9nq1V3UazEsyTD5ns0JrB6frrNyGL+k6AD42yT4Wbi/
X-Google-Smtp-Source: AGHT+IGWZ1u6krznUBKsyupR/Mm/d3E9vTRgE7D3LJYa3XnLe8EVJ1T49wqOx8vR7+3RI/+oITv3XQ==
X-Received: by 2002:a05:600c:3511:b0:426:6cd1:d116 with SMTP id 5b1f17b1804b1-426708fa1acmr99488295e9.3.1720963612225;
        Sun, 14 Jul 2024 06:26:52 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e83273sm52231805e9.17.2024.07.14.06.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:26:51 -0700 (PDT)
Message-ID: <5dd07d5a-0be2-45ff-a401-d900920ec198@grimberg.me>
Date: Sun, 14 Jul 2024 16:26:50 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] NFS: add new nfs3 acl tracepoint events
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20240711073219.1700-1-chenhx.fnst@fujitsu.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240711073219.1700-1-chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

