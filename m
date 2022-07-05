Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AE1567794
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jul 2022 21:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiGETPT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jul 2022 15:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiGETPT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jul 2022 15:15:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25082205EC
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jul 2022 12:15:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265HElXo000545;
        Tue, 5 Jul 2022 19:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9NcQ1qdSGDTXBhpnFrl5G8aJji++a6qcLF/bt1yKfEg=;
 b=fl6kqW/FB4ZIh27+Y511ayC9i/ZNw0XEDuKe41EOV7gcH9j9SvQwv/cZwthI2jzIRSLK
 hvUJBZOfh1ik6Q5BvpKm5Ct2m9mYUbYx/Qzce1cSV1hv61AjhVq8N18hXYFLn3KgC8B5
 40oBqElS2R20i1zO6aysUttsyQz0ZhIZ02cioiszIooemuM9A77DUdlzGzNIxx17Hi+m
 PQP0ZTJQRO39FycHK8Q/1ntUNe9IrjEZt+mt9UJo7LBWcGJPgA3cN62iShUhREzT5Nif
 IqIBc73huCX7wBj1cwcM5bpiZlXMSyMZuFU/bzFgLdgiqRwZUBZK1eLsZ7aGqNpUBz2Z fw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2dwapx8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 19:15:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 265JFDbA019727;
        Tue, 5 Jul 2022 19:15:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h2cf2e9en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 19:15:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3m/t1ZTLqVyvXKououaxhHltQYnL01/pXHXvl5NhpZBJqXiYnTTNcuGE3OlkbPiKmG1Hk7FtOVTLGoDW+2X9Okb27MtgVsE8D0YMCAQoJ1Mk2qmWSC66YVCoUs/FJQ5ZJDN2mTs8VQm1bJhMGeCgBrGQ7d6psizNsuQEBU0R8FllRXoo/Me4Hzs4Tq2qDxQuGc4Cz3WFSmOuQ0mimHtNMto2I2EPcLJxFP1EKNs2cjgLfNIxZaR/suhIBKutV188EvtR2Aw1XQ//GTTCcuaZrOzHM3yadz03pDki6s+3RH69o49R51Gm9dLm8il+5D+dwTd50NXKJMh63n2mV9R/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NcQ1qdSGDTXBhpnFrl5G8aJji++a6qcLF/bt1yKfEg=;
 b=hnxbCxAaV6ZZ3Y6i7gKUr8nwP7zTxtmfu+xRxBJ++n8Ko1iIHJhtiSwFkzclApU3RV15G7mhWXJ4iOBiquOJtHavjF6Fqui+AHhOmwKrBpRDU9WIAuJtxB2oL8S90ytA4a2HCTrjjhk5UiFICcVYgRwEXgOLPVSINnmz01TQJduAHO1Bn+iCivZRzAmaXs8ZJFhHPxKra9gYmAObUdq6QH1ehK5iaGqMa8Ijo8YJygeQJIhWI2HBspeot/iY9T69u1dwyYzZTWJ7PN7OgvAdBv8q8vV4X9FhUjxJ5n4PK8YMZWDMV/w3bzQIzlyk3kqX+oPe4ZHes/8psEGXx4tFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NcQ1qdSGDTXBhpnFrl5G8aJji++a6qcLF/bt1yKfEg=;
 b=WjWAUja0oB3jJcFdxG+050mdZwlCRrlYwE2bDuEi6d4PxqKXbAshQQi4D98TGv9dTTahIk5ZiLL6BFRoBMhS576BeZD8wu1cMqECmUZ97+HGviaMhQDLTd/RqOp8KFy9x81fOS/B8iD39w62iKB4GUY47ayG5hAp0oYS5un084E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR1001MB2191.namprd10.prod.outlook.com (2603:10b6:301:2c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Tue, 5 Jul
 2022 19:15:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 19:15:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] NFSD: handling memory shortage problem with
 Courteous server
