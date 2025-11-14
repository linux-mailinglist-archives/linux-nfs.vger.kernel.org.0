Return-Path: <linux-nfs+bounces-16410-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FA7C5F3DD
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 21:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42004348692
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 20:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F2233F8C1;
	Fri, 14 Nov 2025 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVwAoRei"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA400342536
	for <linux-nfs@vger.kernel.org>; Fri, 14 Nov 2025 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763152178; cv=none; b=OQ6PkPqTGe+pYFlFadr91ZcHRrlo09bMl/EdldBq8lUvEmOaRw21yfcrLyYAkZmLVp3hD5pjA8AuoQROrI2OxKUwAbLMzm7xehC0R6RYlaWj/5xb3AvMzuZz4dK9Ts0TEfovV/U5FTrSf8VpJvZ+bEbX4sGSubexfGoTw7IRQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763152178; c=relaxed/simple;
	bh=lcVdmU5vz7a+l0gC4ZEeBa+XBngETbEwW0f7bZfrPtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vw3wPyI4/yA54KQySndzBTC0aIkpAtJ22R20rHMvy8g52MPQ1tcxYbf9lZoqkuadFsHBgCodAi9TlkzNlVWfLCZ8Lety7JYjcDK41DtqQH6o3XTQtHUj7YO5WFdREOgLVpCjHNiBWvox/GgXUq4cUSKcaBGEnlUDZ3gCs7hE4VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVwAoRei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060BCC113D0;
	Fri, 14 Nov 2025 20:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763152177;
	bh=lcVdmU5vz7a+l0gC4ZEeBa+XBngETbEwW0f7bZfrPtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rVwAoReikhuLhqaYZntozsrXFS8Ve+YJJFKZJBqxBZXBaPbAh3Gh7xufld7SkMwF0
	 9zLd0evNA6lfvxsnpnImj3LKn7kaKePjz/+wzpHlbjt9gIjgwahEUGCdvyQO96dq8o
	 +wCOl74dCplbcubagcudUasWJfJWBDB5k85FluHlMnCdDLbebzKyp/WmKxsd5VM3Ts
	 D8N0qRARVhSd6TT96t7Bx29XCia2tCWzXQ5KLaVtWJ8DNpW6ZOKZMzomqPhXbghqTu
	 traiK6zy3bCag9LpuyJz/99+KbZOeECPrnbQkfhnXy3xpwv0J7POWDTc3YB3ny4vg0
	 LLKeg8SPb5vfg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 2/3] NFSD: Clear TIME_DELEG in the suppattr_exclcreat bitmap
Date: Fri, 14 Nov 2025 15:29:32 -0500
Message-ID: <20251114202933.6133-3-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114202933.6133-1-cel@kernel.org>
References: <20251114202933.6133-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

From RFC 8881:

5.8.1.14. Attribute 75: suppattr_exclcreat

> The bit vector that would set all REQUIRED and RECOMMENDED
> attributes that are supported by the EXCLUSIVE4_1 method of file
> creation via the OPEN operation. The scope of this attribute
> applies to all objects with a matching fsid.

There's nothing in RFC 8881 that states that suppattr_exclcreat is
or is not allowed to contain bits for attributes that are clear in
the reported supported_attrs bitmask. But it doesn't make sense for
an NFS server to indicate that it /doesn't/ implement an attribute,
but then also indicate that clients /are/ allowed to set that
attribute using OPEN(create) with EXCLUSIVE4_1.

The FATTR4_WORD2_TIME_DELEG attributes are also not to be allowed
for OPEN(create) with EXCLUSIVE4_1. It doesn't make sense to set
a delegated timestamp on a new file.

Fixes: 7e13f4f8d27d ("nfsd: handle delegated timestamps in SETATTR")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 51ef97c25456..8f12dee4c3b5 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3379,6 +3379,8 @@ static __be32 nfsd4_encode_fattr4_suppattr_exclcreat(struct xdr_stream *xdr,
 		supp[0] &= ~FATTR4_WORD0_ACL;
 	if (!args->contextsupport)
 		supp[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
+	supp[2] &= ~FATTR4_WORD2_TIME_DELEG_ACCESS;
+	supp[2] &= ~FATTR4_WORD2_TIME_DELEG_MODIFY;
 
 	supp[0] &= NFSD_SUPPATTR_EXCLCREAT_WORD0;
 	supp[1] &= NFSD_SUPPATTR_EXCLCREAT_WORD1;
-- 
2.51.0


