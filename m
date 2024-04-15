Return-Path: <linux-nfs+bounces-2800-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B718A49CB
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 10:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C7AB22C82
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 08:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4D536AF5;
	Mon, 15 Apr 2024 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RI0DRh+d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E771EEE3
	for <linux-nfs@vger.kernel.org>; Mon, 15 Apr 2024 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168501; cv=none; b=X9oWwc8DEbZZjEudIKWY9AKxNknUniK3Gfx7ZQu7gmK/ETDBurE8qVBfQZjfWgKEoCoxDKTdgNXht8FJOY7tONhsawcOXlzk4SP9zbJr7yt5jtjPmERndpEqLA8c2Y8gmunkHiBBrWL3PGfm2yEbldxJdGfujA8+kEmm3WNpAf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168501; c=relaxed/simple;
	bh=4k1+4otvTBDZ5PYJxpuNKBp2vFCkxJXtOC/UxYp6ShE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nxBhL15KQxUSOV41J4GV6KTt1gikjP4blDptlpu3N+CoplfcnRVqDND2Aa1l2O7+OO3dP5+wlCrChqJuNHNzgyW1Je/G28U5oaURvyaPXcQjZJM0Vom4Pb6o668UfJosHMpppx9ZPFqiU5zu8buJvl4HKOwqu9bD6ecrq++ipSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RI0DRh+d; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5200afe39eso354837666b.1
        for <linux-nfs@vger.kernel.org>; Mon, 15 Apr 2024 01:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713168498; x=1713773298; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/hA4hQvVgvC/Y1aNKNgrMzgdLDcJtsyBuGFjluaf/k=;
        b=RI0DRh+diJNQF2F/U9vefSV5DBMC61Z6xtFrWj+N2joIZjgIbcqyeWqjPyUqTWDPFo
         oPGID1ju1jdlJC8xv0sv1ddy9UQCdHuxgm3Tjlu73DKxmBL/szg3SBMuj4trj7mcNuum
         LZEaLQygzzc1yvDg0VBW6XGtwEhcTsKSaIafJABoRA+doA8GZ54Bfr4toaept+7V2Dvw
         EvSDuyVepWRB39/ZHrn3uB91UQE6djnbMq4pG79WHx9iY2pFgvDCbj5sLIVxLs5AML6O
         Uvl59kLE1WjofTECdkexx8sai2deJkicnpniUkFjEj5MIc8CP7JX3GJizvNvLQHQZ169
         CE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713168498; x=1713773298;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/hA4hQvVgvC/Y1aNKNgrMzgdLDcJtsyBuGFjluaf/k=;
        b=jYRNxbKXWbMy9Azyzmo7/M0mf1jlCFi1hymVwNs14QKLhNakm9Xq0em/FxnDEA0R1a
         Oihe3OEiZywHILNNCRC3MrcVZ/1qcGuj6B65eTYej41I7h3eCP4/dfJqkDEB39BF9kjw
         BYLrKtDZqa/CnDP1i3JHBbdE6lZDrahO/UdUuVkMrZgO8N6RZx8iF8LgfbBuVYd9H6ts
         S+AsQhz5WwR4AXHeBu1sSa4jv2y4xoYqOF23xGkfoOS2VvC+fmzgBrHUKYVu0AH9vv5b
         Tns1LbwHTSdvt63QBnUcz/f7qPe+BdD4t+y0Bxz+cIzx3q532AqU8wcozOBcLkzW2Fqn
         vR4g==
X-Gm-Message-State: AOJu0YyVxkeUEMMPspAXzAl12Pblbg6D5efMNHBp4IJfb8k0i0kdYy/B
	PWgJXGWtCJNjBchLkcE83/HH9UKtfg8TsL2/THo3dBZpnjciGGMeg/qtfQV6Uog=
