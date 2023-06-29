Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA445742A6C
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 18:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjF2QQQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 12:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjF2QQL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 12:16:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3593A8B
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 09:15:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TE7mGe011531;
        Thu, 29 Jun 2023 16:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bHO1L+c7xlwx6AWWDcmdukdflLE3Scnqvc7mhy4w2ww=;
 b=hAZK0HMepWo0E+eOPZ/ljaqzSmFKtOCw5o7YVukWliBJhnMeBHD8wEAau+cIhUnFZSw6
 PfcmNwO7gh6cIVrs+L6UyYtD1PbK7fvQJUsbfmut4fNuBoya7TBd7b5QtqQXNRMVRghH
 cJG1+78spz2fOyOe6lmEEYfcoa5fH2tCXVDLRizZir3JXiA0kY0Sfh2MAcmaD28PeyXe
 AVZuxjTYn7smpDOBVempTFAWQlraa0Jz1+cSjG7DFpJDa+ljzTPiYoow86Ol/dl9y/Bw
 949+e7cGKfBeM/e7xyu0M9QvrRTfnZEytKgctOaCceJuZ3EJoVNApeeaboEA0e7a26Xy WA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq3152uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 16:15:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TEupmC020160;
        Thu, 29 Jun 2023 16:15:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxdctgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 16:15:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gn2Gc+hr/J3WDRHkA0kUPSaZ4zJekpZAwMoDC/wIeV7noPr6gAvXY24Bydbnw+hDLfdaho/vEuIHH/xH7qWdcO22SeS7A1ob6P0ecYXaTIs22GqGKzrHRK03ttfgsMOalvt6Kz3cCUPNd4VTfBEpq1aihvNABwl8By7J2JtJWzlgHgNvwPx+TrEf+yr18GnUHmvAm3ZYXckHUM3G4TJsf4b6SHD8Mqlk/u0fHGOt579EIfa/upeXLJtINnr+J/QR/Q4+JjkqWTqY/9CPD5jxbmHDhISnGXnEzJkEJ2iFegIpe0WexqS0Uxiu8Vh109IjSsCUbrPk2SoTzj6pOtL5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHO1L+c7xlwx6AWWDcmdukdflLE3Scnqvc7mhy4w2ww=;
 b=YCQL63hmNRO5inYb6Vs/QXD4oqYWVudISoGwwDKb2laCWdt5JG7ZGqCMbPR2WlmZi1qFeEHrjMwWR48zuMOJyHehnlN8Zbwf89bfGyRVfY3Zxs8mzHXWPASb3WryocPrYK5aa1vKJGP7JynefRheV3gOq65ocxeJTPJ7/+NwA8p8OxJKH/AFBIH1kNRHctPg4XjDUBrtiNMU+c3kZwunbHG8b6QFmJxz4GqH3BN4XRI1lKq+aE4yCwp/0/UsaAHzHYMEXOvY3DRJUwrGvpvE5k3b5t4aYthDOt8SiWSbowhsb9/7hVpdLEdOE+AE2XCsXigb6qy5BSbwxyzAG/SNaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHO1L+c7xlwx6AWWDcmdukdflLE3Scnqvc7mhy4w2ww=;
 b=NF7flJLlF7m+fzVXgq3e/t9sg3lHGT73JQr3CAhuwNPt/N0sHuG8F+TGJemD5n1n+3l2c2b5Zdal8zcKwImj7/qwOMiEisTjGXdv68Qf4BITqDp19y71IJEtdu1DrPEKS6TuT0sSHsvSyJp2B4VLYhznghSEskew0MeSTAyF3KU=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by MW4PR10MB6632.namprd10.prod.outlook.com (2603:10b6:303:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 16:15:37 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::1b0f:fad9:3eb1:95e8]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::1b0f:fad9:3eb1:95e8%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 16:15:37 +0000
Message-ID: <262cda75-f4cd-a120-9942-a31f149fe96e@oracle.com>
Date:   Thu, 29 Jun 2023 09:15:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v6 2/5] NFSD: Enable write delegation support for NFSv4.1+
 client
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org
References: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
 <1688006176-32597-3-git-send-email-dai.ngo@oracle.com>
 <ZJ2bLhHFmOBcX940@manet.1015granger.net>
