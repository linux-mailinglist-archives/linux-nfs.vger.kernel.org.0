Return-Path: <linux-nfs+bounces-12237-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4E9AD30EF
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 10:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B5F171688
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 08:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBE1281357;
	Tue, 10 Jun 2025 08:51:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EEA284693;
	Tue, 10 Jun 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749545496; cv=none; b=PF5ju05IC/YAmFWwFsPSqcdv4MFGNY1vTpjDooSyG4rKFlWp1hs7+xyUGBQdnqXIn0CdJQepRA9DClUH6+m59gYi9BXopdGL75bHuicyIAZjKkIEs9n9C28Bjp4gVoL+9yUBFpilkSP3Uei2THNCQNwBjfI3UvF6JfQXTFyvQCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749545496; c=relaxed/simple;
	bh=zvbyyCxytNDEO+UtXu7CEY0UdZn9oUrPFROd3BayG9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riHMp1cbOJPeJHjgdSPDLiubLSKcPxqqWj0ITiv8MOdY+qSHm/EdR6PCf+0GASnv94v25qMRl0zKo/QpbOK0mr9s0b02GkuOV0g0xoKhdT8/WeN6Hv/zNHWVKFHI2DkPvGAN/+0ygtXexhiI4v3ZQy//uLnOWM7sdBz6+bEPldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: zesmtpgz3t1749545367tcc7ec2f8
X-QQ-Originating-IP: K+mB0gDXQt1bmILfykrmLoezIQBYsxHDPIZp4mtJRxs=
Received: from [192.168.3.231] ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Jun 2025 16:49:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7588561087007042098
Message-ID: <23651194C61FBB9C+e2ddd3f5-f51f-44c0-8800-d2abb08a2447@chenxiaosong.com>
Date: Tue, 10 Jun 2025 16:49:25 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] nfsd: prevent callback tasks running concurrently
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
 Li Lingfeng <lilingfeng3@huawei.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Neil Brown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250220-nfsd-callback-v2-0-6a57f46e1c3a@kernel.org>
 <20250220-nfsd-callback-v2-1-6a57f46e1c3a@kernel.org>
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <20250220-nfsd-callback-v2-1-6a57f46e1c3a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NhdiEwnVOUqEhS2wZxi5s9AxHk8eLLBhcocHTiEFuhpWE0CbRJmlBy5e
	p+RoOFCYgOeVehLZUYxua0a1VN4s9pMF4iDJ+jJDsy5y4DNzYQYBsQXnqpECSoP0nkjz/gU
	3RGy0NyAuIaZgERF/PnT/+7pTUL5sw8qRuXd32ESsclQUtaqvY6/Y9e7z/OittNP3R5EKiv
	P9nRAxKtUHWH3eikbUI4XREQIgCZP6lwepH9dh8E861akqwhY9EjrufKlL8zbn52+zGCMAi
	D8BFlVUAI6zfxgUYS5+EhbH/qgs4KNePMxWYpHFZFVmnsRlGQyMLj0hZ/xPvV4qUiO7v/EW
	3xaZQnYOdNE2583gKYzTtad4ho/WK+ZDuQRuUy5pKSn1OML4Z0ajeNKSs09Lio9FH1x89Kd
	a1TocWVciPSwJxFV3jOFxLrAGYIUhZX15j8hG+Z99Re6JOahZIxH0QZ8kFMwY1pqHQ7zPXm
	KBINOyjUiYj2sG3/ZVl0ZbBKBpdmmaAIAD3Ua8liIY39xZBjygdi75F6NTusrVY7igA9/7v
	bjcRcAgKOAruHtRIoxr5m01jDtn6svEQX6WNDavdah+Mv5502VR40tvQ5qdEkPXLJNVRxck
	Shc/i3Pt+2TTdhjUv2I90LhooIOZbzKlqbPxoHj+FUk9gKCXWsda3RqR750TmFYuV3iV4CX
	hn2gGX2VFI8uaSq7CNJouYsoVCQ+og1XIzoMnr6wG7ug9LUldlfwS+cbuYyobDqiTg9HWf1
	bG6Nq6TvGVmeHXfPRx+r9gCoYrJJVrlBNUu141EaLi7HHhrUm60FwLjL1QA1TnZgBMXDiQt
	dANcKaUGvUrB0QMs00LeZgK9E5RJuB9VKiODizFzjtjD3azRA+HHfego27HFhVuirvOPCvq
	/wTOry6tTrV91+bj9SCm98x30FJ1byn1nbWvDKF07Axw63VEiZhYYUi30sAKIpOtHbOXjnU
	srn5YVhoQfWKhlIqi724vHWosGxteOg2h3U3oLMBqStA+UeHhOXt6BDzL
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

在 2025/2/21 00:47, Jeff Layton 写道:
> Most of the nfsd4_run_cb() callers are converted to use this new flag or
> the nfsd4_try_run_cb() wrapper. The main exception is the callback
> channel probe, which has its own synchronization.
> 

Hi Jeff:

We had a null-ptr-deref in nfsd4_probe_callback():

[24225.738349] Unable to handle kernel NULL pointer dereference at 
virtual address 0000000000000000
...
[24225.803480] Call trace:
[24225.804639]  __queue_work+0xb4/0x558
[24225.805949]  queue_work_on+0x88/0x90
[24225.807306]  nfsd4_probe_callback+0x4c/0x58 [nfsd]
[24225.808896]  nfsd4_probe_callback_sync+0x20/0x38 [nfsd]
[24225.808909]  nfsd4_init_conn.isra.57+0x8c/0xa8 [nfsd]
[24225.815204]  nfsd4_create_session+0x5b8/0x718 [nfsd]
[24225.817711]  nfsd4_proc_compound+0x4c0/0x710 [nfsd]
[24225.819329]  nfsd_dispatch+0x104/0x248 [nfsd]
[24225.820742]  svc_process_common+0x348/0x808 [sunrpc]
[24225.822294]  svc_process+0xb0/0xc8 [sunrpc]
[24225.823760]  nfsd+0xf0/0x160 [nfsd]
[24225.825006]  kthread+0x134/0x138
[24225.826336]  ret_from_fork+0x10/0x18

Is this patch or patchset can fix this issue? And I'm having trouble 
understanding the commit message "callback channel probe has its own 
synchronization", I'd appreciate it if you could explain in more detail.

Thanks,
ChenXiaoSong.


