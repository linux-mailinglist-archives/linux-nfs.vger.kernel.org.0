Return-Path: <linux-nfs+bounces-2028-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF31385A511
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Feb 2024 14:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFF01F21CF3
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Feb 2024 13:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9D9364A9;
	Mon, 19 Feb 2024 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gGD1ZZkq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WqV9TNMs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2418364A0
	for <linux-nfs@vger.kernel.org>; Mon, 19 Feb 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350411; cv=fail; b=lDetp6+isu2JofGsNrxAKTrM+BSYvTZ/TW1rWfQus4ysesiEWR4K1esyqH8sUeCQgRqRThp0yaGtPTB4iYHH11HDXzxn4I478o70WWiDBhj5VbBs0iN9XkCyeSDd3NXPgERwTOUG27mtC/YLgm9VEZqWwJJD78jR/+glzo9AUPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350411; c=relaxed/simple;
	bh=FmDIOGI2kKFNg9Ph8FVaAQXN+leaV/VEPSpw279/1i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wg5whKZLWS/MPZXVC4SpHWQf6gdO6jXqKnArvOU1qUYDSJi4zIFQWA+bc12w0xh5Mq+qtwm5SesOtYau6WBQgQbJzyxC81YyZBfBoVlFy4uVwYbxgPLWS5ZIWMq4yzVFLUV+h/EaL8m++r2T193wrdi6diQmOnB1OVTiuKNbPAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gGD1ZZkq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WqV9TNMs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41J8OEbN010957;
	Mon, 19 Feb 2024 13:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=0MjpXRqehYaODvcTT2d7P672Nwjh1QpdhWkH8jf9jAQ=;
 b=gGD1ZZkqPeIvz+pWNRpvDQTrhTJt/Lm/N+6cEWYUqcdPSj44T8mUuz/oPvY4nzdx1fIx
 B0H5albXe3AtIdAwNsRxG3km42Cp/XNI9/g7fJ3QTXVSZRCXUnVoLOqMY1nVVnjdfqJg
 uwC014yuOLocqlMfiybyRq1m9zhLKBcIboAfzuhkPqbmfGSwBN7dILN4QPL26LGTrGnF
 E90Q3sDU5TPkXMHnEVcqqbQq0sDXi1sLx0BoTRQDAc50m1GJgfgmG4agYYvxUiqALNwL
 10R0Gh06zmUduggZJN8idZebqwNzJhUOo1wVGtE5KHwN11QzeHU7sBqnpqzQsJJX9yzv jw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wak7ec7m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:46:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JCPBYP021107;
	Mon, 19 Feb 2024 13:46:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak862mu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:46:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIcudZozK5jGX/hEbzFZIAflvB8mZNnty1fXI7wph6R88HZz1iQNeuYxXtkHlkj6VxHKDtQqtm7Vlo1phw0MMqCXTL3TFvf2t/3lEgnBzkeA/U9vgutHQ4uYhR3HTPDsHEzOh5eBG7pbN+R24IsQusXwaqXGvd2MktT0icL1AYagr+A7JxeL6OqFPrmm23peKiw2DQbQazEYPyxspBIIbE0cHNsEwYktqAtnA52VZXag4mzcPmivgTLNRfQa+vyLcpuuiKMecNhuEB+Y95y13pGjJYsBULgYvhtmyCcMIR2huDOFlDj4NU1EPu1itpui27fGup3BeZB3TLYx7b0pKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MjpXRqehYaODvcTT2d7P672Nwjh1QpdhWkH8jf9jAQ=;
 b=l7x4Ro6MFLHcTdgXhVaklMY1OkBdjEqn6SyKq9zNgErQIBxmplF7Z5hro8OTRUdmD9WvEMYG3Stwtq9IFuzs5IS1XyXoO1cHwhEW9TYc63tuntdwePHniwheNISa5ew+qgkahm0NXa2ogZXun94eSLYt4NnRFqFFtmQddQacDJNMJBXDomNDX07o5QeVpoeLKjDXrmOvWHaHHkbvuhas4xCMXI5yUX+ONVnwdiHzaCBZMSz+ZsxSp0seFRdoXbaAsJunc5+Yp8s8XLEzVpEZsg+9ulI4OWoMTPZ8Hyz2+amyAVyBhCqW6w2VrRo9P2BFnnGX9x194SakTGL5Y1+Z0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MjpXRqehYaODvcTT2d7P672Nwjh1QpdhWkH8jf9jAQ=;
 b=WqV9TNMsZtgarBQXVAFJYXEABoHK0Q26JNtDPlZgBDI2aqz9bc6JXTCbtZuMmGw/wJ/8tBY9bYnn5pgUJN6z2moxrbYQnLPuuTu32rkSLMLi3WV6JhsfOuC724lC0kZ/apCWjHxlxFwwpfDiiPFQAvbFhZZF7J9DBUz6C3gbfMI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7629.namprd10.prod.outlook.com (2603:10b6:610:167::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 13:46:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 13:46:44 +0000
Date: Mon, 19 Feb 2024 08:46:35 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Roland Mainz <roland.mainz@nrubsig.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: "nfsd: inode locked twice during operation." errors ...
Message-ID: <ZdNbu_xEk0-49mnu@manet.1015granger.net>
References: <CAKAoaQkeevOpxQPjH+KZt3fyYweLsrY-bhHsqvOpdVXuGYwqXA@mail.gmail.com>
 <ZdI0I8YV2Vir8f7g@manet.1015granger.net>
 <CAKAoaQ=CaBGSnoTK9GteCj=CWjMxiGcEhozCOuqu7-ygBeAHYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKAoaQ=CaBGSnoTK9GteCj=CWjMxiGcEhozCOuqu7-ygBeAHYQ@mail.gmail.com>
X-ClientProxiedBy: CH5P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 1492d1ed-1a14-46d0-7f16-08dc31513576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	b6LInxxFZPR1BW3uKSqf0M7EC1HhlAFROyOu07HV0U+y9hDl9vO3E5EpsUkpHDCVqgK0NmQtFUg9wDajovfw8oHhHEWd9V1oM6bTpCxHvGAHZzR75O3qbu3OneQak+Pxv9hDfOOZcPc32yU99pJB5C51Rdm7QDL4b03icgNFcY25kI3YsicOAWX0qiiXUrGZD0px9Lst57IW6n35b6Pu7RH2YicBFGMGdXP2RGu25cRHbvQLymPJBLCBPwbqF+FC6s/m6Ne1ObQP1vjAMRltsdZvIaXDavgNIgxPtNdFGoKMpCVOFkVmZoEqa/P+9g7hCL7Ur2Vg8gPtMCPBohlFYUu3OoYUm1llb0HElW5Cq0Wr1yhJt3IAUV2xdrcZWHNFgN32UJQyypVldDJgYHpykJzHFYUNBSDNr1foGQzRZAkdo0IQJEIawQP22piR+rSL4LH+6QspCf0ABIqJZZdk1qIt7BHLn4d0vRG4u+mcl6E58pMB5tddwfJoJpzgdYJ11QWEBrJAgF+3B3OiwVE2Fgap5zzJOMfl/xq24TJ4NeShBHRbmxtQjx+W2vMDMS+D
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZVZiak03eFp0L1BCOHV1eFpyd21PZ0NhSVRidnE5azIrUWJsdjFJSG5xZnds?=
 =?utf-8?B?c3ozazRLZERpbUdMMTVJd0hObjdpVm8zTWxpYXlhdWIycTAyRUM1ZU9UdFpH?=
 =?utf-8?B?S092THFwOVByZS9lQzdESUEzM0hIQ0FIZVVrckx6bFhwQmEwSWhRS1BGM0Vm?=
 =?utf-8?B?dGUrcHNDaFdQT1FwaVRaaEFkM2xHc2hIUUsxUnhVTTU1T0RSZEdDV0t3OExJ?=
 =?utf-8?B?bTZ5ZHpybHhpYTJsS3gzRW1KMURMV1RyK1JWaWs4a0tTQW4rQjc1YmVXQ2Ir?=
 =?utf-8?B?a2NUWnFSZWdISkZqajd3b1hBbjdGOE0waE1OaUovRnJGMmNpZmhoRmxBTFVL?=
 =?utf-8?B?QkNpMkdrZ2sxNGlqcVJhNkNtRW9rQXFrTEMwZ2c1RGpZR2ZxTzc2WDlta3Z6?=
 =?utf-8?B?QWgyb254ZVJFVTcrakg3VkxQQlpVT3BneTV3QktGTXQzM2djVWFNL1lJdUJn?=
 =?utf-8?B?aTE2cy95MVpaaDBzRUtqYmNIWGpnb3JJMXRPWUhvV1FmeFRwdUVFMWFneUlq?=
 =?utf-8?B?TDlmYncySjkvN0JncThtNWRwRHNlT3A2RTh3QWRDZUpnRDh1bmpjeTBUYzk5?=
 =?utf-8?B?MjN3N0RyNHRMeldUT3V3NlE0YmV5aktiNEZlWWNyZ0I2WTIrQmpnc2U1L2g0?=
 =?utf-8?B?OTZZc0ppRVZsMWhFS1hoNVVYL3JmaS94UVIrRFZiUzA1ZVVMOTQ5VCtLNDRD?=
 =?utf-8?B?cEMzc3M1M2JJYWhVaXNXMHdRVC9UM2N6Z0NIaDBUYlNLNUt2Q09YZ21FRTJk?=
 =?utf-8?B?TGR1Tit2dmpXTVkycXlhaDdRa2RGZ21uYVA5K1J2d2lsMHlhTnAxMHIwTlVy?=
 =?utf-8?B?WFc5QUp5L0hvN3B1TTVsVTN6TlJsS0VsK2RlY3ZYM2VPNTN2Zm5sYWt0REJ6?=
 =?utf-8?B?RWxmd1hQNEFSV1RKM1FNUUdZNk1nakZaa2VnVWFxN2dBOUwwOEtXTTdkNm1O?=
 =?utf-8?B?Y1l2NHptakpUUGNSNzRpZ1lQWFl4UnNRNnMyYmtVYVlSSnpXMC8ydXNCUU9u?=
 =?utf-8?B?bVZCRnZwU3JuZkh6UU8zTE44bkIzZVcxU1FKS3FYNHZYK25EdVk0eUQxa3dQ?=
 =?utf-8?B?SDBzbkJBb0pnUkUrNmhHbUFFbnlrNVNldmJ2T0h6dXNhR3Zrb3FQaGlkZnF3?=
 =?utf-8?B?c3R4OWxZZlh4dWJ5SVh6ZzNoeHRoemh6aHZmeG8xUTVYbUluT1BGQ05Xa1k2?=
 =?utf-8?B?ZDdNOEh5clFPN0tCbE9qbmdxUmkxcW84WWlPM3lJV3lYS2FVTjNTUnFHWVdT?=
 =?utf-8?B?SUp5WHNDcVk1MGFzS1BrOFlpOWxpc25kT1ZZcXM3L1RhM3FQTlc0eDRCN0hw?=
 =?utf-8?B?V1Q4WC9ZOWJHcjQ2S0l6R1B4bmw4cVJyOElHOUxEOXFEcFNFSjc1eXEyN1ZS?=
 =?utf-8?B?VVQ5NW8yMFA1WHJiN2FnTXphNGJrSXcrRWxjQ0RmTzJSS3BqTTBwR1JKK1NZ?=
 =?utf-8?B?b1g2UGVtcmNDckoxc3NMNzdyemppcG0vaERRT2E3Zll0SytON3BGK0F3S1Av?=
 =?utf-8?B?Rk5MYW1zWFZsKzh4WWZMOEpPbzE5Z2FlV2lXQjllYXlpdFN5cXBNQzJCUGw5?=
 =?utf-8?B?L3VNMkU3a1htbmNvMnlUUjdqUitUWUhjTlR5MHJ6RkJQODZEZnNDVk1XaE1a?=
 =?utf-8?B?b0NpSlIzL2J1cndhZU1CRUVycW9VcDN6V21ZMWxFNkMvbFEvT1p4ZmExOE1J?=
 =?utf-8?B?SUgyVG96QU9LWGFiRllPNHpYZklVVnByWjJtZHExWUJuVlpGTWpLTUlTVHdv?=
 =?utf-8?B?NDdWUnlOR2NEVGQ5TVhTOGlVeERhRHh5bExEWGhRYkQvcktPQUpxd3BLNGJI?=
 =?utf-8?B?c2VqcDh6dS9PSzZ3QklpNENyUGFubkg0b1EwQ0Z1eExhWGRZWm9hb3VLQ2dF?=
 =?utf-8?B?RWpJT2FHemN1SXFWZ0VDVXpjanRIY3NBb0JEaW96UHdlVkxYM0VQUjZqd2Qy?=
 =?utf-8?B?TThyclIyWElRRWR4SGNFZ1p1WXd4QXhCNjJTOTZ3czA5YWxVa0dRVEg0UmQz?=
 =?utf-8?B?U25VWmlCWDdzU1BlMlhKMk51NUZVOFdEVExiMVhkNCthUmtJWUh5WDI0NENC?=
 =?utf-8?B?T0RyWXIxYU1hYStkTG91eHlnS3RVOHVUd0I2VFJWbUtUdFRLS21peDlxZldW?=
 =?utf-8?B?TzI5akxDY1F6V3oyS2hNMnI0R2dhMlBhbmNoYmxTNnlYTlJiNnRkR3FLa2lN?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qNXrD1VxTVr5232qeFbDqHW19SEtvGbVnM6YDvutbFB2GNIU9N7GHhvq+RpUNVtzYpp77MNPivsh2Kj/QRJpZ+LjFizk0bBaa1pcuKdVmgLWOeUrKQjjVfPfS45Kvh8H2PCBVTz629gV9ljcxMjRkl5R0sZa88AnP18Hcpyc1af9c0xu+Jrc72L/55kjaO7vWV+GV5ZOSoj84Q2vtLEjvb7eZDbuRFUjJI543vJ5T2M6krUYTc/BL7sukOCqaHo0JRkm3rtkbyxfdqtc9RiYYLWQYEIYUsluMB7iOQR+fSXbDOcgmfECBqdMjhE4aA30jknPpxuWEW1zYTD5LQBEaVqGFQ/k6Wdw7GapxGWRmsKMpE47N1IkA+A2SEzTbxr6CvLjYD/4LJX89Cw7GgkwUhcO6cyoYWE8fLUvpr/wn6aQdT7yilWDFrUNg0iNLljm1kiWDs35mBtpj9ygChpd/WOi+i2AbwW/XUWTi0YkOLy+ZuzTwIMq4aSOo+l61Em1ReJWak2WiikrtU5P5DuBUxk8Br0SdevEyu+k4DR9VGFbklXsKcsmfUeOevVqGDwAGxFBtGWHtw4ZFbcla+AdBYmI1QeUeOO1bNgqsB3ES9c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1492d1ed-1a14-46d0-7f16-08dc31513576
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 13:46:43.9958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAbwoIAdibnUn83wNP7TXzMQJDkp2IPEo5nt2RCi5vfPCdeAG3MnZrH+KYvLgLGIk6OAJm9DXB9WUReAIaBU6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402190102
X-Proofpoint-GUID: iSVbjaYmxR5JbZDQCAEH5SFJ9iOnwotp
X-Proofpoint-ORIG-GUID: iSVbjaYmxR5JbZDQCAEH5SFJ9iOnwotp

On Mon, Feb 19, 2024 at 04:02:15AM +0100, Roland Mainz wrote:
> On Sun, Feb 18, 2024 at 5:45 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> > On Sun, Feb 18, 2024 at 01:00:33PM +0100, Roland Mainz wrote:
> > > I'm getting the following errors from nfsd in the kernel log on a regular basis:
> > > ---- snip ----
> > > [349278.877256] nfsd: inode locked twice during operation.
> > > [349279.599457] nfsd: inode locked twice during operation.
> > > [349280.302697] nfsd: inode locked twice during operation.
> > > [349280.803115] nfsd: inode locked twice during operation.
> > > ---- snip ----
> > >
> > > nfsd runs on "Linux 5.10.0-22-rt-686-pae #1 SMP PREEMPT_RT Debian
> > > 5.10.178-3 (2023-04-22) i686 GNU/Linux", exported filesystem is btrfs
> > > on a SSD.
> > > NFSv4.1 client is the Windows ms-nfs41-client (git
> > > #e67a792c4249600164852cfc470ac0acdb9f043b) compiling gcc under Cygwin
> > > 3.5.0.
> > >
> > > Is the nfsd issue known, and if "yes" is there a patch ?
> >
> > I believe that warning message vanishes as a side-effect of this
> > series of commits:
> >
> > 7fe2a71dda34 NFSD: introduce struct nfsd_attrs
> > 93adc1e391a7 NFSD: set attributes when creating symlinks
> > d6a97d3f589a NFSD: add security label to struct nfsd_attrs
> > c0cbe70742f4 NFSD: add posix ACLs to struct nfsd_attrs
> > 927bfc5600cd NFSD: change nfsd_create()/nfsd_symlink() to unlock directory before returning.
> > b677c0c63a13 NFSD: always drop directory lock in nfsd_unlink()
> > e18bcb33bc5b NFSD: only call fh_unlock() once in nfsd_link()
> > 19d008b46941 NFSD: reduce locking in nfsd_lookup()
> > debf16f0c671 NFSD: use explicit lock/unlock for directory ops
> > bb4d53d66e4b NFSD: use (un)lock_inode instead of fh_(un)lock for file operations
> > dd8dd403d7b2 NFSD: discard fh_locked flag and fh_lock/fh_unlock
> >
> > plus this fix:
> >
> > 00801cd92d91 NFSD: fix regression with setting ACLs.
> 
> Ouch... ;-(
> ... so the patch at the bottom of
> https://patchwork.kernel.org/project/linux-nfs/patch/533299E9.6010806@gmail.com/#8291331
> is not sufficient, right ?

That one made it into upstream as:

commit 2336745e87a646a3dc9570f082b85df519ee523e
Author:     Kinglong Mee <kinglongmee@gmail.com>
AuthorDate: Sat Mar 29 10:23:47 2014 +0800
Commit:     J. Bruce Fields <bfields@fieldses.org>
CommitDate: Sun Mar 30 10:47:34 2014 -0400

    NFSD: Clear wcc data between compound ops
    
    Testing NFS4.0 by pynfs, I got some messeages as,
    "nfsd: inode locked twice during operation."
    
    When one compound RPC contains two or more ops that locks
    the filehandle,the second op will cause the message.
    
    As two SETATTR ops, after the first SETATTR, nfsd will not call
    fh_put() to release current filehandle, it means filehandle have
    unlocked with fh_post_saved = 1.
    The second SETATTR find fh_post_saved = 1, and printk the message.
    
    v2: introduce helper fh_clear_wcc().
    
    Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

So every Linux kernel after v3.15 has it already.


> > Any upstream Linux kernel after v6.0 should operate without that
> > warning. I don't see those commits in origin/linux-5.10.y.
> 
> Are the kernels in the Linux 6.6-stable branch "safe" as NFSv4.x for
> NFSv4.1 client development ?

Generally speaking, later releases are better. If you notice a
specific issue, I can respond to that.


-- 
Chuck Lever

