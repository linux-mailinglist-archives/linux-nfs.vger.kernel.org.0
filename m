Return-Path: <linux-nfs+bounces-7471-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF5E9B07F3
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 17:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10051F24541
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 15:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A217A212196;
	Fri, 25 Oct 2024 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbjv3wiR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C620F3E9;
	Fri, 25 Oct 2024 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869496; cv=none; b=iE/i4kdJuVU/sDUHfDGWfYdgWx94Ehk8pFi7wJoDM1vBq4GB/OpGqogAxMQlHAzINayLwoJarX0xjmBY0UTNY6jSKLbshF7nCeGmP9iXdfCZJUywsStLkpqs25EEt7dbdI0LIjP10AG1H02EyEF7sMhLU/UbtzAGXsXX81gfLEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869496; c=relaxed/simple;
	bh=enc7ArYN6z9V0tX3nNZjICrseiCbidmUvlTURUF1Fto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=to87enqF0ZElDPPhyNv0Pluy84bQ9KRa8f3ajZkSOAJ5Me02XSY9ktcR3myyCnLOcPMnwCaGrCMsQU7/IdwWL9qSWLzhKn2AHyYtCkdk2d7Eo2eV+nuxJocda/97cCZ8dzAQhs/Anb+WZPJFaqS46ziacfsHxgrdQ0OeJa7Vl9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbjv3wiR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729869494; x=1761405494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=enc7ArYN6z9V0tX3nNZjICrseiCbidmUvlTURUF1Fto=;
  b=nbjv3wiRGpYuzG1iYAZHkJoyymI40GD6p1O6RiCsEDOsWKSWeLYPw0Jn
   KmVpvAwSP6wVDmycC9RL+rO/0heXxbGwF4ZIVS/q/MXDiU9nQX62F3/3P
   NPJ2kOR7hWGG6fD3hDjhBHAhHaOJPddDfG4cyNCUVx4Ko1Yies7Yzybes
   bf1C0/CR+u3PHqw5cKFWyOaAXt1dFHvKJ+wGUZ3HDDpenzOgP4j2/E57b
   yX4rdbVC5zWN1SE+a97EMU9TLbZiyH6JxNOJElHBrXy/0jpKbUcmQpzg1
   F30U95ZugVjjoZWSLoyIVIDMiRcmTnE4fG+Yd/mRS38+ChrpINY7xzgN2
   Q==;
X-CSE-ConnectionGUID: ROjhOAiQRES2pJ/V1J6ljw==
X-CSE-MsgGUID: SlA74OysR4q6rJVpnnFdYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29486910"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29486910"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:18:14 -0700
X-CSE-ConnectionGUID: ZKjH/9KwRkS3B3Tu/QjDuA==
X-CSE-MsgGUID: 9mOoshv+T4qqJAkrFdAZ6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85712474"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Oct 2024 08:18:09 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4M4l-000YPG-1y;
	Fri, 25 Oct 2024 15:18:07 +0000
Date: Fri, 25 Oct 2024 23:17:32 +0800
From: kernel test robot <lkp@intel.com>
To: Li Lingfeng <lilingfeng3@huawei.com>, trondmy@kernel.org,
	anna@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dros@netapp.com,
	trond.myklebust@hammerspace.com, jlayton@kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: Re: [PATCH v3] nfs: protect nfs41_impl_id by rcu
