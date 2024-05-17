Return-Path: <linux-nfs+bounces-3274-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A908C893A
	for <lists+linux-nfs@lfdr.de>; Fri, 17 May 2024 17:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA8E1B20AB4
	for <lists+linux-nfs@lfdr.de>; Fri, 17 May 2024 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF47412CDAA;
	Fri, 17 May 2024 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cjkQ3+jj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="liSZ+FfP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D338312C7E1;
	Fri, 17 May 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959273; cv=fail; b=LYXes9O9SMalBKRCyGegOxKDyxzlflbYiMouVbQwdSGuG08+saDEEbC3eXUWuiNglSMjdcxNylqdCzJsx1ty/qXSbC7XsZhxzWoB233v0vVexOTPvdEE7FzOhajQwKll1Gk8bvkUvs+qbGXFuVli4oi1hk4Xf+9mt7jkuTIOuo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959273; c=relaxed/simple;
	bh=ii0aUwTAzxYJ3MhF43Q9FQc50Rr8jyKmS5NANIxrQSU=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ArHyfu/WDynPjBKaE2jmiHOXUPrtCyEk6eCiH/dSNWzTkpbk7r26f5e4wfGAY+c9+bR074Q1lRcvGYch6g2o4kVBK5qS1eXNaF4r5/DUv1F5FJtaqrNQCuyNAjvSN3QpnhaImQozUjf7qUxbjzLcyhYj6twJUKXxSteK4shrlUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cjkQ3+jj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=liSZ+FfP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44HFAALo018246;
	Fri, 17 May 2024 15:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=iD1tSVSARwpWbCViWx01utX068PvNMDRE+WddwVFdW0=;
 b=cjkQ3+jjVIsMObbnwG/yWilWzzUwymY15LeuHw7rQiNcMXFzuxX9fTR9t5KWwP3Bpo6y
 9D5C4CEHL/4UXhqu5hs4K8FOX/P/0uiMg0ffsSuB+lZDJtY2+krXl4rS6A7I4WwPl6Fn
 q993qlQRJz9HLQaDOsT1bmZ13IBTOdYRV5Ppq0vkGZIRVwng1gq2TuDbiLlADQLgVN6K
 0e580LelUmg+LLqT8ifARkCdR/dJYIqQ9Ql4lpJPkW2FBb6LNjf63iQDlgbS3LHV2yUA
 eBpnD3Q+bEWFqZVE9M+Iog9mat9DFY9WhkulD6WpW8hdcfcxQp9+Eq1WobliRD4xnVAc Bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3rh7j5ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 15:21:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44HFKhou018807;
	Fri, 17 May 2024 15:21:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4c59ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 15:21:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmaoNZD1DfuTpZPjNId/5ijXtod/uu4df/5S+99Nmaz0oju79CCzFamiRkT5aWkpKCHEwx0kP4GDYAON+jdclqY7i8gc4cG1c4fCvASnPYHvK2fq2PZ+iv7E8i8HQzEPqelYQQUGfx+o/3xE0S3kWDw+Ou4JMffFuTSug+VYaKtHIEJb/DKz2CewiSvVgkQ0gam2FWRSyg9SPRNlpIZOFbzwB5sLt6hjqQYB+xGUE5xc3fhrzGkxnN3fj9hTzOlUyjt5XEpjBCaKaovOsY6bjhJ8xs2ELFjANYJ6QOH7ICLvvYF5GakcbPspNxzKe84p07wjGAEB3xyDL/ts9ZBpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD1tSVSARwpWbCViWx01utX068PvNMDRE+WddwVFdW0=;
 b=Ocjlfr0PnJDu2i7Mfeq4vCHvgu+3NhXjvRdsVQ/lFbLIbdzkZc7MzxEes/KHMQT3144LJDOxPjw5yYOIjOWvXEKh+79bpoRjbouzxdpzjIz1KeYnLcGIXALTcwPSR3wjVI6z22kRWwjGZ90U7QRR3S8hDJpVRa6wXZarBr6iK3omS60O00Gg9yENVLossSG5UMRm3TosbHrn+GAJpUNjXOzhD0435EK3C+YD8jivB+p8hiRBqee9XQjqQSsxSycoAjtiq+6AeG3zYXiazKtURn6raxqliCqKsaW4CzZIQQBN9pBICSQhPW0cjztmwZWs+m/oRWCeX8X44ySLcJSzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD1tSVSARwpWbCViWx01utX068PvNMDRE+WddwVFdW0=;
 b=liSZ+FfPOCL4OUwZh8qQ7tChL0eM0teXZaoJVxm7Jsbq2BsBuSBd2KBC5v7+5JGFSpPI4Sa2gnNEUvT5pTxpuLSVA/vUDobodWUKFIasGHR10hDJHJ3d1Xv3EESw0I4et2lzjwkND1Uza3erH2d2q/34iINlKu3hbopnmaS/S9U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 15:21:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 15:21:03 +0000
