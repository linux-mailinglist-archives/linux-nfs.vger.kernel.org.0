Return-Path: <linux-nfs+bounces-5685-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB43695DE99
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 16:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D621F21D0B
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4661714DC;
	Sat, 24 Aug 2024 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bIPmIN50";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iM0qb6Ix"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D301714DA;
	Sat, 24 Aug 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724511266; cv=fail; b=B+1lqm83cVOm/1+c/B5idzO3+MAyLo3B5io0xJcvJ5lNiTP79+1LJaObBSfc4KFLBAQtM80jSfOJVX8B00B2+QhZw3kUIdDxZXhD0U0ob+dk/1gvRvD/JZvHmKro7fGivcGuXbbejrOLlzxVjZzAIbNVWd9bXUM7uO0PA6molMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724511266; c=relaxed/simple;
	bh=cORiPnR0f8iJUrzn6djzxKqefHnKhHUmyHaV98o68GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gHP73U6tEFf4T3JK02orWUpPs+HYiQdSfWj2u62iNDJQ8BmG+C8Is3NNFqFQyDNLMbP8ptvsaEs739nP3GXHR9hGYrsc3Rquhkxn8HG80a67362k+SbgmwgQdTRr24DubOzCfm2xyvb8RVBb9Nnq41yT8piL65tUvwMK9xb7Gp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bIPmIN50; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iM0qb6Ix; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47O3tF89018524;
	Sat, 24 Aug 2024 14:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=YEBp8nKGFvUIoUDWvlZtNFbgIKqBeUdgjJJ5M5mrwLA=; b=
	bIPmIN50+zsh9ZFdjBFehnWUEpK5sFbLVN3zD9ty5BGJ8p+z42azL99WAj3l1u0T
	KAQo87Ds+ndQcDy9720i+L1soTMZXiYuYzjOZE+RhZgz8A/RM+FFCtj4AND9sSgf
	5NlGY7o43lOqx52zzLedMXyF/2M+DkeggTnYJZcZjX7BhuN+56wjtHO6eq21DvQR
	3hTJkA6v5ddou6sPkbeSzDuB2xu3oJmItWM8uq6oPMKDM2gb/VdlUO4zgL6HhZJi
	kwOOKEcmYSRMXLa95wWeP8om035usPe0QFSu5eGu5coIhaj2U9BFKybDtK34TSHR
	4k+PvX1RAZbHeOC/JB5KRQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177n40d8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 14:54:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47OE9JdL001870;
	Sat, 24 Aug 2024 14:54:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 417h1grky6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 14:54:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxrAKG9VPVGczddzc5rtbLpthpKSb7HTXjLG4C2MA6XTL7Y+/pzmeULOudxTLoNlJQ8Ftj6jOgM2IBHMQLtcbs4UEHJ/c0/2oD/V4SQYVWt8QTog5J3EIArJHfefJDib4585u0oNfA/ngs36eRw9GXnQAfrVXlycs4cKfHRPUsdL3STBxe/2Q0Jo5HRmwJGOEvXglFo//O80S+H1+7N8zrcNgQ34zBlo3L5SfSB1qhI+aInwgqH55QYqv4r8JYkeEBT83dXIqOClXGAfAh4o//5KXPiMQcG+hywQJt3ZukqF/6w18pWd8Wb519lf46x1FBcP83cyLk/0ONRGUFF/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEBp8nKGFvUIoUDWvlZtNFbgIKqBeUdgjJJ5M5mrwLA=;
 b=PdQklAk13mhKeOmn/mjA3DvBCBn27YWkG3rvs726JHXXqm+HRH71lBYfZxcBYYmNNAyVutD0trZCl0G0uPtUN4wEuwZasrktpyx/p27oVbFvEa5lFYYMKdVSeYQMVnMCb29i0PjETwZe/pwTI4L2xkV08rqmtMMR15KvgA4U34g/9Dp+8Ho8thXFS04qDfKGDLRmG6NLehhkcDeL7vFteEkNjvz445Xgu2JIbMxKQtU4NBgxhKtMFmUmXOQ0FB4AddppO+plMPpEeHJxd1KjbSGnle+tjwIYCq/FYJ/WuJUd07OGE3BWyeIwslek772BAi+hLtQvA52Thk3RkAUX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEBp8nKGFvUIoUDWvlZtNFbgIKqBeUdgjJJ5M5mrwLA=;
 b=iM0qb6IxVSNdZXZ1hWpHjhBlO11lD4//W0APgNFcOPwpMwveLW8BHOos6ObLFApyAdEP8vJvcOGM9KF/90zoBlzjvc5+XkhmNMbDc3fKDH0nbvd9zU6XK2vaI7P4RcDx/RN0jCHxkKVFMiVg3mvFxwhYI0DEZARGfJVFOgf44Ic=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5136.namprd10.prod.outlook.com (2603:10b6:5:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Sat, 24 Aug
 2024 14:54:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.006; Sat, 24 Aug 2024
 14:54:08 +0000
