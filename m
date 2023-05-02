Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7119D6F4581
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 15:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjEBNt4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 09:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjEBNtn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 09:49:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564AD65A9
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 06:49:26 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342AKm4f009007;
        Tue, 2 May 2023 13:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NokYq5Nm/N7GtVkkQ9APoZqyn9XTFANRnfXQ83hhCgg=;
 b=jj+006oP6WZlJYOhn8HGaTepm2KJRIWDXFSP3Cy3tmY0PknDGJjqAc4wx6KIujUmSMhL
 mFs4WVUVvkBvLejc9c95zN92vdDAPvBaHAoGdgYiOSVsQ3m+X7GABYTy+whSq18watjZ
 CVREgWnpGfOoWdojUTXea9NLG9ndCuQuX0l9X1lEMz5in1YNwGrEZ6cVKR6pd+mHFUUG
 pthFuAmg5JxTOm/g7hZgUHIf92yhtY0/P0kjOwYEIYKepUxafW8Sgy56GIU81o7lXPCu
 YtMphwbgxafjZUlgWx+a4kNfxCwjGHcXfWeh+km6D7qrV8evpy4hocnQ+gkJNTSGtIeR 4Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5fmt06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 13:49:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 342ChDuV009941;
        Tue, 2 May 2023 13:49:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp68wmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 13:49:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajrwwWJSWN6QpIJUqUiRNxAkpsajD95fX9IiMZtQoGqG0KvFz3R971MzoGwP0p1eCx5a4e/z9pyt8gz+cquPoneeemUlQ2V001Acxmjgtd1r7JlmHGqLL/7mIpfnYew0YgJPZGjpkhqdypp+2Fu1hUSI0d12aEDYAnu0+bu4q+jAY/odI9rdACjxZMa6yrSAEd0yYQrJwSmgM4EU5tIuwJTVCHl7JoLBQ7++nWjwdpspYgXG5Ra5QAgdQMeG4d5Ms754arvGPyG9NgNPFgEnnmeKtBRDJ+dLenj6f6ox7CWQdaLG1btizhi7BLt6fhH4I4oo061iiC00LAZrSPRMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NokYq5Nm/N7GtVkkQ9APoZqyn9XTFANRnfXQ83hhCgg=;
 b=OygtyTcFLg7jid42gS+6XHNpvyLXpimgBhXfr+t565R+49JG3ISQ9xTBvoNem+9Igd0ZhvQ2ONSsJkBIrSKZpvoFanjVh+aYJIyOJ2WN/mNw8moL6n/KcGAnTA7o977CPi6UHycM+EppWOFxbEWUTTSqb9gJWnjiv54+i/AaPfOQXki6RUYxtBK36KXtZHxLT1ygYMxMctwFOA80VaHIzBitywNfFR4VA5VNa3rZ18Zo7X+VuAG3MEVctmXfz6y8wAg5bSEuiqKuWqKxcXm+cXDGtaq2j26xn6dbTwGSjZsnRAO8xahlihRN3B6uOI+Og1AP/N15w0+DoDK2nlis+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NokYq5Nm/N7GtVkkQ9APoZqyn9XTFANRnfXQ83hhCgg=;
 b=gtwUyx7Lz18bZP+ijsdljap/x/4JgbhvtKKb327nq3iN3CRD/LnaoWIvuePqNo4oG44mdUwvTDl/UvfUkLJb9XKxFJBXxheMLWEdBx1iqLac1H/clQlJoNnALZNZzTgoaGuZ7ejAKPhhWohA1wdscYw+zI38yZ54zqztj69+6K8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6287.namprd10.prod.outlook.com (2603:10b6:806:26d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 13:49:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 13:49:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Sherry Yang <sherry.yang@oracle.com>
Subject: Re: [PATCH] nfsd: use vfs setgid helper
Thread-Topic: [PATCH] nfsd: use vfs setgid helper
Thread-Index: AQHZfPsU0hWi9leffEW/mcTC+uI3U69G/7aA
Date:   Tue, 2 May 2023 13:49:06 +0000
Message-ID: <77C7061E-2316-4C73-89E5-7C8CA0AEB6FD@oracle.com>
References: <20230502-agenda-regeln-04d2573bd0fd@brauner>
In-Reply-To: <20230502-agenda-regeln-04d2573bd0fd@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6287:EE_
x-ms-office365-filtering-correlation-id: cedc6515-43f4-44d8-a9f2-08db4b13ff64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YrFfvym9uVTSyVGtMiMEhzuSdiy7JOy7yG47ZD7GPzJG92tTBJ6fXfJg/QEHMEWwkh57mJEMdefjANdQhiVyYRbm87CY4IpUFAUSeGTju6lz6sgWoCZCr2jfmVvj0VrlWYX7ETJDvbLtseZMJt6mGsqg5M3+It86lfcBuFqcETvCp8xFL0ZlSGCHUyhUdv9Pad9+RhxKBcCn38haCNwOXEfm0Uw29+ds9RSKnhLVS8SGZThd0K6Jb52pw3b58UN8Qa81FM/bbIRXouvErxrpdes/Acv8ZKxSMCVVfcplQb43qVugWMFTZ19aodSj/T4CwQaMM2GdoBP4pUK/LTRd13gQJRhOgMORQ/Ye50ceNvTFHNo/ullbgFdvlYvZeFyNFF6D5CavEJhdZQtNp/kfn7VVGR6EEb3BcrE/rQc/+/KD+UNsLh88shot/1YrQhhs2LEK4K3wXtv2Y7HS6/5gp8ZvgWSofodFU3MJMgdQMMXQku8+5IkcX+fu0rJHP3gdeNQTyfyBS5fXdnPyLSdFpMK508ETUpB/uQbcYG97D8WtRpF+r6BvHk3DpJTXiOOgjxEwacHCrIMpvd0luPea+TqWv+bVS/42fPJvzAOO+/Slxzq+iuON9/3sCFPr4F4TZYluhc++lLhhwCDtG5ZZww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199021)(66446008)(66556008)(66946007)(2906002)(66476007)(2616005)(86362001)(5660300002)(76116006)(64756008)(478600001)(36756003)(8936002)(41300700001)(316002)(71200400001)(8676002)(91956017)(4326008)(6916009)(33656002)(54906003)(6486002)(83380400001)(6506007)(26005)(186003)(122000001)(6512007)(53546011)(107886003)(38070700005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A77GXyAt29f6Bp76bNtuXJKg6LcDHRwVWFPxojUebfgKDu2uJMST3TLcCg7x?=
 =?us-ascii?Q?mbRFVuN4laU8ArY+xPgY+Kpy62352OFDIujLXSQV9ASng+UutXXeFTMBtp/+?=
 =?us-ascii?Q?Wx/zFOyHh393k0+QQqgSsEIkVdalLp0boqJmTr9G8mrMZEOYgsyl9idNLRHq?=
 =?us-ascii?Q?nzDjo05QWdBQMeA9v95cttxVx5Fo8CXBYQBRgfCmBDPeVLC7V7ixv/o+DJoS?=
 =?us-ascii?Q?xKJ43Tc3naozl/iPakD3PZtbghCqeTM3Lwkaf+cwsdgQ0oNjMU+2P3Pmxmt2?=
 =?us-ascii?Q?hYMxl/67ugK39CLf9smQP+WV9xwDVUkTmuYv3Q65XaWdriKIe47czEnyaWJ/?=
 =?us-ascii?Q?cBN4L+eFw2YfXC07xf+Ohton+fiXRmxmswtGVstipQF/ecW6abjXKRKu9wcl?=
 =?us-ascii?Q?YrigmTktXCigt5P7ZhGqXl2spo7ZFJaWkOJvORPXuycK6YDsMoICFUbzC3SL?=
 =?us-ascii?Q?XhxDYJvkCxe7vDnhlw3X4knbUv9q3/4w1tnPMKTkTbs+yXWZ92N3zF2fzhrR?=
 =?us-ascii?Q?iIBYxrHIM779uM1l7Cv7JR/PciTdqMTplTA9PsDRZYKlqDfFskWifoFuBCJ+?=
 =?us-ascii?Q?wBvN4wFElMs1faNyp6AnlMfqG74ASAvq4R01ehr1xM8wSOBL0OyQ5g+89PA7?=
 =?us-ascii?Q?99dqur8yxiYrkZrowJrGUOPxwd5dUcBxF1oWuC9pVFxdJnQnKKf9wzZKBzET?=
 =?us-ascii?Q?+x9KnKu/7HyZxFgWE7Mspnm5tA8r7+fMODqqh6/HE/flFQECHETuL7BeSyp0?=
 =?us-ascii?Q?D4pCG0Mx3MCtFEYCrufFuViXLbyVpRTb0Q6wnDQy7r9f/y/e/muFIzX98Y+w?=
 =?us-ascii?Q?ahQduK/OAEdGRLOKanY4tfKgyDgmXY8GZremskqcfYvvYTVCQ6R3n5bdTBh3?=
 =?us-ascii?Q?AF+IIC/ju2LS2MP6RfnlbyvmETN/bEWvNVzfUJwdhH4Hbrr4z8OFR3G8PGoR?=
 =?us-ascii?Q?F8bmv6Ho+W7+L4GxZUoItoK5W6DewZv47K4hqApljQctnGgYS1OtRbbTSZ88?=
 =?us-ascii?Q?hFTJLWxdDtr4YIVvMLfdBbUiDB4OE0k7ArtEMqg5OpOjCBMKX3mR5Id5d5oF?=
 =?us-ascii?Q?fZlw7Ftk/yZuWKRAo13FEUv79Xjur3WBcTczFUevKSldhu8vjclxAgmm2DlQ?=
 =?us-ascii?Q?wG1beD3o5zNbzY6yDIW+rrsM8rdR0Zo4lMnfWP+ygO8Xfczgill3Ut0PvICL?=
 =?us-ascii?Q?pi6ZlFwZGVbROb52nQnTeqEr6pGdz5yZk4NtQ/ERddBIWtAx/UnBlB3eH6ei?=
 =?us-ascii?Q?2j7RQePD8uh5JzejuWbexB1i0g0HhFDoKqNjD3DiBnuvpXZkMk8g7adU6slZ?=
 =?us-ascii?Q?sqn9/1nPxoip4haKaq26gnw8z3Gz9swGVsJX1HKQTwq0c8/zlqpwa5hjLjjp?=
 =?us-ascii?Q?sXTsOELm4I61vyTP76siitY75/rf01uaHi9Rx5IwB74yt/GzHuO8BHELRGLt?=
 =?us-ascii?Q?4RInILLbSH5oDq4gUl3IFQmxGPZig+ATgSOeP+qmcNSodvYpZolrzaYRt16m?=
 =?us-ascii?Q?Gzj3Ggj04gNSC6DZf7Tnxu0UdJixkXFLGg7FMQrSALIv2IE+IfpSloyJD5tx?=
 =?us-ascii?Q?ZiHUBDP3t5Uq+emo8T8svf/XZFAybPeP9uklAiLYJ3Jn6v5c4DvBki5ryWs1?=
 =?us-ascii?Q?xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <81C77DBC367CCE4182A46003606B66E8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6/mE570mZSGptsr/JYfHFo3kq94PKFC7L1I+zPMav0wlRLkIzDIK0WqXkq13AYN2LuZWx/+OwgL1Cgw4Rfxq1WoUT2UIPhkjwyfoPVB0XDYF0vVZ5S1McgJAIm15zlw+ekxf29AoPlZOS1wxq7LTXSeT2mbO7elYLGRoiYR7Xioq/yJs61saVBsF+rkNiZUFwFHHBC56J7ArWT8q/tDyMYeKfuT39YD6OEcM35Bi7IvsE8r2Uv3SGzZDDX15VrKc9ZKpvPXUZ/wxJgAExCr5Hbl7moq/MemUQkYisp7jRotlmAxENlYofkBwfQY7Y8D8M9dGVTuI0TnYCiER3Q86M/H35J8dWDIqnTM+2aGBTAxXn/NssAG11HwTUJJ4+aCjO5VeOW0oxTVgWLT5rhS0lVouwB7rfLo5+AYvNQhO6FGKVNQCiCUUHTHVqRyEkxbo4f5bNThuh2PLcfQ9r2tqCfzkv8hKpEsd09/QV95XMwQrCouAqV49PQTiGNUupx1WQKREJOgEbrNRUe9iAO3E20rtGkGBahWHAsb2cxwru9IqGMLoiBZVogUjC6bNekAr7ocIUTyTKWFaFLSux11BzdhpYOkFmNl8e0LkmTvozBsREly8fTa7LTd8AUk5eZV/+5DK7IEFvt5kTMN7BjPD74n0ek2LUYJcOpTJ4Gb4BeKWz3Yrkail+a9dBjpp2OAZ8kSns0VJ4KC/6dCgt9lPvJU4ji8MG6lZI3B7MmN+tLYQ42/2SNnpO1kY4I3LqT0+OB8IwMw3hxgvd/R+9d8lgno+/yKV0dPvYZKRNugOreI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cedc6515-43f4-44d8-a9f2-08db4b13ff64
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 13:49:06.3883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Htpo5WTq/PUji11hKn6hpWcT+637oqRyaYNsd023fUz9uFNsLR2fphbjPFoVIZQaQfqh93hJaCNrBWqeVwAFHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305020117
X-Proofpoint-GUID: sWzeh6tmNvvyGyzca88eXvwEKr_L_zk8
X-Proofpoint-ORIG-GUID: sWzeh6tmNvvyGyzca88eXvwEKr_L_zk8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On May 2, 2023, at 9:36 AM, Christian Brauner <brauner@kernel.org> wrote:
>=20
> We've aligned setgid behavior over multiple kernel releases. The details
> can be found in commit cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping") and
> commit 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0' of
> git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux").
> Consistent setgid stripping behavior is now encapsulated in the
> setattr_should_drop_sgid() helper which is used by all filesystems that
> strip setgid bits outside of vfs proper. Usually ATTR_KILL_SGID is
> raised in e.g., chown_common() and is subject to the
> setattr_should_drop_sgid() check to determine whether the setgid bit can
> be retained. Since nfsd is raising ATTR_KILL_SGID unconditionally it
> will cause notify_change() to strip it even if the caller had the
> necessary privileges to retain it. Ensure that nfsd only raises
> ATR_KILL_SGID if the caller lacks the necessary privileges to retain the
> setgid bit.
>=20
> Without this patch the setgid stripping tests in LTP will fail:
>=20
>> As you can see, the problem is S_ISGID (0002000) was dropped on a
>> non-group-executable file while chown was invoked by super-user, while
>=20
> [...]
>=20
>> fchown02.c:66: TFAIL: testfile2: wrong mode permissions 0100700, expecte=
d 0102700
>=20
> [...]
>=20
>> chown02.c:57: TFAIL: testfile2: wrong mode permissions 0100700, expected=
 0102700
>=20
> With this patch all tests pass.
>=20
> Reported-by: Sherry Yang <sherry.yang@oracle.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

There are some similar fstests failures this fix might address.

I've applied this patch to the nfsd-fixes tree for broader
testing. Thanks, Christian and Sherry!


> ---
> ubuntu@imp1-vm:~/ltp-install$ sudo ./runltp -d /mnt -s chown02
> INFO: ltp-pan reported all tests PASS
> LTP Version: 20230127-112-gf41e8a2fa
>=20
> ubuntu@imp1-vm:~/ltp-install$ sudo ./runltp -d /mnt -s fchown02
> INFO: ltp-pan reported all tests PASS
> LTP Version: 20230127-112-gf41e8a2fa
>=20
> ubuntu@imp1-vm:~/src/git/xfstests$ sudo ./check -g perms
> FSTYP         -- nfs
> PLATFORM      -- Linux/x86_64 imp1-vm 6.3.0-nfs-setgid-3a3cfe624076 #20 S=
MP PREEMPT_DYNAMIC Tue May  2 12:35:51 UTC 2023
> MKFS_OPTIONS  -- 127.0.0.1:/nfsscratch
> MOUNT_OPTIONS -- -o vers=3D3,noacl 127.0.0.1:/nfsscratch /mnt/scratch
> Passed all 41 tests
> ---
> fs/nfsd/vfs.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index bb9d47172162..c4ef24c5ffd0 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -388,7 +388,9 @@ nfsd_sanitize_attrs(struct inode *inode, struct iattr=
 *iap)
> iap->ia_mode &=3D ~S_ISGID;
> } else {
> /* set ATTR_KILL_* bits and let VFS handle it */
> - iap->ia_valid |=3D (ATTR_KILL_SUID | ATTR_KILL_SGID);
> + iap->ia_valid |=3D ATTR_KILL_SUID;
> + iap->ia_valid |=3D
> + setattr_should_drop_sgid(&nop_mnt_idmap, inode);
> }
> }
> }
> --=20
> 2.34.1
>=20

--
Chuck Lever


