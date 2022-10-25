Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5618B60D269
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 19:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiJYRXu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Oct 2022 13:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiJYRXt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Oct 2022 13:23:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B85E77BA
        for <linux-nfs@vger.kernel.org>; Tue, 25 Oct 2022 10:23:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PGDLPF012910;
        Tue, 25 Oct 2022 17:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gszUoaaw3EzahbWn7R6IZVRmMVABAZVwkbu0Wo+Krr0=;
 b=zd5klZ44FJg/voHLAtl29TpGtbxJYmjK1vgceZCmJR0ifAx7bw/mq2ibmgo38DK28fAd
 jzR+S9hXZl7eBCYeG0dlUeGFFg8dKBeWqyQId25yzvbMV+2YPjVriwvKFonBfGUlHYuC
 jimfGPLJoYJk8VyDBeda3luv+yZrAAeiKbZ1vvhWruh9iRiypiR6RQdeQuZ0ekTL+CaD
 rXG9iw1y5PxxXUnaz8cEBxTQDmkOisCAvulWqXAFaFevwuZQoo0hLlvBnYwuvmYRl2K4
 ushUlVhTapI40kVLLywnuvJR7oTPQE5jc/iY0bC6ZKpv4zE2TPML8GPSUCFd4abOBt9I zA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc8dbm0gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 17:23:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29PGdcNE039767;
        Tue, 25 Oct 2022 17:23:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6yavg2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 17:23:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSWVxZ3+thWrZwveIaCuOn3Jv5RVWUPD80kTTDgoMI2CWapgdXrjiashTZZOuHXNW4INaLe9nQDHKT43k5pGjMlLfYoc9rnbAN0nOAQxHJo8ZaPYI4b+H38K7lo3h8n4K20htC+5M8eeaN/b4+mJ3r0oHBJU7ACqCFT+//oJJUFBOW8GqclJOzGfz07j87Na9j7J2SQrdWt4Ufq5HmGs+/i9RryKr3NPKhCiFTtg7lNkUlZxNmUY+gEEXXCpUJsQtYvge0RvVeHZiW3n0KcsxI5My+4TeMznkl+Xr0B6t/DHJGCW0sYX4iNj3KdNI/s28hr3IFtEn1nPacXOBK+DOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gszUoaaw3EzahbWn7R6IZVRmMVABAZVwkbu0Wo+Krr0=;
 b=isrTrEln5vQ3VlXQ3RlvQx7wJonTSB7zuPE2Nb0IE3vu24nre6JuGqHyQGZYoKe4TTp+z/B1BvHchQAF/kvZc2s5Sz/T7yYNMZBT5+H3DDgzjakCQV/mLtTHxN9re6hyvVFxoORjeRA/R08QBeWq3H++45l3pyNt3fAzFxDJXivVqPPIihzjqHxNkhuuIY4N2MMWswZZJJhO+tuvA/JUEuUj4KXXC0uCYI8KRrQGcwiaUsUjSX7fwpMyS1p7P97k8NhBmmAWLpySfG8WW7tZmOSNPRVYWSrrCS4AwnxPOZU6r9kLhJZuxw6yyZ6xLIf+Ry9CM9ikPMrXNIjrGHfHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gszUoaaw3EzahbWn7R6IZVRmMVABAZVwkbu0Wo+Krr0=;
 b=njodW9vlDRqcUGOsztLYnAZLh7+wFp5BYRNROk68z8GzNBZNzAYzP+IsSgX9EiXKMw2xBWNAz2VBqIXcIDWWFHHHfkrOofXNmunb1srJWCTABcuNayu2K1p0LOWaLzBAgnDpXUmfCYlLV3hPdjS0upc0bQ4S3FFkpjpCKc6igtg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5362.namprd10.prod.outlook.com (2603:10b6:208:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 17:23:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 17:23:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Topic: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Index: AQHY4ywcCv9nfMlOd0+Wa/Y/m9MOsq4c6pOAgADqiACAAE0UAIAAB+UAgAE7EQCAAAGLgA==
Date:   Tue, 25 Oct 2022 17:23:37 +0000
Message-ID: <1FE9D77C-1FE9-4986-AD14-63F89A114E5E@oracle.com>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
 <166612313084.1291.5764156173845222109.stgit@manet.1015granger.net>
 <166658201312.12462.15430126129561479021@noble.neil.brown.name>
 <51A1D02F-4BD7-4AA4-AB5A-6962D8708122@oracle.com>
 <166664893048.12462.2026765054120312799@noble.neil.brown.name>
 <E948A44A-D36E-4591-ADD2-D3D8504FA2B3@oracle.com>
 <f1a68b015c51a411023be3d1f30516e1651a2083.camel@kernel.org>
In-Reply-To: <f1a68b015c51a411023be3d1f30516e1651a2083.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5362:EE_
x-ms-office365-filtering-correlation-id: caf9f6c4-22f3-49ca-7304-08dab6ada719
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iMSuRFAHim+i3YAqNCRj8Gi9qmcrScQexakd+kNbEyAhkmMvrVCLJoMJbdSwT0bJatpvlvUhhf0Gyqw1m503WCpw56xRYB7R+CYLuuRSZl8S5iammVkrqO22jaTeJ4ktBkOUqXDXmxGdpdNwqHEuzmXbvEnndOoFsn2fjwfyAWujENjSjbOFYs8ouOnKvkRVSzzw+BJ1RjKdoY0rDpcXDJ63O+wAsJ2SuGsFcMlWAJK/nJe0/4bW0FuP6UpY/lEkIefKC2fjv2N+gBdzZsvhtyyCwNfc23qRCFT+982XYaxaXGlDM/m6dQfv0zaMILn9tIxqVBpI0xDuPlRIXt+D0fsyrqVY1nzuuaBkYkUKciUD1ZgwLmH4rxp+ToA95ZGDiRFGABeJi4KIQNSEGLcS489ZZYHuDuaaLdj8eWzKSxhAFpqsU9JFsblBNFTYshahst8tjcQsZgykibz/F47mWHpmgwYTRdfYzRiXfDqwFyWTrOl/cdI1AxXFBYttv0FreuKXz+mltAG5Hpss6ct2T4mTScKThOO6/bhlo1a4oDbohXCt8POhXnzVTOJzc8yZXUd0OPRCixQNN43d6+6PBdP2AuK4iFxTJnAfqMmUDzFT4iKV69CT+Uax/a556rl29y7y4fQzrsMs+M0ER/iwXLzFTESjKZcjTDfPCzN6CKzQVEsjHSaZLv9PQZjllcUKncbd6AOIS1uPeK1WQHGOjh9J36R7WSjWDy44gLLYcZivfi+ECutasDINcFwRtKfd4JB+nrQ/V0w9//V7ABFCmk/n4khYC3Q60ab8o91PYqA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199015)(38100700002)(122000001)(86362001)(38070700005)(478600001)(8936002)(71200400001)(5660300002)(6486002)(2906002)(4001150100001)(4326008)(316002)(8676002)(91956017)(64756008)(66446008)(66476007)(66556008)(76116006)(54906003)(6916009)(41300700001)(83380400001)(66946007)(26005)(6512007)(186003)(6506007)(2616005)(53546011)(66899015)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EA/Zf5iCCBZ1sWXuBhS52dZ9mjc+J7aRb3MyzAEh9mWekARdUJNKzMs46kgt?=
 =?us-ascii?Q?IcgMYReoqeBtEVbH0GvTFYyPYvo0lLKuFNc1Ye+s3IrvLNTTm2HrwMFqy/C1?=
 =?us-ascii?Q?k8Qq2lr+obGsgNaZNI2XEutwNaUzi1YCZ+z+oh902Tf6k20y/9njUb9Khwkm?=
 =?us-ascii?Q?dfbEZS0DYYaHYulvotxWXDyUkl4xRdtVZ+W+Cc3exKd2q5TvMqfR3QxbRINN?=
 =?us-ascii?Q?dBXjPm3Gh9gfJCa/PhOhUwcoR/tKTMe50sh8ZRz075csnZDhFn64TW8qa83Q?=
 =?us-ascii?Q?RBCFf8P7PrIN/CKzkdPhxMjroro73n3EPaB3duRcncV/UxQT7r/acw+n7qkS?=
 =?us-ascii?Q?fTz259Vwlcdolyd8mt+PeFkXRNu5t7lmcYjrRlD96qHhEcd3eopFN5qnKk2I?=
 =?us-ascii?Q?6j1zstwQSWhUn6lYc7hnD39Qk0jJcQUFiNfl6XskThZfTG3NPcq9koJ9fGfY?=
 =?us-ascii?Q?c/04yza8FUashHGNNwWuTBpS5TF7FoqEZpUB/JNs08Vs8aFKZiR2MLMobJnd?=
 =?us-ascii?Q?xozVJc2td7+b7jkwelGI1QtJb6xX7USmVKERsB4GfoBH9wWMKeST43/5FS44?=
 =?us-ascii?Q?lH1A/eh9ZAVmeClKTkKYl7tJAHgCd6XRtgjmY0xW0Lq4egU9OuzDb8MdIE8r?=
 =?us-ascii?Q?TN5LwoStOBwxq66bKpjn1BXXAvFOrq84oiQvM/4utvw/IyxxmYhPHxsji1Gl?=
 =?us-ascii?Q?SC2a8SZ7MtSSKk7D8osYKDmuwaSXmH+zFhaNKFQ6xX0Z5W+Lg/7+HsPwyZ8y?=
 =?us-ascii?Q?VwE0IPctPCt+K5/ZQshi/CW9yB+Ks0rErkTUasIoOsbaFB8fNuXWrERqK8rk?=
 =?us-ascii?Q?J87xeGGcmBaUKSswoe1ru6Xo4iF8YA9VzUgmYTc56DpEeisO9SLQ74AWwlv8?=
 =?us-ascii?Q?0UbcM7DaZ+odA2WGRT8E3zlOU/XWPPgcrYZ/sPIEmUrhvUne7usxsaq2YFqr?=
 =?us-ascii?Q?MdXw7Mg5LjkmNRvhlTMmPXiQwgOVRdd6sVYFmhzykHM0H3K+z8FGu3qqJqQP?=
 =?us-ascii?Q?Jc8i+QVyjGVdU1rVZQxHdkyY2RhE20uCqeXZQdP6oruan7Nrx0m7w01+tNh9?=
 =?us-ascii?Q?E+mVsGT7ssCA58q5kXyYCq6b0HKVQjYrO46ftDiC8yUVpQqabbwvTyrI5zun?=
 =?us-ascii?Q?K6YF3sASdD3pDYuR4+1gXDaNBQtuaQ0KYzAwGrdsJeNHtkBt/aLKK1xD1re6?=
 =?us-ascii?Q?4c3wQo6h1VTLCgLqIc+RiF6fzTrbXmbUMWXdX1itABsWTMvjpYWT+movrwpp?=
 =?us-ascii?Q?rv/phoExGvUX/Y/EbJwjEUCKoXY6S3V6U89GdJdVWhn8HyNcaBN31cJQvvPD?=
 =?us-ascii?Q?w9ue67PcGi940roWHGfg/FhZaAFcQMdsgu4Q3Er6GmGxXsGjw6MA2oXhnD4/?=
 =?us-ascii?Q?RePf5G6LU91COh2XPGZgZR7/+0PJaXb0PXTH5K2ad9LpN9I7UP/EgN1dbNX2?=
 =?us-ascii?Q?WdxZMFUS6WLZaS3W+uQg5lhET8YccF9iH2xlnhZ5cDvIj5E1h1jQozckwYrG?=
 =?us-ascii?Q?mlXQSrA5pKVM4YaLLQjVzycX2OtIhyqmUxVHVkSnsYLj4LJFjT/+cWjRVnSA?=
 =?us-ascii?Q?NClkIS/habe/CbCJ+6o4QuHJpRRyXZfULG9u0iVMkemkDAAT+DLT9yQV6DKI?=
 =?us-ascii?Q?ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5893C3605CD3DD4A9E742E96A27B154F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf9f6c4-22f3-49ca-7304-08dab6ada719
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 17:23:37.5250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wozoAymH+9/+NYRGFyU6+tNKkQ02YRxmMGsVJ/LZMzsolfpqgLguTvysPk75neP5U8q6UMNLlZ1t5A9YlybuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5362
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_11,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250099
X-Proofpoint-ORIG-GUID: fF5ytc8dWQuqouWXNIBQ91X4MMAKL-zw
X-Proofpoint-GUID: fF5ytc8dWQuqouWXNIBQ91X4MMAKL-zw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 25, 2022, at 1:18 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-10-24 at 22:30 +0000, Chuck Lever III wrote:
>>=20
>>> On Oct 24, 2022, at 6:02 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Tue, 25 Oct 2022, Chuck Lever III wrote:
>>>>=20
>>>>> On Oct 23, 2022, at 11:26 PM, NeilBrown <neilb@suse.de> wrote:
>>>>>=20
>>>>> On Wed, 19 Oct 2022, Chuck Lever wrote:
>>>>>> +/*
>>>>>> + * The returned hash value is based solely on the address of an in-=
code
>>>>>> + * inode, a pointer to a slab-allocated object. The entropy in such=
 a
>>>>>> + * pointer is concentrated in its middle bits.
>>>>>> + */
>>>>>> +static u32 nfs4_file_inode_hash(const struct inode *inode, u32 seed=
)
>>>>>> +{
>>>>>> +	u32 k;
>>>>>> +
>>>>>> +	k =3D ((unsigned long)inode) >> L1_CACHE_SHIFT;
>>>>>> +	return jhash2(&k, 1, seed);
>>>>>=20
>>>>> I still don't think this makes any sense at all.
>>>>>=20
>>>>>      return jhash2(&inode, sizeof(inode)/4, seed);
>>>>>=20
>>>>> uses all of the entropy, which is best for rhashtables.
>>>>=20
>>>> I don't really disagree, but the L1_CACHE_SHIFT was added at
>>>> Al's behest. OK, I'll replace it.
>>>=20
>>> I think that was in a different context though.
>>>=20
>>> If you are using a simple fixed array of bucket-chains for a hash
>>> table, then shifting down L1_CACHE_SHIFT and masking off the number of
>>> bits to match the array size is a perfectly sensible hash function.  It
>>> will occasionally produce longer chains, but no often.
>>>=20
>>> But rhashtables does something a bit different.  It mixes a seed into
>>> the key as part of producing the hash, and assumes that if an
>>> unfortunate distribution of keys results is a substantially non-uniform
>>> distribution into buckets, then choosing a new random seed will
>>> re-distribute the keys into buckets and will probably produce a more
>>> uniform distribution.
>>>=20
>>> The purpose of this seed is (as I understand it) primarily focused on
>>> network-faced hash tables where an attacker might be able to choose key=
s
>>> that all hash to the same value.  The random seed will defeat the
>>> attacker.
>>>=20
>>> When hashing inodes there is no opportunity for a deliberate attack, an=
d
>>> we would probably be happy to not use a seed and accept the small
>>> possibility of occasional long chains.  However the rhashtable code
>>> doesn't offer us that option.  It insists on rehashing if any chain
>>> exceeds 16.  So we need to provide a much entropy as we can, and mix th=
e
>>> seed in as effectively as we can, to ensure that rehashing really works=
.
>>>=20
>>>>>> +static int nfs4_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
>>>>>> +			       const void *ptr)
>>>>>> +{
>>>>>> +	const struct svc_fh *fhp =3D arg->key;
>>>>>> +	const struct nfs4_file *fi =3D ptr;
>>>>>> +
>>>>>> +	return fh_match(&fi->fi_fhandle, &fhp->fh_handle) ? 0 : 1;
>>>>>> +}
>>>>>=20
>>>>> This doesn't make sense.  Maybe the subtleties of rhl-tables are a bi=
t
>>>>> obscure.
>>>>>=20
>>>>> An rhltable is like an rhashtable except that insertion can never fai=
l.=20
>>>>> Multiple entries with the same key can co-exist in a linked list.
>>>>> Lookup does not return an entry but returns a linked list of entries.
>>>>>=20
>>>>> For the nfs4_file table this isn't really a good match (though I
>>>>> previously thought it was).  Insertion must be able to fail if an ent=
ry
>>>>> with the same filehandle exists.
>>>>=20
>>>> I think I've arrived at the same conclusion (about nfs4_file insertion
>>>> needing to fail for duplicate filehandles). That's more or less open-c=
oded
>>>> in my current revision of this work rather than relying on the behavio=
r
>>>> of rhltable_insert().
>>>>=20
>>>>=20
>>>>> One approach that might work would be to take the inode->i_lock after=
 a
