Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E441C485A0D
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 21:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244058AbiAEUdo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 15:33:44 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50794 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244036AbiAEUdk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Jan 2022 15:33:40 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205KNxYt029733;
        Wed, 5 Jan 2022 20:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eh7tQHrTVU3WGYVaA/JpCviJuxyQ4trV9Td7WW23JFw=;
 b=SBZvvqvfFIEUgy31fUByiHLbnS7kXbQ4wpBpWch8gDkqgvoX6PE/I3p3bsjXZvsz2d9A
 csI1ozLCquzt8OI6oEj0jkCfy423VAj9xsxnfpgP7YS+LiRveatK+Yup0n10RDf6u7mU
 1ccgRONcJU1qvfvY+hfsFhqDCHzqDXMnB+0xgtFr0wRZC4Bc3B/K010NfANUf6mTdCyi
 0wcI1GsN7/BqnSkCXwEH3k+ITISmggsbo34h2dkwdTzuuY8KyR3LpdjlSRN+adK4ilcW
 TvIeoGQbc7WC7s5ZrWgl+1BvwJ0wHkvXqVyY5YvHM/r1Ox0BazEWaZqZM1BGlhbcmh5T ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3st5wxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 20:33:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205KPnBI116449;
        Wed, 5 Jan 2022 20:33:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3030.oracle.com with ESMTP id 3dac2yy8sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 20:33:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjxUmnPfTqCz21vsqcRikAMVyYW1uk1ksGTg1qz2fbGdVCLzZiQikghS5pYOI7mu5dRK5+/kPgMnwL2FuloBT2oPCCvc3Tg6TipOpjBMbZrS/kLYwx2dsI6vS0sjEcibRhjhoyj9BS0xWlX2Hi/zSyitcGLAmPGVN4EDwC9ASu4ckrJCgx6MRF53eXiYGmh/XFXmD1D/bwSmL41n6cqBXfa5JoufbsvyIL1Se5P/Qlv+o0mvgx1NBjVRY5sMPavO4zSbgIDm5joN8IJ+0C7v86kay3YesorZyoKhpWJJ+qKVoooUVXYyzBtDdXGYM7r5YvH7491rERjrncHOP7ZUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh7tQHrTVU3WGYVaA/JpCviJuxyQ4trV9Td7WW23JFw=;
 b=oA5HpPOJj3yv1k/W36OvjKpzl0Y6EfpW/MDWMVG+dYWAsTCDlMGGbUzCb+mvwmbTjocRlmBdHu4DN6z+OvmMkz5D+oNEuqZcpQCLxXyP6d+VSzaIXBGiHXtMR9fK2/Zs20ggp4BsheQd0oXbxbx6RZTlTpSVBhIxhSgdQcxHavW0SIt0QM1aJNJK+gY/CWMKyFZLrZF7SNJXYdPbGT0oqcvxG4d4RXT32uYuRZhrkHpFIWm9xHKeB9eeHvPiV1BzxEVvv1RgYGhD6EcvDFac5+b3yW92x1KBuPMCVg/E4NRfFhOKELie3uZfqtvMty64dz+tDoelTUU77OAYZ5iHkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh7tQHrTVU3WGYVaA/JpCviJuxyQ4trV9Td7WW23JFw=;
 b=Ey4j7dABzsWg5+dNaMbANrIP1gYcEttAbk7ThblMhmp8ZK2O6YmsbcchmhcL5+2UiZRBj7ZstS3DOJNoaCkBtNb/6nqeCyXUQnfkMc1JfrL4YuryarmzCib1dICOPnADg2Z+lzUISHrh6WDCS+dNz7MqoR1viur77NdhRzY1SDY=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB4229.namprd10.prod.outlook.com (2603:10b6:610:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 20:33:15 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%8]) with mapi id 15.20.4867.007; Wed, 5 Jan 2022
 20:33:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>,
        Olga Kornievskaia <kolga@netapp.com>
