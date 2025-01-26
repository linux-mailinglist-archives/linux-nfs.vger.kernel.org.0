Return-Path: <linux-nfs+bounces-9634-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B0DA1CD88
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 19:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A3F1884499
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD35D78F4C;
	Sun, 26 Jan 2025 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmgExqGa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591A25A621;
	Sun, 26 Jan 2025 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917886; cv=none; b=defkBL3BW9m2ThSXvBlu+q4NymRHKBrvgiqo62hYkbQKJbw13/2pfs1Z07VyPqhJUxyYRoUPnfNUlpBcxB1F39/E6MLByfW69nxxZ5r05vG+5mPKasUih1NXRfilPGAADaTtbZmxuwvLV9uVWnQ2HAj7RfzyHeqCMd5HgXhqnZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917886; c=relaxed/simple;
	bh=6uOUL3ZNmz2orf62SaIOONaeJxTX06WLAcTz1nAkxZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nl/d/PzscaW28RoynzWJoDOSjke2yc8r+Uyr+P4gQN4VJ/1JQKOgIEqiRmSWzMGuf2m8ta+eJYF4rTjH5U9w2QEYbrZyIHeErxipNsqNhQg2bHo6NwiiALauZqV26/ecvk7K6IIn7PloHEVz/zJLYwE+En7bWba9V8q7KijiwQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmgExqGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8A3C4CED3;
	Sun, 26 Jan 2025 18:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737917886;
	bh=6uOUL3ZNmz2orf62SaIOONaeJxTX06WLAcTz1nAkxZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NmgExqGaZDczQrKjNfDGFbEhK97B3smH2UrzAqU/x0vL1a+QMM5nyziYWkII9pxYq
	 ZWbKQSrlEWUlt8uM5ESc7+EicheEmnxI7aYOAd1sy+orTrCQ5Ji7H0TAClem9r89xh
	 NzI0jKgVQnFmtgKSR9Mv9440WCML5ekoEaNnTysaG90vKjrGmcrDH9Z9aBYmf/kABn
	 qmceod9mA2m9fmOUPEYuTda5atuClUuFg7d0q47kPnonij5X4OyuOPXzE6YGO9lQix
	 ZuO2b09FfVR28nwlI7c+ZNW2gB191vEgbP+v+AOVEUKzX9T20xCBO+IbytGOCDfO/s
	 MOXvmw2rcuu0g==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: validate the nfsd_serv pointer before calling svc_wake_up
Date: Sun, 26 Jan 2025 13:58:02 -0500
Message-ID: <173791786468.1538.15975986746668996936.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250125-kdevops-v1-1-a76cf79127b8@kernel.org>
References: <20250125-kdevops-v1-1-a76cf79127b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sat, 25 Jan 2025 20:13:18 -0500, Jeff Layton wrote:
> nfsd_file_dispose_list_delayed can be called from the filecache
> laundrette, which is shut down after the nfsd threads are shut down and
> the nfsd_serv pointer is cleared. If nn->nfsd_serv is NULL then there
> are no threads to wake.
> 
> Ensure that the nn->nfsd_serv pointer is non-NULL before calling
> svc_wake_up in nfsd_file_dispose_list_delayed. This is safe since the
> svc_serv is not freed until after the filecache laundrette is cancelled.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: validate the nfsd_serv pointer before calling svc_wake_up
      commit: a71d376104bd893a3fc349c5ffeb23a66ec78bcc

--
Chuck Lever


