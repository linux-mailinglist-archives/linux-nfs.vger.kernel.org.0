Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433F153F45E
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 05:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiFGDMN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 23:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbiFGDML (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 23:12:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7620D0286
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 20:12:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2570EHXI016287;
        Tue, 7 Jun 2022 03:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gk7cbZZkhk1EIuydCKj21ELvnO5kNVAeGWZY83WnunI=;
 b=E1ragmeAPlhEGXI1a6Dqj01XDq3ZqL+5LHJ4TS3SXkJdR+lP8sH7GOuo3eGVWBYiI+5l
 bVE8tTrayxDWyWkVxwx2keUiF2uH3a6vjAJ0EQVJKK2P/XSOFQwnulM6hVueG/BJUSVj
 6sNBTWEIeO7rfKay9lVT/qQWUFT0Y3HK+GZjIVFsvmZMZbBPi/ykz1pa6T5qJKO8+hNY
 1bA9dGkXNPcPorEFLMbABq0dqlpu+EV8/FH9/TJjAHr/lbPIZA6FUl/glIrN+/qLhm9W
 iEG/uwhodalfxozYr+h4xT+l3nIxqe5Y/5WGfeYq8NY8tW+MOo+FRipWsG7KdMUKzimj eQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghexe9xhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 03:12:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2573B8Jh014574;
        Tue, 7 Jun 2022 03:12:03 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu98kad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 03:12:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWUE2D2gjU9AJe9LASg5oYTW71V0v8H705GDumODDKyQujg0Lpff20qqebgtC/Cp1R7e7gofw0yOpDfwKOnNOtyOT81qAwhD8gZO/ffaBLnMnj+8WaIawPVzGYveiRm7ypIIe5s8kuMJScRfboi0QaCdWZwrPd/lpsYj78CR/b7M8EGtgY0ohXAfIWx1JIXxlolgkS5za/6xZ+Cf8tnChXLSgDR/re067/4wiOV/aW5jrT1etfmTMciHnJBcdG0wN+6t7TI30cErCYHL2iVzKX2xkz8hj2NJoQ0rRDcObECxnK28OuwdJClzzh/j0+iHGcFfF3+FU6NnKpgtAd1+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gk7cbZZkhk1EIuydCKj21ELvnO5kNVAeGWZY83WnunI=;
 b=KA+o21qdBNbPHhQRGSpkDozTIFv+YAjzcbUf1CZ5g+DXuqQpNbDvXMIQJSukWNXiDkjxXafxJoM0UXA05PDLl/SX9roMN+6tHXk6CDhRKqS4QZCdws/47URe0lg8p7Tlg5NBq9HtrTuUTOxAWz9mp9k7oeBNUGvYoAnZ+rom/QnQx0BHpWF5x8Ko8eBh5BgUuglN1GH3yT8uk6tan5e4wYhtAyLXQ/uFMm8mpy6xPHjWvyvOuXgYCGT1qbJN+6+N2PlcMmj7GjYycdYcYfvTX13nrKc8YLrU5ihY0KJyKw6Yagx5zzwYvSl6pmZBOahP9iIL0f5ZKBt8uibaAPUAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gk7cbZZkhk1EIuydCKj21ELvnO5kNVAeGWZY83WnunI=;
 b=vuEGhV7NASJSgXGhVD7PbnCTUZK/M86r/fz5+u2f9R3JuIf+p9R00JsbI7/TyTSmStHHMKYeglbPdet7cHaxgJj6WRxrRC/Ej++sJXTZV9ledwEc0zC2zzwxoj3xM7d0GNgZ/7To3ru4MWlC0lK8ASeRBSwRBPsVkHh+ALKhjus=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR10MB1556.namprd10.prod.outlook.com (2603:10b6:404:3d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 03:12:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 03:12:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 1/5] SUNRPC: Fix the calculation of xdr->end in
 xdr_get_next_encode_buffer()
Thread-Topic: [PATCH v1 1/5] SUNRPC: Fix the calculation of xdr->end in
 xdr_get_next_encode_buffer()
Thread-Index: AQHYeRam8Dx7jt+RMEip5dpodDHiAa1C8gwAgAAvcICAABr1AIAAChYA
Date:   Tue, 7 Jun 2022 03:12:00 +0000
Message-ID: <EA34A2F2-D80A-44B0-8AF3-2234069DDC29@oracle.com>
References: <165445865736.1664.4497130284832282034.stgit@bazille.1015granger.net>
 <165445910560.1664.5852151724543272982.stgit@bazille.1015granger.net>
 <20220606220938.GE15057@fieldses.org>
 <165456356541.22243.8883363674329684173@noble.neil.brown.name>
 <D3608A6C-0CA9-434B-BF56-79AB33793AB4@oracle.com>
In-Reply-To: <D3608A6C-0CA9-434B-BF56-79AB33793AB4@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2020a26a-9403-4b15-d0b9-08da48337d2d
x-ms-traffictypediagnostic: BN6PR10MB1556:EE_
x-microsoft-antispam-prvs: <BN6PR10MB1556583A62B625A64BBE483393A59@BN6PR10MB1556.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SUUtsath+kGWi1FUbZmQoyQARZ0Y8IocReP/usLcV7cyd/CEOFWVTZXIPjGed9lHuiZo1jw15mZDCJwqq+2CfumeeHz7n+xVFcoHwNWUKTtfll2S9n9NzoL//SPp/+cY9UQBrpUQZV8T/vYbv+UNsF09vPjwHy/LDKGOMcJDlS9j5gTdSDQBBprbu/2sZWJa5wHqWEhv9DwCL2X00pcxdC7MIcTufo5Qe/IrD9Kw8vpktsW55AZYuqMWnIQC/vMcdq60wEukLptDqBHs5+6OT0z3e6ujoSItvLWj1Il3xuFFHBw2ODQQ61yDZwd6lpJRta1cFT9L0WEkUIehuZjKpXnPghSIpkHAGjPdLFALqhS0P9UKmyQ2wMxesp10ptiV5cMK65rqk0DPsFlodUy1j0FyRwaGH+zpu0ov4ZUvIIvbQzenrcxRck6TdE88iWvfoxQ2fU00xVWOeWjFpKSK5L/UHasmxiSAV3iAaYwQSqk5+B1oj0Y6sdelrsfOi8yCuB9bSUR+EDFjr/Aayt0s7nzcDH1jzRJO2SrXU6geLer8qABjF3fE9g+QVNJp84YPDde/PN8/Y2SRPnmyyIzRARNI3AXD8Bd+1M1u+5GsPcGKD85QeiNb/PLuUCeplqNrBHMYONvp2z/PfMKz+e19qNO7fLMI/5T1X/uGvS/24tk6iOiLl7B0qFSIf9s75L2fzXv22hx0OWlnD6I6fsHoGHgndcQF9OY4aQFqeXQibRXmoxlzp5wDY93kk7PjlbpvAXjB3bxammR6gk5oM5KoAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(64756008)(38100700002)(66446008)(66556008)(66476007)(4326008)(186003)(66946007)(71200400001)(8676002)(36756003)(2906002)(76116006)(5660300002)(122000001)(91956017)(508600001)(4744005)(38070700005)(6916009)(26005)(33656002)(8936002)(6486002)(2616005)(316002)(6506007)(53546011)(6512007)(86362001)(45980500001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AYeD4YQR3GfiOADMqWg12qv+i74bxvZO2YfLG5oI1YBR8CiUCqVmkWJSNhvq?=
 =?us-ascii?Q?aVxcY2L0n1+GX+/4GaDpVzrodrvSa3JvU7HgCTrWzoEZm6KlHeOxuZCEW2Fg?=
 =?us-ascii?Q?pvHTZxXihrtQZ4PE+yQddpOE/9H/BIzV3YRwAT0T6o1SRpN1yEv3HDrLCXPo?=
 =?us-ascii?Q?pL9sjcXkF/DsX2UQJHasn3aGFRt35K39qeRPZ69wHBNM3PGslqDckddQnnd/?=
 =?us-ascii?Q?OHvj1Njb9OtGq2MSo2syS/LpyB8f6vEI0ABZIDW2LMUotAMOGUgM+ESf/WCz?=
 =?us-ascii?Q?cFE2hU32Qp/eALfFz0XV6WKpWmDuutoLaBROfLffb5y7Gf0GZvhNV6naO/24?=
 =?us-ascii?Q?Tj5+xDuCT3vPhKyEPuxwVpfec1CnDhNrPf+sl4bsPSXnkWES/pVFJMJI5U35?=
 =?us-ascii?Q?LW66GA5tjI2qx54ifP4BVfQxv/3PdMbOgOGjVrNFwUrsEdpO6TGaM/5YisfT?=
 =?us-ascii?Q?gEWmlKXBvjXb85pOTrPEsvU4THqIrO41wCQQelPdzXkZ9SzBYk6SWKqXWHCC?=
 =?us-ascii?Q?MgKCBqlffTtVH1H7fOfIY2GXy0Qhag+6Xso1l4Lu2F0RGNi893l8+3cr+Q6t?=
 =?us-ascii?Q?MUJEFmystmQ9PSGI+UBfg1FS6ZkR4G229tlEx4A/glKSbVyWjif7bMs5LI2Z?=
 =?us-ascii?Q?FFDTE0RTS1n3zcBvUUN03UIDbyKBCEOCLj/uEt08DWq/vN2a0SbFJHLNRL+w?=
 =?us-ascii?Q?PTvpygUVT9t5wQVskBu86eCkv568jh8HA/IobiiH3Hlup4tkEVZXyNxoBWmW?=
 =?us-ascii?Q?TQf0GUOitXfQndJSnrhAfWudoxOPOM9YBM9ZgIhw+NXSkuTRI3IoYHNYEOm1?=
 =?us-ascii?Q?Y4Zuc9Dv0Fla8K7Z6tzjs6rNWeRdbej1pgRNgU0o20Y4raAHbwNYkFWr5wo9?=
 =?us-ascii?Q?ARC9iEsqJ1yUc1aRp7eY6QwMdxNQFBtjT+ekAAbTPa6WX/fN4+ooUXfTUFhs?=
 =?us-ascii?Q?peyp0QbPn/kc6wuAG9jG8eylskUyuvQUiYiS5lsDHClR3i6ZQqZeCUSeMchu?=
 =?us-ascii?Q?uUMEnsQcU9geKi6iopCZann2SNk5x4+9gvCy/Ud1qRwjO5IeFab7mAhjoH/e?=
 =?us-ascii?Q?7HBSj1r/bIXFURObcJU8qQgKcTQo0ctm+6GmEWzscD+c9EGEa8YuFxzg7vnK?=
 =?us-ascii?Q?r1P3iERR19A66X1yfUXncaivKQjnOoW1c/9Re27kNv4Qmm9Gy/MSXl8/UQr1?=
 =?us-ascii?Q?wSlLr/8ZrLKEdO9oRt4DugF9XCQ3daVvT8OBPpNGtZX47ohWQ2FF5XX4NbNo?=
 =?us-ascii?Q?BjTn6W4joxvV5XsYfInZijIEcODeSB9hUnk+VdiI6O97u2+jqMb1gZgEWsKy?=
 =?us-ascii?Q?Eg+6uxYue+tPD49aouenVEdQXEgS7MpDXLDpPS+KYh3GiUv2KHp5gWQD88YT?=
 =?us-ascii?Q?I8gwORJdM/Gk+NLn0KAfKotXx/CqofD0RgbuggVfby0qu9HAvn72ynWnwg4S?=
 =?us-ascii?Q?qvp0CoT6MaG6ASCmNtCTclp3ecDho7YU9xGzPFOJn2+iiHT929oRp8LQwBP0?=
 =?us-ascii?Q?RvZw0F3/OxZDcCHlGAk0nqWp8sxO/4gexxQRoBVczUyfzX+t+BAnpGB1IF6l?=
 =?us-ascii?Q?6c+qkEy7xf7jCezf1gZ52EEZj1KB1ecZph/NPHfpTCT5KYKr4zwiqlzX0XFY?=
 =?us-ascii?Q?4NGPG9TrxfIQ6GwN5KQlBH4Gty7JLyJdmUhrgLXFGFF0Y2uH2qHlF6v4DyLm?=
 =?us-ascii?Q?flwdEaT8SCJ8al/V08XuIm73uL1OlQmxbhKaTHph8UzjampYTB2eNcfi8I6F?=
 =?us-ascii?Q?/vrPNj/6+aRyYApOlw0htPuieAZ2efA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A9C221FB71DC1142B09589A59DD303B1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2020a26a-9403-4b15-d0b9-08da48337d2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 03:12:00.6720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRy8znhUWnFVLz3YrEFUKEpDY9I9AWYC3QxtQqeBCUhx3KImSI+4GIqxMrWJ3ic0tERgVFMc9yxndtYaIELHxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1556
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-07_01:2022-06-02,2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=948 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206070013
X-Proofpoint-GUID: QjEUUvQZ0IjX0JJf1rb9FtnI6frYvCpi
X-Proofpoint-ORIG-GUID: QjEUUvQZ0IjX0JJf1rb9FtnI6frYvCpi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jun 6, 2022, at 10:35 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>> On Jun 6, 2022, at 8:59 PM, NeilBrown <neilb@suse.de> wrote:
>> We then assign frag{1,2}bytes and have another chunk of code that looks
>> wrong to me.  I'd like
>>=20
>>  if (xdr->iov) {
>> 	xdr->iov->iov_len +=3D frag1bytes;
>> 	xdr->iov =3D NULL;
>>  } else {
>>       xdr->buf->page_len +=3D frag1bytes;
>>       xdr->page_ptr++;
>>  }
>>=20
>> Note that this changes the code NOT to increment pagE_ptr if iov was not
>> NULL.  I cannot see how it would be correct to do that.  Presumably this
>> code is never called with iov !=3D NULL ???
>=20
> That strikes me as a good change. I will add it to this series as
> another patch.
>=20
> Yes, this code is called by the server's READDIR encoder with iov =3D NUL=
L.
> See nfsd3_init_dirlist_pages().

This change breaks READDIR, looks like.

--
Chuck Lever



