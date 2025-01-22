Return-Path: <linux-nfs+bounces-9471-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 768ADA194E4
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 16:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DDC3A30D1
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 15:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB23C211A37;
	Wed, 22 Jan 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnMkk895"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA5014AD3F;
	Wed, 22 Jan 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737559113; cv=none; b=FqNxnps86lKsTn3MhRC8wUuHblnRJkDazqTz9A9Kd9/J/p/xlFORW94VfPjwYXFwZkV5vqz7KB9w0nA+ORamxW0/pgdqhuJF2C1ugjgl6xi/HufWrUS2TJvvX1lJDAUdN35FIvcHiChw8RZbna++ErRPEHPFNrlNeaOxFJgw3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737559113; c=relaxed/simple;
	bh=UMbOPxewzWa9KPV/AqJ9HveSc+kt7krgmlgy/yy1x0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iVO0h+cqmJx3iWmX+ywQL9AbiunNFIlwmey97h3byN7owh2J4/0WMkx32GEkePGOZOGMX5BLirlolxgXo46KSYKdxuYJGEYB+KJq9TUjHY0LUEIezdURpdeKWLzN8hVwoEZzcO6LMoBHNQgC7/ZNi7GStV/vqkqtzXn40eNMEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnMkk895; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6D4C4CED2;
	Wed, 22 Jan 2025 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737559113;
	bh=UMbOPxewzWa9KPV/AqJ9HveSc+kt7krgmlgy/yy1x0w=;
	h=From:Date:Subject:To:Cc:From;
	b=cnMkk895nXhkzNaoX/kIhwWy1oiehi4b3QIuo4xlyCMJLkpT4FY/WsGvYctX8n3dC
	 c1m5I01zsj3iyI8L3gHYXQPjslfmsUNQMupdnwZvHxwC+vsyKvHrUaX+fuAN552eVs
	 1202cn6K/WNrhLN6H5KmqR1qTarj24SuKqkiBFwzJkvMT7w04qBzSlW07hlsvM+CFy
	 01IIVYOB2PffrldURdeGh9JkeLHo1WBKd+EF2K+cKoDMVksgMWA6COR0KWT8oY7mv/
	 f4FYstoaDqE8cA8mTn2BV0rtqjofNOsPS/MEv+nb9ezKUas8Qeg8iBwsIhrqF3Aid0
	 iyvIebaXwpk6Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 22 Jan 2025 10:18:12 -0500
Subject: [PATCH v2] sunrpc: add netns inum and srcaddr to debugfs rpc_xprt
 info
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-nfs-6-14-v2-1-be41324fe579@kernel.org>
X-B4-Tracking: v=1; b=H4sIADMMkWcC/22MywrDIBBFfyXMulN8RIWu+h8hC23GRFq0aJGW4
 L/XZl3u6lwOZ4dCOVCBy7BDphpKSLGDOA1w22xcCcPSGQQTinEhMPqCGvmIxhtpFnJaKg1df2b
 y4X2kprnzFsor5c9Rrvz3/olUjn16dMwpa6Vk1zvlSI9zyivMrbUvnSCugqEAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=UMbOPxewzWa9KPV/AqJ9HveSc+kt7krgmlgy/yy1x0w=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnkQxHAwsvE5RI8dumi9ZidYjT9h571nLGBeEWw
 wH2vot0ZdaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5EMRwAKCRAADmhBGVaC
 FQOGD/9zIsXOTrRPoZr+I+smCvxLNoY3QfhouiD1z2RoX3rxp9shMtvbhkKpvMjtxx70ONccwX9
 KH1B1caZ7ZCGqsXreIc8rGOc6sHv9l/LJoz3/uPBZZAaAiIUmHFbNMCamvEl3GilxAoI8YAbckX
 Xfhat7JYH6wwR+FQhDxW+t482a+7efNGhJm+vVuwdKm7dNFi8CN3jiRCtX/b23R2QfIefVJ0DHD
 Lmzk52TSWw6seQOGzqMoCvZUX6XAnnZ83vKiC4NxSmAcjnqCafbrRG4d1ghfPrhzR6GkXFscFeU
 QqU6XpjJax1WQfQlbn6EwoXzWaWvHtS3mpUWJjVoFmxFEdgnbDZe8gjmLdcVV61aRoLpwj80efD
 +FEIGYF/bFUjYD/A+IPne4RnCW+1nbqZmL1H2M50bWBTKQvNmcU0/w17FuENXkm53NhnLLy11ws
 mYVIJsOsn0UoUxwu90vP2UlIzSW70X6UeRHDjBpqm3k8ybNLePYSoDmcPPAUM9D0Q7FBdajXxYK
 bMwBuHWpj29FIjmEh1inKFQzbn1AohSMeejreue+5FUrMnZjyPhocl3Agr8h7KI9A4YoYSO1nFQ
 qady+exmXAaBIFfQh9CPlyb7v9sr7WYyK6JQgGpfLrBHwdMc/4MrUUFfDnHh+ot00elHGbnDh+3
 3rcX5QhZ+UGIK2A==
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
client tree.
---
Changes in v2:
- Don't bother with NUL termination, just use a length specifier
- Link to v1: https://lore.kernel.org/r/20250122-nfs-6-14-v1-1-164b0b5aa330@kernel.org
---
 net/sunrpc/debugfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index a176d5a0b0ee9a2c0ca1d1ed3131b67b782c3296..9498f385716d5eab1c5766a2a4ef5218155432e0 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -179,6 +179,18 @@ xprt_info_show(struct seq_file *f, void *v)
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
+		if (ret < 0)
+			ret = sprintf(buf, "<closed>");
+		seq_printf(f, "saddr: %.*s\n", ret, buf);
+	}
 	return 0;
 }
 

---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250122-nfs-6-14-7f737deb6356

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


