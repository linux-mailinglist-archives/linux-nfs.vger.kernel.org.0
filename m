Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699DE5B4A9E
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Sep 2022 00:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiIJWgU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Sep 2022 18:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiIJWgS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 10 Sep 2022 18:36:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6869246611
        for <linux-nfs@vger.kernel.org>; Sat, 10 Sep 2022 15:36:17 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28AFrEeO029431;
        Sat, 10 Sep 2022 22:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=OCyA7EEyMAXeB9uYZ0F5cLpcwOvil+HbqEqIrMiio6M=;
 b=NJ+tS1L6URpF3IiKGz/rGeKvR6ZJfu+q3Z4UNWee8qEO9PJv+X+YScGSC8U2HF/D/eyZ
 RlXWVP84+PdJ7cfyUJmXKODiW5VKShz4hOq+04jbBRYJCDO2tCVG6d4FO1gPo4hySGwh
 EPmqWkEhR4Nc9bKxxZGSqxZF3+q58C8rFkPN3HawuVuTBB24lLYaj9gP22Np9VWJaKbO
 Ur6kmN3NU1zzMRwstEVHOkOarM7vUJH9uqnDYuXESIntl3d1EgPXI4D+/PChaS6qpH7H
 3ClKktDEYZkE0TcNgm3rJkbWmGXacNNrBPB39RM+9NQszfhNooufxdHZgCI9uKH5xsva gg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgj6sgv6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Sep 2022 22:35:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28ACdVxY012467;
        Sat, 10 Sep 2022 22:35:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jgk8m4ajt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Sep 2022 22:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9HqAuYOqZdoKTAWYbVSnNmCDFk907ZoiqWQdGdhATvq0YCxTwrFJ0F17BLROeGehZHJ50tcN79ohHpevqZLGPUJKqQAnsWIwqOYH0Rhme2bMtXvRCEOzXIqDoIkBqFF1P5q3EOyIJbUb4NPmeKPV5zDgx1XccAUaM0SLJuMGttJXWnhIpktGlvHKD3PVOLQjNQ+zBYPRkJDHsAAvpWx82xe8ckzAP5l6EjfhAt1KQITUucroau68iUYRf8AEyY2OdulJ6wpa+eu02UoemA2Ph4bA84qlNlz1552LBvhZcLdk5PlOhNKmxeFJp/5PnKGBMYLP8wwysFlMKGZmLnu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCyA7EEyMAXeB9uYZ0F5cLpcwOvil+HbqEqIrMiio6M=;
 b=c7Hp+eQ3Ny6iMRGm3Vb/h4YuBIMIr81MOKIh5nFebU7DOisu6vrXX/g/BdetYj6HDkZAqoYyCM86BbzPpiYh6PSNm6VcGBkcn1Nq4NTGsU7gS7SMGpitiovtnLtuOn2mHMPzwZ/MiJ+dcf8FzcRBYpjY//4fv3MvrT9I8tGCZJpETbai3N4a7pB/VrdVwbjQiVTQk4yTONAVEBFrAGpKVlVkhIumM6YNBzkwJIg7UbRFeyk6X3aD15xum1nMv/x3JlhEbwckx1RksKXfrCKiKNROkQ8RM2sypLpEWMEXG7kCbk+eqRiInK9XWKjN66FSfFCxaR2oDqVHTSDkhT2PqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCyA7EEyMAXeB9uYZ0F5cLpcwOvil+HbqEqIrMiio6M=;
 b=g0PNo69p0qcFUMmzeiCYfPjs9IcwrdVzch5nD17Hu7hoYt9TOJUOVi186wVNDntqRxS2ZBco25McfAOfzi9vV3gNFvn5xroCweYqmPJXgYiA9ET7d28GF3Q0z6qtz0eJK6oU8M5TVEH1XWy7yyPkk3wrInxnG5fzia1HVQj3r08=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Sat, 10 Sep
 2022 22:35:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.022; Sat, 10 Sep 2022
 22:35:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Thread-Topic: Is this nfsd kernel oops known?
