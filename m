Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C05531B4C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 22:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiEWTbr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 15:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiEWTbO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 15:31:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0055EA1
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 12:13:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NHE1XV005485;
        Mon, 23 May 2022 19:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E8LqAA0pJAJkA/5sqMX9aJua5CaA77yGNj4sv8vxgMU=;
 b=sKsR0DYOcFmOINw0nqaRxyZFVnznjVhOmaQdjT1LVVGBYvoCvjOxS62Ownjhul8KtWSx
 I3u7ItV8NIn2POHJrW5R3JhR+0KNiLHsiCYgawLf6tTy/zUbzrKXFNVjWpKYBq2ce3BI
 sqbnGMi1YDAeMiGxmtyFu4obJL3okZlWh8I+eFbbPlWymrI0yeImAB9bTkpxzSsblYse
 j4TqhSK0wdXzF3UzB9dab1cG9iAai5s9IX+40iHvAvBKtr8RTz4G7EX9GB6DMshxT8Di
 b36XuryW7VdZMV9Q0+ntfp48dORltfbsYGpbx8mWBeuFC6PMbz9hCuQKdxL406HVkW7M 5g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pgbmcxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 19:13:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NIwKH4035440;
        Mon, 23 May 2022 19:13:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1xb5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 19:13:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuGBCPLGHHpgjMlZURnJEZhln3L0qQO14QdDMODKIGWRfULkwdpvCA8E9yIdmWNSIRO1Bpcrqpar6ptHSS051ElH4RM2iHsFLpfUPEvn+wXeI8c0Z5tkLBMWX/L50bxGEi3UrR4kKtly2Z/yCDjbNSC2LjvZ1XhZjiuUTnzNsKdBuelzFiZ+ET37SDmMWU3ivZu44HD9a0mWFhuN0CL8KjUfWxL95FSFX8IBSE5qNTOL7MvPH7HAET4H/KigdHI1RroxJ8bs0/xFuGWb9nVDf2eaK8SIImgMTLzT2EZCcVUhCOmVYKp3zKUll9xV2RTFVtRuz7hgPCY7ZmUWunWJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8LqAA0pJAJkA/5sqMX9aJua5CaA77yGNj4sv8vxgMU=;
 b=g6TAlP+QGSeUGp1Sf5US16uJDPe3HhN8/uhzpYKy6SgoWL3FpQ7jF7FFyHOuUL9Dj04UCG8feYecZ+EoCNW1EMufW/UEIT1f2pNN/a51qz50XwOvNL5LU9/YlkNwDe7JQD61x9zzneTxNkH0wybij5TDkf1+XjTdE2o2OwkfmaojM1nJqpjidq911k+VWpERv1BgoMzA4COJ1rKkFnVymDGyM1ipXTwEdPQwwuAsU7iL0jxh5JfoU8t4OfOk2VmNVkhSBJa5jSc1fDBu4U8Ex7jWnFGQMTo/lI7yikoa26gIUDTQYQWYqqRpJLn1S0fjlu7ItXIiGsonV1dau2DU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8LqAA0pJAJkA/5sqMX9aJua5CaA77yGNj4sv8vxgMU=;
 b=qTeLKmEJSpJU+Oy21RExZf49yhwBsnGSw5i1IfLYQZjr231K7b9QmC6LH7ThAtIEPKEsLno4NPnk4Q/k7slVQo1ZvKZgsWTK8e0+t9p5W3nPXzTWrNz6vIa4+Joam6GRjWFJWnw15RXbcpCuIvZxPsueLkf7BCbAPKYsrJxppOw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR1001MB2252.namprd10.prod.outlook.com (2603:10b6:4:31::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Mon, 23 May
 2022 19:13:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 19:13:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
Thread-Topic: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
Thread-Index: AQHYbfIMzaj7dJY/skSZB97V0kxLh60seYcAgAAWLQCAAAdIAIAABFwAgAAPm4CAABJ8gIAABdCAgAAEtoCAAAKDAIAAC/SA
Date:   Mon, 23 May 2022 19:13:18 +0000
Message-ID: <A67AA343-E399-44AB-AFE5-02B82B38E79E@oracle.com>
References: <165323344948.2381.7808135229977810927.stgit@bazille.1015granger.net>
 <fe3f9ece807e1433631ee3e0bd6b78238305cb87.camel@kernel.org>
 <510282CB-38D3-438A-AF8A-9AC2519FCEF7@oracle.com>
 <c3d053dc36dd5e7dee1267f1c7107bbf911e4d53.camel@kernel.org>
 <1A37E2B5-8113-48D6-AF7C-5381F364D99E@oracle.com>
 <c357e63272de96f9e7595bf6688680879d83dc83.camel@kernel.org>
 <93d11e12532f5a10153d3702100271f70373bce6.camel@hammerspace.com>
 <a719ae7e8fb8b46f84b00b27d800330712486f40.camel@kernel.org>
 <5dfbc622c9ab70af5e4a664f9ae03b7ed659e8ac.camel@hammerspace.com>
 <f12bf8be7c8fe6cf1a9e6a440277a3eb8edd543a.camel@kernel.org>
In-Reply-To: <f12bf8be7c8fe6cf1a9e6a440277a3eb8edd543a.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1a7766e-a362-4b52-6212-08da3cf04b63
x-ms-traffictypediagnostic: DM5PR1001MB2252:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB225243610DAC4CB8286B1A0493D49@DM5PR1001MB2252.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w7edc3mui9WCHvlXvTbviUAV0eHxYsfUZV2FjhQUJo/KxK8h48v/wmk7Mr9lgIyCLGSMhZg2UuGQ/9yqbbuMb4xTdII9JC3juX1VPCbjwCtHqH6cn6AXfw5YFBmTleFIV/WzK8rp36BCmSo/fbmZuZUvq2WEw5Y5F3rjhVYDOLeoPJyprU+m1G6aHodPL3fvNaRLPJKNfCzG7UyFul8Bxk/Ywhgs5LIpH9bmINmPU9eOh8OLqoFmabhn40vUAHy5gvu57ipGBS26BUSKrCu7Z44mWpitzrchqARvYaTCz+nAZb6hhweK/WIohlt5C7a/UZAnyVZZTeMZzOrX8vTlEOLZqTGy/gl9VAYIgTUQS34wCgyn9BrYHCE5ntogevO28ueWBnxJN++zdpRwVe1BGMm+EPHrS4DbbncnIVoEMXhuH6Jt48UjB+prdWbopc8uWEJsjTQLSEWXVyzV5iCqM881dp1fSCNU+dJOUCLIH0ZAbL3Cgp907FUP7bDqMprp9KwV2KlRwrDcPz4Y/bAuwdp53g5+5onxDDNDFajlYUjMdb56OP0BA1tTK77wd75WJgZhgOCzjyYjl32YTLASWn8bU23Q1lZwvs8kkBg2n/yk1jV/ok3Rs/0MsrLTiNHI18w0iEGkoD/rohQINC0u3oZhXIguj+Ou38Gfw2ldSJDvKOSaHxdYhuUPw3g5HBCKf04aX0OEtHjL0Uo2r9zoAHjxw4eSfvVie1w6//mSYTDEX+Tq1Tssr2CYoRjbAkP2Ja9FKeNUIeZC5JZhbFofRzsKYRE1RtISH07VIzWFXK6YRRVuLSVPrnnXzXOyBIXmRZHEAoKkeB6OfC3XnG0RcdTp9uiCZVC4eBl/t7rVPFFsKZW1eGXZbuYIVrLDunEF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(966005)(30864003)(66476007)(71200400001)(38070700005)(316002)(122000001)(64756008)(4326008)(66446008)(91956017)(76116006)(2906002)(66556008)(86362001)(6916009)(54906003)(38100700002)(8676002)(508600001)(83380400001)(26005)(6506007)(53546011)(8936002)(2616005)(186003)(66946007)(33656002)(36756003)(5660300002)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l0KXP6INURXqC5ajB8YMdHsmj4AQP+Zfg0ITkrk0K8SKU44iYGSatDxb6AuE?=
 =?us-ascii?Q?V4brZwuvH5JosS0XUPTiy738sKuYxMQ90wKL1splXthdy4nIST3GntQ23xy8?=
 =?us-ascii?Q?yjCsGBLK4b/9EibIp11aaTeLP8mJ0KGYLrp0rFKaGL8vBEsTc+8Yb8D9Lk1J?=
 =?us-ascii?Q?M0zv/1z/w3uCD97PzHaq1FFquxIXahyFppiIwDqh5smdu8pa86IPZ5Gby+4y?=
 =?us-ascii?Q?9AjY2qZhrTkheSi0FnglflPYIFG8UOJo8trorBGbZX0vXnYU3tNqsUcNrKuj?=
 =?us-ascii?Q?vrN7eoS7yOSLLnqts8wIuF9ANVp5Es1xZJ07aIqyaFFO/K4/F1DpOeIG/DuY?=
 =?us-ascii?Q?BdtVb0QekwJkOhvo75jxUbHiadPi7DUarVPcCU8+XO7PN/9hKyKtP/JDn3bh?=
 =?us-ascii?Q?CHhT0RvFowB/KQ6MsauArXOEYKxs2xnZnbUIBgziSMqxciEsH+p5j9YE60wm?=
 =?us-ascii?Q?Vs60KYcyTzPWWmD7KdEjxuh4Jo24L1cwnIt2wQrqLApyshfMhwdyqxo/9TKt?=
 =?us-ascii?Q?U6Z3COXgLG9t9axL3zYFg7ym/J8I98OZ6+mmDTh1JrjIMO62nGoDZ/nEnSbA?=
 =?us-ascii?Q?qXtsCObNlJfeVHeL+TthHyxwtpcr7LUwoF9iauQw9QgO16xDhQlBe77kEDUd?=
 =?us-ascii?Q?mHTFHm8pi9+vUpO8u4XQ3u1C7g5oxfCg3TeraSk4tibD1sxNsT+PBnYY44Ns?=
 =?us-ascii?Q?IzNpNpCf6F+TGFA9KoeIJNMWbZykz1OzDO0xAk7f+NRCvjbbDY9DWBiPHykA?=
 =?us-ascii?Q?IWzx7HkbEL93WjuNi89G9zPz4ChWdfdkgwbKGJeSjRw0oB93m+YFa94kxsWU?=
 =?us-ascii?Q?vFeGufA5Qxm2PtSYvmx8MwoR4rASxoAmU4GwN8iZDr7hjcjfKeS1SeXcZegQ?=
 =?us-ascii?Q?YIj9uMxxdD/MH9Ob7ReWwQbQKFzS2zDsH+9EgBfg5qvoLaCxvYHO5pD1+TuH?=
 =?us-ascii?Q?3e9dmzaCGXnRVZ3Avq8mG38kMRuoJUe73eNdY8YqYqvY+Ja2fVmiVFib4V52?=
 =?us-ascii?Q?gKXZvro8Aos9cGvDrEufGzs6aMSDC8XDcG3pN1j06KOT3m31p/75qcQ4tvIZ?=
 =?us-ascii?Q?4RnFgibh0HeESNL/Y6s8rFuhCpRr5exgGFCDPlPwRxwER+c3ujWWVi3mUeFS?=
 =?us-ascii?Q?mRRFBU9pHfZjjtfagYrfRiR3BfUaTorMxlXyG2IgnNKg1tUQKYGN1apwMCNZ?=
 =?us-ascii?Q?8z5Hfyn4D2H/hLJ1LgCHLuxH9WPP2gZFTq+57+tGKa7XMU7RKsAXwg0ysrZx?=
 =?us-ascii?Q?ryuAjRj0rufo8UHFrBdPOSKlc35wKU1kw/CgnVu4hZcGz/LOzaVlg/YdjDqz?=
 =?us-ascii?Q?ZkT+GWfxi6zKiRVRJgMko7ju+xRyzPv3gcl0jpfg6gPxrZ0cNdEeFcRsc70r?=
 =?us-ascii?Q?dS/bW3lYvyoFo/EHMoZEDD5IVecl1a1Si3eeGxzLe9ev3R6cxRKBhaRaBYI8?=
 =?us-ascii?Q?/mJqV7Tk8A+Ov/NQC/1A3oJXMjjMY4P1je3bJ88X5IET4sOSveBwn+GJEq3U?=
 =?us-ascii?Q?9GyUzroC4hGrPL5Wbpm0AcjiKoGklFU9TEgqLHOiROT4BdqP4W+zZ6FTs9yM?=
 =?us-ascii?Q?9ZNBUdHWEA5t3JP6XzX+j+5nCWkHVpTVbGkk53EvayoPa7Rkke9eVN4mNFER?=
 =?us-ascii?Q?/chaUaHiGJAO1tlDubQAEFT+jwfFCGWo8SYaxI9duN4SBqbokQQTOXcspCmf?=
 =?us-ascii?Q?F4wZQ8PwDf0fSt9DVwv8e71wexPJVJ+iqUMNdgoSYvpG+yfjYjdCYo183yiP?=
 =?us-ascii?Q?wycUwUCK1y970if/lFWosBecphlV+kA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E5216806A5C91478B8B765141F9426E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a7766e-a362-4b52-6212-08da3cf04b63
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 19:13:18.0812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmaHxf2swTS4QcLGIkvLqc6r9bpLUiBVIyUesuflSoTBr/2nsOAv5LpYPRuh7HfwYk+2mkdscipTQq4I18RCHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2252
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_08:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230105
X-Proofpoint-ORIG-GUID: XYLXaA6fokf2VkcCOg26NUYbT3G7n8Pz
X-Proofpoint-GUID: XYLXaA6fokf2VkcCOg26NUYbT3G7n8Pz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 23, 2022, at 2:30 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-05-23 at 18:21 +0000, Trond Myklebust wrote:
>> On Mon, 2022-05-23 at 14:04 -0400, Jeff Layton wrote:
>>> On Mon, 2022-05-23 at 17:43 +0000, Trond Myklebust wrote:
>>>> On Mon, 2022-05-23 at 12:37 -0400, Jeff Layton wrote:
>>>>> On Mon, 2022-05-23 at 15:41 +0000, Chuck Lever III wrote:
>>>>>>=20
>>>>>>> On May 23, 2022, at 11:26 AM, Jeff Layton
>>>>>>> <jlayton@kernel.org>
>>>>>>> wrote:
>>>>>>>=20
>>>>>>> On Mon, 2022-05-23 at 15:00 +0000, Chuck Lever III wrote:
>>>>>>>>=20
>>>>>>>>> On May 23, 2022, at 9:40 AM, Jeff Layton
>>>>>>>>> <jlayton@kernel.org>
>>>>>>>>> wrote:
>>>>>>>>>=20
>>>>>>>>> On Sun, 2022-05-22 at 11:38 -0400, Chuck Lever wrote:
>>>>>>>>>> nfsd4_release_lockowner() holds clp->cl_lock when it
>>>>>>>>>> calls
>>>>>>>>>> check_for_locks(). However, check_for_locks() calls
>>>>>>>>>> nfsd_file_get()
>>>>>>>>>> / nfsd_file_put() to access the backing inode's
>>>>>>>>>> flc_posix
>>>>>>>>>> list, and
>>>>>>>>>> nfsd_file_put() can sleep if the inode was recently
>>>>>>>>>> removed.
>>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> It might be good to add a might_sleep() to nfsd_file_put?
>>>>>>>>=20
>>>>>>>> I intend to include the patch you reviewed last week that
>>>>>>>> adds the might_sleep(), as part of this series.
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>>> Let's instead rely on the stateowner's reference count
>>>>>>>>>> to
>>>>>>>>>> gate
>>>>>>>>>> whether the release is permitted. This should be a
>>>>>>>>>> reliable
>>>>>>>>>> indication of locks-in-use since file lock operations
>>>>>>>>>> and
>>>>>>>>>> ->lm_get_owner take appropriate references, which are
>>>>>>>>>> released
>>>>>>>>>> appropriately when file locks are removed.
>>>>>>>>>>=20
>>>>>>>>>> Reported-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>>>> ---
>>>>>>>>>> fs/nfsd/nfs4state.c |    9 +++------
>>>>>>>>>> 1 file changed, 3 insertions(+), 6 deletions(-)
>>>>>>>>>>=20
>>>>>>>>>> This might be a naive approach, but let's start with
>>>>>>>>>> it.
>>>>>>>>>>=20
>>>>>>>>>> This passes light testing, but it's not clear how much
>>>>>>>>>> our
>>>>>>>>>> existing
>>>>>>>>>> fleet of tests exercises this area. I've locally built
>>>>>>>>>> a
>>>>>>>>>> couple of
>>>>>>>>>> pynfs tests (one is based on the one Dai posted last
>>>>>>>>>> week)
>>>>>>>>>> and they
>>>>>>>>>> pass too.
>>>>>>>>>>=20
>>>>>>>>>> I don't believe that FREE_STATEID needs the same
>>>>>>>>>> simplification.
>>>>>>>>>>=20
>>>>>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>>>>>> index a280256cbb03..b77894e668a4 100644
>>>>>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>>>>>> @@ -7559,12 +7559,9 @@ nfsd4_release_lockowner(struct
>>>>>>>>>> svc_rqst *rqstp,
>>>>>>>>>>=20
>>>>>>>>>>                 /* see if there are still any locks
>>>>>>>>>> associated with it */
>>>>>>>>>>                 lo =3D lockowner(sop);
>>>>>>>>>> -               list_for_each_entry(stp, &sop-
>>>>>>>>>>> so_stateids,
>>>>>>>>>> st_perstateowner) {
>>>>>>>>>> -                       if (check_for_locks(stp-
>>>>>>>>>>> st_stid.sc_file, lo)) {
>>>>>>>>>> -                               status =3D
>>>>>>>>>> nfserr_locks_held;
>>>>>>>>>> -                               spin_unlock(&clp-
>>>>>>>>>>> cl_lock);
>>>>>>>>>> -                               return status;
>>>>>>>>>> -                       }
>>>>>>>>>> +               if (atomic_read(&sop->so_count) > 1) {
>>>>>>>>>> +                       spin_unlock(&clp->cl_lock);
>>>>>>>>>> +                       return nfserr_locks_held;
>>>>>>>>>>                 }
>>>>>>>>>>=20
>>>>>>>>>>                 nfs4_get_stateowner(sop);
>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> lm_get_owner is called from locks_copy_conflock, so if
>>>>>>>>> someone else
>>>>>>>>> happens to be doing a LOCKT or F_GETLK call at the same
>>>>>>>>> time
>>>>>>>>> that
>>>>>>>>> RELEASE_LOCKOWNER gets called, then this may end up
>>>>>>>>> returning
>>>>>>>>> an error
>>>>>>>>> inappropriately.
>>>>>>>>=20
>>>>>>>> IMO releasing the lockowner while it's being used for
>>>>>>>> _anything_
>>>>>>>> seems risky and surprising. If RELEASE_LOCKOWNER succeeds
>>>>>>>> while
>>>>>>>> the client is still using the lockowner for any reason, a
>>>>>>>> subsequent error will occur if the client tries to use it
>>>>>>>> again.
>>>>>>>> Heck, I can see the server failing in mid-COMPOUND with
>>>>>>>> this
>>>>>>>> kind
>>>>>>>> of race. Better I think to just leave the lockowner in
>>>>>>>> place if
>>>>>>>> there's any ambiguity.
>>>>>>>>=20
>>>>>>>=20
>>>>>>> The problem here is not the client itself calling
>>>>>>> RELEASE_LOCKOWNER
>>>>>>> while it's still in use, but rather a different client
>>>>>>> altogether
>>>>>>> calling LOCKT (or a local process does a F_GETLK) on an inode
>>>>>>> where a
>>>>>>> lock is held by a client. The LOCKT gets a reference to it
>>>>>>> (for
>>>>>>> the
>>>>>>> conflock), while the client that has the lockowner releases
>>>>>>> the
>>>>>>> lock and
>>>>>>> then the lockowner while the refcount is still high.
>>>>>>>=20
>>>>>>> The race window for this is probably quite small, but I think
>>>>>>> it's
>>>>>>> theoretically possible. The point is that an elevated
>>>>>>> refcount on
>>>>>>> the
>>>>>>> lockowner doesn't necessarily mean that locks are actually
>>>>>>> being
>>>>>>> held by
>>>>>>> it.
>>>>>>=20
>>>>>> Sure, I get that the lockowner's reference count is not 100%
>>>>>> reliable. The question is whether it's good enough.
>>>>>>=20
>>>>>> We are looking for a mechanism that can simply count the number
>>>>>> of locks held by a lockowner. It sounds like you believe that
>>>>>> lm_get_owner / put_owner might not be a reliable way to do
>>>>>> that.
>>>>>>=20
>>>>>>=20
>>>>>>>> The spec language does not say RELEASE_LOCKOWNER must not
>>>>>>>> return
>>>>>>>> LOCKS_HELD for other reasons, and it does say that there is
>>>>>>>> no
>>>>>>>> choice of using another NFSERR value (RFC 7530 Section
>>>>>>>> 13.2).
>>>>>>>>=20
>>>>>>>=20
>>>>>>> What recourse does the client have if this happens? It
>>>>>>> released
>>>>>>> all of
>>>>>>> its locks and tried to release the lockowner, but the server
>>>>>>> says
>>>>>>> "locks
>>>>>>> held". Should it just give up at that point?
>>>>>>> RELEASE_LOCKOWNER is
>>>>>>> a sort
>>>>>>> of a courtesy by the client, I suppose...
>>>>>>=20
>>>>>> RELEASE_LOCKOWNER is a courtesy for the server. Most clients
>>>>>> ignore the return code IIUC.
>>>>>>=20
>>>>>> So the hazard caused by this race would be a small resource
>>>>>> leak on the server that would go away once the client's lease
>>>>>> was purged.
>>>>>>=20
>>>>>>=20
>>>>>>>>> My guess is that that would be pretty hard to hit the
>>>>>>>>> timing right, but not impossible.
>>>>>>>>>=20
>>>>>>>>> What we may want to do is have the kernel do this check
>>>>>>>>> and
>>>>>>>>> only if it
>>>>>>>>> comes back >1 do the actual check for locks. That won't
>>>>>>>>> fix
>>>>>>>>> the original
>>>>>>>>> problem though.
>>>>>>>>>=20
>>>>>>>>> In other places in nfsd, we've plumbed in a dispose_list
>>>>>>>>> head
>>>>>>>>> and
>>>>>>>>> deferred the sleeping functions until the spinlock can be
>>>>>>>>> dropped. I
>>>>>>>>> haven't looked closely at whether that's possible here,
>>>>>>>>> but
>>>>>>>>> it may be a
>>>>>>>>> more reliable approach.
>>>>>>>>=20
>>>>>>>> That was proposed by Dai last week.
>>>>>>>>=20
>>>>>>>> https://lore.kernel.org/linux-nfs/1653079929-18283-1-git-send-emai=
l-dai.ngo@oracle.com/T/#u
>>>>>>>>=20
>>>>>>>> Trond pointed out that if two separate clients were
>>>>>>>> releasing a
>>>>>>>> lockowner on the same inode, there is nothing that protects
>>>>>>>> the
>>>>>>>> dispose_list, and it would get corrupted.
>>>>>>>>=20
>>>>>>>> https://lore.kernel.org/linux-nfs/31E87CEF-C83D-4FA8-A774-F2C38901=
1FCE@oracle.com/T/#mf1fc1ae0503815c0a36ae75a95086c3eff892614
>>>>>>>>=20
>>>>>>>=20
>>>>>>> Yeah, that doesn't look like what's needed.
>>>>>>>=20
>>>>>>> What I was going to suggest is a nfsd_file_put variant that
>>>>>>> takes
>>>>>>> a
>>>>>>> list_head. If the refcount goes to zero and the thing ends up
>>>>>>> being
>>>>>>> unhashed, then you put it on the dispose list rather than
>>>>>>> doing
>>>>>>> the
>>>>>>> blocking operations, and then clean it up later.
>>>>>>=20
>>>>>> Trond doesn't like that approach; see the e-mail thread.
>>>>>>=20
>>>>>=20
>>>>> I didn't see him saying that that would be wrong, per-se, but the
>>>>> initial implementation was racy.
>>>>>=20
>>>>> His suggestion was just to keep a counter in the lockowner of how
>>>>> many
>>>>> locks are associated with it. That seems like a good suggestion,
>>>>> though
>>>>> you'd probably need to add a parameter to lm_get_owner to
>>>>> indicate
>>>>> whether you were adding a new lock or just doing a conflock copy.
>>>>=20
>>>> I don't think this should be necessary. The posix_lock code doesn't
>>>> ever use a struct file_lock that it hasn't allocated itself. We
>>>> should
>>>> always be calling conflock to copy from whatever struct file_lock
>>>> that
>>>> the caller passed as an argument.
>>>>=20
>>>> IOW: the number of lm_get_owner and lm_put_owner calls should
>>>> always be
>>>> 100% balanced once all the locks belonging to a specific lock owner
>>>> are
>>>> removed.
>>>>=20
>>>=20
>>> We take references to the owner when we go to add a lock record, or
>>> when
>>> copying a conflicting lock. You want to keep a count of the former
>>> without counting the latter.
>>>=20
>>> lm_get_owner gets called for both though. I don't see how you can
>>> disambiguate the two situations w/o some way to indicate that. Adding
>>> a
>>> bool argument to lm_get_owner/lm_put_owner ops would be pretty simple
>>> to
>>> implement, I think.
>>>=20
>>=20
>> Hmm... That should be an extremely unlikely race, given that the
>> conflicting lock reference would have to be held for long enough to
>> cover the unlock + the release_lockowner / free_stateid RPC calls from
>> the client initially holding the lock, however I agree it is a
>> theoretical possibility.
>>=20
>=20
> If we want to live with the possibility of that race, then Chuck's
> original patch is fine, since the object refcount would always be
> equivalent to the lock count.
>=20
> That said, I think it'd be better to keep an accurate count of lock
> records (sans conflocks) in the owner.

I don't have an objection to maintaining an accurate count of locks
belonging to each lockowner. I feel comfortable (for now) that using
so_count is a good-enough solution, and is an improvement over holding
a spinlock while trying to sleep. If we go with so_count, I can add
a comment that explains the uses of so_count and possible races.

OTOH, if we alter the lm_get/put_owner API, I would like to ensure the
new parameter will be difficult to misuse. A few more random thoughts
that might count towards due diligence:

- Is there a reliable way lm_get/put_owner can distinguish between
  the two cases by looking at their current set of arguments?

- Is it clear why the conflict case needs to take a reference on a
  lockowner that is not involved? Is there a way to avoid taking that
  reference in the first place?


--
Chuck Lever