>>>>> lookup fails then repeat the lookup and if it fails again, do the
>>>>> insert.  This keeps the locking fine-grained but means we don't have =
to
>>>>> depend on insert failing.
>>>>>=20
>>>>> So the hash and cmp functions would only look at the inode pointer.
>>>>> If lookup returns something, we would walk the list calling fh_match(=
)
>>>>> to see if we have the right entry - all under RCU and using
>>>>> refcount_inc_not_zero() when we find the matching filehandle.
>>>>=20
>>>> That's basically what's going on now. But I tried removing obj_cmpfn()
>>>> and the rhltable_init() failed outright, so it's still there like a
>>>> vestigial organ.
>>>=20
>>> You need an obj_cmpfn if you have an obj_hashfn.  If you don't have
>>> obj_hashfn and just provide hashfn and key_len, then you don't need the
>>> cmpfn.
>>>=20
>>> If you have a cmpfn, just compare the inode (the same thing that you
>>> hash) - don't compare the file handle.
>>>=20
>>>>=20
>>>> If you now believe rhltable is not a good fit, I can revert all of the
>>>> rhltable changes and go back to rhashtable quite easily.
>>>=20
>>> I wasn't very clear, as I was still working out what I though.
>>>=20
>>> I think an rhashtable cannot work as you need two different keys, the
>>> inode and the filehandle.
>>>=20
>>> I think rhltable can work but it needs help, particularly as it will
>>> never fail an insertion.
>>> The help we can provide is to take a lock, perform a lookup, then only
>>> try to insert if the lookup failed (and we are still holding an
>>> appropriate lock to stop another thread inserting).  Thus any time we
>>> try an insert, we don't want it to fail.
>>>=20
>>> The lock I suggest is ->i_lock in the inode.
>>=20
>> I will give that a try next.
>>=20
>>=20
>>> The rhltable should only consider the inode as a key, and should provid=
e
>>> a linked list of nfs4_files with the same inode.
>>=20
>> The implementation I've arrived at is rhltable keyed on inode only.
>> The bucket chains are searched with fh_match().
>>=20
>> I've gotten rid of all of the special obj_hash/cmp functions as a
>> result of this simplification. If I've set up the rhashtable
>> parameters correctly, the rhashtable code should use jhash/jhash2
>> on the whole inode pointer by default.
>>=20
>>=20
>>> We then code a linear search of this linked list (which is expected to
>>> have one entry) to find if there is an entry with the required file
>>> handle.
>>=20
>> I'm not sure about that expectation: multiple inode pointers could
>> hash to the same bucket. Also, there are cases where multiple file
>> handles refer to the same inode (the aliasing that a0ce48375a36
>> ("nfsd: track filehandle aliasing in nfs4_files") tries to deal
>> with).
>>=20
>> I will post what I have right now. It's not passing all tests due
>> to very recent changes (and probably because of lack of insert
>> serialization). We can pick up from there; I know I've likely missed
>> some review comments still.
>>=20
>>=20
>=20
> Thanks. I've started looking over this and some other changes, and found
> at least a couple of problems with the existing code (not necessarily
> due to your patches, fwiw):
>=20
> 1/ the nf_lru is the linkage to the LRU, but it's also used when we move
> an object to a dispose list. I don't see anything that prevents you from
> trying to add an entry back onto the LRU while it's still on a dispose
> list (which could cause corruption). I think we need some clear rules
> around how that field get used.

