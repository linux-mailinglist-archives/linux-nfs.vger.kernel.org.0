Return-Path: <linux-nfs+bounces-17658-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65000D05ACA
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 19:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5E2B32E2613
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 18:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EEC3126D3;
	Thu,  8 Jan 2026 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sg/88xyv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908393126AB
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896774; cv=none; b=rsnsbY1fMY2VbX2psGhS1LXNbDz90x1XvoP6OuTft5cG5ZtbDw+DP/XzFUfc/o5572aipx/GXvvv7zGuZYCmkduciiV+sCsfqc0kigtcTxfPUfhl+XqcPlNo3DLU6Ij4mIH2bFLGswn1unQJ29/Fos7ZnJgD2rFDy/lCg2a2Eos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896774; c=relaxed/simple;
	bh=wJt5dUPaWNKLlkdSoOatIPri5z9PuH8IbZC75D8ceDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/YPyI5eoa0wzGqFEY4Vwjt4a+QmdVR8a9f4m8pg26otzqc+kgUCUbTKfzSYLmJy8EcC8R5prMFJy8JzvxYHOSGW/OEfDleycf74CP36lKlM8cLeizDWIC43JloJ4zHW93v524XLXEfwVFSfO0X75nQNbdB+T09FEuD3oN646Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sg/88xyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD8EC116C6;
	Thu,  8 Jan 2026 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767896774;
	bh=wJt5dUPaWNKLlkdSoOatIPri5z9PuH8IbZC75D8ceDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sg/88xyv/3JTrxUnZpkTP8x9fvabgWC+L4SyF8G8GmlAzRQIoaNtmsY5/sETCx1mE
	 HPfk8XP3GdZHIAmb1a+OWHw5Nii6e1UVnvstA90Aqi0/ZOYKn/1FQrR2xykSTCL3kK
	 32wzINbISSS6//NVPxwKM/LwUWUh6/thbe3l7JuMK4lF2e64AN+3Ypjt8hJJ8fZGnP
	 EvdX8unekzNLVhOd9JkpSpmhr6H7M/Bu6jauqdcoO3dOPmwOB/DVDu7PwkbjQvExCG
	 mGVUmQDBsbQkblVnV1usihdMHuOPTCMPC2gEFpe7F/QHogXC03z5A13BbXtAifwHnV
	 qk4cQYRwa5JPw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH v6] NFSD: Track SCSI Persistent Registration Fencing per Client with xarray
Date: Thu,  8 Jan 2026 13:26:10 -0500
Message-ID: <176789674088.4061225.21652628988289952.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144421.3955020-1-cel@kernel.org>
References: <20260108144421.3955020-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 08 Jan 2026 09:44:21 -0500, Chuck Lever wrote:
> When a client holding pNFS SCSI layouts becomes unresponsive, the
> server revokes access by preempting the client's SCSI persistent
> reservation key. A layout recall is issued for each layout the
> client holds; if the client fails to respond, each recall triggers
> a fence operation. The first preempt for a given device succeeds
> and removes the client's key registration. Subsequent preempts for
> the same device fail because the key is no longer registered.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: Track SCSI Persistent Registration Fencing per Client with xarray
      commit: d0eb03e22c6ab956dc9c91c7a1b04b02556987c9

--
Chuck Lever


