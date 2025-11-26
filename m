Return-Path: <linux-nfs+bounces-16727-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A2532C88337
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Nov 2025 07:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBBB2355B24
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Nov 2025 06:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953883112BE;
	Wed, 26 Nov 2025 06:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BazShSeh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CB725782D
	for <linux-nfs@vger.kernel.org>; Wed, 26 Nov 2025 06:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764136889; cv=none; b=DM5NltuhRkNoDtsfeVXm/lXu9ak5fWNDL5jc6AnxpEodHBdpOyLhsNIrtQV6YOijN97cPd8oYCl/t2JMK/vFbEb1u7XwIdMnAyqsO4hsqIhBKUXn7kOhxbg6+DQ7eEgd69o3EgiHZVVEHAKlqI7hYocrNmkJPyMnK75El9hpby4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764136889; c=relaxed/simple;
	bh=0wDQ7h4a8c68uOJ33GBlo5hpErStY1V5oc2LvIIEFhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3l4lqImxN1+v/zh+RFeuuVqn8yNQ4yaMkiHUaG+8vn9NacoZNJ7a1STXNRaoEziaLzh/P0gaiJP31q2yh/tXV4k1q+jwxVJ4AgY9B37vF8Z3w9CFbhMFqeKjLNtmJ1kA4d7URCbYBEjGyAD+ur0ikqizTonclnCacQiE6KN+DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BazShSeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD191C113D0;
	Wed, 26 Nov 2025 06:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764136889;
	bh=0wDQ7h4a8c68uOJ33GBlo5hpErStY1V5oc2LvIIEFhQ=;
	h=From:To:Cc:Subject:Date:From;
	b=BazShSeha9FV3H5eWCg8L6HO5R3rcj+Js3RXYnnBA3unY+oNTwnfwNAu/lup0cxHv
	 IXc3KWheLxuRB7wy5N8Jrs32kNv4hwFBMctMIhuqKo4XLf1Zsylq6SdfzbNfS6Aqki
	 ZRrR7Auq2BhFnVjqN/lQxyYsPFJxOxPBBOy1fvCUke4TO53Ha5il5D0XLF1pa7Udou
	 ItQtcZx+rMInOscsxliR1LFk7ITUXQFEJAvbrPxOHPco5uK3iU/71UuwtzuPWRitvH
	 uZ+GcDG54BGJzYcPgrq1cMR2ePGOGeR8MJFeKSYh2RXqVcfBa2RmtFn38m/+rusMni
	 rO4L/lJEXzlig==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org,
	zlang@redhat.com
Subject: [for-v6.18 PATCH v2 0/3] nfs/localio: fix various new issues
Date: Wed, 26 Nov 2025 01:01:24 -0500
Message-ID: <20251126060127.67773-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Anna,

Here are 3 LOCALIO fixes for issues discovered as a side-effect of
Zorro's recent bug report:
https://lore.kernel.org/linux-nfs/20251125144508.rxepvtwrubbuhzxs@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/

(note that the "generic/751 hang on nfs" still isn't fixed but that
one is a long-standing issue that can be reproduced against stock
v6.12.53 -- whereas these 3 fixes address code introduced during
v6.18-rcX).

Sorry for the trouble, have a wonderful Thanksgiving!

Mike

v2 changes:
- patch 1/3 is the same as was posted here:
  https://lore.kernel.org/linux-nfs/aSaTC51DkxEqQkrZ@kernel.org/
- added patches 2/3 and 3/3

Mike Snitzer (3):
  nfs/localio: fix regression due to out-of-order __put_cred
  nfs/localio: remove alignment size checking in nfs_is_local_dio_possible
  nfs/localio: remove 61 byte hole from needless ____cacheline_aligned

 fs/nfs/localio.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

-- 
2.44.0


