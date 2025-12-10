Return-Path: <linux-nfs+bounces-17025-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EC0CB4050
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 22:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0921303C285
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 20:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43836329375;
	Wed, 10 Dec 2025 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg1h0L68"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D36324B2F
	for <linux-nfs@vger.kernel.org>; Wed, 10 Dec 2025 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765400398; cv=none; b=rncG/ta1b2urdvDP5kcA8Q+o/wpmxwfAEAXNoqSDrqrQ0o/EoTowhprm5XP4z9FuMDUNx0xQQ7DWrQ6VqmFWjQFV2S4/qZ7zB/QVo37No3RVIiZYqbzTpabQhSMirp6r6iFLfmpfSUailxharHeAar5jTSNayrBHEYnGesX75E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765400398; c=relaxed/simple;
	bh=CQZYjgaTKIMQBqXEPKw7WV1rVsbcuDpXZc/GcG9OzUM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D4Ynd7D7tW+I1hDtMDN4cBLx7/9Z+j2EVj5Xbw4INWIaKz/FTwjqvwsCRzz4LCHBCEhSxU27lZZpBnt+288jR1+lhI0vjsbBQl2BpvGa6laUEmjd4eWBgGTgWAFDgBNDdX6WgHtVOP9CtmbPF/YG3bHaASClGRjdyyYNLMBb0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg1h0L68; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6495c4577adso510023a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 10 Dec 2025 12:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765400395; x=1766005195; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hq3z5nkEBt5evD7mynrOORxKjeBu+75LtEPzk//dHmo=;
        b=lg1h0L68NMRGtFcEgFy+mcLqpAmgxBnMtNTqJoWsoDbzQGMbLEvG3C+8oFm5XmeAoq
         ZWtrpv0qQEv7rn6RGzrJktU6C5fwT9CVHnWtnNkznOg4KXlLnu9SfFOQD/oUoQJOeeZQ
         VcaHWeL1hYb4fyCVrH9UGeydGuUWQUWeznvOOu9v3vCovJBXf2nol/2ntizElYGRi6nv
         Y/oIsUKhwoSPM2tS2pRbL79YsE3TBNEWtPsH831juDMB7zXQ9LGX70aY6AxI8ittj/vK
         pzGO7Z6DMsZvXm1WGf5b2ykXm/Bh0iMX55Ra2CW+QEUmWNzTIN7NMgnABcNJKylmNaPv
         0U/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765400395; x=1766005195;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hq3z5nkEBt5evD7mynrOORxKjeBu+75LtEPzk//dHmo=;
        b=qFFc73Eo0MBM/jff0tFdAsRwpnjT4Gy5wBALkzI936l8Ki9SZbvQbeFXjlwfMaVFM3
         kE7FIkmZPUi+KugPwHgeMrB6My1dXFIWIvAdVIdbNvY4G8HleFUlvXjNRPECwJlA4G51
         LJc7CzaJBO75RvIIom8peaUt6105lgBzkTf+4oyG5cf2aESIOyYeMrWBM10a2rJjbgoO
         d3xgUWU/QXurnzmgD7rep7JAOtH9gSxKkrYvpxRJCi1Z2Vhhi61LnaTsGyvnWM8eApTN
         S/xq+yLdb5Ltw1NSiClwroQEGq98Zqtf7cUYz/CqDwrK+PmgSUxSuD2bu6HP+5fR44ES
         fW8w==
X-Forwarded-Encrypted: i=1; AJvYcCWG9kpadWDjK8YdLW04NaWmzrJTdQHzLIhDDHTjIRqI3f9M3+GxUPtMEg7Zl9XtX5Vf5dQ9J7gm3ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXEeX42ekyAayE4oTiGejjOmSh1zplL9i/gPoDN8gYcWjfEBsi
	5J1cMc4rguTPv/kWkVkl3A/P012uBRDK8bW7BkcAgExmi3wQElgLlFpW
X-Gm-Gg: ASbGncu5XLAWeMmUAxlM3AAFPJzNsN0pnhiH2b6qhLzc92omnI+9tQ5DDqdfgKeV9V/
	q53zQEiWPtzYXjOZ8pgO7BrMCFp2jWBRyi5WFaP2lCtVTZK2W357iL4h0tnWHyHdrwC2q0f+qud
	uLrejvcE/pVXyuWh76W6dKhqF/A0yNQJhHb+Km36rnbtcITdd2+Xobj5hhdFydZn8agR5jbVucj
	03GkGMgdgQyRNHgu0hubA48vc8tI5267A+8fVrcnNq/UzhG0pnpKEZv3jMtxgclMf9BVpLXUoFY
	XuJ2JxECjM+jT5XXdS2rvTv3J3upqvkb5PD8rM3V/3fKck9ZvDvxYhJfJJadnUAGLFpoVx/40hI
	7BQlQPenWy+TgIBZRBp5V0pCy9SSsj8yKHOR5Da85nEf/2zzFuVLFXOUchvkjcO5HLgBtaEvIil
	fu1OXyXAbedKrU/ETtuoPB2jf1iEP8XImdq4hxLOFBX0Rvr5DoxXBh6s4n3wiP
X-Google-Smtp-Source: AGHT+IElmdUsN+Pjvtv6mbFqAmh7xPGC+NhmlE0apjwJOYXgC2GK74hDTavhHYrEElc5Li9RPA8Afg==
X-Received: by 2002:a17:907:7250:b0:b76:c498:d40f with SMTP id a640c23a62f3a-b7ce82b6bc2mr433479366b.4.1765400394478;
        Wed, 10 Dec 2025 12:59:54 -0800 (PST)
Received: from raspberrypi (p200300f97f21d40007e88c368107f7e5.dip0.t-ipconnect.de. [2003:f9:7f21:d400:7e8:8c36:8107:f7e5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa5d0b0dsm55496866b.67.2025.12.10.12.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 12:59:54 -0800 (PST)
Date: Wed, 10 Dec 2025 21:59:53 +0100
From: Pycode <pycode42@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Removed unused variable
Message-ID: <aTnfSQJ4QsfwTSf0@raspberrypi>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Signed-off-by: Pycode <pycode42@gmail.com>

Removed the unused variable ret in
fs/nfs/flexfilelayout/flexfilelayoutdev.c

(Disclaimer this is my first patch, be sorry if I have done anything
wrong!)
---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index c55ea8fa3bfa..9cd04e85d52f 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -53,7 +53,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	u32 mp_count;
 	u32 version_count;
 	__be32 *p;
-	int i, ret = -ENOMEM;
+	int i = -ENOMEM;
 
 	/* set up xdr stream */
 	scratch = folio_alloc(gfp_flags, 0);
@@ -88,7 +88,6 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	if (list_empty(&dsaddrs)) {
 		dprintk("%s: no suitable DS addresses found\n",
 			__func__);
-		ret = -ENOMEDIUM;
 		goto out_err_drain_dsaddrs;
 	}
 
@@ -134,7 +133,6 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 			dprintk("%s: [%d] unsupported ds version %d-%d\n", __func__,
 				i, ds_versions[i].version,
 				ds_versions[i].minor_version);
-			ret = -EPROTONOSUPPORT;
 			goto out_err_drain_dsaddrs;
 		}
 
-- 
2.47.2


