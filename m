Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D613F9AB3
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Aug 2021 16:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhH0OOt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 10:14:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39800 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232257AbhH0OOt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 10:14:49 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17RDWKZ3024871;
        Fri, 27 Aug 2021 14:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Sehnso9pOxtTfD7nfUpV8kpLlVKDKp7WSDZ3NOoEw9w=;
 b=aCVcUKasA8nvtzL1sIiG7NFFyLfC+eRrYoP4lV17m9nXmSDvjmCfGiOH8EO5eZ3L2Vck
 UyHepGWBw5fDZzMiE2LDnaCsE3DEs+DgaMWo5azqOSF/pNSifybTCphkTPWeU9xMHRvf
 4i2I0LRaqcY0YYW4xUVfixdpF99Rw4uUWZioOmFvhMBQ9P3NundS0uBTlWyvbaZQE8sr
 NUzMvl7mOH4f1f4pqBFkjyYGcs21BKWQ9XL9RM5MOUh4dibocGSPpSo/IXlX+pDa6uhQ
 tA/Ii8cZxCIUzC+MEdd4yJbts/2018scOXvCzchmy7ZA4Zf++TYhhX4LP626ZHzWy8hC sQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Sehnso9pOxtTfD7nfUpV8kpLlVKDKp7WSDZ3NOoEw9w=;
 b=zaNPHff3qIue36oZ8J3A+BBsbRpWsmS0lyZmGGxsZ0McnUaMV6QJD8zboCt8hfOhfjTH
 fxBxHNgS/gaS7bvZqTJOztKWp/+ApG8ah8KlXewqQgkDU9H6AOdpVK2nBKNI/gkBO+Zd
 fKxv1H+/FKGIG1w1NvJBTJm1tvW/siQBRpcGXW4TCYy7w3iuEbBBKyOs8BXCoBOjzl4N
 yHtcs3IxVIWm64mjjcqvmnCOY8WAHtPlMLSJtTn2rWZNsTHcpLqt4Kr+LzCf694dQM68
 iWR4q1SWqjo0pjTs4mCewCQo3IyKVKLgnBakdMSFy4/FhoGNqD23jwSbnLcA8McgrxvH BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap4xv3n6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 14:13:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17REBZOx016905;
        Fri, 27 Aug 2021 14:13:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3030.oracle.com with ESMTP id 3ajqhmn191-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 14:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leKOH7jz4bMJkePSokBBB8SaO3nS040Ya9kGkdU/h/XWdPRj4vSFWxVzhHv021JYEH57h0RYGaWV4WnghmRXPhe0ojIPNsxx30uPuR5Q+QOHa9HiOOmB5CBgBNfCFkF8Xe6NNC1PElAmyiTb159F3ftxZV+x0TXiJD437YBupolEHRbi9BGYtSzdSGJnWDTrX2oPOjYunhTwEA0cSEUrwifBjRuV1koIcOTLY6fcRqd/EZlaKjSHo5PGLrfnDuXEkgRY88Z5YbftCMqu8BJeWNkJu7KpPwqOKBWUk/uezLCMGhTSi3YZb7welU6ZbdeXPyQCAV2IeUGVpkef4HhFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sehnso9pOxtTfD7nfUpV8kpLlVKDKp7WSDZ3NOoEw9w=;
 b=P1w3QwmtVx7A9ulpHImO8ixq4ISF3Pi5VIWsnj++vphCoiXRqPEEz2SAMChEnSa4u5MEUJR5ZIQwCt+i7nTr0Dpj8Gm/g2zflLnWqG83DsmoUj7fwrGGGWxSRXvpFoG/PJTWHHJZlZHIUV5XC/als5FeVSqp0bgkwdsFyTEzag+cTWVX+dzt60TkuDTs2Mkj2dX5i5uGZnAigF+dgqdpi8/oGtMyAuDBv4vj/zKqryfJHl+mkr5bIKNIc0Mo1xF2gVB5YBbNO41JFZ/47GPF205TcfAvfXEZxJEEWPW0UVWqSsNTi0/aqYQbFFn2ROVCNvKksIW1Eawc7WMlQCcACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sehnso9pOxtTfD7nfUpV8kpLlVKDKp7WSDZ3NOoEw9w=;
 b=Ufh/48Rcbo1RolndzL6dR6mLOiPYdE48Gjg/9tRt2DDBUYnzQGBp7RVkLn3i/tuhIMSZ/7SDM+nxccrp9KcmhDoVuJcsiL84RnrK9pDSNSz32rzBeOvsw4w/EBQLj/6eZWD5N48Y2IxO7a0wfVmcnOLKwBsgh+2Jzishwzcwvaw=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4464.namprd10.prod.outlook.com (2603:10b6:a03:2d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Fri, 27 Aug
 2021 14:13:50 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4457.021; Fri, 27 Aug 2021
 14:13:50 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Mike Javorski <mike.javorski@gmail.com>,
        Mel Gorman <mgorman@suse.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
Thread-Topic: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
Thread-Index: AQHXjKYRxKTFwD0+C02+ZMVduTdsB6tqSi4AgAAHiwCAAZhPAIAACtMAgAS9YICAAA1rAIAAA7UAgAMLuwCAAZFegIAAyYQAgAAzUQCAAG7RAIAE0AAAgAAF0YCAAxscgIAAOP4AgAAGqYCAASxAgIAGIIuAgAAkXICAACgEAIAAWTeAgAAMTwCAABHBgIAAdRaA
Date:   Fri, 27 Aug 2021 14:13:49 +0000
Message-ID: <6CC9C852-CEE3-4657-86AD-9D5759E2BE1C@oracle.com>
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>
 <162882238416.1695.4958036322575947783@noble.neil.brown.name>
 <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>
 <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com>
 <162907681945.1695.10796003189432247877@noble.neil.brown.name>
 <87777C39-BDDA-4E1E-83FA-5B46918A66D3@oracle.com>
 <CAOv1SKA5ByO7PYQwvd6iBcPieWxEp=BfUZuigJ=7Hm4HAmTuMA@mail.gmail.com>
 <162915491276.9892.7049267765583701172@noble.neil.brown.name>
 <162941948235.9892.6790956894845282568@noble.neil.brown.name>
 <CAOv1SKAyr0Cixc8eQf8-Fdnf=9Db_xZGsweq9K2E5AkALFqavQ@mail.gmail.com>
 <CAOv1SKDDUFpgexZ_xYCe6c2-UCBK0+vicoG+LAtG2Zhispd_jg@mail.gmail.com>
 <162960371884.9892.13803244995043191094@noble.neil.brown.name>
 <CAOv1SKBePD6N-R0uETgcSPA-LZZ4895ZJDKTY7mYvhfu184OQQ@mail.gmail.com>
 <162966962721.9892.5962616727949224286@noble.neil.brown.name>
 <CAOv1SKB6xqyduf5L5hcXOe-xMN-UJOfFeE5eXVga3TviKuH0PA@mail.gmail.com>
 <163001427749.7591.7281634750945934559@noble.neil.brown.name>
 <CAOv1SKC+3LXhM+L9MwU2D03bpeof55-g+i=r3SWEjVWcPVCi8Q@mail.gmail.com>
 <163004202961.7591.12633163545286005205@noble.neil.brown.name>
 <CAOv1SKDTcg5WDp5zf3ZGL0enJ7K693W-9TMYKcrgweyzp6Qjhg@mail.gmail.com>
 <163004848514.7591.2757618782251492498@noble.neil.brown.name>
In-Reply-To: <163004848514.7591.2757618782251492498@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2954bfe0-1f08-46a6-7ac3-08d96964e473
x-ms-traffictypediagnostic: SJ0PR10MB4464:
x-microsoft-antispam-prvs: <SJ0PR10MB446419EDD6405024253806D393C89@SJ0PR10MB4464.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K8e53imSzlZPy+XbgfvqZoNE+QFLX5cXfMoRCOi1dXQoM52kyC+0DzwO4gbcDYeAWv3GQYYSXVW+EI5qrD0I5nPVVwghaplkgedqm/Y/vyTo6Y+GKuyjnUF80NtWgvvCw7YuznVYtdYu/7kzqvDH+a3zs9jxqY2rqWKqvhPF2K2Z3tJglATjgJI6yln58Ab6Ti/wdgzj06nWVIx/1I2ZtpnQN+k5WMC5dcW06T109ZbeM9oWoCXx7wzkL+8yGiQj1lYxq3R9TAtlGSRWe05Ihd2HYUv4vACahSQSfXx34hLs3NQxzPrUbbU00UF3vomXwFOLFcJEyTgIKjq7MhoIWTQr718Op+TMgBgFt1i27aeSPnZH7s/z300/04dzEe3vxY4K2mUPVKFglyIcwg2B+axPIRpeag+DriRZF7u1JcY33MFdTrj/XoHYOgiwGG86rgcIauLUuQ2FQhjxvey/VUgfJwx3uo5ls4w/Y95QSzj9wuzkMJIOyduopW0JFhj8C/i6paYJqzp4UfatOoi2Sldui4wE6eycd50kMWa9jaNM8rF6rXl8/zB7PDUE6yFExWOOQLl9pWlxn/2QxyeNoBWoEH2PThMWfNP9fLyicyarOJc7nr/Uw9iZ/9U3XQTUoiRwdWnmjEiDeqPOeUqwjikmmvXdWJc1UC4rNOTWk+GstsOI4316QSFqoHDyhh/FZ8xV7fMe3AJbky9T7Vc1LdyvNPb+R/Zl/JqajwfZUXV2fSdAwLObrpRsRGM+FV4o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(346002)(376002)(136003)(8676002)(71200400001)(36756003)(86362001)(33656002)(316002)(6512007)(478600001)(66446008)(8936002)(83380400001)(64756008)(38070700005)(26005)(53546011)(38100700002)(54906003)(76116006)(186003)(66946007)(91956017)(5660300002)(2906002)(6486002)(6916009)(6506007)(4326008)(66556008)(2616005)(122000001)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FM3fjkdL8rrzHyVhlVg/Rx8Fu/hIWgm7xSfm4h6mLyGL7EVRcjcksTSoc067?=
 =?us-ascii?Q?Gx1bcPWR01cEjTa4/6SaFQ0j7szJSx/46b/uhK415MJ7jdiN3d58phBR/Yb/?=
 =?us-ascii?Q?E2WG/sDvsIQolposnIqhw2OCv8mRS/mEoJqvThQhIm52EPlApR19xZRWUaF8?=
 =?us-ascii?Q?KgMzzmS7sUHhNXSjTasTki9247350u1yYm1Ai7YqlDGPfieCSAUHJHD+40Pm?=
 =?us-ascii?Q?ObFI+nNXwWLL4xECvXo9PGcCUutdER3txTza5iDvJHlDGhb3D7dZbtuc6/qi?=
 =?us-ascii?Q?lB2GPjQUXtK/ctgqoNcZ3Cs4Ilaue158J9ahZTzAX2uagWEcsgMotRu81DuC?=
 =?us-ascii?Q?0rC//65fInkR3wDhZFMqaH99yRP+wPGO0xe9z803FpBmhxbs+JOyzdFiWPgY?=
 =?us-ascii?Q?X8AYtT3Rg3lyCpudlOU47R8HDXG+54kOS+L+VC1+uRu+13GVj/N3+Nhdlu0Q?=
 =?us-ascii?Q?BDNSP7jYWFlOf38HQ6BqNaj0iS794FwdbnkF0KyUniWhCFhIWltkRchg3yyB?=
 =?us-ascii?Q?HDGcvo+3YOeaHTe3buAP9oxfBqAxterbc4pZ8pMuc9RnXCJuXfV4bi5J3aMg?=
 =?us-ascii?Q?EkDGYCmKORbm3ExJsgxwMF+6iCidY+CYAL07y5zehWMVZDuUuP6T0YNMh3u/?=
 =?us-ascii?Q?b2RCItPrECPDdiBJMp4DLpWgdCCqlFEFUfQbgLn/aKxhv2eWCUN0Bsc8FDu0?=
 =?us-ascii?Q?4WS17oHtniQUoj3PuV4fyhv7vf045DjDFR4Jo5lwxUvDss9ylDuRh/+F2wGO?=
 =?us-ascii?Q?IG9VI52ijj1ucL/XqzJIt8BjK5gr4oYtkH8tpLQ4U4NRY3SdX62gVXsLfdG9?=
 =?us-ascii?Q?RxOMqtAbZjCBHCtPvenvjbS8NrSVNCmW1EPYmSVvH4fs89HP0R1rWJDwkL1e?=
 =?us-ascii?Q?DmntxXkZErxWPAgjCsDU+uSJfqbipJXiDK5eyhIrHjyyB3wsq58IWolhn8iB?=
 =?us-ascii?Q?7wIVFONVJqIKvnEVP4m/FjXAqSpssOfb13as2O5P6TbIJBP09d4V5C/XcOPt?=
 =?us-ascii?Q?8gbJi2B/hNhkwYQGwZc4BlgNdfUHnR9354mI+1c/AVpbtlcF9+MyOKYp2W9a?=
 =?us-ascii?Q?Li/iKLXOeWxXZpwIDAja7wBz3Q5xUXxsxrVz7+P3xywdt4ZZSuMf8YbE2cfq?=
 =?us-ascii?Q?MisuiwKXw1iEnI5rXbcUHsXumqVjfyx7vEYIlEf15++5RzcVJSsUyCj4L34u?=
 =?us-ascii?Q?2jk9rO5JMBnWteG91znUKXEqj+ptatc16rp/+hfU3iDQtNYJeDD2uQC7gWWU?=
 =?us-ascii?Q?J1ed7tBJVB3QDcUoOOmrAg6I7Pr8eKTnqg7/BP0bBNXV+NXXgyKYXIQCUtu4?=
 =?us-ascii?Q?CAJ605LnubKhNEEEtxphxXc3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7553798E87FAF47A097E2515F2168F8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2954bfe0-1f08-46a6-7ac3-08d96964e473
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 14:13:49.8233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u4EJwR6ucA2lxkSOUYnv87UnJ/gItHQcycbhw1yKMkSDpZCcycx6lVkD0FXAjVvZhMnFrW+maS56LrnnCiK5gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4464
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10089 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270089
X-Proofpoint-ORIG-GUID: HqXOiqMuvEvEMrt1NZHMesOGKrXstKZc
X-Proofpoint-GUID: HqXOiqMuvEvEMrt1NZHMesOGKrXstKZc
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Aug 27, 2021, at 3:14 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> Subject: [PATCH] SUNRPC: don't pause on incomplete allocation
>=20
> alloc_pages_bulk_array() attempts to allocate at least one page based on
> the provided pages, and then opportunistically allocates more if that
> can be done without dropping the spinlock.
>=20
> So if it returns fewer than requested, that could just mean that it
> needed to drop the lock.  In that case, try again immediately.
>=20
> Only pause for a time if no progress could be made.

The case I was worried about was "no pages available on the
pcplist", in which case, alloc_pages_bulk_array() resorts
to calling __alloc_pages() and returns only one new page.

"No progess" would mean even __alloc_pages() failed.

So this patch would behave essentially like the
pre-alloc_pages_bulk_array() code: call alloc_page() for
each empty struct_page in the array without pausing. That
seems correct to me.


I would add

Fixes: f6e70aab9dfe ("SUNRPC: refresh rq_pages using a bulk page allocator"=
)


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> net/sunrpc/svc_xprt.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index d66a8e44a1ae..99268dd95519 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -662,7 +662,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
> {
> 	struct svc_serv *serv =3D rqstp->rq_server;
> 	struct xdr_buf *arg =3D &rqstp->rq_arg;
> -	unsigned long pages, filled;
> +	unsigned long pages, filled, prev;
>=20
> 	pages =3D (serv->sv_max_mesg + 2 * PAGE_SIZE) >> PAGE_SHIFT;
> 	if (pages > RPCSVC_MAXPAGES) {
> @@ -672,11 +672,14 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
> 		pages =3D RPCSVC_MAXPAGES;
> 	}
>=20
> -	for (;;) {
> +	for (prev =3D 0;; prev =3D filled) {
> 		filled =3D alloc_pages_bulk_array(GFP_KERNEL, pages,
> 						rqstp->rq_pages);
> 		if (filled =3D=3D pages)
> 			break;
> +		if (filled > prev)
> +			/* Made progress, don't sleep yet */
> +			continue;
>=20
> 		set_current_state(TASK_INTERRUPTIBLE);
> 		if (signalled() || kthread_should_stop()) {

--
Chuck Lever