Message-ID: <202410252304.ImkycETw-lkp@intel.com>
References: <20241022115847.1283892-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022115847.1283892-1-lilingfeng3@huawei.com>

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.12-rc4 next-20241025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Lingfeng/nfs-protect-nfs41_impl_id-by-rcu/20241022-194521
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20241022115847.1283892-1-lilingfeng3%40huawei.com
patch subject: [PATCH v3] nfs: protect nfs41_impl_id by rcu
config: alpha-randconfig-r132-20241025 (https://download.01.org/0day-ci/archive/20241025/202410252304.ImkycETw-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce: (https://download.01.org/0day-ci/archive/20241025/202410252304.ImkycETw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410252304.ImkycETw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/nfs/nfs4proc.c:8876:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct callback_head *head @@     got struct callback_head [noderef] __rcu * @@
   fs/nfs/nfs4proc.c:8876:17: sparse:     expected struct callback_head *head
   fs/nfs/nfs4proc.c:8876:17: sparse:     got struct callback_head [noderef] __rcu *
>> fs/nfs/nfs4proc.c:8876:17: sparse: sparse: cast removes address space '__rcu' of expression
>> fs/nfs/nfs4proc.c:8933:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct nfs41_impl_id [noderef] __rcu *impl_id @@     got void *_res @@
   fs/nfs/nfs4proc.c:8933:31: sparse:     expected struct nfs41_impl_id [noderef] __rcu *impl_id
   fs/nfs/nfs4proc.c:8933:31: sparse:     got void *_res
>> fs/nfs/nfs4proc.c:8973:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got struct nfs41_impl_id [noderef] __rcu *impl_id @@
   fs/nfs/nfs4proc.c:8973:28: sparse:     expected void const *objp
   fs/nfs/nfs4proc.c:8973:28: sparse:     got struct nfs41_impl_id [noderef] __rcu *impl_id
>> fs/nfs/nfs4proc.c:9038:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct nfs41_impl_id [noderef] __rcu *__tmp @@     got struct nfs41_impl_id * @@
   fs/nfs/nfs4proc.c:9038:25: sparse:     expected struct nfs41_impl_id [noderef] __rcu *__tmp
   fs/nfs/nfs4proc.c:9038:25: sparse:     got struct nfs41_impl_id *
--
>> fs/nfs/nfs4xdr.c:5788:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __rcu * @@
   fs/nfs/nfs4xdr.c:5788:27: sparse:     expected void *
   fs/nfs/nfs4xdr.c:5788:27: sparse:     got char [noderef] __rcu *
   fs/nfs/nfs4xdr.c:5794:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __rcu * @@
   fs/nfs/nfs4xdr.c:5794:27: sparse:     expected void *
   fs/nfs/nfs4xdr.c:5794:27: sparse:     got char [noderef] __rcu *
>> fs/nfs/nfs4xdr.c:5800:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned long long [usertype] *valp @@     got unsigned long long [noderef] __rcu * @@
   fs/nfs/nfs4xdr.c:5800:45: sparse:     expected unsigned long long [usertype] *valp
   fs/nfs/nfs4xdr.c:5800:45: sparse:     got unsigned long long [noderef] __rcu *
>> fs/nfs/nfs4xdr.c:5801:20: sparse: sparse: dereference of noderef expression
--
>> fs/nfs/nfs4client.c:298:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct callback_head *head @@     got struct callback_head [noderef] __rcu * @@
   fs/nfs/nfs4client.c:298:17: sparse:     expected struct callback_head *head
   fs/nfs/nfs4client.c:298:17: sparse:     got struct callback_head [noderef] __rcu *
>> fs/nfs/nfs4client.c:298:17: sparse: sparse: cast removes address space '__rcu' of expression

vim +8876 fs/nfs/nfs4proc.c

  8868	
  8869	static void nfs4_exchange_id_release(void *data)
  8870	{
  8871		struct nfs41_exchange_id_data *cdata =
  8872						(struct nfs41_exchange_id_data *)data;
  8873	
  8874		nfs_put_client(cdata->args.client);
  8875		if (cdata->res.impl_id)
> 8876			kfree_rcu(cdata->res.impl_id, __rcu_head);
  8877		kfree(cdata->res.server_scope);
  8878		kfree(cdata->res.server_owner);
  8879		kfree(cdata);
  8880	}
  8881	
  8882	static const struct rpc_call_ops nfs4_exchange_id_call_ops = {
  8883		.rpc_release = nfs4_exchange_id_release,
  8884	};
  8885	
  8886	/*
  8887	 * _nfs4_proc_exchange_id()
  8888	 *
  8889	 * Wrapper for EXCHANGE_ID operation.
  8890	 */
  8891	static struct rpc_task *
  8892	nfs4_run_exchange_id(struct nfs_client *clp, const struct cred *cred,
  8893				u32 sp4_how, struct rpc_xprt *xprt)
  8894	{
  8895		struct rpc_message msg = {
  8896			.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_EXCHANGE_ID],
  8897			.rpc_cred = cred,
  8898		};
  8899		struct rpc_task_setup task_setup_data = {
  8900			.rpc_client = clp->cl_rpcclient,
  8901			.callback_ops = &nfs4_exchange_id_call_ops,
  8902			.rpc_message = &msg,
  8903			.flags = RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN,
  8904		};
  8905		struct nfs41_exchange_id_data *calldata;
  8906		int status;
  8907	
  8908		if (!refcount_inc_not_zero(&clp->cl_count))
  8909			return ERR_PTR(-EIO);
  8910	
  8911		status = -ENOMEM;
  8912		calldata = kzalloc(sizeof(*calldata), GFP_NOFS);
  8913		if (!calldata)
  8914			goto out;
  8915	
  8916		nfs4_init_boot_verifier(clp, &calldata->args.verifier);
  8917	
  8918		status = nfs4_init_uniform_client_string(clp);
  8919		if (status)
  8920			goto out_calldata;
  8921	
  8922		calldata->res.server_owner = kzalloc(sizeof(struct nfs41_server_owner),
  8923							GFP_NOFS);
  8924		status = -ENOMEM;
  8925		if (unlikely(calldata->res.server_owner == NULL))
  8926			goto out_calldata;
  8927	
  8928		calldata->res.server_scope = kzalloc(sizeof(struct nfs41_server_scope),
  8929						GFP_NOFS);
  8930		if (unlikely(calldata->res.server_scope == NULL))
  8931			goto out_server_owner;
  8932	
> 8933		calldata->res.impl_id = kzalloc(sizeof(struct nfs41_impl_id), GFP_NOFS);
  8934		if (unlikely(calldata->res.impl_id == NULL))
  8935			goto out_server_scope;
  8936	
  8937		switch (sp4_how) {
  8938		case SP4_NONE:
  8939			calldata->args.state_protect.how = SP4_NONE;
  8940			break;
  8941	
  8942		case SP4_MACH_CRED:
  8943			calldata->args.state_protect = nfs4_sp4_mach_cred_request;
  8944			break;
  8945	
  8946		default:
  8947			/* unsupported! */
  8948			WARN_ON_ONCE(1);
  8949			status = -EINVAL;
  8950			goto out_impl_id;
  8951		}
  8952		if (xprt) {
  8953			task_setup_data.rpc_xprt = xprt;
  8954			task_setup_data.flags |= RPC_TASK_SOFTCONN;
  8955			memcpy(calldata->args.verifier.data, clp->cl_confirm.data,
  8956					sizeof(calldata->args.verifier.data));
  8957		}
  8958		calldata->args.client = clp;
  8959		calldata->args.flags = EXCHGID4_FLAG_SUPP_MOVED_REFER |
  8960		EXCHGID4_FLAG_BIND_PRINC_STATEID;
  8961	#ifdef CONFIG_NFS_V4_1_MIGRATION
  8962		calldata->args.flags |= EXCHGID4_FLAG_SUPP_MOVED_MIGR;
  8963	#endif
  8964		if (test_bit(NFS_CS_PNFS, &clp->cl_flags))
  8965			calldata->args.flags |= EXCHGID4_FLAG_USE_PNFS_DS;
  8966		msg.rpc_argp = &calldata->args;
  8967		msg.rpc_resp = &calldata->res;
  8968		task_setup_data.callback_data = calldata;
  8969	
  8970		return rpc_run_task(&task_setup_data);
  8971	
  8972	out_impl_id:
> 8973		kfree(calldata->res.impl_id);
  8974	out_server_scope:
  8975		kfree(calldata->res.server_scope);
  8976	out_server_owner:
  8977		kfree(calldata->res.server_owner);
  8978	out_calldata:
  8979		kfree(calldata);
  8980	out:
  8981		nfs_put_client(clp);
  8982		return ERR_PTR(status);
  8983	}
  8984	
  8985	/*
  8986	 * _nfs4_proc_exchange_id()
  8987	 *
  8988	 * Wrapper for EXCHANGE_ID operation.
  8989	 */
  8990	static int _nfs4_proc_exchange_id(struct nfs_client *clp, const struct cred *cred,
  8991				u32 sp4_how)
  8992	{
  8993		struct rpc_task *task;
  8994		struct nfs41_exchange_id_args *argp;
  8995		struct nfs41_exchange_id_res *resp;
  8996		unsigned long now = jiffies;
  8997		int status;
  8998	
  8999		task = nfs4_run_exchange_id(clp, cred, sp4_how, NULL);
  9000		if (IS_ERR(task))
  9001			return PTR_ERR(task);
  9002	
  9003		argp = task->tk_msg.rpc_argp;
  9004		resp = task->tk_msg.rpc_resp;
  9005		status = task->tk_status;
  9006		if (status  != 0)
  9007			goto out;
  9008	
  9009		status = nfs4_check_cl_exchange_flags(resp->flags,
  9010				clp->cl_mvops->minor_version);
  9011		if (status  != 0)
  9012			goto out;
  9013	
  9014		status = nfs4_sp4_select_mode(clp, &resp->state_protect);
  9015		if (status != 0)
  9016			goto out;
  9017	
  9018		do_renew_lease(clp, now);
  9019	
  9020		clp->cl_clientid = resp->clientid;
  9021		clp->cl_exchange_flags = resp->flags;
  9022		clp->cl_seqid = resp->seqid;
  9023		/* Client ID is not confirmed */
  9024		if (!(resp->flags & EXCHGID4_FLAG_CONFIRMED_R))
  9025			clear_bit(NFS4_SESSION_ESTABLISHED,
  9026				  &clp->cl_session->session_state);
  9027	
  9028		if (clp->cl_serverscope != NULL &&
  9029		    !nfs41_same_server_scope(clp->cl_serverscope,
  9030					resp->server_scope)) {
  9031			dprintk("%s: server_scope mismatch detected\n",
  9032				__func__);
  9033			set_bit(NFS4CLNT_SERVER_SCOPE_MISMATCH, &clp->cl_state);
  9034		}
  9035	
  9036		swap(clp->cl_serverowner, resp->server_owner);
  9037		swap(clp->cl_serverscope, resp->server_scope);
> 9038		resp->impl_id = rcu_replace_pointer(clp->cl_implid, resp->impl_id, 1);
  9039	
  9040		/* Save the EXCHANGE_ID verifier session trunk tests */
  9041		memcpy(clp->cl_confirm.data, argp->verifier.data,
  9042		       sizeof(clp->cl_confirm.data));
  9043	out:
  9044		trace_nfs4_exchange_id(clp, status);
  9045		rpc_put_task(task);
  9046		return status;
  9047	}
  9048	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

