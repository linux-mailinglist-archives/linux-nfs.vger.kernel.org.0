Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AA8371A4A
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 18:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhECQj0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 12:39:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50416 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhECQiP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 May 2021 12:38:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143GQWT0095540;
        Mon, 3 May 2021 16:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=H8EWUCEOUdawePiIdIafclIa0Vmb4KgVGXmQyKiZVr0=;
 b=X3IWWY3kL2IwLZgTApek1Qj5tOaP0wQXHZ4l92UXUqOzi4tMCIKYMpwEPMFxgd4vQOq0
 vDZlXKOhszAZ8l99kGz2gZHHjm5Fh7qO1ONIzHNx9vgOjX3ZL1i16HiYdhf0zNCheo9A
 OYpa7FyzJ09/CMhCuWMxql65lYgBISLqo5EGZtlGIyAZ4FoiXwMnW5+0CU+RLhdfDbdm
 T4/UbvCFb+XrQCVE0fOY+8TqzGrWU+CQy5YJRvgsOmWIaXGIPcy0uQKVeVXUC8oSHl3p
 6ZKOJ18GV1uHd3t83EdGyY4euL8zigeXSQsx7dYr6/dLzimxKXgfZ07rthkQPcZfdSJy 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 388xdrv8ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 16:37:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143GKECk074241;
        Mon, 3 May 2021 16:37:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 388xt2nf3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 16:37:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQDi6LTd52QN9nx2HxK8RhP4HL1AjLFMv1ySe7LqmaRYTF2I1031q78NbOnbla8JyDVoGBhlGgPv5hE0Gs/2JV4dmLY/9jVR4nZGYW7cMfz9j/a94BLPqxjGhZ0ImhEpN2glun9Vhffkb+Tiflk99hsRX3JDJ9OuUqg++lyNDNA3PBoMbEky7rxAbbLSxSZZjmj80mH1SNNptdZTU0wFx12mrdC7vKhw/Ftx4UFM1+Das0Ktx2p+hy8W5PVSExsQFwnSOcDx+EipDZRsDyi0VV4D8tHvuSrh0puDslqbHeqAuI70PR03YHscCDAYFZUtdXS8u1fp/pKYbidr18a1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8EWUCEOUdawePiIdIafclIa0Vmb4KgVGXmQyKiZVr0=;
 b=QpbS8lmCwxLIwvsvEKk7qs+d0JnnFb3PRN52HgCXdUE07b14S7j21XRDtAG/gKaKFDsug0wzZ/leAlJ2FD/33XhgCf9qeyyf2H+iSw6zPAXU+ncwk9PkIVL1FVrD+2HUtzdSl7OnYxHHjubeaWuvCga8g4+fgio9Pa5HwuDcw+cJjgE/KhZdTjcjkupKKzTwdTW/akOGQxagdlpAmmOCJsJB6iSJ/h65C4hgLSTP8JlaoXZKAN0Bscr5zKWdT5uW76ZE8Whz2EyQdr590fq76Iu45CNPf7RFMclUZDlOMBWNw2iCiNi41fVeRUtXnvDSZbw1vcwDJt9gQCf0LqEipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8EWUCEOUdawePiIdIafclIa0Vmb4KgVGXmQyKiZVr0=;
 b=hkmnBskycN8ugr+5MMViai/BIh47VMOfGdouoAYPJkCugwFtTB4JZzUjD5s0/vRYQLNFmmv1/yodfr3QjPh0RvycIEVggWieQwl6bjeqHm2souzHW0UclsSIT61bcKIGjm8YnarfNsnfuH8gDjdiJTSWIemHO8wSvvV63zEHA7o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB5406.namprd10.prod.outlook.com (2603:10b6:a03:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Mon, 3 May
 2021 16:37:10 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%5]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 16:37:10 +0000
Subject: Re: [PATCH v4 0/2] NFSD: delay unmount source's export after
 inter-server copy completed.
From:   dai.ngo@oracle.com
To:     olga.kornievskaia@gmail.com
Cc:     trondmy@hammerspace.com, bfields@fieldses.org,
        chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <20210423205946.24407-1-dai.ngo@oracle.com>
