Return-Path: <linux-nfs+bounces-17109-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6386DCBFC00
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 21:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B65B301B5F3
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 20:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6131F12F8;
	Mon, 15 Dec 2025 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvbITau1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9521B7F4
	for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765830651; cv=none; b=b7HriX3iz9MYZmg2Jsmt7bIqGENWO0IREzPEbijFvXXwYDdA9+5gyFDM1K20MPfU1sx3l4L9/kyZbvnvc26T7rlSy4FJqxMqt/uGNPxwEXCkm3heN31RvEWmPShrG7GbmZNMRnr4kpYEf8EVH/vqy6AHFwdM5O0d+6RO54YBIOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765830651; c=relaxed/simple;
	bh=vJj4YdbiZddbbLKWjQF77aQfsTq+98a4O0Eqwyt9I2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgnjrIEOZoDYvQTwJDhpxSCigkGCslPJy++54k7mBZCC0nDrmXORj+sr763IQnvgkvtHsHNB7BIVyZP+Ak6cvPu/d5OGZOhXazWLmZ+WON0nnYhqcQs+CqI5bvudhfG+q0rSbFCC9nN5U8m9MIssfoJIw4lZw8V9Cn4PmvGAS9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvbITau1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE35C4CEF5;
	Mon, 15 Dec 2025 20:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765830650;
	bh=vJj4YdbiZddbbLKWjQF77aQfsTq+98a4O0Eqwyt9I2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JvbITau1L7ArFPUfKCRGBf8+OPQm98VK8XD9D2dFniocZJS4xibtgvySb0npQaWNe
	 PIgdHhl+1ZWi8ta7jcccMv85d6tO+nZ1QbtMykGkX+E+wfGVl0X2kMIF8KfC8303t7
	 BAiAFAoIHCietXR5Adnsh1avWP8Klz8nVHHOYY96aYAmuLJk8LlR4QI+P1htfMFLje
	 UZ7z4zjY/6AZBNV9yziE/IE7NcqaZxOGjwH3p6HY/ZvYGR80HnDAhublgcT9c4PB5G
	 zyuZPlxec0JJ1TBnQzkjBlqbHB0ZNqhsbHVMfNhinu8mwmsc+PZdVglKotu8oVsDkI
	 xKAuGvBG9N8Fg==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: Re: [PATCH v3 1/1] nfsd: check that server is running in unlock_filesystem
Date: Mon, 15 Dec 2025 15:30:46 -0500
Message-ID: <176583063970.936743.6618999709129437311.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215191036.17728-1-okorniev@redhat.com>
References: <20251215191036.17728-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 15 Dec 2025 14:10:36 -0500, Olga Kornievskaia wrote:
> If we are trying to unlock the filesystem via an administrative
> interface and nfsd isn't running, it crashes the server. This
> happens currently because nfsd4_revoke_states() access state
> structures (eg., conf_id_hashtbl) that has been freed as a part
> of the server shutdown.
> 
> [   59.465072] Call trace:
> [   59.465308]  nfsd4_revoke_states+0x1b4/0x898 [nfsd] (P)
> [   59.465830]  write_unlock_fs+0x258/0x440 [nfsd]
> [   59.466278]  nfsctl_transaction_write+0xb0/0x120 [nfsd]
> [   59.466780]  vfs_write+0x1f0/0x938
> [   59.467088]  ksys_write+0xfc/0x1f8
> [   59.467395]  __arm64_sys_write+0x74/0xb8
> [   59.467746]  invoke_syscall.constprop.0+0xdc/0x1e8
> [   59.468177]  do_el0_svc+0x154/0x1d8
> [   59.468489]  el0_svc+0x40/0xe0
> [   59.468767]  el0t_64_sync_handler+0xa0/0xe8
> [   59.469138]  el0t_64_sync+0x1ac/0x1b0
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: check that server is running in unlock_filesystem
      commit: 6ec307901ebd34e7a05f4a1b14b42188d6057c9d

--
Chuck Lever


