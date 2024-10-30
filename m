Return-Path: <linux-nfs+bounces-7583-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F8D9B6BEE
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 19:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6399EB20FA5
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 18:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A36B1B373A;
	Wed, 30 Oct 2024 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5F5S9Qo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561A19E99F
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312101; cv=none; b=omhzpF35WDs5+uYPlHXwdafezKVMzftMLW4nfQoXtatltEzJSXAgHGlFVG4jxD4sdXNt6gqlvSwv7CrIZNd0X5xOk3ea+6uqvWjUdY2lGtO3wDKgRvZdxGZ0cRccfR/k3+8bgYRLa+0YRcWG3uXOdgdHwR64N4AOvhIHBisTuF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312101; c=relaxed/simple;
	bh=OCEBhHsZqW6ftciMoGrthBjzqeAM1Osoq7QhffWfja4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3wc7Alu/fABPeoxJXwL+NHHb40gc2YtoxiNihAomix6fdTNiSYRTY/Dax+FY6CP5IphTlbFjYw9Wu6BVlVtPckbntA2F/bd4iGl2pzXDE6xkigbWvLzvtIDuRvuE5Aov1FXmadTAHwxi3rg58iPD+D3iQCem9ZTwsUjCuuj0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5F5S9Qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AE0C4CECE;
	Wed, 30 Oct 2024 18:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730312100;
	bh=OCEBhHsZqW6ftciMoGrthBjzqeAM1Osoq7QhffWfja4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5F5S9QorYCPVutr47HXoG3aErgpNRqVgjc44Zq66/4QwwtwMeKdZiIdQONGN4fBw
	 17Bd/bgI4/mmY5oU5UeeHqXZpj3KRJcYMVA0c0HmlCERO0j4OIsuL2ovODI0Y71Sv+
	 to7wsJe/QXTT8yzKhGTWIP3F2rtw+wZBWIiPMvlYiqiOy7X50/qCBPZbFNxByILkwk
	 Tr6mcQIrQF6WR2KNb6fBj2k8S07vnCUjzDI2NmULWOsJ1HdsFhQBYZ84spvPzip6TL
	 dwyzwLvUpDhuUNlakyxBzDaMZyJoYQjqLueipo1UhGAj0C+7jXBerhDjHFpq/effAz
	 7OR7+h6UEzQBA==
From: cel@kernel.org
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH] nfsd: make use of warning provided by refcount_t
Date: Wed, 30 Oct 2024 14:14:49 -0400
Message-ID: <173031204295.44815.16993980065300726219.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <173006668387.81717.13494809143579612819@noble.neil.brown.name>
References: <173006668387.81717.13494809143579612819@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=D/2RLf21vlMygPjqd8AuNGZg7mykoh3we2KuaQI+um4=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnIneaNPwLYMYlUBkjRJCZT9qr/jiSKHg/gOBx6 DLhHPgAMeuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZyJ3mgAKCRAzarMzb2Z/ l5h6D/9J6tWBukl6/VyU9bgv3dHuJ/CfcRB87gS9iU6JkJhHvYq0DcJgkRH875LIAt7kSo8b7Vz 1QBPMr1wJWNDmt2uSIRI4yJzAerJZvoh3fUZB722RAyQfaLESyH7IPwBHgjzqQOyTWSRYqsfC9Q sRT/kEx9uV/EVaUtdMab7NieUbEXfBOHPsdoGrrkrF7dZDxmUXmARGuqKip0HF7tUskiPjGsF+B sszBoexyY8NLSaEfaY/HOO7H/kvPt+40qijVutVwJWOoK+MBQb4nd4DAKLbVZCxPFiGc0/+GyBc PJXYktnArkJRc3G00oyBWjzgtjgmyfmxBXHt2YZNY6W5buOuAKLKFObrrXsiG7LS1jlo+oG1NbC bNbN0E3zrM33NX/Pfa6uQV9ALPr0010lqBAOIliLvpsJsWlTRK8fRNmKbAjZQX6pkLU6vOkq8Vy yWNXmpZ15kDepTOR13dDeShH1cYB+5+lZ3t3sVBD7pCaHV/X6GJTq4xZsoeGDT3I1CB5/Sti4vm Hfgg3QuKKxVRecHp8nSjfR6EBYf9cU0RRKF2extgUoEgEgHjvTCLqzP/zC+vYH/xTB/UlwT7jze 0X7W+HMosxY8pTJRhVQLXY1qb+enIeN5YxbNRbDA8FmT7IFqfQajUrzP+VhLKNXObEuKlVFTx7k G1Mtt2B
 IeTyYw5Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 28 Oct 2024 09:04:43 +1100, NeilBrown wrote:                                              
> refcount_t, by design, checks for unwanted situations and provides
> warnings.  It is rarely useful to have explicit warnings with refcount
> usage.
> 
> In this case we have an explicit warning if a refcount_t reaches zero
> when decremented.  Simply using refcount_dec() will provide a similar
> warning and also mark the refcount_t as saturated to avoid any possible
> use-after-free.
> 
> [...]                                                                        

Applied to nfsd-next for v6.13, thanks!                                                                

[1/1] nfsd: make use of warning provided by refcount_t
      commit: 74ca1dc05e0448b248ae3f2be07d716f4938d0fc                                                                      

--                                                                              
Chuck Lever


