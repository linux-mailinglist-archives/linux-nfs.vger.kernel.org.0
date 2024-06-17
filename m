Return-Path: <linux-nfs+bounces-3903-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B5090B31F
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 16:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE4E2842C5
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73274137903;
	Mon, 17 Jun 2024 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="de4YsnlP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACDD139CF6
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633220; cv=none; b=FuKSv56/QpEb85NmkJI8F8MdVi8jKs75dkC7GNmaU7VJMXeoIg2Scr1J1Ae8XJh+fgivwaFYOj+1MVLFGNRSDrCb/4ThElcPAJQRh6jHP+7BsiTP80f+I//LDCDuywzMbTxEheDj7XZ1GYN6woIG5ymTnlOMRHPvaBKnu46kII4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633220; c=relaxed/simple;
	bh=pMyfw1dfiGA1QZu8PBrMPuuOqPTctUixdoLBvWN885M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WAqKZZrHnKt5FnchauXxJnzfpGMoqmJHpPZ1rIQN7qu9/70eEIiWFyWgjDPoDJOLrCLnWDg6/BdWEiLIhOLRwjJbEi2FLB6jIEGl3vrxQKHUwDso/1QXaz+SHzc4qWpRyN9UssV8ev7FSX7Pj+v+JjriAwDSvDJpNF4gh6ZU2IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=de4YsnlP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35f1bc63981so3296946f8f.1
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718633217; x=1719238017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfzEPFl0/Y3VgT03Y8o10XG4X345RRemIWVH9KFw+jI=;
        b=de4YsnlPtoRJT5vBYVRDwDtXEDfHNaDI0zS5cPe6n0YmGfhq/lMGV9k9Qjfem/GFyj
         bcQNoCJu16Nw6D9NGJxp/MqmgXsE7RlR2nhySi5ghHHMLoQ6CBh5XRFdZdEJ/pxCwHBd
         s5mFYEjhTX/fe3PY/23I4+N6nLuGNhFeIce1Xw+qZjb1XD5kUmFD1q3mAUX32fip8CrP
         q5OHoBXnKldG0qpccCNbG4tPKh4XCYdpawboCtlkZjfbySKx9tOPoik293z2e1w3YVmw
         YkpFi1fB+HC1BRCSPIvJzrE0dRvjO6VfiSFrlKGjP5mN9Tj1fpDm29vXd+oBzY3YVOCS
         jYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633217; x=1719238017;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfzEPFl0/Y3VgT03Y8o10XG4X345RRemIWVH9KFw+jI=;
        b=SeYnpfjbGCMCtcg/bdua4EG6R7FpFzyHpghoX28yYk+7M8fEYPKudkg6XuWuz+1om4
         LfooZPsK6Tp0oHK733mciN70vkRt7bqT4h9H/Jaz7c4F0TUUFNIN4I1KuV5VkasvkdG7
         g/e8bXKwGeH5UAiIw+t7A/4crhifdrgUSN1MvEQGPvtrus8XiIBw/yALJek4AHscSc/q
         3w0pKeNH66nZz+LtzyU4ml7YGq6FhMEFNhNhjsU8XX/mnOfHrLQKE6wLb1Z42pI8ieyF
         4ALU1aFweOiNO0PVAHosugmSQmMwgHdQRLGVMzYFJKzd9ESKw+Z8tXS9pqH+L7PH0O8l
         XXvg==
X-Forwarded-Encrypted: i=1; AJvYcCWrhuIWTrjAF8/HIxghOCcZrD83cukZd+jKGdu5uQvurtQSJbEqkrCzk+n7QOH4cui8k4XCX4uVq+j1qCd/YQLjoDxhepzXeNJl
X-Gm-Message-State: AOJu0YwTu2HWY+9WFP09EYo/lgI6IdqUv6qaYqFCULLRVj3tKoFdIx9z
	X789BHI+Hwm8mxduQqdUxdKpCr1MqlLsd9iqbusvcc7j9Z4ZmYT3cZ7rm20NvnM=
