Return-Path: <linux-nfs+bounces-1019-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E45282A03B
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 19:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB361F23D8B
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 18:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5874D596;
	Wed, 10 Jan 2024 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vpdhwpkg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712394D594;
	Wed, 10 Jan 2024 18:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76A6C433B2;
	Wed, 10 Jan 2024 18:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704911259;
	bh=yjPNURAdFYMXbAkFhL7jhpuqM8L0DD+heQFaL9IIg0w=;
	h=From:Date:Subject:References:In-Reply-To:To:From;
	b=VpdhwpkgQjweHO4Lid9eDPwYAoJIbXg4J4Yoiruj8HLGHleH+eves7Up4lHIHC2TX
	 6BwOlbNhcp4UAVCVG5V9FrGI0ka0liuc1zHOYQT2nsRkGwlerC7r9RGNQ/xZBLGu0q
	 ibqUmtzx+bAbldgWuX6+qPz6/uANPT4KfGqLGiCYXSPmZBmzV+Zzz4EKTK1ttZEdij
	 H4Yya1s3IESroyGcZaxe61UdwonlaQcrfx7HXHSMmyJkZpH6qP1S6CwkSjbxF4ruo+
	 4DQAhq9zSg/lNh9O5NDINzrqcwEb3cmim4K5kl0LDP36Eg1tDuVeJ2xC78LKNU1oqM
	 j0aKvYhrEgaVg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 10 Jan 2024 13:27:28 -0500
Subject: [PATCH fstests 2/2] generic/732: don't run it on NFS
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240110-fixes-v1-2-69f5ddd95656@kernel.org>
References: <20240110-fixes-v1-0-69f5ddd95656@kernel.org>
In-Reply-To: <20240110-fixes-v1-0-69f5ddd95656@kernel.org>
To: Anna Schumaker <anna@kernel.org>, 
 Trond Myklebust <trondmy@hammerspace.com>, 
 Chuck Lever <chuck.lever@oracle.com>, Yongcheng Yang <yoyang@redhat.com>, 
 linux-nfs@vger.kernel.org, fstests@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yjPNURAdFYMXbAkFhL7jhpuqM8L0DD+heQFaL9IIg0w=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlnuGYbSfhG3D4B3ZsEKM6HLWTrv4p4pT4ASgrZ
 WtXzpWIxeiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZZ7hmAAKCRAADmhBGVaC
 FcqND/0VXnUWHl8lta/KG7enlULPjoUhLq37ar62Dh82t+DWsi5UPw8HFqUA6O/ZKNX1ttZTyya
 Tl7AzyPQsaRcDHYUtmrdvwPmKeeqj8KmaO+JwOQoVv4BT5W5SGDfsQoMxCxH440UXvbqlMU9yNQ
 /MYNOHso80h43QDevBOGsKhYJoasHmYwQ7Ms/xmnaAQ44LD11S9JwCenY2VbqFkYifq4ej/8+bk
 KPF0HLVZa7/cQKgILjZqYXTfHi0clm5SxHdcIoqkR+cq+CKg+o6SuvxXdMQ9bCqTl3z924YzqL7
 R8XiYK4jDcEDvVxkXoBbhteD2FitrlsFzdStLDzehy47Ttre+/fGVxZNa1w+M4Kh0wqre541H5O
 BZ4gecV+6xH92Fw5mDydQWmWq/mAahgz4lkvRORbIjiWqXwRzuF2OA3/Ur5L9cSAHXDk2Yk0ZMy
 nom0XyBjyOOzqOzTTrioZpdpimQEEAuEpqYZmM/na6e/Bs+hfO3HHFumUQmFX++yEof/TXZZ9sM
 icUlE/bXroLnx+VEJ0m8nUVKH8fLxwU0ynQ07nBtdQJ2OPKNipzjo5f0GrdhDCWdoaeEkWMJDpI
 1XEE0ijnIeun0IyjSmA5u7BJmYDgZM6i4BIC8UQ5hjsSaPuhhiJ5TWUQ1I8ZgJU15TnAKlhJL5l
 /cS5mc8yCgRMYXA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This test sets up two independent superblocks with the same backend
server, and then does RENAMES of the same files in the two servers. This
is basically trying to simulate the case where two clients are competing
to rename files in the same directory on the same server.

This test would usually pass vs. an NFSv4 server that doesn't have
dfdd2630a7398 ("nfsd: fix change_info in NFSv4 RENAME replies"), because
the client would end up improperly invalidating the dcache for the whole
dir after most RENAMEs.

However, this test doesn't (and shouldn't) pass on NFS, because the
client has no idea that a rename has happened on the second mount. The
expected behavior for the NFS client is for it to use the cache timeouts
in this case, which is what it now does with the above server bug fixed.

Exempt NFS from running this test, since we don't expect it to pass.

Cc: Yongcheng Yang <yoyang@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tests/generic/732 | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/generic/732 b/tests/generic/732
index 785aac58f361..5b5087d5accd 100755
--- a/tests/generic/732
+++ b/tests/generic/732
@@ -22,9 +22,7 @@ _cleanup()
 }
 
 # real QA test starts here
-_supported_fs generic
-[ "$FSTYP" = "nfs" ] && _fixed_by_kernel_commit fdd2630a739819 \
-	"nfsd: fix change_info in NFSv4 RENAME replies"
+_supported_fs ^nfs
 
 _require_test
 _require_scratch

-- 
2.43.0


