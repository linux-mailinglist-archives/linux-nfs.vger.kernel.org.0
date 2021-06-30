Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A883B8712
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 18:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhF3QbX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 12:31:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33332 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhF3QbW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 12:31:22 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UFpDBR026939;
        Wed, 30 Jun 2021 16:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Ple9x7fn2GKeMPKf3+uSPlCBWW2aECfaaTvaF8ubA0g=;
 b=MYnkPkXd8JvrZw4uJISjWf1ypetQswtaMKoCquJ+dWnGRFnsP8KsnutfsAfUVgW9jcfU
 PjVOL1o3XfTgVMLVrjGMKupCaiCzOmQ/UdFWw6zJnlV8RaWn8I8GY4sbrplcz8MeWzYD
 IlkzGIZWAKMf9lGHmKsj8DeQyFSyJvlVkNnJTfh+rQ/kuHKA8FGClXsnuwcXm2Rvl1qo
 vzFhC9DKf6Xij0EZd0AD4N0gwiH2jx/4JekEpsb6TVBYikIhABJdHfZkaKai9JjI47xN
 Z/DByRZTnVkOhOEMU2l1bML5oon/NpY/D/YVUCTnoE0eSmI5PdginKb0lQJMzfmZAjGq tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39grmarjn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 16:28:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15UFo70b179893;
        Wed, 30 Jun 2021 16:28:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 39dt9hem7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 16:28:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOW3/i/OP7s5QZ9hK3nRgA6Nk9kMLBqUUfgwXhPk9QovIzyUJWGCHy8q3Ugm6c/756s3wWpy7rxG5EDoeX1wXaNuOQMzhMJfepCAnExbMKfn2vs4K6gHSaslhlNSSogwJziEMqqRVQEtNL/XZHijWdM3fgjTTFUCGxb/q+eMETCxjSCpEnRDI8Z3nPP9xURhRQrAVQYM1Z56TL9rCpsFdUaveMzWOoj4/ZlC3xhKTY0s1r9qqpoi/I9mX+CPaWfm06Atm74Vq4GxcCO6Q+eMx3Ox1zldR0jC9BjpQaPMEkzJ9b1xl43MW3G/WTOfyyt8ICpJndAhsxpP+gmQXSN+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ple9x7fn2GKeMPKf3+uSPlCBWW2aECfaaTvaF8ubA0g=;
 b=H7mDBrfhWgZhcfS7783HnMM3wqK4ohqQZe1BqDZXIcunzgmsBBnKxZfVDpiUcEq9QMOHMgmUEC1uKeSnx49GKPasV9IOtCLk+d/4BZlAL1mazBVdAQEZFNRlNvpMDCoIZ02TMoVFSNilgHO0+1vEG3XOFxC6eyIkMlvKir3SPvk0b//MRPdzQnTCOuARRFr39CfsuJfFuVRImdQZmWs3fWDW8nX/WP2SNKzGxloUzRLHLznIqlfaIuYWBml0TQwnp1sG8OW2aXSwCDb8+02fJcz+if/mzF8vuC6WuhwxhoPfXI77E7nnckQ3tJdfMVUuk2IpEdHSs1hoeADNpOG/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ple9x7fn2GKeMPKf3+uSPlCBWW2aECfaaTvaF8ubA0g=;
 b=omegoD1hDQKR9TM87c4v1aBh5WjCMBxoR2txA4eknVk744BhwqnG16KOb87NynUtoz9x5unDaO5qiYu3cufrdYLpmfKPToaAfO57uFhe1xoI8GeZXWDjGRqgiydjLuE7SgG3wQX9NNWwdt/pOt0TSLBmJIVBYOe1nC7GZCT7Ba4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4275.namprd10.prod.outlook.com (2603:10b6:a03:210::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 16:28:47 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%9]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 16:28:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: 5.13 NFSD: completely broken?
Thread-Topic: 5.13 NFSD: completely broken?
Thread-Index: AQHXbcgaFJnLmMlpmEOPdhWd8pFOCasstRGAgAAC7ACAAAZyAA==
Date:   Wed, 30 Jun 2021 16:28:47 +0000
Message-ID: <EEA82A83-433C-49C2-BD70-BBAE98961705@oracle.com>
References: <20210630155325.GD22278@shell.armlinux.org.uk>
 <1BF34FA4-EC1A-405D-AA8B-217BF94DA219@oracle.com>
 <20210630160542.GD20229@fieldses.org>
