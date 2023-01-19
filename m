Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08366674119
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jan 2023 19:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjASSjJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Jan 2023 13:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjASSjI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Jan 2023 13:39:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC508C922
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 10:39:06 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JGwxo7025485;
        Thu, 19 Jan 2023 18:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Y0yTPkGLDspDL66y8ltrZusB/e5h1wBMsq8StUeDV9Y=;
 b=2qn7JfmLLfEsJPA8al/kbuvcCXK+L2VzjklUpfaF+A7TL6/ZhP2rcxtOq9l6tfFbywRC
 UNG/VdKmVimd/dOALkzEj+t0XqWJemn7jomPLt4tE5UMULODWCvbbQTXTUg8bg/LXSvg
 SXmXyB4aOBTePT4yY+5J/DIIYUEiJsK2GBuwsVmlhMd1oVDUNfkOm1N7J1vEr9L8r4Vm
 3G9sfNqR+XK4/vM9hl6FlwlWbVkn9wbcFWD0FIxYw6l/PbwbrjWQqMMFBuODAnBoyEaC
 3CtYkoMenAVWkWB99ugp6kuSiLYl43fUMWCzSBIKs//JOBqsm9PuGqeYgasllWdumhnz eQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n78958js0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 18:38:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JHshbP004673;
        Thu, 19 Jan 2023 18:38:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2usppk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 18:38:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfbwrIBtbwjQXAsO09gaLjvVDZ7/OxLiq554ZcaWFvt4WeSd6wTGWA8C36XaJAbds7pYtAvRn/ebllmnbL32Ho/wQGzsj4YUrDw59gB+CaaDKk51TPxGzP2OkwuE8/FEDMtTTpWJPgAb4MvhI0wGjStbdZ1w37P7VvJE/MFsRbogrnrXUXBP/C4C/xPq+AkSNxy4q8HK7hXQjSmkcsJZg0MutdXTx3e2ak8jG2EvjD6PrRZTwVnkHbGa+JVJy64jLlTqoaKVr+P2zLbcXACA8u861cPicC2lm3lR6LIYqVISiN78huTikoUEni+LOBjTr5Zu9v3PJZ998/bbCUrcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0yTPkGLDspDL66y8ltrZusB/e5h1wBMsq8StUeDV9Y=;
 b=QgoSMJ5d2+BfskspSzwigq8w0nz2MqksQH9NF3UW9seGaZAlZjtAjCcufP0GNzTIlA8xcmjdE6GUxXXMzDhYjKXGIAH2jb/2gWK7108n7RmKxJ3uKEOBSdDXMiNhe/bRyDo53AILpkOrF/345iqaLwCTiHuii6yQtgaRnsGGJz1BHK/eY6tAPV2wQylrMI4hyS06jg4QuaYNjM3yntkcJIOMLXvCUBtL+h99AyWB1MDZxMBgMhS/c7oOUn1L+6mgBL69izbFhmfQtFFDJJO/rkeDnLtnDknApe2tI3Wl5zBy2O1i/SBsbv/a45c2yi1Z5a2QUeTHwKW1X98SXGqM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0yTPkGLDspDL66y8ltrZusB/e5h1wBMsq8StUeDV9Y=;
 b=M66zz6MphRXu4VkzTzjIFxCW2dqbvhftqWXF27tKDtdoQbbEGkxFZBrMd7ifAL6uCff3ocrXvoFvTfHDXuzti7M85aEeT4u1vOlBZUaD84NolR4SXi2W0t1jFv4PL6r2RKhuP2ygF+v6OOdpUORCuHMbAYLUBucbH1rR7wcFZTI=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BL3PR10MB6185.namprd10.prod.outlook.com (2603:10b6:208:3bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 18:38:53 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%8]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 18:38:53 +0000
