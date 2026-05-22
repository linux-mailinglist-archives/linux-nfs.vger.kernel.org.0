Return-Path: <linux-nfs+bounces-21778-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHlhAIqkD2ocOQYAu9opvQ
	(envelope-from <linux-nfs+bounces-21778-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 02:34:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 685CA5AD777
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 02:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2755930221DA
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 00:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C30024E4C3;
	Fri, 22 May 2026 00:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jp54G9KF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911451E49F;
	Fri, 22 May 2026 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410048; cv=none; b=lV8Gc4/WXs7SLsoCFEkZse4mJFp0z3VhYoSf+AUtsP5rJepwDXiyZA8t/Xyai3iELF7WhVovwoZ6pFRgK304ksN85XhMibZJug80++JSYxIwvDWxt+R0Mybtb+9z2y7YDxm9OWhFMQ+JhBEKw6ourz7/BzkdR9HWVjlmoBh8Ino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410048; c=relaxed/simple;
	bh=r1xUBXluIgV8O6LXapirGIrJa02+P2xK9qYwBVmvKFw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WKd+u7vvv9tFUrzt7Z5et+sND7j3Lb1UADoH4oLinphXZ9X35yqPT+2m0xDt4bk+zUv72UCSNy18lnHBOS5X135KboEPvsfXuDtUdEdWCXmEy/qYUk5Ej2eiQlHHlbyqPWVdqpJCdIIW/KR8UvLx5EuvqOECmArp9k+y885DMsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jp54G9KF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779410043; x=1810946043;
  h=date:from:to:cc:subject:message-id;
  bh=r1xUBXluIgV8O6LXapirGIrJa02+P2xK9qYwBVmvKFw=;
  b=jp54G9KFZDl+aHfokTqUmn6ATopWT36cmWNfUYoY254DlLFK9CTgtSVv
   NmCMPHGrs3XRddAK6ag69EsOqwBY3qnLaoNVNcmFekRhTadbYxMkBJ/iH
   9oJkEKovMrOPVCY55LBUECF6RcsMVoqfZmYtihbpjzCn+fVTwbbK4uPwo
   LMnC6ktpi8NnAgFrrplZpIagPAV6A7Fi5OaoDKbPI//x1aFJx9oQHhoVo
   LKIZurMkJSD/VeD8sceEuGYah+sEbnIx8iG7KHt7YUmCgVJjGufl05nkX
   TfTcZS8x7w4Y62SFXu+bTbACroaJMJUaq/b1F7gBxP7RC3xTJQyKtqUkd
   Q==;
X-CSE-ConnectionGUID: ktPxY8oCSNKZlBfKVxvjAQ==
X-CSE-MsgGUID: TcQyefAATFueS6VBKQ6BBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="105803378"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="105803378"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 17:34:01 -0700
X-CSE-ConnectionGUID: +fORRaL0TbuBc92UEGQa1w==
X-CSE-MsgGUID: JtSUS+S4TC6ZEi3SMqvMoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="245772703"
Received: from lkp-server01.sh.intel.com (HELO fdb68b0ce653) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 21 May 2026 17:33:56 -0700
Received: from kbuild by fdb68b0ce653 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQDpp-000000001TN-1FOt;
	Fri, 22 May 2026 00:33:53 +0000
Date: Fri, 22 May 2026 08:33:24 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kexec@lists.infradead.org, keyrings@vger.kernel.org,
 linux-aio@kvack.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 sparclinux@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [linux-next:master] BUILD REGRESSION
 550604d6c9b9efc8d068aff94dc301694a7afdee
Message-ID: <202605220843.g8Ikcqqz-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21778-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,final.cc:url]
X-Rspamd-Queue-Id: 685CA5AD777
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 550604d6c9b9efc8d068aff94dc301694a7afdee  Add linux-next specific files for 20260521

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202605212104.SAIMqegX-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202605220247.dQAHslyv-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202605220312.Pu7UO05u-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202605220631.ugDr2VPb-lkp@intel.com

    /usr/bin/ld: sound/soc/codecs/es9356.o:(.rodata+0x2c30): undefined reference to `sdca_asoc_q78_get_volsw'
    /usr/bin/ld: sound/soc/codecs/es9356.o:(.rodata+0x2c38): undefined reference to `sdca_asoc_q78_put_volsw'
    arch/hexagon/kernel/syscalltab.c:19:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    arch/powerpc/kernel/pci_64.c:226:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    arch/powerpc/kernel/rtas.c:1850:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    arch/powerpc/kernel/signal_32.c:990:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    arch/powerpc/kernel/signal_64.c:657:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    arch/powerpc/kernel/sys_ppc32.c:70:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    arch/powerpc/kernel/syscalls.c:52:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    arch/riscv/kernel/sys_hwprobe.c:606:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    arch/riscv/kernel/sys_riscv.c:43:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    arch/sparc/kernel/sys_sparc32.c:54:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    arch/sparc/kernel/sys_sparc_64.c:351:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    arch/x86/um/syscalls_64.c:43:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    block/ioprio.c:65:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1830:26: error: cannot take the address of an rvalue of type 'int'
    drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1830:27: error: call to undeclared function 'cpu_data'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1833:23: error: use of undeclared identifier 'X86_VENDOR_AMD'
    drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1833:7: error: incomplete definition of type 'struct cpuinfo_x86'
    drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:2353:41: error: member reference base type 'int' is not a structure or union
    drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:2353:9: error: call to undeclared function 'cpu_data'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c:152:68: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 7 [-Wformat-truncation=]
    drivers/gpu/drm/scheduler/tests/tests_scheduler.c:675:10: error: initializer element is not a compile-time constant
    drivers/pinctrl/pinctrl-generic.c:130:5: error: redefinition of 'pinctrl_generic_pins_function_dt_node_to_map'
    drivers/pinctrl/pinctrl-generic.c:20:5: error: conflicting types for 'pinctrl_generic_to_map'; have 'int(struct pinctrl_dev *, struct device_node *, struct device_node *, struct pinctrl_map **, unsigned int *, unsigned int *, const char **, unsigned int,  const char **, unsigned int *, unsigned int)'
    fs/aio.c:1436:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/d_path.c:413:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/eventfd.c:414:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/eventpoll.c:2200:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/eventpoll.c:2483:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/exec.c:1924:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/exec.c:1925:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/fcntl.c:587:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/fhandle.c:129:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/file.c:818:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/file.c:819:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/file_attr.c:374:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/fsopen.c:120:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/ioctl.c:583:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/locks.c:2214:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/locks.c:2280:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/namei.c:5186:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/namei.c:5197:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/namespace.c:2068:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/namespace.c:2073:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/notify/inotify/inotify_user.c:720:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/open.c:152:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/pipe.c:1054:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/pipe.c:1055:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/read_write.c:412:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/readdir.c:215:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/readdir.c:304:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/select.c:722:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/select.c:733:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/signalfd.c:299:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/splice.c:1578:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/stat.c:420:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/stat.c:505:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/statfs.c:191:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/sync.c:148:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/timerfd.c:394:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/timerfd.c:424:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/utimes.c:142:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/xattr.c:732:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    fs/xattr.c:735:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    ipc/msg.c:315:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    ipc/sem.c:624:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    ipc/shm.c:847:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    ipc/shm.c:849:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/capability.c:137:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/events/core.c:13844:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/events/core.c:13853:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/exec_domain.c:38:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/exit.c:1082:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/exit.c:1112:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/fork.c:1785:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/fork.c:1808:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/futex/syscalls.c:28:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/groups.c:161:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/kcmp.c:135:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/kexec.c:242:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/module/main.c:804:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/nsproxy.c:569:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/nstree.c:763:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/pid.c:695:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/printk/printk.c:1853:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/ptrace.c:1388:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/ptrace.c:1415:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/reboot.c:728:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/rseq.c:547:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/sched/membarrier.c:634:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/sched/membarrier.c:636:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/sched/syscalls.c:132:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/seccomp.c:2126:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/signal.c:3319:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/sys.c:259:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/time/hrtimer.c:2381:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/time/hrtimer.c:2466:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/time/hrtimer.c:2487:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/time/itimer.c:113:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/time/posix-stubs.c:26:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/time/posix-timers.c:566:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/time/posix-timers.c:574:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/time/time.c:105:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/time/time.c:140:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/time/time.c:62:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    kernel/uid16.c:23:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    ld.lld: error: undefined symbol: sdca_asoc_q78_get_volsw
    ld.lld: error: undefined symbol: sdca_asoc_q78_put_volsw
    mm/fadvise.c:200:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/filemap.c:4713:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/filemap.c:4718:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/madvise.c:2013:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/madvise.c:2029:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/memfd.c:505:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/mincore.c:292:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/mlock.c:665:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/mmap.c:116:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/mprotect.c:985:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/mremap.c:2023:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/msync.c:32:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/oom_kill.c:1195:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/process_vm_access.c:292:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/readahead.c:736:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/readahead.c:760:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/swapfile.c:2903:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    mm/swapfile.c:3124:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    net/socket.c:1818:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    net/socket.c:1833:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    security/keys/compat.c:17:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    security/keys/keyctl.c:74:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    security/landlock/syscalls.c:203:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]
    security/lsm_syscalls.c:57:1: error: unknown warning group '-Wattribute-alias', ignored [-Werror,-Wunknown-warning-option]

