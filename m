Return-Path: <linux-nfs+bounces-13929-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D3EB39B0A
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 13:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717171C26EE1
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 11:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3480D3081DC;
	Thu, 28 Aug 2025 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sn9m5bfW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162D82E371F
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379301; cv=none; b=PQ8Qw/ODuM4ydWRc5ZB1rRPuOHRmm5ClCY/4U7pMycLKZyMouOWTkbNZOYtAmZybrD31haHMFKuRI6Xy4N3LZ0EQ7G+74bEgf9LlkQsUwl+wEUJz+KT902HNNo7Wi3ceGUBzephuIbRrZme/rwm4bBn+Bh1rpu9nTFF3MKjfSnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379301; c=relaxed/simple;
	bh=E7Uc7TdlFewis1UFuO1TxJCe964Iks7ZCtQF86vc0HI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B7ZLgexCKGlzimEqJjxFYYHEOUpiKIXtgBjij8gX+AcDiCT1ZiJve+rQ2r8rG6/m9Y65nl6tL2drWfifV3vHQAyrph4LA5t2+ytrXaZLOQw1HTHRwGqebMm15CdYkaybgzbpfAFf5hxMkPYW7szoQf9ljy5OG9VSQMRXp+F/Yk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sn9m5bfW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c79f0a5b8bso639953f8f.1
        for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 04:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756379297; x=1756984097; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxRu2uQ7FfE61dGkwZoWWPCA3TPlzY1BxybUv04x8Ws=;
        b=sn9m5bfWKxRF4OmyMtBrdAnm+Ju83E8d5tjIHrXHCoH0994pTPsBTdjSSbV/w0BLnt
         TCUau/cSCY/NjJTpIdCawzKAMFS285jnmdh/kyyYfNXz8KmzY+Euob9PkwXrFfkSRNBv
         dK2cYmqLmTvM9rurFjOwAdVQoVgPjr1oyTFHGAplrYkABSKEkLAUlnMcAMllnZVOVJ+W
         tBu14n/BdQlktc6m8VTpQe8B0OaRg9mT72bQfectWwyVpmdkN2qZorv7PWzzB1YVgVMe
         vOvMgVTWgwFJZo0+5RATZB5Hz4r7UfvsacrAT5y969kobm36MCCqnIL4E2AlWHznlw4f
         LOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756379297; x=1756984097;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxRu2uQ7FfE61dGkwZoWWPCA3TPlzY1BxybUv04x8Ws=;
        b=lz04SZy19yGlT31RSnUca2jQg0clc+gTA7QjlhpQ0qrs61JlIcWsVqpBtzcTRzSQRQ
         tJ1f40qww+VcBnqvav2oTzpvweqBGC571F+GvyjVF27knQ8DwXjD/4GZviOKQ1gw8zNO
         C2GGLHhLQjyPVPhv8zC72R+LqKnXn6ruJVtRtkzuhziVxExS2B0s09PUxN1XnEh/V97I
         7fepG05iKbiLdH4mOdO2vfb0VWK2E3ApIcrHdM6/pBUK9hudxo+Ox6c9JYG7lNmH/vh+
         6zYujZEZVoV3vn6Si+vEDrXFun/scHC30LCNMkXx0R+f5RUZ7qmySdc2uwAaDNyUoHiJ
         ACmg==
X-Gm-Message-State: AOJu0YyNAI86tTPGPmNlaxCXI4k2/7UEBDTWz1SPxk7QbIttgeEGNWHf
	+/3XXPg2zDAQz86yQ9IjDgQfssDI115MMcvE8ztUB2u1OqGHe2zOlnCgMQlNbjmoFVAXSVBLRyQ
	SprXR
X-Gm-Gg: ASbGncvIHitOO2y1pDIffukzaekoiD0bDlEfh2cG1Sc+kunCTFy8GEN+z/ivvXjPeAX
	L5uHbB5XVoHzjtGio3vKFi5P0j2CEEP7GxnEL1EbrpkkbKS0SjP8X2rxbAXeaUY2tEXfQsDjui9
	Y97HFt+58dkna+ef/l1v88N+b1oIdibi3QnAwv+z30yaXpwv2ASlgbh+pka59xLSya/4d2IRO/U
	XXOFCUX0q1UCvdZDXgPzjjgUm0UBVgKRLjFZB7z6g4Ojbe3/aUGgy2V5jR2pye6D2EkY74vRrWA
	zuY9J51x3MvPLRNRQ9FSqUJrwKfaP141hi9Knvx9G0y0Om1p9sNxMGzviKqA7NMiqgjlG8Vx1Ue
	fPA6q1IPWLsVUPGwGVKxv7MyQzvorjEjaQIPIQA==
X-Google-Smtp-Source: AGHT+IFCqVpVZkJSpHBS9SkCiDAw353tRTvGi0kyzJ3ZWhNV5RGy4Fj5vTkhJoIHm+NKu7yYotoVoA==
X-Received: by 2002:a05:6000:290b:b0:3cd:b3f7:bb62 with SMTP id ffacd0b85a97d-3cdb3f7bd7dmr2363708f8f.45.1756379297183;
        Thu, 28 Aug 2025 04:08:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b66c383b1sm55344245e9.3.2025.08.28.04.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 04:08:16 -0700 (PDT)
Date: Thu, 28 Aug 2025 14:08:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Cc: linux-nfs@vger.kernel.org
Subject: [bug report] pNFS/flexfiles: don't attempt pnfs on fatal DS errors
Message-ID: <aLA4nePqG4rAUXMU@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Tigran Mkrtchyan,

