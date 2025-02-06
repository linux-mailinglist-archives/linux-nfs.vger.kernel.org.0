Return-Path: <linux-nfs+bounces-9909-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5657FA2B167
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 19:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA391884FCA
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 18:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F243819B5B1;
	Thu,  6 Feb 2025 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DB2Vb1nV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA7B19AD90
	for <linux-nfs@vger.kernel.org>; Thu,  6 Feb 2025 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867229; cv=none; b=EJz6I23PuLM3dfTPgtp1Z5/bhCuNFM/FWpMzmlYOtk1iA1MBsOtDclpdNZS8ZGG7U2nd/z9cKqq+dIKFqKCxP2JZKj79iFbGwwlS832MhrAHIVqZF0Jm+jduij51Few8P/5sivttRydxNMuOVq3yxjUfSOANwyYEyQtnmKd4s6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867229; c=relaxed/simple;
	bh=i1xFabsUVYawDOkr8rLETWOaPqEFsej1O0ivmLKGP/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FanDQ8VRN1v34IYJfBS72mjz32Bnvktw8OIfgJyvM9W5KFLvff4AcIFE8W0SwWg+ZhKkoEwomUVNKQMeeDKR7955rir6KhMyMfVtkn9ff07jsxzK2sD3HrWyy82/rLgpnHEIGit/WLCy/V61X745+3IfvrYX+4DbFd1J8K0R3Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DB2Vb1nV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E0EC4CEDD;
	Thu,  6 Feb 2025 18:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738867229;
	bh=i1xFabsUVYawDOkr8rLETWOaPqEFsej1O0ivmLKGP/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DB2Vb1nVCWLNXyzPrL/oopEBgC+H0isT43kk/6u3Xm2xju9ADdqdpyzAOUetIML+n
	 lr+Q5i0TqInwuax68cKTn6tBMVv1RxF4zBJEA9Zoe1YLFjTGI1a/KuTP3s9l60oWAf
	 XIUR/1Y0T5Qd3LSrAqIXH6MtG2duBhwET5k0biP+SnheJi7oXeMH2x//gDldoA4CON
	 lG6u9CdmAkV4BRTvA69ao2oldujtjf+KeoQuRUe6gJ13T/bxBAyZuoEdSUst36ywbX
	 oAwSs6N298EoTjYzJmZS+Cey48EFRcrZTCjD7kKHxdTivrXRzaPRnXh8QJjifVZDkT
	 0YRS4BgMFoSlw==
From: cel@kernel.org
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: Re: [PATCH 1/1] svcrdma: dont unregister device for listening sockets
Date: Thu,  6 Feb 2025 13:40:25 -0500
Message-ID: <173886718134.80197.12225081954855724678.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250206181534.3442-1-okorniev@redhat.com>
References: <20250206181534.3442-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 06 Feb 2025 13:15:34 -0500, Olga Kornievskaia wrote:
> On an rdma-capable machine, a start/stop/start and then on a stop of
> a knfsd server would lead kref underflow warning because svc_rdma_free
> would indiscriminatory unregister the rdma device but a listerning
> transport never call the rdma_rn_register() thus leading to kref
> going down to 0 on the 1st stop of the server and on the 2nd stop
> it leads a problem.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] svcrdma: dont unregister device for listening sockets
      commit: e7afce74443da1f330a4da6c099854a4ec02e572

--
Chuck Lever


