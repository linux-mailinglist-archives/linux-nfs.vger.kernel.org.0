Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B07C772872
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Aug 2023 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjHGO7k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Aug 2023 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjHGO7h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Aug 2023 10:59:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53264172B
        for <linux-nfs@vger.kernel.org>; Mon,  7 Aug 2023 07:59:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377C391G019142;
        Mon, 7 Aug 2023 14:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ri0nZESO6ghpuPZBDGoJGaHPmvgSWuk9Bs3CpQV3UE0=;
 b=EMYPEQ/shcYribn0n6VCpytU3gan2l4TXYL4Hw+qBtpumPp/sFzDo3RGLheBaAtRgaon
 8nZxSM7jS+g1U7O0DoG/Pacm7N6O3VsELhTCUdPuaVnr6hibXdWGF9JmRMDHZKsGpTTo
 7N8xgI9maQjqwbE6iQHbbcqWTWykWhqoD1fxy0s1FX25PLNc6CghNZzNdQ3hOyYvK4Uh
 TCnU1i59dQumyJ8OdE1ZEgWlvQiSsHqO/ER5h8Lkh/81yP4gkkxNxLRHfmpRZIgLPqeH
 EORCyYEuvxhCuaz131wzW2QRSKZnBjIknac2shMKCOh1KiPfAd7IfUGGfuYpmn94hqFw kQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eyuaws4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 14:59:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 377DaYw2032810;
        Mon, 7 Aug 2023 14:59:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvapv53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 14:59:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dV1mH8ffFB6DgdL5xKAWIbmzNYUTUvZNUAiM5wzGKH4bF1tYefYvRT14t3a1fvni7AJUJZ3aUOqOR5cllC4MXMMcrPWtqEIhmtUfI1hDmHckOLLnp+vpFYEFCP8oD+Grkq2Rc2ywckeyqRHv/t8eutyLrYOHrsBRxASzXsJ2jM5QJH/UlUzpk7gZPVdRTyDdY1np5qTzXKkmWXYMxkXuYPvbKqQJX2sobfARDbDPDCXQ/eX6gw6zj+PJouWmQmICxa3GdMczdKwKQLB+qXIr37wwnCb1sWq6QAUTTp+pkVaFwfvCx8MobO9NtzXv9RgwKXmuZGzFMwUSGFa5AO1K/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri0nZESO6ghpuPZBDGoJGaHPmvgSWuk9Bs3CpQV3UE0=;
 b=WVWgNFJD4XTOpzx/TH+L6XtzfNttzm4O6sf1x1jFV4iB6m6r1BJSYdPpiOKn05j2wcj9eOlfoAxc6uelm9nZlEtWcOAg27/EOFtdmUDyNhRzXB9zjNpqVtHbb4KpN5O9Au+2clz5Gs7agoiMsbJVkD2/ZSXKhJAtNd3sSizgPoIHDzZm+TZpbvQ7/nedSkZecsWU+3xx5tC6TTd+sJJPDyGsXmIYYJ5i5mZzlq/uEK5U+8UFe4Am55klAd+nIEm9Q508Y5Y61gAcYxuDK2M2qvoWHZVuWc7P5+YxudSzQHAnpolMvh/JviXivGdNDfCla30g1sR5sXSD2aOR/bRYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri0nZESO6ghpuPZBDGoJGaHPmvgSWuk9Bs3CpQV3UE0=;
 b=Md4LXvNDcmr7wkAO2FLUqUsyRzWrW0+yWDdDV4uuK0PBb5ot54W6+vQy6i/aI9pw+mHTB5RSWhQEw4UN2wboCESciTqxVzVvuyLXPg/gq4XMthPyvJ283H3HPtG/vQPkPRaDCHiXLXaaKW+n07rQGDyIlrOQxIuYp2i9tPauwDg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5135.namprd10.prod.outlook.com (2603:10b6:5:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 14:59:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 14:59:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/6] SUNRPC: rename and refactor svc_get_next_xprt()
Thread-Topic: [PATCH 2/6] SUNRPC: rename and refactor svc_get_next_xprt()
Thread-Index: AQHZxRPgHxYzbBnJF06ZMnHc+KOwgq/Y71+AgAAkxYCABNclgIABCgIA
Date:   Mon, 7 Aug 2023 14:59:23 +0000
Message-ID: <AB562220-7E61-4E7A-A2E7-D919FBF2CCD4@oracle.com>
References: <20230802073443.17965-1-neilb@suse.de>
 <20230802073443.17965-3-neilb@suse.de>
 <ZMv5S7k4iCQgYXZ4@tissot.1015granger.net>
 <169109712368.32308.6546907686830224026@noble.neil.brown.name>
 <169136322726.32308.17877125734879515633@noble.neil.brown.name>
