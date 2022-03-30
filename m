Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5244ECB26
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 19:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349575AbiC3R6h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Mar 2022 13:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349534AbiC3R6g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Mar 2022 13:58:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8E2106629
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 10:56:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22UFOpDB027875;
        Wed, 30 Mar 2022 17:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=d3nX8N+2HMQALR1dgOrRIT/NZXS7M4Ls5yFCPC8/C5g=;
 b=kIXFD23l+WyEfHJbSgrrYrUGU+zFiApY0O2ch3L6rEYUqyttpljsbYg1e2E9wCusP8V+
 /N7RW7sYwZcFwookUjyQzcugm4/3+Vsq/5KyYI8OXjUdfUv1aGy0kUEbY800EXD1b0f0
 x+GvL1IF9zCFOEdELybOBmLLY/oM29LTdq464D5fdy2Zu+ELjQJAzoq2TFFNQAnrq61e
 faKtgfSKTl60c0ej237V/fR2Oi7S4b9OuU4pdmorBOdFT53s6/uhSe57DrtwO3BpVpXK
 VjFmd6EPxDKvy24fyoQes/qd1tXtqFefoIQ1PwMRq3b7RD5GTPElH6pjqMFfhlbsltN3 +w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2j8t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 17:56:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22UHaUJm018036;
        Wed, 30 Mar 2022 17:56:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s94ep5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 17:56:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MskdODvmkoOlqff9WS8of3WaJOWF5EumOBKpZFXe41LjYQ2/+9PsfDXj/NEkseAd7lqoyqzvaQnfKOcuiqULD8NxnQyI5gUt5lT1DIVyepZC//sWmE+Zi+WJltck0v0U7RMDd7pZQR0OBeBKCoj/mESyQaJp9+jTKoOTy5/e3cwOylZNIVQFJmcehxlRc8m8qgpyE0SNxyaS8/62j46ZKsbZP7cAeYnxb8ewwqLJha0JmcW8U1u1aWw17UWJpg8hwJzyRIikS2K81FBZrssrWJiaoRcd8/XC7m975aHHPw+H+2d4bq4U1xDJ/5XL/4m8thI4/7EiP8Nhr+j/YjzyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3nX8N+2HMQALR1dgOrRIT/NZXS7M4Ls5yFCPC8/C5g=;
 b=gQ2F1MPLwFZO64GhHMc+wMb3PqUPgmLFRXd0ekR4N5kzvAojTzdNr2fHsT/5nYihah22JB1MYSyx2GbSkY1hYkhA7FQma5zyOcO+tEfeMsC+pe17AxsmM4AW90dIWbNAV/rOPZ5yTP7cyskI4/jRrwd4VvZ6b1ao2QQkyUCXbGXzYG7PpW34urHN+g/wOxbiD816cr2B0yOZRbamwxQ7Pt9eBk3X3eAFAU3wbnUZ/IpxsHbLu5/q/5AmULMDWafN15DEDIeE28DyA6BhFXcw+nV+N4Ylgrk+xhattNwtMIFb1MdJ39yY9kxTMHQxecbudkLaFSPSXk+OwPBExybTJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3nX8N+2HMQALR1dgOrRIT/NZXS7M4Ls5yFCPC8/C5g=;
 b=Vk1kZxuyGRhnkNwE7Pf6p1RLs/nh9p4U/EWu5sONbC1ldcxaMVGJ0iSRN4/CT91sSzXKJWD0EE+eixmrvkEsfJResWACC+MivzYG+496HJpQ9xdXBVSFrdHOT70oP+CWW/TDnOsfAwEgmWnZ/HJCsW0Wg5Q8RloQ8IYKdjbs/RU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB3578.namprd10.prod.outlook.com (2603:10b6:5:179::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.18; Wed, 30 Mar
 2022 17:56:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%6]) with mapi id 15.20.5123.020; Wed, 30 Mar 2022
 17:56:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jan Kara <jack@suse.cz>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "nfbrown@suse.com" <nfbrown@suse.com>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: Performance regression with random IO pattern from the client
Thread-Topic: Performance regression with random IO pattern from the client
Thread-Index: AQHYRCHUc6q/mRhCvEKbVzqr4c88IqzYBl4AgAAJ0ICAAAuGAIAAGwaA
Date:   Wed, 30 Mar 2022 17:56:36 +0000
Message-ID: <FDDB9D43-A695-46A6-9C82-2205C9779957@oracle.com>
References: <20220330103457.r4xrhy2d6nhtouzk@quack3.lan>
 <64a4832afd830d7c831ab687bc7a72cc791c2f0c.camel@hammerspace.com>
 <FF014DFC-EC48-4CB7-A3F4-04FBB82E4A27@oracle.com>
 <20220330161952.haopqr342qlij5hg@quack3.lan>
