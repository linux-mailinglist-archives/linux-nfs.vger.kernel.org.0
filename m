Return-Path: <linux-nfs+bounces-10441-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C870FA4CE44
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 23:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7467A23B0
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 22:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAA11F0E5B;
	Mon,  3 Mar 2025 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+ibnLvJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA611CA9;
	Mon,  3 Mar 2025 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040792; cv=none; b=EILe5wXf/CvcERPXJHIywyveCgJV8IaQkQkn8V+OU7wQbs9/MtmnD9ySAh/AKR/VAFRd7xtrXj2lTFkZ1hpW2/xgXnSVA2qzPqu0wYRoFZIlC0Z0L/hfPhi+1gZVjxfEhIsl8wk/P/QodYShWRaFaCvRdQxsui9N3j+FQso3P0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040792; c=relaxed/simple;
	bh=sKsO4dNLQ1E9U/qUtl2CADnzjPDNXl7y7zE7Zo3mB9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlUEoUOa5Uu7FxjAu8dU04nEzcDKdmXSIMivMGaY98ge25XhnNxU48a8E0N4HOTUFBm/ojMUzKUEKwKqXjyUyw5ONEHwCE6CrW0VHS0Dnk2949T406e/Ffx4dPjfy77BqUEtk9vb5VNrCExF56MJ0aBcgumO4zTPx1iA35z43h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+ibnLvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6218FC4CED6;
	Mon,  3 Mar 2025 22:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741040792;
	bh=sKsO4dNLQ1E9U/qUtl2CADnzjPDNXl7y7zE7Zo3mB9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f+ibnLvJeJdSqITmAtD7ZTQzbfIlw7udhfAPNZomwBr0qMlAT2DYQhXLdAV+k6O/K
	 FVyIdiieTcBPKcOjf/Je3AB5ivuVQvwau8Q6AWKErV1sVfc0wEFngLb8NiakU1wu3P
	 P+Htna4H05lPze5EM+oUVd0r24/ZoZ8vWQVbqtiltE/A0w3tW9twMq1PjE9aQAnNji
	 S6xS3kYOSSqOyU1Cvvb26cwwRCKhXKZKnvFbbMNlnOBwone4PfOoTdba0yXeUEEsuz
	 SK0nEwC7as5eMraMObpocHGKJqQNaWJVHIUq05D8W9SFTwK0PrgvH1bjeKiekT5acy
	 YWVxxP55GamDQ==
From: cel@kernel.org
To: jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Long Li <leo.lilong@huawei.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lonuxli.64@gmail.com
Subject: Re: [PATCH 0/2] sunrpc: Fix issues with cache_detail nextcheck updates
Date: Mon,  3 Mar 2025 17:26:27 -0500
Message-ID: <174104077139.32322.8702101289480612960.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250301064836.3285906-1-leo.lilong@huawei.com>
References: <20250301064836.3285906-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sat, 01 Mar 2025 14:48:34 +0800, Long Li wrote:
> During memory fault injection testing with nfsd restart, I encountered an
> issue where NFS client threads would hang for around 1800 seconds. Analysis
> showed that nfsd threads were blocked for approximately 1800 seconds with
> the following scenario:
> 
>   PID: 3941444  TASK: ffff0000cf170040  CPU: 0    COMMAND: "nfsd"
>    #0 [ffff80008d387120] __switch_to at ffffc4ef3c7a6af0
>    #1 [ffff80008d387170] __schedule at ffffc4ef3c7a73a4
>    #2 [ffff80008d3872c0] schedule at ffffc4ef3c7a8074
>    #3 [ffff80008d387300] schedule_timeout at ffffc4ef3c7b7b60
>    #4 [ffff80008d387470] wait_for_common at ffffc4ef3c7a944c
>    #5 [ffff80008d387560] wait_for_completion_interruptible_timeout at ffffc4ef3c7a9630
>    #6 [ffff80008d387570] cache_wait_req at ffffc4ef3c6804dc
>    #7 [ffff80008d3876f0] cache_check at ffffc4ef3c680740
>    #8 [ffff80008d3877d0] exp_find_key at ffffc4ef3b6e293c
>    #9 [ffff80008d387910] exp_find at ffffc4ef3b6e2ccc
>   #10 [ffff80008d387980] rqst_exp_find at ffffc4ef3b6e445c
>   #11 [ffff80008d3879e0] exp_pseudoroot at ffffc4ef3b6e4984
>   #12 [ffff80008d387a90] nfsd4_putrootfh at ffffc4ef3b6f8720
>   #13 [ffff80008d387ab0] nfsd4_proc_compound at ffffc4ef3b6fe4cc
>   #14 [ffff80008d387b70] nfsd_dispatch at ffffc4ef3b6cf428
>   #15 [ffff80008d387c30] svc_process_common at ffffc4ef3c66235c
>   #16 [ffff80008d387d20] svc_process at ffffc4ef3c6652f8
>   #17 [ffff80008d387d90] svc_recv at ffffc4ef3c68c5d0
>   #18 [ffff80008d387e10] nfsd at ffffc4ef3b6cb968
>   #19 [ffff80008d387e60] kthread at ffffc4ef3ad4aca4
> 
> [...]

Applied to nfsd-testing, thanks!

[1/2] sunrpc: update nextcheck time when adding new cache entries
      commit: c2689130933a68ee9d6bca39ca5c3c7741279ea3
[2/2] sunrpc: fix race in cache cleanup causing stale nextcheck time
      commit: 48a9b0e38470d7f16625dbf51f85d0fb7315b15b

--
Chuck Lever


