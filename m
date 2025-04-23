Return-Path: <linux-nfs+bounces-11250-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98C6A99759
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 20:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3851B65994
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 18:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A43F289365;
	Wed, 23 Apr 2025 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKAjtw9c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19C828B4E6
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431189; cv=none; b=seeP6UxxawPSuzIWhhcjCiFz8ivmTovcnck6UcWeafI1c7QRLH5wIK1S+oRxbhmvBSnHzA1GFWRRukypKEFjW5SgVLYz1WbrBA0kIc3tyczRWixQinrNfTXVo7qy33C5+yluFQ74wOHf1CMTh+6Tha2F14pJntx9z3sz+JdmZhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431189; c=relaxed/simple;
	bh=UwkN5TVkIxoIdNRwQQyxqALuZ/bB0goDKzixPIo1Syg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Be5xyCZb09cCf0jWtwNlpHuLq9mva4UtTh94cptgLfBbgB+njYckSpnPzTDeS0aSnsp5FWjyndDk9FIRpx8YCNTy6hMU8MyCtB6T4K3EdAzP33c1Zv4u6A5YgjEf1eZNvguLd7vufsi1RR53tLMZEQFMG5Fg+MRu/n1Bh8RbU3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FKAjtw9c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745431186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YvFZZDPpUKc8WuCA3A5RrAUBiKQlT3tbHosZ4MFLKP8=;
	b=FKAjtw9cZ+q8ACTFurkL9Xdh45Ct7pWcXRb6pP4PE4bMkeWu1i/r9QiA/FfWVEVF+dNEAS
	T+niuV2jSPxvUEZ1ERAH0P1DdNrLhdNxTBZb9FJyWn10N4rDTGnBD8FeugtWwWd6nBHG6P
	sX99p2CCG6S9ab5wSnfPfrS4YQshiN0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-zlVKNklHOhy2HnGd-73v6A-1; Wed,
 23 Apr 2025 13:59:44 -0400
X-MC-Unique: zlVKNklHOhy2HnGd-73v6A-1
X-Mimecast-MFC-AGG-ID: zlVKNklHOhy2HnGd-73v6A_1745431183
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DB041801A08;
	Wed, 23 Apr 2025 17:59:43 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.16])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D8501800378;
	Wed, 23 Apr 2025 17:59:42 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] Allow FREE_STATEID to free delegations
Date: Wed, 23 Apr 2025 13:59:39 -0400
Message-ID: <cover.1745430006.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

A problem observed for some clients is that the list of nfs_server->delegations can
grow unweildy, leading to the clients spinning in tight loops walking
across delegations that have been marked revoked.  These two patches attempt
to solve that problem by using the result of FREE_STATEID to clean up the
list of delegations, thus keeping that list pruned to an operable size.

There's a couple things not to like here: I don't like dropping the const
qualifier on the stateid for both the test and free operations.  The first
patch finishes the mostly complete work of ensuring we're passing a copy.
The core issue is that callers can't determine if FREE_STATEID was
successful since the operation is folded into test_and_free_stateid().
Another way would be to un-fold the call paths that are combined using
test_and_free friends, and that seems worse than just carrying result on the
stateid's type.

The second thing I don't like with this approach is that it doesn't fix the
potential problem that the client should try to make repeated attempts to free a
delegation stateid on the server that received an error from FREE_STATEID on the
first pass.  That's probably a pretty rare thing, but its also something
that can keep revoked state around forever potentially creating a
never-ending operation loop between client and server.

First pass, please criticise, thanks for any comments.

Ben

Benjamin Coddington (2):
  NFSv4: Ensure test_and_free_stateid callers use private memory
  NFSv4: Allow FREE_STATEID to clean up delegations

 fs/nfs/delegation.c  | 25 ++++++++++++++++++-------
 fs/nfs/nfs4_fs.h     |  3 +--
 fs/nfs/nfs4proc.c    | 23 ++++++++++++-----------
 include/linux/nfs4.h |  1 +
 4 files changed, 32 insertions(+), 20 deletions(-)

-- 
2.47.0