In-Reply-To: <20220330161952.haopqr342qlij5hg@quack3.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0768c184-cd88-4443-f4c6-08da1276a227
x-ms-traffictypediagnostic: DM6PR10MB3578:EE_
x-microsoft-antispam-prvs: <DM6PR10MB357817BB840BF0A08D68A8B0931F9@DM6PR10MB3578.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e0D+0NvVVp6neLg3OGL6MXEoUvcWbY54jSMQJF9M6P96ax6bfdynDZPaaUBfw2EbXMBE2s+Eq7gXpNcuD8mO3lwPo9qGRYYMNk4hojSf5MCgACeJEBMLoF4rkxxrWujuQJ97+QWTrDnXnr8A95J2ZGOFPoE8c7FZj1qDyPrrXrzgIloXyFm/pmbiJl2FpBgmgwg681qflwjLs3k38IfSIF0By1fHxgfdacX8THQdzXrNiCJDkZRHwSDxbLifNaZ1musBAMPDjNlRV6dOP99in04Bb9v4aySDTx4NjIu8TdD8RY3XJsGMWpjkLnjAtSf/+2QRli+RIFq8fqxihtNy5SrO8+0ans7/oyxwcC8jWcMEzeOX71WhDLR+4Pb2HLVHZPbGcYBNqlw1noSORzeW7wdl8GQs4H7Cc4zbWJmxYKNtoq5ccOGt43cW7xpCKKJNhhg+hNZi4jG2FX5trJQ6vPI5SM+SsE6Vi+trQzfwuZAZQKAadpehhHPwkn3fHI4m8msnCBD2vQvZDze/C2jMSvpQXsgEQ7q1cTgJtLoSNMhO1jye3bgdk9EPrrXwmTv+Re4O3VPls4yOQpElb2/n2QICAKaac9b6Fo6cwPxKavRKRTd4lcopCgjhJbYWLyLHIhAaZaTdp9PlXnGIA2MbzIAKOcYEc44X7yK+ZsoIZ9rKzvA/YO+deEakrx0TyGW5kQCDW6tYy/DB7bupeQG89biMFXOIny/agn6yRaRfE4w/he72GbNkHvT2Is1ZZETA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(122000001)(508600001)(6486002)(33656002)(6512007)(36756003)(71200400001)(2906002)(5660300002)(38100700002)(316002)(186003)(26005)(38070700005)(8676002)(2616005)(4326008)(54906003)(86362001)(6916009)(76116006)(66556008)(66946007)(66476007)(19627235002)(83380400001)(8936002)(66446008)(6506007)(64756008)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gav4mxkNFEjZeetjBlJkxVO9PnXzclVn8D8HsyVrdU/tjalfBieiXBC8+lm7?=
 =?us-ascii?Q?y575H45oUWAYY5e6hYZC9Walnl+bTKSxBOzxG1Y1KzhLS5a0bKWN8Dm85/gi?=
 =?us-ascii?Q?Tyi3l/3l546NEUEc2Hz/VB9r54OenosNAteLlfEJYDuVeEsitHpZZgx6Lq1u?=
 =?us-ascii?Q?GsIGLXacePUU97+yHQsu7CwbOzQc/11ymLGMWGb9OxIOR2wP47LCVeYtQdfS?=
 =?us-ascii?Q?EaI9RWQRzY+dLbgfQNQ5if8wCJSv2AG3yVu8P6IxWh7cPDSBnR5Ww+Jaqq6r?=
 =?us-ascii?Q?yjzD4FgCxzwNSDDHMpSjFQmbg8gXs4ytqXUeRgoHyqEEHPe+YTNCXQF1vZcA?=
 =?us-ascii?Q?WXtXgzmXnK79STYj4Y44Bu5sYBTm3rCNraFiW4ldLSqPNnIjgOPGmhq+j8vQ?=
 =?us-ascii?Q?oIRWwSQ/Q6E2JRFPYARSkOFsHMwl9Xdn9oNvSxwnHaW4Wf4m1AbX14m8b7S1?=
 =?us-ascii?Q?Aj/my6jA0LKKY8a04OPG1s5CLYiuHhPJCypqRAiejJJ+SiPP2hHm57q2hdG9?=
 =?us-ascii?Q?f14lTIjzq2LknZ+RENcF4EG5CTUWKX+kl5eksSfChINybTDCnnzGypAmT9q2?=
 =?us-ascii?Q?2Z0VSU9S2ag7qDMHed7mPuzYsYdBQblpdTpjwE2BTe2z2DUUffeGC/3fTDs5?=
 =?us-ascii?Q?n5fqtZUchhr/IUBq06sAP5qBV3UD6+oq/LN5dGM2Ac//LoZifVcy75RcHx4m?=
 =?us-ascii?Q?3YHOGuYbj+tEGl3FM+PMPV3CBUvx151nSbCkf++QC+KUvctw4SKJVoei6agX?=
 =?us-ascii?Q?k7loVmmO70y0Y8/RuLg1e1KGXpVnYlEqceeWqkpfUl2fV1sz8eLrszuIdJpp?=
 =?us-ascii?Q?s/YHfYT3SzfjFt3KcPJQs9XrmAmFLh7OBRFSskB+3o7tvNiyxXTsO0GzKHeu?=
 =?us-ascii?Q?xklUE098nuXpBGTKDOgJyo9NTKe9q0pse+NkIsRIDa1KSA6R90ziJMpjOkCs?=
 =?us-ascii?Q?y6E7Yce8NkBfwu/zDZ77Rt/6sohDnFlXB9M7dFlGn8iSsR5ThtgJcwI4CMDq?=
 =?us-ascii?Q?+RuVbvITquJPIpxa+usDs6PpViU/wC+SlbskciBNHAL9En2l4/oVX3BjJH6D?=
 =?us-ascii?Q?5S7w8LXPnxd3NX+8RH8MrcPLW65vn7+zvw11jXszvedgoKP0EjddS0Adadlk?=
 =?us-ascii?Q?MwyD9fOcUujEq3iPU+BKu59mxHBepBCAcsGxdQ+K725CXpKi8RSDgeZhvQpf?=
 =?us-ascii?Q?LQLBJxggLFAOSMGj7r9BmVtm7duSqXkUFdFs2FEmZ/SbC249BjAm778h/wRb?=
 =?us-ascii?Q?a8p5jpPI2LAQMVI5Z5AEmqYZ14UhIDRIxmRNlNfV0FzvCeCJVeS+AlslsMvI?=
 =?us-ascii?Q?fi2wHeUD19YLyZydC9kQuzB+lYfsNxHnHyHdzKjThswNP1vojr1dPuP/zmm9?=
 =?us-ascii?Q?zTEGOeC+wM72gZh8m9hY5EcqCvH3WBvadbRFzLJsrc7u710Rj7bINkuNMLKW?=
 =?us-ascii?Q?kOWYdmph4bwapF34NROknI27zLtETgg5GxLyL5V6dhxhGJ8RM5zN40TZTRqt?=
 =?us-ascii?Q?84x2/kW6Zh1xpmlpIYPJj6vx4mUjMyGJ7fj1DDWBBYQcOvjurVsRfeuULDid?=
 =?us-ascii?Q?ZBM5OZ85beCOj5yrK1PZnU9BLjY1LsOw2T0mBkQzuirj5kXWPt1c+DWk5pkQ?=
 =?us-ascii?Q?jyCmd6Cs5c0jSrIJ4ERZf1IzHMU9aU27u2ByVFFyBgQYcuOsaqQ2dOunx1wY?=
 =?us-ascii?Q?tW3B3NbV+xQaj8rR7zB6YvvEsg5b11c+yaH9VLzBDMca5iVXsI5vEkxovDaf?=
 =?us-ascii?Q?jBkeAOj/HhYGOQjDbcIt85uhwNvPVLs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5BA192D044632C4D86827694E5334F2D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0768c184-cd88-4443-f4c6-08da1276a227
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 17:56:36.1377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LwObGTox/I33A/PFC97wXyoQEBOHdUi/XVdXtpNEhvtA6+45QNRMXINR2f007gTlPYqqawt6rqeE/uBK5nYpoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3578
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-30_06:2022-03-29,2022-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300087
X-Proofpoint-ORIG-GUID: AjZ0UPWeqfVkS5RFt7TDrvUIsasggUSR
X-Proofpoint-GUID: AjZ0UPWeqfVkS5RFt7TDrvUIsasggUSR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 30, 2022, at 12:19 PM, Jan Kara <jack@suse.cz> wrote:
>=20
> On Wed 30-03-22 15:38:38, Chuck Lever III wrote:
>>> On Mar 30, 2022, at 11:03 AM, Trond Myklebust <trondmy@hammerspace.com>=
 wrote:
