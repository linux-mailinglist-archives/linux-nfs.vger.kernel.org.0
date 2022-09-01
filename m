Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE085AA0AC
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 22:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiIAUJQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 16:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbiIAUJJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 16:09:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA6A9CCF2
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 13:09:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281HJJ4w008998;
        Thu, 1 Sep 2022 20:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=y5pANrTGGf16cd4V6JhQUOfDhv7ZSaURWu+oT+DKsVM=;
 b=w4J6buk2IMdW164Z4AZJWk5VAIWE0w3a5AnOf+8ybx85A/z7bYNkp9HW+SR3ZkwGo7Rb
 r2g+MzGyAgjG4GdNXQuq2OoeDNNiGQHMEJBPs7SYygT4f8Fsx1cLHkciQpVHq2gQzgpl
 NHW0ln+TXm3IVKHNlH8jt+dtLFtb2CR2v5DkBnwJDeAMvNh4GioDKHoX+TGyjMhloXQZ
 dyAzXiF9ioJZIKTMn8W4Q1/CFOmoT3B/7ti4nlBrRon6F8rtmAVQwL3wWTi29fsqC9Wk
 ly3Gh0JHH5O/TXi3TGDCTHHtENTJZYqPn9khfkaCrqbpsyPWWwSX0mNZpo9EE3wuOxot fA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7a22de50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 20:08:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 281HuBUh027715;
        Thu, 1 Sep 2022 20:08:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q6kx6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 20:08:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRUhhaJNFDUF9jZQvr20GQDSyTxgzeZ0U9vFdOnF5zsKxCiOkK6uTL9q0SVi5vd9Xpixb/If7c41UboMOm0kxh4qCoqt7dk1cv051BZIn0gFsfIzDx0f+lT5hPMz24LUFnv8d/jNvb0ShlDox+sQgdOk3GpZLU0egUrUT2iz7IsmZHEbeK/I1GH1mR/jsW93ghb15m3hrBUjTBBDIt9u/jobOfnMQOGz8nvBfLh5j1s7Yk8Hxqiit59tYPYPz262XYWTn4ehDQ8mgjsi8J9ZdjB5cDCyVUK38nEk0toNRSXlvR0UU7suX0fwRVVRfYsEJbAXywTrtLOC7TNXWwhH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5pANrTGGf16cd4V6JhQUOfDhv7ZSaURWu+oT+DKsVM=;
 b=SIgWPgBFDJRkH8oWOPkjZ4KoMgfNTPmXCngwRtV053qZFn1BCv/zPyWwoOxoYw8E7vsP/svzqQKRnIbs0zFhB9sxC2zNAtkqCmJuvhzV76+itRBHxjwuu6Gv7xpW/W7yHAXvxulAAIkC+Zutr6VYk6IuAoQlWJbEGxfxHnxC/nStnlBU0Th2VHnaFAeivpxWJ3VX9XrkHw5oVpInyUX1JDW419UfgJEsghNVjnZLnMSl7UHtrziScY6ox6QUr2j7K9SIE+w0K911Xsu6DOAHC3rRddZJBtRvLxcJ8IhjKFlbZFa5yP4qdHsmw3f604ovmDej55fSXKrGXBKdzvmEog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5pANrTGGf16cd4V6JhQUOfDhv7ZSaURWu+oT+DKsVM=;
 b=M4lygfTw7JqbZxg1QcCwBtiE5ld8aGz9CGwxyG1yjyMcEEIyxeEVV53nTbKySZQlJbn0yP2c9vYB/DiXKGsA6B/5lPqew7utPdJKPsVhIN5XfB5Ys3ekNKn/hm9VeGuBQJKn8Nl1p36wo+caf8k40IYx427bOi/3WnK4TTl+SJQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB5929.namprd10.prod.outlook.com (2603:10b6:a03:48c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 1 Sep
 2022 20:08:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 20:08:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Thread-Topic: Is this nfsd kernel oops known?
Thread-Index: AQHYvJP9R6JamLcYaUyLf/owehh7vq3HuG2AgALiPACAAGl2gA==
Date:   Thu, 1 Sep 2022 20:08:46 +0000
Message-ID: <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
In-Reply-To: <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bf59854-b719-4c23-ac42-08da8c55c72b
x-ms-traffictypediagnostic: SJ1PR10MB5929:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mK7bq5j6Ym/pIi8BhZNOb+728rtE18MQmE3yKXraXYHyToLkbHUU+S8ljnpw6nI2prLdpZU5hPM53ALWPbGjxQ3e0RfsJvrfKm69xfkDWoq/b8tcdg3/z+JOoYp2r2Z0/td2FUA9lwJxEhA9JsbUZfsNN1zKcnV7FT/PJBt7/hMx9Th8ugTGAtq7CQvVdWtGTx/Xfzaq5HWKL2nRp3x9OEetxxMQlQMwALTbo03zP5/N7WVueRgkhlPRV3XsSfFNpBwlWNzNiUYXth/eNHIH6A//fi1VqHiiA1Xr+Wk3YT4ilTVIZlxg1R1pylYGIthTyg1bOm91TpGhvYnjHPsSYXPE3l25aTIRQogzFSjglTwTtL6QnYo1he6yuMkBolCaB+npdIxsRR4kocAnZnvjTZ4FMK/sGbv2R3/cPSUzIoT1t55J1j6FHPyDD9/Ge8dqZJnrfNByltp215LctZaETdUoFxP8ijMysSkNYsjN6R8N9/oNeSCP4Vg4/11wTuS41nheP4JMoSAcbgLF4VlWBujuU+Nv+XFKhv2j6Sd8MuDX+sFVrNTOaBTk312JxCU6acx5bzrRuvzIPQ+USp+jHIKjIQU2Nxagh4QOFVaSerNNZCpCNDuBrGmkMySR9s6p9U2pLkk0NfMj3hycTr96E4xqkAerl4d2HiPXRsI6aXALCkA1T6Jb+cd+taecIpe211cEvu0Lqjb/w41PdemYxwaWrok1wulxKKIoUpin9u8W/Rgrx6Xt7NQdXO+P+K7WG++YN8cmzP71d2slq19ndUnd1iInY1Ub8C5x4VLJOQk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(346002)(376002)(39860400002)(5660300002)(54906003)(6916009)(71200400001)(38100700002)(38070700005)(4326008)(8676002)(6506007)(91956017)(316002)(64756008)(6486002)(66556008)(66476007)(66946007)(53546011)(2906002)(76116006)(26005)(86362001)(6512007)(478600001)(66446008)(122000001)(33656002)(2616005)(41300700001)(186003)(8936002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xEiUzV58yC6nYJEwqosgq9AVSNjSv4Rg1DthMgmjMhpk3wmXo4UsYMbU/7Ol?=
 =?us-ascii?Q?o3fvPVe2guuSCDVLRDLCfGCuQ4FxS46z6ixFNoJTuZBbq4+FvQ8r5JWyCChT?=
 =?us-ascii?Q?o35HvGHRa6FlT0BU/Y36Mg1V5g9a0MfvtFPHeB5dgvgGzNG4YDpUZbgAbXZk?=
 =?us-ascii?Q?KzbrbmxADzkURoKMPxkFgiGMB7fzG6VpIkWFEJRDYw3e84hgcaiLDge/RPdd?=
 =?us-ascii?Q?+rWmLmIP5LKPrWp08QAuAw5E6I0MegTNQJUGXEn0679jJrEg/1/p1H0SirkT?=
 =?us-ascii?Q?BMVtvIXzGKvb/vo2metO/nbMMERNYR404aZ0dG0kkNK1c8/Tdu5NY+9Axi/A?=
 =?us-ascii?Q?a2gKI7ejGKxetu25YyZMrQwVZeplYD2Ta64GpR74+GYCC6HUN0cCS0pJlAGS?=
 =?us-ascii?Q?EOA1uY+Kd770yGSsQapr+5loJcw7OcUgC4BMNRuOba6lYPvmkwiTEaWA1Xeq?=
 =?us-ascii?Q?WIHmKFag8KRx8KQKB6nvZK46tIiuWXqVEP4fZLB0v/uAVQllHcLJlGKRIGe1?=
 =?us-ascii?Q?r0Kwxbo/MBgCDsPVVVxgm+VODwcMBxPJFJtYNFmYTV6sJRqAZzoAl/XZxvE1?=
 =?us-ascii?Q?0+AQ2lzQTkZ263T3dJmPHVBQTpmrKCSR/LoIFQPXNFjJJxnPwyAz33bfpCS1?=
 =?us-ascii?Q?Yd4DRLAM05FF8JldlW8G4tAFt6j7Katn09aSdEt0pC+w7l+pTHiFlU6XzFV7?=
 =?us-ascii?Q?G4OtfPF6wvNLN6FaYTuIIjsMTLC9wXUPN5pqwJkmSxpVieyw+ZYOB7FKx8/U?=
 =?us-ascii?Q?uAiZlz7tRgcksSDOdObRs9c4OjMQCY0G/kiTNqsghkfJ2GMReMG0GIEPmhJ2?=
 =?us-ascii?Q?dyF/vub8RxYTgm3Zz2D7wgG7S5ALLSsb9p0tQUjiO29KL6L0/UWWl7L+whhC?=
 =?us-ascii?Q?S6iG/Iuxj00TOYe9pnlMKK/7NDk4BUasHxMPFXvc5ATRVLVl2lgIN0MEVRBY?=
 =?us-ascii?Q?gH/0xd34O7xJjmU3g4xMJ75WOYWEfR08LMUKvjz6JaUS+HPtc76z2oDa5E6Q?=
 =?us-ascii?Q?ACSNTYEmIjpJ6VpYKAcbg4adPmFjoTI0xv5afFbC8I2u6RzpoSU3zUsxcpAI?=
 =?us-ascii?Q?pcim6xpSD8b+7uCxrk1Wg6jQFpg0gl3iMLcCTE5e8ex19hK2kL/HCVUmcxZZ?=
 =?us-ascii?Q?j32ywZUwuIjazgkXBL/8kZ8vQtTRSFFiDjt+SEhbkV37uNyTUMmKBCTMZgkK?=
 =?us-ascii?Q?LvPzEsucMXwHuJR5YV2W/5rvpHB+2WVhXPo9VsKZGG3H0I8G0kkta4GNNhuS?=
 =?us-ascii?Q?8PmOUvNKI771enwfDlFB0x14xtren61GzzMnhFhJRcENLLuWyKGvrNEkic4G?=
 =?us-ascii?Q?XhEx1beh+qhuctbWBlLjTKRnsWxi46S20VfINFu4xiUkn06ehnjAkML7lI65?=
 =?us-ascii?Q?4eXL0OdJU7zCEkMEzOr6OH1rPmmYG1rl4AGGbSIZcAvTue+IUfqEh/+1lOGe?=
 =?us-ascii?Q?L49nN0PBrIWTWBpU500TiX9wc0RDz/YK5qSP8he5Xt3pquNTRHRmSqahIh8t?=
 =?us-ascii?Q?haeix9ZUnVOyMQwGgd1TmaGByttQP7ycc+n44a4UyM+MxC9YyxqsmbUbF40L?=
 =?us-ascii?Q?7e89xzKkBwP6eWF3N4TuHhrqgDcjXV02CYGdmNcWU64ITPKX4zHHFSKb2/of?=
 =?us-ascii?Q?yA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5DFF518C5DA22F4FA20BBA6C442C04B6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf59854-b719-4c23-ac42-08da8c55c72b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 20:08:46.7671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdCX1nUFrAXwF8nlA4VXrwMZE0w7E/HcFDPbXvu2P+K1D5SL3z0vupfxmNwWF1FEXuqi+NGPWspMSir3kHil8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5929
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209010088
X-Proofpoint-GUID: 9aXWwGkpooMxqwMtBYadKi9qj3RyATmz
X-Proofpoint-ORIG-GUID: 9aXWwGkpooMxqwMtBYadKi9qj3RyATmz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 1, 2022, at 9:51 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Tue, Aug 30, 2022 at 1:49 PM Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> On Tue, 2022-08-30 at 13:14 -0400, Olga Kornievskaia wrote:
>>> Hi folks,
>>>=20
>>> Is this a known nfsd kernel oops in 6.0-rc1. Was running xfstests on
>>> pre-rhel-9.1 client against 6.0-rc1 server when it panic-ed.
>>>=20
>>> [ 5554.769159] BUG: KASAN: null-ptr-deref in kernel_sendpage+0x60/0x220
>>> [ 5554.770526] Read of size 8 at addr 0000000000000008 by task nfsd/259=
0
>>> [ 5554.771899]
>>=20
>> No, I haven't seen this one. I'm guessing the page pointer passed to
>> kernel_sendpage was probably NULL, so this may be a case where something
>> walked off the end of the rq_pages array?
>>=20
>> Beyond that I can't tell much from just this stack trace. It might be
>> nice to see what line of code kernel_sendpage+0x60 refers to on your
>> kernel.
>=20
> After getting debug symbols this is what gdb told me...
>=20
> (gdb) l *(kernel_sendpage+0x60)
> 0xffffffff81cbd570 is in kernel_sendpage (./include/linux/page-flags.h:48=
7).
> 482 TESTCLEARFLAG(LRU, lru, PF_HEAD)
> 483 PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_=
HEAD)
> 484 TESTCLEARFLAG(Active, active, PF_HEAD)
> 485 PAGEFLAG(Workingset, workingset, PF_HEAD)
> 486 TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
> 487 __PAGEFLAG(Slab, slab, PF_NO_TAIL)
> 488 __PAGEFLAG(SlobFree, slob_free, PF_NO_TAIL)
> 489 PAGEFLAG(Checked, checked, PF_NO_COMPOUND)   /* Used by some filesyst=
ems */
> 490
> 491 /* Xen */
>=20
> I'm unable to complete a git bisect. Could somebody suggest what to do
> when a git bisect midpoint results in an unbootable kernel? I can't
> "skip" this point can I? I'm not sure if marking it "bad" makes sense
> since it's not relevant to the actual problem.

Try skipping. I think "git bisect" is supposed to be smart enough
to figure things out after a skip.

If not, start over and pick endpoints that you think might avoid
the unbootable kernels. Even adjusting one endpoint a little
might be enough to make bisect pick new targets that avoid the
unbootable kernels.


--
Chuck Lever



