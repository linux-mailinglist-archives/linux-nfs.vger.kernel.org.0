Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDEA701EF4
	for <lists+linux-nfs@lfdr.de>; Sun, 14 May 2023 20:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjENSbJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 May 2023 14:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjENSbH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 May 2023 14:31:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D0E3AA0;
        Sun, 14 May 2023 11:31:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34EIHlqv002641;
        Sun, 14 May 2023 18:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0FkrBGieJCC399l8PGjZcXcldghxIFqiff1aHLKlHB0=;
 b=lkr3Ry16JC5ydkNYCX9w+dDuPc+U26JwrSldE5oDX/cKpSBGQYZQ5nv7YlYrK4PH0IEO
 qKovll9yQwi5RVcjG/l3gsVr4321HNQUShbpvZqrUzuLpgXitlv0cRPq1FdU6KKah06Q
 i2aWtLY+K67kCltfIf2BuTpiXgFQDjkK5Rhz4z8KjE5qRsn1bZebRXS1VgH5O7QODmlN
 KimG2S0GePkISO0sI14+uQzlmY9s5klsiZZohpum5VYAyDIdd9UlB8+k2kg02Mi12XnX
 6bp7hDx9kxExm7e9VG3Y44ubqByBzV+gL5ZHx0cPkYzVjVvrNlAJy3bKfi1qbMDrztxV yA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2eawj8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 May 2023 18:31:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34EH0Ao2013659;
        Sun, 14 May 2023 18:31:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj102avsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 May 2023 18:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmHzlXIc2DHDUVaMuiVi+u3LGEnT7fMhaVJyUupboyRyM5Pr4/bxMvwWw+lllHX6q0KC5EiN3SKybfbsBsSdIz5liSvnXkwUVcemG4lLQhaMd5ovUg/XDqFE58TWmbNIHD1EgMJQiTU2sHRN+CuVTsUIqjDDA5DnPsFYGsm75OyrdR96/vmJLd64w2ElXiLXEOcV5Zje0iwswBJ9kzaCPx64VijLgrjs1GhFK/fvVIjwYxO74FVwtfxmWTQUlKk3KASl2ZfPmetELXWujh8VLkC831a/gvzBEyO+3k8hXl0jfRWTG0vRcI3GNU32S/Y1qj7rGOXYORS3c42AhXAnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FkrBGieJCC399l8PGjZcXcldghxIFqiff1aHLKlHB0=;
 b=GpKZ8X0cE401DeWXT4zbhPyZI+dCCTKjiIQdkHJbaUXUgZxC8+CLtKcVygxE6TavHY11aOXnE3LZcVobGVRyVsTrYxxDzxRVxVRd1gDVj5fhGVd1KpdF7XrTvtqGcvGfs251aIv/9Mc/lQSS5e8/gtFXmaQ4ee2CJ4dSFx9/gBppMybaDJS4yi0GdnYG+SioEfh0psYhGW9jgDUup3HvBFSxPAhhvpxNIlOIdwween5+77gRHp7jWoil/kmANjR3xpvVhEbKtHbU2PymWSyaajlTYZLWW8CtcIbmbi9GOPyVLJ55S9Kx2VPc7nzVmCWPp72WTMBka6ks1BAy65YWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FkrBGieJCC399l8PGjZcXcldghxIFqiff1aHLKlHB0=;
 b=SoKSLEYfRj/7eJGOZsTOkolLpPDyF5TzpRv4GnMJ/fB0Hz7TiAwJThkxhk4p2Ap48xdYyRZbqXEk0JkkyN7U9my5BpVj8giHauDFWvvtEBHMreiIY8+ib3/C60LgXTROP1+lGKnQhR9kmR/gkgj/4M0mcNKuUzAwMAeGBOo9yMA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB7692.namprd10.prod.outlook.com (2603:10b6:a03:51a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Sun, 14 May
 2023 18:30:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6387.030; Sun, 14 May 2023
 18:30:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: Remove all occurences of strlcpy
Thread-Topic: [PATCH v2] NFSD: Remove all occurences of strlcpy
Thread-Index: AQHZhOJYGV62rs3GkUCJMHqFG7AZcq9WvaEAgAAnyoCAADM6AIAAYPYAgAGYxQCAAQhCgA==
Date:   Sun, 14 May 2023 18:30:58 +0000
Message-ID: <C065205E-54D3-4A72-94A8-EEDE948CB134@oracle.com>
References: <20230512145356.396567-1-azeemshaikh38@gmail.com>
 <109A2974-3AE0-48C6-8EE3-FADE95E8EF30@oracle.com>
 <5E054593-8995-46FF-824E-55B18BF53BE2@oracle.com>
 <CADmuW3UQ-wqobay34PY+myyk1Pr7s-cf7b-U7TUCnarEf+jsxg@mail.gmail.com>
 <A1414FC8-9CE0-4B8C-ABB1-2365E2F62B10@oracle.com>
 <CADmuW3UkNrSqwQPgZVqRc46hZPK9J6jGYNfU4iS1bQKmEib8bQ@mail.gmail.com>
In-Reply-To: <CADmuW3UkNrSqwQPgZVqRc46hZPK9J6jGYNfU4iS1bQKmEib8bQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB7692:EE_
x-ms-office365-filtering-correlation-id: 1e134934-70be-4180-01df-08db54a95cc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IYC3J8udtQJN2VB2ElBKTZXxsGsvI45q6zUpP6TwV/rXqsg2Pk9eKnNGjnXMdb3pxrKAp82g3okPgqZKYUWACr0e6u2BQ6clL64X1EcwQyNLaikLVDT07hyVq4loxhdXNJsFHsyLOjI7kQw0rZkwtlb6bZzHI3StlpPc062IbT1LEZ5isB0lmW+57Sw1CC6a5TlLwTZZk/c/rCoESDFny9Nhjr+mh29f28rAvPMY227vd7lFNM/r4EZFtZzX/a0vZGj/InXVrtfPjtGtl+BOztMkH3gXI8j+jQH+kMuUIzw54RqA6H0/7XtdCwEeGWzU2kTxjWwfbuK9TH6yRpu66/JtA5QXYcoKyzzbe0tkTiV/FCegJb5d4HHvqsADrj6jwujoMW47+Y6kIljS8WQGJK6bzPGOUbuU7SrIPpP7cynDCsXyDaIm7bdhto1JMJUfGibIIZwVhvwWytya6kOqgBU6VodXuTUIwxAvaSBU+T45ktt5IMLkmzbCXNyydaezELg6iPHPrAXyAWvMnrzu4QGpRzQCwechMrPI6iyakOFRgn6XkFe6QjPluCLFUbfdHWD/geee6jNZDHcG+JlG7GdDut/VuSJWbD9UxkdxZq0e4kaxqyqRM5XkgCUlmWwb98g7ay0PDn1EzENS9XekajpLdaKLmsmlIYh0FduaW+pr63p+9SNiO+YNQSYTMYLf93evTp82p2dXKVGf5QW7Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199021)(316002)(36756003)(64756008)(6916009)(2906002)(4326008)(66476007)(5660300002)(8676002)(8936002)(41300700001)(76116006)(66556008)(66446008)(91956017)(66946007)(86362001)(71200400001)(54906003)(478600001)(33656002)(186003)(53546011)(6512007)(26005)(966005)(6486002)(2616005)(6506007)(38070700005)(122000001)(38100700002)(156123004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1ieUPFHcrzz+eMloe8EQWDwzNBYZDE6bcUR3Hfqk1jSB8u5Dqk0umb1XOV4G?=
 =?us-ascii?Q?FbJfsLtSGS1HRXfk2Vg3o7YdKbRl6tt5iSDt82OXopHwk/Kk1JtLAG07MJ5f?=
 =?us-ascii?Q?m+FxnXX0wjzIVc40ALXViLDQPpZzHOLGgx+lL76aCE//BmWrWnVAF8wjvi+q?=
 =?us-ascii?Q?VHfo2ccCIzs5CSoTQQ1XC5HHTe2u+o1/+79EFnaCLhCD75Qi6MFVaURvg4bi?=
 =?us-ascii?Q?gFvhhiBfLQ+LND18uJSyDT+xNID+rWjjmnty5AKfpWFj889Wp2GUqrqdrCX/?=
 =?us-ascii?Q?TDndkh+cbEt64GLshHCotDeKhUsQUmEmRPNoqXBVm4sCz+tF2FkUar7Jjwjp?=
 =?us-ascii?Q?lcICP2U/YANKAjqLuO3pgh9oQccnvBiztVSCkI6t59ql66dxeMnW3uTOCLY3?=
 =?us-ascii?Q?qh5c1DUUtel19LqWP6iFxq/A8mXBEXCrc0L2yqYU73tGDnlAsN171zWE/o0m?=
 =?us-ascii?Q?x6Qf3sZigH8kINH2BGpWstJPuh1IXLnUk8e76goc5KFVL77YgTTyukkeeANo?=
 =?us-ascii?Q?h8mbrpVBvfhd0WeCRF45geBQ/EbcghcatCwjfKruCsdAUYOT055o30qlfFed?=
 =?us-ascii?Q?6ZDdX+/J90ZvTlZPwVv8E1j9ZmWJjjoHZlfntV3aj3aCXZaFxY4yKBgVEWBd?=
 =?us-ascii?Q?JxDx2aUZcOlRkrIIoqxMtk52YqaXx7M3NH5AF3Vpv3kcc2I0nRZebo0+bKvO?=
 =?us-ascii?Q?TOMqUfQD9PG8OgRwSpRi+AqUoOPKLWhVQvB3mBSBD6BC0Q7j6FE8DX5VHrfd?=
 =?us-ascii?Q?eyeYx1EvJkHnsiKuTSw4CS5eSTsBCfVWDjyh5jaSX/GWzko4NdESQ60jd2cM?=
 =?us-ascii?Q?eCtqfcpj3+ya599m61W4ajlxB9vG+3I8LrmtFCymOTT7bhpbBk9E8TKMrHbv?=
 =?us-ascii?Q?TYWv2jilDs2qSFjGuSgA9f9vo8dcFC1tpQtRmORmuVlAAYNe/aYBC1tzjhyo?=
 =?us-ascii?Q?2IGGLenWWLR8lzdVtGNVJU3sCrqVKiJTKPebrOvvpjw/tODnQuqu5TGocVZl?=
 =?us-ascii?Q?MiYctFkeATZmCMmtAbmyVEj+j+B8YJ3CplKb8IUsnTMARzQLLvxFD+vd8Ssz?=
 =?us-ascii?Q?Pb4iWKbwGDFLGGUhiH/1BmA6MEWIwRS9h5yWYkpMe160IYJJZm0lb7Adw4oQ?=
 =?us-ascii?Q?FRUR7HSlhR7L/1pOvztRdbgyyQVvI7bIwtpsevjLytDT24XEFk2dpXpu/1YZ?=
 =?us-ascii?Q?pbZQgRttagca/gaoFYbPUzzh7T29s8pnRvkjvj/zib06+ddgS0Db5Gm0CQIs?=
 =?us-ascii?Q?7XWnDNP3pLbH3O/oBEKQaMxiyUYR0G9MRaKGMFi/opt4iSY5lHWjgOPnebUi?=
 =?us-ascii?Q?ARMcI2+vSfKqWfqA1fggu3BS+G+5piXSH9DUCZfI9Jx8LCuSv9RS8zR+T4PA?=
 =?us-ascii?Q?hHd/7/H4ZiPEiya1z/RYHus1R5MEy6VEv+I9lXCBVNGAYN3IliVMJh9CCHUc?=
 =?us-ascii?Q?pJFcc9CNSjIITWusJhQxzYK+T7ULXnNnjYb9n4lWE/GgJGAn2sPWUAssWM1R?=
 =?us-ascii?Q?X/TxNkVVPtp9IbyE4InzehP5+Kltek8CpvGS/vWm9ZyfSVoog9t6PcnpKJfE?=
 =?us-ascii?Q?AIDNhi6RZtQ3i3hKDSC49TWZz0f+yJY1UEE4r5kDBsMYB1XFPyAQlBlnP5b+?=
 =?us-ascii?Q?8g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0A670862056FFF4DA63A2409169EC16B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l8KtGEkt2GRR4/oK6IE0CrLEmwmvxSgpBRyOKyIt1c0YkDqE0qufR4kLxBTBkg9KyDsmv05a4BfYyhMGbfbXp7fwf9Ed4o7IsGL8XboKEc/T1MJRJmVzt3rvUfRW/srcht7xMcSMvdOq7QslKjxfVDU3+zvpMGRg8KPYL1EW96sPSPsmSA0oEg08o+u7V7TMC/r2aPXvKw4O/LbpNh8cZmkcCcgABaRbqpRLSkXBAJI41m7rHEg/3HHD+F1eNYjBc8WQckjw82fC12bxWnURvG5VeI3J5vvuk33tRZ84/x9maue69xVnJ5Tz7urU80o7nRPP5XhflybGVbF2SskVeWAyyM+Cio1gRpCY5NtHQP0M5TunPu1sLEgSTTpU5/OKxdStIBbIDznZBRFFkXjvBcfxcZ5WtV96JztNwJmIFcxikJSfceKB5Df8cBz+KNoqfXNQzPQkRAmgDRMegErKKbaqKFkdl2jIZPAX/qU4ccZpcM/Vr84dcCmeFpzyQayFkb2di7INqgVowLW4owk7E5n9dSlhpMgjeDX3PUXbuN8wttVS2NlQa4lXRU2oMur41A8Y0cDaOT/bBEz0ionkfn+44xMNqbM6oLMoDG2BuYoOTeSjiSTX4oo3Ue3BOTn1DNKMAJKTp15r+oEi2VBvbw8u9JLogu8y8MPjrU2zQhQuodSrYSe+deyaZwe0+8J10DRswViyhhEF8uSy99jOloFybk1yRtxCXo2eSBqcsqm14KeiUfbEdHFGyCS95zODvB7J1kEEXThFBaJweE16jS4XkqtgRBfZPb4425JeGeBuguDq74JU6S0nPLgwuTJobaDgbx6whPlnSRZt8rxMFHDmB5/38/kRMbunKOucZ28=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e134934-70be-4180-01df-08db54a95cc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2023 18:30:58.5528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bZXr2Mmqa5LzcWz1/uU8ALFvKL7rsoYCUkN7TgG3HD9vy/dTw9gztIXozrP0p/MC3qY8USCBH5yJYiZF5fEroQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_14,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=409 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305140171
X-Proofpoint-GUID: pbawG1gX-g8jgPPfv0PC3-BE8QO-6UGY
X-Proofpoint-ORIG-GUID: pbawG1gX-g8jgPPfv0PC3-BE8QO-6UGY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 13, 2023, at 10:44 PM, Azeem Shaikh <azeemshaikh38@gmail.com> wrot=
e:
>=20
>>> No, I plan to land this patch before attempting to fix __assign_str its=
elf.
>>> Let me know if the below description looks good to you and I'll send
>>> over a v3 patch:
>>>=20
>>> [PATCH v3] NFSD: Remove open coding of string copy
>>>=20
>>> Instead of open coding a __dynamic_array(), use the __string() and
>>> __assign_str()
>>> helper macros that exist for this kind of use case.
>>>=20
>>> Part of an effort to remove deprecated strlcpy() [1] completely from th=
e
>>> kernel[2].
>>>=20
>>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
>>> [2] https://github.com/KSPP/linux/issues/89
>>>=20
>>> Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")
>>> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
>>=20
>> This looks good to me. So you'd like me to take this through
>> the nfsd tree, possibly for 6.4-rc ?
>>=20
>=20
> This is my first week contributing to the Linux kernel so I might be
> miscommunicating :)
> By "land this patch", I meant to get this patch into to the nfsd tree.
> I'll leave it up to you when you push it through to the mainline tree.
> Although, it would be great to get this through to 6.4-rc if that's at
> all possible.

Please send v3 along, and I will apply it to nfsd-fixes.


--
Chuck Lever


