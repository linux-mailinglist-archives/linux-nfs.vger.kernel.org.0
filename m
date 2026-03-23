Return-Path: <linux-nfs+bounces-20339-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKRiMM6zwWnlUgQAu9opvQ
	(envelope-from <linux-nfs+bounces-20339-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 22:42:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8272FDE33
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 22:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CAFC3055606
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 21:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91A037268A;
	Mon, 23 Mar 2026 21:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RumkR2cW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59106376BE5
	for <linux-nfs@vger.kernel.org>; Mon, 23 Mar 2026 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302108; cv=none; b=YnuDDlTT2PiTRQnqcYML21X0pSmdSVGt8Aiey0Js9XcgEbYELK/qxED6EZ/M4bLIiogXoEACjiPVKhH0Vr8SzwI2MLzR33zjQhYMaMDsEkPVIOaTczoS3gZVMX4cxyCFjOyg41zY8mwWWVPcXgLttE/8voN3w79cBHvtZx/834k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302108; c=relaxed/simple;
	bh=cx7IxrVtG6jBbtfVIc2mXJy3yhUWbxhYQF9v7xm0jIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uoqFF5JHXEJTOB6ao1GKgdqYMDJmjtiv1GR2Yor1AtPcgsAFqze7HCEuvNnzpIIgwjrniBuJP+TlpUtdocu+6Y/cqoyha9O3/wgxa3FfBSSHVGzJIZjCZDoHirRtWUkzR7t6p6sx/7IhjRNTvSP5LL9doYKXhVoUW1QsaRGIEEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RumkR2cW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so6579515e9.1
        for <linux-nfs@vger.kernel.org>; Mon, 23 Mar 2026 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774302106; x=1774906906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RwUz9DsG6Yh4YcejvaSJvj8Cg92DdW9RYhyMqthbjMQ=;
        b=RumkR2cWYLhIRGgKrU7I1NGMNmeVEMsVOoNJgNfMLxc51odqnajczvRSAcM8X4k65F
         L0lWQr5kn9kYMniSmogYb+GSowrlvMGi8gTovC7I9A+5Ycjrm7dHtVpGrA2h+400lDfu
         g1G02mEzjUywazplrP8YaVBnfdVRltY1nIOwB5vTYFypFLi6KFVrQf9839fVDU2g5YrM
         Qw4Hc+5n1JH9uPxD8vDE6/jxPs9mqq+gzM/uxPmM+qpPMzaVRtf2OSsbhUvgKAaIFK8T
         bw4D8rVZiMeJKTi4ROXtr8qFKNCmFJNu9r+JBOfq8A/YfLNGmxEMg5mGcBpsppSz7oj3
         PxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774302106; x=1774906906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwUz9DsG6Yh4YcejvaSJvj8Cg92DdW9RYhyMqthbjMQ=;
        b=mGCrZThMMbzVu34lhVGaFIhmBQ1bJ0pYipyVjCY1asfr49PKOuJgf7J5k6jvBfCL04
         0/MkTcrTb4seaRt5kLLkrI8/egQH7yYwnSGb6+kesVh5Pj4GIB9LGnxMj4oG1VPLixWT
         IbhOh7tkxd7vyGCM6PNuEd0hlx/p8ex3yJ5xZIt5imRm/OTfXdQyU4+F9VWJRJz6ZHuP
         nWA0bKB/jcbBWR1bK9x47Mo9C5BsXd/Y/SWiPBINAaYiIbzrxDnAL+8+zGRBYjQrmINs
         uV0rweB6wU9jC42jRsCIqn4744SX0ysWpDecDATzr41KygUpX1SjZfeJKelHeFs1jjYA
         MsNA==
X-Gm-Message-State: AOJu0Yx+dIc+/ahF6c2780KTbnOmy8B8lWK1yPlwd812u9gcsECnaSnv
	Gyszz5I7J0TtDdh8Yrd8jHtQi5rSPX+O9jqn0fePeE61FNeVu3DiuKGSilY45Upm
X-Gm-Gg: ATEYQzxcrqqziMTEE9YGhzd/i5zESTr8CZgcv/UxuDftqa2/K+NKMjl1pdNuvjKL7TO
	cTKHSiSwmlDPcTvH9TCo4Br7qRk1T2QtOt2hZ0FMAlrVLRN5b0wT0v4snSDIIQvEVnF0ZdJqA/X
	neP5vw4vGXD3Yym9ejoybdcWypVJXhoX1nakCWtjrqdJebFivX6QkC6oC3xCXK2+OgoR/F/2B5h
	TQSTHj2nqwYqI3IzQtu6gbbovkHd8+kbnH5uu5qXyMVahwftJF8tcYpT8+p+pbUmx4Zr1ZgO/wG
	0ibITihSm6pdfTooWjs06DL7GofoJVIcJs5yQf42wgtfixa4CKqWlKBzk4cAwW7r2KLCRN/Ce4o
	lmO7gegexM8I1UeyT1nmWJx7wP3ozwY9SXu7kWsEhLpTdfbze8AflxcftQjlURD0PqqFmi7hSnK
	/LtzaMJJEhe9oW3iw7TPD1i1Ame7qNHBS2Bvq4w2GtzGauBUQWp3dXqj8TzdqIJ1PyKJHwpQ==
X-Received: by 2002:a05:600c:8b66:b0:486:f9d0:aac8 with SMTP id 5b1f17b1804b1-486fee0f835mr170089825e9.18.1774302105493;
        Mon, 23 Mar 2026 14:41:45 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711007753sm2830505e9.5.2026.03.23.14.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:41:44 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id B8B39BE2EE7; Mon, 23 Mar 2026 22:41:43 +0100 (CET)
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jeff Layton <jlayton@kernel.org>,
	Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] nfs.conf: nfsd: Reflect disable v4.0 by default value
Date: Mon, 23 Mar 2026 22:41:14 +0100
Message-ID: <20260323214113.3336878-2-carnil@debian.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20339-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,linux-nfs@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D8272FDE33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In bb3f98c848a0 ("nfsd: disable v4.0 by default") and 27b9d85dbc30
("nfsdctl: disable v4.0 by default") v4.0 was switched to be disabled by
default. For consistency reflect as well the 'default off' change in the
commented entry for vers4.0 in the nfsd section of the nfs.conf
configuration file.

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Steve Dickson <steved@redhat.com>
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 nfs.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs.conf b/nfs.conf
index 18a1b319a524..3628b2f2d540 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -71,7 +71,7 @@
 # tcp=y
 # vers3=y
 # vers4=y
-# vers4.0=y
+# vers4.0=n
 # vers4.1=y
 # vers4.2=y
 rdma=y
-- 
2.53.0


