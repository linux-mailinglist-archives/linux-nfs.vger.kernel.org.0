Return-Path: <linux-nfs+bounces-10155-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C042AA386B2
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Feb 2025 15:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FC33A8FC7
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Feb 2025 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDE122333C;
	Mon, 17 Feb 2025 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNBjO0Yb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A25221560;
	Mon, 17 Feb 2025 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802881; cv=none; b=JSh8xP0tFS91hDiDVi1JUwS6RjB2Bistc8W6hHxa7B2ClqWBs31AbBy4g/OMWoUcT4OWZ/Lumr0ERDCebIUwC/xLHbZpNxCUh07q383Ymt/X94HmjJyLu++sFDrtkDOjoLqggiAlnzWeIxFGvylxy7VQIATLAaNX4hK1QZQy9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802881; c=relaxed/simple;
	bh=IMyuJRD+h7mObgKzJNFiy6OSAqz5yQA0Nt2tPluvGVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjPl+cgZxw/uBa7B66HomneNufnAHcX0I1DjLn+W4BgZD0BFyR0iOyK9mkaQNsT3Hl+lRWmMXB9FozsPe1n5KH6DrDbFO0+EIZIWNAfHu+5ga5dQfXECxdsvh+N86HnTM10z+0juKFLqZ4unzQOe6FMsGwFA97UdB8BpnqJrJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNBjO0Yb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C04C4CEE8;
	Mon, 17 Feb 2025 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739802880;
	bh=IMyuJRD+h7mObgKzJNFiy6OSAqz5yQA0Nt2tPluvGVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tNBjO0YbmUoabpszKyTe/4YLZQzFobnOTtwIoeUHUMqvpMbT7K9EfXQ6ZenFvMG0+
	 4Wzl8XJXfAN3Xr5mhu9Bch3BVuR1RiULrKMhTFy7c0W1IT6t7IBj6qf5yTw6fA/N1x
	 /J0fxKZBvKvFR2Zm/7HxVk9anG9/bwfyUZp3/wlZp8ZNezZEITH4syBPsl2y8Snofy
	 Ub0qgwusQBxk4bs8w3EekNyodeFSUazeJCssW40KOpQiatnfxCeshOVbeEcw4+Bw7h
	 4McGJkLTM6qlGJeBv/XTWlUYxqBB57Kx8yigeCN9fnqKIOdMpC0ZjmaK7pSNocMT0Y
	 kgsa+sHo8Tzrg==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] nfsd: Fix a WARN_ONCE() message
Date: Mon, 17 Feb 2025 09:34:36 -0500
Message-ID: <173980282988.27803.8804843258021715339.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <39691ae0-124e-48ea-8a1a-1a7f26423236@stanley.mountain>
References: <39691ae0-124e-48ea-8a1a-1a7f26423236@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 17 Feb 2025 10:33:31 +0300, Dan Carpenter wrote:
> The first parameter of WARN_ONCE() is supposed to be the condition but
> it's missing here.  This WARN_ONCE() will only print the "xcl_name".
> 
> 

Squashed into nfsd-next, thanks!

[1/1] nfsd: Fix a WARN_ONCE() message
      (no commit info)

--
Chuck Lever


