Return-Path: <linux-nfs+bounces-16627-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 007BDC75C92
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 18:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id AA8402BDBE
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 17:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34D12FD67C;
	Thu, 20 Nov 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="vn12iGhp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23822F8BC0;
	Thu, 20 Nov 2025 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660881; cv=none; b=HX3NdocmBbLWjCiqlwZsyQG1utWFBMH9w3FzCmvHyX6aWeAGXztp9ji7Faw92fwVl4A6PQanfin43I0sV0Q0EcGuQ6Z6XEQ6fp7tq118x0P3ioGusoiZPEhvVxwp4BnX/NaETd+Avovulp+gPvY7As8iSELIe1gvEPbFa2leaRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660881; c=relaxed/simple;
	bh=Ilm5qDrtGnxZNbqD7nazjsxJcRprIIZ6zvJUldHh9V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfnLBrST9h79FQuVLaOXe8r/IhFdT4ybZzkLQmrkyn6EgULq6N8MMs4S6e0ZC+M4pQ2VGz8yeQAd51Z/GoGUyL/ofYioxToEb76sTTLD2AzAnREp9mrsYIUiypOLEqezvDQcXpTkqeAF5fAQnWtVMYrkfqvFBZjnEu+IykmCLmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=vn12iGhp; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1763660872;
	bh=Ilm5qDrtGnxZNbqD7nazjsxJcRprIIZ6zvJUldHh9V4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vn12iGhpkpsC+nTnpoQSAYhOMOF/LrWL5OtqO9ZtvZf1YQsj+ZdWMtqxwx2Ywq7oa
	 Hyf2Dz+fGzBwL7N0rYgYI4Tz2zwhY5VHdzwft4a2gfnmp8rD1FQ3df9I8/cTUAi+9K
	 G38ITwVURG9VkQrVTL+koAYvU79yNMtElav/SLLf6aBio4WTYueoVu+Iap8dbmNikL
	 0oy53DzdqxnLnGLnifwdTXU1OL1+5CMhwXpSbsq+VVapAK3FBLJmH+TBFcTGnLf2T2
	 ckIu9osSSkSQWzhgwvQyb5HozS2J0M0HqncGgYnQuXRUoRRsz/6NjNdDBF9UGY4DYg
	 yvnrHpVCkwbzg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 26959600FC;
	Thu, 20 Nov 2025 17:46:25 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 621FB204000; Thu, 20 Nov 2025 17:45:08 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Anna Schumaker <anna@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Carlos Llamas <cmllamas@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Wei <dw@davidwei.uk>,
	Eric Dumazet <edumazet@google.com>,
	Geliang Tang <geliang@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Joe Damato <jdamato@fastly.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	kernel-tls-handshake@lists.linux.dev,
	Li Li <dualli@google.com>,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Martijn Coenen <maco@android.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	mptcp@lists.linux.dev,
	NeilBrown <neil@brown.name>,
	netdev@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Samiullah Khawaja <skhawaja@google.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Suren Baghdasaryan <surenb@google.com>,
	Todd Kjos <tkjos@android.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 2/2] tools: ynl-gen: add regeneration comment
Date: Thu, 20 Nov 2025 17:44:27 +0000
Message-ID: <20251120174429.390574-3-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120174429.390574-1-ast@fiberby.net>
References: <20251120174429.390574-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a comment on regeneration to the generated files.

The comment is placed after the YNL-GEN line[1], as to not interfere
with ynl-regen.sh's detection logic.

[1] and after the optional YNL-ARG line.

