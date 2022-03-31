Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5A54EDB9D
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 16:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiCaOWT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 10:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237489AbiCaOWR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 10:22:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BFC1BFDFB
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 07:20:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VCgDfh029854;
        Thu, 31 Mar 2022 14:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0cHOeDhDOg3RKyUdPlQcF6E5b467cuXCAspx9FY6fWs=;
 b=dXHtTzeVxvuxCMnQPbJeiN7BSOTkpBzaKLm+Hd3U1NsXntnoHkZ2lCMp97t1y4KB0HR9
 SAXaaUO6BzP/AAtQofNJRM5/uflum4hji0lMm6WALgispddqCY06c6xzXIKyja+Q3i4p
 4OLM2PXaA1bQSjXEcmjFotWnmtr/jCsciaBbQqE0G8XgvR5GbuWLtjbCbfXdTUS7zhhp
 9zoCMsEq4JjZ/XGyGi1ji6m4MHbR1nRJXnH3PuiiT4+DXg0ldl2XDOjA+KPdoAJDv2gk
 amtmnyOP86yyhtJA++cqMyCkgLQWrMX3MmMu5lEYyLYECfiZSFCrlJC/pZjnZG57n7Il bQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqbc9gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 14:20:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VEGYsM023793;
        Thu, 31 Mar 2022 14:20:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s94pcce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 14:20:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYJid2hyap+OgzDGKaNxoYoix0qZz4xUL+a/pQH7cEQJ9qkjDZwqf5rztntyLbjHF2f/yaCy8LxUaso+pfAW1R8cI1po8X2qw3I3kmg78PRMOzCiu/GVWaFpbTlmVzakBqX4N+UvTSluxK5d9ZWycVNI4adsC7SbzOeCkrdtlQ31z9a46cfXO7Lvkqr6A8fEPYxWGxM3imDjpj5wPEaFTFPlYlBgmqByLDOtfWKAgI3KjbXM2tQNxKjDb3ivYAIvzwTOHngyUImOB20MRFQ9oVBxUMafjSmbJa5zTCawok9CTISVHrYh6xCx4n163CSWbeAT7vLL0IRFqM1PB8MWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cHOeDhDOg3RKyUdPlQcF6E5b467cuXCAspx9FY6fWs=;
 b=YdEsbWKnSA9xOZ7nREWdY41Pc3CRPdAKAswQ4mZZTYMHdQYxNFgOgCXRclYyF2q3fCmi0kDC45NxVZ/2rU0d90SpOrha69d2aFFsAA63sjHjKkToaQCDXebMPKvwgaUXKOQq9pN/HuvW8kUhjhGxa38Wecr5q0IUpV6GXQE/GXsMEPSdjc3/ZlnN6UgxVBIPpwIu7Z6M/iRCi+HP50K3NzL/rvxZMU4EE6VBAZiMd85yR65l8fR0H32GhxEPFxBl9UX7uLCGf+bYWGvGLvVpL+puAW0S9aOTgRBBncErLN/X6fN1gjV5GBaK473PtEUxA3V3vxTRbxrgiPcK9rN5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cHOeDhDOg3RKyUdPlQcF6E5b467cuXCAspx9FY6fWs=;
 b=m8achExgCsuu4qa9bziO3k0T35+TuJ/0w3ol263kOqMg06KxVJuarKrHoMOdGTIK5IjattYS49WSaXE0wRKNjsEVW4nmmWiCqpJ7ycQlhi8Kd/nVmXphhhweqjOfkLjfHSibsTfgipk+Vw7lYq4Sw5ZvkzVpqB2R5ZrE8APhKQ8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL0PR10MB2852.namprd10.prod.outlook.com (2603:10b6:208:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 31 Mar
 2022 14:20:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%6]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 14:20:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jan Kara <jack@suse.cz>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "nfbrown@suse.com" <nfbrown@suse.com>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: Performance regression with random IO pattern from the client
