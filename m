Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79425580564
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 22:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbiGYUS0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 16:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiGYUSZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 16:18:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815711024
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 13:18:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PJxO6Y003680;
        Mon, 25 Jul 2022 20:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jb/k1092S2HtCisiyzlqGMvq7If5GsAET+SmaSa//BU=;
 b=FVObfdGINil/RVYunvGl2GNv3PNXj8ICBeWmBuFz/WMC/JjEOLxfoBoh1bvn3g6JgxxP
 iAB1VPykkqnLFwtEqLmGhqfj9VCYahCQSeCKXy5SiZIxT/QMNLVykP6xAyUfp9r1/gef
 Rdz6hgQyJml/b9n6nrR0/fq3LJVzxn+xbIhTqmOfvfL/XF952GcJqrH253zLaMf7XEy0
 uvQTY/o81tQeI926f9jdxrcXWvP2pM28GAs4NXiJCo2QOtr+Ni0UcnthM9mgnSrztPSE
 R30HSm9FxSAPrZJ7s2h+Z1wEqZI6OImlhzKZ8sBeOYthM4MXOXJHvS2cFbLRrB+wh4kd Ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940mgd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 20:18:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26PHPDRe006282;
        Mon, 25 Jul 2022 20:18:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh65ard3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 20:18:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVQADA0XwVZ2OMFfzgSIWvI/OKXYO5yodHOdjBn/671fYeG5PHZW4J1AA2dHm0BiJaHEZ7FEcj/eCluZsfiYgIZQMWYgWPKYRllVen8jeH06wqNcPbjFflZAiI20R7G6qISJUq0g7U6RRF8HCw1CdECuYIxLEaj5HnP6OtPnntp2wV+t+uvnWz/uUuY4l3jsIzVKtLezDFj1oyxSvIkRIjbprMPeBPkPgrErwZOrDEu/9+b03x1Xaon8fYU+p82tV5aaPMgP2HRVA6eQpSHp/0u1azxC3C4oXc6ACbqfBLk3uu7HKCQZAN8XoHt32SggzhAXVry+dcVkNvCRGvnxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb/k1092S2HtCisiyzlqGMvq7If5GsAET+SmaSa//BU=;
 b=Ck8n6YSCP+MnU+SDaQzf3IQu1r3bzMWnkkq6thCgj96CkC67tIMWTon0b+L9WU4hSA/OaSJahOTfISTMZfpo4sAIMVVkP79Kra6RPi1V5iHQnN/1tCiz6vun6CGUsfTQt1VfrgQeispWq6uc31h4F7tqruR9kjW4f/g5TvGKT1rzNW+k0bHBSIbKCl3/Srjoj61NuuvQq6deJZLFDzeItDwl8i84fqm1Dykhzy/g9HSBuVcKwPuBihX+BsQn/Z7LNHoiwEv2ZyUTIc/vEaBv/bReJ70HZOq7SEcNqyx6NJU/oIWbtlAgflKW/wIkhogeQ0YgkkodmmM+Qsek3GwCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb/k1092S2HtCisiyzlqGMvq7If5GsAET+SmaSa//BU=;
 b=wdP6LalJEexFSTRUO+lawDI5DSKhjxtplu2r2CHtk4r+fj/EkAwa2091dnrIzOy6iegELzcwE94IuzxncJQi8c+tPA4+SpkeI/3BfyiFCQPkSGay+ynjTqWWeCkGhbDZa+3P6GfV8SCzMJYuZBp2I9NABM6kKqRnP7RPjBY8R1U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN8PR10MB3523.namprd10.prod.outlook.com (2603:10b6:408:ba::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 20:18:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 20:18:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 1/8] NFSD: Optimize nfsd4_encode_operation()
Thread-Topic: [PATCH v1 1/8] NFSD: Optimize nfsd4_encode_operation()
Thread-Index: AQHYngbpSQ9QZL9xbkiIK/IHMr+cjK2K0oqAgARp8QCAAE7PAA==
Date:   Mon, 25 Jul 2022 20:18:17 +0000
Message-ID: <7B967688-54B3-489A-87B9-3971DDFFFE87@oracle.com>
References: <165852051841.11198.2929614302983292322.stgit@manet.1015granger.net>
 <A87D312E-1042-451A-A1B7-438351BCE368@oracle.com>
 <59534604ed620c0b7e9ec565a4f1505ca0910420.camel@kernel.org>
