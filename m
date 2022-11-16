Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCEB62C841
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Nov 2022 19:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiKPSx1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Nov 2022 13:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiKPSwi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Nov 2022 13:52:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898A65B5B0
        for <linux-nfs@vger.kernel.org>; Wed, 16 Nov 2022 10:51:11 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGH4cUU016352;
        Wed, 16 Nov 2022 18:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GIu5JDmA86AOL1XHvZ4//RxUz0oprzLoeMp6ZJD4jAs=;
 b=efX3WL6JOQ/+pL5zKtMKB/7uBqBinSPqvD6toxjZXGuyfaxfu//opt11nolNHFu9av9p
 TJlLJYtwFwRCgzzkkTzR1OQjrHm6sTipt0VhbJHIa4OaeWoXTwcsl5jJpLhL7GLkRV8j
 ubRIjgrajoywQgB2XsKFKmTpCcT2/MVZ/y80vd3WLXhLd/t0rG8Z5BSX9hnOzeJ4dtSt
 wrGYZ3tQn5oQ1ywJNvjEO3nxuTL60I/oXGlecw6d37mPGfg1nukjubmmWR1jSvRWHJOk
 8shwKS+Kv7XZ1/9K81yjOY02WIX9cbaoNmuaIOxHskOjf48JD76mIqmaxIVBvD8/y9jF ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8yknm94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 18:51:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGHxGuT012455;
        Wed, 16 Nov 2022 18:51:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xe6qmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 18:51:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmKVlz5tKY0Yp3q18DIwivufVsmXGsG594tUa7pjV6BI77+1Ni/KWotR5vvifO0U6C53ieoieQN4VVFS32TqptIiojyqLh2rH34kFCZNWjC8G96pkLy0oxgw8tkhvJz8oTt9ziHYim8gsoetVKbwqck2ZF7I+svza6ITwsJvjj2B6yKMpdfnMKJYXIdchOvz939fG/ZyTHkLc0PyUX0EEgvgzOcceXB6vBlmciY8wCE5oBqYEoT1j21t+eAYlFGgaS2geSd3cdtaE/SoBNxvKhcMMJOeyyl8hLQlDOHPk95l9eUj1/VEQwsuFZZJu6ezQlHNbD5LAQs6ujl6oYWlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIu5JDmA86AOL1XHvZ4//RxUz0oprzLoeMp6ZJD4jAs=;
 b=VKU1VKG8CC/cvlCsS+1dvIHfae2FeC1nXXzLqSEckeVLUCyuyFzY3VeHdoc281PynDThpYdszYa2eCiNDKT3AdUQjrYBdoTEypcHQEcPqTv3HOnAoNCzbqTiCclXkzzGEGqUs4aOoX/imB3Fj44lEUGCNDT8FID/XCMdVVsX3+ccOjRgoOJ7rjJ0NBULj3euRqabfWakmv9xMGZEf1Q4rIpyuXbpzYWNIQ5xE8RkhOMSGF3lxXdNR2jN4EZjoe0JEoXYovBDAkdxUD88M4mwJSeKNF2v4ISYo3ZdMQrpWPNXh+rq5YFKzgEHjVdtPHXd2zE9bnfmkWCCWWfeP215Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIu5JDmA86AOL1XHvZ4//RxUz0oprzLoeMp6ZJD4jAs=;
 b=s+WiqYyDb9GPILRzhHMQ+Ga2Z5Z3MqZrD4bwOR3/aWeU/N7eQ39U+q8PUUFpve9rpy6WIS299ZXfNxZRslMUlx18JH26h8qXZAGNl3EW6Fvv4HW2p+mrL0pt9DnBFNgQ+jwhmJBHsvUiN4VOtM4Iz7rqNU5x39W1muHaLaRd65A=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BL3PR10MB6020.namprd10.prod.outlook.com (2603:10b6:208:3b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 18:50:57 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2d62:ce4b:356d:e242]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2d62:ce4b:356d:e242%9]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 18:50:57 +0000
