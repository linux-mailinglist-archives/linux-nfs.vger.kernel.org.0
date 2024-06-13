Return-Path: <linux-nfs+bounces-3747-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A008390672F
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 10:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A2A1C20AFA
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 08:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1A11411CD;
	Thu, 13 Jun 2024 08:39:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF6026AE4;
	Thu, 13 Jun 2024 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267953; cv=none; b=JCAYbnrdSJZ7045VVSYcQFav0nJWUZw6P5Fvs+bHP/tLHtTofIgLmn5D0lEVD2I4ShumgKuHN0SrTumJzHcSd5RhH4gp6XwdfgkPZlfoavBPY8VpRyqThwVU1N857CdhZCHTT0/sQFc87pFdsD/ea7ZS701Q+z9pd57qixt+T+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267953; c=relaxed/simple;
	bh=xWH1FslbBwCpFpoPQMjOi0tZqpH79HAY3uCalUU1SGc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uN0esdAMA4Sc/MOiddeI6+uH3gPyW7WlkuD+FOUkl3vzYGlbjHC0FTG6CjAl/dSEmIUOHrkcMYrRbwev46VDLR1QwomE0oP2npx2d/G/g8uxDk52wJjBNoAqwWsikrr678MLW9SRkXQ53UFzWLnyc+crreDucro0mKrblq+79LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=none smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chenxiaosong.com
X-QQ-mid: bizesmtp87t1718267734to2hnf8o
X-QQ-Originating-IP: vOO0L+he9GGs+Med8jGz1/0GUF6Uuzff+tDBEEZ7Nko=
Received: from [192.168.3.231] ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 13 Jun 2024 16:35:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7174577849898629138
Message-ID: <BA2DED4720A37AFC+88e58d9e-6117-476d-8e06-1d1a62037d6d@chenxiaosong.com>
Date: Thu, 13 Jun 2024 16:35:32 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: trond.myklebust@hammerspace.com, anna@kernel.org, bcodding@redhat.com,
 kolga@netapp.com, josef@toxicpanda.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 liuzhengyuan@kylinos.cn, huhai@kylinos.cn, chenxiaosong@kylinos.cn
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Subject: Question about pNFS documentation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0

Greetings,

I am very interested in Parallel NFS (pNFS) and want to setup a testing 
and debugging environment for pNFS. I found some pNFS documentation [1] 
[2] [3], but I still don't know how to setup Linux environment about 
file layout, block layout, object layout, and flexible file layout. Some 
documentation like spNFS(simple pNFS) is unmaintained and was dropped. 
Can you recommend some other detailed documentation(how to use pNFS in 
Linux)?

Thanks,
ChenXiaoSong.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/nfs/pnfs-block-server.rst

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/nfs/pnfs-scsi-server.rst

[3] https://linux-nfs.org/wiki/index.php/PNFS_Development


