Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61934EDBA0
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 16:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiCaOYj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 10:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbiCaOYj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 10:24:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFBF21D7C7
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 07:22:51 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VCQctE030433;
        Thu, 31 Mar 2022 14:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/yI/JCTJx1XvZ+Tt6CTnV+pEC2Nhx/MAJHFGsR87b60=;
 b=ge/0mavxvapt5Lu51RTDTEu/hNwMoys9iSLxgMPE7pmwIJYm1+Kbi+0dxt8s6IEyyknh
 scTNF27l0LNbiSSl9MhZedYJtidjcxU2DJJtu1uQK3H2zoyr9EBdiDwJv10jo6c7Nptx
 Z5SpzaXx0bXg6PYElD+FbiGOqtEpulscxmxLkd3pqApd15MLrFXjjqX2NhEG0chW/WHF
 0s3ksOplz+xLLTrPnekL/E7HY7MXhYbQjoFChSGp3VonzfKbPoPhcaHTS8EPW7wWyAQz
 B/yUVV7VkyjX/8ixGgJy6bCObz7Q0yrRWjLSO8esWemZ8Hh5/GMOrwtK1CZ0Ont82nVa bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0mgnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 14:22:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VEGPd7039203;
        Thu, 31 Mar 2022 14:22:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s97ycf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 14:22:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9vGA83muvTMogTBr1CK70afUPV2aL0ZXDyafA+7pJp1CZatyN5JI+/ky7MoEOQ3tNJcg5nhTcazbFVgtmNdARbtoeugD1x16iO6Fzn6H6K296JsGoVlAq2cz7NdAUvWuMtbHPmYIKxWUyabYEGveeZWCGt1rTO4ju7bS08i+BvgoUDSJeiw+r71FHJThlQ/nd3NboT9FkS9N9fP8odPAr5TQMVhS4B1kKFW8XD6KJpiTKvdO2/tFskiF7BSdfY6q5YiaA3r3oXg/ON2ty3IeW5ciiU2Zzw27jYKypKODf45fT4W1UFn961bbplfRCF9Qk2bm5ECZ47nH7qVnLlXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yI/JCTJx1XvZ+Tt6CTnV+pEC2Nhx/MAJHFGsR87b60=;
 b=KsHb4XyXOcDGz6wfk/+W4QB1ICNv/pW2GyEwUvUKsqPADAFDSgTbHoIffi8K/RT2FIgf/ShX8njd6tYMVWQ9fn+dHgYdhNIhVnm9aFClGN3V5G/7vWwr7T85L1XNt+bGyzPW/n6zhTELut65r8ksAb7ra4n6mgikUEafBuIr2uSYwhXWsNbDYPZX9S0H/A75KaNvutkdRFYaa5wxW1Ty4cdvPTWB/fdpQsJT83dCSfj1AWykGGKY6M99JP9LVJyioecCIVHWJuDcxOoigqgBVN+Wg3Rh3Vo10dx1pv2bNG4JvsD9d8XuJ+bsYsIK/mXlavDsOvToB+oH/0EusVbDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yI/JCTJx1XvZ+Tt6CTnV+pEC2Nhx/MAJHFGsR87b60=;
 b=lMGN9CYJyCAaZYmthlWwCrggoV9VaWuyOvOEkPv1iEWBpxR5P59k3tw19oWPOoAt0Ij3QMW9JU8VSVqGvKVcPDX3a2vpdvb3VxrF3TVA7OSCZG5NVuvz0xo0IU/oMi4dfes/+js5vN+irQTZ8O54XBe1axZediuqc47x+hJG+NA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5103.namprd10.prod.outlook.com (2603:10b6:5:3a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.20; Thu, 31 Mar
 2022 14:22:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%6]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 14:22:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jan Kara <jack@suse.cz>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "nfbrown@suse.com" <nfbrown@suse.com>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: Performance regression with random IO pattern from the client
