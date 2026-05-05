Return-Path: <linux-nfs+bounces-21391-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAVkLsD8+WleFwMAu9opvQ
	(envelope-from <linux-nfs+bounces-21391-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 16:20:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E034CF47C
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 16:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC31B300B3E6
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2026 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF13426EC5;
	Tue,  5 May 2026 14:20:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF452F0661
	for <linux-nfs@vger.kernel.org>; Tue,  5 May 2026 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990844; cv=none; b=ldIhs1Xu3CaDU4by0CBSKOaOPSr3pUUSPRWSD78ansLzwdcv2nmbectqxshV8bFAAY9dWrLsbjrqm0yGZZ78dvub23RwmZLroZHUkFcI29227Sh5dDKqaa0BjvHo/O3lVG6dpuZuwDgMHsSD9ArHgdozZcPZMFOxZ/50aixEoUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990844; c=relaxed/simple;
	bh=/d0OBpGYVZpBV3j21ey/rUXXIkrSE+TxnRQFxYXpTuQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N2pe2+OIgCvziajwE5KoG4ExRFXRomSbt70y+x3DZQiMjw/m/eQmbR7HvsLb5D0IdxvsWAhfnpOjfP2R08XsZjMUZIrniGAQ5OO2X3hKlm8Iw16KPR1QuEdG2CXrMK4tr9YNQOZdYvOpy0B7N6YTMbbKnjrWmgWNaYf5TShRjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so84233675e9.2
        for <linux-nfs@vger.kernel.org>; Tue, 05 May 2026 07:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777990841; x=1778595641;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/Kk/WufcsnomHjx1AOXJoM5210I/9LDXcnNDou3dFw=;
        b=fj1Xt8wnu7GLdT3p9XRIYEOsTJaE4LKKHPpf1syEwvxP4HO3raQVkwe/qetP0EuB4+
         ADid2Xp3aPyybhR0tpKKIkV1AqtymgZRLZoQRTXhezvPG5O9KsMGqc+eDZk5WGKyD8tN
         N+JFC3lTfbZVc4WtHwRhJ/KUg+utKktxGwLkdUKfzPZCYk6ynxBaqPLZAA9tkoH3ukbN
         Oz3Bfw1p/XHk3vMMmWo5VLfnWnOXWyLPoO1O3ex11T7fze5f4Ww/Vh+D6IYdftHIDW9y
         IkI5e5wvsdsUmVhrQlnipbnPBpuTdyMoK7nFfL4a3SafRB99H9hRkibpdejUpEtg/K+f
         Pc1g==
X-Forwarded-Encrypted: i=1; AFNElJ++BLbF0lX7Ky42RYfv7j2DJdQtSHqW1SiUdL9qUgUzGE5AnPx02gLtlDfmdYtUmhH3C5mpxMoCGmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2OEZK01pP5UG8ldBjP7k32BKrxY64oEc0i7HdwyFuIduUHU0i
	fhKDTFC2eudfED5lerbIll7HavglmiA7FyE1rv3vppi+q6I6NQhqi3J5MT9JrQ==
X-Gm-Gg: AeBDiev3EtAem7Wttmv5TZ7+YykuF/A4g52aii0DMu9GvGljaOU+KSR/SIqaR/A1Dmi
	B+IGO3+q4PvPGHCCdkozWn20gYjuvnQeGUAU4Rou+aC9JyJZ3GX+kD1ekwoeZlZPDz7yJAsjeOX
	GYRh0QZ0AiBH/SFtI+olvSUk/D9+5nzbOGl/APUZTt2O4FaprFV3WajL4GRwgqFJqKLP2s8yMou
	Jg/kphG62akjDlngsukpv3lMRRiLmSKMgkx/wK61tY8XBOku7vzUTJHzUr9tt2ZqT3hmApczo+8
	GEdxEyI2Dc/aGEjj3E0M/6+0b3PzphkCWUarT+u2GW7qnt8WZs2l/Siz4YEOAqFQYxfwSLXip5I
	HVqbSblJafpYj8kBZhIFbkKhRGArfTd5m/d+22+ZPwqlVFSWJeOI9XepIHXLEs4iJTNai0RYlFL
	SZiqw8TD3r38FO5kRS9+IiAFGaZnSjqhr1RAzrQQLvtJdXGkI9s0Ue1DP3TculY/2W3yOpGR/7J
	ghKNd1ISzlByVRWdNA7Skqh
X-Received: by 2002:a05:600c:8590:b0:487:5c0:671f with SMTP id 5b1f17b1804b1-48a986381b8mr183901525e9.9.1777990841037;
        Tue, 05 May 2026 07:20:41 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69698sm633834915e9.1.2026.05.05.07.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 07:20:40 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH] nfs.man: Document mtls mount parameters cert_serial and privkey_serial
Date: Tue,  5 May 2026 17:20:38 +0300
Message-ID: <20260505142038.52921-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
Reply-To: sagi@grimberg.me
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 31E034CF47C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21391-lists,linux-nfs=lfdr.de];
	DMARC_NA(0.00)[grimberg.me];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sagi@grimberg.me];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sagi@grimberg.me,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.905];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Two new mount params for x.509 certificate and private key pair used
for mTLS authentication. These have been added a while ago, document
them officially.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 utils/mount/nfs.man | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 9a46157998b5..2cea501c9e03 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -624,6 +624,32 @@ the default behavior depends on the kernel version,
 but is usually equivalent to
 .BR "xprtsec=none" .
 .TP 1.5i
+.BI cert_serial= serial
+Specifies the serial number of a key stored in a Linux key Keyring.
+The key payload contains a DER-encoded client X.509 certificate used for RPC-with-TLS mutual
+authentication
+.RB ( xprtsec=mtls ).
+The TLS handshake daemon
+.RB ( tlshd (8))
+reads the key payload from this serial when performing the X.509
+client handshake.
+.I serial
+is a decimal integer. This key must be visible to the TLS handshake daemon.
+.TP 1.5i
+.BI privkey_serial= serial
+Specifies the serial number of a key stored in a Linux key Keyring.
+The key payload contains a DER-encoded client private key that matches the
+certificate selected by
+.BR cert_serial
+and used as well for RPC-with-TLS mutual authentication
+.RB ( xprtsec=mtls ).
+The TLS handshake daemon
+.RB ( tlshd (8))
+reads the key payload from this serial when performing the X.509
+client handshake.
+.I serial
+is a decimal integer. This key must be visible to the TLS handshake daemon.
+.TP 1.5i
 .BI noalignwrite
 This option disables the default behavior of extending buffered write operations
 to full page boundaries.
@@ -1973,7 +1999,9 @@ CONFIG_NFS_V4, CONFIG_NFS_V4_1, and CONFIG_NFS_V4_2.
 .BR rpc.idmapd (8),
 .BR rpc.gssd (8),
 .BR rpc.svcgssd (8),
-.BR kerberos (1)
+.BR kerberos (1),
+.BR tlshd (8),
+.BR tlshd.conf (5)
 .sp
 RFC 768 for the UDP specification.
 .br
-- 
2.43.0


