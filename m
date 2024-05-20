Return-Path: <linux-nfs+bounces-3293-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CF98CA1C8
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2024 20:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CB91F21356
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2024 18:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4893136986;
	Mon, 20 May 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nNNAIaQe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iF+IEdJv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825B34CDE;
	Mon, 20 May 2024 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716228346; cv=fail; b=VNWo09wN7aZk0mLaMXBl1ROZIEHWTc8bpGmllglhMzm7C1FYUT1Kdp6Z6ibd7Yeiii5LLtOjlXtZKXExV+PkHZEYNgWKpcnCzbv6k1tHYimUR92syH9xX+J83U3i+n9GbotZT2Mo2+bu2ihoBJ0c1MEo3opfsyeH8/S7/Ny7i0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716228346; c=relaxed/simple;
	bh=0FmZoxj68YWXUx5KbNyrhWNljOqO2hXEHdJtSkcmht4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Oc5je9OodD4W0cU/3ehYIfrVJTgvwFq7IduEeb9iUg8vYPMJr1Mbh0GdmQi0Gm3+/lYIRU1JHuPGkciqVw1r79RrbpuHyZPznjMHuueVuIEfVsrRmvLtgmRNQhrlKPNFuaC5aGNuVR4wshCcqZer7X/xVYAubwruaFpoESWODJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nNNAIaQe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iF+IEdJv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KFYXom023641;
	Mon, 20 May 2024 18:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kXEmHDa6MC8yPZmbtxCI3BnAYAug//sapb3KsBTMDjM=;
 b=nNNAIaQesq+ZPLP2pMwRLHHD7nhszqi0jt60b5SAQCxmCB0dNnO39NxjV/z8PoTwtlos
 fnOg7apdIg7Ti/yM59W0nP6FhrH51DSkQWNpnd3RhkyC3iUkysBdeTPBngv5PM3eT8tj
 8gNgvvvg2lxqQPLIq4kjJr2HclUg0XDjjqeHIxcc8jXQbUhUyr7sVQo+PrGHMbGgmn8w
 xzQ6+X9IFtWOTe6EN51RAFaPAR9AmOOJUowYMcG1QdJjav9I3u8pTlh8URHkWRjlYWML
 jLZhI6kMwXzd6lttqJr+XnZ7gZXr0buNGhyJQcUrBEXxgtrkcxzqtqp7nJWopPI4Zl09 yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k8d39w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 18:05:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KGrBxW035978;
	Mon, 20 May 2024 18:05:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js6mcb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 18:05:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9w2/CzWTnpPMFL5TFSTdH6FEPMpORJIYut7xegIiLWQDyAeOs7hiRqWSJHkE+KurpSjmW6oSfbjm+6kZNCVtWsazG4pJv4/8JczjOiuEvSxwVv4Xm7AxNiMvTpq4D6jlW6EcT2H3Hco/lnFxg629T1gb/ypUbI8UI+sqwVtkyg1aH3jkXJwcTYXm/YwXcNatFO1AHgYeUpLLfAuIc7fT4QBjcNj5AbllYG0U1uzw+wr6GzDwdJ9zRKF4k0mI6X9Bva4ikJAmu+qXBiIrbzxQFmQ+8Sw4w+nLjadkcw1PXO+s60RQy3Weief++13/tjXdPsyFAxNZWueS3krDWZ2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXEmHDa6MC8yPZmbtxCI3BnAYAug//sapb3KsBTMDjM=;
 b=CCh5RLvdV9CPtV1Gzw2hjiWpOvWDPhDtKXr0fxe7pry40WQdkcZEuhO21nqoXZNcVVonJMpBOaLQwY+GyXg5StqGqYs3TDEj0K+y/o047OmxGzvMqGgTro/zNbd1yIoky42lBZKl5gbF1kb5bcyrmmqOlRBSg7lGAUQLvlxGMeJW0KCs3VwmnDx1vyFmkIzFoN2vH1FFuyY+G5tb+T85lVSy81hFYwZKJh8qR0nRrY2tlBMUD11q5cvSi15ekuDqmLo+cHH8TBjxeHXRgejmBxDKtnOuT6emqfAFXphYITgPD3gNaVE2470P3Hx2Ta12u8AoDv30+KSi+FrMpxMXuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXEmHDa6MC8yPZmbtxCI3BnAYAug//sapb3KsBTMDjM=;
 b=iF+IEdJvXAuzUGPPW4yuzGDtteS01Zw7AP549GGlLaH2Yyo2USrlAjasTsjTIyzCTswruSKyuJjwO3+LwhXGRqn0P5Ruy6Io1d7ksZsANDqtuy7HNIq8nmMooZInfouMd1yIXjZomqZ1PbjipnR9bAN1Kypdq3P2ZupWc85qpo4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6277.namprd10.prod.outlook.com (2603:10b6:8:b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 20 May
 2024 18:05:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7587.035; Mon, 20 May 2024
 18:05:38 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Safe to delete rpcrdma.ko loading start-up code
Thread-Topic: Safe to delete rpcrdma.ko loading start-up code
Thread-Index: AQHaquBRtveEMYGBXEqnSgKIFUPuLw==
Date: Mon, 20 May 2024 18:05:38 +0000
Message-ID: <DE53C92C-D16E-4FA7-9C0B-F83F03B1896F@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6277:EE_
x-ms-office365-filtering-correlation-id: fdc3ebd7-e8ae-4b75-330c-08dc78f7745e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?+uEOOMMKYwNPWYGZsgGrATF39eoBVx/1EOLB/eItlR56ua0l9puGsldg/+L3?=
 =?us-ascii?Q?btx0Jvb9lYLN3sE541azlNwZQpJ9HMjK/7MO4bQl50Q16dNh2EVw1luVtxRb?=
 =?us-ascii?Q?bUquylKg/F/tZKs85d8TxTDbSt4/SxaR01cCB2+3EKZDfhUQXf8J9GsUeFMA?=
 =?us-ascii?Q?YnyILbmHFFRh6rr2HzMtY4dzwR4WhsmVltEVZTl/Xp57YruHic+yA5M0AWJw?=
 =?us-ascii?Q?pHDtXOaK85JDI6Myx12OibqlH2oobYs6DHJr6TrhQl6pbmLFInxtVr3knfw8?=
 =?us-ascii?Q?tNtLAzAAOCp6ZxCqEEoHTX3QIK13VXFj62V74SEH11boj8a3l82aWQGr8602?=
 =?us-ascii?Q?SiqaH4M0fu/b2NN2qcp1oFd6ogpaWiXwghtux4Jg2oYYzNEky9okASdtSN5X?=
 =?us-ascii?Q?bHJLXh1GTENzQkybqMX93AByGDVrgyZ97COxwKeHKl0WQofHram/ohtxl1Cs?=
 =?us-ascii?Q?CfLyjAKinnCOE4PcRXc8nYXmFvjjQmkWpYtQ/ZAF9uiCdO519+F9iPlsclHY?=
 =?us-ascii?Q?+wK8sD2MPNafGzIdPVQ0Fe76frjGH9liVb3zHdRCAcHPWpOatQHJ3l9Whdsh?=
 =?us-ascii?Q?b7/5YovLHHNXGgzKjO2IwN++VeSR9N1pOMBoQLRxUjR167kTnwfDlfY/3rN9?=
 =?us-ascii?Q?3yClNZI2x664sIVeryQAi35TYz6Fk12cToBFFxki/ChsAmYxowUNcn8wzdJ/?=
 =?us-ascii?Q?WHPmWN7vuaGmbYcitygDST3tZ+Yby3MyyICPZqxvIjSnbRkSTyZJiQnBozjY?=
 =?us-ascii?Q?E3RZHYOcUFk8vRw5JLTDF+2+16k0yA6A7+gCgksr0fpVyiM25zhoApBMpykc?=
 =?us-ascii?Q?IRfO+8jWPGy6Qo0NtYkNCjzlEo/SYiRaNlgb/ztgbh/DjnHgeYEAh4jsh3Dh?=
 =?us-ascii?Q?H6T+6+mAG39Yxs+QhMWyBaq22RQLHfxhfj/VwGP1T+QrR0sbzNOd5XGBsqYC?=
 =?us-ascii?Q?ZxjRoMbv1mgWsALfbRsjClRxvAzjsMqkimtv6/7N97/sqmOd7lxQEYfx7SpS?=
 =?us-ascii?Q?7oXpTCagHh0KBDscxIgwQAF2+mFgQ/5DYHaiEH2dcXaOgqvf1RqoXru9FUg6?=
 =?us-ascii?Q?kW8p7Si+aVx4ErjdD7XwAbc1g3nSJ65iKbWu8gPSVqvlhYkPOpjppSudClGB?=
 =?us-ascii?Q?8nANF0unmKtcTUAXDAOBT5enrj4VKk1RFyA6mXMno/+gX/FTHNXQRQc2B/bn?=
 =?us-ascii?Q?YldXNB7qasBJmNeBmxQAuI0hYCKLRWkDEcGwFAU1eKzxcTEDKdSn9utCtjoK?=
 =?us-ascii?Q?lRAC8XE42raLZYAmeaVxwiS5BQnJx1fJ4clavZiiyEFK1oMRTR5nSHd/Igv0?=
 =?us-ascii?Q?U9lYVMr+Ujzl2arZJfdEl5s6cDbQm5aQ8/PUNUCOkh3oiw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?HulLDyK5RKvvt8aoqCdt5d5kiq0AcaWKKoljSargxG62HmOnEBEC5OGDeUR0?=
 =?us-ascii?Q?Q47X9ugs9YANnlAAaWyviA4hXgQtIuDVpAkY4n+EqSeMMJI5y9fDToK8fxG7?=
 =?us-ascii?Q?PsCbLzSQZJOQSbA39UA1h7EXmF9XfJuxmVx+VuJ7N7H141LKkr0/grSskogg?=
 =?us-ascii?Q?Y+JtzHM2kVoIPsrWo2sn85s8W8qN7x3HJ+HHYnp5kBqd8EowEcgIZvSTkUtK?=
 =?us-ascii?Q?2OFM1qGmNXZOz7TNPtL8RQlqbQ6vKrsLhpc7mU/AraMGnSlqkf+Gthg8BeNs?=
 =?us-ascii?Q?f8kuiy2tSyXt3b709TZmIfMHHQO2TsMx5POB6HNvbfWgXJ2QYFGS0FWG+pkK?=
 =?us-ascii?Q?kIsHkmcA9wRuY04AUn9uqUHaD3Zea4l8fpfeQME6Hbiuz1AIvvp8fAe02qv/?=
 =?us-ascii?Q?COsydD5KSLvh8NV2gMQQiSlT+OCHcfQcL6GH0hboZ2EQPvUegkkNUgHo66dc?=
 =?us-ascii?Q?Kl26Cn2qk4Qr9fp2W7fFZNAFJrSD1+oRX0r8wbRl90fQdtXb7W63aXDq4/fb?=
 =?us-ascii?Q?ZoWVLOwbd3NNEMW4GQha+zHAwkc+OUsc8xf3H6DIYyH8sxrS3HqsxTpWNLOf?=
 =?us-ascii?Q?0LqzDHE/OgkG9e86i0iiQDSuLVdizjzWGIy1RhTc9XfdpIR7Kobj2AHrQ87g?=
 =?us-ascii?Q?tR9LTOopUPQnMVklEac701AHbePZeD+PE259YdAs60Gn9AqsiUn5BfOYr7JI?=
 =?us-ascii?Q?MxJTY4feribZR1VjAs8jthM5Rl8FFq1sOWWw5rNfYzukpt34iqLCxHEsKyXm?=
 =?us-ascii?Q?YWExe3dwLjMxTWnmHx/O9GnksZugNN7S6lxzkJITIoGffFBPhfkiiXvkbdzl?=
 =?us-ascii?Q?aIMFoMjkijWvqVdF+63NPB7Ug8F4RRd2Sg5KILOqHUYyXxNz33pZ9UpY13Ge?=
 =?us-ascii?Q?DHstBQG2nngeMcL1AtbfrOuKprN4QYV9zu/bboUybzbwi0Ah74N9Hq+e+D1X?=
 =?us-ascii?Q?PEjKBoKINNfr3XHxky6hnvXNuKdImYau6EkDciMpLZdWt3/hrmw6QHk5fkOP?=
 =?us-ascii?Q?2n4cSwvqh/KucwONZtrxp47y+Jy1H/FAWMCO1tT04D6jThiWcTAErUf2HAjB?=
 =?us-ascii?Q?qu+mwF/rrWW2Pyo2upXKjjN0awxOM3IWa/bMQKJtNO+3LJud5QrVIK78a9Jn?=
 =?us-ascii?Q?mH9WpH6baV0s13ewoq9eGc2FK3U2ULtHtpAaf6WBso0Bkv4RVXqyWg8y+j/7?=
 =?us-ascii?Q?E9nYKs1dl07cX7Jyx+wKkaOKCIkTXGD3tmK1V9Li1PTX2rLBUgihE9+jCxCo?=
 =?us-ascii?Q?mY1z52dA2s9JD2ubYV8WfDV2gX9pZSkl96dw8JphboXgC95gwJXkG/9rg6Bp?=
 =?us-ascii?Q?dp/GtfudGYaYIU6QUz5koFLYmOlfQsouas64ZmoUJZpX0ZcWDLq0GWfYKp4x?=
 =?us-ascii?Q?uNef9Qr/rLaJr3dA9WikR8qRyjGfEgm3oMm1aJn89VvmF2z3WVGq2FL5SPUk?=
 =?us-ascii?Q?VHcMzLS4973aPt/CmkUtg3TVYiuT4U3gk5JRJjsN/qeh65nCnRjh2Q5VuDlQ?=
 =?us-ascii?Q?lUWMTg/g202SgQ66yz/UwzO/GHrICVgOqBymFdkGzSUlqfjgDLBCQmG0z/tt?=
 =?us-ascii?Q?pK+UMl5OdEb9HHe8LRctKJ3hN8bPRD39X3IBueuiQFxcGykTn6zR06UbrXD0?=
 =?us-ascii?Q?ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <97C3BC164999784C9ECEFF788FEB0744@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gRjDWrmHJuZfOAgqgSinSmYtX6Wds5+JWId0sRJvObpCM2pz0q+J1fe70FLdCvi9zSvtzF2hBlJVCaTq5ERSlbMm7AspEx3BZ9qVN/AumTLcjyvjZ+TQy7CDeX0ypWyBsl0PmYlDhV2jkXNH6ZjKyJnhaDY/vjL7OqoQbtdnh+NgUrpyDwbnHlZGwNYZEWWHLPsQauBMPaVBqZhSqU1cy14o7qCG0j6X3eC0kaqvl461qbr2UNR+Q4msU7E1n5hCm8Ol7s0roBanU1aUuzyjahykHcwSPpXmmq4Ktj2qicVjsaT4x7pj2BFA/LLt+IqZei1zM/avpLz1h2K/Hix/G6jIWVoGtpTlZHLb3ttNMz7wMXwx/ukBNEEoGTJR7tPKBgu16/FE2WAxf0nmKHexdHNw5tRgp3XkVrxHDpOcwTjFAKdJxaOVvxhrTCKtJrDsyTvUametV63f6B6ImaYmoMj64JyMfYdzog8UjeKzpQ4ilF/YYuiTj6/SDSKhmqFdKrrEl3yPyHBT7BgWZHefHKJxPDvJIYGit91g6wJTy2N3dhrxz8Fmrkx8TENjmFZ9/w12D/lIycYHilbBzvd2/CfM8rQu1C+AIcIqrFZaMNM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc3ebd7-e8ae-4b75-330c-08dc78f7745e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 18:05:38.4192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LN9TOE/rtJlButiF7/6r5OQldbksVvC29icLx83suhVnrSaYbVIlfgxj0CacG7KllDxIEoOoAlgS+UGgt3wAdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_09,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=943 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405200144
X-Proofpoint-GUID: JsDcOSVz-d0UlSSOsGt1CgWn8Ciw1i5z
X-Proofpoint-ORIG-GUID: JsDcOSVz-d0UlSSOsGt1CgWn8Ciw1i5z

Hi-

I've tested this with two kinds of systems:

1. A system with no physical RDMA devices and no start-up
   scripts to load these modules

2. A system with physical RDMA devices and with the start-up
   scripts that load xprtrdma/svcrdma

In both cases, after doing an "rmmod rpcrdma", I can mount
a "proto=3Drdma" mount or start the NFS server, and the module
gets reloaded automatically.

I therefore believe it is safe to delete the code in the
rdma-core start-up scripts that manually load RPC-related
RDMA support. Either the sunrpc.ko module does this, or NFS
user space handles it. There's no need for the rdma-core
scripting.


--
Chuck Lever



