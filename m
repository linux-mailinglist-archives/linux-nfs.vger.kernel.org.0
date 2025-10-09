Return-Path: <linux-nfs+bounces-15103-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A1BCA84D
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 20:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AC91888726
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6470524678D;
	Thu,  9 Oct 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWGR9gSW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F3924DCF7
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032790; cv=none; b=f8fsuxXqwOCnI/0hw+KPDwTfyIkjwonHR0Jn3FMJCPJuZsXiPBWc+NhTbJuns3090n8ejhTsxlOvrY5YLZwWgU81gy5ljVOPYpqE4hbJA324Cmv6SoDO1Gk4g/g8G6pLwoSVFMKq/5LZsrHtFEv0IvcR2qm26r92p3IRGxACPVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032790; c=relaxed/simple;
	bh=wSwGSUrFwyYyy9nZD7yVBO/zbid6FmOKIBRMlNbrmuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdaaCQ7kz9xe/cnDfP93TZ9LwOOuvZPiUVVdxBM11UrhceKLYfNW+mHfmvxJpr767mDALfidH2drP1NBXA6dt9rI+zVnFn5P4hHXOLsiaxCC1xfhgw0+F9BhMYp1wG0Uv9DUvwHgfW4HkhA5Z9eD/HjT+SfsxvxLaKaQuIPUBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWGR9gSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FDAC4CEE7;
	Thu,  9 Oct 2025 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760032789;
	bh=wSwGSUrFwyYyy9nZD7yVBO/zbid6FmOKIBRMlNbrmuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWGR9gSW7SDjPHNZ12pSVzcKLrJOL0jry+zpuckfquc+esowk+cgZBHrqMFtnu2UK
	 Rb1wa+7cFCbNv/yq0kS4G4c23OpXV3GN1hVmlEyttHLkXHw7HkksErOVmMw40xV+EC
	 /u/80fXq2EiFvx+qtzK6HQM0WaWtttVX7MimDMJmPUXQf3AQIq0QbTaUtG9SmMxWam
	 sOE/jxF0MrEyRkRmanvWQR973xKF3pk9tz+PLU8c1bidOjsidENleoGxmu4+lchdfJ
	 +LWmmWHh6UgbDFFdwgN4zyBasszqeFpSqHi4UNQgvK7UVlEJ8oERhx/JedgjKS+Ooj
	 kx5UXF/z92azg==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	NeilBrown <neil@brown.name>
Subject: Re: [PATCH v2] nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from supported attributes
Date: Thu,  9 Oct 2025 13:59:44 -0400
Message-ID: <176003277769.4149.545859393892148978.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009173835.83690-1-okorniev@redhat.com>
References: <20251009173835.83690-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 09 Oct 2025 13:38:35 -0400, Olga Kornievskaia wrote:
> RFC 7862 Section 4.1.2 says that if the server supports CLONE it MUST
> support clone_blksize attribute.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from supported attributes
      commit: fcc43f116744ac6d34f2bd77c1be34e8171d3d3c

--
Chuck Lever <chuck.lever@oracle.com>

