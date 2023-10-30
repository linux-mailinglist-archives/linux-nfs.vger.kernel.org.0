Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EE37DC30F
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Oct 2023 00:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjJ3XVU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 19:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjJ3XVT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 19:21:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE34CE1;
        Mon, 30 Oct 2023 16:21:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UMxJ5T027898;
        Mon, 30 Oct 2023 23:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Xmd6a1HFCEs4zHzanMDaFYvFZD6VsU2NQzb2qz4zmoY=;
 b=B8t0Q0lUZXSxo3OKv5GaZHY/Ibe6IsjW/xjlNSeVZDBQNz2ESPGLXu8tAsRKqn3Grni8
 4pgXpAWeH3aap0l3XxvU4T1MqsyDWKMDWgODW+Ynk3oufHUdz8oJEaR0MIsdkzfXHmxv
 0KNymRPdxFOWb4dDEh02hm/yF5lkE9zHMVi2J/pxspXrQ/+dQqYaEDUC4EOlCUhL5VM2
 5cqBCD0TE4Oqx4cLI5BhorMjy/9QVd8Nzdux0SOB01bx/h8X0NlAVed74p0Oqdldal7w
 jQNHP4PWWP2roshSDM3QMAFylbqDomGo6B/CFBvCHYqnlvtMRkM34YrW2A2mTn76N3A/ Tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tuubunt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 23:21:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39ULGu6r022427;
        Mon, 30 Oct 2023 23:21:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr4xmb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 23:21:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEmm9Xyh3n+ukVCQUD+u+gxXM7eVt4Z57cZDiSxlbGFQsgyn/Iv8Ij15w/CR5FtLeQHH1UOTl487pjcv77ufZRx/y+B1xLvsZ1W/MFWvOw1gt17YJthaFB9XjDowsL0jEmZruiGWThSZFzyVSmRz10y8DAZfXM6HYvdfrn9HR5ikhrm/wWb+QLWvGh0TGcrkyoI/Ns1fCvu04NfUeonq0Hd4lG64PnZX3KsnNEGZ2iBuNg5QaE7tKvPeWVKVKSE4Smj26AKyPUYdZmxh8YAW6XC1u6XC20Hcw7MkAmYGwZJy6imOmHaDVSWbdGW8H73NO/W4vanSVVwXT/YYbLsy/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xmd6a1HFCEs4zHzanMDaFYvFZD6VsU2NQzb2qz4zmoY=;
 b=Recw2Sz96sZXYbE2cZC6VwIfRApJZQN69q7VDmpHFTasRdYujmtJXBkKESYbfsbCFRYZqTd9aGHAIG/ef//4JAP0Gd/j4sGFt1zOZiPEybTKKeO4sQh1c9kvQho2YqIN/L3wykWehzHWCliSCKTGzSoW8GUpY0UeNBQRXmjM4e0Upfq+vXxmgnEFKom8qJPeWgL//B21mxzfCCzxJfc++2s78PE6kQUbelxoeaKQZHS9XjPry3Xi5u70G9vto+xyW2omhcDpC1OprVJvsquesmfQglQJwoz1aFWKLNjVQIxD2lDQwhBMTLhk0NPWOlLDYqwfyro+1rbnzpvtCrgMcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xmd6a1HFCEs4zHzanMDaFYvFZD6VsU2NQzb2qz4zmoY=;
 b=wg/yB0T0wdFIMFQTGlCjDXV5hArhcqQj/epE+Tl9DHKRj+j7z0C2UQIdthvDtlOlkGnbfDfvF7f7H0dQXmhtpfm94V+0R/WJznx7ViKjX8bzomcftKZ/DLro7eJapcRJ4LOknhCkXjQs/bIFpT+oC85EP1D4jxQIBbTAVfN0vDQ=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Mon, 30 Oct
 2023 23:21:06 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::3a93:ba27:cbea:c6d4]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::3a93:ba27:cbea:c6d4%4]) with mapi id 15.20.6933.019; Mon, 30 Oct 2023
 23:21:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [GIT PULL] nfsd changes for v6.7 (early)
