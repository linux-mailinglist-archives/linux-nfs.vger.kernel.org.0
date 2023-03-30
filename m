Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8D76D0CFE
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Mar 2023 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjC3Rjy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Mar 2023 13:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjC3Rjw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Mar 2023 13:39:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB78BE068
        for <linux-nfs@vger.kernel.org>; Thu, 30 Mar 2023 10:39:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UEELjr028943;
        Thu, 30 Mar 2023 15:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=mjVElOxBsVhbpmlSaP4rU7+gxt42HetWQ5kCTbtdK74=;
 b=WFeKYWZLd+qhrMtkM2ZLp5uW9mFi2fRh9DF5Y1c9iIxhlHEBY0QFq76hKuW4QX7q0ZYP
 NBy6UWYmZVdP7ATRWCpZJh3Vpd+khIhXdx1p31dyxnN8riwleLg/UPLgo3DaWOt9X75x
 Ayge1fte5UsNOxbUFY4PxSJiYPkIeE5nPbEWCTrRCxN4ul7lkqtjX3dxPrxtkBIwlxPv
 O5TvtkFUL8RkJLSBSilkWA7dqHfJRQQQB1vJxn2S/XVhdrT88Z+etBEBqpLBAFPjeoZZ
 YGK5drH//sHZY9V8/+N2hcuf7Jvn2UZTCzdOlKl1reMpp/Rc82kRkBldZFv6njT6rq8H /Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmpmpb47t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 15:33:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32UEDbVF030035;
        Thu, 30 Mar 2023 15:33:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdg4782-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 15:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzHs46kx1hUZg6Uio/4u+aahHfjbV8OgC8Z75bUcmp7/n7Yz5PSsE9PhbDhp9juLUyf0tsb9xR+wWCHnT8tPpWOfMMOdZ2+YobPR3PYmcJt3fJTMz277gbBb7kL1h1g4QsBel+GVb2e2s9uRiRY6i0e3ow2Qz5aWc+W0Gf3QSRwFVHTT25A1mmlX72yiuK4jpY/82Su14yYOXUXbjbJuY192V/DuWVX6QNwgODmufYW/WemkZu7aDQjj59lStAaMYGK9wDvohnx5SSxBZtvJg/2DMcnWlSutr5bbAPfMNI0f7na8iDXUwZ98sI5PuHklRujCWKncwKDcKFXOmwng5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjVElOxBsVhbpmlSaP4rU7+gxt42HetWQ5kCTbtdK74=;
 b=i2JtJdrCSo/Xe/2Edj6DNLZANzb/mulGqfralb2zZYTOreTJSZ+WX5KfcPv1zc6kM05J5s8Q/c3gdx0mAnF85xONmxjY1jTwnRJEinIuyMxNt8WhTgQ79T6xewuNiBQSFff5qLC+D8F/o7qLEUcanBW1wfBVHkOystbHusPg88zdidaLHNkmzNhx42h+4KzWC8qlcTr8Xfu8soZKqLOXuYQDIRiB7FJWmK1d96umOMOkIyGVyiyQ6IZqCLnXg8dNY4jh7W9JqCoOok1cbg1LMGkEqtd8OPmWvSz1gjAS7qEiyGffYLh3SFsg032jba9ldSuSwJYqOToiKuA8MQv/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjVElOxBsVhbpmlSaP4rU7+gxt42HetWQ5kCTbtdK74=;
 b=XkBg67bJfwocz7dXGhI7gdJrx3dBnBndvONr6o6Qi6YNI8s2xcnhFXqzId/lGrDDCJmxcaBubNPxEmdHY+QfXevgy3+bKoMiWA03rfx7S7+VZZvqf0Z4kTGcfoavsevCs+61E+ELfomijxMq1uXJ/f5sM5nKw0h4zfEj8Am66/Y=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by CH3PR10MB6904.namprd10.prod.outlook.com (2603:10b6:610:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 15:33:16 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::effd:a3fc:9fdc:a534]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::effd:a3fc:9fdc:a534%8]) with mapi id 15.20.6178.041; Thu, 30 Mar 2023
 15:33:16 +0000
