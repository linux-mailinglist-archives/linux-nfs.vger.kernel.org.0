Return-Path: <linux-nfs+bounces-323-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C44498043D1
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 02:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EF51F21311
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 01:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1CCECF;
	Tue,  5 Dec 2023 01:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EKKtfiwC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vKP7eBB3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0543B113
	for <linux-nfs@vger.kernel.org>; Mon,  4 Dec 2023 17:14:11 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B51AlKA022166;
	Tue, 5 Dec 2023 01:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BAFEhLWe/L8eFhIBf//CCeQ7bLwxJtc5rNDuRxPtpPc=;
 b=EKKtfiwCMvShxxBrdD5ecvrBZ3wzzd7Y9Ee17c44CGzO/g/5dHO7WR9NppH5KSStNg+Y
 7Fzam080F1sfmDbBkhWGsaxVlpa8BCDK3n8IZo27mfMhCrHk5eMkzPPqjs4zxIEWoq+3
 zcme2s2NoDh3Qm7rjyWHBUgTU5NG12LyO7OasnAOJOkZSkQHmTLy1rAY86BURdBxhuZs
 Cb5NHim0TxCfY5mXmfO3+o3HJJYVzsgpzNPPaS3OPjs849iAyER4ASLWV7sNHy1G5ubN
 lJMpDmk4nQmxXOt86CoIzNRcgjQj124KymRD89Bm4PGNIqh0ieW7hTwQH67ulTlcPup9 kA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ussrv00br-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Dec 2023 01:11:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B50XmN8018516;
	Tue, 5 Dec 2023 01:06:02 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu16mryd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Dec 2023 01:06:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnBuaY2fVHliFmylhM0sl/+HBOBhNYaHBTPTFBv/+OA43eUnBROHYlC8mBKcfQ9bQmKK0efE241mKaIyA5NGVFo/1rqybGYofwLNBR9g8EflKrml77ApKoA3iKjvu2AN7lfqrhWkIZi+LCH8fQBw8Kqalu6H2pljxfDQ8goqzmd6TT+F2mWRSrtn1B1xbmzkleS7twIBKMPQ9qDepCk8zwkmd4KLjWgI1Kas7TmRm0/6D7D/fjk1XeXu0pXO4pJfL8fMqKJukyKa3ctnXr8OUJ+dmkjiBd3v3ny6cOrx88XWN1XYoK7dX/+bryNm/HJY9sMUgYbPSxHaPa4nvZI5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAFEhLWe/L8eFhIBf//CCeQ7bLwxJtc5rNDuRxPtpPc=;
 b=cAbpDYjtO0CRITQcQnrcozFHDtzsOAmOisMRtBlztiUdVxKv28fFJDumwtbNTTrRUb7A5Egxh+sNuLfaEdwkodITLVcsQAsghizZFZTnqJVvZwt5RQq6fJgLSLd2Z9fQx3fsX/1X7aMTdnvbl9R7jbPlZeW+3oyw0lI81S/5YaiNd6ZkwnyZ7LNt3gRIaK6SgHmwb1KqTDwHI3naEcZSrf+P71AUU+wYyXxYVgJEtOmcTsGsW0aXGx481WiwLfp4AJYfMAzV1HslnnURtRJh8ty8fcaczBN8tERv4krm6FEv4K5vO0PKHRgp6zk9eh9bXpmB1at+OXw3Zus3WB+ZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAFEhLWe/L8eFhIBf//CCeQ7bLwxJtc5rNDuRxPtpPc=;
 b=vKP7eBB3nrMWzu5PXwSyyTAsllAfRss5v4LwH7miWNJZXF/EntCMU/zDntrqGiOBMYExKTzF0ov36eQ/Rb2/YVT36lxc/rsTZY0Y1DfIhvbPODODIQODCj3u4Q21PJMfWkfYG00J9yvgc9Mli/nZdpDioQkJOJHLuIWreQmgRNE=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by IA1PR10MB6856.namprd10.prod.outlook.com (2603:10b6:208:423::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 01:05:58 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%6]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 01:05:58 +0000
Message-ID: <af0ec881-5ebf-4feb-98ae-3ed2a77f86f1@oracle.com>
Date: Mon, 4 Dec 2023 17:05:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: kernel v6.6.3: nfsd hangs in nfsd_break_deleg_cb
Content-Language: en-US
To: Wolfgang Walter <linux-nfs@stwm.de>
Cc: Chuck Lever <chuck.lever@oracle.com>,
        Linux Nfs <linux-nfs@vger.kernel.org>
References: <e3d43ecdad554fbdcaa7181833834f78@stwm.de>
 <ZW37M7DOavddVpFd@tissot.1015granger.net>
 <537b96d3-1d8a-4eaa-b271-e103f73e980d@oracle.com>
 <1d2ee7fb2014d837ba056e66e36c0e10@stwm.de>