Link: https://lore.kernel.org/r/aR5m174O7pklKrMR@zx2c4.com/
Suggested-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/android/binder_netlink.c               | 1 +
 drivers/android/binder_netlink.h               | 1 +
 drivers/dpll/dpll_nl.c                         | 1 +
 drivers/dpll/dpll_nl.h                         | 1 +
 drivers/net/ovpn/netlink-gen.c                 | 1 +
 drivers/net/ovpn/netlink-gen.h                 | 1 +
 drivers/net/team/team_nl.c                     | 1 +
 drivers/net/team/team_nl.h                     | 1 +
 fs/lockd/netlink.c                             | 1 +
 fs/lockd/netlink.h                             | 1 +
 fs/nfsd/netlink.c                              | 1 +
 fs/nfsd/netlink.h                              | 1 +
 include/uapi/linux/android/binder_netlink.h    | 1 +
 include/uapi/linux/dpll.h                      | 1 +
 include/uapi/linux/ethtool_netlink_generated.h | 1 +
 include/uapi/linux/fou.h                       | 1 +
 include/uapi/linux/handshake.h                 | 1 +
 include/uapi/linux/if_team.h                   | 1 +
 include/uapi/linux/lockd_netlink.h             | 1 +
 include/uapi/linux/mptcp_pm.h                  | 1 +
 include/uapi/linux/net_shaper.h                | 1 +
 include/uapi/linux/netdev.h                    | 1 +
 include/uapi/linux/nfsd_netlink.h              | 1 +
 include/uapi/linux/ovpn.h                      | 1 +
 include/uapi/linux/psp.h                       | 1 +
 net/core/netdev-genl-gen.c                     | 1 +
 net/core/netdev-genl-gen.h                     | 1 +
 net/devlink/netlink_gen.c                      | 1 +
 net/devlink/netlink_gen.h                      | 1 +
 net/handshake/genl.c                           | 1 +
 net/handshake/genl.h                           | 1 +
 net/ipv4/fou_nl.c                              | 1 +
 net/ipv4/fou_nl.h                              | 1 +
 net/mptcp/mptcp_pm_gen.c                       | 1 +
 net/mptcp/mptcp_pm_gen.h                       | 1 +
 net/psp/psp-nl-gen.c                           | 1 +
 net/psp/psp-nl-gen.h                           | 1 +
 net/shaper/shaper_nl_gen.c                     | 1 +
 net/shaper/shaper_nl_gen.h                     | 1 +
 tools/include/uapi/linux/netdev.h              | 1 +
 tools/net/ynl/pyynl/ynl_gen_c.py               | 1 +
 41 files changed, 41 insertions(+)

