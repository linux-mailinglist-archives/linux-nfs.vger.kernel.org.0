Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A97256A930
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jul 2022 19:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiGGRN7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jul 2022 13:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbiGGRN6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Jul 2022 13:13:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB57A31212
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jul 2022 10:13:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267GtwuK004460;
        Thu, 7 Jul 2022 17:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1dsGUPJ4q2vtI8sNjP6s1bBn4/zRW4JH79BfmAj3eY4=;
 b=ujxka6pQBnFjteISjaQz2JQZixBCrDBK8uO/ZLr+xt1I2dNtXwMuuGHUTiIlCtJ0TSod
 hoWuiGaW7+mmm8Vzeu5FlynuXAdG9ASe/bEsQaCEDYZFc+uTIpEhYExHo4Nn3ySuVDCa
 zSxm7AKstybzJmVOfPV0YEJR7K86fubxYIm13HjBEFfwEGMZ36OrvXykFJZb5IJgL47a
 z+F+jUsO2mIe/W4FGPidqwG+xqXwlz5jMhq/boEsQ/qaeLL6HcBvNxjI08ttoS+F44XS
 xN3QdU/ROVwzvMz61EVPh/YsP2cu4i2dDBIqDYj0e4ghFp7aWqS3WINlyBPtJYPJ+7oz DA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubynx8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 17:13:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267GtJ6N017298;
        Thu, 7 Jul 2022 17:13:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud600ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 17:13:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKXYF+OEIhlaey4vZ7xHQJNnzEuVccrNpxRN36PLnzKa0AVnm75VCJ8NNpGTYY/ZRY+UKC3tVb4Wibt/gnsG9wBHQ4UgjvJz92Q2oxe9DShMiESixZcjGABo0sgyWhtN+F5M8VNjTB+mBTgQn9vJflK3mning0UU+0v10d4233Rd1bzNfqHlX51597M9dyiIbuhdnAfzA0yUKkz7oWpXpJn4d+pRPHoTGx5REsfY0rbKSlpESJAeX0Bk4NyMBNT4ut2/ALfcg4s5HpVGnfEhTq6K/440Hxkyv3O9A3CMh1XyZFzU0vNctG4iKmZkU8e7Qt3Y8iKPMQAoZNZiUwHAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dsGUPJ4q2vtI8sNjP6s1bBn4/zRW4JH79BfmAj3eY4=;
 b=IW2km7vLERGkMaLOekuExHVVoDBoTF9GceztOVmFhFzwvUX/+pcoUuZiW0b2pqdKgvh3c+wPAyPHjpPILyZOBCB3MtEKqpbRh8rLQuZ360PkV80NEvoDcK5cDLRIK6Gom2r9cYHikIe/6611tHZvfjn4qm0h8gQxPoO97QwbOywWu0Eb48CKPuD3uTwCBtkVrrjOAxzQFHhDZoS7jgwBoxv6Gvddkw+3WOaTZ5YT1XrDGY4HuzndcWnbJxI4Q/b203IFRU0ll9ml1WDhcZdXxrvzE4mPa0DB3eD2wcCEmTdeYBtKqrXoVZ1aACTaxBdZ06Ffk6A2+tx0cCkdaoGfjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dsGUPJ4q2vtI8sNjP6s1bBn4/zRW4JH79BfmAj3eY4=;
 b=qHGjN3xeegAlUCkhyDsu9J5C3TGLsz9tt6d6ob4ygJpD1BirTgHiHj/M0BMhTSeyfUnP3TcGJ07t/mc4yO8fwEd0c+81NeO0jP1OYyUJpEPmkFFd5Je7wJnpn5opk3vPtf+5C3T6ayR7o5DT6RMa2Aflb9tQSlX2+OqZczvQYug=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6032.namprd10.prod.outlook.com (2603:10b6:8:cc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Thu, 7 Jul 2022 17:13:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 17:13:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Bump the ref count on nf_inode
Thread-Topic: [PATCH RFC] NFSD: Bump the ref count on nf_inode
Thread-Index: AQHYkhpvRGZ0dTioakaq+LLAbdwSV61zIGIAgAABKICAAAC9gIAAAxCAgAAAUAA=
Date:   Thu, 7 Jul 2022 17:13:53 +0000
Message-ID: <6F64FA5F-BC8B-4FBA-B04C-F20FE434AA90@oracle.com>
References: <165720933938.1180.14325183467695610136.stgit@klimt.1015granger.net>
 <f3dc1a01fae6759a350adabf944892417a63d529.camel@redhat.com>
 <307aab1000890798345175063c24a77038a78167.camel@redhat.com>
 <3A439D76-F78E-4449-923D-7E71A47FE36E@oracle.com>
 <81b43bd844e7cbae885d094cc7ae5026cee24d15.camel@redhat.com>
In-Reply-To: <81b43bd844e7cbae885d094cc7ae5026cee24d15.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 449240b3-8aac-4906-dca5-08da603c114d
x-ms-traffictypediagnostic: DS0PR10MB6032:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OyjTOtskqAobd/7FIod5KMecGh2z7bj8dq5GqMuXDkbLKERBVpC9SBuzb7Z72pbm47SutFFyq9C6i25vskni+SRhpzxdeIhVM6FpKocioCLdeTxb26BswozcQ9M2unIkqGe+RFCu/QJyVS+8dvqrA7DbdNRGA3X4DGRyOdroRu9s3pUHOChQrWM7xShPizMGUVlhgOYJeqmIXtpKPMVLva+QSaVh0Vn1pgWPMOEzWTjoyrmYIKlaB4MQ01y66b42Nkj8cXef5AAeZLFtawMFLsfbpxE76ZA6fSpz1bWoiRq37300H+5xeo0eXsTUPFi4E/FIi7EQ4AXqqnWG4IiYksy47o+DBxHh0zJS8+hWCJVG4AeNN7jd+qA4pynqj+/fTvUsiYJnwd1EyS6aGCa9hHwKIzWNJoOuKZGyIQkG/5uwjzgQBwYVhch9R1K58KY9nXBwfFEM9DWp3qC8m0q+yc2WtwbD+pBWcIjBS89ZzaE4wSDUlJEIyKzKkRDtBskw3zfqrs74OV5Cpi6ayniRQIZX1h0904Kp6U/vNd7Go2Sue+pGVktYwNOPdNU9DYHUBwE2CyYMvN00SxPA/caI9bphpRkFFBG+TQgpDXgmzyJhmMbSPPA2NKWqtXodWZqR19MbyoEvJ4e69784biSGCyrYDKM26ykINOaQaamDGSxl3U6SXQPX7t8I7GmBAyn4du8X+OMEFj4qMwwWI1OVaVsYWbTQMg1S9tRGsP8n/LDiC9lJZxwcJ0EaJg9yem5ZyQTZijbY0lHWXbXXqFbvjEHqhR0gRv3t7qNVRrUFo8uEkHrjpu767U/jKy39UusHsNCSLSyuvVPXD9+1mOgcgKf2ZmF+2AGbdZpHPK57B3o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(346002)(136003)(39860400002)(122000001)(66556008)(33656002)(86362001)(38070700005)(316002)(76116006)(2906002)(36756003)(91956017)(66446008)(66476007)(66946007)(64756008)(38100700002)(71200400001)(6916009)(8676002)(5660300002)(8936002)(4326008)(4744005)(6512007)(26005)(6506007)(2616005)(41300700001)(478600001)(6486002)(53546011)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CbKyY5BVNHQiLH9zAygA0M1GsHtZbdkQs+CqCJdrNV7aPPRW/UacC1EhWyA1?=
 =?us-ascii?Q?uk0/JW9ENxuX9KJ5pLUi+4y6UC4+vF5ujN3W2ZCm88KuY1e3zT71PNHpEZaa?=
 =?us-ascii?Q?FZ+d1E2mHGE/nCAZptEq7gWEb3icyh6Q+kNqFn2D0r5TzPqgaoB6EXxT0/6r?=
 =?us-ascii?Q?Ts+SyEwn0O+79Oq/OIfQsIAldSQDuRCuwTB0ByjHUGrQ/1gzcNqrxqFXR3C2?=
 =?us-ascii?Q?zJ08oS/526SpR29noJrTX5IUy5qwFKNhEq1ElJ6YMDqbnM3AWP8iYlb1PToR?=
 =?us-ascii?Q?I8xK2OU9uJL/hvk2LDKwxVCeLD484U3ep8PIQW9RQNcenyiNjLsGMulQ7cqs?=
 =?us-ascii?Q?jsaY8StJ+Qv25HvTIvqh8yiuWBLDwqJlX0TLwrRI8SasWDza3yJE0+N8Ma0n?=
 =?us-ascii?Q?V41qMNyaunv3gBYJjW/5rVU59ft8GnzKATFd96JJhb405dfkQQgFyM8fyy36?=
 =?us-ascii?Q?nXzUJft0hC3kPNhnpYesFnNku0NlJhC8XOSE8gGcmm3+5r+vSjFu6BSes1+a?=
 =?us-ascii?Q?bRHBB5K7Axq80tevzBkM+TYPB+xqTKc32GZc025UJFNt0/UHf/pUaaLz76vd?=
 =?us-ascii?Q?SSjYUPXfeLD0G+2Or9AmxL10a6fVYsWLoYM8TtKYzcId8/Fnih2kOXpqDVAp?=
 =?us-ascii?Q?cObWaEM/jT4K1pvbn763NPxeYgM0APbhT5hxiwyE+HwOJnNPyg6+LwCFIaTG?=
 =?us-ascii?Q?kCjzZqH3nG///42sHW6FS7JVor7C5w6KsDWAovvfXMGHjyR6pU+jIkPq/gcr?=
 =?us-ascii?Q?P0oLeO8+X3IsACRMm4qVubEP1uxtPnk1WEZ0dj9uKX/bjTrgy2W2eh9qk5nW?=
 =?us-ascii?Q?KK+ge8XxD+uwJITs2jfiYp8qXd27VfbhFjmblQeOLkHxZi2Cpv+imZIJLpQF?=
 =?us-ascii?Q?ASUwbabfO68ZdYa+pV/8OqmK4/QC/E04dxMkJY7VX/yUnsdcIGcwXL6HjlIJ?=
 =?us-ascii?Q?bFbYB1z3TYE9nmEmekmGiEeXF2oWUAekUNJJKRUEOUy8xujdc0IgIa1PNExB?=
 =?us-ascii?Q?+8QCF7yv1fvmnl5DLuaEkYIKE+lVd0Us23Dev8nhUpqnlt7EHW4ikCfBv1KY?=
 =?us-ascii?Q?bMYgGcuY8pDi7VBVp2fwiuV6LgJ2COz28UXeXKD3FZ+flyJZ8DxulUo1I7j2?=
 =?us-ascii?Q?EMBPd07NQ0jD08EJcItORPrBzLqmMQTiqNZijW+6frD5gt1IXP3VmnH8qmb2?=
 =?us-ascii?Q?1+fDwdOL6ZRFKQ872BZUezCDxUrXgf+ZOd2El2S27k8qTLS7Fpf/7iE2bc7x?=
 =?us-ascii?Q?f+iYlhFfe0kj3U91+9pU/uL6B3e1rK7OMIjyvFAB9O531jUK0tDpPdOdzCKp?=
 =?us-ascii?Q?1gL4FmzZSZzqcm5a3aydAL4NQOnBDfMvOJHIStvrf9mgRyyYQIrbr8OiXt+A?=
 =?us-ascii?Q?H+2xlntbp2HGbwo8mxhq5ct35M4FYpynFw47Z/bEIUsGGAngYupNn7gsFXCh?=
 =?us-ascii?Q?XkMzkOvTerk6PeIbCxowB/5WFYa0sQeL/b2f5+WCUeoFQfG0ibf7HU6z/vdt?=
 =?us-ascii?Q?JzaQ2FG0mAAbmki8TeaAFfbSJ09ag32wWfucDen6UL3+mT7UTJtTZv2Boox2?=
 =?us-ascii?Q?SxntEeqhxb9KW6xX3lUUPa/KJEv1oE5GsgT/w7GgKHbbATySKLN3UNvh4GOc?=
 =?us-ascii?Q?Tw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <09686FF55841594480E5492A21EA384F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449240b3-8aac-4906-dca5-08da603c114d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 17:13:53.0341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cqSwygJ86z9Z8kxYciag3dtVh60SX9pHjlWfehDmk/oZ2IY8xpt0CY2LRAXp4ODQAtKqwjlGjEy2kEpyEpgz1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6032
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-07_13:2022-06-28,2022-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070068
X-Proofpoint-GUID: 3oDsXSOYZ1J3lyMHAtWDlUmy6LcfTayr
X-Proofpoint-ORIG-GUID: 3oDsXSOYZ1J3lyMHAtWDlUmy6LcfTayr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 7, 2022, at 1:12 PM, Jeff Layton <jlayton@redhat.com> wrote:
>=20
> On Thu, 2022-07-07 at 17:01 +0000, Chuck Lever III wrote:
>>=20
>>> On Jul 7, 2022, at 12:59 PM, Jeff Layton <jlayton@redhat.com> wrote:
>>>=20
>>> One other spot. We also dereference it in nfsd_file_mark_find_or_create=
,
>>> but I think that specific instance is OK. We know that we still hold a
>>> reference to the inode at that point since it comes from fhp->fh_dentry=
,
>>> so we shouldn't need to worry about it disappearing out from under us.
>>=20
>> Needs some annotation. I would prefer not to get that pointer from
>> nf_inode, then. As your comment says: compare only, never deref.
>>=20
>>=20
>=20
> Yeah, maybe we should pass in the inode as a separate parameter to that
> function?

That's what I ended up doing, that seems most clear.


--
Chuck Lever