Message-ID: <e0ec16f9-9780-c2c5-8cd4-c1083a2227fb@oracle.com>
Date:   Mon, 3 May 2021 09:37:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <20210423205946.24407-1-dai.ngo@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: BYAPR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::22) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-155-60.vpn.oracle.com (72.219.112.78) by BYAPR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:c0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend Transport; Mon, 3 May 2021 16:37:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4888c701-527a-4f0a-3af3-08d90e51b2b1
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5406:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54062BE06A52F0FC38E8B07B875B9@SJ0PR10MB5406.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WTVLl35VYghJ8IvAp2YSlNz4WqRipwguvU0O0+DA2PtlTNSkUkTv55I4KIQNvspJkhOx8Wu+qmIu1+ksrdnD156ajuKhFHWhi/GeOiwuymNl+G6+cBj6Z7B0Npuv9lnlAQYMqbHAQfnvKL+2+OnOB/sEQhpVio+y7lzSIADK7Td3YaeT7YfoG9/d9IKV+c19GxDUadVTWgvNV/kPZEqi7ZNoaUK/JUD1Mw+ztoDAIjZhwjVYlm/qkkQb+Xi60z+F7VZieOMUkas4VtyZOXshFNR8OFpgsiq6z94l54IfQd1JQ37SqNMCoux8nBHQgcM3duWoUxtDunAIJEirMX2nyeZeiMyDP9hKgnPqM0az2UDBTxWDSQdf8zlwGuV4slf3eocVPpXCEWgs8Jvy3phiNN4JwIWwCj4U+dL4xe2Y2orw1z19JnoFltRJ6zBNxrtPYDXDczb3a/vTJudAt3P0rHbB/T4wIfSijcAXon3h5gKDPqzEmeh0rHzo5a3xSllN8JhmrEnFFBHhhVdGHLE1NvUmZnuGIXCI+Hy3VePG8drU3KXRMlC0zV/9qYWo6s59RFlQZdOKwRiubvOOa4xEVMV0ZYsm9+9F4Lr5nvOpdH6TxGRD1KT98z8JaMxcpwdStyn89ZQjmDRLfAzojj6H/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(316002)(36756003)(86362001)(478600001)(4326008)(66476007)(66556008)(8676002)(31686004)(16526019)(956004)(186003)(31696002)(2616005)(66946007)(6486002)(5660300002)(6916009)(7696005)(53546011)(9686003)(2906002)(38100700002)(83380400001)(26005)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SVk4OTMzbGp4MFVwY0MzNmhZOWU5YlVWMFFaMEFPRTVzVTV2R3hXL0JqSGNF?=
 =?utf-8?B?QmZuVmNPOWtGOGFYWkIxL3o3YkxGb0xJRlk3NWwwR1RtcVZucFFIVS9XNkcv?=
 =?utf-8?B?NkFLbFAreUkybFhYUUs3VVhHK2Q3bURYaGxLa29oMFZBdlE4cDIvdmQwWmsy?=
 =?utf-8?B?WTB3Y0FybHh4UHJldzB6c2Y0OElYR2c1QWhoOVJYNCtzbW12K3dIZlJ5RHZN?=
 =?utf-8?B?ZmRVTUw1bUY3R3lXeTJDd1lmcDJnRjFOaE1YQ0h5VFh0ZEllYVRTYVNOMjBq?=
 =?utf-8?B?c0Q4ays0c0w5eVRLTCtOMzd2aCtJYUJjQXNCNWRGTXJZdVRaNjVpR1ROdVF1?=
 =?utf-8?B?eXNON3RjN0wzUWR2cXdPZ2sxaFVuMDJNT0lWemtJc0w5QWV3MnJQS0RDdGM2?=
 =?utf-8?B?UGNSYzRmR05RK2w1SG1YcGo5NWFCbFdrV0xGTm1KSjhEVXc2MVhXMThFNkZk?=
 =?utf-8?B?OFVTdEhYdEN0VzVwbnRnYjVWRjhDRXFPdmozNUZLNTY0aEpZQWwyem1UWndz?=
 =?utf-8?B?VVhLVHVXMG1pZ0hEVXZ3ekZFc0NpTytiUWRKZnJXampNOCtDbDMyWGFNYjhu?=
 =?utf-8?B?Nmhld3NlUGFtdnBtSU1HdlZYVHl0QktESWpKQzVrTnl6NzZ4T3RFbVVVcFow?=
 =?utf-8?B?UFZMMExhb0trKzIvaktUMXpCRndNUEQ3cXgzWUVnSEJwcS9udWlFWThvemZh?=
 =?utf-8?B?YUd6UjhVQ1FwcFkvOG54VWxnUlA4aEhNQU9Id0drMWFaNnJUYnRmaU1xMkdw?=
 =?utf-8?B?eFcveEVGYnRhZFlrdWxOVVR2Y25uazdScWs3MXh4UEN2SzIwRG0vOGEvanNT?=
 =?utf-8?B?M3RTUEZ1ME0rM041czFRbW1EVFhOVEFHS0R1RE9mSjJSbG9YYysxVXErYVMy?=
 =?utf-8?B?dVorREtCa0Y1Y3RvV1FOQXZDaGJlQ3lTZDl4bmlPTTdvdEtoQ3hNdFRWWW1n?=
 =?utf-8?B?NVh3dkY4Ujl3N2dUSE51MWlGTGZaSk8xcDliTWx2cENXRUMxQ0JkK2Uxdk1x?=
 =?utf-8?B?ZTZBYzNLQUQvazlvOW5PdUtidDBUU1lBN2tZUnVWemFlQ3QvOHBPZVBRRWVT?=
 =?utf-8?B?UTNTV0ttQUloMVIrTnlLcjA5QnFsckhJT2VWTzB2VDhYUnVsd2ZQQ0dIK3lS?=
 =?utf-8?B?UzV3UUxXOXpBUjRIU1lreU41N0FiYTN0YitDTWxRc0hPUkEvRnl1QWhoanNB?=
 =?utf-8?B?SnBBbnJrL3VCWXJoZkY4cmk0VlQ3c1hnVmR5MWNRdkJ1bjdueE0vaVVKeG5q?=
 =?utf-8?B?RDlGRzZGdVBqb2IyT2xXVEZEYzZubjF2QjNwb1o1R2hBb0xCSGU4aUJQT3hw?=
 =?utf-8?B?aS9iblROS3lPN0ZoK1JIbkxQRDRrcmk2UUdweW4xeC9hcXBBS2xlLzlTMVpL?=
 =?utf-8?B?am9nOUFyWXg0dEJpZkNSbStRRDJ5TzJOcllycy9ndFZZWmlhQ1h4TUFlRzd6?=
 =?utf-8?B?T0Erb0IrdElvekJwOERzRkhVa1pUelh0Nm96cEZqbTNUOFBxRmFhRHlsVUdj?=
 =?utf-8?B?QXRBa3NaYnREMzFzamt6RW8xRlMzcmk4ZVhMSTdvYkxNMTgzSUV2Yk1SN0di?=
 =?utf-8?B?UklBV2hEa2ppckljenp0d1lyT3VoUXN2dmtoR2dNNFhGMzA1TExWb2ZUUDRY?=
 =?utf-8?B?dWZlekswMkdocmV4RnZ1L1BQZ1Z1Wnp5RkxpV1FUWUkxcHlScUxXWU95Zlo0?=
 =?utf-8?B?SWhlT0lUSTVHRUN6c1FiOUhiWTZndHRVbFo3L3BPbVhRUHE4T3NBQ1ZWQ0hR?=
 =?utf-8?Q?L5E+Tp61Jkge0KIuTaMhKNxO9khYS7lQAyCxmY+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4888c701-527a-4f0a-3af3-08d90e51b2b1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 16:37:10.4656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QR2XERB9NbrO0kKUoZ19vxUcinEbk3dyeQtwpvt/RV3PLEdavxJCvgL3QYOxU7IyUQV3PNX1VGKnb9fVAfSdfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5406
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030108
X-Proofpoint-ORIG-GUID: 4CSTVjoEJ6gRNRR877wSOeRFhph_jSjT
X-Proofpoint-GUID: 4CSTVjoEJ6gRNRR877wSOeRFhph_jSjT
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030108
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,

Just a reminder that v4 patch is available for your review.

Thanks,

-Dai

On 4/23/21 1:59 PM, Dai Ngo wrote:
> Hi Olga,
>
> Currently the source's export is mounted and unmounted on every
> inter-server copy operation. This causes unnecessary overhead
> for each copy.
>
> This patch series is an enhancement to allow the export to remain
> mounted for a configurable period (default to 15 minutes). If the
> export is not being used for the configured time it will be unmounted
> by a delayed task. If it's used again then its expiration time is
> extended for another period.
>
> Since mount and unmount are no longer done on every copy request,
> the restriction of copy size (14*rsize), in __nfs4_copy_file_range,
> is removed.
>
> -Dai
>
> v2: fix compiler warning of missing prototype.
> v3: remove the used of semaphore.
>      eliminated all RPC calls for subsequence mount by allowing
>         all exports from one server to share one vfsmount.
>      make inter-server threshold a module configuration parameter.
> v4: convert nsui_refcnt to use refcount_t.
>      add note about 20secs wait in nfsd4_interssc_connect.
>      removed (14*rsize) restriction from __nfs4_copy_file_range.
>
>
>
