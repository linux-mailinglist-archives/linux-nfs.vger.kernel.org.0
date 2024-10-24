Return-Path: <linux-nfs+bounces-7424-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1AC9AE5CF
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 15:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C21AB24B66
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 13:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A50F1D2207;
	Thu, 24 Oct 2024 13:15:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C341AF0BC;
	Thu, 24 Oct 2024 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775757; cv=none; b=P8MERIY7TrLJDMDygi78mXc83xG7TTY+hVp3itJKoa0afZeDgZ3mZDHHcE1FKiqjitmOihxIjnSBVS5SMviJtue5cDUZgGKivXZafEiPe8QfbPBQCtzXFNh+vBIKfEcBOexOxclSc9GMrsYbSoIF5c8bnRXnDi4CxxzDDr+IR6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775757; c=relaxed/simple;
	bh=8+zYBhUVLK61D2TwrFLMSrE5LXGFSS00+qrwplAWp/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fml2xHdvKzghkTW9lAPSKh6nF+zb3LC5veEgtTdQAFJ15bkVPgQzwGVplQkgZYBhAPffnciHLIe0+8kEYw3kGiMsosRM9p0t9UEU6Y5Og5RbCwcmelQErPIabJ1jTJn/S2GAOtzHpTUhEsZo+B0A24R7pOrGyUfidx2uz/nFz1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A06BC4CEC7;
	Thu, 24 Oct 2024 13:15:53 +0000 (UTC)
From: Chuck Lever <chuck.lever@oracle.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	joel.granados@kernel.org,
	linux@weissschuh.net,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	Ye Bin <yebin@huaweicloud.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	yebin10@huawei.com,
	zhangxiaoxu5@huawei.com
Subject: Re: [PATCH] svcrdma: fix miss destroy percpu_counter in svc_rdma_proc_init()
Date: Thu, 24 Oct 2024 09:15:32 -0400
Message-ID: <172977515008.2386.365430128275371946.b4-ty@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241024015520.1448198-1-yebin@huaweicloud.com>
References: <20241024015520.1448198-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=8+zYBhUVLK61D2TwrFLMSrE5LXGFSS00+qrwplAWp/E=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnGkh8Ima3PUwfMfNTvXEaT9jPh5sVzQaLcYUtg DGNTEVPRJGJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZxpIfAAKCRAzarMzb2Z/ l+FCD/0SMwcfLpqSmCnGlK+MfSuVl/i8a8yJxDfystE2x55TH1wiAnh9cmle04upLxLcYtGWvi+ LEd7KEz0ao/axl0Xr31dB/lGjSzrnRDepEqr61NmHTwfTpsnZcfChQrKayRH72kcNYAV5+YOh5Y HAFJmHnEg650+AwRzKQlyhJpmrFV5p75rmeZxcE905TBBxkFckxupgK4uoPHtH+tpEVRVHBXCMu Eyjif2wXCdgncQoYdsORXtEjPc+EwiqEmMs4EE+EwbqVMW3gDlsUnytfexksqjHITCPD36x/1k8 6DmT+WK12znI4DRGxWzv7NKr4uUl/3twleS8jnyqt4ytXIMG+FnvnOfyo+XkDpeRuBD0EUunnRi qjt4LBUk+wdsIebmLCRsOsfvHLbWk3YJ8lClIWMJfGEfu3DWGeyVnq+FLy85mM3A02iUkfUk1mi x6k0JdPF/kL4m3sUlCKO5KzDufu5lVr5ETIZ+Zt2xEaerZYmphr+ttm8HhPm0ZvPde5dO3s4hDo 2BydIBW7mHD8kszb9tdb3DCkgBUJGMeKgNNO8vtw9DeCBbjCl/7VmsjNRI51vygSMGI00yhOAkR 4N0/dK9O8aUuUryLQgc34voru/EbPvV2YNN+rBkiaOYElwgxuZ/HcfBIDJxpAOKLw7RusDAilSe hihiQw
 pnjTjWhqQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

On Thu, 24 Oct 2024 09:55:20 +0800, Ye Bin wrote:
> There's issue as follows:
> RPC: Registered rdma transport module.
> RPC: Registered rdma backchannel transport module.
> RPC: Unregistered rdma transport module.
> RPC: Unregistered rdma backchannel transport module.
> BUG: unable to handle page fault for address: fffffbfff80c609a
> PGD 123fee067 P4D 123fee067 PUD 123fea067 PMD 10c624067 PTE 0
> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> RIP: 0010:percpu_counter_destroy_many+0xf7/0x2a0
> Call Trace:
>  <TASK>
>  __die+0x1f/0x70
>  page_fault_oops+0x2cd/0x860
>  spurious_kernel_fault+0x36/0x450
>  do_kern_addr_fault+0xca/0x100
>  exc_page_fault+0x128/0x150
>  asm_exc_page_fault+0x26/0x30
>  percpu_counter_destroy_many+0xf7/0x2a0
>  mmdrop+0x209/0x350
>  finish_task_switch.isra.0+0x481/0x840
>  schedule_tail+0xe/0xd0
>  ret_from_fork+0x23/0x80
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> [...]

Applied to nfsd-next for v6.13, thanks!

[1/1] svcrdma: fix miss destroy percpu_counter in svc_rdma_proc_init()
      commit: cd0f8809d24b55390eab29a02a595641531e4390

--
Chuck Lever <chuck.lever@oracle.com>