Message-ID: <bc0c344b-8939-d55e-85c5-168b85e974d5@oracle.com>
Date:   Thu, 30 Mar 2023 16:33:10 +0100
User-Agent: Thunderbird Daily
Cc:     Calum Mackay <calum.mackay@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH pynfs] rpc.py: Don't try to subscript an exception.
Content-Language: en-GB
To:     NeilBrown <neilb@suse.de>, Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>
References: <167996453785.8106.14290228013263156210@noble.neil.brown.name>
From:   Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 gx3r8uLHNg==
Organization: Oracle
In-Reply-To: <167996453785.8106.14290228013263156210@noble.neil.brown.name>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------iQvsdEvozjrYhzSKisY9BUoI"
X-ClientProxiedBy: LO4P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::19) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|CH3PR10MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 648dd931-4360-46e6-4177-08db313414cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XkF8OqbAJXi3IaeGWw0XKiApEtoOrUFgCfkjXgbEj7JBwu3mQ+6GjEdFOAwB+dIl9zzsDdKe5Ihbm2bEW9NahtqX53/tpTIurHr45ILL7saMHIXF6BiqUYu0xr7FM/FUuceUd29yiWycxXTMS9gM9sT+6/rr4TXXMO/GpJ02BOnnH5Y7GFVNB8cUQIIPhEAS6US3Lu9b9rj/trf7uo3L69Emmj1iq7a11J2XRUCXBb5rkhbH4fFAc5bh6vt+RleG+kKibIjSYTsZPT6PTEO/ZDNYdgzt2MQJ1c21kZxN2FSy/9755OOMNA3c0N2eOioFpn6AQ2KjsXkIceIZxhBhyZfl6M4qkK1ntF3mdZPX2mAkWexcP0+es2uVtTCyIUhlywsWS60zPl6zzDRwiDV8Xgq5rd+Ly5RP42FxiVfEwGckS5H06XMhrFMmGCcvZxK3sUMlo3fFVxVOpTye9k6yqh5NKLXn+kdPDHINMzmONV5ZJkaU+FFkAMtW/XIJiUSl75zGNGfwMrd7PXokpAFyCbm0LQEnwlDgtkackKSE1C6/2Dgt9Fn4GdFMngmIbW4WMX432iIXNST3erkS+H1NK0dQgQOvgtACTyZP8rrBnoqTl4RKz9KcpaxbEwUv8mA+lhQPlCtYGoO/GyCSEsnvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(6486002)(6666004)(26005)(6506007)(66476007)(53546011)(36916002)(31686004)(6512007)(110136005)(54906003)(478600001)(316002)(21480400003)(33964004)(8676002)(186003)(66556008)(2616005)(83380400001)(66946007)(4326008)(235185007)(44832011)(2906002)(38100700002)(41300700001)(5660300002)(8936002)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHdDUDhKNDcvMHNVekFydEUrQjRwcGprdEZmUU8vS3JqMFdtenVQeDhuWFlR?=
 =?utf-8?B?TCtsdFY3QmNDVmZ2MlRXTXNVcHNHcWZnT1lGZkxsWXlIZlFmbzZJQ1I0TzJR?=
 =?utf-8?B?eHprL0hnM1c2TzFYU1pMd3lOMlVQN2NwbXd1THJQK1ZZcGpkVEQ5YTBoaVVX?=
 =?utf-8?B?RUZ1cks2UERyU3Q1VlFDQTM4d3VKdjRKRzVzZ25sdG16eTQydHhjMHkzTk9z?=
 =?utf-8?B?MnllTVM4MmNtVUJqMm83RVVnVjd2RE4xV3UyNE56Vk1TeHpZKzVaMDEzLzJI?=
 =?utf-8?B?WnZkekJyRTIzZkNyYkJSbzgvdHV4dTk2cy9xdGNOT29VVk1SUzRLb3lQT2cy?=
 =?utf-8?B?cVZYQUovMFlDeWhWemY3ZFhMSzRzR21OZzBFQU1GdVk1NGZtTW9qeEZaOXdR?=
 =?utf-8?B?M21JQ3NieXFKNkI0VHROWHFvY2JqWGlkN0FGY0xrajEvQVBYTXpEcGwweU95?=
 =?utf-8?B?TlBZQ1BhcDhHd3Nydm1iU2NiTDlzdnBkaHJxZ3ZoRmk4a1NYTEx5MnJZRk1l?=
 =?utf-8?B?R1N2MnFVc0VmNFllTXNnZ2JkVXkrdTdSYTRRSDFkc0h2c3h3WFpja2YxSjl1?=
 =?utf-8?B?SGpCWTNmcDhhMUZJSmdSMm5vUFhza3k1WjQrOVloVUlmQU9NTHZzM2pRcEVr?=
 =?utf-8?B?dVJ4UkpnaDdoSzR6ZTZKcDg3SFRRLzUyNmRkalpEVlI0UVNaUklobnN0bGpI?=
 =?utf-8?B?SEt4QTlLR1RtbWtzSFN0MWZaVUplR3BoeE5hMGZZODlrRGdabE5YT2k0enhn?=
 =?utf-8?B?WlFNTHVBdWlxZnlOMEZZdHVsYkVPbUV3RlRmc2lHYWpFdGdGRmNJeUhNbHhl?=
 =?utf-8?B?MSthakJzaktkQ1Z1SytxUGF3RUVrTkNMQWtrTDhXZW1yWllkL1NpNFFJcFh2?=
 =?utf-8?B?c3JBRkp0M3NVczdwYVhKczUxTUc5dXRBYWt0aExzZHVTRWZxTjI1MHJMOXA5?=
 =?utf-8?B?QzRyNEt4S210VWw5Ymp1QnMwamxsam5YWStoelYzYUd6ajY5YVFEMkdZeTdV?=
 =?utf-8?B?M3dBSjQzcHo4VFNSZVVha1c5bU55TGxaajlxS3Y0RDByb1V5N0xVQy80L0x4?=
 =?utf-8?B?Q1IzZ3lxWWhIbEYxOUZNMmRVOU9udEIvMzR3RWM0ZW5LeG1xNlk1azF4b01O?=
 =?utf-8?B?elMyZmxDUUxxVUx3U09kR20rRE81bXdDMlV3TEh1ZURYYk1UZU5RaXo4V0d2?=
 =?utf-8?B?dnNWeUc3alU2aWVnaEk5U3FzNTV3UGVtTnVra0F5T3N2L2N6OHRPcHlPMHhz?=
 =?utf-8?B?V1NpalNzdWRuL01FNTg2M25Ca1cxa1B1K0h5NUZmSmRaZ3JtakdGZTYrKzF6?=
 =?utf-8?B?WFcxNzg4R2VELytNVTl2ODgxWnc0Ri9VOEp5Y0VsYlcrVWN1aTJEYWtlMlht?=
 =?utf-8?B?TURVem42d0tLSzdQMGNqZWdUUURXeTVOSWtrQTkxcGF2SVNWak1DdFI0YmU3?=
 =?utf-8?B?MEd1d3NiREI4L3pWajdRMFVzaWt5TmI3bkVQd05TaGRWYlprcHZJYTEyeGNQ?=
 =?utf-8?B?cWp6ejE5bEJjY0lyRUU0eHUrR3F0OEFQNldVNVYwSkw2YlE4T2FJVVJGSVpB?=
 =?utf-8?B?cTY2RzN5VTFkSUMrRldnczlxczJvYm9Eb2QwdkhzM3NVUEVMeXVsWm5vREN2?=
 =?utf-8?B?YXZNMmlIUmtuQ3BLTGNBT1FPYm9wTU1Pck9HK3dkOVo2MEx1Q3N2SzM0cFR6?=
 =?utf-8?B?bkFjcVRjRWI4NWhRNWtQMVdvWFFCeTY5bkZrRU1nY2diYk5kVTJLU0c3UGlR?=
 =?utf-8?B?L0Erbk1OTFJoS0tIZzFnZ2dhSS9kNktWcERVc0toVTg0MmRYK0NNb3V4NWVF?=
 =?utf-8?B?YnA3WTRwekovY2JwaDdyc1p1cWZFRGFRcFp3ai9OY0N0bjNQdDFhSnRTT3ha?=
 =?utf-8?B?czhkTFArbkZEZEwwaFJORHV6V0tIMkoxbDNLTlYzR0N4YUVaSFdzUDQ0bmh0?=
 =?utf-8?B?ZElVREdQTEVtZ21DK1VUSldQZTUyMXNoRkpreFluZTRyTzBGRVI2c3BSSktx?=
 =?utf-8?B?WXF4WHFOU2pHU1pJbUJIQTFMb0lJV0lPTWhEZVVZOHM2dVp3V3JxMGFSbGlO?=
 =?utf-8?B?eDduTE1UQVE2eWNiUFB1a0lNcUNWTFh4MTRtS2JNTTM3YkhaK2crcm52RnlN?=
 =?utf-8?B?cDF6dU92T01qclpZcnhCMkZtektvUGl4VHlic3RLVW1yNGpXZVlOTThLMjZX?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KJM0d+LT1ivQUnnmZWr9dB27FKGYqbej4egSXgoMpa1SqyR/3Go6EL/BsxgGF8WZ5sFCPKoqBGlFKmbP3FiT6c1ApYZuzSnCdaveJON1AQIDKL/OomN+T17v9PHzezxy9DxIp5vynoeiA79p38aSGJaqq9AbNkSMJHzz4Chq3KG/xkbPZhm9n07iDZyANK+Of38GSdXCTki1ZdPYSFnh+Ex3KrPBATZJp96F9wugI+bWXGMk10xqGS6dY8tANSb+JuG8TU2kPe1Kg04XaBUnwydbDr+wti8olHge7VfkVrlH4oUxCaji/uhlnfAKHrgpegmocX0OAw+5XgEh/DzAqSONiJBfd7s+OmBLdTjQo/f+mUX1iuJnOQwgUZ+WKuUsnHScjYhdSeLUCCnrkmNUqLf3naopBsH/9pdQ/s6e24HD91w/wNxdhWOi8hh8OduSAd9nqJJ0EKNs3hPZ6J5NHDL4d/fWy9GYk7DCD7nEu0w0EeS2aGfeQu83lkq/miEo994/L2Im35JCipF54sXMbt9/R7srxXpAH3EDn1kuP/X2dDscCvyVxV7ECV5Zav9SaaBj/vb2zYWZC/OIs83Sc7WKgqXN9CE86AM4Eo4/Wlc0gcE177N3G30IU687l+VkRe5PNM7jSh/vHgrhwVrl6L/AxaapwAyS9Ctgiw8kaYI9HtaSLuXp3Xaxvo1vwlk4qbP411N79wETPRDpF7oFgmt8a3nftCxe3OJbsPMBrY8OnIl7SeS0EL58GBe6IDxLxzW+M6sM51fqiceLpElRK0FtSjFqsZ28RXhhiDEXRhg50o9dO98Wsz63ul03ek5GQVfLq2zjKb5SGGrnPx0VXE65S1QqFAIUEe841/AlKLE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648dd931-4360-46e6-4177-08db313414cd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 15:33:16.2613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKaVXpHvgUbd0dtr9moDQihAPtbp5iendsaeh6NcBRIgewO9TkXL+D1RiPRcbaV4ha68NVT1soqJkeS/BtGZSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_09,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303300123
