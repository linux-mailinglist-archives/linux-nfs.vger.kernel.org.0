Return-Path: <linux-nfs+bounces-14220-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5EDB51BA2
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 17:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22F016B13A
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 15:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E190286439;
	Wed, 10 Sep 2025 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxUWdeyK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA4C279792
	for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518180; cv=none; b=RyLARIwM6YuzZvd4Xb0hVuJfgQ7gVU6hRVcXX1ZKA07XWdYeg4IuVqcluZ4EAbuY4XCi0DgXm9H8288bKW87LsYOekwdtHcVCufGr24V7dUTgHqrRV37sWeuq/GQ719XIkm44dMBF0JDMXISb7hM3w3fcChZDvGj7Ch2ILKsEvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518180; c=relaxed/simple;
	bh=RyO+IsAKVQRarVDWLRs8C1xFEAnxveKLfFoX0/X18r4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sk40VbF26vVlrnmJ8zNCk5qfdgApnIUCQ9WSDcXxIvUxauzI5k6ejIdsJTrCX7xDh3mdNd+n91xk8qahIWPwEhUrscEmLuIJtZ+7qwE5WlxkDtn+xrbNwcmDewLxfvRYdoYqpz3L/9WZt0rxcGeY6NqM8kOZ9qrRDosWQKhN6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxUWdeyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C506FC4CEEB;
	Wed, 10 Sep 2025 15:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757518179;
	bh=RyO+IsAKVQRarVDWLRs8C1xFEAnxveKLfFoX0/X18r4=;
	h=From:To:Cc:Subject:Date:From;
	b=NxUWdeyK4lxJydX8VfvjemE9Lx5+nE4J/N/4276rKkmKnOZpPWMaafvnIRrHhJ3yy
	 G3WP8AEBvyJ2N5Jrp0mOylhxMThEw/gVCOLUDowj4eoOmnsxyg5ig4CWAESuYige3w
	 v8vgoQqD69IGUneentQRfxUxI4CUz/PqoLgaYSi+QHSrkdXA/JGyRRmBBeCYp+24xg
	 s98+M0/VO2Ac2VDHtTHwqOY83oc/vA1LQ7YRpcSwxKW1B7icY3lAVAxn0/Ds3PzC9j
	 IU7jXtVop1+8LUs0gcM3ZFwaX4aURCO4A3+0spJdK4pNSJoaGln/gIAkRuQIG1zXsy
	 t5WAVGHpG2a2Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	rtm@csail.mit.edu
Subject: [PATCH v1] NFSD: Define actions for the new time_deleg FATTR4 attributes
Date: Wed, 10 Sep 2025 11:29:36 -0400
Message-ID: <20250910152936.12198-1-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

NFSv4 clients won't send legitimate GETATTR requests for these new
attributes because they are intended to be used only with CB_GETATTR.
But NFSD has to do something besides crashing if it ever sees such
a request. The correct thing to do is ignore them.

Reported-by: rtm@csail.mit.edu
Closes: https://lore.kernel.org/linux-nfs/7819419cf0cb50d8130dc6b747765d2b8febc88a.camel@kernel.org/T/#t
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 2 ++
 1 file changed, 2 insertions(+)

Compile-tested only.

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c0a3c6a7c8bb..97e9e9afa80a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3560,6 +3560,8 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 
 	[FATTR4_MODE_UMASK]		= nfsd4_encode_fattr4__noop,
 	[FATTR4_XATTR_SUPPORT]		= nfsd4_encode_fattr4_xattr_support,
+	[FATTR4_TIME_DELEG_ACCESS]	= nfsd4_encode_fattr4__noop,
+	[FATTR4_TIME_DELEG_MODIFY]	= nfsd4_encode_fattr4__noop,
 	[FATTR4_OPEN_ARGUMENTS]		= nfsd4_encode_fattr4_open_arguments,
 };
 
-- 
2.50.0


