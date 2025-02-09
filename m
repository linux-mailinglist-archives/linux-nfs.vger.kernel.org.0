Return-Path: <linux-nfs+bounces-9981-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2967CA2DDC1
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 13:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A491D3A677D
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 12:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15E11DF737;
	Sun,  9 Feb 2025 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVZAjpjP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A1E1DF25E;
	Sun,  9 Feb 2025 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104298; cv=none; b=lCnN+OtIAu/iYwA+UL7zCRy2CUn6Pldn3QQDUBN/vUd15jg88+Ibrl9DOdvQ6ws0M0XhAEI5ReUccVmji9gYLLHUZM2sb0kt8K5Ip9dxirMniuYzO6UYKVjVMwciEMPq1/9jVTHtaKyNtKWlI/dlg8fCFRY6P7qW7dqJdBAdeao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104298; c=relaxed/simple;
	bh=dxNkzQ9dvAsv5b3oqVUkUt8bu9X5wXULwoC41VXqXLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XDpsU++lf00D/srK4xcfD7oRcq3k5Qfaa9ip0wwgU2id4vXXZj6OEEDIfvlDLbFtXFiLeN+UAu2n4pZjFMef4gFIDy5bJ1UH89qSsocKXm+KSTSMR+7WL11WQJbT6Hp1ATv4oCHwEuPLSsNW1vCLdaStMz8top8yXCKJV/0HMjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVZAjpjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C716C4CEF1;
	Sun,  9 Feb 2025 12:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739104298;
	bh=dxNkzQ9dvAsv5b3oqVUkUt8bu9X5wXULwoC41VXqXLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QVZAjpjP22esVF/NA9E56dThKIRqH1QRcosL8My0Fkawj9Ge+uWi24bl+JhyXJQuw
	 /gTlUUcmn91N5shFMf8HHbFFUvyhfh3fMVj6IdOMjKVo8yF7IC63HORsU11byN4u+w
	 SJc8XpIkVKX/l6ZJS/pnnKvI7QxS5mc1qCiemX/ubkQjwpdbxLwcfBq7tutvJjSuJZ
	 W9deVflwYFCILTaIv43QTiGC2n5GIOssTTeRU1RpcBoZ5DmYxgTxYLtKWVTgW/2mqb
	 2NyMXwZ6ZwpVin/3iigdcv/cp5fw7ZKiHejulxzPZqF8If2NH7YfxMdKSXDAZasyOP
	 +TNcsN1rn9SBA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 09 Feb 2025 07:31:26 -0500
Subject: [PATCH v6 5/7] nfsd: when CB_SEQUENCE gets ESERVERFAULT don't
 increment seq_nr
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-nfsd-6-14-v6-5-396dd1bed647@kernel.org>
References: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
In-Reply-To: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dxNkzQ9dvAsv5b3oqVUkUt8bu9X5wXULwoC41VXqXLU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnqKAjdxMj5+gyUhPTPibLgaDhdaLbGL5L7Pabz
 WLmTGxum4eJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6igIwAKCRAADmhBGVaC
 FfrsD/0cRAtp81cpZzRbkzVPI69JPAGZLDQFQzf++6+9deQA55w7n3dIId3q/yBLQWnJrNVanqs
 FNsGFfQPlBQrKolFyahNaEnxH4XnFctTGRcVT1T60iIgqOcDFgPkIs/VQMx4e3tO3IyyuaCn/c+
 IJMbGzYsb+EHylq1+cnyAclcZbfFSXmzhd+JGipJKy1mySXhITnffsoVLooPZHuDKMMLe8PBYYr
 P4rfmBrtCE+QY2RgT2SLv/zXb6HsAGcFoW18+uE6rYDLO+Yg/Vvt6qsyojIs/FodnWZ2U9A6a6s
 tRE9/MoSqNQy9OysLeDf3JFvW5xY2Ws9fkf4mJ/veYXJhlmtpYFXy2fGZh4P9EUv7eujLX9wTxR
 /8cteEMzBHAYB6Lstl5kV6Swe/gyfdl9iqmnlNJRSzOr8z4DWmS0hbwFbaFeGTlCxU5E6Epp41s
 5X4erKv0yder6YWMsvJmwnohKZUorTUgKeiRycmYqQrOlEn92wmbvmKmasfBkpEJ8wioMb5MCfj
 M3XGK8mP2qi0oPx6hkGdjF06C9t/XTKQwExrJrUW3tGko+1uJrSMfiBCNlN6TzBIN4C0xo9dbKq
 twvN5el+xYCXckoO1O99ou3RpOJ4fuAmCl0bDL/S4/WQbEsQrLiju05byTb7Dc7tgJNRVaAqN/N
 dyU326Xgw6PBX9Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

ESERVERFAULT means that the server sent a successful and legitimate
reply, but the session info didn't match what was expected. Don't
increment the seq_nr in that case.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 8cfd6ffa6e18c4db5924d35f7b3344dbf350700e..18803ebe2bddd433308cabd6f99b64ec887069a7 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1363,7 +1363,12 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		ret = true;
 		break;
 	case -ESERVERFAULT:
-		++session->se_cb_seq_nr[cb->cb_held_slot];
+		/*
+		 * Call succeeded, but the session, slot index, or slot
+		 * sequence number in the response do not match the same
+		 * in the server's call. The sequence information is thus
+		 * untrustworthy.
+		 */
 		nfsd4_mark_cb_fault(cb->cb_clp);
 		break;
 	case 1:

-- 
2.48.1


