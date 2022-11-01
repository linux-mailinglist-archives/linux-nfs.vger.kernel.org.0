Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A0B61520C
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 20:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiKATNq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 15:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKATNm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 15:13:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383921EAE9
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 12:13:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1Ina3c016606;
        Tue, 1 Nov 2022 19:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ir4EjMdaubPbbbJTsW9XoNwF+U4UeZlpdy0CavFCG6c=;
 b=ewlQEodgTvZ1tCdkrhege6hszMVuz7QlmzMPiCBajzv6MfXgtxwofvLwUS/fYC1gVP1v
 gEKSLs6fEgO4ijab8ZZ5lMMZrx9NuyIBrHF9EQFF/lZZ2JAxGpsGDl8EK/nFF4i6Z3ml
 ru35bAkCY2MCZhVUKc8cJKR19K6BPzdrsYZepGqZSidaCmGU+Q1iAtOy3MZ3hz4pfoTQ
 DT98JZyLery5cYniV+VudgqoHyO2RKEbjdTh+/GrcwKVzCtz9Np0wNt4YLjFBVkbVbXv
 vuEuAr94OftwwsdOXRWWbx02uaPJ0mAUIjCzN+yWEa+qzk5iMh8No1g5DWiku9afYJyo 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgussqmdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 19:13:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1Hft6a013957;
        Tue, 1 Nov 2022 19:13:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm4rn05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 19:13:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8Lwgr+0Y02jlDTS1yPkMSIHvD4hCl9R7XbS5dovMxK+V6vqw2qEkCTygmpMMYVSQRPljbfBH/aRPex7CtY3tf9m7K7Wp0ncNxoX35VR+NVXLvffEWVj1T5xdX7roYWBnzf/ZlV0am+PEC+RB9Rt6b51hhX+nlJaf07aLOknq6TMLlOAkP5onV79dIW10n4FVEUsH69vx6x/r0r7YLh7xOxEBAW5uWjat2c3bMir9kLBzxH6iB6Oa9pT1Vufk2QPI6zdfpGYjA/D7ZITQC/6Se70oTPBsivUph3VhIDzgNZyu0vFW1gwxa5i9KsiVKqzqG1XBYW8mARgFf4ChQxAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ir4EjMdaubPbbbJTsW9XoNwF+U4UeZlpdy0CavFCG6c=;
 b=MMCKD6/DMGx4SKZsWKeswcuDCLfUw6f8U4OrDG1wenF/Uo9CZfsNVFfSDfJSWI7eOiIC2g7VSLqLI/gxD7iDVBhU6eXKbGIhhzLJ1FuCun57fH3ae7mxgukfstrDtLOH5FZpUCpCDV4d2XEZqZgrw69lv9NCqOaH5jon8eHmYsZj+ghYHt/p7KJfnmdwrm9UzDOWk+Y6i/SxhZYGOBcmZ+b+IKIbggT1a0WQyTGXN9KyGRJyRfC11nJlcJZpgd+X/9lr/Q8wmZ9dXm9CmXVb9RU8zZlBGjfU/9+J4KvP/Ssoua0EqCb2Dh5Cia1cXYMuPYnMDxEdwi+06ZLZXjLxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ir4EjMdaubPbbbJTsW9XoNwF+U4UeZlpdy0CavFCG6c=;
 b=i5qSX+VaXG8YvTMsvKRJQIHSpZ4Px3AOMOYqLxI6xSVPpLdbxs7JoDaNBg01Nw4AZSYelYnZwGB5KCfTmDToHgG8pczpRX6Bs4Wjdy9CSywUZYMRC+J051GyXslHCZk9seNJhxyE9pO1V64BVOQ+tE7DZmUEvBu41hYd141tC3I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6706.namprd10.prod.outlook.com (2603:10b6:930:92::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 19:13:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 19:13:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Thread-Topic: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Thread-Index: AQHY7gDKf+UJMCSoA0e+WwOAy53hT64qUesAgAAKjQCAAA8pgIAABGKA
Date:   Tue, 1 Nov 2022 19:13:23 +0000
Message-ID: <0B609D3B-955F-4F15-9EDD-16B98087EF06@oracle.com>
References: <20221101144647.136696-1-jlayton@kernel.org>
 <20221101144647.136696-4-jlayton@kernel.org>
 <42F8EAC1-7383-4B98-BAD1-D676950718E0@oracle.com>
 <17bf0292cbd63b6bb13f6595b5d82c2a173b3ee4.camel@kernel.org>
 <53599736e1733bd011325170a269e9adda2f2de1.camel@kernel.org>
In-Reply-To: <53599736e1733bd011325170a269e9adda2f2de1.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6706:EE_
x-ms-office365-filtering-correlation-id: d1bff9b2-f5f9-4177-cf3d-08dabc3d25ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tE1jEiQGezrUWbhSELDAm9/4Jisze3FAAHHiC/kStZEMQ7pk3qy3yiqFYK247PPzlIjSLmEt8ZXss1Rw/T0BmCbzNulORGlkfZ9WIcJoy01Pp5YAVBwlvkTNM42kMdAbljTUMckNXN5Msv0cOC79TMScZF+11G8RJ6fXpSSmdWr6NAnB6zjPXRVOgbaimjMHBAPzIBl4pb5ixmR+DeRax7qj+yfmD6r2syoP3rgHqVtMIYd9vQZ+BHtEbRtdNUZIIlKpGqoGW/l7cL9PdfoE+FEX6Jw5rw/0qJ3XJ1oe6XVbQfkjvoXK1XSX8/JPAXtYupxZlwxwIiZq+5E36qiGjXioqHDfpMk/wlniq7U6ApA/JpCbXVYcY++PWsGPZg4RBDcL0X4VhUNlMRwF1u9hdN7sm4rJYVdvULNe0PGwPHf5T28ft1RxIl4jv2/O+ULJHXwm7AU/9nJOZi3o+UFQ4w0f7jZn6p7Y8M//VuFx3WPhAJz8XGBrSgfFg75SyyzUlRcPURb9zL/oM11CB+ysWe7gSDe9ifBNEvktpPz/TOc5YadiLLjPo5V2Oyre+nhfjjpo4ziT5c2ogNKIROkdsy1mrWtwSkD5ONDrBU5UnBKccZnIFF8Q8LwvJromXRKiJ3fV3plBWukLlPnripEtzJelc1acO2TxkqMeyEGo8SN4pN/EMH6TVs6gsJGWDrNZhBzz6bPAQ0jONyHxNaIQSiYW1Sk6aRpBfXh28qvqpUOZQIZnDfvAzkXQKQ+Zg0Jb45ImekNDR/GujmxYAvVnx0DIIKA8XLZHnhwtazEzBH4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199015)(6512007)(66476007)(71200400001)(8936002)(2906002)(316002)(66946007)(26005)(38100700002)(76116006)(54906003)(5660300002)(66556008)(33656002)(91956017)(8676002)(66446008)(186003)(478600001)(41300700001)(2616005)(83380400001)(86362001)(6486002)(6916009)(53546011)(6506007)(38070700005)(64756008)(4326008)(122000001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1hNzXEg71tWu7h9UY52KSijGz++D/lBgCh0P3cDQc9oX6kDRQY/WJKj0vlR/?=
 =?us-ascii?Q?Q5jeGxWZC4LdAUD3ORJ77TA2VBHnR89paoKRqBPFMghcqRlsInzwSQs+VMhR?=
 =?us-ascii?Q?zaz7CysxqkXRvRNk0Iy7fVvK/kbKFfrSYyQV8fUHFDhpWgJr0aqhXVcyMgRC?=
 =?us-ascii?Q?oGZDOAo0oa45RYfIvLj+KdFVi39y/G2uyOvDXQ/AO6Gv7cY+FdyOYYjaaV7U?=
 =?us-ascii?Q?267NzZkRezBOXCLkJf4zqzpJDhh+bbyLnqNPZca4z5LON0TLH64+eSWhKhPB?=
 =?us-ascii?Q?ko+CZbBkIUY6A16kKJoEI9FcH4DODaRfMsV+ThPpNCrUHjpC01UdrliXJTIj?=
 =?us-ascii?Q?HMoYU/yFbbg/btbCUwOsDzcj3egtYGELegY60CR6Tk+SJoNghcltZbfWr5B+?=
 =?us-ascii?Q?/2ZURB7+1YJRxz7wwtGYFzmE2noF6QH/wlqKmlvJ96IxGlj6xSSFwKrUd69Y?=
 =?us-ascii?Q?EnpTs4wAQXJbcQfwjtXLwBv3VETaWqt1MEBjZzk6+vh4Lkpba9MvFMFlvTYi?=
 =?us-ascii?Q?InKPnoc+SxaRJ2mhtHno9iBCzmZWdduuiYcetQarQ4UYDF5rGcnvweCuifNl?=
 =?us-ascii?Q?LGtfZZdpZ6pR/5b0vhB1qgXzx/+FQn5Po/hDzKpjxNXIJj1OfRi4Kub5f3oc?=
 =?us-ascii?Q?xBZC3+yl97Oc0K1R3ZU/p0+X2o4aObfByzMTr7rdI7wtD+0ER2GAz4dmbKgd?=
 =?us-ascii?Q?hunBeZOeykd0RBeBX8dUc13eN8ws7JZTktJVRXkxhCwe6Uz1I0WBfdreW4RN?=
 =?us-ascii?Q?M6MNjgXnILu3BQQCaWUiyHbn/YFADKYmgzPqlY+dC48kYW48VEmq+kIg2N0t?=
 =?us-ascii?Q?6nUvwuNJ/gclCIi9TDTDzieUXtUhkk6VIPt0kfc8zzURSkPNVZAXbpeLP4C7?=
 =?us-ascii?Q?JGBToBQNbQzxpqfRdDXyOssjt304YrQbJBgtN3OXvd2o+osCKxascz3QjXTZ?=
 =?us-ascii?Q?7+AURMPT6Rdy2eSJPRRK9QE2R6MLAWT+ZvmlrtbAWKedW4lZbfHC5UsY1GWO?=
 =?us-ascii?Q?fxHX5u6wbGzrxgpdoQpWy5OOmuKLrRWkh6i3N/IbXCzMj3tglgerkxs4zFoa?=
 =?us-ascii?Q?1GrEC4brOxuyNo5SVTarNt+6yoQ2WS54g5nmbkRQqyJOCEk2WrwCZwS27QbN?=
 =?us-ascii?Q?jSriy0rIwgtP5jVe0F/uL04dOyKYci1PXQrQaurQmGmpLgSjpp7lBedgUay4?=
 =?us-ascii?Q?UNhvKvx4c83bdmVIL8HugVHgrz2fzUbFb3KQORvumg3VAJOwdSgvn8njbjw7?=
 =?us-ascii?Q?w7WD7fgeO8imsTxbDyxth9kJy2wL6riAlnoianMotejUaop1e1DHk02vsCdI?=
 =?us-ascii?Q?SpVmry75u/fDgPEHz8K6fj2VpRzdbObDQnEU/CqBa+SQZIlQJkpA//j/RbP8?=
 =?us-ascii?Q?0Qcg3Is1zKHYIYK3O6ttU4PbJ0gOSarJmFALvaVT7PwoypvW05hjHAn2tjua?=
 =?us-ascii?Q?kOM+V4UUKIli2Ll2XpUXp0kgmud0XnYBGnOZZOc3OmgQMMwcLV1z+KN3nwNp?=
 =?us-ascii?Q?PtHEGL6/+lLaNjVROAp4hgEjlQL4QTHctTezQxyh+X1sUFMQx4hzmiAKnZSN?=
 =?us-ascii?Q?lRUkMZ0JO9jcy/1JYiPhpDRb2pZBhnQwJq3zXPRVfaOX/tZYnh6HBytj8fnr?=
 =?us-ascii?Q?rA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D921C6CBF48E714F95ADA007C424F7EA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bff9b2-f5f9-4177-cf3d-08dabc3d25ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 19:13:23.6961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +zkl2tEcX2WNSNLreuYuZozzsfOMsTo7+2PqP/UrT66DPxZE3E13enwv3dwrGNXnYsy2zKHg4H5OGMiI9UXPoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_09,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010139
X-Proofpoint-ORIG-GUID: p-G6q_SWrWfPMJvY4L9Fwh8bCPSvYj5F
X-Proofpoint-GUID: p-G6q_SWrWfPMJvY4L9Fwh8bCPSvYj5F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 1, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2022-11-01 at 14:03 -0400, Jeff Layton wrote:
>> On Tue, 2022-11-01 at 17:25 +0000, Chuck Lever III wrote:
>>>=20
>>>=20
>>> Test results:
>>>=20
>>> When I run my test I "watch cat /proc/fs/nfsd/filecache". The
>>> workload is 12-thread "untar git && make git && make test" on
>>> NFSv3. It's showing worse eviction behavior than the current
>>> code.
>>>=20
>>=20
>> What do you mean by "worse" here?
>>=20
>>> Basically all cached items appear to be immediately placed on
>>> the LRU. Do you expect this behavior change? We want to keep
>>> the LRU as short as possible; but maybe the LRU callback is
>>> stopping after a few items, so it might not matter.
>>>=20
>>=20
>> Could be. I'm not sure how that works.
>>=20
>=20
> Looking more at the old LRU code, I'm not sure we can make a direct
> comparison on behavior. I think that the old code was just broken, and
> that it inappropriately took entries off the list when it shouldn't
> have. That mostly worked out in the end, but I don't think the lifetime
> of those entries was what was wanted or expected.
>=20
> With the new code, it's much more clear. The only entries on the LRU are
> GC entries with no active references. Once nfsd_file_do_acquire is
> called, the entry comes off the LRU.

The new mechanism is not working the way you might have intended. I see
the "total" and "LRU" numbers equaling each other throughout the test
run, which is a sign the LRU is not working correctly. What you said
here suggests that the "LRU" number is supposed to be less than the
total number of cached items, and that's the way the old code behaved.


> I don't see how we can make the LRU any shorter.

I'll dig into it and see what's going on.


--
Chuck Lever



