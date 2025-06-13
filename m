Return-Path: <linux-nfs+bounces-12458-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7353EAD95EB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 22:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86253B9A34
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 20:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E361A76AE;
	Fri, 13 Jun 2025 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm6vApVF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1E672608
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845331; cv=none; b=qVEBGDFMduEj6gXvSLRtuMme+GetAqHkc/moHfs7n4vMk0XlvVIWXzrs1MlfHL7j35xjWC099H0gRYOF0xIxvlfYbn34vmqQvFwtFn4+ocFo3eoElf2GiIP0iG7Vdh1wftr8/y0z+ljOxRfmyYq/uPQH7Cm9McEbnp4d47qjYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845331; c=relaxed/simple;
	bh=u8/oqRxj4kMvwHqQVRHLh6Wn9sljlOgzbahR15cu+EE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FN8f7EzmhAmZfjZwMcXJRdDWL01xSgjtRGzuLIGtpnATwhnQFxqFWliAv7RHavtlwMyqnsBaPxHmjVrIP9ci240XQ1H4EOd04ixnB3dj1PzJOhdrbkpgj23KdLaIpO/RlDzQyAfKbMCrefRhUn2MjEkii9jqVnLtVWxlGBDDClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm6vApVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9810C4CEE3;
	Fri, 13 Jun 2025 20:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749845330;
	bh=u8/oqRxj4kMvwHqQVRHLh6Wn9sljlOgzbahR15cu+EE=;
	h=From:To:Cc:Subject:Date:From;
	b=Lm6vApVFcQRFpGFVEiG+Gh8cTH2gbXjrKNthFKA4fqFR/fMPwKhzXIvE2BbpDAHVh
	 tIX6aRkA1ZfREEADCnrZsv4z8qYaqquvTd56XrS6QZKRDISeKT93EDLC24ghfXgKqO
	 RGFIN8nESBAsG08yf8qePdX8YK4vgeGN/NZ4m474Ped1FJ6J39BI3b6nAq+8Bh9f5P
	 iMVW4rs5FzSF9TRFG23YYaQ92vyQJJp+jRdVKdK5k0pZicU3zLu/i9qZwlbvu0/5L8
	 VbxrHY4/45Q+sjOmNCB4VyjTedxvZa1qi+B6//gu/vQCFKPsU9wm9VyslOuEzbbVQ/
	 RA+8PlUl1NNXQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v2 0/2] Make NFSD use the vfs_iocb_iter APIs
Date: Fri, 13 Jun 2025 16:08:45 -0400
Message-ID: <20250613200847.7155-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Mike has expressed interest in making NFSD perform direct, uncached,
or asynchronous I/O, independent of how the target file might have
been opened by the file cache. To do that, the idea is to pass in
RWF_ flags during each VFS read and write.

However, Christoph suggested APIs that already exist which
streamline the I/O operation a bit and expose the per-I/O flag
setting directly. The suggestion looks to me like a straightforward
and sensible general clean up of these code paths.

This series refactors nfsd_iter_read() and nfsd_vfs_write() to use
those APIs instead of vfs_iter_read() and vfs_iter_write(),
respectively, as a first baby step down this path. No behavior
change is expected.

Chuck Lever (2):
  NFSD: Use vfs_iocb_iter_read()
  NFSD: Use vfs_iocb_iter_write()

 fs/nfsd/vfs.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

-- 
2.49.0


