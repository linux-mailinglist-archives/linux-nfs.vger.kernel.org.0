Return-Path: <linux-nfs+bounces-9877-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 375EDA28C20
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 14:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966423A121B
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 13:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06C813B5B6;
	Wed,  5 Feb 2025 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6ncJ5B1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963FD126C16;
	Wed,  5 Feb 2025 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763040; cv=none; b=Ry7Y+AW3Pxf0lDamEgNyZ+wq8cT9shR4Kku0p6gffUQg8e2R8hQrpUJpPPNOaU/YB6xoerQS/ZjKH5JRrxQDnpZij8l5k4vez2v2kWFpMc/wMFAGjTP5FNXxyeXvUIcpDEnq9Wb9JcHrPAsjFHzqJVTkFwRRRYvWMu9HraX8s4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763040; c=relaxed/simple;
	bh=8QWgHWjdj9HTgfaEoItcX74VRFkbt8qSiH7IrFQ3zVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h98jlG5djFs46KHP/9+aRfzJncym3PO8Dj6b4PL2FV8VevBTEkyTJsGn4qisPyiJZUo/7duiT4O3Kbc6St3x0FXVMVmWAKofa0JYbfoU14FsX6L8+hyqS8QYT2u198e5nt6WxkwiQPj0p2qD34i+2ZAqozY5Hqi3RwCrQ17FRvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6ncJ5B1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E71C4CED1;
	Wed,  5 Feb 2025 13:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738763040;
	bh=8QWgHWjdj9HTgfaEoItcX74VRFkbt8qSiH7IrFQ3zVE=;
	h=From:Date:Subject:To:Cc:From;
	b=u6ncJ5B1gvzEZOpW0OikBPaSEFkvM8ai65cnWSAazzOKl6rBK1Y6kM9yAsgg+7Gh0
	 3pH8rp3kqqP8w21lN/fs+mN4/VguOwStHsm46WZ7/mUoPIPjjXNHdA5HCOMTrho/3G
	 gnvCCKe6rbwJdsWYLWbsYf0H/XuWlQrux4mlbqt/ZMp91U6P/qTLVYRhwFqnZHyXDP
	 qffgyVrCnIIZZ5JQegqiL9ASpLv5xgtJeuWkroXWMZr5xLHc1lofM89zN1fVknGPZ7
	 IWdiLc4fhUzq5s2M9veLG5Eg68OfS+lRbFgH+Qm/0VdYwgCel7oe1P+1lM8044uU3v
	 ECSDBABtr8/kA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 05 Feb 2025 08:43:48 -0500
Subject: [PATCH RESEND v2] sunrpc: add netns inum and srcaddr to debugfs
 rpc_xprt info
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-nfs-6-14-v2-1-402e8072661f@kernel.org>
X-B4-Tracking: v=1; b=H4sIABNro2cC/3WNPQvCMBCG/0rJbCS5fKGTg10ddBSHxl7aoKSSS
 FBK/7shm4jc9N57z3MzSRg9JrJtZhIx++SnUAKsGnIduzAg9X3JBBgoxgFocIlqyiU1zgjTo9V
 CaVLOHxGdf1XVmRzbU3vYk0vZjz49p/iuHzKv7a8sc1pGS8us6joh2O6GMeB9PcWhWjL8I6GQF
 iUXIB0qs/kil2X5ANUhv1rjAAAA
X-Change-ID: 20250122-nfs-6-14-7f737deb6356
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=8QWgHWjdj9HTgfaEoItcX74VRFkbt8qSiH7IrFQ3zVE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBno2sejwdzHOEp4tQHehOb8zoWBTni3qZNjKieY
 bO3vTS++caJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6NrHgAKCRAADmhBGVaC
 FQXVEACCkPLx0opKSxVbwXTJuMcdwuhXQTVBmg4Od/XJB7G8kJ7XiR1MNOzBoszZMYWP0yLVBRx
 7lDZL2Xvw4qooF71p2FVnXFfuRWh9z26b3HCMkt2hG9kYfEiWbfqusOKWB2zLX0cbIAZMcciMWu
 LMJtwngHadw7iJzoqvfuEZTZIGrExqAehx4EIA/Jp9SdbUpasRTTjrEROUaw7vQXRw2UiuYksLW
 a1DQFy29zAwmzaHKyR1ahhtyCMJvEn01oAzNJUiPfk3eMhwIFnQD3DvnVrfHy72dHS3S9p0eIvz
 rWCdJSpSt0sBpwUBzF7f3xV8VcTULTG2A9QjH94elnt2UbdzPzTPYZmYtjm7cU6pXeVo8lMjzlF
 gRDgct05AXl8FUj0hkKOrsbU0cqawH/bQTLd2kNU7sjw9AhFFeI5Sw1ep25bFfOqKHGhOvAcg7V
 x6nZEbpjqg+DUnLgHgdqsvrMQVV6Sz3Dn5sS3DkmSanHayhoWY+5HVHqQVPwtu4A/dhdfzeO622
 l7mXPvarcyln0cAiMu8QqaSQ4j0SPc8CmnbJX5qByWY8NgfXy8ikfSBxIPYE8m630IiHksATCDA
 sjBr74caIKMIDZKd5ZmQSnEP7SK3h9gvZ9brG9z6tbDwe55fAnfPhfcSc5hyPVimWTymB/RN/zo
 QZXEvY0DESFtdSg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The output format should provide a value that matches the one in
the /proc/<pid>/ns/net symlink. This makes it simpler to match the
rpc_xprt and rpc_clnt to a particular container.

Also, when the xprt defines the get_srcaddr operation, use that to
display the source address as well.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
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


