Return-Path: <linux-nfs+bounces-4756-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3B292C4F9
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2024 22:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056D528178D
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2024 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866C3146D74;
	Tue,  9 Jul 2024 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ob3XUogJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F0A1B86DD;
	Tue,  9 Jul 2024 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720558084; cv=none; b=QSEcL5t4XH/w0Ly8PewCzI5abw5cOfF5o1iunFW+X3nVx1tQHW3kdHnn8cew+KGaQuOOMYTYwD7SYt2UvFuVAWTg4DIW58rfyKECJig+JYF+8gGjHGLjHYH0qlb+8toJRFxyjDQtYt/XlKhO0vVY/6eQfe8CHcYfmjGvkKscwbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720558084; c=relaxed/simple;
	bh=0IDf6TB+FYUHkNkAUQiGcWACaOXwFtv93FPLqJAuQF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qKABrg6mUGXBopM0v+zJ9xIWPcFj/XCzW2Dy6FyAKY5SyNV0Q0Sj4TiQeqBf6dvuVdmcOj69v+u9MH/jA6gj9Cpsj/iXtO77a6FXGhz5Tv7AVHiGF6TVs8lKVEEjbTzXVNFj4M8GasBsc7CeDE4EL8BNQUbVcLcvdN2oybCbLLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ob3XUogJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469C1YTq003817;
	Tue, 9 Jul 2024 20:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gjNkgghvbaiGaVfC9986p0MdHkU4HA49qHYTTJZJj+w=; b=ob3XUogJJYo0F6Iw
	dAlAUZfolnpZiFGj7Z365Xx6MLB76up8l3/wgNhUhN0z+mxVCJ/1VpE+7g7WQJzg
	7AS4iqTP/8tmDYYKZFJAQvxbybfrPW6aC/QOZwvv12q49C6Szjlh42cNg7/P1miF
	xJfebFzaQrjodTJPY5mxUBBRcK0WTjdVSB93hK4WXMb8oo+flHlj5N7A14LHuno1
	K2CrwhsxcM9oJHIn2syZaUhgZYg4h+zg2Me1DNrK27EcBa6YjVHl422ZNcJZFGzu
	8ZD4aQZQRM2fD1MXQFecjvHDH1A5gp/a4ZCm0UapkibYgLAvR3JBeZdsiw25mRqd
	mQ+3sg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 408w0rae1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 20:47:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469Klmvt014652
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 20:47:48 GMT
Received: from [10.48.245.228] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 13:47:47 -0700
Message-ID: <e0a9f5ab-92d4-4a41-8693-358e861f2ef6@quicinc.com>
Date: Tue, 9 Jul 2024 13:47:41 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: nfs: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust
	<trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck
 Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia
	<kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240625-md-fs-nfs-v2-1-2316b64ffaa5@quicinc.com>
 <abe2e12fcd6a64b603179f234ca684a182657d6a.camel@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <abe2e12fcd6a64b603179f234ca684a182657d6a.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bDOqncjgmTe-V7cPJHhh8rGPj9jFqcW8
X-Proofpoint-GUID: bDOqncjgmTe-V7cPJHhh8rGPj9jFqcW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_09,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090141

