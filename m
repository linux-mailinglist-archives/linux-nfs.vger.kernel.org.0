Return-Path: <linux-nfs+bounces-7590-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2510D9B6DAD
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 21:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB7A1F22224
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 20:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E1B1BD9E6;
	Wed, 30 Oct 2024 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUIQ8zwe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8781BD9DA;
	Wed, 30 Oct 2024 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320220; cv=none; b=jbq2agvRSMCbF/1kQhRTRxEM+QjP/jDdLzBLg4/WjXRqXZ60BxF+ypiVQmO8CF1Mk48xqBAKUQJHoXHApDCx7uu8meAaKWvSqhm8Xw56VEpKZaPN4wwoCiyayYJEw5mStZskd65jykroGKoUcAC5A1z+rtGRHKQIA+IsK3vRIew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320220; c=relaxed/simple;
	bh=GSIJ035ylUTtlnBe2BWwGpbq6N5x8JvMFxRErH3XITU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AO7ltRZxa61nJxz8TegrcblybgNfqKIay48DMH7bw/8No4HNDmEUShN+R9/59iAelJU2gHhgubRC0NCb1dEtOfy0rk3FQKeZRGNgGFGpsUnUOUw23H7fyBvQukgxEB/lmmwVnupeRu8hKrfBy82de4GR4DohKMqZKKNmyfwx+BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUIQ8zwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286DEC4CECE;
	Wed, 30 Oct 2024 20:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730320219;
	bh=GSIJ035ylUTtlnBe2BWwGpbq6N5x8JvMFxRErH3XITU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sUIQ8zwealJz8la8B3meNXwZm/IcHQOv0JSHGIGpqc1cm0kHeu17Z9QwjpJ2kfAnO
	 nlUBIPw8VlTgl/Wnlvz7n2JL1whn2293aM729Pek5rDjxVT0cHuGE+jTAOl4Gdi2bF
	 vNwZbYPZbP0nSrx6123bpa0tPDX21eilUKCOuyHlwrMvMf4JCdY0CiHlUD8k7rR0Qr
	 BlUWx9E2E5Dhr1mlQtZe6u3gy0r26pE6O9kQ9YFUHpWzPSkjGkpiLtcw+0hQyZEHbd
	 o0DBLfJcebMR/KQ++OfuGJAmklSPZMmQgTalPXevvnqvKH51U6ebrsIKFPWjDrp2mD
	 1C+3/5pXR9A6Q==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] nfsd: allow the use of multiple backchannel slots
Date: Wed, 30 Oct 2024 16:30:10 -0400
Message-ID: <173032010891.47979.16372737966948328031.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030-bcwide-v3-0-c2df49a26c45@kernel.org>
References: <20241030-bcwide-v3-0-c2df49a26c45@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=519; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=V0YiDuOkQoIeaSMhsdfVxSemxtPO3BSkOT5QC9ao4qE=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnIpdSLIvIX8RcNPMhNG8pq61h9rgXuGx72Sdgm e/M/S4M2V6JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZyKXUgAKCRAzarMzb2Z/ l5snEACDyE0blPoeX9FelAMAqz+9OSuZWtE/tBNTeumC6jZZbZMMiEI8FzMKZGp6mbFAO5VgLa8 pQLUCIjg3s8K8uCFNXBrhBDLmGiXbA6HIM81AQ2T6rUr79HhvkCwhvVw9yoq80Efi/79TNIBR8A VKMQgs9JmseKddSzaAr4lA4IR0sYyZbWnRbZjuGs6PXtXhKfLVWPNdqy0X/59iYyx+8ETQjG6aN qbKjz56U2reMmDW14a3qq6y3vAwUQvTNLEcNfzZPikHrklkxGbtBi+q1d4vdCmr2qL9fYZsSBD/ WVYO/Q1YwJtluT3EKP/Fodde9CxrWBWa6mya/ZRiT8Wg4koK6kRv0j0IrnzNs5tP39kcqZo8C/6 7et7T0HQtg4tkTtwOJu7DgQWcHZ6Vx1n60TloRy1IHvTe69lzAd8DuuujCb0C8uNCDfaCTvhuDf 1gCqoYqm56aQyyDbTmzYZMwtA8e1Tof5Ve940ZzDE9Ct3zhX3iEW4HifVy70jyvUgixPTsyZsmU hLrmFrH5dTInP+szRIW1pnM1twFsPEFRLNgqcldTJ8oLmxR9ZkR1sNCBgXvcSXph2SDIaAkkTgD EDB1cb3+9JZFtm/9U3vqUP4n4NmRSGdtvLbq9Mdl3TO7JIsb379ADwJoKJbfMQ+8hQMfCKJ82cC 0/MeHzy
 bBUbnZ6w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 30 Oct 2024 10:48:45 -0400, Jeff Layton wrote:
> A few more minor updates to the set to fix some small-ish bugs, and do a
> bit of cleanup. This seems to test OK for me so far.
> 
> 

Applied to nfsd-next for v6.13, thanks! Still open for comments and
test results.

[1/2] nfsd: make nfsd4_session->se_flags a bool
      commit: d10f8b7deb4e8a3a0c75855fdad7aae9c1943816
[2/2] nfsd: allow for up to 32 callback session slots
      commit: 6c8910ac1cd360ea01136d707158690b5159a1d0

--
Chuck Lever


