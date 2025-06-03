Return-Path: <linux-nfs+bounces-12068-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAA7ACC5A2
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 13:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC833A443A
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 11:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CE422DF85;
	Tue,  3 Jun 2025 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/t3uCpC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D68A22DA0A;
	Tue,  3 Jun 2025 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950952; cv=none; b=u72xZYyYmBgVWwI8l64DwQGDyHIYFF3pHMt+7cOr7MdswU/wfiH9+Uk+MPxVrXHUdZGMkp8NjpMN+ZNWfGoQ0A3bvv094R6trUTYrGxTdx6mqykBcCeMwzAREuENKJXZdVnog6eTShlvOsJa3Kmu9AkUIrCE1vEf+uVPLDLbw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950952; c=relaxed/simple;
	bh=Ff53/dBOn02tu8unDuQE7acOfEwLWwrBf8ZUP4pXjeY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QcLWWWcWKPnzbkjErvOrSqL+BuFB7hODe7vHqu+xnUQsCMFoPdC6bnmdMzzY17plVFAdVG/XrBOnrP/m70A3NRF+ITHd8gOjDr9+VrYiRVNhoP9JQISC7t7kIA+wRSJ2+9JlEVFpV4iM8QEewxiKgM5HVk+XhFzwQQmWBk/2UtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/t3uCpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A532AC4CEEF;
	Tue,  3 Jun 2025 11:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748950952;
	bh=Ff53/dBOn02tu8unDuQE7acOfEwLWwrBf8ZUP4pXjeY=;
	h=From:Subject:Date:To:Cc:From;
	b=h/t3uCpCsNkaHLegrlbjQFm/N102mM3hnc0R5zGqP3xByuv6QMyT5TJGyF7ZqJnax
	 68wgwIOzHIlUZjhEq9zMNqEGZ6EB757611Bpzv28C59IECUtFDwDgxGxHTrauuaGt6
	 OQtxsi6yAv1WY3S0v2Nzj9mmzekrTB0NpAEthw7ZSkE5AoyCvjQNZdqOmoo5D7zgE6
	 nK8c3jWBrIdaNrsyawZIaCTsEoR9YP4ecG7LR1sam+zYa5yWKKrVoJKrWm7++4245q
	 5zyj6j+dife93WOyl6z+SqcIQHj2GPf8Z3jIjUEbis/yFf0EDhuQAaV+zhRAg9DnNn
	 75YrZmqQo+n0A==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/4] nfs: client-side tracepoints for delegations and cache
 coherency
Date: Tue, 03 Jun 2025 07:42:22 -0400
Message-Id: <20250603-nfs-tracepoints-v1-0-d2615f3bbe6c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ/fPmgC/x3MMQqAMAxA0atIZguprRa8ijiUGjVLLI2IIN7d4
 viG/x9QKkwKY/NAoYuVD6mwbQNpj7KR4aUaOux6HNAZWdWcJSbKB8upBp33vQ92sC5ArXKhle/
 /OM3v+wFY7iJ0YQAAAA==
X-Change-ID: 20250603-nfs-tracepoints-034454716137
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Ff53/dBOn02tu8unDuQE7acOfEwLWwrBf8ZUP4pXjeY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPt+hYqlTwpo/mMUyUVg3vaH0k4ZAeBHg1OOWu
 Zi4FljrCYaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD7foQAKCRAADmhBGVaC
 FUPuEACHqVF7/D9r5TLGqJ3qfsX0OVGZ268VRpiu+/XxNi/kg6Iyiq59kF+K+4NW9FEx/j//1Vy
 BiCVngFdjWRx9MhBHznMM90BnoyoWkeKJNGAnulvTKEOIwLSqQTg/dsgbMzbhYz9upFMOWVo2Dz
 cdcpHrpFJq6yf7bumxnaqPQukhyUC0nJsGGyUBox9YSYLYnRAXkRGNzZzS6YBJ1IX1rouTu70oB
 cPJb5ErFZOn246f5/Hn2X/wBg2KfKzt1Gd8CVtBxyuH366r1nnySD1/y+3GN0IKfGfvtJmGr/I6
 MqbR85G95vd3/axvrMH+X7F6CWxoTpBT68G0/biGpSjLc78UgYxc/PvgPSH9EYKzKOXQzrO++T2
 aelsj2zJXZ+pbUFUopwclNxgZD3yUR7oLYHw6qW1Z3VzUBjuEgMmRWGHfDFDg6qH8Z/xTxCb+ZW
 UkK8aHQ3ARtSH/AXr0Hq87MbBs4rzNA4vUaFzSYnW8KuGO9PxzvpymfKPoWRoB0mI5WTyx+sKGa
 jKHTNmh7c/zpbBN29iFzchqFjD6FuSyjCifTpdKXs5M5LWhUrqwWPtpcwVmm4hjqTK4JUGcAz8u
 K8sGVP0nANk/urdFUpZOPv4aV/DFLQYpTDPBhAHyaMk7ziPQDCZuAV5GmXt/N154azZWmTU0yXi
 Iih4lrNbu9+Zg/A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

These are some tracepoints that I rolled a while back when working on
the client-side pieces of the directory delegation patchset. I think
that these are useful in their own right, even without dir delegations.

Please consider these for v6.17.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (4):
      nfs: add cache_validity to the nfs_inode_event tracepoints
      nfs: add a tracepoint to nfs_inode_detach_delegation_locked
      nfs: new tracepoint in nfs_delegation_need_return
      nfs: new tracepoint in match_stateid operation

 fs/nfs/delegation.c |   4 ++
 fs/nfs/nfs4proc.c   |   4 ++
 fs/nfs/nfs4trace.h  | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfstrace.h   |   8 +++-
 4 files changed, 118 insertions(+), 2 deletions(-)
---
base-commit: e3e3775392f3f0f3e3044f8c162bf47858e01759
change-id: 20250603-nfs-tracepoints-034454716137

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


