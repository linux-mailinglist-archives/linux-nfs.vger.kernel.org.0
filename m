Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C175AC077
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Sep 2022 19:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiICR7l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Sep 2022 13:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiICR7d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Sep 2022 13:59:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A17DF9D
        for <linux-nfs@vger.kernel.org>; Sat,  3 Sep 2022 10:59:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 283AnTLm015431;
        Sat, 3 Sep 2022 17:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Q9MkLO0oiufTVIcqdKBlAHvi+0ff/jTkkULeC0MvRkM=;
 b=0OUgSUJD/c/RDHnHyirIr+2Mey2eNI8MVyugCHGc3GQtg6HGk5PivwvYRzbAPcDN7Rp6
 4hcp2WUTAsKXCowLY8q+uAHCQeJBYM11FpryBO2dzJmiPEuPuQu7V6UJY80tqbZZ7Wy3
 xnTkKWYHooREjM3mVAZ2wMXmXp6ueHyOcnkCuIXaykdBjU4kBn2jBiFdgfRNNUm43Tt5
 yaEBYhN9Y7SdnoTKFgQ/UxyD27MNnPdIjePy1Nn+sqkOT595O2f2HJ6Q0xRuSvk1Rm7g
 EU0bk9SzrOfqkAMFwPSt4ablHcDXUHHXD4aP4coCvVAI7hr432zKegqV0PZvsRDzVXl2 jA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxhsgv4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Sep 2022 17:59:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28398Qfq002606;
        Sat, 3 Sep 2022 17:59:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc0bhhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Sep 2022 17:59:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C44LkBrWhSKcZ20tD1qqVFc+wxtpkCcejRhLBVtGAwJzf8l4KYuj+16xTgd3flcQUSjWR0b43jJFhw9K8c2f1mQAJS5wJRGM56II1NjePoiOO5Al8LXJNmucXZoaCktJwJ/DwjSMAj3+uunlq5EowSJ853jwLckJvQwoG9WwXQ/Lpn+CyF00a0HVammcsXWzm1P0Rjm41BrSQ4UdKnB6TWnVHEmq4rC05D6uF+Qp0tjhDp1eihtdMAtLuHR5Cspx6F8Na3au/1riDVwDWjSyQj2MTNsoELMVJ4WpzRSl0qnSdulLeMR5+3U+NDRPeU1URxT+pWijywDAwwCrI3qY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9MkLO0oiufTVIcqdKBlAHvi+0ff/jTkkULeC0MvRkM=;
 b=gc88EoG4MIfBLTSvQCJ6PmZCSmkgaXAP0PcojsORiwT3jrNRyvKxqSCNyYXwT6uuygDAdgPGV7qtCFX8/zkiFjgHYagEkC6D1Rf1OuRY3XuebRSSU7/kjK1dJh1xQMtf8BEHTCkUsIvMw8yDwir/W3qBCPfwWospkkbh5XUnX19U6HFoFFX3BXTT8siiPyeDg0iHFqalUCOKy5YknrV79LiRTz6jfptceOwd0Oqr7mFLi4OAu8L5IFwPWFXuHGe8kq3pkh0aAUrGzdzXzpdGaMj17lxhktfmh/lX76FmQMaClLCh98dbmRb0o3/X4IdDxKmANzcDhrJLTatNvhcOJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9MkLO0oiufTVIcqdKBlAHvi+0ff/jTkkULeC0MvRkM=;
 b=vz750yoqAPzBqj3B+n/4T4f9KMPri4xpwMNAttxZN2I0pTZiSeWBvCP6W7OXOE4uapo8sn9XvXi5GeCe0MleZ1n11bg84cVQDz5xStW5OY6TJ7JZQGboFsP7476cvzaxQqU353rvPXTOBsQixmUqrnGhAdUq8B1c+mVIIKq/iXs=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CO1PR10MB4579.namprd10.prod.outlook.com (2603:10b6:303:96::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Sat, 3 Sep
 2022 17:59:20 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::803:3bcf:a1ee:9e1c]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::803:3bcf:a1ee:9e1c%5]) with mapi id 15.20.5588.010; Sat, 3 Sep 2022
 17:59:20 +0000