CC:     "rtm@csail.mit.edu" <rtm@csail.mit.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfsd v4 server can crash in COPY_NOTIFY
Thread-Topic: nfsd v4 server can crash in COPY_NOTIFY
Thread-Index: AQHYAkTSfcyQ73azGUqH3aX+rbcvl6xU3MuAgAAFmAA=
Date:   Wed, 5 Jan 2022 20:33:14 +0000
Message-ID: <88B4B5A4-74B1-4D6C-8210-BE6C754EE5FF@oracle.com>
References: <7318.1641394756@crash.local>
 <20220105201313.GE25384@fieldses.org>
In-Reply-To: <20220105201313.GE25384@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd58aed1-a50e-4625-a2f4-08d9d08a9996
x-ms-traffictypediagnostic: CH2PR10MB4229:EE_
x-microsoft-antispam-prvs: <CH2PR10MB42294AC563FE8AC89D698669934B9@CH2PR10MB4229.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jnNDbToBuR0yDTWONqboVemWKPQ1IPoxdqCuFtV9kO3gNGgcBRWGHrr4TG47SgoVjmAK0cClG6i1naWEj0SP+e3zoD5lYG5/cjZimr4B6LMbJ5Rz1b4Kg19aNB10+Xkel41k7iButkCJxLG8z1pfFYo8mwZmi4MklIRNuqqfluX7dM+PBPeCqjvoe9CFLsqSh9pwMxR6x//VmPhZTozhj3GCqA0aIg8jFQrWPZMv5mTx/hCU4lZUh1R2p+rR0MvrOp+ROjQzaeA3J65vmml6YAfnS+bO/MiVLMdblmlAJnzP9Ir+eDonnFTQvFc2OnFk5Y4bmp+fqyiYK/4/JBuntxc2H5r4LLjs0hteEiDy/3/fFepsXlGHTViFhI7n6OZfZ2AANnGCKobFRGQKfMJ+vq+dMDZhdo57ZbImHTNq6QIL2TX6B+nfXuRfQvPbCYUmpxmKaMuKgYFy9IqQywLWwqLgZpw0+WMt/fgEWOYpu0jDg61qRMrDeUEa0IRUV/GIG+FNvJag8PjtTB3W+xFkn4G75q06rDG1ohBjUAiRdoVRkRhnFEkyO1J3kula9GlQN4NEvNULF5S6BBxCo8voWLmuLaaX6NcJhNruY4AX0978QlBxxExT9AwEL6W8GhXUcspwJG/IZJuNsX27trjqlud4CHVLDTCmHb30ynElkkPBA3IFPlhM36P979KpOQYRGigbG7U0rXiMDDKrgfqTwcswITucJmJ9zYCrl6AESEUVmd+vr4FJv07mBgJvbfve
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(66476007)(5660300002)(122000001)(4326008)(66946007)(83380400001)(186003)(26005)(76116006)(316002)(54906003)(110136005)(6506007)(53546011)(66446008)(66556008)(38100700002)(6512007)(8676002)(8936002)(64756008)(6486002)(86362001)(33656002)(36756003)(508600001)(2616005)(71200400001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k4MiO4wQXuV+KrnYx/4mK5KyKYgQkpf/y4VXzNtPHF/lDEPN1DF+0EX2W8JT?=
 =?us-ascii?Q?TNFC67vorlJuK0JsQv5YXKFGdSIN5P+cw5fd6RK/ivqXb0CL57uv45+qEg7d?=
 =?us-ascii?Q?cTEjK/se8e8iZO/CFCYA+YameIkT6Gt7p+o7iXDXv9zARKYMp99hYEKfHdXv?=
 =?us-ascii?Q?s6C8aSiHUOcQde35qRiFJ8zHB+IGzK6zRmCbHTf2apGIRCcFojMZGHH20bWk?=
 =?us-ascii?Q?xKcx9TIHlxV7xQzUWlBHNYfKrZ6UyZSSb1sc9ww8k3CGBhhyp1yMKbqm/gSY?=
 =?us-ascii?Q?N0ymc51kO7c18VDy2SXJdLw4Na+6kmQD0427WbsWGPK4KdUOGdb5Pk/crf7x?=
 =?us-ascii?Q?Uwm+aMIMrY4zo6VSLjfw+MnUeMJ8UtTWBZWAX0qVma8IJD2dbRVUennzwhIt?=
 =?us-ascii?Q?k8y6Trm0Ab0EeLENrUjA4bo08nwJdGS2MTehcOxo47+AQxP63yxkycRWjJDC?=
 =?us-ascii?Q?5ipWmcqu05K+FKl1kKnyjNkeZUTdXo4oH1EEe5NTCPceH92YzvWEygDfuUcR?=
 =?us-ascii?Q?SDwYikWklTQrEOQHlr/yjoscg+5TRhub/zGIftUnaMr7TjY+50ZIAwznSBCp?=
 =?us-ascii?Q?9HZKyQX0LlCyG6Fp4s66Ts6ICdJ+oFIjp8oU1K/O920WWQgV8AnmoeqHzzT5?=
 =?us-ascii?Q?PHZAYAf6TXWED8VM+90+tspz6lGApLrAY7EPFvepfGIN2ZC4XuEyYbu1lT8J?=
 =?us-ascii?Q?WJPnMLZS3yUWKY18LpdrxutSaZvqx4gpsyYYRAr+WWsyTUePBffEJtzMagUX?=
 =?us-ascii?Q?qQezsG83EYG4mrEtYJuKBjmRRta5mjkyA3hUs/6hWTfXEPvtBb3Lvc6qXCjl?=
 =?us-ascii?Q?cOxioZDoh6/9elAYEqlIOkq6x/S/XTmZLO+kg1vUDb7y5+hKrZGkOjMHkOAM?=
 =?us-ascii?Q?oTHJKc8lizxc7XXiOxYK+Js1mdCjSTlrsaL7wZPC2jwIIfr3qtMpbssXmopw?=
 =?us-ascii?Q?uucFj2AoXWLKK90mEvqBn2FjmIZYYqHawLAF53aNU259Ka9wZ1T7Flhw2l+q?=
 =?us-ascii?Q?kOOAJiE4RGFTtLGWSSQfscBEaWoK9UcSDRWYsCijA+5fIUJ3g/OLZ7hJ3tsw?=
 =?us-ascii?Q?NilkGcZQyCop0+X6WD5B8RMV/E8o+1GnlU5mdQHp7jwXFZ+HHr4Q+zlTKNgN?=
 =?us-ascii?Q?0dYqwVZMV6LOE4q+ua2BdQeawAvsZZyFLUaP4VpDCJXaVbRAuaqR1G03e6wD?=
 =?us-ascii?Q?AfoBcIPoSztcme2X5H7prcKl37DDGW37UFVQI0NrAMd56CXqyXc8Qg7ZB9Ti?=
 =?us-ascii?Q?Sdjq9xchF2LPRCKf+dc6iBr6a3jBHRjoIyB3JaracbPyzWRmCrUikP2OO0y9?=
 =?us-ascii?Q?z4wtjTQSs6GluyZSe3xKww6t/0HRMIP+WeWCZ91Jbu/tRocZn2xk3PPx5k5h?=
 =?us-ascii?Q?BAc38PFwLaYf7bf1xkqGOX33Rn/mr0ywm75KtILmezLQ0NLnBzB7b55caDod?=
 =?us-ascii?Q?1l/hxTz3kDeSrXIOYbtkf0PBNA3+2DxMLr7maeWadKTzWAN2/i09drQskGnc?=
 =?us-ascii?Q?qmWLFfuCXNKjuA4/tXFcHC2aZybspfWkx8PMk3rBRpkNB4oqnIumI7aJpi1I?=
 =?us-ascii?Q?lc64qb1y3opv3dUIBeWvdWZOk5xQaW9STBDxfg497X6OZIJdfIgEsH5JP/7O?=
 =?us-ascii?Q?ScSh047z4KcHCvNrGbzrKAg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7CF8E723D69C1418B546834F4F94BA7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd58aed1-a50e-4625-a2f4-08d9d08a9996
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 20:33:14.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3OeQ1MfLVLxhiZ+pNkltK3JhDmcpWXnIvOFZxga1gYAfplrg55My4RGLisjiUfyqF1BH5PI3Bs2hQVL6kVsb0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4229
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050132
X-Proofpoint-GUID: zyCCLlTv2VR-XPGU6zipIoALNKoM4b0d
X-Proofpoint-ORIG-GUID: zyCCLlTv2VR-XPGU6zipIoALNKoM4b0d
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 5, 2022, at 3:13 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Wed, Jan 05, 2022 at 09:59:16AM -0500, rtm@csail.mit.edu wrote:
>> If the special ONE stateid is passed to nfs4_preprocess_stateid_op(),
>> it returns status=3D0 but does not set *cstid. nfsd4_copy_notify()
>> depends on stid being set if status=3D0, and thus can crash if the
>> client sends the right COPY_NOTIFY RPC.
>>=20
>> I've attached a demo.
>>=20
>> # uname -a
>> Linux (none) 5.16.0-rc7-00108-g800829388818-dirty #28 SMP Wed Jan 5 14:4=
0:37 UTC 2022 riscv64 riscv64 riscv64 GNU/Linux
>> # cc nfsd_5.c
>> # ./a.out
>> ...
>> [   35.583265] Unable to handle kernel paging request at virtual address=
 ffffffff00000008
>> [   35.596916] status: 0000000200000121 badaddr: ffffffff00000008 cause:=
 000000000000000d
>> [   35.597781] [<ffffffff80640cc6>] nfs4_alloc_init_cpntf_state+0x94/0xd=
c
>> [   35.598576] [<ffffffff80274c98>] nfsd4_copy_notify+0xf8/0x28e
>> [   35.599386] [<ffffffff80275c86>] nfsd4_proc_compound+0x2b6/0x4ee
>> [   35.600166] [<ffffffff8025f7f4>] nfsd_dispatch+0x118/0x174
>> [   35.600840] [<ffffffff8061a2e8>] svc_process_common+0x2f4/0x56c
>> [   35.601630] [<ffffffff8061a624>] svc_process+0xc4/0x102
>> [   35.602302] [<ffffffff8025f25a>] nfsd+0xfa/0x162
>> [   35.602979] [<ffffffff80027010>] kthread+0x124/0x136
>> [   35.603668] [<ffffffff8000303e>] ret_from_exception+0x0/0xc
>> [   35.604667] ---[ end trace 69f12ad62072e251 ]---
>=20
> We could do something like this.--b.
>=20
> Author: J. Bruce Fields <bfields@redhat.com>
> Date:   Wed Jan 5 14:15:03 2022 -0500
>=20
>    nfsd: fix crash on COPY_NOTIFY with special stateid
>=20
>    RTM says "If the special ONE stateid is passed to
>    nfs4_preprocess_stateid_op(), it returns status=3D0 but does not set
>    *cstid. nfsd4_copy_notify() depends on stid being set if status=3D0, a=
nd
>    thus can crash if the client sends the right COPY_NOTIFY RPC."
>=20
>    RFC 7862 says "The cna_src_stateid MUST refer to either open or lockin=
g
>    states provided earlier by the server.  If it is invalid, then the
>    operation MUST fail."
>=20
>    The RFC doesn't specify an error, and the choice doesn't matter much a=
s
>    this is clearly illegal client behavior, but bad_stateid seems
>    reasonable.
>=20
>    Simplest is just to guarantee that nfs4_preprocess_stateid_op, called
>    with non-NULL cstid, errors out if it can't return a stateid.
>=20
>    Reported-by: rtm@csail.mit.edu
>    Fixes: 624322f1adc5 ("NFSD add COPY_NOTIFY operation")
>    Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 1956d377d1a6..b94b3bb2b8a6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6040,7 +6040,11 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
> 		*nfp =3D NULL;
>=20
> 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
> -		status =3D check_special_stateids(net, fhp, stateid, flags);
> +		if (cstid)
> +			status =3D nfserr_bad_stateid;
> +		else
> +			status =3D check_special_stateids(net, fhp, stateid,
> +									flags);
> 		goto done;
> 	}

Thanks, Bruce. I'll take this provisionally for v5.17. Olga, can you
provide a Reviewed-by: ?


--
Chuck Lever