Date: Fri, 17 May 2024 11:21:00 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] NFSD changes for v6.10
Message-ID: <Zkd13J6KgE/kdKSJ@tissot.1015granger.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:610:11a::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 139192dc-7f06-49be-5925-08dc7684f700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dlVoZ1ZrZ3ZaaFh6M1FqZXlOT1ZPNWR6ZUpFZ0kzSFA3MHU0NUE5WnRYUkkx?=
 =?utf-8?B?YzlkK29QN0ZkL1hLRnFQYVBqUEk0NHR4aXpMS3Jpd082MThiSE01UGpiYU9W?=
 =?utf-8?B?bWVGWmxJcE1tSWwxZEpFMGN5UGtDOE1FRGpqYVl4QzJOYTJrT3NtaGhPZEtQ?=
 =?utf-8?B?cEg0N2JzT09lc3M1OG1SbVZxaFVQL3NhZmpadUhRZlNreWZuZVlhdTFiS3pa?=
 =?utf-8?B?OXBwMGtEM3pQbythU1FGeDBGSmtoVnNLWWc1TDNvWTRrSmhDUStGWnhSY2Vn?=
 =?utf-8?B?UzZNayt0QzRwTjQzNkxicjV4Wk1Pbll3YXFXZytqUGJWNGZlbnJ0QUFCNGdl?=
 =?utf-8?B?UUZ0dk1walc5VmpZSkZpOVV1cm5PM3lkL3E0aWlkcU5OSzUvSE9Fa05xZWtX?=
 =?utf-8?B?VVMwWFp3VXl2R3JkTXJBUm9ZdEdCY1ZpMUNPTnFINUt6YUhpaWhxK3A4bXor?=
 =?utf-8?B?OGYxS0Ftd2pkaVREdTV6ZXNpT2NqMHJQUzNpa0YxdS9YRDN1dndLTUJvSFI1?=
 =?utf-8?B?WUxyVm1BU0gyZExqL28weVFXZGY3SjQ3QXFlVWdIYnZzRE41Zlc1QnNOOUh4?=
 =?utf-8?B?bFgyelpQUCs1UTZQeVM4ZEFpSHJPTGtuL3BPRStHYVhVYzlrd0Z2OUdZMXMr?=
 =?utf-8?B?bHlYaWRhWnhxbU10WmkwdC82b01EaGNIVWNkU1RmVXBwM1dORnNpUnZaVXYr?=
 =?utf-8?B?YWNLd1JXQTVHeCsyb3RHWUZrQzkzVmRJcVFUTitNdGNuODdwQjZISEI0WjNi?=
 =?utf-8?B?bTVSQVR6TjhodWFzNVJXMEtrUnByb1M4bGNkVFJsTDJoY2hBTEYwc1ZGT3Rv?=
 =?utf-8?B?VnVHNmNRc25hNUJvS3B2Z096ZE9WaWxpKzZtVEliMm1VRy84QVJXVm9TN3JI?=
 =?utf-8?B?WGpQbmtCQkQxbmc1QlA4S2xYbEZHT1ZWR01nSFI5Yy9OR2lIRlRSRzgwcTU2?=
 =?utf-8?B?QTZxbWxOME5hTlVqT1d6THBvdFlCOUNOYmF3Ry9VUWhMMXEvQ2paVHcvTW9X?=
 =?utf-8?B?L2RiNHpwdXE5bGhqcUVkVDRyVWZja3c4MHVTbHVrd1p1TFdITWhqUTZocG9x?=
 =?utf-8?B?R0QzbVI1ZWFvQitrZ1psQ3VZejlPSkV0RHhyMkFGSktBV3prNGRHTmZQcjVY?=
 =?utf-8?B?cjNIbngxblRkR0dmbnRQS3RhNGdBZXNqcUhqM0RZcXlNd3kvVmxVd2ZZNUE1?=
 =?utf-8?B?NW1TOVJUODVPYW1OWlJyQWtRNmtZNkVzZFo0cnNnWmZwOXAvNnRLUDhlOVhl?=
 =?utf-8?B?cTFpWlBta3FjUERiYm5LcnFGOFVCMEhQWmU3OTJ6UUJFZGhmaksybFIrTXhT?=
 =?utf-8?B?akdRenA4TCtCampOanhxU1dQMVh0K0FiZi9wWkQrdnZ4eWxRR1NWN2VySU9F?=
 =?utf-8?B?RzliaUpqbVB4Y2ZWWE9maEwyeFJzMU9iQ2VZcUhwTXFCUTNXQ1RZdzlFdzR0?=
 =?utf-8?B?Z0NsK1dacEJjS2tQZlRMSFNmMTdGUGo5cktBTmtrTUM0bFkzUU16ZUNVTVFo?=
 =?utf-8?B?SHIydHF3bXU3VzdKanpuMU94OS8yajdRMW9kc0VpZlFjNDl1NytCdUpwVktK?=
 =?utf-8?B?YWwwNnUxc1l5Um5SOW83Nmw2dllMcFl3SDRaeW42NENLWjRtWG0wUzd5V3Mw?=
 =?utf-8?Q?W9qzyWGBVx6k8G1kH3iQ4LG0qUKyIcbv4Jy2iMui3XNE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MEE1M2pLSzBpZEhXT2I3R2UwWEdObXNsemwvQXlDL21hTlhsTGNLRXo1a2RL?=
 =?utf-8?B?UTlJNG1ZR2xweWV5cXJBZ1ZaV2FNa09CdDRQUEhoU3R3T2RzNEhBNGJ2ZkZu?=
 =?utf-8?B?U01rVlJLQURnSWsycENVZ0E2eXlSRmcrVVRIVGpPTGJkc0xudjlnRjlVeS92?=
 =?utf-8?B?RUt1ck5sOXkwYVlKKzl6RkVkdmlQN0NHM25kbThlWUU3NVgzdlRYaGFZQWN3?=
 =?utf-8?B?MnFmZmhEcERKbmRiUkF2MDJLWXBSTThTOGlCU2NtblFRM2RUQ0NORnVsSW5m?=
 =?utf-8?B?NmdYR2xMSFhCYXdFZTNCTlNtalhXa2k3bk5RbVM0bURsS0I3T0Q3dWc4WkNJ?=
 =?utf-8?B?VS9lSmFCYXhLR3U2WDNPOVVtUXZwdGhtamdiYmNNMmEveUkvRm5PT1AreVgz?=
 =?utf-8?B?WHRaa05SUHRMaUFIaE5jUHIwOU1PRGlvaGhSS3Q5V3E1bnh5UGJCcjRLNGZu?=
 =?utf-8?B?U2U4ZmlZZ1RnL0cxZEZNZTYweVdtWUp6bFdSaU5XUEhHZWJ6bDQrM0xCK0Rv?=
 =?utf-8?B?blRMQUQ4TFBNUHRSWGZYeDhNL2hFRVIzdHN5U1lnQlIxR1lzNmZNUjUrYnpw?=
 =?utf-8?B?ZUVzRFZNQzlMMWpKWHYvVXl0eEplK2RBM1RHSU1PNHdXdW80TkxnUEdWTGY5?=
 =?utf-8?B?UEpUak5DWE9Ya1hiYXhDbHRjM21TMzJRSUlnQm45V3JaNkI4dzRVR1FPTW05?=
 =?utf-8?B?N0t5c05UV3p0cC9kZHVXUDdIcVJDVVNhVjFtY3dQU2FsZWgyZFN1Mjg4cXFr?=
 =?utf-8?B?dFhyWlBsWDUwUFpTanJjQ2pJZFJMdWVyc2pLcUJuRE95NDUvZGtZNjZFZkE5?=
 =?utf-8?B?R0FZdzVyV1ZEbUVqSHdkdFZ4NVM3WXRvd2FuVHoweGNaeStSWW8wYXhzMXV2?=
 =?utf-8?B?RGRoNll1ejdHUlNBSnNrbXpnYkkrclN4ZkFPajN5cXc5MlNBMjlKYWd5c0pt?=
 =?utf-8?B?TTY1WnZYTHRvY2hpOXlGYWdhRGVtZDlMdkxVNWFMVVAzMHBXYzB0YnNlUVJS?=
 =?utf-8?B?Ty9OUGJoNlY1eFBYNVRSbmFaeTdhaVdjeldLM3EzcGwrcGhiQ0xaOFFnYjV5?=
 =?utf-8?B?SUlBK3U4UEhEMHR1TklPcmdqR3RjalVoKzNsMFRZd1hQTnB6cU1MWW5NcDdi?=
 =?utf-8?B?dU5aTm9mcmt1cEFuUlFoT1pZWHRxNHBRcXZVdlhPUnhpOVhHckRoVS9mRWhr?=
 =?utf-8?B?L0pIZW1xbmdnQ2k3RlRndWUvVjlScktSOXNFdDBGY2hXSFhkYllZLytXaVlo?=
 =?utf-8?B?ZGxzUWJFK1F5Uk81bWpPQzFvZGJ1UUtpYklnL01lOE5kbHRSZEI2NlRUTWx1?=
 =?utf-8?B?andOWVZKbWpLUXNrdUFpLzV3eDJ2TW81TmJ1d2ZldWxJbCtBMjR0VXlET3Rr?=
 =?utf-8?B?bXRpZW1CYjNxUFFwRmdZS2tUMldNU0xubXlJeVpVV0NWMjMxQUdkNzhnZXkz?=
 =?utf-8?B?YlVLdmRUd2hmMENnTUNSSkhVY0k1NlBGaTFjS2VzYndqdlloYkdqeWRNd0VV?=
 =?utf-8?B?dEhyRkgwMHp0L2xhM3p5a2UzUngxemtRM2liT2plK2JRU09oUE9CaWMxK3pL?=
 =?utf-8?B?L29IWTNKMklNcDcwSU4zbmVIS3NWYlBnWUt1RnRNeVFiVkJjQWR0NGU2aXNp?=
 =?utf-8?B?WlkrODB2UEdJSnBZb0dZaUh5ZlRZbVBTZDRPMXU4OEVqY1FXNEhUQk95TlpR?=
 =?utf-8?B?dnVsUXZEQk55ZFRVdDhJMTdVWGNkRTBMY29Qa3l2dTVhY3paaUVlM1d1NVB6?=
 =?utf-8?B?NTV4ZFE5LzUvcHZTd2N4MGY4Mm5mbmpSTEZ6bTlwM0o1M0Z4a0JQZ3ZyWVdl?=
 =?utf-8?B?c2RrZ1YvWTd1ZFJiZDhLZEVMY0xhL0NYUlU3bGdFTGZCeUpxNWdGOXBxeWZ0?=
 =?utf-8?B?OUdQSXlQc0thUEpLMEkwOXJ6dVhTNnhTU3VyMk5HV0R6OCtRWGFJYlhEcm10?=
 =?utf-8?B?T2ZPK1lwKzJ6UnpScnFGQU81Zmo0YXRidEFsY0REMGpQci9GanRGdE8ycEhF?=
 =?utf-8?B?a1ZEUHRrRUZFQjA1cEo3L2w1cjhqTFMwRjB5TkNsQ3JXRVJMMkJtR2lFZTYw?=
 =?utf-8?B?VWpPRkRya2VWNVRjaVZZVzN2aktoVVZHeENrQmNLYS9TM2ZvNGRPTlRLdjZ0?=
 =?utf-8?B?a3F0WWVnSU10a05PaUJoZWpYd3BkcGI1dTBkUm9TU0ZSL2kxNFhSbzl0dXBz?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WsZWuR23xUpeAZsYMjp/LuNuYMHwAoYi4uPWrdokAWasXmlZDT6RTMBJ/vWAAqqgzyr34LwqapwsE6WdISdtUyzCVCbe2bvIDJx24Gl4z/kDc7qr2ZVYq/yd4oK7zViEINiojVl9BFd0CiqJMWgfd0bswxIXpz8icHOtVtLnxOVZEcJh5n3Ye3ofyZd1bdpl0Dyksob+SDl3lYi6PY4jO3lgLApB473P8ifQU+4ZGiICJu40VsUXYQhvN/5bIZlcmHBI2y3OuLof6looBcZKAbDtXokCm9T/Rwv85jzhxdJqOtfo9Bj/rZjYjIKllWkYw96I7aPZWmQPwLwxwiga+0ahnkPL9SPyWj3KaU3RFau++ZygO9tMep5q9AZaBUjKvjqibX/SxA/lK44WJs7qwbhrm60aZCFkuQi2tx1ZJrbHbugMAx+OPMVUmVctbJD1z47zEqNhyyOZB1fp5LcX3ymKEo+aIVmey2wOkvAeGvH02FGmt5bWLKvXMxnZrdhYvvVl1+FN++DBHnrOu/nOClHDib/E3JdubdglJ08EICcjP8Toc4Fv5JKeN0EqjKetW8LR/osxY9weds4Q2muj7ew58XAFVmXXn6nc7hoIovE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139192dc-7f06-49be-5925-08dc7684f700
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 15:21:03.3062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfQgPmOlJM4Zjqcu/RJJ5mHIWG/PQNtQdDTCDdVj2S80RyM888DMJQi4eC8Ck8JWEDVfgGXP0A5h0mcBj9S30A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_06,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405170120
X-Proofpoint-ORIG-GUID: iQ2sLfSiF_02S0jjtcxJcZSMHzBDDcWM
X-Proofpoint-GUID: iQ2sLfSiF_02S0jjtcxJcZSMHzBDDcWM