From: dai.ngo@oracle.com
In-Reply-To: <1d2ee7fb2014d837ba056e66e36c0e10@stwm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:806:122::24) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|IA1PR10MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4c9d91-3d80-4ae9-65bb-08dbf52e5756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dUHp5sK0HOKcpeYyfsCGMGGS5xWSRmqwEtKCChVqA1hDB2criPv0RmvdoS644Lu8suOh6CQCAyPexOp8BgzgCKvRMQukc6MbFaYuk1WTaAW9SD/R+3fZspp38IqEPDIEzQctg9zsx6YkZ+BV+cAocUG5SrUx3bRM9iUtG8qJAu+qW9Coolz+1mpzSZYBql/DZi6xJL/4WvYmgAz8Etgs2VzWmcu4WelRXTe2SMYcjkPm4fFwBdrSyJRMg6OVaonUr6xZsWGmZMAVEI1o19KVe/qwf1gmrIwh3PGq0XvQBD9x9IZcgSgU7E/2hzx2DBiZqyHtGArfzWukI4bWIzik9AMulZby9+eyxujJhdF/BJ+K+6n6FUIue1Lj7ygiJYQZMEDvHHdTFZjxpZuReWkPo49HcDr4e/zxazxBTJwjEJyN96viRgNPjAX69meLHrQxiyupUoHb1RDIXae/y3E2O1Zt6iz+BBrAZFJQXECT59hjgXcUSmXXtzl99Q3xnOneOGm+PyIu7rcAyVn73osuTAvrSmzSKeGjTHdASuf2FOIop/tP2fxKRfktmVt93B0dHw9OVUfXYir/mdFGXw27ZvtBF4SKKY8JDsucBG6Myf1mPO5+8BLU22rZ2ZM8CEasqLu9KGXZ8c3dDGS6P7AGAFZrnvJJ3Yr/LO6hX3dtJ5E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(36756003)(86362001)(31696002)(2906002)(30864003)(5660300002)(41300700001)(9686003)(53546011)(6666004)(6506007)(6512007)(2616005)(26005)(31686004)(45080400002)(83380400001)(6486002)(478600001)(8936002)(8676002)(38100700002)(4326008)(6916009)(54906003)(66556008)(66476007)(316002)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WEVGQVNGYWVveDlwYnB4QmRjL2x2UC9nRnhUaG5wR1hsc2dmL2ROdzlKNXd6?=
 =?utf-8?B?SHpVL2JSS0x2SXlmV2lvd0hHM2FjZDBJY1g4cWc1SXRiYkxTSzZiWHFlaWhB?=
 =?utf-8?B?RFFjQWFRK1o1NUJVcEpQVlBISEE1UHZnYXJpYUo5T3hReFRocHVnb1M3ZDhy?=
 =?utf-8?B?M1A3YWM1NWd4TEg3cGRxZ1MwQS82UmhoZnlNZ0ZUNlJYdThYcjVleHFvSm5C?=
 =?utf-8?B?TmdnUDM0Y3dMTUpyWUpQVFZGU0pkN2JSVnUydFRkaC8ycnFZU3dEa1RqNmd0?=
 =?utf-8?B?YnV4TCtWWkErK0oxRHF1Yi9Fb1dCSGZTUmJ0SU1lNTZlM0l4aXczU0NBMTkz?=
 =?utf-8?B?UGg0TWNjM21lamdXdmdzUjB3UlNpWm5qcHR6aVY1YVR2ZnIvb2RlbFZNbXBC?=
 =?utf-8?B?bVM5KzFRU2lVWWZ4ZHlDWjE0UFp0NCtnb1FDYVc2cnVieXZnQ3MzWkdaQlpn?=
 =?utf-8?B?ZmxmUncyenNlOTVDMlRzMWV1RmFnSldqVlh1YTNvd3cveHVWWlFDT2R1eWRz?=
 =?utf-8?B?RXQ4SVpFRnBWZDBtRjlFWVFHWTdMSTcyQnEzT2xYTjU5d0FRSlkxUXBjem5L?=
 =?utf-8?B?d0VpTi84dDJ3WjU3TWh1QkI0LzVEcU9RdnFJVXppaTBieDg0Ym9TemN6VVRu?=
 =?utf-8?B?VU9lRjhlWldlaUFKYzFlRWhKQ2hZTGJ1elpRWFlieWZJRFdBbThVeWUyMVp4?=
 =?utf-8?B?c2dJSG8zdmFtNjllcXBZaCtjTWdsdmNmQTNYbHZKV1JzSEdhMFdKcTQvdXQz?=
 =?utf-8?B?WmVlVGl3THBiNjRNeWNFd0dlZHUvellkQm9tYkk5TmFJZU9LY2pqWnowS2dx?=
 =?utf-8?B?VDhCdXd5SG1mRUlpbVhqd1BvNFhmRVBJY2ZtN1hpU1JrdW9rMmZBdUNpQUYr?=
 =?utf-8?B?dHB2N0FQbld1TXRnQ3crVlM0S2hIeWorTkRUMmNQOW4vL2p4ZzQvOEZISmg2?=
 =?utf-8?B?T1o2U0V1SVVTOHlValZFU1I1SjNpT3drRGNRbW1MRFRLcGpDWUhXWG10Y0pp?=
 =?utf-8?B?cXBPM2paTVBHODZwdFprbGNlcmEwSlNvMWVDN0pJbUNRMm9IMFptcXBrQk1a?=
 =?utf-8?B?VGJRQm1TWUVzTzJjOG10cnlWWGlXZVFaeDdWR2RCSHE4K1ZLRzhaOEszYlgy?=
 =?utf-8?B?aUVkV3YzQUxob3Vic04wc0dIKzM5Sm1iTnRudThlNVRMdnBzZG1oYUFRWEpL?=
 =?utf-8?B?WDA3N0lCT3JjbFdpcmRCckQ1ZkdqRWl2WjJSZy9Wb2doaUJqQjdHazhPYk15?=
 =?utf-8?B?aHF4N21RUVRXUW0vSmtacWVUek9TS0ZQWVF5T2FHdUVtL28wd1JNQ1gxaWMy?=
 =?utf-8?B?bVMwUStrLzNwbnNqY0FZWFZieklMcUp2UXV0YnRkaFYzQi9iSDRBMkxNcFNy?=
 =?utf-8?B?cUh1a0labzhNc1RjeUlEdndVUnA0N2J0NmRnem16RWFraW8zeTRzcTJrWDFK?=
 =?utf-8?B?UXI1WHB0OWNWMDhjZzVrSUtCU0xENVR6Z1V4ODJzOVBoejU0WlQ2U2NSNCtO?=
 =?utf-8?B?U3o1VXkzd2g1bHArYWdoT0lSa2NLUzRhcW1FV1QyS0Z5aEJEMkxVaThyUlp3?=
 =?utf-8?B?Ti9hb1ZLSjZpN1pQcFBnQUhrQzY2NTdEa21sbW1weDdUdUZxNVc5dCt2NGhC?=
 =?utf-8?B?c3NmMUtQWERwSU9HbHQ3Z3V2S1A2Smk3TUErVXozUHlhOFpPRjAyWGpmSnZm?=
 =?utf-8?B?c2piTmFDMlRsKzh3L0RKSmxneEZ6WU1zTXI3MC9OQzlDN29XQnpqcCs2eGxw?=
 =?utf-8?B?d0VWMDNISElUUUFCU1B6eWhkc2VtUGtOV1JkNjkrU1BpU2x5YTBwWkRlelhh?=
 =?utf-8?B?WVFBY3JsM0xrNHVYUlFJR0taUW1iclpYME5IYVd1WjB4eFpBMDJTZWdBbFE4?=
 =?utf-8?B?MGE4c0xkQVpRc09TOTB1ckljMmFvaUppQUo0dXdsUVJXc2pmYk90UFpwNkcx?=
 =?utf-8?B?QUlZNVpwYTR0SVcxV3FlWUdkQVhwSk9YejF5MTV1bG5mVjd2QVk5amJieVVl?=
 =?utf-8?B?czFTNFk5bERUVUVBVlRhdzI2QnVEYmdqOVh1Skl1UUZkUlNOQTdiKy80Nk9E?=
 =?utf-8?B?TGIyWVdrRkZBSVJnellFN2NlcTI3em5VQTVWYjd3dXptaFdJbVkzMC84Wm13?=
 =?utf-8?Q?jGebyyexPAz8pWEsxkAqjJvK9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2dPumFXPnxP+Gvz4ZZ46TVjW7JxYDqnDe+5pmmgmzQF5javuCOo839qYq63HDp39eHb1daVeHI++hGA3kBJLI5mF28H7dtXx1cyWFE+8tvd1XeFdAcxYkcOQk19aR/OCtZz4RGDgiJe9ZhNPUPhDjYugwVz5vP4qBVXBxTEzhb0oMgamTvwYU7+DIR8KDnPH6lWopWhB+U0WKMsS1KqwxD55n3M0+vvwBwd8Ei1aEju3BogvKrUcr16c1VqgGpA93d4sb62dxO7RAbyDPjKSjoGwF6hciit7Q8WymiShSP+C9obFzGkfWCgQwNwNsZUoJcL5G+B6LmnbB/5H0lyU/Ylbu/T/RQcoIRkC91wHHW8Md6dgFNOOPbuFYIU1effBX0eaEQbKTG9c/y2vkchdhJ2w6TpQZoxH/CThuxKgbi/CHBiuZzwDigxkG6cJ/aPiiL91KSrW8lG7cK0pUz4o9timlYCQnXS/cu2/WTGDRT7oE+R3iZtmORRDrW0cluo4sTe3jUcAwS+kKUF8RsaCO6Dh272ICSq0ds0+5qz8aT//ygl/YL3XKqM/XbTAcZ6hRj3Q7itQoaa4fVEv6GYDm19BRp80FrESOeds8c+VRg6fjb4t+VKd+qDPiTx0NwkZJTrJkJN22csZRMAbzbTroVQoVrmura0tCuxifDHH8W/NGJlIfwvs0jLd5wgkVyVG7D1iX18jkdk8GjBJ7pBYPTMc48QopRPsJPJLOD+XB9AHSd3ewAe1IRW17LSiJFmWQMDtscR+uS0Bdk5bDDSPSduMBPV+hHFveYQSJWd3bFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4c9d91-3d80-4ae9-65bb-08dbf52e5756
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 01:05:58.7468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuzREMGB7j/cym2TrGREAXOAockL3AoNuVgkAiOviiOf/bVZ8zfRniXE3LTP2ey7FYl/MO2UpISEOrUVLh5nZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_24,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050008
X-Proofpoint-GUID: 57pXWsE-EbGcEeK_Y4lieIbtCkAxByyv
X-Proofpoint-ORIG-GUID: 57pXWsE-EbGcEeK_Y4lieIbtCkAxByyv


