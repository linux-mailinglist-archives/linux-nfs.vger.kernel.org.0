Return-Path: <linux-nfs+bounces-9612-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE849A1C60A
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 02:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D6D164E41
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 01:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2630F157E88;
	Sun, 26 Jan 2025 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgLbX40u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19753365;
	Sun, 26 Jan 2025 01:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737854012; cv=none; b=CdL92JDtcNehejNMgsyIwBOtLiMGEqtrPXWkM5/OrDPh/4YCybuvCs/jRE1hjVmNaaAbt/W+npCqFtXrhS/PmugCkoORQEn1qpDDaG1r4mdJyufi8Bkeme6N9L+kiTZV8IpiXDU2m0fQXMQ6eHm6kZbYiCdAu1Q9L1Htr+E7Mwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737854012; c=relaxed/simple;
	bh=niRaW8BMSJcX2zywf1Rn07w4JUDzKCSVKqP0bw53zEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d5HDMV32SNtYbYmPZvGIdZQYIyo//d/Q6RfELnsxxVZhaIF7sUqPxuvb2pWRYfN8JFttzt+03+c7uFpljzb0SgsCVlc4jgg/ls4QPZIlvx8Kz4+Q04i559IF5U1oopk1BkaFFZF75qbmncq7fEz6hi1zPkVUBq9NZOx4TzD7EFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgLbX40u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89002C4CED6;
	Sun, 26 Jan 2025 01:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737854011;
	bh=niRaW8BMSJcX2zywf1Rn07w4JUDzKCSVKqP0bw53zEA=;
	h=From:Date:Subject:To:Cc:From;
	b=LgLbX40ufNguePSZBKDGxgZDMy23s77HrIPcN0fFGQj2dMl3Z2PsTZNl0UgHNKpDB
	 xaNN3he3nZcnnyn0RN3VbBCw1PfNuRoQTthK+gYwTm4vpEkIsrN6YAM0S1NvxZkeUA
	 eB4UM+UftPtRjaE4qMwvA9IYKcY5sJJvbrFsg84KumOITj8Dw2devgmqnTCLHJ1xxl
	 EgnB91iUKISFpRiCq3AqYCk6uXJR+AmSDqnMyhTIbHpMlKHmlVILTM7KAmU7PA78fr
	 lz6O38gHy5mWZATMtttmmDqbmnBCCX7x890Shv5/kKpdtLyj27x9ZwTmvOkE80f4Cf
	 a+5mmkhbLoa+g==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 25 Jan 2025 20:13:18 -0500
Subject: [PATCH] nfsd: validate the nfsd_serv pointer before calling
 svc_wake_up
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-kdevops-v1-1-a76cf79127b8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAC2MlWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyNT3eyU1LL8gmJdA0sLSwsj08RUi5QkJaDqgqLUtMwKsEnRsbW1AH3
 v4UtZAAAA
X-Change-ID: 20250125-kdevops-0989825ae8db
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=niRaW8BMSJcX2zywf1Rn07w4JUDzKCSVKqP0bw53zEA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnlYw2ukl7tPXixpmy0Pk71jVtoiQQxT9i5oNZ3
 QkW/GiXhoeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5WMNgAKCRAADmhBGVaC
 FfP6EADHeU+DdaLhlc2419lGKITdIx1sjSQ6Ytk5baNXcdk2r+yjeKSMpRYmHqFlCNTQNd4QTgZ
 5xEVeB6xUAUm6W0YE/q4VL3n5HmI9j2FCpDf/Z0k8/2cKqrPd34QYGpovkskVEnyzKusb5UiJFw
 l2jt56CxIf28T6YPaAfh9dA4Qhjzd2pr2BezaSsTFKG6xpkKZXT8StqRwLqo1CBJzlJMVua3LkR
 7UN13dfz/zVv8Ty3ZKc4mk5p8+9pVG/d74n3kqC4CJ7IXgBtmVf5b0JYngA5retCd6VamuVXLNH
 s6TUhjfnI5s1v6A0EiJaL9tJqAAaMjJy5ycVTBsw2Cfp5EJUUcAxAMBM3eo0fn9dE1NBRjMtrMk
 5Efww9bT1RDhE61Idowfba6M1R7IGEx4HBjC2nSu/oJR0tvMIrf7drRlyGpu4b7ji/HLmO2RT/L
 6lOAiG5f3c6mGOmneipY2eDspL+BdMaKmF4zAoz8wLrL5JOVdvkO1KhZhcIidSTjAt8Dc0l68Dk
 cBI1v7yovGW4IzDNV38UngmlnLzuMgYFwImLYsdft8SR3NQgwAxDrHEOCw/vR0HqnpxxXWLGwyg
 mr8oFa8ngc4F+TpTPyfQyAFLZhcHOnhM9n0JkSpOqbtS6r1koFhDo6qjVd3GAInuO+0qDpIJXJS
 oMAD7ZMZT0n3uZQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

nfsd_file_dispose_list_delayed can be called from the filecache
laundrette, which is shut down after the nfsd threads are shut down and
the nfsd_serv pointer is cleared. If nn->nfsd_serv is NULL then there
are no threads to wake.

Ensure that the nn->nfsd_serv pointer is non-NULL before calling
svc_wake_up in nfsd_file_dispose_list_delayed. This is safe since the
svc_serv is not freed until after the filecache laundrette is cancelled.

Fixes: ffb402596147 ("nfsd: Don't leave work of closing files to a work queue")
Reported-by: Salvatore Bonaccorso <carnil@debian.org>
Closes: https://lore.kernel.org/linux-nfs/7d9f2a8aede4f7ca9935a47e1d405643220d7946.camel@kernel.org/
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This is only lightly tested, but I think it will fix the bug that
Salvatore reported.
---
 fs/nfsd/filecache.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index e91c164b5ea21507659904690533a19ca43b1b64..fb2a4469b7a3c077de2dd750f43239b4af6d37b0 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -445,11 +445,20 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
 						struct nfsd_file, nf_gc);
 		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
 		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
+		struct svc_serv *serv;
 
 		spin_lock(&l->lock);
 		list_move_tail(&nf->nf_gc, &l->freeme);
 		spin_unlock(&l->lock);
-		svc_wake_up(nn->nfsd_serv);
+
+		/*
+		 * The filecache laundrette is shut down after the
+		 * nn->nfsd_serv pointer is cleared, but before the
+		 * svc_serv is freed.
+		 */
+		serv = nn->nfsd_serv;
+		if (serv)
+			svc_wake_up(serv);
 	}
 }
 

---
base-commit: 7541a5b8073cf0d9e2d288cac581f1aa6c11671d
change-id: 20250125-kdevops-0989825ae8db

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


