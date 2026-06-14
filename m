Return-Path: <linux-nfs+bounces-22553-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v1MoDsmnLmp51gQAu9opvQ
	(envelope-from <linux-nfs+bounces-22553-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 15:08:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D79268114C
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 15:08:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jpd7WpQd;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22553-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22553-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E66163002E60
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643EF39FCBF;
	Sun, 14 Jun 2026 13:08:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2772E3264DA
	for <linux-nfs@vger.kernel.org>; Sun, 14 Jun 2026 13:08:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781442501; cv=none; b=r2zynlxD2ULAjUnpJE/HqgiLt9FTMonBZFRGXFNWwmcKJNcwBx0PWgarrNNjpBuv2hXP7DuzaHlQo8+X+H65nQ2SCF6zhAQmFQ4PxQSJ0b9hLk8us1t7PRs3EoClyNpcYEvmoVHZT/wtnfyR5A+gFy34L6qITbyRBwRR76ynW+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781442501; c=relaxed/simple;
	bh=zCcv9MOOOHTxPw7gDjLOWlMtYn5V7225F/m2vJlTgFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIdPjNXUlC66eSgRknHD8CN2JT0iRXuTsF8gZ4uPevNAyblhats8Kc3uSuAKxFUJ6/w0+Bh/Or0cLceqJ5r56qsAKq2PZxjkdfQH+HupL9BiBUrcSmwYcuhjcvqsXvKdu6WbKBaWljKBJJbb4QfUxR1ghi7UQqxfPbXAmHRtjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpd7WpQd; arc=none smtp.client-ip=209.85.222.174
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-915d64fead9so363787285a.0
        for <linux-nfs@vger.kernel.org>; Sun, 14 Jun 2026 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781442499; x=1782047299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U3Z2uDchQ6KXV2OGuJ7w74+HBWtFtKyX+FjHZ4sgUZc=;
        b=jpd7WpQdMm+txs0aszsimyk5kbhbvBnP8q7TOQjGexHX+MBfCYPfSc5oEJ6mYng0Xo
         QfQ2d+FbJbI00gqxuoPlfwoO63ZUbc+Pk+PJWdTivGCZKQ1ZwGeK/7yISvt3kTQnMios
         cfR+z/FjLG8MHNOpqYI7I8gkPmwnQeUX1UadcKN2jtwElzEC6ZQmcZ7EwvN4UgFJXis7
         1djiHJ0/OAQr9ZHaQORc2yqk41cnqznDDkdoJGTer14Ag8yPdrsIj78TZY9aCCfs9Ivn
         KSVtYeOVev9Ih1rcllKWIKq8YvkyJf34IkgUjn8b8EqhpArOz9psRxBqQLLNj7u2ZhTi
         xRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781442499; x=1782047299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3Z2uDchQ6KXV2OGuJ7w74+HBWtFtKyX+FjHZ4sgUZc=;
        b=GugVyAz4DEq7r/uCXgUohpCbZSGaEvPGy4qyN9UbajjNq2jYuaIzucKPwBhqqJtY43
         xXDGEeIJw3Uasol0SAe8oX3DvXyzIfI5sNnUgODhTRfeXlYhn42wtJ8oCIl6lK+9zE0F
         RTc3CzJscqLqbYkoUL2jD60wPYj8OsYXHfJzoFnSl4Hb+Gnupt19nDm4TYildGbninvN
         /X9cB51U6ykWCBAg6IsYvXlHBrN0Rva7sJD0r7WR9r1sxICMim71zTJMsiHWECwj3fRX
         wPgpoPvC92jWRmSAb4509/OqFhwKUITx/f6B9jxQBS1SQMtYfa8kUGJ0v3inmq5w3fuR
         0XGg==
X-Gm-Message-State: AOJu0Yy9M9sMftNahLyvW9UVdEXi4nvyb1bWeY46QQwyiR3FLK6nJcH7
	YBg2/TB3sFy7p3+XEDvnb3jF2a2G5HzQj3NlaxJc2ZwqtopJZAa8ywuGVss1SA==
X-Gm-Gg: Acq92OFq5L9qNmVQz+vP1YtHDG9luVcWMtHoLJqXtOBOGDNDwEqlvc8cnagNFDYqMPX
	dM7YcLOf9k2QjYzXEvdYsgO+LWE1j6oeCqnpnnaYOFpRyJx/1euJThxRX26JwygyaNup0ifUYun
	nRWvHmOAjvVdvxUHmgCczUeN2f62pMUqYh7YzV5BrzSYmCVc6PXJIf+PNtJ2aGKB9670DcR9AbE
	3K6iM44U8SmrO1nb1L8TXM6PBQN23zJ1O88ZnNbE++hfPrpyXK1UmCl94OSbj9qIfJ3IJHHVmDB
	AUfCHz+VVUlK7ngxTQs5tLCsBE6kVZWcVm4+lHfa0iGpD+4MqkylRbSxTBWFa4GbW3MvbOzMCmH
	NaDANN7FxPivwwi/ZipVxhNxBaL8mNeASkAIdPnPcjFl/boGicA1hqLL7hKxDST+lfTqQ1anssi
	8gFdLpurOp9jKLc8b/n80URlb3/u7dWpXxG1PGnSeo7Ycc836YEUBwbXogSZPjZ/FoCaSbsp2b5
	nMJWgk/Q7u0lbB2g8eRjpeU7S2nVFhnyHxM3dH5AQk=
X-Received: by 2002:a05:620a:6313:10b0:915:8e2b:e5f1 with SMTP id af79cd13be357-91619dafea1mr943818585a.3.1781442498991;
        Sun, 14 Jun 2026 06:08:18 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d301b2cf04sm77838966d6.16.2026.06.14.06.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:08:18 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] NFSv4.1/pnfs: bound GETDEVICEINFO notification bitmap length
Date: Sun, 14 Jun 2026 09:08:12 -0400
Message-ID: <20260614130814.2521819-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22553-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D79268114C

decode_getdeviceinfo() scales a server-supplied notification bitmap
length by four for xdr_inline_decode(). The 32-bit multiply wraps to 0
for len >= 0x40000000, so the bounds check passes on an empty request
and the verify loop reads up to ~2^30 words past the inline XDR buffer.
A malicious or compromised pNFS server, or a man in the middle on an
unprotected mount, can drive this out-of-bounds read while the client
decodes a GETDEVICEINFO reply. It is a read, not a leak: the loop only
checks each word for nonzero and returns -EIO on the first, so over-read
contents are never returned.

A conformant reply uses a single notification word. Patch 1 bounds the
length before the scale so it cannot wrap. Patch 2 adds KUnit coverage
and is offered separately so it can be taken or dropped on its own.

Tested on QEMU x86_64 with KASAN: a Level-2 KUnit case drives the real
decode_getdeviceinfo() and reports a slab-out-of-bounds read on stock,
returning -EIO after patch 1; two benign controls drive the same decoder
in bounds and pass on both stock and fixed trees.

Michael Bommarito (2):
  NFSv4.1/pnfs: bound notification bitmap length in decode_getdeviceinfo
  NFSv4.1/pnfs: add KUnit coverage for GETDEVICEINFO notification decode

 fs/nfs/Kconfig                      |  14 ++++
 fs/nfs/getdeviceinfo_notify_kunit.c | 110 ++++++++++++++++++++++++++++
 fs/nfs/nfs4xdr.c                    |  10 ++-
 include/linux/nfs4.h                |   3 +
 4 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 fs/nfs/getdeviceinfo_notify_kunit.c


base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0