Message-ID: <5163ae19-b78b-d047-f700-93b3ad651eea@oracle.com>
Date:   Wed, 16 Nov 2022 10:50:54 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] NFSD: pass range end to vfs_fsync_range() instead of
 count
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Brian Foster <bfoster@redhat.com>
References: <20221116152836.3071683-1-bfoster@redhat.com>
 <87A52A9B-83F7-4FE6-8ED1-E710BAFF84B5@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <87A52A9B-83F7-4FE6-8ED1-E710BAFF84B5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0052.namprd06.prod.outlook.com
 (2603:10b6:8:54::30) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BL3PR10MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 441c2f2c-49b0-4bfd-6b7d-08dac8037f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UGYOKE/9xJkWiiMwAN8eW76te0mMkDnjluWxL/ghYOwPAoLWc33sWeOVXH3SnFkdeqc9vPcGB4lL1ZQhsX0zpvSSs7UAuRorQwBYohNnOPXgp3+u2Th51r73kho4Adg+QRRtw8uFGlSRDWqPa/CYGaKH0vfP2h4WmHE97fU+NBGcX5FxYJbpf6ChzBhLZlpUl69nq2Hc7B4tw504dZ1h5aerSbVpPnD+Xu65TODdFoNZBmrvMNyZ/adck+yHZvepphFd1N3osMUaEEWDBGinan3PYxdwUbnJGnHy+/72/gPnc/bgTIPnivfc4WtcmDTV5K/PfYtJ/4o3Yg5qrfweeoZDSfP4pcsrICPDDCAKshmvSbq4QtegPw8urEj50F6VIfs6nxdz5GJzIyk4B6vh3M/uFhRUWjU6FWUesPilx+nP+3ZmFTkhn1stjjNcBZ83uQ8vFoQkVXMbEhEJkCFzPFE3XxfRBoWme8ptQnQoqtRb16HxfSnY9SQNKlQH+wmBYdWQERFKXYzbaPT+Sj7kjoDdmvXfICZo4u36gdXIUEQ+G79MVgqZ69C4iiMZIW5n6OY9XDStpVFs7Otnto7CxWm0A5ldqg7CMrqJEFNr1G5ploKS9VYp7TjP+Wb5kI/WdxSI/WU2ntE5Eo5Af1gZeGyDnrr4CFemgTWVGikg0IkZRQZKig+nxBjk+vnxMwCiPAUGYOGsMUUt98EAbzzeqnLIApyo/39OTakWJbXsViYugKw4cujCNZT9P+jEv3v6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199015)(86362001)(9686003)(6512007)(26005)(53546011)(31696002)(66556008)(316002)(83380400001)(66946007)(2616005)(5660300002)(2906002)(41300700001)(66476007)(8936002)(38100700002)(4326008)(8676002)(186003)(36756003)(478600001)(6486002)(31686004)(110136005)(6506007)(6666004)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkRwbkgwRUdoQ00yTWR1aHJTV1pSNjRwK3B0MG0yZmREOHRGZ2k0ZVJXUWU1?=
 =?utf-8?B?QTkzSEYwWDhRYUlCN3dScjZRSSs3RzRtS1BSU3dldkkvZTd2MDBnRjlhd3JM?=
 =?utf-8?B?akpJQU9YTU1rdGhudUxUZkI2L1pma3Q3QUd6L2F3QStWZGVsT0hWajBsa0s1?=
 =?utf-8?B?bkdzUmI3b0lRcXFpUzFkLzJFRlg3TE15TjdjNmo1UnJGL1dWeXpHc0ZZbnlx?=
 =?utf-8?B?Q0NaN2xQRnlLTVRnV0d3cWZESVo3R1duaFhoL2ttbWpsYTlNMkx1S2VNY2Nx?=
 =?utf-8?B?a2NXZEYzdzFTMFNNNUY3dTNWdERkR2RtWDR0V0VDNVB0d2hZWldlaDNNNlpO?=
 =?utf-8?B?eExici9tZnR0VWlzei9CYWNzRWRFc3A5NWR4ODl4VXZVOENmcHJ2SmpuWlRu?=
 =?utf-8?B?SndqQnl0akRSaGxjS0RYMzl4REMvcjA2UEg3R3lDcFFxY0l4NCtXTzFwb3Ro?=
 =?utf-8?B?L1VqdnUyV3JNVWJrVzZjdWIzczVmYlpmVytRTGpmTUw4MTJDUmlBaFBvNEZh?=
 =?utf-8?B?WWx1blZtRDRGbEJ6OHBncVRnWWY1Q1Zqd1ZTY3FKRno2UnM0MFJCTUUwOU1E?=
 =?utf-8?B?a3EyVFVHOEhsZUw5SG4vZGxtRmZybmM0UGg2UEsrSFRXOWFMaHp5MWovNEJ3?=
 =?utf-8?B?Y3BqUExuTjZZQTcyMVdObk1JSmNRQVJKRXlJWndVbDRsNUpBNFgvTlZ2WUw2?=
 =?utf-8?B?dHJhSUtjb21ZdEVoMVQ2bTdLZmdFb1N2NnZLYy9iR0Yza0tKM2VoWksvS2hK?=
 =?utf-8?B?S2xRY0RxTWcyaDY1QXJjbUtmd0x6Q29hc2d3WEFzdjVjZDd1eWtyVUp6dTVl?=
 =?utf-8?B?R0ozNVFhTEplRFBLWkNOaTNrd2U3ekdiYVJPd25iMW9XcVhjN2RXNzkveVRi?=
 =?utf-8?B?S3psWDVBSjBiQjBzR05NblUxdW0yTnBxMmZRQm0rZTlaR3k5aHhFL0FjbUNP?=
 =?utf-8?B?RGZFd1VDNEcyUDk0MzNtYWU4clFaYzAyd09oSlB6NllGbWN4enR6cVl6V2JN?=
 =?utf-8?B?YlNGN1NGOWQvby9iK3BUczFDT0RoSkY4cFlUVG1tNXlGZzZCQytCV0E4eEd5?=
 =?utf-8?B?RUh3Smd0QXFXMFBoS1lFclAzL1ZTSUEwZTlhczZseEhiMzJ4UWJNMVFMNGRk?=
 =?utf-8?B?SDQrdUxYRFNUYUcwTjNIQnhXQ3RsNkh4M3dYa3luY0NjWjBKQnd6WTRTaG1G?=
 =?utf-8?B?RWsvaW1rL0Z6ZnNjd085dzZtb3dNNUhCbEJjSW10YXhOa1ErTWtEVFZ4Yklx?=
 =?utf-8?B?M1RncEQwbUlJMmY2VHZvc1RwaEMyNWlFNXYrbUlCT2J1a3hvd3VHTitEVSs3?=
 =?utf-8?B?YXdDOUNTMzQ5b2hvcUw2anQ4aWpMcjRnL1JWem5mS3Azeng5T25qTDZkSHJX?=
 =?utf-8?B?WmhkTmlhUGlmY3l3QWFjMmE1TjRqdG55RFlOdEFIY1RtU29LdlY4dSt3MHBF?=
 =?utf-8?B?RXE3TXZGNk5iRTBkMGpwWmw5U1ZGSjd3bEF1blY0R3MxUlJOWWRnKzFaT1k2?=
 =?utf-8?B?eXBENXZoREd2UkZqU2hxQ2lsazZXYk44THA2bGlxNHNRVUJmcWFWbDFIemFZ?=
 =?utf-8?B?cDZiZnJvOEVEdkx4dFBFOC9jMWhzRUJSUDBSK3Y1RmxRdjJUYWxnUHp5b2xO?=
 =?utf-8?B?S1VmZXgzL0FLYzlFUktJVTR6b1p3NCtSVklpdFNTQlhyY09aWnI1SEI4Y1Rp?=
 =?utf-8?B?OGFRYXUvcXpmZkpQdTM4NURqMlkzaDlDejg1S3lOaWpvczYzb1k0dUxuNHhR?=
 =?utf-8?B?VXkvZW1aMkVoUnB6UjlNMWUxM0g5M281dElhNW5DRXZ3dWd5SVY1Yy83R1ZK?=
 =?utf-8?B?U25IVTZpemtLZTNGNEtxYTd6YUlHZ3RySXVvWlZYTkFMM29nZzROMHhBL2Ja?=
 =?utf-8?B?TWswQS9uZWhDTVVFT1FIcC85bnJNVUtKK0Roc1ZjVEJJTVkvZXJhS3hlUkk5?=
 =?utf-8?B?QUY0UW8zZi81S0tVM1FMa2tDZzNEMDBlekdCNHRFU1BlZlc5N0pDOGZzU29P?=
 =?utf-8?B?ZlNxSnYrR0d3Vms0UVNGWFF3YkFoT2NyOUFXakdRNGtMbEpZbUNXMDJpdkV5?=
 =?utf-8?B?RXE2SWowN3dOTHhEdVpjaWF0M0RZSTFJeXUwN2s5VXVnTlNDNnZCRmtLSTRq?=
 =?utf-8?Q?cvAjmTdLogew0k0xIYdviWgeA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PzvFzsyhd7JYoiSfLuODHEo9DYFesqZA5jJ2Kf5QtcrMEopr6fDzLAyjXcpZ98Rhfa5ajDgf1IbrMnUFrGmcDdHOiHNzog4pH0sC7Yktp/SSTh3hAC/90mWJOcM7oEh9iztIbDgjylANzYO2/OLb+NRyd91pUM4ZUnTyP1UzXz9kozYovJBArUTKFbsaQIlJO0FfCzb3tp5oFPrO2YzmHrOE4gzwFhQ/sddUaSGhxuFw6S1a5SCQIOZAesYcUnOFGTdCkneaPBe0Ugn93/J93Ma4BNf8phb15wG98EqrW6epj0uVKe9IC4sNSTKpaDyIeeYNZUCSzRe1hGPIZmlq7ShRL2qtj5hwVN54FJSfDvF3LLyzVcOoU6f1dXpybgzFWPEBNYyr2e5DKwvhQEFC+LpwE4dF/poN1jLZ90+O9N0xlAbUwGRsCzzqprWPxQcYyxBJs+CxOcpCdRb7JplO7Ysw92aSyanYpJG6uIcbtUIphK7SJh71GDum5A/GQY1mEFRZWM/OhoDPre2YkUP9jWAmjL2pd/T3bWCOUoZr4Xyl1NirlajSS01QSPK3AJGDofP7gnYnlPK8De4TiNiu44j5oIeC5+OYht2wyj8cPkPyguIQfYO2a3Vf7fz8561jWT93CEucMPwbb7pQdhj5gJuCDbiz73i66qKM1KRoalGpT8kyVncIQxzVenqIcU56L/FQDLVDRfnESseF1Yd5WuTfAM6MEC3oQbq7RKkt+MvStRYdytACNcrvztV434Jowh2m66W6jLPD8l6zDtprLVNR60BLCGL/ZpeFEtIhx/h2oXmOoLGwInRXW7byMRlL
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441c2f2c-49b0-4bfd-6b7d-08dac8037f84
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 18:50:57.8075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hj/H5suwKh28XWRGaTmRpOgp67v2hAl/hwyzbVteN9qnho4vwdm0VvhoaqjRBY7gG7nUWosUUKOJUky/yv/SfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6020
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160129
X-Proofpoint-GUID: Msnh0pH7MccaPAMUGMSYk0piZwoQ4O1Q
X-Proofpoint-ORIG-GUID: Msnh0pH7MccaPAMUGMSYk0piZwoQ4O1Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/16/22 7:34 AM, Chuck Lever III wrote:
>
>> On Nov 16, 2022, at 10:28 AM, Brian Foster <bfoster@redhat.com> wrote:
>>
>> _nfsd_copy_file_range() calls vfs_fsync_range() with an offset and
>> count (bytes written), but the former wants the start and end bytes
>> of the range to sync. Fix it up.
>>
>> Fixes: eac0b17a77fb ("NFSD add vfs_fsync after async copy is done")
>> Signed-off-by: Brian Foster <bfoster@redhat.com>
>> ---
>>
>> Hi all,
>>
>> This is just a quick drive-by patch from scanning through various flush
>> callers for something unrelated. It looked like this instance passes a
>> count instead of the end offset and it was easy enough to throw up a
>> patch. Compile tested only, feel free to toss it if I've just missed
>> something, etc. etc.
> Dai, Olga, can you review this, and one of you test it?

