Return-Path: <linux-nfs+bounces-9466-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCAEA19477
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 15:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005517A2C80
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB48214219;
	Wed, 22 Jan 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM7Q5tBd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D37211712;
	Wed, 22 Jan 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737557963; cv=none; b=H176gwrtuN1/l8JK7YNAGMFY06ouXzofnCrMeIrrWFpKuQ5/TZoZc2yfmKa6zn5lygXM4pRBH8bUzRfND5GQYWgS4Qyrxtn4qB3YZOgsfJC4Ag9LBhM6U3AcBCm+FAzM9OizqBPWysy5b/gp/18w3krTZvpwEL450ERnI+M8qzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737557963; c=relaxed/simple;
	bh=c6nwRLk/ehaOCxcKDXFXDOxPoKD5idgpD7Lx+jfeLUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uOV0+swdcO5CLPpsfAWWAGWyNqi3uCPJTYcqBSLHCXgrj9THMdDF8YAu1g6Bu/sY+DjlhbRQxiRjmvUs6EfqRxW3u2D/vA500vZTVO3QAaviAtdK6HCVOp1Aew5NTer9MeV/XxcjN6qygrFIQs/iGsNOtryG0PITqK5uOQjWl0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM7Q5tBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCD1C4CED2;
	Wed, 22 Jan 2025 14:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737557962;
	bh=c6nwRLk/ehaOCxcKDXFXDOxPoKD5idgpD7Lx+jfeLUM=;
	h=From:Date:Subject:To:Cc:From;
	b=RM7Q5tBd/dLszol2K96sHGTGWwEZgwNyHt12baL1j0+08mLCsJVNRzo8U6V9J5+u0
	 YakeMj7eq2N8y+E9419ySwk17pBMuJNjoKCyMmNXFlfvuefAMbH1d7E6oyPcRUfoAT
	 pAvtduwQyzgFU49Q0oM9pgOSK+7kTckfWMavNtBatKJctymCAKurjppXACWBUVBjck
	 Xjdd4dvEONFTVmCYAiocu99J1JTwqYSB6qcA0eTz93RYq7j4S3MB8C+zWjHehlXOig
	 0juRCMIp+0b4rAvJBHRmqRqDHGIwB955VNVLWNhyCODOWg39O02WgeO9bpIss0TqHk
	 31Nz5YeP/MmTg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 22 Jan 2025 09:59:17 -0500
Subject: [PATCH] sunrpc: add netns inum and srcaddr to debugfs rpc_xprt
 info
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-nfs-6-14-v1-1-164b0b5aa330@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMQHkWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyMj3by0Yl0zXUMTXfM0c2PzlNQkM2NTMyWg8oKi1LTMCrBR0bG1tQC
 TqNzFWgAAAA==
X-Change-ID: 20250122-nfs-6-14-7f737deb6356
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=c6nwRLk/ehaOCxcKDXFXDOxPoKD5idgpD7Lx+jfeLUM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnkQfJ9To4FYE3jMTHQiHRtMZXCApL4M2HWSbvi
 OLp073zk3aJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5EHyQAKCRAADmhBGVaC
 Fb6eD/9ynCH6WFt3Gma2DvE1r5+rt4NMlryUPlYMIirXAA4LNO0IMLcJwA7zcuycIytq2BqGgBk
 VAITZJFX9k0AfoLWOByz781rP50BhV382VDTpZz7+888ig8Jc/tewwxhlCCMBFeHFMb61dXzzF+
 N+L1FkXd+0TeBxtMuppAwo45JnPWC7rBJ9f7CdDdmf3h4eeLovWUuJhhV2+ZhQCiT67dbeUw7oM
 oxTdnTF3f6CWyaUOhMElHyULEPi49LyxKcmeoRoZxx+7XPg+hHtswqa/jJ1tv7JHIjL+WFyHnN6
 lPb/ZMjitd25BwIGeEuTkCccJA/0MQv38wWneWNWX5RwRwNKVxDvkbvgLmDZSRfxvxApEM4EoRd
 rPJG+Ut7K5OqYb6XGUl45xYMNjUv+1YBK6sA2YUJDl9W5VG/+tw8at95TCbjoOtqEjPuKmM/8Hw
 Zqqr3fH8nKRmDTOKzukpP2Yv9bcYO7c71OX/sthanoypAIUWgzyLDTmqyuAQl3t0s71jrOXrbsD
 Pt6sOAFI5swwHznDYsHpUBr+q4aGYa325D3FBN/NltWAWy85mAYOjNDrX5TVRy9IIlQz9prw8js
 YDzrVBqwnjjS99APpiTuKvoZdc/9Xdlwv3xSCh45lvZ7d8Tpwtk3ttgtmL36/P7aN7ak/GuLEHu
 j0fB+vweC/Q3TCA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The output format should provide a value that matches the one in
the /proc/<pid>/ns/net symlink. This makes it simpler to match the
rpc_xprt and rpc_clnt to a particular container.

Also, when the xprt defines the get_srcaddr operation, use that to
display the source address as well.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This is more client-side code, so I figure this should go in via the NFS
client tree, but if Chuck would rather pick it up, then that's fine too.
---
 net/sunrpc/debugfs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index a176d5a0b0ee9a2c0ca1d1ed3131b67b782c3296..3b39493234d7079ff762a862bdd51725f36472dc 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -179,6 +179,22 @@ xprt_info_show(struct seq_file *f, void *v)
 	seq_printf(f, "addr:  %s\n", xprt->address_strings[RPC_DISPLAY_ADDR]);
 	seq_printf(f, "port:  %s\n", xprt->address_strings[RPC_DISPLAY_PORT]);
 	seq_printf(f, "state: 0x%lx\n", xprt->state);
+	seq_printf(f, "netns: %u\n", xprt->xprt_net->ns.inum);
+
+	if (xprt->ops->get_srcaddr) {
+		int ret, buflen;
+		char buf[INET6_ADDRSTRLEN];
+
+		buflen = ARRAY_SIZE(buf);
+		ret = xprt->ops->get_srcaddr(xprt, buf, buflen);
+		if (ret > 0) {
+			if (ret < buflen - 1)
+				buf[ret] = '\0';
+		} else {
+			ret = sprintf(buf, "<closed>");
+		}
+		seq_printf(f, "saddr: %s\n", buf);
+	}
 	return 0;
 }
 

---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250122-nfs-6-14-7f737deb6356

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


