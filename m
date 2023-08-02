Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1742376D99D
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 23:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjHBVeD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 17:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjHBVd4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 17:33:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCE33A86;
        Wed,  2 Aug 2023 14:33:33 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372HJ98W009360;
        Wed, 2 Aug 2023 21:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2TsnEEfiA7GqSV1Uk05AgkMU7xr0vUDZOqJ5GQBRooU=;
 b=of1EdoSl0pc8eQ6YxcwjfAVpzdRoEUJlUq7tsNtBYfzR0bvRXsspGk6YHKZxqL7/mdiT
 O0Wi589v3+HT/WnlLnaZpLJLANyD7dSx5gt+JqygCKhtZcLLX34QHC2cS9CxZkL4RbtB
 Dh9IZMQkdYRoaM5/ZTNZYyVrCVnbjhX41UwvFd7PBzoW1GbsXOjB14OyfeyFogtN40JA
 s+H8hePXll2+p0xhMPKypkpTTGjMwgu7XhxRb6zLeSEX+l5JWEMIFEpPxl3QBYszf3Iw
 ql7G6V9vze4uxfijzA7Ai7w0yfprAGJMzuSxg7WGkI1FDUnkQyp8+gB4BAGHzwLiHLDq wg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc8cwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 21:33:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372KUmdD020583;
        Wed, 2 Aug 2023 21:33:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s78qv8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 21:33:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iA2qwbLRk6gJbDSebxe1R57qOw4j2I23NJRdotQSdYsoJMR+wMjisY/1JloLbste6fImAfW29Y+pG9P7deXXTRBz+xf06ICLKJkeTy/QBPgcLdn3H2mrQu0K/Ea8MHVn7xiaButuCZ+l9GOrDgwl5rQsS6F8i5cUsRbGM2Dg20Oh1dPJUQBZiRAD1KQqn0+PHzhMuB0kd1Yi230qpNCUIp2NuJqjVkHYnxJZjIaUEDKgG3uefSe5xhkAMr1vezpvro+E8c90E36C/ZzVr7BBM0bVPO/x9AW85+S7CpCPIrUhHPn+m84T0nZcYJK8Deti8UGCBuO0urCbxEtPrUrQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TsnEEfiA7GqSV1Uk05AgkMU7xr0vUDZOqJ5GQBRooU=;
 b=ZwfjSdaMgTdEodUYmSR5TwK/t/D7WeiV1aFqH3YlKvdLXIGDbS+cVA+YJE0CHDACyZoXFSNCkwwQ8k8o4B5E05gKRJnNCE7B+8Vt/TCtnrOgfpH90Ov80swjKTxlMvoAS8W0iJDDwup5kcc/3xzBNk48nFp7CzBP1O9PII6U6iovC5EAwvAJkrgidlH5Yx7ksbBsCItNMdq6LB3TV0U6BKVwWj1MPQ48s/WIkunPW+KlPjzy/xWUZEdLg7TfNClCJZdwR1aaztulgEx5rE3AVPskrd2QdwGsdR4+44IZAaY/pSE/tKU7D6UGGa0gvNS+6SyyXhPVtUwQkXZrI8RsKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TsnEEfiA7GqSV1Uk05AgkMU7xr0vUDZOqJ5GQBRooU=;
 b=GxzRo2ptUJftokVYtI9xlP1S0smWXe3MpdyJL2xfSutVGx0rcYuAvB6mCBs6rhEYijNMZtUUMLcb6qbhl28ZKWyjPHRgdcK8npfWeheE+pZg2/2rRCwl6LWoCC7AJFKrRc7MfbYhw4Y3ZVzQaCC21g5u+QrjzSX60LsyumR0y1w=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by SJ0PR10MB4702.namprd10.prod.outlook.com (2603:10b6:a03:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 21:33:12 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 21:33:12 +0000
Message-ID: <5296d1a2-e410-c5bd-a8ca-66b8b42f158e@oracle.com>
Date:   Wed, 2 Aug 2023 14:32:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] nfsd: don't hand out write delegations on O_WRONLY
 opens
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230801-wdeleg-v2-1-20c14252bab4@kernel.org>
 <8c3adfce-39f0-0e60-e35a-2f1be6fb67e6@oracle.com>
 <c9370f6fde62205356f4c864891a3c35ef811877.camel@kernel.org>
 <0a256174-44ea-d653-7643-b39f5081d8a5@oracle.com>
 <d70f4dd0fc77566f15f5178424bcf901ed21fbad.camel@kernel.org>
 <26761CA2-923C-43FC-BDC6-14012115EAA0@oracle.com>
 <6801380f-75cb-49b2-4e89-49821193fe32@oracle.com>