Thread-Index: AQHYvJP9R6JamLcYaUyLf/owehh7vq3HuG2AgALiPACAAGl2gIAAWREAgAdmpICAAAw8AIAAo8KAgACEegCABUMMAIAAAf4AgAAOhwCAAAZVAA==
Date:   Sat, 10 Sep 2022 22:35:52 +0000
Message-ID: <5FF21605-6F1E-4DF1-A141-F86263CA579F@oracle.com>
References: <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <D0A6E504-F2C2-4A5F-BC51-FD3D88A790F0@redhat.com>
 <CAN-5tyHYH7ODzmTK=Maa3NZOSxfcE0mfaWY11+n2htQpya869g@mail.gmail.com>
 <EE9C1D1C-AA5B-48BC-9E3A-8A4523456AEE@oracle.com>
 <25AF9743-A2A2-4AFE-9123-BAD3C8F17655@redhat.com> <Yxz+GhK7nWKcBLcI@ZenIV>
 <9D6CDF68-6B12-44DE-BC01-3BD0251E7F94@oracle.com> <Yx0L9p4VMH2v2tBX@ZenIV>
In-Reply-To: <Yx0L9p4VMH2v2tBX@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4745:EE_
x-ms-office365-filtering-correlation-id: 9dd2aac6-e08d-48e0-414f-08da937cd182
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0FQ+i4yNsP8+PD/AGgJMYk9I/9eaA5bWLh6h+rY9E9XvJjbYY4MmZ9/PK9piGZBLCKbXvnI3qNJXizOCSkArp9d20oeZ4MGFp+y6ggXxSu5AJH+/b5rBI4qiRZzYfbhQC67N5859KSUgfiH+uwiB553vrSvpn5FKChFn1TL0ghMd+/3gF2g/z9nqrDE3PkupUlnzGL75sUZBUAeK4Jfyps1sUGfaqt4EaaYUsDCEKptgG0fJeDNpT+q+0KIJnNdZnrH9Pn8HGh7tzaNry+nyKDCTt9lINsSdJKPSyJxQQ/9PLl3jkQwskAIzI/1vAR/h8kI4A6HbYkV2PaEwylMBROAq5Uqwz1ApztlNwTIzMDTwDbcsNidKxSYxkSTE+8i8VGeVmT+qAJcXZSb5eorOEGSr9a8++iF5gTswdqyElNXpS8skW4P0PXKnIl7PrPZ8wrAL2dUwKYqUEhezpXW1Wa8ZqZGy+rDcGISjXMLSK46vYNo1TQUBshZk3jw5PQDUA1zb+Vu8lAUAxSfHJHVAERW4kXK6uksVbp+agkzvPR5SUBg0GZqTg3TVThmLKxOedQf4U8i7djxeDkTIxAPxIJQJ50MuCUZCvE4UMq1L4ojyEYDVBP4Cp03BArikqRAulX2rzpKdR7i2gwu4iJPfbHeLrvBmceNMVIHoij/YqWLQIjP49x76NTpb5kxzYZt4SYXENqeNv4ievSdK9bnH5APuitUsegy9YsbcQ6zgJkWfoO2DSfc71M9cGIs8wTq/HayhFspNculx+OfllH3vc4Gq79kIOvvjrILFhNzc1M0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(136003)(366004)(346002)(186003)(8936002)(2616005)(2906002)(5660300002)(6506007)(6512007)(36756003)(33656002)(26005)(86362001)(71200400001)(6486002)(53546011)(478600001)(38070700005)(122000001)(38100700002)(41300700001)(91956017)(66446008)(316002)(66476007)(66946007)(66556008)(76116006)(6916009)(54906003)(8676002)(64756008)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U+1qrv9EvepOHQEF7y7zxgTYQBKqooMtwfj70lqXoCqKqI6KnFFV1Ss5f00z?=
 =?us-ascii?Q?SaPq4grj+ubEmaUuJObHCEnJ3YYJw3xRqrDVWzDP9nmit8P21HZY2K0u8gd3?=
 =?us-ascii?Q?LSlP9l8sDUBOYm8u8N1rdvnjln4G5U/L4BzAH0WZRZgdSm893cYU8YqqZ9so?=
 =?us-ascii?Q?Bj5bYRDBXQP8jDK706CDlpwldP9JOgR2B0CF6lTGcDBleZuezi/Q8q5qCrii?=
 =?us-ascii?Q?YBXStEKD58BvEIRqFBQWGne9/ISZBCeoXCf3qI/0vK1WoH1pBsymN/Mdr4Fw?=
 =?us-ascii?Q?FC19AiWtHtmxoR4Cqv7LTs81KuuIYHkBU4uWPAS8HI0jnYpNOrdIhU1zY9O9?=
 =?us-ascii?Q?q7AMcWbxEfg3PbT22F4NJ00ucDTgQi/bZVtBqR9O5BBiXSrwVHMjVQgPs71s?=
 =?us-ascii?Q?bhU7V+J/UOiho6IWAcKbC+TLiL+Zr0xkbV7H55Xw6rNTD75dEg+4+ylmQGmw?=
 =?us-ascii?Q?x+G8MArNI/QmvS4iKEnRgWMYqNQ4RK2rVyvBOkDpPf9+TbWtQwQIv/WE1LHB?=
 =?us-ascii?Q?3z+H66zxKR4vm31Gsh5spcq7KO8jlsHIYXLDs0H6IVtP0Da1Yb5zmygVTMAX?=
 =?us-ascii?Q?L/tMjTlZqGmJm7LBAbWaJISjiUlU+f2o3sR0iMBEEieRPmPC2W8AYRZivx9H?=
 =?us-ascii?Q?h3o1NViJIyM/inOaFxZ6MFiQbhfIAMCsOLj8iqlDgLmOP07PZsXzP++agayJ?=
 =?us-ascii?Q?t6MLi8FMgS5w9l8xoJGfPVNxc0D1YOUeOncrNfluSEbafsrgeIzGOSPfgMN0?=
 =?us-ascii?Q?fuW8/Lypj9WGO0nAFbcNjICyWKyFT3271jXwKYwp4Wb8NcwmCKJBFpY9NOvF?=
 =?us-ascii?Q?7xVYvJKylnFvpzczLFmbgsCEJCfEkxYBbHAg7bO+A19KVnXoOL9vxuU4Ws4F?=
 =?us-ascii?Q?PgbJfaiy9Ebp/Zq6Lr38Q9vlp37HHiBlLi5tb2GLzwfnePVLJ5qqRe4q19cx?=
 =?us-ascii?Q?ZXST4yXJBkJG+fA5az4mR3d0AMTQHG5nZxikaQXSS4NQ5LfqTznlXEW+CqFm?=
 =?us-ascii?Q?NQnrKXCVYiSvDtMAcsAEToLp3JFiXbQQk8f3M4LuLrTCVh8SuvmKRngDTcsm?=
 =?us-ascii?Q?DCMt5zRSpTfl6MDhjJaG0O9avekJ5E3D35sR0naiAirT8TNa7Fse6vpW8J00?=
 =?us-ascii?Q?qYTi3CoVh149UnmyvmMtKDv6OEcDYoSbgAiYM7qSyPafMOXG4WIGMahXQlUS?=
 =?us-ascii?Q?UYwGa8MH0mWIR9DZXPQRrOOEJfGIA+rAlbzTInlSVxSsR/VElKJDY+EsRV4Q?=
 =?us-ascii?Q?YedV/2rY17FJUldEpo11R+uCnwRhhrn9HVZH39TQy5PK1AGm/c/jXV4JGM2d?=
 =?us-ascii?Q?/ql3JvzH25jeftxnRbxaZ8cBJq8WdLAr4VFh2Zrs/u2ykqb0i7oqP23r6zns?=
 =?us-ascii?Q?BbLc9O/IkjGGIOKSvP62gdEdS+4b1YiDNPGwqB7ac7dM5zgV2xQdT7l1arYa?=
 =?us-ascii?Q?BbhFdARUVdREQhMvWk6YdzXAZlD62zNu6lwq5NHw91A7RGr+xIvX/xgRc/NY?=
 =?us-ascii?Q?vYL09bOxi5518soPbxovgTTV6QtnHZhcPdPZQXSQL5Gfp8D2SHGB/A5MHDsp?=
 =?us-ascii?Q?MvdgKU41l2BcFcrByD30cgqxyZHALXgpd+u70fEZzgGDBwgCdU8yRg0TrRgo?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C1CB27C5200CCC46B45075360B432C8E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd2aac6-e08d-48e0-414f-08da937cd182
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2022 22:35:52.6080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wiTjOiTjxFScoGHHV95Txe6kHUjOhwpzmoS21NK1JS5P6qEtzE4Vb007PSjFc7YKO4sH8ZBLTkrrJ77ykmyMbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-10_12,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209100083
X-Proofpoint-GUID: t8ogwhgdurWiAH_YR5ZOHkLtJUaWrvpz
X-Proofpoint-ORIG-GUID: t8ogwhgdurWiAH_YR5ZOHkLtJUaWrvpz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 10, 2022, at 6:13 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> On Sat, Sep 10, 2022 at 09:21:11PM +0000, Chuck Lever III wrote:
>=20
>> It's also possible that recent simplifications I've done to the splice
>> read actor accidentally removed the ability to deal with compound pages.
>> You might want to review the commit history of nfsd_splice_actor() to
>> see if there is an historic version that would behave correctly with
>> the new copy_page_to_iter().
>=20
> Nah, that's unrelated...
>=20
>> Is the need to deal with CompoundPage documented somewhere? If not,
>> perhaps nfsd_splice_actor() could mention it so that overzealous
>> maintainers don't break it again.
>=20
>>> +	struct page *page =3D buf->page;	// may be a compound one
>=20
> Does that qualify? ;-)

