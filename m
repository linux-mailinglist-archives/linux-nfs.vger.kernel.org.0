Return-Path: <linux-nfs+bounces-13081-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D806B0630B
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 17:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EECE189971B
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 15:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739C719ADA2;
	Tue, 15 Jul 2025 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUlMXYXV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999F12566;
	Tue, 15 Jul 2025 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593663; cv=none; b=RZRdLOJiRiMUFTf94Ld2/Fm6+njch6J706+TLrImDSbaNn1oTsH62yQgpvBQB95sAaAD0aGY05rqRxyt4LYcW/5UqcUoPkuZrZg542nUOl0pb3N4P8Cn77tBypTiee1FMNalcPbKBym1cGWWhw3J03dS65YxzQh5Om072i+sviA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593663; c=relaxed/simple;
	bh=jWXJkdMExanq1YlOIvO0J4rSXugA5nzucWUyfwphbFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B01afmSLPlpcSCD2DQRp5tUAazb7x0pPEmaroEjE2xykudnkgnUSW011vw44pPPkjoRpz1JiDTMND9yjMaWV+xqCMhTnedYLOr8FVqPjuUCb9a//yuHC06D5qGwZ/+oxGdcJH5omZFDVJoCvklLydd0OmaMCIPKhWy0RuF97SVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUlMXYXV; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553b16a0e38so5871357e87.1;
        Tue, 15 Jul 2025 08:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752593659; x=1753198459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixADBVnIqNcUON2e7BpnBQozPltpp8iiDxc4IJSiQQs=;
        b=SUlMXYXVsC08Ys5Idd1IkfvKWz5j++HC2ddA0m04JDd/0IZyl7pyZg9uZt/TZtLI3d
         elXcxrgS+EjAGM8J+SU/Foj2vdLrhr/Y/Vro67yrDtsXAJW2jiUZminzTUM7hmcZEM3H
         GegeHkbS60Iho/Nm1YsjiOttaOopOc+2EaNxFaOXDHZRtg6HMR5e40SR1fo06Ab/RzFY
         LYFOk3BNYDVMKoGPURRC9JJ3mqTZbq3cvIZttBAqBzhenyLtzmZfDajKo3K7F7gpBKud
         aCNQs+UP+vQa9GzO/dRp5xBHQM5WsvquanSkkpS8M1moSJOIbiw5445Lts3xUIUujwro
         I1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593659; x=1753198459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixADBVnIqNcUON2e7BpnBQozPltpp8iiDxc4IJSiQQs=;
        b=WZQbeDFI8xo70bYbfzZMohIhNmoB7GbjLmc55GK4xrgS7Paz8WqbPHO1Z7+2zi26id
         ZeReJL06ecP99QagQ/LlJtEjRDyCVwqQynt8iL2cU0eRpyxuCpBdtVulfqs7u7qfW6k9
         aT30UT7v7bzP+IGcl8TGOMOalF4Uv3n7uNoJC9dsTBq7s7Le6OBS016bMteLJ6+yCI6g
         dwBLE1V6LnqWiY0RoJLxXP7CwFugnGPBCJkfsArsLc9AZREaUFML6OeUSh8/yWP8mF1w
         J1soHapYJQsPxh0qX4C/qwo4ss8arRDmXroFE88Cmi9bluUgi0wMjz7V/p0E+ZqPFIPG
         LxFw==
X-Forwarded-Encrypted: i=1; AJvYcCXPzuaM0YdHfMvWSMCcInUFmWaNrv7YY44Y54LGZh5ccAL54cFoNlThgP5wIrqcWdg8dU8fyJCu9F/Kg/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzPiccj3Arwsw/qdSmmCzyK5kuT1l2LTbrlmqw59D6fCKuR0Ew
	EvZgbvBB2ZhhdYcY5thbEwPnQp0a+xXDkz3U08OzBSKAM1ddT5Rqqq4Z
X-Gm-Gg: ASbGncviXR6ce99CBpRvzYBqiY34+x2gEfA4xewIlU7Tsy0Iy7TMQ0/OGZ9afgjRU+D
	SdJJGlndfCTwaeO++CEsERW0YhmkjIUN9X7oSsZf+ARDhBQdHema8peQ1mLo74WJo0jBPSUVkxq
	7KzZKI8Xc484eoJRJGSLn0fv6b7ww+1IPBb+PwdFHU5il9NcDGybPIN7VQo0igNau9R4Qo+2RQh
	njwjCyQt03t3P2pQlnYj5+hF/egCuVeJxhwJ+d5mukCb0d+6FDwaiGxz7MEWL3lFsU2xRZCjnj0
	uPOFsim3rqVGqeydU0Wh9YIPUM2zX2WZs+opIiSdM/vOWQ4swKydQcwZTMFth+cn0iuij9rZEjp
	89DSk9S4Cu824cJcYSbo/6fTZT1kmlhhZd9m+wMl0FbQ0ocLoVkA=
X-Google-Smtp-Source: AGHT+IE4adUPJWTkAj0zeJViVlW3lMzcBMU+nd78EvAjz/9JbFajMuOfpMO6N+hRcS/mB9RIHZ79OA==
X-Received: by 2002:a05:6512:2390:b0:553:35ca:592a with SMTP id 2adb3069b0e04-55a04678767mr5587022e87.52.1752593658439;
        Tue, 15 Jul 2025 08:34:18 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([85.174.192.104])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7e9c7dsm2316482e87.64.2025.07.15.08.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:34:18 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/3] NFSD: Minor cleanup in layoutcommit processing
Date: Tue, 15 Jul 2025 18:32:18 +0300
Message-ID: <20250715153319.37428-2-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715153319.37428-1-sergeybashirov@gmail.com>
References: <20250715153319.37428-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove dprintk in nfsd4_layoutcommit. These are not needed
in day to day usage, and the information is also available
in Wireshark when capturing NFS traffic.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfsd/nfs4proc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 85ee486ce0caa..656b2e7d88407 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2492,18 +2492,12 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	inode = d_inode(current_fh->fh_dentry);
 
 	nfserr = nfserr_inval;
-	if (new_size <= seg->offset) {
-		dprintk("pnfsd: last write before layout segment\n");
+	if (new_size <= seg->offset)
 		goto out;
-	}
-	if (new_size > seg->offset + seg->length) {
-		dprintk("pnfsd: last write beyond layout segment\n");
+	if (new_size > seg->offset + seg->length)
 		goto out;
-	}
-	if (!lcp->lc_newoffset && new_size > i_size_read(inode)) {
-		dprintk("pnfsd: layoutcommit beyond EOF\n");
+	if (!lcp->lc_newoffset && new_size > i_size_read(inode))
 		goto out;
-	}
 
 	nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate, &lcp->lc_sid,
 						false, lcp->lc_layout_type,
-- 
2.43.0


