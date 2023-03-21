Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC456C369B
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 17:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCUQJ5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 12:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjCUQJx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 12:09:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549A0392BD
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 09:09:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LFxCU9019619;
        Tue, 21 Mar 2023 16:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JKx2ONAUIawijOUAaHHvlUexMD6ikbkB4lOldEGogbU=;
 b=kYhOhhhMYrNBWO2aDltUDcm8/nw8EwonVHwtBfUKjoaACDtRCfOgn4EB2DzGeceHCRB6
 BMpnP3oEWRV3WqusJ040x5tjYA3LOui/Gxh8oxkao7oFmDUEGr79Dw5CXEpbTDyKIvXR
 +YGOhyC+HPkWEOZQzruLc8GacayWfaFLSVcaL3+lhCP9rTrnbUYp/sx2FVNBjAjfjj9p
 cflmYccL2QXyF6V0pvZi9oLw2wRlyMAvYMeHHlTi6ioLlrnw/SlHKibi3TQHK9VUh3x2
 n65rIn9Bb8jTMwoYoZaDiMCQWpZ2328kcBawsDyM4bNzBBZYH8ZB/S+p9LwYOXqDncnD EA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3qdpn6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 16:09:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LG9Xt4015362;
        Tue, 21 Mar 2023 16:09:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r6fwj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 16:09:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsTlWnTKLb5B07rlzyRq4dHDpwbqSVTMwXixIHeuCwhmislJhhZcMZWA2TUsEm3Wv1O26Ap09bd3krApidex2guYP9+isObUejiXKzIodMCtmtGxmsAm2sonjwAZ1TVrZ7NBxpEcl1x1udxNmOq28Oc33pw8QpUE4r6Ly+R5Xnbn8LbML9Ujh4YHe7A9RGCv9O5TR9UjLlMKLpic1l6STa8PoaQN6zjJwW/hNP+YKrBTX7uOXOjCP5FrA9cV7KWVBRnUhQSdt4ZSW25aGP+0S1nIHgC/dUxfhq5oHzZfuhYGmbsIh4YcZoddxeIlCIBUVNXQN/0AU2kof7G4uplnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKx2ONAUIawijOUAaHHvlUexMD6ikbkB4lOldEGogbU=;
 b=OwGh5DJSq7Cl2mCgPhP/TY3/6HodLfirm9ASlPUbh6qTfmKKaqti/o4B6i+YRtWE9upo9T5WiDS5BLqhIbeg6CTfPKT1gJp5NgJ0toz9n/86ItUNzr+yBLG4AkpmOkn1yvlf6rEm8Pw6RzCfykSpfkHfB3SQJY/2PUMVekEid4o0P9N+2ESBpTv4uA210V0TQrLo37cFy203aHjt6TBr4FXpJY/ECX/5d1s6VAW8lulEk/SitARHNnVoZxYQKIzSYBSMVpO+Ds9HD6zwwfRdZZEGwtsEAyShbGDFdKmH1A3sp9J1TS2GvJt3CCXpsiNNuUjbnMoK1tmStjNPOX5UtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKx2ONAUIawijOUAaHHvlUexMD6ikbkB4lOldEGogbU=;
 b=s0B/btzNgNps19BIgKVlUVaFoeya7ZMsX++aEtSRubiCsYr2qZij8JCBS60PJ+sXYBHMYogKZXjUlR7A0XMGnY7WzGUUHDXukmc/4gxLw3epX3PA8qsmhN5ofKoyps7dH4U7tRpKt+QOPBksjccqaDZ8yecWy6fh246EdVUvGQ8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7300.namprd10.prod.outlook.com (2603:10b6:8:e3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.35; Tue, 21 Mar 2023 16:09:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 16:09:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-tls-handshake@lists.linux.dev" 
        <kernel-tls-handshake@lists.linux.dev>
Subject: Re: [PATCH RFC 4/5] SUNRPC: Support TLS handshake in the server-side
 TCP socket code
Thread-Topic: [PATCH RFC 4/5] SUNRPC: Support TLS handshake in the server-side
 TCP socket code
Thread-Index: AQHZWze6raUwPVIJ30ib5xd+ODRKva8FHigAgAAnHICAAA8FAIAAFFiA
Date:   Tue, 21 Mar 2023 16:09:37 +0000
Message-ID: <CB9BF445-99C3-4EEA-9B7A-9DF4CE5659F3@oracle.com>
References: <167932094748.3131.11264549266195745851.stgit@manet.1015granger.net>
 <167932228666.3131.1680559749292527734.stgit@manet.1015granger.net>
 <55c3480354ae273fceb67976bbce33b9e04e6cf3.camel@kernel.org>
 <81A90B73-3367-4D4E-9F60-A20CF6EE6BF9@oracle.com>
 <d9b1dae62fed0f61bb48a017719f0f0114fed3c2.camel@kernel.org>
In-Reply-To: <d9b1dae62fed0f61bb48a017719f0f0114fed3c2.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB7300:EE_
x-ms-office365-filtering-correlation-id: 3bfa5109-5151-4d69-8ebf-08db2a26aba4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TUodUA0lhJ5pyRj5IyfTrUwLzQRHoMYn7KED9kyiDCYoYnLue+P3HiDzR5r2g0difVzV1ih2JEArCqMyMyLQz0Uu08R7PDJDDQxWIDG3oCDrvYRxdJ6O1O7zSnoCliUIeX/4mTR1m7GBANyL93dGzvQY0UBrkkP0AciiQdDMU9TH2skbADTyaF96U7g5b52MKGN88DVrKc9QRJxlc1zMXvWl/5c/r9e9Q3RNFqthsO+ONZyeLMbcWMv7bjegzWAK9HTCaMGxD4HpSp4jF8ZhVdv0i2YwFB66dRDwe0j6jCb8Sj14TDpt7UAXNOYHLLhifN1+QygCI8U2tMFCXC74qVnwvlodiNXRsFtNK4ClJLdzb8MPlx0szqaswv4umJ6JYxeU4xTpn1IuRnDk81rRMheb/pa+ekBTqb0y7VG0PlAN8ekqBbTXBQMZTntsZbbMBkUuqwX9ODoRazNcnfOB9ZCmsQUC9D5nLhIlIGh+e9kk7//SIUsAmX1PuHWhlvqq7mNFw58WJ+zORCYKF5u8bkRLBaAR3BheqU6dNlQpTdh96IwNambVFrd8fyvhf7EiGuJds6pQJ6+VVONr3NYocdV/8/rcl2uoup2Zvxz4RY5yCm5Ab7BN79uNnq02D2+gnB+zUi1uaVrvcopMrqFBwTki55B8oIsytqNh2tP7T3jbA4MEBQEUjiQ/9IO36tHQd/q+PVCnB5MqIyWOAx6MGN0OnOY7Ws34PbNq9VUdvdg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199018)(38070700005)(36756003)(33656002)(2906002)(122000001)(41300700001)(8936002)(5660300002)(30864003)(38100700002)(6506007)(54906003)(6512007)(53546011)(26005)(2616005)(76116006)(186003)(316002)(83380400001)(478600001)(91956017)(66446008)(8676002)(64756008)(6916009)(66556008)(66946007)(6486002)(66476007)(71200400001)(4326008)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x/0okzu/3ZcxP6az2Aknb0V5oqqxIsELW5zGDvedFOS26V+iLBbmadC0OqoU?=
 =?us-ascii?Q?R+TK2ogWezePOOzJWFf4MWVJ4Hyye1z2aU2quV9PDLQjD174NjS2MM3t7r6e?=
 =?us-ascii?Q?33cKNHRi61oBfRIUv2BIzrwtlc2EBo+t5IHnMa8ljDaxB58j8fzc3DcGCmMi?=
 =?us-ascii?Q?Eioro9z44GlGdb3OaTfDtkeZJ9v27cG/QqVcRFAdwrz2kR/urMe3uqgukyo4?=
 =?us-ascii?Q?4P1X/u8nZSM0IPbKh9YUVMQBDpOf3S0mkRN74SxvPJ3a5zxGuS4Mf5wSWmx/?=
 =?us-ascii?Q?vyw4dfucYM/uHzak2Q+Fes6zEoxmCvvt/orFQYXh4d5MMgD5RZjyR4Mr+xKX?=
 =?us-ascii?Q?QCrdKWQp/s3ilR91uCxg8h63RHsqvWaQXZCg5KfskjvRAi9WqEbHo9V3xw7e?=
 =?us-ascii?Q?j1E0XZJb2wSHrz8Fs80lYpQQYOsEo+QkrqEpMvy4k3t8J7fyrdo+sJSO/Ipo?=
 =?us-ascii?Q?eSQT97iT8XX1DePs/Sb+8AcbT8Sprml3Z4h74cgKQT4g/1bz4jn8Opx4b1ie?=
 =?us-ascii?Q?aJA49SFigY8zww5zdgElcbb7xlAYdPPm+czcCTrSJoOJGzxwfFPnJedhnwup?=
 =?us-ascii?Q?KvjO/Rui/vSTuWt88k21O8mM9670ZdZFYEnal2FemEV95ACMNZA0F4ZiPO6Q?=
 =?us-ascii?Q?XtRmjM4mG914AOo0UCzaaLw8Bh2F6plNrRZtYLr/qe3XQ9KCykOPdZfLI9j1?=
 =?us-ascii?Q?Y+BgQc3Zh78j+ooGtnREy+Dgn0b/u4+SMe99E3qS5UbLrQdzJhtw3Uc9c079?=
 =?us-ascii?Q?W0j8uQuT/SbMjtRt0uiZSSythZ73dj68/zTbe3oi3qDS0XJLFCRA06dT50GD?=
 =?us-ascii?Q?BIlknjwkYE6iYUCmvdQ7RX6ugwpkOeFTsuWLvSd6J/+WwiInfmTsgOn0w79z?=
 =?us-ascii?Q?uFvV3z3r+iFw6DlRzMNqaBSPNeHfy9y3v2fut/4H1oltI3dsHpEFZ8aF/+6S?=
 =?us-ascii?Q?ID90TIWF1oX6JO9AnZGbBS+9jxZzF+V6AnTJypYIkbrxu3GG/2F/NrTPo4tc?=
 =?us-ascii?Q?QtEIYP6BvO6ao6qFl0nbmdeLzOhVss93cH6LvBQ+gEkcZQIX9RqLKLUghWHv?=
 =?us-ascii?Q?OgTAIYF+veuSjsLGBs/dJc87xbtviU7o3MCGDONQtb3R2nsndIbb2Ojb7RbI?=
 =?us-ascii?Q?exHx7UuV/4owFuMZF1DMgsMqMxwFF94F9q90o+YUn0nrNNT+VN0ErJGE5WIO?=
 =?us-ascii?Q?Rjfdok3XR/zyqzNkS6dtqf8ygRdI9v4A4VqPs5tXcY1Hhebe1QOALgU2be7C?=
 =?us-ascii?Q?lFkVkUSPgmM4hlgTVbeSXyQhcQS+xScXY4iPkUm8GPZyYEo7NkkK5DsH8HoN?=
 =?us-ascii?Q?qN8s4dMIb/VJR0zGYcSHywGMk/5bHSRUTIpO+EATefRQxybbel76eKBZJ1Wg?=
 =?us-ascii?Q?csf3lVkwNaCMaFCq4DvHWEZEeasuc7SwnaP+97k5/pJpsSDbQEeZSXNeCp4i?=
 =?us-ascii?Q?VKBxo7c36sPaGsPNPWGZLw11vs0La2FwrFF7q1wexXgX6fTJr12BQehG/U19?=
 =?us-ascii?Q?21s2JqbQMTDB644fPSWdfYoBpj680qT1B0C85M9Ej8fNYyZb/rmzU6oOLXkU?=
 =?us-ascii?Q?FM79ewK1B5CEQmYRO/WuNqY7WKUoR5hiS6FFMh5SYvC+omk+xSuq1gLdiHJE?=
 =?us-ascii?Q?Vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <411DBBF07741A94F9C4403E10EF85623@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hdeKJiTjKHyuDpUTo2uigxfMH3DrVnyQUjQ97rLNB/uMNbjWJh0nS7FsGt+dLKe0ByUh8eW30bVhMTxgFSnSCvFbW/QAKWFNmVrW2YGAzipJayyrYoHySdI/fbJV/UoiZHuJZTfEujCOugxDYnQmrmdez8BJHAVrPKiqSBJSU63diYtB0oE6dPlOLPcoy4EP9pLYZ1NtC9SC1/0L0RQt2Dhu5kVi4VDk6PXbOmXHjuQGYNWC6dWV9eoJft1bjwA0f+GWduFC7MBgaUNMd5GOgZsPey6+4/byDX35iLB7fCPvBaZ/NUSIzTyrf7KIsWWK7ev/S7MoZTHcr55mms9d1ohloOxpomLd5+MO9C33U5F27fifV5fdfV73pRgmM2A6AYky7pp855SfXsbGiLH4b9DKHiqSeOhWt4ev6MjexyZhIn+aqdgQwTnfwq8CHRPUzn6MJZBQwwnK2YVaM8iiIGruBPNogGdFcrL7TzGl98FE42YbhKPOs9R+mkkC7mncWAh3Cy8HAdi3HuiZbdNN8zNVD5OaaDXXF4WJZlG3y3NZMTOicSphX1MLHZO7J4jFZGU5iXvg4Uk7rX3YRHbyYUU+F+RBJg0rqSnapHMz/nsbJ6fPpS4co3FggNbX1Xw93hmS+nAWekrV1Lrse5bj1Ogy0CW7gZNmQzJkS5pi5XafyjFvry9vLapskZ1vhSuTEd1ESo/LZHwOhC1yTdVTq9+WAm92EYTw6Xpq+v7G602Bd58Zi+Sx/TZs5R3v1zduCF9uPd/jrNCkKuIXScsC8KffXoiUtl/t0E8chd579kC01wc/2B/TljzJTwMO0m6Z3aYKDJRlUdiZEz7TNzjFnA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfa5109-5151-4d69-8ebf-08db2a26aba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 16:09:37.9400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qO8O1ci5nKtHnuhGp0uc+Hr5jxvMXgLdq8JvgrIFoILYpHiCGXr5nJsdBDCxXmwCsDRmtDoWj9MuDX9DnTUJPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210126
X-Proofpoint-GUID: IAjra-bzQLcT3H-UJ9rkdPvOyHMTqsUP
X-Proofpoint-ORIG-GUID: IAjra-bzQLcT3H-UJ9rkdPvOyHMTqsUP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 21, 2023, at 10:56 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2023-03-21 at 14:03 +0000, Chuck Lever III wrote:
>>=20
>>> On Mar 21, 2023, at 7:43 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> On Mon, 2023-03-20 at 10:24 -0400, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>=20
>>>> This patch adds opportunitistic RPC-with-TLS to the Linux in-kernel
>>>> NFS server. If the client requests RPC-with-TLS and the user space
>>>> handshake agent is running, the server will set up a TLS session.
>>>>=20
>>>> There are no policy settings yet. For example, the server cannot
>>>> yet require the use of RPC-with-TLS to access its data.
>>>>=20
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>> include/linux/sunrpc/svc_xprt.h |    5 ++
>>>> include/linux/sunrpc/svcsock.h  |    2 +
>>>> include/trace/events/sunrpc.h   |   16 ++++++-
>>>> net/sunrpc/svc_xprt.c           |    5 ++
>>>> net/sunrpc/svcauth_unix.c       |   11 ++++-
>>>> net/sunrpc/svcsock.c            |   91 +++++++++++++++++++++++++++++++=
++++++++
>>>> 6 files changed, 125 insertions(+), 5 deletions(-)
>>>>=20
>>>> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/sv=
c_xprt.h
>>>> index 775368802762..867479204840 100644
>>>> --- a/include/linux/sunrpc/svc_xprt.h
>>>> +++ b/include/linux/sunrpc/svc_xprt.h
>>>> @@ -27,7 +27,7 @@ struct svc_xprt_ops {
>>>> 	void		(*xpo_detach)(struct svc_xprt *);
>>>> 	void		(*xpo_free)(struct svc_xprt *);
>>>> 	void		(*xpo_kill_temp_xprt)(struct svc_xprt *);
>>>> -	void		(*xpo_start_tls)(struct svc_xprt *);
>>>> +	void		(*xpo_handshake)(struct svc_xprt *xprt);
>>>> };
>>>>=20
>>>> struct svc_xprt_class {
>>>> @@ -70,6 +70,9 @@ struct svc_xprt {
>>>> #define XPT_LOCAL	12		/* connection from loopback interface */
>>>> #define XPT_KILL_TEMP   13		/* call xpo_kill_temp_xprt before closing =
*/
>>>> #define XPT_CONG_CTRL	14		/* has congestion control */
>>>> +#define XPT_HANDSHAKE	15		/* xprt requests a handshake */
>>>> +#define XPT_TLS_SESSION	16		/* transport-layer security established *=
/
>>>> +#define XPT_PEER_AUTH	17		/* peer has been authenticated */
>>>>=20
>>>> 	struct svc_serv		*xpt_server;	/* service for transport */
>>>> 	atomic_t    	    	xpt_reserved;	/* space on outq that is rsvd */
>>>> diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svc=
sock.h
>>>> index bcc555c7ae9c..1175e1c38bac 100644
>>>> --- a/include/linux/sunrpc/svcsock.h
>>>> +++ b/include/linux/sunrpc/svcsock.h
>>>> @@ -38,6 +38,8 @@ struct svc_sock {
>>>> 	/* Number of queued send requests */
>>>> 	atomic_t		sk_sendqlen;
>>>>=20
>>>> +	struct completion	sk_handshake_done;
>>>> +
>>>> 	struct page *		sk_pages[RPCSVC_MAXPAGES];	/* received data */
>>>> };
>>>>=20
>>>> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunr=
pc.h
>>>> index cf286a0a17d0..2667a8db4811 100644
>>>> --- a/include/trace/events/sunrpc.h
>>>> +++ b/include/trace/events/sunrpc.h
>>>> @@ -1948,7 +1948,10 @@ TRACE_EVENT(svc_stats_latency,
>>>> 		{ BIT(XPT_CACHE_AUTH),		"CACHE_AUTH" },		\
>>>> 		{ BIT(XPT_LOCAL),		"LOCAL" },		\
>>>> 		{ BIT(XPT_KILL_TEMP),		"KILL_TEMP" },		\
>>>> -		{ BIT(XPT_CONG_CTRL),		"CONG_CTRL" })
>>>> +		{ BIT(XPT_CONG_CTRL),		"CONG_CTRL" },		\
>>>> +		{ BIT(XPT_HANDSHAKE),		"HANDSHAKE" },		\
>>>> +		{ BIT(XPT_TLS_SESSION),		"TLS_SESSION" },	\
>>>> +		{ BIT(XPT_PEER_AUTH),		"PEER_AUTH" })
>>>>=20
>>>> TRACE_EVENT(svc_xprt_create_err,
>>>> 	TP_PROTO(
>>>> @@ -2081,6 +2084,17 @@ DEFINE_SVC_XPRT_EVENT(close);
>>>> DEFINE_SVC_XPRT_EVENT(detach);
>>>> DEFINE_SVC_XPRT_EVENT(free);
>>>>=20
>>>> +#define DEFINE_SVC_TLS_EVENT(name) \
>>>> +	DEFINE_EVENT(svc_xprt_event, svc_tls_##name, \
>>>> +		TP_PROTO(const struct svc_xprt *xprt), \
>>>> +		TP_ARGS(xprt))
>>>> +
>>>> +DEFINE_SVC_TLS_EVENT(start);
>>>> +DEFINE_SVC_TLS_EVENT(upcall);
>>>> +DEFINE_SVC_TLS_EVENT(unavailable);
>>>> +DEFINE_SVC_TLS_EVENT(not_started);
>>>> +DEFINE_SVC_TLS_EVENT(timed_out);
>>>> +
>>>> TRACE_EVENT(svc_xprt_accept,
>>>> 	TP_PROTO(
>>>> 		const struct svc_xprt *xprt,
>>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>>> index ba629297da4e..b68c04dbf876 100644
>>>> --- a/net/sunrpc/svc_xprt.c
>>>> +++ b/net/sunrpc/svc_xprt.c
>>>> @@ -427,7 +427,7 @@ static bool svc_xprt_ready(struct svc_xprt *xprt)
>>>>=20
>>>> 	if (xpt_flags & BIT(XPT_BUSY))
>>>> 		return false;
>>>> -	if (xpt_flags & (BIT(XPT_CONN) | BIT(XPT_CLOSE)))
>>>> +	if (xpt_flags & (BIT(XPT_CONN) | BIT(XPT_CLOSE) | BIT(XPT_HANDSHAKE)=
))
>>>> 		return true;
>>>> 	if (xpt_flags & (BIT(XPT_DATA) | BIT(XPT_DEFERRED))) {
>>>> 		if (xprt->xpt_ops->xpo_has_wspace(xprt) &&
>>>> @@ -829,6 +829,9 @@ static int svc_handle_xprt(struct svc_rqst *rqstp,=
 struct svc_xprt *xprt)
>>>> 			module_put(xprt->xpt_class->xcl_owner);
>>>> 		}
>>>> 		svc_xprt_received(xprt);
>>>> +	} else if (test_bit(XPT_HANDSHAKE, &xprt->xpt_flags)) {
>>>> +		xprt->xpt_ops->xpo_handshake(xprt);
>>>> +		svc_xprt_received(xprt);
>>>> 	} else if (svc_xprt_reserve_slot(rqstp, xprt)) {
>>>> 		/* XPT_DATA|XPT_DEFERRED case: */
>>>> 		dprintk("svc: server %p, pool %u, transport %p, inuse=3D%d\n",
>>>> diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
>>>> index 983c5891cb56..374995201df4 100644
>>>> --- a/net/sunrpc/svcauth_unix.c
>>>> +++ b/net/sunrpc/svcauth_unix.c
>>>> @@ -17,8 +17,9 @@
>>>> #include <net/ipv6.h>
>>>> #include <linux/kernel.h>
>>>> #include <linux/user_namespace.h>
>>>> -#define RPCDBG_FACILITY	RPCDBG_AUTH
>>>> +#include <trace/events/sunrpc.h>
>>>>=20
>>>> +#define RPCDBG_FACILITY	RPCDBG_AUTH
>>>>=20
>>>> #include "netns.h"
>>>>=20
>>>> @@ -823,6 +824,7 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
>>>> {
>>>> 	struct xdr_stream *xdr =3D &rqstp->rq_arg_stream;
>>>> 	struct svc_cred	*cred =3D &rqstp->rq_cred;
>>>> +	struct svc_xprt *xprt =3D rqstp->rq_xprt;
>>>> 	u32 flavor, len;
>>>> 	void *body;
>>>> 	__be32 *p;
>>>> @@ -856,14 +858,19 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
>>>> 	if (cred->cr_group_info =3D=3D NULL)
>>>> 		return SVC_CLOSE;
>>>>=20
>>>> -	if (rqstp->rq_xprt->xpt_ops->xpo_start_tls) {
>>>> +	if (xprt->xpt_ops->xpo_handshake) {
>>>> 		p =3D xdr_reserve_space(&rqstp->rq_res_stream, XDR_UNIT * 2 + 8);
>>>> 		if (!p)
>>>> 			return SVC_CLOSE;
>>>> +		trace_svc_tls_start(xprt);
>>>> 		*p++ =3D rpc_auth_null;
>>>> 		*p++ =3D cpu_to_be32(8);
>>>> 		memcpy(p, "STARTTLS", 8);
>>>> +
>>>> +		set_bit(XPT_HANDSHAKE, &xprt->xpt_flags);
>>>> +		svc_xprt_enqueue(xprt);
>>>> 	} else {
>>>> +		trace_svc_tls_unavailable(xprt);
>>>> 		if (xdr_stream_encode_opaque_auth(&rqstp->rq_res_stream,
>>>> 						  RPC_AUTH_NULL, NULL, 0) < 0)
>>>> 			return SVC_CLOSE;
>>>> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
>>>> index b6df73cb706a..16ba8d6ab20e 100644
>>>> --- a/net/sunrpc/svcsock.c
>>>> +++ b/net/sunrpc/svcsock.c
>>>> @@ -44,9 +44,11 @@
>>>> #include <net/tcp.h>
>>>> #include <net/tcp_states.h>
>>>> #include <net/tls.h>
>>>> +#include <net/handshake.h>
>>>> #include <linux/uaccess.h>
>>>> #include <linux/highmem.h>
>>>> #include <asm/ioctls.h>
>>>> +#include <linux/key.h>
>>>>=20
>>>> #include <linux/sunrpc/types.h>
>>>> #include <linux/sunrpc/clnt.h>
>>>> @@ -64,6 +66,7 @@
>>>>=20
>>>> #define RPCDBG_FACILITY	RPCDBG_SVCXPRT
>>>>=20
>>>> +#define SVC_HANDSHAKE_TO	(20U * HZ)
>>>>=20
>>>> static struct svc_sock *svc_setup_socket(struct svc_serv *, struct soc=
ket *,
>>>> 					 int flags);
>>>> @@ -360,6 +363,8 @@ static void svc_data_ready(struct sock *sk)
>>>> 		rmb();
>>>> 		svsk->sk_odata(sk);
>>>> 		trace_svcsock_data_ready(&svsk->sk_xprt, 0);
>>>> +		if (test_bit(XPT_HANDSHAKE, &svsk->sk_xprt.xpt_flags))
>>>> +			return;
>>>> 		if (!test_and_set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags))
>>>> 			svc_xprt_enqueue(&svsk->sk_xprt);
>>>> 	}
>>>> @@ -397,6 +402,89 @@ static void svc_tcp_kill_temp_xprt(struct svc_xpr=
t *xprt)
>>>> 	sock_no_linger(svsk->sk_sock->sk);
>>>> }
>>>>=20
>>>> +/**
>>>> + * svc_tcp_handshake_done - Handshake completion handler
>>>> + * @data: address of xprt to wake
>>>> + * @status: status of handshake
>>>> + * @peerid: serial number of key containing the remote peer's identit=
y
>>>> + *
>>>> + * If a security policy is specified as an export option, we don't
>>>> + * have a specific export here to check. So we set a "TLS session
>>>> + * is present" flag on the xprt and let an upper layer enforce local
>>>> + * security policy.
>>>> + */
>>>> +static void svc_tcp_handshake_done(void *data, int status, key_serial=
_t peerid)
>>>> +{
>>>> +	struct svc_xprt *xprt =3D data;
>>>> +	struct svc_sock *svsk =3D container_of(xprt, struct svc_sock, sk_xpr=
t);
>>>> +
>>>> +	if (!status) {
>>>> +		if (peerid !=3D TLS_NO_PEERID)
>>>> +			set_bit(XPT_PEER_AUTH, &xprt->xpt_flags);
>>>> +		set_bit(XPT_TLS_SESSION, &xprt->xpt_flags);
>>>> +	}
>>>> +	clear_bit(XPT_HANDSHAKE, &xprt->xpt_flags);
>>>> +	complete_all(&svsk->sk_handshake_done);
>>>> +}
>>>> +
>>>> +/**
>>>> + * svc_tcp_handshake - Perform a transport-layer security handshake
>>>> + * @xprt: connected transport endpoint
>>>> + *
>>>> + */
>>>> +static void svc_tcp_handshake(struct svc_xprt *xprt)
>>>> +{
>>>> +	struct svc_sock *svsk =3D container_of(xprt, struct svc_sock, sk_xpr=
t);
>>>> +	struct tls_handshake_args args =3D {
>>>> +		.ta_sock	=3D svsk->sk_sock,
>>>> +		.ta_done	=3D svc_tcp_handshake_done,
>>>> +		.ta_data	=3D xprt,
>>>> +	};
>>>> +	int ret;
>>>> +
>>>> +	trace_svc_tls_upcall(xprt);
>>>> +
>>>> +	clear_bit(XPT_TLS_SESSION, &xprt->xpt_flags);
>>>> +	init_completion(&svsk->sk_handshake_done);
>>>> +	smp_wmb();
>>>> +
>>>> +	ret =3D tls_server_hello_x509(&args, GFP_KERNEL);
>>>> +	if (ret) {
>>>> +		trace_svc_tls_not_started(xprt);
>>>> +		goto out_failed;
>>>> +	}
>>>> +
>>>> +	ret =3D wait_for_completion_interruptible_timeout(&svsk->sk_handshak=
e_done,
>>>> +							SVC_HANDSHAKE_TO);
>>>=20
>>> Just curious: is this 20s timeout mandated by the spec?
>>=20
>> The spec doesn't mandate a timeout. I simply wanted
>> to guarantee forward progress.
>>=20
>>=20
>>> It seems like a long time to block a kernel thread if so.
>>=20
>> It's about the same as the client side timeout, fwiw.
>>=20
>>=20
>>> Do we need to be concerned
>>> with DoS attacks here? Could a client initiate handshakes and then stop
>>> communicating, forcing the server to tie up threads with these 20s
>>> waits?
>>=20
>> I think a malicious client can do all kinds of similar things
>> already. Do you have a particular timeout value in mind, or
>> is there some other mechanism we can use to better bullet-
>> proof this aspect of the handshake? I'm open to suggestion.
>>=20
>=20
> I don't have any suggestions, just trying to speculate about ways this
> could break. The only alternative I could see would be to defer the
> connection somehow until the reply comes in so that the thread can do
> other stuff in the meantime.

The server has a deferral mechanism, funnily enough. ;-) But
we could also just use a system workqueue.

Note that the handshake upcall mechanism itself has a limit
on the concurrent number of pending handshakes it will allow.
That might be enough to prevent a DoS.


> That's something we can potentially add
> later if we decide it's necessary though.

I shortened the timeout and added a comment suggesting this
as future work.


>>>> +	if (ret <=3D 0) {
>>>> +		if (tls_handshake_cancel(svsk->sk_sock)) {
>>>> +			trace_svc_tls_timed_out(xprt);
>>>> +			goto out_close;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags)) {
>>>> +		trace_svc_tls_unavailable(xprt);
>>>> +		goto out_close;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * Mark the transport ready in case the remote sent RPC
>>>> +	 * traffic before the kernel received the handshake
>>>> +	 * completion downcall.
>>>> +	 */
>>>> +	set_bit(XPT_DATA, &xprt->xpt_flags);
>>>> +	svc_xprt_enqueue(xprt);
>>>> +	return;
>>>> +
>>>> +out_close:
>>>> +	set_bit(XPT_CLOSE, &xprt->xpt_flags);
>>>> +out_failed:
>>>> +	clear_bit(XPT_HANDSHAKE, &xprt->xpt_flags);
>>>> +	set_bit(XPT_DATA, &xprt->xpt_flags);
>>>> +	svc_xprt_enqueue(xprt);
>>>> +}
>>>> +
>>>> /*
>>>> * See net/ipv6/ip_sockglue.c : ip_cmsg_recv_pktinfo
>>>> */
>>>> @@ -1260,6 +1348,7 @@ static const struct svc_xprt_ops svc_tcp_ops =3D=
 {
>>>> 	.xpo_has_wspace =3D svc_tcp_has_wspace,
>>>> 	.xpo_accept =3D svc_tcp_accept,
>>>> 	.xpo_kill_temp_xprt =3D svc_tcp_kill_temp_xprt,
>>>> +	.xpo_handshake =3D svc_tcp_handshake,
>>>> };
>>>>=20
>>>> static struct svc_xprt_class svc_tcp_class =3D {
>>>> @@ -1584,6 +1673,8 @@ static void svc_sock_free(struct svc_xprt *xprt)
>>>> {
>>>> 	struct svc_sock *svsk =3D container_of(xprt, struct svc_sock, sk_xprt=
);
>>>>=20
>>>> +	tls_handshake_cancel(svsk->sk_sock);
>>>> +
>>>> 	if (svsk->sk_sock->file)
>>>> 		sockfd_put(svsk->sk_sock);
>>>> 	else
>>>>=20
>>>>=20
>>>=20
>>> --=20
>>> Jeff Layton <jlayton@kernel.org>
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever


