Return-Path: <linux-nfs+bounces-15501-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF60BFAB29
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 09:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C050503BEE
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 07:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFA02FE066;
	Wed, 22 Oct 2025 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ptf1SV2k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5E92FD1DB
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119562; cv=none; b=SYbhKWxNyRC6z+UnLCPZY2337mgskx2z2cUL+G2DGjwhLJ7YtlwLhxNmDDPjDnOKfYp4KJmeQiKCHkSmxFr34g2Qfcy4FjXAacOPdUEMLvCu/ebsELpOHgozJQDQ1KBLSJ1o9fmDADJlFUXOX2BFadYKEO5U5WjLSzLrg0dM0GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119562; c=relaxed/simple;
	bh=rlMvOD5AeQ6KDpmk6ybghzAuvBOGcGG1LB9F+sDiuvU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=nQ4B3AgP0CDMGvykotmp1fQN6exQNdE/AaDoLSd0J92zxJxDXOU55hc/4fggtuU4Q52WWiReK20mNevcasvafGNZC7ma+F1stvPHXhRqocoJMFTLchjhghQ8W+Fnrw7zQb60BjCfhasVrj8xAOcLZCYYhmcIkrk2GNR5wse5KVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ptf1SV2k; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <39c67bcd-5369-44e7-9c7e-e9702ff95d53@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761119549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JkvxiA15m8LIzHDIMK6e0GwIrZbRTroCc89AgizbxBU=;
	b=Ptf1SV2kG1sp0usJgAo9cL5Psn6sVeD65crSNni/cWyfgHwi3aS/us4cQJZh71wGrfwLdN
	R7ECVnq5m+23YPSswFC68zlhXzuydYFvCW62zKfA81UpSrgIDgw2RrPFr9Sb2pp5oxP/jQ
	VCLG8Xuh26f2ad2XE9xw0X1sMDJEe1k=
Date: Wed, 22 Oct 2025 15:51:38 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
Subject: Where can I find nfs-utils?
To: chuck.lever@oracle.com, jlayton@kernel.org, trondmy@kernel.org,
 anna@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Greetings,

Previously, the nfs-utils repository could be found at 
https://web.git.kernel.org/ , but it can no longer be found there. Where 
can I find the nfs-utils repository now?

-- 
Thanks,
ChenXiaoSong.


