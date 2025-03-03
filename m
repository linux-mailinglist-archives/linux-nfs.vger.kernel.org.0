Return-Path: <linux-nfs+bounces-10425-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E53A4CA50
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 18:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7FF3BF980
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 17:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565B024110D;
	Mon,  3 Mar 2025 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvs4Qhdm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E14B23ED77;
	Mon,  3 Mar 2025 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022779; cv=none; b=phOKRDp0pIuGZe1A0HWqpo5ABRJdDiSLrp/zXg0qXDgW2tveVibB3yg3RModjPT1wg2cmG2Y/VVNCUMV3xlu6tofUaiwN7JNfsZ5HFuM3Ohq3TJCxWaemEI6JU8xG2LMH4zX0pyCkbAIiDi3xv8DqufbByUmDpBEl40O9bynOBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022779; c=relaxed/simple;
	bh=3FsD+s45OjsIemR8o7iKS9geA8NlGbBjBb5uxzlcHL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AWxk2Yw3ng8FcJH+XOGFVpb0uTVrz+xuNU7/rCsUzOLz2uHZS5kOKqLOyVYj/KjXZMtpP1ZIA2R3IabG9+IrRrUmIHk7Q/dO88pgcGUSA6++FbTutA6foTlR0xvVWKlhuXCncR+r8IiOGWebgfrYdNEzNqx6TY9iFvkoD6I1xDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvs4Qhdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100B9C19423;
	Mon,  3 Mar 2025 17:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741022778;
	bh=3FsD+s45OjsIemR8o7iKS9geA8NlGbBjBb5uxzlcHL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tvs4Qhdmrzes34y/dEXNLiKGl7fI+cexyPuZ9Y99c1LTSAeOKL1be1+GczvMEiLx1
	 IpG80p2YQCwo7mQt30d8oes61zLANxKoHfmObW0g161t0dIUE2AGPWgpcFb615071s
	 TCES/Z6rWU0BEYcDsC07vdk0dymlc1voAX7pmbGrih10GXNMjQ+PhGFrxG1eA86aRa
	 UiVe5YRejMeyNgbMLKw+nsCi4Q3o/YUXc4XCBFUXPVPcUvIJFEp5gasSCkVFW4Rycb
	 6288N2EDPTyMjbc9zq7TeHczhPLmLsyWD0aNV3X5aYbnCox4ss4skCOg4WKvDqeKMz
	 HZfPT+iSA0B/g==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Mar 2025 12:26:02 -0500
Subject: [PATCH 4/5] nfsd: clean up if statement in
 nfsd4_close_open_stateid()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-nfsd-cleanup-v1-4-14068e8f59c5@kernel.org>
References: <20250303-nfsd-cleanup-v1-0-14068e8f59c5@kernel.org>
In-Reply-To: <20250303-nfsd-cleanup-v1-0-14068e8f59c5@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3FsD+s45OjsIemR8o7iKS9geA8NlGbBjBb5uxzlcHL0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnxeY1wFXoJvoBuxkX8RXg5JR4IG8AbHHA+EZFZ
 VNE3dh0C4mJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ8XmNQAKCRAADmhBGVaC
 FSK7D/4uXU94dyrDE6NbpETObgXuOUvAeSY2eHnVHudkx3zmKBgGD740DFOh/wMTZUDKxVPwRIt
 Tf5esM75x7KQSzARS+0KAitZ5g6d+ktPx/LVRiyJFGObBSLDMTOy8byeAlCPgakSX3ZuLV2nIam
 CZwNbxhWvb/DvKYV4gCYZINT/yhO92kwb3tEKmfxLWrhXorpfszIKkgf++ltscq8i2bGfMzAo3y
 aoy3go1cepxHOvkogHo19igPdRX3YjVdsNAGsfCfsfk1ba/+ln+sW0IU1aqSID2V3WE3O534B9U
 mo7wTH6sTA+dtsS6VccYYeAoTfL10WZ/P4kO3MMnOelqQvYYPV4YxlDF4VBl+F7C/FS0OjXy/sC
 QN2k2IEuqK+xEGKkAxG9g+4+S+3Zu48b5Dk4uKmYqoA85z2LoTNSrtyRyeu2Q6cR0B5iU7PLjmJ
 9LOE6/W4/zcse4HVujN5b5G18qWGs4SWxX19qQojfpuDSrkC6ipvpAvTylDSP3jzQCapfcDvl/C
 eRw42FyywMOO1bxq9NpL9cQtEngql2r8TbGD3ExPlqGeY15kojVcyEsOuaz9xMraPWCYyow2eCH
 Pa7AO4wyk2b7zkYVg6akAHn9NZ7WJNvHW7xWNdlLlT9scz8UDAGz2lrXYp0aGmMbhL5sP5lqX9/
 fdP0yZeXVDtu16g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Just set unhashed to false in the one case where we return that
explicitly, and drop the else.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a7bac93445e2fdbe743b77e66238d652094907cb..1f3e9d42fcd784ea8d101ad3549702a30dfe9058 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7644,12 +7644,11 @@ static bool nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
 		list_for_each_entry(stp, &reaplist, st_locks)
 			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
 		free_ol_stateid_reaplist(&reaplist);
-		return false;
-	} else {
-		spin_unlock(&clp->cl_lock);
-		free_ol_stateid_reaplist(&reaplist);
-		return unhashed;
+		unhashed = false;
 	}
+	spin_unlock(&clp->cl_lock);
+	free_ol_stateid_reaplist(&reaplist);
+	return unhashed;
 }
 
 /*

-- 
2.48.1