Message-ID: <1f395e2b-695f-836f-2038-6a672c651d53@oracle.com>
Date:   Sat, 3 Sep 2022 10:59:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v4 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1661896113-8013-1-git-send-email-dai.ngo@oracle.com>
 <1661896113-8013-3-git-send-email-dai.ngo@oracle.com>
 <FA83E721-C874-4A47-87BA-54B13E0B12A3@oracle.com>
 <2df6f1fe-c8eb-d5a1-0a11-2fd965555a33@oracle.com>
 <7041D47D-ECB3-497E-9174-96E9E36FFBDE@oracle.com>
 <eb197dde-8758-7ef4-8a7b-989273e09abc@oracle.com>
 <3CD64E7F-8E81-4B37-AAF3-499B47B25D19@oracle.com>
 <fc5a3aa7-af8e-656d-a16e-c07c201ec62a@oracle.com>
 <44A716C4-3904-424D-A5D6-CE46FC9145F0@oracle.com>
 <2b9549f8-58ec-be8a-1b15-3a6d7751a04f@oracle.com>
 <5B4E5FAA-5D46-4E43-962D-64AFDC035C41@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <5B4E5FAA-5D46-4E43-962D-64AFDC035C41@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::19) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecca377b-c861-4f31-3cab-08da8dd606c7
