Return-Path: <linux-nfs+bounces-20794-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMRaBzTX12mDTggAu9opvQ
	(envelope-from <linux-nfs+bounces-20794-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 18:43:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB2A3CDBFD
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 18:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75BBE3004427
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2026 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCE233E37D;
	Thu,  9 Apr 2026 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbdQ3+a4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9C63DA5B9
	for <linux-nfs@vger.kernel.org>; Thu,  9 Apr 2026 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753005; cv=none; b=WlMpkWW4fkE92m7x6d5m8xhvVCJV1o7x9Gw7yxYtPFOmobenCskR0K3dgVnhh/eSfEcEZUs25tj+4fdoYaaUHnWYIxg5NyPoloIn9VuVh7UeZklWlgX/oaP7Q2G/En0ilgeKgO0x5LhDTp84u2ChLziGbTvfAIHRepDQkSfAfWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753005; c=relaxed/simple;
	bh=ZGR2pLE6wCryztrCLMCD81bauIGXdzvDJor1fE6Sbb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=otaFqzM3hMqc8A9G4zEPvcL/iUx/ZwvOaPyRg00TqWuTkQBPL60fDGyHZoyTOVhwM0zK2cbmX7jCYdzMOBxmoRsBzWSoAMVLDiGsBTxpL4sD4LG0vhOTckwCUTDV4cUL8nW3w46eLPt1OjqtNNANytHQyqe9VzWzvOZ7kTwnhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbdQ3+a4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775753003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Cr0e9y1QZcTKQR+0DY/Wf50iNBY5u6e9CYPK69MIGM=;
	b=MbdQ3+a4uolB1398okUTVl00yipVaTYaPfMs/mAAR8zD1+oW3UQ2/zEX2p39a+/Nwt/vl4
	/mZLARktEJhf0yjOHYhoqA4taYG2/fg4AuRdPpha7fb8fkwG8LRT/49dgTCd8M0ndIUwpY
	edrNfd97Ym8lmpFO8grvCUYAPBw/6fE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-n_-27ZZmNteN2qx1ez238A-1; Thu,
 09 Apr 2026 12:43:19 -0400
X-MC-Unique: n_-27ZZmNteN2qx1ez238A-1
X-Mimecast-MFC-AGG-ID: n_-27ZZmNteN2qx1ez238A_1775752998
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8330D1800592;
	Thu,  9 Apr 2026 16:43:18 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.236])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A2251800240;
	Thu,  9 Apr 2026 16:43:17 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v3 0/2] nfsd update mtime/ctime on CLONE/COPY with delegated attritutes
Date: Thu,  9 Apr 2026 12:43:14 -0400
Message-ID: <20260409164316.19748-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20794-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[okorniev@redhat.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2BB2A3CDBFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

generic/407 is failing in presence of delegated attributes and this patch series
explores the solution where the CLONE compound returns updated mtime/ctime
in the GETATTR op in the compound.

Both CLONE and COPY need to update destination file mtime/ctime
(in presence of delegated timestamp) when file was modified.

v3 changes:
--- Consolidated synchronous and asynchronous COPY patches into single
patch.
patch1: pulled out notify_change() code from nfsd4_finalize_deleg_timestamps as
it's shared with nfsd_update_cmtime_attr and both paths log an error if
notify_change() fails
patch2: dentry can be pulled from copy->nf_dst->nf_file.fh_path.dentry and
no longer requires additional tracking.

Olga Kornievskaia (2):
  nfsd: update mtime/ctime on CLONE in presense of delegated attributes
  nfsd: update mtime/ctime on COPY in presence of delegated attributes

 fs/nfsd/nfs4proc.c  | 30 +++++++++++++++++++++++++++++-
 fs/nfsd/nfs4state.c | 14 +-------------
 fs/nfsd/state.h     | 16 ++++++++++++++++
 3 files changed, 46 insertions(+), 14 deletions(-)

-- 
2.52.0