I chased this when converting filecache to rhashtable. There don't seem
to be any logic errors in the current code, and it seems to be a common
trope in other consumers of list_lru, so I left it alone.

Yeah, it makes me nervous too.


> 2/ nfsd_file_close_inode_sync can end up putting an nf onto the dispose
> list without ensuring that nf_ref has gone to zero. I think there are
> some situations where the file can end up being freed out from under a
> valid reference due to that.
>=20
> I'm working on some patches to clean this up along the lines of the
> scheme Neil is advocating for. For now, I'm basing this on top of your
> series.

I'll try to refresh kernel.org:cel for-next later today.


>>> An alternative is to not use a resizable table at all.  We could stick
>>> with the table we currently have and make small changes.
>>>=20
>>> 1/ change the compare function to test the inode pointer first and only
>>>  call fh_match when the inodes match.  This should make it much
>>>  faster.
>>=20
>> I had the same thought, but this doesn't reduce the number of CPU
>> cache misses I observed from long bucket chain walks. I'd prefer a
>> solution that maintains small buckets.
>>=20
>>=20
>>> 2/ Instead of using state_lock for locking, use a bit-spin-lock on the
>>>  lsb of the bucket pointers in the array to lock each bucket.  This
>>>  will substantially reduce locking conflicts.
>>>=20
>>> I don't see a big performance difference between this approach and the
>>> rhltable approach.  It really depends which you would feel more
>>> comfortable working with.  Would you rather work with common code which
>>> isn't quite a perfect fit, or with private code that you have complete
>>> control over?
>>=20
>> I think rhltable still has some legs, will keep chipping away at that.
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



