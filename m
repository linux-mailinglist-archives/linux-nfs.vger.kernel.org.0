Return-Path: <linux-nfs+bounces-13427-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F33B1B651
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 16:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A137ADDDE
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 14:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94B72749D3;
	Tue,  5 Aug 2025 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ2EBJdx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D732264A0
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403884; cv=none; b=K69UQW62RM+e5esgjpVSDfnm2TvVkxFodIQhStjPhmLPBLy/W8iJZusNQZQAdistANNjiq2rfdHsNxcgIjCIYAr/yhZCgcH6ku5O6ZfuoaQ52s/jWwsHVnnSIYj3TKu/t89O3Bj7lToQDnvQKN1Qt32uHH9xL4hxbO1k7gLShx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403884; c=relaxed/simple;
	bh=YmXROR13dzOgq82gnY88cA1Oo3VtlSna2yMVASHqEng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eG8FkzM9IZc+zsJzp98NBhfLL545sMj7TdzDtheccVsKqHLb8MhRW4X8WriS/PmxJyXb6KSkTIltae+9WW3kKQWzeLLj5G5k6z6x1/eGgzbRZSaPsh+lTKr9r57jNeikIdZvAQfyIzTV/loJRaM2dDwd9OC1+W5QMiqzuevpZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ2EBJdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F1DC4CEF0;
	Tue,  5 Aug 2025 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754403884;
	bh=YmXROR13dzOgq82gnY88cA1Oo3VtlSna2yMVASHqEng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQ2EBJdxDHGXXcT6i0LDu6FnBeTEd2WLOJ3PQCLcQRWwdO/wNzQd5hv2wApUOf2sd
	 nEAtQtedozgRx57MtJ0PjsAV2W7x5HwhTJCqs0Qv1UwvThclEtANfQ3hn+w3wx+cce
	 GoOOwo2RhTiZqPZByrWeX+FXLeEHdKBwYfMUh9ZzJxUCBVCdKHI0uCY7EbaEZR4p4F
	 O7L6x0E/anjn9JhrczxJQWMxm2EVEl8uFkTcROrrRrDHBuR4/p/788uG5SiNVg1/FO
	 5ZPCzU+KFEX5gM2VcOsldhp0vYWL678acC3qjzQV50J0OHcTZeahxpOTtuetNuEgrq
	 +ASFHrzA2HXgw==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH v2 0/2] nfsd: Clean up nfs4_make_rec_clidname()
Date: Tue,  5 Aug 2025 10:24:40 -0400
Message-ID: <175440385761.99423.7408843667966941183.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250804224701.2278773-1-ebiggers@kernel.org>
References: <20250804224701.2278773-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 04 Aug 2025 22:46:58 +0000, Eric Biggers wrote:
> Two cleanups for the MD5 calculation and formatting in
> nfs4_make_rec_clidname().
> 
> Eric Biggers (2):
>   nfsd: Replace open-coded conversion of bytes to hex
>   nfsd: Eliminate an allocation in nfs4_make_rec_clidname()
> 
> [...]

Applied v2 to nfsd-testing, thanks!

[1/2] nfsd: Replace open-coded conversion of bytes to hex
      commit: 9093f8308442fc5096e973a46107f8623e2b336b
[2/2] nfsd: Eliminate an allocation in nfs4_make_rec_clidname()
      commit: b0a26370a4129a7e3b477f80c39b08ed5faf1422

--
Chuck Lever