X-Google-Smtp-Source: AGHT+IHDZbXCFBXwbnXcDrWZn2ocDbHY0hBSBHWSG0CtmvrPKMVAjIMtcKtYZ5slFz12ytWdZUf88g==
X-Received: by 2002:adf:f705:0:b0:35f:32af:d79 with SMTP id ffacd0b85a97d-36071901363mr11440363f8f.27.1718633216594;
        Mon, 17 Jun 2024 07:06:56 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c8fbsm11886296f8f.43.2024.06.17.07.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:06:56 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:06:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	trondmy@kernel.org, anna@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs: remove dead code for the old swap over NFS
 implementation
Message-ID: <975db363-b830-499b-89f8-9d843da47427@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615080827.1239935-1-hch@lst.de>

Hi Christoph,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/nfs-remove-dead-code-for-the-old-swap-over-NFS-implementation/20240615-161031
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20240615080827.1239935-1-hch%40lst.de
patch subject: [PATCH] nfs: remove dead code for the old swap over NFS implementation
config: x86_64-randconfig-161-20240616 (https://download.01.org/0day-ci/archive/20240616/202406162226.EHq7u0eB-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202406162226.EHq7u0eB-lkp@intel.com/

smatch warnings:
fs/nfs/write.c:737 nfs_inode_remove_request() warn: variable dereferenced before check 'folio' (see line 734)

vim +/folio +737 fs/nfs/write.c

^1da177e4c3f41 Linus Torvalds          2005-04-16  728  static void nfs_inode_remove_request(struct nfs_page *req)
^1da177e4c3f41 Linus Torvalds          2005-04-16  729  {
6a6d4644ce935d Scott Mayhew            2023-10-11  730  	struct nfs_inode *nfsi = NFS_I(nfs_page_to_inode(req));
6a6d4644ce935d Scott Mayhew            2023-10-11  731  
20633f042fd090 Weston Andros Adamson   2014-05-15  732  	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
0c493b5cf16e28 Trond Myklebust         2023-01-19  733  		struct folio *folio = nfs_page_to_folio(req->wb_head);
a43a94f57a0e00 Christoph Hellwig       2024-06-15 @734  		struct address_space *mapping = folio->mapping;
                                                                                                        ^^^^^^^^^^^^^^
Dereference

^1da177e4c3f41 Linus Torvalds          2005-04-16  735  
600f111ef51dc2 Matthew Wilcox (Oracle  2023-11-17  736) 		spin_lock(&mapping->i_private_lock);
a43a94f57a0e00 Christoph Hellwig       2024-06-15 @737  		if (likely(folio)) {
                                                                                   ^^^^^
Checked too late

0c493b5cf16e28 Trond Myklebust         2023-01-19  738  			folio->private = NULL;
0c493b5cf16e28 Trond Myklebust         2023-01-19  739  			folio_clear_private(folio);
0c493b5cf16e28 Trond Myklebust         2023-01-19  740  			clear_bit(PG_MAPPED, &req->wb_head->wb_flags);
29418aa4bd487c Mel Gorman              2012-07-31  741  		}
600f111ef51dc2 Matthew Wilcox (Oracle  2023-11-17  742) 		spin_unlock(&mapping->i_private_lock);
20633f042fd090 Weston Andros Adamson   2014-05-15  743  	}
17089a29a25a3b Weston Andros Adamson   2014-07-11  744  
33ea5aaa87cdae ZhangXiaoxu             2019-09-26  745  	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
6a6d4644ce935d Scott Mayhew            2023-10-11  746  		atomic_long_dec(&nfsi->nrequests);
dd1b2026323a2d Jeff Layton             2023-09-19  747  		nfs_release_request(req);
33ea5aaa87cdae ZhangXiaoxu             2019-09-26  748  	}
^1da177e4c3f41 Linus Torvalds          2005-04-16  749  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