Well, no, since you just added it :-) I meant pre-existing
documentation of the API. I take your remark as polite
encouragement to go and look for it, because this is an
area where I need deeper understanding.


> FWIW, there's a separate problem in that thing - it assumes that
> pipe_buffer boundaries will end up PAGE_SIZE-aligned.  Usually
> that's going to be true, but foofs_splice_read() is not required to
> maintain that.  E.g. it might be working in terms of chunks
> used by weird protocol used by foofs, with e.g. 1024-byte payloads
> + 300-odd bytes of framing/checskums/whatnot.  In that case it
> might do 1024 bytes per pipe_buffer, with non-zero offset in page
> in each of them; normal read()/splice()/etc. would work just fine
> with that, but for nfsd_splice_actor() results would not be
> nice.
>=20
> AFAICS, sunrpc assumes that we have several pages, offset in the
> first one and total size; no provisions exist for e.g. 5Kb of
> data scattered in 5 chunks over 5 pages.  Correct?

struct xdr_buf assumes the first page might contain payload that
starts somewhere in the middle of that page; the remaining segments
of the payload are contiguous page-sized chunks, with the last
segment starting on a page boundary but possibly being short of
a full page in length.

It's not a true scatter-gather arrangement. A 5K payload can
only be contained in two pages.

Someday we hope to switch the whole stack to use a bvec or
something more general than an array of pages, where each
segment can represent something that is not page-sized. There
is a struct bvec inside of struct xdr_buf already, but not
everyone uses that yet. RDMA, for example, still uses SGLs
or page vectors... so I've been waiting for some forward
movement in our transport APIs before doing more heavy
lifting.


--
Chuck Lever



