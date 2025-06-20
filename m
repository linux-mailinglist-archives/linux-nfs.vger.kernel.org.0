Return-Path: <linux-nfs+bounces-12601-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE00AE2683
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 01:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F687A7B28
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 23:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FCB23E346;
	Fri, 20 Jun 2025 23:39:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C82376F5
	for <linux-nfs@vger.kernel.org>; Fri, 20 Jun 2025 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750462752; cv=none; b=sp7OUcRDepBCxajWmiNjjqb7I8pYgeGVtirk5zr4ASWX4Io9+vpHo8zhpcNpZKrFd9Mkb195f3n7rj3FN8J+w2jQNnruyDgwhQzE9vyGCIzGM5+2eA8IwIlLakD9f9huUeKAnXqhFv/00AJ8gb0c5MGvT/eF55aVjmtRD0OAt2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750462752; c=relaxed/simple;
	bh=dyGijIe7KMWVmo09J8aO/4HSChpYfSDOUU2UxtH6IoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uuUWGOd70Ul0wT2xXoyIZTK8vf3pjTttUF+P5IqDrluZ5/WOPNFDXYSSvwE41RkNNz4RnsHlAQuB8AKBljP3Xe9ImtZV3+9vzZGstqu9WnCG8ax5cpuuN0iMu+2vzK04Mfr3ZW8JJQIh+DY29NR8wUY2RmqwxFjHXE42gazpjeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uSlJy-0023qH-Gm;
	Fri, 20 Jun 2025 23:38:58 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH 0/3 RFC] improve some nfsd_mutex locking
Date: Sat, 21 Jun 2025 09:33:23 +1000
Message-ID: <20250620233802.1453016-1-neil@brown.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch hopefully fixes a bug with locking as reported by Li
Lingfeng: some write_foo functions aren't locked properly.

The other two improve the locking code, particulary so that we don't
need a global mutex to change per-netns data.

I've revised the locking to use guard(mutex) for (almost) all places
that the per-netfs mutex is used.  I think this is an improvement but
would like to know what others think.

I haven't changed _get/_put to _pin/_unpin as Chuck wondered about.  I'm
not against that (though get/put are widely understood) but nor am I
particularly for it yet.  Again, opinions are welcome.

NeilBrown

 [PATCH 1/3] nfsd: provide proper locking for all write_ function
 [PATCH 2/3] nfsd: use kref and new mutex for global config management
 [PATCH 3/3] nfsd: split nfsd_mutex into one mutex per net-namespace.