Thread-Topic: Performance regression with random IO pattern from the client
Thread-Index: AQHYRCHUc6q/mRhCvEKbVzqr4c88IqzYBl4AgAAJ0ICAAAuGAIAAGwaAgABEwICAAP1lgIAAE7gA
Date:   Thu, 31 Mar 2022 14:20:11 +0000
Message-ID: <E275D6B3-9F15-4002-9967-B35820A01937@oracle.com>
References: <20220330103457.r4xrhy2d6nhtouzk@quack3.lan>
 <64a4832afd830d7c831ab687bc7a72cc791c2f0c.camel@hammerspace.com>
 <FF014DFC-EC48-4CB7-A3F4-04FBB82E4A27@oracle.com>
 <20220330161952.haopqr342qlij5hg@quack3.lan>
 <FDDB9D43-A695-46A6-9C82-2205C9779957@oracle.com>
 <e5dcbff2ad43304af5039315c00316f2ee5a4e25.camel@hammerspace.com>
 <20220331130935.ejqu3kxsjm2tvlly@quack3.lan>
In-Reply-To: <20220331130935.ejqu3kxsjm2tvlly@quack3.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7652e44f-94bb-4217-dbfd-08da13219108
x-ms-traffictypediagnostic: BL0PR10MB2852:EE_
x-microsoft-antispam-prvs: <BL0PR10MB28520F14F402B4A6107463BC93E19@BL0PR10MB2852.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q/gv+GUjmIo4OkvPJLiS4V0Qc+g3sP9CS/AX2It1C6vxI/t5IhHpflcIVXcfbYpZXkbjlTEk0KTTDvRXPxNwvibyOkdbUXcBG/A56KIwlIrNG2iNHUmtBCIP13ygHO64ZQA7ONLi5T7heoS+CZpFGbG2HdtYOINzoWaLpcc7D5nPVst4vNVzFa7VHqvNubybp4Cg79WYVBochEjubR3+eeXzHW3T49U+YOx11/1sDZMEkgjVKQiQ+EZ/faGhuSp0ybcrogq+x+G2GukvK6XLz033CpxPhLmDxCSzMR7+Q0DlYFJyzJX6niwXBoQhAyWNcvj7iyHgnfRC/oFi0tVsP/HUmY/yq4vTQB6htrzUduYZXNgWrMtMVzQ9P8Wm8HnYd0M8/hUhOaEabB1VXwwhV/MACmIhCWG0dGjvpz9tgB8gmC6V+AyE6hhTbIfek2qx7wmI7VnyepodULwJUnuRqkl/CdcEg6+WBvS4OAMdQG2HYvzJqzeZ+jqC1w7j9c9muQgb1ClruZzf0GMkRNaSmlMDvfNLIQp/CgCYd90422IPrlfL9Angje6CFycXPgWuz8NXdeFRDs/HHd2cbBNNP5b7nGGzkah5dZiWUq/JiQcD/9TaZmcXnJNv7SwQfDxh7XIXKdPtR8eH8UlTi/el8/YD4YTF2NX+k6FNT5RWMgp1e3/KJrMv0PGnM10WomkOqga4/Q1BJNWn+mf95R8Bkkkbs42e6ZepIZhXT/MV0UJv3JQegcAxyX/47EcPSyz7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(122000001)(38100700002)(6916009)(86362001)(19627235002)(36756003)(54906003)(38070700005)(8676002)(316002)(91956017)(33656002)(508600001)(5660300002)(66946007)(66476007)(53546011)(8936002)(66446008)(26005)(76116006)(4326008)(64756008)(66556008)(186003)(6486002)(2616005)(6512007)(2906002)(6506007)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xV3CmJ31YaQ9pG03fjqb7s/9N5TwKWg6Q77808QBpv+WL4mRNWw2AR/l2r8g?=
 =?us-ascii?Q?1RkvzebwEztGq2y9R4X/G1C4PiXQ53tK8QhaO+zS9W2bXG57WbeFgYC7NQnc?=
 =?us-ascii?Q?c0GLS7mQsbJZEtcXMw3L7ELobZdy7J+zSByOb5ZTg4fuVjK46k3AMRQXfLqv?=
 =?us-ascii?Q?sV9QDrhnhdlnJpGiBf+NvKdeo6SFF9ya1Z3ZsH787jo4gwQxbfyiVv/bZvCv?=
 =?us-ascii?Q?yG8EQvRYouozkTA5qpRMLI22OdmG1ZGEBVncPYZlfb12m0KY2fbewuqNQqI6?=
 =?us-ascii?Q?mtTEZo1W678iMCVkkkqvDzV3BGuB8ON0S2IKI/jAwtZ7VzD9OXiJEXkLH0D9?=
 =?us-ascii?Q?aXIPezIGLvsvtiiFKmVMz5mcN8ooGxEQrm+XksBSIbnGuT5lojtZiU+A1rWV?=
 =?us-ascii?Q?nA+CtvYYFBtWmUVSJ6OZZayirxj7pRxcYhDDEey13SxaIJHZRmBZsafJbEYN?=
 =?us-ascii?Q?oDe9BGDcmsWq52+Cp/6OMajXwLItJjA7i5kM+L8qGMETbddQH0o1tFCyr0Au?=
 =?us-ascii?Q?dm/U3yesTJDzdYcD/VFAIBbSY7Xtxmk+HJs0E5PsAfUUjruTyJd2JRJ6dr7N?=
 =?us-ascii?Q?5hE46UXIOEcpqHuL8FYM22gRgRNlJ9olDOFxZmrgshMQKOmHS8FgBGpRNmLC?=
 =?us-ascii?Q?jHmb+OzU3+z1GEGIXc0vvMU4OjZsHBXbvaoNA3q7zy55+5r4QG/AYpBYL2vQ?=
 =?us-ascii?Q?daEXFdUc0Dd46uTvOstk2wYnEno5onmZwwcOZ5kYaX81m6/T9Sv1d+Ra7Rso?=
 =?us-ascii?Q?pzFvKVa1j56ddyWMg9bCSkvAkl6VlPDwhwf58zS7NeTteJevuEdt8Mej7Gwn?=
 =?us-ascii?Q?1PkR3ozz/kS+w8cef/3hnX2iy8HiLtDo9Y3gcywbuL3f5MrbVNt/Nn4gs7qM?=
 =?us-ascii?Q?9mfpTNEsLZXliM0f2z9QuVI1bxR/OjckBZWCvZm6UbcgGhiJDDrBdJtK6PpB?=
 =?us-ascii?Q?7apWlw0bz/SI1sLUiDEtJGKbTEaU9VSdciGRa/NiI+k+NZ3Whgwla/fknRgu?=
 =?us-ascii?Q?FKR+/dw8aw03uc5LqcaantKxIgVBIn16iFIW80OxDSQm0+qdbIQ/eF1lfCGQ?=
 =?us-ascii?Q?yGqWn6A2kffUAQlA2uOPc4kVjo0UWHlEgJMWjypXCgfTNaPIhB14y4ReHhI4?=
 =?us-ascii?Q?KFslXN/B1dg7EGxl3c/X8Npm1s6HlCdj33vdmrk0OFF++vdb1r7XxFK4U1aA?=
 =?us-ascii?Q?QIUAr2ORDjOizMC0GPBki6i7agVn99/NdvP0qkoy4Gv2OxedkrIpVGMBmVhy?=
 =?us-ascii?Q?yxNzxTZZCa2wQYj9H7wD47+gLS+L3bH0Wd1RkeIdVOUOdFu+EKh5BYIqdWwS?=
 =?us-ascii?Q?m5xGwnsc9K1vvt5XMC65iQAcXsdFqSnwVq9fNgaSCQNaXwgq5kpXhp+pzph/?=
 =?us-ascii?Q?LQDdsDlMoClvAXAmGqBzm7VX5pqf96px7hzsonV9lxkZZJ+oWPwjOwTCV9cl?=
 =?us-ascii?Q?3GLKAPNvLwSbUCqlQLC6n2dIAI3/1Dx+sA+RA2lDC9N9+MP4/GgXSAvfYRpm?=
 =?us-ascii?Q?9a9izSfPHca9YfYbOmEM1AMR0uCLkKwBiscYJ1KoKAUxUKEtsS7ElcLc2pis?=
 =?us-ascii?Q?bp7FzStpbk+4uWnLJM/U1um8KUK9HIVimCfjm1+rIN+CtXfaOBioh7Zb+eMZ?=
 =?us-ascii?Q?PBL5EUQShnH74TwdRU6TS16+cUl96qyRro7TsIMA7PzdwRKBoMguC6cPLNcx?=
 =?us-ascii?Q?N6ofR9dyC8SZ8wcHw5+pi/6RBgXcfJ5506QSg7SEYq5+lMvy7jMe0yIgp2YB?=
 =?us-ascii?Q?nes+rBa/GbAiNDW59/PXIN793zSAr4g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C920F64DBE246D48AB750B3B135B49B8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7652e44f-94bb-4217-dbfd-08da13219108
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 14:20:11.3222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3c5uXfXZNp2ww0t8TWgGHOglyp5AmNl1uADgvwCNib7PUZ3kzcceJByyXl1vMGOgEbU0DNXzSpM0MsDevxwcQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2852
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310080
X-Proofpoint-GUID: kGgYtcv7xfngDtcMt9bWOBOGV8LDSesx
X-Proofpoint-ORIG-GUID: kGgYtcv7xfngDtcMt9bWOBOGV8LDSesx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 31, 2022, at 9:09 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> On Wed 30-03-22 22:02:39, Trond Myklebust wrote:
>> On Wed, 2022-03-30 at 17:56 +0000, Chuck Lever III wrote:
>>>=20
>>>=20
>>>> On Mar 30, 2022, at 12:19 PM, Jan Kara <jack@suse.cz> wrote:
>>>>=20
>>>> On Wed 30-03-22 15:38:38, Chuck Lever III wrote:
>>>>>> On Mar 30, 2022, at 11:03 AM, Trond Myklebust
>>>>>> <trondmy@hammerspace.com> wrote:
>>>>>>=20
>>>>>> On Wed, 2022-03-30 at 12:34 +0200, Jan Kara wrote:
>>>>>>> Hello,
>>>>>>>=20
>>>>>>> during our performance testing we have noticed that commit
>>>>>>> b6669305d35a
>>>>>>> ("nfsd: Reduce the number of calls to nfsd_file_gc()") has
>>>>>>> introduced
>>>>>>> a
>>>>>>> performance regression when a client does random buffered
>>>>>>> writes. The
>>>>>>> workload on NFS client is fio running 4 processed doing
>>>>>>> random
>>>>>>> buffered writes to 4
>>>>>>> different files and the files are large enough to hit dirty
>>>>>>> limits
>>>>>>> and
>>>>>>> force writeback from the client. In particular the invocation
>>>>>>> is
>>>>>>> like:
>>>>>>>=20
>>>>>>> fio --direct=3D0 --ioengine=3Dsync --thread --directory=3D/mnt/mnt1
>>>>>>> --
>>>>>>> invalidate=3D1 --group_reporting=3D1 --runtime=3D300 --
>>>>>>> fallocate=3Dposix --
>>>>>>> ramp_time=3D10 --name=3DRandomReads-128000-4k-4 --new_group --
>>>>>>> rw=3Drandwrite --size=3D4000m --numjobs=3D4 --bs=3D4k --
>>>>>>> filename_format=3DFioWorkloads.\$jobnum --end_fsync=3D1
>>>>>>>=20
>>>>>>> The reason why commit b6669305d35a regresses performance is
>>>>>>> the
>>>>>>> filemap_flush() call it adds into nfsd_file_put(). Before
>>>>>>> this commit
>>>>>>> writeback on the server happened from nfsd_commit() code
>>>>>>> resulting in
>>>>>>> rather long semisequential streams of 4k writes. After commit
>>>>>>> b6669305d35a
>>>>>>> all the writeback happens from filemap_flush() calls
>>>>>>> resulting in
>>>>>>> much
>>>>>>> longer average seek distance (IO from different files is more
>>>>>>> interleaved)
>>>>>>> and about 16-20% regression in the achieved writeback
>>>>>>> throughput when
>>>>>>> the
>>>>>>> backing store is rotational storage.
>>>>>>>=20
>>>>>>> I think the filemap_flush() from nfsd_file_put() is indeed
>>>>>>> rather
>>>>>>> aggressive and I think we'd be better off to just leave
>>>>>>> writeback to
>>>>>>> either
>>>>>>> nfsd_commit() or standard dirty page cleaning happening on
>>>>>>> the
>>>>>>> system. I
>>>>>>> assume the rationale for the filemap_flush() call was to make
>>>>>>> it more
>>>>>>> likely the file can be evicted during the garbage collection
>>>>>>> run? Was
>>>>>>> there
>>>>>>> any particular problem leading to addition of this call or
>>>>>>> was it
>>>>>>> just "it
>>>>>>> seemed like a good idea" thing?
>>>>>>>=20
>>>>>>> Thanks in advance for ideas.
>>>>>>>=20
>>>>>>>                                                             =20
>>>>>>>   Honza
>>>>>>=20
>>>>>> It was mainly introduced to reduce the amount of work that
>>>>>> nfsd_file_free() needs to do. In particular when re-exporting
>>>>>> NFS, the
>>>>>> call to filp_close() can be expensive because it synchronously
>>>>>> flushes
>>>>>> out dirty pages. That again means that some of the calls to
>>>>>> nfsd_file_dispose_list() can end up being very expensive
>>>>>> (particularly
>>>>>> the ones run by the garbage collector itself).
>>>>>=20
>>>>> The "no regressions" rule suggests that some kind of action needs
>>>>> to be taken. I don't have a sense of whether Jan's workload or
>>>>> NFS
>>>>> re-export is the more common use case, however.
>>>>>=20
>>>>> I can see that filp_close() on a file on an NFS mount could be
>>>>> costly if that file has dirty pages, due to the NFS client's
>>>>> "flush on close" semantic.
>>>>>=20
>>>>> Trond, are there alternatives to flushing in the nfsd_file_put()
>>>>> path? I'm willing to entertain bug fix patches rather than a
>>>>> mechanical revert of b6669305d35a.
>>>>=20
>>>> Yeah, I don't think we need to rush fixing this with a revert.
>>>=20
>>> Sorry I wasn't clear: I would prefer to apply a bug fix over
>>> sending a revert commit, and I do not have enough information
>>> yet to make that choice. Waiting a bit is OK with me.
>>>=20
>>>=20
>>>> Also because
>>>> just removing the filemap_flush() from nfsd_file_put() would keep
>>>> other
>>>> benefits of that commit while fixing the regression AFAIU. But I
>>>> think
>>>> making flushing less aggressive is desirable because as I wrote in
>>>> my other
>>>> reply, currently it is preventing pagecache from accumulating
>>>> enough dirty
>>>> data for a good IO pattern.
>>>=20
>>> I might even go so far as to say that a small write workload
>>> isn't especially good for solid state storage either.
>>>=20
>>> I know Trond is trying to address NFS re-export performance, but
>>> there appear to be some palpable effects outside of that narrow
>>> use case that need to be considered. Thus a server-side fix,
>>> rather than a fix in the NFS client used to do the re-export,
>>> seems appropriate to consider.
>>=20
>> Turns out it is not just the NFS client that is the problem. It is
>> rather that we need in general to be able to detect flush errors and
>> either report them directly (through commit) or we need to change the
>> boot verifier to force clients to resend the unstable writes.
>>=20
>> Hence, I think we're looking at something like this:
>=20
> Thanks for the fix! I've run the patch through some testing and your fix
> indeed restores the good IO pattern and returns the performance back to
> original levels. So feel free to add:
>=20
> Tested-by: Jan Kara <jack@suse.cz>

