Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB5862C8C1
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Nov 2022 20:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiKPTIi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Nov 2022 14:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKPTIg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Nov 2022 14:08:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7184F22BD4
        for <linux-nfs@vger.kernel.org>; Wed, 16 Nov 2022 11:08:35 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGH3tRn025321;
        Wed, 16 Nov 2022 19:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mahVUEM/g4p/7Hek77ua8PTyBFw0MRDVq4U0rnNBxgs=;
 b=I4HtXzrdGnWsLXEDXLYIwVJxWNfHMetOHqHFtWFhampkArteArhOevvFCKa37kD6GR19
 WfLJ18h8zf/tVbcgNFpNZRms8I2JuasUM0qtIJKkvVMmkzJyP7lF2wIERYySNQlryYO1
 yfRfCaT60ItvwNlSQgUi5zkK3L/KRjF4eMLnnz/zU+grsSk6lFJLyC/iyaD1IDxUNkH5
 PYfpgluJGmM0FGl0lgO2QfHX6nObTxt0jPyk2qbjakKYKOq+VbuDn9S3skhvFb1/V981
 O0j6EKyE6y1SXa6V1vJoYXTNuH0M7EQJ3AIldGAzbLYkrtWVI1Qmn+xknlnIhIvEt0u2 pg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3n16a9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 19:08:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGHsFrn040918;
        Wed, 16 Nov 2022 19:08:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3k8r32m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 19:08:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyyrZqgOx3o6ixYaAym2+3XyffIGUlO+8oSa3su6tpLZjI5WSemjz35lic/qYSuYWGWiazsGIKgU2kRszj3ssEYu/Mg2a6bDtptCr76iqo3StR7zHvCZUxKsl9vuOPgvX9nrDbjnMyRFQ2Qi8HEF6mxrsUtvtYpwnVb5nVKsMyAYp0Ta73cE1Oritk5pUShWpqYpdRubTy8nGxEBOz/dLPJoSmiGkwf4RQpmv/OhKEeKMu4N7v5fQZ5sQRmmQmp/GbuF3buL24sNzFfFE28dg9ujkL5iZ3J77zpQAclwRQL3z2fUNHox+RPXK5yG8lafZQ8BdNbQK0X72hgUCj1gYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mahVUEM/g4p/7Hek77ua8PTyBFw0MRDVq4U0rnNBxgs=;
 b=lsYrtVLc0mkqMLq9NFvOaoY0TimijzIlNrI5Nu8aF39hUoIz1sCrPaoEQziDrJwrpRY52+OKmU3wJSrHqgT3zIq4pZEQO6BaE+HjXKA6d5buAIhKU0cSXB5QC97Gf830uCMCxzXnk+/zSXXhBCdxLpPEGdA5UafoiAjl1FRtfL1qEfR11XQx0CW+nKuqGFA2dCuLSzVnAxGIDHJRkgKQqThyMKdXE/rGTreGsP7faJ2ekItQ5nmTifuIB3TnZ7GTaxzrbBL5X9OSkbZfHlIixFex9+q6savTxr1Ecb+4CseKl4Oia5fK38LpP6EAy3b0bLUz0t712dOv3CsruJ62mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mahVUEM/g4p/7Hek77ua8PTyBFw0MRDVq4U0rnNBxgs=;
 b=h0URzumJz2G4JLWJhCAgF1kciAfi4lwI7faF6zVQTSIErvj6/91yLYzEheHhK7rOj8PlwUKZPgjtf76GcEnOKBsTNuzQ2mnoITOKu/VbF2exFeEV/UWBHHD/LZy8zkMb8xWf+kTFz5fzO+JaJVjE21o1/PLcB4p5gHqX6CKSbQs=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CO1PR10MB4465.namprd10.prod.outlook.com (2603:10b6:303:6d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 19:08:22 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2d62:ce4b:356d:e242]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2d62:ce4b:356d:e242%9]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 19:08:22 +0000