>>>=20
>>> On Wed, 2022-03-30 at 12:34 +0200, Jan Kara wrote:
>>>> Hello,
>>>>=20
>>>> during our performance testing we have noticed that commit
>>>> b6669305d35a
>>>> ("nfsd: Reduce the number of calls to nfsd_file_gc()") has introduced
>>>> a
>>>> performance regression when a client does random buffered writes. The
>>>> workload on NFS client is fio running 4 processed doing random
>>>> buffered writes to 4
>>>> different files and the files are large enough to hit dirty limits
>>>> and
>>>> force writeback from the client. In particular the invocation is
>>>> like:
>>>>=20
>>>> fio --direct=3D0 --ioengine=3Dsync --thread --directory=3D/mnt/mnt1 --
>>>> invalidate=3D1 --group_reporting=3D1 --runtime=3D300 --fallocate=3Dpos=
ix --
>>>> ramp_time=3D10 --name=3DRandomReads-128000-4k-4 --new_group --
>>>> rw=3Drandwrite --size=3D4000m --numjobs=3D4 --bs=3D4k --
>>>> filename_format=3DFioWorkloads.\$jobnum --end_fsync=3D1
>>>>=20
>>>> The reason why commit b6669305d35a regresses performance is the
>>>> filemap_flush() call it adds into nfsd_file_put(). Before this commit
>>>> writeback on the server happened from nfsd_commit() code resulting in
>>>> rather long semisequential streams of 4k writes. After commit
>>>> b6669305d35a
>>>> all the writeback happens from filemap_flush() calls resulting in
>>>> much
>>>> longer average seek distance (IO from different files is more
>>>> interleaved)
>>>> and about 16-20% regression in the achieved writeback throughput when
>>>> the
>>>> backing store is rotational storage.
>>>>=20
>>>> I think the filemap_flush() from nfsd_file_put() is indeed rather
>>>> aggressive and I think we'd be better off to just leave writeback to
>>>> either
>>>> nfsd_commit() or standard dirty page cleaning happening on the
>>>> system. I
>>>> assume the rationale for the filemap_flush() call was to make it more
>>>> likely the file can be evicted during the garbage collection run? Was
>>>> there
>>>> any particular problem leading to addition of this call or was it
>>>> just "it
>>>> seemed like a good idea" thing?
>>>>=20
>>>> Thanks in advance for ideas.
>>>>=20
>>>>                                                                Honza
>>>=20
>>> It was mainly introduced to reduce the amount of work that
>>> nfsd_file_free() needs to do. In particular when re-exporting NFS, the
>>> call to filp_close() can be expensive because it synchronously flushes
>>> out dirty pages. That again means that some of the calls to
>>> nfsd_file_dispose_list() can end up being very expensive (particularly
>>> the ones run by the garbage collector itself).
>>=20
>> The "no regressions" rule suggests that some kind of action needs
>> to be taken. I don't have a sense of whether Jan's workload or NFS
>> re-export is the more common use case, however.
>>=20
>> I can see that filp_close() on a file on an NFS mount could be
>> costly if that file has dirty pages, due to the NFS client's
>> "flush on close" semantic.
>>=20
>> Trond, are there alternatives to flushing in the nfsd_file_put()
>> path? I'm willing to entertain bug fix patches rather than a
>> mechanical revert of b6669305d35a.
>=20
> Yeah, I don't think we need to rush fixing this with a revert.

Sorry I wasn't clear: I would prefer to apply a bug fix over
sending a revert commit, and I do not have enough information
yet to make that choice. Waiting a bit is OK with me.


> Also because
> just removing the filemap_flush() from nfsd_file_put() would keep other
> benefits of that commit while fixing the regression AFAIU. But I think
> making flushing less aggressive is desirable because as I wrote in my oth=
er
> reply, currently it is preventing pagecache from accumulating enough dirt=
y
> data for a good IO pattern.

I might even go so far as to say that a small write workload
isn't especially good for solid state storage either.

I know Trond is trying to address NFS re-export performance, but
there appear to be some palpable effects outside of that narrow
use case that need to be considered. Thus a server-side fix,
rather than a fix in the NFS client used to do the re-export,
seems appropriate to consider.


--
Chuck Lever