Date: Sat, 24 Aug 2024 10:54:03 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>, Li Wang <liwang@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>, Avinesh Kumar <akumar@suse.de>,
        Josef Bacik <josef@toxicpanda.com>, Neil Brown <neilb@suse.de>,
        linux-stable <stable@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] nfsstat01: Update client RPC calls for kernel 6.9
Message-ID: <Zsn0Cyok23EMVHmY@tissot.1015granger.net>
References: <20240814085721.518800-1-pvorel@suse.cz>
 <Zrytfw1DRse3wWRZ@tissot.1015granger.net>
 <20240823064640.GA1217451@pevik>
 <0BDD1287-471E-47A8-A362-DF660806CED6@oracle.com>
 <20240823185302.GA1302254@pevik>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823185302.GA1302254@pevik>
X-ClientProxiedBy: CH2PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:610:54::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: 0688c44c-a467-4962-efbd-08dcc44c9a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm10Yjg5K253c2pRMzJySllEcXBiMHQySWc0SnEwVnR5elJwNTBXUXduUldS?=
 =?utf-8?B?MU1icE9KRUN2MCtreXkyR1F2V2VWbi9LemoyTGRwakYxNWZDRWh0elVrOWVE?=
 =?utf-8?B?NTcwemozTS82VGV2d0FpVGJ6NlJSNmVrYm5aZTFDS2lxTHhJOWNrcGpKdkF0?=
 =?utf-8?B?aG9jUkZDSm50Qkd5WGlXb0JhdXl3dVdlRDAwdzhBRnBJRzgzKzVyaDNWNVBF?=
 =?utf-8?B?S0lBY3dxNU5yV2FCeDFDOUdkTzhBTGRVTWdQWDVXUjNkVnJkR2hrcmxoQ0dM?=
 =?utf-8?B?ZGs2Z2wyWElNUGtqK1J4Wk4rd0JYNERGU2ppVjVPRkhBUmdUWmdlQUtkeXpV?=
 =?utf-8?B?bWZyc2hUZk1iYmEya3BoejVvZk8rYUNBeURIOE0wQXRVUUZmcElNSVhvYkdj?=
 =?utf-8?B?OW96VHdsUmlsYU1vQTk0ZXQxNitlUUEvUlR1UEw5N2I5YW5zVzk0ZFRvYXg0?=
 =?utf-8?B?UVJwdzZvUklIWTVBSWhQeDdGQmhQeXFYaFEvYWFXZ2dBRGY1Zlh3Ty9mZnVn?=
 =?utf-8?B?cDhkczBXU3puRzlNR2pYK0JXN2duczdsZ1hVbXd4c2xZWGJWRk5OWUxlZFgz?=
 =?utf-8?B?bEFuTE5ybHRScHF5TVdhbHFtdm5CMTFqNkJPRkJqSkJWSFprV0RNem9pSkVK?=
 =?utf-8?B?U2gzMzZGeWsvNGhteXNBcTBTOGhLLzVVbXdlQjIwalRQNjFRL3dzS1RpdE11?=
 =?utf-8?B?b2JxdEFDV2ttdzZta1Q1QXIzSmQ4enNyLzRydk1tZDQvVFk4MUQ4MDA5UGtF?=
 =?utf-8?B?L3A5YTZLOSt2ZGtmR2NiakhDd0RkNUtPc2tMRm5EZThEajJCUzBscllUQWZu?=
 =?utf-8?B?L2orSkNWd2piVTBic0g3eDhKNmFtcWFEd2c4QmhvZG9WOXMrcUNjV1F5ekQ5?=
 =?utf-8?B?eEQyYm9mWC9UdklRMmpUVWZVWjVoZ1ZWQzdQakVaMlR4QlMyZEtxMUVGTk5y?=
 =?utf-8?B?ZnlpVHBKYjhVWkQ4SThYU0JSc2QzMlpmbHpXYWZBdGNNYXg0TS9oY2NHYzRU?=
 =?utf-8?B?aCtwN2l6N1E1VTZuZ1hFRFJUMkxwVHdHOGtjYU55RnlaamFEZ3UzQkVwTVFk?=
 =?utf-8?B?Y3YrT3ZtajFBSTBVRkM5S3ZCS0drMi9ya1JVNVMvc2ZJczQwdVJDRHloNUM0?=
 =?utf-8?B?SHlubE0rMzc4enZoaGtzR0RwdE1EcVRDdzRiOStDRTFyOXdtL05menhFZjZO?=
 =?utf-8?B?YWJ6enpqMzExek1UNk1kaVliSDdldUJPMmRPYXZFSUpnL0VHSEZjdU5IUWR1?=
 =?utf-8?B?U1ZMd3UxckdicGtXdnJJSG80NGRBaDZqd3IyWkgxa2FHdW1NK3dYeDh6aG1m?=
 =?utf-8?B?QmsvckhYZXdISVh3ZEJ2SGN5ZFFOcUticUwrQ0NDaytvc1pOSTMrOVZaUFB0?=
 =?utf-8?B?SmY0dWx0VnVvTjhFZmd1Z0ZFQlh1VDY4TnNZcVFxN2RvaDFhM1dyRmlTVVEv?=
 =?utf-8?B?dXBXbHBPa0VhUU15NzlXWlppenNOVktMUVhaZnlTMVJabm8vTTlKRkZBN1c2?=
 =?utf-8?B?end5RlhkYWtSN1hnVWt3bEluV3VPcmZIVE5QQTh0K2R4cnhHeFVCQW95d3JT?=
 =?utf-8?B?QzhPdWhQdFJQVnZjWEMzc0xhaGNQSWpYaTFyTm1lT3lSWWdHVFRIS3FFL0ZU?=
 =?utf-8?B?RzFqT3VpcVpoa2VZYkFuUTYxNkE4OWhZWU01bm9STU1RY1JrcU5LTjFYYnBD?=
 =?utf-8?B?Z0FnN2s2RUVSenZTVDFzcStjSWJIM3UzSHc2eWJTQlU3alFlNG1BSDZqK1Nh?=
 =?utf-8?Q?NTSblAjQ7DWD+iIEntdrCYKzXmuYNFGRfGNEcZ6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWl2MWM1L25OTFhkZDlkNmxZNnVUSjREUzU4eGI2d0tCNnRuVTQ4N1B1MU40?=
 =?utf-8?B?eEJGVUFIRk80NmVLY1Q0Sy9PVWRTV3htT0NMeWtOeWtlZUNHS1VMSkppbEVi?=
 =?utf-8?B?U0ZlcW5iV0NEK25wVThjQmdPTGRFV2pZVVhvYms5MlJyWWY2YzBBMlI5OEc1?=
 =?utf-8?B?cDZSb1JXK1hFTWt1OE05NllLcTBhYVJLZ0R3WmYvYzdDSnN6c3BVV3Z5U1hr?=
 =?utf-8?B?YWNQKy9XYWNqRVZNbGI5c0E1YmZzYk40WkJ3ekdYa254U0RzK1FpSkc5dy9v?=
 =?utf-8?B?OU9aeDFkTFBRZlpDRVV3ckUyUGc2cWNBbjhiTmlONW1Lbk5xRnBYcHU5SWF0?=
 =?utf-8?B?amVicndQQmlyRFdKS0NQSU5HN3krOVFMZFdLajJvQlUyb05LNTB0MmtvTzBr?=
 =?utf-8?B?NDlwVmIxNWlpN092SWkrVnpVV2wza1I0dVVWZCtMNVlCaS9aVGs5TEpGZmZm?=
 =?utf-8?B?NnlkVkxzQXdnU3dsSjdrQjZkY1h6VU1JbWZqMzBGUkNZa0ZaNDhaM1ZNVGgr?=
 =?utf-8?B?VVJwSTZ2V0czNkJ6bTd2MFRoRFcwcFhmNlFhVVBXL1RUYkUwQUw2ZFltNEFF?=
 =?utf-8?B?YjlybVp3T2RXcDFqU2ZaTE9WajJyMmFNRW91Ukx4MndyakxQdDE0WmVPbGNP?=
 =?utf-8?B?S3Z1MlFRTDE3bkNlNWFZb2ZjamxEaDFyVU5EOG9EQ3dwdGNvTC9OUklnTGh1?=
 =?utf-8?B?V096SkFXNGtIeldsK0xpTXYyMzZBV1dxeXlIU2Q2aWtManJHUmsyaG9qMUc2?=
 =?utf-8?B?VmpuOEJYR1ZQVU91MmRDTVBRODRZZmdJNTE0LzNTVjdXT1hibWVIWGxZLysv?=
 =?utf-8?B?QmJVbFY5K0lvV21hRHBZbUFUN3NmRUpBcnovNEJuMkd5RTh3T0kxaHk5UWZR?=
 =?utf-8?B?VEUwUzUweXhDeXF6eGVuZWwzUHV4bGxuQXFYRDEycWx0ekd2b1BhRytnOVg2?=
 =?utf-8?B?SVJobGxBVHFGcHJ0bTg5VjkyZ0pqMkFVNWxUdGhLazFyS0l5elVJUGpSSmsv?=
 =?utf-8?B?VUJscENVSEYxd1F5VHRpUnBSZ0VRUk94R1p5TDdRQU0zT09IUlY5R3ZFRDBT?=
 =?utf-8?B?QUw1MWpJOStwL09JY0EycDR5aURsR0Y4M1FqSkRNS1FUZFBZR0JBeHBTWkc4?=
 =?utf-8?B?MDhwVkVpNTNVK2NRQkF3RkRzRFM5Y1AwZ05HMmtmb3hyT01ncXcxR2JPVzZM?=
 =?utf-8?B?aXZzTTVRaUpZTks1dEpBUkRoWGNWT1dXRWhweTI2SitEVnkrVVI4QjhNSU1S?=
 =?utf-8?B?SG9oVVl1UTQwcXVycXRzTUVobFo3YXVOTTZxK2Q2TUpXMDVvVlBqM0ZFaytF?=
 =?utf-8?B?WmtRZUorNEtsM1NkbktuRzY1RlVKazRRWFdIN040bHlHbVA5WkkyNGw4NzJU?=
 =?utf-8?B?azF1VVl6L0VzWDJTdkRPdmxHSEt3ZWlHWXhOUVNPem5CTjlraFN3WmpQcHVG?=
 =?utf-8?B?b25ELytoZlpJdnZhOWs2OEwrYk9YUHg4SzJGbWlwbFdpdmdyNjUwMTYrc0J0?=
 =?utf-8?B?cW95Q2lUV2plaGJXMzZFNGZQMHU4a01oMHpYaENndG8yTVZyRnArbGU3MjBo?=
 =?utf-8?B?R3FpR09jMDUrc242QStJV3JNTXUzN2FVMTRJSk5wQS9Vck1aaGRpajdKdVM2?=
 =?utf-8?B?akhqUHJlV29GZ1Rna0JwMjBTbHFPNjZBRUxIcDRUeXBCczA3NVB1RVZyZU1p?=
 =?utf-8?B?Q0R0b09wdm1jNEZqT1JDL2lTTnd4UFlmbW5xdXZTT1hNR25tdkZlKzF6a0Ez?=
 =?utf-8?B?OUEvVVdCZXdnWmZUbkdPbWZkWWlkU1VpczFHWS94RkNYMzkvMVZsRlVZWFRp?=
 =?utf-8?B?dW9xeW15VHZzMGp4eHFGZTgvVjd1eGczODkwUHhQemRzOUxIOWZSckxYcDI5?=
 =?utf-8?B?WGFVRy85TmlJbE5ZM2kzb2ZrRG5IWm1GcXNQazhQL3VxcC9YbWxvSHJYaSt6?=
 =?utf-8?B?VWJDVlNha2EvWnBOdHBjSGcrRjNaVk9IM25mUFNLckYvVDQvQU9wSW95YjJ6?=
 =?utf-8?B?OHFQMHNBQnNvRVVaQVVjcEh4b1FEVUwzQ2twT21jUFNiWXYyS0FiY0w4bWN1?=
 =?utf-8?B?SzkzR292UHhhUDN1NDFpdXVpbWVEaEhGMnZpL0lSVzJlbG82N3pDeS9acFVo?=
 =?utf-8?Q?QNaUCxsv2WMyZDeX5uEcBK7dv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IAiTaqE8b1djpteTTMepmrJUeXaGn5xmNik5ipMd1K30aXXyTjqpLZUBgocRzxZl6yLYV6T/B3JpNm/IqE4lR/AODX8s5Bzkbf81oU/TVvqUkHSji09Jf/8cBMmRHpYaS14IXAu3XbrqW+yOkBen5aGinDJiG8c7WV7muO6r1ErIkZWqpIqqAd1/mIbBmvBgswsjbWfk5kRTnLqZDu22k7oS4TwJtFnO+JPQFXkouU8El2EZg3A92wJIBM92vP5Yt9obW4m+maBfuVX+sLGTD2zSof6hBnewZhSnlYaDRgAKOSSK1MFYRishW5K29aBt0Wcwb38PPj9QtLZDEaSU3TTV7qyWod12MQp9fmlU8ppwyJ46u7JBAF+krfCLMGDs21dtlqgRjEuErupsdphfAmgit4qpoa1C5i5XazKYJBeVXfinUqPyU/t8Zb4bmlhfpbWn0BjAXlQmWjjHJl/0UHeYr7TBvtHKU2LiULFx33JbBFISwsfGu8YZTVuMPjct+5F83z1jUUKjIPrZ/H5rJxfCRIANTJtvvmQp+bmHY32zdJITQoGnV5L9nhVHYOGocdo6A5eDz0H9EKGlRRzti7IRT+L4ExDzsxaxL1AUXJ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0688c44c-a467-4962-efbd-08dcc44c9a59
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 14:54:08.1284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFfDutWOlyHUnoP8agTGKBn8Qy0xKtrFqrCq67/VB7oaC7HkgbosNb2p8k1M8yG2STxnAwU0FvnLyk1d/fEDMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-24_12,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408240092
X-Proofpoint-GUID: pxbJQuNfUtx35hVciUE51qENzmCVrLqB
X-Proofpoint-ORIG-GUID: pxbJQuNfUtx35hVciUE51qENzmCVrLqB

