Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABFE626A78
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Nov 2022 17:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiKLQNs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 12 Nov 2022 11:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLQNr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 12 Nov 2022 11:13:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38358D4F
        for <linux-nfs@vger.kernel.org>; Sat, 12 Nov 2022 08:13:45 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ACFunbm017955;
        Sat, 12 Nov 2022 16:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9BozIqM1d3Lh+vBZNNX20woURyJ2CSUXKUu8662BgUY=;
 b=TJgspcPYR4c3kTNtiSg98OVqgZdPYRV2MVYuA0r0hXM3SDRLxUUaxu9U27P/m7k3L9zM
 e6QW+efyPzi4uvFAXWlInxyWGDjN6z5YcYLyvIy+v0Urfjnpxp3lNGnRFTia9N9NBxFo
 OBohtl+EnTmgh+DoTVpIq8BR45rooZFWmTS9dLIIISD4VLg85vaGDch0+bdhbHwvySBn
 M8C7XJdH4eRd1zoYgDYMFqoFGWqGwCAxuGb7XoDvUa0KqM9T4CJEJE0kNVD81dCWD+P1
 cVoWAAX8LlWCy7aJZhy8w3YZ6l9Rgmfxpu32cwejyahEQhGpEMLpe5YWoZIaKuWKYqRk cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ktejs80p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Nov 2022 16:13:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ACE6I6m004249;
        Sat, 12 Nov 2022 16:11:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x2fdma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Nov 2022 16:11:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCvPTlzwwidaSoTsMQgkeaycXgAnxisMxa5ckxHIdT97Fjbxl/SINVLVNOIV4cVnfQSdNTEpXD9d9tJd9/hHkyfpuynz20wfgC9Vs768htX9mIWCbLu4jcMfcmeXtd4vp+JhXtetXDVVBZQMnN1poTjo0uO7d3xEYiLzAftr56C1JpZcTaEULmU54lWbGyv9D4NcaMadLnGkSyM1SnydqLEGBorQ1aGyjWQsH0cHee3LTjoKdnJNHiGWT7R3iCqiVKPfAGaRe+HmLvsyveoQiATqwxLkp/hFiUtrym6yy8mH2AnDUITuvwJLA+OaGQ9/9nogwhWGtFtfMMoLEhKV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BozIqM1d3Lh+vBZNNX20woURyJ2CSUXKUu8662BgUY=;
 b=M/Wkll3geJrjXPDP+y1K2nGmm3KRGwYJc8WGiofeuP9kBLfQ7psM3oMLmE+SgGaHQTHyWPpgQLQWeMX5ECPWXwHx12cl6z+0kmEAgCVO0HLEo+6qmW54CrUR8gU67yPWZA5NGTu7aeXnGN8LvycpW350fNDdeyrOM7Jw2WmaKEf294kckEyRV1lvOgaich+U69BBMjJGhptkdQA6TXA3rysLnoRWVFX/+F/K3tuwWMTOwYeL+UO2a9vpdHj0no6sr+pbkpQGe9SRnKPkrlGMMk/zrhGxbdWUEAYn0cALGuatQG43Mmc/qe4uR+asIfYX7Tdf9EF4ltsGs0MOWDmGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BozIqM1d3Lh+vBZNNX20woURyJ2CSUXKUu8662BgUY=;
 b=TSzYO5bAIIWFPvc4HnhVkZQNA1i3++UX5viZdv2x1tA8YkH9MCui+WgwJDmZZawunMe7q7BeaBhUDO9Hy6y06tWYAfGeFLc89OxTvjk9sLHCVzVFpVGAskOnLuZb8AS3dNP/cUOjLqzXSxm0ISHPTuTrbTtQ8YoQiJ2rae1cdNc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB5969.namprd10.prod.outlook.com (2603:10b6:208:3ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Sat, 12 Nov
 2022 16:11:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5813.016; Sat, 12 Nov 2022
 16:11:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     yangerkun <yangerkun@huawei.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: Question about CVE-2022-43945
Thread-Topic: Question about CVE-2022-43945
Thread-Index: AQHY9lPsG7m4h0F1H0mCkh/AgNtLPK46/vqAgAB3S4A=
Date:   Sat, 12 Nov 2022 16:11:47 +0000
Message-ID: <B00F6DD5-8215-457B-A681-39D7A64B7668@oracle.com>
References: <48b858aa-028b-1f56-3740-e59eb7a5fca2@huawei.com>
 <265166ff-cd0b-ea5f-ad28-fed756dfd4ff@huawei.com>
In-Reply-To: <265166ff-cd0b-ea5f-ad28-fed756dfd4ff@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB5969:EE_
x-ms-office365-filtering-correlation-id: 0a2230c6-1fad-47fe-9614-08dac4c899c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B8sgpJHHHFvxhdDO399aFYhjMPqOag8BoWg3FF3MCNaJ+PZRGo0D01hIsayLb45GI3gfQ+t8pNxdk140arlL/AGmUCW92nGcPZqUpNVzzdF2Nm0A5B2QLeCzGmxVREHGZd9sJN4DTYSC3mpMrJkE5Jr3qSj7sWPPobr2zidiJEVTEJBpmM4zd6y95rSsoD1UcleXbOImeuJGNy0H9IhMuxP9r8HcPsnsj/B1JlastIwggDABjxgMqg36AR5MtNd7DhnpiOn3Ug7l3mDMGfjlQIKAhNp0utAAj8WKpq0e+PXNhGt0XU6r39R89ftdaVvIjA589Aa7Z/50rsteySJLkZl6esw/qPsgpQeb1849xvkIcDaC5AVvxD5Z6IcjEsiEGvxzFnsth2N3qNXiNbv3mxyTUKVGPt6WqBn9mJFGUF3uyHq+tV0kTlyNaAqDfTk4fROBbXnDcZaZhnc6jYZrXED7zaN8EjUGfhoUwHx94xAMelmmdw9ja5QsklJ24secBfGDFK9mg4sw2XjWu0utIsUAQ7tNKI5CHiWkRFjPsc0DBe0f43fbls0Srhx1LoR3TCl3hkLH4JcSvcvWS3bBAHeXHLQxSnRYPgYKNffxg3Gi3KwtKl0sIxOZeCqM4I/L7qTifmN8LdN6+QJiHArwFqDqAW8Lsc5OeuXZAhC5Qm/9g2hOKYBeysNWeETpEbm3ts9EZxxd2WzDcI3M4eOfa9NcPChHkKu186MA5zQklQATgcPAC/QpNWR6EvUalGSCOWhjqXnIGT3FgvtjV4HWa5B3uLGtnq8CZXDEnmSh0sfF4baKNp3jaUMnjAOR15uHRfs8xIcDDWjyWIQOAtGCu6dyBENkIY0qv1gE/ejWZZ9XMiLy2e7Yq47odss2wwqN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199015)(2616005)(186003)(26005)(53546011)(38100700002)(122000001)(83380400001)(6506007)(6512007)(2906002)(5660300002)(71200400001)(91956017)(66446008)(54906003)(41300700001)(478600001)(64756008)(6486002)(6916009)(316002)(66946007)(8936002)(8676002)(66476007)(66556008)(4326008)(76116006)(36756003)(33656002)(86362001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m66GFumwJpO2yBbsHb3a5sxngXAWbUHa9YV8HoD9l5FLQdUJTnrzGxGwE0A3?=
 =?us-ascii?Q?4RjtRrEw2KS+sEcUEuPOLgYru6ERiJ0iQ8+fzIaDq0mjRepAeFIcaqZeTRhh?=
 =?us-ascii?Q?DMcYtterjDiDTeb0ELsG3BWL32VpFu3CIVaWDU2X3qvQlvpOl8AkMWRalj/+?=
 =?us-ascii?Q?KpQ4XZ3AZvUZkCzcojTyG4npKd8K6jfHu+hTViZkxGQrY30ganv42ERAtsBA?=
 =?us-ascii?Q?fyBSDgsuZ8y31bQ7/SLEtArTPzlfZ1uxt32UJlzSYGssRUwhn02fT80ZpmOH?=
 =?us-ascii?Q?a9l4dPD9wpq4sbhffDIUwh5F7S8HDLLul0hEyiRbV2A9KELWNz8mvCceLZbj?=
 =?us-ascii?Q?UyBYAYwt3KUl7t0av4d9ozzWb/035cj9kabQMivT9NfW38wz1GJb1ZAItWMW?=
 =?us-ascii?Q?3G3y/INO37Z0Yaodzntlo6mttxUZR+J4UvhJiFEU9eFD0RC0UEH3iVt7X1oR?=
 =?us-ascii?Q?UkT1vDDyMFV8wBt4bdkh+jC3ndrHWKzBbEE4lyZ719SvQWxLT/lsjfyi61WR?=
 =?us-ascii?Q?mrLAAthaPOEB7i6xNNSU6XW+jbjvBmcWBycIeSdpX8TObxcmxbEk4N2s6pyU?=
 =?us-ascii?Q?5n4ytotVsDBPKSSZd1w4YIHBrNPc7X7GYM7SJXI1jxupB9G6afF9+T3NSEjA?=
 =?us-ascii?Q?u/pot3Mh/US/JZZzuCXgsB35aM+eSEJsRqtWSUanHQkXiyvz1aTkYJ57yV+x?=
 =?us-ascii?Q?fc/dKR23YWRXTdhCKYStPfYS8IgtjEO1oo2SIe4IrvjuQkODkYa2IT7PAJtx?=
 =?us-ascii?Q?8jlkNmoqZ2QD/+ltbmWTG7jnOwja5dIuCtmZp2PcT5OWuRm19sm2Hpgw3Upj?=
 =?us-ascii?Q?rsBnIiiD6UFkPn06bT/Ko3T7S8s13u4/aWWJ+BuVOQkBBx99PsV2VtW/QTVX?=
 =?us-ascii?Q?sVDirhq7YOPIR0z5rzUfIdAOlzzgmgyYruFMcUEnRODdR5iP4kkkMbu7dHEi?=
 =?us-ascii?Q?YR6wLUQGKYKsCho2JUM1H5MYW20CtTw3uegkKjsJYawEBMdYPcvmxucEz6rE?=
 =?us-ascii?Q?/apo2LXuKCwWTDIM5wXg9Lvt9fanJGZdH8HM+Aam+UaSXCt3uTXvkvTalR2U?=
 =?us-ascii?Q?wTUq+EFKog1YO/klKUWYSgTPPbQ6qdr0ra3n8jCdX/vdEIloU66QmqWhRMSX?=
 =?us-ascii?Q?TvYvsKyUNN9f64VNe7PX4ZzeBvwh43OrM/bo6HaNdthqRZ9JMzcVu0UqnbIp?=
 =?us-ascii?Q?TXj92ReN1hy5sOfQ/f8y3qQ0U1lBP3jCAmNJ6Ey6mOfXli//FYiGmb43fqmy?=
 =?us-ascii?Q?Cn0plnaOZj0mRY1RbQEaKbHwoQQxzXsR2DuICI+Xl4k+R8yAC+rFhr0Zl/+0?=
 =?us-ascii?Q?XaSXYP9IvHpczXslWYdblwSO5oLgDurTWo+l0I/qXfB0y6gmISyV2MQj4Spo?=
 =?us-ascii?Q?JTjn8VADqwYXUDuX9IbEJQRdYvOI+7sxRk3CbcilAyyns8SJM6xO10aMzLPC?=
 =?us-ascii?Q?BzNTiXCmyYHaggD185EuYEBSkWCC6f9G6aVLEtnTb/eWLWULjf5DPdvBQLPI?=
 =?us-ascii?Q?QcaSSCtY0TBCf8CwdxhC7ZbWpHZSP8QS4gDMdQgDtAWsalF8fU6jF2TkPN7e?=
 =?us-ascii?Q?znRZg/Dp5EHLXMCkXutqrBjvCoflTa+4CMkjTRaBYDXDUsdObGyEaCdQM+UL?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C82E23AA948374986C4C9AF0F9644CC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oOTDCPHGzHvQv106deZJXTy7QcHa6nZmv/t5yWgUfKmHN5S+D2pJR1KrgwF9c4SoKh4JyOmnBnKL7Oo5KwEJHr8H1qCqwF0HRqQnSf2FiyJLqpo7lIhDKzurqoqXHC4lLM081qmJ+Hox7C96QARJKu7wCZXVe1ZEGEYgukJNzehx02OoUIlEFIr3jBzo7+LJnmnGO23fNFoUjvTa4smB98rfHmiwTEJJzqpi07rEukA9lDpbiuIszyRLQ7pH7JOu6qwaStjCiwFCyyV6kc69L+wrhIPDqIYrBgV8QC8p50XaIP6Gequ+Ni2YhEtDgXHCzIunw/svEN2wnV2HG9Sm0aLcYov/ok6eyfhnz4WW+x7jyJwF++C5pg19zVXpr/Wr51Duwk2zbAjTeaYs489mzTmOPD1DAvlFxUBYh3Bof/MnlM2QhU/KCnEmBiFjk9s0MgiW6RnHJw4fzJFrM0kKm/4vOSwcy9uTxm/hpehro/pu6KT1viA1RFXhe9vRHvk2NpaoxMzVtFBgX8z6wHsmoymdiHkM8vUlpCXe96XXIN/3a0fhKfJSdjnZodVnr6Y4cVrWTHztvWum6r8bhozkfGyVRB4mKfYnO/pW3N9FYDQRpEb78dJCiSlg6SVrVfLFHZJDQ7j3oDGJ5Fdkz1qEx/QC+AFPmP7/SCGuRd0nZXllXO51z/w90Q8TG1FVz45kHDtC+Tx92yg7DJ05mOtObK5AgylkYP6hrmoiABVaL/lFfFgAY+WMCXwYRFmCDfw5FOb5R463MtF41ulMvDwQIvB+sYu3LzMWLcl+eiczO15ytEaIZv/wu89IufxGH2jA1BCH/+Z0gM2TwdEqz98pUmJZ8H+OtEIfpQPxwHjsTeo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2230c6-1fad-47fe-9614-08dac4c899c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2022 16:11:47.7760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCAujoO7+YCIPJuHD952dHBu0FEkQswibxR+VfHSqM3T/PW4/Co/WS9uGYgk+C2GTNSLIGwnBLnxCnrKsUKLUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-12_11,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=871 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211120124
X-Proofpoint-GUID: dkAGCkfd5CrOgKfGbHpTkkzDod74fgaz
X-Proofpoint-ORIG-GUID: dkAGCkfd5CrOgKfGbHpTkkzDod74fgaz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 12, 2022, at 4:04 AM, yangerkun <yangerkun@huawei.com> wrote:
>=20
> On 2022/11/12 13:01, yangerkun wrote:
>> Hi, Chuck Lever,
>> CVE-2022-43945(https://nvd.nist.gov/vuln/detail/CVE-2022-43945) describe=
 that a normal request header ended with garbage data can trigger the nfsd =
overflow since nfsd share the request and response with the same pages arra=
y.
>> It seems that the patchset(https://lore.kernel.org/linux-nfs/16620497352=
6.1435.6068003336048840051.stgit@manet.1015granger.net/T/#t) has solved NFS=
v2/NFSv3, but leave NFSv4 still vulnerably?

I asked the folks who reported this issue to check NFSv4 as well.
They were not able to exploit NFSv4 in the same way. For now we
believe this vulnerability does not impact the NFSv4 code paths.


>> Another question, for stable branch like lts-5.10, since NFSv2/NFSv3 did=
 not switch to xdr_stream, the nfs_request_too_big in nfsd_dispatch will re=
ject the request like READ/READDIR with too large request. So it seems bran=
ch without that "switch" seems ok for NFSv2/NFSv3, but NFSv3 still vulnerab=
ly. right?
>> Looking forward to your reply!
>=20
> Sorry, notice that 76ce4dcec0dc ("NFSD: Cap rsize_bop result based on sen=
d buffer size") fix same problem for NFSv4.

76ce4dcec0dc is a defensive fix. But, as I stated above, we haven't
yet found that NFSD's NFSv4 implementation is vulnerable to this
issue.


> So, for the stable branch like lts-5.10 which NFSv2/NFSv3 do not switch t=
o xdr_stream, it seems we only need 76ce4dcec0dc"NFSD: Cap rsize_bop result=
 based on send buffer size"). Right?

At this time we don't believe 76ce4dcec0dc is required. But if
you want it applied to v5.10 (or any LTS kernel) please first
test that it does not result in a regression, and then make a
request to the usual stable maintainers.


--
Chuck Lever



