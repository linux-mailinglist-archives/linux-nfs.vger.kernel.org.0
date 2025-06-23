Return-Path: <linux-nfs+bounces-12628-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1C1AE391C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 10:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A75E174313
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 08:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F87020298C;
	Mon, 23 Jun 2025 08:54:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA422FE0A;
	Mon, 23 Jun 2025 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668861; cv=none; b=gAz4oJdLse4yiuXvwrC2IaOfWBQasmWSmxIhXjA2amaxm8PztF9xg/ulbs7PAExenli7MG0acYmpwOQCDAXhgCaeZ4LFQ2tfVnYr0QyFEGpB3YGVJ7s1lDsA7hQFUbWkx+t2c2Nt6SKb+O+3pKstS//xWwxkYWpneWdLoYQNWdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668861; c=relaxed/simple;
	bh=dnRZoYhTiLx6mP17snlGpXsJ4rO4wTDqx7YoKhd07FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHT8jbwn5NT8y2iHeAqmrxyjYgk9hkF/1YdWryrSm3bIr6uH6IsT4MPX1K/uFYZh96X5n/onSUkBM2s/ByYfHmg0RZbQyLO3Ofp5TzIF847R2ByHPrKedjwdCh9niow1jf8+4gHUCZghyk2HJPuat3NDgNH1tiYE1RHj3v2beig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: esmtpsz20t1750668727t4d83c62a
X-QQ-Originating-IP: gyIRPxu7pnQLRfC/m8i/nC3NTJCG8EuNVauDHQpuNl0=
Received: from [192.168.3.231] ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 23 Jun 2025 16:52:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6986087831248753503
Message-ID: <E5A6E17D75867EA8+e74cfa32-ffd5-48b5-b5a4-b89b85f66866@chenxiaosong.com>
Date: Mon, 23 Jun 2025 16:52:05 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] nfsd: convert the nfsd_users to atomic_t
To: NeilBrown <neilb@suse.de>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, huhai@kylinos.cn,
 ChenXiaoSong <chenxiaosong@kylinos.cn>
References: <20250618104123.398603-1-chenxiaosong@chenxiaosong.com>
 <175042051171.608730.8613669948428192921@noble.neil.brown.name>
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <175042051171.608730.8613669948428192921@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Nkqq4bFvvULWBJ+c/T9TltPLkYKl82R8WOPDta8KcHFNjrKLmLx+0EDf
	aN2mxMzB7zv2jWAps1FXhuIAGMxiVvvwDNG3os03+EQW9+qgHeOn9981u/ZKRC96pmW2w7n
	SOKhQWGTSYCJKDC4s2zD4gHO686e5qaSPRxw8/u6KgtRWbd4FHcqS04hESx+oBi9CsyMswt
	ldXbs+p4Fn3QcpZBlV8qJLBzjcbX5oswb7Pz3TN1One61tH6Mu7VCu+5qYyYWOvyP4bAIQM
	lyzXeh+R/bp3WC6uJJBRQvtt5wRrj3A1CoMsXcfRLxNyGc9GuTcRG6b7/XnCzo+0PH+JOxT
	iF1vC1XkT2cFuubAQXrj+C/rb5BIXwKx9mJHMgI2a4NFpd7sI1d1mesCHxGJXNJ86riarul
	ImLfchm1Zv0HCtOLevbxy3IEOIPi3Fy+1evht/5Ck1jej96mu1epB7WoUG8G0Bata34q5/J
	OSlo/34NqtRftSIshMFfy3IH7F0nLYgB07342PNqFMTNwtpqymAnRencQKu7adE0q/mqvnk
	5v4uPORREztebYgCtJ9qz/TfpPnxpwE6sZQadSKt+CMA+3qfzktNbSK9Ms4DiHkyrodJTyC
	kIkug8qJVeD6d+LQVq//PUHcQissNpmgzumohhXBRPQWMxb1BmSGcFHuGnQJFuJMaDX9hf4
	smaOllXVta3hf57h0x/NpNl11RLDB8d8fgmnBcoyUE2FWbPOcB7ju/ThHMr3bJ006qvQQOt
	3Xu/TIz2ZcC2SkEAI+Ez87KjndzGYVQpBvDK+kKS/bx6ccjRkjge6lZccTdWekfZpwnO01Y
	0TAqGUjlzeMRluv/fh6p/21T5b3RJn1I1FMO60FkxXPklVtX2TptS49kMsHqnX1Nh73ZnVc
	1p7ucMxcAjLbUogFKVpSo5t+moVhxPswc/SLxMOeAo68E0nIkYxKihEBFZ8jbBEr2b7xzCb
	yLe1zixJV9yWrw3ZV6qLN9C6CEuekdfBcVjYWfa+E9HCCXe0+X5kQBzlB/1hQTo8MVcX/IX
	xKr9fKuw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

It seems this patch (or patchset) could resolve the issue.

Thanks for your reply.
ChenXiaoSong.

在 2025/6/20 19:55, NeilBrown 写道:
> The only possible cause that I can find for this crash is that the nfsd
> thread must have still been running when nfsd_shutdown_net() and then
> nfsd_shutdown_generic() were called resulting in the workqueue being
> destroyed.
> 
> The threads will all have been signalled with SIGKILL, but there was no
> mechanism to wait for the threads to complete.
> 
> This was changed in
> 
> Commit: 3409e4f1e8f2 ("NFSD: Make it possible to use svc_set_num_threads_sync")
> 
> Sync then threads were stopped synchronously so they were certainly all
> stopped before the workqueue was removed.
> 
> NeilBrown
> 


