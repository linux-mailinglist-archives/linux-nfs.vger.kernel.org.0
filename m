Return-Path: <linux-nfs+bounces-7989-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE649C94A0
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 22:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE1E2B23B6F
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 21:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50539189F2A;
	Thu, 14 Nov 2024 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6h2+4Uq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B076026
	for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731620453; cv=none; b=VMjkKNwa6xiirmSAZ6811bIvFBUYbvuhrACHZA3xLO3IesJHtwgZZ/ajDeQXhHTDUWoebVaRoPn6R8mHiB7QIiT4LewWU4Jm/SwuSgliWd3152m01VrpdOAAXN10uAQSv/YGhHZiN8X6YMX+8ICrfxWcYIdBWTFnPkR5rcdEIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731620453; c=relaxed/simple;
	bh=FnDMVM1kXfhHp8BIo1GQYyAYvypvaI12VQxKSpagN4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MdNWQdsJ7E+F9NiPfNsTZsFythJIPj2Lxx00PV080HRJrgHAKRWM2A6sgIkeRHmMkwL0Xmy98xQY1XrgnJV6JrlqFk01GUcsjzsV1j2dVuhC0+lUteEdI9D6PztbSO1a6a/kp9x2D15Do5HMPiLQZhCXT4Kwa8POQLd5rmmqD/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6h2+4Uq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so9234035e9.3
        for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 13:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731620450; x=1732225250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cWFZWNW6f4o/S/9Wi8yh5FHmMKTtYeje5S6KSQvqKQo=;
        b=C6h2+4Uqjy/M82gUeWEgcuL5G8zyEjXoaTem/Tf3cyL/jLS8/fNC3UUOJlgnDXCZcI
         feMOTmVWhibPQl6MbMmv6ZRQOpZc6ePRVwLm7CNzEN/It9ryl/paqkQq/h+FwflcJ011
         mdPUkkDxAJr7NRgNBVCsFMU1p0pNwk8Lgb2u5veWOSrxGHHvQ8rGs5NzHZj/VQyQcc/O
         Dq7S3jNDly0auHF9ZstTOfWqjTZ6Zp0L+Z2yActovssdUfk4DBECL2HChnAY4bDlNuyv
         NTRQHDT/pcYYmnrpT3xYDVMWlVPjBBWbA0aYKuNNWmEG2Bj+Ei5gqZVOe8epFIzFDRNy
         X4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731620450; x=1732225250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWFZWNW6f4o/S/9Wi8yh5FHmMKTtYeje5S6KSQvqKQo=;
        b=nLQYnws4UMRcZ1GBqRGPzR4uOqhGgTDn97V0owVtyWmZZfn60/ZGVaQAUe+DW/65uS
         KQBtcC9XUVzzalER2AYb7mToslQH7uMWcimYGrXBSQ4O199nw59vy/72AuvXALgsHaa3
         Yh8GKIpAzh847RCS4/SnzyWooyRlBnMutilcT1h32jw73SQ/EpyfPLUKHDl2V/f4zhgU
         tIlU0fDvCx0sjTDiwmx2W7mSN0RZfcoqpFwxicmd0Om/2aj4FCXrF4T/z52T6VcJN25a
         17XyuTw8cE6q7HK7/MzRludVN32brLt/Ykdb8OLLXjqRFLot3EzNiLVJcIe35d9yvF/u
         Kqog==
X-Gm-Message-State: AOJu0YzghLj16GA8J3EIdPaYPtf2w5shea0Zrt3k2+z+kxnJpSvISDyu
	N9lALezytTSbUNxlhyu32K2v0jt9kbG+c5h6corypyP2GLhbZgy/sah6ew==
X-Google-Smtp-Source: AGHT+IGxPL1lZy1HoZRuzn8O95xRV7u4oSpQEw6RLUJSoIfvTaoXICpK7l6vrH5vNyJqVj9iDXrCbw==
X-Received: by 2002:a05:600c:1f96:b0:431:58c4:2eb9 with SMTP id 5b1f17b1804b1-432df71b177mr2512265e9.3.1731620449515;
        Thu, 14 Nov 2024 13:40:49 -0800 (PST)
Received: from x230.suse.cz (gw1.ms-free.net. [185.243.124.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fe73sm36533185e9.20.2024.11.14.13.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 13:40:49 -0800 (PST)
From: Petr Vorel <petr.vorel@gmail.com>
To: linux-nfs@vger.kernel.org
Cc: Petr Vorel <petr.vorel@gmail.com>,
	Steve Dickson <SteveD@RedHat.com>,
	Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: [PATCH rpcbind 1/1] configure.ac: Add check for systemd-escape
Date: Thu, 14 Nov 2024 22:40:44 +0100
Message-ID: <20241114214044.1099257-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

364b7fef added dependency on systemd-escape. Although it's mostly
installed on development machines, there are systems without it.

Warn properly when it is missing, because warning like this can be
easily overlooked:
./configure: line 26206: systemd-escape: command not found

Reported-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 configure.ac | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure.ac b/configure.ac
index 9a8e3ce1..b3eb35b1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -705,6 +705,8 @@ AC_CONFIG_COMMANDS_PRE([eval eval _statedir=$statedir])
 if test "$statedir" = "/var/lib/nfs"; then
 	rpc_pipefsmount="var-lib-nfs-rpc_pipefs.mount"
 else
+	AC_CHECK_PROG(SYSTEMD_ESCAPE, systemd-escape, true)
+	test -z "$SYSTEMD_ESCAPE" && AC_MSG_ERROR([systemd-escape required])
 	rpc_pipefsmount="$(systemd-escape -p "$statedir/rpc_pipefs").mount"
 fi
 AC_SUBST(rpc_pipefsmount)
-- 
2.45.2


