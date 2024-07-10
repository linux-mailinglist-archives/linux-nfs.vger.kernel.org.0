Return-Path: <linux-nfs+bounces-4770-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC46B92D242
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 15:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97117282E7A
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC54619249F;
	Wed, 10 Jul 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiMw688F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36DC192493;
	Wed, 10 Jul 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616788; cv=none; b=Bw+585vAlEaWkTf41O/rRZbvxOhG9q5ciWfZEt2uFW4MI4fNbEWENxrz2h9KLTR5Y27pA3s4VyeyJ4ZwL67zNrw5Jc+QKnIZjsMBS9ZXIDeLDHR80889+0B3TViylTJ9uUwkFWiq0I2kwMKC5/tknkaVzQ1ksYuR5f398D+TLA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616788; c=relaxed/simple;
	bh=PW5J9RmIMWOs63awhlKVRUsc/q4YKmg5qreeXssolV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u8tUzbZl7EP9l13keF+K4fU4nfHjqurR9ujKMNbDjLNNH9aR9ZvhoWFIQeciDO/VNlfP30XIhtYmHJt3J+fD4Iz+SEQqL6oWmLr9HoG035rfGwr8sg1QRCx0po3GhSss/opPHYQqAT/O0urwlJOxK2ilbZRreopBLrS/aIndeyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiMw688F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4900C32786;
	Wed, 10 Jul 2024 13:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720616788;
	bh=PW5J9RmIMWOs63awhlKVRUsc/q4YKmg5qreeXssolV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SiMw688FWW7JGJgbfE2KskdR2xPCVCUaohwjmypFnJMo3FxpWOONbpCP8SsmobD4D
	 WA8J2x7Md3quwMCadzF/01mL+0M5MnsqUH77+hhEDdWwXSaoqIfd1RzoNW1ZDXaC2W
	 /s0J9FZZlMdS9wUhLCR0ZwXgQ90XxG7+RqEC1z+Opm1XHRJTgrUv0KfRQy8RX/M9I5
	 Ke1dZNyrtmOE97bjHeotQ36db8ffQHMON6hppZao4Ws8l1MIvB0h76ITvIOMsRekUv
	 fB8R4SesdotUEAPrvXvqqWi1WHJGNqhKRBKFKlQehInflrFRnYKycXXNM8uIFq57jI
	 ttbkElQkQucSQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 10 Jul 2024 09:05:31 -0400
Subject: [PATCH 1/3] nfsd: fix refcount leak when failing to hash nfsd_file
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-nfsd-next-v1-1-21fca616ac53@kernel.org>
References: <20240710-nfsd-next-v1-0-21fca616ac53@kernel.org>
In-Reply-To: <20240710-nfsd-next-v1-0-21fca616ac53@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Youzhong Yang <youzhong@gmail.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=PW5J9RmIMWOs63awhlKVRUsc/q4YKmg5qreeXssolV4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmjodSC+xMX7A+v7sYgagQPog5F6NLwmjttcuO0
 xBcvKjd/Q+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZo6HUgAKCRAADmhBGVaC
 FRiHD/9I1vDhHMocDJFsxvaHkCVa3fKzADNGbS9odsia4tuFszKqqHCAG2Bwa0427ewDEU7bpzX
 P2R4KrGUSCIq1b+Wrc0S+AtsgZY57O3nBN4yO7cc6Gi3bXcf9OqJXUXOB95wewIOx2akAVIjfco
 SLXnRFVx9sEuX6JuKs/TVJ3UcRI0whKRs9d28aY9jV2gik+fJ/gRlK231ydiRR14azllZBUlaf3
 VIQ5sq/eaocem/gOOsPhw4gUGaNjPzSPDF01jRF4lSb5FppiRR9rkMZ9U6H1G6Gs8Sd1wYkq+gC
 BoOwLEqe4aKR+wVrWdajMCbTHep6hCoiGHfny1oCOrVTeKIl+PT4UITzn4iJE3uYSoV4vX3fiJP
 ts2ZzY4xlhWWYcWZd5wI+jqNxeKqVAkvuJKaVsCfGsChYQCpsPyCNl2LZSVblj5DtqeKxdEwO6F
 v5CLzE+FIHdyoJJarKwWYqlXLWYByIXUzrbL0cECDUjMbzUrbiu4iDFxZ7XyfTzRO5xhthXA4H2
 2Sve9REPux/eN3fHKyma7Xj4XRRCknjzABT3hbd7bbXE62+MbfGWYtiheYAUPjc1txWvZfyUSof
 5hns8o+AQhksQ3eZ7VD3P+yfs0dLBYTMedEfADpp6AuGDZ8w9TjI4JlqIp+rAm9PCjI3zEHVIrP
 0lVSp4DXgeryGlw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

At this point, we have a new nf that we couldn't properly insert into
the hashtable. Just free it before retrying, since it was never hashed.

Fixes: c6593366c0bf ("nfsd: don't kill nfsd_files because of lease break error")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index f84913691b78..4fb5e8546831 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1038,8 +1038,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (likely(ret == 0))
 		goto open_file;
 
-	if (ret == -EEXIST)
+	if (ret == -EEXIST) {
+		nfsd_file_free(nf);
 		goto retry;
+	}
 	trace_nfsd_file_insert_err(rqstp, inode, may_flags, ret);
 	status = nfserr_jukebox;
 	goto construction_err;

-- 
2.45.2


