Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BBB745E01
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jul 2023 15:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjGCN5d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 09:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGCN53 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 09:57:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CBDE51
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 06:57:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363DTMOL023141;
        Mon, 3 Jul 2023 13:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jMjJANQC2P0blrIHZcZBxxeSXTkr/C8qeh6fP5EjNP4=;
 b=WI7JsGy564fbxCAX8IC8SGkC5+CYd1Sr7dg0LrfcO5u9DZEf3yG0w6VGcBJO8WpSkZp6
 jc55Wo7CqjHRYyrVoDgXy/cBxuwdhgfocBLbPAZGIDwVGAn8kV2mCfJR++A2/kXepONg
 8FC7zs1z9VlBCvuUpVLZ9MeelgvrR7ziqwAxkM2W1mFzjZ7N79peP1bNRromLAPd6Yhv
 nCJGjkksZbWyfgUgXiwYtqxcvvUMhob+CTepFXGhk3TqCbYk3H2ERW4mDCuzEN0QxBXG
 F1b3D/S8I1wjgqBfiUyhcgNfT6M9+6w8hVH7La2waDGVXf+L7aOC4vvvdGECTUvQMO3Q lw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjar1ar9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 13:57:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363DlYPQ039224;
        Mon, 3 Jul 2023 13:57:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak33yy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 13:57:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2OnRMCMBS0NlhCJl70WoHKAdYT9gx5Mu54kXv2So7XF48yPO/h9RPPnksCu8WLVNj/6ys2wNOCO8QjopoJgfSPt6bNeSnG2MPgPE6j+8SFi8ohY9NcFWTCHh1qGfbfSJaXgnJc30qryRobBB/CQjGDjcKHhAAGM2qMmVEwxUiqKJP/jo3qGg1jrPJaOLXOYtdCakPeQi4vCS8gYbMwNktvExyAsJe3vA5iCb4r4Y1MzXJFt+IZY4Ti9kuDAjvgQzdrYPZ3Bndj0p9rpfjwFhQap5sf6SsEDU30XgXbq4bqjC00U+we5rZ+GGfk+39poM7WGMW8QxH8OcCfoMp+MEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMjJANQC2P0blrIHZcZBxxeSXTkr/C8qeh6fP5EjNP4=;
 b=mohUADyJwogn/k2PYSAbXp+jCzo80Y7uM/GAZA+wxk/fQ54TCjgoFCDFuLc5pZ6BOH/auGYEMHMfl+cGESRGz8ai78Ju4Swlg+2GyB5nB+2BoV2q40eNLxz2k5mna5mNbLhgdbdydJAVNBM2euUFmWlNXMgeZyWsY0TS/kStWQ0ke/MhS69UelQbPT6eDq0PQ3ydTkcIVj1LtWEcMVVeSetazj92aPlvg64oA8lVy6GxXhD0501KgQVEKdc4kVwt4iKbvqmqcAhaGkJIDtfvTXweXs8ObQw33O5lbAt/LT7sXoQdC3bE3oTisY0kpf0zfcfS50UjKrLp8h8NkAH6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMjJANQC2P0blrIHZcZBxxeSXTkr/C8qeh6fP5EjNP4=;
 b=iRMiNzsoVbIvCzJZ9eZuJbpMac4aUDaHqHlf/SxMGxbeLQM09Wbs8hm809sUiSTGAPdbrGP3CuUBWPJGKjJYUf2wMYRrdbe7OQsNeVlUMno+uJbWxf6FhVqQExsZIVwpacM2lzBvPT6ivxProuKQsHfQ8+6/d2YBmmomdapEdbE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6653.namprd10.prod.outlook.com (2603:10b6:303:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Mon, 3 Jul
 2023 13:56:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 13:56:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 0/4] Encode NFSv4 attributes via a branch table
