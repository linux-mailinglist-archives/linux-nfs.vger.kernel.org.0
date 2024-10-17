Return-Path: <linux-nfs+bounces-7235-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1513B9A25FD
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 17:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE9B284D6F
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 15:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFCA1DE4C0;
	Thu, 17 Oct 2024 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSS2dDFh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E71DDC3E
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177439; cv=none; b=AGtcqVnuIGhirR8bK7FCUoqbaDoLBq0zcyftVjbcs4cTkmLI8OVGd3dALDVo6b+wBe1jJReWxiFHYxZ1RDcT4A3Imrdxs8CrKU2Ecj3eGVg1Ql3RLCINuSPCVYEOY8k1WGryE1lLJRc57zU3GZ7VSjrpFiUZRjHMWRGNXvrIYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177439; c=relaxed/simple;
	bh=YLsNw4DsI3rsKV6OW289XzAVkS0gruw/5XekjUAxtw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h9tqWyP14zL2BmIUgYgxwtNd7vCTS/W1sDhfEXcJgclu1TmwVSnzVeHMTpfboRSugsjtNkiFNx5cRYa/r1Eq/VliSuRIlhcbsoRtZwMIp/s4b/CopMiNUYuzSMiqnWxh01NUD9z6A/6tjWpfwFCt0/88HJMYmOSR7gVAykESZow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSS2dDFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7785C4CEC7;
	Thu, 17 Oct 2024 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729177439;
	bh=YLsNw4DsI3rsKV6OW289XzAVkS0gruw/5XekjUAxtw8=;
	h=From:To:Cc:Subject:Date:From;
	b=CSS2dDFhEUsr3xjEso1JsthMdbYlP7lRAHT+6qdkA6prwLlFrjiBwaSgLKL8euubj
	 Hao8fGqJ+elAYhoI/7yn8y+Yrch5K62JbjhDPvMfk5h/3kiC5sue21fOR2NX1yeZNZ
	 3nM7lPZgfO/jSY6oD6DCw4F9WvRQY/1YBJPWW0lKsuaKCB27VX8gb7oG2lv8eCEhTn
	 vW5WNLRKUWRK26RA7PuiMmYL2L5J/k6I43poolqJPHRyHHtDFoFRaSQLaXxrcXjdNU
	 WlhAZ/HvOU98CoFYkTSMxLVyNZMjGLqjhBoZ/NIs6uKm5gJ9meZu6M7I11rVDG66bz
	 Gigxsky+KLv/Q==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/6] Fix nits found by static analysis
Date: Thu, 17 Oct 2024 11:03:50 -0400
Message-ID: <20241017150349.216096-8-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=822; i=chuck.lever@oracle.com; h=from:subject; bh=0XYWLvL3rU2bUqDRC64oU1WKjAC8VnV1lu5CoFhHSz0=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnESdVQ4uz0tKMEFVLvSE3LoIw0m+IslOj3sdtg As26obNtvSJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZxEnVQAKCRAzarMzb2Z/ l9B0D/9DmaMmitPYgfb2zEWtIaXakujlcEMpbkD9iJVnxV9A2Wdb0oDacpnsOZL/uN1YQOC0MQt S7H1ATGK0yuBmuNw1JBs/GyOio/TJiRk8SQba0mXSIV7zQ0dSA3ub301zmMsTfkCIVDHJykuHrs +/8UssES/3BECy4FwdEU1fDo7cSzG0YggkXfZAX4Weo5H++8Da91oCw/nUp7KC/ivnlxzhmQkWx 3hJRa4TPoCHTCOp86jP8SqX1+8RfQEW0BMWCz3bp8dngSGGO+BXc1R0ibgIHVAiCHpDTBtlTR5l OzUJc8UdsokYMCAf4cDWPfpTiQX/ya74yCeLWuEcU2dpgJ78tiV46ZTQDfIJEXfnd3UzhYZTFFt KKurx9hNas4iJ3pMe4qxXbiMwCCCCFDd4dv1r8J/oUj/RmKP3ZEXpL8VRPMbBeJFffGksU8MNsi iGNgwsMbOLZhjpnZXSY6VWRopfejtG/ILraOY2cQUlAtYEg3UgeNcUexMPfp4UjTQ570NN85wJx QVU/z8ydN+68Cv48qEZe8dxHDmQ0Fn52kTFBQN4vDJKG8YXqTHsgZNE9KDt/7ZQDWAQae1cNITi PYFl7VMoUxMUOiELxaB2B+TeOaxy8HqVPeR2y/GeGf529vNcXxZdkbOT+Ugb1TL8gmMREPb/p2S imQ6vTE9sC3JIyA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Here are a handful of fixes for issues found by static analysis.
These are the ones I understood enough to address immediately. There
are others that will take some time to analyze and address.

Chuck Lever (6):
  NFSD: Remove dead code in nfsd4_create_session()
  NFSD: Remove a never-true comparison
  NFSD: Prevent NULL dereference in nfsd4_process_cb_update()
  NFSD: Remove unused results in nfsd4_encode_pathname4()
  NFSD: Remove unused values from nfsd4_encode_components_esc()
  NFSD: Cap the number of bytes copied by nfs4_reset_recoverydir()

 fs/nfsd/nfs4callback.c |  2 ++
 fs/nfsd/nfs4recover.c  |  3 ++-
 fs/nfsd/nfs4state.c    |  3 ---
 fs/nfsd/nfs4xdr.c      | 23 +++++++----------------
 fs/nfsd/nfsfh.c        |  2 +-
 5 files changed, 12 insertions(+), 21 deletions(-)

-- 
2.46.2


