Return-Path: <linux-nfs+bounces-13714-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB63DB2A953
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 16:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C6D6E31C3
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4123B34AAE1;
	Mon, 18 Aug 2025 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTzIr15h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F023375D4;
	Mon, 18 Aug 2025 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525679; cv=none; b=DYUAdHpBxFWDj0ZCwQFjc2mqwXQM4rXzeg28xPVVWEPRNIbFDGPYA7k2TmL7Oj6fawsYEGjRt5lWtjzx/T6bRcp/YDadWtC3KzJ4M+shd1vrNRhu7MRnGC9LAoBpsp1AnU2Azs5yXjlAD2eNOiE6lfHC7XgrrxCqVASCEnpqgnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525679; c=relaxed/simple;
	bh=aNAyYi27OGoTDXnS0yJLC/hDmA8wpEF3Axk2bYbNUsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foQDYNa/CQWFF/r9tT0QUM9W2zk9DiniX1iWe5xSgIBTosuOq3xO9GFgm1Mv7tpSioLlertM745mmCFmGg4+eJmfE5k29T//ZgijByNvITQCoRPP0Ux+4mCORBsZzST2wzbnnkCswzLQeGyPbz3ygc7y4WuyOfUDYdTL81pDpVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTzIr15h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC18DC4CEEB;
	Mon, 18 Aug 2025 14:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755525678;
	bh=aNAyYi27OGoTDXnS0yJLC/hDmA8wpEF3Axk2bYbNUsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTzIr15hFVsTsgl1iSmzQzcpzXRUu3NCCqQkCOFTGuT6kAR/7/GdZ6XzVj/slW9xN
	 Ij+tfrjkxf7AP6xpE9dl1q+syBBPExlTWaLL46We1TrTd2jrD9hLDczOXAbowyueG9
	 bbPjQLO32lqFUOXUzVh0Ib2nUVtGvpB3tdv8xFjYGWbMVTg4zkMW0gw0O3mQKCKwpk
	 8ZHiI+qUdBQfrqaeOl3XL1vDVCQtKN8mg2Fhr7lL7suMmc9qnQ9TUEN8WHYX95kfnh
	 sd49fTR2r2t4VguGOC/5oqDianlgNASiVGDFZ+uEmYNt751b8qp8gnuLC9tJmSBsIV
	 rie+CxDvpPMIg==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFSD: Drop redundant conversion to bool
Date: Mon, 18 Aug 2025 10:01:15 -0400
Message-ID: <175552566805.832278.5767019281006426668.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818100320.572105-1-zhao.xichao@vivo.com>
References: <20250818100320.572105-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 18 Aug 2025 18:03:20 +0800, Xichao Zhao wrote:
> The result of integer comparison already evaluates to bool. No need for
> explicit conversion.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] NFSD: Drop redundant conversion to bool
      commit: 1baa19c0b871e309dbbd4e26f244944db2589ac4

--
Chuck Lever