X-Google-Smtp-Source: AGHT+IGtHPlfGFwukmR/LHy7vTJI6h0xW66eI/KoUVVKTGMN9Gq4FeRhPAar1/iR4PfuclEmY+Vocg==
X-Received: by 2002:a17:907:72c9:b0:a52:53f3:af3c with SMTP id du9-20020a17090772c900b00a5253f3af3cmr4434105ejc.10.1713168497724;
        Mon, 15 Apr 2024 01:08:17 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id dm3-20020a170907948300b00a523b03a1edsm3848767ejc.20.2024.04.15.01.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:08:17 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:08:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: bcodding@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [bug report] NFSv4: Fix free of uninitialized nfs4_label on referral
 lookup.
Message-ID: <ae03a217-e643-4127-bb4a-4993ad6a9d00@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ Why is Smatch only complaining now, 2 years later??? It is a mystery.
  -dan ]

Hello Benjamin Coddington,

Commit c3ed222745d9 ("NFSv4: Fix free of uninitialized nfs4_label on
referral lookup.") from May 14, 2022 (linux-next), leads to the
following Smatch static checker warning:

	fs/nfs/nfs4state.c:2138 nfs4_try_migration()
	warn: missing error code here? 'nfs_alloc_fattr()' failed. 'result' = '0'

fs/nfs/nfs4state.c
    2115 static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred)
    2116 {
    2117         struct nfs_client *clp = server->nfs_client;
    2118         struct nfs4_fs_locations *locations = NULL;
    2119         struct inode *inode;
    2120         struct page *page;
    2121         int status, result;
    2122 
    2123         dprintk("--> %s: FSID %llx:%llx on \"%s\"\n", __func__,
    2124                         (unsigned long long)server->fsid.major,
    2125                         (unsigned long long)server->fsid.minor,
    2126                         clp->cl_hostname);
    2127 
    2128         result = 0;
                 ^^^^^^^^^^^

    2129         page = alloc_page(GFP_KERNEL);
    2130         locations = kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
    2131         if (page == NULL || locations == NULL) {
    2132                 dprintk("<-- %s: no memory\n", __func__);
    2133                 goto out;
                         ^^^^^^^^
Success.

    2134         }
    2135         locations->fattr = nfs_alloc_fattr();
    2136         if (locations->fattr == NULL) {
    2137                 dprintk("<-- %s: no memory\n", __func__);
--> 2138                 goto out;
                         ^^^^^^^^^
Here too.

    2139         }
    2140 
    2141         inode = d_inode(server->super->s_root);
    2142         result = nfs4_proc_get_locations(server, NFS_FH(inode), locations,
    2143                                          page, cred);
    2144         if (result) {
    2145                 dprintk("<-- %s: failed to retrieve fs_locations: %d\n",
    2146                         __func__, result);
    2147                 goto out;
    2148         }
    2149 
    2150         result = -NFS4ERR_NXIO;
    2151         if (!locations->nlocations)
    2152                 goto out;
    2153 
    2154         if (!(locations->fattr->valid & NFS_ATTR_FATTR_V4_LOCATIONS)) {
    2155                 dprintk("<-- %s: No fs_locations data, migration skipped\n",
    2156                         __func__);
    2157                 goto out;
    2158         }
    2159 
    2160         status = nfs4_begin_drain_session(clp);
    2161         if (status != 0) {
    2162                 result = status;
    2163                 goto out;
    2164         }
    2165 
    2166         status = nfs4_replace_transport(server, locations);
    2167         if (status != 0) {
    2168                 dprintk("<-- %s: failed to replace transport: %d\n",
    2169                         __func__, status);
    2170                 goto out;
    2171         }
    2172 
    2173         result = 0;
    2174         dprintk("<-- %s: migration succeeded\n", __func__);
    2175 
    2176 out:
    2177         if (page != NULL)
    2178                 __free_page(page);
    2179         if (locations != NULL)
    2180                 kfree(locations->fattr);
    2181         kfree(locations);
    2182         if (result) {
    2183                 pr_err("NFS: migration recovery failed (server %s)\n",
    2184                                 clp->cl_hostname);
    2185                 set_bit(NFS_MIG_FAILED, &server->mig_status);
    2186         }
    2187         return result;
    2188 }

regards,
dan carpenter