X-Proofpoint-GUID: EsjPBaw_zOs46dq0eZLv8-9w_Ef68LOh
X-Proofpoint-ORIG-GUID: EsjPBaw_zOs46dq0eZLv8-9w_Ef68LOh
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------iQvsdEvozjrYhzSKisY9BUoI
Content-Type: multipart/mixed; boundary="------------BfZFQ885l74bI8bwQXGnO9Ko";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: NeilBrown <neilb@suse.de>, Bruce Fields <bfields@fieldses.org>,
 Jeff Layton <jlayton@kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <bc0c344b-8939-d55e-85c5-168b85e974d5@oracle.com>
Subject: Re: [PATCH pynfs] rpc.py: Don't try to subscript an exception.
References: <167996453785.8106.14290228013263156210@noble.neil.brown.name>
In-Reply-To: <167996453785.8106.14290228013263156210@noble.neil.brown.name>

--------------BfZFQ885l74bI8bwQXGnO9Ko
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjgvMDMvMjAyMyAxOjQ4IGFtLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0KPiBBcyBmYXIg
YXMgSSBjYW4gdGVsbCBweXRob24zIGhhcyBuZXZlciBzdXBwb3J0ZWQgc3Vic2NyaXB0aW5n
IG9mDQo+IGV4Y2VwdGlvbnMuDQo+IFNvIGRvbid0IHRyeSB0by4uLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTmVpbEJyb3duIDxuZWlsYkBzdXNlLmRlPg0KDQpUaGFua3MgdmVyeSBtdWNo
IE5laWwuDQoNCkkgc3RpbGwgZG9uJ3QgcXVpdGUgaGF2ZSBhIHJlcG8gcmVhZHksIGJ1dCB3
aWxsIGFwcGx5IHRoaXMgKGFuZCBvdGhlcnMpIA0KYXMgc29vbiBhcyBJIGRvLg0KDQpjaGVl
cnMsDQpjYWx1bS4NCg0KDQo+IC0tLQ0KPiAgIG5mczQuMC9saWIvcnBjL3JwYy5weSB8IDIg
Ky0NCj4gICBycGMvcnBjLnB5ICAgICAgICAgICAgfCAyICstDQo+ICAgMiBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvbmZzNC4wL2xpYi9ycGMvcnBjLnB5IGIvbmZzNC4wL2xpYi9ycGMvcnBjLnB5DQo+IGlu
ZGV4IDI0YTdmYzcyZWZmMC4uNTg1ZGIzNTUxZjczIDEwMDY0NA0KPiAtLS0gYS9uZnM0LjAv
bGliL3JwYy9ycGMucHkNCj4gKysrIGIvbmZzNC4wL2xpYi9ycGMvcnBjLnB5DQo+IEBAIC0y
MjcsNyArMjI3LDcgQEAgY2xhc3MgUlBDQ2xpZW50KG9iamVjdCk6DQo+ICAgICAgICAgICAg
ICAgICAgIHNvY2suYmluZCgoJycsIHBvcnQpKQ0KPiAgICAgICAgICAgICAgICAgICByZXR1
cm4NCj4gICAgICAgICAgICAgICBleGNlcHQgc29ja2V0LmVycm9yIGFzIHdoeToNCj4gLSAg
ICAgICAgICAgICAgICBpZiB3aHlbMF0gPT0gZXJybm8uRUFERFJJTlVTRToNCj4gKyAgICAg
ICAgICAgICAgICBpZiB3aHkuZXJybm8gPT0gZXJybm8uRUFERFJJTlVTRToNCj4gICAgICAg
ICAgICAgICAgICAgICAgIHBvcnQgKz0gMQ0KPiAgICAgICAgICAgICAgICAgICBlbHNlOg0K
PiAgICAgICAgICAgICAgICAgICAgICAgcHJpbnQoIkNvdWxkIG5vdCB1c2UgbG93IHBvcnQi
KQ0KPiBkaWZmIC0tZ2l0IGEvcnBjL3JwYy5weSBiL3JwYy9ycGMucHkNCj4gaW5kZXggMWZl
Mjg1YWEyYjViLi44MTRkZTRlMDhiYzkgMTAwNjQ0DQo+IC0tLSBhL3JwYy9ycGMucHkNCj4g
KysrIGIvcnBjL3JwYy5weQ0KPiBAQCAtODQ2LDcgKzg0Niw3IEBAIGNsYXNzIENvbm5lY3Rp
b25IYW5kbGVyKG9iamVjdCk6DQo+ICAgICAgICAgICAgICAgICAgIHMuYmluZCgoJycsIHVz
aW5nKSkNCj4gICAgICAgICAgICAgICAgICAgcmV0dXJuDQo+ICAgICAgICAgICAgICAgZXhj
ZXB0IHNvY2tldC5lcnJvciBhcyB3aHk6DQo+IC0gICAgICAgICAgICAgICAgaWYgd2h5WzBd
ID09IGVycm5vLkVBRERSSU5VU0U6DQo+ICsgICAgICAgICAgICAgICAgaWYgd2h5LmVycm5v
ID09IGVycm5vLkVBRERSSU5VU0U6DQo+ICAgICAgICAgICAgICAgICAgICAgICB1c2luZyAr
PSAxDQo+ICAgICAgICAgICAgICAgICAgICAgICBpZiBwb3J0IDwgMTAyNCA8PSB1c2luZzoN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAjIElmIHdlIGFzayBmb3IgYSBzZWN1cmUg
cG9ydCwgbWFrZSBzdXJlIHdlIGRvbid0DQoNCi0tIA0KQ2FsdW0gTWFja2F5DQpMaW51eCBL
ZXJuZWwgRW5naW5lZXJpbmcNCk9yYWNsZSBMaW51eCBhbmQgVmlydHVhbGlzYXRpb24NCg==


