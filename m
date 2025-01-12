Return-Path: <linux-nfs+bounces-9149-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4248CA0AB99
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jan 2025 20:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DA11665A7
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jan 2025 19:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEE51BEF9B;
	Sun, 12 Jan 2025 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPKbVcxC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711A914F102;
	Sun, 12 Jan 2025 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736708772; cv=none; b=HK4fvVSVq5F97MdSFRtT9zgFrQNZPOKMVXY3/IGumJGM2g+kbPB1g1pjfZC3xz3+xTagKP+/qeqfwAkBmS/pI86GJd3/KNp6z6L/C7bFdA+AmXbJ+OykAjW0Ey+abA4asMdhEx0RxHb7S6r4bWl2AbFJjfE7kjSKxxrNDHfjyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736708772; c=relaxed/simple;
	bh=qkD95bR+axvvViVaHc38JcPMdV/ZQZ0ca3liSq2GwTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTS0a7jGoRwAwWgzq6fgn3ojS8LaLSDvH4s1AwaBe2q3slFq198Io5EZn56BXXrQcnC6Z7LMNuuJGOkHaBy28BR1Q9ThDKj02g2FXJRrl+1LqZoK9/P8G4N2K5JHgXCdGZEYrQ15zjAphxtgdEXHJIO/6mqgGUo6BtcfeTRgw1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPKbVcxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2094C4CEDF;
	Sun, 12 Jan 2025 19:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736708772;
	bh=qkD95bR+axvvViVaHc38JcPMdV/ZQZ0ca3liSq2GwTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WPKbVcxCdOydTom41wWc+BJ3hkz+dgKvbIEt74IVx+BHTNnlx36e4vqOskg32FcW1
	 KM3/G4NNaABKl0rH2DdGD7X5bbmqzSw11QK8MgijZ9V+oRZnRdP5VuUQyozNRWif3i
	 L7VmGUUk7gMxsshWTnPn1/AiVPWj57Axv81Yb2rqfHqwuMVDW8YTsqF6mrVz4IzGPo
	 rKEsy65eqsiwFI3sVFbKr+yB4Gi1Jfv7SwUXJKMfQ5pgwj4cyjxoR05+E7G3kNb2lf
	 feiBocVLn8Tr7wght/D5ycg98k7ykDYkBTR5A+6GXjL71dciWIh0LSSVjNnc0kdLhK
	 aHvbUAAzf9d3Q==
From: cel@kernel.org
To: trondmy@kernel.org,
	anna@kernel.org,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux@treblig.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Remove unused krb5_decrypt
Date: Sun, 12 Jan 2025 14:06:07 -0500
Message-ID: <173670873194.6037.17383805217745191281.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250112162015.454346-1-linux@treblig.org>
References: <20250112162015.454346-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sun, 12 Jan 2025 16:20:15 +0000, linux@treblig.org wrote:
> The last use of krb5_decrypt() was removed in 2023 by
> commit 2a9893f796a3 ("SUNRPC:
> Remove net/sunrpc/auth_gss/gss_krb5_seqnum.c")
> 
> Remove it.
> 
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] SUNRPC: Remove unused krb5_decrypt
      commit: 155340eed2560b136e05eb3acf485c7aae11be46

--
Chuck Lever