X-MS-TrafficTypeDiagnostic: CO1PR10MB4579:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fU+xRoSsMxQvoYWSZYTK93JJoo7fwcx/yBQIClQe1Gg7fWdJ4ToUuOaDwxII9mLkxxfzAQB8tAwoixzGB8vguQO0vZM0H7h/idqAbV7HfghVjE/tH0V9tvZvX6tG4Wvo/V5Iq2pl9FT7YKtNV2mNXr5rrNw1pu0bM1yE+TrpJmhpP1a7VLpWYZQmEtj0C18UHCrCD5gyw1i+UmjuGUh/7kyGcSy+bZPX+NXrdh2JralntRwRh2tJqcLOrRKJEUPVMLx+SoYosKUYp8DhDKgRdhsnJNo1RNRI7Kt0jefVJEQmXp/3og0NRa+aXURsvvdIl1l8H5vhlKFNEOJe7VqIRTbB262AJhKDhTOu91Md8Ag8BHCvE9WvTh3wLvEbpJnEy2jMa4q9yuP/HU7ydjb2p0sKdsRVkq9F1oOYu00pwWoc7P3ub587KeWFKgh12W6JqY4RenMai3yVwprGe/TkJVc1VyC8FpW38RaTyu/qvhGH2ROVN2B6qMtUCh1HQIc0gUvrQ/uXA+rXSBKxyVGEqNRkYz8X/n0ILtqxd3apJWk83P7xTniXqrfRzdEi8/7v5GkmvlQ/GhC34oRfQVoFTkhkfTCAaN1RuAkJIf+T2rQ6XJQAcu76jD83CWUhQ5AU36zN8mrTXZY83SVGrizTomRLpcbs6y3OXocS+mtBd6TxjHAsmXg61kqvMxyiZ5yzQjWP18f3ZRyGM4Ap/+j8DKP67wu4uS9E+9U0o/rz4+5djTUfw0Tto86OcC7RUSJO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(39860400002)(376002)(136003)(2906002)(37006003)(8676002)(4326008)(38100700002)(66946007)(66556008)(66476007)(316002)(45080400002)(54906003)(30864003)(5660300002)(8936002)(6862004)(83380400001)(53546011)(6512007)(9686003)(2616005)(26005)(186003)(6486002)(6666004)(6506007)(478600001)(31696002)(41300700001)(86362001)(36756003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2ZqLzFoUjlXdmFrWEt4ZXFZSVphaFp5QXlsYU1UUktCQ29XSEZ4MTl0cjdE?=
 =?utf-8?B?RTZPdHlQYzNGK3lUcXlScS9ub0tQcGt1b0ZDdWZtUGVHQWtMWkh6eHA5WGlh?=
 =?utf-8?B?bm1iaWNrZ1FRSHY4aS84RkcwbFpCdlFFWHA0TTdSSWJZem9LWUEyU01tTDcr?=
 =?utf-8?B?aDE4UDE0UERBKzhkVkIwRGVkT2VCZXlGdHlGSS9KMUhockw3M1dEb0lzUHdE?=
 =?utf-8?B?bDdlNG1Ma25EMGYrN1BRTVk5ZmZESkV6NnA3T25LbjJHa2ZrdXE2NmJEc1U4?=
 =?utf-8?B?cUN5WW9nRnJRakdabzNjNlE1WGhFUCtIOEU0TXVEVndQNjN1NlJtdmJHcHNV?=
 =?utf-8?B?M1ozeG53d213VWdoUlp5V25SMVVkbGdiSlZRMUUwckdiL2xlNGd2T1crWmpY?=
 =?utf-8?B?clltTDc2WEZISU1veHZNRmxLWTA2YzY1RnFGSjlJNnBBMXJ1b1ZCYTBjT25Z?=
 =?utf-8?B?bDZ1OUJQeFg3SGxxVk1lLy9OZjNGdzFUN1N2VnZUS2lJMEJjczZvQUtTUEph?=
 =?utf-8?B?Z3ZqZTJjbWhvcEllQWM5SytOQVQ1bkkwanZZV2lXaUk3N0d6MVBJczNheDBo?=
 =?utf-8?B?c2JkL0xNV21oMm9ZVWhzNmpZTUpJbHlJMnd6VnEybWVlbFRYWTQwNW1UNkhy?=
 =?utf-8?B?dEVIMFJ4STh1VHkxSW9jbjVBcXljYjJsQm1SczZFVm9yZ3V5ajYwTGIwbnBU?=
 =?utf-8?B?bVF3RE14TkpnTWF3dXBwb2Zxb3FqRjJBZUhWZytOdTFtY01HRlREOUYzMHRP?=
 =?utf-8?B?OExGNkg3UTlnZ3dzMHBNTlkrL3pDNWFsYUY2MDdXTTMxcVZpQ1I3Tzd2aDQ4?=
 =?utf-8?B?NFp2cm9pZDR5M1VEOW8vU01WTDlCMVkzMktMOXNvTmp3dVJKN2NTN1M3MTBj?=
 =?utf-8?B?TkJMRTRkWkNvUkNacVJGdnp6VEowdHNFa1Bmem5JdW1YS2p4blM0cFpEQlhO?=
 =?utf-8?B?SG1BWXUrdjIvOUFlZ2lYcGZhRWdxbjJQZU5zdThHZlN6UWdVdTY4UjFaOVFB?=
 =?utf-8?B?UnN1SkhmYkRFTGtEZ0FtZUVqWGZBNlNsS2g2cDJpT3NoN0xYdi9YQys4bGpy?=
 =?utf-8?B?ZXpGcG4vSExjclhaSkh3ZUJ5SnF3b051dkF1MlVKUytqU3ByNTIyRXVHb0xG?=
 =?utf-8?B?b2FhT0dsNEkvSUx4RjQ3WHQ3NGpydEY5UjAvQnNNdW41MmZ0djMva282OTJr?=
 =?utf-8?B?dHNSdEEyRlFaWTFyL2R6eWdOZDJhbWJRQTVRSExLb3crbHlpMFlXS1hFeHZu?=
 =?utf-8?B?a0dLSnFYZElSOStza0dicTVFSnF0ZkJ5eUdMUTVWdi9WOE10QlQwblYrZXlE?=
 =?utf-8?B?NXJNQ1hqSlN2SXJnMHM2Vm84dmxkZFY5VzBVNlp5VGY3OHJNalNzZ2lLWTBU?=
 =?utf-8?B?NjJYRGVLMnZxSk8rVEdiTmhuZnEzUkY4dkFxVnBmbTJBUCtKaFpmK2d0WUZX?=
 =?utf-8?B?ZjVYWW1YL1c5NGUzMzVSOTVydllKeVVIa3Y0Tit3VmZJUmo4MWV6alYzSm1Y?=
 =?utf-8?B?M1lpS0FYclhnelYvTWpuTHQzQkt4K3phcmxWNm1RR25SakY5ZUlIMTR5Z3gv?=
 =?utf-8?B?eEhIRkM2elZtcEJOS1NhS0F6eGFPT1lwWEJ1MUU2dy9tSkJqa2twb1hDYThW?=
 =?utf-8?B?YnJ5eHowdW1wa2p4S2hUY2ptMHZVY3c0VGhJbmJCL2ZZcXc5ZGFIOWxpK2NB?=
 =?utf-8?B?M2hrOXBENS9yY3owUzRDakQwMlBjU3ZScDBjMk5wVmVOY1NOME9sVTVpWDZw?=
 =?utf-8?B?cVJEcTU4SlJ3bHRLV1JtQVZyNzFRWmh2cG1wZFlFZ2lPUC9PbW9hc2lYTytM?=
 =?utf-8?B?ZktMWkRzMG16aHlvVjVsLzdWY3hCejdSVTVsV1daR3Y5RlIyTmVkWC9ybTRG?=
 =?utf-8?B?Qko1dmlTWlQrTXI4TDhlYWNsWktqZXI3aXowY1VFdXcyN1lIekRKdjFWS2o4?=
 =?utf-8?B?TkNFbG5WVTVIWmJNZzJRRnd4Q0xiQlJ0Tjd3ZTBMTFgrbE9ETm5UNm4vcVF1?=
 =?utf-8?B?TFZ0SzFtS0dsOTE1b0JXWE5MOVZHdUtZN083R0llVTNvVUVNa0lMbVpoSEh5?=
 =?utf-8?B?cDFjaFZmdE1oclA4V0p3NXVQNTBEK3FOZ1BLL2V4WkJoWndxKzdZekJhdWll?=
 =?utf-8?Q?IcthkUUCXD628bBigXbQUq8HP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecca377b-c861-4f31-3cab-08da8dd606c7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2022 17:59:20.4303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZPtmN6ayYulZ4VAl9xeqYJLYB9tmnYpMM59VLHRoGYYEMbF9t9Cs07aBl0NZ6wJjawgvnHvUJofmQyB4yqcMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-03_08,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209030092
X-Proofpoint-GUID: vr_G0ZfJLtOhi9J2cqtOhJYKPEiOEcaY
X-Proofpoint-ORIG-GUID: vr_G0ZfJLtOhi9J2cqtOhJYKPEiOEcaY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 9/3/22 10:29 AM, Chuck Lever III wrote:
>
>> On Sep 3, 2022, at 1:03 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>>
>> On 9/2/22 6:26 PM, Chuck Lever III wrote:
>>>> On Sep 2, 2022, at 3:34 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>
>>>> On 9/2/22 10:58 AM, Chuck Lever III wrote:
>>>>>>> Or, nfsd_courtesy_client_count() could return
>>>>>>> nfsd_couresy_client_count. nfsd_courtesy_client_scan() could
>>>>>>> then look something like this:
>>>>>>>
>>>>>>> 	if ((sc->gfp_mask & GFP_KERNEL) != GFP_KERNEL)
>>>>>>> 		return SHRINK_STOP;
>>>>>>>
>>>>>>> 	nfsd_get_client_reaplist(nn, reaplist, lt);
>>>>>>> 	list_for_each_safe(pos, next, &reaplist) {
>>>>>>> 		clp = list_entry(pos, struct nfs4_client, cl_lru);
>>>>>>> 		trace_nfsd_clid_purged(&clp->cl_clientid);
>>>>>>> 		list_del_init(&clp->cl_lru);
>>>>>>> 		expire_client(clp);
>>>>>>> 		count++;
>>>>>>> 	}
>>>>>>> 	return count;
>>>>>> This does not work, we cannot expire clients on the context of
>>>>>> scan callback due to deadlock problem.
>>>>> Correct, we don't want to start shrinker laundromat activity if
>>>>> the allocation request specified that it cannot wait. But are
>>>>> you sure it doesn't work if sc_gfp_flags is set to GFP_KERNEL?
>>>> It can be deadlock due to lock ordering problem:
>>>>
>>>> ======================================================
>>>> WARNING: possible circular locking dependency detected
>>>> 5.19.0-rc2_sk+ #1 Not tainted
>>>> ------------------------------------------------------
>>>> lck/31847 is trying to acquire lock:
>>>> ffff88811d268850 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}, at: btrfs_inode_lock+0x38/0x70
>>>> #012but task is already holding lock:
>>>> ffffffffb41848c0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x506/0x1db0
>>>> #012which lock already depends on the new lock.
>>>> #012the existing dependency chain (in reverse order) is:
>>>>
>>>> #012-> #1 (fs_reclaim){+.+.}-{0:0}:
>>>>        fs_reclaim_acquire+0xc0/0x100
>>>>        __kmalloc+0x51/0x320
>>>>        btrfs_buffered_write+0x2eb/0xd90
>>>>        btrfs_do_write_iter+0x6bf/0x11c0
>>>>        do_iter_readv_writev+0x2bb/0x5a0
>>>>        do_iter_write+0x131/0x630
>>>>        nfsd_vfs_write+0x4da/0x1900 [nfsd]
>>>>        nfsd4_write+0x2ac/0x760 [nfsd]
>>>>        nfsd4_proc_compound+0xce8/0x23e0 [nfsd]
>>>>        nfsd_dispatch+0x4ed/0xc10 [nfsd]
>>>>        svc_process_common+0xd3f/0x1b00 [sunrpc]
>>>>        svc_process+0x361/0x4f0 [sunrpc]
>>>>        nfsd+0x2d6/0x570 [nfsd]
>>>>        kthread+0x2a1/0x340
>>>>        ret_from_fork+0x22/0x30
>>>>
>>>> #012-> #0 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}:
>>>>        __lock_acquire+0x318d/0x7830
>>>>        lock_acquire+0x1bb/0x500
>>>>        down_write+0x82/0x130
>>>>        btrfs_inode_lock+0x38/0x70
>>>>        btrfs_sync_file+0x280/0x1010
>>>>        nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
>>>>        nfsd_file_put+0xd4/0x110 [nfsd]
>>>>        release_all_access+0x13a/0x220 [nfsd]
>>>>        nfs4_free_ol_stateid+0x40/0x90 [nfsd]
>>>>        free_ol_stateid_reaplist+0x131/0x210 [nfsd]
>>>>        release_openowner+0xf7/0x160 [nfsd]
>>>>        __destroy_client+0x3cc/0x740 [nfsd]
>>>>        nfsd_cc_lru_scan+0x271/0x410 [nfsd]
>>>>        shrink_slab.constprop.0+0x31e/0x7d0
>>>>        shrink_node+0x54b/0xe50
>>>>        try_to_free_pages+0x394/0xba0
>>>>        __alloc_pages_slowpath.constprop.0+0x5d2/0x1db0
>>>>        __alloc_pages+0x4d6/0x580
>>>>        __handle_mm_fault+0xc25/0x2810
>>>>        handle_mm_fault+0x136/0x480
>>>>        do_user_addr_fault+0x3d8/0xec0
>>>>        exc_page_fault+0x5d/0xc0
>>>>        asm_exc_page_fault+0x27/0x30
>>> Is this deadlock possible only via the filecache close
>>> paths?
>> I'm not sure, but there is another back trace below that shows
>> another problem.
>>
>>>   I can't think of a reason the laundromat has to
>>> wait for each file to be flushed and closed -- the
>>> laundromat should be able to "put" these files and allow
>>> the filecache LRU to flush and close in the background.
>> ok, what should we do here, enhancing the laundromat to behave
>> as you describe?
> What I was suggesting was a longer term strategy for improving the
> laundromat. In order to scale well in the number of clients, it
> needs to schedule client expiry and deletion without serializing.
>
> (ie, the laundromat itself can identify a set of clients to clean,
> but then it should pass that list to other workers so it can run
> again as soon as it needs to -- and that also means it can use more
> than just one CPU at a time to do its work).

