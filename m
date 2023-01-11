Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71833665A47
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 12:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjAKLdT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 06:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbjAKLb6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 06:31:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DC5B7FF
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 03:31:40 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BAZh0I022581;
        Wed, 11 Jan 2023 11:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kD3vyXYDgtNAQ7H9IQoSfNmjI9aLmwUEBHb4MZM1eHc=;
 b=W5KG/7IvwWLMbuULtFHHIOBFuKIZ4V0WcTcTVORreiTFK7TbO8eQMZoxf0YeMsLvwPwv
 fg4/mKv/MYtSo4cLKbFz6A24cLrpsnbEvUZdOuftI3BFY7W94Sniqc8CH5RPd7jDZbf3
 QxfhhLzqZqqzgZNWY5CIlnTdXFhq0g1TiL/StMtOsGtTqk3mZudA/wILq4S9U4Tl9SDq
 0JSiX7lFw4tN9tdZyKdfHGvqdGAEtRxpPV+/OvbhD5iDGo9v1twg7AGFfpv6bX9RLrHb
 aqodiSWiMcDXluaXrIps5JTB0msuhCY1MZDypdpgeNElZaw7YAi2FvxUk/LlMgTwIpxk dQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1g8513wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 11:31:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30BBVUSb029452;
        Wed, 11 Jan 2023 11:31:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4dk981-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 11:31:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvHHSvjYdkSM9+4G0XtObCUPUser3KWNjXCvg092vTeTTnv1IuJV+HApwSP2TEchyo+c0bhH5/K2rkuR2LyJp1nbP7yqBVkBHMQGV8ZDBAm6pIWKBzcpUBcQesmut+6Au7N8QaU4mzBbadQx1hFYD8hgI7mWlq1iDiarRBvIOIK2IXgmDKAbxuluBCDleM0nBtoIalYScbZJCav6Hoo7W/2yxtG9O7ai/+amJWM0oKVvuFaccVqPH00Ckf7WhcwH2gUiHFLRhknCFQ4vFkpC4FjdDujPCq0oV1UXbQmFhFP70OYPfaOCRfqJhFjWPls39ueB7DR14y2vbIVTYOd/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD3vyXYDgtNAQ7H9IQoSfNmjI9aLmwUEBHb4MZM1eHc=;
 b=OCVqqwKnT+EwIP71NPkEj6EqRGOC17bRtulHmMAWTVaryf/UvcsX+dsH+0noHkek2rPB2SO9VgTwSRbenWfQSnIhI2uqDWZpHIQalMKh5Yu+R87beIM/1IInVDkmlAvWg+KHVYIoiApmfmv1YTsMDfNXSpUTJ8+++dZnbrFsj2nzTNNMiSm01V1kTBOc7fe8deugvx2wLNhs/1CBpVD2SwSNiCuxgunK8wbs8jg7nIoM4FBYTh5ZXyrOeqUje2x4/WfrfjEF74ewpZscpjsK3Ki4UUoIEnRtQlkhQoyXDC+TAhVw90WRCzx025gFOodQotTe3PH17itptF4jmR7UZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD3vyXYDgtNAQ7H9IQoSfNmjI9aLmwUEBHb4MZM1eHc=;
 b=s4miHHVHUzRP9a9D/bCJn1R8JKb/86e7CIPqU7ID2lHp1BdRCkpclOtGGaMJA4ill+c2crK3gXmh+s6vkWDip82biIMeQ5ZYsRiVHVWjdkmEFnbRNJE+/P8Oy0oBuEBgnGAy5aaU6DpDZlCmD6Yq3fIeTLeYvIMZlES7a439cKI=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM6PR10MB4203.namprd10.prod.outlook.com (2603:10b6:5:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 11:31:32 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%8]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 11:31:32 +0000
Message-ID: <3b7b3462-0f15-58a7-b49c-eb563d20a8ec@oracle.com>
Date:   Wed, 11 Jan 2023 03:31:29 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
Content-Language: en-US
To:     Mike Galbraith <efault@gmx.de>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
 <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
 <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
 <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
 <5e34288720627d2a09ae53986780b2d293a54eea.camel@kernel.org>
 <42876697-ba42-c38f-219d-f760b94e5fed@oracle.com>
 <f0f56b451287d17426defe77aee1b1240d2a1b31.camel@kernel.org>
 <8e0cb925-9f73-720d-b402-a7204659ff7f@oracle.com>
 <37c80eaf2f6d8a5d318e2b10e737a1c351b27427.camel@gmx.de>
 <ce3724b88bb2987ac773057f523aa0ed2abacaed.camel@kernel.org>
 <2067b4b4ce029ab5be982820b81241cd457ff475.camel@kernel.org>
 <ec6593bce96f8a6a7928394f19419fb8a4725413.camel@gmx.de>
