Return-Path: <linux-nfs+bounces-10590-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D51A5F899
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 15:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA75882B01
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 14:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D30D267B95;
	Thu, 13 Mar 2025 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZl2aUoR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ABD268C57
	for <linux-nfs@vger.kernel.org>; Thu, 13 Mar 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876436; cv=none; b=tg885P16BcGxiRRkhVuOjypGR5mTTrCbYAX6NinatiUyEXA/qw7MVb9bWaL15tcTaQXohxaXIGaEH5rkdZhTfOlMxOi9QgJYqa87m6aDbudioCPY8tK+KLxuMHD2sbprE8Jq2NgBflM98YkdNJj5UQqKwIUA6TlOTQtCIMXfQ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876436; c=relaxed/simple;
	bh=jGt5I3lbo0ZqeHsCetJ0lPvpAgIWxLQep/LVRg/ITwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fbzFjZBqqgtLfUa570/OlLdWAluU/2Oj9NPQ1r9/g4OICuDTNHcehdR9Jr25uu7S6IH6RlJky+39CNHmYqIEBKyn9zkNxzYc4LOsZasi5XOye4NG3KbM+BBSsuX3X6tkEdhGU6DY42AJFPR7SMrYSHmzTBaffTZsH3VjSDDH1vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZl2aUoR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741876433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eZFOTt8bO5tB2DqaRiluFN8AolLHO+WiIJvnzz3t9D0=;
	b=HZl2aUoRAtSbwX747NRaAdOO+1CXOEOMw0SvKWBdmPJLCJd/ITBx29u21Eb65C7shfLAEG
	CNUy0zEb934xQq3zdbfqKJ0A9gWKD84q1Y7e/OLzc2fthXZP9dnnixNmCO4jgJ4NFLTZXy
	qjlVKhogNWnY8RZw9f0VhxsHAu1wZZg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-uggtlKjUMluZ365gfZ87FQ-1; Thu,
 13 Mar 2025 10:33:50 -0400
X-MC-Unique: uggtlKjUMluZ365gfZ87FQ-1
X-Mimecast-MFC-AGG-ID: uggtlKjUMluZ365gfZ87FQ_1741876429
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EB901956053;
	Thu, 13 Mar 2025 14:33:49 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.76.7])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E03F19560AB;
	Thu, 13 Mar 2025 14:33:48 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/1] Mount option rdirplus extension
Date: Thu, 13 Mar 2025 10:33:46 -0400
Message-ID: <cover.1741876108.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

v2 - Instead of adding "force_rdirplus", extend rdirplus=force

-------------

After these two changes:

1a34c8c9a49e NFS: Support larger readdir buffers
and
85aa8ddc3818 NFS: Trigger the "ls -l" readdir heuristic sooner

.. we've disadvantaged/regressed some users workloads where the user is
forced to use NFSv3 (such that we cannot prime the dcache with d_type on
READDIR as we do for NFSv4), and where the workload is a search through a
large directory tree.  Previously, the smaller buffers and/or the larger
heuristic size worked to their advantage to optimize the client toward the
READDIRPLUS path.

We've been able to relieve some pain temporarily by putting a knob into
sysfs to allow them to set the operation to one of:

	- force READDIRPLUS
	- disable READDIRPLUS
	- use the default heurstic

That's exactly the solution they're looking for and we have most of that in
mount options today with the "rdirplus" and "nordirplus".  Missing only is
the option to force the client to always use READDIR plus.  What follows is
a patch to do that by extending the existing rdirplus mount option to take
values.  I'll follow this up with a man page update to nfs-utils.

The global heuristic is always going to be wrong for some workloads and we
cannnot depend on something like a mount-wide option to always work well for
mixed workloads on the same mount.  A realistic long-term solution involves
allowing the applications to signal their intended behavior.

So, I am going to look at plumbing in a posix_fadvise() flag for
READDIRPLUS.  There's been some interest expressed already for other
filesystems[1].  I plan to send along patches for this and face the
discussions.  However, that work will take some time to filter up into the
utilities and into distros.  In the meantime, I hope we can add this simpler
mount option to help the folks that need the old behaviors in recent
kernels.

[1]: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhBWV3DfqaE=reuPjh8w92wwujA6Abj=Gt0YvapR4m_1g@mail.gmail.com/

Benjamin Coddington (1):
  NFS: Extend rdirplus mount option with "force|none"

 fs/nfs/dir.c              |  2 ++
 fs/nfs/fs_context.c       | 32 ++++++++++++++++++++++++++++----
 fs/nfs/super.c            |  1 +
 include/linux/nfs_fs_sb.h |  1 +
 4 files changed, 32 insertions(+), 4 deletions(-)


base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
-- 
2.47.0


