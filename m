Return-Path: <linux-nfs+bounces-11871-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8242AAC1EC3
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 10:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3451F5048DE
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F00D1EE008;
	Fri, 23 May 2025 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCW8uzjd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C374218FDBE
	for <linux-nfs@vger.kernel.org>; Fri, 23 May 2025 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747989311; cv=none; b=VHEDfBcgPfTG8GJkca41LDo6DhlXcXiLhoY/qmUSvVVe8DRXLbFbVQ8iY4OhTD0rpIH+6jXjbDEPC7DIe1L4hth0agJtujNwDzPu36r+LtUUULHfnEaDsgoWJzcaK4Tqw5BbJiyKmdPWfmVmUyTqnodfeGhRZbp8tm7/Mu0vNQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747989311; c=relaxed/simple;
	bh=3TKCaIyB5/0opVLcNoQ1gcsKEomRJ1FYv7vspoTx96c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sHnMLnGS/9HWF3mPtCRkg7WwS1TAFBDmtwSll4Q93tCuZBeNyd8XyUcy/GY7MqRfHlNvVeVB1LRvGBHsZyipmChL7VfHqWa+sYY9q1lZMtmr4Z38tPUOUL52xFrTzYSTeBY+RGwL2+R0QixDxHyU1UNOs89/pYuIeO0JsT2qbQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FCW8uzjd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so5061245e9.1
        for <linux-nfs@vger.kernel.org>; Fri, 23 May 2025 01:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747989307; x=1748594107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YbryJ7vGqluEKazlG50NrGVTXzGTh20PwbvTVePubi4=;
        b=FCW8uzjdkegTQaXSgicQDmJCEkRU+BnmQeyAgfBLMju6bBIH18Kqk+4TSnI79qOCKh
         zHm1MByLm/kVB0oTu6ErNVZg9hHuTktIiTwE24YnjxAFzvIycQ+A+uq3Vd1wp5mA1De8
         N/2k8tdff14brPqLEnNUUzMeDHa6Bb3HAYTtrNxsvQOBW4EM37YPUr77XfDooUMHUAN7
         qn1LF8fdMdbVO5WWPcnYuM847aRgVULTGdNxklwAFhwifxJJwkHORMSvPHe+EYw17qVK
         wX9d0yvoA9s3XBeLmNqISjAQ0nfYrGXnsxa2UawlOZKfvrT+aKhDJvGEmXDdb6LJeUVN
         8Eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747989307; x=1748594107;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YbryJ7vGqluEKazlG50NrGVTXzGTh20PwbvTVePubi4=;
        b=nfQQTbqFwI3ZBm1UPXTHeWhgXBMgMIK0VhYzcsaQnhv6/7W5QAl5C66yIHr1C0kHAG
         2COw9Y+qGetWmkqNz239/szyG/wy85erVEXAfAnJMCXTIa1V3eG+EDrvqJJovjeGGzIa
         LSTgb1TBPCihpNNAM/SzvD5rU9NZkI5NKPzPP9fuwJGOGs3mwfIb/I9rF8xHm2DajiUV
         CIP2li4onn08HxKjv50kPhMEHLuXAUbwP8/3coLIjMIr5VhNrY7GF4Ds3oBUIdpa7DP0
         /1VlTphanlco9z69ImgNEhRRJhvJOvmaZ/BpDXRlj5aT9evOHp97gM1RxHZz2CbrBF8X
         FNLw==
X-Forwarded-Encrypted: i=1; AJvYcCW5axfzrOfENGrGuuBOIrSDF+M/MpDSEIAimPTYExxRSfd3NLf6uS2YyDtwUvSR+nINpYX8epIES2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpQJe6dBcyPU+y+zDW8ooSWRZKkYcopo6WahsJWbR5fzr99lat
	0MrBUTDuKY2Ni5LH2oSfVJV42kIzWFT5C8bMScrF1n41h/ZJ5mGnzQoM8EuUKO/IrSA=
X-Gm-Gg: ASbGnctwDxHHq1t4yt3HUg9esJItmhL267e7EP46uDt9F4p1LVH88zXNHq8N1zmV5yS
	GNoN3/+g0bXqUbSopW5fx6Em8OuQR9SGYqjDHGTfxFaSPQOcCp3nK2DGK01iqRFewKRrlD/jiBt
	HIv/Y1MyU5HjQZJbT4vOdPDH2KZ8Kh42vrG7hGISqYf1RHxOJ6RBFRbLh7o2MpPbD9SOZqlhJ/P
	hVh6uoV82Bl+QeTzomUvnMnMpWp4Uk6tXR5ItOJ6z0JbFGUIpOUl9P30Q/qtRKzMR1PCH1fDHXM
	DBSWAx3jMPcRMMM/yxVi5NdRKUOPxX2ghpA46MhhY0qJo3p9ylJ82Yya
