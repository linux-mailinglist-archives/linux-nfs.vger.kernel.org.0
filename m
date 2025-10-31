Return-Path: <linux-nfs+bounces-15847-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0429AC2540C
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 14:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B24D14E042B
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDB8169AD2;
	Fri, 31 Oct 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZbgRqThg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2295C311C10
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916973; cv=none; b=PAAXBV0+WHSXFe1q+89m7UORqFDO8UxGtdHsfbRWydY4+5E2DAcHNnaciiKPtYbp6kyhv0mgEQ9AhZHkY1QojDqHVhhmd4m4VOEAH9NJqFJgO+QBLKv38SMjGW6A+kvubqSfERHfXVLYn+hMep5vTU2ChqAmi+Hls8ev9u+ixPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916973; c=relaxed/simple;
	bh=GklorhE6hm1svpGYjLhof5srWRRuNfQP1YdfxRXHlBc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VneoYp8JJPfJGq+5c1eZ8Pdr0+TQeZaDvS9nr9UwCSqRYWiLZgGsnd35wqSj1jM+YiBzQgxbzKyG6/FyPnDWgga9LGK77SPEjrao/ziWXYDXeLCEFUN4DLb5WFuOYXWj+dkAFyEmzCNJAHKi4aofp03WBEtKwyWweQNSqjUtb3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZbgRqThg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4710665e7deso10701715e9.1
        for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761916970; x=1762521770; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIOeZhbbI9P6thb659GIRE01pkzjGWDwb6GMZyBzePQ=;
        b=ZbgRqThg7kacs2TxnYAQ8dtfhvsFUK9DODd+QTgS85LR5EEZGnHsLW1YhXr1MkN5Yy
         51vG6X2jJYS4ET2lX4iQnaynpSkgCj768Bg8crJK2OhDReZUXyC9xXJ69fE4beHf8Zxt
         tbgxlj65xTSLdX3gypTJKZ9EN4/X4HA601G+xLw80ElaxH1Lrt1erXIyMCv58LSL5Quy
         0YtNM72LnXW8rdJ4rqPbMeN6omQ8B/YsVMD6sKUyJxdqazxy/yBlN0eK7QJUbNTSTD3U
         4uRdc6bLqZzgAD9jKxrIaX9uCYs6NDKPPCw3dWbgME/wLe3MjofhnDdUR9HsUOexo6UU
         Q5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761916970; x=1762521770;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIOeZhbbI9P6thb659GIRE01pkzjGWDwb6GMZyBzePQ=;
        b=ZKxktP/TYA9GqS2tzVm+VAVbL2sjXbkG7SJsXcFsL/NBrwxSBYeudoul2FTom9M2VE
         1CCAR0781tHF1yn84iH65cMiYgQIgZm3iV6FQeczNbiQO4PZMZLdtcI9A8ZjHC25fpvk
         xKFffeZFMDB3EVGYrVxKR1s/Irss/ub2VIeH4qz1Oen8xvh5XEdXy0Z+oTK9ZPBStraY
         MbzrLemLj1ts4ivthO2kzyuwUFNBzXq1PwDyFL++AY1Dbw6L98pUUMRjqNKETcxV3x04
         QRzUWOBcvOCZdPL3HqGZXX46HA1kRrHzE9g2c2tN1NnvHYddMZBDbcLvy2P5WhBPUgPT
         qe/w==
X-Gm-Message-State: AOJu0YyySR5pEE5eGJreA04wRDUXNyd59oogMyeM8DY+SHkAOEJLN2Az
	2tta0dVUwzTpgmhTYcOTLOiUGMcVbrdhOW0NxZKAFisJtMZmWfGx291VRxhtltzFLm8=
X-Gm-Gg: ASbGncvg09V4/O11McPYpBDTq8l+w4E8jXi/ksphpOW5+KfVhbUNb1hupedIoXHLXNV
	FX8TPvwzM7fy/1usJwEgjcGxAqNyc6mBNc08JmpTfmxWftkKdu6H8R6hidM/i5UurMt1//HRlAq
	tEFWhK1rUq5QjcV8nvkjzKaxwx0f92qc32irs03s9Mn42y6RHZNBF8XJZCLutMCr6m8MPJBhg9o
	Lb2WQ2CruQdvSP/fBbxa2RHazDv7JdN1ZT9ViKOlS6hPNPOFaSyUbhu2PrX/mYVE0KQ6wTNOeAO
	OTQi1yjBEujIYeCUO1HL42QpqbezdZdPhfVnFxqhpf0/vH0dugfdQ5JeAB1ivwBVF1aBDmLuMP4
	WDf/+9ZJGfTlKZznPVELld8fZVmyp3U/cyqeDB2b913UYalHfa/nJjkBum8HILdErAvAFwNgi7D
	lTzMr1yqeQWIHR+8tJ
X-Google-Smtp-Source: AGHT+IHdqbTG8SXhwPiWZEc+DK2uliOf/uSEWzuJhQSIJZIalBTR68vFp+EJ7Xd5OYdf2yfr0ncsZQ==
X-Received: by 2002:a05:600c:4695:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-477308be7b3mr37904535e9.29.1761916970294;
        Fri, 31 Oct 2025 06:22:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429c13f3278sm3540778f8f.42.2025.10.31.06.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:22:49 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:22:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [bug report] NFSv4: Observe the NFS_MOUNT_SOFTREVAL flag in
 _nfs4_proc_lookupp
Message-ID: <aQS4Ju3132AqZeqB@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Trond Myklebust,

This is a new checker rule Harshit and I wrote.

Commit 76998ebb9158 ("NFSv4: Observe the NFS_MOUNT_SOFTREVAL flag in
_nfs4_proc_lookupp") from Oct 20, 2020 (linux-next), leads to the
following Smatch static checker warning:

	fs/nfs/nfs4proc.c:783 nfs4_init_sequence()
	warn: potentially more than 1 'args->sa_cache_this = 0x1001' type='uchar'

fs/nfs/nfs4proc.c
    778 void nfs4_init_sequence(struct nfs4_sequence_args *args,
    779                         struct nfs4_sequence_res *res, int cache_reply,
    780                         int privileged)
    781 {
    782         args->sa_slot = NULL;
--> 783         args->sa_cache_this = cache_reply;

args->sa_cache_this is a 1 bit bitfield in a u8, but the commit mentioned
is passing RPC_TASK_TIMEOUT (0x1000).  Should this code be changed to:

	args->sa_cache_this = cache_reply & RPC_TASK_ASYNC;

Probably not...  _nfs4_proc_lookupp() is the only caller which passes
anything other than zero.

    784         args->sa_privileged = privileged;
    785 
    786         res->sr_slot = NULL;
    787 }

regards,
dan carpenter

