Return-Path: <linux-nfs+bounces-13154-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09897B0A654
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 16:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E3816C467
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EF62DAFC7;
	Fri, 18 Jul 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma2643ML"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45272AE7F
	for <linux-nfs@vger.kernel.org>; Fri, 18 Jul 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848732; cv=none; b=kP07X+zWLQfXOuO9YxtfvLge+MNoBV5ezZFegXLj8vqLFtUdWH+d+fjnMlgOLx/6hD3ym0Zfx5jAmlxFZ2HWwPAHF2VJSH2QaitdNIGiiAK75QDGbkLYBbNJF7nndNKDxaQOJJtRjs4VzBmocU+SXc5HZvC5RZbMKxJUK2XDo6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848732; c=relaxed/simple;
	bh=Qb6pSQ48qf7xzP7KgZcpBkNISMfbByqnr0qrvO0Q1Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1OOoXlYYRErm8X5Z6wPe1ljt+7VIT04ipN3X8FxaG3xFMMaj/xy+VxlWP+dE58YHMJzou6UA6aySJn+jpvJ/W3y8EVZ4nopbwmsnU2tb4TAHY0nbpeIqLQwRBLUCp3MIOXI+aptkPK2paQuwF8MmgvURKyc9VYFVHwzBRXSjk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma2643ML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58FBC4CEEB;
	Fri, 18 Jul 2025 14:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752848731;
	bh=Qb6pSQ48qf7xzP7KgZcpBkNISMfbByqnr0qrvO0Q1Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ma2643MLOnMEOreF8HXAKAUp6QmixljNt8/tEHJL51i1iw51dpwkQ6ioiMzULCDLE
	 UH5HL5zk8bA+Raf2fu1Zzdx9dZgwbCdHo8142NIfbX6Ddj/pCWP7fSO5XqL4lZ5GCV
	 +yvehSHgNJOmu6Xuz1SeBASv0AdrmlxJn06pdU2RlU07XA/0Avawc4F1JUuiHNUsdt
	 i5KS5kYOxZ7w/8N9m447WdK/En+h+wlTXmKjKguP4HFZtsC4KAe/5t6cLctY641TtF
	 ckx5sF7TSCdW/evtwIToqd4g3wqPh0SMrEzxx50Z+7zGhhDA94z6GATM4y6mqae4Uh
	 xUmM+iCncA7Rg==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/2 RFT] nfsd: fix another problem with recent localio changes
Date: Fri, 18 Jul 2025 10:25:26 -0400
Message-ID: <175284851548.1668994.14828037670346771563.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250718012831.2187613-1-neil@brown.name>
References: <20250718012831.2187613-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 18 Jul 2025 11:26:13 +1000, NeilBrown wrote:
> Mike reports ongoing problem with leakage of refcounts for the net in
> nfsd when localio is used.  I believe the first patch fixes one possible
> cause.  The second patch removes some related dead code.
> 
> Mike: thanks for your testing so far.  Hopefully you could find time to
> test this one too?
> 
> [...]

Applied to nfsd-testing, thanks!

I assume 1/2 should be expedited? If so, I can add a Cc: stable and
get it into v6.17-rc.

[1/2] nfsd: avoid ref leak in nfsd_open_local_fh()
      commit: 3ae40032ec9e2a829fb5ab1ebaa92d5d2b1fae89
[2/2] nfsd: discard nfsd_file_get_local()
      commit: 470c6ae5e920028abc2ef0044a05023977c4058c

--
Chuck Lever