Hi Linus-

The following changes since commit dd5a440a31fae6e459c0d6271dddd62825505361:

  Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.10

for you to fetch changes up to 8d915bbf39266bb66082c1e4980e123883f19830:

  NFSD: Force all NFSv4.2 COPY requests to be synchronous (2024-05-09 09:10:48 -0400)

----------------------------------------------------------------
NFSD 6.10 Release Notes

This is a light release containing mostly optimizations, code clean-
ups, and minor bug fixes. This development cycle has focused on non-
upstream kernel work:

1. Continuing to build upstream CI for NFSD, based on kdevops
2. Backporting NFSD filecache-related fixes to selected LTS kernels

One notable new feature in v6.10 NFSD is the addition of a new
netlink protocol dedicated to configuring NFSD. A new user space
tool, nfsdctl, is to be added to nfs-utils. Lots more to come here.

As always I am very grateful to NFSD contributors, reviewers,
testers, and bug reporters who participated during this cycle.

----------------------------------------------------------------
Aleksandr Aprelkov (1):
      sunrpc: removed redundant procp check

Chuck Lever (6):
      NFSD: Move callback_wq into struct nfs4_client
      nfsd: new tracepoint for check_slot_seqid
      NFSD: Record status of async copy operation in struct nfsd4_copy
      NFSD: Add COPY status code to OFFLOAD_STATUS response
      SUNRPC: Fix gss_free_in_token_pages()
      NFSD: Force all NFSv4.2 COPY requests to be synchronous

