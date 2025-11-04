Return-Path: <linux-nfs+bounces-15991-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6690C2EE19
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 02:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A230018885FC
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 01:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F5A21ABBB;
	Tue,  4 Nov 2025 01:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1rmbqE8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB4372614
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 01:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762221024; cv=none; b=batKFYXEIp0qvVXgjVv26x4jUf/242KOfKsIGnCYsZFs5Wn3ZPhElRhkhru01oir034XqcljgW3V9lJQuUTM0tLPKegDtJoywKsd/FWy6XE3C4p+nHmNpS9QZAVUEEludvhlkXCenN3ubAHJJEuohgOcNLSW12qwcR1VQhzeNZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762221024; c=relaxed/simple;
	bh=ArUbHz837jGCzBKiF7G63BOAzfRXtQ8g2xjjw7O2Tf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkeVzSU888M+V9MP+BOA8fPgpijcTNfD2fUf7PgfdSEsdkjqlv2xk3ZMzmC6aUC/nD6P58PMm9LFVj6Gwqtdu3LErUx6CGr5YTvvwOU0dirKw0xB4NcdopRULBWzQD70zy/9lvndP5s8eyQh54DNvWHzx/ImLa8PN6JNWH64RUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1rmbqE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBA8C4CEE7;
	Tue,  4 Nov 2025 01:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762221024;
	bh=ArUbHz837jGCzBKiF7G63BOAzfRXtQ8g2xjjw7O2Tf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1rmbqE81nElqaaTD4q7DQqEVR+e7xf+l2VF7sT7BjntN+XAPvntOUypjNrMOmaU7
	 1tO5dZYQw/NSrXEqv0YM0tGSv5OvglhQkmawlZhi7iar+8gCv5j5WdzAJIb2nykvnU
	 eQlboWHRcOr79hmo+9/OXe8cgf/BqOoOwry057vdGDepq3AXVDn6w59Vb44oY479Zw
	 h1VFfWGmJuB/b+zViUOvD3SR9CcLs7WtpQiZrJyMatvXq/7eZBYmx08DiUL5Uv7NLW
	 lMNOQl+VL/SORRyIpgUqcKwHkxjcMmw1yzWNfJh1M9AAeo86xLU2l4w2wvKpkM8qyq
	 P1Jy+h3wkl5Mw==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: Re: [PATCH v2 1/1] NFSD: don't start nfsd if sv_permsocks is empty
Date: Mon,  3 Nov 2025 20:50:19 -0500
Message-ID: <176222101233.32169.13503558412269965060.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103175734.38634-1-okorniev@redhat.com>
References: <20251103175734.38634-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 03 Nov 2025 12:57:34 -0500, Olga Kornievskaia wrote:
> Previously, while trying to create a server instance, if no
> listening sockets were present then default parameter udp
> and tcp listeners were created. It's unclear what purpose
> was of starting these listeners were and how this could have
> been triggered by the userland setup. This patch proposed
> to ensure the reverse that we never end in a situation where
> no listener sockets are created and we are trying to create
> nfsd threads.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: don't start nfsd if sv_permsocks is empty
      commit: 1782663f9156302f16f9e8c3fee3dee0865f6eac

--
Chuck Lever


