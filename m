Return-Path: <linux-nfs+bounces-11157-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6C0A91E02
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 15:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF61C3A5EA9
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E146E35972;
	Thu, 17 Apr 2025 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7zN7ICO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A818F6C
	for <linux-nfs@vger.kernel.org>; Thu, 17 Apr 2025 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896527; cv=none; b=AmJPCpQbdP+lMIqszl601lbdDFgWEBTS5ePJpJmuPrl3iGRullmUKkHrhvk6iQDOK8VMb4t1BofeXqocVeDd2Ar+uk36TUeAWGpcIxn2k06WRRWISG5phXrUktX+jpP8G4xN0MqgKM/LQplk+6EEsQkMV6Zfd9hIXQA2GDBAHyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896527; c=relaxed/simple;
	bh=3HI70zhIVfOZUxLXulF4y8uriTGXfzc07AH0uLdxh5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VBtM+6/YGx/hhAcgcbZ2JPIBF/y9f3pW+qidrZNLlQRPiZh0ZsqnyIDrmRKoAsEx5XSm6s/5pubou2LIffxoE9fBHzJGA3jfcCasExKBVtM6P89/mxW4L9kfq9AQPBAKOT0oOH1Bc5mPFudP6N1bbApeaxPWFcE7EGZ8tAXUWGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7zN7ICO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744896524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=WFCCnYsZ3gCeeeM68u/f29xAKTsg+MKGS5uoqdjrDt0=;
	b=e7zN7ICOWf+hVuvv+IPeZgfEaEtrjjOAF75Zpnl50crdivE49g3BV3cuiQni8VOK8INuen
	bvlB0xSWECsysRc/hdVVRTRI1gu6POaDKjnRmumVbgahb3/z0VcqMpsP9sWZtt8lYlCxcu
	tP42fF0TcIvOFdfm9M50whA1is8ogEg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-ImeClmmWPA6ExuybtmcjXA-1; Thu,
 17 Apr 2025 09:28:40 -0400
X-MC-Unique: ImeClmmWPA6ExuybtmcjXA-1
X-Mimecast-MFC-AGG-ID: ImeClmmWPA6ExuybtmcjXA_1744896519
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DBF618004A7;
	Thu, 17 Apr 2025 13:28:39 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.16])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D98E18001EA;
	Thu, 17 Apr 2025 13:28:38 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Wanted: more fixups for client delegations test/free walk
Date: Thu, 17 Apr 2025 09:28:36 -0400
Message-ID: <9146009C-5726-400D-8571-504F5B36C651@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hey Trond, Anna, et al.

I'm looking at working on nfs_server_reap_expired_delegations() because the
work to walk that list is order n(n+1)/2  and the list can grow very large
due to some servers doing SEQ4_STATUS_ADMIN_STATE_REVOKED these days.  It
can currently grow unlimited by 5k delegation watermark.

First observation is that we don't remove revoked states from the list even
after doing FREE_STATEID, so we're still doing walks across delegation
state we'll never use again.  I think we can fix this by plumbing in the
error result from FREE_STATEID.. so that's a potential bit of work.

I'm tempted to just do:

@@ -1342,7 +1346,7 @@ nfs_delegation_test_free_expired(struct inode *inode,
                return;
        status = ops->test_and_free_expired(server, stateid, cred);
        if (status == -NFS4ERR_EXPIRED || status == -NFS4ERR_BAD_STATEID)
-               nfs_remove_bad_delegation(inode, stateid);
+               nfs_delegation_mark_returned(inode, stateid);
 }

.. but I think that gets us up to not tracking state the server might still
be tracking.

Other approaches might be to walk the list once moving the work to a
temporary list and then operate on that linearly.

Advice, thoughts, or direction welcomed..  I'll probably work on splitting
out nfs41_free_stateid() from test_and_free_expired(), so the delegation
code can know for sure that we're done with that state.

Ben