In-Reply-To: <169136322726.32308.17877125734879515633@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5135:EE_
x-ms-office365-filtering-correlation-id: 57775de0-b1b7-4a63-3dad-08db9756e2df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pOtmjlodVruP+MRhiyRs3JTDPg1u5KYzCw+bYwV49PzUHqbQrSMmWMNjti8zbX8J+Tx7HdOspSTdLTj2YqmfNEBmi3Z8OzbGZ9XjA7hO/ab5+GhPE9Tuy5UAzbGwy0Yn/pXcQg4krn3BGCVbMl8aEV3aLHaJ09raDVfbfFpy/UWGnfq6khfmhfklPwtfdGeOIxIpFmlO27gFbNB/kfl9IcvFIBMHLZvyShUhvby6iVkIxFX8oh28hGOrER3IcZM1gNeg8W3iO01LvVT6yUvNWsJOtX986bFPoCk4mB6y84HWO6Zx/YA3iSptHcsqyOqETvG0eFqSlVEAmhdndiTYdMWCrfAS5SN/JQQg6DLFsB1nv5MADEXknkeHTVFNGV7AimLM2Y1mW9dejPK3IdtWgXdj4DZmhiWw3NkScYBSmJC8IxiVB2EYO1s8TcXDA4ppjJg/+7GKPjiaX6c2YFNasOMS8v5TaLWLX5hskSzMDDESq6zsiQeNHe4/qAcsme33KpV+Rs6Bs5phkt8DwwWQShO4FbqHmgUAmJsMDAllBsQFVCtJjDinMsZIdSZTxs5MiYpVTqROEccabKDJSLsIxrLXe0v+Hs+g5P+DKT09+jzTtG08r6gZ3EwD5b3eBv27t3/zUFROCQCtXOAzUXSi2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(396003)(136003)(346002)(1800799003)(186006)(451199021)(66946007)(36756003)(76116006)(66476007)(66446008)(64756008)(6916009)(4326008)(91956017)(66556008)(2906002)(478600001)(8676002)(8936002)(5660300002)(41300700001)(316002)(54906003)(86362001)(38070700005)(33656002)(122000001)(71200400001)(6486002)(38100700002)(6512007)(2616005)(26005)(53546011)(6506007)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ICbX9zqXqBE0lWJvzSIMA/6c541wUOCGMMF069ysVPUNPeMIW2VebkNTxjwa?=
 =?us-ascii?Q?OQX7FnDA6SeltlGY6UuOfSTseXXSKBKiXyHjtRFD1dyuLBxP+pOvjCWfY0jJ?=
 =?us-ascii?Q?mU3U5lELCLWU14tjiz0wdeDhNLZLXoGIDxVzijWNRt0EeJSBc5KmacjR4P94?=
 =?us-ascii?Q?3FHs7tDXxZklcbGB9/AN1yXATnqTV9Amg4mgXcOcU8lRZ1vnFbQSxrtmQ1tc?=
 =?us-ascii?Q?4xqNGz05MZ9dfCRg7oMM/VdL9I5aBUmDMDizyckPFnUrBeh0F7cBIHqCSFq1?=
 =?us-ascii?Q?oe+tr9irrIW1i9DC59mc/BqRoU0wS4ATL0sqSrCrz9TaAXywagHLly9bLfRq?=
 =?us-ascii?Q?NtKyrW/4FIpGDGcHPfVM2vsShu2IyI3EjSRn2K6EUaq7CZkrLhmLSVbbejf+?=
 =?us-ascii?Q?NQMK5CC4chSZ+dYlBuwcV6yiWf/kPbQEsvmmH9dSffpKAi9oYxSxcoazeOio?=
 =?us-ascii?Q?PCRiLdDw5EpQqvfECoUkdJ9/W7sGMfQiDEMfFsTA9f9fqCZINn9bfFbtQXxi?=
 =?us-ascii?Q?9PiuS7ltI6YNBw93aI+rQXp9OJkjM4IitjanfIE8BlAhl684TXt8z4tly1Ff?=
 =?us-ascii?Q?gW0SgZ5viHxhl0lGQuacJw76P9yEdqTW5TUWZQsHJuCjHIyyCpEbh4Whkk0V?=
 =?us-ascii?Q?Yb/AJXaKROxEq8ZT2IlnQPK6PCpc6Nybf2ATxIBL8SBYzG2PFRQqx/6RPF5D?=
 =?us-ascii?Q?NpcgiUqn5Rtf/8QZy1qN5B8OnXToOL9mGHSmE5IhVJjb9YktB9Fkt7zWW8iT?=
 =?us-ascii?Q?m2yn6CwZeujGa9gcpVRAPpeWIFlu6PEA/cMZUAMYYFuVpsQKBDGZK5ujGFsL?=
 =?us-ascii?Q?bNYm5WkpeUPWyT177w1laeZj+S6VHnxoXfUV8qf7Ggd41SMgzvAiTci59jku?=
 =?us-ascii?Q?rkALjAnC3unStM9t8EUULF5yesYkLObGKK3Ccebj1RlrYaJTQIJcgTvFMfjs?=
 =?us-ascii?Q?o7ZSmCoti9bhA7pn87Dahi883WzKbwaLtE5GiEbYmdm4/M13XfeODbYpy/1T?=
 =?us-ascii?Q?/5r2KKZ5IxCaTUZvjqBOfTd6bIiaBcSn+A1pxNEudalsi/H73JswNrm0MKa3?=
 =?us-ascii?Q?cbZXXDw1a2Guiy4qumVDHiU4YQ4AMA5H92uWwY2rpIKsFh7zd2+VKqfJseB7?=
 =?us-ascii?Q?38lpnvE0P0KjQ0mEhxFfMRp1ad3s5aqK76TxjDPAkMDzynTshOewspyPRlC2?=
 =?us-ascii?Q?6nsiMhfpp7kYaQUzOeLOwgEqQGyoYY/3efZhYGijKBSD+d5FppByEHYnhlt8?=
 =?us-ascii?Q?wE03q80sGDD2kceWjnm4jHvEZXN2z3gFhcwC00SR1xeV58z+p9wsuNuIcjmt?=
 =?us-ascii?Q?f2vSYgfYrd9YL79Z8JPPEcT4zT4+4yQbO7Y5c2LN8CTHsRUp5Vfnh7iPLBzS?=
 =?us-ascii?Q?fOlvjDvSjPjJwCuQhiA7cYPzw/7vYcC6DUnoqQocMw9h6d5ZC2AuCCiQTgUX?=
 =?us-ascii?Q?EQwR9G0mQfTmZ/jaC+TXDtbIr+YmP8TLxldFiKzfYYxB9jAdgJHvD/2aFK2u?=
 =?us-ascii?Q?sZ3yR7hViOfNmsOHJsWeuzf6fxQMG+QqWnMH5zR6anq5qVCbH1R2Do3HgtAW?=
 =?us-ascii?Q?nZhk55wWd7tXQj+bud60AoOMcyHoP+J97+v/HBtNCr/JxXRx/8WgiXPEmUQN?=
 =?us-ascii?Q?1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A64441F0193ADE489A1FDFCF3BC131B5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S14r4qBdlcbgXWKCllatZSBxOW5OphEryfu0NJdy8wMLNjIPQNang8eOQ5mk9yb7hj0oFqRd5qB3x8dBSIbHHAldaqhhj9m9F4Qks3ZujcYeG0eUxX/JUpUJDx2232EnFCaPN/TA3iqyh9i+9s53ppPbT1Sa+0gf8qoa5ZGYNYCRW6E3ZipEMW5ILT7m2Z2rmGSGzwozjts6ZYgP3d1570wwXX0D8Lih+pgWOPJ2T0TLn+vTy4F/kMTP9sdJVRKmJNSpIDQymKojdpnPaI6OgIO5zaTnXgGYrKX+nGx92Y3E77eMm/r16dzST0bxks8ttoZfbl3ajoTpMeoWLuyKeT8RXI1AWjxMmW8eeNl5VIgNrs4IICD8GEw+pObdh/jC4Di8ZXt9YsPFdB/dGsCbLk5713uWV/PrILRk95u6zV5oHpWc3G29Z2gdXreda0S7RdNhXgoEIm60Kr1z073JmddlyX2d7R79PSQjsOJCrXGurulHROE88BwxAHLASxFq4Bgum748mYcVVY9QIsct7MGytvGM0qMtPuErbbbiVJz69iK+pIzufLn/MEBFDmrp3yzRhX9k2Lvt2qxkedt8b8xNaKfT1jsMHBWHdmQdpEESWxOiU1qvk470ZLBUg+Hvgyk2V/jxWAX4dBksMyo7DASYZd+LupB9suH7N2pskOIPsA1Rf16Crcz8HGpDhZ0Pee64V3qsvr8jPv0oTt4evsqU3zVXp9cTpOrWKGgOYM8IdLHUYVO8R5W6SeBan83LrGclwTXVSCVrbT+xVmMyz294q2D0JxQjqduD6qOaQpwlqddGlI66Rh3wQxipsXAp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57775de0-b1b7-4a63-3dad-08db9756e2df
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 14:59:23.1821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +HlLMcAiP9eKGEpCZGg2oDVfouG7ulI8N4j2Oy81Z8Ktd3zR1DGTjwFYDtt2dNpLSTPypoq/DeZPL61moYW3gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_16,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=910 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070139
X-Proofpoint-GUID: KRfyUC4BZ3JLmEnqSwdregCGMUlMZoDs
X-Proofpoint-ORIG-GUID: KRfyUC4BZ3JLmEnqSwdregCGMUlMZoDs
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 6, 2023, at 7:07 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 04 Aug 2023, NeilBrown wrote:
>> On Fri, 04 Aug 2023, Chuck Lever wrote:
>>> On Wed, Aug 02, 2023 at 05:34:39PM +1000, NeilBrown wrote:
>>>> svc_get_next_xprt() does a lot more than just get an xprt.  It also
>>>> decides if it needs to sleep, depending not only on the availability o=
f
>>>> xprts but also on the need to exit or handle external work.
>>>>=20
>>>> So rename it to svc_rqst_wait_for_work() and only do the testing and
>>>> waiting.  Move all the waiting-related code out of svc_recv() into the
>>>> new svc_rqst_wait_for_work().
>>>>=20
>>>> Move the dequeueing code out of svc_get_next_xprt() into svc_recv().
>>>>=20
>>>> Previously svc_xprt_dequeue() would be called twice, once before waiti=
ng
>>>> and possibly once after.  Now instead rqst_should_sleep() is called
>>>> twice.  Once to decide if waiting is needed, and once to check against
>>>> after setting the task state do see if we might have missed a wakeup.
>>>>=20
>>>> signed-off-by: NeilBrown <neilb@suse.de>
>>>=20
>>> I've tested and applied this one and the previous one to the thread
>>> scheduling branch, with a few minor fix-ups. Apologies for how long
>>> this took, I'm wrestling with a SATA/block bug on the v6.6 test
>>> system that is being very sassy and hard to nail down.
>>=20
>> I'm happy that we are making progress and the series is getting improved
>> along the way.  Good lock with the block bug.
>>=20
>>>=20
>>> I need to dive into the backchannel patch next. I'm trying to think
>>> of how I want to test that one.
>>>=20
>>=20
>> I think lock-grant call backs should be easiest to trigger.
>> However I just tried mounting the filesystem twice with nosharecache,
>> and the locking that same file on both mounts.  I expected one to block
>> and hoped I would see the callback when the first lock was dropped.
>> However the second lock didn't block! That's a bug.
>> I haven't dug very deep yet, but I think the client is getting a
>> delegation for the first open (O_RDWR) so the server doesn't see the
>> lock.
>> Then when the lock arrives on the second mount, there is no conflicting
>> lock and the write delegation maybe isn't treated as a conflict?
>>=20
>> I'll try to look more early next week.
>=20
> The bug appears to be client-side.
> When I mount the same filesystem twice using nosharecache the client
> only creates a single session.  One of the mounts opens the file and
> gets a write delegation.  The other mount opens the same file but this
> doesn't trigger a delegation recall as the server thinks it is the same
> client as it is using the same session.  But the client is caching the
> two mounts separately and not sharing the delegation.
> So when the second mount locks the file the server allows it, even
> though the first mount thinks it holds a lock thanks to the delegation.
>=20
> I think nosharecache needs to use a separate identity and create a
> separate session.
>=20
> I repeated the test using network namespaces to create a genuinely
> separate clients so the server now sees two clients opening the same file
> and trying to lock it.  I now see both CB_RECALL and CB_NOTIFY_LOCK
> callbacks being handled correctly.

Thanks for these results. I'll apply this one to the topic branch,
but I'd like to get client review/ack for it first.

Meanwhile, I've applied the rpc_status patches to nfsd-next, and
pulled in the first half of topic-sunrpc-thread-scheduling for
v6.6.


--
Chuck Lever


