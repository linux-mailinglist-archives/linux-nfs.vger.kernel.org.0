Return-Path: <linux-nfs+bounces-19714-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNVcL+XEp2mYjgAAu9opvQ
	(envelope-from <linux-nfs+bounces-19714-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 06:36:37 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2344E1FAE23
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 06:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C490302658A
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 05:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14A837CD59;
	Wed,  4 Mar 2026 05:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuTlsCCG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F133364943
	for <linux-nfs@vger.kernel.org>; Wed,  4 Mar 2026 05:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772602588; cv=none; b=V2YVaLFwX4wwxj0dWxnAQFkl6OdtrTdptvAHDW2d/rcVsFV6gREXGLIEPJHPs7+v2jJ/rsR1Valk1VX5JNH++89qUEtn1v+kjmO0cDpV+gqG3WgAssU2y5rln5m7GZLuV529bJgBbHZvgoVxgzwM8TmcOUE18BiGQ3iYq4cvd2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772602588; c=relaxed/simple;
	bh=DdGnEi2MIzcNo3q2Zph5X3WR+wOdcO1pfRapVm1aFa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvVjfXtuUUO1YCbPxXkgnsU2dCTgQ1hWR5matraeoiTJC9kGF3pEydCNC84ikhrUzwrqvbVRc3WJ4CnwzwarYLTxmwDNiDsNFl+4vfvtEZ1gbweORuCL6WFisbDvrWgO22GsOFlAqsii2yYKtnHmAgprOWvdAuUdXeNw1sHfzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuTlsCCG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3598b95ad7dso2245581a91.2
        for <linux-nfs@vger.kernel.org>; Tue, 03 Mar 2026 21:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772602587; x=1773207387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tBaAO3EhPpnhGGnT8RJsqBThiWnEysWAZzlV8WTFAvE=;
        b=OuTlsCCGosBzUauHhHv5Nr7SBeMDsCXXi/oaeAz4l/KEd7iFMpPBEJqJt7TcTTKxK8
         8bgrhiFB+b/UTAMcuxQeBoSACq+7yzePEhALqejpcZBMoqOndRG4fy+qqqf4VqKdg3N0
         DLy9URN+ZQxO3oiDhjabuDFyfSTFTcqttQwibmZVH3nfZqC6y18Js3EO1IjpyLkPVgat
         c/eio31GNapjWF1nNIsDCajiAmzky0aU01VIp4LMWYdRVwsJX0cGSfpJmRf+1easyKDr
         WdLdQzVlIJm91LxptvPCU7qzjKnesnqfjJ6o2lIVlvVfrjW0eOs6TA2P+uF+k7noTs/v
         Yy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772602587; x=1773207387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBaAO3EhPpnhGGnT8RJsqBThiWnEysWAZzlV8WTFAvE=;
        b=E7N0PFv7ATR+8Rve4l/3Qa2Eq061VtJDlYJAYF/PdQ1Ru8RZunYJQd1PL2monTdf8j
         3AdyvELMZpc5iMry9uLUumGRYxfS7L0bOz/o8RraSZhjXW+lvfMzEa2CDxbLUUiU9HBP
         hHoic5nK8rot/1cruhC9YIWjhHaaceidJfRx4UH3E3mhroG8JMdOJYq23XeWGZQ993QT
         vXCdh1+V2en+VU3WKfDGUGRXnCo1ePRBytN9ojCWu0U/7PNOEsnM27jHY061FoNdM12D
         3+0bZhkIj7MCdOwSRX/07ug+PRKPtrVm4SDfouqQTmHcpbZ99bJ2XgL8wiuchayy0DjY
         V3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCV20taPMn75YoQ9GucG/tg364a2u179dGkNcGH51DoX7pVv/Wtomr2t+VRGCcSeDCfByZo+3ZRkY1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCo7H41BshANlK6m3loo2cIUKTv8q/Xyy9um1WqJlFj/bo963F
	wC+KBvGymvfczjmfUFsjq/VmOAQBvA7303+RWbRQU7DRpzvKh72Fcj4t
X-Gm-Gg: ATEYQzw//QgmAtcSJRWIGuC6oYncN1FgTf0mLMnaLo2CY2gKB8TxnOxRDRIIkLLbCeo
	yuYZcPve9frFKKyA1U8eXJBAF55mrM7n/K2xDg3lxXk3eOzkgGzv5IL2Uhr/Ueg7YbmarBJfN6t
	cNBKcFudnQdc/FZWkrk/UjpQlf9w48NItZ+bqURi+VxV65AFJ0BJ4UBs9wfAym5cVS2w9X5LU12
	qJlIfbc2QR/2+EM8hv5NoptyMEInC7BlnOCmaOr2lxgRQERpDaEWGO/pYcVIkYmRuS58s6bWl95
	QM+Vzd/yQ8MfhOph90M0yz6hUY0jxOgOohizRobyyf6g9DssTmvKSWW1wyk/152IF322Ou+uENB
	GGmozFw9/g3OTibbWkC4MFv6RQjr0EvC9B3E0ogwWuDPoYlYNqGVr5qbSpxVxR76maozHtzBnzg
	tZ/n2438rBs638fyPUArC0HVVaCULLFakr4zXSMv8KWQ==
X-Received: by 2002:a17:90b:3952:b0:339:ec9c:b275 with SMTP id 98e67ed59e1d1-359a69aec32mr1042348a91.6.1772602586933;
        Tue, 03 Mar 2026 21:36:26 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c090bfdsm4020057a91.8.2026.03.03.21.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 21:36:26 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v7 0/5] nvme-tcp: Support receiving KeyUpdate requests
