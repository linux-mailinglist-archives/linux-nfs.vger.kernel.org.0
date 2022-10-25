Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADE360D224
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 18:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJYQ64 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Oct 2022 12:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiJYQ6y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Oct 2022 12:58:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A111011A1
        for <linux-nfs@vger.kernel.org>; Tue, 25 Oct 2022 09:58:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PGDQIv012990;
        Tue, 25 Oct 2022 16:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ICXxnOPAjxsWNbxp395udSszqaIUTm4qD6nK7L5kQFU=;
 b=bqCpdOBs2tj/LR2ShVA0PWCAnPcpGv9FOpSayqRr34oAwrtyyP84uQlA+cowZYQMIJPJ
 GRMczmBJsFb4qYOxFEyb8CwA137K9qqoeYArI1NfNMuzfORCcQEq2xXkawjkOuxJW4hX
 yS7YJL9cpnzK1QzsaLI+CzYytlApCVrbGZ174udQkYLTxS6Qxt53t3oIp5fl+pyBjac2
 0G7CfvTtBvTG43zCwBTuMoWcCKH3MKXo4P8yFEVsKAyvNuqCeg4Ruvpjmugim+j2CdiH
 OuMweRFMR2TEnylFIdAg/+Mzb+39NbkRKn/O25ew5hJXktHGMLM7Li6cTo/6TKhYKkqn JA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc8dbkxat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 16:58:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29PExvwq039894;
        Tue, 25 Oct 2022 16:58:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6yaut8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 16:58:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFa+OUVnjICXjQQWJ6oxUsoW6cHXQid39zUP8oBykS6weGcxdxNVJD/T+JGgG1l6V0fkuUQ2R/mwV5gfPodqABr0aE1/T72n05gVcITBnnIjGm06LnBP7rJqBdUzfPhabUnxV4Zqr0OH8zt4FxzouN8raobAMy9HWHXNW/9DtgVIG++w5jBpjk4tTbRXkl0gFBx/FgxYRBDCOE4PKg80V8uuu+9QmuoPgBhptv/x43ibuGxWBa/q1nUqlSzBLQG4ebQTWF7AIFJ+0sDde3XQAhVrXwCG09U5VrGNO3HC4nGIvyrYzZ285Wx2klu3WeAiKt/EO5Emf2HDzVhS/W/EGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICXxnOPAjxsWNbxp395udSszqaIUTm4qD6nK7L5kQFU=;
 b=UVXgwgs9KjtWstl2ceDnoymjD4cOP+m9LmK8XEpuwHGIkp93Z/deHUQoeypeN2nAqjhTq3F2LKOKLQf35aUUqQmhngvmnvEp2tB4B0sZq5+4TrJqrc1cyXTfCyLBtUR03q2G4Th398QZhxZdCRRyjv3A9lsu486hkEafSle3K7qGy6NEpTuuwbPmiUzRmcQJTqh+iYdtUI7XYqGVpsvPT9XNUYoInP8wqon3y1KdOQYaVkfNDxRfOInLejgwy43IHPHP2Uw/4iZOUWo2AIt/3EJ40mVp1VI4SG6797DOqxIBNWcfAXKrkYQDiEFUEdkiHEnWte7L4WSpgJdz+2DP5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICXxnOPAjxsWNbxp395udSszqaIUTm4qD6nK7L5kQFU=;
 b=Hh5AACYJfnG7YD56UZcNx8RRYa4NqTnSMkaw2B1ArB5Feh9YBBTGVD5/op7k6/MEXML/nWY8xCN9hxVBjVE9eX/g9iZL4MVL7iIpy0k3vfxtpj8zcQbWAJ9vyLgIaMHGIiV5xJ14IYdXR+zRuy5T4jqQsYSGPuvD/jn7ahkrFK4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5362.namprd10.prod.outlook.com (2603:10b6:208:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 16:58:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 16:58:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 13/13] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Topic: [PATCH v5 13/13] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Index: AQHY6AJxNlboIvY4vEuTvEj23BK0Oq4ePvWAgAALxoCAAQtTgA==
Date:   Tue, 25 Oct 2022 16:58:43 +0000
Message-ID: <999F93CE-3F0A-4A2E-B16D-160E10D5248D@oracle.com>
References: <166664935937.50761.7812494396457965637.stgit@klimt.1015granger.net>
 <166665109477.50761.4457095370494745929.stgit@klimt.1015granger.net>
 <166665500851.12462.15192873887843652314@noble.neil.brown.name>
 <4099E49B-869F-4E90-AAC9-0D02D76A9DE0@oracle.com>
 <166665971504.12462.13469404534446502129@noble.neil.brown.name>
