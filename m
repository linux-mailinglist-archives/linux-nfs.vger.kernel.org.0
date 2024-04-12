Return-Path: <linux-nfs+bounces-2775-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4A18A2C47
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 12:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2ED1F21EE9
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 10:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1652453373;
	Fri, 12 Apr 2024 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CCOl4BeI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RDw3Nx8+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7374CB2B;
	Fri, 12 Apr 2024 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917580; cv=fail; b=pD2cQPCRtyAFBnXLEmEHHlC4VtheAOjhDzS51S6iuIOHUzYN2PHpTubzoaFHaMuEVNRvFxh3QPrslgl44pSFFtOJkJrFbjnTPugJUQX+CyewDyqxSz5NK0D7FvNq+w0s+JdLTIIXY6mzCPdGY9BR/pppKgBeaOT9azJJwv0uM4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917580; c=relaxed/simple;
	bh=sa46Gd3b8aVl9Jee0u8+fE/z4hhFaHLaFgt5VUXKxHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BESqYmvEadGAxN9vW6KpzK5v4wtjgbjd5GjFiWYFxcWZgml71C7VcC1E6PGfEGc+chKkjSXYeP6DLD0zUHSGwu+dHojEdE/Iw9CczWKQXXo7yW3eHI0/XHGmbSdK3BwTBqAWHwbVY5t6L0vJYDq8UPkNKKlw6pUClqln/SpML7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CCOl4BeI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RDw3Nx8+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43C9447A015314;
	Fri, 12 Apr 2024 10:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zYvuyuE58REjWHdx3rA/xJTuODq8D6ChHcPgfWmwqLY=;
 b=CCOl4BeINidKUmIhv7ZSOhNowkOKtb7/ELAtn/HA5qnSDhnLgznTLfz8wyQRbuqUBIHS
 fiyeXnJf4cQSRlyx5BK+M7utM4SwvmE0ClG/gGCd31ru6vxEOWYzXBnlg/5vi6xOuzvV
 S9l/tZEnjPPRNeVnylrakVTlEt8JJUisi0ptjVwJz7fM7hzVXBed38k0Tg688RHBJ7s2
 PDsbGv2G02noGgt/t8K6Km7XP7Qa+N8NlObkgvO9BefRWJG6NBZQqmhRlbLAVzRONRe8
 HoNjSR6Ile9K8BRCyZv6KFkobUHrYe/G7RUlJxxjVXhU1eM21l89SJeHkKwH5FyfCxqm rA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xavtfbcug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 10:25:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43C9ImCv007835;
	Fri, 12 Apr 2024 10:25:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuasydm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 10:25:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNl+pFFojyNpBCnwcp/jSeEaXRdhfb+GGnlFT3DIFDkiB+W1B5EAOcNPFl52znyuKGKOGgXXHqx+2nJdvgdojUnw1wLXAf1TlNUUhs96Sw+44dwhza1Z7FtgzBmtA/R4Ir0FIDkr+dJYaQGxbUi0e7BSuvcM9LofTwFOFowXSbFyOZxuJSMo/yKVBkIhoYh+g2Yr8D6cWuljTYrmBgwrkpP8CxJ0gr7RJPuH8mMP8FlKZuhZ6rNvyhKr66loxViq9gqPpFWJDJBgdoCfHFvFqDD/s+IJ1TFwJ85GmcCk+OzXKmWLC/r82bB0+S6wdAcSIXGwHyIK+Ozwrji9nxTJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYvuyuE58REjWHdx3rA/xJTuODq8D6ChHcPgfWmwqLY=;
 b=SiZ1WpUerljK6pJWEn4i1JST759ns4W8asbceKL2UsNBZy+M7r6VtCOR7e8pkA8HVCWw+wrNcP9IZAHU9DFQqBx/1phfODfdZDSZ6Uz6fjrjrIUiYOjs9NEWMlLpSJR+E93izE3Jtxzeu/C9lz7KUakyaKdq1Z5GHbtvPN1Tn0piHhZFLEQ4yOSEKvJenWQOPQYaJR2oHv/fd3F5Kf7/YzVYaPa2niMe2vnHZvoFWI/3bEuVougCth2XDn72KgrB4kTQGXVuslo2MXqu+85ToHLAxvJNY0TFcxlLajdwZEiX/NP0VHuSTTiKSmE2LjhPGK4tIJFCt/S82VfrcT34EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYvuyuE58REjWHdx3rA/xJTuODq8D6ChHcPgfWmwqLY=;
 b=RDw3Nx8+LZwbjtHr0JS/iPnZ6JUwhIIh2+/gYDn1ms5GjsmAnPiDzYQF2W0zffqZRVuecE6IvvY4j2ZUQUhT0IsPPRe1x/n23pcTtWVYgQ20nG9Aw43Som4LT/LzbrhWV3Ct4brIJpY3pg6PDKI5gUNDywG/xcyJet3pcaIMSt8=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH0PR10MB4485.namprd10.prod.outlook.com (2603:10b6:510:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 10:25:46 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 10:25:46 +0000
Message-ID: <2c2362c7-ace7-4a79-861e-fa435e46ac85@oracle.com>
Date: Fri, 12 Apr 2024 15:55:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        broonie@kernel.org, Calum Mackay <calum.mackay@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20240411095407.982258070@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240411095407.982258070@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:404:14::16) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH0PR10MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad67f6a-286e-459d-652b-08dc5adaea55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iPQtvqK4jXek82je2K4Rhm0/vTjmX+or0ozzWn9MMALrnYGdKuiinSLzHYZBwKAlClDP2Ufd0mzycL5I7lx9HgDMESTyxJWaksMhIC9q8J1PqW06lgzBPdlmmQJqmD6voySwbyaG4gE8lQO6pat/OtKEZJGZTjjU3D4HWQYTyE6NMShVkFvLvi+e2HqJPko6yDx1Gw1Msg21M8vzTNYDm/70mxMm2qyylcOVK/QJy3ohBADXpM6TzB4D1l892yPUnCvZ0BxzJhM2ZBIgC5cuEfZlj+MOHf3d8/47Tb3VQGdIn4eYlYVTA04HiWBwssG1DhmDFn6vgHpBPCJySSnFIocMExSk7t45ORk8CYMnyb8VqzHrR/S3GHStSMdeU10qvejAT9SiOzs5CjbEc8edJB1DUo0jzuOvRg5TeUlIHT8Yt0peuI/7/2JIe41tPXPc1uSIm7ipmJ6DyJEPgO0CFE9/ASQb/B4aE4ow7bAcey0eRGyBN6YT55jQsVH9i60nkq48C/VkO0MuYHzaafw9p4S7xX7CjKnlpnJsBTtUTzJwJUourveEajugojKuXZy/afGDcBeLasHUKwpugQWTIgqSzYy42A+V2DQrOZxvqIOKD+t3rWnKhRww+rlJyoyFNqgt/tWWRxSnnfTlQBa57DKLnDCGvtBYfjL3uE9afFA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Ny9XcUlGRjk1dVBnRkVRbjRtY0Rubm54VUdWdk5kcXhYbkw3QW1XeDBlQm5R?=
 =?utf-8?B?Z0tsT2krLzBoMGFMYTAzVXkxTTJSclFIbktjQlRYUitZN1dLMldWVlhndEZF?=
 =?utf-8?B?ck1GOHlsKzBYRmFnWWRHN2VpODJEUlVpNGkyUE5SNUZCdndXdUdLdzVrZ3BI?=
 =?utf-8?B?cWhKMGRLWjRhU0lCV3Zha3FYdTQ3a1Y2YnVIckRNU3JGNFN0aVpob1VFU2cy?=
 =?utf-8?B?enNkT3ZoZnhPVlBObFovVXhrREdYbkEzS0FDUlZYUFFpS28rNjdLWndHNlFQ?=
 =?utf-8?B?Z3JMYTJ1aHluK0dLQ0tuUWN6YVloa0ptZXgzWGFXODFRVFcyck56NTNNS2ZT?=
 =?utf-8?B?eVNVcnlxYjR1djZFcmVBZWRERFZvOFlnb0M3MUFybTduRVZoWWdnZ2Jxa3Rh?=
 =?utf-8?B?TXFvblp1UEVEWFFEaHZ1QmJIU3RFMjNUazduU1FSYjVJY1NDYzdiMktQMTkr?=
 =?utf-8?B?TlRhWWdTUzJQbTJiMERIeE0rbXhpVit1dzVXYTRJcFNWa0VleXo1OUFEcHJW?=
 =?utf-8?B?clRjdXJlaVFYRU02NFArL0FpQUNJbDYvU0VpTWJmNTA3VVNkZ0E1S0x5Mzlr?=
 =?utf-8?B?V2JENjJibzFxc3dZLytCY3p2ZUZJK28xZWJMN29maE5Vcm1LY1graklGVnkv?=
 =?utf-8?B?dlNzRWswaHR2Y0tuNEJEQ3ZJeEpubG5EL21FUHRSR3ZoeGNIZ0o0TTNPNGNZ?=
 =?utf-8?B?UlArdXNhOWRaV21GeEUwcWNlSWtxa2o4TUloUlhBQmhmbnpkVWhadVpwek80?=
 =?utf-8?B?a0psdWRIMmNBWHNxbnNxMGVIc1h5VEJya2tVWnpFRHlvYWgwR0NxdDZiNC8r?=
 =?utf-8?B?ZnlXMitRY3JjdHY2TGpQVXdUa0xYSVJUcE1YNGo4cnlFYTY5MVdZaVk0aXRN?=
 =?utf-8?B?MVBaMk1vdm5GMFZ6YXFOa3BQMGlNMDM4VmI4c3ZVc3BJV3NvT2h2eDQyN0ln?=
 =?utf-8?B?eUt4M3RJcC9kbHhxMGtjdEVuYkE0a0FFbS9mMXJKMzMvWTJRa3hxNEw1Ym5x?=
 =?utf-8?B?bWJ2WkY2VU5BbGhXNUtPaEJqRThZSTR1RlhENzVGMU1GMHVwdjB2UjU2UUVF?=
 =?utf-8?B?dE5OMUNCSjhJRGYrUlowTERDNzBId2dmNW51UFRVdUNsc3pmaFFiRmJ1UGg1?=
 =?utf-8?B?bGxEK0VDb2t0NnkwVVBKdGwzWHNibzdtcmVKV1FMQ0c1QjEvVlhBbmRaeXJm?=
 =?utf-8?B?RXJuNGhXM3dOVEJ1MWFndHVsc3FwdFU4UGtvREhMZEJjNXRwV0MrdHV6MWRK?=
 =?utf-8?B?NUNHZVdMMHZXWDZqWXNxZ1RUbUhyRFVQWG90ZWZPa0lrMzhKa0FnRVU5OFox?=
 =?utf-8?B?ZHM5OWZrdmVFK2lkdWRyOVYzdnZkQXMzUVRBa2xtVHF1bHd4bEtHb09wZDVG?=
 =?utf-8?B?KzN0L3dXeExuOEhkYXdLMU5rLy9qZitrTVhLSmhVNGJGM3ZpQ3dnbk9VK3pT?=
 =?utf-8?B?c2FybXpRSEhaMHBMMmZuZkxnYjIyNXJKWENvb0dUL1RYNW1LWmVZL1hTUkNR?=
 =?utf-8?B?Y2Vvbzl6Y1NlNlkrMHBzaENCRGNuWVZ2WWRHcUZiaUhkcnVhRzZPdHVGVjU1?=
 =?utf-8?B?dkhKL0x0REdialFXR2RrSWo3aUNkNTRSNEI2WlpMV1ZDLzF6MUFuSHFRMjF5?=
 =?utf-8?B?T3NRTUF4Z05YOUVtUU1TNmVOaTdJd2ZvOXNhU2VEbldTb25LS05qZ2VLVFYr?=
 =?utf-8?B?UmRZNGpIdTFpejg2RGVjNGZxRW44WDNoeHE3YWxEUlJjY0xFRnJnR0VHeDNQ?=
 =?utf-8?B?bVZtRXY4bGo2ekxqeXJmUUdod1JlQWZ3WVdkZ2Znd3dKcWZOMFVsWk1PU3Bq?=
 =?utf-8?B?c1VMUVFEVG9SYi9pbzdRMXlUTDh0bUZiNjU3VEVhdURXMFFYenU4ZG8ydVF5?=
 =?utf-8?B?SFJtQVNMbVJJMEpwaW1MbWowSVBVNXRWSEd0aDRuZFc4RGZtTHN3MWw3aDF3?=
 =?utf-8?B?NWlhcFB1VUVRWDErQW93dWJ3VGM1LzI4OW1BcjBCL3l1cFR1K0RFRFdLbG1q?=
 =?utf-8?B?YzYrbXQwUDRZYjExcy84eFk5WGI5THVrQllKT0JOVUl2Sk1nK3Y0d3FrZnk3?=
 =?utf-8?B?RW5GbFdvV0U0MG5SM2dGditWS29UVk52cmNSSGEzeEEycFpydFUzMHlNMXkx?=
 =?utf-8?B?R091ckphYVVSdTJ6cnNic1JQRDkrTzIvdlNWUkhQWWVzWEZFMVB5OEd0dXVN?=
 =?utf-8?Q?awr3Ol3ti4YrDV88XXkmFtY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	t97wf0OARh3h9+28ZaWLqn7N80P24le3x8xn/LcauOndENIL5YwVx0ui98NCuSnlbQgBcU0sdkp0Sv8UmJThOUHxQLXxEMf1CEhhCxXg7hiblRFlG5n8eiT3WupvycUL7pM2TGzn955l7Lm6QFgEmXKq88sN6SHtYfCRtaes7Cd5B9e5rHCHSPETXF8/h0gMpXtPC8VFa1FDimB9LnIThTiPttQUM83Ex4UoctP91sZVN9hxI5UggRIX36VZw5+GAWH0mjhrfQyxbu67ISkRNeF64pgVXaGt9HrBqoCC9T6Z8G3h205uc0ALU1RF2Kjx9fX+ZWVvzxq9BClkkqgfVg8L4SxXDFqGY82M0nkR2Kh9ndl/CivR6G0wMFNO5RMsyiZcW2m2HGI70/PpPp2aNWRU8f46nMI0KFpIYg5v+O+vhyf/IRu3vB905Phbd1wGPsetFOUJh87Z6gYjtELuyesbGiAICLX3UqITgpBJUBwZeGhkBYjKUIUaRYhfmIOz9xIG5LH1ij0R1zpdYfHc2LCIAEbjaEPs4eEved9dcH6Fo/63E1GyjEAR4AtgzZnW/3RA04Yxruzqh5RopkKProxuPfu7Wkkztc3bDM5ra8M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad67f6a-286e-459d-652b-08dc5adaea55
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:25:46.2779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyADGPcVP7/6V0A4AoSi2HRiPe19RgqxTOF12yNoa9Hr6/Fh3aQkIA2++KwDV/j/nyOCw7liSh0pDfdyUUOlXtkfS52jQBnijAGmO6kq2tNvoQ03elY+ucRa4l1A84Ri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4485
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120075
X-Proofpoint-GUID: ZLkZf84YQVQSrp2XJEp9JnnoNjfxwnoj
X-Proofpoint-ORIG-GUID: ZLkZf84YQVQSrp2XJEp9JnnoNjfxwnoj

