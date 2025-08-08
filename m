Return-Path: <linux-nfs+bounces-13512-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26757B1EA82
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 16:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E7A3B4871
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 14:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5203127814A;
	Fri,  8 Aug 2025 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnVP5Ihh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4A024B26
	for <linux-nfs@vger.kernel.org>; Fri,  8 Aug 2025 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664056; cv=none; b=FGsarKglOTg9gMyxViMxvb4tUEy4gmLwr25AaNGsnkcSY6SZkaBacMAAGmoLzgfIMFJTj6RZg6MgE2osfvRfsU+VfPyvURszzcQbB9w2VXTFB+CCcqP+XasOH7i0/LShHm2oVyVR/pgxPDFFeHsPTwSc8YKh73UJGMGP8UnllWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664056; c=relaxed/simple;
	bh=sXbxhFQYFm7YKVfyxQPAsI1nTdtoao81cWsEcEqVqLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtZy89l2GTTRxpeEaOWvQc/LkiSAqpY+r/Zoyl7wsrN+eOuiGd1IUGzRvyTmlnIfPLzz6ijgVAd0+/zxDjx5KyFJi1hahEymyNO9xb2l2wgzjAJhdDICu/MzcZ6n1M7paQOLMcbTL4Y4f0y43JKz+e73lSOPo4We6du+wtfSsu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnVP5Ihh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E5AC4CEED;
	Fri,  8 Aug 2025 14:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754664055;
	bh=sXbxhFQYFm7YKVfyxQPAsI1nTdtoao81cWsEcEqVqLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DnVP5Ihh/S2Yy+UzkZGUGnhGy+ieX8zktay7SNoSrXzD5vLWdmFUksElkvC7/oLXW
	 WLovU1mkLMgIVUVT0X8kFDekFU7xTDbwge34KS9ch7MtIPhmHpnca1kjo23H6imxba
	 +69nRKvWpHw0QOb+/Q85CX68WMWFjBPvop7w8s9WTd4X+t0oRvLwO1mmI9gT0SXQo6
	 MwEb4PyjVT4dgbhEb6My5BNQxMnU/mMFO/5dvIawfNFbwpm9Dx88H/dUBmQ1hRo7Sp
	 N5FaNhA24heRKlv7ux/WifYL3ir3sgrUAh7HNu0QKcJMKpLzt0ni1MYq51IxRrpo3L
	 8rqUh3BrjqdfQ==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Scott Mayhew <smayhew@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: decouple the xprtsec policy check from check_nfsd_access()
Date: Fri,  8 Aug 2025 10:40:49 -0400
Message-ID: <175466399816.118560.4351603388872895733.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250806191543.2348885-1-smayhew@redhat.com>
References: <20250806191543.2348885-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 06 Aug 2025 15:15:43 -0400, Scott Mayhew wrote:
> A while back I had reported that an NFSv3 client could successfully
> mount using '-o xprtsec=none' an export that had been exported with
> 'xprtsec=tls:mtls'.  By "successfully" I mean that the mount command
> would succeed and the mount would show up in /proc/mount.  Attempting to
> do anything futher with the mount would be met with NFS3ERR_ACCES.
> 
> This was fixed (albeit accidentally) by bb4f07f2409c ("nfsd: Fix
> NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT") and was
> subsequently re-broken by 0813c5f01249 ("nfsd: fix access checking for
> NLM under XPRTSEC policies").
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: decouple the xprtsec policy check from check_nfsd_access()
      commit: c8f9c4c2f1f28f61d073c0834f2a61521a57ad3a

--
Chuck Lever


