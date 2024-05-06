Return-Path: <linux-nfs+bounces-3184-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BB48BD6B7
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 23:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E73A1F2176A
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 21:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684B515B968;
	Mon,  6 May 2024 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NqzoUsGf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BAXzTpld"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8967EBB
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715029999; cv=fail; b=AsJUxgglsjOaVTAWJzpLQUw+I8uzZcMFhMakhBfUBRLqAEURy7/dp/O+ghuLA6lWPjODgCmumqySHt/IgBAa/qUso6vnhBzShB6txWlhADiSc87oEB8HY9cJwybPFd5o9T6C3nOMlc966+X4/L4qQuT/wxuWaUiHqUED1cA1wnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715029999; c=relaxed/simple;
	bh=VbzY808AOtStTb5JLj/JbAfJHtP5tmXZJ7Vce9JrycE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IHTD3DkYJKBPH8KJ8SuOdduXVGx7iVeeoUH6MVQXar9/1QGORYb5mDb+5s4xZDc9hCwhA7RBk8n89k07svKOWSlo4d+8zJvUwUNpLaVCz75E5mKlQqeCXPc9Xv/ZAtlzqpanfSNF5XFe9bl8QHZucdIc8enh8ZyPuOjIbdqqI5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NqzoUsGf; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BAXzTpld reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446IF7RX007305;
	Mon, 6 May 2024 21:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=Sp5E1AUh4F78RPILNd4p3VoQMLw+ArMxFJXNfoO4K3Y=;
 b=NqzoUsGfjm20ZcmT3pdhW8Oo4ivy4xTbC+9JAzqjrVb+cJy7yJGElChx46R6NQGwWA2F
 qmAGZRwWmivr37XiBvP+unr2nVCYDWrI/+XVzz4p69rEAYcoaxsAfGZme1sWaBfPJShD
 y0MgU3RAYx8KFayemZxPnl32KWl/AE6/wdiewJX6RGOFDkQA7iKTb0R68ppgQ5qHybeG
 Jn5UP7cL2+vcnnT60Ph9IBauzR3iMV//ybXYfEAoSJyeqZOe8BXzX95h9SON9TyMql2e
 qFkNkC86JB5ZhmgbYuUREQS9XQ98aUdjM53O/8StcXhZWub2k/mjDd9PiyfAiXBELS+j Ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcwbujmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 21:13:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446K14ne029401;
	Mon, 6 May 2024 21:13:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfcdcmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 21:13:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKXQzilKLoSBGlnIwFghD/nYML4hKNWx1oQ8Sw2z7xr7/EbjfVtYd+iy3cfUNn7FMy3X6KsNayaoggHqM2Xs9UuNWu6tjHqqtLo1s0btLchip8AVkkssuE7eJFRTwpydAMNeja+sJxH/lgaCUbMeXDxQaL9gG4RkliLM0SE+VZya9bNYRINFB4oman4IVMJ4v5wwspTAWvcJKRqB3YdVrTH8v/8ji2cEqsZKoh0UecP9oiX6RX4H7cVbbj2If8DFTdqzgzWva9stXs2/4tZYcsANnfEXnKMRpHkOyq8TDNNKF2DhupK/2yhehDO4kVE/Z+3+OssK1CuJcy178YFtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yxGUtMu7n2SdRkLdKvHYCycKlKaKy5oIFwtypRUEJM=;
 b=KQY5MhiFM0watBYkGvE/Mlx+LcLRFjofva05lhhvpruD14Jk15aKA74owLi9a/b2E/JKR7Su0klXq1aBHXfpuHCB7pCpQJ1QEyiM87aHkI0p/c9NbC5CPgpO7iIwz+1PTCfS84U7Ji4XLyeAk44eohpK+nQDF53K13b/lKZxpgtKiVvaCfwTSJZqIFMnAyfB/L/uBEZF/yl/2h2R5iwSDxs4zy6mzh8r+F5akDtSsp9odS9O9fBr83SkDX0twSTFiZTzZZ3WJRGKGu/aAgvsOH+dhIfEgstpqKYipUaqilGug6FJQhE1ufmObV33eMxeUb4RK6t6/spY0hsATEW3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yxGUtMu7n2SdRkLdKvHYCycKlKaKy5oIFwtypRUEJM=;
 b=BAXzTpldF4WUAf4pwOUeIoNVcol9qWTK/MhjebPzHzVFY7w5VVEzpd7k45rOr/AdVoCzTcWo/1AAs4aZkYkb5sbdV/4qXco3aAinbszUYey8loCrwbWIQgRm0BBjH7xxDvrjQJ6cpjYk41ll7qMbHgQf4iKrrdvJWjHPCq7AFhI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5797.namprd10.prod.outlook.com (2603:10b6:806:204::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 21:13:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 21:13:09 +0000
Date: Mon, 6 May 2024 17:13:05 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "cel@kernel.org" <cel@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
Subject: Re: [PATCH] SUNRPC: Fix gss_free_in_token_pages()
Message-ID: <ZjlH4YdsBCYpFQwN@tissot.1015granger.net>
References: <20240506205245.4455-1-cel@kernel.org>
 <528891aeeb2686245cf9665d38c760f4627165fd.camel@hammerspace.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <528891aeeb2686245cf9665d38c760f4627165fd.camel@hammerspace.com>
X-ClientProxiedBy: CH0PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:610:cc::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 612ac9d1-de5d-462d-80c0-08dc6e11545a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?iso-8859-1?Q?+QlEsKdVUgEHXym7YvIjEqyudBTry/4fDVRMAx1LZBC6fTbwtrxA8qBVL9?=
 =?iso-8859-1?Q?5mfery4hqSGyb/7lvN1raRYt7l3/eMGF6PWkl52GrkNFuElbpg4yDpxblX?=
 =?iso-8859-1?Q?iJ6RkSZ1pEHklw+CEcvckQSpsUhNDSu9uK5Bt/trk95vk2XWobj9BLWFmU?=
 =?iso-8859-1?Q?7yjqkHo4OmM45ougLIBRcXYq5W192XwEj71mg39ZpSpL+AkAMyAvGngtS8?=
 =?iso-8859-1?Q?5Bjwcy6bn0R/uoPSoafVSaTevvKWQVT0445nkrTVzVkfyG1jt7NGN4FVCL?=
 =?iso-8859-1?Q?6jMIRiZTKbMA4NMEXj9Zp5sXl9dCi2tNKJchCFcWP23LZy/t+RRH3CAOAV?=
 =?iso-8859-1?Q?15kOnq2yMMYElqNFoIPE6P3FpE0eetASoUKupNT/AwLk5mQ5vPR8tXtEST?=
 =?iso-8859-1?Q?UUm7XAIxhTr0qR+mBiGHsF13MhnxOecDqKqw6sfjrcRv4xVvItJhNHVV/Q?=
 =?iso-8859-1?Q?4eZDxrwD77/oalvTs4iPHGQk5xnDtzbUsWSOJpP0OUrlT408ZJ+ZIL14kw?=
 =?iso-8859-1?Q?9uPmJ15s+7HplYZJXK8d7wo1Y7sTiWvDMvOmlX3OUbMVdVTl8wtvhdfcoP?=
 =?iso-8859-1?Q?ZFXBVmxx8y2gTBF4Lt8hUjEp1AHdsyI0umzNeHQdbMmHk4ntMwF7/+Batg?=
 =?iso-8859-1?Q?Q1QAWxf6FR0cGk/lL8jfiGjut46XpPtWHm9g1H8sEqSOW+yW7o2Fm/2bES?=
 =?iso-8859-1?Q?q39kRI5OfgNo/0YhU0Hc5BT+6oko8NpsBB2RKFUDwHpSWXbNSV+8ekMMRQ?=
 =?iso-8859-1?Q?vmZIf24jiz8IsjkQVB40lvidARlnEPaoAlwfsy+oPg/Uwt+P8qLPlbHno3?=
 =?iso-8859-1?Q?wtl/zAJa24YV7Hd1eqY4QXN8s6XlzVI45KROUMFehwxaf2G6UrUV7RPiML?=
 =?iso-8859-1?Q?z2l9flZdCrfOReVQf28OwNskJVOlvSK49X+SNMNMgCe+ly03i5uyMt6EEt?=
 =?iso-8859-1?Q?aO5cBrWc8HQyUerUi+DTYsKw54dYDn8c9rnuok8SwNSH0ehi771IRt7OWr?=
 =?iso-8859-1?Q?S793Mz4bLxZW+T9NflZHyg9xKDdfEuEA0ErAZOkAt2zBOsZmp/nO7cqjJa?=
 =?iso-8859-1?Q?ZoImZJ2i6C1oTBPq5YQJ16b3R19UommlS3hxRJj04mV+pZip7JlGWuJdUF?=
 =?iso-8859-1?Q?66L1XixjC3Iae6XfN4VZsebsXx0Ch0MsJGDwSWeboJQDRNg8PMR7XUI9zp?=
 =?iso-8859-1?Q?N9sroCr/e3M226e0S8mTx4bpnUGY6Iwhjsw9tvLM4Lv5CMskd8j2HxOuzM?=
 =?iso-8859-1?Q?4iIanofrSlawFh80ECVoMOrjqABKXlZXT69NaNcUKRvgode+CnMU8qZpA4?=
 =?iso-8859-1?Q?i8bDvQj4gwt2gPy0LGlv7nSOVA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?K/d33KwENaDfceTUTsskFA9zy5smNHsPswD9bbmi5KxGOjm9jUjadFUywS?=
 =?iso-8859-1?Q?pycrbPwuY/mND2e2K5Cc+fngTdBkuwrMoyb/ds/YO7hjyvPORy1T/lWJZl?=
 =?iso-8859-1?Q?E3u1hOR/a0E16T27xjGaA2tgDSVqglsd1zJnNBIBlsd8tmWNbO3copOeUa?=
 =?iso-8859-1?Q?JGZdpRNhS2abRmG046aDnDt92lIPPgNzzGMzKIauFBVjj4eafsNm9uMtRt?=
 =?iso-8859-1?Q?KjcR9dLHOiPzkPAKnzBsyD3TqovU4hSZXHZsmAgRIb1lCx7UKnoon1M2qG?=
 =?iso-8859-1?Q?R//zbrTaIQHbi41ezCh9pyVr71Tx1s/On4ckD6cAT4iVoEfzMXvevObzof?=
 =?iso-8859-1?Q?/lfHQE+S2vErihp96nhD62rTBrk6mHW/CpXj6w4P+XtHjd8tN7Ni4ieJHE?=
 =?iso-8859-1?Q?NAd17tPXjjB9CPlPvKRi1HS4HHxgelHW9FWOySYxJET1vCxtfBf7veWUmj?=
 =?iso-8859-1?Q?uIRylQvejuNeD+/DQBVWPfvD/DsOVKQ8Qxa0LlVxEC5LICwtM07jubS7Y2?=
 =?iso-8859-1?Q?fKGal3xqWFsbzp0Xeuv1XlVHpzLZTzS8bwNIYodgF+x/H+7Z8PIiPX8wtr?=
 =?iso-8859-1?Q?pGXWHc0wacWXgMh9C7ifZeIrfO9u80JC5NvMYbIbxcaYBFSQ+dOLSC4eoR?=
 =?iso-8859-1?Q?zuyBoWkiNOA6FgktNWf7CBPnRwoN+rWb9aAAFcg5SPfuvXUP5QIma+tVRN?=
 =?iso-8859-1?Q?jtePQnkWd4T9aEfMkBl7zpe6v+37iqEu878Wwt+7DUcnxw/1GzJ1kZ42cB?=
 =?iso-8859-1?Q?upHeFlv0uCBJpQXFXVi9ODCmoums4aSBQKc0IdkwzR8PW/DweDX1B/+i/q?=
 =?iso-8859-1?Q?5dYi+SORxaFd2eoiJMzH7N4NowYNuHNEvqVCav2czzuMXW3+dEP2uYZLej?=
 =?iso-8859-1?Q?5LV/Sj2/sTZis6AFDYipF3btoJyBsPzdaFEOcK5N13lBIgoScC557HpY3l?=
 =?iso-8859-1?Q?ZH2C+QyLcBe3HFwop9BR/OWAzfJI8PPYe4B7deF7dlpoRzcrAg4ILBdK7u?=
 =?iso-8859-1?Q?DrEUH1425b0ZIELUb9RtFjoJebMPqFAREM0SZDCx7sFPFkqI7IxtZsTaR1?=
 =?iso-8859-1?Q?UYhh0Ek85ErlY4AHOCh33Wo7cFxsfQpzpyOYy22Fo5OKv/aCOQWT1GtKR0?=
 =?iso-8859-1?Q?wzEyq6vXmFbCN3EOHvY2HbemvcUqzqKfD2USeNVhvd8BITEmUt3lYLQUEf?=
 =?iso-8859-1?Q?2cMPSg9yBZVUvaEyDLz6OJYpjwPaCwHoA3YEpX3dxbeb4isl6aq7OqPLLW?=
 =?iso-8859-1?Q?UORZ6uRAFRn6HmmvOoUCz9Ef9KTZ2Sfr0BCV+EAIQyPJqZUs+3cpKqUH7w?=
 =?iso-8859-1?Q?LcCP8dJNO0OleyLtOZyoxhIgyJGgh9zHlB95qQPjpxYElxPklRqZYpCKVH?=
 =?iso-8859-1?Q?xFG9lpYvUhnUnVqiBDzNjPV/MMFgW31sCXxQTKY0J/VJMvvp8D7dp9e26E?=
 =?iso-8859-1?Q?Hmz0BmVNTVemYy/rtGPUhFJRQKxSm1VRlOPfcKlAwfQw7ocInQ5zEbNJCW?=
 =?iso-8859-1?Q?kLwYvRgBGw2OxF2SBPFLz3OURoyaB68gbnE5FWKJNfPZIQQPN8dsnVPxNj?=
 =?iso-8859-1?Q?U1HDOsKbdWUc6z4r/m34OMn9ikxX10SJNlt31Xt0jPjSku4QOykb7Bgp49?=
 =?iso-8859-1?Q?LmTLiZdnRiyQzWfhjKwIIgcy7Iil7ckzQwTvp4xdPF8axe7v3Lmk01Vg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dvRJaPhUK6QZU0pORKD3UcAjF4LUzauLhipk5ZvC0jg5TLetN+EL7sSOthJEtUyYxdgeAR7VzOGpO6dmuJho9cBsFKE0yeSqntgZBW96EYdGQmRz9c49TehRnru3KXrCtZBh+xjFJwqAFH1j6mUPEOkfjd7oCpaAPCiNTA7BiRpWfq7XYFypDASnadfc0frkx5JURvXWpzqBg7NepJRGM3j08bB6igxh0poWIdsVCA/dTlHe3ql7rAFJAn3cl59C//7i9JCPtQTf1MTy+ANSj3CNs0XHquPzkLPiNiHAPjJYqXPO4+Gkph//6xrhilQjBnfGx1G4ZU26paNJw0L2wPtKqonsAvTmR5dxRxT3bLBfeeCwNxQhkzUTDHp92aPTwkIi4JRivsgv8Ks4t24i1S+YWf0WLhTca17Ivc3H1ZnksZ2AsrqjQqYhZFRZ+2nbbmiVFowgCfmj+OXnEGj40Ln6ra+bs/wD4SltMtV8HdFk+0KGAXmWkW8twvu37lvGMkKCQIz2Vc75M3SJ39pDdCjPAjn2NbvwAutIxuQjt1qPS1lVnZTru/KZysdD6rC+dA0ZEpcgtLbZAwnSfluGKr8eBZzWxVnPZWEXrOcczqQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612ac9d1-de5d-462d-80c0-08dc6e11545a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 21:13:09.0842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSxWERNqWrEM9Nt6RTbBOD15ERssqSMm/5iitu9mz/pAcDh6zZTOTbDKEJMvRNJ/4JoD1E9yufAAwK6jcxZ8CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_15,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060153
X-Proofpoint-GUID: xIhVXiP2UyWo8v2PLTwR0jRCfb0d9tQZ
X-Proofpoint-ORIG-GUID: xIhVXiP2UyWo8v2PLTwR0jRCfb0d9tQZ

On Mon, May 06, 2024 at 09:05:34PM +0000, Trond Myklebust wrote:
> On Mon, 2024-05-06 at 16:52 -0400, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Commit 5866efa8cbfb ("SUNRPC: Fix svcauth_gss_proxy_init()") from Oct
> > 24, 2019 (linux-next), leads to the following Smatch static checker
> > warning:
> > 
> > 	net/sunrpc/auth_gss/svcauth_gss.c:1039
> > gss_free_in_token_pages()
> > 	warn: iterator 'i' not incremented
> > 
> > net/sunrpc/auth_gss/svcauth_gss.c
> >     1034 static void gss_free_in_token_pages(struct gssp_in_token
> > *in_token)
> >     1035 {
> >     1036         u32 inlen;
> >     1037         int i;
> >     1038
> > --> 1039         i = 0;
> >     1040         inlen = in_token->page_len;
> >     1041         while (inlen) {
> >     1042                 if (in_token->pages[i])
> >     1043                         put_page(in_token->pages[i]);
> >                                                          ^
> > This puts page zero over and over.
> > 
> >     1044                 inlen -= inlen > PAGE_SIZE ? PAGE_SIZE :
> > inlen;
> >     1045         }
> >     1046
> >     1047         kfree(in_token->pages);
> >     1048         in_token->pages = NULL;
> >     1049 }
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Fixes: 5866efa8cbfb ("SUNRPC: Fix svcauth_gss_proxy_init()")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  net/sunrpc/auth_gss/svcauth_gss.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/sunrpc/auth_gss/svcauth_gss.c
> > b/net/sunrpc/auth_gss/svcauth_gss.c
> > index 24de94184700..bdd8273d74d3 100644
> > --- a/net/sunrpc/auth_gss/svcauth_gss.c
> > +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> > @@ -1040,7 +1040,7 @@ static void gss_free_in_token_pages(struct
> > gssp_in_token *in_token)
> >  	inlen = in_token->page_len;
> >  	while (inlen) {
> >  		if (in_token->pages[i])
> > -			put_page(in_token->pages[i]);
> > +			put_page(in_token->pages[i++]);
> 
> Wouldn't it be both more efficient and transparent just to break out of
> the loop once you hit a NULL page? You already know the remainder of
> the array will also be NULL.

Based on the way that the ->pages[] array is constructed in
gss_read_proxy_verf() ? I guess that is true.


> >  		inlen -= inlen > PAGE_SIZE ? PAGE_SIZE : inlen;
> >  	}
> >  
> > 
> > base-commit: 939cb14d51a150e3c12ef7a8ce0ba04ce6131bd2

-- 
Chuck Lever