On Fri, Aug 23, 2024 at 08:53:02PM +0200, Petr Vorel wrote:
> 
> 
> > > On Aug 23, 2024, at 2:46 AM, Petr Vorel <pvorel@suse.cz> wrote:
> 
> > > Hi Chuck, Neil, all,
> 
> > >> On Wed, Aug 14, 2024 at 10:57:21AM +0200, Petr Vorel wrote:
> > >>> 6.9 moved client RPC calls to namespace in "Make nfs stats visible in
> > >>> network NS" patchet.
> 
> > >>> https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/
> 
> > >>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > >>> ---
> > >>> Changes v1->v2:
> > >>> * Point out whole patchset, not just single commit
> > >>> * Add a comment about the patchset
> 
> > >>> Hi all,
> 
> > >>> could you please ack this so that we have fixed mainline?
> 
> > >>> FYI Some parts has been backported, e.g.:
> > >>> d47151b79e322 ("nfs: expose /proc/net/sunrpc/nfs in net namespaces")
> > >>> to all stable/LTS: 5.4.276, 5.10.217, 5.15.159, 6.1.91, 6.6.31.
> 
> > >>> But most of that is not yet (but planned to be backported), e.g.
> > >>> 93483ac5fec62 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
> > >>> see Chuck's patchset for 6.6
> > >>> https://lore.kernel.org/linux-nfs/20240812223604.32592-1-cel@kernel.org/
> 
> > >>> Once all kernels up to 5.4 fixed we should update the version.
> 
> > >>> Kind regards,
> > >>> Petr
> 
> > >>> testcases/network/nfs/nfsstat01/nfsstat01.sh | 9 ++++++++-
> > >>> 1 file changed, 8 insertions(+), 1 deletion(-)
> 
> > >>> diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > >>> index c2856eff1f..1beecbec43 100755
> > >>> --- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > >>> +++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > >>> @@ -15,7 +15,14 @@ get_calls()
> > >>> local calls opt
> 
> > >>> [ "$name" = "rpc" ] && opt="r" || opt="n"
> > >>> - ! tst_net_use_netns && [ "$nfs_f" != "nfs" ] && type="rhost"
> > >>> +
> > >>> + if tst_net_use_netns; then
> > >>> + # "Make nfs stats visible in network NS" patchet
> > >>> + # https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/
> > >>> + tst_kvcmp -ge "6.9" && [ "$nfs_f" = "nfs" ] && type="rhost"
> 
> > >> Hello Petr-
> 
> > >> My concern with this fix is it targets v6.9 specifically, yet we
> > >> know these fixes will appear in LTS/stable kernels as well.
> 
> > > Great! I see you already fixed up to 5.15. I suppose the code is really
> > > backportable to the other still active branches (5.10, 5.4, 4.19).
> 
> > I plan to work on backporting to v5.10 next week.
> 
> > I've been asked to look at v5.4, but I'm not sure how difficult
> > that will be because it's missing a lot of NFSD patches. I will
> > look into that in a couple of weeks.
> 
> > I'm very likely to punt on v4.19, though Oracle's stable backport
> > team might try to tackle it at some point. (pun intended)
> 
> Thanks a lot for info, we'll see what you / your Oracle backport team will
> manage in the end.
> 
> > > We discussed in v1 how to fix tests.  Neil suggested to fix the test the way so
> > > that it works on all kernels. As I note [1]
> 
> > > 1) either we give up on checking the new functionality still works (if we
> > > fallback to old behavior)
> > > 2) or we need to specify from which kernel we expect new functionality
> > > (so far it's 5.15, I suppose it will be older).
> 
> > > I would prefer 2) to have new functionality always tested.
> > > Or am I missing something obvious?
> 
> > I don't quite understand the question.
> 
> > The "old functionality" of reporting these statistics globally
> > is broken, but we're stuck with it in the older kernels. I guess
> > you might want to confirm that, for a given recent kernel
> > release, the stats are actually per-namespace -- that's what we
> > expect in fixed kernels. Is that what you mean?
> 
> Yes. I'm just trying to say that Neil's proposal "work everywhere without
> checking kernel version" will not work. I would like next week, after you send
> 5.10 patches to expect anything >= 5.10 will have new functionality
> and update kernel version if more gets backported.

I wanted to be sure you were aware of Neil's suggestion, and it
sounds like it isn't workable for you. So, fair enough. I will get
to work on v5.10.y ;-)


> Kind regards,
> Petr
> 
> > > Kind regards,
> > > Petr
> 
> > > [1] https://lore.kernel.org/linux-nfs/172367387549.6062.7078032983644586462@noble.neil.brown.name/
> 
> > >> Neil Brown suggested an alternative approach that might not depend
> > >> on knowing the specific kernel version:
> 
> > >> https://lore.kernel.org/linux-nfs/172078283934.15471.13377048166707693692@noble.neil.brown.name/
> 
> > >> HTH
> 
> 
> > >>> + else
> > >>> + [ "$nfs_f" != "nfs" ] && type="rhost"
> > >>> + fi
> 
> > >>> if [ "$type" = "lhost" ]; then
> > >>> calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
> > >>> -- 
> > >>> 2.45.2

-- 
Chuck Lever

