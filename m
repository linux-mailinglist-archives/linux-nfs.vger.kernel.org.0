Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D5974DA9B
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 17:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjGJP4Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 11:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjGJP4H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 11:56:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C1E10C6
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 08:55:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ACRBsS004892;
        Mon, 10 Jul 2023 15:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=B/8DHzg4UK3rMp9+l6796mPaMLrLRIixbzsoXUHZKPs=;
 b=JQPu3kyOcx8DbBgwUQ7hYGDqWLHyOdzqcKVqQbZ4JHvzxGlOkV2V5QU2HIhX7WhrOeFU
 g5oMrdljVQ+07iRWzS082ZkjAF9vRGdDXJ+UMD/nXQ3IoZgcGpUX6UEQhSMqLeMO9XiH
 RxxpiJ5Bhzne8+lajN76Gk5jvZERAZQyPzwpYPf71Br9vxJfLlJnetJZ3ZvQjwxyZnFD
 Ja83F0OSh25h/svs35MyigF1hZT7AaSR56dWJQbzHeeFDBVBzt6szIrq+Of4JIh8Xe00
 6QsB3cO8KXPz2CHQ5PDhtZtyPKWDPA9qGAuTTXlLsdx//Y61RonX4Bfgw0yR7qiQYhuw Eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr5h11enf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 15:55:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36AFli95004014;
        Mon, 10 Jul 2023 15:55:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx89wanx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 15:55:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXmtFgdotkxlZkejSpGkeGqxpmYahQnfrVqoLpwq5qni34w+pZ0Umi1sWiLemLA45nGo9CGy6H6KSm2AUMMHyGjE/NAsE9BwtvdGR/G+2rcxSkCUAy9YInQFIhGttEvO1Rsqxw3ooTwav/cPzWA1B2aHPJL9YIsTn9CPvmmYynWjWBn+E37znyulBHqywv+OH3yEyEw0fFHuInVdh0v50pzUzvwuYgRXAY6xWDzgwfNm3zAQXjHSGoEwWbsi9fO4HKACLwxT1XHTPXtlXVict06DiX6e/hM05vkNKXivXtglGlgpNWNeB6STi+60f1jPjj9b07/Lr0bKtb+wYstIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/8DHzg4UK3rMp9+l6796mPaMLrLRIixbzsoXUHZKPs=;
 b=k1XtnHoskGX3fagyFDNaRQ9GxwxRtEJWYREmczrz5xNquWQMagmkf2VWdO/ydzHW3Bthr1O2qIgVAwxHqWMJezcXWfvg1Rnd1tlDHHw3AxWgyhpOCsiJeOIqTg1kAu4GBQlEerdiBeiCL1sATpZduYEkYCTLJY7DGJ54SRbimPIo448IJxCcslBJ9lsWalMRu9kuMDpj+EBRn5bqwVRkDW19JDaEuFRChILUypqF2VeV2d1j8CFhczcusTDyNU6nNfNa4RLWb7BlJokyWavAOICQ6LmjkHYbc+MgbOWUcuB1dBJiEm36iKJdRnWHBhhYFSboCIQj4hMUiEub8nwXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/8DHzg4UK3rMp9+l6796mPaMLrLRIixbzsoXUHZKPs=;
 b=Nvo3v3phmfgTYXPVFWrL1YUXaTbrdlkhSlqQRhdpsRP871dJDuY5ycMNUB1k/yfVd9esMaxDCnACa2w+Hiiz3JL8BradfqQE3dxQKxWCY7pFRTBdqlbWOwxTBVtzftMIdB1PT4QFJypRd+Y0/Op8pJS/aPdpUzbESJujmtPmXZI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5847.namprd10.prod.outlook.com (2603:10b6:510:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Mon, 10 Jul
 2023 15:55:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 15:55:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [RFC] NFSD: add rpc_status entry in nfsd debug filesystem
Thread-Topic: [RFC] NFSD: add rpc_status entry in nfsd debug filesystem
Thread-Index: AQHZqnL2PhgnbC/p9EORLOfjtI8RFq+hzdIAgBFk9gCAAAY1gA==
Date:   Mon, 10 Jul 2023 15:55:38 +0000
Message-ID: <E916B0DD-7470-4F2C-A7F8-13DB070CC593@oracle.com>
References: <bac972c22c5acfa43969bb1bf164341b16ea045c.1688032742.git.lorenzo@kernel.org>
 <ZJ2NUPdX0KqvaUlr@manet.1015granger.net> <ZKwkulG5mZFRnFFD@lore-desk>
In-Reply-To: <ZKwkulG5mZFRnFFD@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5847:EE_
x-ms-office365-filtering-correlation-id: e722c2f2-d0ad-4ea2-f45b-08db815e1ae1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 40M9RES8waQo0KkAVv/cKA+1Ck3ghgaY10BuZyjaWnxc7Pjc4Joiov48RwgMTmZ3ZSLNzjsy74Cx+5GHMAD4BFaFAA1/Ofa5yfAWooW4Ut4zq7fRBb37V2/xR0FhaeNX5K1bdOK8Mah0bkmvEK8vhkZzA1ravkWJSzxac1V5/04+lSUOGFWJi1of0qugOFBbjIKHGwORVvHbH4n+NtyYbM7jiOoAH5n9ja1X6CjoDJgprvg9t2Pv99DuuBWVjQf7z0uFB12f0KeftJwegQuHRW07PqWzPFFBOpkBhF7uZFpA32jBv1DQGQ88edvAUE5ZKLY4QbHrg/PyabptLptRyMNbhvIKoxC72lkOZ/O1fQVB4V+F2vaJt/aUxFF3x243NMm3yBFLR/1Jram6MFrCJCgPcnxIDdz8F4lSGmPzKbts6Dh31lvgPIW7M9loLIooXGX6Bt8QJswnfPOOtnoT4/z2x0lkouUybCrdCLEfQKw9mPPQkOK23o9Ni2zgyDBuwJCVOUOgq/oc32nG0y6LsWM8DQfrv071Uoojd5sq+SI82elLbuP68oWyJHenDYdfm3UieYXjsYca36sdzq8F6hQlMPOSbO2C0YylJNe6M5Yx75QNwYo0YGIgzEuuKeyXhUc8lAa9RPBYM3LtaVL04A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(36756003)(86362001)(122000001)(33656002)(38070700005)(38100700002)(41300700001)(8936002)(6506007)(5660300002)(26005)(186003)(6512007)(53546011)(8676002)(83380400001)(71200400001)(2906002)(66946007)(54906003)(91956017)(478600001)(316002)(6486002)(66556008)(2616005)(76116006)(66476007)(64756008)(66446008)(4326008)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hlp1LcZeJiSsi1/Z8TFpPDwXtB5zSO+UUYpiS1WKOhoO7KMfgD46ZyrlgxzG?=
 =?us-ascii?Q?PW99sN4PJGQCU9diQFdELVHuqk40Pbiy7ZRmWaN3D7OSHdh5vAShnbBwtSbt?=
 =?us-ascii?Q?C432CdrXbUI0AacJMc3h8WmJAODwVMhsF94s5C3n+J84ajKquLP8Fx6anZg3?=
 =?us-ascii?Q?iUa0ebViu2bt9896nb2Cn0JVc95lNzoSgWWGOGaZDczyYvL13qkPiB7LtGRG?=
 =?us-ascii?Q?UaEcplc9VbUGH/WQIDm0bSRiZWWk4gOrYpaaIQoYFrUAEA8izBkiN1cXnMyI?=
 =?us-ascii?Q?wByCgNgntdtQgkFrLiEenm4ATx/LdTdg6zEaggKxdm0+abaqXVcXqnp6TDJo?=
 =?us-ascii?Q?84OR1iWCgrl1GEH70xvE/UqzO83zwHwCrBSwa68opb6j8n6GDIK4mfKknZKl?=
 =?us-ascii?Q?PBW/H9ya9eKhAY2tiLVrE0y8TznfRpcCP21BHL6+oEOL6EyzYWYUMcjvQXcJ?=
 =?us-ascii?Q?Gdmn7Ipoes+hStA9eMVTgA+QVLjYv8zo3lkFJhiNQK7c1I2Kt5xoC2F/CzwZ?=
 =?us-ascii?Q?GJBiYcc9+mCU0kDHMGI/CmZGYbTXhBUG2Hnjr6h83TXymUxwgChUJSCd6cg+?=
 =?us-ascii?Q?2/Oo2zFqN2MfSKgORhKMpKbwhX4d2CN9sa7XrGqq3bSNrtzjuVF9FBQz9UMW?=
 =?us-ascii?Q?v3FXn0WBfOlimx4jiY4IRhZ4oGYKezBKbaPJNAr/2mLAbVdM8oX4iwkwm6gH?=
 =?us-ascii?Q?Y+xqLOC/knvM6FAlwRTrx3bzcZ4EBO7vhatlv4P2uZVZjY53H6fQYb31C7cy?=
 =?us-ascii?Q?v9JGQBuz0mANGeF1iak3PnCugAVIPlhqkn+WRhr3X9Mb1UwNh9BN88ODWvuW?=
 =?us-ascii?Q?0Gb1+BeoHCCCg1QhY1kQHORf30Wka1f6FYfCEwuJLlwuCBC8Xif80KPZWupm?=
 =?us-ascii?Q?5Kq0VrcDKVjJRqUtj3pcyWIFS/hZvsZEB362+FkTu83xSna4yqTyZE6bfZN8?=
 =?us-ascii?Q?wBO06PaXq8v88dfMD74hyfqIhClB4ZebykkHax0/fqkZtrwSlJzGOwvgZOXa?=
 =?us-ascii?Q?TXtdMuu1evo8HWGLO0bkCsmUdOC6K57wyR99OwN+01t40VHFKiNuV+YMpkt9?=
 =?us-ascii?Q?BM/7BM7318VsLhKVLqohF+U2bWpTGmm8ralUB6eZHu5Knw7b86C6Vn4Y8hsh?=
 =?us-ascii?Q?ntRsspDSer7vQUR/5zE5SA0oLqJ5+gsl/tZPbIGz+brQBdTT+8hMs0MLP44d?=
 =?us-ascii?Q?XpdN8mnacim8rMU1btXRfOffeusQu0Jvdm6KeoScVjsm4X6zK/qhxJweQF9y?=
 =?us-ascii?Q?ou1TE65OCmg9d+fvqoKIrmsOAj24yXCNYwkB9SR8F7NOvakAvgm0RxfKjvcR?=
 =?us-ascii?Q?f0VwEQbEFEOYLQ2x57QXPcvekpR8v+gSNgKoPV4qI/3Qpc07bkTzcJW5fjjB?=
 =?us-ascii?Q?Ecdquy5qWWal55z1T2owsiqh/exRK27XX+rMEPWteuWHJgVvDq50JjjOLVN1?=
 =?us-ascii?Q?/15hl9YHqLHZ9pYiBMWr4TgGyinQYESqzycdA1ROwcNy3lW6wnh4URgKdkuF?=
 =?us-ascii?Q?H8WB8FiwVnmkxYEL0f5GDnhOqRzWuc2ZlQps9t26PhTqPE7F/hxhDl8RF5Hk?=
 =?us-ascii?Q?iG3wHtAhfohOAfBjZk5VoG8IuUH6Gy7kayizcii4RvVncUqylv/l+qqnxO1J?=
 =?us-ascii?Q?gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5B760EFB3972D4198DC088922B68515@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nQ0Cj08fXyVnYy9yHloCqpMe/b/Q5GiB2+rwsrPhibzyAbmd0WvN/yVRZU9ewU4MioZnC7wzG/7XcQw7XbRZp1/0Di983Yt06/Dj/5nfPXVFIkXcEx5lKpvvkQ7Np00fsLCPVX+IX3BVqxVGPascn9RNkL4Lb/fo1Dx4uFmcn1vOsfzRkvUWj6yj5Yv2YMzNmCn3TXV3UEYWm4l3JHO3dPw1p9WriN+3Ijr1TStHiGstk/ynvpV57bZVDHNK4+5SJB+9iTaKHUrmS4pQb95yLZYGHyTcgjDL8BTunVVrjlgL7Zj+YFUYuUkhBp+3E2N7Ub0fn4ZM2sth9okOfELi0/725Ekz+BJzVLKeMn/V7WGNqWCO6cVGj1mjfZGFu2+Btq5WAOvPuz1yBk4yfrnbhRomKAh7m2vsZIFt8I8m3M6tirIkQtCKAtoWHNKK082T1SfpslRQLvbGG1dNo26/rvSdfOsMHaM1D8KSgOhmVF3OmE0tUwVVGuZO89UUHrXRApzXK/3DluYoQ3T4EXDmlsqo9itO+j01STA5qlbr2TpYjxwUbwlwVOMGrosr3vDV/ma1wXkhPdTwko6nEBnlP4y6qSGyYQ6VLL61+qjbXvnajnBs9dhc32AHVdmU0K+359aU8Ywe+J5qV5VagkPD1BbmuOmUGhA001rZjOGyqCHIj60a7C7dfQLoELS77sMubJBnpBMHcDXJV9d9bLyEpKZfjOU6ZeV5y6gjqd1zGTZ0JoEmX5L/QJg5zjxEhNRWbpxL6fZoWBU4y+w/r9Urh3yP6al/1yNL5PzPL86FdfhnttIvq4JxB5Oy3z6yeiDE
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e722c2f2-d0ad-4ea2-f45b-08db815e1ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 15:55:38.0565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLLZoXZt8ZcNH436cH/dW15LXuFapD5wwQ8qrUer8qaRyAXVLA5M1oiYzC5I75+apyTO26s+8k76l4bpxBMYug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_12,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100143
X-Proofpoint-ORIG-GUID: v3xY1KcbVUwzIk8VzcKq6zNLs18HXEtm
X-Proofpoint-GUID: v3xY1KcbVUwzIk8VzcKq6zNLs18HXEtm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 10, 2023, at 11:33 AM, Lorenzo Bianconi <lorenzo@kernel.org> wrote=
:
>=20
>>> + for (i =3D 0; i < serv->sv_nrpools; i++) {
>>> + struct svc_rqst *rqstp;
>>> +
>>> + seq_puts(m, "XID        | FLAGS      | PROG       |");
>>> + seq_puts(m, " VERS       | PROC\t|");
>>> + seq_puts(m, " REMOTE - LOCAL IP ADDR");
>>> + seq_puts(m, "\t\t\t\t\t\t\t\t   | NFS4 COMPOUND OPS\n");
>>> + list_for_each_entry_rcu(rqstp,
>>> + &serv->sv_pools[i].sp_all_threads,
>>> + rq_all) {
>>> + if (!test_bit(RQ_BUSY, &rqstp->rq_flags))
>>> + continue;
>>> +
>>> + seq_printf(m,
>>> +    "0x%08x | 0x%08lx | 0x%08x | NFSv%d      | %s\t|",
>>> +    be32_to_cpu(rqstp->rq_xid), rqstp->rq_flags,
>>> +    rqstp->rq_prog, rqstp->rq_vers,
>>> +    svc_proc_name(rqstp));
>>> +
>>> + if (rqstp->rq_addr.ss_family =3D=3D AF_INET) {
>>> + seq_printf(m, " %pI4 - %pI4\t\t\t\t\t\t\t   |",
>>> +    &((struct sockaddr_in *)&rqstp->rq_addr)->sin_addr,
>>> +    &((struct sockaddr_in *)&rqstp->rq_daddr)->sin_addr);
>>> + } else if (rqstp->rq_addr.ss_family =3D=3D AF_INET6) {
>>> + seq_printf(m, " %pI6 - %pI6 |",
>>> +    &((struct sockaddr_in6 *)&rqstp->rq_addr)->sin6_addr,
>>> +    &((struct sockaddr_in6 *)&rqstp->rq_daddr)->sin6_addr);
>>> + } else {
>>> + seq_printf(m, " Unknown address family: %hu\n",
>>> +    rqstp->rq_addr.ss_family);
>>> + continue;
>>> + }
>>> +#ifdef CONFIG_NFSD_V4
>>> + if (rqstp->rq_vers =3D=3D NFS4_VERSION &&
>>> +     rqstp->rq_proc =3D=3D NFSPROC4_COMPOUND) {
>>> + /* NFSv4 compund */
>>> + struct nfsd4_compoundargs *args =3D rqstp->rq_argp;
>>> + struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
>>> +
>>> + while (resp->opcnt < args->opcnt) {
>>> + struct nfsd4_op *op =3D &args->ops[resp->opcnt++];
>>> +
>>> + seq_printf(m, " %s", nfsd4_op_name(op->opnum));
>>> + }
>>> + }
>>> +#endif /* CONFIG_NFSD_V4 */
>>> + seq_puts(m, "\n");
>>=20
>> My only quibble here is that the file format needs to be parsable
>> by scripts as well as readable by humans. I'm not sure I have a
>> specific comment, but it's something that needs some attention and
>> verification (with, say, a sample user space tool, hint hint).
>=20
> maybe we can add a csv hanlder, what do you think? not sure.

I suggested JSON to Jeff as another option, but I don't think we want
to swing that far in the other direction.

There are plenty of examples of /sys files that are both parsable and
human-friendly. I'll leave it to you to find one or two formats that
seem capable of the task at hand, and let's pick from one of those.


--
Chuck Lever


