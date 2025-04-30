Return-Path: <linux-nfs+bounces-11362-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A35AA419C
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 06:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6DA3AB816
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 04:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05C01922C0;
	Wed, 30 Apr 2025 04:05:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66BC126F0A
	for <linux-nfs@vger.kernel.org>; Wed, 30 Apr 2025 04:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745985903; cv=none; b=QtNIRyvIz1cpv3s6H5tXzOQGq1bgLPu4WgiQ4YmnUgqip9GnHdBgJQFQnXGL8fOvMYEh+OXkZj+Plvm+Vi1UEOeSfsdJIqmD02nGBA5wMSnmL7BvzbaT75GYqpbE8bD9rqetUusjvH92rNsu0LNv7oObVi0ZbvVqEBlCb/l6VPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745985903; c=relaxed/simple;
	bh=WycH3A9pK0R3OirqwVTpC7cMO7EVgvOk/ONtWmvUp+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gEwNxVX+cZDT5iY6CAGLIGkFLd50xfUE4Ebv5hRiGb1jy1V0G1uuZy261NsI7KHQpjDf8IaMQnNk5dQFTvHoyj7FZ1IBrcBa/fg+gRijQ7Vt6FYfRYADImid/FMAaUdW3qPdXhd3VdYLgjI5WGm0gXQNh8oFBaMXr8qcUSvMyjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1u9ygm-005EYA-Fd;
	Wed, 30 Apr 2025 04:04:52 +0000
From: NeilBrown <neil@brown.name>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/6] nfs_localio: fixes for races and errors from older compilers
Date: Wed, 30 Apr 2025 14:01:10 +1000
Message-ID: <20250430040429.2743921-1-neil@brown.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Following the reports of older compilers complaining about the rcu
annotations in nfs-localio I reviewed the relevant code and found some
races and opportunities for simplification.

These patches address the various issues.  They compile with old and new
versions of gcc and don't introduce new sprase warnings.  I haven't
tested that localio, or even NFS, still work.

NeilBrown

 [PATCH 1/6] nfs_localio: use cmpxchg() to install new
 [PATCH 2/6] nfs_localio: always hold nfsd net ref with nfsd_file ref
 [PATCH 3/6] nfs_localio: simplify interface to nfsd for getting
 [PATCH 4/6] nfs_localio: change nfsd_file_put_local() to take a
 [PATCH 5/6] nfs_localio: duplicate nfs_close_local_fh()
 [PATCH 6/6] nfs_localio: protect race between nfs_uuid_put() and

