Return-Path: <linux-nfs+bounces-13649-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 607CCB277F1
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 07:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA5B1CE2C48
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 05:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D534223DEC;
	Fri, 15 Aug 2025 05:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTp7wtoo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D0F374C4;
	Fri, 15 Aug 2025 05:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755234142; cv=none; b=G9wz0i9l9ir+gjSiUtuuvCNzydP4hmVX41PlgaTbfVD1FQ1R4TeyYd8ctnjbvE5TYRGfEIYj3LbJYS2V+/03LbQMqGfSU4xCUNSgXQ1Y7BPwabxRvL4q565NoAKdPjSKQsyGd9qSc3gkpn3YbMDylujk5p+00ZyMKC+rEhz0JwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755234142; c=relaxed/simple;
	bh=4aoISFqoZW3xIWfmCOYas+QHZ7GQjQ+ceAIQLkxwDZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CV+VcVIzgC/XVPEEvy3Ji+dMOB/FqUT278YRQOtgy3I6XDJw2ydKMX8R6+QHR7AIiPkn5/xvCS3XlF66TcReJZP4e2emjnD1ONYrAeUfPRt/TSKRsW6ytjHgVwFWv9o2BVARdI77Uuslf5Lr06kxBzCX+qMtHwPYg0ZAF7/egQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTp7wtoo; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326793a85so1502012a91.1;
        Thu, 14 Aug 2025 22:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234140; x=1755838940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HvJ9vjlQgWj0JGVdSmCK4V4OH1FNmLUxKe8JArbwI44=;
        b=PTp7wtoo24622jPyRmbLk+NyKrV9mx7f5+XG3+2wMR1DqVEGnMjZB1i0MZYSGEFH8n
         7q0nU6LoEBlSNij2PfXSVsEpQnF8Mknu59Ym0o6jkW4Uo6xRQ7FfC1oN597Qv36bH6O2
         xgiS59Y0KRbkAlWsZLReitOf/4oI5w4Nv2xtLqwBcuGdZtfNmWMouM8VifCW08JkjUHR
         OBqvoIxQ2XoW63+03UCVrRykwkV2I+82JqVZSL4ibJC+pnm4katf26FNfTGw+e8pwWQH
         7BbTBzPFvd8AjzVuGqTPqB6IOtFo6YU+Wk9VOfof4eIzMeGi89/9W0i7VQASeq8w1M+F
         le1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234140; x=1755838940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvJ9vjlQgWj0JGVdSmCK4V4OH1FNmLUxKe8JArbwI44=;
        b=qSLBmB/0BhD5RAL72BIXcK4f/wYr7xrO3Iwn0Ja2n3hPKnIr4wyex03M4oiJmwAecN
         YlR+rJOMMpOgFYq1pNNpU9NK3BSVTVV5gqgj7OFUHmfpvQVzf0bUcoHJyDfWiILDHYk0
         r8TERz8BK9qMY9h68uI/fLBq68nMzcI46PwUI755PdiPGQl4btrvDmbFgrMm40wcI+Pe
         OB2QpKXARqeJ61OOvnLFs6BvEqDMybmZANL9ETUc4Lyv0ZDdX5T95UPGXAWiJTamHhDZ
         CDc9N4LyrjhgLm5qQ3CAK9KeJw7l75n5szkthvZJDUr95+Gvkijk/8ZfFKd/ncJMJ95I
         abkg==
X-Forwarded-Encrypted: i=1; AJvYcCV2SVTdRQVG19FGgRi+DS3xdybjeGEPYsUoz+VDsXLIvzmdlEBBOHvYpDsPYTtA9lZ0xk/jMYgmUOnjPDVd@vger.kernel.org, AJvYcCWq9+j1e2+VGxvzX0baAqc0aUcKR4zXhSyQrfbnYJKq/QJ8Anssoez9wZQTCzW3+Lb5hli+n7bMTp5e@vger.kernel.org, AJvYcCXp+Icc+Z7TQslMknr9Z6Kt8XQEhFIQ3xFYdwEsQI5ZQuTPc7gchJmRPS0ZMqYrZynje69wzhsRTok=@vger.kernel.org, AJvYcCXzM4GmwkdzwtIxyOO87CsFysTzfVoZmUzTVZ9nAxSEljl0CIAbrMo2iOUt4Zf0xLZIV1GCumdT@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgRYlIna7iM8IS4mlyTWkkQjLW+MXNZAFbuyntqJhbCMWkrKQ
	Br8PaKj9D4VbBKiRrPNzH62FsulHOiHjfPdU91S8tcGc5izGgwIvxFGr
