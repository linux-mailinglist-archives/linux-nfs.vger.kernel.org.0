Return-Path: <linux-nfs+bounces-14073-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A77B45A65
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 16:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED557C15A5
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C0636CE14;
	Fri,  5 Sep 2025 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKCmQXYV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9A36CE0B;
	Fri,  5 Sep 2025 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082413; cv=none; b=lZdqJIXIRH2Ooxyl1Y2okeVm+xlPPJF/gYjTIuVhPyzFqEjhPIa9e4mlzy+sLC91ncF3qO+GdFQF2lgfnqJmRFVVkov0IPAY8TozW+bg3ouKFSgKy8qecsg+AvTwTsnBoPx5D7FCGePVLhpryh0veZaOCQFmG/i0u7YLi9Rnkvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082413; c=relaxed/simple;
	bh=LV0JBUG2SwgOJZFlcn56mSQ+ApkXiLxAyOWpCxVcuxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPkh4O8+9dxyBR26aQfiRnJtCcVU3dRW9t/MterDODPgOJeifeKVkUP/hl+o93sfmGUYoViiiP5klb29hIYtz07j8zDWi5AblEV7GiEv6QncYHlRSX5n+obnzCbnnzKYevvi0aZ2RLHg3/bmkMpLM5ie2SkPezza+XhECjg+b3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKCmQXYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F61C4CEF1;
	Fri,  5 Sep 2025 14:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757082412;
	bh=LV0JBUG2SwgOJZFlcn56mSQ+ApkXiLxAyOWpCxVcuxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKCmQXYVQ4epAASaItp7eI7RtUBWzQTJfFME6Ib9VIZwF5cBdWRtEVBXbxlaug3g7
	 qRcP4WU7Sv4zq4nFXZLUd5WbFSvKvjBT0a1U2wY/dTX3Zz1PmRkhu/AalFf3JIDssg
	 8Qo5A3jVWCgOnKAr1H1yQ2P4qooroBy5uW5UVDvKZ5vdwP8LsXAadWny/Zn5+EzoI7
	 EzIW9lKREY2NSsGCMMIM2geZA7jFpVLAIx0LLdY5UaWVKKCqwcgClXG4PpPf3dLyTE
	 BeeMnR1qPap8s/g/qGu6GbXYKA6eDz/C+SVmlofo/zsLTTOANcBVqe6DbNpLaybyDw
	 WjSmbC/XbfYwA==
From: Chuck Lever <cel@kernel.org>
To: Scott Mayhew <smayhew@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nfsd: delete unnecessary NULL check in __fh_verify()
Date: Fri,  5 Sep 2025 10:26:49 -0400
Message-ID: <175708239501.6078.12054846313340172657.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <aLnhkm7q1Di0IiIu@stanley.mountain>
References: <aLnhkm7q1Di0IiIu@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 04 Sep 2025 21:59:30 +0300, Dan Carpenter wrote:
> In commit 4a0de50a44bb ("nfsd: decouple the xprtsec policy check from
> check_nfsd_access()") we added a NULL check on "rqstp" to earlier in
> the function.  This check is no longer required so delete it.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] nfsd: delete unnecessary NULL check in __fh_verify()
      commit: ec3d9745c6a3f41658d17873e4890b56cc27f9c8

--
Chuck Lever