In-Reply-To: <166665971504.12462.13469404534446502129@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5362:EE_
x-ms-office365-filtering-correlation-id: 73f47727-b8dc-4e26-1c81-08dab6aa2ce0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4NMbQolKPkxq7zR44a04tLU2DnkXlP9gqQ9Qms7QittS4frf9R3pWKNJ4MedX0tOxX20L6exdnvlwOYAgrqs7QpNof6+xXMQ5M062PludHOpbXCIKptS9SieyUZNQkMHVXcaYlob4qAOPO2iP4LB7NYSwtmfL3tbPtGzrHOx/AB+xyJhisPmvRbstTWXMsUGYg00BD/yJWEnx/WRsl/7bzjIvAWb0Pd4z0z3kImwN7+TdCElgLnlZyuK2rOiimlvribHgwO0pOvq2b/FwYm1RAxLu+4qoFvHLzbsPyvwUy1zVIYik5a1A71wT0CYm9KorqC6Y6i+O5AzL8BFBnns+H30v9wDgEesoogn5faH5GyWLO7dz15bibOhlBd9mPxQrQ20CZzBYX47Evrx5oinYXzpy5TfJmrBJl6lVl4laldEj3J3viNU8UK+Y9FJ7cJYL0kdpn5Gj3fQ6cGEqSRYzbiPfaj5PKUomn01zMLpcen1tMEgStCfkdblEkY3B3A+dXIxGFvlnlI3TwIGB5hMymMf5tr/dQOr2MXHHJ3Caqi9hV3YEZk/jBC48NOQRBCTwF8HfQoMP+Eu5bsu2lfWVbkK4WVsL8KFd3IKyrqcYnwokTvj1mWk7vH3jEyLI5m5vCUI8jJd3KjznrwTz+mU9xkNnZEszRUJSwFFwTj9an3Z6SxMs5ESO1sufxZIcjYsFRtuvlnFico47ExbR114y/lZCq867UBBiw9HLh7a85qUg18j/kT+QlVbKImPPqEakWsk8ANC2909w95k1e2l26PV/nz2/K1ANfxeeH13IAk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199015)(36756003)(33656002)(5660300002)(6486002)(71200400001)(8936002)(38070700005)(478600001)(91956017)(8676002)(316002)(4326008)(2906002)(122000001)(38100700002)(86362001)(6506007)(186003)(2616005)(26005)(6512007)(53546011)(6916009)(41300700001)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rt85jF7QNFbEfcx6cMSBEFiCpa//1gPLIZYAeqXHj0LGrY8MLQjoArTpNvzn?=
 =?us-ascii?Q?ejLa8/1/+roNKoUdVnx7E8HdvKbmqa/ylQ62tKrfp0FKH+wkfJt9ie0+jQD8?=
 =?us-ascii?Q?7k72p+QqOuWeU6OvFqJUxvmQ0w8Rf/OCoKXq/VVFvm526Px/Zyl90Hyxp/Jb?=
 =?us-ascii?Q?xDTtQV+SfYhG9YPmtxhzAG07VNvgQTHI3/l3I3xLA9ZXRUJ1Q/k5x9bFej2g?=
 =?us-ascii?Q?atiksithlze4QMbU3AmvoN/24TJjoOTrhCCplQBw3IdkRvx/b13ZTeW2Ifw7?=
 =?us-ascii?Q?Kyja9T/biRZkEBZCUrEOEXTEOag0HD84AjSJuoZE0zn/OmVuDynGdQ6IAbwI?=
 =?us-ascii?Q?ayX0org5N2lFY0JEw7Khul+GqsvktgIpgHPBwZpSNPDvz213q73vdmOXwaLf?=
 =?us-ascii?Q?mpZKaJOm366ICEbumU7d6oUNui8bBUYFZ579XoGWtTCKX//l3hpnNCjJXNHj?=
 =?us-ascii?Q?GpHLCvq5C03G/pCU+ZDu3+Cjw0/xcoH1LkHIKjuoEc9spvYymvhcgmr9uKhf?=
 =?us-ascii?Q?/jjP2V96z7t2KFa2uvxqlyNOjuzXdYAoIL3YLnxhXUADxMqAFDTPyGKJI3S6?=
 =?us-ascii?Q?YNrJbx72EKGslnxNvdSYYRyVBoqSLtRzt3PXyPvS4bis9NXD70iQQ6aXGBhz?=
 =?us-ascii?Q?y8oIy8J/USxMAPJSalNFBMlIk3UjuewleKJUgO1aox3PlqRUEQu5mBdDRgXQ?=
 =?us-ascii?Q?K/k/czn3opFS+S1UdWwJg8v3tQfz6sXp5oJ/BOT7NF5VuzO+0S+WL+hi7t9F?=
 =?us-ascii?Q?CmkFX3LAjov4wFvCjEAq5hWzf5oDjwdTZIRhUS9pLKgqHv3zOnirEJNaO2B4?=
 =?us-ascii?Q?FYHy/H3rVkyGAAMf0+vGjkBn1M1XiTctg2qsu/S6rJyenzZ2b4sMFOL9ZuHn?=
 =?us-ascii?Q?TAf7ZUS4kuDj3UtyBQliLglfH3LZ2nvJGoIAq8ZN4n7ZPcCxfNkp7MRWmpbk?=
 =?us-ascii?Q?F1uaTmguhckGefkaY1yid8GbMCMVRFXoK15Bcf3UJFyIx3tufapt1uBleoSB?=
 =?us-ascii?Q?7BUJxdPpHtCAvrkrtKtBAnOGTaiWU+nRuJLR8UFM+pFuZx1bmnGHyRgdL+89?=
 =?us-ascii?Q?g7qDVbkArsRNb/BLNh41yohDWy8ub/OsRzdvWviFKt7oy1vV0h5y5BjpsXsM?=
 =?us-ascii?Q?QwAAcercCpdCBoji7NkmEbYW6fTBeX1Oxc0r8L8DH3zsF7djK6UpMGyvpfSG?=
 =?us-ascii?Q?O7k3sG7/+cs1H0uxbQ74yzOoPAaqBMmZCwp6ueFQMKWBKrYh87Sy1H2Lchqy?=
 =?us-ascii?Q?l68grnAy2KtFjFEwsTp0dnK4CFfXfcXdhd5t/qIoz9+nwoYFzvnZtr9jEAKJ?=
 =?us-ascii?Q?L735XtAafJyKitx+ei6sEewsWm7fcx9i9P6W6QONffTZgWiNFxhWkqfcNTnL?=
 =?us-ascii?Q?7RFA6LW8ZqLoWwOK+GXnzg/UirYL+t2GK4oQkj+ddUBIv7F2mM0mkdL9ooMf?=
 =?us-ascii?Q?S2YNN7PERFu/08y3uE9IIYsoVW5qeyuTQsxbIVuK6JXAk5qRbpes46uF2/au?=
 =?us-ascii?Q?puRSsoDwYYsE3JSw5XpemyDxDFuTSt567eK62iWyfnMG1s8O2zdED+Fqu6nm?=
 =?us-ascii?Q?3G53rrq9AKx3KCTl4aY/jpn3prGD/OYfDk26lKrwKkb9haiFEdGW2L5sCFJg?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1ECE62B03C65B8419A277257F899D984@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f47727-b8dc-4e26-1c81-08dab6aa2ce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 16:58:43.9368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RrLgY1mGlBGTZ3vTpK8aNa2nSnOcW2NSml/BwLtZd9k5Vp90hkHHkFCuvJjhQEJJ6ohyhhxJVy18M8MD/a/Tnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5362
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_11,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=703 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250096
X-Proofpoint-ORIG-GUID: oF1vYqnfjGDkeL19mehAaU4wJHMK0DV0
X-Proofpoint-GUID: oF1vYqnfjGDkeL19mehAaU4wJHMK0DV0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 24, 2022, at 9:01 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 25 Oct 2022, Chuck Lever III wrote:
>>=20
>>> On Oct 24, 2022, at 7:43 PM, NeilBrown <neilb@suse.de> wrote:
>>=20
>>>> +	list =3D rhltable_lookup(&nfs4_file_rhltable, fhp,
>>>> +			       nfs4_file_rhash_params);
>>>> +	rhl_for_each_entry_rcu(fi, tmp, list, fi_rlist) {
>>>> 		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
>>>> 			if (refcount_inc_not_zero(&fi->fi_ref))
>>>> 				ret =3D fi;
>>>> 		} else if (d_inode(fhp->fh_dentry) =3D=3D fi->fi_inode)
>>>> 			fi->fi_aliased =3D alias_found =3D true;
>>>=20
>>> This d_inde)( =3D=3D fi->fi_inode test is no longer relevant.  Everythi=
ng in
>>> the list must have the same inode.  Best remove it.
>>=20
>> My understanding is that more than one inode can hash into one of
>> these bucket lists. I don't see how rhltable_insert() can prevent
>> that from happening, and that will certainly be true if we go back
>> to using a fixed-size table.
>=20
> With rhltable each bucket is a list of lists.  An rhlist_head contains
> two pointers.  "rhead.next" points to the next entry in the bucket which
> will have a different key (different inode in this case).  "next" points
> to the next entry with the same key - different filehandle, same inode,
> in this case.

That's the detail I didn't yet have, thanks. I will remove the extra
inode test and give it a try.


> The list you get back from rhltable_lookup() isn't the full bucket list.
> It is just the list within the bucket of all elements with the same key.


--
Chuck Lever