X-Gm-Gg: ASbGncsV9kkFHtvm2hfPx142dgBP+TJxXKlyZM1ZkkVKFyFzYU0jpiEo7R3akd8RAnX
	XbMBSJpAbTu8lGpdCKGFCfo+RHJrTJxk46jzSsBCf/1xcTLuRYsNx+sfvbhPKe97bYtzlvMpkO9
	p7cv3TQnHGLw9aY7ztXhkl3lR12ceiEXhZG1LzL6Wxg5e69iNO6vQJvxXrslMvWJKACDgitU2Vw
	XAXN7C47AH584A3SXcFt7s/xJmIc7rbW192zezd8AJK7tAfYkU1UWWXVyNXattMrfJZo+03j0g4
	7ZYIpeib7ympgQ/6etDPgLydKpVhhEJ9iDtP6iVuMvnvlCt0H23xb6S9fPu5WxjPpTGerZNRES9
	q420lhB7CDksw4WU3g6X3xqoCakcdHDJB4/grj6kwtDB0LwrBLknBvuXd00FjsN63Bf70fPJ19w
	osJiLX/Wuk+zeu2uEccGiUO7dLS89pB7lCBzC7Uw==
X-Google-Smtp-Source: AGHT+IFc/j6gSSFssjIPr1g+lc0GaAJwz273eKQ4JRPcXd+8ZTYMotiRajoz1cIteit3jJWFjwumvg==
X-Received: by 2002:a17:903:41c3:b0:242:e0f1:f4bf with SMTP id d9443c01a7336-2446d720275mr11691175ad.18.1755234139897;
        Thu, 14 Aug 2025 22:02:19 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53c6e1sm5128645ad.115.2025.08.14.22.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:02:19 -0700 (PDT)
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
Subject: [PATCH 0/8] nvme-tcp: Support receiving KeyUpdate requests
Date: Fri, 15 Aug 2025 15:02:02 +1000
Message-ID: <20250815050210.1518439-1-alistair.francis@wdc.com>
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

Alistair Francis (8):
  net/handshake: Store the key serial number on completion
  net/handshake: Make handshake_req_cancel public
  net/handshake: Expose handshake_sk_destruct_req publically
  tls: Allow callers to clear errors
  net/handshake: Support KeyUpdate message types
  nvme-tcp: Support KeyUpdate
  net/handshake: Support decoding the HandshakeType
  nvmet-tcp: Support KeyUpdate

 Documentation/netlink/specs/handshake.yaml | 19 +++++-
 Documentation/networking/tls-handshake.rst |  4 +-
 drivers/nvme/host/tcp.c                    | 78 ++++++++++++++++++++--
 drivers/nvme/target/tcp.c                  | 71 ++++++++++++++++++--
 include/net/handshake.h                    | 18 ++++-
 include/net/tls.h                          |  6 ++
 include/net/tls_prot.h                     | 17 +++++
 include/uapi/linux/handshake.h             | 14 ++++
 net/handshake/alert.c                      | 26 ++++++++
 net/handshake/genl.c                       |  5 +-
 net/handshake/handshake-test.c             |  1 +
 net/handshake/handshake.h                  |  1 -
 net/handshake/request.c                    | 17 +++++
 net/handshake/tlshd.c                      | 46 +++++++++++--
 net/sunrpc/svcsock.c                       |  3 +-
 net/sunrpc/xprtsock.c                      |  3 +-
 16 files changed, 300 insertions(+), 29 deletions(-)

-- 
2.50.1


