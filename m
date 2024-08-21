Return-Path: <linux-nfs+bounces-5534-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBF695A3C4
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 19:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5825D284101
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6002B1B2ED4;
	Wed, 21 Aug 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nJZ3K6OK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dDi+g11n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24471B2527
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260835; cv=fail; b=Dnh9LRzLSRI9Ks0Dhp6TsYg3XSqtqE5RsOd74ac3THb7kRjVKAh2Vko1UKGuCFpn4fiVDtyGQV2grWSR3xl3fzPhESdPV7N+GANTUK/UHnVublWnPOqvWxY4oFj4XF54UuqEib1bl8UqLfNq76qcyBnDg2MRk+xRjTMG4RcWYkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260835; c=relaxed/simple;
	bh=Ab6AiRDBPDAykAb1zHElyZrAn1XpD57XuJAG6hc46rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZO56LwekitddPYkMoCC2AJGr6AsrB5nIIiY3BHJZGDlLBXEUskB7tsqBmO+NNq0c0rohN/0t4UAqu/ZR8R9168VYdtudben70Az2sM8bt9/DEHlj0/qk3DymNTCiGv6gtGHXnAj/ZWlchTFaPT7L64hfpBfnweFiq/BKj+40Th4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nJZ3K6OK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dDi+g11n; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDIamg007061;
	Wed, 21 Aug 2024 17:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=ONS77R5FBAz00bN
	4iDbFzZcTFOE0g1nirtiJzORTs30=; b=nJZ3K6OKtjBiljXag2Sz5A3a60u0vyb
	k+85STL4X37ksNNLHNZVAEUL8KLkos2EyuyxlmrufZE85QWYCDibv+YdMq/bHaaz
	j5yCAyi0X6ZZL+rOuf1cP+qHdC9AGDNPcoQBeBmT+Ev+MgE/A/5HMnwC5/zvid5T
	xE1RJ4qY+fEaxAVHxeUAHxq1Szp2EF5anxLxSmLPfUxSocucqZ44yT+fQ7TvNzB1
	HOJtPLy+S4A187zhK9E8QW8OM3XelavGpRmQibiW5d/Q/Dpmh+kuWo67feHkpNST
	KbqB39mKgTj3QfEo021nBGEGqrhB6+6v1f8eK5L392wTiFNC5bLAbQA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4v04d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 17:20:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LGgW18019209;
	Wed, 21 Aug 2024 17:20:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415m0b9mdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 17:20:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXpsFtKJeOSx4PkTatiGEkHLbh6kat9tIaeT3tnTQL2EL1K/hnGDzRhqa0dZ47eLNqJcivsvFM/IIWultvP9z4krmoZOxjIuvw9iNrGYXdcrnMEIxMyW/FRtcmMzq9KGiVVR5TK/4kFFHqBirQs6URtWc/CHkb8XgRn0mg84NvIe9mAYknjZ60WKpa0ECZ6B+JHx+Q7rW4RdcBroB0v4/Vyn96E6l534q4Dwnyqv3OHb12wGaU5DuYqElH4j1IKDWdpyf11goMFJwNVETBZyiQGHXN+XjOqpGwyQ4dcjRIkOXw+ifYxFAx2qg5lZEWnuabQW4rdjo1L78XJGY8aiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONS77R5FBAz00bN4iDbFzZcTFOE0g1nirtiJzORTs30=;
 b=gLMdqgXDrWNQRGwGrpbpeh6vnl1+0DRCar2Tb4GL4YFkgwLWLIgPaoVu8EYPnD61IbJWqOfxAdduaaCchnOEXrCneqc0IFAvCoCcBTj8NvN+WfZt4dxkgDT0ueQNE9I8oMG+KQiYY3nZnMqHjQWx7LmnuijdISB1WP48Y4Jzlnk5MGzvacy02yOtsuTQojI0mZeumWNrC+Iwb3mZ9NYbm2rNG1D00Xo3hHmdJN3O8WvqW9xKNUq5Y8sMrIPP+oAmoEZ8vIsvNnvKiXJ6reA96j96MXzxY22VbUmcP+d9xNVx6uePuhWk42EIeGf2bOaOU0FtWk0LkRKv4KEntnKKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONS77R5FBAz00bN4iDbFzZcTFOE0g1nirtiJzORTs30=;
 b=dDi+g11n4RBqnwYfzK+44WYUdEX/LwROtwwWvgKM6osyYcovc08UX7nf33AyZyJhSaRG57f2gDwu8EywoW4x44lwCDOmDRezJ7aAJjfwBY6tQPdPZL6gXuRJ9rRueNhAOqPLN0fTYUH1B5NHcpZ+edQ+Ezhhj2SuvRMwc5wAn5Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6677.namprd10.prod.outlook.com (2603:10b6:303:22f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Wed, 21 Aug
 2024 17:20:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 17:20:12 +0000
Date: Wed, 21 Aug 2024 13:20:09 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH -next] nfsd: use LIST_HEAD() to simplify code
Message-ID: <ZsYhyYOiJ5qQAc8z@tissot.1015granger.net>
References: <20240821065326.2293988-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821065326.2293988-1-lihongbo22@huawei.com>
X-ClientProxiedBy: CH2PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:610:58::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3b31f9-b6b2-467e-48e7-08dcc20583ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+x0E2+Tv4H4b8TlxJMGdkQEVTj+STfd77pxpoIsks+ac4H2IV/16B3kEw3UY?=
 =?us-ascii?Q?04k9JeEM2qO4rb/lQuF5JKMpBV0dWLE8kuxbwSkNTut9FHwcE3QA2GRSTs4V?=
 =?us-ascii?Q?Yc7BSx0t2QdEym/nVpaZE9uaeNF/xtnbsx4S5TfoxQrsLgQAfQq6l7WTlCKv?=
 =?us-ascii?Q?OELyw9bueKKNS+gyODrsc7SzGDPpon3cLO82N0I5lRm/IyWV9WkAtSzpcOqj?=
 =?us-ascii?Q?5FtgOsXzEEveQYrAReUDlAw6sPAWQ6mXw0KUwNg/QQuaVB45WFonZ59F/Ws6?=
 =?us-ascii?Q?qItTB4Sfwt8CqLc1pUzmEQQwPBXXIUKAinBIFtxdrkm4qDJ8nc8yVGtRF2WB?=
 =?us-ascii?Q?nw8ker7DmU/5kSpXfa+67ooAHXs3kuLMuhzsFj8v5XaKGCWPN1MB+xQHnaFe?=
 =?us-ascii?Q?gRhSxixxoUTFSeiTT/r/MvZdr+V66QvELR1aethryWg8TTPPRmOzHFf86eol?=
 =?us-ascii?Q?CGCxgiu1/xY2J0WK31eCHhjvavc8JDZx/QZEYT+fb5B6ppBSx1TzhTGkzmhH?=
 =?us-ascii?Q?7dHFPZf3/seyR3JRs1HY+vioJTRGFI3ubDoZCWT2ytlgwUsuktx49tEY2kyy?=
 =?us-ascii?Q?MPWxHCEWq/6MSSwe/8QB0tHjmMRklz+spKMYFe/13bAvHiWW/A7ijuhMk6c1?=
 =?us-ascii?Q?WPfbJhzEeXn/n+Gy8a1oTWEy2eyvrag3yGcKWWGagoGc15d3rLJMhp5Mi09a?=
 =?us-ascii?Q?1SanfW2H8ngktGswC1lItkFv62gxXi5Uiqdin2FrMInEzcxv3JCFqv80br88?=
 =?us-ascii?Q?PcrK/jN3LJ9AziuiV0MO1lfI86naGQLD0QJDNjuyX9vlL89Hk2FSNsDFUE+C?=
 =?us-ascii?Q?Oa8oR8UGRqvRGKiiQAC6SqgC4ja1mAx7NxozSlhvUhy6uwZvZ7Fg44jMpNKT?=
 =?us-ascii?Q?FrpGTfo9ptYKnengzdJkLeD4JWR8dRVMdR7F471PW/dTyfTgcOOogDf+zgQL?=
 =?us-ascii?Q?b5V7QPsZDucNl6XR0WczAPFkT6iKvq8dhoPYuzKuNf67NQCYfsD9oeZGgKt4?=
 =?us-ascii?Q?MEePQm3pUr3q/U7jQZnBVUjnKOn5rcWtC0X9I0bxMU/wYTOcSmCIOCt+82nz?=
 =?us-ascii?Q?WW0BWmun1RtsnVWSF47p1YlbUI6aIZOyttP1r62DEmHjp06U4zb3YEqXQRAO?=
 =?us-ascii?Q?fFhQQomnDpXWUNxZ0XOZo/jfeNWsshFxjD4zF+Scs677C089AGEA9A9WTVxF?=
 =?us-ascii?Q?rOvsGuRAoda9WFbmb+EweU/czIEkPENalFMrKoltslwkVASo44H/NJFFstoo?=
 =?us-ascii?Q?3+yLDmNzD7ZcSK3r6NBvLkUojEatrcOPUpl7SwY5BT47bcW1VRNncH9tx+6w?=
 =?us-ascii?Q?yuYo/xdVDLBla2pvH08zrJ3IU+R1WHH/+Bh14+bc2URr8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u1osRY22W2Bmi+UWiuclIy9e4SwjUG4QI1KUDqV9sT65eHzgE6dtHukb/A4S?=
 =?us-ascii?Q?y0j+l8IYcwPW8z6GllmmIVrXYxSyZgzY8p0rhdJ+vta6Iu/JKgu4Tgvpo7Mo?=
 =?us-ascii?Q?YA8niKHEd9Q8LIHtusGysF3ItkanNSn8B0Ydf/Wp3ZcvEWP2Vomh2cryLMvk?=
 =?us-ascii?Q?gDUlFUdQBKytJGl+ANrol4XeuSDSmOMOJtq9Wjm3kobmldDup4lGi1LnZX9i?=
 =?us-ascii?Q?LJ32kECwQzhDJNulTlwsseHzUaqnRdHMf/GitIp65v29Kf0jAdmmwBhVrKdX?=
 =?us-ascii?Q?drNTPSB7fRQ6Imm/tLAiB1YpI7dOC3mU4qK8Kj+3a/IdeimxQLyNSJtxj0MH?=
 =?us-ascii?Q?/JJu0XG7Um2LAaDrqMgBTTpUEbLgcBErYAxli3ZdPSFMZoiNE7oZGh21h5t2?=
 =?us-ascii?Q?F2NzXjwHy8qCa7QM7MxQ8gumOutZ0fSKps+3JRHrb2l3wxGhaIkl4+JXHRRS?=
 =?us-ascii?Q?HnX3Tj3+5Pa5OsvbYl9PmUYhy4OSWHJJ2e7srT20pnxxYawMJPVW1SOlKPgZ?=
 =?us-ascii?Q?vLRd8CzPXvjMd/Q1aSlHZsnQTvjyFbx6iwCNbQsv+G7Wi8Fcsdy0KQ6UJ54b?=
 =?us-ascii?Q?qElyYLceOYutS5ROss45EAcau4oRTPzTWom5LIMM1Nuk9Pt7CxgofhZRlRQk?=
 =?us-ascii?Q?mSMr0vymi9+grtRJ9FOUc+KWqL/x3vpn4NDJYT+Hp+JMSY9fU44Kl7Xq7VXg?=
 =?us-ascii?Q?qJ7lFjfachiP0c2AoQ6PM3yocqk1MF+UgTJw4QWQdZCQ5kYdWNPWJOUFUIH0?=
 =?us-ascii?Q?WQ+Zksx9Tg6yxJSeQdmRBOrqwklPyefjVh1649gSZuT8OmOHAXkLUaP5YZgX?=
 =?us-ascii?Q?B4NLcQWnRWEM2YT8Pq2/fMdF0aAOKITicvcjppI/xFLKvGtnfjiPyJnYXm+d?=
 =?us-ascii?Q?vwBFCFwVwa9MiErrCM+zJK3vmurlC6WUBOzqW5u4k9xtWSpJ+Hd3SSM0Le42?=
 =?us-ascii?Q?qykwEQWEkOT2ZczJM6cfl4iTPBQtgACaQ0DX8HDOl4Zfz4FQftcpVklOBu+Q?=
 =?us-ascii?Q?a8uJ3CIUQJdu+0cEEdKn1ryhwQ7PsV7jdrYEfc7s6ueW5na7c1PYZn0mf7hT?=
 =?us-ascii?Q?sOINeV9l7Ef1E020B3FJLU2IEWHrbulziC14L0TjBoxVyHMwg3HdWFpfjW2s?=
 =?us-ascii?Q?cybPTyPjlUsHkkekD7VakldXUciMuoW5LxQc5SoyHfofu+A2rfV1JESGkzPT?=
 =?us-ascii?Q?3gHjkfEjjrjPI57pLaXy0Hw0Di3/A/Kkv8KLS88wvSu32n0U3NhnlEI5lf7T?=
 =?us-ascii?Q?MLp3iQx2yZ6sublOhquDHf/55ipRcxvjLjFi3K9/tQfUT2J2lXnyIultAkYd?=
 =?us-ascii?Q?5SmXlid1rRRRDtYuyxcdL36sdLuw1vkqInD3XOzscBeg3tu6S8cMckPnVG5P?=
 =?us-ascii?Q?IxkXr+X17Sg4NijP6r+4WST9h3/fukfdrxsB66/PJv//eDIbyWX+wvrt7vv5?=
 =?us-ascii?Q?CdVPa5TvRPY1K52mlBO90YhJIw1I0cYMTCWMa041iG9dyuyOSCnpgiYnPEJb?=
 =?us-ascii?Q?4uIHXAAXOzUs7sqOszhUqs3n3dkxEa7EGuVZDZ3RU58/uoJCaJqHkDsMEJ6j?=
 =?us-ascii?Q?7RmCXSrBzZ1lTNuCkJE5Ap5VAjOMirf/NXXrr8Bw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OEubh72lFQza9qmu7s3fdfjp3WwfZAUk8xCGR52U0/WJQunRZbAr1gHHQxY55g2gK18vDLpNF8wA8hw2+sBKQQ/MkKJDFdWecDeZcCMOZY3ZDv8/nSIPzTdH6ZrrcVj7mJ87rxj3OT1Y2tRtCPLa4OE1FPv+tFh6lLKxdzQ1y1LOnNOSdrB422qRfKoA/g47gKTlQP64i/iuBI/JJLldWlANY8gq1sp9Vq1Rb6ibZUZcPE+I8NqF+wRUEh/bmbz2w/53w4jRV4HreTVPUQ60sGO7tQZigExaRE0C7p0CC89Bxe7dgnB1N6uDsyyi0BtWHBBsCqXWNB8GuI0AzmOCN9/e5Ewva+tP5ZE7IPBb2Hjzvp8/P9nwdcq3iUmlRcL/ZRORW8VZqioxxeK/WvoPU2kAKkFCUkOmpmutRqboKfRl2wz5chdPvOZm+1Fjgi1ppOdgo/j4nB8R9O5sa2lVMmBwmecLpQJICSJbBttPHapxv9bXPXmybMmuUZRm6dllTc8a7GrpswdnPY9Bh/AIyXEtpvw+Qn+/MhluT1pVTYBYuOiX0BxMBtdagP6HeNTPXH68Qui91LTXjTSU1FWxcKAYVQKWuBlF60w61mondLw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3b31f9-b6b2-467e-48e7-08dcc20583ba
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 17:20:12.2869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VL3cBk1wiy6GKE15Mw18wFiUd7mq9ELd03jsFcFka5d8t3jfky1PsN31+bF5YLLv+04BRaldbJkrmL1bmD0guw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210126
X-Proofpoint-ORIG-GUID: ues1dl6WHEEDDXJ4J9GMKlSiV_iOXHVl
X-Proofpoint-GUID: ues1dl6WHEEDDXJ4J9GMKlSiV_iOXHVl

