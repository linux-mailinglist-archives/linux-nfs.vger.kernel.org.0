Return-Path: <linux-nfs+bounces-4783-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E628E92DA25
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 22:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230641C21955
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 20:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B68198A29;
	Wed, 10 Jul 2024 20:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXZEc1PS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A1198A25
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643531; cv=none; b=rF53nbJ7ew4P+9m6lw1KnRr4Pq+W6ch735niPUAh4/o6lVRaHky2LYQO410+GqNqXiA6vTqM3gdwo3f195VB4M0DJVcbMwWxz7ey5n+asJhEnyH35/OGZGhMWGcRwhCIn3FvZ/RTD1/i6df48CrEuA1Xht4ghCjkdpChSAWFEYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643531; c=relaxed/simple;
	bh=R5WpJmZa3ypbOg9tztZyPKNQ1l3zAyngftS0fZcEMTc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Oe6zq16KA/AZJXLPOSM2Etri/9Q/5gaA1274AamXqWdon8d6U3nvWehYG+j+rgNzF5uU8X5jLCoagXkTGxAYzPtr3E+9iShZywghLBbT1R69Q5ZPgHj9UMaW+xqpghewuoksC3w4xfFeqh56ROOA7/kp76Df3LGsMyaChZlphYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXZEc1PS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720643528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aAVrVXWsi/qNv2lLoGNpo5WQR+YaoRdF5NxiZg2FqkM=;
	b=LXZEc1PSze1WUYu85/wFbGtuAEmXHMQcrmcRzH7XeC/Bo7ErKNlWTra7BbXtqVHiGO8sL2
	PV3L2/VyLwaBk6oHP1qmDxZZSYwpMm5EmO9j9xkqOYNA0kngl0gAg1arYdGZQMQCSsYg/m
	VU+roavI8YbP71VlDCzYQSmf0rfUz9c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-V-Nuepr6OViLT48dVkTNZg-1; Wed,
 10 Jul 2024 16:32:06 -0400
X-MC-Unique: V-Nuepr6OViLT48dVkTNZg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1088419560AA
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 20:32:06 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6361F3000182
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 20:32:05 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: linux-nfs@vger.kernel.org
Subject: [RFC PATCH 0/1] A rare failure to wake up sync tasks
Date: Wed, 10 Jul 2024 16:32:03 -0400
Message-ID: <cover.1720643005.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hey all - RFC patch here because this race is very hard to reproduce so I
will be testing this for a few days before feeling certain that this fix
does the job.

Meantime, I'd love some feedback from any one that has mastered load/store
races.  Do I really need a full smp_mb() here?  I think I do because the
race is not to the tk_runstate's ACTIVE bit which is set under the queue
lock, but rather to the wait_queue_head..  I'd love to be corrected.

Comments much appreciated.. this problem has been very elusive to catch.

Benjamin Coddington (1):
  SUNRPC: Fix a race to wake a sync task

 net/sunrpc/sched.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.44.0


