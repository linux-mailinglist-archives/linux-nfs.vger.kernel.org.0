Return-Path: <linux-nfs+bounces-9984-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C192EA2DF0E
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 17:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2661648ED
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 16:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42231DF737;
	Sun,  9 Feb 2025 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spXQ7zNq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A91CAA94;
	Sun,  9 Feb 2025 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739117688; cv=none; b=NOo63B3wYdrtnYmcuZiXynv5iPYGSGq/L/8PwcWEvbD/kRQFDmtgJvtePPPU8KDATOeNURLxY6WogHjb5TixKnun6XwJbmRjh4ssBm/wuM/qiAgFW8moDqANVqlUdqyZssfJKvlJ/97yod511tYpkM/UMs6LG8cXPOYNgAJ0EUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739117688; c=relaxed/simple;
	bh=o7t3GlfNmSmomEmhzTP7sg+4ra8TNBtvuC45jw3kd4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+Q1vHG/d9n/gg3Dzz6hBOXjvTcEk2lKxd3c1a5TbPsKX2KrYkQlLLMPMHtp0eGQLc/g+qyz0pm7buv6fctiCwxAPyHMN2808ENRKIGQMuKiOjULhx6SQk2Bidol9YSOhzithAOHMw8OHycDngA4yR2ZAJ2OKgXCr0Z3XDrcpow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spXQ7zNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534A9C4CEDD;
	Sun,  9 Feb 2025 16:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739117688;
	bh=o7t3GlfNmSmomEmhzTP7sg+4ra8TNBtvuC45jw3kd4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spXQ7zNqdGlHJ6VNwtu5K0UJw1oTcqo1FgBbgh7/MazLofvkDyrAwagYvZOPCH19y
	 AXyQZgqZp3fL061PYLQbegVhhCfGhFTO0feLvQnDnvZgdMUH3VZPCYu4hE5fZwCYmI
	 KoI1WfYmDV4rJR9SdL+hwCEkchztnbe6SpwMe4H/ylVlU6EYIGx4O1PmI3jhYSx8zs
	 Xm1GTcheEc/qfMDtPgnPzsWi1eyPDrJjfoNJewyu2FiKB2eUgzHUUa0rNeEkPRBES8
	 38DrgCRbmWA+IZxqxrniH2l0Uvp6gyE/bRhxXoh3sUTCAKIiWc4m2WY4fM/X5In+49
	 kfvJFDfnAX7rw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] nfsd: CB_SEQUENCE error handling fixes and cleanups
Date: Sun,  9 Feb 2025 11:14:44 -0500
Message-ID: <173911760206.97922.9559360232269811403.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
References: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sun, 09 Feb 2025 07:31:21 -0500, Jeff Layton wrote:
> This patch is mostly the same as the v5 series. Just small cleanups
> and dropping of special NFS4ERR_SEQ_MISORDERED handling.
> 
> 

Nice work. The comments and change logs contain good rationale
for the code modifications, and the new code should be easier
to maintain.

Applied to nfsd-testing, thanks!

[1/7] nfsd: prepare nfsd4_cb_sequence_done() for error handling rework
      commit: 61d4e0b9d8e47ec93a90f57f8ec76a5b7ba970ea
[2/7] nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
      commit: 62dc8f549352ed1a38738112f9cf946b7e97e10a
[3/7] nfsd: always release slot when requeueing callback
      commit: 8d09824221012b221cfc1caa76215c6b4bba3e24
[4/7] nfsd: only check RPC_SIGNALLED() when restarting rpc_task
      commit: dde7c58af30ee0dc13cc47c7d57da9102124597d
[5/7] nfsd: when CB_SEQUENCE gets ESERVERFAULT don't increment seq_nr
      commit: 90b44566f9024e0edc8373ef72e39bc162286bc5
[6/7] nfsd: handle NFS4ERR_BADSLOT on CB_SEQUENCE better
      commit: 7f7c89cb74dd8d5484837256bc14a77de8d91075
[7/7] nfsd: eliminate special handling of NFS4ERR_SEQ_MISORDERED
      commit: 58e65798b82f31aeb6c85c8db13179a0a1bf2b2f

--
Chuck Lever


