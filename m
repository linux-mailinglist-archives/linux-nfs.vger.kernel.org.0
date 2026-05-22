Return-Path: <linux-nfs+bounces-21842-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKDzNrTJEGpAdwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21842-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 23:25:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCAB5BA672
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 23:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BB523008D0E
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF19388E58;
	Fri, 22 May 2026 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/ji/YRG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D868B384CF4
	for <linux-nfs@vger.kernel.org>; Fri, 22 May 2026 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484988; cv=pass; b=GeKRB9Syb8cu5qr0KZaNtsPeoH4Vf1Q0fJyhIP2wJP+WxESdFqR/458uT/83/4thjYgzu7Zfi16aPWW1oZQFzPJydIXP2CFDk3X0dqyOM3NfPnP0poHWQOV2NhAKCSSYNSycbxq1eCYMgVizPtyAwyr6Z6Oz0okeZOwLGKZEd0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484988; c=relaxed/simple;
	bh=Q9C5fj4fC8wUK0uEXadSq8iP3msdsskh+VoPWf8ltMY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=roKhdzDYeJJwInrkUCRIpJQUtCA+JNb6rcrPm+Z5gH2YZ65Z4/6Mat2ZM3EJhbcJWojAIKQfjP4YNSxCsteLs/n9njKhtNibgU4tCdYCWtEj9ujED90wUBjI2H5xebHJkCC/NMKBBjQnmmBpR2IqUkJ/FpEfllGNmSvpEdpleVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/ji/YRG; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-672645dbfeaso9874617a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 22 May 2026 14:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779484984; cv=none;
        d=google.com; s=arc-20240605;
        b=FPmz6n6A//8jbYaWqmBOYfsN0Dj8kSZN8xJdEpOgzPiq39qtPuC49RGufsXeusXfaJ
         sQh9nAwgGFg3LPq2YwPBGfwxp5RZiCs4gRW0tvE0SHOV2s+pcmSmLcwiAz9LGnUIn22d
         8RgZYFrQ6H1K4IrBF7BIamyCTMHmF6rqU3I8mWy5Xj+8SkmtzlPPKHlzsvvT59TCsedI
         Ltg1z0WoGUGZQTkXCWWZrwr7do4Rpv/YDQxuKVU/two5VEI2HCxVEj9+KjjcPCRQwly9
         84BMAq7D06WkhSZkPH46vrxwgsXRZ+NWV4czm0mAcO6PJpVW2LZhO+rLFdezWETliLvZ
         VXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Q9C5fj4fC8wUK0uEXadSq8iP3msdsskh+VoPWf8ltMY=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=Gs38ZTCJtBvMGMf73A3haMXbeQIrEf/wHWJX58a8kPIsWBuqfs+rfZ+7RbfjxHEgUF
         68z46bMefL58BcWC0KyHHhuYvsa2ltXxW1pXPl5xJXN1unY96A4XnJPBzYGSjQSXub0U
         jW0OGarXnr+Yyk0JRaDlieISnIsKTaiM8XM7ltRqoT2cjh010fgTki7krrLxKfJaxy1+
         Ai2uI8+BgQRRqaSzrutoRhP0EIl1pHTp7/cQZHEgNdIv/F5DGTy8/Me62rzolgHII8k9
         87miJL8zkRQyPJifaUh+UZa/Psoc8dA34+n7KIR3RosWvVdsoMgBDNWBDd8R5hfBHUQm
         ZeKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779484984; x=1780089784; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q9C5fj4fC8wUK0uEXadSq8iP3msdsskh+VoPWf8ltMY=;
        b=h/ji/YRGcXdQgm6n7sIxzTwrJ8PxKdlFK4G0dr1q6YofBhXOv3rx/MaVbxQzENCWWO
         J6+HDOB9tkSojAUXd3o+kOJnQy+5PYpY22L1n3OsHaim1AKRRz5DvaGlObjcG+ajKqH2
         FxXr4Nyqt0t3SatXhjS7ffjOOIag1zRslZS4YK1dbW8hGK6q0l38EHO4NBzTJ/e1ryni
         u//Gn5Y1dL3Dr+zU7ZXkGm5bTPoXmBlmjQhB7WAttpIMMlkEewZpubkbcz79roHkqcf5
         Gi4vN5ZAqut1h/I+6tYExrtUybU/uGMPc0t7juWAR5oNIoYGF82LhJmaoHAG5azedXYv
         QoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779484984; x=1780089784;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9C5fj4fC8wUK0uEXadSq8iP3msdsskh+VoPWf8ltMY=;
        b=DnpJ01X36HChZV9jNham9c1lPlsAPV8ybN1w+SD2/yyHa39fjNG3FqDuApv3/qRhbc
         H8IYXLB1o4t0QkT03WE9P9+ih79orHkLrvYhi7+GgEXS9LikDquTouEQalE9FRNDY93y
         WNlqF3qlM2/pUK8bGpysEsc7Go2pZc0unlCchvfbXcuEf4n40utTcS9/pp+vUWw7VlZe
         8HNrXTaOEH3Wus/jt3GedmfKzbqvzwgDjXt/mZzzWm3VRYd5v722rs93n59FBcxooIFg
         LUFa5pRfidSCspjEutNUuJI6ZXyJDr9HIfK6gK/eH4SerCFyHqv0karoQEtvV3S1u8AV
         3B4g==
X-Gm-Message-State: AOJu0Yx6DWkRnkTvlAIS+XMr/fYymLB5pHiABf6id77OhT0/zf0Kuj9K
	M/0+/TxUNqAkNVRzcWVeaVEmagR8ZD2p+W0p6cNSqu0iWD9dpcgM8YtWEkDw2beal+IAQJzZguR
	cqFWEaX634qny0cq9a5aMHvS4BIQcL6qC
X-Gm-Gg: Acq92OFYWt+vNA/RmU7+tnUzwtxxJV8ff+a8+BMIDMtfzwwk9vhrFVWK+YSf7gwH3xJ
	OU0Cw/K2+1eIzLbMpJDoyZRJ8P7Vi1cEuPV8juVrWNEdujmbVnHo7hv+zpCpLqQYDQPejsbwFez
	KbkICa/TeMMTixh7QsL7l9/k7f6Ryfk6XxXZRiWpY3iL/vyzSbAeNsPxHz4r3odmU0huiK4OiUX
	4Sdq7HLQWmka2dgjBVEfRnF0FOUYrq2Z8Ep/25ozv+ypejFscsVnRscrKUkbz/6g67AFQDzsL6v
	dXZ9FXfJFSvyurF5S61M/MGbpvlpu0JD5yIg1JweUyLH8YD0ug==
X-Received: by 2002:a05:6402:241a:b0:687:f05d:7cb6 with SMTP id
 4fb4d7f45d1cf-6889c406c7bmr2800578a12.5.1779484984021; Fri, 22 May 2026
 14:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 22 May 2026 14:22:50 -0700
X-Gm-Features: AVHnY4JEJcYI5nUJE8Zu2LacUuh5m2QE320jP-GZu6yWDcMyTQ_xc6EKKC_barE
Message-ID: <CAM5tNy4OxnoqYvWhmyr7Ksk0Cc12_Zdn22fwoe+N=Z_3GYpapg@mail.gmail.com>
Subject: striped flex file client patches
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-21842-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rickmacklem@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BCCAB5BA672
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Hopefully you mind a dumb ass question..

Are the patches for handling striped flex files pNFS
for the client in a kernel on kernel.org now, or where
is the best place to grab them from?

Thanks, rick