LGTM, tested ok.

-Dai

>
>
>> Brian
>>
>> fs/nfsd/nfs4proc.c | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 8beb2bc4c328..3c67d4cb1eba 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -1644,6 +1644,7 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
>> 	u64 src_pos = copy->cp_src_pos;
>> 	u64 dst_pos = copy->cp_dst_pos;
>> 	int status;
>> +	loff_t end;
>>
>> 	/* See RFC 7862 p.67: */
>> 	if (bytes_total == 0)
>> @@ -1663,8 +1664,8 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
>> 	/* for a non-zero asynchronous copy do a commit of data */
>> 	if (nfsd4_copy_is_async(copy) && copy->cp_res.wr_bytes_written > 0) {
>> 		since = READ_ONCE(dst->f_wb_err);
>> -		status = vfs_fsync_range(dst, copy->cp_dst_pos,
>> -					 copy->cp_res.wr_bytes_written, 0);
>> +		end = copy->cp_dst_pos + copy->cp_res.wr_bytes_written - 1;
>> +		status = vfs_fsync_range(dst, copy->cp_dst_pos, end, 0);
>> 		if (!status)
>> 			status = filemap_check_wb_err(dst->f_mapping, since);
>> 		if (!status)
>> -- 
>> 2.37.3
>>
> --
> Chuck Lever
>
>
>
