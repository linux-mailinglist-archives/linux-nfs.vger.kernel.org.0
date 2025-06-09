Return-Path: <linux-nfs+bounces-12223-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFECAD28F6
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 23:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772643A44D8
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 21:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C832921D3F4;
	Mon,  9 Jun 2025 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="MVJaTZl4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A111401C
	for <linux-nfs@vger.kernel.org>; Mon,  9 Jun 2025 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749505972; cv=none; b=sgdvKrPghMQEKo3wW/++MkSwqjgk3AgUT0/PyQApgnZtVhEvxlDYhRJ0XoLd6kRv2DRvVGxwvZvx+6dswh0pcZ+cQV7xU/0DzD0mq2Yl+F7vyt7QEq9uS5SGFyMGwmXy1G4jrGDc3fZLpUMUNMPtzc7bGVUQ2+e83+FWTLT8DP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749505972; c=relaxed/simple;
	bh=px5cYI7LfaG+ED4nCTa3HeK2DAAvpnD/sf3UkqpuqBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDbcNJ23nqWszJYk1spbvXNW70YrUaHXiL5tJUo6HvXGb8b+EOmwuTMU7RtYoBg93b4qe1dIT+8wk3bCSTwSidxupmOM3WRE3LEY0NtwxWtYdN2idq2/KW2Hs5QKn/F7wBg+baM80dMtr9eitQsaCpEMtYXtqPbtgAGgNTueK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=MVJaTZl4; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [IPv6:2001:638:700:1038::1:9b])
	by smtp-o-3.desy.de (Postfix) with ESMTP id AEA9811F804
	for <linux-nfs@vger.kernel.org>; Mon,  9 Jun 2025 23:43:14 +0200 (CEST)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 39A7313F647
	for <linux-nfs@vger.kernel.org>; Mon,  9 Jun 2025 23:43:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 39A7313F647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1749505387; bh=3hR04zluhm5VmPy7cYstmix/+kp6p/z95hwKbKS9uR8=;
	h=From:To:Cc:Subject:Date:From;
	b=MVJaTZl4aVSDGAR//9Z3QSaS9oEKkNQqBI9JSD+XJVAydV1cYHk3jZLkxRB08Z3zG
	 7tgFigAR1cll/4bfEmY0NNQRq7uw6dpeK190ClWV8ffya1ngQc7xjW+2RC5vppUpvQ
	 sdMZ2o4t2ntV3KQ4XVrKZ4J03TKof+YgGVRPto3I=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 2DD1920040;
	Mon,  9 Jun 2025 23:43:07 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 2110940044;
	Mon,  9 Jun 2025 23:43:07 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 3585E320093;
	Mon,  9 Jun 2025 23:43:06 +0200 (CEST)
Received: from nairi.desy.de (VPN0424.desy.de [131.169.254.169])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id E367320044;
	Mon,  9 Jun 2025 23:43:05 +0200 (CEST)
From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To: linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH 0/1] pNFS/flexfiles: mark device unavailable on fatal connection error
Date: Mon,  9 Jun 2025 23:43:02 +0200
Message-ID: <20250609214303.816241-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As mentioned in the thread 

https://lore.kernel.org/linux-nfs/601285843.50695650.1748800817824.JavaMail.zimbra@desy.de/T/#u


We observe that interrupted batch processing jobs put the client into an unrecoverable state that requires
the client host reboot. Finally, I was able to build a custom kernel with all required third-party drivers to prove
my assumption. So indeed, marking pNFS device unavailable fixes the issue. Thus, please consider the proposed
change and backport it to older kernels. I did testing with (which is not part of the patch) and will try to
add a trace point as soon as I find out how to implement one.

Tigran Mkrtchyan (1):
  pNFS/flexfiles: mark device unavailable on fatal connection error

 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.49.0


