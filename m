Return-Path: <linux-nfs+bounces-11949-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA3EAC6B6A
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 16:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759F6164650
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79002874E3;
	Wed, 28 May 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmiVGNHU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792827AC50;
	Wed, 28 May 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748441409; cv=none; b=mKdoNDLRCgJhz8xldERMfx71esfHO++YmF1EpPteXRln80FvHVh36oTEI0F44gfvbZNCb3xcEX53abmkEQcq61S7lV2jYp0F3mFHz8dsXQsLKsGdjJW0Wt7Cy+BhtfLTclWOdIYsvMjiFVvmbyJF/bop4qXU0fqIrtbG9ssL1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748441409; c=relaxed/simple;
	bh=tC5NUiE+rCAqZQe8ytkJqWiWbf0cJ4RmDhgSv5rmL10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCnJSA8Qf9VKQWNNICDg7pnTUKeyiLVErRF8Wp8wl/uOHBRZ5oy+ME817krh3AjpDvRkXvnG+2rsvhA/Ce9QaY/5Xr7GbMo605hT1UmMSepIhUhbDINZhyKs/2ekmk6p5SCqZp6xL6QrubMhOAatpc/j5RfuPk0g2wPEAWyd2MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmiVGNHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9DFC4CEE3;
	Wed, 28 May 2025 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748441408;
	bh=tC5NUiE+rCAqZQe8ytkJqWiWbf0cJ4RmDhgSv5rmL10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MmiVGNHUf8M2wFf0WFu5cQVsZWiAoTUMRPcKVJj4gq4tdxkynu1mYKtHzS/aTcgtO
	 wuUwAZkuMRN9m8g1mtX7OVoVBuNb/yoyuXPcbRTgjUXD2fm7bQxfjmCIp4iu7IZD19
	 BwZGFJz7K7hFpXvPAGrgkm+PAKTvIwsJbBui5RHaNlh8bGNwRmKImKN1yDwGveVXxX
	 odswcry/bsM4u8gxgUQNdHl29s/ibTUIexkndhwj2Wi138D1HPxVwhRTZZpwSEhQIS
	 Pv7nm1Fgy/GOTLg7gN+ZB6tKqUgYRreaK0aF8pesT1oeaDEBw4ZfDVyhTceGLwhUQJ
	 60WTLjrQk04lw==
From: cel@kernel.org
To: jlayton@kernel.org,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	NeilBrown <neil@brown.name>,
	Su Hui <suhui@nfschina.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nfsd: Replace simple_strtoul with kstrtoint in expkey_parse
Date: Wed, 28 May 2025 10:10:03 -0400
Message-ID: <174844138406.135094.10722176151660746055.b4-ty@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527092548.1931636-1-suhui@nfschina.com>
References: <20250527092548.1931636-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 27 May 2025 17:25:49 +0800, Su Hui wrote:
> kstrtoint() is better because simple_strtoul() ignores overflow and the
> type of 'fsidtype' is 'int' rather than 'unsigned long'.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] nfsd: Replace simple_strtoul with kstrtoint in expkey_parse
      commit: 901218eec3b10a773edcdca717dfe5bedde03f46

--
Chuck Lever