From:   dai.ngo@oracle.com
In-Reply-To: <ec6593bce96f8a6a7928394f19419fb8a4725413.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:806:28::10) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DM6PR10MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ac87b2-895b-4e01-6f61-08daf3c76397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbGC9ePDMY4ZK1xkyzIzeVXIYYQGz9Wke8BFu/+C8Iqc9arHGT2buRtGi1Nmor+40Pp4p2WV2BGndbPvsftBOuZX6JmcFJ8VlYZ9PBTuUF6kTEqZaLJT+PNldysXqoTg96cGloOe1Yt07XBmcPLTNhvsTsaaTL6srPDluHloLpTZ/URrZT1qC6r5mCKgeyAf/Fn8OMMmsm14n/UED5ogfn49mj3ZT4SA1Scv/ftm8SwmiOJ+54W3ZRwsuDN3xIwuxFutk4fCGhrnsZ2+6O69Pm71CY0OPZgv/TxW9P8VV1S86icl8SeZQhfxvNEbCuIdkiS+6HpHN3Lew3rDphgsLuRkqnDsjv7SsnHUO4tuDL6djofnSc/6VO20sP7FDCR/xPaDyjyq0DQ3LCzPoKCJzoE6H29tVO4RCB4ZQK59EM0geeY8+UJrPzJEuGT+V22f0BrkfUS8+3mP7HRSUc3zuohXy7Zd55EKnj9IMDDVUg/mE7Ki97lyD4tIbL3P74hrKh3SYae6T9gTod0EvLRBZ424uwj5aQkpbszplKDM2UdK1OEaNerlZ98XDQOV6MJxfDpfzetVbfNINGZCRsKCyl/EHtep6dJbaHzJ4IHc0G1faHNgx+24T2wpDjeisXKswT3Zwdiv7MoL7afGu0qRKQA9YUqFHXLL8K94L7BY3GqRfUmPM3qllF9SEQzq2ujK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(9686003)(478600001)(6486002)(41300700001)(38100700002)(6512007)(86362001)(110136005)(316002)(31696002)(2616005)(186003)(26005)(66556008)(66476007)(66946007)(8676002)(4326008)(36756003)(5660300002)(53546011)(6666004)(6506007)(2906002)(31686004)(83380400001)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm42SkUyMkdPVFF6ejBNeGZQYUhiZGJrVDFwUFdxTStEV2lJZkY0alh4OUV6?=
 =?utf-8?B?b2dYTldyOUV4K3Fyemo5bzdkNkhRUGErOEU4bXhhQnpFSFRMaFZrRlAzVXgy?=
 =?utf-8?B?dWU0eFltQXRPdjFTQ084TjZpSXpVV3hwK3FmQnlmbE9mTGpETzYrajZiMlFk?=
 =?utf-8?B?L29BaVk0N1RRNFo0R3ZhazhsRWRla2NlU01JT3lLKzNvN2prZWFBQXBuV0Zy?=
 =?utf-8?B?NXZWQWNuTWIrMGsydnNtb01rQkhsV0JBSlUvN2x3WnU4VGVlSkkyTm9PaGty?=
 =?utf-8?B?SjFBQ3J1bzAyTWNEQTZhclorT0w3K2NGOHB2bTNJVFNWYWFBLzB3ajdsY3Q3?=
 =?utf-8?B?STFnMWNDSDZFb2d0SytHczZ4SzVIUXVkSDBwN2d6VDVYRG5EZitUMitZeko5?=
 =?utf-8?B?OTVrN1R0VmV1eFArK2pHR0hvWWJRelBaUjRiRUhhR1NFa3VhUFNZNTYwZHIy?=
 =?utf-8?B?R2N5bEhuL0NvOG14dURxTU9xYkFCMGtBdVZEYStnUDVUQlRuMlcwMytrNzAy?=
 =?utf-8?B?bFljTEs5YTA3Z3NheGRUZXRiUHo1eUF6c2ZNMkZrU0JGVmpCRDNWNTlIRTNK?=
 =?utf-8?B?bVZMK1hINm54WEkreU15ekZzNHcyQTR6RFpTaVlXQXM2S0ZvdVV4RzZ1UWxl?=
 =?utf-8?B?cThDY2lqNG51RWtlSTdJU1Ixa3NLc2hoNWFjRXExM0l1U1pWMFBaMnp3U2xO?=
 =?utf-8?B?eEM5YmNBWFUwN3k1V2k1bUZHZnFmY1ZnUk1MRmQ5ZXl5d0ZyZStpR1d1eS9w?=
 =?utf-8?B?Uy9aN3VlZ21kV05XNXpwZTVaRi9aSktWQlhUTjRFaXdmUmRnZjZGem5Oc2E4?=
 =?utf-8?B?a1Vub3BPQi90WlVNRTNpcjRUWGZTMTNzWDR0VmJEUlRmTlFRa09yamdtaW55?=
 =?utf-8?B?eXdySkYyak8zOFk0UmY0L0oxeWYyL0ZqMVhycU15T3ZhbzhydnloVHRhK2h6?=
 =?utf-8?B?MTBlbUpDek8vRkxsQzJGWFNvQ20xejJpNWJpa2t2cVJlZFJiY2pyWnhmOGlw?=
 =?utf-8?B?WW16TmhDRmVTbzJvWlFicVE4QitZS2ZKN3lZR3FQbGc4eGZBaXI2alZJbC9W?=
 =?utf-8?B?YmUzaEQwYlM0dEtMeEVHQXdMejBLcjQ3UEVtM0g5Z1IreGU5dExZU1pNeWlL?=
 =?utf-8?B?UGtBZ3BqSFhpTm50U052NWx6RGVoSHN3a2FQZE5zMURrbVdzakp6aFhGNnpQ?=
 =?utf-8?B?MlBTMW0xRjA0T1dWRlp4eUZ2V2NqS3pQMkcvVDh3QzErZkFEcWJjWm92Mkgx?=
 =?utf-8?B?K1o5b2hXdUlQV2pGL2pxb0MxVk5Jb0ViZytOMGdFUU0reitPVXI5c294UVdB?=
 =?utf-8?B?Q3NRazJ3RGpkVkFheGNEb0oxSmszSjljQ1M5V1J1Z1BtSmhKYnRvcDhDVTBZ?=
 =?utf-8?B?Z0VrdE04T1NRZHhNeUxEenRvbkpNRTVrSG9sMHBSeklHUUZhblFXQXhCYW1I?=
 =?utf-8?B?Uk5RUWRVQVpkVU1kSEFIV0I5cXA2eU02WDJPQ2xYbEdTQndUS1N0bFFLclhu?=
 =?utf-8?B?eDdGRTdzcTB1YWZucVdOYm1wT1g5Q0JGZXNoOXo2ejhVZXZQQjB4RVRxVnZk?=
 =?utf-8?B?WTJRN3BqdHhXeXJ2bzkrQjFINW5QTWJVRlcrVFo0L3JncU9FVmFKR1M5N2NK?=
 =?utf-8?B?bHFnOGtUYmE0UWk0WWFCU25DNmNRcGptaEtsbHorS1QvVFZ5ZUdWRFEyT1p3?=
 =?utf-8?B?Y0d2alA2Z2trd1F5TFl5c0w1VmZzWk40UHhrWTBla3dvR015WFNrbHhKRjZZ?=
 =?utf-8?B?NUN6UENudDNhWkZyYzJ1OWc1R1hsV1VLYmVFR2ZDeit3R3pvS1JPODMxY0FB?=
 =?utf-8?B?OUNZRmZacDdYc2VVdC83eGt6UTNrTnRLSXNyY3A3bm1SUWt6elp0ekRYYjJB?=
 =?utf-8?B?V21yYVpLb1hIQTNaWmNuZnFseHo4V0ttRHJBMXpnY0RxNDlOQjFNbnRyb01W?=
 =?utf-8?B?ZUhNN0JWaXJRem9YQjdYYVcvbUE4UXpHcERoeGVubHhWRm9ZOC9hbnRab2dT?=
 =?utf-8?B?Z0F6ZGZNUnQrcC9Md2dId0JTUldra1BTYlNKVm9YMGd2bUVGak9qYytvcXFL?=
 =?utf-8?B?ZHZ5eWtOSWpoTEpxV1JHbDJsQnFxam84N1Z3S3hKNTB4ZDNVUFlCZi96dUFa?=
 =?utf-8?Q?9UANs3K7JL1RWMqIcl1YRkE5G?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LIhP4rPhsx4+roBHFemJET/XU4C8VGd2yoXwNiJKRtx173oPpYrqvEz6K8Qsr7fLOJkqGtmQqtMjipBDoY23pkP1G8z90t1znxEZi4YenWtSsRU8wUdzeL2gfiPHzGaezmnIeetIsk+pMORmXz/JtAgL4pHGE6/wO33UMkfhJZK8edW2X5KOdnzw3kKGqwX48KlqPn/+KvJmw12MP6Hw/VDhK2bzJl1EImP4gyNaEHPemsF1lBP+lsjWv+KuoiuWbQk/BkUw/YX/5YfgRIgIku3ZRygl05jiwvlUYXd2KQqt275DNvte/bj3KqYQHllq2aWyL+pFBFdy5t/GgB7lKWlyyjt17o3FNVHQX186JocpKqemQa3FlDQi3kWdU79iOkUfHLE1Rxwo5MrkC+VbpZslHSF6/QGrjWAqyevpdbSMCm1OBHPC2UGFu4lNJjCHMJmqYKFBz4bCsoes7TZBSf8YfqvYfXWbHLDpJUZ0AKiPSZG9OFVh0rTPRgz+OYKslVcBy+C8sFsnjtJAFBUsRRGP/vDCQxmno5I+fVgA24W2BNXRiDLtKeylD2OivPVX+8pucrGsGTq6aD+9siAVQzjEou+hbaTga8KjQdbAfQ2plnLlb1FcN4Apce3LCc9O5lVn1ZwFsGMMmaXwsJKn2dx5sVlbj0SlmYxHFtbv3i1m48llGlDQc8e/aW/36hMOWVHxfX2tAzjmrR+eMFZm//qRxUl3ewiylQGCukvzoOJIrx7p/lZGlWuImoYQaOAxWFiTPyDMeyVrPm+zi+nkbFc8yoKMnBYHDab3nnOsPk6KaWpnf3r8Qma53h3adzk/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ac87b2-895b-4e01-6f61-08daf3c76397
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 11:31:32.2818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqfwtsGiXpph/jGJoHAuc+E6O1yarusuYK7w2W/P9AxldDS/Jv0Y1/PgLXuBAieRgSa25VOzIreyb4RbBJljYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_05,2023-01-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110085
X-Proofpoint-ORIG-GUID: 6Qy8Tmrp8E1dnpMw1PpSuvPimyle3E9D
X-Proofpoint-GUID: 6Qy8Tmrp8E1dnpMw1PpSuvPimyle3E9D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/11/23 3:19 AM, Mike Galbraith wrote:
> On Wed, 2023-01-11 at 05:55 -0500, Jeff Layton wrote:
>>>> crash> delayed_work ffff8881601fab48
>>>> struct delayed_work {
>>>>    work = {
>>>>      data = {
>>>>        counter = 1
>>>>      },
>>>>      entry = {
>>>>        next = 0x0,
>>>>        prev = 0x0
>>>>      },
>>>>      func = 0x0
>>>>    },
>>>>    timer = {
>>>>      entry = {
>>>>        next = 0x0,
>>>>        pprev = 0x0
>>>>      },
>>>>      expires = 0,
>>>>      function = 0x0,
>>>>      flags = 0
>>>>    },
>>>>    wq = 0x0,
>>>>    cpu = 0
>>>> }
>>> That looks more like a memory scribble or UAF. Merely having multiple
>>> tasks calling queue_work at the same time wouldn't be enough to trigger
>>> this, IMO. It's more likely that the extra locking is changing the
>>> timing of your reproducer somehow.
>>>
>>> It might be interesting to turn up KASAN if you're able.
> I can try that.
>
>> If you still have this vmcore, it might be interesting to do the pointer
>> math and find the nfsd_net structure that contains the above
>> delayed_work. Does the rest of it also seem to be corrupt? My guess is
>> that the corrupted structure extends beyond just the delayed_work above.
>>
>> Also, it might be helpful to do this:
>>
>>       kmem -s ffff8881601fab48
>>
>> ...which should tell us whether and what part of the slab this object is
>> now a part of. That said, net-namespace object allocations are somewhat
>> weird, and I'm not 100% sure they come out of the slab.
> I tossed the vmcore, but can generate another.  I had done kmem sans -s
> previously, still have that.
>
> crash> kmem ffff8881601fab48
> CACHE             OBJSIZE  ALLOCATED     TOTAL  SLABS  SSIZE  NAME
> kmem: kmalloc-1k: partial list slab: ffffea0005b20c08 invalid page.inuse: -1
> ffff888100041840     1024       2329      2432     76    32k  kmalloc-1k
>    SLAB              MEMORY            NODE  TOTAL  ALLOCATED  FREE
>    ffffea0005807e00  ffff8881601f8000     0     32         32     0
>    FREE / [ALLOCATED]
>    [ffff8881601fa800]
>
>        PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
> ffffea0005807e80 1601fa000 dead000000000400        0  0 200000000000000
> crash

Can you try:

crash7latest> nfsd_net_id
nfsd_net_id = $2 = 9                <<===
crash7latest> struct net.gen  init_net
   gen = 0xffff97fc17d07d80
crash7latest> x /10g 0xffff97fc17d07d80
0xffff97fc17d07d80:	0x000000000000000d	0x0000000000000000
0xffff97fc17d07d90:	0x0000000000000000	0xffff97fc0ac40060
0xffff97fc17d07da0:	0xffff994e7bf87600	0xffff98f731172a20
0xffff97fc17d07db0:	0xffff9844b05d9c00	0xffff9832a6a0add0
0xffff97fc17d07dc0:	0xffff984a4470d740	0xffff984a93eb0600    <<=== entry for nfsd_net_id
crash7latest> nfsd_net 0xffff984a93eb0600

Thanks,
-Dai

>
