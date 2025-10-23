Return-Path: <linux-nfs+bounces-15573-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0B1C01ADB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 16:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCE03B15F5
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 14:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7199731691E;
	Thu, 23 Oct 2025 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuDJrucr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC26DF76
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228268; cv=none; b=RKg0SWVOeAboSALfaaMdE7y7JglElDymQeVraDnzQLr9Wz37aGzos0TK+c8MQ+PagzxZV3fvRN9ZRuQtcgKiOBq+mnBho2A8a5b1w4xMIWHA/elx1c9C3DsCbqh7mF9q9UoGDldYOMfphcZ0GO6Qgu5mIWj9fXph8EO/gu/Bn2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228268; c=relaxed/simple;
	bh=Al5WnrwlRCBx4MVzMIPy7eTyQAu0vhewBP37iZwwJpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlpYh0GRSIeWuXIqjJIlNDpF9cESOWSl9JM+DL6bWKHmKOh/N1/qUgjM3YPJZasiUPPalb+qBZpIXou9JvQz5WpWSFXyHn5g6meicSDp2eoRGdQI6ZJ/DjsukU55q0cbUv3GjdBjwJFHasoySChCrJTQh9gTgnVPuaBOyJRJVBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuDJrucr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700D1C4CEE7;
	Thu, 23 Oct 2025 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761228267;
	bh=Al5WnrwlRCBx4MVzMIPy7eTyQAu0vhewBP37iZwwJpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iuDJrucrMNihOmfTpG3aCzJcfZlQWHIWEIgtQ09Yi0qTvf7Jlq+vhhq+RWEQP7/LX
	 cyCFpWtG5fL9IazuBgi8B2FwfnOJiZ65JNAERmPgDyMIMD56yXhu5CF/HoYSHH1TpF
	 /v5iC3jR06Ae87HRbKpP8hyxnQ0FFfXJDBSwUAwPZbNgYZD+sb2njHLGXhaoSkM5In
	 fO3BVxsywsA5B+ri7MhqO0YcUomDy9VX/LlUZ5idZxCqva3Jjx9ihrmghCe0NT/Vjh
	 /PqI10gF1tUVD9WGcLsMXP+VBcLHZem+ZjHI7RsvzIwWVDxorWZy1DKqRWPQZclLfU
	 ZYAorRw1NcqfA==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Christoph Hellwig <hch@lst.de>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add a nfsd blocklayout reviewer
Date: Thu, 23 Oct 2025 10:04:24 -0400
Message-ID: <176122825495.11794.14217544320399480179.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022114533.2181580-1-hch@lst.de>
References: <20251022114533.2181580-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 22 Oct 2025 13:45:30 +0200, Christoph Hellwig wrote:
> Add a minimal entry for the block layout driver to make sure Christoph
> who wrote the code gets Cced on all patches.  The actual maintenance
> stays with the nfsd maintainer team.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] MAINTAINERS: add a nfsd blocklayout reviewer
      commit: 1e831684ab98190b92d831d209fb87fb683322ef

--
Chuck Lever