Message-ID: <3ff5458c-88ab-18ab-ebfe-98ba8050fd84@oracle.com>
Date:   Thu, 19 Jan 2023 10:38:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, aglo@umich.edu
References: <20230117193831.75201-1-jlayton@kernel.org>
 <20230117193831.75201-3-jlayton@kernel.org>
 <9bff17d4-c305-1918-5079-d2e9cf291bc7@oracle.com>
 <eb5a9fa65a8c2bcc257101c96f7fbbe18a3b74ff.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <eb5a9fa65a8c2bcc257101c96f7fbbe18a3b74ff.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:805:ca::16) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BL3PR10MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a084f5-767a-4cc7-4b13-08dafa4c6a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dRElT/pWMeV72MFJAJVQM7/TwTepnVTwb/nsGOD5evVQpdTPL+gnfHkD8NWV4ayPQraV5plwCNqKTOLUlZCZzIaS6CvRZ/CU/7L2VNCzTNJxDF7mmvRFtQ5TUlAXp5iLryPaicOGebgcpD7R+EB780SXf9sO2vpSa1dut8snE93RAgz6+ggq7j/nJQ/vVFytiHIrAP5iR/U+WHzx6taxNwdkA6xfSsmHeOzehDJHyTnZGNlJvNLET8sUQKyzcfIXX0dEdLXnuBcqDet0qRCXpSUVBu7Hymuv9r8Rzq9efHTEULeE/+2BOPFG7Bqu0meI472aMBew7u9Y1SeDJ+nkFIOjhPxOw5K+aC4YBevVOr45t9c1daU9jJ/rbeEcXRdvJRWwNlDnDpYFPCAq2mFtbCRa8TKLXoR1jcQwxJQJW0DDPfNBm+gwCYXAQDErPCzB02hoezU516W3+pT9F8WXqdS/blZv94U1lb4MhSqkoV/JmQMz2HIothpDY9ZqcrffQuWgrtkqFRUefQAHg/UiGSmJ/lgiwrA9HfoqgVxE2qgKueu3MljAtbqhWYhHQecNkGQLSY52UL9OCOH0U1JLUNJ78aN5SwkvT3T9BX8BMsQJzyEWDDItKurBIBv4o+UwQdyxBuKPJo9fCgZAH3LfNnOLmgOeSVmk/a84Ff4X4J7QGteAFVbjfHYjyZO2HK82
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199015)(2906002)(8936002)(4326008)(316002)(36756003)(83380400001)(41300700001)(5660300002)(8676002)(66556008)(2616005)(66946007)(66476007)(38100700002)(186003)(26005)(6506007)(53546011)(31686004)(478600001)(86362001)(9686003)(6512007)(31696002)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlnb0lyU1AwQXJOUk9GbFB4ZEJZKzJaZ2JDSDdyd3o1ZlFrVmlLbHpDTDdr?=
 =?utf-8?B?eGFTdzBnUlBoNjl6cnJ5aXAwVENmNzRHdkliaXgrMU10OWZzOGltOGdvVEZ6?=
 =?utf-8?B?RmxTamFwK0VFN1p4ZjZRQUxnNW5QT0hlZ2QxTDdKaWxLTUxrQ3BrcFF0aEo1?=
 =?utf-8?B?TjJ4ZUFidmtDaDYzYnVuZjMweE5yM3V1Qml3YUVlaDlROHppdEF2cjkxSWZO?=
 =?utf-8?B?emloWDlZaDdXdUl5ZmpmbXI3UGxzL1pweWloZS9FZzdPSnNkS1dzNGVPOWl5?=
 =?utf-8?B?T0JLeElsZDhGbTdjZW9vU3FKdERyOFNKWVYwY1FLcnl5bGZ3YW1iMFhKeHBy?=
 =?utf-8?B?RzhzVGtwMjBDczlKVk5pb2VZVStXVkxqbjdiTVFReFZaWDBDQW5XL09KSWFJ?=
 =?utf-8?B?eUY2WnZPa2JVRTA2b0xhU0VTUVpJMFFZelBpM2kyaU9wY3Z4dEN0Zi9jSHF4?=
 =?utf-8?B?aEZkM0c1VHJlSGl5K2F0THlTV3ltRE5UV1RvR09DTU4wSEV2NzBrZGNtUStI?=
 =?utf-8?B?b0JwM2d2UnQxR1MrdS9uK2hmY3hjQ1N2cEpJT3pwY0V5VjRHR3l3Nk9sV3lm?=
 =?utf-8?B?bTFGcWl0ZjFXR1h5NkF2UFU2TWJRMDdVRUU3KzBVTWRRK2xqRktQYlBvYnR4?=
 =?utf-8?B?MkxVczVTNGdHcE8zNTJIRlpyNStuZmRiTmJZczdFWVQwSzNWNFlJRHZhUTdZ?=
 =?utf-8?B?ZmQxQVAxSk9NOTdSOXBHNnJ2ZGRISFArcmEvZ3dFbC9hVGpEZ3BNMCtKOVJN?=
 =?utf-8?B?UngrYXRVM1c5cnV4dEVCZjhjdmdYbDN5UjZOK0hzRVVXeXJ3K0tQTlRPSDlq?=
 =?utf-8?B?RHVxQVpITU4zSmRUdkFDMThVTjVSVHBWVGJ4YUN5eXFNd0haUUpSUUR0Q1cz?=
 =?utf-8?B?d2w1ejhvcGFSdkVxaXNnbHlKRWRjYUFtek1qaFBjNU9acWQzbUZjWGF6RzBP?=
 =?utf-8?B?Tk5ka29sdXVVanIxOHMzMC9SVENtUGs2VnRENHJ2OVBaV01pQlF1dEZkQU9z?=
 =?utf-8?B?enZPc21Wc01KWmUrcFQ4T1hOL0sxZHdJMjhFSWNQUzhyK0o2Zyt4ZjJhT1ZO?=
 =?utf-8?B?UU8wQ0FRMkpndDk5bVVZMGE4MWsyclFxWGlNWVFaSkgxY1lxZmhiaVNXaVdk?=
 =?utf-8?B?VGNZQXVHV1M0Znhaby9Ea29ZdnUrLy9zNG9lSkliUXoxUEZxMWxubnZmQ0pl?=
 =?utf-8?B?dSt5ZE9mM0dpNzhMdDNZdjZaM0tWdnZBbTNENjExTHdNWjRUOWRDNFJPTTdw?=
 =?utf-8?B?VGlYSWk0akpXZDluUWIvemxRUC9WU0dEeWxadTVRVVVtNk9JbERyOFJUME0w?=
 =?utf-8?B?K0hnVUFFSHAyV0MzcU9IMWZoTlRNdmMvb0NJVU5VM2F4ZyswejZnL0pVekky?=
 =?utf-8?B?WXp4cFkwaUdCS1ZibzBvQ00rOUhvQmROcmw2RWRvTENRZXRlMS9GejZ2Y0NM?=
 =?utf-8?B?K2plajZjY0xCVWlmSzU0My9hSGpEeUpSWE5GVDhLVXhOOXlsV09ZY3ZOZHAw?=
 =?utf-8?B?QTRKdXk3UldIMk9DaDlsZUZDUnVvd2kzQTExUE1oSHpJcUtQVEJUdy90OUda?=
 =?utf-8?B?S1dWMERMTmMveE9kQmowUUZUT1g1YkdsNmN5QmVmOS9QZHB4WUlQTHV1UEx5?=
 =?utf-8?B?eTZTaWpyOFJHMmRkVnljYitiblcvdGtHTnNaYU02WUQ5RFBDbTdtcU5uYjU3?=
 =?utf-8?B?RmMzZmM2bzNOUVBST0xBd1gzUlA3L3dYMkd3ME44TkhHZXJURldmdUlRQ2pN?=
 =?utf-8?B?MGxON1JYNFVVaHErTS8vTTFleWhSc2tWY1B1WWdZdlVwajMybUFCd1BDNGph?=
 =?utf-8?B?TElaZWJqMG0zaGJJenRTUVJFM1dMQytIMGoyRDUrZUt5dUxydmFiMlpmcnpJ?=
 =?utf-8?B?WmRHNXhCbEdZUnpNemVFbTBGdmEySVkza1htUjZwaEtlWGtUNzBLRGRZTml1?=
 =?utf-8?B?bmFLZEQxTjhTMmQyQWRRV1AwakZjZC8wUkhZSWRZeG02d3BxMytmcjllYmln?=
 =?utf-8?B?WWpKWmpNTFUwMkVGZDlqRSt4WnNXNnpjd0FKUXRkY0c0OE1SNThJL1IvV3Q2?=
 =?utf-8?B?cVN2US96ZmRRZFE0UExrV1NRc2k1TS80MnFJdFFWVU52Qnl3bzhScVhWVnV5?=
 =?utf-8?Q?eJyTjCmJhxSItTxb1QR9aQgty?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SX51DHJqhMUYIwOhTY2x5k7blNiEqUX8I8RjihlnioHFZw+yRiWDgiQ4UNL9aU/s0WlMl3DRydT7a30y/5OwXaEbQ+uf2UjBcFWzZugIKSDQv0cK23UCFws9dgNtzhFgXBKgMFqr9l5Z4pTVKz+xyuS30sUhUWCXhGrD0/hAlH0T2cat0UhTTucbAFowxc5NWrJ4+aSjJPorw6SawiIVvD7HZ8cZDnmd1xNz55iK7ofrQt9J1YBfd3U+SFJpKIn6Nf5BRGFzO6RlRcfxeuhSTWqNv4pIXTqUJ77pzzTOxQv7Rwk547tJe0Eu4cQbSxtW17yhNla4cuw7hpU6oM8C0pFnD5wJ4rJfZHS8YWHDF7jyC/NeM+E07sXNHUSi8wRkmZCsQiNdseMbKRSzOwzDOa0lFoZdCWIt75jBeii226adiowwXFkHgFQWn2IxJy/DN5OGAN2V7w/DckLUFbJHZsMGuslmTVDnqw3ks0DFw43ntE1EVXNuVpnmrIsMW4IxXcMqQieX3XvnnPUvF4uMoBULDOPYF89DLcK2UnPfpoYEO0w6q+a6EdqGnMHQQfcrNcffA4PYi/LIUSz18NKC25YUD5EnuKncG18MeF7SWvaWukiQG06YGH7dB4S4PGvcZv/KERO5df9ELtR2tHglxVSsjzycqbMVHU2eVPx9a4PPxez4hMd4qFdLlRIx4hh/wv/QJB7/EVmSfX8i2DfwXEEsrmNxqoNYoOD7ZVRgwIsx3jyVMpGQYctKpngdNlDAf2U6/KG+F7BFvNbuCBwBN6xMJaW4AhEGIFAdE+C56przPhQattthSYsgyliHSuIV
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a084f5-767a-4cc7-4b13-08dafa4c6a30
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 18:38:53.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPC777/u7ctPhNRhOQwfzgyRRE2dd93lrg7MaI45ERbTVVofctXxImARlUBkETQ9lvXdC8BB6ZBnKkVk39n49w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_12,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190155
X-Proofpoint-ORIG-GUID: l_7OluYd9C7gSehpwpzhFclqq-fXZQgz
X-Proofpoint-GUID: l_7OluYd9C7gSehpwpzhFclqq-fXZQgz
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/19/23 2:56 AM, Jeff Layton wrote:
> On Wed, 2023-01-18 at 21:05 -0800, dai.ngo@oracle.com wrote:
>> On 1/17/23 11:38 AM, Jeff Layton wrote:
>>> There are two different flavors of the nfsd4_copy struct. One is
>>> embedded in the compound and is used directly in synchronous copies. The
>>> other is dynamically allocated, refcounted and tracked in the client
>>> struture. For the embedded one, the cleanup just involves releasing any
>>> nfsd_files held on its behalf. For the async one, the cleanup is a bit
>>> more involved, and we need to dequeue it from lists, unhash it, etc.
>>>
>>> There is at least one potential refcount leak in this code now. If the
>>> kthread_create call fails, then both the src and dst nfsd_files in the
>>> original nfsd4_copy object are leaked.
>>>
>>> The cleanup in this codepath is also sort of weird. In the async copy
>>> case, we'll have up to four nfsd_file references (src and dst for both
>>> flavors of copy structure). They are both put at the end of
>>> nfsd4_do_async_copy, even though the ones held on behalf of the embedded
>>> one outlive that structure.
>>>
>>> Change it so that we always clean up the nfsd_file refs held by the
>>> embedded copy structure before nfsd4_copy returns. Rework
>>> cleanup_async_copy to handle both inter and intra copies. Eliminate
>>> nfsd4_cleanup_intra_ssc since it now becomes a no-op.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
>>>    1 file changed, 10 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index 37a9cc8ae7ae..62b9d6c1b18b 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *nsui, struct file *filp,
>>>    	long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>>>    
>>>    	nfs42_ssc_close(filp);
>>> -	nfsd_file_put(dst);
>> I think we still need this, in addition to release_copy_files called
>> from cleanup_async_copy. For async inter-copy, there are 2 reference
>> count added to the destination file, one from nfsd4_setup_inter_ssc
>> and the other one from dup_copy_fields. The above nfsd_file_put is for
>> the count added by dup_copy_fields.
>>
> With this patch, the references held by the original copy structure are
> put by the call to release_copy_files at the end of nfsd4_copy. That
> means that the kthread task is only responsible for putting the
> references held by the (kmalloc'ed) async_copy structure. So, I think
> this gets the nfsd_file refcounting right.

Yes, I see. One refcount is decremented by release_copy_files at end
of nfsd4_copy and another is decremented by release_copy_files in
cleanup_async_copy.

>
>
>>>    	fput(filp);
>>>    
>>>    	spin_lock(&nn->nfsd_ssc_lock);
>>> @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst *rqstp,
>>>    				 &copy->nf_dst);
>>>    }
>>>    
>>> -static void
>>> -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_file *dst)
>>> -{
>>> -	nfsd_file_put(src);
>>> -	nfsd_file_put(dst);
>>> -}
>>> -
>>>    static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
>>>    {
>>>    	struct nfsd4_cb_offload *cbo =
>>> @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
>>>    	dst->ss_nsui = src->ss_nsui;
>>>    }
>>>    
>>> +static void release_copy_files(struct nfsd4_copy *copy)
>>> +{
>>> +	if (copy->nf_src)
>>> +		nfsd_file_put(copy->nf_src);
>>> +	if (copy->nf_dst)
>>> +		nfsd_file_put(copy->nf_dst);
>>> +}
>>> +
>>>    static void cleanup_async_copy(struct nfsd4_copy *copy)
>>>    {
>>>    	nfs4_free_copy_state(copy);
>>> -	nfsd_file_put(copy->nf_dst);
>>> -	if (!nfsd4_ssc_is_inter(copy))
>>> -		nfsd_file_put(copy->nf_src);
>>> +	release_copy_files(copy);
>>>    	spin_lock(&copy->cp_clp->async_lock);
>>>    	list_del(&copy->copies);
>>>    	spin_unlock(&copy->cp_clp->async_lock);
>>> @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *data)
>>>    	} else {
>>>    		nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>>>    				       copy->nf_dst->nf_file, false);
>>> -		nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>>>    	}
>>>    
>>>    do_callback:
>>> @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>    	} else {
>>>    		status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>>>    				       copy->nf_dst->nf_file, true);
>>> -		nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>>>    	}
>>>    out:
>>> +	release_copy_files(copy);
>>>    	return status;
>>>    out_err:
>> This is unrelated to the reference count issue.
>>
>> Here if this is an inter-copy then we need to decrement the reference
>> count of the nfsd4_ssc_umount_item so that the vfsmount can be unmounted
>> later.
>>
>
> Oh, I think I see what you mean. Maybe something like the (untested)
> patch below on top of the original patch would fix that?
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index c9057462b973..7475c593553c 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1511,8 +1511,10 @@ nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *nsui, struct file *filp,
>          struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
>          long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>   
> -       nfs42_ssc_close(filp);
> -       fput(filp);
> +       if (filp) {
> +               nfs42_ssc_close(filp);
> +               fput(filp);
> +       }
>   
>          spin_lock(&nn->nfsd_ssc_lo
>          list_del(&nsui->nsui_list);
> @@ -1813,8 +1815,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>          release_copy_files(copy);
>          return status;
>   out_err:
> -       if (async_copy)
> +       if (async_copy) {
>                  cleanup_async_copy(async_copy);
> +               if (nfsd4_ssc_is_inter(async_copy))

We don't need to call nfsd4_cleanup_inter_ssc since the thread
nfsd4_do_async_copy has not started yet so the file is not opened.
We just need to do refcount_dec(&copy->ss_nsui->nsui_refcnt), unless
you want to change nfsd4_cleanup_inter_ssc to detect this error
condition and only decrement the reference count.

-Dai

> +                       nfsd4_cleanup_inter_ssc(copy->ss_nsui, NULL,
> +                                               copy->nf_dst);
> +
> +       }
>          status = nfserrno(-ENOMEM);
>          /*
>           * source's vfsmount of inter-copy will be unmounted
>
