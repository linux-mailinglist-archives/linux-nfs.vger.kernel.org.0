Return-Path: <linux-nfs+bounces-21541-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD8dD75xA2q55wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21541-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:30:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EFE527A88
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 939A532F0637
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A734E744;
	Tue, 12 May 2026 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBYPr1/F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5390236B043
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609641; cv=none; b=Vx5iJA92tivu6DqJhGfcbhtCcTwSEhhqwE9uJuGP0R8VDBXj+6xAq27WurWXCFHa2XwwPdUA6xCPZCsAi1JJY8IIgM8LgIHr1ySQXk7JzRmFTPvBc+Gf/FL3j5mV32EG6mE6QihFm9IgXV5ZJCpJrLVJGlRpT2fOREyPxcuwXWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609641; c=relaxed/simple;
	bh=R2+oHWRZ/4D8W57D/BcCa+FvL4+JYRieOJDjrvEpoBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRrOLKMMJoAiy54ZEEBneBOOqx5aPoLbtqd7y0qH3s3VYDws/2UIq7LAzBdgtB/yQ5dvLNPpiXqHm5sajD6evxb8WJBSSOIGG0qWkth1YiDtibRYr8s+MAoHR22IxahPhvrz+th+1sXb9OcfYH+glh38CddrVOL+gw1tEols1GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBYPr1/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909BFC2BCFA;
	Tue, 12 May 2026 18:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609641;
	bh=R2+oHWRZ/4D8W57D/BcCa+FvL4+JYRieOJDjrvEpoBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RBYPr1/FeQ2WNP+6/wY/yNUsDmwsAV6s68J7587xF9ybdoUUe4WepbJq+UqUCw5ZF
	 IebXAZp/Bdum0f+2ozCSngQaXDX/2G0bqatycrnYcTtLCtZSSHo/x4n3Y0f0lGr9RV
	 LxGPqyuuF6A+Wj/dsMeSZdNp5HHEvQ4MA9Pt01upNwwDuBjNExwGPp7nPOudKhJjFo
	 SDt8vIlRXmhcdTZ0Jz8LQEJssYbFd2IbQmAOY6l50e4KBKDRKAhIwX6gYVX+KsHtUj
	 Bt/Skb0HgU4aCcQZZkQ/GqtYkmjIaKjyPV8wSK/0Mg1yhazqm4qxN9LhFC1B115xEH
	 diMzAjS9huMjA==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:36 -0400
Subject: [PATCH 01/38] lockd: Stop warning on nlm__int__drop_reply in !V4
 cast_status
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-1-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=SjBmTgAqft3LXVNwZu2/+QFiRWe1el8+7FDYnarGMHI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23jq2qrz71aRJmJotd5lyFxAI+MWk8+T+/bJ
 zxzwvBJiv+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt4wAKCRAzarMzb2Z/
 lysLEACkzX5c03azRNIcwHQbe8O4diCANSHyqPLZK+uJlFlKiLARAYnWijup1NccZIBc6sEqK73
 n2lUPHd64QXHpIeLUPmdnY4saq7x7d/ZiJ+MuQGJy/Qa2Gl6yBnbgXapJADplkR6pl6A6uVJwva
 iYe8HzTOMYsomPBss25U94uVyVZZbLfoHhZXCC9P6L2wrS/rximR3bpV9WCXwYxYtcUbRrTRwxu
 wXCCN6vYaBrlPZkUQ4snBvoNzgUIwNa92nOfulM6kEnp3eMWvIqFG4SBA3zEsvLxczbhSLAS0O6
 ynTAblvVWeSOmQP8arjGwToTR7hbMXTxKKMoRac1e2NUcJh9tOwzT7Z3uT4TFXuoF5InU5pJJIp
 b3XmqitANEV4viFucntkYLof2VttE9ZJTW3S0ag6gXmWbRoff3/ZhKYIOY2qH+vgQW6wWfYalNa
 tj8Btll13uBCFNq7X2GoMGPC0yuI8R8ph8hSVWH5t6lQhkbznDwku9n0ZFtVL03pD2ZwgQk+fVM
 Jb47acg2HoSsO56gwKf2eV13NbPTlGhR5dJFYbG81/oF6qRNjqV3ayVSMsoA7B2OBYFtgiKk/rf
 oPyVRdp+b0LPavunEFLyFnaIxLFitF/XBD14z6ru0jCFoOO8H+Wpf15j9+pAd7Rs82QZzhTraxP
 qDRLpfyQDL2U2nA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: D9EFE527A88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21541-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

cast_status folds internal lock-daemon sentinels into NLMv1/v3
wire status codes.  The !CONFIG_LOCKD_V4 variant warns when an
unrecognized status falls into the internal-sentinel range,
gated by be32_to_cpu(status) >= 30000.

nlm__int__drop_reply is defined as cpu_to_be32(30000), so it
sits at the lower edge of that range and trips pr_warn_once
("lockd: unhandled internal status %u").  The status is
returned unchanged so the reply is still dropped, but every
dropped reply on a !CONFIG_LOCKD_V4 build emits a spurious
warning.

Compare against nlm__int__drop_reply directly so the warning
still catches the genuinely unexpected sentinels deadlock,
stale_fh, and failed (30001 through 30003) but excludes the
legitimate dropped-reply marker.

Fixes: d343fce148a4 ("[PATCH] knfsd: Allow lockd to drop replies as appropriate")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index c0a3487719e2..110e186802b6 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -49,7 +49,7 @@ static inline __be32 cast_status(__be32 status)
 		status = nlm_lck_denied_nolocks;
 		break;
 	default:
-		if (be32_to_cpu(status) >= 30000)
+		if (be32_to_cpu(status) > be32_to_cpu(nlm__int__drop_reply))
 			pr_warn_once("lockd: unhandled internal status %u\n",
 				     be32_to_cpu(status));
 		break;

-- 
2.54.0