Unverified Error/Warning (likely false positive, kindly check if interested):

    Warning: block/blk-map.c:366 Excess function parameter 'op' description in 'bio_copy_kern'
    csky-linux-ld: sound/soc/codecs/es9356.o:(.rodata+0x16c8): undefined reference to `sdca_asoc_q78_get_volsw'
    csky-linux-ld: sound/soc/codecs/es9356.o:(.rodata+0x16cc): undefined reference to `sdca_asoc_q78_put_volsw'
    drivers/android/binder_alloc.c:389:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/auxdisplay/panel.c:1508:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/base/regmap/regmap-debugfs.c:180:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/char/xillybus/xillybus_core.c:425:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/dma/qcom/hidma.c:389:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/gpu/drm/amd/amdgpu/dce_v10_0.c:2853:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c:357:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c:295:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/gpu/drm/udl/udl_main.c:260:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/gpu/drm/xe/xe_sched_job.c:162:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/greybus/es2.c:1428:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/hwmon/ibmpex.c:433:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/media/i2c/ds90ub960.c:4790:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/mtd/parsers/redboot.c:304:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/mtd/spi-nor/core.c:1645:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/net/ethernet/mellanox/mlx5/core/cmd.c:1508:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/scsi/aacraid/commsup.c:1928:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/scsi/aacraid/dpcsup.c:216:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/thunderbolt/stream.c:1388:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/tty/serial/max310x.c:1727:24: error: incompatible pointer types passing 'struct i2c_driver *' to parameter of type 'struct spi_driver *' [-Wincompatible-pointer-types]
    drivers/tty/serial/max310x.c:1727:25: error: use of undeclared identifier 'max310x_spi_driver'; did you mean 'max310x_i2c_driver'?
    drivers/tty/serial/max310x.c:1727:32: error: 'max310x_spi_driver' undeclared (first use in this function); did you mean 'max310x_i2c_driver'?
    drivers/tty/serial/max310x.c:1745:25: error: 'max310x_spi_driver' undeclared (first use in this function); did you mean 'max310x_i2c_driver'?
    drivers/tty/serial/max310x.c:1745:32: error: 'max310x_spi_driver' undeclared (first use in this function); did you mean 'max310x_i2c_driver'?
    drivers/usb/host/xhci-mem.c:866:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/usb/misc/usbtest.c:1416:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    drivers/usb/serial/usb_wwan.c:501:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    fs/btrfs/file.c:3288:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    fs/btrfs/inode.c:8975:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    fs/isofs/inode.c:1267:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    fs/nilfs2/recovery.c:397:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    fs/xfs/scrub/bitmap.c:116:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    kernel/bpf/syscall.c:3797:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    kernel/events/core.c:12131:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    kernel/trace/ring_buffer.c:2348:1: internal compiler error: in final_scan_insn_1, at final.cc:2813
    ld.lld: error: call to __compiletime_assert_537 marked "dontcall-error": BUILD_BUG_ON failed: 21 - 1 != HWEIGHT32( (VALID_OPENAT2_FLAGS & ~(O_NONBLOCK | O_NDELAY)) | __FMODE_EXEC)
    lib/raid/raid6/powerpc/altivec1.c:37:16: sparse: sparse: Trying to use reserved word 'signed' as identifier
    lib/raid/raid6/powerpc/altivec1.c:37:16: sparse: sparse: two or more data types in declaration specifiers
    lib/raid/raid6/powerpc/altivec2.c:37:16: sparse: sparse: Trying to use reserved word 'signed' as identifier
    lib/raid/raid6/powerpc/altivec2.c:37:16: sparse: sparse: two or more data types in declaration specifiers
    lib/raid/raid6/powerpc/altivec4.c:37:16: sparse: sparse: Trying to use reserved word 'signed' as identifier
    lib/raid/raid6/powerpc/altivec4.c:37:16: sparse: sparse: two or more data types in declaration specifiers
    lib/raid/raid6/powerpc/altivec8.c:37:16: sparse: sparse: Trying to use reserved word 'signed' as identifier
    lib/raid/raid6/powerpc/altivec8.c:37:16: sparse: sparse: two or more data types in declaration specifiers
    net/bluetooth/mgmt.c:4400:1: internal compiler error: in final_scan_insn_1, at final.cc:2813

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- alpha-allyesconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- alpha-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- alpha-randconfig-r052-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- arc-allmodconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- arc-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- arc-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- arm-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- arm-allyesconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- arm-defconfig
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   |-- block-ioprio.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-aio.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-d_path.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-eventfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-eventpoll.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-exec.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fcntl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fhandle.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-file.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-file_attr.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fsopen.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-ioctl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-locks.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-namei.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-namespace.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-notify-inotify-inotify_user.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-open.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-pipe.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-read_write.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-readdir.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-select.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-signalfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-splice.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-stat.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-statfs.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-sync.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-timerfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-utimes.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-xattr.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- ipc-msg.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- ipc-sem.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- ipc-shm.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-capability.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-events-core.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-exec_domain.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-exit.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-fork.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-futex-syscalls.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-groups.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-kcmp.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-kexec.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-module-main.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-nsproxy.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-nstree.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-pid.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-printk-printk.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-ptrace.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-reboot.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-rseq.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sched-membarrier.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sched-syscalls.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-seccomp.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-signal.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sys.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-hrtimer.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-itimer.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-posix-timers.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-time.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-uid16.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-fadvise.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-filemap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-madvise.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-memfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mincore.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mlock.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mmap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mprotect.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mremap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-msync.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-oom_kill.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-process_vm_access.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-readahead.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-swapfile.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- net-socket.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   `-- security-keys-keyctl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|-- arm-randconfig-001-20260521
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   `-- block-ioprio.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|-- arm-randconfig-002-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- arm-randconfig-004-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- arm-randconfig-r062-20260521
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   |-- block-ioprio.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-d_path.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-eventfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-eventpoll.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-exec.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fcntl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-file.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-file_attr.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fsopen.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-ioctl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-namei.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-namespace.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-notify-inotify-inotify_user.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-open.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-pipe.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-read_write.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-readdir.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-select.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-signalfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-splice.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-stat.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-statfs.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-sync.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-utimes.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-xattr.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- ipc-msg.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- ipc-sem.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- ipc-shm.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-capability.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-events-core.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-exec_domain.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-exit.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-fork.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-futex-syscalls.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-groups.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-module-main.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-nsproxy.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-nstree.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-pid.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-printk-printk.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-ptrace.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-reboot.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-rseq.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sched-membarrier.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sched-syscalls.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-signal.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sys.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-hrtimer.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-itimer.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-posix-timers.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-time.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-uid16.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-fadvise.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-filemap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-madvise.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-memfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mincore.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mlock.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mmap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mprotect.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mremap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-msync.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-oom_kill.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-process_vm_access.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-readahead.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- net-socket.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   `-- security-keys-keyctl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|-- arm64-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- arm64-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- arm64-randconfig-001-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- arm64-randconfig-003-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- arm64-randconfig-004
|   |-- ld.lld:error:undefined-symbol:sdca_asoc_q78_get_volsw
|   `-- ld.lld:error:undefined-symbol:sdca_asoc_q78_put_volsw
|-- arm64-randconfig-004-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- arm64-randconfig-r072-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- csky-allmodconfig
|   `-- drivers-thunderbolt-stream.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|-- csky-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- csky-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- csky-randconfig-001-20260521
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   |-- drivers-base-regmap-regmap-debugfs.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-acr-base.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-iccsense-base.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-gpu-drm-udl-udl_main.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-gpu-drm-xe-xe_sched_job.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-greybus-es2.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-mtd-parsers-redboot.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-scsi-aacraid-commsup.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-scsi-aacraid-dpcsup.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-usb-host-xhci-mem.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-usb-misc-usbtest.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-usb-serial-usb_wwan.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- fs-btrfs-file.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- fs-btrfs-inode.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- fs-isofs-inode.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- fs-nilfs2-recovery.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   `-- fs-xfs-scrub-bitmap.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|-- csky-randconfig-002-20260521
|   |-- csky-linux-ld:sound-soc-codecs-es9356.o:(.rodata):undefined-reference-to-sdca_asoc_q78_get_volsw
|   |-- csky-linux-ld:sound-soc-codecs-es9356.o:(.rodata):undefined-reference-to-sdca_asoc_q78_put_volsw
|   |-- drivers-android-binder_alloc.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-auxdisplay-panel.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-char-xillybus-xillybus_core.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-hwmon-ibmpex.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-media-i2c-ds90ub960.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-mtd-spi-nor-core.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- kernel-events-core.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   `-- kernel-trace-ring_buffer.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|-- csky-randconfig-r062-20260521
|   |-- drivers-dma-qcom-hidma.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-gpu-drm-amd-amdgpu-dce_v10_0.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- drivers-net-ethernet-mellanox-mlx5-core-cmd.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   |-- kernel-bpf-syscall.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|   `-- net-bluetooth-mgmt.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
|-- hexagon-allmodconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- hexagon-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- hexagon-defconfig
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   `-- arch-hexagon-kernel-syscalltab.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|-- hexagon-randconfig-001-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- hexagon-randconfig-002
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-buildonly-randconfig-001
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-buildonly-randconfig-001-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-buildonly-randconfig-003
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-buildonly-randconfig-003-20260521
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   `-- drivers-tty-serial-max31.c:error:use-of-undeclared-identifier-max31_spi_driver
|-- i386-buildonly-randconfig-004
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-buildonly-randconfig-005-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-buildonly-randconfig-006-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-randconfig-001
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-randconfig-001-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-randconfig-002
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-randconfig-002-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-randconfig-003-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-randconfig-004
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-randconfig-005
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-randconfig-006-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-randconfig-007
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-randconfig-051-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-randconfig-052-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-randconfig-054-20260521
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   `-- drivers-tty-serial-max31.c:error:max31_spi_driver-undeclared-(first-use-in-this-function)
|-- i386-randconfig-062-20260522
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- i386-randconfig-063-20260522
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- loongarch-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- loongarch-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- loongarch-randconfig-001
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- loongarch-randconfig-002
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- m68k-allmodconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- m68k-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- m68k-allyesconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- m68k-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- microblaze-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- microblaze-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- microblaze-randconfig-r061-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- mips-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- mips-randconfig-r071-20260521
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   |-- kernel-time-posix-stubs.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   `-- security-keys-keyctl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|-- nios2-allmodconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- nios2-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- nios2-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- nios2-randconfig-001
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- nios2-randconfig-002
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- nios2-randconfig-r054-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- openrisc-allmodconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- openrisc-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- parisc-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- parisc-allyesconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- parisc-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- parisc-randconfig-r073-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- parisc64-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- powerpc-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- powerpc-randconfig-r063-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- powerpc-randconfig-r064-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- powerpc-sam440ep_defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- powerpc64-randconfig-r061-20260522
|   |-- arch-powerpc-kernel-pci_64.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- arch-powerpc-kernel-rtas.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- arch-powerpc-kernel-signal_32.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- arch-powerpc-kernel-signal_64.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- arch-powerpc-kernel-sys_ppc32.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   `-- arch-powerpc-kernel-syscalls.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|-- powerpc64-randconfig-r131-20260521
|   |-- lib-raid-raid6-powerpc-altivec1.c:sparse:sparse:Trying-to-use-reserved-word-signed-as-identifier
|   |-- lib-raid-raid6-powerpc-altivec1.c:sparse:sparse:two-or-more-data-types-in-declaration-specifiers
|   |-- lib-raid-raid6-powerpc-altivec2.c:sparse:sparse:Trying-to-use-reserved-word-signed-as-identifier
|   |-- lib-raid-raid6-powerpc-altivec2.c:sparse:sparse:two-or-more-data-types-in-declaration-specifiers
|   |-- lib-raid-raid6-powerpc-altivec4.c:sparse:sparse:Trying-to-use-reserved-word-signed-as-identifier
|   |-- lib-raid-raid6-powerpc-altivec4.c:sparse:sparse:two-or-more-data-types-in-declaration-specifiers
|   |-- lib-raid-raid6-powerpc-altivec8.c:sparse:sparse:Trying-to-use-reserved-word-signed-as-identifier
|   `-- lib-raid-raid6-powerpc-altivec8.c:sparse:sparse:two-or-more-data-types-in-declaration-specifiers
|-- riscv-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- riscv-allyesconfig
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   `-- drivers-gpu-drm-scheduler-tests-tests_scheduler.c:error:initializer-element-is-not-a-compile-time-constant
|-- riscv-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- riscv-randconfig-001-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- riscv-randconfig-002
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- riscv-randconfig-002-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- riscv-randconfig-r131-20260521
|   |-- arch-riscv-kernel-sys_hwprobe.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- arch-riscv-kernel-sys_riscv.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   `-- ld.lld:error:call-to-__compiletime_assert_NNN-marked-dontcall-error:BUILD_BUG_ON-failed:HWEIGHT32(-(VALID_OPENAT2_FLAGS-(O_NONBLOCK-O_NDELAY))-__FMODE_EXEC)
|-- s390-allmodconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- s390-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- s390-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- s390-randconfig-001
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- s390-randconfig-001-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- s390-randconfig-002-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- s390-randconfig-r064-20260522
|   `-- drivers-tty-serial-max31.c:error:incompatible-pointer-types-passing-struct-i2c_driver-to-parameter-of-type-struct-spi_driver
|-- sh-allmodconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- sh-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- sh-allyesconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- sh-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- sh-randconfig-001
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- sh-randconfig-001-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- sh-randconfig-002
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- sh-randconfig-002-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- sparc-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- sparc-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- sparc-randconfig-001
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- sparc-randconfig-001-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- sparc-randconfig-002
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- sparc-randconfig-002-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- sparc64-allmodconfig
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   |-- arch-sparc-kernel-sys_sparc32.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- arch-sparc-kernel-sys_sparc_64.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- block-ioprio.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-aio.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-d_path.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-eventfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-eventpoll.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-exec.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fcntl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fhandle.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-file.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-file_attr.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fsopen.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-ioctl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-locks.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-namei.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-namespace.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-notify-inotify-inotify_user.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-open.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-pipe.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-read_write.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-readdir.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-select.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-signalfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-splice.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-stat.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-statfs.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-sync.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-timerfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-utimes.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-xattr.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- ipc-msg.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- ipc-sem.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- ipc-shm.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-capability.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-events-core.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-exec_domain.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-exit.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-fork.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-futex-syscalls.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-groups.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-kcmp.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-module-main.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-nsproxy.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-nstree.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-pid.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-printk-printk.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-ptrace.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-reboot.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sched-membarrier.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sched-syscalls.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-seccomp.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-signal.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sys.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-hrtimer.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-itimer.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-posix-timers.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-time.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-uid16.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-fadvise.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-filemap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-madvise.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-memfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mincore.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mlock.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mmap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mprotect.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mremap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-msync.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-oom_kill.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-process_vm_access.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-readahead.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-swapfile.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- net-socket.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- security-keys-compat.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- security-landlock-syscalls.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   `-- security-lsm_syscalls.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|-- sparc64-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- sparc64-randconfig-001
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- sparc64-randconfig-001-20260521
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   `-- drivers-tty-serial-max31.c:error:max31_spi_driver-undeclared-(first-use-in-this-function)
|-- sparc64-randconfig-002
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   |-- arch-sparc-kernel-sys_sparc32.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- arch-sparc-kernel-sys_sparc_64.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- block-ioprio.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-aio.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-d_path.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-eventfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-eventpoll.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-exec.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fcntl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fhandle.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-file.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-file_attr.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fsopen.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-ioctl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-locks.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-namei.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-namespace.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-notify-inotify-inotify_user.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-open.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-pipe.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-read_write.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-readdir.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-select.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-signalfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-splice.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-stat.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-statfs.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-sync.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-timerfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-utimes.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-xattr.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-capability.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-events-core.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-exec_domain.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-exit.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-fork.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-futex-syscalls.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-groups.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-kcmp.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-nsproxy.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-nstree.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-pid.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-printk-printk.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-ptrace.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-reboot.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sched-membarrier.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sched-syscalls.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-seccomp.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-signal.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sys.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-hrtimer.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-itimer.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-posix-timers.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-time.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-uid16.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-fadvise.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-filemap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-madvise.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mincore.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mlock.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mmap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mprotect.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mremap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-msync.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-oom_kill.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-process_vm_access.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-readahead.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- net-socket.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- security-keys-compat.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- security-keys-keyctl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   `-- security-lsm_syscalls.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|-- sparc64-randconfig-002-20260521
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   `-- drivers-tty-serial-max31.c:error:max31_spi_driver-undeclared-(first-use-in-this-function)
|-- um-allmodconfig
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   |-- drivers-gpu-drm-amd-amdgpu-..-amdkfd-kfd_crat.c:error:call-to-undeclared-function-cpu_data-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-gpu-drm-amd-amdgpu-..-amdkfd-kfd_crat.c:error:cannot-take-the-address-of-an-rvalue-of-type-int
|   |-- drivers-gpu-drm-amd-amdgpu-..-amdkfd-kfd_crat.c:error:incomplete-definition-of-type-struct-cpuinfo_x86
|   |-- drivers-gpu-drm-amd-amdgpu-..-amdkfd-kfd_crat.c:error:use-of-undeclared-identifier-X86_VENDOR_AMD
|   |-- drivers-gpu-drm-amd-amdgpu-..-amdkfd-kfd_topology.c:error:call-to-undeclared-function-cpu_data-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-gpu-drm-amd-amdgpu-..-amdkfd-kfd_topology.c:error:member-reference-base-type-int-is-not-a-structure-or-union
|-- um-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- um-allyesconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- um-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- um-i386_defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- um-randconfig-001
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   |-- block-ioprio.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-d_path.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-eventfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-eventpoll.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-exec.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fcntl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fhandle.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-file.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-file_attr.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fsopen.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-ioctl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-namei.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-namespace.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-open.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-pipe.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-read_write.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-readdir.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-select.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-splice.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-stat.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-statfs.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-sync.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-timerfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-utimes.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-xattr.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-exec_domain.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-exit.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-fork.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-kcmp.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-nsproxy.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-nstree.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-pid.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-printk-printk.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-ptrace.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-reboot.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sched-syscalls.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-signal.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sys.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-hrtimer.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-posix-stubs.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-time.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mincore.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mlock.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mmap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mprotect.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mremap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-msync.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-oom_kill.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-process_vm_access.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-readahead.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- net-socket.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   `-- security-keys-keyctl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|-- um-randconfig-001-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- um-randconfig-002
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   |-- arch-x86-um-syscalls_64.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- block-ioprio.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-aio.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-d_path.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-eventfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-eventpoll.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-exec.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fcntl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fhandle.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-file.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-file_attr.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-fsopen.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-ioctl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-locks.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-namei.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-namespace.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-notify-inotify-inotify_user.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-open.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-pipe.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-read_write.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-readdir.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-select.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-signalfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-splice.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-stat.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-statfs.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-sync.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-timerfd.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-utimes.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- fs-xattr.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-capability.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-exec_domain.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-exit.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-fork.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-futex-syscalls.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-groups.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-module-main.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-nsproxy.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-nstree.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-pid.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-printk-printk.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-ptrace.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-reboot.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sched-membarrier.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sched-syscalls.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-seccomp.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-signal.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-sys.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-hrtimer.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-itimer.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-posix-timers.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-time-time.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- kernel-uid16.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-fadvise.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-filemap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-madvise.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mincore.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mlock.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mmap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mprotect.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-mremap.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-msync.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-oom_kill.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-process_vm_access.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-readahead.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   |-- mm-swapfile.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|   `-- security-keys-keyctl.c:error:unknown-warning-group-Wattribute-alias-ignored-Werror-Wunknown-warning-option
|-- um-randconfig-002-20260521
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   |-- drivers-tty-serial-max31.c:error:max31_spi_driver-undeclared-(first-use-in-this-function)
|   |-- usr-bin-ld:sound-soc-codecs-es9356.o:(.rodata):undefined-reference-to-sdca_asoc_q78_get_volsw
|   `-- usr-bin-ld:sound-soc-codecs-es9356.o:(.rodata):undefined-reference-to-sdca_asoc_q78_put_volsw
|-- um-randconfig-r053-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- um-x86_64_defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-buildonly-randconfig-002-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-buildonly-randconfig-003-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-buildonly-randconfig-004-20260521
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   |-- drivers-gpu-drm-amd-amdgpu-jpeg_v2_5.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-pinctrl-pinctrl-generic.c:error:conflicting-types-for-pinctrl_generic_to_map-have-int(struct-pinctrl_dev-struct-device_node-struct-device_node-struct-pinctrl_map-unsigned-int-unsigned-int-cons
|   |-- drivers-pinctrl-pinctrl-generic.c:error:redefinition-of-pinctrl_generic_pins_function_dt_node_to_map
|   `-- drivers-tty-serial-max31.c:error:max31_spi_driver-undeclared-(first-use-in-this-function)
|-- x86_64-buildonly-randconfig-005-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-defconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-kexec
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-001-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-002-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-004-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-006-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-011-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-012-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-013-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-014-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-015-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-016-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-071
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-071-20260521
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   `-- drivers-pinctrl-pinctrl-generic.c:error:redefinition-of-pinctrl_generic_pins_function_dt_node_to_map
|-- x86_64-randconfig-072
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-072-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-073-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-074
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-074-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-075
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-076
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-076-20260521
|   `-- drivers-pinctrl-pinctrl-generic.c:error:redefinition-of-pinctrl_generic_pins_function_dt_node_to_map
|-- x86_64-randconfig-101
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-101-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-102
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-102-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-103
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-104
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-104-20260521
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-121-20260522
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-122-20260522
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-randconfig-123-20260522
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   `-- drivers-pinctrl-pinctrl-generic.c:error:redefinition-of-pinctrl_generic_pins_function_dt_node_to_map
|-- x86_64-randconfig-161
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-rhel-9.4
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-rhel-9.4-bpf
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-rhel-9.4-func
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-rhel-9.4-kselftests
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-rhel-9.4-kunit
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- x86_64-rhel-9.4-ltp
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- xtensa-allnoconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- xtensa-allyesconfig
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- xtensa-randconfig-001
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|-- xtensa-randconfig-001-20260521
|   |-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
|   `-- drivers-tty-serial-max31.c:error:max31_spi_driver-undeclared-(first-use-in-this-function)
|-- xtensa-randconfig-002
|   `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern
`-- xtensa-randconfig-002-20260521
    `-- Warning:block-blk-map.c-Excess-function-parameter-op-description-in-bio_copy_kern

elapsed time: 724m

configs tested: 282
configs skipped: 11

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260521    gcc-13.4.0
arc                   randconfig-001-20260521    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260521    gcc-12.5.0
arc                   randconfig-002-20260521    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260521    clang-23
arm                   randconfig-001-20260521    gcc-8.5.0
arm                            randconfig-002    gcc-11.5.0
arm                   randconfig-002-20260521    gcc-12.5.0
arm                   randconfig-002-20260521    gcc-8.5.0
arm                            randconfig-003    clang-20
arm                   randconfig-003-20260521    gcc-13.4.0
arm                   randconfig-003-20260521    gcc-8.5.0
arm                            randconfig-004    gcc-14.3.0
arm                   randconfig-004-20260521    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260521    clang-23
arm64                 randconfig-001-20260521    gcc-8.5.0
arm64                 randconfig-002-20260521    gcc-8.5.0
arm64                 randconfig-003-20260521    gcc-8.5.0
arm64                 randconfig-004-20260521    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260521    gcc-15.2.0
csky                  randconfig-001-20260521    gcc-8.5.0
csky                  randconfig-002-20260521    gcc-15.2.0
csky                  randconfig-002-20260521    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260521    clang-23
hexagon               randconfig-001-20260521    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260521    clang-23
hexagon               randconfig-002-20260521    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    clang-20
i386        buildonly-randconfig-001-20260521    clang-20
i386        buildonly-randconfig-001-20260522    clang-20
i386                 buildonly-randconfig-002    clang-20
i386        buildonly-randconfig-002-20260521    clang-20
i386        buildonly-randconfig-002-20260522    gcc-14
i386                 buildonly-randconfig-003    clang-20
i386        buildonly-randconfig-003-20260521    clang-20
i386        buildonly-randconfig-003-20260522    clang-20
i386                 buildonly-randconfig-004    clang-20
i386        buildonly-randconfig-004-20260521    clang-20
i386        buildonly-randconfig-004-20260522    gcc-14
i386                 buildonly-randconfig-005    clang-20
i386        buildonly-randconfig-005-20260521    clang-20
i386        buildonly-randconfig-005-20260522    clang-20
i386                 buildonly-randconfig-006    clang-20
i386        buildonly-randconfig-006-20260521    clang-20
i386        buildonly-randconfig-006-20260522    gcc-13
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260521    clang-20
i386                  randconfig-002-20260521    gcc-14
i386                  randconfig-003-20260521    clang-20
i386                  randconfig-004-20260521    gcc-14
i386                  randconfig-005-20260521    clang-20
i386                  randconfig-006-20260521    clang-20
i386                  randconfig-007-20260521    clang-20
i386                  randconfig-011-20260521    gcc-14
i386                  randconfig-012-20260521    clang-20
i386                  randconfig-013-20260521    gcc-13
i386                  randconfig-014-20260521    gcc-14
i386                  randconfig-015-20260521    gcc-14
i386                  randconfig-016-20260521    clang-20
i386                  randconfig-017-20260521    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260521    gcc-11.5.0
loongarch             randconfig-001-20260521    gcc-12.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260521    gcc-11.5.0
loongarch             randconfig-002-20260521    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260521    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260521    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260521    gcc-12.5.0
parisc                randconfig-002-20260521    gcc-15.2.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260521    clang-23
powerpc               randconfig-002-20260521    clang-17
powerpc                    sam440ep_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260521    clang-23
powerpc64             randconfig-002-20260521    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                          randconfig-001    gcc-15.2.0
riscv                 randconfig-001-20260521    clang-23
riscv                 randconfig-001-20260521    gcc-15.2.0
riscv                          randconfig-002    gcc-15.2.0
riscv                 randconfig-002-20260521    gcc-13.4.0
riscv                 randconfig-002-20260521    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260521    gcc-15.2.0
s390                  randconfig-001-20260521    gcc-8.5.0
s390                           randconfig-002    gcc-15.2.0
s390                  randconfig-002-20260521    clang-17
s390                  randconfig-002-20260521    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                             randconfig-001    gcc-15.2.0
sh                    randconfig-001-20260521    gcc-15.2.0
sh                             randconfig-002    gcc-15.2.0
sh                    randconfig-002-20260521    gcc-12.5.0
sh                    randconfig-002-20260521    gcc-15.2.0
sh                          rsk7264_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260521    gcc-8.5.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260521    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260521    gcc-8.5.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260521    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260521    gcc-14
um                    randconfig-001-20260521    gcc-8.5.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260521    gcc-14
um                    randconfig-002-20260521    gcc-8.5.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260521    clang-20
x86_64      buildonly-randconfig-001-20260521    gcc-12
x86_64      buildonly-randconfig-002-20260521    clang-20
x86_64      buildonly-randconfig-002-20260521    gcc-14
x86_64      buildonly-randconfig-003-20260521    clang-20
x86_64      buildonly-randconfig-004-20260521    clang-20
x86_64      buildonly-randconfig-004-20260521    gcc-14
x86_64      buildonly-randconfig-005-20260521    clang-20
x86_64      buildonly-randconfig-006-20260521    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260521    clang-20
x86_64                randconfig-002-20260521    clang-20
x86_64                randconfig-003-20260521    clang-20
x86_64                randconfig-003-20260521    gcc-14
x86_64                randconfig-004-20260521    clang-20
x86_64                randconfig-005-20260521    clang-20
x86_64                randconfig-006-20260521    clang-20
x86_64                randconfig-011-20260521    clang-20
x86_64                randconfig-011-20260521    gcc-14
x86_64                randconfig-012-20260521    clang-20
x86_64                randconfig-012-20260521    gcc-14
x86_64                randconfig-013-20260521    clang-20
x86_64                randconfig-013-20260521    gcc-14
x86_64                randconfig-014-20260521    clang-20
x86_64                randconfig-014-20260521    gcc-14
x86_64                randconfig-015-20260521    clang-20
x86_64                randconfig-015-20260521    gcc-14
x86_64                randconfig-016-20260521    gcc-14
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260521    clang-20
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260521    clang-20
x86_64                         randconfig-073    clang-20
x86_64                randconfig-073-20260521    clang-20
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260521    gcc-14
x86_64                         randconfig-075    gcc-13
x86_64                randconfig-075-20260521    clang-20
x86_64                         randconfig-076    clang-20
x86_64                randconfig-076-20260521    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260521    gcc-8.5.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260521    gcc-11.5.0
xtensa                randconfig-002-20260521    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

