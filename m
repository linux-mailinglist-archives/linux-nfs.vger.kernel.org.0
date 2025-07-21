Return-Path: <linux-nfs+bounces-13162-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62C8B0C729
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jul 2025 17:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECE03B54A3
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jul 2025 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241711ADC83;
	Mon, 21 Jul 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMhfQRhy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08742E406;
	Mon, 21 Jul 2025 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110160; cv=none; b=Qci6TLunFFwU7Fe58mM8QtkzNbdbVT+fJtNwXGXzwEhkaceO8qhhJDqWJ/N8mAgUm/JAyH9PBcxqRQNoaNc0cW3QolcZCkrhac88XWiUU6DUipJuSAZEGpCu/wafz+Sj2JTjC+FlTUs1DBuYBXJpIu8pUrsMc2nEKQZCubRwPtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110160; c=relaxed/simple;
	bh=usfW4WlCSN/PQlE5JYdafnj9dRAWtuA2L0ggcp5vT34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tA5rGv+dYiEbiO08KcOoJPOUKiIicCR1yMJfXP1xuuapBEVeknQZG8bsS9bgge+4Y36koLGYFpRMQuNnV0zBO5CocPWyEt3HVzmruh05/I/FIdnlKWhDzbTj6jZTQV7agrPCPV8oaBrbACF5NSD1TlI4GFIAa6S5tLpzJtl18sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMhfQRhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02A7C4CEED;
	Mon, 21 Jul 2025 15:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753110159;
	bh=usfW4WlCSN/PQlE5JYdafnj9dRAWtuA2L0ggcp5vT34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TMhfQRhymwOLLalk/nyPtAhxlOMUu5ffFQpggAVh+b4Y8/J9/9jFdcbDHJwVeclWI
	 4IXAN1v0xD3h7uEooNUTllYcO0yazc59baQWNDJ8N8TS8Pe/4NNaAUfpVyNhZM2nVn
	 cRHZY5tBomefMEVjsjX7/uKKdMVIPqencwf+YnxCWFM+CrUcS+Ov4MSQyaR1PkNeXJ
	 TPTd+vIoLbAVG1J9RDG61TJ0YJW3Q72q+uWpYgqkZCPlXFyWEUF2LnU41c7EM2a/4m
	 Ve63pt2LsLkblv+mMSQJgIMaaCkE8+OXVqKNsiRXz6Dh8KsThabnhrOp8GtHvSgl+0
	 4cqZy9rAgFRzw==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] NFSD: Rework encoding and decoding of nfsd4_deviceid
Date: Mon, 21 Jul 2025 11:02:35 -0400
Message-ID: <175310998907.2268053.13719232117488948870.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250721145215.132666-1-sergeybashirov@gmail.com>
References: <20250721145215.132666-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 21 Jul 2025 17:48:55 +0300, Sergey Bashirov wrote:
> Compilers may optimize the layout of C structures, so we should not rely
> on sizeof struct and memcpy to encode and decode XDR structures. The byte
> order of the fields should also be taken into account.
> 
> This patch adds the correct functions to handle the deviceid4 structure
> and removes the pad field, which is currently not used by NFSD, from the
> runtime state. The server's byte order is preserved because the deviceid4
> blob on the wire is only used as a cookie by the client.
> 
> [...]

Applied to nfsd-testing, thanks!

Note that:

- nfsd-implement-large-extent-array-support-in-pnfs
- nfsd-fix-last-write-offset-handling-in-layoutcommit

have been dropped from nfsd-testing because of conflicts with
this patch. Please rebase these two on the current nfsd-testing
branch and resend.

[1/1] NFSD: Rework encoding and decoding of nfsd4_deviceid
      commit: 52d6381bf1caa63f6cd8b3df54162f36b03b3a68

--
Chuck Lever


