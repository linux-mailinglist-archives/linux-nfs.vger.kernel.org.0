Return-Path: <linux-nfs+bounces-5126-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA03693ED53
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 08:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CB0281BB0
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 06:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20A583CD9;
	Mon, 29 Jul 2024 06:22:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25CB82877
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722234163; cv=none; b=VgeYyLW08vxYBn1zfhKJ1mzAPo2NjKsGnqvT4+PoudWF9yVjQr6aC9+inbRdOR97gRgLIysla5KxtoLH7nQ7aYmViUkkMgRW+cWk/wV1o09cjQcOlbH3J/DLQKwiibBm4zb8qZHmC4Cuex8KNtZjSBE4KYvo6eYzxwTcPPSedNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722234163; c=relaxed/simple;
	bh=hjjIMtLXsRowWJTsFZFs0FGHMWuAIRn3zMKwdzFZlVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHcp2BEpdwkvvOem/1THvJPRwB51KzSFbR614T7Po8vgP7ifZxCeg7JLLArVkjdstnXlBbHTVKWFc93YHTEdBOjQ6HYzn5BcWv6E6XER7qHmWXShglZxeW3MecLfgylq7j/55rIm2g6ZXw+0B6oD37jFCtCF3w9SGdk6RLgJZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280921baa2so1077395e9.2
        for <linux-nfs@vger.kernel.org>; Sun, 28 Jul 2024 23:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722234160; x=1722838960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcrMmy1kl1trlyFU4fNrbFfE/gf001bjOnJ7xTNIN84=;
        b=Kie9TgW8CubN0Agid+rWkPVKPXhozfVcvvLNElaIpa8UrDQu9nHUE9tJwz1BYMNCr7
         pQJmW1jwjr/kq1c9HWi2sJGlWv96+nKh98soskVcXk4D0vF9sV7l8XKf+jPd00i0djoe
         FJqldpUgC6BFuszI2x4O5r3hoOiQymzZKZM6B4Q6kkZ9t1jLKuMchNpWvQweH2WUtCf2
         cjx77X3ja+A9nkhX+uoZ30CGsSQX4FxLz9XqFcVHke+osnibUAc/WkY5ajv4CutdjvbN
         t5oGF5QcT5sTURpq91OmJrQs59l6ULCnIeViThBLmytXjNs2yPXSiCESE1yePBKdc58F
         MeXA==
X-Forwarded-Encrypted: i=1; AJvYcCV0b5jqZruqD9NgDnIdt4vT6xN2TQgynhI5QDoDWFDqkZqvERH4vkpRF9BI9PMSdeSmXVWGIbAPAiion+o3isUnVSLbuCedhFHc
X-Gm-Message-State: AOJu0Yz8sZ/7W6AjrK/15GO7aXonPLGVfSoBH+ByErJi1tvpcBa6Rilq
	B4Z4FhFJLU1ALIEQ6u5srS0NHaJpfAMEoXrnvnvqodCSJXkiclDA
X-Google-Smtp-Source: AGHT+IFYGT1k7kCPuLrOqHIqyzA2D6/4fdpD7+t3cofOCztVkirsr19TzmkJvH5ZMr0361MeWFJ8hA==
X-Received: by 2002:a05:600c:19c7:b0:427:9f6f:4913 with SMTP id 5b1f17b1804b1-4280576b7famr58912055e9.5.1722234159977;
        Sun, 28 Jul 2024 23:22:39 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574003bsm161755635e9.17.2024.07.28.23.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 23:22:39 -0700 (PDT)
Message-ID: <aa94fd00-0a91-4924-a943-2e21e6da1df8@grimberg.me>
Date: Mon, 29 Jul 2024 09:22:38 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nfsd: resolve possible conflicts of reads using
 special stateids and write delegations
To: kernel test robot <lkp@intel.com>, Chuck Lever <chuck.lever@oracle.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Dai Ngo <dai.ngo@oracle.com>, Olga Kornievskaia <aglo@umich.edu>,
 Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20240728204104.519041-4-sagi@grimberg.me>
 <202407290814.7REsmaH7-lkp@intel.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <202407290814.7REsmaH7-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 29/07/2024 3:35, kernel test robot wrote:
> Hi Sagi,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.11-rc1 next-20240726]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Sagi-Grimberg/nfsd-don-t-assume-copy-notify-when-preprocessing-the-stateid/20240729-044834
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20240728204104.519041-4-sagi%40grimberg.me
> patch subject: [PATCH v2 3/3] nfsd: resolve possible conflicts of reads using special stateids and write delegations
> config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240729/202407290814.7REsmaH7-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240729/202407290814.7REsmaH7-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407290814.7REsmaH7-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> fs/nfsd/nfs4state.c:8826: warning: Excess function parameter 'inode' description in 'nfsd4_deleg_read_conflict'
>>> fs/nfsd/nfs4state.c:8826: warning: Excess function parameter 'modified' description in 'nfsd4_deleg_read_conflict'
>>> fs/nfsd/nfs4state.c:8826: warning: Excess function parameter 'size' description in 'nfsd4_deleg_read_conflict'
>
> vim +8826 fs/nfsd/nfs4state.c
>
>    8805	
>    8806	/**
>    8807	 * nfsd4_deleg_read_conflict - Recall if read causes conflict
>    8808	 * @rqstp: RPC transaction context
>    8809	 * @clp: nfs client
>    8810	 * @fhp: nfs file handle
>    8811	 * @inode: file to be checked for a conflict
>    8812	 * @modified: return true if file was modified
>    8813	 * @size: new size of file if modified is true
>    8814	 *
>    8815	 * This function is called when there is a conflict between a write
>    8816	 * delegation and a read that is using a special stateid where the
>    8817	 * we cannot derive the client stateid exsistence. The server
>    8818	 * must recall a conflicting delegation before allowing the read
>    8819	 * to continue.
>    8820	 *
>    8821	 * Returns 0 if there is no conflict; otherwise an nfs_stat
>    8822	 * code is returned.
>    8823	 */
>    8824	__be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
>    8825			struct nfs4_client *clp, struct svc_fh *fhp)
>> 8826	{
>    8827		struct nfs4_file *fp;
>    8828		__be32 status = 0;
>    8829	
>    8830		fp = nfsd4_file_hash_lookup(fhp);
>    8831		if (!fp)
>    8832			return nfs_ok;
>    8833	
>    8834		spin_lock(&state_lock);
>    8835		spin_lock(&fp->fi_lock);
>    8836		if (!list_empty(&fp->fi_delegations) &&
>    8837		    !nfs4_delegation_exists(clp, fp)) {
>    8838			/* conflict, recall deleg */
>    8839			status = nfserrno(nfsd_open_break_lease(fp->fi_inode,
>    8840						NFSD_MAY_READ));
>    8841			if (status)
>    8842				goto out;
>    8843			if (!nfsd_wait_for_delegreturn(rqstp, fp->fi_inode))
>    8844				status = nfserr_jukebox;
>    8845		}
>    8846	out:
>    8847		spin_unlock(&fp->fi_lock);
>    8848		spin_unlock(&state_lock);
>    8849		return status;
>    8850	}
>    8851	
>

Its not clear what is the warning about here...