In-Reply-To: <20210630160542.GD20229@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b73e0b3a-b7e3-42f6-96a3-08d93be42337
x-ms-traffictypediagnostic: BY5PR10MB4275:
x-microsoft-antispam-prvs: <BY5PR10MB427541482DD1A75A5519D3CC93019@BY5PR10MB4275.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u/EvTjCxEVLVMVWzwqy7ySginYwmJZaNat70Fg1tQF/GwuSf4MOYJ8hLmEUv0/p4Difm14T8A88XDcK98MSsZ5LXNGnYEdMfCID1kbSqpELdZ2ypGDBNiZVDbRTs4KZNimOv+YZJIFNUnPfwUpdPByaThaCzO+lyia0AOSCO7aE2ZnG4dOTTzrwVCbvMlaOUGcSMuYfts8yMNgwl3UoyFvA69M+XwAUMUcFZKOqniwL+aNYJLfBhJ45h0vTE/rrNS/3wwRaEBpNn49I/JJHGpWG3HKqxjgcZoKaLYe9GWC82iebgK/bjCICkVIntWKkM8mOHwvX4sXHa8Py2EAR2zBA34tGP3QrqY8LxNcEMKoMIUNT7WfBlguPO345RfpoxG4vXE+D9yu/wsc9TLKUeikNxQlraG//Ur+nd/muTBdxzEcfqQgzgxa+isEPptR5iKu1huglCVAfbPFr/Oph9Z1eOQYfLCOZ9fbC1TKIGXgtRu/8V+lf5AJVi1G6ToNkM9dkCmS8SCvydO20owvQJ8dKKbONCi8HWd8bWL23+HLfMl+OHPwmJdzNvFKHewI6PAqh3r7Xu1dVCU5du5MTZa/4pUlTRg54Uyzs2Ud9hBnHMzTehm76xoZtdIPbFFJztA54VFiTRZPW+9jt523SOmCopzC+IJimdBJHU40BJRSICWbGXutgzBwiUtBj5YS8EixlZ4AEL1qzGQKBFeRDE+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(39860400002)(396003)(376002)(2906002)(53546011)(86362001)(6506007)(8676002)(54906003)(2616005)(316002)(26005)(4326008)(36756003)(8936002)(478600001)(5660300002)(6486002)(76116006)(91956017)(122000001)(71200400001)(66446008)(64756008)(66946007)(38100700002)(66556008)(83380400001)(6512007)(66476007)(186003)(6916009)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mu+g0uxqWSdzqdGh+0NY74hLRAGgWJmbk0R+RbxE9icw1+oKodlW9cXUkI5o?=
 =?us-ascii?Q?oGNFf/pfHD3KUWZ5lJ5UmLty72SEdSjR2Kd+zuZdUsBDszGGvWccZQn1w8H5?=
 =?us-ascii?Q?b4eri7cR+fusMHkEVvlO1+orxPyVMk1rh8mBGVT5Ae+tmboegCefwtQW7VCP?=
 =?us-ascii?Q?VnYqValtCS1mCKPlFxXwailOatfweE0W82ef9AnHTMlxGms9OMGNv8tkRllG?=
 =?us-ascii?Q?I042PC1iizIMoDZFE0aGURi6wlCb828Wtt+GQtffzYL1rIFzKkLCAJmrW31A?=
 =?us-ascii?Q?hZtUOlQsT1yoPttFtSFthq0N7Q+ZFGmF7o2LeBhJPCMugR45wCuDDALaQtix?=
 =?us-ascii?Q?e9ThiuUZ481fXymdxPOocV/szb3tRx6BOX61XpvuLAKi/HpQONha9jL0racI?=
 =?us-ascii?Q?gS2+DhOJY7VuMKk0p6ZMMR4fDPTf5Y9yq7cwVaiB2u/h+wEZee+LrBzM8QYt?=
 =?us-ascii?Q?Q2BpfF+CgIhL3h7URQsDJz3+OCV5xHx0R39USAvuihRkTbLLqS2Sf1n3MIuT?=
 =?us-ascii?Q?MDZ7OIl2rBhjR9uOJPuQbJ4yVwkNDPzqyZVdAFl7rAw6jWJeSUsuoWJijIlM?=
 =?us-ascii?Q?7tCKnnE61XPy9JVskIGikSSctY4qq7JUPDHhuq7F/7AjXc+yTvKQGjsBA3xM?=
 =?us-ascii?Q?+rycbO3REtY4ZipbVbvcw3TFioB51zMHYS2vWlMXb8Ik/L7jumeH7gYA+tSM?=
 =?us-ascii?Q?vkJmWI8w+Pc+ChYxVYToAbczKyLltkHsiBl+E5B+5c5W7cLNfGesCbivsqzf?=
 =?us-ascii?Q?e/NZBQQ2xB8S08P/lR+Bu7MgfhLMZIRkhpBMILrsmKtjt6uI2N4hJQK2IW1H?=
 =?us-ascii?Q?JDtrlr+TNH68uh2kf0u9sj613rGlblBrP/S5MwS7GTmzbVNr6/0btVSSGJ/p?=
 =?us-ascii?Q?3aA09VtkNV4flE8cNBr9o0yV5/99/iMxxYLtlSysi9ckoDxBApDKdfSrwN/A?=
 =?us-ascii?Q?P9uA8+D8WtZJvm5HOgYgfv275u5Zaew7BG3dY/pLSA8HVvQVbLeqcxPpdq41?=
 =?us-ascii?Q?VqSmwqK8DTcnjoksC2tds9+4UGG+zoQ/XF1GwBg14O7B2mUg1J44Ijyi1dIo?=
 =?us-ascii?Q?4DBzJSRIP3ak7vHQYTsseZUGOafppRs12BY07n5l7I+HxJjkiJ0L/Bxe1Lzt?=
 =?us-ascii?Q?j1GdnXPbMInLyysHK7oy2A6idTkazcerczcbL3mOHnB16V7wouLvl+y87p3r?=
 =?us-ascii?Q?QJO27ASL8m4M2CZ1wkkwUkphg+rFT1adbkktOkZV2rjb2vRvZtKx82kkk7cG?=
 =?us-ascii?Q?oZLRIhbdsEn4IqO62EzM5kalZyWQQa+A+jeA8vImZf91RehcfC84s7I7Bs+/?=
 =?us-ascii?Q?rd+qOh3Uhyu5Hyt/4f847qva?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <94321C775CC0074F84740E5AD7A97560@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73e0b3a-b7e3-42f6-96a3-08d93be42337
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 16:28:47.7281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dgidqVwUD/IXzk+BNug96sHphd0UpWvq0T/KTDhBzrBSFWkno96ln+yqPItDca1jP2rQHcOHKvqiM1OvBRzusg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4275
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10031 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300094
X-Proofpoint-GUID: tucwZaPjlADWD1Ikn_bNKCw6M4lRfZR8
X-Proofpoint-ORIG-GUID: tucwZaPjlADWD1Ikn_bNKCw6M4lRfZR8
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 30, 2021, at 12:05 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Wed, Jun 30, 2021 at 03:55:16PM +0000, Chuck Lever III wrote:
>>> On Jun 30, 2021, at 11:53 AM, Russell King (Oracle) <linux@armlinux.org=
.uk> wrote:
>>> Has 5.13 been tested with nfsv3 ?
>>>=20
>>> Any ideas what's going on?
>>=20
>> Yes, fortunately!
>>=20
>> Have a look at commit 66d9282523b for a one-liner fix, it should apply
>> cleanly to v5.13.
>=20
> So was this a freak event or do we need some process change?

