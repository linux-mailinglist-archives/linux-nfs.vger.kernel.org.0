Return-Path: <linux-nfs+bounces-14053-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7789B44BBA
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 04:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F3E482EC3
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 02:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672B41F3B85;
	Fri,  5 Sep 2025 02:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz6P41kB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFE51A254E;
	Fri,  5 Sep 2025 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040443; cv=none; b=DsnuPC9IlgJQlsPZF86JW1l9WIa4ryRZLGrmEw6ZOXaeFIt56ry/Uywx8iGExBmdGsT4+LEasN2zREdm5Yof8A6O4qzW17Dg0xNyD3lzswfKizMhGhhQTvvMwzTLwb8SuFEcyTPmUgqE0pU2dSdzR3csmGew5EfR/hDXAkbtDCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040443; c=relaxed/simple;
	bh=557DYTo6ddtSvf+PUcpc9kZvkLXkNp+jXeHWroetNSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUOlFLMTeZYhW0StJK5W8pAjNHEP7Zon9MI+QCimZeAV+ZJ29Zayi9a9UyMb2DpjKsv64Li5bgrnTrGXCYKuLOw69zzDNrDmREBDS5SH/nNvH2NdldastVFb52tIFOnrn1+/FrYC7YRtIjcLKXukGSf1XxlqTd+gkA+Z46xpJ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dz6P41kB; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7723bf02181so1335438b3a.1;
        Thu, 04 Sep 2025 19:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757040441; x=1757645241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gM3TMQ0WbfGUuMmelR/0TgQBGHBy9kRHA2KtDMurmyY=;
        b=dz6P41kBBmGNjs/lEpTKJdZeqXVo+9as+Xhju70A5NDdUYvOE0gc8ov9QcuTb6+Bb5
         zc7xLSe3he5WGKz7g0Vo6bLmH4RX3UT88ICLddh66/hPYY3vFsjWx9rJ1yQzv9lI2dhL
         33ewCsiPH2bnpEg8DrODXVD9RnPbpDda4UKSfu25ah0egK8MsgCDui6syOYh68YS+dyd
         DYTGJSClV4enrQ33Pu9eSPg2E15+H4QpZgSMWvAM6qRKclZ67GXT61uqG4Q/NoN5YWk6
         kPTF4WJQy8S/ccRVpttoLtkVTrKQEwSwTkfnIvtIlm2EtTWhipDfZ3MdfbwkOZpFOyuX
         6vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040441; x=1757645241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gM3TMQ0WbfGUuMmelR/0TgQBGHBy9kRHA2KtDMurmyY=;
        b=QbJCjSAUzY+g0SeOD5rDAhVmAeaM0ZLxXIgmyaNvLbeIV0CGl4KBzFykLmK6YcZx2c
         Rwol0PGOipo3W9QGV2UTVSTUPsXh8y6WWc9K4NKaWgUvVlwxtbog2Fitq1r6wRG4NSLg
         0+8DmWJLZL0wW4tTKc3fBFMIOkX8VbWEKV7+uGsP7JidEfE2vXSihxjL1muoZHlLanZR
         jGNy7Txx9u9bIHlRJSbbswHw+FklWvAlhi3PN+tlRl+NF2S3m4tLOvYcuTXCneBB2lYs
         fXjf+m31a52SoWb2gahOtcjIExn09POaz5Rp771iqcprPPLr987h9jHPdQIQjUXWs2/S
         JqZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIdRLA35ss77tU/mtUO14ANZXa7BP+ZHF0lzUtDU+uESfG1uHzO3LWlUKr0RtobSO2Fbir+G0C78Pc@vger.kernel.org, AJvYcCVdFbyBOASmSMhP6B73X3VeePCuQ+f64khsmnyqLiCAktBi33h9gidKV1BNjpdWdB30PMb5967d0uMOrkt2@vger.kernel.org, AJvYcCW1m8sNrKYndzqJz+PUxQX4HnX3WpSogEIf/o2eHbNBJ5Y1E0ddLiqu3sf7eF1xDUWrCNKVxESM@vger.kernel.org, AJvYcCX+FNcjecX14kFIwEQMzkfU/VmWQoy9WuJjsBZE1DupBHdAMsLw28Juac/36WjwADIsx5gL8dkDg4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRSddAyRqV1CaxXIuLEvShqz0wVBgLT07AeqQpoOq37IPFJNnC
	AnCX66C3Im13e147lnb2KkNYmH71sBqsZjftPmkMcpyGur5tHqd9jsbV