--------------BfZFQ885l74bI8bwQXGnO9Ko--

--------------iQvsdEvozjrYhzSKisY9BUoI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmQlq7YFAwAAAAAACgkQhSPvAG3BU+I4
Xg//XS/V30O1GixKx1UzwUp7diUrnTe39y3LGCkeU3aLXpA8gYOexk231h6hJysvkFSLnfUTQ1W7
H5f4Xemk1rqRqp+on291QnJVZyOQGGpaYiBuKbkeCNha5rPDvgqhenavOW+1DHeQ+zMjeJdJhnHc
Z0QopYmu4CyxRgFm4s/g+SENG6/H8FWgBIVF4uemduOcoUjl8tvkLyhYvUTox7ewXqauxLMAVHN4
RTlSDqsvILtiM490+86fQagpgHz1yxmgqjpMb8n67Hfz5uc4bO9HydEHr3rwwpp4SbATglgZqq0G
CQfF6GafGY8Ay+O8kPQzbmiAEw8H3CjQtoFBFysP8ymN8ZU1jrVIB7TSoOJob323FJ4fuL4snqoJ
q8TckpSvxQX2IFoTu9PkvatvwekBiyE7TNuTXQFIQERvPYWnPSPV9nO4dIu5xcmdOD2tK8ySqfhI
ZcIQ37/1Yz9PSvKVAH7URX+qI8Pvmp6ozoe2b1gZ4+k1RP7KpY0Afgb1MyEHYXSI6L6XSNAPY/Vf
fm6ht2W8y/j8KCswnz+mN7CEKwmQ1XBgxIZfrvApTN+df2M5q14QykutKVIVFMl/9P+CwbMj0A96
hSSg6u/PJCjgGVFQZ6v72yWaRswnFlhXPWGh8lwrBeA4kqBgazjAdD9FHkpbH6WGlnbbVPWNlDX0
c5I=
=dqnG
-----END PGP SIGNATURE-----

--------------iQvsdEvozjrYhzSKisY9BUoI--
