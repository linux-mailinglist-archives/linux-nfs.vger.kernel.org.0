Return-Path: <linux-nfs+bounces-14711-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD09B9FA7F
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 15:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FD24C429C
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 13:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A7E27990C;
	Thu, 25 Sep 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuFE7WTD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333842798E5
	for <linux-nfs@vger.kernel.org>; Thu, 25 Sep 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808050; cv=none; b=QXIYh9Ok9XU0qemG256H86464qD7dxGPWefck7rxijN3NLM5BUEWtTYE8SojDO21WWLx0Tw0aKSQc7kt97JIQap9qIliKbND7gbDD8zOaTHaQfp+fBWJwB4f6Qa+GV2mpqgGqJ4YrjDkbJRa9DGDWmxLjRDVh94LHLWeO1ywSAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808050; c=relaxed/simple;
	bh=/fH+5nATfRNcgKznWZbQqizp5Y45nekpk6RH/ZXGsB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKIzZSoXUcAz2NPDl6p3DcqdDsl/hoW/gRqe4C0XA1JgF/u7SSovTmP4kEaV5baGYJp5y8kwaAXgPNiVPoSh+tDczlq7sfKLdnwE+aM6m31A6GP8/j3dD62DKhxUVBgagwDCJluhHtKMMrfzVXXOJYRdD2hV/iBI86Xn4hlTsaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuFE7WTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB53C4CEF0;
	Thu, 25 Sep 2025 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758808048;
	bh=/fH+5nATfRNcgKznWZbQqizp5Y45nekpk6RH/ZXGsB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tuFE7WTDX3MQBCmLgFJOcGNrgqrMr+OrCsMbVkaahdGnkwFFDvMofklb/MYsezlw5
	 C+UBfxFq5GlbkP+punzkIp5LUyeSWlNMvqevPETvLu1lc3y8i88UrXiaouOHelgQJt
	 /1MqGE1aWWIA5vMFD4UqZzGrUp8Oh/oWvRwLV3x+J7PBTCYadbgg+W23f6eZVbVAXj
	 cijF7b3vmyDZrA8SO60MmHxmho4zIECgYybyRutBeAGClL9Tb0cUNiDboTBaUMbPMt
	 OPoSh1wtzrmHuoBEaoaAV9vQxPUHYc6I//LgYckbhBGEygfSDHIKGQuW5VnT8ne57d
	 vnjkJTa1jIhYQ==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	tianshuo han <hantianshuo233@gmail.com>,
	NeilBrown <neilb@ownmail.net>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>,
	Dai Ngo <Dai.Ngo@oracle.com>
Subject: Re: [PATCH] nfsd: fix refcount leak in nfsd_set_fh_dentry()
Date: Thu, 25 Sep 2025 09:47:24 -0400
Message-ID: <175880803103.231553.6867199116353309488.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <175876366905.1696783.15284382788363472723@noble.neil.brown.name>
References: <175876366905.1696783.15284382788363472723@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 25 Sep 2025 11:27:49 +1000, NeilBrown wrote:
> nfsd exports a "pseudo root filesystem" which is used by NFSv4 to find
> the various exported filesystems using LOOKUP requests from a known root
> filehandle.  NFSv3 uses the MOUNT protocol to find those exported
> filesystems and so is not given access to the pseudo root filesystem.
> 
> If a v3 (or v2) client uses a filehandle from that filesystem,
> nfsd_set_fh_dentry() will report an error, but still stores the export
> in "struct svc_fh" even though it also drops the reference (exp_put()).
> This means that when fh_put() is called an extra reference will be dropped
> which can lead to use-after-free and possible denial of service.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: fix refcount leak in nfsd_set_fh_dentry()
      commit: 37177499c0acfa0b35afe11b0af241c52cddd6c6

--
Chuck Lever


