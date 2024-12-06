Return-Path: <linux-nfs+bounces-8401-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAB19E7B34
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 22:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB221885E30
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 21:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D8D1AAA3A;
	Fri,  6 Dec 2024 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy4Omo7z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BDA22C6C3
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522195; cv=none; b=OG+NkY+8UXJfyDendCIbYwE4UtRM/8/jS4mga4Rjt9dCrES0/w+CeJ0RYwUPkpkFyRdH1uG+ys1q55lcU6NecV40/x/OL0rkK/KBQnSmEY8gE1uesQvx37xUrcFL1OcLanuV+CXph3LxuNSy5xjv3s2YgUGYmeDPTXHa2RMYi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522195; c=relaxed/simple;
	bh=XIkFEw5ClcNqk83odWvidPMRr0ufIgEowdu6iHACqQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQC9FAFtMtAF8HupAwAKYnSorIJffYWmcgdJitTsYD2j9lGFVcFBvCFHvbeyTLB9/Ohohj583Ufz0gxehhjLVXYF1575GxIhtIuuH/1PUj085/jcGke/pfb+0zg/aulZlXzB7OGZlryucgfvO1bxUI5qkHVJu3L06hrOB09U1X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy4Omo7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E14C4CED1;
	Fri,  6 Dec 2024 21:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733522194;
	bh=XIkFEw5ClcNqk83odWvidPMRr0ufIgEowdu6iHACqQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jy4Omo7zfV5Ka0NiAWipxhrvfGPtBWgrsUJy5H/3DZlNJMp8RYOu8DVhk3Wpa3vRs
	 qKNkXQ7uI7bOVkBqOWrDG+jKr1Z5wXDvBR5C7e5BRce83XlLFJ/xPXeyCD5jG+5mD+
	 THTS6yyfqw55AidcQ1tj8rNoetXbo/P9ccl63g5DbzIyH/ZFMiTzPu9XCx2HnTi70Y
	 /oZsMTD+zrC/7tFC3iWEVfwbyyY8tzYQhP7gmo9qagUWCXQkUZFZK/8hsJxPoOhtRD
	 A60tz7rKOCGm0iuD60FvSLqupPhcnGUqplyUzClavYH/yEiXXgIzI9HzPRFxOFUmTP
	 JlatNEp9hJhlQ==
From: cel@kernel.org
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/2] nfsd: use new wake_up_var interface
Date: Fri,  6 Dec 2024 16:56:28 -0500
Message-ID: <173352216221.458035.12030085264827993988.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206025723.3537777-1-neilb@suse.de>
References: <20241206025723.3537777-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 06 Dec 2024 13:55:51 +1100, NeilBrown wrote:
> wake_up_var() in a fragile interface as it sometimes needs a memory
> barrier before it.  Recently new interfaces were added which include all
> required barriers.
> 
> These patches update nfsd and svc parrts of sunrpc to use new interfaces
> where appropriate.
> 
> [...]

Applied to nfsd-testing for v6.14, thanks!

[1/2] nfsd: use new wake_up_var interfaces.
      commit: 70b79974d849d8ff1f60295c03600f9c9db4da05
[2/2] sunrpc/svc: use store_release_wake_up()
      commit: 101543f023804bc0e62a2fdb15e143c022fedc7c

--
Chuck Lever


