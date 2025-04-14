Return-Path: <linux-nfs+bounces-11129-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC2DA889D1
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Apr 2025 19:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229441898887
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Apr 2025 17:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FC9289360;
	Mon, 14 Apr 2025 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnCBuiYR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48681284664;
	Mon, 14 Apr 2025 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651748; cv=none; b=ncpTvL7/vsDAiTytEzX4/GuyRZNH+S/V4EWiIw8IUja7PLkCjuJ+Q4a6omUV092fLbAIVTacxowvOZPN0MPCCcCE3yKb3JVCkkRQxIaG+/X+DJPWvZav7U6CiYBOPzRFIwSU7En9/18JLkWlu6oW8VGTt8t2SiOc2k+i86qSSME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651748; c=relaxed/simple;
	bh=2LwujIMcoVo/g6CQX8qVI4v8Y7PUKl68g94gIm8Qgzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYklIG3JTxQ2TjiR1ycmBPZr4QezHCGK4AQDulnjDW4jwHEhVIP+NkmYw6AHyheignqEunAUwrElCYSQ109p3JK4eIBJHCot1E0nT+Mnos+fYgeKfPceEn8APvL9t95FRPMGG/hF7ASp/Gkq/+3Qyk0oTlVxFDDav028Np0P8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnCBuiYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAB3C4CEE2;
	Mon, 14 Apr 2025 17:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744651747;
	bh=2LwujIMcoVo/g6CQX8qVI4v8Y7PUKl68g94gIm8Qgzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JnCBuiYRzqonBU7B1877cTLwtpZuADmhQAgVCfm39GeVzRGfbweIlv7TkbYwcY7sU
	 qAUIf4F1ykm4ENI6Y5aXU0BAdyvDgh2HP/CcX8iSf8VnOwFjlyUZ6BTK07QgWy5c+W
	 /DDYwdO1jJPcO1RhxD6lZcPXTHkN5d2dzRUP6MoUzdsoM02bhWZmxB8Ik2mqVifzfG
	 nOPJKTLb5XG1QftgNTXsCvp5W/IduO/YN80HoHqDNLCuDMz23XMlNDyssnnwMmtivp
	 +nlK40VkvCoKSsaIPSbI+7x1K+cYR8XRngdnUMEEYF+iku2weEOtbu0ui/sVwSo+ee
	 c19l1NTuFPpXQ==
From: cel@kernel.org
To: jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Li Lingfeng <lilingfeng3@huawei.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lilingfeng@huaweicloud.com
Subject: Re: [PATCH] nfsd: Initialize ssc before laundromat_work to prevent NULL dereference
Date: Mon, 14 Apr 2025 13:29:03 -0400
Message-ID: <174465166461.41191.18027879549273675051.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250414143852.1308979-1-lilingfeng3@huawei.com>
References: <20250414143852.1308979-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 14 Apr 2025 22:38:52 +0800, Li Lingfeng wrote:
> In nfs4_state_start_net(), laundromat_work may access nfsd_ssc through
> nfs4_laundromat -> nfsd4_ssc_expire_umount. If nfsd_ssc isn't initialized,
> this can cause NULL pointer dereference.
> 
> Normally the delayed start of laundromat_work allows sufficient time for
> nfsd_ssc initialization to complete. However, when the kernel waits too
> long for userspace responses (e.g. in nfs4_state_start_net ->
> nfsd4_end_grace -> nfsd4_record_grace_done -> nfsd4_cld_grace_done ->
> cld_pipe_upcall -> __cld_pipe_upcall -> wait_for_completion path), the
> delayed work may start before nfsd_ssc initialization finishes.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: Initialize ssc before laundromat_work to prevent NULL dereference
      commit: 05d68df60b9af7765c38073ff117169aa5f52310

--
Chuck Lever