Thread-Topic: Performance regression with random IO pattern from the client
Thread-Index: AQHYRCHUc6q/mRhCvEKbVzqr4c88IqzYBl4AgAAJ0ICAAAuGAIAAGwaAgABEwICAAP1lgIAAE7gAgAAAr4A=
Date:   Thu, 31 Mar 2022 14:22:38 +0000
Message-ID: <020930EF-E866-40CE-83BA-5539C55C091C@oracle.com>
References: <20220330103457.r4xrhy2d6nhtouzk@quack3.lan>
 <64a4832afd830d7c831ab687bc7a72cc791c2f0c.camel@hammerspace.com>
 <FF014DFC-EC48-4CB7-A3F4-04FBB82E4A27@oracle.com>
 <20220330161952.haopqr342qlij5hg@quack3.lan>
 <FDDB9D43-A695-46A6-9C82-2205C9779957@oracle.com>
 <e5dcbff2ad43304af5039315c00316f2ee5a4e25.camel@hammerspace.com>
 <20220331130935.ejqu3kxsjm2tvlly@quack3.lan>
 <E275D6B3-9F15-4002-9967-B35820A01937@oracle.com>
In-Reply-To: <E275D6B3-9F15-4002-9967-B35820A01937@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99b779c5-2321-405a-54f7-08da1321e89c
x-ms-traffictypediagnostic: DS7PR10MB5103:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5103E1F27F453A399CCB2FD393E19@DS7PR10MB5103.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lcumPvc5M3rIK9kwqO8FLzChnc4b7DqUZpKNi5c9VHZBcOJud6KKbFTdHda+MkQ2YDC4RqiZlBNbsuyZiRkTnyYW4SYeMki0Vgij2TEImhx4PLQr9Yx8PoD9Us53P1vYipPeUAJ2wqDFE4+52naWZuERZKPMBsfgy0POcwxJvZ2Ex2YFKb/+RYqG4YQ8EMwmKF3HAcTaGvZhBlaN66M4Ngs3CmyMZWt0HnGzyQ8y31NfA0PRe+jGZxgkhBkedKfqKOdYDCMwkUjeFN52wY4tNYMQvAJTrLP4Thvv1E3A4kqTicoDXh/uLuECRsHiuqdekZ0C3Ey+vrOQsC0qo1V88zvRVHLLNQ+TZd0T6JuhqjSlCIb1CKmIeX7FvRFA8gxnlB5F2Vm+YZ02rVcvUNn7qap44q9pH3E8LvWn9N/3x7DDPxhlFU/AB6Zbkwrk1kGEiVUIkBETRJW/Sog9NQIgknOKt5W/pJxccH1ujdv6dyW2dw4QlEhn7Q3IjRgzjF5y6yGFld8zGyWLbFCEv5hl1NQaIIVmehGN86GcWlTBNxdzWeX51FX60bm0/Qq8wNWX5da24hpiR2AvkSW/+paltriM6bAbdRmUDrGl6ASRaeogIOWP5MjlDkjfm+CbSMYwL86xXxV2y2n3xvgyjHCRTAf3YLSU6vN3hVkJZeSEuxxhB0VLnPB0vsqyQwfNxJQRUeGSkmtVOzo9KoSTR4KLY7HtZI+3MLCe0pxgiv86MflIaElLeoZtwwIbNtnz7n4d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(66556008)(66446008)(8676002)(66476007)(4326008)(6506007)(76116006)(8936002)(122000001)(66946007)(2616005)(86362001)(91956017)(5660300002)(33656002)(6486002)(53546011)(38070700005)(186003)(26005)(71200400001)(508600001)(54906003)(6916009)(19627235002)(316002)(83380400001)(38100700002)(6512007)(36756003)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vDs1q1XwNenDqJJpN0ahDlsPbI8flcapRpAkGMQ0syisefyBmzjvmomoNd7Q?=
 =?us-ascii?Q?kVG/HwSLx2fyixAIo5ty3ezEfpF8ewYECWWt03WtB9BiEHOgd/slUx1nWGlk?=
 =?us-ascii?Q?2a+eheGe893sh551nxGG6Zc7FM7Zm8hA78/uN+xdQi5tCVkvocrxVBSjRNA4?=
 =?us-ascii?Q?i+FA+WYh9uIunVLHaqvmCQywaCFNs1K15O2VamfkIfcXn5IOOf+xPOHeVXBa?=
 =?us-ascii?Q?kcJ27kjD1OKcPan44TPSamUbZlKrObvB/vY7X2J0TmTWSTOvJNgtHTDsw6hL?=
 =?us-ascii?Q?OU8srOKm2EUtW146ei7DFlcHNoDe+FT1vyb2Y8jncgxV3UX8Nc2azFRFuBzC?=
 =?us-ascii?Q?bB2nE1Q/sxCwy/7HhWMe87jH1eEf/Y8lSc5HKy1FU2D2WMc/oJqWsJZPdTf9?=
 =?us-ascii?Q?d1jMothW/Rz2U07qSlqPbwWZqg1/T3Q3NX4HwqF/g4YrVhWZ/grWD+8Ohq5u?=
 =?us-ascii?Q?zERoTkVwOrEo7j4yyRnu2sXMQLrJqyHLDpXnO+tvZp+x7urY7MMi079IUYLF?=
 =?us-ascii?Q?/DUXsfd/XxeHVJZ0Hqo1t+HRkPJdzYjd8oAXXk7dbZYpd7inwnvKj2GIKNGf?=
 =?us-ascii?Q?bm8uuKZg2D1kLOLU9TBQf5sI+2MFIpnhkUU/bOrA6lASQLJYEkA5xJ59pCrE?=
 =?us-ascii?Q?IVYCdOew9K33nKIPN4O3j4w1Duw2okk8858DyHBlDcOOJqymYHLHb0AMU5VB?=
 =?us-ascii?Q?i0htzt/+6C+oQG75ZaI2aWdkrasPniR9Rt4T6Tyf/wdM455Azi941Zy0aIAB?=
 =?us-ascii?Q?Ql439hxmoHEHqejCfcxW8qrPwK3JC0geW89dVY4fG67B0oCNaGwSRzlgI+nJ?=
 =?us-ascii?Q?3f4Ko/gtI1AxSwZA/zsLeX4rXe9DBFAe6+pjM25EI/SLatwrY4shluQZW36U?=
 =?us-ascii?Q?3biAM8hHEz95RzE1MaE+EU2L0/fWIXrk65kutGkTie9kqfXebOrSWi8czh2V?=
 =?us-ascii?Q?SUcif4PHaHS0vfCZnuz3W3H5KTOpxvv74JdEzOt4YPFf/pLVr56UCa6z4wSz?=
 =?us-ascii?Q?Uyl++gDWZnw/8gprhxfThRC0wRqWMuA/L+XAv/FzfuqpZRZUv9FrjPcuBrZp?=
 =?us-ascii?Q?byDTbpGAjch8TDJzIZnlaRF7aHzD09HRhwHjfJShURaklk+I+eIVUvdo63DF?=
 =?us-ascii?Q?X7FxvA5zIIuqFdIBUN6DUznlb5E0vwsM2J2Fum/ExGqwLM48c5uEN7TtI0Kh?=
 =?us-ascii?Q?54Q1B4QrWGKFpWjEHfZcs0T7YXLUlLe01V0xHoGOA+HcVe6YsxkRDKiL/4sD?=
 =?us-ascii?Q?oMyTBE+whsV0H/7meXAc6JTzoXyU/EVaBn5iOonv55zahknqPsqC8+sR9f7z?=
 =?us-ascii?Q?rCP/e0rHnLFCcOuijNzA/3U3HS5Aic1xLJxjB7Y/JAMeRaptSJ5kbTSjxP4o?=
 =?us-ascii?Q?N2dJsIuWdBXB6fd4DX6Vw1Yaw7ikxCZ/fMkpJV+6S51fDwMakk9M1X00mrW+?=
 =?us-ascii?Q?LRVmwnZ91Y1JTOc8r6pUMZN6ebc5VdKPqq11XMj2FgGQrNNkE86kuEqg239p?=
 =?us-ascii?Q?ykIyAGU7H9RC2s8SWXh7aoz9tf4fIho0Z1gOoBIGNURnhQYDNuha9pLN3tuQ?=
 =?us-ascii?Q?htv9bWS6ClciHvayFPCDhF4SQskp3nfiHHY1ZyvTT/Wtdwnsnk9q0KB1xZSz?=
 =?us-ascii?Q?+n3HsCPdvcoiXW1BKWgsGj8B2t0pOCXJPCqxQm8ZcQwfFjCiWW6MI+bdFuFs?=
 =?us-ascii?Q?vHWTe13W0009aI3Svnkshj+Vbk3V50CRBHhWNFMZWLOtz4/uET6rAqaVIKsZ?=
 =?us-ascii?Q?Qk6RstRXJsGTXIE8cBc1vvkAMukshHk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <028309892F4178409D29365A183DFEA8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b779c5-2321-405a-54f7-08da1321e89c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 14:22:38.2973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kU15UpaSXgf05TJ9mynKV5W+y+VrwmcKsXaNVUsGEsDzQTrd4eYZeBGiMSiUPUfuj3hZn27eQJNHJVZjlKW9iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5103
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310080
X-Proofpoint-ORIG-GUID: X16iAV20z8UWDOw9zyCDJBF5UdG5xO8y
X-Proofpoint-GUID: X16iAV20z8UWDOw9zyCDJBF5UdG5xO8y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

