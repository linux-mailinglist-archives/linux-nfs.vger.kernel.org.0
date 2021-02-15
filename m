Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAFE31BE75
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 17:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhBOQKI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 11:10:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57034 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhBOQBl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Feb 2021 11:01:41 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11FFopww138153;
        Mon, 15 Feb 2021 16:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wrEHRakAAEtQabcM4Z3jbSXFBCAcWUTcJSCPN6zGo5g=;
 b=p436n0onV1Cqzu4XmGj3eAYEkzlEqKJAVFO+44YQCTdetDQBHuicAFqzE2k175VGmncR
 2PyQ9LN3cfG3tJ42iwFfmbEhny+T0c5/e5m3u6j6QxWKYP0ynlkQ7LQ+dmAPQEH7V5zR
 vI4Etdq65vRG0ZBY6ZNATOZLR4RUm7UJNWXQcFGs1uw+6Gbtqm9co0B7mCaePq3rzHnm
 R1g2msDTEU0Lx4O44jN0cYLn2+J0HtPwn2CyPRQ3oNEyDWDaBTgOIssUIvzfPGobHEyJ
 7c9bRNgUK7pno4dQO2+yxzXX7D7EJorPxKBlavGYV3IKQXfgAtsC4AKP+c33s1vPC6wh dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36p49b4m49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 16:00:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11FFoGt9028320;
        Mon, 15 Feb 2021 16:00:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3030.oracle.com with ESMTP id 36prbm7fmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 16:00:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuptUnnMhy8zT6bcFiOYTZI3iEOdA/Rm1atx74UiN+FTL+uKhUYX9GoUnLiMeN/apdo0iVVoZoJg34ihzrBWdB+gE0gJz9v9Gouwyt3HxksjV3j5fEtZ1G8+0DFtOesrbckaZtC2SfEXohswOG7JAtqs7VmV+C9eWG3/FEYccNmN5zt7vdhOxrgOMDfElVS9uw6UW8Kd2dpK4qGdpqTnTsHIj+2/aVVPettKgCkELoHICrjDWv0aC/qPzBKT+Bl+N2eufBzluHMYLN/51WDCNCwrQaJUQ+FrvQYo0DLUVlW0QnpHjxPOORPye2xDsMoM5GWzP4XiEpyRtJAsWOCbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrEHRakAAEtQabcM4Z3jbSXFBCAcWUTcJSCPN6zGo5g=;
 b=IwdnNmNgx32hg/vU09SDarTN/FslbNNHlFwkRIHwqiU3ZzK4/qS7mo5H8kGVB8MMmFuOw+Xn4vNB3AB4FD+Vu7gb3pNpLWzYc4W1arwbda6hLdrYTMmFBziNR2bwo0A802xhKrcrmgMuF70g0E0nQDqDDM2ii5B07B2jjKohc5LKOcHApdzY5QOihn6ySRqvIY58BkLpUD+Y5wEyMxqEAytA+hSWr8AAI5GK8FfvGg4W8u/U5c4h/BTtyeFuCgF3hn8tXTBq8/myMD2Wa8EpVaUM4uMpfiu1g8nMldtPpgtELfXo3rfSTiqUUT52k3BqF68KRZ6NjFn5Gh7AL8cs/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrEHRakAAEtQabcM4Z3jbSXFBCAcWUTcJSCPN6zGo5g=;
 b=KTlW+fnsSfa5SgbQ2lUEgmD0RvwuJpTeysAjKj3pMb1v7oY1mbuSrw1pIe7q0pmssQWcF34jINkFLribju1a7pnsVqM70toG1IFUcTTFZ6vZbpjUR5aaN9Lg7l+aBZ2qJ/1ITWPqTi+7C91Int2KKF7aYIPI1/ILGTv2jP6uBao=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3954.namprd10.prod.outlook.com (2603:10b6:a03:1ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Mon, 15 Feb
 2021 16:00:47 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.041; Mon, 15 Feb 2021
 16:00:46 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     Mel Gorman <mgorman@suse.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: alloc_pages_bulk()
Thread-Topic: alloc_pages_bulk()
Thread-Index: AQHW/jD1lENfvnr+s0+/RnBes7PyXKpPoPgAgAFz0YCAADINgIAAGAqAgAClRACAAKuMgIAAd5CAgAYCQYCAAEGOAA==
Date:   Mon, 15 Feb 2021 16:00:46 +0000
Message-ID: <345E0497-BFA9-4634-8017-DC9BFF643290@oracle.com>
References: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
 <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
 <20210209113108.1ca16cfa@carbon> <20210210084155.GA3697@techsingularity.net>
 <20210210124103.56ed1e95@carbon> <20210210130705.GC3629@suse.de>
 <B123FB11-661F-45A6-8235-2982BF3C4B83@oracle.com>
 <20210211091235.GC3697@techsingularity.net>
 <F3CD435E-905F-4262-B4DA-0C721A4235E1@oracle.com>
 <20210215120608.GE3697@techsingularity.net>
In-Reply-To: <20210215120608.GE3697@techsingularity.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: techsingularity.net; dkim=none (message not signed)
 header.d=none;techsingularity.net; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3392558f-a7c3-4f10-4232-08d8d1cadb89
x-ms-traffictypediagnostic: BY5PR10MB3954:
x-microsoft-antispam-prvs: <BY5PR10MB39540F5A2C7C589601B0195C93889@BY5PR10MB3954.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DD4L8OvBosuiSAbDBPVeI/KrlQ/ARkpc9D0uBWcJqlz/NtClcTLCHV4z8aU6AAz1bQd9O4Fl2kJc9dZQlrEjRH4xetmTt/h0HkOYXyP96IzkStFXsr1pUhhxQ1JctG5x/bfBhMLXDwiRHBTfGKDbIaRC+12Ipy4yV5M+uWNnfpJoyFRU5Oo3x80utdQbdZoGaG8/c8sZHaX20hFJrgj9JkXt20gZn6T+Zcudm6Tv+L9S4ermDdK/mdNfgRfgxEWUC7F76nSlCEVLvVqNY54Z1LvVw8pknmocbZCn5NB/PbYTP1U6qrR7sD1ZQyrEDgfPz11CqdsBwboXXMLa+dVmKUhWxnQC77/Ba5qSX+/qla2cJZVE5dciU0CRh3uar2rHSZCeI4OBkVwxxaq3bCJiaBTQWmdi6fWv/SB8ZGegk9qZ9JIagH2/X+DzurU87jEG+LecoS5eh8grLnb8UHXNzZFnm70Qscc4s+HNI9eokCGmgxZ8TWi/PuY30FjyoaXFqNMSurlmUepm1x+PwubP+h7EkjrwWx4SrLbWslxMWeKoDtU5csyG6jGycHJKBZfvXH/AuQkJoXT6yCT4yCa51Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(396003)(39860400002)(136003)(64756008)(5660300002)(66476007)(66446008)(66556008)(2616005)(6916009)(66946007)(83380400001)(8676002)(4326008)(76116006)(36756003)(6506007)(53546011)(91956017)(44832011)(186003)(8936002)(6486002)(478600001)(26005)(2906002)(86362001)(7116003)(316002)(6512007)(54906003)(71200400001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NYrqS5rAJzT8IJDOz1EWOmfeilshLF3svSmnfo6YGArsI5CHdXBjWCJ81ro7?=
 =?us-ascii?Q?bjiM8LhtjUVFX0f4uIVboiRaw0fQZTDJ0M3zvnO7wDWd7ixjR+SkH7RYdANl?=
 =?us-ascii?Q?iSXlfxM1Oey1EdwCgmHYAO6apOPpmMWqp4QA72ZzUz0DU1Ldcz3oXCtYfaXV?=
 =?us-ascii?Q?HxKbuofoQemNiHguQvC3k3FjxT99JR/iEO0ADD1GWl2uZAwxZ00gZsEHqXmX?=
 =?us-ascii?Q?X7eRibjv7Y/Q3CAQJIBVPPiyB7nKeG1vrjr/sY8oGzmHuIhECQg85BIZ0Vzb?=
 =?us-ascii?Q?U555ZvityfKf1upAH/D3j0VBuse8Q/UE+WCugZ37QRvAR60B771vSx9hNkCp?=
 =?us-ascii?Q?Jhfv0iq5CWESBpX56BzEv+Maxc22R7dvDMMh5y75ArPo7HSfiznJ2YvtaDEP?=
 =?us-ascii?Q?OT4En2r9jBvEXeJcL0DCrmSwJsoMprwrNCSke9ID+zgfXZHhGOeLGSXXZCeU?=
 =?us-ascii?Q?ZhuVD30YXmY5acIVXM9KTtjF6KZOahADhftfuofsTJtTgaqIgMGhZjvQrYMD?=
 =?us-ascii?Q?xbY0b5odoH3Pa7Kzy5rVbL1I8ZisiLE9YF5+iujKQZBRjYcZziWMHXIy101Q?=
 =?us-ascii?Q?4oQlhJNv4wxhQXFiGmmPGB+gundDrAr3bX8210BAmJzokDdQAaxeaBcVeR+A?=
 =?us-ascii?Q?khxbWMOyr2qCCmzuvS687xCOn/pR99yglO1Ple/S5niN2u/4KMJI4g2kkKlt?=
 =?us-ascii?Q?BCOf7cuTdwgRFy6/F7dW5GDgMIQFCF+KGhJNzI39kwXgGHjneiZv6FeaH/+e?=
 =?us-ascii?Q?ESrdE+efoxbECDe8zFUEJGf9q159bVsj3GndQtS2Ov2BV26y7chttmVibILa?=
 =?us-ascii?Q?GXRgAbDbsx1YscGVAZPpCZVLQsNFrzMU7g93kfQIva6BYtTkCxfFAFNGMb65?=
 =?us-ascii?Q?H6TpL1f/0xnj7UCVGZ1uJBRi2VoeIJ1fraJKaDfhk3xWhJhNUaS2mpH5w01J?=
 =?us-ascii?Q?7jXMWyOuAeqRDBvRMzOo22rQEXCPtwrxcAaQDCjv064KzpiiB9ZopGNRtz/R?=
 =?us-ascii?Q?HjRhVAEpAQsxnnFC3KwV33NVellbvxy+Fqw4eRv8WexUSSHkHwof5cIviFCL?=
 =?us-ascii?Q?eAsMMIN6UHb4CmEO97vuMJQ8Uls92aue3tFKu1PJz2npwtBqLB+g5pbmrRLa?=
 =?us-ascii?Q?JfaV3NxEN3uSb+jE0Vw5BHGbiDsMtIK16dPIlUNegHxoP/4ZlCkDBp+vYZpw?=
 =?us-ascii?Q?6C63d4ORyXpwUiWaSQ0JDtvq/ETwNzBkylFGIe1GgsAqCcVLPGLTboZL7AaQ?=
 =?us-ascii?Q?5Z7ElpBQvQTPNtQ4Cs3wmrYshjLeFl2m4v/+eRBEyH0Nhj4jcbKcz1lFEcgc?=
 =?us-ascii?Q?ajax92vZXiMORW+iFa7SLBdD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F6DD35621BFF3A48A4241680BDEE03F2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3392558f-a7c3-4f10-4232-08d8d1cadb89
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 16:00:46.8953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDz1y+ztTornMvhn7wOwo2KCewDbXr74JU3TVSDgP9IsKNg4OjMT+xKQ+OFM7G9H45X5ROSE7rT7uXnMQRFM7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3954
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150125
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9896 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150125
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 15, 2021, at 7:06 AM, Mel Gorman <mgorman@techsingularity.net> wro=
te:
>=20
> On Thu, Feb 11, 2021 at 04:20:31PM +0000, Chuck Lever wrote:
>>> On Feb 11, 2021, at 4:12 AM, Mel Gorman <mgorman@techsingularity.net> w=
rote:
>>>=20
>>> <SNIP>
>>>=20
>>> Parameters to __rmqueue_pcplist are garbage as the parameter order chan=
ged.
>>> I'm surprised it didn't blow up in a spectacular fashion. Again, this
>>> hasn't been near any testing and passing a list with high orders to
>>> free_pages_bulk() will corrupt lists too. Mostly it's a curiousity to s=
ee
>>> if there is justification for reworking the allocator to fundamentally
>>> deal in batches and then feed batches to pcp lists and the bulk allocat=
or
>>> while leaving the normal GFP API as single page "batches". While that
>>> would be ideal, it's relatively high risk for regressions. There is sti=
ll
>>> some scope for adding a basic bulk allocator before considering a major
>>> refactoring effort.
>>>=20
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index f8353ea7b977..8f3fe7de2cf7 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -5892,7 +5892,7 @@ __alloc_pages_bulk_nodemask(gfp_t gfp_mask, unsig=
ned int order,
>>> 	pcp_list =3D &pcp->lists[migratetype];
>>>=20
>>> 	while (nr_pages) {
>>> -		page =3D __rmqueue_pcplist(zone, gfp_mask, migratetype,
>>> +		page =3D __rmqueue_pcplist(zone, migratetype, alloc_flags,
>>> 								pcp, pcp_list);
>>> 		if (!page)
>>> 			break;
>>=20
>> The NFS server is considerably more stable now. Thank you!
>>=20
>=20
> Thanks for testing!
>=20
>> I confirmed that my patch is requesting and getting multiple pages.
>> The new NFSD code and the API seem to be working as expected.
>>=20
>> The results are stunning. Each svc_alloc_arg() call here allocates
>> 65 pages to satisfy a 256KB NFS READ request.
>>=20
>> Before:
>>=20
>>            nfsd-972   [000]   584.513817: funcgraph_entry:      + 35.385=
 us  |  svc_alloc_arg();
>>            nfsd-979   [002]   584.513870: funcgraph_entry:      + 29.051=
 us  |  svc_alloc_arg();
>>            nfsd-980   [001]   584.513951: funcgraph_entry:      + 29.178=
 us  |  svc_alloc_arg();
>>            nfsd-983   [000]   584.514014: funcgraph_entry:      + 29.211=
 us  |  svc_alloc_arg();
>>            nfsd-976   [002]   584.514059: funcgraph_entry:      + 29.315=
 us  |  svc_alloc_arg();
>>            nfsd-974   [001]   584.514127: funcgraph_entry:      + 29.237=
 us  |  svc_alloc_arg();
>>=20
>> After:
>>=20
>>            nfsd-977   [002]    87.049425: funcgraph_entry:        4.293 =
us   |  svc_alloc_arg();
>>            nfsd-981   [000]    87.049478: funcgraph_entry:        4.059 =
us   |  svc_alloc_arg();
>>            nfsd-988   [001]    87.049549: funcgraph_entry:        4.474 =
us   |  svc_alloc_arg();
>>            nfsd-983   [003]    87.049612: funcgraph_entry:        3.819 =
us   |  svc_alloc_arg();
>>            nfsd-976   [000]    87.049619: funcgraph_entry:        3.869 =
us   |  svc_alloc_arg();
>>            nfsd-980   [002]    87.049738: funcgraph_entry:        4.124 =
us   |  svc_alloc_arg();
>>            nfsd-975   [000]    87.049769: funcgraph_entry:        3.734 =
us   |  svc_alloc_arg();
>>=20
>=20
> Uhhhh, that is much better than I expected given how lame the
> implementation is.

My experience with function tracing is the entry and exit
timestamping adds significant overhead. I'd bet the actual
timing improvement is still good but much less.


> Sure -- it works, but it has more overhead than it
> should with the downside that reducing it requires fairly deep surgery. I=
t
> may be enough to tidy this up to handle order-0 pages only to start with
> and see how far it gets. That's a fairly trivial modification.

I'd like to see an "order-0 only" implementation go in soon.
The improvement is palpable and there are several worthy
consumers on deck.


>> There appears to be little cost change for single-page allocations
>> using the bulk allocator (nr_pages=3D1):
>>=20
>> Before:
>>=20
>>            nfsd-985   [003]   572.324517: funcgraph_entry:        0.332 =
us   |  svc_alloc_arg();
>>            nfsd-986   [001]   572.324531: funcgraph_entry:        0.311 =
us   |  svc_alloc_arg();
>>            nfsd-985   [003]   572.324701: funcgraph_entry:        0.311 =
us   |  svc_alloc_arg();
>>            nfsd-986   [001]   572.324727: funcgraph_entry:        0.424 =
us   |  svc_alloc_arg();
>>            nfsd-985   [003]   572.324760: funcgraph_entry:        0.332 =
us   |  svc_alloc_arg();
>>            nfsd-986   [001]   572.324786: funcgraph_entry:        0.390 =
us   |  svc_alloc_arg();
>>=20
>> After:
>>=20
>>            nfsd-989   [002]    75.043226: funcgraph_entry:        0.322 =
us   |  svc_alloc_arg();
>>            nfsd-988   [001]    75.043436: funcgraph_entry:        0.368 =
us   |  svc_alloc_arg();
>>            nfsd-989   [002]    75.043464: funcgraph_entry:        0.424 =
us   |  svc_alloc_arg();
>>            nfsd-988   [001]    75.043490: funcgraph_entry:        0.317 =
us   |  svc_alloc_arg();
>>            nfsd-989   [002]    75.043517: funcgraph_entry:        0.425 =
us   |  svc_alloc_arg();
>>            nfsd-988   [001]    75.050025: funcgraph_entry:        0.407 =
us   |  svc_alloc_arg();
>>=20
>=20
> That is not too surprising given that there would be some additional
> overhead to manage a list of 1 page. I would hope that users of the bulk
> allocator are not routinely calling it with nr_pages =3D=3D 1.

The NFSD implementation I did uses alloc_pages_bulk() to fill however
many pages are needed. Often that's just one page.

Sometimes it's zero pages. alloc_pages_bulk() does not behave very
well, so NFSD avoids calling it in that case.

I can post the patch for review. I cleaned it up recently but haven't
had a chance to test the clean-ups, so it might not work in its
current state.

--
Chuck Lever



