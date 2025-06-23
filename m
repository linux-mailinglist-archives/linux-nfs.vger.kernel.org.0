Return-Path: <linux-nfs+bounces-12619-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 131ABAE33D3
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 05:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8FD3A50D1
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 03:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138A9225D7;
	Mon, 23 Jun 2025 03:00:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F1B10E5
	for <linux-nfs@vger.kernel.org>; Mon, 23 Jun 2025 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750647645; cv=none; b=psaBlQs6b8lpyCZxxh+woG/6T41r6VESp8CiH5mhV6I0oYi0RhbtNxN8dhxk7vZazHyMk1Vbdtwga2Lc+JavCPtSoW56Fey64jK+qZUiqvDs/LTmD1hcFah3kjhixN95/4dMxpuiVklzdI41lKmcUP3jf3Tjgv2fVgiT6rdNq/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750647645; c=relaxed/simple;
	bh=4ER8w3dtYeZIa/1RphQuV0BAZ5cuLjpAfoPNE+c89IY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jELmBTdRdA6pUHNZmtx31EjX/cBVSYmkH+iEfQ2HuVyGTfhhhRNInf/NHf5Ki40TGZnYFbru9Mr+Va8y1IC5fmT3u0rliBLDc8RHSmqDgd+KgrxFicKWW3X1EmOmYHzSy+eEf7cdV5artPLuGwZAMeaU1UYCkFBfIMwY32fYkoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uTXQC-0036aN-Pp;
	Mon, 23 Jun 2025 03:00:36 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH 0/4 RFC] improve some nfsd_mutex locking
Date: Mon, 23 Jun 2025 12:47:12 +1000
Message-ID: <20250623030015.2353515-1-neil@brown.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch fixes a bug with locking as reported by Li
Lingfeng: some write_foo functions aren't locked properly.

The other two improve the locking code, particulary so that we don't
need a global mutex to change per-netns data.

A final patch revises the locking to use guard(mutex) for all places
that the ->config_mutex is used.  I think this is an improvement but
would like to know what others think.

I've put the gobal cleanup code in the module exit function so that the
locking is already managed.

NeilBrown

 [PATCH 1/4] nfsd: provide proper locking for all write_ function
 [PATCH 2/4] nfsd: use mutex for global config management and clean up
 [PATCH 3/4] nfsd: split nfsd_mutex into one mutex per net-namespace.
 [PATCH 4/4] nfsd: use guard(mutex) for all ->config_mutex locking.