On Wed, Aug 21, 2024 at 02:53:26PM +0800, Hongbo Li wrote:
> list_head can be initialized automatically with LIST_HEAD()
> instead of calling INIT_LIST_HEAD().
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  fs/nfsd/nfs4state.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a20c2c9d7d45..ee852719d07d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1663,9 +1663,7 @@ static void release_openowner(struct nfs4_openowner *oo)
>  {
>  	struct nfs4_ol_stateid *stp;
>  	struct nfs4_client *clp = oo->oo_owner.so_client;
> -	struct list_head reaplist;
> -
> -	INIT_LIST_HEAD(&reaplist);
> +	LIST_HEAD(reaplist);
>  
>  	spin_lock(&clp->cl_lock);
>  	unhash_openowner_locked(oo);
> @@ -2369,9 +2367,8 @@ __destroy_client(struct nfs4_client *clp)
>  	int i;
>  	struct nfs4_openowner *oo;
>  	struct nfs4_delegation *dp;
> -	struct list_head reaplist;
> +	LIST_HEAD(reaplist);
>  
> -	INIT_LIST_HEAD(&reaplist);
>  	spin_lock(&state_lock);
>  	while (!list_empty(&clp->cl_delegations)) {
>  		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
> @@ -6616,9 +6613,8 @@ deleg_reaper(struct nfsd_net *nn)
>  {
>  	struct list_head *pos, *next;
>  	struct nfs4_client *clp;
> -	struct list_head cblist;
> +	LIST_HEAD(cblist);
>  
> -	INIT_LIST_HEAD(&cblist);
>  	spin_lock(&nn->client_lock);
>  	list_for_each_safe(pos, next, &nn->client_lru) {
>  		clp = list_entry(pos, struct nfs4_client, cl_lru);
> -- 
> 2.34.1
> 

Applied to nfsd-next for v6.12, thanks!

[1/1] nfsd: use LIST_HEAD() to simplify code
      commit: afec13278f4ed7dad696cfdaddbee978d905b9f2

-- 
Chuck Lever

