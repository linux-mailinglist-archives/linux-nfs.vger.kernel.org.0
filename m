Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554883575BD
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Apr 2021 22:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349319AbhDGUQ2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Apr 2021 16:16:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60166 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346203AbhDGUQ1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Apr 2021 16:16:27 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137K94sZ128799;
        Wed, 7 Apr 2021 20:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HmkbRgvFhYnAst6nbrNgn6pfuWZL1H8HdqatAG/WRM8=;
 b=B1RA4XJLdv01+4ywVfE2WGp73RYEbxXSidrggIVyYqKkcD/ZqBqjyppgIIl5nIZpaEHG
 2vgyPo3fIz61VLNWD+/hsVNyAMdQGTYYVosODrN4R0Bb55tKv8BXzHl0RnOF9Re5WSmM
 bdiKVR6LQtuysFTX1Wu4bUULaRtHJdYKx4p+XbG7eoJQxgwcCW6ziZKRN7q50mxidhJX
 vVIb/qZTT7W5StLbfZkiMvP3BW0CRWB/hoyt3kSxVTDeqSCNB3c6zuybaTnGfCoEfj4f
 QOw6isbZtGXZJij3tbhFJHZhrFNi8+Ub42cK9jy0k7VXh3gLk47MkyIaLsh6NqJLW5uh 5Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37rvaw3upm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 20:16:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137KFw10174112;
        Wed, 7 Apr 2021 20:16:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3030.oracle.com with ESMTP id 37rvbetswn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 20:16:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NG6fSmZje8D9wRDv+kkLrw6OYr0Adlf6BuMb/zkABFGm3JzaRwgH3UVBkBpKBIrfG0TADCFVz/wIcLsnF8kTuRWbAV+0wKY5E5gBNSJkYNjxTNz/vxrSmC4MIprDijSJI5X3+dUMpO0cxiRDFKnA1ghLO26CdCiSXn1x2XXkg8hKYiJ6+JFGXDZrKM1mHIkRecRYo7iqfkJnIHsBxpTMYgDnPGs7xeCuj9VD2SmoyIbVIeMI1u+haXb1W3WfnUiwoeYeYWLsC/FF24IodWhHgRsrrSt3/tcZCq/42GXoOFfiZcElNnTgjN4cX1B+EYBGWLHsLkprTEQllJckfx5vEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmkbRgvFhYnAst6nbrNgn6pfuWZL1H8HdqatAG/WRM8=;
 b=ERP0TEtiL8YKPRFotSPIeP50qkV3KBBIalgH+IFWzDXCJjLEtdVNaKip7ccgbbFAy9N29oj9auVOGYhaTSLWGmlHUtQZkdk3ANtEN+cpwF1qEdDFNxCKR2VC75Se5SEK1mrF7AlQFQH5J+uMk1FdNMABoFZfK0b7LJcBrhPR+cqoKzUBOoJTkW8446iEie02FkM6ZLEApNzpJKXFMOwx3bFfhBrxcxoWGJEC07MTEL4AFgM31+9smfGocH2JYAEPQC4y7jVSaUpqmbWofF67Hoizn1bMzVoC/6DKL0534xWALTAJ0jWESCI+FJzxhkOQoUjq0rqSmM8yhbqCXec9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmkbRgvFhYnAst6nbrNgn6pfuWZL1H8HdqatAG/WRM8=;
 b=dg6YbjtVut1rcFjQE6wE/dlexmctoN05bvpLhZaoJb9edzYLwVDrGRzLF07hU76C977weZSTGubYHkOOJSCRlPFX8g18ZLfetFwRS+vnxB7PrRJwaVnkNxMM3YfmmB6q7doBsh9dFpMfmQmw6gmSReTyBxH8Wq8fPkcLzuNMNxs=
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 20:16:06 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 20:16:06 +0000
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
 <0b0c7c79-d593-c4ae-db9b-46600f2cea28@oracle.com>
 <CAN-5tyGw8_xOfMM4PNUCvo_wKEHs5NgLo3ZQf-sTGb6FHJ_r8Q@mail.gmail.com>