From:   dai.ngo@oracle.com
In-Reply-To: <ZJ2bLhHFmOBcX940@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::30) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|MW4PR10MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bbaadd7-22f6-4c1e-d236-08db78bc131c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +et5E0ZXNxDA8sLm56lSZKvsr/nVEBZP/fosrw3ipOvb4G3MMw+sVLg0ls5H0Ges2JTDAl2UEW19gwaTc/cD5hT+kArQulCkX+dmuH81MA+ds7ypZyh7TrxUoamdCliDDpCrmIiCbjjTWmZ5YzWW723orhfpKKk+gy058DxJCrCJQTJaSgXGv45b59of06yG1XKUbEKbzr4lQSa/mfbQT3P1X9lVtwpZdjpZu4ZJffMzJn4we6XAb+p+VzNSpKa5/NQl9UPxaMWEiUiTpo2mGcKfVlJR6tjHO0uO3ancODylu/MWMjM0WhoKlMJLI6iV/hiJmOggCkwKtDbijDJGCo9+7HqpyhYP7ts/90QpsBm8cukYHdrrcCN11Oae36fY7WgHU3RlMfBJdBiVDXjtwQvPkubuiewjpYM1e/VkDzuaWVhwrpKkHqqMOfIZI5U9g4vrebzGbFak0W0sYqhB7VVYFxOOwpvwn6YDNFj5jZPIoR3P+5fxZZcxP6HiQfFQ0tMKXf3Khwu8KP9g+kyiW6NeRWAA+KDapQJNsEYheCoRSWI2XNoMAUGkxVhVfsSrbNmPeyZDrGs4MW9qmu2A18xmKx4y5yLtCBNI/vdZO8B6CodtVXppO3Z5pX/aXmVx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199021)(2906002)(8936002)(8676002)(6506007)(316002)(53546011)(66946007)(4326008)(66476007)(66556008)(6916009)(31686004)(41300700001)(6512007)(9686003)(186003)(26005)(6486002)(86362001)(66899021)(38100700002)(31696002)(83380400001)(6666004)(2616005)(5660300002)(478600001)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVdEVjJwSVgyZ3F6R0dqU1NuNGVSdVNsTVB6bGtaRVVzaGUzRHB4YkVHa1pZ?=
 =?utf-8?B?Yi9iL3pIVlV6T2ViMWVYQmxVaEFZMVdudEdVdjhoYnJTLzMrK0UzU3JlZVNZ?=
 =?utf-8?B?V093VGxTb05XOUc0ZXVqTjZzRkNEUGpQeG5oVmthSDJWTWlRK1VFMFpONS9z?=
 =?utf-8?B?dVcvMWFjL0RsZFhQa242NTQ2ZHc0VE9xVDZmcmUwVTBjMUt6cXF5d0FGbHln?=
 =?utf-8?B?T3EvYmJHOE1MTzd1NktTSnRrTWM4OFdJVWk3K3BLNWtkUVZaSDlsNUVqeUFS?=
 =?utf-8?B?SGQyVTh0eTMyNzNqdU80WnNYcm8ySFYweHR6Tk9nRFRSeFdsVWlmeTBZVVVI?=
 =?utf-8?B?bVZHV2NtTVdMMHVyNHV0R2J6aTd1cVFUOFNZcDYxMFlnbmt4b09yNXI4akh1?=
 =?utf-8?B?TUZnNVVuYVhON2ROQk9lVURPam9KQXMrd2VYc2VwQ3BKQythRHRVRlc0TG1N?=
 =?utf-8?B?bTRHZUZVNzE0QlVjcmhjNEp1dXcxekI5QUNSZHh4NFR3cnNXMFNlVkFiU3FD?=
 =?utf-8?B?Z2NuWUJWVUQ3b0s3MkZxRlRLK2prQTBuOHp4clFOQ2R4UW12ZThCdGFEa0g2?=
 =?utf-8?B?cWsrMm9XTjY1M3pEVTF2Smx2VzJlalV1emlsVktlS2FDSUVCckpVQ2ZSemdJ?=
 =?utf-8?B?V1lFUk5GSE5kK1pzTFRidkVjb0w0UkdRTTFoYldSWTJYbTh6dDZsekF2VGo2?=
 =?utf-8?B?MHp2THgxTFlGRlpCNk9nclpENE93TldaUS92MnFYKzEzOHVIUFlyOFFDeFcy?=
 =?utf-8?B?TnBVTEE5M3cyczhrQmNGSThpaHFpUjhQMTdNVm9NaWIwRUc4Nzcrem5uT3Ro?=
 =?utf-8?B?MFNHSURpMnRBcDlKcVFVbjJCWjkrYjBtV3ZsdHJCRzNEZktZSFZzb0JFeVlx?=
 =?utf-8?B?S1hCM2FrOXNFZHR0Y0dRZFZWYkFIREFOdEhuSEtrcTNOMkZ0amc5Z0xUbXMw?=
 =?utf-8?B?N0hRUnpHQU5ndEdBcTEyR0h6NnVJWHN0cUx0UCs2RWlza1dDenIzNVR2OFBr?=
 =?utf-8?B?cGU0d3JGM2F5WU5YNWJKdEtrY0Q1b2I5eEcvcm05NVA4YzhVOGFlR1BvT2I0?=
 =?utf-8?B?SXE0MVFLMjJJZVkrWE1Ka09jY2VOd2x4TW51TFRoa1VDRDd6dHdHQnJuUlky?=
 =?utf-8?B?VlVCMUpjYjdXbkRQRHVod21BQXpNTUZPVDRVZ2tobG9YSjJLVnA4UDNLbzZV?=
 =?utf-8?B?REZ1M1N1SlNhdVhXTFd4RThTTU8yYlhkN3RaVkx4WFo5RHlvbmF3TGNacDc2?=
 =?utf-8?B?d3hSVmpYY0lNZk51SjQ1dmh4ei9USVpWYW1Hd016RURFL0dUdHhtUTZtV1dy?=
 =?utf-8?B?Q0xWc2ViRThENVlMQlh3bkIxQThPMjhWc0l6OVlXSS9oNlZEbDZ1cTNVWmFj?=
 =?utf-8?B?cHBqd21YVU5EeWdRNzlkQ0tCQUFseE9mK2JZaCt1NWgvQ0xOOVRlb3E2eFlX?=
 =?utf-8?B?K2tQandjZExOcmhpWmpMOFE0akJiNnc2RjJXR0pVQWNPaC9sQWZuU3crZkQ2?=
 =?utf-8?B?SWdMTTdWbE1XRFowdk9FcnFJbVNwZzNyT1Z4Q2NhYk9wQ29QL3kwSkpZY2U5?=
 =?utf-8?B?ejhoQzBncnh3Vmh1TUdtYS9NdyszeDE1TVlieHJuam1IYzFpTlY4MTRvbThj?=
 =?utf-8?B?R3hYMHBTT2h6M04xSlRRVktsdEg5dU9EMG1iRkc0S3VrN1Z3RWdjNGQ5NHNU?=
 =?utf-8?B?Z2FRZFFnVDk5REFTSVl5Z3FTdTlFQy9DMlN0VUpRZ29CUFBJbUlIRzBQbmFM?=
 =?utf-8?B?b2dYUXBma3VKYVFNZkJBa25jUDVjVzMwMXUzNytwQ2IzS3dJZXhoWkxWUGVs?=
 =?utf-8?B?UjdpMWV2U21zbXRJUllLTUxySjhwYTdTZlhrNHc4emVDMkhoOW13cVh6UWp4?=
 =?utf-8?B?ckFsUENQYXJwVWlnd3NoaGgrN01GY1NyRVhXTUMwdkFLTndRL1VGOXgyUkd1?=
 =?utf-8?B?d3QzbEpLQzZKbHE0cW1EWEhPaklGSXgvdjhQK2Yxc3Bra0hwWStISGV2Tmpz?=
 =?utf-8?B?UXFKVitpT29qS1B4bXV0U1dlUUdtNVNRRGRpY00wTFFvTWhObndjczFZTHdY?=
 =?utf-8?B?U1FKNDhhV0lFcVV6OTBIeHZ5ZWVTcFRQaW9ScXVHMzMvTHA1RWRDSUljUGZU?=
 =?utf-8?Q?tyOHIYclRxpZAqR73ftu2mK5D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Jbzy9W8K4oHaIiSLBFkpdKxqclPQUWq+dTRRhcNMEcQeqiu4du5x4nwjPzQeHDkUD7czlpvkJ1ug8a6eCy/dXiB+ouvUbA2fsPdNav0geT7D32f/yVa+xTXHoi7z9qSZavQZfcaZi/CrrngN+LLV5+VuYCzvLctI8Ww9mK0AVhyvLlCGGEeSKEFyI1huWaWuVY+d3wkQvwojwN2pL8lOHF78PC/FsWVa4PYOTN9nBdLE/4EGQXlmTTv1y3+HUQCxiZiGMNI19DpsCoZP3T3lAiowATIXHzf3us5LsN8MAg96tkW9e9g7SMJXWrOgB0J0Ofo4KJr0HB5HEdcuuZZCbePB2x/XajFCPhcwDgy41GSHsXgFCaUWBaYQQUrvjcfszgTcZmRS9kedF/WqrY+GzSh9X5DTE9XPdavHk2HWw/UrWuvskxTLRxUclt1re+iOyTbKsiYPGJBpsAB2iLlxOBEoF2dFlsisLC3noLTYrRJf3tAxL43Y87BHEVDYa3JUHT0tJdhUbQeIMK8Bjn+rDl0BOBx2FO3TiU1sYH1xkEKDtfRgeTnDtMKVK23WNfqUlCkwJdzPuGCCs82qCitd0kXhiCu9aN4flcbcJZciN7UjrOimrCwe7595vx4D8YtMgvEjEFBvWN9k1Fo03qgu4ItZdn1H1JgMIVgBGxzuskgYgZfu0iJ32v1LQB+LVzau47HHrTZDJ2JZC0amK8lCxqVDZOVh+6koGuaoi+2qRG8YpgHciMlW8ahrDB4+12X/j5gRq0OcRhAZgbbtTCF6O7ET5/1nBeCOuegS1xQdv/8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbaadd7-22f6-4c1e-d236-08db78bc131c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 16:15:37.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KR/mnMM214gQtLYuIPugR1zOthBeQtM/hs4F9M+UCw/6k5eoWLh7dznbdCz/AdCL7AnU01R0FWwjX1o4dxpVxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290147