I would say that it is "Somewhat freaky".

In the future we expect there to be more consumers of the
bulk page allocator, so this kind of thing should become
less likely over time.


> Looks like the problem commit went in 3 days before 5.13.  It was an mm
> commit so they're probably not set up to do nfsd testing, but nfsd is
> the only user of that function, right?

NFSD is one of two consumers of that function. The other
is __page_pool_alloc_pages_slow().

The author of __page_pool_alloc_pages_slow() was cc'd on
the broken fix, but I was not. I was cc'd on earlier
traffic regarding the new API because I instigated its
inclusion into the mainline kernel on behalf of NFSD.

Mel does indeed have the ability to test NFSD, and has
been careful in the past about testing before committing.


> It says it fixed a bug that could result in writing past the end of an
> array, so made sense that it was urgent.

No, a prior commit, b08e50dd6448 ("mm/page_alloc:
__alloc_pages_bulk(): do bounds check before accessing
array"), fixed that particular bug. The broken patch
fixed a page leak in the same use case.

I tested the new API with NFSD extensively, and did not
notice page leaks or array overruns (although, rq_pages
has an extra element at the end for other reasons).

NFSD does feed full arrays to alloc_pages_bulk_array()
quite often with RDMA, so I think I would have noticed
something. With TCP I think there is at least one missing
page per call, so the common case wouldn't have triggered
this bug at all.

__page_pool_alloc_pages_slow() always passes in an empty
array, so it also would never have hit this bug.

The problem was discovered by static analysis, not a
crash report. IMO the fix should have waited for testing
and review by the NFS community. This close to a final
release, the fixes for the array overrun and page leak
could have gone into v5.13.1. I hope automation will
take care of all of this very soon.


--
Chuck Lever



