Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F613572DE
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Apr 2021 19:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354688AbhDGRNi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Apr 2021 13:13:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40486 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347803AbhDGRNh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Apr 2021 13:13:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137H499u003243;
        Wed, 7 Apr 2021 17:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xAiWnhgRwV9dFAlsgNYqVNaGRd0Ro3V3jz4iW0DX8ko=;
 b=E0xavnvMG7b8o/fqrYUM88Fqju47nrwAM9UWuth8fNQiIe1mqMh/gxJJtsichWIE9MId
 27hpOG3fuh9QC0uj1DBD9JO8juVgwkCkcTT50p/mXj5Md+4T+A/JvOhjE2nVjLjGnA+1
 xelHHsmmQmL9kqAmyr16sXLbf8p27+99Xto38CqAzyp2Rx2HuqbbKiGdXyg3t+6O5RDZ
 Dr3vHvnA4Tk/K38QzMbYt3S5GKC8X/UK9FLN27Z/TdMkaZNhM3VKcVl7Wqs0NNGy5kHN
 liYeX+rwxKZPRNaV/QjbvDBJU8UASFsEal01RnC9wsGIIPZJSHTQrk2baNn08byL0AAx DQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37rvagbapb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 17:13:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137HB70J051125;
        Wed, 7 Apr 2021 17:13:18 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by userp3020.oracle.com with ESMTP id 37rvb05gms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 17:13:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2IRnlCfR6wpXpNu7faKjDHi8BZTLVVDb2dMsHiIrQi3DKL6QISoQvi6mtNua9PkScfqcPmD21LtS6JlR6lXD45SfUgp2inosx0OGi5D/tY2i7yKeB+6nIVD7HykJIS/MAAZtdzHLwdhwEwTOOhNuZBdqSOeb5DQAkhETFEiOuRoJnj8ScVYcddnJ2v0TvhNec0eg3PLOVy8GLrjitbEsv+Te580Rzh0g8i/SMMtrykEQ5h+nf+7tJsoGYMUisWYBZStZBbbgQaUmnn+ObY0hcVLY2n+rKizsKZJ1HPBHmqCPS2DDBUObrFtbvX2zFmunQdbLn6kKz0DY/0zgorhXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAiWnhgRwV9dFAlsgNYqVNaGRd0Ro3V3jz4iW0DX8ko=;
 b=DNESGgHoKbuI0fwqVAwgG6uzICfoLm34Dnkk6q9eMJGkCu5qYPoW5GraC+xt264E+mx/9IghNw1KwH/EX5seMNvt5BIqXP2iNGr3Hd4LPwYN+OLxEk2AnB3qrPpVW2RwOToJdoQPoQlESqa/LUlilIH8lRfPUT9N2rSu9kxmDqKPZKeo7f/Fz3zvGlRjdByVMrpE/Cwt2Z00gKtDOPt43LSwCrnVGW/Y3flsdntT7QBbrk1voU1lK3C2t8hmLRgibC/rL0Ucz9U4XlGf/UMNbOBVBTcAN9aTywKA4UFzF1XfBahby14XugVz7PuCXhlhK7Do/CBBsATe5zo1K4SQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAiWnhgRwV9dFAlsgNYqVNaGRd0Ro3V3jz4iW0DX8ko=;
 b=MJJrQsjH5stTRwIZzgOhkEuwaEl8OG4SdXYGzFfdVTEMO88n9leBuaoIzK4vMha7s5mcWC2V5ABjcZmsOcShTF/w58slApSdZ70/CIakm78twbXbTushYVdfRCjH9zRl9g1Qjl9ORFyxK2al6m3dClNZghFDuHP8J6koJbR56fo=
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4033.namprd10.prod.outlook.com (2603:10b6:a03:1fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Wed, 7 Apr
 2021 17:13:16 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 17:13:16 +0000
Subject: Re: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's
 export.
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>
References: <20210402233031.36731-1-dai.ngo@oracle.com>
 <D85FBDD3-5397-4D47-932D-159AFE2A5E0F@oracle.com>
 <CAN-5tyHVOEr7zZM92PVS0GYJQ2M6rSs6_zqZwuioumQQm7zzUQ@mail.gmail.com>
 <7BED2160-1052-49EE-BB62-6ACF6F84C91C@oracle.com>
 <CAN-5tyEKqNHmwiMfCpkZrCVYeaO-FH69v5L4Tk_8EsoTfytpVA@mail.gmail.com>
 <01CD778D-57A0-442A-8D1D-5084F0FC2497@oracle.com>
 <CAN-5tyFEXBiWVbCq0Hgh01W=OVZkdYYAEujSug6biBaU=Ny8Og@mail.gmail.com>
 <99a1f327-ce69-e6eb-39fc-77991bec5b4c@oracle.com>
 <c16b4437-a554-be60-3c04-fd578b9f88ff@oracle.com>
 <CAN-5tyGS0ZO4PtTseLSmC4=fYQCUwMs6FB509g2PSCg1v+jySg@mail.gmail.com>
From:   dai.ngo@oracle.com
Message-ID: <0b0c7c79-d593-c4ae-db9b-46600f2cea28@oracle.com>
Date:   Wed, 7 Apr 2021 10:13:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CAN-5tyGS0ZO4PtTseLSmC4=fYQCUwMs6FB509g2PSCg1v+jySg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:a03:331::21) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Macbooks-MacBook-Pro.local (72.219.112.78) by SJ0PR03CA0076.namprd03.prod.outlook.com (2603:10b6:a03:331::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 17:13:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 574beb0f-32cd-42e3-5765-08d8f9e86ec2
X-MS-TrafficTypeDiagnostic: BY5PR10MB4033:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4033B6CE959A3ED16076ED8987759@BY5PR10MB4033.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f91i24yhjLs48f1z35BtefEgE12fRH6SLd/T8Kzi8IntMuYdfb7vwg58DMJHgMbQ03jaNEtkIcq10ylJ3T/ZXvqkwjCj+QrJ/s12HWDaQGJhzb8dmDSZLLWiw9zBboVLfQFYFhT5ZwnUnoKWIkI8X6o38Zw7rhfDYb8087ai05wDaxo3aNTfkTwjr3pa6FMWEhkuS+LYRWL/4acO9vcv5zZSGv6A38WRwyNJPm7nemYCpxUGHQX+brFzXPGokfLiQgfIh6cVmyQWIBYyYKXew7JkNB1ax/ipysM2nFt2zzj3mm7VTeK7v6X6/kbULrDgo2g5xPN9Sb2hGseRtARmBWWK0f58yB41HvS/X/GK4izQFFXfdRRbpNRt5MGT/XdhRZ3QIUnFnEJfWeiyNh6fiH5CacaZwlPgo7zLT/An0CzoMihRR+YiZSXa2PhFZE+IC90AUF4SyD0lmJ3s1OrwTBjtxrMh8y7ANuRJSbGj/gjXaA/ptLvLpltk0Q9IhHA5397QhTnYMfBQPJiPfUEGWXqZXpTOyjlMNARCqO9HPzYEgzKp9nNJG+vgxr109XqKX+BLA0iBhpAaciX35VP9v/A4EMPni0rfE0PugYBiZoqdPM6ftlnqHi6YxjIFAJFhGHow0XrK9EzI0hgHmojiDL9bPrKvYTYCsv/KaQsucshqAweUiaqxsEnEYgZi+dtDKuABMetUK1quXSx0BeI3v/uALJlr+FEZTLiEstYzOJvIgCHCxcDt5nHmr+KGMmXZmykvMcV3kRq1gaAYWdoGyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(396003)(376002)(8936002)(31696002)(66946007)(478600001)(8676002)(6486002)(86362001)(31686004)(2906002)(9686003)(6512007)(66556008)(956004)(2616005)(66476007)(38100700001)(53546011)(6916009)(26005)(186003)(6506007)(54906003)(966005)(5660300002)(83380400001)(4326008)(16526019)(36756003)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S0svNGY1d1VTUk1YOWJsemd6b0c2ejh0Yk1OYUoxQS9JYkVQWkF6V2xGNkor?=
 =?utf-8?B?dEU4NWphZDhCM2dxSTVTdnBpY0d6ODZDaGR1ZUlteW9iUmR4STNnRi9UdCtJ?=
 =?utf-8?B?aGhlSktKaWRWTU1VMCtIblVPQk5jbldCRlJ5cUxBa2U5bWdqbEpMMm5yMmFa?=
 =?utf-8?B?UUI0MHhqeERHR01QNVloWkpiZVgxbHdNMXhZeDNNOVI3K0hOaldvYWpzSlp4?=
 =?utf-8?B?NDJ5aUxUaXVLZENuVTY5a2J0Zm9MOEljcWpEdGpNM09rWDFDRFVoaVV2dHhn?=
 =?utf-8?B?QnpjeURlWXYxZUZRVDFGc1dwRks0ZmFaMFlNNTZBOFNFenRDOXA1R3phSGww?=
 =?utf-8?B?RDU4TGNwd2N0V1ZrV3hxSCtJTyt2LzVjemRVaG53S3Z3NXhtTUFLWXVuRVBG?=
 =?utf-8?B?RDNvSENaQzM4WUVocGY5eU9JTTlGbDBQbEJVQnJtUkN1UUROMWpicW1SeHow?=
 =?utf-8?B?bzZGbE5EaGFuNGZPWUdXcWNvTyt2OERCSHJBdVZySm5GeXIxM1k3L0FkdVFl?=
 =?utf-8?B?WG5jd1ZHRG9CQVNPK0s3Y0MwZys0VUpHcm91eEtUekMzaFhQaS9lK0tJb1A0?=
 =?utf-8?B?RWh1Rzl5aWpaQmZpSlRQeXR4RTN1bEowWjBTQ0hXR01Qa2J1ZmJGV3dyLzhQ?=
 =?utf-8?B?UDF2L2RDZ1JvUThwdFRUWDY5ZGwvVWNpUGVkRXE2cmRSUGZKUENXdjZHdmFz?=
 =?utf-8?B?ZmFCbmFHMXFJQkw0bTBieEhub1d4cFNMbGo4R2pscjRCOExxZGtBV21lMGFU?=
 =?utf-8?B?WC9rTW8wZVZaSStWVGFhdmprSDliRjhRMGhuZWF1SUkycEJQSWg4SWdlQ0tD?=
 =?utf-8?B?bDRUUVIzazVua0E1bUdobkJibzFhcjcvRVlEalMxNVI2dVR1SHYrTDJEWkxT?=
 =?utf-8?B?bjdNbEJGaUxqTGgvSVFrZytuYzg2MXJrdUxiT2o1Q1JrOGFqZHhMUThtV0o3?=
 =?utf-8?B?K0tpT1d3em4rVGJUU1Buc3ZGWFhjTUNGeEo5WTV6V2MwR2RYSFBCZnJYUUtZ?=
 =?utf-8?B?SjZYSFp5cnVvMXVBWk5JdElnamd4R3lJd2dHS2IwZXdDMHMvNDdQWjRoclRR?=
 =?utf-8?B?bHQ1RFRDc1VvaGpDNUZtU2psK3Y3M0dlV2dRRXp3cXNENS94TlRKb2lPVjU0?=
 =?utf-8?B?c2p0dkM0dTdZTFFuc1NqMEtHVHptTFFSSGRyTDltT3VNanhrTlBOYStuNVZN?=
 =?utf-8?B?YzNaVjdoL29mMlFaa0lpYVJpV0Z2R3pJYWlQR0R0N1VwYkVZR3ZrVFBPTlBQ?=
 =?utf-8?B?cHVxM2J5YnNkTzFrUjNPRTVhbWIxVXRxMXpJUCtKRS8yMitWUUEyWVA2eU5v?=
 =?utf-8?B?NEd0UUxrQ1dsZmRscXpxcDlkdEhlTllsUHhKRk0rRU1odmZKRzFzOXc5S2Yx?=
 =?utf-8?B?MkFmcHA3U1IvcHRCNC9sWG9zY05CUmlSYkQ0cUJWRHA4bW5CVXYvOStOSUtn?=
 =?utf-8?B?RWYzNEdBOENIV1dZVmhKMldLMk84RW9lMk9oSUIvampHcS9qcjFuODIvMlpu?=
 =?utf-8?B?NEtBSVovTGplYWlRalo2WHl2N0ZGVHBJVUJDdUpQWXA3QzU2YVBENU5QU1NE?=
 =?utf-8?B?elVHeHdJcTR2RGtkNFVBZk03Q3l1ZDRLMTdEUm9hN0hsRndwbFQ3RHU0Um1s?=
 =?utf-8?B?TkFnZnNSaitFeGgrNytCaVRBMjY4ZHhJR21seU9ING5XMzZ0THF0dTFPekhq?=
 =?utf-8?B?WHU3OEJQY2RoYnJpcVk2SkE5emdYZHM1NVFOcGI4L3dxOFhhTkJFWVU2T3Uy?=
 =?utf-8?Q?aa921HyFYggxlFbhveP9LvlZyVTGDnTXtGerxql?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574beb0f-32cd-42e3-5765-08d8f9e86ec2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 17:13:15.9800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgnQZsorKlo93kU2Rv1r/2XMLHoTJxF3fGeVixAXB/OFmvmjCYbvR9AQepUdSW6qSoQdg1E6uCpgqqGyTPWjFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4033
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070117
X-Proofpoint-GUID: DdxD1QbLpitGRte1AcWkitXAfeJwEHhL
X-Proofpoint-ORIG-GUID: DdxD1QbLpitGRte1AcWkitXAfeJwEHhL
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070116
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/7/21 9:30 AM, Olga Kornievskaia wrote:
> On Tue, Apr 6, 2021 at 9:23 PM <dai.ngo@oracle.com> wrote:
>>
>> On 4/6/21 6:12 PM, dai.ngo@oracle.com wrote:
>>> On 4/6/21 1:43 PM, Olga Kornievskaia wrote:
>>>> On Tue, Apr 6, 2021 at 3:58 PM Chuck Lever III
>>>> <chuck.lever@oracle.com> wrote:
>>>>>
>>>>>> On Apr 6, 2021, at 3:57 PM, Olga Kornievskaia
>>>>>> <olga.kornievskaia@gmail.com> wrote:
>>>>>>
>>>>>> On Tue, Apr 6, 2021 at 3:43 PM Chuck Lever III
>>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>>
>>>>>>>> On Apr 6, 2021, at 3:41 PM, Olga Kornievskaia
>>>>>>>> <olga.kornievskaia@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On Tue, Apr 6, 2021 at 12:33 PM Chuck Lever III
>>>>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>>>>
>>>>>>>>>> On Apr 2, 2021, at 7:30 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> Currently the source's export is mounted and unmounted on every
>>>>>>>>>> inter-server copy operation. This causes unnecessary overhead
>>>>>>>>>> for each copy.
>>>>>>>>>>
>>>>>>>>>> This patch series is an enhancement to allow the export to remain
>>>>>>>>>> mounted for a configurable period (default to 15 minutes). If the
>>>>>>>>>> export is not being used for the configured time it will be
>>>>>>>>>> unmounted
>>>>>>>>>> by a delayed task. If it's used again then its expiration time is
>>>>>>>>>> extended for another period.
>>>>>>>>>>
>>>>>>>>>> Since mount and unmount are no longer done on each copy request,
>>>>>>>>>> this overhead is no longer used to decide whether the copy should
>>>>>>>>>> be done with inter-server copy or generic copy. The threshold used
>>>>>>>>>> to determine sync or async copy is now used for this decision.
>>>>>>>>>>
>>>>>>>>>> -Dai
>>>>>>>>>>
>>>>>>>>>> v2: fix compiler warning of missing prototype.
>>>>>>>>> Hi Olga-
>>>>>>>>>
>>>>>>>>> I'm getting ready to shrink-wrap the initial NFSD v5.13 pull
>>>>>>>>> request.
>>>>>>>>> Have you had a chance to review Dai's patches?
>>>>>>>> Hi Chuck,
>>>>>>>>
>>>>>>>> I apologize I haven't had the chance to review/test it yet. Can I
>>>>>>>> have
>>>>>>>> until tomorrow evening to do so?
>>>>>>> Next couple of days will be fine. Thanks!
>>>>>>>
>>>>>> I also assumed there would be a v2 given that kbot complained about
>>>>>> the NFSD patch.
>>>>> This is the v2 (see Subject: )
>>>> Sigh. Thank you. I somehow missed v2 patches themselves and only saw
>>>> the originals. Again I'll test/review the v2 by the end of the day
>>>> tomorrow!
>>>>
>>>> Actually a question for Dai: have you done performance tests with your
>>>> patches and can show that small copies still perform? Can you please
>>>> post your numbers with the patch series? When we posted the original
>>>> patch set we did provide performance numbers to support the choices we
>>>> made (ie, not hurting performance of small copies).
>>> Currently the source and destination export was mounted with default
>>> rsize of 524288 and the patch uses threshold of (rsize * 2 = 1048576)
>>> to decide whether to do inter-server copy or generic copy.
>>>
>>> I ran performance tests on my test VMs, with and without the patch,
>>> using 4 file sizes 1048576, 1049490, 2048000 and 7341056 bytes. I ran
>>> each test 5 times and took the average. I include the results of 'cp'
>>> for reference:
>>>
>>> size            cp          with patch                  without patch
>>> ----------------------------------------------------------------
>>> 1048576  0.031    0.032 (generic)             0.029 (generic)
>>> 1049490  0.032    0.042 (inter-server)      0.037 (generic)
>>> 2048000  0.051    0.047 (inter-server)      0.053 (generic)
>>> 7341056  0.157    0.074 (inter-server)      0.185 (inter-server)
>>> ----------------------------------------------------------------
>> Sorry, times are in seconds.
> Thank you for the numbers. #2 case is what I'm worried about.

Regarding performance numbers, the patch does better than the original
code in #3 and #4 and worse then original code in #1 and #2. #4 run
shows the benefit of the patch when doing inter-copy. The #2 case can
be mitigated by using a configurable threshold. In general, I think it's
more important to have good performance on large files than small files
when using inter-server copy.  Note that the original code does not
do well with small files either as shown above.

>
> I don't believe the code works. In my 1st test doing "nfstest_ssc
> --runtest inter01" and then doing it again. What I see from inspecting
> the traces is that indeed unmount doesn't happen but for the 2nd copy
> the mount happens again.
>
> I'm attaching the trace. my servers are .114 (dest), .110 (src). my
> client .68. The first run of "inter01" places a copy in frame 364.
> frame 367 has the beginning of the "mount" between .114 and .110. then
> read happens. then a copy offload callback happens. No unmount happens
> as expected. inter01 continues with its verification and clean up. By
> frame 768 the test is done. I'm waiting a bit. So there is a heatbeat
> between the .114 and .110 in frame 769. Then the next run of the
> "inter01", COPY is placed in frame 1110. The next thing that happens
> are PUTROOTFH+bunch of GETATTRs that are part of the mount. So what is
> the saving here? a single EXCHANGE_ID? Either the code doesn't work or
> however it works provides no savings.

The saving are EXCHANGE_ID, CREATE_SESSION, RECLAIM COMPLETE,
DESTROY_SESSION and DESTROY_CLIENTID for *every* inter-copy request.
The saving is reflected in the number of #4 test run above.

Note that the overhead of the copy in the current code includes mount
*and* unmount. However the threshold computed in __nfs4_copy_file_range
includes only the guesstimated mount overhead and not the unmount
overhead so it not correct.

-Dai


>
> Honestly I don't understand the whole need of a semaphore and all.

The semaphore is to prevent the export to be unmounted while it's
being used.

-Dai

> My
> approach that I tried before was to create a delayed work item but I
> don't recall why I dropped it.
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-nfs/patch/20170711164416.1982-43-kolga@netapp.com/__;!!GqivPVa7Brio!Jl5Wq7nrFUsaUQjgLJoSuV-cDlvbPaav3x8nXQcRhAdxjVEoWvK24sNgoE82Zg$
>
>
>> -Dai
>>
>>> Note that without the patch, the threshold to do inter-server
>>> copy is (524288 * 14 = 7340032) bytes. With the patch, the threshold
>>> to do inter-server is (524288 * 2 = 1048576) bytes, same as
>>> threshold to decide to sync/async for intra-copy.
>>>
>>>> While I agree that delaying the unmount on the server is beneficial
>>>> I'm not so sure that dropping the client restriction is wise because
>>>> the small (singular) copy would suffer the setup cost of the initial
>>>> mount.
>>> Right, but only the 1st copy. The export remains to be mounted for
>>> 15 mins so subsequent small copies do not incur the mount and unmount
>>> overhead.
>>>
>>> I think ideally we want the server to do inter-copy only if it's faster
>>> than the generic copy. We can probably come up with a number after some
>>> testing and that number can not be based on the rsize as it is now since
>>> the rsize can be changed by mount option. This can be a fixed number,
>>> 1M/2M/etc, and it should be configurable. What do you think? I'm open
>>> to any other options.
>>>
>>>>    Just my initial thoughts...
>>> Thanks,
>>> -Dai
>>>
>>>>> --
>>>>> Chuck Lever
>>>>>
>>>>>
>>>>>
