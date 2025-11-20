Return-Path: <linux-nfs+bounces-16626-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD24C75CB0
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 18:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 565504E038E
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9F42FC011;
	Thu, 20 Nov 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="BbIS2P69"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC95F2F8BF0;
	Thu, 20 Nov 2025 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660880; cv=none; b=BjJ0sYdWyibbLEkX/3MCfOXsvvIKIuimAg2hG8f7fG2ON88h1yAjx6Mea4NMdUHmIxq6UxjAqBgv4ADR50sEpFRVlD1cSLTS5dm+HJ9GLn+HXjhLTnAQX4M/aWD7sUoWBrpMqeTNhp8n6//rCZWnvsv2DwBkI96fYd4IKJXGk6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660880; c=relaxed/simple;
	bh=Q5CBm+m4hE1qg8WOGkB/pV5OGeigy1uz+XMPBiUMLs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ISvSmLlAXUZ/YzDBQd7z+bWydDPlQ1pNKTh2t0nV446aGp3GKKVH0a3q6qn+V7j30cljJvwJZiiT/+isRlzgwqh9nY8EJKhmNxxHejdjeR5h5HI0f52iT5c3kCzOQo7k/pj82t2Amsd0pCy1X4b1dnKSEgnY+bXfNZ2SMvNUu/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=BbIS2P69; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1763660872;
	bh=Q5CBm+m4hE1qg8WOGkB/pV5OGeigy1uz+XMPBiUMLs4=;
	h=From:To:Cc:Subject:Date:From;
	b=BbIS2P699erwigCOeT99ysNM4IJhezBiGzW7LYadfR/wj6LRswafPUHr4MNHxLd2O
	 24AnF584X/l0KaODT0TqjF6W0+lfQHpVb3q/cKIW74ccM5hIGlMpv4DZo9lBTL9QR6
	 txRg3Qln2pTsxvPPKC/voIvHPHkvutlCHrKrMRUtoB0Fz6JXa9/A2GLWbcP1FHv0Jf
	 nmLAD9AKA7NwQBmObe3ZReidxPgsiGCUGuDXMMF5SYWsUdzrBM3ImK0sxIwWCJMeoa
	 ENTtefW6/tUcozdPXzmKbnePt6KpJl8vWCvJWFURJBPZO8CMs+4lnsx722Gpkp9Vrf
	 DpZD/rpXOeWag==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 9842760104;
	Thu, 20 Nov 2025 17:46:25 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 1B1442002DF; Thu, 20 Nov 2025 17:45:07 +0000 (UTC)
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
Subject: [PATCH net-next 0/2] tools: ynl-gen: regeneration comment + function prefix
Date: Thu, 20 Nov 2025 17:44:25 +0000
Message-ID: <20251120174429.390574-1-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It looks like these two patches are the last ones needed
for YNL, before the WireGuard patches can go in.

These patches was both requested by Jason, during review
of the WireGuard YNL conversion patchset[1].

[1] https://lore.kernel.org/r/20251105183223.89913-1-ast@fiberby.net/T/#u

Asbjørn Sloth Tønnesen (2):
  tools: ynl-gen: add function prefix argument
  tools: ynl-gen: add regeneration comment

 drivers/android/binder_netlink.c              |  1 +
 drivers/android/binder_netlink.h              |  1 +
 drivers/dpll/dpll_nl.c                        |  1 +
 drivers/dpll/dpll_nl.h                        |  1 +
 drivers/net/ovpn/netlink-gen.c                |  1 +
 drivers/net/ovpn/netlink-gen.h                |  1 +
 drivers/net/team/team_nl.c                    |  1 +
 drivers/net/team/team_nl.h                    |  1 +
 fs/lockd/netlink.c                            |  1 +
 fs/lockd/netlink.h                            |  1 +
 fs/nfsd/netlink.c                             |  1 +
 fs/nfsd/netlink.h                             |  1 +
 include/uapi/linux/android/binder_netlink.h   |  1 +
 include/uapi/linux/dpll.h                     |  1 +
 .../uapi/linux/ethtool_netlink_generated.h    |  1 +
 include/uapi/linux/fou.h                      |  1 +
 include/uapi/linux/handshake.h                |  1 +
 include/uapi/linux/if_team.h                  |  1 +
 include/uapi/linux/lockd_netlink.h            |  1 +
 include/uapi/linux/mptcp_pm.h                 |  1 +
 include/uapi/linux/net_shaper.h               |  1 +
 include/uapi/linux/netdev.h                   |  1 +
 include/uapi/linux/nfsd_netlink.h             |  1 +
 include/uapi/linux/ovpn.h                     |  1 +
 include/uapi/linux/psp.h                      |  1 +
 net/core/netdev-genl-gen.c                    |  1 +
 net/core/netdev-genl-gen.h                    |  1 +
 net/devlink/netlink_gen.c                     |  1 +
 net/devlink/netlink_gen.h                     |  1 +
 net/handshake/genl.c                          |  1 +
 net/handshake/genl.h                          |  1 +
 net/ipv4/fou_nl.c                             |  1 +
 net/ipv4/fou_nl.h                             |  1 +
 net/mptcp/mptcp_pm_gen.c                      |  1 +
 net/mptcp/mptcp_pm_gen.h                      |  1 +
 net/psp/psp-nl-gen.c                          |  1 +
 net/psp/psp-nl-gen.h                          |  1 +
 net/shaper/shaper_nl_gen.c                    |  1 +
 net/shaper/shaper_nl_gen.h                    |  1 +
 tools/include/uapi/linux/netdev.h             |  1 +
 tools/net/ynl/pyynl/ynl_gen_c.py              | 26 ++++++++++++-------
 41 files changed, 57 insertions(+), 9 deletions(-)

-- 
2.51.0


