Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DE3611BAB
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 22:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJ1Uk6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 16:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJ1Uk5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 16:40:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAF422B78B
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 13:40:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SKSjY1005946;
        Fri, 28 Oct 2022 20:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5i1OZqnlyVvoNPhz+v99mzPlrjEdFDiJi6yyY0vcYog=;
 b=d4+jbFIYmo2+uUddoTHYMEZ2PNh+PW+a2fiR0JSWCj6cfmL+PChzDAJfwQVMZcacYyp3
 S66jQ6/yXXW4DGMWAeizsxJRxZnzcprWHBRTjbXNZfwFkwz0ojLtqMu0I8FmRHVtE6kU
 3d1zLrxmXhvANfC6QkeCGdhjawd7P9+IoxavO+dj3KwDgXYIxb8q4enfvTD+1WRTGETq
 IOU5eA6cfAsXQXO7mx8si8UJ5RALe/mJBvuiQe7dw0+ioyLjG/LltIOy7pO2UKrj+k1r
 fQ7lI2hO7/N3WZUa/ydSCnvP4KBhExC7ArxM+QZo7mmO29FYUr/8t025dnAgqKOpV9ms bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfagv68dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 20:39:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SKc5Wm006723;
        Fri, 28 Oct 2022 20:39:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagjdka4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 20:39:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6JM0QJpTnShIGWDFbfFrrTaGXctzl1sLobdWarJk1ie8G8lCoIn6CRzmYWHjAhWAzPpqL1L9J/QSsyZ7h/oqsEfRkPBED8cLmRq0Qcd+89CWnhMOn1KWM1hkCj7ElWbbpbrcTm/Sd9R65YXtuzji03NJY0IhCyzVlwTXE+LqJ4mlRBEfjw04g3jwTF44qG81zkx10ms5YYcgCVY93+PVPKIMW+63fC/oSfeiwY0OUadWfQgMr2tqi8s2qNJjqucMFQ5/wePqueqz2jnITx+/qZeq2Duy5wL2Pz8029bcnmNGFz8ri9XGzakTVI7VDxCcTi4Ybsm/MRy1k3PDMLcsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i1OZqnlyVvoNPhz+v99mzPlrjEdFDiJi6yyY0vcYog=;
 b=VU2lHgPxSyDywJcG5r2TwMoENiW0Cwqu3DTBfW7v/GMXmP6N8psCd6RQM3vWpS8/3HefyssNZnriB7qAPnQ7ShEk6gf1B4gxud8SADz/8jjN7tGAK+mFFekI+NR6kdMMxMa7ypiWDfytyeDydgBuuCNmpSgwTel+XIqqMAAU8Ao8tfbIe/+hNEXs1xxsWVMdlrEHFUMrUoL/DwWgJhfkH2MOaCF/9JCHAtesltd25kY3942r8aGigNdq2P8nYGuIJiWTtcXkhR0eyyntPlDrLvCfUsdSk10TG+detwgXurfUy6WrU6VHkNEIN2bFXWscgAg86+2vBq2h1AP9W69j3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i1OZqnlyVvoNPhz+v99mzPlrjEdFDiJi6yyY0vcYog=;
 b=Gl58LGIG+HxcnupcCDI8G9D7IaY38JVWfMOMEcZCPnZ8hQHWg/GyAXWRLdxB4TuGrwR9pyCogGu4Q2T9hdfhBxJqs6UImRb+uEJFH39o8mhI+qbVAgE8MQuM2pZcqA4tb/sMdZRt5AO87H8MWuNyuEOpoK9LCn+OVZjDgPDZW+4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB5990.namprd10.prod.outlook.com (2603:10b6:8:b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 20:39:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 20:39:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v3 2/4] nfsd: rework refcounting in filecache
Thread-Topic: [PATCH v3 2/4] nfsd: rework refcounting in filecache
Thread-Index: AQHY6v8c+/AX0w4PQ0iPSe2aFwWbQK4kNtsAgAAGgQCAAAduAA==
Date:   Fri, 28 Oct 2022 20:39:36 +0000
Message-ID: <3DD6D3B9-552C-470F-BF54-929497C58A4F@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
 <20221028185712.79863-3-jlayton@kernel.org>
 <96D34180-0E11-4582-8B45-B3FD9CD8F2DB@oracle.com>
 <432239da4d20337f6f14c91f40fb4432e637a662.camel@kernel.org>