X-Proofpoint-ORIG-GUID: iyTSS-0PP8Wnc6EXzMJz3lE_Bfut9S8U
X-Proofpoint-GUID: iyTSS-0PP8Wnc6EXzMJz3lE_Bfut9S8U
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thank you Chuck and Jeff for reviewing the patch.

On 6/29/23 7:54 AM, Chuck Lever wrote:
> On Wed, Jun 28, 2023 at 07:36:13PM -0700, Dai Ngo wrote:
>> This patch grants write delegations for OPEN with NFS4_SHARE_ACCESS_WRITE
>> if there is no conflict with other OPENs.
>>
>> Write delegation conflicts with another OPEN, REMOVE, RENAME and SETATTR
>> are handled the same as read delegation using notify_change,
>> try_break_deleg.
>>
>> The write delegation support is for NFSv4.1+ client only since the NFSv4.0
>> Linux client behavior is not compliant with RFC 7530 Section 16.7.5. It
>> expects the server to look ahead in the compound to find a stateid in order
>> to determine whether the client that sends the GETATTR is the same client
>> that holds the write delegation. RFC 7530 spec does not call for the server
>> to look ahead in order to service the GETATTR op.
> Here (and the comment below) I would rather state this issue in
> terms of protocol constraints.
>
> "The NFSv4.0 protocol does not enable a server to determine that a
> conflicting GETATTR originated from the client holding the
> delegation versus coming from some other client. With NFSv4.1 and
> later, the SEQUENCE operation that begins each COMPOUND contains a
> client ID, so delegation recall can be safely squelched in this case.
>
> With NFSv4.0, therefore, the server must recall or send a CB_GETATTR
> (per RFC 7530 Section 16.7.5) even when the GETATTR originates from
> the client holding that delegation.
>
> An NFSv4.0 client can trigger a pathological situation if it always
> sends a DELEGRETURN preceded by a conflicting GETATTR in the same
> COMPOUND. COMPOUND execution will always stop at the GETATTR and the
> DELEGRETURN will never get executed. The server eventually revokes
> the delegation, which can result in loss of open or lock state."
>
> Comments and further edits welcome!