Thread-Topic: [GIT PULL] nfsd changes for v6.7 (early)
Thread-Index: AQHaB07bp3SsPgtJx0O5OMKo6TKfuLBi4k0AgAAei4A=
Date:   Mon, 30 Oct 2023 23:21:06 +0000
Message-ID: <96800661-0F30-4F9E-89E4-C0B032EFDEB9@oracle.com>
References: <34E014FF-351E-4977-B694-060A5DADD35A@oracle.com>
 <CAHk-=wifhiJ-QbcwrH0RzPaKeZv93GKDQuBUth18ay=sLu5CVA@mail.gmail.com>
In-Reply-To: <CAHk-=wifhiJ-QbcwrH0RzPaKeZv93GKDQuBUth18ay=sLu5CVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|CO1PR10MB4500:EE_
x-ms-office365-filtering-correlation-id: 73d8eee8-5e26-444c-ef77-08dbd99ee445
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4UKMigz3proUJDYjp6ljcKU185Y6sqv7w3PH97DYDuIVSUARX93razmfJ14v1bvz4s/EQNtD7tJnNHohS4kO+muSg2OvYRCt3O3CbxjDoJvmC2B9FKXPZ/pH5v4cgEzNPV3AsdVuJJqMXBg7UQ6otfRK/UUQ8DGm+xwVN5RmJbNzBWUpPO2A/NJ3j23XZUN4+XoOTSjYsp04MCaZcw/zG58HpE9PKe8+/d+lGP43NHshlpQ6tCeR7w9csApTh+VkTnx/Y0Lh39p7NnPs80pDtVYFbWojjsRIHOvTHdQHFmxiCNS0qkQmasX4a9JEKrdaHqTYe4nl0fIGwEJC19/lVQdlnqjVKEDeE3snMmLOq1Ga/QUw/j4oidyXTbf9DIxoLtHsbzO9doXObZWiYik1kHlDhrOd4sJt486KbNfiWUNdQInLJv+geC12CmUF1T7WK8qnZ176jF539KWOQ7ICAbgWHFtApI5b5k9I5ukC6SqguQdMxroJkiOom9Z8gNQ4XE8w0KvcvVl7ggDORBce0LSopOWhJQPG0VfcH2Utdz65lKBijwILMAqWKK6AbLys2jNWP59ky+E2I7cDy86xDDkz8dK4RQakscR9uDFiicPLnMCzNKChlDVMasuPBOm3vnjtYdv+oNcRzjat12f1zQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(316002)(2906002)(6916009)(5660300002)(66556008)(26005)(4326008)(41300700001)(8676002)(38070700009)(8936002)(83380400001)(38100700002)(64756008)(66476007)(122000001)(91956017)(6512007)(36756003)(66446008)(53546011)(66946007)(2616005)(6506007)(71200400001)(478600001)(76116006)(54906003)(86362001)(33656002)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qJqp7NSrQMYPJQVD+vvl0k+gpgH3HAPJoHC1odL7PkN7s78RS+qql6wG0peR?=
 =?us-ascii?Q?trcx4PaAtlpZ+CmvgvzT/wsMvJlatXANjLvhxR23O/a8bnvB97P05PLQhguG?=
 =?us-ascii?Q?ceae5MKrLhsDG7wteTsrflvC9+5P/s10dZukyUdhwSG/LqsFL2KkJEqr0x2h?=
 =?us-ascii?Q?OneNKkIa0Pn15iIrrkHn86Qw+D5x8G7+TNHgERWC5CdWy70gT4qck+wGbe3p?=
 =?us-ascii?Q?GH2zOgGDcurMyByjBNqgIxidi74FdSdBnutVTep8ZwlZrlEccChfPVeHzpWq?=
 =?us-ascii?Q?qNvz4xphltXg86tEWJymMNhM72oXj06/sYU5tI/UQIhFt3redWFqotrFx7Aa?=
 =?us-ascii?Q?McRASPmvnzGXKkQ3bSw/jHVn9vkRtZgEtmbZKp9/rArOIxJDsFMmhoOu2s4g?=
 =?us-ascii?Q?JPzfQGZ59wRvruxVvgCp7h4pYCL7/iZyTEnjnY9UlvXuQgClJ3fVsEFmD1G8?=
 =?us-ascii?Q?0fn2ovV2Grl+mxc0XbY3qqL2xk3zQrpmhdDEi5GQM3vnRYXYjTFwa8m8VCsN?=
 =?us-ascii?Q?O2XEkgWr6sLZAPSAuB9QcemKRs/YG1DVUhIByhep2gVo+Cw/I8ftb1fQ40AW?=
 =?us-ascii?Q?M528jo36fYHCsuMkwPxDmL+jqAUGOBU5EoG7nl6LXkTchfyRUE1CKe85SguX?=
 =?us-ascii?Q?7Uv3P4+mcMjgShq2E/vkYPxJ1GFd8ZFs1VsKc4rg1jxJx5Pl0vhc0eZGpHyC?=
 =?us-ascii?Q?LFRe3a8sk51TFv/QksVAwE0ZmhDFD6jdNiuGLGyhU5cREuUJmQ0Oe3xeQD3E?=
 =?us-ascii?Q?p8gq//Yh/kooC4OrLPcI2P8vt4Vcybl16c+U4kBqzhNZpPFgpHs19cWiA1fj?=
 =?us-ascii?Q?xR17ZnAtGRL4mxUehfkGrI4m0vt7ChXZQF9XZ1QZMxYE8wZfwZKCbhP8BrZh?=
 =?us-ascii?Q?1aPsyKxZ/pzRhOZe5h3kDpinHfeQJYReYrLdGgvzYZIdjCcM+DA8tOEQhzub?=
 =?us-ascii?Q?ls/9o7NO6o92VG/ChfeSu0sOGspydZ4uWZ1lSYWqRwCD3xT9/mWR8VMnSNt+?=
 =?us-ascii?Q?cdu9zAe3dMNtLeidv3kV18HBSPyR5rDXZWBFLWiqnmJbB0JkrjIQLOTfuV8c?=
 =?us-ascii?Q?gy9fmBJ2Z5BcAd4e6Jn5hIuTRkAzN3vsKY36eEp6Ntvmeq9Clq92Ch6bML8I?=
 =?us-ascii?Q?HB9FIb5rSd3Lavx0ops6yNU1OstSXyBl/5CE2wwIBReyC5j3oURcpLO9S6Ji?=
 =?us-ascii?Q?AOy5cUpdRlu2yA9KyV/g7/PDTRFstuIa/zC/TORxMC57TEIcJ3b5Z3fnL7+d?=
 =?us-ascii?Q?FE7KYt21YajXGx3vEP2TRz5sBoOganKciBwyeMkfXNZPK+S8nzOMVfkM3amm?=
 =?us-ascii?Q?o7AqUejYvFmmjBaHnLz1iEDAW4m1jWKBGEJ5GrP57KOHklxEOOE6RDMOo6ua?=
 =?us-ascii?Q?4HeY6gnHFsnI/JE/qFMnu3haAojfSkk7UkZamwvj4G1x7/H6cwDbqr8BSfXJ?=
 =?us-ascii?Q?i9lBtNKGozYj0+itGHLrbYlzYnmzQXxmZsF2lsbhHpt8MhGAjNf8QIbxKhs3?=
 =?us-ascii?Q?D2J8OE1JDVia/A8B9QAJrvdtIJHD9IIZ6er6Q9CJA1pJBTKO65zO1gu9wZf4?=
 =?us-ascii?Q?lwf5sD5BGETCibdWGcXIBonsfUy3+4t5LTFwbYO/?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D5D70A32ED9B6C4CBA0BBBF5FA7FE599@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9PIUqcAQ/8wT62X0exxreU93xclTXEXeJA3xq2fCndeu/C4Z59igr+9PeaMbvMArFSG6H8S5oIqlbDdaimKnP/HTCql+HcTcQlfT28iP94LHq60tIlL+uon0GEFcxgXIQJTSBpvci3bqJihbmxSwF+i9baO84JItLiW964SKqt3at/n/1QAZeWpdmrlnyWdIOXhwbikA7gE8bEQ+OLCg0YALWpus1/TMtT89TqovBpyp15cH9RJpPCjgquP1J1r6x5yBSq0fT1VTCVtym9T3YQP/csRQdVp311oQNWuUp19Jvvtu9/Qm5LVNkdd+c7TXGNiIqvszRD4g5rXoqH6fS+C0zy3NeSuqrbau2darrOQbbMO1r3m+q24N6XlNsOCT3eErkQwQbOymsCYn0SR2vH/j/BzJMUm59tDPvzzlNoZREA+XKoCxJHniivg1llkZ/wUlJRpRbWj6GmGYHGhv1xUtznisO21XWKeqhrGnlCq3kFnrIT7GzOU2HVsFwaSb3gJz8utHGl/vNVuIETBKiXOik9p2ZFgkYlBXbPk5AC7ScLqOGJ0br+0zlZMApYDwX+W/UcGIG4B1fAPXkIQXFAK4DdQTaPNSutmLt35dDwxkPJci3sttDQFDOOA2Ky92AkXdzJ2E+7sRI57OJ0yy5o8mITdEkveOPahvhNyo1sMUsERl9FNMrRJxLpBZlq30yCDmNAbirlkJq9OYz0gi+rPVw7exjXUl1s4eEE5BLkEXQLBLsd1vLeOwt5ep6HklaoROvey0Pq4qZNeI6L4jgmLdPWLbd5ClITasvhueuFTGpY3b8MLmiJ6C+KiNnx1cd1/X12pjiJ2POVsQRL53Nw0CG3WFlWmXr8Z6JGW2NW6oPWhpyYAJyp4ixXwu5DRR
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d8eee8-5e26-444c-ef77-08dbd99ee445
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 23:21:06.0326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TtKtROoG/6owFIKkRtS/ZI8pvnxC8RLiyuaYtwhfjMTCcfm7hLTrWySEQxNjZS5T/Kb736Rbccz+JYHITSGYeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4500
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300182
X-Proofpoint-GUID: 5CfScFAsXm1X8hqwlWL86tvbuxnHl9Xw
X-Proofpoint-ORIG-GUID: 5CfScFAsXm1X8hqwlWL86tvbuxnHl9Xw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 30, 2023, at 2:31 PM, Linus Torvalds <torvalds@linux-foundation.or=
g> wrote:
>=20
> On Wed, 25 Oct 2023 at 04:24, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>>=20
>> This release completes the SunRPC thread scheduler work that was
>> begun in v6.6. The scheduler can now find an svc thread to wake in
>> constant time and without a list walk. Thanks again to Neil Brown
>> for this overhaul.
>=20
> Btw, the "help" text for the new Kconfig option that this introduces
> is just ridiculously bad.
>=20
> I react to these things, because I keep telling people that our
> Kconfig is one of the nastier parts to people just building and
> testing their own kernels. Yes, you can start with whatever distro
> default config, and build your own, and install it, but when people
> then introduce new options and ask insane and unhelpful questions,
> that scares off any sane person.
>=20
> So Kconfig questions really need to make sense, and they need to have
> help messages that are useful..
>=20
> Honestly, that LWQ_TEST option probably fails both cases.  The
> "testing" is a toy, and the Kconfig option is horrific. I literally
> think that we would be better off removing that code. Any bug found by
> that testv would be so fundamental as to not be worth testing for.

I have to admit I didn't look too closely at that part
of the series, except to note that there's no maintainer
of record for those files. That's probably why there was
little initial pushback on the scant help text.

Do you need a refreshed PR with the testing bit removed,
or can you live with Neil or me sending a subsequent
fix-up later in the merge window?


--
Chuck Lever


