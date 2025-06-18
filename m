Return-Path: <linux-nfs+bounces-12567-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55504ADF8CB
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 23:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F1A4A0BA6
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 21:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA9521D011;
	Wed, 18 Jun 2025 21:34:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD5217654
	for <linux-nfs@vger.kernel.org>; Wed, 18 Jun 2025 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750282450; cv=none; b=WtPrNPqic7EzbzWjFFOtbDLY7QCPpoWNH8053gAdMCLD+eDVxXPfn2XZmgN9x3XA20JPoYCChqFAMON545ZeuPLJehhvQIkg0+tAZ299F29DHunhgRlhZPmv0iVRLBpYbl0xt1f4MEfsebz57tux97HWsQHoZYHqpz8I7ktPfpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750282450; c=relaxed/simple;
	bh=Aj95uwS2ADhQwDsZKD0KZ89jkW6ufk+qgC1peMnmo2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3Sn7ZCPGXtsMzzE2Zaik1yxRzRZXxnNFEF5Jmj35YX0gywfGD2Va1Aq+5LQSA7h7vMEEgea1XnE0jacfpULuvy4tHKknbdyi+JCLecrI/7HctB6UZIAL7w1MEi8FrICURLrt6VOe/wIAMFyKoJlbpYS3CNzfWiQEfKVWF1qPSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uS0Ps-000Yqo-Jq;
	Wed, 18 Jun 2025 21:33:56 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH 0/3 RFC] improve some nfsd_mutex locking
Date: Thu, 19 Jun 2025 07:31:50 +1000
Message-ID: <20250618213347.425503-1-neil@brown.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch hopefully fixes a bug with locking: some write_foo
functions aren't locked properly.

The other two improve the locking code, particulary so that we don't
need a global mutex to change per-netns data.

NeilBrown

 [PATCH 1/3] nfsd: provide proper locking for all write_ function
 [PATCH 2/3] nfsd: use kref and new mutex for global config management
 [PATCH 3/3] nfsd: split nfsd_mutex into one mutex per net-namespace.