I will update the comment with this explanation in v7.

-Dai

>
>
>> Tracepoint added to track whether read or write delegation is granted.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++++++++-----------
>>   fs/nfsd/trace.h     |  1 +
>>   2 files changed, 30 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 6e61fa3acaf1..f971919b04c7 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1144,7 +1144,7 @@ static void block_delegations(struct knfsd_fh *fh)
>>   
>>   static struct nfs4_delegation *
>>   alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>> -		 struct nfs4_clnt_odstate *odstate)
>> +		struct nfs4_clnt_odstate *odstate, u32 dl_type)
>>   {
>>   	struct nfs4_delegation *dp;
>>   	long n;
>> @@ -1170,7 +1170,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>>   	INIT_LIST_HEAD(&dp->dl_recall_lru);
>>   	dp->dl_clnt_odstate = odstate;
>>   	get_clnt_odstate(odstate);
>> -	dp->dl_type = NFS4_OPEN_DELEGATE_READ;
>> +	dp->dl_type = dl_type;
>>   	dp->dl_retries = 1;
>>   	dp->dl_recalled = false;
>>   	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
>> @@ -5451,6 +5451,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   	struct nfs4_delegation *dp;
>>   	struct nfsd_file *nf;
>>   	struct file_lock *fl;
>> +	u32 dl_type;
>>   
>>   	/*
>>   	 * The fi_had_conflict and nfs_get_existing_delegation checks
>> @@ -5460,7 +5461,13 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   	if (fp->fi_had_conflict)
>>   		return ERR_PTR(-EAGAIN);
>>   
>> -	nf = find_readable_file(fp);
>> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>> +		nf = find_writeable_file(fp);
>> +		dl_type = NFS4_OPEN_DELEGATE_WRITE;
>> +	} else {
>> +		nf = find_readable_file(fp);
>> +		dl_type = NFS4_OPEN_DELEGATE_READ;
>> +	}
>>   	if (!nf) {
>>   		/*
>>   		 * We probably could attempt another open and get a read
>> @@ -5491,11 +5498,11 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   		return ERR_PTR(status);
>>   
>>   	status = -ENOMEM;
>> -	dp = alloc_init_deleg(clp, fp, odstate);
>> +	dp = alloc_init_deleg(clp, fp, odstate, dl_type);
>>   	if (!dp)
>>   		goto out_delegees;
>>   
>> -	fl = nfs4_alloc_init_lease(dp, NFS4_OPEN_DELEGATE_READ);
>> +	fl = nfs4_alloc_init_lease(dp, dl_type);
>>   	if (!fl)
>>   		goto out_clnt_odstate;
>>   
>> @@ -5570,8 +5577,13 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
>>   /*
>>    * Attempt to hand out a delegation.
>>    *
>> - * Note we don't support write delegations, and won't until the vfs has
>> - * proper support for them.
>> + * Note we don't support write delegations for NFSv4.0 client since the Linux
>> + * client behavior is not compliant with RFC 7530 Section 16.7.5 with regard
>> + * to handle the conflict GETATTR. It expects the server to look ahead in the
>> + * compound (PUTFH, GETATTR, DELEGRETURN) to find a stateid in order to
>> + * determine whether the client that sends the GETATTR is the same with the
>> + * client that holds the write delegation. RFC 7530 spec does not call for
>> + * the server to look ahead in order to service the conflict GETATTR op.
>>    */
>>   static void
>>   nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>> @@ -5590,8 +5602,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   		case NFS4_OPEN_CLAIM_PREVIOUS:
>>   			if (!cb_up)
>>   				open->op_recall = 1;
>> -			if (open->op_delegate_type != NFS4_OPEN_DELEGATE_READ)
>> -				goto out_no_deleg;
>>   			break;
>>   		case NFS4_OPEN_CLAIM_NULL:
>>   			parent = currentfh;
>> @@ -5606,6 +5616,9 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   				goto out_no_deleg;
>>   			if (!cb_up || !(oo->oo_flags & NFS4_OO_CONFIRMED))
>>   				goto out_no_deleg;
>> +			if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE &&
>> +					!clp->cl_minorversion)
>> +				goto out_no_deleg;
>>   			break;
>>   		default:
>>   			goto out_no_deleg;
>> @@ -5616,8 +5629,13 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   
>>   	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
>>   
>> -	trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
>> -	open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
>> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>> +		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
>> +		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
>> +	} else {
>> +		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
>> +		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
>> +	}
>>   	nfs4_put_stid(&dp->dl_stid);
>>   	return;
>>   out_no_deleg:
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index 72a906a053dc..56f28364cc6b 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -607,6 +607,7 @@ DEFINE_STATEID_EVENT(layout_recall_release);
>>   
>>   DEFINE_STATEID_EVENT(open);
>>   DEFINE_STATEID_EVENT(deleg_read);
>> +DEFINE_STATEID_EVENT(deleg_write);
>>   DEFINE_STATEID_EVENT(deleg_return);
>>   DEFINE_STATEID_EVENT(deleg_recall);
>>   
>> -- 
>> 2.39.3
>>