In-Reply-To: <59534604ed620c0b7e9ec565a4f1505ca0910420.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98af56a9-bef8-444e-1e70-08da6e7acfae
x-ms-traffictypediagnostic: BN8PR10MB3523:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OwmhkpKWqivg2NphUWosh7s8tUCSqqs0DxZA6E0k7v4eQ/vQsqBEgMJHDhCOg+hEjfZ6jMrvBFlyK+tIPV7zyDTI1n2UR8YEWwAYP3GN/RYxyk1iRYaZ7onRomD7PO+bMvztrZAFnTozd9OMcdjlFDb+N4NSRuPVjPkhbTWX/NsjotBsBm7GXhMj+QFcgWtnfqnICDXrp+RlJhNFo142LNFbAp7eaz+DWaWf89z1EnlhxANT7880GBNB9FIAg3vQgddI0AI4UPcU+M7XcIxUMD/qYhVLxPGyzwmxW+IfXjwrU6r7godQcCa5EjLZoavlElMCRysWY3kGipbw0bGg9mhJgaPqwOxUByJI/1TqUaXma5FRbjb+QEgkK+8dZ3gg95Gu2tqEbPPnk33dwztOpaponuRS657bXqEHpiFi5tiJ7EqEX0etEbd625xLeQd3hkSxEP3RHrA3/okkenASgNnumYL1Ap/fqz1lSP4/y0cdHLkKTOm9pw2vKjNq8Pqw+KjHoDsxqeYi82T+HT+WckQUrLyPzchQHm0dg9R5A3Iq1v6pQ071/EHiMdul3ntSY1RoqOY0Uwm2CGT3RcImahtBryA0c6T4hsmjou0AscFToy4aQchwzDiE8CI5j2zRf97s9whnqFb8pyrP/Ip7AJAGnaH2mFwGKRpweWb7KeqD1YRQFCgPblyeegm1+2MFpnsme8tuFbl6vW7pHoSIbxzmOz4c3xgguWF6pKcb5bL2+2ozWHpU4DHMy9PLM192MA9WNf+7DmE0RGoPuHm2/KMEGaYCKqH5hMWLnA4Urh449AG1lXtfgZ82DpPk6lNhzWixiUxpPi62SL3q8tcXKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(396003)(39860400002)(366004)(86362001)(36756003)(122000001)(38070700005)(38100700002)(33656002)(186003)(83380400001)(2616005)(6512007)(478600001)(6486002)(53546011)(316002)(2906002)(71200400001)(6506007)(41300700001)(8936002)(6916009)(66446008)(91956017)(4326008)(76116006)(66946007)(64756008)(8676002)(66476007)(66556008)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?81flYzM+TfqnCxj1giKayX70HFvSBDhcf6hMAzMW0hibSyRzeDJTOmQ1pmm6?=
 =?us-ascii?Q?0XF9jC68+WeyYog4w+l9dX/srTD7NTreI/QsSDtfOt9At/NNOckSR7CqWezn?=
 =?us-ascii?Q?VZBPITF52Q/5hGH5kDqm0qtYmN8trb+gwiozLdS5+3N+Kc9AFjnKTAVRC00q?=
 =?us-ascii?Q?sssIAzWx6Dhw9DTmU8t7W84YAM2fpgdN/275oKTjYp/DUxMkAxS2rjRkyFeL?=
 =?us-ascii?Q?kHA7leeWJ/Gu18A2oLlmb4vquI+QPmtdeBqGRFRtoGTxaRFG7veNM+eQaSXd?=
 =?us-ascii?Q?GZiuZUl1+N5yy/7MXlO8BKi2tmZFFEgggTrDd/Cx2wShwuS6ImJxwTFQmp47?=
 =?us-ascii?Q?AaVJAPwaPYPGJHiqUtfILRSlYqA+8zdnz39/pcmgXMLNAvRvbU0igY7dnY3A?=
 =?us-ascii?Q?eY9ZCSATMYFbPx8B/yZfp2Oj4Nt3aYtCJXvYFj3tx29VYyyD4BGuCsKx3W0W?=
 =?us-ascii?Q?JHKlJVkqerV7uzfIMTzsV3YeUCIk+n/PFrCp/ZpKmJECvRVZt6SN5y+qJuI0?=
 =?us-ascii?Q?0f/HgiWaZxYg95spMjdsuQcEOzzmz1VAy2pUUiS1DIf5zn4E2qA+orXrlVIr?=
 =?us-ascii?Q?0DwVr2wn8BU7HVDJPNWQxgNEpFs30eZcdw749sf9/L0+vwcbKjh4QsJnNiUt?=
 =?us-ascii?Q?1knUm751lwDRBHv6XpzPKAmouIKuQQLk+5ksCTr+nkCC4bqtNRPfjyTW4AAn?=
 =?us-ascii?Q?TRzqQQthqn9a4DXh8jT9EVPkE1KyTyLoH82tVB097ZDIKsxolL3d1SRTheZG?=
 =?us-ascii?Q?8zl/GpKYXmsF1fd2H3UvUykW1fkanvIKYHE2aTdfhbysUY3QpE3ja8VH5rYZ?=
 =?us-ascii?Q?Lw/qCrG6UXcze5hZy3jdParV96LxWozz2qrqyi/qV9DdCAE45Fb3Vu/HtVEy?=
 =?us-ascii?Q?aWaw3lqRXZMa5fC+1aTTssXSbGUzUJbr0Mi+zhQ72dCJmyHxR7bMLACXbZ++?=
 =?us-ascii?Q?fEzTZePJgwKNE6MbeVwID2avTPb3WTvM0iuuhQDUR3OY3TA1fa6OlCxujqpy?=
 =?us-ascii?Q?umx+s4T1swgwy9I1XREJ7G4ckHgQS8dT2aSjqVlaDbgJHBXOrJ/8nedbqCvo?=
 =?us-ascii?Q?uWWs7iRSFkU6kwFu2mCUoTKbom6dI/6ShFx8DtKHaG+54E0zN5m5MaaBNKoY?=
 =?us-ascii?Q?k1uUfsUzxTanAC6kCYOoMxBmk2egn/cbgYNNUdNFfkd5Mg/mtAYNuPijoZp9?=
 =?us-ascii?Q?8317noylliKKfUSBt7H5VAh4RVWhXYKd9UXkaYRwNkGS+rpsPHPtZWKSXjzf?=
 =?us-ascii?Q?4tm6U0stM97hW6DfKgvAsMv9lTHicleSZPuWcXB6CMB0KhPjWyKXCjrreHH1?=
 =?us-ascii?Q?LbwE6ZK3gg2unWsf3FO3u8oymhORMNr1+7Z/SSbMucxV5gql3M0TG2kGlGAF?=
 =?us-ascii?Q?DbF7lJIGjGv1r5Qr1ko0CKBscTHuqY5bcPjyykYgkOhgZ3Y7CW3ZUbHoYZvo?=
 =?us-ascii?Q?8D+qaFnNPKophqFSzxH03okNmCsbXK5ws4TIK39RcpkpGAWKxlFocCF6XTfJ?=
 =?us-ascii?Q?wiPqhVJ0OUKq4Fs4FjkKIEXYbEBZ+iLQds9QVl9acRFlozCnTNg+7i2Zn9C2?=
 =?us-ascii?Q?lZIrMajbDi/Dfcz32tPqBQy5QZ0hV5KyvF1IyDGurOnhCa9UqfFl+SUspfnH?=
 =?us-ascii?Q?mW7ofQhmZR19hh3BrU9J2MlON3x5XKUC7eXnlrmBWN4VWHBTmNTi/ewnvt2Z?=
 =?us-ascii?Q?SeFGZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4821628618A42E41A4DB56D22DF6DDB4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98af56a9-bef8-444e-1e70-08da6e7acfae
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 20:18:17.5237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfLO41sbmYqxeFloj1Rle7CBbPYAmJXkTa37AWeHj/4iKsXBwokaHPyVjlZ74uxvJlA5CEyyMlxEmnodpAU8PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_12,2022-07-25_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207250083
X-Proofpoint-GUID: SYOrgj67cRHDOE_0eVQ-rvFZ4ih0B3tr
X-Proofpoint-ORIG-GUID: SYOrgj67cRHDOE_0eVQ-rvFZ4ih0B3tr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 25, 2022, at 11:36 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2022-07-22 at 20:12 +0000, Chuck Lever III wrote:
>>=20
>>> On Jul 22, 2022, at 4:08 PM, Chuck Lever <chuck.lever@oracle.com> wrote=
:
>>>=20
>>> write_bytes_to_xdr_buf() is a generic way to place a variable-length
>>> data item in an already-reserved spot in the encoding buffer.
>>> However, it is costly, and here, it is unnecessary because the
>>> data item is fixed in size, the buffer destination address is
>>> always word-aligned, and the destination location is already in
>>> @p.
>>>=20
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>> fs/nfsd/nfs4xdr.c |    3 +--
>>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index 2acea7792bb2..b52ea7d8313a 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -5373,8 +5373,7 @@ nfsd4_encode_operation(struct nfsd4_compoundres *=
resp, struct nfsd4_op *op)
>>> 						so->so_replay.rp_buf, len);
>>> 	}
>>> status:
>>> -	/* Note that op->status is already in network byte order: */
>>> -	write_bytes_to_xdr_buf(xdr->buf, post_err_offset - 4, &op->status, 4)=
;
>>> +	*p =3D op->status;
>>> }
>>>=20
>>> /*=20
>>=20
>> I hit "Send" too soon. Here's the cover letter for this series.
>>=20
>> write_bytes_to_xdr_buf() is a generic mechanism by which to push
>> an arbitrary set of bytes to an arbitrary alignment within an
>> xdr_buf. It's expensive to use, though.
>>=20
>> I found several hot paths in the server's NFSv4 reply encoders
>> that write a 4-byte XDR data item on a 4-byte alignment, and
>> thus can use the classic "*p =3D cpu_to_be32(yada)" form instead
>> of write_bytes_to_xdr_buf().
>>=20
>> This series replaces some write_bytes_to_xdr_buf() call sites.
>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> Nice cleanup. This series looks good to me (and it's a net-negative LoC
> too).
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks, Jeff!


--
Chuck Lever