Message-ID: <8e055819-9f3b-e751-99ab-85682c28081b@oracle.com>
Date:   Wed, 16 Nov 2022 11:08:19 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] NFSD: pass range end to vfs_fsync_range() instead of
 count
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Brian Foster <bfoster@redhat.com>
References: <20221116152836.3071683-1-bfoster@redhat.com>
 <87A52A9B-83F7-4FE6-8ED1-E710BAFF84B5@oracle.com>
 <5163ae19-b78b-d047-f700-93b3ad651eea@oracle.com>
 <F8A4FD38-41F4-4B03-99D9-7043CD3977FF@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <F8A4FD38-41F4-4B03-99D9-7043CD3977FF@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:806:6e::33) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CO1PR10MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 6993f3f6-8a79-466e-112b-08dac805ee36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQNnT5c9T2ISkrxuC8+X+vjTBEM6uAnTRzjN74sZK4lAdXqIGn4MQu7a8DBFcg4KxSVwcz5wIHz6OzAe8Ea2XpOdR5D6l+l82RF66iIoJJYSPKbtJ0Js6JXcACmYYjGH06YXtlgLbP1YCKHezhn/D+Tq1XhZw3RnsLZ96bcXht+VeZ1DW2IrTe20kUNJjl7TYKh4YcB1UejJqS0cslbrqmxo1zBgj+MTiYD3celGtDHopi7rIALEyr3cVFq65ZUJlnep+N/IrGifs6KQBnV/YdLWTejSwZ4KAHx/dn9nKqPQYvVnCNWOvRTGXegeXPDAvRcu5Sv+gU7M3BXFFpm3JAaF53hrT6LeVQJZKuUGnw3SPz8wQZq6PWmsga0FwcoZUBCDMumNNfHBWSGw54+m4Eq/abu6Jjlrw/PZ0frXW63B4ZOUR4hnLzq+jsICXDMXVTX2BIXkB1M6ZrH3TmEojOX1ZGoKqH0AtRjpBFLw4VpPoVv6+E3HeTZc784JaWa4MLecBEtoz7sZ3DL7ZyDXFVGYohOt/HJTD19AJokA35VLfmg9Sx8WEJSHESoWx5nJS1L8ZmSo2akPbnLeXH/vUB36QxDMwaz/zIPklZii9Rd3fYdAsi4ISIf77cuiRpLL6bov+eJMHG8sUcRvw0b3DcFLq1c0YMDl6iwG8gl/1S9LgEza0su9mekN6ytk5YVYZ7J6epqZak7D0qES3NZ1nFWJYA4qa1c3rhegebFLXNy6hyg9TnBogrLF7lKUBvZd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199015)(36756003)(9686003)(86362001)(31696002)(83380400001)(53546011)(2616005)(26005)(6506007)(6666004)(186003)(6512007)(38100700002)(6862004)(8936002)(8676002)(41300700001)(4326008)(2906002)(66476007)(66946007)(5660300002)(66556008)(54906003)(478600001)(316002)(37006003)(6486002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ulp0b1lBaFVPMEVRQW11RDYyakwzSlM3S2lZeElHQ3RyanRUOEs1eFY4anFO?=
 =?utf-8?B?dkxRaUZkMXFYK0NvbkU3OGlwNzgwK2I0RUIzcGYvaUtsN1dHbS9tdW5USXBS?=
 =?utf-8?B?QjNKRHlOa1dOMWZWQis0Rk5lWTBwZ3Rmbm1lK0xxUUNnNDNaRXByVC92KzQ4?=
 =?utf-8?B?NFBxV1VkeWdSc2tNQlhkVGFTUVFZUjNCK1FEc0dEcWVMM0VqT0ZGM0dnU0Nz?=
 =?utf-8?B?NGlTbXh2UWxHWGxXRU1YNGxvSjdVRkFrM1NVcFVDbDBEaXA0NDhTZkVTQzZE?=
 =?utf-8?B?em1qbDZDdnBIUnVhZUg5UWlKOW9ZNG9QdnNOMnk1dENHblRTaThmdUJ0aUFB?=
 =?utf-8?B?VU1FRW5oZDNpeXNrajNvT3p0a3dxbEcyNUVSUXM3MHZNN0Q3dERHT2lDWVhG?=
 =?utf-8?B?MlVDNldwQ0tESElYMEpmZndvdUc4TGt3WTFwT21LZitLUWNuT21pcTArdkdi?=
 =?utf-8?B?K1VrWFVpZVJNdTJUcGRqT1c5Q0R2azNsUHpwdm80bjlNWEZOMXFhbDJFQ3My?=
 =?utf-8?B?MVAzRFcrTlRDWEVpOWZtM28rczA0dnlOUE1ZVmM0L0k1RzhYNzRsZnpLaTI1?=
 =?utf-8?B?SnVPM3BVUVZxS1BxTFQrWGJtWWgrRmlzdmFrSVltcmFqUW5HeC85T3hYWXlr?=
 =?utf-8?B?RTFYcGZmU3MrOTVYRjcrODAxSXlqZzZKczVMSHQ0OGdLTG1JNm90S2NHNFhu?=
 =?utf-8?B?SEttRGQzVWQ2aERkZzhaeS9NU1I1c00vZE1qN1FMNGNrbFhpeCt5QTBVVVBU?=
 =?utf-8?B?SzN2M3V4ZXZPQ0tIaVZpSTBmeEVlWFBDbzhrQlgzUTgvN0txcTRZbDArR1cz?=
 =?utf-8?B?U2tLMTd4YVIwZmQ1QUY1cjFuMkRBbGpZZVRuVjBDWGlFcDNMWUVLcnlHSW9Y?=
 =?utf-8?B?YkpnU1UwbGNpNUFJSHUrVEVUVit3SDBmSk9RcEp6czlkcUg1RHgreTZwTDcr?=
 =?utf-8?B?U25mN3owRnYvWU5UVTc0UUpidjZMbUVzeDBDdGFVSGZSdjV0TjRyTGY3M1Uv?=
 =?utf-8?B?Z0lzdHlzVDRRR0ZBdGYzbGhEMUIxeGRYU0hJazZERkpRVTdCSzJRQVRKQVJy?=
 =?utf-8?B?OFRYYThCT0dBOXJvaWlyVVFQWk5QNDZlOUZ1akJMdGd4M2ordVlwS08ybFNq?=
 =?utf-8?B?Q0JLT1Q2cjNJREJmNFFZcU9TbFVnNnM2YVNnSjk5WkFqa2RsUXJwcXdjV2NS?=
 =?utf-8?B?WmJHMlRJcnQ3Z0o4WXBkUVdYT296UUtuTVYzQ01lRmZQdUpHYitHUUhIa3Bj?=
 =?utf-8?B?aVhsaXlWTVAvWDd5TkhLSm9xSXVHZWcydEJBbFREWWJPM3VKa2ZveklKaWYw?=
 =?utf-8?B?ekRqSEJJNVdBaGdmU1JLVVF3TUV4clBqU1VzVDRxYno4aVgvQWtmNmwvaEw4?=
 =?utf-8?B?cTZSOHQ4NlRUclB3cS9GQ2tTY1lndysycGRXT1ZxNGhma05Pb3hhNkd2dVBV?=
 =?utf-8?B?Skdyb05NZ1BMMHNmNzg3RTlwb0w1b3JBZEo4ZktET2lpWll5Y0dtMTQ4VCtj?=
 =?utf-8?B?NVlYeStQVmRiaVpTelhPQktGTW1sSjh2Wm8zLzE3eElKMkkxNFByRStpYUhI?=
 =?utf-8?B?eVNtTm1PUkdZMTJMQjdVV3l4L3RjSE4rMTZTNU5RdjhsUzI0RERCSXFHSFA1?=
 =?utf-8?B?VEw5Z0lGeEsrU1d5eW1jZVVUZ0pZMExuN2JXdUU5UXRJKzA1alpzMGF6TDVT?=
 =?utf-8?B?M0luRExMZ212Zzh0U2pNMHBNc2p0LzlmK09xdW53UVRESVQ0dUZqcWhPdHFw?=
 =?utf-8?B?OHR0VWVKMFU1ZTFVMEFDdHFRY1MrT1ZrREQvWldLTTFxZFY1MjNITlNhYkRr?=
 =?utf-8?B?ZjBtMHhsd3JienFCdkRvSDBsQm5vNDEwa21RdWdGQWNGOVhJcXhqNU4zUUJz?=
 =?utf-8?B?ZkJrMmNRNk1xTnNVN2xyTmFIOFNVK2srVUdkWVR5RitiZHdUakl0VVhsWTF2?=
 =?utf-8?B?S0hiVWhkaHJNYnovRUl3MlVMTEtMUjBrTW9Ic0lCbWEwcmo0R3pxa2FlL2tQ?=
 =?utf-8?B?blBnRXpnUElsTHBtSzFKY0dBNmZ1ZHVQUHJXaHlvYjc3d2VVaC8zMnBEa2pp?=
 =?utf-8?B?RHBHb0o2UDJ2NGt2dnZmanFzeUgzRHloZlgzSWhvV2RibkNPUUk4OFQvWlJj?=
 =?utf-8?Q?t7nXISVJ8pVC3e3To6TMIQk16?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QkXd9h8LgnTYkGMK6FBZHtOc3j4AsnJGBNoy0FcBg8rDyz70CuCeQhNk92D/0aORp4hW8HDWBbVuUi8HACy9Tk/irRp28JJ9SbP3371TtAlR5445KuXfoc+2YlViQQ3q8xw3d0c2otASyriA/olCJe1VYhlV96mjhwY9iw0nIYO6sU7j3GdxidLL6X+fkbbxRP7Ll/pWf+GCbfXKCwZy/fji5CYxvESO/36MZbGpDKtfjmjOGaJYynkY1AI2NsH4cntjQ2Vkl1hX0B15zqmeZPpgNZsaElvn8MvVXTpVi3hw11hD6m8DG1Lm0+m+kyVcW+T/l3O+30OLtBLzzoXLiNmsaRH673upiehaB6zJuqIKls+fOqcEjG2KEDwNDKHTSI99bDoT1MQHIADHz+y8CmbffDeBFWgJ27+tS0l+qjrJsjn8ZGkeQBLQGtrQJJIF/p2eWtmypSaBX0djh6bj/T/VVp1uQrXvbdm1hTpnprqGMsN7hGTUVjthmYdTYTXjn5c8PUvotNJtgT64srJyX2QMUYA1x/H3/ucXUx/0yKGmxkZXE1E16yLZB2v7tZeueNVzH6KeT9OJAfGYZ76CXCekBQ7096iC3zMMqQHeUjT5oW3V4VAn2QsWZQEYDfR06FnyeY6CrHMglW2lRFC+SUQFKWV/NLRLPZip/hq0//iQlH5GgbwQCjZ1fsp7j9g6kBZy8npdeDc5+8tuFaxNXz4H0COQwnKzPG5839O4MbxbaKtJI8xYli1RSM5H16L26Hc9MoXfIXpxUw8QXfI4EAm25RMhf1wG/4EFV0VhtUyAwP3XZXn53bXoNqsdzJlo
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6993f3f6-8a79-466e-112b-08dac805ee36
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:08:22.5133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yq595uLPCBHSCklUiiZ6rYLWrHNStj/wtlAzpOZecO5Hdc00/vPaWCMTnOR708vr4Z5BTKlFS2iLHlklFKawXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160132
X-Proofpoint-GUID: W0Mn6KWdiBCujQetv97W9TA37paWDCq9
X-Proofpoint-ORIG-GUID: W0Mn6KWdiBCujQetv97W9TA37paWDCq9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/16/22 11:01 AM, Chuck Lever III wrote:
>
>> On Nov 16, 2022, at 1:50 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>>
>> On 11/16/22 7:34 AM, Chuck Lever III wrote:
>>>> On Nov 16, 2022, at 10:28 AM, Brian Foster <bfoster@redhat.com> wrote:
>>>>
>>>> _nfsd_copy_file_range() calls vfs_fsync_range() with an offset and
>>>> count (bytes written), but the former wants the start and end bytes
>>>> of the range to sync. Fix it up.
>>>>
>>>> Fixes: eac0b17a77fb ("NFSD add vfs_fsync after async copy is done")
>>>> Signed-off-by: Brian Foster <bfoster@redhat.com>
>>>> ---
>>>>
>>>> Hi all,
>>>>
>>>> This is just a quick drive-by patch from scanning through various flush
>>>> callers for something unrelated. It looked like this instance passes a
>>>> count instead of the end offset and it was easy enough to throw up a
>>>> patch. Compile tested only, feel free to toss it if I've just missed
>>>> something, etc. etc.
>>> Dai, Olga, can you review this, and one of you test it?
>> LGTM, tested ok.
> May I add Tested-by: Dai Ngo <dai.ngo@oracle.com> ?

Yes,

Thanks,
-Dai

>
>
>> -Dai
>>
>>>
>>>> Brian
>>>>
>>>> fs/nfsd/nfs4proc.c | 5 +++--
>>>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>> index 8beb2bc4c328..3c67d4cb1eba 100644
>>>> --- a/fs/nfsd/nfs4proc.c
>>>> +++ b/fs/nfsd/nfs4proc.c
>>>> @@ -1644,6 +1644,7 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
>>>> 	u64 src_pos = copy->cp_src_pos;
>>>> 	u64 dst_pos = copy->cp_dst_pos;
>>>> 	int status;
>>>> +	loff_t end;
>>>>
>>>> 	/* See RFC 7862 p.67: */
>>>> 	if (bytes_total == 0)
>>>> @@ -1663,8 +1664,8 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
>>>> 	/* for a non-zero asynchronous copy do a commit of data */
>>>> 	if (nfsd4_copy_is_async(copy) && copy->cp_res.wr_bytes_written > 0) {
>>>> 		since = READ_ONCE(dst->f_wb_err);
>>>> -		status = vfs_fsync_range(dst, copy->cp_dst_pos,
>>>> -					 copy->cp_res.wr_bytes_written, 0);
>>>> +		end = copy->cp_dst_pos + copy->cp_res.wr_bytes_written - 1;
>>>> +		status = vfs_fsync_range(dst, copy->cp_dst_pos, end, 0);
>>>> 		if (!status)
>>>> 			status = filemap_check_wb_err(dst->f_mapping, since);
>>>> 		if (!status)
>>>> -- 
>>>> 2.37.3
>>>>
>>> --
>>> Chuck Lever
> --
> Chuck Lever
>
>
>