Thread-Topic: [PATCH v2 0/2] NFSD: handling memory shortage problem with
 Courteous server
Thread-Index: AQHYj9kTr28oHI8WDEa3jt5++5AbZq1v3WyAgABCf4CAAAd4gA==
Date:   Tue, 5 Jul 2022 19:15:10 +0000
Message-ID: <B554475F-E7C4-4553-8F8A-6818692902E5@oracle.com>
References: <1656961543-25210-1-git-send-email-dai.ngo@oracle.com>
 <3A5C2D8F-0752-4070-9BEE-31D5E5F9AAAF@oracle.com>
 <10a4bdd4526fade000f3468b9b8735d2402f5f0d.camel@kernel.org>
In-Reply-To: <10a4bdd4526fade000f3468b9b8735d2402f5f0d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3ffa62a-3b13-4b44-1af5-08da5ebaade6
x-ms-traffictypediagnostic: MWHPR1001MB2191:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aOJS0lZghYby67+aFDg9E1p1jR9mOyqq9zuPQQ0aiT7NRo/uzcrmTs8GsDhcDxK8c7dh+SKaiY4WXRsDD01iwh5oNFT+VbunOWyo209vu18x/9BlRxvACGjowEEZ/5oSQ81AeTHzb7l2uGtAZ1SwGgrLlFHjELRRjZU5t/wTsMSJGhYSrIQEcDPjjOBMMhdwMlDqPJNRYgSBpJw3SEFz0E16nv9uPGxQJCNqYPW98N40zm6zpOsON8MUnulRuFkx/Mk6gynTmqtLJ/XEBQ1XiFrw4ySILdriMKQ8I9jHJF476yNPmQf9Nu6Lsmnr/Sy1JpW4tDwESHnPwlEmj4dfOiCNn0jT28lupHHpi6g5U+4Snv66Pl+R8Jt7gcD99oNa0UYMKXuu+NHDOfdzIPHQOg/jFqIhhYVGa95CNLcpn6SegUcgluuhiUbZ8zT9G6dqfXuU5YrrLjfacRJQHHyL5DaITiczY7qXw2tRoHteXbjq6ZpF5A041C10Wh+OTUMCVTv8HWy6ly5+K8jKq18sCVSL62qitypdwf3F7gaQQcmuIP3aPBKkDsKJs5ulA9BYU75Pef4HS/EN6HymEay1V9KmRz2areMWABVyPySuKkQeb+iL0R2F08OjSu5WpQjmjyk0xB1UOJNsnmSbN0FnqED4xeVNUHjkD6Ebw6kJBSFxkesAeUxiq6FZS8wIUoX+irEQ4X7voT16Z0Y1quep9456Oj3uTfyhBXz+pxqmtNiJheTdXDfaM67CwEmcag8afx+pWhtvz9l9YoO9BJJcNNNGVPYlajyJY+hGIffmxfphNHWlBEZtb1fJwfZ/DIf9E56N6EwCAVB7AKaBVUyIT9wGdFL1Fq+omJxfam1aZWsE9+4NzVPjE+A/aWWY45rJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(346002)(376002)(366004)(5660300002)(33656002)(2906002)(478600001)(2616005)(4326008)(122000001)(38070700005)(6506007)(66946007)(53546011)(64756008)(66476007)(76116006)(66556008)(38100700002)(8676002)(66446008)(83380400001)(186003)(91956017)(36756003)(6512007)(26005)(6916009)(54906003)(6486002)(41300700001)(316002)(86362001)(8936002)(71200400001)(87944003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HnundZyb+5JZccHgRNLhXvAFhPJJ1RYpsikxRsxngzg4tN6PbbgdCCJNTHOr?=
 =?us-ascii?Q?s76PLr/uvnwU6t368/6sf1p6zDlOHbZaCJ4099jrHMOisTB5tkK0zPFybFAb?=
 =?us-ascii?Q?C1OS3+JmGOvfoO1FffmpA/FTLb34dxoRyZh8+W4J2ZrDh7qSmbT8/NwxIHhW?=
 =?us-ascii?Q?9aOn7ibwhxkP2YT8LksasjvW2nHzTl7sDPHyivzTnt4mfuhnzxaWK/KdRjTu?=
 =?us-ascii?Q?Ut/809vAR+Y0jCtUdDoWHXtRJk+JrV34ZYE+8UNv7TqZU2P5bdcZJRPOsGrO?=
 =?us-ascii?Q?o5n3zKf7mQ1SlJb2EM+SmfwWpnvWUvL5jPlza/X2Mg2cxSg+8mJKejGkzaPd?=
 =?us-ascii?Q?HMfHQkR4out7mglAtr8UhwXrlhN0b48LMHdA5qN4RGsgihBpgNgYG4AZcrpE?=
 =?us-ascii?Q?s9NnmBLSCxk7dYE0YaPmcy3XyqLiF/e+2W16eJvJuqFTOusfWQbjzstkaI7x?=
 =?us-ascii?Q?HuvllfJStQdEeQW15I5KI+BKX/1WlHTJyRZX+V2wk5+AQfmbgzA4aTivX5Ht?=
 =?us-ascii?Q?BeAsYqTj6FhhECJu2auiD4r1bXRhEjXSqpbPK+yNNQBIcEupCKzZB9/5YGsV?=
 =?us-ascii?Q?HZoZRyxsfv8D9ILAQpOR3FjGWsXSS1Eg1alt9F58kqbGHpt3p5Z7HlG6xovO?=
 =?us-ascii?Q?w7wMF0DqgDg7wKRZbaB2CK9DeM1QfKpKONSpXBNHpRpILFhhYt3o9zpXK8eX?=
 =?us-ascii?Q?fOHi6kihPddjoymit3jzhzq+eJDKByFVX3YBVTXGgHKqcTj3vGBSxARdhhEq?=
 =?us-ascii?Q?JC3ceNd04UiBj4AnEzDaywhVJbrv+e5Jrq2Oo4hIW5PS5t3eoSqg/k96AXh5?=
 =?us-ascii?Q?maL3adJeqLTUnxaYYApwbbP1PhJVcNV9g50ATIywvySvSxJIH2Xi2MwN+oJv?=
 =?us-ascii?Q?P7RYAl0udydz+oisY2L4GfUsNvvjmi3ghmk9vC+d10KuzF9ESo+exUGYWGcV?=
 =?us-ascii?Q?PAdOjnaA/T42I7NQ2iLn7RD+XJseAnyqr3lTM7WbA5N+VlS4Cp6Q54Dyw2Wl?=
 =?us-ascii?Q?L8etOfLycSWdKQlzQ1KV5f67ohbd563Qztc2FNIjZ6qoRahFMvxx24o0/6Gx?=
 =?us-ascii?Q?IyeU5WpoVlbtGybbXSrh1V82LoO0diG6G24WerLOKrpe353CV2mhZXFiHkMz?=
 =?us-ascii?Q?TjnROZcUZ+OaTywI/ytNjElU9N45ZWlLcyTnZ1YHCycEUnbvHG3OBkXYCvwf?=
 =?us-ascii?Q?jXDLKqqM9Q0JrSuwQIxmvkoNzibOVNdFLn6VtduHK3+nsHzdRHUHtm8rqXdm?=
 =?us-ascii?Q?fucZAYRHooHzDVfo589OFdRrrnmZrSsLH4yfIEOp0c2GzAn3/dtBXKcW9FkG?=
 =?us-ascii?Q?oJCvAyRL3dRYIfJMEBpCZPmIDMR//c635g91cB6J6rUU6rg8HLSCydonfMgs?=
 =?us-ascii?Q?cOiz7ZB35/GiZ4DcQFf9O/ID0IQkbCL5UoeUXb5tvkRYkQM/l+nZCfeN4p4J?=
 =?us-ascii?Q?uUvpbBv2KQlf4kqS0EKLolnX9I/x+hH08bJgW9jaEIP/RZZ5KaEV8oIefdNL?=
 =?us-ascii?Q?3cQxeqHCoRGOL0RF13o9ebIWI07c/vQ62uRZttZ9ImrbPdbtEJ3GownVrOrb?=
 =?us-ascii?Q?4kCNrK5JgJ2qmuNdWp6ynweIp+/qIyd7OGPh1HLU7Y5YJ97+zG37EVo2oSKE?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4DBE4DFF662836499FE30B962DBADB4F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ffa62a-3b13-4b44-1af5-08da5ebaade6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 19:15:10.0344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuUQYNg391RttkB8a8jOlfGGogFTBWx1lLrgd8/ohKL3qbw1/cC0zZXF1+WluGRNUx8b/Q8E50Dsuy8Pk+ToDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2191
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-05_16:2022-06-28,2022-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207050084
X-Proofpoint-ORIG-GUID: CazyxJVQG2su3UYWAXoQT0cwdATEqw5c
X-Proofpoint-GUID: CazyxJVQG2su3UYWAXoQT0cwdATEqw5c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jeff-

> On Jul 5, 2022, at 2:48 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2022-07-05 at 14:50 +0000, Chuck Lever III wrote:
>> Hello Dai -
>>=20
>> I agree that tackling resource management is indeed an appropriate
>> next step for courteous server. Thanks for tackling this!
>>=20
>> More comments are inline.
>>=20
>>=20
>>> On Jul 4, 2022, at 3:05 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> Currently the idle timeout for courtesy client is fixed at 1 day. If
>>> there are lots of courtesy clients remain in the system it can cause
>>> memory resource shortage that effects the operations of other modules
>>> in the kernel. This problem can be observed by running pynfs nfs4.0
>>> CID5 test in a loop. Eventually system runs out of memory and rpc.gssd
>>> fails to add new watch:
>>>=20
>>> rpc.gssd[3851]: ERROR: inotify_add_watch failed for nfsd4_cb/clnt6c2e:
>>>               No space left on device
>>>=20
>>> and alloc_inode also fails with out of memory:
>>>=20
>>> Call Trace:
>>> <TASK>
>>>       dump_stack_lvl+0x33/0x42
>>>       dump_header+0x4a/0x1ed
>>>       oom_kill_process+0x80/0x10d
>>>       out_of_memory+0x237/0x25f
>>>       __alloc_pages_slowpath.constprop.0+0x617/0x7b6
>>>       __alloc_pages+0x132/0x1e3
>>>       alloc_slab_page+0x15/0x33
>>>       allocate_slab+0x78/0x1ab
>>>       ? alloc_inode+0x38/0x8d
>>>       ___slab_alloc+0x2af/0x373
>>>       ? alloc_inode+0x38/0x8d
>>>       ? slab_pre_alloc_hook.constprop.0+0x9f/0x158
>>>       ? alloc_inode+0x38/0x8d
>>>       __slab_alloc.constprop.0+0x1c/0x24
>>>       kmem_cache_alloc_lru+0x8c/0x142
>>>       alloc_inode+0x38/0x8d
>>>       iget_locked+0x60/0x126
>>>       kernfs_get_inode+0x18/0x105
>>>       kernfs_iop_lookup+0x6d/0xbc
>>>       __lookup_slow+0xb7/0xf9
>>>       lookup_slow+0x3a/0x52
>>>       walk_component+0x90/0x100
>>>       ? inode_permission+0x87/0x128
>>>       link_path_walk.part.0.constprop.0+0x266/0x2ea
>>>       ? path_init+0x101/0x2f2
>>>       path_lookupat+0x4c/0xfa
>>>       filename_lookup+0x63/0xd7
>>>       ? getname_flags+0x32/0x17a
>>>       ? kmem_cache_alloc+0x11f/0x144
>>>       ? getname_flags+0x16c/0x17a
>>>       user_path_at_empty+0x37/0x4b
>>>       do_readlinkat+0x61/0x102
>>>       __x64_sys_readlinkat+0x18/0x1b
>>>       do_syscall_64+0x57/0x72
>>>       entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>=20
>> These details are a little distracting. IMO you can summarize
>> the above with just this:
>>=20
>>>> Currently the idle timeout for courtesy client is fixed at 1 day. If
>>>> there are lots of courtesy clients remain in the system it can cause
>>>> memory resource shortage. This problem can be observed by running
>>>> pynfs nfs4.0 CID5 test in a loop.
>>=20
>>=20
>>=20
>> Now I'm going to comment in reverse order here. To add context
>> for others on-list, when we designed courteous server, we had
>> assumed that eventually a shrinker would be used to garbage
>> collect courtesy clients. Dai has found some issues with that
>> approach:
>>=20
>>=20
>>> The shrinker method was evaluated and found it's not suitable
>>> for this problem due to these reasons:=20
>>>=20
>>> . destroying the NFSv4 client on the shrinker context can cause
>>> deadlock since nfsd_file_put calls into the underlying FS
>>> code and we have no control what it will do as seen in this
>>> stack trace:
>>=20
>> [ ... stack trace snipped ... ]
>>=20
>> I think I always had in mind that only the laundromat would be
>> responsible for harvesting courtesy clients. A shrinker might
>> trigger that activity, but as you point out, a deadlock is pretty
>> likely if the shrinker itself had to do the harvesting.
>>=20
>>=20
>>> . destroying the NFSv4 client has significant overhead due to
>>> the upcall to user space to remove the client records which
>>> might access storage device. There is potential deadlock
>>> if the storage subsystem needs to allocate memory.
>>=20
>> The issue is that harvesting a courtesy client will involve
>> an upcall to nfsdcltracker, and that will result in I/O that
>> updates the tracker's database. Very likely this will require
>> further allocation of memory and thus it could deadlock the
>> system.
>>=20
>> Now this might also be all the demonstration that we need
>> that managing courtesy resources cannot be done using the
>> system's shrinker facility -- expiring a client can never
>> be done when there is a direct reclaim waiting on it. I'm
>> interested in other opinions on that. Neil? Bruce? Trond?
>>=20
>=20
> That is potentially an ugly problem, but if you hit it then you really
> are running the host at the redline.

Exactly. I'm just not sure how much we can do to keep a system
stable once it is pushed to that point, therefore I don't think
we should be optimizing for that state. My concern is whether
larger systems can be pushed to that state by drive-by DoS
attacks.


> Do you need to "shrink" synchronously? The scan_objects routine is
> supposed to return the number of entries freed. We could (in principle)
> always return 0, and wake up the laundromat to do the "real" shrinking.
> It might not help out as much with direct reclaim, but it might still
> help.

I suggested that as well. IIRC Dai said it still doesn't keep the
server from toppling over. I would like more information about
what is the final straw and whether a "return 0 and kick the
laundromat" shrinker still provides some benefit.


>>>  . due to the overhead associated with removing client record,
>>>    there is a limit of 128 clients to be trimmed for each
>>>    laundromat run. This is done to prevent the laundromat from
>>>    spending too long destroying the clients and misses performing
>>>    its other tasks in a timely manner.
>>>=20
>>>  . the laundromat is scheduled to run sooner if there are more
>>>    courtesy clients need to be destroyed.
>>=20
>> Both of these last two changes seem sensible. Can they be
>> broken out so they can be applied immediately?
>>=20
>=20
> I forget...is there a hard (or soft) cap on the number of courtesy
> clients that can be in play at a time? Adding such a cap might be
> another option if we're concerned about this.

The current cap is courtesy clients stay around no longer than 24
hours. The server doesn't cap the number of courtesy clients, though
it could limit based on the physical memory size of the host, as
we do with other resources. Also imperfect, but might be better
than nothing.


--
Chuck Lever



