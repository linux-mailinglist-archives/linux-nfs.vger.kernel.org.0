Return-Path: <linux-nfs+bounces-7279-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490FF9A402F
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 15:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1C91C2441E
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8F71D88A6;
	Fri, 18 Oct 2024 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlBBWD5E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77DE1D54D6
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258779; cv=none; b=P+eh3mQSJ+4Qr2P5h+Se03BaSGfsemPNSvu4/Npdx53o3KkAyiIUos1z1LG7pLsKmB7KF9wrJq2xmUeKbvX94UL/B8ht8wdrnBIRwKrj3C+D/XvXD4HlCGmk+LA0BdjiHwo+mSpKnJcTzcR2BYnaPTpNXfUmSpz4JLyoLJPR9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258779; c=relaxed/simple;
	bh=Nc0QOSj4baQrHeIjPEUf0BfkWx72J87aOIPwStI/ea8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnQLlmAlvVkBhz6cnC1i8deAw/y1UmAp86YlTs8Igr+E9J+9lNfr01Ms/dBQkp++Fnh4EF+IclJ+l9oJvTVmcQ8sbq9saSC6BN6EoiVq6RoYSon96PLyresWDVtBX7rm3Lh1fXjzOnJNBjTAqluTsj/p31pNEpJ3u+IBxRZOPyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlBBWD5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFF0C4CEC3;
	Fri, 18 Oct 2024 13:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729258779;
	bh=Nc0QOSj4baQrHeIjPEUf0BfkWx72J87aOIPwStI/ea8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LlBBWD5E2fCNIgYXjSI1G7i1fbas2V4nWwVEGfx+9Xovr16TaC0tTFcUIVMA+PWKZ
	 9rDk68xM9nAo4PQ6cs9pAqjvSjEO4hKQ36ZYzC7V/9g6pFXGq1jIiAujmxaeKouvN5
	 GPIENnoYAZexjlPsqbXoJyuNnEqPPES+76PsqBdifhC7ziXcwmpi2+sjOedLVTwtgK
	 zYP/2GAVQD39i2Ghe07rLOB9VNHiGSmtJXi2i5OG6LHFeNuoR50q0AEMNZkAJRSePe
	 vG+Cswf6SJnjtEXdI56rDYZLrA2B2ROuxQJayVQyRqQJhtblMZFRQOq0LvYmkIkM8w
	 tljPkZNlQ9zmA==
From: cel@kernel.org
To: Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: refine and rename NFSD_MAY_LOCK
Date: Fri, 18 Oct 2024 09:39:35 -0400
Message-ID: <172925875846.230036.8190047848574023818.b4-ty@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <172920135149.81717.3501259644641160631@noble.neil.brown.name>
References: <172920135149.81717.3501259644641160631@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=EwONOgrorlS7KLDqLXZX1QPzTwlclq6DxrYnM4Kgklo=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnEmUYu7R0n09n264S5xMNru9w6VEsAt94Mdsyf cm/iKuD4FGJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZxJlGAAKCRAzarMzb2Z/ l3yuD/9s3UGLszvgGAt9wD35j1KAdOUtxi8D83MlmgPmY9KsO7VddoW+P79RoSImXxTmXGZWRKz 9113k6wO4p3YoQVJBvrFUrpGoygSkZF/r11o3LYEwmjRvAUiTmL8/h+lgZ5WD2ifVEOtBUrHf41 uejzMDfAayOweAFf2D+RoflI+h7l6g3gmCzKb5V6RDWef1ujwGLa9nhVLOrAKmeZd6sTgpCaaEZ OivX7NUnayt1szurt2jhoh5lQ/A05IbMlbU+nGX8cP4wXBYf4zrzXJ8QLB4iWr2/NsBJB1o0ebo i4/A09X4ZSOHwB9wRCzsKft2ByUM/jXM/af9gyB1BdGc9pUSFxwYkbsE9/cz2x5V+O63sjhTkNW zM/ag4e2wA+Mz0fI4wL2qgJauBYGL6j2KsOIFPH+2TflwCovEGsV7ah4oRNIc3N5zUvjIn0XlPm Y2j5Dywy/YbhfxD2YZLUV0zIgMUn8y/O++ZszObR8658fOZZCQhbOFKUL4Na3I7rbI4E+vljAHB zjOaU2L8P+38zlVbepZMe6DJZxRFMpIZOOcGq5zepjiZDCLVCVQLC5ocJ9EGB5AzNzyEzjgULMb flGsvABdeo5QXNwdTt91MD1XFQJiDElDWnmKEYhQ+q2D0V0LcfJQentusf5asoYPWE9QgRZu+Y5 zEgKDj
 gMoEU+Yog==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 18 Oct 2024 08:42:31 +1100, NeilBrown wrote:                                              
> NFSD_MAY_LOCK means a few different things.
> - it means that GSS is not required.
> - it means that with NFSEXP_NOAUTHNLM, authentication is not required
> - it means that OWNER_OVERRIDE is allowed.
> 
> None of these are specific to locking, they are specific to the NLM
> protocol.
> So:
>  - rename to NFSD_MAY_NLM
>  - set NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS in nlm_fopen()
>    so that NFSD_MAY_NLM doesn't need to imply these.
>  - move the test on NFSEXP_NOAUTHNLM out of nfsd_permission() and
>    into fh_verify where other special-case tests on the MAY flags
>    happen.  nfsd_permission() can be called from other places than
>    fh_verify(), but none of these will have NFSD_MAY_NLM.
> 
> [...]                                                                        

Applied to nfsd-next for v6.13, thanks!                                                                

[1/1] nfsd: refine and rename NFSD_MAY_LOCK
      commit: f94d4ca4e9862261a77dcfc8b567a563452add41                                                                      

--                                                                              
Chuck Lever


