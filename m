Return-Path: <linux-nfs+bounces-13799-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66C1B2DF64
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 16:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F19172FB2
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 14:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5120320CC6;
	Wed, 20 Aug 2025 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGZ5OZwK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A033D320CB3
	for <linux-nfs@vger.kernel.org>; Wed, 20 Aug 2025 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700052; cv=none; b=dRqYTz+PqIJMjL81ELRwoaNWwO2zKdzhjon4j6zAEgPWS1tWBw2NvfRmEGyXfy54zEL3i5av2prfcSRSfDGikZ+5fgPCItGC3s4pLGpdNzLBxvoT9bYY4Y46q9wMLSgTR/L52q31PP+fKppp4JmEBl3AdxrB8MKWA8Vpu7tK+0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700052; c=relaxed/simple;
	bh=2wP1STMAZGZlPOS0R+HzffMea18KTXZ6Fby/4ymssKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7KnGyFyxPoASdD0pYrEQ07xlRAp85QSoxAMDXvVahNUVbV6EH83oFlaSrMWwFH1AAT39ICny4px/+6kPB/ocNa31CGiHis/lylgD0jUxf8glYm7CjmNb1u7IlQ10YdNQo7n7vQA2McD89cbvkWw/iPg6N7Hn6jIhd/rt5qb/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGZ5OZwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE80DC4CEE7;
	Wed, 20 Aug 2025 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755700052;
	bh=2wP1STMAZGZlPOS0R+HzffMea18KTXZ6Fby/4ymssKI=;
	h=From:To:Cc:Subject:Date:From;
	b=fGZ5OZwKKe5sqwuz8eqYldgzjNwGce4jV414fEomBDdI+FBciP4rpUYk8s7ImxuKl
	 1bI/X5SHvpLANfPVQhYx7SEQ/dr14CwwSH1q6YGAQhRX9rIlvx0kqJdPuGsEmGbwww
	 IsuDcnRSXfQdKXLc4hAn2GgdhPYowgXGEkH5P0ITCbE6gwi/4yhpD278ZcKZ9ACpF1
	 t3NhrPCHmgNT6ljbdhPYpmoNDFTGyRVvv7xPFAqMJKQve3uihP9KSxXETMh6wcOeP5
	 LwKE7L6a6SKx6GJhLG2mBR9JIzXjB4UnMupIG4t6Wzue6V5kQxYYixyhxQFbBlKgoc
	 9fo1XV+NtXABQ==
From: Chuck Lever <cel@kernel.org>
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 0/2] rpcbind unregistration clean-ups
Date: Wed, 20 Aug 2025 10:27:26 -0400
Message-ID: <20250820142729.89704-1-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Following on Olga's fix, here are two possible clean-ups I found
during code review.

Chuck Lever (2):
  NFS: Remove rpcbind cleanup for NFSv4.0 callback
  SUNRPC: Move the svc_rpcb_cleanup() call sites

 fs/lockd/svc.c                  |  6 ++----
 fs/nfs/callback.c               | 10 ++++------
 fs/nfsd/nfsctl.c                |  2 +-
 fs/nfsd/nfssvc.c                |  7 ++-----
 include/linux/sunrpc/svc_xprt.h |  3 ++-
 net/sunrpc/svc.c                |  1 -
 net/sunrpc/svc_xprt.c           |  7 ++++++-
 7 files changed, 17 insertions(+), 19 deletions(-)

-- 
2.50.0