diff --git a/drivers/android/binder_netlink.c b/drivers/android/binder_netlink.c
index d05397a50ca6..81e8432b5904 100644
--- a/drivers/android/binder_netlink.c
+++ b/drivers/android/binder_netlink.c
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/binder.yaml */
 /* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
diff --git a/drivers/android/binder_netlink.h b/drivers/android/binder_netlink.h
index 882c7a6b537e..57399942a5e3 100644
--- a/drivers/android/binder_netlink.h
+++ b/drivers/android/binder_netlink.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/binder.yaml */
 /* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _LINUX_BINDER_GEN_H
 #define _LINUX_BINDER_GEN_H
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index 3c6d570babf8..36d11ff195df 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/dpll.yaml */
 /* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
diff --git a/drivers/dpll/dpll_nl.h b/drivers/dpll/dpll_nl.h
index 3da10cfe9a6e..7419679b6977 100644
--- a/drivers/dpll/dpll_nl.h
+++ b/drivers/dpll/dpll_nl.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/dpll.yaml */
 /* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _LINUX_DPLL_GEN_H
 #define _LINUX_DPLL_GEN_H
diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
index 14298188c5f1..ecbe9dcf4f7d 100644
--- a/drivers/net/ovpn/netlink-gen.c
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/ovpn.yaml */
 /* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
diff --git a/drivers/net/ovpn/netlink-gen.h b/drivers/net/ovpn/netlink-gen.h
index 220b5b2fdd4f..b2301580770f 100644
--- a/drivers/net/ovpn/netlink-gen.h
+++ b/drivers/net/ovpn/netlink-gen.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/ovpn.yaml */
 /* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _LINUX_OVPN_GEN_H
 #define _LINUX_OVPN_GEN_H
diff --git a/drivers/net/team/team_nl.c b/drivers/net/team/team_nl.c
index 208424ab78f5..6db21725f9cc 100644
--- a/drivers/net/team/team_nl.c
+++ b/drivers/net/team/team_nl.c
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/team.yaml */
 /* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
diff --git a/drivers/net/team/team_nl.h b/drivers/net/team/team_nl.h
index c9ec1b22ac4d..74816b193475 100644
--- a/drivers/net/team/team_nl.h
+++ b/drivers/net/team/team_nl.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/team.yaml */
 /* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _LINUX_TEAM_GEN_H
 #define _LINUX_TEAM_GEN_H
diff --git a/fs/lockd/netlink.c b/fs/lockd/netlink.c
index 6e00b02cad90..880c42b4f8c3 100644
--- a/fs/lockd/netlink.c
+++ b/fs/lockd/netlink.c
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/lockd.yaml */
 /* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
diff --git a/fs/lockd/netlink.h b/fs/lockd/netlink.h
index 1920543a7955..d8408f077dd8 100644
--- a/fs/lockd/netlink.h
+++ b/fs/lockd/netlink.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/lockd.yaml */
 /* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _LINUX_LOCKD_GEN_H
 #define _LINUX_LOCKD_GEN_H
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index ca54aa583530..ac51a44e1065 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/nfsd.yaml */
 /* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index 8eb903f24c41..478117ff6b8c 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/nfsd.yaml */
 /* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _LINUX_NFSD_GEN_H
 #define _LINUX_NFSD_GEN_H
diff --git a/include/uapi/linux/android/binder_netlink.h b/include/uapi/linux/android/binder_netlink.h
index b218f96d6668..bf69833c9a19 100644
--- a/include/uapi/linux/android/binder_netlink.h
+++ b/include/uapi/linux/android/binder_netlink.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/binder.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_ANDROID_BINDER_NETLINK_H
 #define _UAPI_LINUX_ANDROID_BINDER_NETLINK_H
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index 69d35570ac4f..b7ff9c44f9aa 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/dpll.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_DPLL_H
 #define _UAPI_LINUX_DPLL_H
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index b71b175df46d..556a0c834df5 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/ethtool.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_ETHTOOL_NETLINK_GENERATED_H
 #define _UAPI_LINUX_ETHTOOL_NETLINK_GENERATED_H
diff --git a/include/uapi/linux/fou.h b/include/uapi/linux/fou.h
index b5cd3e7b3775..bb6bef74d2d1 100644
--- a/include/uapi/linux/fou.h
+++ b/include/uapi/linux/fou.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/fou.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_FOU_H
 #define _UAPI_LINUX_FOU_H
diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
index 662e7de46c54..d7e40f594888 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/handshake.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_HANDSHAKE_H
 #define _UAPI_LINUX_HANDSHAKE_H
diff --git a/include/uapi/linux/if_team.h b/include/uapi/linux/if_team.h
index a5c06243a435..f4cd839ae725 100644
--- a/include/uapi/linux/if_team.h
+++ b/include/uapi/linux/if_team.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/team.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_IF_TEAM_H
 #define _UAPI_LINUX_IF_TEAM_H
diff --git a/include/uapi/linux/lockd_netlink.h b/include/uapi/linux/lockd_netlink.h
index 21c65aec3bc6..2d766a0fa6ea 100644
--- a/include/uapi/linux/lockd_netlink.h
+++ b/include/uapi/linux/lockd_netlink.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/lockd.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_LOCKD_NETLINK_H
 #define _UAPI_LINUX_LOCKD_NETLINK_H
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index bf44a5cf5b5a..c97d060ee90b 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/mptcp_pm.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_MPTCP_PM_H
 #define _UAPI_LINUX_MPTCP_PM_H
diff --git a/include/uapi/linux/net_shaper.h b/include/uapi/linux/net_shaper.h
index d8834b59f7d7..3dd22c2930d9 100644
--- a/include/uapi/linux/net_shaper.h
+++ b/include/uapi/linux/net_shaper.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/net_shaper.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_NET_SHAPER_H
 #define _UAPI_LINUX_NET_SHAPER_H
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 048c8de1a130..e0b579a1df4f 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/netdev.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_NETDEV_H
 #define _UAPI_LINUX_NETDEV_H
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index 887cbd12b695..e157e2009ea8 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/nfsd.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_NFSD_NETLINK_H
 #define _UAPI_LINUX_NFSD_NETLINK_H
diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
index 680d1522dc87..959b41def61f 100644
--- a/include/uapi/linux/ovpn.h
+++ b/include/uapi/linux/ovpn.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/ovpn.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_OVPN_H
 #define _UAPI_LINUX_OVPN_H
diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
index d8449c043ba1..a3a336488dc3 100644
--- a/include/uapi/linux/psp.h
+++ b/include/uapi/linux/psp.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/psp.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_PSP_H
 #define _UAPI_LINUX_PSP_H
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index ff20435c45d2..ba673e81716f 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/netdev.yaml */
 /* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index cf3fad74511f..cffc08517a41 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/netdev.yaml */
 /* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _LINUX_NETDEV_GEN_H
 #define _LINUX_NETDEV_GEN_H
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 5ad435aee29d..f998a7378381 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/devlink.yaml */
 /* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 09cc6f264ccf..2817d53a0eba 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/devlink.yaml */
 /* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _LINUX_DEVLINK_GEN_H
 #define _LINUX_DEVLINK_GEN_H
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index f55d14d7b726..870612609491 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/handshake.yaml */
 /* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
diff --git a/net/handshake/genl.h b/net/handshake/genl.h
index ae72a596f6cc..8d3e18672daf 100644
--- a/net/handshake/genl.h
+++ b/net/handshake/genl.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/handshake.yaml */
 /* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _LINUX_HANDSHAKE_GEN_H
 #define _LINUX_HANDSHAKE_GEN_H
diff --git a/net/ipv4/fou_nl.c b/net/ipv4/fou_nl.c
index 506260b4a4dc..7a99639204b1 100644
--- a/net/ipv4/fou_nl.c
+++ b/net/ipv4/fou_nl.c
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/fou.yaml */
 /* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
diff --git a/net/ipv4/fou_nl.h b/net/ipv4/fou_nl.h
index 63a6c4ed803d..438342dc8507 100644
--- a/net/ipv4/fou_nl.h
+++ b/net/ipv4/fou_nl.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/fou.yaml */
 /* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _LINUX_FOU_GEN_H
 #define _LINUX_FOU_GEN_H
diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
index dcffd847af33..c180930a8e0e 100644
--- a/net/mptcp/mptcp_pm_gen.c
+++ b/net/mptcp/mptcp_pm_gen.c
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/mptcp_pm.yaml */
 /* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
diff --git a/net/mptcp/mptcp_pm_gen.h b/net/mptcp/mptcp_pm_gen.h
index e24258f6f819..b9280bcb43f5 100644
--- a/net/mptcp/mptcp_pm_gen.h
+++ b/net/mptcp/mptcp_pm_gen.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/mptcp_pm.yaml */
 /* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _LINUX_MPTCP_PM_GEN_H
 #define _LINUX_MPTCP_PM_GEN_H
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 73f8b06d66f0..22a48d0fa378 100644
--- a/net/psp/psp-nl-gen.c
+++ b/net/psp/psp-nl-gen.c
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/psp.yaml */
 /* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
index 5bc3b5d5a53e..599c5f1c82f2 100644
--- a/net/psp/psp-nl-gen.h
+++ b/net/psp/psp-nl-gen.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/psp.yaml */
 /* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _LINUX_PSP_GEN_H
 #define _LINUX_PSP_GEN_H
diff --git a/net/shaper/shaper_nl_gen.c b/net/shaper/shaper_nl_gen.c
index 204c8ae8c7b1..e8cccc4c1180 100644
--- a/net/shaper/shaper_nl_gen.c
+++ b/net/shaper/shaper_nl_gen.c
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/net_shaper.yaml */
 /* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
diff --git a/net/shaper/shaper_nl_gen.h b/net/shaper/shaper_nl_gen.h
index cb7f9026fc23..ec41c90431a4 100644
--- a/net/shaper/shaper_nl_gen.h
+++ b/net/shaper/shaper_nl_gen.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/net_shaper.yaml */
 /* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _LINUX_NET_SHAPER_GEN_H
 #define _LINUX_NET_SHAPER_GEN_H
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 048c8de1a130..e0b579a1df4f 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/netdev.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_NETDEV_H
 #define _UAPI_LINUX_NETDEV_H
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 0dd589e502cb..b517d0c605ad 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -3442,6 +3442,7 @@ def main():
         if args.fn_prefix:
             line += f' --function-prefix {args.fn_prefix}'
         cw.p(f'/* YNL-ARG{line} */')
+    cw.p('/* To regenerate run: tools/net/ynl/ynl-regen.sh */')
     cw.nl()
 
     if args.mode == 'uapi':
-- 
2.51.0