=20

> On Mar 31, 2022, at 10:20 AM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
>=20
>=20
>> On Mar 31, 2022, at 9:09 AM, Jan Kara <jack@suse.cz> wrote:
>>=20
>> On Wed 30-03-22 22:02:39, Trond Myklebust wrote:
>>> On Wed, 2022-03-30 at 17:56 +0000, Chuck Lever III wrote:
>>>>=20
>>>>=20
>>>>> On Mar 30, 2022, at 12:19 PM, Jan Kara <jack@suse.cz> wrote:
>>>>>=20
>>>>> On Wed 30-03-22 15:38:38, Chuck Lever III wrote:
>>>>>>> On Mar 30, 2022, at 11:03 AM, Trond Myklebust
>>>>>>> <trondmy@hammerspace.com> wrote:
>>>>>>>=20
>>>>>>> On Wed, 2022-03-30 at 12:34 +0200, Jan Kara wrote:
>>>>>>>> Hello,
>>>>>>>>=20
>>>>>>>> during our performance testing we have noticed that commit
>>>>>>>> b6669305d35a
>>>>>>>> ("nfsd: Reduce the number of calls to nfsd_file_gc()") has
>>>>>>>> introduced
>>>>>>>> a
>>>>>>>> performance regression when a client does random buffered
>>>>>>>> writes. The
>>>>>>>> workload on NFS client is fio running 4 processed doing
>>>>>>>> random
>>>>>>>> buffered writes to 4
>>>>>>>> different files and the files are large enough to hit dirty
>>>>>>>> limits
>>>>>>>> and
>>>>>>>> force writeback from the client. In particular the invocation
>>>>>>>> is
>>>>>>>> like:
>>>>>>>>=20
>>>>>>>> fio --direct=3D0 --ioengine=3Dsync --thread --directory=3D/mnt/mnt=
1
>>>>>>>> --
>>>>>>>> invalidate=3D1 --group_reporting=3D1 --runtime=3D300 --
>>>>>>>> fallocate=3Dposix --
>>>>>>>> ramp_time=3D10 --name=3DRandomReads-128000-4k-4 --new_group --
>>>>>>>> rw=3Drandwrite --size=3D4000m --numjobs=3D4 --bs=3D4k --
>>>>>>>> filename_format=3DFioWorkloads.\$jobnum --end_fsync=3D1
>>>>>>>>=20
>>>>>>>> The reason why commit b6669305d35a regresses performance is
>>>>>>>> the
>>>>>>>> filemap_flush() call it adds into nfsd_file_put(). Before
>>>>>>>> this commit
>>>>>>>> writeback on the server happened from nfsd_commit() code
>>>>>>>> resulting in
>>>>>>>> rather long semisequential streams of 4k writes. After commit
>>>>>>>> b6669305d35a
>>>>>>>> all the writeback happens from filemap_flush() calls
>>>>>>>> resulting in
>>>>>>>> much
>>>>>>>> longer average seek distance (IO from different files is more
>>>>>>>> interleaved)
>>>>>>>> and about 16-20% regression in the achieved writeback
>>>>>>>> throughput when
>>>>>>>> the
>>>>>>>> backing store is rotational storage.
>>>>>>>>=20
>>>>>>>> I think the filemap_flush() from nfsd_file_put() is indeed
>>>>>>>> rather
>>>>>>>> aggressive and I think we'd be better off to just leave
>>>>>>>> writeback to
>>>>>>>> either
>>>>>>>> nfsd_commit() or standard dirty page cleaning happening on
>>>>>>>> the
>>>>>>>> system. I
>>>>>>>> assume the rationale for the filemap_flush() call was to make
>>>>>>>> it more
>>>>>>>> likely the file can be evicted during the garbage collection
>>>>>>>> run? Was
>>>>>>>> there
>>>>>>>> any particular problem leading to addition of this call or
>>>>>>>> was it
>>>>>>>> just "it
>>>>>>>> seemed like a good idea" thing?
>>>>>>>>=20
>>>>>>>> Thanks in advance for ideas.
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>  Honza
>>>>>>>=20
>>>>>>> It was mainly introduced to reduce the amount of work that
>>>>>>> nfsd_file_free() needs to do. In particular when re-exporting
>>>>>>> NFS, the
>>>>>>> call to filp_close() can be expensive because it synchronously
>>>>>>> flushes
>>>>>>> out dirty pages. That again means that some of the calls to
>>>>>>> nfsd_file_dispose_list() can end up being very expensive
>>>>>>> (particularly
>>>>>>> the ones run by the garbage collector itself).
>>>>>>=20
>>>>>> The "no regressions" rule suggests that some kind of action needs
>>>>>> to be taken. I don't have a sense of whether Jan's workload or
>>>>>> NFS
>>>>>> re-export is the more common use case, however.
>>>>>>=20
>>>>>> I can see that filp_close() on a file on an NFS mount could be
>>>>>> costly if that file has dirty pages, due to the NFS client's
>>>>>> "flush on close" semantic.
>>>>>>=20
>>>>>> Trond, are there alternatives to flushing in the nfsd_file_put()
>>>>>> path? I'm willing to entertain bug fix patches rather than a
>>>>>> mechanical revert of b6669305d35a.
>>>>>=20
>>>>> Yeah, I don't think we need to rush fixing this with a revert.
>>>>=20
>>>> Sorry I wasn't clear: I would prefer to apply a bug fix over
>>>> sending a revert commit, and I do not have enough information
>>>> yet to make that choice. Waiting a bit is OK with me.
>>>>=20
>>>>=20
>>>>> Also because
>>>>> just removing the filemap_flush() from nfsd_file_put() would keep
>>>>> other
>>>>> benefits of that commit while fixing the regression AFAIU. But I
>>>>> think
>>>>> making flushing less aggressive is desirable because as I wrote in
>>>>> my other
>>>>> reply, currently it is preventing pagecache from accumulating
>>>>> enough dirty
>>>>> data for a good IO pattern.
>>>>=20
>>>> I might even go so far as to say that a small write workload
>>>> isn't especially good for solid state storage either.
>>>>=20
>>>> I know Trond is trying to address NFS re-export performance, but
>>>> there appear to be some palpable effects outside of that narrow
>>>> use case that need to be considered. Thus a server-side fix,
>>>> rather than a fix in the NFS client used to do the re-export,
>>>> seems appropriate to consider.
>>>=20
>>> Turns out it is not just the NFS client that is the problem. It is
>>> rather that we need in general to be able to detect flush errors and
>>> either report them directly (through commit) or we need to change the
>>> boot verifier to force clients to resend the unstable writes.
>>>=20
>>> Hence, I think we're looking at something like this:
>>=20
>> Thanks for the fix! I've run the patch through some testing and your fix
>> indeed restores the good IO pattern and returns the performance back to
>> original levels. So feel free to add:
>>=20
>> Tested-by: Jan Kara <jack@suse.cz>
>=20
> Excellent. I'll queue this up in the NFSD tree for 5.17-rc.

