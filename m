Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CE1613861
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 14:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiJaNtz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 09:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiJaNtx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 09:49:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BD47679
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 06:49:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VCarOr032306;
        Mon, 31 Oct 2022 13:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=a0ueQ+yBMCyXngiGwnwWMfxLiC29kt2gs5iW8q1GXI4=;
 b=oPrPxtqXRkD30eUOZbCmk7lD9CxXjwq17OORX2WG5tO2kIMwMqDV430JIeeTbzD2Mwc8
 RuuyE+sFE2tHcz+UCdPkGuewkNBW4TW6BoBgYoPzDU7Uugxpt+nNwOrGanB//PSQCvDa
 7pe0RGbAcOlhhFx+esUUj7JTo4wakOtnSHMLqvAH0ixz5iKSo1Bvn/vQ2yZXwOSizjAS
 V6U8wHTaMrqycv5SjUD+MaFm7+ExrelJRjrTKSMD+LxhfSQ8GMljTt/sAMgNmxFWqvlr
 EdLwq0AbHokOZfNtEZZnaz30bXhtqYV7CUjTybBMqR/+v2iM3B26b6OFQaaiwFODxqs1 tA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtbkhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 13:49:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VCqHUo016133;
        Mon, 31 Oct 2022 13:49:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm9kfn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 13:49:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SInoIxTPbwTjpUNcGhqimgY30fUy4nOhWCj6RFvSykJyBukEoWCf+Q7iV8ltF7B5QZ6q1C5rGbKJJInFPRZlVwHMIfVSA4O4Lo+JeTMYp8kB5T76RdCWwLuRAMldxmbJjRqwePq7aUsuBgs+vgQhsRvGN0JLOpQKRKy5tTrD3PpkTL9wuvJs+yImm2LxPlb+DBa/OhI6GMxlPXe7ZSL4E0w78uQF+O8+1PGRol+KCg+3tQWR0CECLGNZETjJGpYQqIlgNKHroJbNcykjrzJNKR8hZkbP+B54TqgPpHWqxUCqBmViiC6cP7jQEZnIjw4VzOBlSlBpbREmTcIcIiI4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0ueQ+yBMCyXngiGwnwWMfxLiC29kt2gs5iW8q1GXI4=;
 b=NDb5HzcISsXOwp6e8DTJ5hXo7VYZ6P1193JQ8hJxLssxsjMIWfsasuBW7EuclYvlRPDdB/8JIHg3vks8VinHuvhdIUxMieI1k7wQpWeCUxI9r2e3Ou1XpamowdDgBkK/V+bDFqoJdwh0stDxts6q2dryt9nLcg4bDYosMx6OB4R89eLow+pmRdpYQUZB0byy6TK2ZgWlCU5mQxYu+ml08U1ycjTZNHGPemwiZf7TKKO8fI6Wl991Vs02A4p5N5xSRyYQqXW0LxMKq95TFvDGN+oVk8TS3HF9Hqm3wqIAt5T+CTXnQj63v3uCdnipHDfF0akuzL/hYPV7dOYF6Uid0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0ueQ+yBMCyXngiGwnwWMfxLiC29kt2gs5iW8q1GXI4=;
 b=Zr6ICh9pOTo41rT4dkMaSVr3h0AkuEGsEqeExkhGaWJExqarMDdtgPSjXzHpPRaLEzy06amWvVd/0PQKs/WEc1CynCnmRVuRv3yvOR/XPP6zu7wTJndoeGnM671gkIRcMwoBKXgGGY6oAoHpJgSs1SBkgP3CPUq1PLvBpF02z7g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5633.namprd10.prod.outlook.com (2603:10b6:303:148::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Mon, 31 Oct
 2022 13:49:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 13:49:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix licensing header in filecache.c
Thread-Topic: [PATCH] nfsd: fix licensing header in filecache.c
Thread-Index: AQHY6UgyJjhEsyzLKU6cRbJ9KOmgVK4oK36AgABZYgCAAAKYgIAABOIAgAAAUIA=
Date:   Mon, 31 Oct 2022 13:49:38 +0000
Message-ID: <75DFFED3-D488-4005-AF44-230569897417@oracle.com>
References: <20221026143518.250122-1-jlayton@kernel.org>
 <Y1+A7XzxKbRCCH4z@infradead.org>
 <3C6909FD-6079-48AC-93E2-BD7937E31F86@oracle.com>
 <Y1/OFbwh8WtbjKH0@infradead.org>
 <298bef5fa91630478e4815f9f797fb904455d873.camel@kernel.org>
In-Reply-To: <298bef5fa91630478e4815f9f797fb904455d873.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO6PR10MB5633:EE_
x-ms-office365-filtering-correlation-id: eb6fa9e7-766b-43a6-5e4c-08dabb46c0d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NuxECL7D182yLnB0xsFXm6iqXd2w4mOwXSlHKlkTdXB/Mk3rNYcsj+9rzGDsHPaJoJ/Fnsctj31QpCyJaZPNj8xiMt6LYS+XYeEQ6flKMyDEQc+kAib4IzrQHYj49MzRvea5VDYaVN0bDjaNK4DkXmwy2OEwcQdx0cINA+VC/MqnOdha9Ok8Dn8rOVSuNgUVVI7G5b+7Xs5vLOJiB2lPKQBv/zrJJ0WOji8SNtqFbF2RG0IwMICNlzRvn6acisfS1JSoMMbHsk/5twR0Im54BAUu8tVr6P2t1goDUGztMOg6LLIY+h5cUY2l+cbpD+l42X2Srop/L20fyvVVFwfbDUtXznEnOqFXPKhPIZyvkN4sf+tP113aQXmhSvR265X4odNQb5XL/+OrHeLqZfEDKHULQ9sREO1l3vgc+3nPPrHVA576Uv0+6bwHoazNMkCYXLtuBx7zIAfTe3JqudlUlwDNhWckZKaMQ3QUa0vMWfuTaDUqMNLByesFnydxnpZaXd27BE62qvZh0r5MSNuUzpWXWrGiZHjPDlKJN4bC8ks02jbD4HxKgZLLZBXjUanst/02O53lV+1VpCj53xp6WQx0r5H62BNPCFcF6hr6+QUAv5HLFEDLy/XdB2qe7ANssYn8w6GjSgYeM5FNu/VzeU/UoLOOFBB5Sqfu+wZJbFNCMUH55Oxd8obQ2QgY7srFGWJut58l/OxH2orgdQDfc79rnqBcI84sDNujDN8MSvbc/xxc/ek5H/cra3cDZoLYX+ZRsovxXkEj7gmrjXXew+SP5X9WUffQKeJONnlS7sE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199015)(38070700005)(122000001)(38100700002)(36756003)(33656002)(86362001)(4001150100001)(71200400001)(2906002)(6486002)(478600001)(6506007)(91956017)(316002)(66476007)(8676002)(66556008)(64756008)(66446008)(66946007)(4326008)(8936002)(6916009)(54906003)(5660300002)(41300700001)(2616005)(186003)(76116006)(26005)(53546011)(6512007)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mP5ufWRLEzZNceFr/sOGuY9KEC49UTND1s+Z37EUlY6UMw8/4RNEMKREVJIf?=
 =?us-ascii?Q?nm5ejnYSCYzWI5wdCQGSN62UFRKY5PTWuu4GZtU8X5Hpie9juyVRMGCIakZf?=
 =?us-ascii?Q?0Tvazt8jObH5Dkwsi4ZzJXaiYnAPCzojYO6yGwD3ayPlqwPAMwyPcpKFNs0n?=
 =?us-ascii?Q?bx5epFsKjHLy2pOCgfsGAC8MTER+0oxkaQ4ZJFBXwj62Tr6lnfZ12ilL/fxn?=
 =?us-ascii?Q?+YAIKET6lvMkB9HlYwecWAh+1Ldwzlq/jFsDgFTaL4x9wXrnAL6nWZk6u22T?=
 =?us-ascii?Q?d1gv1SRIBjR0JJNd0xx4+ZU+lQ6ew9Y2/OSaL/afjLu3nSi3NIQGDdhJARpr?=
 =?us-ascii?Q?2sEPx1toG2pGsrLcmhT+YdqU50TVEqMRHhMBuwITzr9FdIdmysm42UFHt414?=
 =?us-ascii?Q?zySNjKcLebohI5TQ9qEBXNgi4wOg4PAmoOCTYke/NbaUkVOb9y+pgBQwDhn7?=
 =?us-ascii?Q?LFSSRRmin/WS6iEDvLsGIUCJJeIFweCdNGVuptsuGZa57Ci4ue5k8kbQSL+o?=
 =?us-ascii?Q?1BuDbXMzCv4oOl265A6Bi4qmIDqf9IelePRzbpI/BhXUhu5+shVe/0UHyNVF?=
 =?us-ascii?Q?Qu4GV8NIAgxxTfG6cp+W9b53iJijTbT99YPGwQW+hpnO8ANLKKGyeZW/Z+Hi?=
 =?us-ascii?Q?3HEOndcf7H0/yqnfVbrggTZmbgOANnWOD+SfhyA5WuL6quKxDV7VxEMiGYFx?=
 =?us-ascii?Q?fHd2Kt+UmlgR4a+CkyoCVUbIVGYeayv/HRB4BfPHDYvOIYIyt+K6XRGGdm0p?=
 =?us-ascii?Q?4oppiPAdd7gTVUhiCeNa+zWPk7Temy/DgdC0KtsSMIS7vpLnG/x8F27aMbxc?=
 =?us-ascii?Q?OnKn6CG8c5FkStQl6hkBoGCByDtVaUNN9C3P0ML+YKIFBGZztbE7BylypoVc?=
 =?us-ascii?Q?1aAAsMZX4oQLixEZ63hNSt535qQIyyYfbwjK3CIS04H2jsr6TuCRImXjaIst?=
 =?us-ascii?Q?r4krAA7a+pZ1gX8O4BsPcZaqHcfdxF9yseVC05OhAu5/ScxS3S/v60ZxDMX2?=
 =?us-ascii?Q?hfBtBQFwMFLGKgWo4BwOGpaUlSJJoA2DoWhtlgSREikN2OvaaG/lmNaBTt5Y?=
 =?us-ascii?Q?exrVtvdECoNTL1vRP0E0RU4ZmSqQyP2M0uEeWdKAJHzdfH0DyUj7pc9IHO9E?=
 =?us-ascii?Q?57Qpowjcq3feFHU28WSPid/BYFqRzVNf4c2azP1B9NtI2QEg3eKDWTFDTZ6l?=
 =?us-ascii?Q?x6Ta9u0m5jsq4CHm7xQTNXNYyyDP/Er3mn4mxZRl2b4ZJyaOLh14S4/C7iXc?=
 =?us-ascii?Q?PQh3qe43o9vfc9vggV8Bv2WCUm1lwgcgzj3xTRZiehH1CNRnGiJQ21/IfpsD?=
 =?us-ascii?Q?dIDtfYcdDUcgqX+pGcN+8ERJ7N8OSes57PWajhufbvVRqQUhv5vERTTjgqMs?=
 =?us-ascii?Q?D7Km8kpKNT1OVXbHe4YxubZlk3Hfu28lvbVjT8hmrTColUqOSDYAm7rk4F7C?=
 =?us-ascii?Q?JpmhEqYERNNZWhZpQAzg7qQiYLH3320Zbd6382dwD33dhn4eJzjrqENk/kTE?=
 =?us-ascii?Q?Mf5njELA1l9Y8aC7mJogySiRUCnu+J9LysJZDJ9dkfSd/4wntyU5k5cm7BHX?=
 =?us-ascii?Q?6wInThn7BDTUl2BwHLwo5Xdbn4x+/CU8vcwxfehJZCoQ+0PgpJoG7aXn8DO5?=
 =?us-ascii?Q?qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25CF97A63B37B942804C34D23AA900B3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6fa9e7-766b-43a6-5e4c-08dabb46c0d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 13:49:38.3766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lu7mQlviAzOFoSHnc6qB4FpVknhzunTjlxi9R+gIx8YiJ5rT4VVOOSvfg9ocEwe6fNFAEF1wyJCKjy6/pxUJ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_15,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=986
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310087
X-Proofpoint-GUID: eiY-7UQJH_8o8uMvejAYwPL9xgYp0o0H
X-Proofpoint-ORIG-GUID: eiY-7UQJH_8o8uMvejAYwPL9xgYp0o0H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 31, 2022, at 9:48 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-10-31 at 06:31 -0700, Christoph Hellwig wrote:
>> On Mon, Oct 31, 2022 at 01:21:45PM +0000, Chuck Lever III wrote:
>>> I know you are Not A Lawyer (tm), but:
>>>=20
>>> The e-mail address in the copyright notice is stale. Is the convention
>>> to leave stale e-mail addresses in place?
>>>=20
>>> So I would expect copyright ownership of this code to go to Primary Dat=
a,
>>> Jeff's employer at the time. But they don't exist now either; it might
>>> be difficult to get permission from them to alter this notice.
>>=20
>> I'm not a copyright lawyer, but I've talked to a few, so:
>>=20
>> - first, does Jeff own the copyright for this code, or his employer at
>>   the time?
>> - if he owns it, can cna do pretty much whatever he wants
>> - if he doesn't, I would not touch it without approval from the
>>   copyright holder, which gets a little complicated for a company
>>   that doesn't exist in that form any more.
>=20
> I went back and looked at the PD employment contract and I think I may
> not own the copyright here. There was no explicit carveout for open-
> source contributions (like I have at RH).
>=20
> In light of that, I guess we should drop this patch and replace it with
> one that just adds the SPDX header.

OK. I can cobble one up.

--
Chuck Lever



