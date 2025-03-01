Return-Path: <linux-nfs+bounces-10399-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48160A4AD5B
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 19:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6046E17015C
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 18:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631691E32A2;
	Sat,  1 Mar 2025 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7a0Rji2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D14423F37C
	for <linux-nfs@vger.kernel.org>; Sat,  1 Mar 2025 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740853917; cv=none; b=BsZXwW2uDJYbe6aYCjeAuK4DX7HlEYmWsGqfmtTXz9kxm/KyUJC/+mX6bpFQ93xhTDIZYgnCMiLizogQ9ChDlC6d2yUHgPmfIfYUfA3bNkuzcWyFPcnE6yW1+i8GT2a5/6bqbG0iat04zlBkkZy+OcpzGiYZEjRMDj9hx8GeOSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740853917; c=relaxed/simple;
	bh=pXLkTue2agU9aUoirGM9pYc+ArZ6Ml0BGKW+n3BCSPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCiPvuMmx71ezGD1/qASYaWa7yCPY1DL8C47IloKG/ZLcUqLmcpZltSI8Sa3cFZZEhDTo8giDbr0oHImKFiNZQLLMbNILgVZBVdy3wJt8QGV7Vj35iE3bVKs4ZUDJ181k8dchV5ImNfTb/62ANRnCSE5GiM8cB3NfI8nVIcJf7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7a0Rji2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DCAC4CEEA;
	Sat,  1 Mar 2025 18:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740853917;
	bh=pXLkTue2agU9aUoirGM9pYc+ArZ6Ml0BGKW+n3BCSPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7a0Rji2oMYCanpFcZLXRZoeIdLqAtMHzIKndAL32sP5ts+VB403IqzNBPrJqnWBa
	 dSU7v68xce7wLTLFDFNYzDp9Ecm81kQusgbOvwf/oaND+YPsmBJJPBDGFpjc8U0ykt
	 RxFQOlfA3STJsajMy/V08Ij+n2+zH7sFxvyizbZS3593f+2gfQI4ZBXov17l4M7vBu
	 ksYiSluT2LDzkvRlej+km3DnaoRe3pbMgGhczbwVj7YRzPhJThcvQ2ZzYda8D5XBK1
	 7fmISQXTcC8CFs4hHIgqCBd+LXXJDOsyjpQojleIO6VfzRtjKCP3uIMUjpAFxEC4VZ
	 247PkZEUiIuCA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/5] NFSD: Shorten CB_OFFLOAD response to NFS4ERR_DELAY
Date: Sat,  1 Mar 2025 13:31:48 -0500
Message-ID: <20250301183151.11362-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250301183151.11362-1-cel@kernel.org>
References: <20250301183151.11362-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Try not to prolong the wait for completion of a COPY or COPY_NOTIFY
operation.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9a0e68aa246f..3431b695882d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1712,7 +1712,7 @@ static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
 	switch (task->tk_status) {
 	case -NFS4ERR_DELAY:
 		if (cbo->co_retries--) {
-			rpc_delay(task, 1 * HZ);
+			rpc_delay(task, HZ / 5);
 			return 0;
 		}
 	}
-- 
2.47.0


