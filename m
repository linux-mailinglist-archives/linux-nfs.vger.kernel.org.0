Return-Path: <linux-nfs+bounces-11353-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E217AA1AAD
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 20:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59DC47B745A
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 18:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E209227E95;
	Tue, 29 Apr 2025 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDY4FgbV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE657224234
	for <linux-nfs@vger.kernel.org>; Tue, 29 Apr 2025 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745951597; cv=none; b=cSNJg/Ae24l8yRoDiMTERCBlH8ywY78Ban7i1MuROa1PUnIUTMZD1GfRYOfJ1berpdODdaEWmkdoXOLyXwSfReag4zDuzN2YKr8vJEmoalsdK+I8CgcUOgzG0X5Eez2bLEy2FemLnDYiqvXW/7csmHlX5VybhCsvzsy+NhIBMR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745951597; c=relaxed/simple;
	bh=tCvypSRxNmYLCiILc34x9OqnSmi5rktM9dQSQ7f+TDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u9QmEka+mGQwcynHhamNrGrxqVIraZzVFNVX9sWoszLyMa3G5sl68OBFE7s5/J9MCqu7H7A7T2orH/F6REsNNLhtSOZ9WAIBV+BzeZ5dvZk612alv7pvqISDyFgktlvaolEVwINmAdAn2HfOk7g9e3CZVZvbF+CndVDVWyF/cMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDY4FgbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7B1C4CEE3;
	Tue, 29 Apr 2025 18:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745951597;
	bh=tCvypSRxNmYLCiILc34x9OqnSmi5rktM9dQSQ7f+TDY=;
	h=From:To:Cc:Subject:Date:From;
	b=IDY4FgbVyu0cZVzK548H9vYsOwZ+7SJFa5Nu2vlOBeGzZShKWiYUCwN69bG4gNCii
	 5evfPHSE5/5V9/ZQUl/TI+9txLG95nPqPjtf8Z+NQvgdxAC4D+WFWxXO8Mj0/+nL+Z
	 VQjJpiPQ7gWUjLPng91qx3MQP/V5/EwJH9As1tiXeDC1MYm5KG2vMmrn/st+1jJP6F
	 jyt5BWbL451K6ORfKpE9fSswCcB7ySvXq4FGRgP1CsZGF2ScqTTs82gfbxmA7mn7yz
	 G4A28rkDAV6pXfkLg0PPZ1eYIi1GAbs7wvjnjuIW4fVsJEk/QK6psRf45dpL/qazXJ
	 bJIlP/YzgXRnA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH v3 0/4] rpcctl: Various Improvements
Date: Tue, 29 Apr 2025 14:33:11 -0400
Message-ID: <20250429183315.254059-1-anna@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

These patches depend on kernel patches that have been included in
v6.15. They update the rpcctl tool to use the new sunrpc sysfs features,
in a backwards compatible way that won't crash on older kernels.

v3:
 * Rebase on top of the 2.8.3 release.

Thanks,
Anna

Anna Schumaker (4):
  rpcctl: Rename {read,write}_addr_file()
  rpcctl: Add support for the xprtsec sysfs attribute
  rpcctl: Display new rpc_clnt sysfs attributes
  rpcctl: Add support for `rpcctl switch add-xprt`

 tools/rpcctl/rpcctl.man |  4 ++++
 tools/rpcctl/rpcctl.py  | 50 ++++++++++++++++++++++++++++-------------
 2 files changed, 38 insertions(+), 16 deletions(-)

-- 
2.49.0


