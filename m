Return-Path: <linux-nfs+bounces-6594-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB8D97E732
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 10:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90221280F64
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 08:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E1E328B6;
	Mon, 23 Sep 2024 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ag23fwXv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A002C9D;
	Mon, 23 Sep 2024 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078864; cv=none; b=qwEPtwgaZAxT4m2VPYJSZ2676KrV3NqaXaJL8vCAgYfYDDBEgLCmSc9NJo3NSdnnZVMgdiJT3lE2FxIADyKLUDWxAmcLa9eKU29Ad/7N5Kb51e8dgO1+FzfI7TRq0Wg4c665Bl7CPyaJNDoVY3+5Ly6HXug7GGQ3l/+g2YkXpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078864; c=relaxed/simple;
	bh=XN506Irq1YGFWH9rhZPynkDP1nbO1RwV+6v4MGauZQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RAiVBblTzVDw3cA/CXunWy60igHXYX1TlWvrpURsFVjOCp/1TDdhvpA6iWHUIW3GWa0SXkdeBcu1kpGdSdTJxTTaMhc24hLNcsF209pB4y/75TF7TGICY8KQwTVKAW5Pj1IeZZdpYb0N9z+4RQ1GbD8mvoSgl7de8N1vwpDMCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ag23fwXv; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727078859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vtdcH2O9rkRNxjdgWC5uJjmAqWJGi1QC5VKqyCJu5So=;
	b=ag23fwXvMaJ2cYNMVDbzvoMDybGHP+9xQxvqoehpY+9GGBwrdeCeUpFzJNHdpAygfrWUw6
	aQYrG+ZR5qjb0hWzBcgU5Exag7MiZCEyveZ1L0UDX9eTSjmK1QES2Y2jVRNcXQVFl5Gi+D
	bdSwa+kYklv1RaiT3iwz4jZmIFxscHE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] NFSD: Remove unnecessary posix_acl_entry pointer initialization
Date: Mon, 23 Sep 2024 10:05:46 +0200
Message-ID: <20240923080546.230198-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The posix_acl_entry pointer pe is already initialized by the
FOREACH_ACL_ENTRY() macro. Remove the unnecessary initialization.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/nfsd/nfs4acl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index 96e786b5e544..936ea1ad9586 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -198,8 +198,6 @@ summarize_posix_acl(struct posix_acl *acl, struct posix_acl_summary *pas)
 	memset(pas, 0, sizeof(*pas));
 	pas->mask = 07;
 
-	pe = acl->a_entries + acl->a_count;
-
 	FOREACH_ACL_ENTRY(pa, acl, pe) {
 		switch (pa->e_tag) {
 			case ACL_USER_OBJ:
-- 
2.46.1


