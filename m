Return-Path: <linux-nfs+bounces-13167-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489EDB0CAC8
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jul 2025 21:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7D13A8C85
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jul 2025 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221AB223338;
	Mon, 21 Jul 2025 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDzFP+lp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72E21FF42;
	Mon, 21 Jul 2025 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124420; cv=none; b=quIMCPUNNCB2RFRcDca0fAq3G8Gz9cOIrPoOsB0+Nif29ReHjV5uvvS5Qw36l7lp3FHQGLzF4OVw4eSqW8u2y2cYv3DI/cCD6YS7v4ykSVmJee4brOWYhi+Nq4LDZC7FMpQAu05p6wTibQ6ahA4DmlAQKTLqgNMPNegbAIjZ3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124420; c=relaxed/simple;
	bh=jycQ6WTKmjSd6LPJ+OmK2U+ejKG7d2BuV8D5LCzgpnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhqZmrnTP9U7cnEt72UKKmZHzofEHdS5ruIgpYKoamSIANNlnUXP8MqPa7Oga5fHrk4WhjzetC4Dhubu2hoQPlIg0u296DiB5z8EgjaqPslUjye7pN6f4MFo9ciXjLkp/lf+2RV/i3h7CMxiiRtGTB+7aloYscj0L3Y+u+gc6Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDzFP+lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8041C4CEED;
	Mon, 21 Jul 2025 19:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753124419;
	bh=jycQ6WTKmjSd6LPJ+OmK2U+ejKG7d2BuV8D5LCzgpnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vDzFP+lpY2pFW81hN7FXLQH/7Thv/XErOLP/G+QUcoroH29g23L5OLqWeFu1NLeCm
	 gYJGQy7zq2S/wgiNKTbcOhxWbvICiMX6RAZxyLw9SrzpNlO8zCfFHzWq33f3SBfkJT
	 SfDvFTdcyRFJvxLp7FlcRnHNwGGnXLpJ6p74IUGMo5LqIZMAowdfVjS+OzD5ImaesW
	 isYpFg5bxkb/az9wL4Kc0HmocunCNYBVW8rgR1RUXbc3/0+Otw8+8ffX2dgbBYIxUZ
	 qUT3TK+ANHQ5i6KLrnjaIkaxQFyWZqfJreqBktbYrV/44rzbSNKJUD/pGb3FPTbaL6
	 stRCwuFhTY4Jg==
From: Chuck Lever <cel@kernel.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] NFSD: Rebase dropped patches for block/scsi layout
Date: Mon, 21 Jul 2025 15:00:16 -0400
Message-ID: <175312439897.2283085.2899965740934279002.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250721184105.137015-1-sergeybashirov@gmail.com>
References: <20250721184105.137015-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 21 Jul 2025 21:40:54 +0300, Sergey Bashirov wrote:
> This series resubmits two patches that were dropped due to conflicts
> after the deviceid4 handling rework. The first patch is rebased. Only
> the decoding of bex.vol_id, which has the deviceid4 type, is updated.
> The second patch doesn't change, it just depends on the first one.
> 
> 

Applied to nfsd-testing, thanks!

[1/2] NFSD: Implement large extent array support in pNFS
      commit: 0c8cc94a6dc2b200617094c0016cd46f01c12490
[2/2] NFSD: Fix last write offset handling in layoutcommit
      commit: f91f48cedc8ef26d55a548e4e3879070d06906f6

--
Chuck Lever