Excellent. I'll queue this up in the NFSD tree for 5.17-rc.


>=20
> 								Honza
>=20
>>=20
>> 8<--------------------------------------------------------------------
>> From c0c89267f303432c8f5e490ea9b075856e4be79d Mon Sep 17 00:00:00 2001
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>> Date: Wed, 30 Mar 2022 16:55:38 -0400
>> Subject: [PATCH] nfsd: Fix a write performance regression
>>=20
>> The call to filemap_flush() in nfsd_file_put() is there to ensure that
>> we clear out any writes belonging to a NFSv3 client relatively quickly
>> and avoid situations where the file can't be evicted by the garbage
>> collector. It also ensures that we detect write errors quickly.
>>=20
>> The problem is this causes a regression in performance for some
>> workloads.
>>=20
>> So try to improve matters by deferring writeback until we're ready to
>> close the file, and need to detect errors so that we can force the
>> client to resend.
>>=20
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>> fs/nfsd/filecache.c | 18 +++++++++++++++---
>> 1 file changed, 15 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index 8bc807c5fea4..9578a6317709 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -235,6 +235,13 @@ nfsd_file_check_write_error(struct nfsd_file *nf)
>> 	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err))=
;
>> }
>>=20
>> +static void
>> +nfsd_file_flush(struct nfsd_file *nf)
>> +{
>> +	if (nf->nf_file && vfs_fsync(nf->nf_file, 1) !=3D 0)
>> +		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
>> +}
>> +
>> static void
>> nfsd_file_do_unhash(struct nfsd_file *nf)
>> {
>> @@ -302,11 +309,14 @@ nfsd_file_put(struct nfsd_file *nf)
>> 		return;
>> 	}
>>=20
>> -	filemap_flush(nf->nf_file->f_mapping);
>> 	is_hashed =3D test_bit(NFSD_FILE_HASHED, &nf->nf_flags) !=3D 0;
>> -	nfsd_file_put_noref(nf);
>> -	if (is_hashed)
>> +	if (!is_hashed) {
>> +		nfsd_file_flush(nf);
>> +		nfsd_file_put_noref(nf);
>> +	} else {
>> +		nfsd_file_put_noref(nf);
>> 		nfsd_file_schedule_laundrette();
>> +	}
>> 	if (atomic_long_read(&nfsd_filecache_count) >=3D NFSD_FILE_LRU_LIMIT)
>> 		nfsd_file_gc();
>> }
>> @@ -327,6 +337,7 @@ nfsd_file_dispose_list(struct list_head *dispose)
>> 	while(!list_empty(dispose)) {
>> 		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>> 		list_del(&nf->nf_lru);
>> +		nfsd_file_flush(nf);
>> 		nfsd_file_put_noref(nf);
>> 	}
>> }
>> @@ -340,6 +351,7 @@ nfsd_file_dispose_list_sync(struct list_head *dispos=
e)
>> 	while(!list_empty(dispose)) {
>> 		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>> 		list_del(&nf->nf_lru);
>> +		nfsd_file_flush(nf);
>> 		if (!refcount_dec_and_test(&nf->nf_ref))
>> 			continue;
>> 		if (nfsd_file_free(nf))
>> --=20
>> 2.35.1
>>=20
>>=20
>>=20
>> --=20
>> Trond Myklebust
>> Linux NFS client maintainer, Hammerspace
>> trond.myklebust@hammerspace.com
>>=20
>>=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

--
Chuck Lever