In-Reply-To: <432239da4d20337f6f14c91f40fb4432e637a662.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB5990:EE_
x-ms-office365-filtering-correlation-id: db5db796-943a-4460-f45b-08dab9248765
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVRb2jmY1WLl2NarW6LS7P73t5A6G/d4nBxElQw3hbfK7ukvQAxps3L6+87y5n7DHfgdbCSNGtJV7RkIyonNm7CpBjO4bTF7nsp0URFiaakp2JswMx4crQcUyy5W4D9AlIErg6H3mranN3avy1iiNC+n8rk2xG7BdGNVP7JGzlzLPrQRT0oTYy50GEa4SsXUOFeeTGMaMLzAH+9fsu0febm8Hh0uI8UbgwmXLKeUUaQWLT8Ht5N/4q0oSONb5JAU7ypbj/em9mQDMYOqV78D4siMwasrPyp956h5HJwWsrhDhKMFplls7sb2Q6Hj69+NutNRBGn0e0XAgAgRTzxMgltk17vsW3smJq+tCVKfP0PZwQag0DeyFLZ5EN0iLk6rRhckpt0aV+1K6c+UbfJ3xjs9P06e1EPUlXBRLRaefLDf7iHf1WDNYSLIOMQUdLRLHyK8FCJhKRgMvwpaiwvMPKYc6WKuMjFOZPSaGy0WnnVhPudv1r7kVZgwQNEUslSwRXLP1K/D+US4qGohSMyKtrSVK4RReNy5neFV6/j5349ggAp8xGcoX+KBa+WYdtWR+iHnqXXNxfZ5EP2ZvN9j8YKX5AqUqIXJPDJZL05r2HGQLPI5h/vdtmoVpgt2n3d+0UNX5+Pur7fA56sRDP/298UrSy89sXJajZ4Ycuzb/hr1Gjc/P+Q74Oznkxq9pIJHtiEYF6qgVbiRap6Wf5B1p1LHFI1ohPjk9SPUOD6GEi+vuiPcmPI3oRsBqPPuSmyGW3UJSXlT2fXj1N5U+1f4e49ghXYIbEfBCyu21o4gHHk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(36756003)(41300700001)(66899015)(33656002)(6506007)(38070700005)(4326008)(8676002)(122000001)(4001150100001)(2906002)(38100700002)(86362001)(30864003)(5660300002)(8936002)(186003)(83380400001)(53546011)(6916009)(6512007)(54906003)(66556008)(66476007)(66446008)(64756008)(478600001)(2616005)(76116006)(71200400001)(66946007)(26005)(6486002)(316002)(45980500001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ovlsDQ/7ypzDwqehH0+uVPXdcO9SqWZtAXXXGGSUcoIE0ghlR4zWqwz6Wv01?=
 =?us-ascii?Q?OGZd/MLkvnPP8sWRPLKnRrgitlg8jwDibUPZ6/ny/cQ4D+dafDUqIawFwwKK?=
 =?us-ascii?Q?le2ekPWzGN91LTzHSIaLjS7YN1i95C9NrHiTgA0YLyRVMnIa71aHxVFc49j0?=
 =?us-ascii?Q?/VSpQ83gZQ7L47WYpvbjcyFIRUYuFZoGiO6MjmbuT7sWQ1ygPIGbvABjsvVO?=
 =?us-ascii?Q?3cAd5o94W2EeLVmFtq8eWwB0uI/m3jFrR6yeyM25Fu2sYUBCaLOkdcrTXZdc?=
 =?us-ascii?Q?LZHghqKZ1nljKBXKXdeKm96bplWpxJPZc4Zl8rxOlikOr1Xgw4/D6C9fmEzJ?=
 =?us-ascii?Q?ACDB4AnERAO+h92Wk9tibZ9ieA5JpQfW99euVkad4BqofONME/cT9TS7Vsca?=
 =?us-ascii?Q?HO6X+jrt4PodOcvBiTdrseKyobI9nQSMTRh5XJsfgLHStP/208zZUgmilaKp?=
 =?us-ascii?Q?f+LzCY56e5Mbe8VJ1vZSXrZbE6hRFIBKxvPYiQdrB8C3gzPhOWloKUcMOQOo?=
 =?us-ascii?Q?VK5EVm5Vu8Ht/RG8blFzml6XDHiDN6A4xkbjNXwR+izDVJJmMYhaaOLv1q0l?=
 =?us-ascii?Q?kHKqo+Gwn6+Wmy+3NIlgcwtIbSRAoSjPefFlGcC1oAv6WBHaNpIs/V5G6BSa?=
 =?us-ascii?Q?oB+TJKqBWtrIPPmdKR5znusqFVmda3Vyze7vzHz7SST3Oxb5mTECHgmM6ny0?=
 =?us-ascii?Q?VHuCjYlROe3jmyR9RIs+kh/eK0UQrZEI9kKMpNDYFx4OvPdMte2h4cR4wWwP?=
 =?us-ascii?Q?gzGKSHFjJ2yh16eBjsOE7mjmRJfByjY34hFvSZmmI9tDE1B73WO+40hP437K?=
 =?us-ascii?Q?CZpgtuC5mgUd7keLOFCsB+WNKiVKLw29gLyiXlXMfamyeWLJwrHA3NKEWvEP?=
 =?us-ascii?Q?q5IywEhBmqJpt/aJe+IKJJxilXoUmASRA/c4CtxkAFo1/qMxgJ2r+CrlqMjw?=
 =?us-ascii?Q?rGTHMUICPvXghV3CDrjOCEQ4IaIRTSuarJkLTY8ZN2nUmL7njhfU9z3wU8nc?=
 =?us-ascii?Q?eip/C40fDiZAA4NJBMCm6tGD+R8oYcQRnyxpCOasYLU0JjjXdycjWfqvj5ok?=
 =?us-ascii?Q?rDkySehO8ZTBbKWCaHh9Xqw5t382zMod7ckutf0hOXieWahvCrgeI2p12zvw?=
 =?us-ascii?Q?k8GeHNPYscWK7EDISyf+XbY0753KyhUuviKFig5vvckauHonVXo5Hp6OIBeh?=
 =?us-ascii?Q?VmUjW/l5/nmFlWsVfghsgpdiDK7oP2Z+WIfBWYxzGLcCm++wPkvLwoD/Vu7o?=
 =?us-ascii?Q?gM2/j9NsUaz2sDGhEKVuFcAogtMrL6HlPif/ZC5nv/6mVGtI/zqc98pZc+Wl?=
 =?us-ascii?Q?S+i3XL71nW+duvIqwGsJHNWkgho1H7LmXdhpNPXtyLAZkH/xi7xE8MHBELAP?=
 =?us-ascii?Q?/fROo0krSCW+GUY1CWy49DlFWL/kjjl59h/+DnCjN7H/pxz5O/QJYDupoX6b?=
 =?us-ascii?Q?GhYhD3BF1Xup2QVDNDGy8qfi1WLlLnagny6w8euKLoxUjD4bz8IQHvTdr6Ia?=
 =?us-ascii?Q?m+LfBfMXM4IKNwarIFWoypRG3i6LWlna/SDJU1SEOtlqhUgAFt08mfBwcDXE?=
 =?us-ascii?Q?ncgzDkD22AbU8PppyHuTlkOtD1nRn8Tp25fNLkUY/N3GIQHxqRuDTj2Ddrx/?=
 =?us-ascii?Q?tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1DA9F8B1E632384FA238FB6064F5434D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5db796-943a-4460-f45b-08dab9248765
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 20:39:36.7600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: szwpv6zMwUKk4tIAD5toU/D2e/7lb1kvc/eWiyna7Rcp0nlDRjdZmjdSr9h4pP7i9CF9razDU+dJsIo2DWlF6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5990
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280130
X-Proofpoint-ORIG-GUID: ePKfyVoAIPQaMFxT7vNkjwjFM3Xp2Ht6
X-Proofpoint-GUID: ePKfyVoAIPQaMFxT7vNkjwjFM3Xp2Ht6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 28, 2022, at 4:13 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2022-10-28 at 19:49 +0000, Chuck Lever III wrote:
>>=20
>>> On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> The filecache refcounting is a bit non-standard for something searchabl=
e
>>> by RCU, in that we maintain a sentinel reference while it's hashed. Thi=
s
>>> in turn requires that we have to do things differently in the "put"
>>> depending on whether its hashed, which we believe to have led to races.
>>>=20
>>> There are other problems in here too. nfsd_file_close_inode_sync can en=
d
>>> up freeing an nfsd_file while there are still outstanding references to
>>> it, and there are a number of subtle ToC/ToU races.
>>>=20
>>> Rework the code so that the refcount is what drives the lifecycle. When
>>> the refcount goes to zero, then unhash and rcu free the object.
>>>=20
>>> With this change, the LRU carries a reference. Take special care to
>>> deal with it when removing an entry from the list.
>>=20
>> I can see a way of making this patch a lot cleaner. It looks like there'=
s
>> a fair bit of renaming and moving of functions -- that can go in clean
>> up patches before doing the heavy lifting.
>>=20
>=20
> Is this something that's really needed? I'm already basically rewriting
> this code. Reshuffling the old code around first will take a lot of time
> and we'll still end up with the same result.

I did exactly this for the nfs4_file rhash changes. It took just a couple
of hours. The outcome is that you can see exactly, in the final patch in
that series, how the file_hashtbl -> rhltable substitution is done.

Making sure each of the changes is more or less mechanical and obvious
is a good way to ensure no-one is doing something incorrect. That's why
folks like to use cocchinelle.

Trust me, it will be much easier to figure out in a year when we have
new bugs in this code if we split up this commit just a little.


>> I'm still not sold on the idea of a synchronous flush in nfsd_file_free(=
).
>=20
> I think that we need to call this there to ensure that writeback errors
> are handled. I worry that if try to do this piecemeal, we could end up
> missing errors when they fall off the LRU.
>=20
>> That feels like a deadlock waiting to happen and quite difficult to
>> reproduce because I/O there is rarely needed. It could help to put a
>> might_sleep() in nfsd_file_fsync(), at least, but I would prefer not to
>> drive I/O in that path at all.
>=20
> I don't quite grok the potential for a deadlock here. nfsd_file_free
> already has to deal with blocking activities due to it effective doing a
> close(). This is just another one. That's why nfsd_file_put has a
> might_sleep in it (to warn its callers).

