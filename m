Return-Path: <linux-nfs+bounces-11381-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33846AA5E65
	for <lists+linux-nfs@lfdr.de>; Thu,  1 May 2025 14:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAAB11BC4268
	for <lists+linux-nfs@lfdr.de>; Thu,  1 May 2025 12:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE10022577E;
	Thu,  1 May 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="be/Ya5Uw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A716622425C
	for <linux-nfs@vger.kernel.org>; Thu,  1 May 2025 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746102590; cv=none; b=QG2QdIF9J1VkjsozCJrBZV9iJUWuJSkqjBCMhDrjj1E+/1851TDG4Kdvw2bK0NipQ7AFNUOGm3HokuAe3WkGncRe40OqY00nqEqT4ErQLfjavRr0+mGYO8HHCzvooLeusYlvqm08+6iJ0qGqwtjEvtMp3UI5mfQR4vA/de6obxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746102590; c=relaxed/simple;
	bh=H6cm7PGrZIPcOl6QfXyJZcgOLJKzaPiQdLKxfyUecFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=arwFcW3aSW5MopQPL5j093K3aywrYlva1o4HwmIFv2PJ9K461jI8TYNIFBMdfik1vHQGfvzAOVtPmyAyqmcwoe0iLvxb7cSpsfVx/avDXtIcpXDi3L27mVb7laNvbsaQ1VIA5oeNxBM3Vi/fecSGfGNcMU67CZ0dn/he6f+OGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=be/Ya5Uw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746102587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ESgaYRAh0BbODCvd9fU8eYlcwPiRBDpDIa92Ypat3sE=;
	b=be/Ya5UwtWQ0vac5hjMLXCXQ0HZMOv/hctSA9fGhIMs/VdPyW7yeIpFygQtSi3oa9WfPud
	0hVFwOqhetKSCKvkt7nJ7F9E7kmqQ4/29ZZ0xvLgoeeB27IrkGnZgI3UG5TmkP+hAQd3gO
	RqPGxauihQmEllwbN72z881y4/1TgAk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-bgXfTcx1OTyF7trcYg_49A-1; Thu,
 01 May 2025 08:29:46 -0400
X-MC-Unique: bgXfTcx1OTyF7trcYg_49A-1
X-Mimecast-MFC-AGG-ID: bgXfTcx1OTyF7trcYg_49A_1746102585
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C8C4180036F;
	Thu,  1 May 2025 12:29:45 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.76.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B8DA195608D;
	Thu,  1 May 2025 12:29:43 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/1] Allow FREE_STATEID to free delegations
Date: Thu,  1 May 2025 08:29:41 -0400
Message-ID: <cover.1746102154.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

A problem observed for some clients is that the list of
nfs_server->delegations can grow unweildy, leading to the clients spinning
in tight loops walking across delegations that have been marked revoked.
These two patches attempt to solve that problem by using the result of
FREE_STATEID to clean up the list of delegations which keeps that list
pruned to an operable size.

Changes on v2:
	- dropped the first patch which was unnecessary
	- add the FREED_STATEID case to nfs41_test_and_free_expired()

Benjamin Coddington (1):
  NFSv4: Allow FREE_STATEID to clean up delegations

 fs/nfs/delegation.c  | 25 ++++++++++++++++++-------
 fs/nfs/nfs4_fs.h     |  3 +--
 fs/nfs/nfs4proc.c    | 12 ++++++------
 include/linux/nfs4.h |  1 +
 4 files changed, 26 insertions(+), 15 deletions(-)

-- 
2.47.0


