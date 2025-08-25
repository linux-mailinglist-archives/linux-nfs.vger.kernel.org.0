Return-Path: <linux-nfs+bounces-13881-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E976B3406A
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 15:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15701A84A98
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AA221257E;
	Mon, 25 Aug 2025 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxXTPYAv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C71E267B12;
	Mon, 25 Aug 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127495; cv=none; b=eotU2m92pp/cbF+k3zuR3pl2R8QOqxYIlkpekH8osobVx1giVu5qmTSi/ogB8PO9NXmuyCOc/bALfK0S0MRtj5Hqc1ru+RrT+ALPRZjwjvYjFvBWxhI1jfr+mfUFu1P0XDqvDGqWIg00NFlsfn3qz1wbL+NwBJ7WzK8Movsxxnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127495; c=relaxed/simple;
	bh=WQL44nqUEkOVb7tO4wNaDm6LA85RjkoatKVjByBKDZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lmkx+tg9RX/shzQ1BBqLyEtMYmg31qnlTH+vTD1URFxSl9PsOxlFO5McPxLYi+htlE0qZNq/xGxFFQiAYlLgB5pYKbd8VsbXTyrFnzN7QmB+/kaIvXTb8RGnAVM5dOxu6QffveQlaJvEuVRkBr6H8lZBZ6IccNGHUPQP8vxEuJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxXTPYAv; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f474af957so679866e87.1;
        Mon, 25 Aug 2025 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756127492; x=1756732292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5fw3ZMJHDqMnjQnhOh6MuUcNCVkHnMj73CqPHZAXRk=;
        b=TxXTPYAvNTt+3HLVVdHU5mJC7bBG5fzPzP0xxhduO0SwhniOATj99VcvrU/BwrdYE8
         7u5q2TSSBVj5HoHY8cgo85+8L3Liz2VLt9flsDyZRMAYnlHuk9FnAoZNVtgQb0LYEbtg
         0I+YyY96PVUYWzZA3oT43ovDrcFbxurmGJPnWHl4fY4t/9th9jeXiobOyTVpLhiM0wPK
         9sQlY22+EjSK8W9NuhclKp6zjZno9xIF8IqWrzeKkp67oPjP5GNL4ckd5PpLLOYKQ2tD
         koktVK3AI/ydjZLB5nchZne8Usb3dl/AtuTkTnkM/VEHSGDDU94kJI1479lg3VITNiIZ
         Op3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756127492; x=1756732292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5fw3ZMJHDqMnjQnhOh6MuUcNCVkHnMj73CqPHZAXRk=;
        b=BqiYyk6VFA4t3XM8a8C5VrHdIJKOROHeI+z7qYkOpgrcNH0YOXvAQJSUYljvC/eFPH
         B5JvMKeqQ/9x6tErD8IBoCsVcTSfESbovWUep1AHGTUbM0jJw5PeF+yEyLN55KMm0/kz
         /fUnSeXl7MekBCizrTpJYAbxHj0pkeF3kw/RjOTfz48A6URCoc9aJClmy4zmCLurzC+l
         UO/YL5orXF/dBC8qKMRwSeeS8XYISQp7fg0AUjeL2p8lYKK2CpK2lwfBHxTu0xWClbnz
         16hG7CUBKGlP/hpKIXDd/lDxPkr/D8QfVEE2kJHq1vAK3ugbfaheBtHGv1omd1WfyVbj
         DniA==
X-Forwarded-Encrypted: i=1; AJvYcCWr1UQkFl+iMUsF2iloyfJZAqfLL8YR+h24VDYvabHRpEpGqYWfIxRf4+jue1nxRT905GBPMx7tGQeDavM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ0WyQ/tJKig4woIWK310KzVpt2j/GHzQDcm3sWD/0A1hgTMpg
	6Po2m0kLOkzZhzmWa2nEkPPJTJGisy+nSglmWJxjbRy+8qZZy1pNAmzMWBoIRF92
X-Gm-Gg: ASbGncvFk6b3lPU4AoEQmXF1PUOwqEEKE993qG9ObOYYPnVFe+eVvCLQApjhOXGfjmX
	aQz25op6A+JVUMfFm1SrLf4Q4oY4ZDGc9+EEzgeeCRrspX8ZSWRrVmiaSjIWO2Vkp+HWt8rLr68
	dt1D0tuvIVRSxIX1hydnQ3WSFhAVRSf6VTELDUR1zhX5lb6i/15LbWP0aExFVR7M3YkaKcX00Uv
	IDnQu5/i2MCDln7Lfkzj396mviSSGFSv9MVCYkLC2upnFdp456xhhN9Rcwz3oHr19JIz3JaAXMd
	NmpJV46pYygPZzy0GrjrNPAFbIFNG4xWzft+rekHQMRmJk97rQ8Od2VLO6doTF1OoDBkzVZ7kr1
	yerwtY7zwX4MGCO1jDy7h8XDwZwK+WAvifxHYVQ04SVr2CZBZQXm09oolJ4FU9lk=
X-Google-Smtp-Source: AGHT+IEhu8aaFR/Z0VBtFPeItxhOzCa+vetNd7ZA5b9sNVOYebl/5UglxJm9QDnAHDOlHqGih4v2lA==
X-Received: by 2002:ac2:4f09:0:b0:55f:4711:cf87 with SMTP id 2adb3069b0e04-55f4711d252mr809942e87.41.1756127491260;
        Mon, 25 Aug 2025 06:11:31 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([85.174.193.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c12423sm1613685e87.51.2025.08.25.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:11:30 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: [PATCH] NFSD: Disallow layoutget during grace period
Date: Mon, 25 Aug 2025 16:11:02 +0300
Message-ID: <20250825131122.98410-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the server is recovering from a reboot and is in a grace period,
any operation that may result in deletion or reallocation of block
extents should not be allowed. See RFC 8881, section 18.43.3.

If multiple clients write data to the same file, rebooting the server
during writing may result in file corruption. In the worst case, the
exported XFS may also become corrupted. Observed this behavior while
testing pNFS block volume setup.

Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfsd/nfs4proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index bfebe6e25638a..3000b43be9221 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2435,6 +2435,7 @@ static __be32
 nfsd4_layoutget(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
 {
+	struct net *net = SVC_NET(rqstp);
 	struct nfsd4_layoutget *lgp = &u->layoutget;
 	struct svc_fh *current_fh = &cstate->current_fh;
 	const struct nfsd4_layout_ops *ops;
@@ -2486,6 +2487,10 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
 	if (lgp->lg_seg.length == 0)
 		goto out;
 
+	nfserr = nfserr_grace;
+	if (locks_in_grace(net))
+		goto out;
+
 	nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate, &lgp->lg_sid,
 						true, lgp->lg_layout_type, &ls);
 	if (nfserr) {
-- 
2.43.0


