Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525904C1AA5
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 19:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243566AbiBWSHQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 13:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242325AbiBWSHP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 13:07:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1500329A8
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 10:06:46 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NH81WL018646;
        Wed, 23 Feb 2022 18:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GE63H7/fGF/lmvINPeNB2dn77EyTOg2z9B7PIsFKlaI=;
 b=qnOfeZztpeyBjCCf8hpygvgo0S+UZPycyw973HfPUgfvgsbYUjXCzbVbTDob1WR4YZdN
 dPhzInFPfH4WyrJJa+Fzkt0Gjv94ksqSgCjMTrrLtCimF6FTMGwlbD682p2ZkedaOt+T
 inqE8P1dnfAzDeHfuhSSRrym4+fCh2E0lBez9lj/8CdLhPHe1Ybn8XgXCKAuVrS+W6He
 ZMyF1OjOSr81Q4qENKF3Kad11LW0tM7Rb4Vn80aSq4nKnLSj6Mm1YwqimuApTx6Rf6jK
 pKRC6d7PoJC/8UsSPK2pKax/imH1pPt2GFx08ws8c7xZHQ+9DswS5q3y4IxvX8Khr6F0 Bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ectsx53x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 18:06:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21NI0m5l071375;
        Wed, 23 Feb 2022 18:06:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3020.oracle.com with ESMTP id 3eat0pwv8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 18:06:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nH+jeIMkeoogIUU+OtMEElYCKNSdAU9znndWKegnfMgmYpw86LeL6jADqqt+j5+uTZux/XVMSTp/yFoz/8CMkJO2Dd4mP7Q7HDLfOCPfaiWTUDOOHKjRp8kNhwDIoYNpkhgFnLgPo5xP5hhzV1+VPpyZaR6UyAumyqipLHVyZYEN+xsbH7Q4u/nChIbT/P16k/8L7hd8cem+l2a44Hl+opUK1UOxfCN/dMPYQ1oYCLYdLObFo+PQsnsQ7n7J2yHKJXgM1ApBZ8yBnSGaxc1DKOXEiLAEnLoSA1bsP5tu7CRIfGgbevcFzT8onZhjNRpVKdbjCn1dhPl76B3d0jKPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GE63H7/fGF/lmvINPeNB2dn77EyTOg2z9B7PIsFKlaI=;
 b=fNMA4rN2XK6i1VFdTZ1mgRkKsPIWCnXHxwebkpaHBDVoTI2syYHZT8/pu0f9mEodQdMbUGiFUEkUjqFZA90CPqyBwFXWD2Kvx3Oyp8n4XVMMWvkvcWe/5eHnSRW9Z08pkUveg8HTqcpqfjyclGFaNWZBZN6J81T6J4I5y5F33vYRDLNIPkHlLPyGMi1Vp1LpNcL1Mp7rGCOGTlKEkXjoWe4lCS6nkEZuNq8NsW/J4fdTXZ+SfL95E8dOXGJrNZkh/QFDKlhS2OeQ6DIP/HAL0egiu6kgbVKzJH7JKK0IS74dJKKNUsah/vI3GIZdCL1hOkhhfGmp3krPsvGN+alZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GE63H7/fGF/lmvINPeNB2dn77EyTOg2z9B7PIsFKlaI=;
 b=IAPIfXu2ZOIfsvgfUJpE1Xalx5h2xQZFkSfKgcGXlh5SC6kZfpLhcpR1JhIEpbiAmW9/p21SCR+Ae0RMxXlqSGbO0Wppy7G7owB3Bepre7qokiHcEOH8+SiOCZIL9Q4vLmwQEpODttjne2W3dL96Nx9iNWqvEDxEEasweLC7JA8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2813.namprd10.prod.outlook.com (2603:10b6:805:cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 18:06:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 18:06:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Kurt Garloff <kurt@garloff.de>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
Thread-Topic: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
Thread-Index: AQHYJqo39+LyDrnueE2TsZR4Xaed/KydEsUAgAAiEoCAAImBgIAAFXKAgAOfFIA=
Date:   Wed, 23 Feb 2022 18:06:37 +0000
Message-ID: <FFD47AE3-D6B0-417F-B0CF-D89E6FDB38C5@oracle.com>
References: <50bd4b4d-3730-4048-fcce-6c79dfe70acf@garloff.de>
 <8957291b-ecd1-931e-5d0c-7ef20c401e5d@garloff.de>
 <F693AC98-DCB4-4086-AC19-EE1B71DB2551@netapp.com>
 <be851303-b1bb-7d8d-832e-a1a3db529662@garloff.de>
 <10d55787-7b97-8636-9426-73fdeda0a122@garloff.de>
In-Reply-To: <10d55787-7b97-8636-9426-73fdeda0a122@garloff.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d16c38d-fae4-477d-203b-08d9f6f73c28
x-ms-traffictypediagnostic: SN6PR10MB2813:EE_
x-microsoft-antispam-prvs: <SN6PR10MB28133BA6047C69A068F055DB933C9@SN6PR10MB2813.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jMmpxWMa/uQ1SBiC+Aj+QPCxx6Mp+lyBfu4Hf5S5xB13ZTolZPC7BZL0PtNhwYczprHDRvydf47HeNpEdC00TK4Asr2XcH18FXgN+JE4HRXgfjFckt0Xhz44uXOqXZZ5MSuAvYsMsUxFgLFz5Ws8wL2WK5PAbgCHi3AxdA7azr6TC70NIrWFMwP4ILOxZm03rASFUQJEPtapsWKXjjGOimCKqRVh01e4vqPWFJcVAOHBQAnQdcZ9SHStKm43Oj+o6LwhUwZQs3cjbxuVeL9s6SmsXUELLc4OojORPBai7fXPzz/BkhTsL4+4rnuv8v+/fcymHpwPkQnbzw2GisH1ki6LT7I+jFPk7zyouQAoC+ytgmorTquOrlF12HFXGkUZ9hgziUONYZT5e+JqRaxR+HHOosjn/AFnZJUNO/Qkx5Tge6r8VOzbWT3jCyWRBTphrMcwK1IWvhosP/ZxvObKndBmW+z4Y0zxK7WY+wCNTMZMG+8M0WsNDig45QwbkCO69fiXW/wT9+1cFHs1fImiaMPlgPUDWSTT7OcVJVFWAFQfOPywEWZqrDjVZuTUdeIGPmuCxW4lNp1Anblo/aytMr8CH+awW3dU7zONVugg0MT2qAZI0gNzXBeERDvxmY32Fvb/Psc/zIkZ+wdOCsrtC+3EvCgShZIWuISusjMQHt8qqSO1jDEOJcsZADg+/U5nMZPd696BcL+2ZhwV37TGBOB/7c3Jn8qQZDJSiTUwPXtTb8vTIsL2db93VRzIPrg6AqWXDix89Ir/YP8e9YZBcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(54906003)(33656002)(83380400001)(91956017)(110136005)(316002)(38070700005)(6506007)(66446008)(8676002)(8936002)(2616005)(2906002)(186003)(508600001)(66476007)(36756003)(6512007)(122000001)(64756008)(66946007)(6486002)(38100700002)(5660300002)(71200400001)(66556008)(53546011)(26005)(4326008)(86362001)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bg/cQ9CuRHNv1SzNfrD0GgsnTgt5oZ8CrML7sbEaGd92Z5HH0J22KSfePGKC?=
 =?us-ascii?Q?sliSIFe1k34cEsx/a4dlLQ1QSKzlY/8Id9gpycDLxt0BJhZ0ucQX7OEhakSQ?=
 =?us-ascii?Q?5jWt7c6pCfRoSUworXvt94fAin7a6mKf4XaJXsR3EtUtkKDI2gDxGkJFu5J4?=
 =?us-ascii?Q?A7rk8XFbz6/8qZ9QzThuEMjmeo29MAtZM8NVF3zcn8u1ukm1dBkDZ4gGUQQi?=
 =?us-ascii?Q?pf3FJbLMu+dIOKAIpN2UyqnLjXNwQl1wof2vaY8vvPbtDlv4UDVDcxcroV9N?=
 =?us-ascii?Q?uPg1QduepOdaddsvn/9rSOI+Bjaae+3VToz+UZDlhbfMqsVFyyRxrnLDFTMY?=
 =?us-ascii?Q?rThqH8REwJ5yPQF+6ZjhMyyYCjdggbtaV3HxV9edEMRHqe4sOVTCvlMTkyNM?=
 =?us-ascii?Q?LW9CuwT4aZPgY/6gsdQcxBYBFeYFjQ6sMh54mfPHNtqtaQ4E41FM7z3WQCCS?=
 =?us-ascii?Q?NUbuN98aXMrQoxCyTH9gv39cs7YBNtxneL90ybj1IT0V+9MaecPIwKStZf53?=
 =?us-ascii?Q?++MTJJaL/yg5OxFkvSY/vjZGHwOMphj8d5n/cs8/xjMKDU51sYAkz5qjdqcT?=
 =?us-ascii?Q?h5PBag97NxTaiINcUqr/w4VELE8FVgEsmiXqJfSfV+C9TJxRAjtQhSwfci/8?=
 =?us-ascii?Q?3r9xhNaKGvfv3sQ62gBl25kr8KQ9R+Wrj+/Fk+ggW7toS/f0WOQKVx9uMu+C?=
 =?us-ascii?Q?Z7RzFR6qmH0cSYuCwQhf8YZZ4P8k8+l3BvqoxAlL1qhG2UiQ/UikAP1OqA2a?=
 =?us-ascii?Q?lpz4R4BMLkkpzjkAzBpoWXXcqULGicKCbSaSB71Hg0mBDG88/ARksW1+NMj7?=
 =?us-ascii?Q?zVpgKwjTwdhQ1PJwAYeGvH0Wx8+jbcBjR7qInFTSHDsVabwZhDdd07Vl0OCM?=
 =?us-ascii?Q?As6nYAKkNNGFgLAJmJx+6U51UcvwJMq1tiIVQHDjVcZJALftC+CoZ2ssSkng?=
 =?us-ascii?Q?Yyg912xmwFW5FsegEU0BaiNatspWzaSL4ME5S8bl0ah01hpSJmfZDMOnOX61?=
 =?us-ascii?Q?SXAwgJe7gX+fJdDJ/KDl9nG5N1YfEKKytqyhkjGScRJ2/tfxZqlc8IkyQ+FV?=
 =?us-ascii?Q?GSsV2Gd9URol0GQcKZppvKHNB1NqdksBbZyagj8nEAD8qJbM5kR2fPtssZNB?=
 =?us-ascii?Q?GwaJ+uPUIoDlp/aw1Jsfxz7QTwbzosKhDZ99b8wjAwOadjaSuzCVucGU85Ww?=
 =?us-ascii?Q?b7qgOv6mATo8GK8qUAxEbPNu2BIhtyKPodj5+qWUftuHo+vTmhyd9W0gHBnr?=
 =?us-ascii?Q?eamkn3JOo/I+mw/KX28aJbiPu9xEl74PO/egaY4yyz3TwU6c7nPg0sLBtBmc?=
 =?us-ascii?Q?QWjNuV4vfe0WHGPKsBcR0e5aqmajRofrGTyUdLilJz0gePgkV+f+/lYmD0S/?=
 =?us-ascii?Q?wSfAwwlxzCFyYTQM/OAQG+1GMA6q8jLXzg4GIEJpGMhY+7jRYWrYy0Nddfyb?=
 =?us-ascii?Q?ivLWczJxcdhjQ1foIkkgGfRtUfRinjp5h+oWhxVPLL4Zy1mFoz6jrd74aw2D?=
 =?us-ascii?Q?wud4UlZFfhwViudF+OixNXgjkKL/lDmcC3mgbnrey8dH0Nr+7CpURaAAN5zp?=
 =?us-ascii?Q?A10cjVku023K+6+moWhs11TyIrgDGpnh+gZFX7e4ZHz7B0ogb3GXrRXVkSNS?=
 =?us-ascii?Q?DBMBeRoV/uVbSiMA0HRDUJ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF86DCB9E40BAB468D6E5CD3E0BEF658@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d16c38d-fae4-477d-203b-08d9f6f73c28
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 18:06:37.5316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odQYNpUs982RcIcuGUqLHNMAgTQX0bq33AaIfKMjy2HrFA8Bb8NyVKtiRc7/vNQsp91FOpU4GnwDHhPYjwBcgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2813
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=964 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202230103
X-Proofpoint-ORIG-GUID: HkgF05aN_zVi34WISlhWCExzfKDeSKNT
X-Proofpoint-GUID: HkgF05aN_zVi34WISlhWCExzfKDeSKNT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 21, 2022, at 5:48 AM, Kurt Garloff <kurt@garloff.de> wrote:
>=20
> Hi,
>=20
> On 21.02.22 10:31, Kurt Garloff wrote:
>> Hi Olga,
>>=20
>> On 21.02.22 02:19, Kornievskaia, Olga wrote:
>>> [...]
>>> Is it possible for you to provide a network trace?
>>=20
>> Yes.
>>=20
>> Is tcpdump what you'd like to see? wireshark's dumpcap?
>> Any NFS specific tracing tools I should be using?
>>=20
>> One trace with a working kernel and one with the broken one?
>=20
> Comparing the good and the bad trace ...
>=20
> mount -t nfs 192.168.155.74:/Public /mnt/Public
> against Qnap 4.3.4.xxx NFS v4.1 server.
>=20
> Both do:
>=20
> Establish conn
> NFS NULL (ack)
> NFS EXCHANGE_ID (4.2 -> NFS4ERR_MINOR_VERS_MISMATCH)
> Teardown and reestablish
> NFS NULL (ack)
> NFS EXCAHNGE_ID (4.1 -> ack)
> NFS EXCAHNGE_ID (4.1 -> ack)
> NFS CREATE_SESSION (ack)
> NFS RECLAIM_COMPLETE (CB_NULL, ack)
> NFS_SECINFO_NO_NAME (ack)
> NFS PUTROOTFH|GETATTR (ack)
> NFS GETATTR FH:0x62d40c52 (ack), 8 times
> NFS ACCESS FH_ -x62d40c52 (denied md xt dl, alllowed rd lu)
> NFS LOOKUP DH:0x62d40c52/Public (ack)
> NFS LOOKUP DH:0x62d40c52/Public (ack)
> NFS GETATTR FH:0x8ee88cee (ack), 3 times
>=20
>=20
> Now the differences start:
>=20
> The fixed NFS client repeatedly gets ack back, the broken NFS client gets
>=20
> NFS GETATTR FH:0x8ee88cee (NFS4ERR_DELAY), repeating forever (exp. backof=
f)

Any idea why the server is not able to respond properly to
the GETATTR request? That seems like the root of the problem.

--
Chuck Lever



