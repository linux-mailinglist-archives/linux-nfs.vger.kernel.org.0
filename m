Return-Path: <linux-nfs+bounces-10994-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB61CA79623
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 21:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED151894BAD
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 19:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C631EE7CB;
	Wed,  2 Apr 2025 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW/0Up+W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095042AF14;
	Wed,  2 Apr 2025 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743623789; cv=none; b=LSsXPEjat9TVHcVEVGUzobUqB/fuC3yMMJfYKH8jGrO/vgTLJdPQXNJAWjeI4+ZvKfT5bY+oMttSb0wW0EAm24LCKJeWXJDsUXIzk5W+z6NNakRUa/6PA1ueH031A7XJ7E0hnXfrsi2hBliVuu1SbEk2JhgwPAdud4P0I3Xi4T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743623789; c=relaxed/simple;
	bh=4lEN8IIdybiPB+uzxrd44PlgsotJF2cfI48sBavvbjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lL9dVXNIvAUFBCJCVuRqrsZX7s2H0VQuc9btrGCUsXz55wyJA4hGReDLTKxct+E+f9pEH05KMKyxcTsJiKhb1EueYoj/bzlw4sWQoW6P3p1ksL8StjXMSkl/ZmWAoln+FAcVN5i8max9tFwUJ09KhMTd/1xRPSToZCFWKD445Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW/0Up+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7F9C4CEDD;
	Wed,  2 Apr 2025 19:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743623788;
	bh=4lEN8IIdybiPB+uzxrd44PlgsotJF2cfI48sBavvbjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UW/0Up+Wt3pNphtpXBq/5KyKrnCxJTyvPjkg8vbpBh5QdD2dzkvWomBsunXefqnC1
	 tK2vtwHp8sUr7K3E9l6elDO1xo6BigThgjtHSTLGHQhCc260lZ50zT+QE5Ts6SZ3p3
	 cnVVPfpL6KDjDMOKfrCsXA+7ZrPfI0R3OBJYRnKEQ7c5oBMycsSVjfE8hJ3znaC8Iv
	 ymsboMjlYqmvJamA43IMEnWd9lACmnMSTR9YoJJV1O/Yti2/dSuWa2zaFqrVfTjeta
	 cxJ4ewcW2CSoGEimaCwF6SBsd0K2PxRqM1a75t3JBPxtBLmhpc7lATlQ8cD+Nc+gme
	 Ium76H0d56wEA==
From: cel@kernel.org
To: linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: add missing selections of CONFIG_CRC32
Date: Wed,  2 Apr 2025 15:56:23 -0400
Message-ID: <174362375580.124554.17129111199347955680.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250401220221.22040-1-ebiggers@kernel.org>
References: <20250401220221.22040-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 01 Apr 2025 15:02:21 -0700, Eric Biggers wrote:
> nfs.ko, nfsd.ko, and lockd.ko all use crc32_le(), which is available
> only when CONFIG_CRC32 is enabled.  But the only NFS kconfig option that
> selected CONFIG_CRC32 was CONFIG_NFS_DEBUG, which is client-specific and
> did not actually guard the use of crc32_le() even on the client.
> 
> The code worked around this bug by only actually calling crc32_le() when
> CONFIG_CRC32 is built-in, instead hard-coding '0' in other cases.  This
> avoided randconfig build errors, and in real kernels the fallback code
> was unlikely to be reached since CONFIG_CRC32 is 'default y'.  But, this
> really needs to just be done properly, especially now that I'm planning
> to update CONFIG_CRC32 to not be 'default y'.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfs: add missing selections of CONFIG_CRC32
      commit: 3d28468e53a519bb8adc0675e5000f56f11e0602

--
Chuck Lever


