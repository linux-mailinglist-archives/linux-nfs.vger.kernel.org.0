Return-Path: <linux-nfs+bounces-8752-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E4D9FB3CC
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 19:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265F91882DFE
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 18:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0CE1B87FC;
	Mon, 23 Dec 2024 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS9S45Me"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BB71B413F
	for <linux-nfs@vger.kernel.org>; Mon, 23 Dec 2024 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734977256; cv=none; b=q1OzDHU0G7VcTOcajM7VWOzcAD6k1ACjS84iqTv/m6xUa7MPQ1YvWnUSeIpCzSFxVABPHGH/g6GUElzEigFE/66i/WFTmgZQM4Xg08naVF85QxIXqS+ic1uIfhckPzOI9XTJrCYItvrXABOHFlK0I5AeBfJKvt3BcUrIyK9N0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734977256; c=relaxed/simple;
	bh=vAHOURc2QFDsQ+Vf8bG4s7SmgSxxIAqY+fbvIc+HAmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Arv5fiE4T43jW0T8DOQdomU7VDWPJDqfUjtnWSC9QOWQDGHga/FhCm6qAGtWMaT5yGXsq2IsxaAqq/+ZHuc4LfOiLuhVkdweGfDp02cU9rJVcNaKg79RbJQUUz3ptge4c8HHPtdYLMWSDTPd9xwMhEoSK2tMCFd8y0MexiCDDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS9S45Me; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDD9C4CED4;
	Mon, 23 Dec 2024 18:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734977256;
	bh=vAHOURc2QFDsQ+Vf8bG4s7SmgSxxIAqY+fbvIc+HAmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IS9S45MejnANLMTn/4jEJn5L8pnDLIm48yP2Tu/PP/9ruRYIWlLVKsMjZJ9YSU2So
	 FIrRGD03msAX+ZSlJrkXHlkfHqAr2LoSnjpCNK7LGQqiC17CEQlZewI45UN/tH0BQW
	 4RoI03yEQ4p6aXLG9OiGpXhaQhiPjg1ZySnwxyy/NxJp35U4kHAJg8ELdv/IOJLwMv
	 m9JOpHCQSTwgZvolv1qdi1WlJXV7PndCpdVkl0CPV76wYiK8bpDDQXbyoKGVkKsU3g
	 qI0bihhGTWpeL6RBoE4QPmemAz9EmYJx9qOGDcWrvvwmVqKPEMPAToO2l2spjieAkl
	 3LfrbWnggrE2Q==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/2] SUNRPC: Document validity guarantees of the pointer returned by reserve_space
Date: Mon, 23 Dec 2024 13:07:27 -0500
Message-ID: <20241223180724.1804-6-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241223180724.1804-4-cel@kernel.org>
References: <20241223180724.1804-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=chuck.lever@oracle.com; h=from:subject; bh=uLjWKL2TqJ36N4+l0iS/D1tISUCfw5s2iZUTBBNq+1k=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnaabiYpTlpGfVrZeCU0efdCBKJxwWnKgtiAbre 2PvUG+5zNaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ2mm4gAKCRAzarMzb2Z/ lxXFD/4gIhUIYJ4tekDCLqHCZ27ots+bRfNyYH493H/aeqk2mFugOLhUJDtjzJzDelc94rYvomk C223ZwtzPahjNeHliMv4yn7/0diCrfL08ODvppDBd3XASg3NA3eHPYH8DzUdsADAa5R6JfKjbZe nB71/GFFBSyTWPzFaxyBFFSAQQBNzfrenS/akiHQU8wki/lLghjM5zZDrrJXWwK0NnwKpAOCHLR qCK4w2FsCkeV/EIQoCwZ4p139kFa9WUz79oWjuH0hXaQJ/zWaVFsONRP2cxJb0g5XFyUPec1/eO qr3Zrul7aW3bW7oOAgdljYOH86t7a21jdpypLDQwc3DqZCBM1qSk8E1JAoH2VwbI9l/fLKw9pba caqIQ/tdXYdZNGJ34O0pGq1MOsH7IyDa/Qmk49k7R7pTxbvRY6POBPuD+0aUOLjvu9vIKlE/ibC a/0BDwDMxjyvPiYNje+2OFqjZ2GgLy+aoDaVnNiGy/pcMDFyYbj7pwXnb7ehhbV0tE9/azcS3pg G6v7qpDSaLvO+2yHZ8mY2y/m0VGyM3H+w10edkS2fsWBhXd3DIi+0pTV/aQ9G4zuK/EtoEMvvxo EvNyBkldcbJuSdK5D/AaWlY9up2BDCzl9TcSxdneEhrBR0ImavKWclEPotZtsjSjHuDvycjZLni dM5h86zR9tz43Fg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

A subtlety of this API is that if the @nbytes region traverses a
page boundary, the next __xdr_commit_encode will shift the data item
in the XDR encode buffer. This makes the returned pointer point to
something else, leading to unexpected behavior.

There are a few cases where the caller saves the returned pointer
and then later uses it to insert a computed value into an earlier
part of the stream. This can be safe only if either:

 - the data item is guaranteed to be in the XDR buffer's head, and
   thus is not ever going to be near a page boundary, or
 - the data item is no larger than 4 octets, since XDR alignment
   rules require all data items to start on 4-octet boundaries

But that safety is only an artifact of the current implementation.
It would be less brittle if these "safe" uses were eventually
replaced.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xdr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 62e07c330a66..f198bb043e2f 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1097,6 +1097,9 @@ static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
  * Checks that we have enough buffer space to encode 'nbytes' more
  * bytes of data. If so, update the total xdr_buf length, and
  * adjust the length of the current kvec.
+ *
+ * The returned pointer is valid only until the next call to
+ * xdr_reserve_space() or xdr_commit_encode() on this stream.
  */
 __be32 * xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes)
 {
-- 
2.47.0


