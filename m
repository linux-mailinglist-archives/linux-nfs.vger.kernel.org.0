Return-Path: <linux-nfs+bounces-12532-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E62A5ADCE32
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jun 2025 15:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16275188CEF0
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jun 2025 13:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3232E6D37;
	Tue, 17 Jun 2025 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPo3mMxF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD72E266C;
	Tue, 17 Jun 2025 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168120; cv=none; b=eKR3ILGtoF5vGd/20CQ+DVvSl0QOjcvjVmk9Yfh+BN2dJVNfMM7f692IuyyEfCyGBrPfvd/Z3f1PPJ5iqXCeal+j54d37of+JJRdGmAAsNd6ughnt8kyU6F7pGiBhnwojchi9NGF+IHqC49nTSarr9Mv9MM/95HwG608ZES2IlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168120; c=relaxed/simple;
	bh=CC0pQmZOifV+kXRbEIORrVEDtXPMfO7f7/1stjrjXiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZO9GY7Vssq4Cs5AnmJAIIwfwrv+8h0sKn6/tXGUuJS8EBVEMqjuQv051uy27VXR1+vmPFtfdWWNr33DerWJwXOqMCyh+w3zU4SHs6ZKLX61Aj1kR6mNsxvxJQgU3XB8xHNh1p1Fu+B01B0uKH1qh+eeIW6PZ1qEyW0QMhLoOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPo3mMxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD46C4CEE3;
	Tue, 17 Jun 2025 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750168119;
	bh=CC0pQmZOifV+kXRbEIORrVEDtXPMfO7f7/1stjrjXiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPo3mMxFDXUTJA5p3aSGonT/Ar7T710bZtU3yL/w0GY5uc9pExDGlTZGbLNJSz+L9
	 T5KmmvlpaXGw4iV1hZaXnYkRo6D2CcpJ0zkKsjXVP1Ljc8Hyr/5ca3BMcc/v8jb0s5
	 e/s7oGvcbKQaMM2NVBYYrtQVZWh4jTWjWBGkygy+/vrFi6bBgKIo8Bc2HCMVslbvMk
	 o8dtRf2xS8H1Rjh1SET86k18k1UYq+EHD4b23eAt/6y0h2hCUlWulRoPXNz56vptB8
	 SoqAArWFA80/7gpylEkqyr9CBkCmy1CvXUrdc83+aCrtDptSe6NLxXb8RybvSmRzWv
	 sZ/agH8cBl4Cw==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] NFSD: Avoid multiple -Wflex-array-member-not-at-end warnings
Date: Tue, 17 Jun 2025 09:48:34 -0400
Message-ID: <175016808512.336273.15483620286888395120.b4-ty@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aFCbJ7mKFOzJ8VZ6@kspp>
References: <aFCbJ7mKFOzJ8VZ6@kspp>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 16 Jun 2025 16:31:03 -0600, Gustavo A. R. Silva wrote:
> Replace flexible-array member with a fixed-size array.
> 
> With this changes, fix many instances of the following type of
> warnings:
> 
> fs/nfsd/nfsfh.h:79:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/state.h:763:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/state.h:669:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/state.h:549:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/xdr4.h:705:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/xdr4.h:678:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: Avoid multiple -Wflex-array-member-not-at-end warnings
      commit: 9aa83533d2e694c84d7d09f9c8eab29ad9f2adef

--
Chuck Lever


