Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD39355C9F
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Apr 2021 21:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbhDFT6e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Apr 2021 15:58:34 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58898 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhDFT6e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Apr 2021 15:58:34 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136JnAfd169683;
        Tue, 6 Apr 2021 19:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=SF9m7igOpJlbnY6Feli64Wv60Yn+LPwGo9tO8QQcz6U=;
 b=JO1VaPKw/i+wUlHuRSEaDHbA0U82f+SmVQ6lVlrTGfwWjmwQ+e8RYjieHLHCI06TWcXm
 SbbQf90NuSEDVrUCGsl8sReUcrmjbaqJjrA0341w9bN9lrGY7PjMU2sXroL4F9JaKhtV
 auNMOyGEqcfFFkfzkr9r9paj8eAzBrS6f6n9jI0JDjLD9dm+0EpDVSbXg5W7YnCMb2G2
 KBmEHS9lWfQmPzZqtqgrzAv34A9pmZ8capjNqBEtnGSoNgEqIT15jB60/pIDiJrFDr0l
 3O8ZJZo3PRX8yxhudWnPkCsGTrPb+VjGr0DBSTeTB9sPBem5uLNtH6ZbWRFGG6icaq4i nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37rvaw0c48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 19:58:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136JtG4E075807;
        Tue, 6 Apr 2021 19:58:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3020.oracle.com with ESMTP id 37rvb2v817-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 19:58:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXubdOzMhoPPVnhl+4Tj7GQmKxthwvChDjMWcZ1iA/lJzOuC3bpDwunFJIYaDNCnz7UA81Yzvk5vp26booxrIyddoG+EG1+LLEZ10HjHHQhi6joEWCh9NRmTHKx/72K5Jsvx0RonhxZo/JI6B2NML13fPZVyizp41+7NbfNdmIZQftw5r9ciL34MCcLdS1I4O7SkSUefF4/p/pOlH9/VMZPnedoKyFMRRxHYXRu76SuYRvIsLcvoWNVm1hsEFgjS20ilosnf1w6xZyzfl2EbCtNWeAC4kSHwX/WB7woDek7gKRM3y6pV8Xc6nhzvhQuXBIhPfweA7jkrFuIr9qneIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF9m7igOpJlbnY6Feli64Wv60Yn+LPwGo9tO8QQcz6U=;
 b=dFeZSmQxX9KJA4qk9px0WYr+BFoh3AnsO2zt/enRZq05dwqfCILLAJjQkPPmxeFB+UovDKWhbORXQYkMKqlVHjvFnYlYxxvnbJKYr+HFsjunPEu3XgnDvhYIITW/DksKt8dGoH6UAQNSKhDUkGd3+eOJanPpWj1WswHpvOSwofL8Dv5rFWn7kzP3DowidFGu2thMiaQKCjzlEjAWCHQM9Ve46Jn1IQaBg9AUENu4o7jJRBELAFmJ+N7XShnORoQY8Ed3uFiAPsgP9ZWNEPEM2en5xsHYFyRJ56+pQpLRIyjQkZspRn4tXvqlJcQmlQCmq6x0iO/cV94M34HXtSzK2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF9m7igOpJlbnY6Feli64Wv60Yn+LPwGo9tO8QQcz6U=;
 b=JTWfHe8XhM+m/WpbooB1BcYZXJ2DepiIxDQgr9DpI7MvU+MqEWa8s3py4C1wGK8Req9hhYiIJ5uePVsJa5SPGjuGiVW1Dq+0HBBhQ7yUNrpIlnV5fJC41PaPC4FMlWId/Hzq0VOMegj9Sh4xHrP59hK/8H4wWXOxz3eauIY+Pos=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4814.namprd10.prod.outlook.com (2603:10b6:a03:2d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 19:58:19 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 19:58:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's
 export. 
Thread-Topic: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's
 export. 
Thread-Index: AQHXKBgu9IXq70YdMUCq9qUqUB+L96qntQoAgAA0ZoCAAABtAIAAA/oAgAAAWAA=
Date:   Tue, 6 Apr 2021 19:58:18 +0000
Message-ID: <01CD778D-57A0-442A-8D1D-5084F0FC2497@oracle.com>
References: <20210402233031.36731-1-dai.ngo@oracle.com>
 <D85FBDD3-5397-4D47-932D-159AFE2A5E0F@oracle.com>
 <CAN-5tyHVOEr7zZM92PVS0GYJQ2M6rSs6_zqZwuioumQQm7zzUQ@mail.gmail.com>
 <7BED2160-1052-49EE-BB62-6ACF6F84C91C@oracle.com>
 <CAN-5tyEKqNHmwiMfCpkZrCVYeaO-FH69v5L4Tk_8EsoTfytpVA@mail.gmail.com>
In-Reply-To: <CAN-5tyEKqNHmwiMfCpkZrCVYeaO-FH69v5L4Tk_8EsoTfytpVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3029311-e3d8-42ea-b5df-08d8f936530c
x-ms-traffictypediagnostic: SJ0PR10MB4814:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB48147889BD414AF812D1095793769@SJ0PR10MB4814.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0jItxcinYtAPYocXqipQTTTD+1hxQjkW9oerYVQKbj70UHVe5sDyia1AnF9SCbizusSsmVEjBJCkM7RnrZP/MSjggF9iXbLrF80yuiwgz+5ZrGjfuyHbvv5AW26soWXKDNEErvopLUiHjGRg7MwGowtztosbbpksHz81OZ9c04lqenCGNKLmBBN8KwB8n7MaltETrFT3z9F6NMKH536RULQAtKKjB6p4z95+LO8spWV5AP2LOo8H60snuXezV/mxfEJVJgvWpCWhKc9lkuKRcOVYwi+rw8R3Pp2APsyvEiep1l5N/KnlKDcSIhKAXBl4nD+PLjkJUdbJrKOyrfPcGx7J/+HFKVq6GDnUM5oGkelQXE1tEnMM3bMSX8gHdO2DQVcVUlKkOx1PRWb8aae09H7Z/FMYcRmQov+zx3EtfZME8PO6WjBGNtKk6zexp8G3kZLQgVN6B/BsxNwgEMCLxXd8qKP2+YR3QBX0bJCq72RJP/mXoc+uJOVOTZJMH2WMSa2XwmgS+MOD8pMs/Flt+trNVfEjuJfcDX6P8HRPaAKigss+NOjsSqwKGWWGHAvnhJMNmto56PbR1aZCWdd076hgX8psBOHYxeIkPVor+UnxNMLhaco2aRULcOhIGJvHtz3aNxQgef9aic+O/sHSMmtHdj/Pd+20BdNqLwfY6W/ZeAV3iLwQDXs2LPIY1DeY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(376002)(396003)(6512007)(6506007)(5660300002)(2616005)(8676002)(83380400001)(4743002)(26005)(6486002)(8936002)(36756003)(76116006)(66446008)(71200400001)(186003)(316002)(4326008)(478600001)(38100700001)(66556008)(86362001)(66476007)(91956017)(64756008)(33656002)(66946007)(2906002)(54906003)(53546011)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DeJ3kuhR1XEdoQk53WNYCFuyO/w1+xExof1zbKaCzpaJ7+8ap2yc1LkZTD8O?=
 =?us-ascii?Q?VVhnXBShPRPltAube+K1QDB7XGnykM+xtebeyKmCIB44CyhQCvKzO+RK1tYI?=
 =?us-ascii?Q?MIvOc7hFLkyiPi58GzFnOju8U9wJ2ShAiCMbiP+Th2HWC/GdL7Ane44s5mjJ?=
 =?us-ascii?Q?CPW3fwPKddZYF7E3YkmA6BAoS7t/EKWl3lO1Ts5Iy/mjWGSrRss6bp4I5oPu?=
 =?us-ascii?Q?GXXN3bTm9OpRfdQHI0Jyek0cdknqxRjynQMCZp5egdWHWp/Yy8BalJvh8hhN?=
 =?us-ascii?Q?ct/3hXapJmWlRkmjVv9oEE14SMwW6UKK7auRipeJvwIpkKAtPIozFfRGKZ/J?=
 =?us-ascii?Q?ekelCTfjFzvondzkH6XmrLZl+HwrG963BAIeQlD7Y+xwb6bspAtxwDsUIKlJ?=
 =?us-ascii?Q?r1epi4lhPDLh36eokll6JmloMZWHQ3HR0dYBwnh2JBoOorNZgIKy8UL9XnnG?=
 =?us-ascii?Q?nRMQ8zNkkJlFSuKB9H1HkWm3nclZfLRgw3U2JqtZds3JhitVAVKjg98D3bwI?=
 =?us-ascii?Q?x+ZYdj7iPVfdedX3bKVFrmwFJoztQSxbSIqMMTLvOdzGYyKLCRhAWB4F8bAu?=
 =?us-ascii?Q?+EjhsAcv+BmjZzykfc7+ZzgB0LMqi+1C9ihpwbTqVbhfxVqBHJwVnttEcXMG?=
 =?us-ascii?Q?ewLHU9O9F4j9GoiYaLFCq/tPK6VVn6TmMvrxpJIs87gvxuEbycGS9bps4P1n?=
 =?us-ascii?Q?eQ9k6swDzE1fyvLFLCJ89XqogrJAK50ZIrVlJxZrnpBJngBmatHUS49Mkpoz?=
 =?us-ascii?Q?voUpYLGH/7VODuuEEE6uiQB8eT0eaiagUQAdyH0mPoJZvJTceIoxvCdBn0/x?=
 =?us-ascii?Q?keHSo9s0srYFl+b5eoyKeTBRQOLX3gxoq6P3ZUUR3oDISsYJtBcR0VaDi2CH?=
 =?us-ascii?Q?gEV2E+ped31Z5iJ9CfAqXWe1xkFM/vv0qf8oaXaXzsV93x3So4iMMVZxc0Nd?=
 =?us-ascii?Q?0b1ifzd+kGAa7Mf2Kmp5MQaLeGCuAdeihmlGKYYg6fH+4LeCYSfFyvS1TQnc?=
 =?us-ascii?Q?iU4/6/mV8wHLitbvrRtKjrrE0SpyliSOqcoC9ZdnnVwvvDU+OPGOdM392wKe?=
 =?us-ascii?Q?nDynkklEz1P5k5hSzzSXQkYM/uZutmAK58r0O3Wy5J5ptkVbXtJkWojcVN1j?=
 =?us-ascii?Q?SIoxBkZbocfZY6oR4PZZrs8FgNSllkY5y1gXYCSatCuqGVJLBZKiYISZNHs5?=
 =?us-ascii?Q?/U8WiAtcvfHtlkSGYor6xvNwritLLWrzHVsfvvBn/A60pEwKK0V6L+8l61m6?=
 =?us-ascii?Q?j99vbpVqjS6x3xpFHfxZc+plMbqhkt9Ve5tR0IbOvzGy+QxLzpegzXYz6U4A?=
 =?us-ascii?Q?v+qJC+Rl+17nm1i8BHAbuRfJ/pxKlsultFO7iIw+qfk9mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7EE775F60A17F4F96EA37A607CDA23E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3029311-e3d8-42ea-b5df-08d8f936530c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 19:58:18.8632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBXdyr8l9G6HLQrk2YERml7IyW35g05JqijKvFUutEYEyyFdYJmWsp0KnnPg+Qy0eqzRZYD7HcTOnSs+egB1ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104060135
X-Proofpoint-ORIG-GUID: VOz12P84Rh1HgyuHLNyK7sWJhE3Iubhc
X-Proofpoint-GUID: VOz12P84Rh1HgyuHLNyK7sWJhE3Iubhc
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104060134
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 6, 2021, at 3:57 PM, Olga Kornievskaia <olga.kornievskaia@gmail.co=
m> wrote:
>=20
> On Tue, Apr 6, 2021 at 3:43 PM Chuck Lever III <chuck.lever@oracle.com> w=
rote:
>>=20
>>=20
>>=20
>>> On Apr 6, 2021, at 3:41 PM, Olga Kornievskaia <olga.kornievskaia@gmail.=
com> wrote:
>>>=20
>>> On Tue, Apr 6, 2021 at 12:33 PM Chuck Lever III <chuck.lever@oracle.com=
> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Apr 2, 2021, at 7:30 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>=20
>>>>> Hi,
>>>>>=20
>>>>> Currently the source's export is mounted and unmounted on every
>>>>> inter-server copy operation. This causes unnecessary overhead
>>>>> for each copy.
>>>>>=20
>>>>> This patch series is an enhancement to allow the export to remain
>>>>> mounted for a configurable period (default to 15 minutes). If the
>>>>> export is not being used for the configured time it will be unmounted
>>>>> by a delayed task. If it's used again then its expiration time is
>>>>> extended for another period.
>>>>>=20
>>>>> Since mount and unmount are no longer done on each copy request,
>>>>> this overhead is no longer used to decide whether the copy should
>>>>> be done with inter-server copy or generic copy. The threshold used
>>>>> to determine sync or async copy is now used for this decision.
>>>>>=20
>>>>> -Dai
>>>>>=20
>>>>> v2: fix compiler warning of missing prototype.
>>>>=20
>>>> Hi Olga-
>>>>=20
>>>> I'm getting ready to shrink-wrap the initial NFSD v5.13 pull request.
>>>> Have you had a chance to review Dai's patches?
>>>=20
>>> Hi Chuck,
>>>=20
>>> I apologize I haven't had the chance to review/test it yet. Can I have
>>> until tomorrow evening to do so?
>>=20
>> Next couple of days will be fine. Thanks!
>>=20
>=20
> I also assumed there would be a v2 given that kbot complained about
> the NFSD patch.

This is the v2 (see Subject: )


--
Chuck Lever