X-Gm-Gg: ASbGncvtGVW0dqFipRzGDPNMUsP0Ea54a3qjroheM42UlWqk591s8pcZZzhcuUYFAlv
	sZ/rGI7TnXdcZGmCoL+kXi7NlMjvsU1IDEyFWfkRfeBb7zVAO8dOw1F9bA7WEgfU/nJMCbCyfMl
	RFrkRGV411a8UIwTwKtQQqapYp1VzR53q+mDtIMwmF0/mplESckOxyzKvfA+PrDI8I1J7f8pvCh
	than8dx+zqWSjl6MkfIolGQIDwBu5qlJHv+1iIMunWmWZ+LImZ5k9zqgkblvz0/m491Z8Tubzrk
	mJWPXuA8sXjddRGvh/p/e8l+00K/f5znHPvxVmSG2a5tZzfTYyZrbC3yjcc9tW7REUrgjZVo0cw
	wl6IqmtY4/y4AmYc/dJ+Femsz5CWq94PhgkoyVVdwAEj48VN03KxAyrCP4F1+GjOV154KTHkCpM
	TiBTv+46ggba7MdHpRF0UlxS0sYO2WxqddFUIuG7fVoY3bKU1n
X-Google-Smtp-Source: AGHT+IFnFUAgkSS6yBhBqxWiiAYRF6dBvxDDhPo+1WikDfiL7zeeqA/KVbZCbB5Nq6/UGRBPPZzeeA==
X-Received: by 2002:a05:6a21:329f:b0:248:4d59:93dd with SMTP id adf61e73a8af0-2484d59950emr12008405637.52.1757040441006;
        Thu, 04 Sep 2025 19:47:21 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e0519sm12991858b3a.84.2025.09.04.19.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:47:20 -0700 (PDT)
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
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 0/7] nvme-tcp: Support receiving KeyUpdate requests
Date: Fri,  5 Sep 2025 12:46:52 +1000
Message-ID: <20250905024659.811386-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3

v2:
 - Change "key-serial" to "session-id"
 - Fix reported build failures
 - Drop tls_clear_err() function
 - Stop keep alive timer during KeyUpdate
 - Drop handshake message decoding in the NVMe layer

Alistair Francis (7):
  net/handshake: Store the key serial number on completion
  net/handshake: Make handshake_req_cancel public
  net/handshake: Expose handshake_sk_destruct_req publically
  nvmet: Expose nvmet_stop_keep_alive_timer publically
  net/handshake: Support KeyUpdate message types
  nvme-tcp: Support KeyUpdate
  nvmet-tcp: Support KeyUpdate

 Documentation/netlink/specs/handshake.yaml |  19 +++-
 Documentation/networking/tls-handshake.rst |   4 +-
 drivers/nvme/host/tcp.c                    |  88 +++++++++++++++--
 drivers/nvme/target/core.c                 |   1 +
 drivers/nvme/target/tcp.c                  | 104 +++++++++++++++++++--
 include/net/handshake.h                    |  17 +++-
 include/uapi/linux/handshake.h             |  14 +++
 net/handshake/genl.c                       |   5 +-
 net/handshake/handshake.h                  |   1 -
 net/handshake/request.c                    |  18 ++++
 net/handshake/tlshd.c                      |  46 +++++++--
 net/sunrpc/svcsock.c                       |   3 +-
 net/sunrpc/xprtsock.c                      |   3 +-
 13 files changed, 289 insertions(+), 34 deletions(-)

-- 
2.50.1


