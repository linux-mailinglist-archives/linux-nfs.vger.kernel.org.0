Return-Path: <linux-nfs+bounces-15293-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B66BE3D47
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 15:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 751CB4E1D0C
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AB933CEA1;
	Thu, 16 Oct 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gjhf51Pd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBF733CE9F
	for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760623146; cv=none; b=iuDl0WTF0Q/Ztm+qlY59d8HL840jx/ekCSBtuG1vQ70RCsmyl3t63vZ4AbNHAZXWEziJYztZT8shEhVszAZSN1fn/NIjRlkf4NryIrdsRw/HAQe/dIiDAIpwlFfisA/ZYZrjriUmoOgz7YR3prSqlMSaW3jBhaHvtoEVSn5m728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760623146; c=relaxed/simple;
	bh=3OQOwg/LRHhfm/F3k9m8itqjqzyd3JYAC8fd8CBi8zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gL5gv/5n/huniWJ+bLEeC/pFn6bVHCzIMSwC0/ihJn0qmX+FhVndKVKlO7gOxIpW4EOWasFwP6ClgrFIdMg0rSwrolsTj98A8Heuvtk0Zm034rfyaR4o8LqmrQUhvOnEPtWMAyXST2CIJ4A/NkmYg7vyvkDJG/DuDnB3jnW+v44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gjhf51Pd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666D2C4CEF1;
	Thu, 16 Oct 2025 13:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760623144;
	bh=3OQOwg/LRHhfm/F3k9m8itqjqzyd3JYAC8fd8CBi8zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gjhf51PdJfK4imLrRttgi2ka6jMy0inNtL2K7/aomozMDAl+prP7aKtAclIp6iYTM
	 PkL1mTATbIcUvO8Mj7SOFhm/BGoSMn6ICZQadQmdXwdeATxlGyU9Ju1xyfzJioydj8
	 2DPtBB5g5mt54+TEPLcKgoXkMN5M2+GRXdQOrWcb/0feclxaZ5rFq4S++uIw0U5SA2
	 udlggpX5SJQOEkTbU60QW8DcX9jAH2CGbVQCTycIQtROFtBaVEssIBly1sU/meRnHA
	 EwqU9uyS0OxufHYP7m0J5PDI788eYek+uvTeakplqbujXFYgQaOH0GHheLbj0xp3Qs
	 54470hSt0oNHQ==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@ownmail.net>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 0/2] nfds: fix up v4.1 slot-based replay handling
Date: Thu, 16 Oct 2025 09:59:00 -0400
Message-ID: <176062313361.16631.6207601690258883852.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016013310.2518564-1-neilb@ownmail.net>
References: <20251016013310.2518564-1-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 16 Oct 2025 12:31:12 +1100, NeilBrown wrote:
> v3 - with the fix to nfsd4_encode_sequence() in the first patch
> plus some minor cosmetic changes as requested.
> 
> NeilBrown
> 
> [PATCH v3 1/2] nfsd: ensure SEQUENCE replay sends a valid reply.
>  [PATCH v3 2/2] nfsd: stop pretending that we cache the SEQUENCE
> 
> [...]

Applied to nfsd-testing, thanks!

[1/2] nfsd: ensure SEQUENCE replay sends a valid reply.
      commit: 337a6c1fcbfb6612067fc75e2668739e3ed7115a
[2/2] nfsd: stop pretending that we cache the SEQUENCE reply.
      commit: e51cf313aae1b04edb5953751028bda51c5d5952

--
Chuck Lever