Belay that. 5.18-rc.


>>=20
>> 								Honza
>>=20
>>>=20
>>> 8<--------------------------------------------------------------------
>>> From c0c89267f303432c8f5e490ea9b075856e4be79d Mon Sep 17 00:00:00 2001
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> Date: Wed, 30 Mar 2022 16:55:38 -0400
>>> Subject: [PATCH] nfsd: Fix a write performance regression
>>>=20
>>> The call to filemap_flush() in nfsd_file_put() is there to ensure that
>>> we clear out any writes belonging to a NFSv3 client relatively quickly
>>> and avoid situations where the file can't be evicted by the garbage
>>> collector. It also ensures that we detect write errors quickly.
>>>=20
>>> The problem is this causes a regression in performance for some
>>> workloads.
>>>=20
>>> So try to improve matters by deferring writeback until we're ready to
>>> close the file, and need to detect errors so that we can force the
>>> client to resend.
>>>=20
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>> fs/nfsd/filecache.c | 18 +++++++++++++++---
>>> 1 file changed, 15 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index 8bc807c5fea4..9578a6317709 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -235,6 +235,13 @@ nfsd_file_check_write_error(struct nfsd_file *nf)
>>> 	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err)=
);
>>> }
>>>=20
>>> +static void
>>> +nfsd_file_flush(struct nfsd_file *nf)
>>> +{
>>> +	if (nf->nf_file && vfs_fsync(nf->nf_file, 1) !=3D 0)
>>> +		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
>>> +}
>>> +
>>> static void
>>> nfsd_file_do_unhash(struct nfsd_file *nf)
>>> {
>>> @@ -302,11 +309,14 @@ nfsd_file_put(struct nfsd_file *nf)
>>> 		return;
>>> 	}
>>>=20
>>> -	filemap_flush(nf->nf_file->f_mapping);
>>> 	is_hashed =3D test_bit(NFSD_FILE_HASHED, &nf->nf_flags) !=3D 0;
>>> -	nfsd_file_put_noref(nf);
>>> -	if (is_hashed)
>>> +	if (!is_hashed) {
>>> +		nfsd_file_flush(nf);
>>> +		nfsd_file_put_noref(nf);
>>> +	} else {
>>> +		nfsd_file_put_noref(nf);
>>> 		nfsd_file_schedule_laundrette();
>>> +	}
>>> 	if (atomic_long_read(&nfsd_filecache_count) >=3D NFSD_FILE_LRU_LIMIT)
>>> 		nfsd_file_gc();
>>> }
>>> @@ -327,6 +337,7 @@ nfsd_file_dispose_list(struct list_head *dispose)
>>> 	while(!list_empty(dispose)) {
>>> 		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>>> 		list_del(&nf->nf_lru);
>>> +		nfsd_file_flush(nf);
>>> 		nfsd_file_put_noref(nf);
>>> 	}
>>> }
>>> @@ -340,6 +351,7 @@ nfsd_file_dispose_list_sync(struct list_head *dispo=
se)
>>> 	while(!list_empty(dispose)) {
>>> 		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>>> 		list_del(&nf->nf_lru);
>>> +		nfsd_file_flush(nf);
>>> 		if (!refcount_dec_and_test(&nf->nf_ref))
>>> 			continue;
>>> 		if (nfsd_file_free(nf))
>>> --=20
>>> 2.35.1
>>>=20
>>>=20
>>>=20
>>> --=20
>>> Trond Myklebust
>>> Linux NFS client maintainer, Hammerspace
>>> trond.myklebust@hammerspace.com
>>>=20
>>>=20
>> --=20
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR
>=20
> --
> Chuck Lever

--
Chuck Lever



