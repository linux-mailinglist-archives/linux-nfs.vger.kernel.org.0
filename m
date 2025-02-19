Return-Path: <linux-nfs+bounces-10197-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC82A3C6D9
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 18:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1DB3B79A4
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 17:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9712116EB;
	Wed, 19 Feb 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqMhpBlj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429D41ADC86;
	Wed, 19 Feb 2025 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987895; cv=none; b=hKDDYdFbzzWNpKSL7wm8r9tUAtpUVP1Sni+iu2wqMYA+fybD93BdWHK8wkVFp+XXsW0tE7lcyRHbhTEVO2az+5/US8sFf+mzC33q7KjxXtvzbB911AVCmaurIalxhfRFoiEawrIUfjr5p6UJyntHOAUE5/TXFsEc1bHH/NWGVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987895; c=relaxed/simple;
	bh=twv1E+swy9QjZdA/OrEkjl50LDIDwsj5YvoXhji/Pjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaURfG6OiG45LTQ1U+/KqT4Lta4TWpUpp5NkvGZhjIvhSEtJ/QwJLR9WkWHcqjs2/zI1qGoQQ4LUyPUGF2OdRwCT+HDobyKfgWntot3bx1IH+NfCmyJiO5JH9hKIG05My5f2+PZd7VDLCRYxRnZ1RXCdLDxCfFE1Z0wyuShAu2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqMhpBlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57DCC4CED1;
	Wed, 19 Feb 2025 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739987894;
	bh=twv1E+swy9QjZdA/OrEkjl50LDIDwsj5YvoXhji/Pjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AqMhpBljSFUlDyIEXwrOznVdkZpmv48Kx1hP2MidjiyJwvP1p1oaHR02m/FTcBWqh
	 MTKOcuMrTUHA+dyFB061kBvwr4ic9iAPFELd9C95lq+CICq9jdk7ClbES65fMfwtxU
	 72HxCDWs9x3TScmjIMPGES+/13Ev2tOnnnvTvKQfV/RVIOfGbHvI0uww2WbZHXfyhN
	 GS4EWf3shFUYU/kqLoy7SccqmhnH4TRFQTafN2gcCkIf27FKA+0x5Wm0DrqKJjFVeT
	 iDT+OtJnTZVFpNKfcT1NeorvQ4kN5szwUplfGSwGlrrMzCdc0wdU/Pz7WfPX1jtR5q
	 BktYVhBJXZ6EQ==
From: cel@kernel.org
To: Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [RESEND PATCH][next] fs: nfs: acl: Avoid -Wflex-array-member-not-at-end warning
Date: Wed, 19 Feb 2025 12:58:10 -0500
Message-ID: <173998787836.10421.7389404025921854937.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <Z6GDiLZo5u4CqxBr@kspp>
References: <Z6GDiLZo5u4CqxBr@kspp>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 04 Feb 2025 13:33:36 +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of other structs, we use the `struct_group_tagged()` helper
> to create a new tagged `struct posix_acl_hdr`. This structure
> groups together all the members of the flexible `struct posix_acl`
> except the flexible array.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] fs: nfs: acl: Avoid -Wflex-array-member-not-at-end warning
      commit: 5aea7cd1e98f11108d019c3b629fce37f526377f

--
Chuck Lever


