Return-Path: <linux-nfs+bounces-2897-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED91B8AB3C3
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Apr 2024 18:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2831F234C1
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Apr 2024 16:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B8D1386A4;
	Fri, 19 Apr 2024 16:51:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D213791D
	for <linux-nfs@vger.kernel.org>; Fri, 19 Apr 2024 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545475; cv=none; b=ahYFFgPcxxEAMY7KFakYqxnPAzZCGFf8gYXvLaR+XZqbJzEF9qWDuS2wbd/q08VPviPxZTWocvaCeks4eaIQ6Huy73t8rRrtIi4/5KTE/e2Fgz48sBSQgx2K/IbxaJZbsTB57Xz1AgfX6ZC9TTUwaY9J05B5VZR5uHJottKb3IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545475; c=relaxed/simple;
	bh=CxSgkAv9JSRVwGa7F3otjg0mftNdSkxZTUqCxCbo/bM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=AptAZxXJQyzhEff41AGxVUqCFLsvnuzMThOU3sAGhS3heBOSOIzC6RngQa4FCStKRDK8MlBqqwW6dIRTnM2qOFVXkphwx5tBQ3oV2StYhKjgpqaXO2j6wPCNjnpV5dsoEdoplUVIzOv/V7JjKtUtocT00bT149CMLEGmBBYxM64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (ip5f5af59e.dynamic.kabel-deutschland.de [95.90.245.158])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B6F2B61E5FE05;
	Fri, 19 Apr 2024 18:50:47 +0200 (CEST)
Message-ID: <aaeae060-2be0-4b9f-818c-1b7d87e41a5f@molgen.mpg.de>
Date: Fri, 19 Apr 2024 18:50:47 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: NFSD: Unable to initialize client recovery tracking! (-110)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


Since at least Linux 6.8-rc6, Linux logs the warning below:

     NFSD: Unable to initialize client recovery tracking! (-110)

I haven’t had time to bisect yet, so if you have an idea, that’d be great.


Kind regards,

Paul