From:   dai.ngo@oracle.com
Message-ID: <3b6e1b4f-4276-e503-9432-e15a339cac9f@oracle.com>
Date:   Wed, 7 Apr 2021 13:16:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CAN-5tyGw8_xOfMM4PNUCvo_wKEHs5NgLo3ZQf-sTGb6FHJ_r8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: BYAPR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::39) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Macbooks-MacBook-Pro.local (72.219.112.78) by BYAPR06CA0026.namprd06.prod.outlook.com (2603:10b6:a03:d4::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 20:16:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 440b9f2a-d208-4ff3-0254-08d8fa01f96c
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45442DC0BCB123972B93D09687759@SJ0PR10MB4544.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UKiT+P6vIXxjzXAMf1OEpIP4OTzfKWmu8+Z5vuMRnmEhZIK8oHhdYUSXQ4AyDh+IUhpOgSuSLyW0CzV9kUkqNaB1N5dEpiNEyp8GU0bb4+f8CYE+wJTgs7AWjTCCmLq/Zn7Eee32F7ZlCqAMOg1BkgrlGx6bbcYroLYSHYccMu4j+hcCCVpt3SG4L5e9k5iRggWXeqa5Plzy/zmxmDR7MWijOAjsblzNxTFgCzOXQRcChP/OLxOlnN6yZOnVx2kOf2+SghWnPQesAAxzTTEBYTR+kRO9gYoEMy9zjKF2Rl/Q0XivOdBIDHP8jzpgsP3BdVkBwwyVWz2HQLCq4KyarmytU3dXBQ05VK3+VUtB6lbQijP2JtXAKUt2RZzS+RKP4aO84CzQ/5AECki4Pl+uadQRyGEKFLX8fJJe50MCWZuVzt4tnh26NGqPm4H4RBv59xyBgZAslAmLWq+c+BY83ruvzVT3H31aoNIeQKk4mLd953wcL9vsaD/RrAc0+rRkQ7I2fe2Uo4MaIb10OZw9UN0dtbsVPzCklLd+mP8++t+buiUZ7NlLZoE3iN3Znh3gu8DE5Ii7fxZ03bmqJN6wtOWgJ1MYrQLOhMGktQShHHLYfT56dI8vXwoQPH8qaa+NSrQIFOa3kHacJOmcDdI3O16tKqP3wPu9ULgMHpEcDlD0Y46g5RUHzsLHkEDKsjmx5lssk3iwjeoHohPHAWwZJXeLVMHfOS9Y3icVNX/jyo1QqTqKVCWo38rYW2rYmZPYfnIkoRYDSj6+JrjafOezOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(366004)(136003)(39860400002)(38100700001)(31696002)(316002)(6506007)(53546011)(54906003)(6486002)(26005)(478600001)(966005)(36756003)(83380400001)(186003)(66946007)(6916009)(6512007)(31686004)(8936002)(4326008)(5660300002)(16526019)(956004)(9686003)(86362001)(2616005)(2906002)(66556008)(8676002)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SXVDQWQwakVkWEg0VWR5L3lNVnYxc2xNM3RmYnB1aThFNU1JWFUrRDNwbUd4?=
 =?utf-8?B?YVA1YlJwc3BSRHZrbzgwRFhxVHhsdGhWUzJyQmJ0YzBzVkI1Nng3K3haOVF2?=
 =?utf-8?B?UFhXUDRxU1U1aFYxeUJ6SUllcFQrQUZlSVM4NnhkVE15ak9MOG10MFBJdC85?=
 =?utf-8?B?STJHWDdMNENoN0drNEN5b2RhSHg0S0NST0FtSktVbCtDaUdUMVRGaG5wbGVk?=
 =?utf-8?B?KzdDUXZmY2lWaG93MlJZYStUUFhNTmQyWTJwUDgrNU42T0pPY0N6djA3bHJ6?=
 =?utf-8?B?cDI3YTBtcFJEYUhpNldwenlDSjBUdVN5ejRjRnFoVG1KVVQyMkN5eHFicUtG?=
 =?utf-8?B?dHVUR24zWkpaY3QvRVh5NG9nMGhFUVRoNExMVm9sKzhwMlpXVlFwdDRURTRa?=
 =?utf-8?B?TlEwZlZJMnM3TGFkM043RVBWVWZWUUVsRkFSZEV6L3FIa0o4ei93RzE4TUNw?=
 =?utf-8?B?L3hCOEtDZ2ZBOGpiU2dDSDQ2bXIveElTSmRIZllHNmI0cjVpbWNVRHZ3S3l3?=
 =?utf-8?B?b293eXc4TkxaUEZRb2kyalN5NnlOMWFQR2lBMlRLbjU3Y1IvUkRSV3p1L2p3?=
 =?utf-8?B?SGlla3lJYXI0blNHTzh4S0tCdCs2QXRvb24zMnNZNlA5amhZWEM3elZYQVFY?=
 =?utf-8?B?QzNLRmJqcXRKZjcwNU9LUS9MZ1h6bkp6U1dCZ2l2ek04djJwM2JoRGZFWmNW?=
 =?utf-8?B?MS82Q3Z6aExYYVpFZTlNOVFVeXhkRXNCTWhWMTVzZU1WbFdLL2FoeFZEcHpl?=
 =?utf-8?B?MTFOc0JjSlBOaFFtZGRHZkJ2VWZrQUdGSjcvT2F6anNwS0VvcDh0WVJTSUlZ?=
 =?utf-8?B?UDdJWjcwTFNvRVZDRTRTUks4bld6NTU4UEp6Wmc2Y1YyVUZ2Z3A3VjJSSVRC?=
 =?utf-8?B?WWU4c2ZIVWtxWHJ6ZHAzcnFVdm4rSmF5LzBUbGdmRFQwaUJiQ2tNd3VUdzJI?=
 =?utf-8?B?WjBYODhtUi8yb2Q4WjlCLzFDTGtFTzZKa2xsSHZUYmhPYmxwVC8zQzdBb1hw?=
 =?utf-8?B?STlHSHJQYkZ2YjBqM3FmbGxBRy9USjdBNTczMHVtTUVVWUdTWXlpZTlnYkhF?=
 =?utf-8?B?WU1VTXE3WWdTSnUwK1U2WFUvYUhMOTJIY1ZMckdqOEN5U3VwRmlaLzZyRFg3?=
 =?utf-8?B?NFp2Z0NrdzQ2L1lPeDBJeER0TzNBMVdZU2hoRnhzWERHZkFFNTl6UklNd3BP?=
 =?utf-8?B?UWxyQ1dFY0ZydnVDcHRuNGpLZ1J5aFVnRzZKdWNYc2FqMDNXaURRaFZ3MTlT?=
 =?utf-8?B?Sy9SbmhIUzdTQ2tKK05kcnpQMS8yMWU5NDFqSUR1M21ibEdXWndSS3FXaGVS?=
 =?utf-8?B?Y3hJT1ZUZk9XMzZoYmFQL29nSmJYTUk2YWJmOHl5MURSYzFmZ3JnQ3R6RGJT?=
 =?utf-8?B?VEtBK2FmdEdSZEFSV0loRjZKOFdyN3FYb2gxc0R4NTZSTzllQ3hGU1U5VDFj?=
 =?utf-8?B?aWQ1UmR4TW91ZmpRTkpsTXNsL0hoSVN5TDh2NkpGZ3J0Tzc1b2dpQVJRMndo?=
 =?utf-8?B?eFJGMi9NZFFQTVhUNGI0Uk44WmNZU2VTVGZBQ05FdnpHRktiKzRJUkd1c0RZ?=
 =?utf-8?B?QjB5VXR2bWM0SmtYRTZac0NGcGpwVkVFWGlUUGRpUnpLWkh1dnB3cW1CK01H?=
 =?utf-8?B?Y0l3bUcxNGJHZTJtWE95ZExVakJJU0ZYRy8vMWx3Nng3aGNuTEJKd1cxZXZs?=
 =?utf-8?B?YlJ4K3ZWaFd5U2hqMHV1NWIwOU0zQVBXVi8zSWJGWjEyOGRTOXNNTmswSjJa?=
 =?utf-8?Q?IAakUifPxx36q0pTbhWt80l3gV8yvVlRQnUjlGj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440b9f2a-d208-4ff3-0254-08d8fa01f96c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 20:16:06.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLiQihC7F26epMd7ay0N5K8eM2i7nw95f1iBpi3bW7uXo35peemkvKpyqZ5n25akWJCqGSMgkJGLRNPpe0p+0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070142
X-Proofpoint-ORIG-GUID: FgQ3CHUBtPIUpVl8uBlnrprzdcvExczc
X-Proofpoint-GUID: FgQ3CHUBtPIUpVl8uBlnrprzdcvExczc
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070141
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/7/21 12:01 PM, Olga Kornievskaia wrote:
> On Wed, Apr 7, 2021 at 1:13 PM <dai.ngo@oracle.com> wrote:
>>
>> On 4/7/21 9:30 AM, Olga Kornievskaia wrote:
>>> On Tue, Apr 6, 2021 at 9:23 PM <dai.ngo@oracle.com> wrote:
>>>> On 4/6/21 6:12 PM, dai.ngo@oracle.com wrote:
>>>>> On 4/6/21 1:43 PM, Olga Kornievskaia wrote:
>>>>>> On Tue, Apr 6, 2021 at 3:58 PM Chuck Lever III
>>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>>> On Apr 6, 2021, at 3:57 PM, Olga Kornievskaia
>>>>>>>> <olga.kornievskaia@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On Tue, Apr 6, 2021 at 3:43 PM Chuck Lever III
>>>>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>>>>> On Apr 6, 2021, at 3:41 PM, Olga Kornievskaia
>>>>>>>>>> <olga.kornievskaia@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Tue, Apr 6, 2021 at 12:33 PM Chuck Lever III
>>>>>>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>>>>>>> On Apr 2, 2021, at 7:30 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Hi,
>>>>>>>>>>>>
>>>>>>>>>>>> Currently the source's export is mounted and unmounted on every
>>>>>>>>>>>> inter-server copy operation. This causes unnecessary overhead
>>>>>>>>>>>> for each copy.
>>>>>>>>>>>>
>>>>>>>>>>>> This patch series is an enhancement to allow the export to remain
>>>>>>>>>>>> mounted for a configurable period (default to 15 minutes). If the
>>>>>>>>>>>> export is not being used for the configured time it will be
>>>>>>>>>>>> unmounted
>>>>>>>>>>>> by a delayed task. If it's used again then its expiration time is
>>>>>>>>>>>> extended for another period.
>>>>>>>>>>>>
>>>>>>>>>>>> Since mount and unmount are no longer done on each copy request,
>>>>>>>>>>>> this overhead is no longer used to decide whether the copy should
>>>>>>>>>>>> be done with inter-server copy or generic copy. The threshold used
>>>>>>>>>>>> to determine sync or async copy is now used for this decision.
>>>>>>>>>>>>
>>>>>>>>>>>> -Dai
>>>>>>>>>>>>
>>>>>>>>>>>> v2: fix compiler warning of missing prototype.
>>>>>>>>>>> Hi Olga-
>>>>>>>>>>>
>>>>>>>>>>> I'm getting ready to shrink-wrap the initial NFSD v5.13 pull
>>>>>>>>>>> request.
>>>>>>>>>>> Have you had a chance to review Dai's patches?
>>>>>>>>>> Hi Chuck,
>>>>>>>>>>
>>>>>>>>>> I apologize I haven't had the chance to review/test it yet. Can I
>>>>>>>>>> have
>>>>>>>>>> until tomorrow evening to do so?
>>>>>>>>> Next couple of days will be fine. Thanks!
>>>>>>>>>
>>>>>>>> I also assumed there would be a v2 given that kbot complained about
>>>>>>>> the NFSD patch.
>>>>>>> This is the v2 (see Subject: )
>>>>>> Sigh. Thank you. I somehow missed v2 patches themselves and only saw
>>>>>> the originals. Again I'll test/review the v2 by the end of the day
>>>>>> tomorrow!
>>>>>>
>>>>>> Actually a question for Dai: have you done performance tests with your
>>>>>> patches and can show that small copies still perform? Can you please
>>>>>> post your numbers with the patch series? When we posted the original
>>>>>> patch set we did provide performance numbers to support the choices we
>>>>>> made (ie, not hurting performance of small copies).
>>>>> Currently the source and destination export was mounted with default
>>>>> rsize of 524288 and the patch uses threshold of (rsize * 2 = 1048576)
>>>>> to decide whether to do inter-server copy or generic copy.
>>>>>
>>>>> I ran performance tests on my test VMs, with and without the patch,
>>>>> using 4 file sizes 1048576, 1049490, 2048000 and 7341056 bytes. I ran
>>>>> each test 5 times and took the average. I include the results of 'cp'
>>>>> for reference:
>>>>>
>>>>> size            cp          with patch                  without patch
>>>>> ----------------------------------------------------------------
>>>>> 1048576  0.031    0.032 (generic)             0.029 (generic)
>>>>> 1049490  0.032    0.042 (inter-server)      0.037 (generic)
>>>>> 2048000  0.051    0.047 (inter-server)      0.053 (generic)
>>>>> 7341056  0.157    0.074 (inter-server)      0.185 (inter-server)
>>>>> ----------------------------------------------------------------
>>>> Sorry, times are in seconds.
>>> Thank you for the numbers. #2 case is what I'm worried about.
>> Regarding performance numbers, the patch does better than the original
>> code in #3 and #4 and worse then original code in #1 and #2. #4 run
>> shows the benefit of the patch when doing inter-copy. The #2 case can
>> be mitigated by using a configurable threshold. In general, I think it's
>> more important to have good performance on large files than small files
>> when using inter-server copy.  Note that the original code does not
>> do well with small files either as shown above.
> I think the current approach tries to be very conservative to achieve
> the goal of never being worse than the cp. I'm not sure what you mean
> that current code doesn't do well with small files. For small files it
> falls back to the generic copy.

In this table, the only advantage the current code has over 'cp' is
run 1 which I don't know why. The rest is slower than 'cp'. I don't
have the size of the copy where the inter-copy in the current code
starts showing better performance yet, but even at ~7MB it is still
slower than 'cp'. So for any size that is smaller than 7MB+, the
inter-server copy will be slower than 'cp'. Compare that with the
patch, the benefit of inter-server copy starts at ~2MB.

>   
>
>>> I don't believe the code works. In my 1st test doing "nfstest_ssc
>>> --runtest inter01" and then doing it again. What I see from inspecting
>>> the traces is that indeed unmount doesn't happen but for the 2nd copy
>>> the mount happens again.
>>>
>>> I'm attaching the trace. my servers are .114 (dest), .110 (src). my
>>> client .68. The first run of "inter01" places a copy in frame 364.
>>> frame 367 has the beginning of the "mount" between .114 and .110. then
>>> read happens. then a copy offload callback happens. No unmount happens
>>> as expected. inter01 continues with its verification and clean up. By
>>> frame 768 the test is done. I'm waiting a bit. So there is a heatbeat
>>> between the .114 and .110 in frame 769. Then the next run of the
>>> "inter01", COPY is placed in frame 1110. The next thing that happens
>>> are PUTROOTFH+bunch of GETATTRs that are part of the mount. So what is
>>> the saving here? a single EXCHANGE_ID? Either the code doesn't work or
>>> however it works provides no savings.
>> The saving are EXCHANGE_ID, CREATE_SESSION, RECLAIM COMPLETE,
>> DESTROY_SESSION and DESTROY_CLIENTID for *every* inter-copy request.
>> The saving is reflected in the number of #4 test run above.
> Can't we do better than that? Since you are keeping a list of umounts,
> can't they be searched before doing the vfs_mount() and instead get
> the mount structure from the list (and not call the vfs_mount at all)
> and remove it from the umount list (wouldn't that save all the calls)?

I thought about this. My problem here is that we don't have much to key
on to search the list. The only thing in the COPY argument can be used
for this purpose is the list of IP addresses of the source server.
I think that is not enough, there can be multiple exports from the
same server, how do we find the right one? it can get complicated.
I'm happy to consider any suggestion you have for this.

I think the patch is an improvement, in performance for copying large
files (if you consider 2MB file is large) and for removing the bug
of computing overhead in __nfs4_copy_file_range. Note that we can
always improve it and not necessary doing it all at once.

-Dai

>
>> Note that the overhead of the copy in the current code includes mount
>> *and* unmount. However the threshold computed in __nfs4_copy_file_range
>> includes only the guesstimated mount overhead and not the unmount
>> overhead so it not correct.
>>
>> -Dai
>>
>>
>>> Honestly I don't understand the whole need of a semaphore and all.
>> The semaphore is to prevent the export to be unmounted while it's
>> being used.
>>
>> -Dai
>>
>>> My
>>> approach that I tried before was to create a delayed work item but I
>>> don't recall why I dropped it.
>>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-nfs/patch/20170711164416.1982-43-kolga@netapp.com/__;!!GqivPVa7Brio!Jl5Wq7nrFUsaUQjgLJoSuV-cDlvbPaav3x8nXQcRhAdxjVEoWvK24sNgoE82Zg$
>>>
>>>
>>>> -Dai
>>>>
>>>>> Note that without the patch, the threshold to do inter-server
>>>>> copy is (524288 * 14 = 7340032) bytes. With the patch, the threshold
>>>>> to do inter-server is (524288 * 2 = 1048576) bytes, same as
>>>>> threshold to decide to sync/async for intra-copy.
>>>>>
>>>>>> While I agree that delaying the unmount on the server is beneficial
>>>>>> I'm not so sure that dropping the client restriction is wise because
>>>>>> the small (singular) copy would suffer the setup cost of the initial
>>>>>> mount.
>>>>> Right, but only the 1st copy. The export remains to be mounted for
>>>>> 15 mins so subsequent small copies do not incur the mount and unmount
>>>>> overhead.
>>>>>
>>>>> I think ideally we want the server to do inter-copy only if it's faster
>>>>> than the generic copy. We can probably come up with a number after some
>>>>> testing and that number can not be based on the rsize as it is now since
>>>>> the rsize can be changed by mount option. This can be a fixed number,
>>>>> 1M/2M/etc, and it should be configurable. What do you think? I'm open
>>>>> to any other options.
>>>>>
>>>>>>     Just my initial thoughts...
>>>>> Thanks,
>>>>> -Dai
>>>>>
>>>>>>> --
>>>>>>> Chuck Lever
>>>>>>>
>>>>>>>
>>>>>>>
