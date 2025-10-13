Return-Path: <linux-nfs+bounces-15181-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F68EBD354E
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 16:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A8F634C83F
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 14:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ED31F2380;
	Mon, 13 Oct 2025 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aN/wOoAE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA221A447
	for <linux-nfs@vger.kernel.org>; Mon, 13 Oct 2025 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364259; cv=none; b=Z7isaPOrB2i3PP95A2kX1x/AuVbp7AI/asuQ+WAsKr7psc7kmzS6sypOPLWGj8C5+HAU+pLLwrM1iQt1EfzKCZ+gvHyHF+46EgbSHxgemrmeXQgU3g1/dS5BWoEOnOJ2IeF6DhnjqQufVqINmqtdTMi4lJG8VR9X1y28I1nrLGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364259; c=relaxed/simple;
	bh=e90jufusVFKDkTNdj+v8XfVr8eB1h0iESSC5oJAs18A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFCZbnNY7dzHNDsZac6nxLkWJyUjCx95G4Nw+A1tQsv5dudkCWWm2tzJTpNA2NMOS9xUoDpP8+eluPVqAthVvKgo/y7Gsf+HkWTKDFFh40EDDA/ECLrOzggeG7rbahenoGJeQvp2s5ddL71qBWae8qMDdFkmzIWuVyX6n8I+RIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aN/wOoAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9028C4CEE7;
	Mon, 13 Oct 2025 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760364259;
	bh=e90jufusVFKDkTNdj+v8XfVr8eB1h0iESSC5oJAs18A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aN/wOoAEcf1d1ysWtz/acHiLC6W0/kJK8gFaN3/SmrQoM8KI39naw1e08jz6v+SLF
	 58ilNoS/19uQplQTKC7o671j6cs/OdyGHjVrzgzb8PvQY7sSMzhJdSf23H+VVnt7XL
	 ninK3s/cUYjGBV2MbSYsOCW5hPqATUjDAO6QUYb3IxF1U9FJF07b4dOOJB6wfmxUsj
	 6UK7ZpzxQjOVGbCZCsnLdLGhn9KT6raOPnvTjXivkFZ9z32GasLkU+LF4pa0LkGWXF
	 Smk+PjCiiqYuQJriQc5NeS5ugZJ/zC1c887Mh5yKLhMzc7SAngWAbLDY3RqWDWOm0t
	 ylnJcxvveYxLQ==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	NeilBrown <neil@brown.name>
Subject: Re: [PATCH v3] nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from supported attributes
Date: Mon, 13 Oct 2025 10:04:15 -0400
Message-ID: <176036424260.12421.9660666296871750379.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009203759.87870-1-okorniev@redhat.com>
References: <20251009203759.87870-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 09 Oct 2025 16:37:59 -0400, Olga Kornievskaia wrote:
> RFC 7862 Section 4.1.2 says that if the server supports CLONE it MUST
> support clone_blksize attribute.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from supported attributes
      commit: 6e7b714679d28da7bd91b3f4656bf0865d6006b6

--
Chuck Lever <chuck.lever@oracle.com>

