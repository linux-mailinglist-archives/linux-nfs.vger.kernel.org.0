Return-Path: <linux-nfs+bounces-6252-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A252796E031
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 18:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F09B216E5
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47EE19AD6C;
	Thu,  5 Sep 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+dn4IzX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC384C2FD;
	Thu,  5 Sep 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555109; cv=none; b=jw+x9h0kb+oD4a2Ni+P885ECGWEWtp5n0ixYNMsC+4KkNMQxjGxi5ZySlqO5VrvAB9/gL/6OR7qrS9X7iuC1T5DMPohZmsHsX7zELeCRs5wmE8fJdtY7atfyaSZrI2OvqQEEgoxv2pTFph/vt1gwSwQiDejKmZ/piGB05GfpkOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555109; c=relaxed/simple;
	bh=0y0h16uEOrJ8vHCIrO+tdDreN+rQGphbGRKdlzR0ON8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjAMCzAq0eXVtG6LZf4tb7vwZMlduIVNUCDxEn4TqUNeK2qlrFJUf34a//1PJDRjjKpcJzg4R98EfAPpnEc1cpWTAs/ZpUarNiaOhxaWM/YNW87QUL38piatYgGguw1ObXmuDCml3wSRIJRCF0yBYOw99Y4YSIVvZIYk3ec3EZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+dn4IzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309EEC4CEC6;
	Thu,  5 Sep 2024 16:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725555109;
	bh=0y0h16uEOrJ8vHCIrO+tdDreN+rQGphbGRKdlzR0ON8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+dn4IzXJsgfMnrm+5s77GeQYbKNPeZIvVrIKJyW/SaPQ0NO+XGqNA4mTmCDEAoiC
	 +Xp4nDtBLhMUXxScjGm4nUic9F7m4aMHr2Az/ZlULNUSbb6u4yD85PLi4v5R0XeBpa
	 vXv4ge6MaNSFhg4TVTu4FW5n7iifrtJ1G1/gzzgGTd7JHL7zXS0/mVzIE5OaXtKrSR
	 Slj1J+wEX/u4FTC1gyfJBPoFm8Kz9FnSVA97gHPcLqc+aN1qODMDAhPi8fk1ZLqxSp
	 VFcizZuecLvb14fVgp8AICv7nIDCGoe2aAuQLXdHTcZfS/CehOwVMWykxrY+XxtDa3
	 nB2Pdx/E1wGQA==
From: Kees Cook <kees@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	andy@kernel.org,
	trondmy@kernel.org,
	anna@kernel.org,
	gregkh@linuxfoundation.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nfs@vger.kernel.org
Subject: Re: (subset) [PATCH -next v3 1/3] lib/string_choices: Add str_true_false()/str_false_true() helper
Date: Thu,  5 Sep 2024 09:51:14 -0700
Message-Id: <172555507039.1959022.16303899697737520578.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828132509.4447ff09665fa0d7b8020294@linux-foundation.org>
References: <20240827024517.914100-1-lihongbo22@huawei.com> <20240827024517.914100-2-lihongbo22@huawei.com> <20240827164218.c45407bf2f2ef828975c1eff@linux-foundation.org> <8d19aece-3a33-4667-8bcf-635a3a861d1d@huawei.com> <20240827202204.b76c0510bf44cdfb6d3a74bd@linux-foundation.org> <a6ea03c9-f92b-4faa-b924-8df58484fb13@huawei.com> <20240828132509.4447ff09665fa0d7b8020294@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 28 Aug 2024 13:25:09 -0700, Andrew Morton wrote:
> On Wed, 28 Aug 2024 11:49:51 +0800 Hongbo Li <lihongbo22@huawei.com> wrote:
> 
> > > Anything which is calling these functions is not performance-sensitive,
> > > so optimizing for space is preferred.  An out-of-line function which
> > > returns a const char * will achieve this?
> > I think this helper can achieve this. Because it is tiny enough, the
> > compiler will handle this like #define macro (do the replacement)
> > without allocating extra functional stack. On the contrary, if it is
> > implemented as a non-inline function, it will cause extra functional
> > stack when it was called every time. And it also should be implemented
> > in a source file (.c file), not in header file(.h file).
> 
> [...]

Since I've taken over string maintainership, I've applied this to my
tree (where other similar changes are appearing). This should reduce
conflicts here...

Applied to for-next/hardening, thanks!

[1/3] lib/string_choices: Add str_true_false()/str_false_true() helper
      https://git.kernel.org/kees/c/6ff4cd1160af

Take care,

-- 
Kees Cook