In-Reply-To: <6801380f-75cb-49b2-4e89-49821193fe32@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:5:333::18) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|SJ0PR10MB4702:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3f94ca-bece-489e-1710-08db93a01304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/UbPHfmdVBTIAGGxhRqxZK+1fykCTz7sHxzyE5VgMBjrk1Jmujbmb8/nVY4jMP7ltyzUzWufDQaHU/GXGQwQuQZX6TvHqlSMlhatAeZMu0hLoX92iZl9ieZCCcL/P4ChqKsW3Uvnoc03cskubpNQasu2/FPO+L5VPAPLKES5GnzEmo18hSXfchgIZMr7zB4AXy4SxTB9rEygHVHnMZUyFpOvQ0AiOj6uq6CbUR+E0edBx62KgI0TjEcZ9rekpylIePVLIW3+EKFYM9XrAFqJPQ3ufCBxWaE20NTu+rcmQY7MAaZh12USaQ60/XEq/Qj2xRnGhpnmg2CQ9qusG25YY2WOwFSUEdWGA8lb+t7cC7K0EikmA8REoigqQVpWQvr1rQUMo3iUBOhlyOh2I6UTBuQvSY/eG4pjV9HKaG7eLOoy/6gulLfrO9CpVTvCxCuoakEOwk6bESUazcdlDUE5CHtYkTOgRHG2EPgnYzVXMUSSdloT5TPEbWuQvYOutlvDeUoXE6Uu8k+OzuF4Q7NOA0c7sk4DChy2x2wslQvLRv/DvKLCDdj6nhxLbEo65BGnoNKXW2o9TLMOzWsZ+q1QblFLG/JYK7tuGKwlKzcj6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(186003)(2616005)(9686003)(36756003)(6512007)(966005)(316002)(478600001)(86362001)(54906003)(110136005)(66946007)(6666004)(66476007)(66556008)(38100700002)(4326008)(6486002)(31696002)(53546011)(6506007)(26005)(41300700001)(8936002)(8676002)(31686004)(83380400001)(5660300002)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djZsamVGWTdENE9lSUgwUU56VGpITlphamo2QTBjT1VwOWtqYzREeDE3Mndm?=
 =?utf-8?B?T2RXbWt2M0ZiYnExellYRUk1K1pQK01wMk9rejVQSHptRXpvQ2pveG5pYVlo?=
 =?utf-8?B?b2o2TkZjMFpTLzJwc3F0NldxZVgrOC9ubHBnUEVFcGNDVE1EYWtsQzhNTXFu?=
 =?utf-8?B?NjZhQjJUYkZrSmkxYlpJdzJlcG51aSt0NTI1dGhxWFQrQTFhM3JDVjFrWFds?=
 =?utf-8?B?ZmFMTzFTTFBlNkxQN0gydG5GM21rTzZxZmN3WXphZ2g5OGZZdmp2NWc0WU9v?=
 =?utf-8?B?ZEVmZlpZdjcvY1FkQ0ZJWkpNd2hseklqRW1QOHF3Qm9PbzdBbm1odWxxZFQ4?=
 =?utf-8?B?dmNTZzJUQTFJMTB1UGRJSFoxb0NTM1pEdGlTU3U2bWdwV2dLRTBPdFE1NGlO?=
 =?utf-8?B?eW5pRGROYlE4RVowYk5aZlhuZFQveVNxNmZmLytGelBIdXFSOTNTVU1sWW91?=
 =?utf-8?B?djNVU1pueER0THFKelFkdVFOdk9lWW5yN1NmVWJ5OTl5TjVwUDl1U0c4YktQ?=
 =?utf-8?B?ckYrc2RaV2t4YzY0a0ovR1FWVURVQ1BrNWtzb3YrQXRRT1lnQ0RXZS9NT2tz?=
 =?utf-8?B?bG5YZEhFVDQ5dVFwMXVwZkY0WHVSc3NrQmtyRGlXMFVkdjhvM2k0OFFCckEx?=
 =?utf-8?B?Y1R3REI1NHlFa2wyblNvejRGN0NUcFJKYXBrR0g1d1FiZEJvS1hVMzVEMmth?=
 =?utf-8?B?NFVnaHF6YTNZNXNlcE95YmljSitVS1psem50QVQzWGkvVEFTMWVqZWZrRzNm?=
 =?utf-8?B?azRNaU1XMXhsL0tONjJaVW9Ub3hNeFVkVkJFaHg4bUR3SitzK3NodUIxbzBM?=
 =?utf-8?B?QVhMMVFhWDV4UWhLN0VvOVRmTld5Nko0RVVCODFEdXFWTC84NE5UWnB0WlAz?=
 =?utf-8?B?N1Q4dFl2SHF6SDdlQUJaOTVOS0F3VEpQQ0szek1hU0JOZnMxNkZuWEhlbjZx?=
 =?utf-8?B?M1pKb29uTG41NDluUk5OM285dFRDS3Y1WUpVdDB1aHRnRzUwdFkrcTF5UE15?=
 =?utf-8?B?ek45VjVhWjNMUXhRd3JsRXVsR21xOEo5MkplOFk0R2F4NUJ0YUk2S1pFODRW?=
 =?utf-8?B?TCtJWUVDaHZXeEZ6ZU5JQUxHTk9aT2tOQVhycVM0RWE4WWJXV090OXhtMStQ?=
 =?utf-8?B?OExwMGRnWUh3NUlnQUdYN3hGZFBoQjNPcDFaRFRiT3RjNUhOeWEyWVdVaGRw?=
 =?utf-8?B?V0g2eVkzeHo5RGxqUlVaUngxT284MkdWVnFreThYcTU3RmFodW1Leit0aGlz?=
 =?utf-8?B?RG9HcmVEZENBSW9QQVBTR0VmTFNDL0VIN1lpeDAxK014RUwzTWFyNHBlcmtD?=
 =?utf-8?B?QjZCaEoxNFN2aWoxeXk4T1ExN29IeHlKbm5PbzhIcWFrTUdZVHR4MmVzTVdX?=
 =?utf-8?B?YzJBMnExZ0JEbTlaMlBhSGI1eUJuZXhDTVpvcWk2TVovRS9aa1JhaWZycmE4?=
 =?utf-8?B?WUI2aEl2WnNIZHVlSU96K2VjMGRJU055djdWcFRKcFIyWTRsMTk0TzAzUUJ3?=
 =?utf-8?B?V0FxYmtYV3JIeWh2OVZDdmxXYnBHOGZLSHZrMGtIUERsZmtSOTMwN2Vld3RB?=
 =?utf-8?B?dlZnOFdadHBpbDlUY2taRGVldE1iNzZBZ091ekNPZGJsbVE3YnVyOWhQOXVU?=
 =?utf-8?B?alU2VnN1UytrVUxPWm13ZDJkSWdGMWV3TWdnVldhcS9IZTVVajNIZ2tTaWpI?=
 =?utf-8?B?QXlVOFJqVXVPODJ5K0NwYnJXcDQxQk92SWwzOFFORW9KMkxJWmprdE10VUVK?=
 =?utf-8?B?b1dkM0VNOHo5MTE3Y2xGNTBQV3lsYlBFcFBITmN5SkVteDNzWUw2R0trcWRW?=
 =?utf-8?B?bTN4bllrUkR6a250OHJhcEh4bXMyWGxIUkxjdzJodDJIaXR6ZWlPMkViaWpZ?=
 =?utf-8?B?MFZmT1ZWaUw2M2grbWV3QndUclRnVXV4QUpQSGx3RXlFaFBkdWpyTW5kL3Jk?=
 =?utf-8?B?VGFsUGZvaURNRGxxeThXOC9TdlNWT3VmTHlaemZlblN0TUF0NmQvNTY0ci9J?=
 =?utf-8?B?ZmpyM3VMQTg3TGt4Y0RreWY0NzErMk9GME1GbUlReVdmekZIR1l1dGRvd1Zt?=
 =?utf-8?B?S2Y2Q3lTd0ZQWTIxODluTHBvSDNPaWRTRGNRak1ta2xkZk9OZGdwbHRTM05C?=
 =?utf-8?Q?8HvFn0aAdKy5+R/64d3+QPLx5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Px3w0znqPBGvCABYgHxXN9cpmH0VuN75CFOSDCflp/KJFURSy5utIg+MST5Ou37T/Jm7rr0AlbA62l9XQOnsbWHMN5N7IPk+wsHcHL8ImwQSPhsrQq214qBLlJ6JXj8lbRv3ygVxPfJEGOAb33RsfHOblVnU+Zr1dubc0Ab1/XNwODuWWIuEGzs4uukL9FNelRAfNt8qhHb7tCiDhnSLJRd9zIyJyHqw9LnSxOTP1v0oiRKnRdXD1f5D+/iI63hkHdm528OkXrS3qKE2FC4skkl7EHfBiTnDerKNLp2lyikgEiGsi6VwtlEUI3IOJA1QaFSkJQFAKRJcVtUPjJjH8PKtXkcekQKFj7iZib4Rk2zaywsPlyaiFrCiHhzmSEWQhnYySzdja7W1QApy6j7RTe+Vfjq/XxoovP/Te2t2Dml0zZLSqH12XZ3jU+ShvQ80DQQ5rg2rJBCxxlNIy753nko1Q3Us1oXAOWYWrEqgXHCN4xe6xoA0lwfgcrg5cSrbnw7eC/sR3rSCtO9Jp74VunEOWHs6TqJEltxup1kE3s0xDLNOe+cgXkG2YFdP+MYeg8Lqht18n2our+asGhX6ClXACL6g4IYC/HyYn/DcPvo3hFpLOUdwqyvxfFgfUfCZLH6EPs0NDyO87gvaXwq4/QNI2xhr8RBFIxtw26GRAMf+zlRZYT6OJljjuyKyf7f/G/f7Z8f4pSSJ5OYEDpoXn0N/LvxifHjlcl0nV1LaNc8g+0J7lCs5J0iXakxjRBF0pWKv0OqCvgESTPP1fuXOd75ngtUoIw86U9Hd5VPDXRx5lIaerRQhhOAfteHFJygb3TEF6NicgXyY7OoS6iZipklEEjdV2UplvCYMkXukZyGneS6e3HHoUTSNTnDePtG5
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3f94ca-bece-489e-1710-08db93a01304
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 21:33:12.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pO0TQPyuYMmmopX+3Q+ALLKz9mWdbWVGAIYsccCcPRpnA70KMOOIk5Rm8/k3WVgISRhS2z2MvePGG/7jmfkpCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4702
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020190
X-Proofpoint-ORIG-GUID: 9S8yDtPKcmgOmxDRAoF4j-s7IJSX8e5n
X-Proofpoint-GUID: 9S8yDtPKcmgOmxDRAoF4j-s7IJSX8e5n
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/2/23 2:22 PM, dai.ngo@oracle.com wrote:
>
> On 8/2/23 1:57 PM, Chuck Lever III wrote:
>>
>>> On Aug 2, 2023, at 4:48 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>
>>> On Wed, 2023-08-02 at 13:15 -0700, dai.ngo@oracle.com wrote:
>>>> On 8/2/23 11:15 AM, Jeff Layton wrote:
>>>>> On Wed, 2023-08-02 at 09:29 -0700, dai.ngo@oracle.com wrote:
>>>>>> On 8/1/23 6:33 AM, Jeff Layton wrote:
>>>>>>> I noticed that xfstests generic/001 was failing against 
>>>>>>> linux-next nfsd.
>>>>>>>
>>>>>>> The client would request a OPEN4_SHARE_ACCESS_WRITE open, and 
>>>>>>> the server
>>>>>>> would hand out a write delegation. The client would then try to 
>>>>>>> use that
>>>>>>> write delegation as the source stateid in a COPY
>>>>>> not sure why the client opens the source file of a COPY operation 
>>>>>> with
>>>>>> OPEN4_SHARE_ACCESS_WRITE?
>>>>>>
>>>>> It doesn't. The original open is to write the data for the file being
>>>>> copied. It then opens the file again for READ, but since it has a 
>>>>> write
>>>>> delegation, it doesn't need to talk to the server at all -- it can 
>>>>> just
>>>>> use that stateid for later operations.
>>>>>
>>>>>>>    or CLONE operation, and
>>>>>>> the server would respond with NFS4ERR_STALE.
>>>>>> If the server does not allow client to use write delegation for the
>>>>>> READ, should the correct error return be NFS4ERR_OPENMODE?
>>>>>>
>>>>> The server must allow the client to use a write delegation for read
>>>>> operations. It's required by the spec, AFAIU.
>>>>>
>>>>> The error in this case was just bogus. The vfs copy routine would 
>>>>> return
>>>>> -EBADF since the file didn't have FMODE_READ, and the nfs server 
>>>>> would
>>>>> translate that into NFS4ERR_STALE.
>>>>>
>>>>> Probably there is a better v4 error code that we could translate 
>>>>> EBADF
>>>>> to, but with this patch it shouldn't be a problem any longer.
>>>>>
>>>>>>> The problem is that the struct file associated with the 
>>>>>>> delegation does
>>>>>>> not necessarily have read permissions. It's handing out a write
>>>>>>> delegation on what is effectively an O_WRONLY open. RFC 8881 
>>>>>>> states:
>>>>>>>
>>>>>>>    "An OPEN_DELEGATE_WRITE delegation allows the client to 
>>>>>>> handle, on its
>>>>>>>     own, all opens."
>>>>>>>
>>>>>>> Given that the client didn't request any read permissions, and 
>>>>>>> that nfsd
>>>>>>> didn't check for any, it seems wrong to give out a write 
>>>>>>> delegation.
>>>>>>>
>>>>>>> Only hand out a write delegation if we have a O_RDWR descriptor
>>>>>>> available. If it fails to find an appropriate write descriptor, go
>>>>>>> ahead and try for a read delegation if NFS4_SHARE_ACCESS_READ was
>>>>>>> requested.
>>>>>>>
>>>>>>> This fixes xfstest generic/001.
>>>>>>>
>>>>>>> Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=412
>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>> ---
>>>>>>> Changes in v2:
>>>>>>> - Rework the logic when finding struct file for the delegation. The
>>>>>>>     earlier patch might still have attached a O_WRONLY file to 
>>>>>>> the deleg
>>>>>>>     in some cases, and could still have handed out a write 
>>>>>>> delegation on
>>>>>>>     an O_WRONLY OPEN request in some cases.
>>>>>>> ---
>>>>>>>    fs/nfsd/nfs4state.c | 29 ++++++++++++++++++-----------
>>>>>>>    1 file changed, 18 insertions(+), 11 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>>> index ef7118ebee00..e79d82fd05e7 100644
>>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>>> @@ -5449,7 +5449,7 @@ nfs4_set_delegation(struct nfsd4_open 
>>>>>>> *open, struct nfs4_ol_stateid *stp,
>>>>>>>     struct nfs4_file *fp = stp->st_stid.sc_file;
>>>>>>>     struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
>>>>>>>     struct nfs4_delegation *dp;
>>>>>>> - struct nfsd_file *nf;
>>>>>>> + struct nfsd_file *nf = NULL;
>>>>>>>     struct file_lock *fl;
>>>>>>>     u32 dl_type;
>>>>>>>
>>>>>>> @@ -5461,21 +5461,28 @@ nfs4_set_delegation(struct nfsd4_open 
>>>>>>> *open, struct nfs4_ol_stateid *stp,
>>>>>>>     if (fp->fi_had_conflict)
>>>>>>>     return ERR_PTR(-EAGAIN);
>>>>>>>
>>>>>>> - if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>>>>> - nf = find_writeable_file(fp);
>>>>>>> + /*
>>>>>>> + * Try for a write delegation first. We need an O_RDWR file
>>>>>>> + * since a write delegation allows the client to perform any open
>>>>>>> + * from its cache.
>>>>>>> + */
>>>>>>> + if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == 
>>>>>>> NFS4_SHARE_ACCESS_BOTH) {
>>>>>>> + nf = nfsd_file_get(fp->fi_fds[O_RDWR]);
>>>>>>>     dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>>>>>> - } else {
>>>>>> Does this mean OPEN4_SHARE_ACCESS_WRITE do not get a write 
>>>>>> delegation?
>>>>>> It does not seem right.
>>>>>>
>>>>>> -Dai
>>>>>>
>>>>> Why? Per RFC 8881:
>>>>>
>>>>> "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on 
>>>>> its
>>>>> own, all opens."
>>>>>
>>>>> All opens. That includes read opens.
>>>>>
>>>>> An OPEN4_SHARE_ACCESS_WRITE open will succeed on a file to which the
>>>>> user has no read permissions. Therefore, we can't grant a write
>>>>> delegation since can't guarantee that the user is allowed to do that.
>>>> If the server grants the write delegation on an OPEN with
>>>> OPEN4_SHARE_ACCESS_WRITE on the file with WR-only access mode then
>>>> why can't the server checks and denies the subsequent READ?
>>>>
>>>> Per RFC 8881, section 9.1.2:
>>>>
>>>>      For delegation stateids, the access mode is based on the type of
>>>>      delegation.
>>>>
>>>>      When a READ, WRITE, or SETATTR (that specifies the size 
>>>> attribute)
>>>>      operation is done, the operation is subject to checking 
>>>> against the
>>>>      access mode to verify that the operation is appropriate given the
>>>>      stateid with which the operation is associated.
>>>>
>>>>      In the case of WRITE-type operations (i.e., WRITEs and 
>>>> SETATTRs that
>>>>      set size), the server MUST verify that the access mode allows 
>>>> writing
>>>>      and MUST return an NFS4ERR_OPENMODE error if it does not. In 
>>>> the case
>>>>      of READ, the server may perform the corresponding check on the 
>>>> access
>>>>      mode, or it may choose to allow READ on OPENs for 
>>>> OPEN4_SHARE_ACCESS_WRITE,
>>>>      to accommodate clients whose WRITE implementation may 
>>>> unavoidably do
>>>>      reads (e.g., due to buffer cache constraints). However, even 
>>>> if READs
>>>>      are allowed in these circumstances, the server MUST still 
>>>> check for
>>>>      locks that conflict with the READ (e.g., another OPEN specified
>>>>      OPEN4_SHARE_DENY_READ or OPEN4_SHARE_DENY_BOTH). Note that a 
>>>> server
>>>>      that does enforce the access mode check on READs need not 
>>>> explicitly
>>>>      check for conflicting share reservations since the existence 
>>>> of OPEN
>>>>      for OPEN4_SHARE_ACCESS_READ guarantees that no conflicting share
>>>>      reservation can exist.
>>>>
>>>> FWIW, The Solaris server grants write delegation on OPEN with
>>>> OPEN4_SHARE_ACCESS_WRITE on file with access mode either RW or
>>>> WR-only. Maybe this is a bug? or the spec is not clear?
>>>>
>>> I don't think that's necessarily a bug.
>>>
>>> It's not that the spec demands that we only hand out delegations on 
>>> BOTH
>>> opens.  This is more of a quirk of the Linux implementation. Linux'
>>> write delegations require an open O_RDWR file descriptor because we may
>>> be called upon to do a read on its behalf.
>>>
>>> Technically, we could probably just have it check for
>>> OPEN4_SHARE_ACCESS_WRITE, but in the case where READ isn't also set,
>>> then you're unlikely to get a delegation. Either the O_RDWR descriptor
>>> will be NULL, or there are other, conflicting opens already present.
>>>
>>> Solaris may have a completely different design that doesn't require
>>> this. I haven't looked at its code to know.
>> I'm comfortable for now with not handing out write delegations for
>> SHARE_ACCESS_WRITE opens. I prefer that to permission checking on
>> every READ operation.
>
> I'm fine with just handling out write delegation for SHARE_ACCESS_BOTH
> only.
>
> Just a concern about not checking for access at the time of READ 
> operation.
or not checking file permission at the time WRITE.
> If the file was opened with SHARE_ACCESS_WRITE (no write delegation 
> granted)
> and the file access mode was changed to read-only, is it a correct 
> behavior
> for the server to allow the READ to go through?
I meant for the WRITE to go through.
>
> -Dai
>
>>
>> If we find that it's a significant performance issue, we can revisit.
>>
>>
>>>> It'd would be interesting to know how ONTAP server behaves in
>>>> this scenario.
>>>>
>>> Indeed. Most likely it behaves more like Solaris does, but it'd nice to
>>> know.
>>>
>>>>>
>>>>>>> + }
>>>>>>> +
>>>>>>> + /*
>>>>>>> + * If the file is being opened O_RDONLY or we couldn't get a 
>>>>>>> O_RDWR
>>>>>>> + * file for some reason, then try for a read deleg instead.
>>>>>>> + */
>>>>>>> + if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
>>>>>>>     nf = find_readable_file(fp);
>>>>>>>     dl_type = NFS4_OPEN_DELEGATE_READ;
>>>>>>>     }
>>>>>>> - if (!nf) {
>>>>>>> - /*
>>>>>>> - * We probably could attempt another open and get a read
>>>>>>> - * delegation, but for now, don't bother until the
>>>>>>> - * client actually sends us one.
>>>>>>> - */
>>>>>>> +
>>>>>>> + if (!nf)
>>>>>>>     return ERR_PTR(-EAGAIN);
>>>>>>> - }
>>>>>>> +
>>>>>>>     spin_lock(&state_lock);
>>>>>>>     spin_lock(&fp->fi_lock);
>>>>>>>     if (nfs4_delegation_exists(clp, fp))
>>>>>>>
>>>>>>> ---
>>>>>>> base-commit: a734662572708cf062e974f659ae50c24fc1ad17
>>>>>>> change-id: 20230731-wdeleg-bbdb6b25a3c6
>>>>>>>
>>>>>>> Best regards,
>>> -- 
>>> Jeff Layton <jlayton@kernel.org>
>> -- 
>> Chuck Lever
>>
>>
