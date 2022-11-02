Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3967E616C1F
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Nov 2022 19:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKBS3v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Nov 2022 14:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKBS3t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Nov 2022 14:29:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E495B116C
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 11:29:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2HT6ce013636;
        Wed, 2 Nov 2022 18:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SPf0YMVbxkyJGp15QtHvc+0R11pADnqmvWiBmsHYdA8=;
 b=nJTqJ2zFUnXiaNbwM063EVEVpk+bgDmqrxx/0FmmCE89dqpH6dP5IK7WXYsSNFjH5MqN
 liXhsWQqkSMyxGgDhxaUXX431SZquoVqXwI0Dp89Aa1tFzyyxeMCynM0Lq9tjqvpmJcT
 E5uxFjqAjIZQnJhTMkEhZL59TruHbixoUJ9wdGqbLk4cUUkmfcI1Oahhw+ghvfiLvOAf
 ZkC9O5ie/nUD1ajsskUr02qINJeVxwdvrV36fcOTeW2FFY2ndIc0etzLv1QpBJNZxYwV
 VTO0tS1TL4VT9ua+JwOXnlYy9352FrmFZ9G6X4grcJOq08onJjQ/0/QzTLsSi45Ew5OR PQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkda64u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 18:29:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2IIIR7029706;
        Wed, 2 Nov 2022 18:29:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm5te1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 18:29:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlAS/bpsQlBUgyWqdMd6709MAFxaKXARJt0XP6GlV0SsLKnqrHfJrxVbStZiqwlVl50aH37/jvLfw3H+x+iNd20RW7CwlYUWlFHzJ8nIyIDLZ7Kdj3a61+vSej69YpIto4eqJ0Zwgwkl1FigWApJia4ZxLzgg4uBPus60IczX/E1PeTUJ1xkm85XrljJirsyg9FlVDBSPbMOqlziyKuKfnFHp8sF9JbSQGTTGzgaRvRRBueq5Qm3dzE7xU+6vIqzhpx3d9BdWowxW1loEeMi95JaTfxlMSN5O1WeKy5FBvOQtO929EhvQmxpz/QHt/kQxOhoymXNMoSViG2/TdHQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPf0YMVbxkyJGp15QtHvc+0R11pADnqmvWiBmsHYdA8=;
 b=JLNJ0sxBFemT/liJ+cz98gSK4UDUecGwLoVOTyLh6e2JECqJeFUklBoj5lsWi/46fAD0BKX7BY0p+FqxzMNDGp+ExZhmYeHpnfte/qUiTa3gh3HMZbmr0ND0jdWEkikSnPHs1R7LOto63BIoIl1eSifJ9EOrcWXWc7cRB0/64j6GIxUP04jnR0uhzGC1ybZcKRhrO95298tDcWtb3R4efFdd5j6o3p/FQK+BNgenekozmCL0SZDFcfKfjJ6d59CQIpOcrwBOjd1/ePg36mT+QQvdhCrYtQ21UmxQCeZuQ7KO+X35lD0fpvPrpLDmczQ1xz87+1gZ8frkt+hFpDe3MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPf0YMVbxkyJGp15QtHvc+0R11pADnqmvWiBmsHYdA8=;
 b=EXpb40F0Rz7go/UeK+iDoNJpwooEQkbSvTiGG3A4AJZJoGD62JoHFC68RS2Ustok2g9ZR4L09IBfS9R7kNLOEDtAsSnY7EXj37iIO19JV4vCe1076iIUZ9FBnV80+uQHRGeCuJeQzA6EZyc5i70LkcTdykpbI94d/fw+BBf7WKo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5176.namprd10.prod.outlook.com (2603:10b6:408:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 18:29:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 18:29:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Thread-Topic: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Thread-Index: AQHY7gDKf+UJMCSoA0e+WwOAy53hT64qlIAAgAAEOACAAAdXgIAACmQAgAEyK4CAABNLAIAABjeA
Date:   Wed, 2 Nov 2022 18:29:40 +0000
Message-ID: <63DD8573-0510-4892-82F7-191D0A5BC57D@oracle.com>
References: <20221101144647.136696-1-jlayton@kernel.org>
 <20221101144647.136696-4-jlayton@kernel.org>
 <166733783854.19313.2332783814411405159@noble.neil.brown.name>
 <bb8a4e623371ad4ac9d49f2cbe0d4880e8ba52ef.camel@kernel.org>
 <166734032156.19313.13594422911305212646@noble.neil.brown.name>
 <4ed166accb2fd4a1aa6e4013ca7639bc2e610e37.camel@kernel.org>
 <db00762c5e0b983c72bee2c6bfa4476b2090a942.camel@kernel.org>
 <4E9232A2-E4C0-4877-96B1-5D745085BB05@oracle.com>
In-Reply-To: <4E9232A2-E4C0-4877-96B1-5D745085BB05@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5176:EE_
x-ms-office365-filtering-correlation-id: 940c8933-5cd8-4c3f-afe6-08dabd003445
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5c6lZuTUXlwl/dxf45U2GZK6bIt2Q00TSPA0RYCpsj6qYZvabWdmfooc9u5CosP+1lgC13AV1194AQMj5NMfdECtqR41h+RSy4QgnREtH5sgbrhzdE69KtM+ssOQU+skcAryGEwLx7MQ7YQYEHe3So01ED8uxwH4qkCqgbjyta0CPavFcDPn5XyUYP5HMYq+WWeJBG0IOm1nUFUbxU74kc8NZoBxRTtA/etbwpi7CQZvntHwZCSV6j28/1fvJ2kWdCnGYv8lVslNyQuAE1L4oM8UpMwuL9Z83nBBsULX1W0inlAuJtUMKMpxBqaPlXZ80hnn43SoyD6Yfquv/ohs77AFot61gcTJD7pw27rW9p8Oj7lY5lOs8jRGxPMX9ywOV1kOTmbeCOSTK+NXyMF99kR5ueQFj/YFc4KDySpob9ijIo7pdjWjYcWHgnMdkduJR+6NcOsG/rmRIlvE70QG9uLFtlD15llpr0j3S8i+xYki7qF7y/CKidzCPg+2WNqYEiMVYInaKJ8lAK2IgrDisP0pYo6njTPt8p2zvk/dgZvW5SVSm5Ep5XEvTiT4hMky/PE0gvkKox5ulVDzF+7EwHmpi/aq/sfe8x3Ikq1s90nxFnqFxMSaRhgZYg5L5bMhNLQqhJiHrAjsbDTZtfHxe/Mx99FHm04dtsNPhLiXyaUHoaR6wIkoPxzx+ijuE4DmniLwLSqyyw8LFWaBZl4p4t2z6hKuaYZV7986kvrz6K3o3Bm7HxT3krtstD0eT0xIqmUtXVJRbMi5btOzAjBsO/ZI6iiXTyC6LGoVBW0hOhk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199015)(38070700005)(122000001)(86362001)(36756003)(38100700002)(6512007)(66899015)(8676002)(2906002)(6486002)(71200400001)(33656002)(478600001)(316002)(54906003)(41300700001)(5660300002)(91956017)(6506007)(8936002)(66476007)(6916009)(76116006)(66556008)(66446008)(66946007)(4326008)(186003)(64756008)(53546011)(26005)(2616005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cxHX15GRWbix9RNHtRy14q7dVpB/Rzp8McEmKq8bx1dj4yzd+LX3YeI/WGxK?=
 =?us-ascii?Q?fUD62fAYC6PF2F8yolbEc6vanjtbVpE+1VKx1qTljZy6nVtZqZ7LfaTPbX0w?=
 =?us-ascii?Q?8hxR49kmZcVLXJCTU282d0hdnNYheFvGBYX+XP6Tm010Pf4HXm3X/CiTQoho?=
 =?us-ascii?Q?0TASKmooCBXMqnSAn18U+8ZLT7HD7+VabZR4Yf6iE7VggZRrmKtiF1c930Ec?=
 =?us-ascii?Q?0uRnuvi1M3NaX1EnteWrGc3umbdLgbW2/X8xE/b9wrTbGlyGLkle7pJdFtHp?=
 =?us-ascii?Q?0AKfpNodAB6Hgao1qzH7Ub7FdZbLgpCF5c1Lvy0qma974pG1c/8qZmMitxaf?=
 =?us-ascii?Q?LzLuXMzCcsPNXgnpoTBQRLhS2G6DDPplpAkVF5JZ+o9UgSeQkLCNTDWmvRvK?=
 =?us-ascii?Q?mE75y+faTDTWwsQeRM81MuV2T/4f75y0ExcASVAtq2KT1cfIpUgf2EQBftXG?=
 =?us-ascii?Q?eCaersonLViDblP0+LAgUYQMwgX/7NOS/DSWDVpUjgNavd1zrs5KT6pq0Hpz?=
 =?us-ascii?Q?ggVvIGcVhBtuXXsAaMJWHHNOREF1PPDeIH1xzEZ8RCwCKCLna0+93+eubwvf?=
 =?us-ascii?Q?tW1Bsn9g+cW148cRhkMgwrlicYbWtjDROiF328LbecVVLnexKufcJcF0URBc?=
 =?us-ascii?Q?LRUP50y+5daaMmWInAgiuhOQTISD2fq5skOMcD8Mm3qw95e45AZ7Q7d4ikFY?=
 =?us-ascii?Q?x0k6zOmcV4WGauhKaHlnAEK/3rbU/NhTzJiXd0Y7bhxhe2D9vlb9LxQG/5IS?=
 =?us-ascii?Q?is6DvbkbztnV3MC5xv041IoTliZ+UEx/NHGIr/stgtBl3o1fGXUkzOxjnq/W?=
 =?us-ascii?Q?2iUdJxpwvHkWR+pTWWbLwEzgWLwdyLqoem/VOoPCViJqyTWFPVhzfCqSrjty?=
 =?us-ascii?Q?9JGaefuIt0e1Pbr/rX1v7TYaaI5lUNYz845AH4KUou5gy68DrzJOI6FfU0LF?=
 =?us-ascii?Q?BwDKeDjK5oD7hKmrRBOdiUEhdDeubRQR+9U2CBgOOzBIXvfGFi59sJB3g3N5?=
 =?us-ascii?Q?7xnqJZQP7gwk5IisDvDNAoKykYEEmwLkxWYXr2iVCnyIzVlTwxnr/t6PCktE?=
 =?us-ascii?Q?OWnKBifHceoinIfSaJi5YVSlBGV/lpIRdE18si24OICtHW9YL0NPgwK1SM4X?=
 =?us-ascii?Q?Q2ewz2DOvDjxTFP02XbBbZleohsiSjTLhS8KtW+/B53//0eROsYkOIGxz1LQ?=
 =?us-ascii?Q?t4GGhiKkSNmTf+72P2izW+7P2j/yYVtLLmnzLEZwfm6yYuKQJFxCWdr0oF5z?=
 =?us-ascii?Q?8VK2O93a6KrnFBsyJkJDKW8XKRfQkTgEjdmnuoL3WyOK57kWb/90jh1eXy2j?=
 =?us-ascii?Q?Sr9Q45Q2u6K0CRHFL8IrJukt4JmnHyC3A14h6Y2zFJIyumC6Jo51YWan9m95?=
 =?us-ascii?Q?nZi3Nbu9rO/zlRyCkQqRrPUqBFzCFblocz60P9BO8FqnP6nUAkGDSuRIG4Fb?=
 =?us-ascii?Q?7IUtdkfKX+RM9KmgkC5Lp97sUC9vcxpy9zP7phwESSj8VLuoBznJlBOWibli?=
 =?us-ascii?Q?B0as+9+Rrrd9/FJRC78SqIc2LQXtCsNR3L5M6dmKe10xXNUz/u22MZTUbGv4?=
 =?us-ascii?Q?NV4KZcPQs0NF29txSjztJ5PlyvaG2jcaV8J3gtX8RzkLVKBun/PUSdyXbJ7o?=
 =?us-ascii?Q?vA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0FC11E09980A414CA082047937CB8963@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940c8933-5cd8-4c3f-afe6-08dabd003445
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 18:29:40.0353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TJhwlRcgJJ7moRqJxUxg+xU7mLiB8FpLqzHz9DhR2YDFHKvAkmPfPZtJQ42ILGDKBayvW9dhLzjt+MiLy4GRBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_14,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020120
X-Proofpoint-ORIG-GUID: _y_zZZQPbd8WXhGXU8RL6KPUgM3d6bCs
X-Proofpoint-GUID: _y_zZZQPbd8WXhGXU8RL6KPUgM3d6bCs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 2, 2022, at 2:07 PM, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>=20
>=20
>=20
>> On Nov 2, 2022, at 12:58 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> On Tue, 2022-11-01 at 18:42 -0400, Jeff Layton wrote:
>>> On Wed, 2022-11-02 at 09:05 +1100, NeilBrown wrote:
>>>> On Wed, 02 Nov 2022, Jeff Layton wrote:
>>>>> On Wed, 2022-11-02 at 08:23 +1100, NeilBrown wrote:
>>>>>> On Wed, 02 Nov 2022, Jeff Layton wrote:
>>>>>>> The filecache refcounting is a bit non-standard for something searc=
hable
>>>>>>> by RCU, in that we maintain a sentinel reference while it's hashed.=
 This
>>>>>>> in turn requires that we have to do things differently in the "put"
>>>>>>> depending on whether its hashed, which we believe to have led to ra=
ces.
>>>>>>>=20
>>>>>>> There are other problems in here too. nfsd_file_close_inode_sync ca=
n end
>>>>>>> up freeing an nfsd_file while there are still outstanding reference=
s to
>>>>>>> it, and there are a number of subtle ToC/ToU races.
>>>>>>>=20
>>>>>>> Rework the code so that the refcount is what drives the lifecycle. =
When
>>>>>>> the refcount goes to zero, then unhash and rcu free the object.
>>>>>>>=20
>>>>>>> With this change, the LRU carries a reference. Take special care to
>>>>>>> deal with it when removing an entry from the list.
>>>>>>=20
>>>>>> The refcounting and lru management all look sane here.
>>>>>>=20
>>>>>> You need to have moved the final put (and corresponding fsync) to
>>>>>> different threads.  I think I see you and Chuck discussing that and =
I
>>>>>> have no sense of what is "right".=20
>>>>>>=20
>>>>>=20
>>>>> Yeah, this is a tough call. I get Chuck's reticence.
>>>>>=20
>>>>> One thing we could consider is offloading the SYNC_NONE writeback
>>>>> submission to a workqueue. I'm not sure though whether that's a win -=
-
>>>>> it might just add needless context switches. OTOH, that would make it
>>>>> fairly simple to kick off writeback when the REFERENCED flag is clear=
ed,
>>>>> which would probably be the best time to do it.
>>>>>=20
>>>>> An entry that ends up being harvested by the LRU scanner is going to =
be
>>>>> touched by it at least twice: once to clear the REFERENCED flag, and
>>>>> again ~2s later to reap it.
>>>>>=20
>>>>> If we schedule writeback when we clear the flag then we have a pretty
>>>>> good indication that nothing else is going to be using it (though I
>>>>> think we need to clear REFERENCED even when nfsd_file_check_writeback
>>>>> returns true -- I'll fix that in the coming series).
>>>>>=20
>>>>> In any case, I'd probably like to do that sort of change in a separat=
e
>>>>> series after we get the first part sorted.
>>>>>=20
>>>>>> But it would be nice to explain in
>>>>>> the comment what is being moved and why, so I could then confirm tha=
t
>>>>>> the code matches the intent.
>>>>>>=20
>>>>>=20
>>>>> I'm happy to add comments, but I'm a little unclear on what you're
>>>>> confused by here. It's a bit too big of a patch for me to give a full
>>>>> play-by-play description. Can you elaborate on what you'd like to see=
?
>>>>>=20
>>>>=20
>>>> I don't need blow-by-blow, but all the behavioural changes should at
>>>> least be flagged in the intro, and possibly explained.
>>>> The one I particularly noticed is in nfsd_file_close_inode() which
>>>> previously used nfsd_file_dispose_list() which hands the final close o=
ff
>>>> to nfsd_filecache_wq.
>>>> But this patch now does the final close in-line so an fsnotify event
>>>> might now do the fsync.  I was assuming that was deliberate and wanted
>>>> it to be explained.  But maybe it wasn't deliberate?
>>>>=20
>>>=20
>>> Good catch! That wasn't a deliberate change, or at least I missed the
>>> subtlety that the earlier code attempted to avoid it. fsnotify callback=
s
>>> are run under the srcu_read_lock. I don't think we want to run a fsync
>>> under that if we can at all help it.
>>>=20
>>> What we can probably do is unhash it and dequeue it from the LRU, and
>>> then do a refcount_dec_and_test. If that comes back true, we can then
>>> queue it to the nfsd_fcache_disposal infrastructure to be closed and
>>> freed. I'll have a look at that tomorrow.
>>>=20
>>=20
>> Ok, I looked over the notification handling in here again and there is a
>> bit of a dilemma:
>>=20
>> Neil is correct that we currently just put the reference directly in the
>> notification callback, and if we put the last reference at that point
>> then we could end up waiting on writeback.
>=20
> I expect that for an unlink, that is the common case.
>=20
>=20
>> There are two notification callbacks:
>>=20
>> 1/ fanotify callback to tell us when the link count on a file has gone
>> to 0.
>>=20
>> 2/ the setlease_notifier which is called when someone wants to do a
>> setlease
>>=20
>> ...both are called under the srcu_read_lock(), and they are both fairly
>> similar situations. We call different functions for them today, but we
>> may be OK to unify them since their needs are similar.
>>=20
>> When I originally added these, I made them synchronous because it's best
>> if nfsd can clean up and get out the way quickly when either of these
>> events happen. At that time though, the code didn't call vfs_fsync at
>> all, much less always on the last put.
>>=20
>> We have a couple of options:
>>=20
>> 1/ just continue to do them synchronously: We can sleep under the
>> srcu_read_lock, so we can do both of those synchronously, but blocking
>> it for a long period of time could cause latency issues elsewhere.
>>=20
>> 2/ move them to the delayed freeing infrastructure. That should be fine
>> but we could end doing stuff like silly renaming when someone deletes an
>> open file on an NFS reexport.
>=20
> Isn't the NFS re-export case handled already by nfsd_file_close_inode_syn=
c() ?
> In that case, the fsync / close is done synchronously before the unlink, =
but
> the caller is an nfsd thread, so that should be safe.
>=20
>=20
>> Thoughts? What's the best approach here?
>>=20
>> Maybe we should just leave them synchronous for now, and plan to address
>> this in a later set?
>=20
> I need to collect some experimental evidence, but we shouldn't be adding
> or removing notification calls with your patch set.

That wasn't clear. I meant: as I read it, your current patch set doesn't
add or remove notification calls. Sorry for the unnecessary subjunctive.


> It ought to be safe
> to leave it for a subsequent fix.
>=20
>=20
>>>> The movement of flush_delayed_fput() threw me at first, but I think I
>>>> understand it now - the new code for close_inode_sync is much cleaner,
>>>> not needing dispose_list_sync.
>>>>=20
>>>=20
>>> Yep, I think this is cleaner too.
>>>=20
>>=20
>> --=20
>> Jeff Layton <jlayton@kernel.org>
>=20
> --
> Chuck Lever

--
Chuck Lever



