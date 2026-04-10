Return-Path: <linux-nfs+bounces-20811-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EHnOZgj2WlrmggAu9opvQ
	(envelope-from <linux-nfs+bounces-20811-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 18:21:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D013DA543
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 18:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCC7F303DAC2
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 16:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB493203B6;
	Fri, 10 Apr 2026 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciqNx3UG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95173D6688
	for <linux-nfs@vger.kernel.org>; Fri, 10 Apr 2026 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837370; cv=none; b=VkwQnumOe6vk+iZsQlmQ4RHi/hcM1EjUSxLsi3zEzNosrQdqMl0YSIM1Jj2LFS3b/IFeNwBi/Mbsc+9AS9fAsV/3J+PmOgk1j9fCJrICAwPId2iZ8mVuSEYZuRCnEHwuvbbRPekZcvwK53x2XkHow/MwgB8RhruGVmtCg74q/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837370; c=relaxed/simple;
	bh=ThPbyEyF+rX+cQLxAsbdBqA4IoANCAebrEhPqc7aFSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKU/bbLTitKuq/Q7iu05a7x3synUyWneWK9bij0yhfJce9dmW81PgKA2S2BGJUsVuVLuprM0aNeAzYCdpLYbYi3ltmc92vmtAfb9511KITvohfPcHJBoXlnSk+p8rAZ08Wt8I8Fk39HGgMCUzWL/Zfjw+ivJLiuXTbfFinQZMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ciqNx3UG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775837367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yCySvQ8FgF+bExb+qVNpusFVxq3NW2NLSj9Zvi52pgQ=;
	b=ciqNx3UG0+iVJ1N1dblEi+Qv6bjtHknLcU3eRzPOlXGoViVCvkkopmEIU7n45I11cvLDB8
	krisXG8+wc2nxhyl6S2+ylSRSvBU+XSqxTRhA5jLaCd9CJOWKTjMq9EH+LoiPg9jzm9Dq8
	3EoWFCRwvXYnXwB1uA8sWkFsjNwHGXo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-bcnYMRjwOpq_snRF_kQMlg-1; Fri,
 10 Apr 2026 12:09:24 -0400
X-MC-Unique: bcnYMRjwOpq_snRF_kQMlg-1
X-Mimecast-MFC-AGG-ID: bcnYMRjwOpq_snRF_kQMlg_1775837363
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E820B195608E;
	Fri, 10 Apr 2026 16:09:22 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.94])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C0E24195608E;
	Fri, 10 Apr 2026 16:09:21 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v4 0/2] nfsd update mtime/ctime on CLONE/COPY with delegated attritutes
Date: Fri, 10 Apr 2026 12:09:18 -0400
Message-ID: <20260410160920.56855-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20811-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[okorniev@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43D013DA543
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

generic/407 is failing in presence of delegated attributes and this patch series
explores the solution where the CLONE compound returns updated mtime/ctime
in the GETATTR op in the compound.

Both CLONE and COPY need to update destination file mtime/ctime
(in presence of delegated timestamp) when file was modified.

v4 changes:
patch1: moved struct iattr into nfsd_update_cmtime_attr() which now moved into
nfs4state.c and takes flags as 2nd arg for adding ATTR_ATIME when needed.
patch2: removed comment about dput in nfsd4_do_async_copy() and now testing for
a set nfsd4_copy->attr_update which is set if file had NOCMTIME set on open
then timestamps are modified.

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

 fs/nfsd/nfs4proc.c  | 14 +++++++++++++-
 fs/nfsd/nfs4state.c | 44 +++++++++++++++++++++++++++++---------------
 fs/nfsd/state.h     |  1 +
 fs/nfsd/xdr4.h      |  1 +
 4 files changed, 44 insertions(+), 16 deletions(-)

-- 
2.52.0