Guoqing Jiang (1):
      SUNRPC: Remove comment for sp_lock

Jeff Layton (6):
      nfsd: trivial GET_DIR_DELEGATION support
      nfsd: drop extraneous newline from nfsd tracepoints
      nfsd: add tracepoint in mark_client_expired_locked
      NFSD: move nfsd_mutex handling into nfsd_svc callers
      NFSD: allow callers to pass in scope string to nfsd_svc
      SUNRPC: add a new svc_find_listener helper

Kefeng Wang (1):
      fs: nfsd: use group allocation/free of per-cpu counters API

Li kunyu (1):
      lockd: host: Remove unnecessary statements＇host = NULL;＇

Lorenzo Bianconi (4):
      NFSD: convert write_threads to netlink command
      NFSD: add write_version to netlink command
      SUNRPC: introduce svc_xprt_create_from_sa utility routine
      NFSD: add listener-{set,get} netlink command

NeilBrown (6):
      nfsd: perform all find_openstateowner_str calls in the one place.
      nfsd: move nfsd4_cstate_assign_replay() earlier in open handling.
      nfsd: replace rp_mutex to avoid deadlock in move_to_close_lru()
      nfsd: drop st_mutex before calling move_to_close_lru()
      nfsd: optimise recalculate_deny_mode() for a common case
      nfsd: don't create nfsv4recoverydir in nfsdfs when not used.