Thread-Topic: [PATCH RFC 0/4] Encode NFSv4 attributes via a branch table
Thread-Index: AQHZqvMKgPkCgxCJ3UKxuAN3nOfCL6+nfTiAgACZHoA=
Date:   Mon, 3 Jul 2023 13:56:19 +0000
Message-ID: <F0F2C0F7-3F73-4713-BB37-661463646CC5@oracle.com>
References: <168808788945.7728.6965361432016501208.stgit@manet.1015granger.net>
 <168835968730.8939.17203263812842647260@noble.neil.brown.name>
In-Reply-To: <168835968730.8939.17203263812842647260@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6653:EE_
x-ms-office365-filtering-correlation-id: 72fc8b8e-e4fc-4746-423e-08db7bcd4733
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WKhW4XuAP0udeXAh2+uKuozn9FugFQar/yvGopJ5AMTPVam1xlZkXxl/6TgCAYFTv0C+DuE63u3DncRUajfKakhFPxdIS4tzi7n2YppgJ1RsrD63JCHCLWUCzHEoXfSfvBa4gD3cSTK787qC0IirciOzmguLmYHFx5CA8puN4i8PPtSFtGHOo/yJus2s+AHk0l2IF2EIZTR8t3APA1jU1TGbzaOV4SN9Rlf6uK90l7hksPwOQIKrI4yH24X2+7V1K8fwuFS53DyDS3mcNKVx40ZBCNIPlfq87lsT2P1u9VBy2OlJu1JjnNLMHh6ImTg2yKOyL5uj7bf33WuYh6zeREVIkZh+BvtX+Wl3Xmzj5ROu118NvRSZt/aB84xOp/Qc0dGEOqK2v0mDF1n3q3+IMU+ipk+sCwMH6wkW0TQNHLyV5iA3YCyXmtTqDEb07G2zYe7qcE4sm/QKr6sLTXz4rMsErWF7CwnhN6P3yfLL5M54egdQhhMNOZ96kpx1f7A2swAVP9ZMsRGnq43xMJu7rvkzp9l4TjNQ7+0HiCGf97z5j2J43DPWXR0CRkgbJg1/DLej7+xQph0+Fpm3bB83Zup9enlV43QwezyF++kZYe5JIf4Xc1FKTEGNBXbbhTOXi6/g/OYisMTbxOn9+TkS5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(86362001)(33656002)(26005)(66446008)(2616005)(6916009)(66476007)(64756008)(54906003)(478600001)(76116006)(4326008)(91956017)(71200400001)(36756003)(66556008)(66946007)(41300700001)(8936002)(316002)(5660300002)(2906002)(6486002)(122000001)(6512007)(6506007)(38070700005)(8676002)(38100700002)(186003)(83380400001)(53546011)(66899021)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R9JPzp+flk109Cu7u3K96T0KXxEIKK5TvgjtyXumPE5OzA+7fXGRblPxGDEm?=
 =?us-ascii?Q?ls0YEFBY1X8OqtALo7WavDE71BkWdgwWQmxY5kO+tOEsnBv3F0u774QXNebQ?=
 =?us-ascii?Q?Av/0TvkB9mmGm2oYyLGxj14hf2bsbf1QpP+Fo5uknLje784SmkBkfEePgi1y?=
 =?us-ascii?Q?UxlA3+KccmRf3A7w72FTMdSBFaYV5o616kY3kJbZKzhh5uZGQF1R5Y8yQEXe?=
 =?us-ascii?Q?47iAkk7WkZGjZo4TCntgv9JbnTSkL8DRLEz15CZ+wrRjsV5uMTkGA4Kz0C8p?=
 =?us-ascii?Q?3JPtj7GWHUzJyMdgWyqoU78piLDCgRz9AOScD/RvDySJjI8UjOzzTlWjo3HB?=
 =?us-ascii?Q?5MD21t5u2WgZc+3GZEdfVY00qW7lsLsexB+phbK38XrGAiTeOWdh1bdXL7yr?=
 =?us-ascii?Q?lpBzVfHEGJCuVXguLuGI/G4RUl+oXRzboQJsVsg0NktRJW+XIP9Mo2t1pee1?=
 =?us-ascii?Q?t1DmLXoH3hbkUytiKESQ5BRQqeumAzlrsFUSRoSaujenqJSjOYlwBLJMwj2A?=
 =?us-ascii?Q?Dfww/c1C9plZe1yRXzJ999CutITYZSS+kpFTo7DW9oRSewoOn9o9bi4Ma0cl?=
 =?us-ascii?Q?Qh+ows5635kMUAl9NFSELv/3/r+SzZ3iz6F9pbXnupRpQ+XOnOAOLpB+0/6C?=
 =?us-ascii?Q?KNegh33eyN3iDjRg/xpLXCTY/Ul6zgArdJoGD50qS7nALWr0vb0gemG5gVzW?=
 =?us-ascii?Q?DWkEytvyXYWxdmhHDHDN5cuAmS1HjLwHSiXHZW5CSYJ8A5UYhzosAVE+lb26?=
 =?us-ascii?Q?HtOlHSuzl93bLKLggZsSYFxq141LjOU2tDPtuAmDOceNW1tOLlG6XJZmgNtL?=
 =?us-ascii?Q?/9N1/nDpl2oxIVyzrN3mg2HXN0NLjA9QkwkI+vO/G9bT/J8tMx+FQJOpILOb?=
 =?us-ascii?Q?NTphr5xJnD7Xl/RDoRfLDw9qtLzYzAoGFqwUXqKnsaYdxbsnBpFgQkVr77YB?=
 =?us-ascii?Q?rkIF8Ul7f8I6/4s421lrC1uJBgtQmCj2GVDixh1BRAOjfIUatAucwKZKz0Lj?=
 =?us-ascii?Q?bUT3fhYaW/Hl184gF3kY+2NyFYkl0ZD2yDO5Gfe/eSteidQkbODO5m4weiIj?=
 =?us-ascii?Q?y6TIW0xsduSxVIj1c8wfiFqs1n2Esk/cpyIS0TxjVLGJRBuJKYqd0eGJES/Q?=
 =?us-ascii?Q?/SsFKhajF3Kg8XlgBIqRjtBUSTzbfYyF1snIl54fXodwlQlKQBZgS/7ATEwq?=
 =?us-ascii?Q?XSywKenNWKhYbsBFJ+oIjZF33NIAeHF6BXvkANtm5PG6zliOPc2kgXicbGSj?=
 =?us-ascii?Q?4/1oyx0lYllJDmkwaMaP58SrPAN8XD5mBUVrf4y2gY7T1AWmBaIikbW0ZeLU?=
 =?us-ascii?Q?xA45PHFcH+YUg+jUzZ1SFQg/n9emWOKEQT+cnXGFj41+dyEsW04f1/ilW6Dk?=
 =?us-ascii?Q?4kcvyEjy9kJJhEUiGGuh51kMUp5BRsyWWRz58nkvJ6tPFTnJ/v7XBZDiuerL?=
 =?us-ascii?Q?8Jr46LaA8ykyQeiBxPD2E+XkOWwcrEJkmcdsm6QdVxiNbXE3cqbwW2SrxYFz?=
 =?us-ascii?Q?SnjkFkPA1ip5NrAqQ3MW19ddAuFHiD7i1Vv8h+OWYsAp/ChFcCB84fgFpZo3?=
 =?us-ascii?Q?PTHN5mHltLMcJNIzh6GHqAsGC7d1KmEo1zfWmc5cK4bqwEL0srHYqsC1O0dj?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F16592F3FD41D4A84EAD1FCEDC85F14@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EH0vbJIkcKF6j+DHUTP3KClOk+ivULv1trdz4Nl3R0rtckseuY2cIW35l5itYdiah1ABtiZMBcVruNwx479P6XMSMuJB8SutkakZj4pIaFGguExexDhx1tKqZaokznHpSadb9Ec0EydLdGwTJBk7aGrUvgxoGbbW9zz5yXjrGwvGsjb6QI32p4Pv7ViWn45NBogotoEx+4+C89tchXunZIdyUIozOSM8u/D08mq6B4V31+syyGD2Cz0spaEnDgGARlZrsaKB+ZthRpQjY6GXjHWaZlGSvZolsdCNfsHrCaAWqGWmpBDctghLX1PucBg9MpkjGXhjaSDEJSAHvWGKA1KvGX/B5rwPcIo0vrnVYkZBCCwOCIgVskpBEjjuZrDJdmtqRfMFLWBd7OeUGpPtxsY+5LY4KlQwIxCfFXw5ojIPqYFSL88CGq+hGje97yV8DeMZGv01A9BBqOLolKjtEWoabHlJHwSXf9ktoJ7hfrM9N0AgPI1urUGS45YMb6tQLw6xbitfPfm7cmXE1+waXFASOhxCAtNvlnjaAa9i1C6GXBpjXdgsxRGs65iIGXH/qaQcB1DD+6BRmz6ZTxkpg4P644/ZdFmOO+IYXDR7HzUz4L7o+gTUiFO7hG5ne/KIOs5J9UW4qaHYvuZI1nxRE5fdWfaDRVNIQxIbrINwV4WP2m7mB2WYHh2dw37KfZnuPKBUgFGVVMI35RJk5XZEBXZRMihlKIfSgGTXxlSL3bcZr/FapCsORBicBOVScJrSvVSoYGROB4dELOG2iFiOaVTd3/ZniyuxGjBukzYEuXjDdMNUtYBWILr+gHc6jymx
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fc8b8e-e4fc-4746-423e-08db7bcd4733
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 13:56:19.5863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzgN7AZmMM2B2Bf8yqHKXOf+xofj0Zqk0jD//TjvYkcNi2qOTF9/EQdGxeYiXsNZBEGuxDgOuCWqAGKdT1qi+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030125
X-Proofpoint-ORIG-GUID: w78on13VsAMIxBszCLBTF6o_9grvmYKo
X-Proofpoint-GUID: w78on13VsAMIxBszCLBTF6o_9grvmYKo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 3, 2023, at 12:48 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 30 Jun 2023, Chuck Lever wrote:
>> Here's something just for fun. I've converted nfsd4_encode_fattr4()
>> to use a bitmask loop, calling an encode helper for each attribute
>> to be encoded. Rotten tomatoes and gold stars are both acceptible.
>=20
> Tomatoes or stars .... it is a hard choice :-)
>=20
> I wonder what the compiler does with this code.
> If it unrolls the loop and inlines the functions - which it probably can
> do as the array of pointers is declared const - you end up with much the
> same result as the current code.
>=20
> And I wonder where the compiler puts the code in each conditional now.
> If it assumes an if() is unlikely, then it would all be out-of-line
> which sounds like part of your goal (or maybe just a nice-to-have).
>=20
> If the compiler does, or can be convinced to, do the unroll and inline
> and unlikely optimisations, then I think I'd give this a goal star.
>=20
> I guess in practice some of the attributes are "likely" and many are
> "unlikely".

This is absolutely the case.

My first attempt at optimizing nfsd4_encode_fattr() was to build
a miniature version that handled just the frequently-requested
combinations of attributes. It made very little difference.

The conclusions that I drew from that are:

- The number of conditional branches in here doesn't seem to be
  the costly part of encode_fattr().

- The frequently-requested attributes are expensive to process
  for some reason. Size is easy, but getting the user and
  group are not as quick as I would have hoped.

- It's not the efficiency of encode_fattr() that is the issue,
  it's the frequency of its use. That's something the server
  can't do much about.


> With the current code we could easily annotate that if we
> wanted to and thought (or measured) there was any value.  With the
> looping code we cannot really annotate the likelihood of each.

Nope, likelihood annotation isn't really possible with a bitmask
loop. But my understanding is that unlikely() means really
really really unlikely, as in "this code is an error case that
is almost never used". And that's not actually the case for most
of these attributes.


> The code-generation idea is intriguing.  Even if we didn't reach that
> goal, having the code highly structured as though it were auto-generated
> would be no bad thing.

Maybe it just calms my yearning for an ordered universe to deal
with these attributes in the same way that we deal with COMPOUND
operations.

I appreciate the review!


--
Chuck Lever


