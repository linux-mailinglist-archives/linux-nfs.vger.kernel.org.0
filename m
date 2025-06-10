Return-Path: <linux-nfs+bounces-12275-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44117AD3E35
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 18:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C2F161ED5
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 16:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A50823BCFD;
	Tue, 10 Jun 2025 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1DWBGB9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2E15A85A
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571513; cv=none; b=ffIQS0cAx+Qw6AJlRiMFlY9UeqIjMkiPDpXerjKTOqqkAk4D60XUq1ch+xibkR2P6dO6i4wdmGIg3lWLRUefI9pD+BUGc9qePZfpymXlCd4nqhaM/6OAUP+0RFpqFKnruRODrINrMGjgTbpKAVSiCv0Oum3x8/RROfgMI13y/Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571513; c=relaxed/simple;
	bh=8M+CICboWtCGZ7ZNiM2Ju6yrA1TRAW/+hjLcS9DE7MY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5+F1aFullFqGTjHthKEbn2ShRpxbiOmO/3lVWvRfQoZjhKphar/hqAkmteOSIrs01neqfj9bAUalOMvX/lC9MHAUiKt4+PoDhudoD+HYAbtLzwL1vTu1c42ks7jTjOJTVaFPgNljatjucZS43qH3sdUuUtm62kaATwWDNVnwWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1DWBGB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC11C4CEED;
	Tue, 10 Jun 2025 16:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749571512;
	bh=8M+CICboWtCGZ7ZNiM2Ju6yrA1TRAW/+hjLcS9DE7MY=;
	h=From:To:Cc:Subject:Date:From;
	b=G1DWBGB94MNZRTA7kQUfA6GqL4c48q4S24ps0El9AbjWPKQpzony48o9GzJCOzLib
	 GXoydkwDFi6zERVh/gx9V2nouEZ6eXgPstp8cK5QQnMnHWSAgT4LyIUwQ5Ifq7LQSD
	 CDI1szcKoY00XiWq0pKlYpI/vcoRfC4IEt07eXw2bcAICNmEVrNxSdttxfZ/d5WVH2
	 RVnSiuj+M61akzscJ1vUX+zpSrXXUeexTigDHgfyTObKLmB14o2elcwWXl1ome9Q9U
	 afzPaUzHyPgMI1zt7SqewvwSmv9D1Z21qAZmLZyK3g+h8aMCP3EiPueVTFSt1buUwX
	 3+JretnLX3s9Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/3] Remove the max-ops-per-compound-limit
Date: Tue, 10 Jun 2025 12:05:06 -0400
Message-ID: <20250610160509.97599-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

After some discussion last year, Jeff reasoned that there was no
architectural reason NFSD has to restrict the number of
operations per NFSv4 COMPOUND. This is an experimental series to
explore that idea.

Chuck Lever (3):
  NFSD: Rename a function parameter
  NFSD: Make nfsd_genl_rqstp::rq_ops array best-effort
  NFSD: Remove the cap on number of operations per NFSv4 COMPOUND

 fs/nfsd/nfs4proc.c  | 14 ++------------
 fs/nfsd/nfs4state.c |  1 -
 fs/nfsd/nfs4xdr.c   |  4 +---
 fs/nfsd/nfsctl.c    | 31 ++++++++++++++++---------------
 fs/nfsd/nfsd.h      |  5 +----
 fs/nfsd/xdr4.h      |  1 -
 6 files changed, 20 insertions(+), 36 deletions(-)

-- 
2.49.0