Commit f06bedfa62d5 ("pNFS/flexfiles: don't attempt pnfs on fatal DS
errors") from Jun 27, 2025 (linux-next), leads to the following
Smatch static checker warning:

	fs/nfs/flexfilelayout/flexfilelayout.c:880 ff_layout_pg_init_read()
	error: uninitialized symbol 'ds_idx'.

We recently changed ff_layout_choose_ds_for_read() from returning NULL to
returning error pointers.  There are two bugs.  One error path in
ff_layout_choose_ds_for_read() accidentally returns success.  And some
of the callers are still checking for NULL instead of error pointers.

Btw, I'm always promoting my blog about error pointers and NULL:
https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/
It's not really related here, since we should not mix error pointers
and NULL but I still link to it because that's what they taught me in
my Trump Wealth Institute course on Search Engine Optimization.

Here is what ff_layout_choose_ds_for_read() looks like:
fs/nfs/flexfilelayout/flexfilelayout.c
   758  static struct nfs4_pnfs_ds *
   759  ff_layout_choose_ds_for_read(struct pnfs_layout_segment *lseg,
   760                               u32 start_idx, u32 *best_idx,
   761                               bool check_device)
   762  {
   763          struct nfs4_ff_layout_segment *fls = FF_LAYOUT_LSEG(lseg);
   764          struct nfs4_ff_layout_mirror *mirror;
   765          struct nfs4_pnfs_ds *ds = ERR_PTR(-EAGAIN);
   766          u32 idx;
   767  
   768          /* mirrors are initially sorted by efficiency */
   769          for (idx = start_idx; idx < fls->mirror_array_cnt; idx++) {
   770                  mirror = FF_LAYOUT_COMP(lseg, idx);
   771                  ds = nfs4_ff_layout_prepare_ds(lseg, mirror, false);
   772                  if (IS_ERR(ds))
   773                          continue;
   774  
   775                  if (check_device &&
   776                      nfs4_test_deviceid_unavailable(&mirror->mirror_ds->id_node))
   777                          continue;

Bug #1:  If we hit this continue on the last iteration through the loop
then we return success and *best_idx is not initialized.  It should be:

		if (check_device &&
		    nfs4_test_deviceid_unavailable(&mirror->mirror_ds->id_node)) {
			ds = ERR_PTR(-EINVAL);
			continue;
		}

   778  
   779                  *best_idx = idx;
   780                  break;
   781          }
   782  
   783          return ds;
   784  }

Bug #2: The whole rest of the call tree expects NULL and not error pointers.
For example, ff_layout_get_ds_for_read():

fs/nfs/flexfilelayout/flexfilelayout.c
   812  static struct nfs4_pnfs_ds *
   813  ff_layout_get_ds_for_read(struct nfs_pageio_descriptor *pgio,
   814                            u32 *best_idx)
   815  {
   816          struct pnfs_layout_segment *lseg = pgio->pg_lseg;
   817          struct nfs4_pnfs_ds *ds;
   818  
   819          ds = ff_layout_choose_best_ds_for_read(lseg, pgio->pg_mirror_idx,
   820                                                 best_idx);
   821          if (ds || !pgio->pg_mirror_idx)
                    ^^
   822                  return ds;

This needs to check for error pointers.  But also if pgio->pg_mirror_idx
is zero, is that a success return?  I don't know...

   823          return ff_layout_choose_best_ds_for_read(lseg, 0, best_idx);
   824  }

fs/nfs/flexfilelayout/flexfilelayout.c
    842 static void
    843 ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
    844                         struct nfs_page *req)
    845 {
    846         struct nfs_pgio_mirror *pgm;
    847         struct nfs4_ff_layout_mirror *mirror;
    848         struct nfs4_pnfs_ds *ds;
    849         u32 ds_idx;
    850 
    851         if (NFS_SERVER(pgio->pg_inode)->flags &
    852                         (NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR))
    853                 pgio->pg_maxretrans = io_maxretrans;
    854 retry:
    855         pnfs_generic_pg_check_layout(pgio, req);
    856         /* Use full layout for now */
    857         if (!pgio->pg_lseg) {
    858                 ff_layout_pg_get_read(pgio, req, false);
    859                 if (!pgio->pg_lseg)
    860                         goto out_nolseg;
    861         }
    862         if (ff_layout_avoid_read_on_rw(pgio->pg_lseg)) {
    863                 ff_layout_pg_get_read(pgio, req, true);
    864                 if (!pgio->pg_lseg)
    865                         goto out_nolseg;
    866         }
    867         /* Reset wb_nio, since getting layout segment was successful */
    868         req->wb_nio = 0;
    869 
    870         ds = ff_layout_get_ds_for_read(pgio, &ds_idx);
    871         if (!ds) {
                ^^^^^^^^^^
This doesn't check for error pointers either.

    872                 if (!ff_layout_no_fallback_to_mds(pgio->pg_lseg))
    873                         goto out_mds;
    874                 pnfs_generic_pg_cleanup(pgio);
    875                 /* Sleep for 1 second before retrying */
    876                 ssleep(1);
    877                 goto retry;
    878         }
    879 
--> 880         mirror = FF_LAYOUT_COMP(pgio->pg_lseg, ds_idx);
                                                       ^^^^^^
Uninitialized.


regards,
dan carpenter

