Return-Path: <linux-nfs+bounces-4206-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FE99119A8
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 06:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2028C1C20C02
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 04:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6A312C7F9;
	Fri, 21 Jun 2024 04:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZG21aij8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDB3EBE
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 04:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718945008; cv=none; b=JrwHyGmOP0N2W8LS3+3JMYLhzTe6djfgQuyQnf7gNnbL1ZiLhfjqIgdgrNu3ld/tslS/7zkmbnqD+Bo70ZOPGdysyQ+EZO9LDd19nh38jtorDwPatt1ov7bRU1BuQoZW6CAQAhMDVItYHkMOz+cDyOcvqFC8NA0dSnmCdOKAnis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718945008; c=relaxed/simple;
	bh=aU2LscF3D48a9W6xDKMEP62XbyB0yI0ks6PC23L7krg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L9xoluMiXtB+I8Xxk04h1889WEcmFS/qsFmlasXQd4LpUb7UXKeBkuQWCM+++PK/VL9dwX/cdDXFgpz3sGVBtUujmR4id2yMV20XYZizJeHEgxuRoOzOuNW7pjDWmWbLSIj+8Y/7wRHS0G6GTE8DZ6fu7POuX+QwImM/1G8aTEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZG21aij8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHC7x0013905;
	Fri, 21 Jun 2024 04:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fpdjPZs/oJuC6GieWZZzUWSaXdt9dbMmlBgM5Vu20Jc=; b=ZG21aij8V+1+QY/I
	2RHJKmISobV7qtbnr6x2swtSXeG+TdxnRKJGAhtV8sP3TQMtZquhsUvUpoPGlWW2
	7sbe46i2CBu+sRlqTQ3wAG10rtGvZFA8ca4NWrlW2m2Us4pGQyXkUUU7ztMIPkP0
	+zK2HbtSz7X0/N8C1YjxVexz1zYjqe9B9MLmzJW0G8tfCIvBe9CW0O/iei/YWj5C
	syHnha0I2R7h52wBtFBtl3B+hIqbMLfftmUgsb8iPbJgliTPxLdxu9kvPwfebu/o
	TASo5kcBZVaoCgeionfUZmJWeli+PEqMtgyQlF31hsD1dKYQNu4R32DrtUNFIF9m
	br06LA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrm7sagu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 04:43:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45L4hF5U021868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 04:43:15 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 21:43:14 -0700
Message-ID: <63919ec7-eb3b-4952-b1c1-d20d09389252@quicinc.com>
Date: Thu, 20 Jun 2024 21:43:14 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/18] nfs_common: add NFS LOCALIO auxiliary protocol
 enablement
To: Mike Snitzer <snitzer@kernel.org>, <linux-nfs@vger.kernel.org>
CC: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        <snitzer@hammerspace.com>
References: <20240619204032.93740-1-snitzer@kernel.org>
 <20240619204032.93740-6-snitzer@kernel.org>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240619204032.93740-6-snitzer@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O_DQLA9zuoA0kox10QbMm9ffnWJHU2wL
X-Proofpoint-GUID: O_DQLA9zuoA0kox10QbMm9ffnWJHU2wL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_12,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=692
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210033

On 6/19/24 13:40, Mike Snitzer wrote:
...

> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> new file mode 100644
> index 000000000000..086e09b3ec38
> --- /dev/null
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/rculist.h>
> +#include <linux/nfslocalio.h>
> +
> +MODULE_LICENSE("GPL");

also need a MODULE_DESCRIPTION()

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the 
description is missing") a module without a MODULE_DESCRIPTION() will 
result in a warning with make W=1