Currently nfsd_file_put() calls nfsd_file_flush(), which calls
vfs_fsync(). That can't be called while holding a spinlock.


> What's the deadlock scenario you envision?

OK, filp_close() does call f_op->flush(). So we have this call
here and there aren't problems today. I still say this is a
problem waiting to occur, but I guess I can live with it.

If filp_close() already calls f_op->flush(), why do we need an
explicit vfs_fsync() there?


>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/filecache.c | 357 ++++++++++++++++++++++----------------------
>>> fs/nfsd/trace.h     |   5 +-
>>> 2 files changed, 178 insertions(+), 184 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index f8ebbf7daa18..d928c5e38eeb 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -1,6 +1,12 @@
>>> // SPDX-License-Identifier: GPL-2.0
>>> /*
>>> * The NFSD open file cache.
>>> + *
>>> + * Each nfsd_file is created in response to client activity -- either =
regular
>>> + * file I/O for v2/v3, or opening a file for v4. Files opened via v4 a=
re
>>> + * cleaned up as soon as their refcount goes to 0.  Entries for v2/v3 =
are
>>> + * flagged with NFSD_FILE_GC. On their last put, they are added to the=
 LRU for
>>> + * eventual disposal if they aren't used again within a short time per=
iod.
>>> */
>>>=20
>>> #include <linux/hash.h>
>>> @@ -301,55 +307,22 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key,=
 unsigned int may)
