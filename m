Return-Path: <linux-nfs+bounces-20735-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MPrIMFM1ml8DQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20735-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:40:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE7B3BC4A8
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1F6D30FA854
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9B23CB2F7;
	Wed,  8 Apr 2026 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDHT8w1+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D23CA4BD;
	Wed,  8 Apr 2026 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651414; cv=none; b=kvWMAwxdQZcn+kkXEVIz4d8AJ/1CsbMsAO3E+CHA+AJa0iOLC5dyCs6NDVZaNh5BCgUE04FyOaoOifpjbNNXy4JsFo0d+cjeR8PWGpTaEB+1LfyzQv8DVl9RCfQN8CcdhB9KL2CTQJMzILHIPUVpgnt10QJBdvFTVE8cw20qLTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651414; c=relaxed/simple;
	bh=Uhj/8f6FRa0X48xFSViYJFr18UqOly5fNpXgvimQfyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p+Iclqt24kGzc1FbIAZgYoqnPE4vJYcxsMqgiMkuJBMTEHS5FSsC9DELn8YtUopDNZT7pSyyXeU1fJB5BSi6TFAfjq9UWQyMPnZgPz4eeW9lG9hMHohIe7SkmEn4u6/jWOKOd9VMEXJvKeIhvJaS/Q1UtSvHGPij5ykbwTRFQQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDHT8w1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34959C2BCB1;
	Wed,  8 Apr 2026 12:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775651413;
	bh=Uhj/8f6FRa0X48xFSViYJFr18UqOly5fNpXgvimQfyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GDHT8w1++cgYrjPGY9LxLD33wbnb1USFs+7YI9ucl2lyFZKbNczNC9K7PPlZBSj77
	 knVz6UL1/A6yzoQ+D7FhoF7KHxu1GzOBf8GIEY0b8gGEsOlA/7j4/BbB9rNDdGdAbR
	 tVGuFVxUwwrOHfVZz/Elw9AmBqeU6rUsALKxQZDEyAj2FLug4jA08XnwlRVWnK9oQb
	 87f8H4zeBEskbXFgCL6Jd294kN+LftRCxDyKDIC6CClGhdbUMLr4i1X0/I/wUWD6oU
	 CrrC62SSziumNk+1UbPNQ7FTGIaR6hdbD78RGoEHumM+0Y1ubfMBPj6ZFbCs9UrJqg
	 9Dpf0MRwTOoUw==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 08 Apr 2026 08:29:56 -0400
Subject: [PATCH v8 6/9] NFSD: Replace idr_for_each_entry_ul in
 find_one_sb_stid()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-umount-kills-nfsv4-state-v8-6-6e02a1d03d60@oracle.com>
References: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
In-Reply-To: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=gFq6w2SMcg/HDr83bDGzOlzwepA7RPvucQexOAGIZbA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp1kpPitqleMEpJnz48VTLPp0DlKKfH4/uFQESM
 DprGtTHdDeJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCadZKTwAKCRAzarMzb2Z/
 l7NmD/91n3eq7ybNDKQyZMIrIkVIseb8QhJLHln90ik0RkQL5MGTKorG07DQaprxDEqqSVjcRHx
 e2chZdAL0Vk6XVzmpMyPqmxAEgitjoHk4fthdnRuMgFUg2eRZ1F4MaKb1HceXS/Cht4CYr8OS0n
 vKlHqAWFwDO8iX9og5i4c7hUXCggjfFrtxqEkzSxNPMW6fzf/YYEi3eLrV2n5Wa2/NG1xVAHPdx
 VP0X2cVfygkEtRwRtlNRznxK5sHS5nVEc8tp18ryBwX6cS9BhzWvLw+rOeBzfafHZURkobZZeBG
 odJm0WbILs2H1L01iHMA44IqHitFOalCvHYXNj6+4eWceqsTiSrVk4r/zOkv5UpS7IzmmuXz4BH
 2XCF/kUe8u8WANGkO5ro3rNiAwAUl4h1+EjgxJwiVkHx48lBCxQCg09Auee6NRk5TDkEBWXwgPz
 /FbwsAUC8IqYiThlxY/FE1B2fr7O273/3GW9jimXqVFED5tam4fTuVS+MUnXxdxcWy+xz9w7ajw
 +Y1wlx7r16ZOeIOunxM7rc3FXkYuAuksANQAsPXhwjbP2mgc+AfPg8ZUjZXZHqyDhU4h22cLlCn
 eU2xHGkPH0Vp7n72rGoaLZkKdT1GGCO7rLyuofbubWQFBgdfLMlq7JBGh7Ajh+nCyFMJgGyeQjz
 ojWuH8ICYyGpFXA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20735-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 3CE7B3BC4A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Replace idr_for_each_entry_ul() with a while loop over
idr_get_next_ul() for consistency with find_one_export_stid(),
added in a subsequent commit.

No change in behavior.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b095b1beaac0..1478ff741b79 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1760,17 +1760,19 @@ static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
 					  struct super_block *sb,
 					  unsigned int sc_types)
 {
-	unsigned long id, tmp;
+	unsigned long id = 0;
 	struct nfs4_stid *stid;
 
 	spin_lock(&clp->cl_lock);
-	idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
+	while ((stid = idr_get_next_ul(&clp->cl_stateids, &id)) != NULL) {
 		if ((stid->sc_type & sc_types) &&
 		    stid->sc_status == 0 &&
 		    stid->sc_file->fi_inode->i_sb == sb) {
 			refcount_inc(&stid->sc_count);
 			break;
 		}
+		id++;
+	}
 	spin_unlock(&clp->cl_lock);
 	return stid;
 }

-- 
2.53.0


