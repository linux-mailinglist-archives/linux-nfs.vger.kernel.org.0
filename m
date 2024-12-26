Return-Path: <linux-nfs+bounces-8784-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D66C9FCBDF
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 17:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE86161496
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 16:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5C686252;
	Thu, 26 Dec 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZtbc2Me"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45944C74
	for <linux-nfs@vger.kernel.org>; Thu, 26 Dec 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735230536; cv=none; b=j8RJj0yDFaOQM8xSE/OlepZNff35L8xlAh+tjM14kL0qKdQJ/Rkr/AtFR/IBYQDPHzzUOxFsRwkh3C8ABv+COUn3nnr/p75R7IYjgaCAQA75dnDV33lkIccPouEt0k1ywj/wd2x4rZsWp2RpTodBdWK0I1WSnz5KR2/e/bgU7tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735230536; c=relaxed/simple;
	bh=+otuU0aaBISc3Bf/d3MPZgX0bCtwLPMqQd3XaRzD/2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZCAe5naKHcFGORei45rkZq0UFNDJtjgSTcUtoAqhakbHE1DtR3v0egwAQdFnehoaC7iTKRBMwifn97vIj8LbmHK7C8KTtPhMJj9aGBd/nQRNdVgRqcRHwiDGzE9XpF0FpRm+8XkkiMk6nexRx/pRVu/SVtSqc/aGp/4avUZbpck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZtbc2Me; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E30C4CED1;
	Thu, 26 Dec 2024 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735230536;
	bh=+otuU0aaBISc3Bf/d3MPZgX0bCtwLPMqQd3XaRzD/2w=;
	h=From:To:Cc:Subject:Date:From;
	b=pZtbc2Me+Lg6CLbGWuHtjwtwCLeWDgOVAzzTq6yz8G9ebGVtwsse2BZkO2q9mo6ft
	 cW5uMbPoow/noeQG9SZDogNar2mEYgmI1dhxyj75FPkZE/qXjRjwMhyAyIylQe9J0W
	 +or/LH1r4VB0ukEeH/KbF957eCpTVt5KJYP7oPbbYlHCZq6SpYCSM5u6BCnQF1bsGH
	 voenKp+avYec0LRVWUOVdjYPYgL4gpgjbpLV5I32A9dVgnrE/3UPZ4Y7jmgkPP3fzO
	 2/Y34oG0Gsa+F34zmHNxyhbVCNQbVQXpu7dJu9BE3mTVH+fEJCuGX5s34qXlHPu5Jv
	 hDmUI2m17ynnw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>,
	j.david.lists@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 0/6] Fix XDR encoding near page boundaries
Date: Thu, 26 Dec 2024 11:28:47 -0500
Message-ID: <20241226162853.8940-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Refresh the patch series to address the longstanding bug pointed out
by J David and Rick Macklem.

I believe we have identified and addressed this issue in all of
the NFSv4 COMPOUND operation encoders on the server side. Only the
GSS integrity and privacy encoders are still vulnerable but "safe
for now". Barring further review comments, this series is code-
complete.

Neil suggests xdr_reserve_space() should not ever be open-coded in
NFSv4 code. That seems difficult to enforce: nfsd4_encode_operation()
is certainly an XDR encode function; it lives in fs/nfsd/nfs4xdr.c,
for instance. So xdr_reserve_space() seems like a reasonable thing
to see in that function. I'm not sure exactly where to draw that
line.

Changes since v2:
- Address same issue in NFSv4 READ/READ_PLUS and fattr4 encoders

Chuck Lever (6):
  NFSD: Encode COMPOUND operation status on page boundaries
  NFSD: Insulate nfsd4_encode_read() from page boundaries in the encode
    buffer
  NFSD: Insulate nfsd4_encode_read_plus() from page boundaries in the
    encode buffer
  NFSD: Insulate nfsd4_encode_read_plus_data() from page boundaries in
    the encode buffer
  NFSD: Insulate nfsd4_encode_fattr4() from page boundaries in the
    encode buffer
  SUNRPC: Document validity guarantees of the pointer returned by
    reserve_space

 fs/nfsd/nfs4xdr.c | 109 ++++++++++++++++++++++++++--------------------
 net/sunrpc/xdr.c  |   3 ++
 2 files changed, 65 insertions(+), 47 deletions(-)

-- 
2.47.0


