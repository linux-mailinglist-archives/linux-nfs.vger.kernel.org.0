Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C724769791
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 15:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjGaN1h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 09:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjGaN1f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 09:27:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747211BC6
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jul 2023 06:27:08 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDNLHe026358;
        Mon, 31 Jul 2023 13:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ps5MOa5gi6wHvNIzelcUUAOIbFwsFF+w2WFoh91jV3w=;
 b=nQ1ED7S8rEYv4fsxxeBiFUn40BbbT+CJjgLNVYxU+rIByx0YR/0uQgZWn4JlBnjKzfPn
 oaY4N1n7N3XQvAdB/rm1FjCLKkt2B0g1U/0Qc6jqYDXQnxHrdbkXE3XBWvLG+qXaINfH
 OLvql+qPAaP5eY7bGwghp6ZySaH6pGnVB9jvwEXnAdk6oA07tRddfsrUwiCEdZNtignM
 VHCyPNKSzztY9kBA/L5072FEyKY8JK7Q0eTbt1E7KK0QoZ7GMKYtfydop5i9rGvr08bh
 S/Oj7I+ewpQF8N3ZmZ5+O9oTJcfn/Li49Zf0WogB8fWalrnOzTVajQscfxBBFqkSCAmR Qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uauth30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 13:26:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDEj0T008653;
        Mon, 31 Jul 2023 13:26:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7b2ckm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 13:26:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrqDCaRidg2p8Qa+8kGCS/z/Y+9O/vgVzKVCvqAFkDUm/RY7SGfQHXDykLzXYGKsFZsv9UU6xcAdMi+63NbFDR3oZc/+zIHZcw8tbt77ee0BO/tuSI6Fi2/hrbnxi2WVGeRaA7xqfeQUpAy7Eoccb5Cl7r5eZoZD1jl97HIUFbbn1VabVAY2YZpYzLdfuTiy11kPzhMLTSMa9AJGHrtkHwXRzTWXdOQtAl4d5hPuUd7lNqcsDO38ceHzmGA86USgtIDoT5ZwzTUJBKW+L7U7MJF8MfDj3Sg+tlLUrAJpg/QWC6Tnx/ptdIPTvIDXp4s1BjtNn6iIIbH/3jc9T8kQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ps5MOa5gi6wHvNIzelcUUAOIbFwsFF+w2WFoh91jV3w=;
 b=CWeeRmSyQIwHJ4Ws8Jai3EOkSDrMjmaGyMEwXCtYAyiRK2wGmISptMV1lwp5r9V0+sWu9wwuseluaL+S/0BsHtp7u+U3UNX0+tEdB5LSiBh50SSL42Ss/XSls6UUiNYqa6f8MLctkQVlZxgXisAha6WyhbeQ/TxaL7Q7xd/f5uxhUgbyGSx3wIIXV4SgqV2pc4HTkeJAvPNPkCvXCPVMLyGEOsDqBcT7MLUTT/wkq86YPzO5SDNdrCWgQ22dBQUYXL9ZSiqHk0MzH0MVc89JhDbLVy+GgVFZB4kjlek0nbUMUZOryMMeeu0xpxLyzbczeioPz3pUvvvlIMkTahZqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ps5MOa5gi6wHvNIzelcUUAOIbFwsFF+w2WFoh91jV3w=;
 b=VvPk40NjAccEkE7v428VlkHfAXHxcuww0DfEnETIzDFYZBOPkDQsOi3WMlYb1FS0B+ZId0MMA5FmWw92H3Z2/KylNF6CBPxcYzmeVhmvvRATsAyrduGRMkI9X6bL6EXoMvgXqmc/wxPUDqRF4d+mcDITuc3Ck2mzOUd72gDdxfI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7989.namprd10.prod.outlook.com (2603:10b6:408:203::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 13:26:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 13:26:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Zhu Wang <wangzhu9@huawei.com>
CC:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH -next] exportfs: remove kernel-doc warnings in exportfs
Thread-Topic: [PATCH -next] exportfs: remove kernel-doc warnings in exportfs
Thread-Index: AQHZw6F2u0wIqvq+zEieCZdvSek2vq/T3eSA
Date:   Mon, 31 Jul 2023 13:26:24 +0000
Message-ID: <C48BDA01-2647-45F4-8980-EB4F5C2327EF@oracle.com>
References: <20230731112300.213602-1-wangzhu9@huawei.com>
In-Reply-To: <20230731112300.213602-1-wangzhu9@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|LV8PR10MB7989:EE_
x-ms-office365-filtering-correlation-id: 63107250-32ee-4c66-76b4-08db91c9bd02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WCXDVjVwQGK3vkcmWqJdPQPLN0TZ82isPlHmQFdnyb08MBodrqR0SXJHa0W8nuU+IJ8a3ASmv5uOBA8+4OZggYKta8rRL935k+u/xIF23HyTWyiUtN3rbpab1TfDEgS0T2MxdkJ4cq3pN6qX9v5Pj3taSebwmfc/XC5wWB0FF5A3f5Jftgo1V99n0cBqU9qKs66HFVHxZgt6p9wJ0D2ojr5lUsaVhAmQCbJHd84BPP+bMz73/sg1q73KPpM+QuHzBbBvgCLaCTtLe8utzhJDmuFD1quPE1MdebxXrhWJ1LsTl9jNlkFKsMU4lbNpYfDqECiLD7vqe+xtCv6cjdYvE//MF2N0tUMCue+4yKAduIPGz8urKmSl/9GN4aqSEFJfAoZjQfG0oHX28MZzsPDNGeBWsyM8eH7KbYj0kK1Qppif8azQK2xytPKIpkE26wCtOnmGDOGBZDQ57fnlMy7oX/0uidGhOZ5Pgaa7A9o4l5LILSPmDyI8hnh6fng9d3yM4fShnAfEYnQs0KYbTCuFvUuVn91ngKrGp3d/7uoaVb+Ag5UOClNQdnM0LlB9bSAW3LmQhklUjUdzz1Pe7n5K6xhnCag1FpBTIDdesyvrcCdI0Kr0sT3QUjl3RNhRTruqyt15N+hiRhQhd4cENwAFLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199021)(38100700002)(122000001)(36756003)(86362001)(33656002)(38070700005)(6512007)(478600001)(71200400001)(2616005)(6486002)(53546011)(186003)(26005)(6506007)(8936002)(8676002)(64756008)(5660300002)(91956017)(76116006)(4326008)(6916009)(66446008)(66556008)(66946007)(2906002)(66476007)(54906003)(41300700001)(4744005)(316002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jwbqx/Sb/7xJRx6LytdCSYZnvhHNfPXNbvSE6tH4ckdQs1OF1Xrz8YpQi9xX?=
 =?us-ascii?Q?OPD//NIWfb7aHp8n/r5HJGSC9+ol+9RUyAEYh3Ww/FHJntl5+951yXUs1JQc?=
 =?us-ascii?Q?HAJO+R+RaGea6FI0jWnvVdEHuvIf64lWZWUzrP8ZBsGSig7pWPWK33eown1Q?=
 =?us-ascii?Q?Ol5D2xqOdS+cbj0R2oGVxesm7VSoewKxpChjkZml11ykojySH2ODpgTaYmNW?=
 =?us-ascii?Q?M+O2REwArfbe/TKICQqndwWToElQMrfSMkmGWfbDljAm5go3K7GRqgl4JoNr?=
 =?us-ascii?Q?tOZLCM+H9IZryKup9QP7p8I3R0kIi59+r+rsJERDhVYW5ptq7YkT3NbSIcK4?=
 =?us-ascii?Q?N6GcDFtNcF1eqfsj12aLKrhqi1e+YXGX0Y3rzsiXrX51t0kKqZslcTkVtgYZ?=
 =?us-ascii?Q?k9hcEaa4h3daGgjOBOwhT1jpRqhTGl6ZvX27tJOizyR6RyhaDGORvc0fhg2K?=
 =?us-ascii?Q?1yYfXWljkD3jYVBb3G6JsIR4iX9Bjx+NlNuaUqcJoZ2Gc25QkTxmh0PRbmyD?=
 =?us-ascii?Q?e2GkFO94k3Vu2wz2ToXUHEWZiqgZfRt+SsKAnCXqfUmPjjOeCaW6V0aopsSe?=
 =?us-ascii?Q?XMxosbhrXF+QmtMhL+EGWnZ+dGKOAXESwKj7a/TyLOsQZW8bS2j7CCMafo8j?=
 =?us-ascii?Q?DTkOaJg5cBxT+26czst8xKWHjmEBIup/xinwS4DXhmnKpRSJIlEoWTyDIGsr?=
 =?us-ascii?Q?2r2zKnSHZSkXMvQCQSb3DDgejA03mb356iJ0hRsd/BoBEVI2XCEef6B8eRdC?=
 =?us-ascii?Q?rK/l2TVGNIBghqIjYk/EIfhX+Muu0s2D7oqOCFGYrbMQcYx+nLyHz9K9UAKL?=
 =?us-ascii?Q?I9sraJrFnrTLluYozw88OVT297wHF3c6bcz8jkaEfRAI/1HwO8MJy0N+YgkV?=
 =?us-ascii?Q?EkdCDCIxhzoxklG0oe0e4Xndqua1Zp0KTT7AQCaTo9UoLqSlyvibg0PLGwW/?=
 =?us-ascii?Q?AAaOWe0eS2w53KwNHdPERVLkqMqB7ugdyXhPIwABuUCi03TOTwGK5LflmF8e?=
 =?us-ascii?Q?WmbhMJrLMjOvXmBy/ebUXBtyMh774hNlD6GgTavAd7Ezm54OJ0CasCk2WZr5?=
 =?us-ascii?Q?VmH7mK9ZEdK4kd0Me1ChzIiOMvqvdzDcnvCclIJPRDKolGzQ5ZdPMoW+t84n?=
 =?us-ascii?Q?hkVd9gcvSZL0kbfuAaYSm1t7v9F1j9peXCajHprZUzI6T6qHoFJdDDY/3XKB?=
 =?us-ascii?Q?V6G+pB4c8WVBpXOxUOxyriExv5+dmaqUbZPyz1vYPZS2LXhNtBM2871lTchh?=
 =?us-ascii?Q?EaAGNg+bjCzvxEtpd7ZE3io2gV6+N97G1ziNOYt12WChqj+2NRjBWHkbKu45?=
 =?us-ascii?Q?8P4zBgJUpfNl25z5vs3Wrm5DxaCcZOeq72vvRUTM0fXVORJNI+Q77GUuRcPX?=
 =?us-ascii?Q?9ZkxD2oNJsI2HBDsBtbPx24Ojuhvh7nlY1BiuOncUEKAVvXcs5H6U8CaXw8x?=
 =?us-ascii?Q?dRqxjGWcVMx2Jc8CKgDIc5GKaiVAtVgRBFTO/qz1fkSzRZI8/bPQMziBcsdO?=
 =?us-ascii?Q?3SZYxY5SL7ndROk/TJpylAxFY5IplDQ0C4zFgLJuFnD0Flr5PC7NLJVGPX3D?=
 =?us-ascii?Q?LROlr/OWEoG1TZrhVu5ITG7C1JuMsrBfpnUvQ4S553RaBtnvncym+zY3/nVQ?=
 =?us-ascii?Q?bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8200C76947FAB441960C1989274491C9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tac9B7OWPz38y2zeS9R+nwvUEwhFYl+dSK15QbHZXAAjzRoexmL0RN5gCbtKlJm6n7TRcIGOd4qfkgPRZCXRw3qqmaU+rvmT4MuzVGo90uNuXkJ50g4A6wIWMGymARYLNlJ+AYqlgmP8AxvrvdMA8Ln1lbvNBjUudgoUJeWCtpHXgOpuHrt7DUGkrj0YNgla/Fy+zfMvtj8lS2Wrp55Ndpz6Q2qqUDtjbmIWh5pitOwT5Hyj1z91ZkCDs3mLb/8TOKuY2ePa2Okah2UX/QswkwXEky+7/qCrfN5YhiAkPgIcGqJZ6g5BoWeOr0zj6kV+DT6/9K9bn9p89Zv0mTM/cBlmZHHXRlj3Vex02zvloajllH/wsLkFD8kFnL2TJGCOis0wab++9RHh35HYzT4ENt4RFsUeuG82Xp4/yReTMr38K726e4fNUxp1lX0LtqegMgfXG+Thhl1QZeSC9wbu9pEzKFL3+8HAcSsWi3EanbvQY5pQaw57T0VBPGRYqZDxMWsLZqQuQjBybAQM813SIAorAryIzvOits19MlsdIH9h7dxC7CQ7Tx3j1oW10Q7DFfeBJFxFJBdd2fwXlZIy0tvyfyswlqceDtfweH8iDy7nIuCVuGZFeWusvgLxmWggASPS3j520Mw3s2X/ku+OYYY84lUF+nPnLbxLI9i6DNQjTQhcByDl8eSKqUUENjz1mwtXgjzyQbOPbkeyaScao8IAJcqeztwd48domhi0m/jaYQ1ChfXp2RC0gJbG7ckkyBQdX3zArJV5ARdN4b4gkDB6/Aq2u6ok6nCktsb17vgytDd4I0LEf588TDZhc69A+t03myoXnW4Mi8Ykv9cilJT5VhSif4N4Sz6Dvlzn9RZkskDcAklGbS4wEZwt7hY81RgwHtBmi+klIbVbLv1rmA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63107250-32ee-4c66-76b4-08db91c9bd02
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 13:26:24.8079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hm6LWDbpzAPkbuavLMrfDNPvTqSyv7SuaFc6Z/AqilUcr19qPyw4ByjiJz1C/oq/2QU7FgiquT68D2fIP2G7lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_06,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310120
X-Proofpoint-ORIG-GUID: yC6KP9wk7Pu_XQB2jtbJOOSWYlx8sI2_
X-Proofpoint-GUID: yC6KP9wk7Pu_XQB2jtbJOOSWYlx8sI2_
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 31, 2023, at 7:23 AM, Zhu Wang <wangzhu9@huawei.com> wrote:
>=20
> Remove kernel-doc warning in exportfs:
>=20
> fs/exportfs/expfs.c:395: warning: Function parameter or member 'parent'
> not described in 'exportfs_encode_inode_fh'
>=20
> Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
> ---
> fs/exportfs/expfs.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 40e624cf7e92..5074e29f087c 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -386,6 +386,7 @@ static int export_encode_fh(struct inode *inode, stru=
ct fid *fid,
>  * @inode:   the object to encode
>  * @fid:     where to store the file handle fragment
>  * @max_len: maximum length to store there
> + * @parent:  parent directory inode, if wanted
>  * @flags:   properties of the requested file handle
>  *
>  * Returns an enum fid_type or a negative errno.
> --=20
> 2.17.1
>=20

Applied to nfsd-next. Thanks!


--
Chuck Lever