Date: Wed,  4 Mar 2026 15:34:55 +1000
Message-ID: <20260304053500.590630-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2344E1FAE23
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19714-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,suse.de,gmail.com,wdc.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alistair23@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,infradead.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wdc.com:mid,wdc.com:email]
X-Rspamd-Action: no action

From: Alistair Francis <alistair.francis@wdc.com>

The TLS 1.3 specification allows the TLS client or server to send a
KeyUpdate. This is generally used when the sequence is about to
overflow or after a certain amount of bytes have been encrypted.

The TLS spec doesn't mandate the conditions though, so a KeyUpdate
can be sent by the TLS client or server at any time. This includes
when running NVMe-OF over a TLS 1.3 connection.

As such Linux should be able to handle a KeyUpdate event, as the
other NVMe side could initiate a KeyUpdate.

Upcoming WD NVMe-TCP hardware controllers implement TLS support
and send KeyUpdate requests.

This series builds on top of the existing TLS EKEYEXPIRED work,
which already detects a KeyUpdate request. We can now pass that
information up to the NVMe layer (target and host) and then pass
it up to userspace.

Userspace (ktls-utils) will need to save the connection state
in the keyring during the initial handshake. The kernel then
provides the key serial back to userspace when handling a
KeyUpdate. Userspace can use this to restore the connection
information and then update the keys, this final process
is similar to the initial handshake.

This series depends on the read_sock_cmsg() kernel patch:
https://lore.kernel.org/kernel-tls-handshake/20260217222033.1929211-1-cel@kernel.org

ktls-utils (tlshd) userspace patches are available at:
https://lore.kernel.org/kernel-tls-handshake/CAKmqyKNpFhPtM8HAkgRMKQA8_N7AgoeqaSTe2=0spPnb+Oz2ng@mail.gmail.com/T/#mb277f5c998282666d0f41cc02f4abf516fcc4e9c

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3

Based-on: 20260217222033.1929211-1-cel@kernel.org

v7:
 - Don't use recvmsg() (see [1]) instead use read_sock_cmsg()
 - Remove reviews from patch 4, as it changed a bit to support read_sock_cmsg()
v6:
 - Don't free handshake request on completion (handshake_sk_destruct_req())
 - Add handshake_req_keyupdate() which reuses existing handshake request
   for a KeyUpdate
 - Other small improvements and tidyups
v5:
 - Cleanup code flow for nvme-tcp
 - When using recvmsg in the host code first check for MSG_CTRUNC
   in the msg_flags returned from recvmsg() and use that to determine
   if it's a control message
 - Drop clientkeyupdaterequest and serverkeyupdaterequest
v4:
 - Don't stop the keep-alive timer
 - Remove any support for sending a KeyUpdate
 - Add tls_client_keyupdate_psk()' and 'tls_server_keyupdate_psk()'
 - Code cleanups
 - Change order of patches
v3:
 - Rebase on the recvmsg() workflow patch
 - Add debugfs support for the host
 - Don't cancel an ongoing request
 - Ensure a request is destructed on completion
v2:
 - Change "key-serial" to "session-id"
 - Fix reported build failures
 - Drop tls_clear_err() function
 - Stop keep alive timer during KeyUpdate
 - Drop handshake message decoding in the NVMe layer

1: https://lists.infradead.org/pipermail/linux-nvme/2026-February/061252.html

Alistair Francis (5):
  net/handshake: Store the key serial number on completion
  net/handshake: Define handshake_req_keyupdate
  net/handshake: Support KeyUpdate message types
  nvme-tcp: Support KeyUpdate
  nvmet-tcp: Support KeyUpdate

 Documentation/netlink/specs/handshake.yaml |  20 +-
 Documentation/networking/tls-handshake.rst |   1 +
 drivers/nvme/host/tcp.c                    |  80 +++++++-
 drivers/nvme/target/tcp.c                  | 213 ++++++++++++++-------
 include/net/handshake.h                    |  11 +-
 include/uapi/linux/handshake.h             |  12 ++
 net/handshake/genl.c                       |   5 +-
 net/handshake/handshake.h                  |   2 +
 net/handshake/request.c                    |  97 ++++++++++
 net/handshake/tlshd.c                      |  97 +++++++++-
 net/sunrpc/svcsock.c                       |   4 +-
 net/sunrpc/xprtsock.c                      |   4 +-
 12 files changed, 467 insertions(+), 79 deletions(-)

-- 
2.53.0