I see. Currently on my lowly 1-CPU VM it takes about ~35 secs to
destroy 128 clients, each with only few states (generated by pynfs's
CID5 test). We can improve on this.

>
> In the meantime, it is still valuable to consider a shrinker built
> around using ->nfsd_courtesy_client_count only. That was one of
> the two alternatives I suggested before, so I feel we have some
> consensus there. Please continue to look into that, and we can
> continue poking at laundromat improvements later.

Okay,

Thanks,
-Dai

>
>
>> Here is another stack trace of problem with calling expire_client
>> from 'scan' callback:
>> Sep  3 09:07:35 nfsvmf24 kernel: ------------[ cut here ]------------
>> Sep  3 09:07:35 nfsvmf24 kernel: workqueue: PF_MEMALLOC task 3525(gmain) is flushing !WQ_MEM_RECLAIM nfsd4_callbacks:0x0
>> Sep  3 09:07:35 nfsvmf24 kernel: WARNING: CPU: 0 PID: 3525 at kernel/workqueue.c:2625 check_flush_dependency+0x17a/0x350
>> Sep  3 09:07:35 nfsvmf24 kernel: Modules linked in: rpcsec_gss_krb5 nfsd nfs_acl lockd grace auth_rpcgss sunrpc
>> Sep  3 09:07:35 nfsvmf24 kernel: CPU: 0 PID: 3525 Comm: gmain Kdump: loaded Not tainted 6.0.0-rc3+ #1
>> Sep  3 09:07:35 nfsvmf24 kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>> Sep  3 09:07:35 nfsvmf24 kernel: RIP: 0010:check_flush_dependency+0x17a/0x350
>> Sep  3 09:07:35 nfsvmf24 kernel: Code: 48 c1 ee 03 0f b6 04 06 84 c0 74 08 3c 03 0f 8e b8 01 00 00 41 8b b5 90 05 00 00 49 89 e8 48 c7 c7 c0 4d 06 9a e8 c6 a4 7f 02 <0f> 0b eb 4d 65 4c 8b 2c 25 c0 6e 02 00 4c 89 ef e8 71 65 01 00 49
>> Sep  3 09:07:35 nfsvmf24 kernel: RSP: 0018:ffff88810c73f4e8 EFLAGS: 00010282
>> Sep  3 09:07:35 nfsvmf24 kernel: RAX: 0000000000000000 RBX: ffff88811129a800 RCX: 0000000000000000
>> Sep  3 09:07:35 nfsvmf24 kernel: RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffed10218e7e93
>> Sep  3 09:07:35 nfsvmf24 kernel: RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed103afc6ed2
>> Sep  3 09:07:35 nfsvmf24 kernel: R10: ffff8881d7e3768b R11: ffffed103afc6ed1 R12: 0000000000000000
>> Sep  3 09:07:35 nfsvmf24 kernel: R13: ffff88810d14cac0 R14: 000000000000000d R15: 000000000000000c
>> Sep  3 09:07:35 nfsvmf24 kernel: FS:  00007fa9a696c700(0000) GS:ffff8881d7e00000(0000) knlGS:0000000000000000
>> Sep  3 09:07:35 nfsvmf24 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> Sep  3 09:07:35 nfsvmf24 kernel: CR2: 00007fe922689c50 CR3: 000000010bdd8000 CR4: 00000000000406f0
>> Sep  3 09:07:35 nfsvmf24 kernel: Call Trace:
>> Sep  3 09:07:35 nfsvmf24 kernel: <TASK>
>> Sep  3 09:07:35 nfsvmf24 kernel: __flush_workqueue+0x32c/0x1350
>> Sep  3 09:07:35 nfsvmf24 kernel: ? lock_downgrade+0x680/0x680
>> Sep  3 09:07:35 nfsvmf24 kernel: ? rcu_read_lock_held_common+0xe/0xa0
>> Sep  3 09:07:35 nfsvmf24 kernel: ? check_flush_dependency+0x350/0x350
>> Sep  3 09:07:35 nfsvmf24 kernel: ? lock_release+0x485/0x720
>> Sep  3 09:07:35 nfsvmf24 kernel: ? __queue_work+0x3cc/0xe10
>> Sep  3 09:07:35 nfsvmf24 kernel: ? trace_hardirqs_on+0x2d/0x110
>> Sep  3 09:07:35 nfsvmf24 kernel: ? nfsd4_shutdown_callback+0xc5/0x3d0 [nfsd]
>> Sep  3 09:07:35 nfsvmf24 kernel: nfsd4_shutdown_callback+0xc5/0x3d0 [nfsd]
>> Sep  3 09:07:35 nfsvmf24 kernel: ? lock_release+0x485/0x720
>> Sep  3 09:07:35 nfsvmf24 kernel: ? nfsd4_probe_callback_sync+0x20/0x20 [nfsd]
>> Sep  3 09:07:35 nfsvmf24 kernel: ? lock_downgrade+0x680/0x680
>> Sep  3 09:07:35 nfsvmf24 kernel: __destroy_client+0x5ec/0xa60 [nfsd]
>> Sep  3 09:07:35 nfsvmf24 kernel: ? nfsd4_cb_recall_release+0x20/0x20 [nfsd]
>> Sep  3 09:07:35 nfsvmf24 kernel: nfsd_courtesy_client_scan+0x39f/0x850 [nfsd]
>> Sep  3 09:07:35 nfsvmf24 kernel: ? preempt_schedule_notrace+0x74/0xe0
>> Sep  3 09:07:35 nfsvmf24 kernel: ? client_ctl_write+0x7c0/0x7c0 [nfsd]
>> Sep  3 09:07:35 nfsvmf24 kernel: ? preempt_schedule_notrace_thunk+0x16/0x18
>> Sep  3 09:07:35 nfsvmf24 kernel: shrink_slab.constprop.0+0x30b/0x7b0
>> Sep  3 09:07:35 nfsvmf24 kernel: ? unregister_shrinker+0x270/0x270
>> Sep  3 09:07:35 nfsvmf24 kernel: shrink_node+0x54b/0xe50
>> Sep  3 09:07:35 nfsvmf24 kernel: try_to_free_pages+0x394/0xba0
>> Sep  3 09:07:35 nfsvmf24 kernel: ? reclaim_pages+0x3b0/0x3b0
>> Sep  3 09:07:35 nfsvmf24 kernel: __alloc_pages_slowpath.constprop.0+0x636/0x1f30
>> Sep  3 09:07:35 nfsvmf24 kernel: ? warn_alloc+0x120/0x120
>> Sep  3 09:07:35 nfsvmf24 kernel: ? __zone_watermark_ok+0x2d0/0x2d0
>> Sep  3 09:07:35 nfsvmf24 kernel: __alloc_pages+0x4d6/0x580
>> Sep  3 09:07:35 nfsvmf24 kernel: ? __alloc_pages_slowpath.constprop.0+0x1f30/0x1f30
>> Sep  3 09:07:35 nfsvmf24 kernel: ? find_held_lock+0x2c/0x110
>> Sep  3 09:07:35 nfsvmf24 kernel: ? lockdep_hardirqs_on_prepare+0x17b/0x410
>> Sep  3 09:07:35 nfsvmf24 kernel: ____cache_alloc.part.0+0x586/0x760
>> Sep  3 09:07:35 nfsvmf24 kernel: ? kmem_cache_alloc+0x193/0x290
>> Sep  3 09:07:35 nfsvmf24 kernel: kmem_cache_alloc+0x22f/0x290
>> Sep  3 09:07:35 nfsvmf24 kernel: getname_flags+0xbe/0x4e0
>> Sep  3 09:07:35 nfsvmf24 kernel: user_path_at_empty+0x23/0x50
>> Sep  3 09:07:35 nfsvmf24 kernel: inotify_find_inode+0x28/0x120
>> Sep  3 09:07:35 nfsvmf24 kernel: ? __fget_light+0x19b/0x210
>> Sep  3 09:07:35 nfsvmf24 kernel: __x64_sys_inotify_add_watch+0x160/0x290
>> Sep  3 09:07:35 nfsvmf24 kernel: ? __ia32_sys_inotify_rm_watch+0x170/0x170
>> Sep  3 09:07:35 nfsvmf24 kernel: do_syscall_64+0x3d/0x90
>> Sep  3 09:07:35 nfsvmf24 kernel: entry_SYSCALL_64_after_hwframe+0x46/0xb0
>> Sep  3 09:07:35 nfsvmf24 kernel: RIP: 0033:0x7fa9b1a77f37
>> Sep  3 09:07:35 nfsvmf24 kernel: Code: f0 ff ff 73 01 c3 48 8b 0d 36 7f 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 fe 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 7f 2c 00 f7 d8 64 89 01 48
>> Sep  3 09:07:35 nfsvmf24 kernel: RSP: 002b:00007fa9a696bb28 EFLAGS: 00000202 ORIG_RAX: 00000000000000fe
>> Sep  3 09:07:35 nfsvmf24 kernel: RAX: ffffffffffffffda RBX: 00005638abf5adc0 RCX: 00007fa9b1a77f37
>> Sep  3 09:07:35 nfsvmf24 kernel: RDX: 0000000001002fce RSI: 00005638abf58080 RDI: 000000000000000d
>> Sep  3 09:07:35 nfsvmf24 kernel: RBP: 00007fa9a696bb54 R08: 00007ffe7f7f1080 R09: 0000000000000000
>> Sep  3 09:07:35 nfsvmf24 kernel: R10: 00000000002cf948 R11: 0000000000000202 R12: 0000000000000000
>> Sep  3 09:07:35 nfsvmf24 kernel: R13: 00007fa9b39710e0 R14: 00005638abf5adf0 R15: 00007fa9b317c940
>>
>> Another behavior about the shrinker is that the 'count' and 'scan'
>> callbacks are not 1-to-1, meaning the 'scan' is not called after
>> every 'count' callback. Not sure what criteria the shrinker use to
>> do the 'scan' callback but it's very late, sometimes after dozens
>> of 'count' callback then there is a 'scan' callback. If we rely on
>> the 'scan' callback then I don't think we react in time to release
>> the courtesy clients.
>>
>> -Dai
>>
>>>
>>> --
>>> Chuck Lever
> --
> Chuck Lever
>
>
>