On 6/25/2024 9:44 AM, Jeff Layton wrote:
> On Tue, 2024-06-25 at 09:42 -0700, Jeff Johnson wrote:
>> Fix the 'make W=1' warnings:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in
>> fs/nfs_common/nfs_acl.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in
>> fs/nfs_common/grace.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfs.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv2.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv3.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv4.o
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>> Changes in v2:
>> - Updated the description in grace.c per Jeff Layton
>> - Link to v1:
>> https://lore.kernel.org/r/20240527-md-fs-nfs-v1-1-64a15e9b53a6@quicinc.com
>> ---
>>  fs/nfs/inode.c         | 1 +
>>  fs/nfs/nfs2super.c     | 1 +
>>  fs/nfs/nfs3super.c     | 1 +
>>  fs/nfs/nfs4super.c     | 1 +
>>  fs/nfs_common/grace.c  | 1 +
>>  fs/nfs_common/nfsacl.c | 1 +
>>  6 files changed, 6 insertions(+)
>>
>> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
>> index acef52ecb1bb..57c473e9d00f 100644
>> --- a/fs/nfs/inode.c
>> +++ b/fs/nfs/inode.c
>> @@ -2538,6 +2538,7 @@ static void __exit exit_nfs_fs(void)
>>  
>>  /* Not quite true; I just maintain it */
>>  MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
>> +MODULE_DESCRIPTION("NFS client support");
>>  MODULE_LICENSE("GPL");
>>  module_param(enable_ino64, bool, 0644);
>>  
>> diff --git a/fs/nfs/nfs2super.c b/fs/nfs/nfs2super.c
>> index 467f21ee6a35..b1badc70bd71 100644
>> --- a/fs/nfs/nfs2super.c
>> +++ b/fs/nfs/nfs2super.c
>> @@ -26,6 +26,7 @@ static void __exit exit_nfs_v2(void)
>>  	unregister_nfs_version(&nfs_v2);
>>  }
>>  
>> +MODULE_DESCRIPTION("NFSv2 client support");
>>  MODULE_LICENSE("GPL");
>>  
>>  module_init(init_nfs_v2);
>> diff --git a/fs/nfs/nfs3super.c b/fs/nfs/nfs3super.c
>> index 8a9be9e47f76..20a80478449e 100644
>> --- a/fs/nfs/nfs3super.c
>> +++ b/fs/nfs/nfs3super.c
>> @@ -27,6 +27,7 @@ static void __exit exit_nfs_v3(void)
>>  	unregister_nfs_version(&nfs_v3);
>>  }
>>  
>> +MODULE_DESCRIPTION("NFSv3 client support");
>>  MODULE_LICENSE("GPL");
>>  
>>  module_init(init_nfs_v3);
>> diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
>> index 8da5a9c000f4..b29a26923ce0 100644
>> --- a/fs/nfs/nfs4super.c
>> +++ b/fs/nfs/nfs4super.c
>> @@ -332,6 +332,7 @@ static void __exit exit_nfs_v4(void)
>>  	nfs_dns_resolver_destroy();
>>  }
>>  
>> +MODULE_DESCRIPTION("NFSv4 client support");
>>  MODULE_LICENSE("GPL");
>>  
>>  module_init(init_nfs_v4);
>> diff --git a/fs/nfs_common/grace.c b/fs/nfs_common/grace.c
>> index 1479583fbb62..27cd0d13143b 100644
>> --- a/fs/nfs_common/grace.c
>> +++ b/fs/nfs_common/grace.c
>> @@ -139,6 +139,7 @@ exit_grace(void)
>>  }
>>  
>>  MODULE_AUTHOR("Jeff Layton <jlayton@primarydata.com>");
>> +MODULE_DESCRIPTION("NFS client and server infrastructure");
>>  MODULE_LICENSE("GPL");
>>  module_init(init_grace)
>>  module_exit(exit_grace)
>> diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
>> index 5a5bd85d08f8..ea382b75b26c 100644
>> --- a/fs/nfs_common/nfsacl.c
>> +++ b/fs/nfs_common/nfsacl.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/nfs3.h>
>>  #include <linux/sort.h>
>>  
>> +MODULE_DESCRIPTION("NFS ACL support");
>>  MODULE_LICENSE("GPL");
>>  
>>  struct nfsacl_encode_desc {
>>
>> ---
>> base-commit: 50736169ecc8387247fe6a00932852ce7b057083
>> change-id: 20240527-md-fs-nfs-42f19eb60b50
>>
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

I don't see this in linux-next yet so following up to see if anything else is
needed to get this merged.