Hi Greg,


On 11/04/24 15:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.155 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 

I have noticed a regression in lts test case with nfsv4 and this was 
overlooked in the previous cycle(5.15.154). So the regression is from 
153-->154 update. And I think that is due to nfs backports we had in 
5.15.154.

# ./runltp -d /tmpdir -s fcntl17

<<<test_start>>>
tag=fcntl17 stime=1712915065
cmdline="fcntl17"
contacts=""
analysis=exit
<<<test_output>>>
fcntl17     0  TINFO  :  Enter preparation phase
fcntl17     0  TINFO  :  Exit preparation phase
fcntl17     0  TINFO  :  Enter block 1
fcntl17     0  TINFO  :  child 1 starting
fcntl17     0  TINFO  :  child 1 pid 22904 locked
fcntl17     0  TINFO  :  child 2 starting
fcntl17     0  TINFO  :  child 2 pid 22905 locked
fcntl17     0  TINFO  :  child 3 starting
fcntl17     0  TINFO  :  child 3 pid 22906 locked
fcntl17     0  TINFO  :  child 2 resuming
fcntl17     0  TINFO  :  child 3 resuming
fcntl17     0  TINFO  :  child 1 resuming
fcntl17     0  TINFO  :  child 3 lockw err 35
fcntl17     0  TINFO  :  child 3 exiting
fcntl17     0  TINFO  :  child 1 unlocked
fcntl17     0  TINFO  :  child 1 exiting
fcntl17     1  TFAIL  :  fcntl17.c:429: Alarm expired, deadlock not detected
fcntl17     0  TWARN  :  fcntl17.c:430: You may need to kill child 
processes by hand
fcntl17     2  TPASS  :  Block 1 PASSED
fcntl17     0  TINFO  :  Exit block 1
fcntl17     0  TWARN  :  tst_tmpdir.c:342: tst_rmdir: 
rmobj(/tmpdir/ltp-jRFBtBQhhx/LTP_fcnp7lqPn) failed: 
unlink(/tmpdir/ltp-jRFBtBQhhx/LTP_fcnp7lqPn) failed; errno=2: ENOENT
<<<execution_status>>>
initiation_status="ok"
duration=10 termination_type=exited termination_id=5 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=fcntl17_64 stime=1712915075
cmdline="fcntl17_64"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
fcntl17     0  TINFO  :  Enter preparation phase
fcntl17     0  TINFO  :  Exit preparation phase
fcntl17     0  TINFO  :  Enter block 1
fcntl17     0  TINFO  :  child 1 starting
fcntl17     0  TINFO  :  child 1 pid 22909 locked
fcntl17     0  TINFO  :  child 2 starting
fcntl17     0  TINFO  :  child 2 pid 22910 locked
fcntl17     0  TINFO  :  child 3 starting
fcntl17     0  TINFO  :  child 3 pid 22911 locked
fcntl17     0  TINFO  :  child 2 resuming
fcntl17     0  TINFO  :  child 3 resuming
fcntl17     0  TINFO  :  child 1 resuming
fcntl17     0  TINFO  :  child 3 lockw err 35
fcntl17     0  TINFO  :  child 3 exiting
fcntl17     0  TINFO  :  child 1 unlocked
fcntl17     0  TINFO  :  child 1 exiting
fcntl17     1  TFAIL  :  fcntl17.c:429: Alarm expired, deadlock not detected
fcntl17     0  TWARN  :  fcntl17.c:430: You may need to kill child 
processes by hand
fcntl17     2  TPASS  :  Block 1 PASSED
fcntl17     0  TINFO  :  Exit block 1
fcntl17     0  TWARN  :  tst_tmpdir.c:342: tst_rmdir: 
rmobj(/tmpdir/ltp-jRFBtBQhhx/LTP_fcn9Xy4hM) failed: 
unlink(/tmpdir/ltp-jRFBtBQhhx/LTP_fcn9Xy4hM) failed; errno=2: ENOENT
<<<execution_status>>>
initiation_status="ok"
duration=10 termination_type=exited termination_id=5 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240129-167-gb592cdd0d


Steps used after installing latest ltp:

$ mkdir /tmpdir
$ yum install nfs-utils  -y
$ echo "/media *(rw,no_root_squash,sync)" >/etc/exports
$ systemctl start nfs-server.service
$ mount -o rw,nfsvers=3 127.0.0.1:/media /tmpdir
$ cd /opt/ltp
$ ./runltp -d /tmpdir -s fcntl17



This does not happen in 5.15.153 tag.

Adding nfs people to the CC list



Thanks,
Harshit





> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.155-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

