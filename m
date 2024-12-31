Return-Path: <linux-nfs+bounces-8847-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 398459FEBDD
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 01:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9A0161B7E
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 00:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12577485;
	Tue, 31 Dec 2024 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeBd4V7V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CE7747F
	for <linux-nfs@vger.kernel.org>; Tue, 31 Dec 2024 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735604945; cv=none; b=k//L2Gax/j288kxTlkz6wP6O8RD4HHVroiXSi3w/BZGiQmWCWzxPt5sFakk1NFdL+En6X1YEhCYddOiiBxNkPS/W3Ru0Con96PmACXcde8yFGsQrL4Jpuna90lQII1XntapTK2onZFkRn2FXHoANcBWckipOaFZl3yiuqEqMGMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735604945; c=relaxed/simple;
	bh=7Powe4JvzTtbpcC1hLIMKoXs4R3+fPUQemc02H7HlQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKPGlNya5nJFt1/6MGQzobZeblZUGStz1ar7LVNwhSIDIXoj3FWSmKl1g/iCKDgqn74W15dHarth/DGgDJ4BuXY9ZborF5VOrd9BLys414jO+7KQhUwKUqooCtba/qlq3IMzaVjubSemqeFasfEfwDpCodcNx4hYZE21VXs3Cng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeBd4V7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716DFC4CED0;
	Tue, 31 Dec 2024 00:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735604945;
	bh=7Powe4JvzTtbpcC1hLIMKoXs4R3+fPUQemc02H7HlQ0=;
	h=From:To:Cc:Subject:Date:From;
	b=EeBd4V7VMsDpxcnS9Igux/3QTcC5h73sp5MDnzhw2KPd1m+Y0W2zlRb19CVcm9FKn
	 EgefStiJUKoHuROlOMF8RyVhUGsXN9kpF+6S8W8UuxapjLfcdr4thw6oyixPtcjJi9
	 0Q7XDCd3ktxMpkdacdNKsqmuSXrTkGNGKNOU/JcJZtBYdjgMhmegnDLchWTq/gduMs
	 6P2Rm8ggzORSj+DK88QCCP2u5RTEDwzVBZQPCQQbOSfpBeVhZYUARoD8GZ/ZVGPs6e
	 nQy/nakfQhSQc9rtTDt79JYeztQFKTiTiYkHYEB2mMiKcPlad954KzJN0piZRhD2pw
	 uVNy7qR4PnK9g==
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
Subject: [PATCH v4 0/9] Fix XDR encoding near page boundaries
Date: Mon, 30 Dec 2024 19:28:51 -0500
Message-ID: <20241231002901.12725-1-cel@kernel.org>
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

Changes since v2:
- Address same issue in NFSv4 READLINK and SECINFO operations
- Update kdoc comment for xdr_reserve_space()

Chuck Lever (9):
  NFSD: Encode COMPOUND operation status on page boundaries
  NFSD: Insulate nfsd4_encode_read() from page boundaries in the encode
    buffer
  NFSD: Insulate nfsd4_encode_read_plus() from page boundaries in the
    encode buffer
  NFSD: Insulate nfsd4_encode_read_plus_data() from page boundaries in
    the encode buffer
  NFSD: Insulate nfsd4_encode_fattr4() from page boundaries in the
    encode buffer
  NFSD: Insulate nfsd4_encode_readlink() from page boundaries in the
    encode buffer
  NFSD: Refactor nfsd4_do_encode_secinfo() again
  NFSD: Insulate nfsd4_encode_secinfo() from page boundaries in the
    encode buffer
  SUNRPC: Document validity guarantees of the pointer returned by
    reserve_space

 fs/nfsd/nfs4xdr.c | 214 +++++++++++++++++++++++++---------------------
 net/sunrpc/xdr.c  |   6 ++
 2 files changed, 122 insertions(+), 98 deletions(-)

-- 
2.47.0


