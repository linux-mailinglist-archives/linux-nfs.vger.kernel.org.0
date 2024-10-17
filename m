Return-Path: <linux-nfs+bounces-7238-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2596C9A2601
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 17:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577A51C2122E
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE071DED77;
	Thu, 17 Oct 2024 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqP4tcUw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DBE1DE8A4
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177442; cv=none; b=hcbqKXyUzXDTdw/tsZ13Kwbic0spnwYBFuwEphAKe78tBfQzeWeoTJNvDZR7YJpYhYXXHZ4lRSEEmLox46Lr/C0uUBjOSTH8bpiDtBQj7NHxx5oUYHKPq/mhbn0yq33uKJK0F/MLTmTnxUeHHTX9DcbN7eHWYmkgeHvl5oZrjwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177442; c=relaxed/simple;
	bh=U9UQzU41z5wHuKSoAlUXFfMTQ3XngxxUC7pDfgH0RCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ll3hm7vL2Gx9Nsq8D690koITE4m9nZlkZvsJK36m7M7DRRtQ2ZPNXo2BOn17HM1pxPrhlYxPWEkFnY4+zY4iMJzY+tDn2/+M+1+YP9P30cYPjXslUhZDDKcGWQCYhCI9PjzHevLdWtweW93Ay4bd/7bmk67a2Nt/TC3L96il51c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqP4tcUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608E5C4CED1;
	Thu, 17 Oct 2024 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729177442;
	bh=U9UQzU41z5wHuKSoAlUXFfMTQ3XngxxUC7pDfgH0RCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KqP4tcUwd8wvjcCCQevn8qP0W4Z+Iz2kuRpj1xF3En+ynEWfE5jLNDG9/qWW1XnL6
	 dvp0HHNJqFyhuLgMPpgq/sN7U25kYlv4haTqHyX/TMxAPiBxUCppo+tw8p05+bUvp0
	 Z2oOAnU5cciYasZyB5qgO93nRyo6pm3rwJtvV/ulKkt5oqbv0AqZ+b6dHLPOKL5mLG
	 fT4yj1Jh9NUvecCuenpZjPeq0+FG0jhmnhzUWvJK9IQ81fL54opTXgjwXHPahiKlQc
	 w3DOYdnOjcvmgzfvUHkwFbfgaj7M2ZCEqI9AW8OOBqrboBquceOyH/aVzHGXxCI1qO
	 fWPDs7FmpEibg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 3/6] NFSD: Prevent NULL dereference in nfsd4_process_cb_update()
Date: Thu, 17 Oct 2024 11:03:53 -0400
Message-ID: <20241017150349.216096-11-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017150349.216096-8-cel@kernel.org>
References: <20241017150349.216096-8-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=768; i=chuck.lever@oracle.com; h=from:subject; bh=SNXmIoW4WxzSMhrWR5Xm4EitRtuKSsFWMVCZYMQJPJ8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnESdbyyGZe4NI1jzLACe0lW86O/mfKL3O55I4E sEFHwnYgF+JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZxEnWwAKCRAzarMzb2Z/ l+w1EACpbthCxK0ZuuZigu8WI3EfJ0S/3Gt2vGBvtB7gbck7/0DjNNTTZmzHPVi1ugq+Uk8VFi7 jsk6zOnDsNwGV7JuQQVD/9juNyoLtPlFRH7TlkIrK8XxUi9CA/sNscVJU8w51RIA7SfGzgwFhQC PnySLe3pgcjHJPalr1jS7junkG6PxU6JkZQ6c7V1UBOa2/JyGs4haaqQChDX7V013tziSR6M/o2 FdP8CGFb8oR4aKE6FM3bXhSM1ete9WOXZWa4nxYNhXHHg/26LTWLrVhPfX5axwIiYuSGX08XPf1 XQuj/C2yAXrVf+CLAwS0DgXd1NLT1/oetGKO0sCII3Xc0joTIwbjSovvHf5GSF4P1ZUCy91Tqkx PhtVWNh/W4Y5aNvNz5L6H2bGS0ogKSFHKi/AjzLmnSHk+Fvs1xaG9tGq/js37QZIkOuBDMx+8+T xGjErZCuefSljQ9bpOlagZogMBJxEpHCn8iCPNxaze9MM7/NnSqdO/h01fMYfOUFM+51ECN8tPX vIitoTnvOyTUXHtXlM37dwbVwuJOhyuAvGwm3rTFFtz82XvUTNmIjkCviCV3PufCLol16nzwIHo qLxt2B7lmL+uTEOIr4AlN48KaI95l2DMuXHuFedLaHVK1reoKAhruQXtgtsPgAqXM3stzG8qFKg T3xgx/DAY+T0qjQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

@ses is initialized to NULL. If __nfsd4_find_backchannel() finds no
available backchannel session, setup_callback_client() will try to
dereference @ses and segfault.

Fixes: dcbeaa68dbbd ("nfsd4: allow backchannel recovery")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index d86a7b983785..2e18f635078f 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1500,6 +1500,8 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 		ses = c->cn_session;
 	}
 	spin_unlock(&clp->cl_lock);
+	if (!c)
+		return;
 
 	err = setup_callback_client(clp, &conn, ses);
 	if (err) {
-- 
2.46.2


