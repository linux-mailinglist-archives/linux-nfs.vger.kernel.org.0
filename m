Return-Path: <linux-nfs+bounces-12595-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AF6AE1AFC
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 14:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AB93A9764
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 12:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6446257AF2;
	Fri, 20 Jun 2025 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbt/CC6F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F91221FC0
	for <linux-nfs@vger.kernel.org>; Fri, 20 Jun 2025 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750422722; cv=none; b=qODVyXKiJZ0m9NaRbMLzMJMarlEHeBDKnczf1c5PvSiEssYkWkp0HlB3aXiOdHtBwn1Zx25i3xsuX1848+4TwLwArA3seC3j83+/tfxOlAEiSk2c/g5qemXnLPu9rLF3iAmnNUQnyPB3BmI0gPxrJLQRFwHNqL3A7J5LtM9DSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750422722; c=relaxed/simple;
	bh=6tcM5+MUwnRyUgk8+WCYBrfMJOSrT0lpOD6O54Q6+4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyBNEEnC8zhi5e+nq2NEaNSYTZxBR0WTMCxKZmM0wsqTxbyHrUv4VP3VJby1J0M3M0i8fT+BpZVdmwJSaeaaEUEyTmESZUxbbXhBgfpwR3KVMNmH9kb6meRfvq2/swCanx4z3DqYOeWzYA4wS3CjH4WwCSVP3tEPpjR5YXo5AYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbt/CC6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E01C4CEF1;
	Fri, 20 Jun 2025 12:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750422722;
	bh=6tcM5+MUwnRyUgk8+WCYBrfMJOSrT0lpOD6O54Q6+4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pbt/CC6FPgn3/aTo9ONeReqnKJDtNdwF1qAoT0kj4XLv4Ho0TSX37f3uPH70e0y1n
	 x4hQ2CaoqAXXXKWLq5/4Js28UCEHlg5UVk+FkzrI5isVeZPI54nKYAeyVbv4PIQeFB
	 YvCAmMMUEUIV0Nlo9rspkMv4ycueYw65QPf7E9Eg63Y7k56MW256y6sqgYjqvXOcQO
	 UEX+AbA3OUYeCXpvaai6aug+zEfFVzL/qtyYfRYCqI7NlYYH5ykGaqE1BH7z0puBiv
	 Ri+byvOQIvbAtkRyrIipw4wEkciU7K9p7DMauNrMeamGqLyCvVRqEoMznehkATYTS1
	 iC9lAhY30Tagg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/2] NFSD: Simplify struct knfsd_fh
Date: Fri, 20 Jun 2025 08:31:55 -0400
Message-ID: <20250620123155.271392-3-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620123155.271392-1-cel@kernel.org>
References: <20250620123155.271392-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Compilers are allowed to insert padding and reorder the
fields in a struct, so using a union of an array and a
struct in struct knfsd_fh is not reliable.

The position of elements in an array is more reliable.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.h | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 4569b5950b55..1cf979722521 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -49,17 +49,14 @@ struct knfsd_fh {
 					 * Points to the current size while
 					 * building a new file handle.
 					 */
-	union {
-		char			fh_raw[NFS4_FHSIZE];
-		struct {
-			u8		fh_version;	/* == 1 */
-			u8		fh_auth_type;	/* deprecated */
-			u8		fh_fsid_type;
-			u8		fh_fileid_type;
-		};
-	};
+	u8		fh_raw[NFS4_FHSIZE];
 };
 
+#define fh_version		fh_raw[0]
+#define fh_auth_type		fh_raw[1]
+#define fh_fsid_type		fh_raw[2]
+#define fh_fileid_type		fh_raw[3]
+
 static inline u32 *fh_fsid(const struct knfsd_fh *fh)
 {
 	return (u32 *)&fh->fh_raw[4];
-- 
2.49.0