Stephen Smalley (1):
      nfsd: set security label during create operations

Trond Myklebust (2):
      knfsd: LOOKUP can return an illegal error value
      NFS/knfsd: Remove the invalid NFS error 'NFSERR_OPNOTSUPP'

 Documentation/netlink/specs/nfsd.yaml | 110 +++++++++++++++++++++
 fs/lockd/host.c                       |   1 -
 fs/nfsd/export.c                      |  16 +--
 fs/nfsd/netlink.c                     |  66 +++++++++++++
 fs/nfsd/netlink.h                     |  10 ++
 fs/nfsd/netns.h                       |   1 +
 fs/nfsd/nfs4callback.c                |  31 ++----
 fs/nfsd/nfs4proc.c                    |  79 ++++++++++++---
 fs/nfsd/nfs4state.c                   | 188 +++++++++++++++++++----------------
 fs/nfsd/nfs4xdr.c                     |  83 +++++++++++++++-
 fs/nfsd/nfsctl.c                      | 526 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfsd.h                        |   3 +-
 fs/nfsd/nfsfh.c                       |   4 +-
 fs/nfsd/nfssvc.c                      |  11 +--
 fs/nfsd/state.h                       |   6 +-
 fs/nfsd/stats.c                       |  42 --------
 fs/nfsd/stats.h                       |   5 -
 fs/nfsd/trace.h                       | 100 ++++++++++++++++++-
 fs/nfsd/vfs.c                         |   2 +-
 fs/nfsd/vfs.h                         |   8 ++
 fs/nfsd/xdr4.h                        |  24 ++++-
 include/linux/nfs4.h                  |   6 ++
 include/linux/sunrpc/svc_xprt.h       |   5 +
 include/trace/misc/nfs.h              |   2 -
 include/uapi/linux/nfs.h              |   1 -
 include/uapi/linux/nfsd_netlink.h     |  47 +++++++++
 net/sunrpc/auth_gss/svcauth_gss.c     |  10 +-
 net/sunrpc/svc.c                      |   2 -
 net/sunrpc/svc_xprt.c                 | 168 ++++++++++++++++++++-----------
 29 files changed, 1286 insertions(+), 271 deletions(-)

-- 
Chuck Lever

