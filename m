Return-Path: <linux-nfs+bounces-10990-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8769A7913F
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 16:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADCCE16D95F
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 14:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE49323906A;
	Wed,  2 Apr 2025 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZxGTGaH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B160219306
	for <linux-nfs@vger.kernel.org>; Wed,  2 Apr 2025 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743604391; cv=none; b=QpFoWKMBtWfR5XcLVCXvnVKFAWry0o6IfibqhxBmy6LsYYBtzKCNgBDlvkGdsIklH4fZcj7OBTnDTws9CeImorgH7Wdwy35R/9ldmbLwlkaSMTTBH/sG7JiOKSHnGdSstLppBekjQ6N/DvOFHcnwVSwTSoqUcTojacTMSITHyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743604391; c=relaxed/simple;
	bh=cx6c1GaXbVwZykhdz6vbj/02BFYvDUD0DeE2CcR9daE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJI9p/lUkzdROo7OqT+u68RHbFNKDT9KVWUn08PobURvDUxAh5YZXctvUBQ8azaBJQKgZZn4wrihVOSSI5fN/v2k3/0VZ5SxPXknt2ja8y8PveYe9bdyeoRFE+SPC7Vi/mDv3RvqTiHFI0mvU40mqjv2TD51eji/if/4UV1sQGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZxGTGaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BB4C4CEDD;
	Wed,  2 Apr 2025 14:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743604391;
	bh=cx6c1GaXbVwZykhdz6vbj/02BFYvDUD0DeE2CcR9daE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZxGTGaHa/Wu739+PEM36xCxfq6wmSHJIswJQSGd3Rk4Tteyd1TXQMzmg5dJ+DoRg
	 0c9pcYB2gi+2cbmGYOCd4oUmfx/41b62FPppaLXhvKImfllQ7Dy4KUjk0G9V7w+Zou
	 Jv3/ULT4NpOYhvlKTZtygs8iSlRXlWH68VCWrFM1GajebK6hr+UBwxNHQbMGhOVs3Z
	 1eSq/H2kJ5FmDB7TTW5tqskVgm05nue1UrigmQE5wAPdUq1iFl+au06b5/pY1YEO+i
	 Y37mbqfAiGwP2PYQMX9DZpToJ+ABZBg/yZc5C+DxX5lbfBCfzvElJyV+gHpwi+hf2g
	 0tPByOaz+bLjw==
From: cel@kernel.org
To: jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: remove redundant WARN_ON_ONCE in nfsd4_write
Date: Wed,  2 Apr 2025 10:33:05 -0400
Message-ID: <174360436416.37828.17599943712066367696.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250402140619.16565-1-guoqing.jiang@linux.dev>
References: <20250402140619.16565-1-guoqing.jiang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 02 Apr 2025 22:06:19 +0800, Guoqing Jiang wrote:
> It can be removed since svc_fill_write_vector already has the
> same WARN_ON_ONCE.

Applied to nfsd-testing, thanks!

[1/1] nfsd: remove redundant WARN_ON_ONCE in nfsd4_write
      commit: e20ef2bd835ca8c6e4b835a8e3f7cfa09957b7ab

--
Chuck Lever