X-Google-Smtp-Source: AGHT+IGDLAMP6aDEKzjJ8nU1sJDp2T3vwd2IHZI+1NwlB0Wm65hoqonKY2iKdd6kvHgAkP8caUNfmA==
X-Received: by 2002:a05:600c:43d4:b0:43c:ec72:3daf with SMTP id 5b1f17b1804b1-44b533c19b8mr15328325e9.14.1747989306976;
        Fri, 23 May 2025 01:35:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a3648baa6asm23534815f8f.91.2025.05.23.01.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 01:35:06 -0700 (PDT)
Date: Fri, 23 May 2025 11:35:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, anna@kernel.org
Subject: Re: [PATCH] NFS: Fixes for nfs4_proc_mkdir() error handling
Message-ID: <202505181116.RhlCb75I-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516150010.61641-1-anna@kernel.org>

Hi Anna,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anna-Schumaker/NFS-Fixes-for-nfs4_proc_mkdir-error-handling/20250516-231124
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20250516150010.61641-1-anna%40kernel.org
patch subject: [PATCH] NFS: Fixes for nfs4_proc_mkdir() error handling
config: i386-randconfig-141-20250517 (https://download.01.org/0day-ci/archive/20250518/202505181116.RhlCb75I-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202505181116.RhlCb75I-lkp@intel.com/

New smatch warnings:
fs/nfs/nfs4proc.c:5277 nfs4_proc_mkdir() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +5277 fs/nfs/nfs4proc.c

8376583b84a193 NeilBrown           2025-02-27  5260  static struct dentry *nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
^1da177e4c3f41 Linus Torvalds      2005-04-16  5261  				      struct iattr *sattr)
^1da177e4c3f41 Linus Torvalds      2005-04-16  5262  {
dff25ddb48086a Andreas Gruenbacher 2016-12-02  5263  	struct nfs_server *server = NFS_SERVER(dir);
0688e64bc60038 Trond Myklebust     2019-04-07  5264  	struct nfs4_exception exception = {
0688e64bc60038 Trond Myklebust     2019-04-07  5265  		.interruptible = true,
0688e64bc60038 Trond Myklebust     2019-04-07  5266  	};
c528f70f504434 Trond Myklebust     2022-10-19  5267  	struct nfs4_label l, *label;
8376583b84a193 NeilBrown           2025-02-27  5268  	struct dentry *alias;
^1da177e4c3f41 Linus Torvalds      2005-04-16  5269  	int err;
a8a5da996df7d2 Aneesh Kumar K.V    2010-12-09  5270  
aa9c2669626ca7 David Quigley       2013-05-22  5271  	label = nfs4_label_init_security(dir, dentry, sattr, &l);
aa9c2669626ca7 David Quigley       2013-05-22  5272  
dff25ddb48086a Andreas Gruenbacher 2016-12-02  5273  	if (!(server->attr_bitmask[2] & FATTR4_WORD2_MODE_UMASK))
a8a5da996df7d2 Aneesh Kumar K.V    2010-12-09  5274  		sattr->ia_mode &= ~current_umask();
^1da177e4c3f41 Linus Torvalds      2005-04-16  5275  	do {
8376583b84a193 NeilBrown           2025-02-27  5276  		alias = _nfs4_proc_mkdir(dir, dentry, sattr, label);
4c35d65f4c6f1e Anna Schumaker      2025-05-16 @5277  		err = PTR_ERR(alias);
4c35d65f4c6f1e Anna Schumaker      2025-05-16  5278  		if (err > 0)
4c35d65f4c6f1e Anna Schumaker      2025-05-16  5279  			err = 0;

This doesn't work.  Imagine we are on a 64bit system and
_nfs4_proc_mkdir() returns a valid pointer.  It depends on if BIT(31)
is set whether we return zero or a random negative number.

This needs to be:

	err = PTR_ERR_OR_ZERO(alias);

078ea3dfe396b1 Trond Myklebust     2013-08-12  5280  		trace_nfs4_mkdir(dir, &dentry->d_name, err);
078ea3dfe396b1 Trond Myklebust     2013-08-12  5281  		err = nfs4_handle_exception(NFS_SERVER(dir), err,
^1da177e4c3f41 Linus Torvalds      2005-04-16  5282  				&exception);
^1da177e4c3f41 Linus Torvalds      2005-04-16  5283  	} while (exception.retry);
aa9c2669626ca7 David Quigley       2013-05-22  5284  	nfs4_label_release_security(label);
aa9c2669626ca7 David Quigley       2013-05-22  5285  
4c35d65f4c6f1e Anna Schumaker      2025-05-16  5286  	if (err != 0)
4c35d65f4c6f1e Anna Schumaker      2025-05-16  5287  		return ERR_PTR(err);
8376583b84a193 NeilBrown           2025-02-27  5288  	return alias;
^1da177e4c3f41 Linus Torvalds      2005-04-16  5289  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


