Return-Path: <linux-nfs+bounces-10428-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFE8A4CA1E
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 18:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7613E188F36A
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 17:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9BF215169;
	Mon,  3 Mar 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot+RHcgD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EBB1E48A
	for <linux-nfs@vger.kernel.org>; Mon,  3 Mar 2025 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023332; cv=none; b=H2/0xZEyNzJtPFnPFSplmfx8ucaRk9D1xKYfoI958LUUqszlApEJ4Lnr58QqgM6RtCl6pXnZ0PPpl3DoCEVKWZDq0WTsoJKZf1SNoamEG9JJQyvp+s/YTnyN1vFq0mKeJSeyVPgbpoHFeWmnlNa7P+uCAUMGYN3y4RteRDbWAP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023332; c=relaxed/simple;
	bh=t69ktUO+7E7CjBp65CqBZplb0EiXKqdruu5XaU72eV8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HmiulKgiFgqx7KzaMg7xHHnm94Y6RBZpBGlxD+YElAAd43qpDtJMs8iXrJtJo0yL72UwjraENNMgun89voA4/yfg2GmAYUCO1PtSxWOHpzTmiLkTIWKKLaHisGY1Jhxqw99qxu/ZyFXx4H0JRCxqIihMzmn+SL2hbQazbr9516w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot+RHcgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41872C4CED6
	for <linux-nfs@vger.kernel.org>; Mon,  3 Mar 2025 17:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741023331;
	bh=t69ktUO+7E7CjBp65CqBZplb0EiXKqdruu5XaU72eV8=;
	h=From:To:Subject:Date:From;
	b=ot+RHcgDGQDUUSfCwbN+juVRQ957+5yzXMCeFTFGr3AhsuZZVSkB6DfNRivbgKyBd
	 5MEj1R2MVi7g5cE215aXJDZmuzgvLL0WxfZ6Qi3hgAtPOWTh9jao1mcG/vgbhVdC93
	 FOk5Vm+KxgAHKUQvapVVQuCg3bsfQFPqw9H32RFA4laGTJnRdl8HscSMcXzWQfbefP
	 4RN74ZrGxn8qBC+/auzcOXEGU38IzSHmFvHEMReEM+p2ND+n5OAd3J8miA35NmH+3K
	 PwiRZj7MkJp3/YN4MclSs3R4z8YC6Ot/S1vOdiuoOVbGr2Ln3EeSuOfGTbawU6LB0o
	 DaYBk3PxuNQtg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH 0/4] Fixes for looping in the NFSv4 manager thread
Date: Mon,  3 Mar 2025 12:35:25 -0500
Message-ID: <cover.1741023037.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The following set of patches address an issue where the NFSv4 manager
thread can end up doing a lot of looping in order to do asynchronous
returns of old delegations. When the list of cached delegations gets
large enough, this can sometimes lead to soft lockups being declared.

Trond Myklebust (4):
  NFSv4: Don't trigger uneccessary scans for return-on-close delegations
  NFSv4: Avoid unnecessary scans of filesystems for returning
    delegations
  NFSv4: Avoid unnecessary scans of filesystems for expired delegations
  NFSv4: Avoid unnecessary scans of filesystems for delayed delegations

 fs/nfs/delegation.c       | 63 ++++++++++++++++++++++++++-------------
 include/linux/nfs_fs_sb.h |  4 +++
 2 files changed, 46 insertions(+), 21 deletions(-)

-- 
2.48.1


