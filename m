Return-Path: <linux-nfs+bounces-12593-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C70FAE1AF9
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 14:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9AC27A4421
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D710D284B3E;
	Fri, 20 Jun 2025 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd/BCmUP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A7C25F98E
	for <linux-nfs@vger.kernel.org>; Fri, 20 Jun 2025 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750422721; cv=none; b=VS/+d6PR+8UA+r1rGwnIArrm7/to/jtpTm/yaoEFgCN5qRM3vz+iF7fa4XAZygsexR1wvAKslFATKBgxtgKAB6ml2xgccNom/LHNBPwq7vxZkh3qLfAYP9pJFPghSwq+2ntlNwPhm1j/NI7Y3ZVgUVSCBFhj4hiEPVl+UmavwIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750422721; c=relaxed/simple;
	bh=MM4pVsbHxM19XeQ4zCkyLRSZmVBPbWIP+ETqJ6aDnF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uE+bRqAG0+R8gHIB7iPncHwLGONuy4oyaumaMG3763rSwsjJI9SCw8b0Z36RZBvHO5YNTwZhJyoea1CxYo8B0QhyVIjOgaRqiaSayb10ILbUEEyzAkHkaMznWLwGq+U8kanMcr31y7Xt3eVcu0cFtTtObTLdGrrWPI0CZE5+TV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd/BCmUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BBCC4CEE3;
	Fri, 20 Jun 2025 12:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750422720;
	bh=MM4pVsbHxM19XeQ4zCkyLRSZmVBPbWIP+ETqJ6aDnF8=;
	h=From:To:Cc:Subject:Date:From;
	b=hd/BCmUPnGQlC9T/RHCAEwyb/EYQqCnMmGKg9Nzzt7mRjMcJAE+nCVORRpTVlZCj3
	 kWcxqnk96orBkLoV6c/Cy5uN+7oOlAinFPX3AeAHpYwLYj1eTQydOg7kqSwj6A2cFx
	 yU4ae8/5y7g3qRTXCM5K91qXAEmfRLlE3PZh/vxD36ZO/TxZm+XtHmS34JCGc3CoV+
	 tzrmgNpWKQHuvNvVQHabPcNeJokvqQbnHu+LEUut2PP3evBnVZduRplZ61yQ5l99Hj
	 efsYpd71N1yODtcdGsGfgLVuV/JdoklZ7TRFOhbLmec4nWcriC45/Vn9BoubaYmZhg
	 QdqbVbxosQ/7A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/2] Remove union from struct knfsd_fh
Date: Fri, 20 Jun 2025 08:31:53 -0400
Message-ID: <20250620123155.271392-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

This is a low-risk way to simplify the knfsd_fh struct, based on
Christoph's suggestion of using array indices rather than u8
fields.

Compile-tested only.

Chuck Lever (2):
  NFSD: Access a knfsd_fh's fsid by pointer
  NFSD: Simplify struct knfsd_fh

 fs/nfsd/nfs4layouts.c |  4 ++--
 fs/nfsd/nfsfh.c       | 16 +++++++++-------
 fs/nfsd/nfsfh.h       | 26 +++++++++++++++-----------
 3 files changed, 26 insertions(+), 20 deletions(-)

-- 
2.49.0


