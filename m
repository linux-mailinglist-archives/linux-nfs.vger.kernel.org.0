Return-Path: <linux-nfs+bounces-6358-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E159723C3
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 22:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EA11F23DEF
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 20:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE16189F45;
	Mon,  9 Sep 2024 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2VMXabj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68724175D20
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914153; cv=none; b=kzJfCDs5r06xxprKSE9znHi3+DM2uMfws27EjX+q5pssloZmcFpisI+M88DGopxeXPk84ISighX0DNoacxJ59xrWjYWTrh7wMBt6Skg7q9ylNpAfyC0uS7uWQMGffxxls71Sy5FReaD7ALgxTIsx59ODSgPKxwj5DTwfp64oqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914153; c=relaxed/simple;
	bh=hjPIUN4kUx5+2QvySDr27TSjQYFDlKRATbWqPj9q4Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkZhilj1IratAyzdgA3v4Lwddld7SAqcmw6PvW2kQcSbcKPmEh2kBn4HPMx7KvHpSiJNw/p4fGhh80mJ1Zh8RdawNyYxXA3Q5noKd9p1KIEaTAfqioYFVpeQWnIUPbFdFjmkM36utZKKwnATuhQB9wm9/HLwGA4XvkCxL8kCP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2VMXabj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2C7C4CEC5;
	Mon,  9 Sep 2024 20:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725914152;
	bh=hjPIUN4kUx5+2QvySDr27TSjQYFDlKRATbWqPj9q4Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A2VMXabjK2r04FMJCvtRrajcAxPFud1cjSN/FQ0N0hY2J1MXQBXPGDJ61dxC53EuT
	 mHozZELis2SRTXsY+J5bLwLxWtG8+hdvKaxmziy8lVGn6K4DB8jorRahUjr1kSPytt
	 5KUi2g4Rclfc1XRYOQoyhJXRqjY21AuK1CgcpSmgC/yETFB4Pq0LtyPX5rQdA/vkfH
	 X7cud1r4Iem7di8lVXPBkxvnzjhFtml5cnMAhtZc4T2yHI2YZHVPbHt7RhU241fEWR
	 pUdRMpOye6RX/j9fISc0gkfLw/PLgNmMrklznmjfvyeiOTWM1bjDRJwTgXZ6QkZjm4
	 6ZfEZb4rvHO5Q==
From: cel@kernel.org
To: Scott Mayhew <smayhew@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/1] nfsd: enforce upper limit for namelen in __cld_pipe_inprogress_downcall()
Date: Mon,  9 Sep 2024 16:35:46 -0400
Message-ID: <172591411804.84357.17027994153109786918.b4-ty@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909202855.510399-1-smayhew@redhat.com>
References: <Zt8BuA4gxVMpBUcW@tissot.1015granger.net> <20240909202855.510399-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 09 Sep 2024 16:28:53 -0400, Scott Mayhew wrote:                                              
> diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
> index 03016fb9..fb900c7b 100644
>                                                                         

Applied to nfsd-next for v6.12, thanks!                                                                

[1/1] nfsd: enforce upper limit for namelen in __cld_pipe_inprogress_downcall()
      commit: 2760ad9b89938ce09705ab30e2087c1fb29a5bb4                                                                      

--                                                                              
Chuck Lever