>>> 		if (key->gc)
>>> 			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>>> 		nf->nf_inode =3D key->inode;
>>> -		/* nf_ref is pre-incremented for hash table */
>>> -		refcount_set(&nf->nf_ref, 2);
>>> +		refcount_set(&nf->nf_ref, 1);
>>> 		nf->nf_may =3D key->need;
>>> 		nf->nf_mark =3D NULL;
>>> 	}
>>> 	return nf;
>>> }
>>>=20
>>> -static bool
>>> -nfsd_file_free(struct nfsd_file *nf)
>>> -{
>>> -	s64 age =3D ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
>>> -	bool flush =3D false;
>>> -
>>> -	this_cpu_inc(nfsd_file_releases);
>>> -	this_cpu_add(nfsd_file_total_age, age);
>>> -
>>> -	trace_nfsd_file_put_final(nf);
>>> -	if (nf->nf_mark)
>>> -		nfsd_file_mark_put(nf->nf_mark);
>>> -	if (nf->nf_file) {
>>> -		get_file(nf->nf_file);
>>> -		filp_close(nf->nf_file, NULL);
>>> -		fput(nf->nf_file);
>>> -		flush =3D true;
>>> -	}
>>> -
>>> -	/*
>>> -	 * If this item is still linked via nf_lru, that's a bug.
>>> -	 * WARN and leak it to preserve system stability.
>>> -	 */
>>> -	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
>>> -		return flush;
>>> -
>>> -	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
>>> -	return flush;
>>> -}
>>> -
>>> -static bool
>>> -nfsd_file_check_writeback(struct nfsd_file *nf)
>>> +static void
>>> +nfsd_file_fsync(struct nfsd_file *nf)
>>> {
>>> 	struct file *file =3D nf->nf_file;
>>> -	struct address_space *mapping;
>>>=20
>>> 	if (!file || !(file->f_mode & FMODE_WRITE))
>>> -		return false;
>>> -	mapping =3D file->f_mapping;
>>> -	return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
>>> -		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>>> +		return;
>>> +	if (vfs_fsync(file, 1) !=3D 0)
>>> +		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
>>> }
>>>=20
>>> static int
>>> @@ -362,30 +335,6 @@ nfsd_file_check_write_error(struct nfsd_file *nf)
>>> 	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err)=
);
>>> }
>>>=20
>>> -static void
>>> -nfsd_file_flush(struct nfsd_file *nf)
>>> -{
>>> -	struct file *file =3D nf->nf_file;
>>> -
>>> -	if (!file || !(file->f_mode & FMODE_WRITE))
>>> -		return;
>>> -	if (vfs_fsync(file, 1) !=3D 0)
>>> -		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
>>> -}
>>> -
>>> -static void nfsd_file_lru_add(struct nfsd_file *nf)
>>> -{
>>> -	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
>>> -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
>>> -		trace_nfsd_file_lru_add(nf);
>>> -}
>>> -
>>> -static void nfsd_file_lru_remove(struct nfsd_file *nf)
>>> -{
>>> -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
>>> -		trace_nfsd_file_lru_del(nf);
>>> -}
>>> -
>>> static void
>>> nfsd_file_hash_remove(struct nfsd_file *nf)
>>> {
>>> @@ -408,53 +357,66 @@ nfsd_file_unhash(struct nfsd_file *nf)
>>> }
>>>=20
>>> static void
>>> -nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_head *d=
ispose)
>>> +nfsd_file_free(struct nfsd_file *nf)
>>> {
>>> -	trace_nfsd_file_unhash_and_dispose(nf);
>>> -	if (nfsd_file_unhash(nf)) {
>>> -		/* caller must call nfsd_file_dispose_list() later */
>>> -		nfsd_file_lru_remove(nf);
>>> -		list_add(&nf->nf_lru, dispose);
>>> +	s64 age =3D ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
>>> +
>>> +	trace_nfsd_file_free(nf);
>>> +
>>> +	this_cpu_inc(nfsd_file_releases);
>>> +	this_cpu_add(nfsd_file_total_age, age);
>>> +
>>> +	nfsd_file_unhash(nf);
>>> +	nfsd_file_fsync(nf);
>>> +
>>> +	if (nf->nf_mark)
>>> +		nfsd_file_mark_put(nf->nf_mark);
>>> +	if (nf->nf_file) {
>>> +		get_file(nf->nf_file);
>>> +		filp_close(nf->nf_file, NULL);
>>> +		fput(nf->nf_file);
>>> 	}
>>> +
>>> +	/*
>>> +	 * If this item is still linked via nf_lru, that's a bug.
>>> +	 * WARN and leak it to preserve system stability.
>>> +	 */
>>> +	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
>>> +		return;
>>> +
>>> +	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
>>> }
>>>=20
>>> -static void
>>> -nfsd_file_put_noref(struct nfsd_file *nf)
>>> +static bool
>>> +nfsd_file_check_writeback(struct nfsd_file *nf)
>>> {
>>> -	trace_nfsd_file_put(nf);
>>> +	struct file *file =3D nf->nf_file;
>>> +	struct address_space *mapping;
>>>=20
>>> -	if (refcount_dec_and_test(&nf->nf_ref)) {
>>> -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
>>> -		nfsd_file_lru_remove(nf);
>>> -		nfsd_file_free(nf);
>>> -	}
>>> +	if (!file || !(file->f_mode & FMODE_WRITE))
>>> +		return false;
>>> +	mapping =3D file->f_mapping;
>>> +	return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
>>> +		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>>> }
>>>=20
>>> -static void
>>> -nfsd_file_unhash_and_put(struct nfsd_file *nf)
>>> +static bool nfsd_file_lru_add(struct nfsd_file *nf)
>>> {
>>> -	if (nfsd_file_unhash(nf))
>>> -		nfsd_file_put_noref(nf);
>>> +	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
>>> +	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
>>> +		trace_nfsd_file_lru_add(nf);
>>> +		return true;
>>> +	}
>>> +	return false;
>>> }
>>>=20
>>> -void
>>> -nfsd_file_put(struct nfsd_file *nf)
>>> +static bool nfsd_file_lru_remove(struct nfsd_file *nf)
>>> {
>>> -	might_sleep();
>>> -
>>> -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))
>>> -		nfsd_file_lru_add(nf);
>>> -	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
>>> -		nfsd_file_unhash_and_put(nf);
>>> -
>>> -	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>> -		nfsd_file_flush(nf);
>>> -		nfsd_file_put_noref(nf);
>>> -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
>>> -		nfsd_file_put_noref(nf);
>>> -		nfsd_file_schedule_laundrette();
>>> -	} else
>>> -		nfsd_file_put_noref(nf);
>>> +	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
>>> +		trace_nfsd_file_lru_del(nf);
>>> +		return true;
>>> +	}
>>> +	return false;
>>> }
>>>=20
>>> struct nfsd_file *
>>> @@ -465,36 +427,77 @@ nfsd_file_get(struct nfsd_file *nf)
>>> 	return NULL;
>>> }
>>>=20
>>> -static void
>>> -nfsd_file_dispose_list(struct list_head *dispose)
>>> +/**
>>> + * nfsd_file_unhash_and_queue - unhash a file and queue it to the disp=
ose list
>>> + * @nf: nfsd_file to be unhashed and queued
>>> + * @dispose: list to which it should be queued
>>> + *
>>> + * Attempt to unhash a nfsd_file and queue it to the given list. Each =
file
>>> + * will have a reference held on behalf of the list. That reference ma=
y come
>>> + * from the LRU, or we may need to take one. If we can't get a referen=
ce,
>>> + * ignore it altogether.
>>> + */
>>> +static bool
>>> +nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dis=
pose)
>>> {
>>> -	struct nfsd_file *nf;
>>> +	trace_nfsd_file_unhash_and_queue(nf);
>>> +	if (nfsd_file_unhash(nf)) {
>>> +		/*
>>> +		 * If we remove it from the LRU, then just use that
>>> +		 * reference for the dispose list. Otherwise, we need
>>> +		 * to take a reference. If that fails, just ignore
>>> +		 * the file altogether.
>>> +		 */
>>> +		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
>>> +			return false;
>>> +		list_add(&nf->nf_lru, dispose);
>>> +		return true;
>>> +	}
>>> +	return false;
>>> +}
>>>=20
>>> -	while(!list_empty(dispose)) {
>>> -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>>> -		list_del_init(&nf->nf_lru);
>>> -		nfsd_file_flush(nf);
>>> -		nfsd_file_put_noref(nf);
>>> +/**
>>> + * nfsd_file_put - put the reference to a nfsd_file
>>> + * @nf: nfsd_file of which to put the reference
>>> + *
>>> + * Put a reference to a nfsd_file. In the v4 case, we just put the
>>> + * reference immediately. In the v2/3 case, if the reference would be
>>> + * the last one, the put it on the LRU instead to be cleaned up later.
>>> + */
>>> +void
>>> +nfsd_file_put(struct nfsd_file *nf)
>>> +{
>>> +	trace_nfsd_file_put(nf);
>>> +
>>> +	/*
>>> +	 * The HASHED check is racy. We may end up with the occasional
>>> +	 * unhashed entry on the LRU, but they should get cleaned up
>>> +	 * like any other.
>>> +	 */
>>> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
>>> +	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>> +		/*
>>> +		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
>>> +		 * it to the LRU. If the add to the LRU fails, just put it as
>>> +		 * usual.
>>> +		 */
>>> +		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
>>> +			return;
>>> 	}
>>> +	if (refcount_dec_and_test(&nf->nf_ref))
>>> +		nfsd_file_free(nf);
>>> }
>>>=20
>>> static void
>>> -nfsd_file_dispose_list_sync(struct list_head *dispose)
>>> +nfsd_file_dispose_list(struct list_head *dispose)
>>> {
>>> -	bool flush =3D false;
>>> 	struct nfsd_file *nf;
>>>=20
>>> 	while(!list_empty(dispose)) {
>>> 		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>>> 		list_del_init(&nf->nf_lru);
>>> -		nfsd_file_flush(nf);
>>> -		if (!refcount_dec_and_test(&nf->nf_ref))
>>> -			continue;
>>> -		if (nfsd_file_free(nf))
>>> -			flush =3D true;
>>> +		nfsd_file_free(nf);
>>> 	}
>>> -	if (flush)
>>> -		flush_delayed_fput();
>>> }
>>>=20
>>> static void
>>> @@ -564,21 +567,8 @@ nfsd_file_lru_cb(struct list_head *item, struct li=
st_lru_one *lru,
>>> 	struct list_head *head =3D arg;
>>> 	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_lru);
>>>=20
>>> -	/*
>>> -	 * Do a lockless refcount check. The hashtable holds one reference, s=
o
>>> -	 * we look to see if anything else has a reference, or if any have
>>> -	 * been put since the shrinker last ran. Those don't get unhashed and
>>> -	 * released.
>>> -	 *
>>> -	 * Note that in the put path, we set the flag and then decrement the
>>> -	 * counter. Here we check the counter and then test and clear the fla=
g.
>>> -	 * That order is deliberate to ensure that we can do this locklessly.
>>> -	 */
>>> -	if (refcount_read(&nf->nf_ref) > 1) {
>>> -		list_lru_isolate(lru, &nf->nf_lru);
>>> -		trace_nfsd_file_gc_in_use(nf);
>>> -		return LRU_REMOVED;
>>> -	}
>>> +	/* We should only be dealing with v2/3 entries here */
>>> +	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
>>>=20
>>> 	/*
>>> 	 * Don't throw out files that are still undergoing I/O or
>>> @@ -589,40 +579,30 @@ nfsd_file_lru_cb(struct list_head *item, struct l=
ist_lru_one *lru,
>>> 		return LRU_SKIP;
>>> 	}
>>>=20
>>> +	/* If it was recently added to the list, skip it */
>>> 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
>>> 		trace_nfsd_file_gc_referenced(nf);
>>> 		return LRU_ROTATE;
>>> 	}
>>>=20
>>> -	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>> -		trace_nfsd_file_gc_hashed(nf);
>>> -		return LRU_SKIP;
>>> +	/*
>>> +	 * Put the reference held on behalf of the LRU. If it wasn't the last
>>> +	 * one, then just remove it from the LRU and ignore it.
>>> +	 */
>>> +	if (!refcount_dec_and_test(&nf->nf_ref)) {
>>> +		trace_nfsd_file_gc_in_use(nf);
>>> +		list_lru_isolate(lru, &nf->nf_lru);
>>> +		return LRU_REMOVED;
>>> 	}
>>>=20
>>> +	/* Refcount went to zero. Unhash it and queue it to the dispose list =
*/
>>> +	nfsd_file_unhash(nf);
>>> 	list_lru_isolate_move(lru, &nf->nf_lru, head);
>>> 	this_cpu_inc(nfsd_file_evictions);
>>> 	trace_nfsd_file_gc_disposed(nf);
>>> 	return LRU_REMOVED;
>>> }
>>>=20
>>> -/*
>>> - * Unhash items on @dispose immediately, then queue them on the
>>> - * disposal workqueue to finish releasing them in the background.
>>> - *
>>> - * cel: Note that between the time list_lru_shrink_walk runs and
>>> - * now, these items are in the hash table but marked unhashed.
>>> - * Why release these outside of lru_cb ? There's no lock ordering
>>> - * problem since lru_cb currently takes no lock.
>>> - */
>>> -static void nfsd_file_gc_dispose_list(struct list_head *dispose)
>>> -{
>>> -	struct nfsd_file *nf;
>>> -
>>> -	list_for_each_entry(nf, dispose, nf_lru)
>>> -		nfsd_file_hash_remove(nf);
>>> -	nfsd_file_dispose_list_delayed(dispose);
>>> -}
>>> -
>>> static void
>>> nfsd_file_gc(void)
>>> {
>>> @@ -632,7 +612,7 @@ nfsd_file_gc(void)
>>> 	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
>>> 			    &dispose, list_lru_count(&nfsd_file_lru));
>>> 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
>>> -	nfsd_file_gc_dispose_list(&dispose);
>>> +	nfsd_file_dispose_list_delayed(&dispose);
>>> }
>>>=20
>>> static void
>>> @@ -657,7 +637,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrin=
k_control *sc)
>>> 	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
>>> 				   nfsd_file_lru_cb, &dispose);
>>> 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
>>> -	nfsd_file_gc_dispose_list(&dispose);
>>> +	nfsd_file_dispose_list_delayed(&dispose);
>>> 	return ret;
>>> }
>>>=20
>>> @@ -668,8 +648,11 @@ static struct shrinker	nfsd_file_shrinker =3D {
>>> };
>>>=20
>>> /*
>>> - * Find all cache items across all net namespaces that match @inode an=
d
>>> - * move them to @dispose. The lookup is atomic wrt nfsd_file_acquire()=
.
>>> + * Find all cache items across all net namespaces that match @inode, u=
nhash
>>> + * them, take references and then put them on @dispose if that was suc=
cessful.
>>> + *
>>> + * The nfsd_file objects on the list will be unhashed, and each will h=
ave a
>>> + * reference taken.
>>> */
>>> static unsigned int
>>> __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
>>> @@ -687,52 +670,59 @@ __nfsd_file_close_inode(struct inode *inode, stru=
ct list_head *dispose)
>>> 				       nfsd_file_rhash_params);
>>> 		if (!nf)
>>> 			break;
>>> -		nfsd_file_unhash_and_dispose(nf, dispose);
>>> -		count++;
>>> +
>>> +		if (nfsd_file_unhash_and_queue(nf, dispose))
>>> +			count++;
>>> 	} while (1);
>>> 	rcu_read_unlock();
>>> 	return count;
>>> }
>>>=20
>>> /**
>>> - * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
>>> + * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
>>> * @inode: inode of the file to attempt to remove
>>> *
>>> - * Unhash and put, then flush and fput all cache items associated with=
 @inode.
>>> + * Unhash and put all cache item associated with @inode.
>>> */
>>> -void
>>> -nfsd_file_close_inode_sync(struct inode *inode)
>>> +static unsigned int
>>> +nfsd_file_close_inode(struct inode *inode)
>>> {
>>> -	LIST_HEAD(dispose);
>>> +	struct nfsd_file *nf;
>>> 	unsigned int count;
>>> +	LIST_HEAD(dispose);
>>>=20
>>> 	count =3D __nfsd_file_close_inode(inode, &dispose);
>>> -	trace_nfsd_file_close_inode_sync(inode, count);
>>> -	nfsd_file_dispose_list_sync(&dispose);
>>> +	trace_nfsd_file_close_inode(inode, count);
>>> +	if (count) {
>>> +		while(!list_empty(&dispose)) {
>>> +			nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
>>> +			list_del_init(&nf->nf_lru);
>>> +			trace_nfsd_file_closing(nf);
>>> +			if (refcount_dec_and_test(&nf->nf_ref))
>>> +				nfsd_file_free(nf);
>>> +		}
>>> +	}
>>> +	return count;
>>> }
>>>=20
>>> /**
>>> - * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
>>> + * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
>>> * @inode: inode of the file to attempt to remove
>>> *
>>> - * Unhash and put all cache item associated with @inode.
>>> + * Unhash and put, then flush and fput all cache items associated with=
 @inode.
>>> */
>>> -static void
>>> -nfsd_file_close_inode(struct inode *inode)
>>> +void
>>> +nfsd_file_close_inode_sync(struct inode *inode)
>>> {
>>> -	LIST_HEAD(dispose);
>>> -	unsigned int count;
>>> -
>>> -	count =3D __nfsd_file_close_inode(inode, &dispose);
>>> -	trace_nfsd_file_close_inode(inode, count);
>>> -	nfsd_file_dispose_list_delayed(&dispose);
>>> +	if (nfsd_file_close_inode(inode))
>>> +		flush_delayed_fput();
>>> }
>>>=20
>>> /**
>>> * nfsd_file_delayed_close - close unused nfsd_files
>>> * @work: dummy
>>> *
>>> - * Walk the LRU list and close any entries that have not been used sin=
ce
>>> + * Walk the LRU list and destroy any entries that have not been used s=
ince
>>> * the last scan.
>>> */
>>> static void
>>> @@ -890,7 +880,7 @@ __nfsd_file_cache_purge(struct net *net)
>>> 		while (!IS_ERR_OR_NULL(nf)) {
>>> 			if (net && nf->nf_net !=3D net)
>>> 				continue;
>>> -			nfsd_file_unhash_and_dispose(nf, &dispose);
>>> +			nfsd_file_unhash_and_queue(nf, &dispose);
>>> 			nf =3D rhashtable_walk_next(&iter);
>>> 		}
>>>=20
>>> @@ -1054,8 +1044,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>>> 	rcu_read_lock();
>>> 	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
>>> 			       nfsd_file_rhash_params);
>>> -	if (nf)
>>> -		nf =3D nfsd_file_get(nf);
>>> +	if (nf) {
>>> +		if (!nfsd_file_lru_remove(nf))
>>> +			nf =3D nfsd_file_get(nf);
>>> +	}
>>> 	rcu_read_unlock();
>>> 	if (nf)
>>> 		goto wait_for_construction;
>>> @@ -1090,11 +1082,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
>>> 			goto out;
>>> 		}
>>> 		open_retry =3D false;
>>> -		nfsd_file_put_noref(nf);
>>> +		if (refcount_dec_and_test(&nf->nf_ref))
>>> +			nfsd_file_free(nf);
>>> 		goto retry;
>>> 	}
>>>=20
>>> -	nfsd_file_lru_remove(nf);
>>> 	this_cpu_inc(nfsd_file_cache_hits);
>>>=20
>>> 	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may=
_flags));
>>> @@ -1104,7 +1096,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>>> 			this_cpu_inc(nfsd_file_acquisitions);
>>> 		*pnf =3D nf;
>>> 	} else {
>>> -		nfsd_file_put(nf);
>>> +		if (refcount_dec_and_test(&nf->nf_ref))
>>> +			nfsd_file_free(nf);
>>> 		nf =3D NULL;
>>> 	}
>>>=20
>>> @@ -1131,7 +1124,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>>> 	 * then unhash.
>>> 	 */
>>> 	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
>>> -		nfsd_file_unhash_and_put(nf);
>>> +		nfsd_file_unhash(nf);
>>> 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
>>> 	smp_mb__after_atomic();
>>> 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>> index b09ab4f92d43..a44ded06af87 100644
>>> --- a/fs/nfsd/trace.h
>>> +++ b/fs/nfsd/trace.h
>>> @@ -903,10 +903,11 @@ DEFINE_EVENT(nfsd_file_class, name, \
>>> 	TP_PROTO(struct nfsd_file *nf), \
>>> 	TP_ARGS(nf))
>>>=20
>>> -DEFINE_NFSD_FILE_EVENT(nfsd_file_put_final);
>>> +DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
>>> DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
>>> DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
>>> -DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_dispose);
>>> +DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
>>> +DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
>>>=20
>>> TRACE_EVENT(nfsd_file_alloc,
>>> 	TP_PROTO(
>>> --=20
>>> 2.37.3
>>>=20
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



