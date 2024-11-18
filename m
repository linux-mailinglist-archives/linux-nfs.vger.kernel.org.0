Return-Path: <linux-nfs+bounces-8087-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B6F9D1B2E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 23:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F284BB22932
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A61F1E8856;
	Mon, 18 Nov 2024 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmN6t28H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C11E8821
	for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731969651; cv=none; b=MkIZlLTao7nTXjvn2ktfq5Q/Ldbxnrv2yP2ZLzBEcz3f+56xemcMVRGjsiZl5pNvJcEdScFE++y5i+I5ad4q8UywouEMaROJEnFduB2qVyLVNGs6ly2FfYZkulEFI3guNzRFDTDr7LizrDpeu+N4Wx8JsOlrmpRwCVJ4GVFfc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731969651; c=relaxed/simple;
	bh=IwvWeYwJTMOuB9zMw8pWHnpFQi44jYl76g5qw5BujXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a7miqW8xdf6C8MvD4M/eyTLeO7UkUOViznEH/F/RCBfFFEFSOVpejPTS6RtfUq2+9SOTtglPvcf0SyB0rguGZGkf+NP7d84vuiC00UgCLrCnqC/UWd/EgZx13ixDBZ/uf6eZqwKVSDOqPKHefvWqgV3k3I7V8DLkz63AdHrYtrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmN6t28H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731969648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1O230Jlxlah/OjRxFvR7zagjddCyf3ntg587u1hFFis=;
	b=EmN6t28HtfnMC0unZ3bHthDg0421foxCFyHI5p15HIhD8n1lcDSUtq9hBI0tCqKvRjVV8X
	affA8PUhfW4ZDlnNglZTc6MS8WDIMDmrTYwGgu216nSkUOwUfShLkaKMsiTUdm1J4A6WAr
	5IiOdYdaSqdZy3v8iaBwUf0vvFPuMjg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-7gXCOA-SMRCEMaK5SVFpSg-1; Mon,
 18 Nov 2024 17:40:45 -0500
X-MC-Unique: 7gXCOA-SMRCEMaK5SVFpSg-1
X-Mimecast-MFC-AGG-ID: 7gXCOA-SMRCEMaK5SVFpSg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDD9A1978F59;
	Mon, 18 Nov 2024 22:40:43 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3FB71955F43;
	Mon, 18 Nov 2024 22:40:42 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] two fixes for pNFS SCSI device handling
Date: Mon, 18 Nov 2024 17:40:39 -0500
Message-ID: <cover.1731969260.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

A bit late for v6.13 perhaps, but here are two fresh corrections for pNFS
SCSI device handling, and some comments as requeted by Christoph.

Benjamin Coddington (2):
  nfs/blocklayout: Don't attempt unregister for invalid block device
  nfs/blocklayout: Limit repeat device registration on failure

 fs/nfs/blocklayout/blocklayout.c | 12 +++++++++++-
 fs/nfs/blocklayout/dev.c         |  7 +++++--
 2 files changed, 16 insertions(+), 3 deletions(-)


base-commit: adc218676eef25575469234709c2d87185ca223a
-- 
2.47.0