On 12/4/23 1:10 PM, Wolfgang Walter wrote:
> Am 2023-12-04 20:12, schrieb dai.ngo@oracle.com:
>> On 12/4/23 8:15 AM, Chuck Lever wrote:
>>> On Mon, Dec 04, 2023 at 04:34:00PM +0100, Wolfgang Walter wrote:
>>>> Hello,
>>>>
>>>> after upgrading from stable 6.1.63 to stable 6.6.3 our nfs-server 
>>>> logged a
>>>> WARNING and then more and more clients hanged:
>>>>
>>>>
>>>> Dec 04 14:59:25 engel kernel: ------------[ cut here ]------------
>>>> Dec 04 14:59:25 engel kernel: WARNING: CPU: 17 PID: 8431 at
>>>> fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x174/0x190 [nfsd]
>>>> Dec 04 14:59:25 engel kernel: Modules linked in: cts 
>>>> rpcsec_gss_krb5 msr
>>>> 8021q garp stp mrp llc binfmt_misc intel_rapl_msr intel_rapl_common 
>>>> sb_edac
>>>> x86_pkg_temp_thermal intel_powerclamp coretemp kv>
>>>> Dec 04 14:59:25 engel kernel:  enclosure sd_mod usbhid t10_pi hid
>>>> crc64_rocksoft crc64 crc_t10dif crct10dif_generic ixgbe ahci xfrm_algo
>>>> xhci_pci libahci dca mdio_devres mpt3sas ehci_pci crct10dif_p>
>>>> Dec 04 14:59:25 engel kernel: CPU: 17 PID: 8431 Comm: nfsd Not tainted
>>>> 6.6.3-debian64.all+1.2 #1
>>>> Dec 04 14:59:25 engel kernel: Hardware name: Supermicro 
>>>> X10DRi/X10DRI-T,
>>>> BIOS 1.1a 10/16/2015
>>>> Dec 04 14:59:25 engel kernel: RIP: 
>>>> 0010:nfsd_break_deleg_cb+0x174/0x190
>>>> [nfsd]
>>>> Dec 04 14:59:25 engel kernel: Code: 02 8c a4 c2 e9 ff fe ff ff 48 
>>>> 89 df be
>>>> 01 00 00 00 e8 70 7c ed c2 48 8d bb 98 00 00 00 e8 b4 0e 01 00 84 
>>>> c0 0f 85
>>>> 2e ff ff ff <0f> 0b e9 27 ff ff ff be 02 00 00 0>
>>>> Dec 04 14:59:25 engel kernel: RSP: 0018:ffffbd57227c7a98 EFLAGS: 
>>>> 00010246
>>>> Dec 04 14:59:25 engel kernel: RAX: 0000000000000000 RBX: 
>>>> ffff94a77356e200
>>>> RCX: 0000000000000000
>>>> Dec 04 14:59:25 engel kernel: RDX: ffff94a77356e2c8 RSI: 
>>>> ffff94b78cf58000
>>>> RDI: 0000000000002000
>>>> Dec 04 14:59:25 engel kernel: RBP: ffff94a0392b3a34 R08: 
>>>> ffffbd57227c7a80
>>>> R09: 0000000000000000
>>>> Dec 04 14:59:25 engel kernel: R10: ffff94a05f4a9440 R11: 
>>>> 0000000000000000
>>>> R12: ffff94b8e3995b00
>>>> Dec 04 14:59:25 engel kernel: R13: ffff94a0392b3a20 R14: 
>>>> ffff94b8e3995b00
>>>> R15: 000000010eb733cd
>>>> Dec 04 14:59:25 engel kernel: FS:  0000000000000000(0000)
>>>> GS:ffff94b71fcc0000(0000) knlGS:0000000000000000
>>>> Dec 04 14:59:25 engel kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>>>> 0000000080050033
>>>> Dec 04 14:59:25 engel kernel: CR2: 00007f9ef8554000 CR3: 
>>>> 000000295e020003
>>>> CR4: 00000000001706e0
>>>> Dec 04 14:59:25 engel kernel: Call Trace:
>>>> Dec 04 14:59:25 engel kernel:  <TASK>
>>>> Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x174/0x190 
>>>> [nfsd]
>>>> Dec 04 14:59:25 engel kernel:  ? __warn+0x81/0x130
>>>> Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x174/0x190 
>>>> [nfsd]
>>>> Dec 04 14:59:25 engel kernel:  ? report_bug+0x171/0x1a0
>>>> Dec 04 14:59:25 engel kernel:  ? handle_bug+0x3c/0x80
>>>> Dec 04 14:59:25 engel kernel:  ? exc_invalid_op+0x17/0x70
>>>> Dec 04 14:59:25 engel kernel:  ? asm_exc_invalid_op+0x1a/0x20
>>>> Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x174/0x190 
>>>> [nfsd]
>>>> Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x9a/0x190 [nfsd]
>>>> Dec 04 14:59:25 engel kernel:  __break_lease+0x25c/0x720
>>>> Dec 04 14:59:25 engel kernel:  __nfsd_open.isra.0+0xa9/0x1a0 [nfsd]
>>>> Dec 04 14:59:25 engel kernel: nfsd_file_do_acquire+0x4ca/0xc50 [nfsd]
>>>> Dec 04 14:59:25 engel kernel:  nfs4_get_vfs_file+0x34c/0x3b0 [nfsd]
>>>> Dec 04 14:59:25 engel kernel: nfsd4_process_open2+0x42c/0x15d0 [nfsd]
>>>> Dec 04 14:59:25 engel kernel:  ? nfsd_permission+0x63/0x100 [nfsd]
>>>> Dec 04 14:59:25 engel kernel:  ? fh_verify+0x42e/0x720 [nfsd]
>>>> Dec 04 14:59:25 engel kernel:  nfsd4_open+0x64a/0xc40 [nfsd]
>>>> Dec 04 14:59:25 engel kernel:  ? nfsd4_encode_operation+0xa7/0x2b0 
>>>> [nfsd]
>>>> Dec 04 14:59:25 engel kernel: nfsd4_proc_compound+0x351/0x670 [nfsd]
>>>> Dec 04 14:59:25 engel kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>> Dec 04 14:59:25 engel kernel:  nfsd_dispatch+0x7c/0x1b0 [nfsd]
>>>> Dec 04 14:59:25 engel kernel: svc_process_common+0x431/0x6e0 [sunrpc]
>>>> Dec 04 14:59:25 engel kernel:  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>> Dec 04 14:59:25 engel kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>> Dec 04 14:59:25 engel kernel:  svc_process+0x131/0x180 [sunrpc]
>>>> Dec 04 14:59:25 engel kernel:  nfsd+0x84/0xd0 [nfsd]
>>>> Dec 04 14:59:25 engel kernel:  kthread+0xe5/0x120
>>>> Dec 04 14:59:25 engel kernel:  ? __pfx_kthread+0x10/0x10
>>>> Dec 04 14:59:25 engel kernel:  ret_from_fork+0x31/0x50
>>>> Dec 04 14:59:25 engel kernel:  ? __pfx_kthread+0x10/0x10
>>>> Dec 04 14:59:25 engel kernel:  ret_from_fork_asm+0x1b/0x30
>>>> Dec 04 14:59:25 engel kernel:  </TASK>
>>>> Dec 04 14:59:25 engel kernel: ---[ end trace 0000000000000000 ]---
>>>>
>>>>
>>>> 6.1. did not show such a problem.
>>>>
>>>> Both are vanilla stable kernels (self-built).
>>> Thank you for your report.
>>>
>>> If you are able to bisect your server between v6.1 and v6.6, that
>>> would help us narrow down the cause.
>>>
>>> Dai, can you have a look at this?
>>
>> The warning message indicates the callback work was not queued since
>> it was already queued. In this case we'll have taken an extra reference
>> to the stid that will never be put (see b95239ca4954a0), we should fix
>> this but I don't think this extra reference causing the client to hang.
>>
>> It's hard to say what the root cause is without a core dump and/or some
>> network trace or a way to reproduce the problem. As Chuck mentioned, 
>> it's
>> best to bisect the server to help us narrow down the cause.
>>
>> Wolfgang, could you provide some additional info such as how often this
>> problem happens, under load?, problem reproducible?, number of clients
>> involved, type of NFS activities, etc.
>
> I cannot reproduce it on our test server. Our fileserver run the new 
> kernel since friday, 2023-12-01. The problem occurred today.
>
> * number of clients: about 300 to 400.
> * we use kerberos krb5p
> * only nfs4
>
> I only saw it once (today), but we used 6.1 till friday. I downgraded 
> the server to 6.1. I think I cannot bisect the problem as I cannot 
> reproduce it on the testserver. I think load and a lot of clients are 
> needed - which means I there are a lot of our employees are affected.
>
> One symptom was that new clients couldn't connect and more and more 
> clients seem to hang.
>
> The server did not crash, you could still login. When rebooting nfsd 
> could not be stopped, though.
>
>
> I overlooked earlier log entries:
>
> Dec  4 11:42:27 engel kernel: [235320.039490] receive_cb_reply: Got 
> unrecognized reply: calldir 0x1 xpt_bc_xprt 000000005d610da5 xid 752a73b9
> Dec  4 11:43:23 engel kernel: [235376.870705] receive_cb_reply: Got 
> unrecognized reply: calldir 0x1 xpt_bc_xprt 000000005d610da5 xid 7d2a73b9
> Dec  4 13:55:15 engel kernel: [243288.670210] receive_cb_reply: Got 
> unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000ca358149 xid f1cc71b6
> Dec  4 13:55:15 engel kernel: [243288.670788] receive_cb_reply: Got 
> unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000ca358149 xid f2cc71b6
>
> Dec  4 13:57:29 engel kernel: [243421.785082] INFO: task nfsd:8491 
> blocked for more than 122 seconds.
> Dec  4 13:57:29 engel kernel: [243421.785104]       Not tainted 
> 6.6.3-debian64.all+1.2 #1
> Dec  4 13:57:29 engel kernel: [243421.785113] "echo 0 > 
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Dec  4 13:57:29 engel kernel: [243421.785125] task:nfsd state:D 
> stack:0     pid:8491  ppid:2      flags:0x00004000
> Dec  4 13:57:29 engel kernel: [243421.785130] Call Trace:
> Dec  4 13:57:29 engel kernel: [243421.785132]  <TASK>
> Dec  4 13:57:29 engel kernel: [243421.785136] __schedule+0x3b8/0xb00
> Dec  4 13:57:29 engel kernel: [243421.785146]  schedule+0x5e/0xd0
> Dec  4 13:57:29 engel kernel: [243421.785148] 
> schedule_timeout+0x147/0x160
> Dec  4 13:57:29 engel kernel: [243421.785155]  ? 
> __pfx_sha512_transform_rorx+0x10/0x10 [sha512_ssse3]
> Dec  4 13:57:29 engel kernel: [243421.785162] 
> wait_for_completion+0x8a/0x160
> Dec  4 13:57:29 engel kernel: [243421.785166] 
> __flush_workqueue+0x140/0x410
> Dec  4 13:57:29 engel kernel: [243421.785174] 
> nfsd4_create_session+0x847/0xd30 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.785288] 
> nfsd4_proc_compound+0x351/0x670 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.785334]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.785373] nfsd_dispatch+0x7c/0x1b0 
> [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.785415] 
> svc_process_common+0x431/0x6e0 [sunrpc]
> Dec  4 13:57:29 engel kernel: [243421.785492]  ? 
> __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.785534]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.785572] svc_process+0x131/0x180 
> [sunrpc]
> Dec  4 13:57:29 engel kernel: [243421.785630]  nfsd+0x84/0xd0 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.785672]  kthread+0xe5/0x120
> Dec  4 13:57:29 engel kernel: [243421.785675]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:57:29 engel kernel: [243421.785677] ret_from_fork+0x31/0x50
> Dec  4 13:57:29 engel kernel: [243421.785682]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:57:29 engel kernel: [243421.785683] ret_from_fork_asm+0x1b/0x30
> Dec  4 13:57:29 engel kernel: [243421.785689]  </TASK>
> Dec  4 13:57:29 engel kernel: [243421.785690] INFO: task nfsd:8493 
> blocked for more than 122 seconds.
> Dec  4 13:57:29 engel kernel: [243421.785699]       Not tainted 
> 6.6.3-debian64.all+1.2 #1
> Dec  4 13:57:29 engel kernel: [243421.785708] "echo 0 > 
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Dec  4 13:57:29 engel kernel: [243421.785718] task:nfsd state:D 
> stack:0     pid:8493  ppid:2      flags:0x00004000
> Dec  4 13:57:29 engel kernel: [243421.785720] Call Trace:
> Dec  4 13:57:29 engel kernel: [243421.785721]  <TASK>
> Dec  4 13:57:29 engel kernel: [243421.785722] __schedule+0x3b8/0xb00
> Dec  4 13:57:29 engel kernel: [243421.785726]  schedule+0x5e/0xd0
> Dec  4 13:57:29 engel kernel: [243421.785727] 
> schedule_timeout+0x147/0x160
> Dec  4 13:57:29 engel kernel: [243421.785729] 
> wait_for_completion+0x8a/0x160
> Dec  4 13:57:29 engel kernel: [243421.785732] 
> __flush_workqueue+0x140/0x410
> Dec  4 13:57:29 engel kernel: [243421.785735] 
> nfsd4_create_session+0x847/0xd30 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.785801] 
> nfsd4_proc_compound+0x351/0x670 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.785848]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.785889] nfsd_dispatch+0x7c/0x1b0 
> [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.785934] 
> svc_process_common+0x431/0x6e0 [sunrpc]
> Dec  4 13:57:29 engel kernel: [243421.785998]  ? 
> __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.786045]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.786089] svc_process+0x131/0x180 
> [sunrpc]
> Dec  4 13:57:29 engel kernel: [243421.786152]  nfsd+0x84/0xd0 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.786198]  kthread+0xe5/0x120
> Dec  4 13:57:29 engel kernel: [243421.786200]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:57:29 engel kernel: [243421.786202] ret_from_fork+0x31/0x50
> Dec  4 13:57:29 engel kernel: [243421.786217]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:57:29 engel kernel: [243421.786219] ret_from_fork_asm+0x1b/0x30
> Dec  4 13:57:29 engel kernel: [243421.786223]  </TASK>
> Dec  4 13:57:29 engel kernel: [243421.786224] INFO: task nfsd:8494 
> blocked for more than 122 seconds.
> Dec  4 13:57:29 engel kernel: [243421.786234]       Not tainted 
> 6.6.3-debian64.all+1.2 #1
> Dec  4 13:57:29 engel kernel: [243421.786242] "echo 0 > 
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Dec  4 13:57:29 engel kernel: [243421.786252] task:nfsd state:D 
> stack:0     pid:8494  ppid:2      flags:0x00004000
> Dec  4 13:57:29 engel kernel: [243421.786255] Call Trace:
> Dec  4 13:57:29 engel kernel: [243421.786256]  <TASK>
> Dec  4 13:57:29 engel kernel: [243421.786268] __schedule+0x3b8/0xb00
> Dec  4 13:57:29 engel kernel: [243421.786271]  schedule+0x5e/0xd0
> Dec  4 13:57:29 engel kernel: [243421.786272] 
> schedule_timeout+0x147/0x160
> Dec  4 13:57:29 engel kernel: [243421.786274]  ? 
> __pfx_sha512_transform_rorx+0x10/0x10 [sha512_ssse3]
> Dec  4 13:57:29 engel kernel: [243421.786291] 
> wait_for_completion+0x8a/0x160
> Dec  4 13:57:29 engel kernel: [243421.786294] 
> __flush_workqueue+0x140/0x410
> Dec  4 13:57:29 engel kernel: [243421.786308] 
> nfsd4_create_session+0x847/0xd30 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.786352] 
> nfsd4_proc_compound+0x351/0x670 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.786391]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.786427] nfsd_dispatch+0x7c/0x1b0 
> [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.786463] 
> svc_process_common+0x431/0x6e0 [sunrpc]
> Dec  4 13:57:29 engel kernel: [243421.786516]  ? 
> __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.786554]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.786589] svc_process+0x131/0x180 
> [sunrpc]
> Dec  4 13:57:29 engel kernel: [243421.786641]  nfsd+0x84/0xd0 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.786679]  kthread+0xe5/0x120
> Dec  4 13:57:29 engel kernel: [243421.786681]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:57:29 engel kernel: [243421.786682] ret_from_fork+0x31/0x50
> Dec  4 13:57:29 engel kernel: [243421.786685]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:57:29 engel kernel: [243421.786686] ret_from_fork_asm+0x1b/0x30
> Dec  4 13:57:29 engel kernel: [243421.786690]  </TASK>
> Dec  4 13:57:29 engel kernel: [243421.786690] INFO: task nfsd:8495 
> blocked for more than 122 seconds.
> Dec  4 13:57:29 engel kernel: [243421.786699]       Not tainted 
> 6.6.3-debian64.all+1.2 #1
> Dec  4 13:57:29 engel kernel: [243421.786707] "echo 0 > 
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Dec  4 13:57:29 engel kernel: [243421.786716] task:nfsd state:D 
> stack:0     pid:8495  ppid:2      flags:0x00004000
> Dec  4 13:57:29 engel kernel: [243421.786718] Call Trace:
> Dec  4 13:57:29 engel kernel: [243421.786719]  <TASK>
> Dec  4 13:57:29 engel kernel: [243421.786720] __schedule+0x3b8/0xb00
> Dec  4 13:57:29 engel kernel: [243421.786722]  schedule+0x5e/0xd0
> Dec  4 13:57:29 engel kernel: [243421.786724] 
> schedule_timeout+0x147/0x160
> Dec  4 13:57:29 engel kernel: [243421.786726] 
> wait_for_completion+0x8a/0x160
> Dec  4 13:57:29 engel kernel: [243421.786728] 
> __flush_workqueue+0x140/0x410
> Dec  4 13:57:29 engel kernel: [243421.786731] 
> nfsd4_create_session+0x847/0xd30 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.786778] 
> nfsd4_proc_compound+0x351/0x670 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.786844]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.786893] nfsd_dispatch+0x7c/0x1b0 
> [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.786931] 
> svc_process_common+0x431/0x6e0 [sunrpc]
> Dec  4 13:57:29 engel kernel: [243421.786986]  ? 
> __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.787024]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.787060] svc_process+0x131/0x180 
> [sunrpc]
> Dec  4 13:57:29 engel kernel: [243421.787125]  nfsd+0x84/0xd0 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.787172]  kthread+0xe5/0x120
> Dec  4 13:57:29 engel kernel: [243421.787174]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:57:29 engel kernel: [243421.787175] ret_from_fork+0x31/0x50
> Dec  4 13:57:29 engel kernel: [243421.787177]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:57:29 engel kernel: [243421.787179] ret_from_fork_asm+0x1b/0x30
> Dec  4 13:57:29 engel kernel: [243421.787182]  </TASK>
> Dec  4 13:57:29 engel kernel: [243421.787183] INFO: task nfsd:8496 
> blocked for more than 122 seconds.
> Dec  4 13:57:29 engel kernel: [243421.787192]       Not tainted 
> 6.6.3-debian64.all+1.2 #1
> Dec  4 13:57:29 engel kernel: [243421.787199] "echo 0 > 
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Dec  4 13:57:29 engel kernel: [243421.787208] task:nfsd state:D 
> stack:0     pid:8496  ppid:2      flags:0x00004000
> Dec  4 13:57:29 engel kernel: [243421.787210] Call Trace:
> Dec  4 13:57:29 engel kernel: [243421.787211]  <TASK>
> Dec  4 13:57:29 engel kernel: [243421.787212] __schedule+0x3b8/0xb00
> Dec  4 13:57:29 engel kernel: [243421.787215]  schedule+0x5e/0xd0
> Dec  4 13:57:29 engel kernel: [243421.787216] 
> schedule_timeout+0x147/0x160
> Dec  4 13:57:29 engel kernel: [243421.787218]  ? 
> sched_clock_cpu+0xf/0x190
> Dec  4 13:57:29 engel kernel: [243421.787223]  ? 
> __smp_call_single_queue+0xad/0x120
> Dec  4 13:57:29 engel kernel: [243421.787226]  ? 
> ttwu_queue_wakelist+0xef/0x110
> Dec  4 13:57:29 engel kernel: [243421.787229] 
> wait_for_completion+0x8a/0x160
> Dec  4 13:57:29 engel kernel: [243421.787231] 
> __flush_workqueue+0x140/0x410
> Dec  4 13:57:29 engel kernel: [243421.787233]  ? kick_pool+0x5d/0xc0
> Dec  4 13:57:29 engel kernel: [243421.787236] 
> nfsd4_destroy_session+0x1c3/0x280 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.787275] 
> nfsd4_proc_compound+0x351/0x670 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.787310]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.787342] nfsd_dispatch+0x7c/0x1b0 
> [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.787374] 
> svc_process_common+0x431/0x6e0 [sunrpc]
> Dec  4 13:57:29 engel kernel: [243421.787421]  ? 
> __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.787455]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.787487] svc_process+0x131/0x180 
> [sunrpc]
> Dec  4 13:57:29 engel kernel: [243421.787534]  nfsd+0x84/0xd0 [nfsd]
> Dec  4 13:57:29 engel kernel: [243421.787567]  kthread+0xe5/0x120
> Dec  4 13:57:29 engel kernel: [243421.787569]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:57:29 engel kernel: [243421.787570] ret_from_fork+0x31/0x50
> Dec  4 13:57:29 engel kernel: [243421.787573]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:57:29 engel kernel: [243421.787574] ret_from_fork_asm+0x1b/0x30
> Dec  4 13:57:29 engel kernel: [243421.787577]  </TASK>
> Dec  4 13:59:31 engel kernel: [243544.662855] INFO: task nfsd:8488 
> blocked for more than 122 seconds.
> Dec  4 13:59:31 engel kernel: [243544.662880]       Not tainted 
> 6.6.3-debian64.all+1.2 #1
> Dec  4 13:59:31 engel kernel: [243544.662890] "echo 0 > 
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Dec  4 13:59:31 engel kernel: [243544.662902] task:nfsd state:D 
> stack:0     pid:8488  ppid:2      flags:0x00004000
> Dec  4 13:59:31 engel kernel: [243544.662907] Call Trace:
> Dec  4 13:59:31 engel kernel: [243544.662909]  <TASK>
> Dec  4 13:59:31 engel kernel: [243544.662913] __schedule+0x3b8/0xb00
> Dec  4 13:59:31 engel kernel: [243544.662933]  schedule+0x5e/0xd0
> Dec  4 13:59:31 engel kernel: [243544.662935] 
> schedule_timeout+0x147/0x160
> Dec  4 13:59:31 engel kernel: [243544.662939]  ? getboottime64+0x24/0x40
> Dec  4 13:59:31 engel kernel: [243544.662943] 
> wait_for_completion+0x8a/0x160
> Dec  4 13:59:31 engel kernel: [243544.662958] 
> __flush_workqueue+0x140/0x410
> Dec  4 13:59:31 engel kernel: [243544.662965] 
> nfsd4_destroy_session+0x1c3/0x280 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.663069] 
> nfsd4_proc_compound+0x351/0x670 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.663126]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.663164] nfsd_dispatch+0x7c/0x1b0 
> [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.663208] 
> svc_process_common+0x431/0x6e0 [sunrpc]
> Dec  4 13:59:31 engel kernel: [243544.663273]  ? 
> __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.663325]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.663362] svc_process+0x131/0x180 
> [sunrpc]
> Dec  4 13:59:31 engel kernel: [243544.663414]  nfsd+0x84/0xd0 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.663496]  kthread+0xe5/0x120
> Dec  4 13:59:31 engel kernel: [243544.663500]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:59:31 engel kernel: [243544.663502] ret_from_fork+0x31/0x50
> Dec  4 13:59:31 engel kernel: [243544.663507]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:59:31 engel kernel: [243544.663509] ret_from_fork_asm+0x1b/0x30
> Dec  4 13:59:31 engel kernel: [243544.663516]  </TASK>
> Dec  4 13:59:31 engel kernel: [243544.663517] INFO: task nfsd:8491 
> blocked for more than 245 seconds.
> Dec  4 13:59:31 engel kernel: [243544.663528]       Not tainted 
> 6.6.3-debian64.all+1.2 #1
> Dec  4 13:59:31 engel kernel: [243544.663536] "echo 0 > 
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Dec  4 13:59:31 engel kernel: [243544.663547] task:nfsd state:D 
> stack:0     pid:8491  ppid:2      flags:0x00004000
> Dec  4 13:59:31 engel kernel: [243544.663549] Call Trace:
> Dec  4 13:59:31 engel kernel: [243544.663550]  <TASK>
> Dec  4 13:59:31 engel kernel: [243544.663551] __schedule+0x3b8/0xb00
> Dec  4 13:59:31 engel kernel: [243544.663554]  schedule+0x5e/0xd0
> Dec  4 13:59:31 engel kernel: [243544.663556] 
> schedule_timeout+0x147/0x160
> Dec  4 13:59:31 engel kernel: [243544.663560]  ? 
> __pfx_sha512_transform_rorx+0x10/0x10 [sha512_ssse3]
> Dec  4 13:59:31 engel kernel: [243544.663566] 
> wait_for_completion+0x8a/0x160
> Dec  4 13:59:31 engel kernel: [243544.663569] 
> __flush_workqueue+0x140/0x410
> Dec  4 13:59:31 engel kernel: [243544.663573] 
> nfsd4_create_session+0x847/0xd30 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.663642] 
> nfsd4_proc_compound+0x351/0x670 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.663689]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.663744] nfsd_dispatch+0x7c/0x1b0 
> [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.663806] 
> svc_process_common+0x431/0x6e0 [sunrpc]
> Dec  4 13:59:31 engel kernel: [243544.663877]  ? 
> __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.663918]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.663957] svc_process+0x131/0x180 
> [sunrpc]
> Dec  4 13:59:31 engel kernel: [243544.664013]  nfsd+0x84/0xd0 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.664053]  kthread+0xe5/0x120
> Dec  4 13:59:31 engel kernel: [243544.664055]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:59:31 engel kernel: [243544.664057] ret_from_fork+0x31/0x50
> Dec  4 13:59:31 engel kernel: [243544.664060]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:59:31 engel kernel: [243544.664061] ret_from_fork_asm+0x1b/0x30
> Dec  4 13:59:31 engel kernel: [243544.664065]  </TASK>
> Dec  4 13:59:31 engel kernel: [243544.664066] INFO: task nfsd:8493 
> blocked for more than 245 seconds.
> Dec  4 13:59:31 engel kernel: [243544.664078]       Not tainted 
> 6.6.3-debian64.all+1.2 #1
> Dec  4 13:59:31 engel kernel: [243544.664087] "echo 0 > 
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Dec  4 13:59:31 engel kernel: [243544.664098] task:nfsd state:D 
> stack:0     pid:8493  ppid:2      flags:0x00004000
> Dec  4 13:59:31 engel kernel: [243544.664101] Call Trace:
> Dec  4 13:59:31 engel kernel: [243544.664102]  <TASK>
> Dec  4 13:59:31 engel kernel: [243544.664103] __schedule+0x3b8/0xb00
> Dec  4 13:59:31 engel kernel: [243544.664106]  schedule+0x5e/0xd0
> Dec  4 13:59:31 engel kernel: [243544.664108] 
> schedule_timeout+0x147/0x160
> Dec  4 13:59:31 engel kernel: [243544.664110] 
> wait_for_completion+0x8a/0x160
> Dec  4 13:59:31 engel kernel: [243544.664113] 
> __flush_workqueue+0x140/0x410
> Dec  4 13:59:31 engel kernel: [243544.664117] 
> nfsd4_create_session+0x847/0xd30 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.664163] 
> nfsd4_proc_compound+0x351/0x670 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.664218]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.664255] nfsd_dispatch+0x7c/0x1b0 
> [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.664317] 
> svc_process_common+0x431/0x6e0 [sunrpc]
> Dec  4 13:59:31 engel kernel: [243544.664386]  ? 
> __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.664427]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.664466] svc_process+0x131/0x180 
> [sunrpc]
> Dec  4 13:59:31 engel kernel: [243544.664522]  nfsd+0x84/0xd0 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.664562]  kthread+0xe5/0x120
> Dec  4 13:59:31 engel kernel: [243544.664564]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:59:31 engel kernel: [243544.664566] ret_from_fork+0x31/0x50
> Dec  4 13:59:31 engel kernel: [243544.664568]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:59:31 engel kernel: [243544.664570] ret_from_fork_asm+0x1b/0x30
> Dec  4 13:59:31 engel kernel: [243544.664574]  </TASK>
> Dec  4 13:59:31 engel kernel: [243544.664575] INFO: task nfsd:8494 
> blocked for more than 245 seconds.
> Dec  4 13:59:31 engel kernel: [243544.664585]       Not tainted 
> 6.6.3-debian64.all+1.2 #1
> Dec  4 13:59:31 engel kernel: [243544.664594] "echo 0 > 
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Dec  4 13:59:31 engel kernel: [243544.664605] task:nfsd state:D 
> stack:0     pid:8494  ppid:2      flags:0x00004000
> Dec  4 13:59:31 engel kernel: [243544.664608] Call Trace:
> Dec  4 13:59:31 engel kernel: [243544.664609]  <TASK>
> Dec  4 13:59:31 engel kernel: [243544.664615] __schedule+0x3b8/0xb00
> Dec  4 13:59:31 engel kernel: [243544.664619]  schedule+0x5e/0xd0
> Dec  4 13:59:31 engel kernel: [243544.664621] 
> schedule_timeout+0x147/0x160
> Dec  4 13:59:31 engel kernel: [243544.664624]  ? 
> __pfx_sha512_transform_rorx+0x10/0x10 [sha512_ssse3]
> Dec  4 13:59:31 engel kernel: [243544.664629] 
> wait_for_completion+0x8a/0x160
> Dec  4 13:59:31 engel kernel: [243544.664632] 
> __flush_workqueue+0x140/0x410
> Dec  4 13:59:31 engel kernel: [243544.664636] 
> nfsd4_create_session+0x847/0xd30 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.664700] 
> nfsd4_proc_compound+0x351/0x670 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.664768]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.664813] nfsd_dispatch+0x7c/0x1b0 
> [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.664854] 
> svc_process_common+0x431/0x6e0 [sunrpc]
> Dec  4 13:59:31 engel kernel: [243544.664920]  ? 
> __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.664959]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.664996] svc_process+0x131/0x180 
> [sunrpc]
> Dec  4 13:59:31 engel kernel: [243544.665082]  nfsd+0x84/0xd0 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.665116]  kthread+0xe5/0x120
> Dec  4 13:59:31 engel kernel: [243544.665118]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:59:31 engel kernel: [243544.665120] ret_from_fork+0x31/0x50
> Dec  4 13:59:31 engel kernel: [243544.665122]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:59:31 engel kernel: [243544.665123] ret_from_fork_asm+0x1b/0x30
> Dec  4 13:59:31 engel kernel: [243544.665127]  </TASK>
> Dec  4 13:59:31 engel kernel: [243544.665127] INFO: task nfsd:8495 
> blocked for more than 245 seconds.
> Dec  4 13:59:31 engel kernel: [243544.665150]       Not tainted 
> 6.6.3-debian64.all+1.2 #1
> Dec  4 13:59:31 engel kernel: [243544.665158] "echo 0 > 
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Dec  4 13:59:31 engel kernel: [243544.665168] task:nfsd state:D 
> stack:0     pid:8495  ppid:2      flags:0x00004000
> Dec  4 13:59:31 engel kernel: [243544.665170] Call Trace:
> Dec  4 13:59:31 engel kernel: [243544.665183]  <TASK>
> Dec  4 13:59:31 engel kernel: [243544.665184] __schedule+0x3b8/0xb00
> Dec  4 13:59:31 engel kernel: [243544.665187]  schedule+0x5e/0xd0
> Dec  4 13:59:31 engel kernel: [243544.665189] 
> schedule_timeout+0x147/0x160
> Dec  4 13:59:31 engel kernel: [243544.665191] 
> wait_for_completion+0x8a/0x160
> Dec  4 13:59:31 engel kernel: [243544.665193] 
> __flush_workqueue+0x140/0x410
> Dec  4 13:59:31 engel kernel: [243544.665197] 
> nfsd4_create_session+0x847/0xd30 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.665253] 
> nfsd4_proc_compound+0x351/0x670 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.665297]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.665335] nfsd_dispatch+0x7c/0x1b0 
> [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.665374] 
> svc_process_common+0x431/0x6e0 [sunrpc]
> Dec  4 13:59:31 engel kernel: [243544.665428]  ? 
> __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.665478]  ? __pfx_nfsd+0x10/0x10 
> [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.665526] svc_process+0x131/0x180 
> [sunrpc]
> Dec  4 13:59:31 engel kernel: [243544.665576]  nfsd+0x84/0xd0 [nfsd]
> Dec  4 13:59:31 engel kernel: [243544.665629]  kthread+0xe5/0x120
> Dec  4 13:59:31 engel kernel: [243544.665631]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:59:31 engel kernel: [243544.665633] ret_from_fork+0x31/0x50
> Dec  4 13:59:31 engel kernel: [243544.665636]  ? __pfx_kthread+0x10/0x10
> Dec  4 13:59:31 engel kernel: [243544.665637] ret_from_fork_asm+0x1b/0x30
> Dec  4 13:59:31 engel kernel: [243544.665641]  </TASK>

Thank you for providing the additional info.

Looks like there is problems with the callback workqueue. There
are NFSD threads stuck waiting for the workqueue to be flushed.

If the problem occurs again, please do the following:

1. from the NFS server, dump the workqueue info
# echo t > /proc/sysrq-trigger

2. from the NFS server, dump the RPC threads:
# cat /sys/kernel/debug/sunrpc/rpc_clnt/*/tasks > /tmp/rpc_tasks.txt

3. pick one of the NFS clients that hang, dump the NFS threads:
# (for tt in $(grep -l 'nfs[^d]' /proc/*/stack); do echo "${tt}:"; cat ${tt}; echo; done) >/tmp/nfs_threads.txt

Thanks,
-Dai

>
>
> Regards

