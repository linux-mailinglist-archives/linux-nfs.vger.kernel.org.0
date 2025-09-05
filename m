Return-Path: <linux-nfs+bounces-14069-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D69DB459FE
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 16:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3911CC3B5C
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61169225401;
	Fri,  5 Sep 2025 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIZcQgY/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5431D618A;
	Fri,  5 Sep 2025 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080947; cv=none; b=qncSgy06pbyZRkaRWJOYgeXimMC/nE50Hyg5pEdp2RAl+hGQh9BC1x57bax/yozzVxjBZ3rKGyNvUP81YLf5D07Pvk+l4XSvtKi6Y1RgljUaif6Fovv0CSvrGEYj8jSjZ1eqhs28VdmnbORks02HGpGsWtnPCbgZwVVhZGIoDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080947; c=relaxed/simple;
	bh=p7SNkxBMDceyrMBtDVw3FbEQeKmi497N1GJZiGp7K9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc316BLdvNCXfmE+b5o0VJJENgMJ05/sAXsHqDAIp3lEBwQm0FP0w25FSbIsNgbCOk0mOsoR12VTysa+8FkDKMdLbAMkZUU5+LCJKJKT27uRXdcahS0sBvFRpwnKeUOx9sxDfL2NBComrnxJgWuzFkFGqya0KkpTyyPyLRx1/Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIZcQgY/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757080946; x=1788616946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p7SNkxBMDceyrMBtDVw3FbEQeKmi497N1GJZiGp7K9k=;
  b=CIZcQgY/UgTrpQDy7tvqE7qRdj7EkebKTSYpSElU+ramiHAxVofjivR1
   4XdF0w8VyMGHSvy+iRSMggwaM1t7rgY2gGuaiBvXXtuQsbzV20EA44Emf
   8GYTefXRFmes0i6vMR1c+bpF1y6BdRM/7lbqasIFwN0mpIo3A5s8FpK8B
   9gpXc1ZHJAOW6UFs8Dqlee0mZHMJarvBJNiNw4JwYFt0xNlANFNjiUebT
   6uMeqwfN+GH7gJJeSU/AttVW+CQGtZoabA+hqW/hM7/a0PGFXrlAw0AJO
   3uyy9RdSFEVAZz36r7FzIKXZz3WkudQdh4TmPDBNFSaO1BGW4DKXTt7nt
   A==;
X-CSE-ConnectionGUID: i4KiG2UOQceQaajlYYW2gg==
X-CSE-MsgGUID: xojMqzQCS5ynXaeHcwlpjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70046424"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="70046424"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 07:02:25 -0700
X-CSE-ConnectionGUID: 7tJWMnQ6TUWYlbJDxGoMTg==
X-CSE-MsgGUID: FiViECbySquhBvzeXiGqtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="195826206"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 05 Sep 2025 07:02:21 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuX19-0000Tv-05;
	Fri, 05 Sep 2025 14:02:19 +0000
Date: Fri, 5 Sep 2025 22:01:45 +0800
From: kernel test robot <lkp@intel.com>
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com, alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 7/7] nvmet-tcp: Support KeyUpdate
Message-ID: <202509052153.luapQMZm-lkp@intel.com>
References: <20250905024659.811386-8-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905024659.811386-8-alistair.francis@wdc.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on net/main net-next/main linus/master v6.17-rc4 next-20250905]
[cannot apply to linux-nvme/for-next horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alistair23-gmail-com/net-handshake-Store-the-key-serial-number-on-completion/20250905-105201
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20250905024659.811386-8-alistair.francis%40wdc.com
patch subject: [PATCH v2 7/7] nvmet-tcp: Support KeyUpdate
config: s390-randconfig-001-20250905 (https://download.01.org/0day-ci/archive/20250905/202509052153.luapQMZm-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250905/202509052153.luapQMZm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509052153.luapQMZm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/nvme/target/tcp.c: In function 'nvmet_tcp_tls_record_ok':
>> drivers/nvme/target/tcp.c:1173:12: warning: unused variable 'htype' [-Wunused-variable]
    1173 |  u8 ctype, htype, level, description;
         |            ^~~~~
   drivers/nvme/target/tcp.c: In function 'nvmet_tcp_io_work':
   drivers/nvme/target/tcp.c:1479:5: error: implicit declaration of function 'update_tls_keys'; did you mean 'update_cr_regs'? [-Werror=implicit-function-declaration]
    1479 |     update_tls_keys(queue);
         |     ^~~~~~~~~~~~~~~
         |     update_cr_regs
   cc1: some warnings being treated as errors


vim +/htype +1173 drivers/nvme/target/tcp.c

  1168	
  1169	static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
  1170			struct msghdr *msg, char *cbuf)
  1171	{
  1172		struct cmsghdr *cmsg = (struct cmsghdr *)cbuf;
> 1173		u8 ctype, htype, level, description;
  1174		int ret = 0;
  1175	
  1176		ctype = tls_get_record_type(queue->sock->sk, cmsg);
  1177		switch (ctype) {
  1178		case 0:
  1179			break;
  1180		case TLS_RECORD_TYPE_DATA:
  1181			break;
  1182		case TLS_RECORD_TYPE_ALERT:
  1183			tls_alert_recv(queue->sock->sk, msg, &level, &description);
  1184			if (level == TLS_ALERT_LEVEL_FATAL) {
  1185				pr_err("queue %d: TLS Alert desc %u\n",
  1186				       queue->idx, description);
  1187				ret = -ENOTCONN;
  1188			} else {
  1189				pr_warn("queue %d: TLS Alert desc %u\n",
  1190				       queue->idx, description);
  1191				ret = -EAGAIN;
  1192			}
  1193			break;
  1194		case TLS_RECORD_TYPE_HANDSHAKE:
  1195			ret = -EAGAIN;
  1196			break;
  1197		default:
  1198			/* discard this record type */
  1199			pr_err("queue %d: TLS record %d unhandled\n",
  1200			       queue->idx, ctype);
  1201			ret = -EAGAIN;
  1202			break;
  1203		}
  1204		return ret;
  1205	}
  1206	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

