Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40113700A72
	for <lists+linux-nfs@lfdr.de>; Fri, 12 May 2023 16:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241185AbjELOii (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 May 2023 10:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241124AbjELOih (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 May 2023 10:38:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1628D1BE2;
        Fri, 12 May 2023 07:38:35 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CDnbLB010817;
        Fri, 12 May 2023 14:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vv/b5yuXakgBep1n0Rs1YQi6/QJTutPbOR0cauUge+o=;
 b=y9zIheFYcgH+fVRIj+nvuibpP9vV+xpO3A7WkCPwsqocDijtsu8MMuYTDv6str0PAgHd
 BeUK5D4hDv4dPwy6Cd7wQdu7zYphCKzi45lXMEOudZv/wlluxVAcYnibRyp7XpKxhxaf
 j44aih009zBSXcUW6MgYqssbjE1p6H4n4Kc5dUeADyxYXuK6Fl19mJyYd1tQcLHHvuqO
 KUa+C7SAz2WMQveaI3wCnsCZulelL7+VtyKkzWTmcaPJDAnJOOF+QH5KLn2UCJzyhBjq
 exwg1oFQZYktnxH4TJrhy/aLkdVj2TfhhTvvRyuwDbzRLKCDgg7AK1U4r59jBPfZSgsN dA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qhje7h3yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 14:38:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CDOWTB011616;
        Fri, 12 May 2023 14:38:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf814x6e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 14:38:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGUuaa/KKTIe+b3j0pPsqNc6gxC3WiAwuQ+aeclzC1HIg3YO/FpBRiP5Mrp5q7dZ/GKggOnFZUB79EHiG0wsdX/y+93lilngg9ZybBBvoANayL2gSo0r3T0/KKDg6ouKkHCqSQSLJkQlrvQXrDl/dso1L/R8aiRalT9aXXze6t/naRxCRDTdyUcPvoZ0RJ1ipMLTxZecQFJ2wkjMMmM3tt+DorP0JS52H1ZTY2vVwH8CQokcuI/uEqGk9bZlqF7XoSFObi7h0tdDBawdU2eg5bpOR4y9NF0/9hBw5Mgk15LyhLR01u6nZwM/UJ9xL500LHD55/oR5lRa7/oWQGqbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vv/b5yuXakgBep1n0Rs1YQi6/QJTutPbOR0cauUge+o=;
 b=f/Zm8P4C3ajGfC8k2dHAW8uR9i72cQnaV7faMSIa9I/U2knkPkQ9FTAjzGBMfbShU05ichMjzqSMOwN8yMjkX6tcf6+yq7owyye1z2vbQDDX/XK1x0NaIO9rW6G3XFhoShJMfFO8UwbQfG9+0ENV/AgFsnBGclLqx4UXXa5jXxewtBI0Kdv6Ks68n2gEJ7hQ2vmCesZaY6OjB2eSMY/Uiy4O8myTXAhXFPIPYUwdK9nbgNmEy3qiTPMoY9VLVMRKGQlmPSJYR4noFyptE7cR+GSaN+h2wIkOlMtPezMLYzZhpzNQ+d8HVqSzhAY3FL8j1ifyVaOy7i30K/lbDwdPeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv/b5yuXakgBep1n0Rs1YQi6/QJTutPbOR0cauUge+o=;
 b=FK8Ot8CL9uv8VwMz1kSkG0/DHfOOx1j76nqrADzrZLKKt63/RQK85+aVHiOBCGtAzUQPBb9pyd1GhnVZVRrx2Y2E6AhIHJ754f4Q3UWenjiS7EsUIy1Dpz6vHKz2onsOZFnopX6Ke5aAosqXHKKUAh/CwYlFCoyOHHaLuT7Y0ak=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18; Fri, 12 May 2023 14:38:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 14:38:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
CC:     Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Replace all non-returning strlcpy with strscpy
Thread-Topic: [PATCH] NFSD: Replace all non-returning strlcpy with strscpy
Thread-Index: AQHZg4w4w644hNPMzEqt/IwppCpl6q9VJ/yAgAAdSICAAXBDAIAAAiYA
Date:   Fri, 12 May 2023 14:38:27 +0000
Message-ID: <076418CA-6400-4A92-8634-60F2934F985D@oracle.com>
References: <20230510220952.3507366-1-azeemshaikh38@gmail.com>
 <72239648-C807-4CDD-8DA7-18440C83384E@oracle.com>
 <202305110927.12508719D2@keescook>
 <CADmuW3UbHBWN0JzXMYX667hkXyWJY8_88K1sJfRnKNg7_u38=A@mail.gmail.com>
In-Reply-To: <CADmuW3UbHBWN0JzXMYX667hkXyWJY8_88K1sJfRnKNg7_u38=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7125:EE_
x-ms-office365-filtering-correlation-id: 206d02ec-2172-4cec-8f0f-08db52f68c39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RvHdvQGSLdRCxq09xmsUrvLBhDL/6sCKmlt7Na8Kbhl7WsCexc+/rZhT9cOPaLlva8Wnq7OpLHSeqqpVISnTaJkdKEASQJHn+weabaG92+pv5qfzcSsnw/lFyBaal2n7Jl8ti2jvfl9+C0Hq1k+a9AQuVlEp2DMiHZMMTzxL3v50CIrg/0awqH0bYKNGqznSqlTFUZ45yEYLo4R0oZoNCLHKPp1sr3foamkRDrKzIhG5GQbVNDPSbMBmGnFMOlAiXmcl4mQljndufareQRYVtKzL9SyhxweQe9DO2IaSrzBBfEJWVXjocbrt3oIYe+ZiZufj9pHOifPlZBPLK7/E0LT6iNvidUwsE/fs1AwVSglxKc24DE5u1d7+EnWXj/sZAlDOKykhEtsDD+8FaVxxz/qHUhbm/jj8l/wu1p7u/pyoWRmUq2oNSwkbt+tKqdRMOVnH3BLCP3VVZaHeOkCkVu5RY0HtHZF4BzmM0N7aBmM5Fobv5Kq5TkWXyu7dtwY9CS3NcsieWsbD7e57E+CZNni9boYC9Qp09WhghiAuwoiqIp+x83gPo+ueey6y6mVfSZAlHj/jvX6eZ/pCUBhX9yaUXZwwjCiMQXcKLGhC7+mVIrqxX9exIUdK/9BKwdrIp0PLYeJ6KS1xX9COFy2ti3OJ3afDsM42tKn2KXFKbA8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(478600001)(2616005)(2906002)(186003)(36756003)(6486002)(71200400001)(38100700002)(83380400001)(38070700005)(6512007)(6506007)(53546011)(41300700001)(316002)(33656002)(26005)(122000001)(54906003)(66446008)(86362001)(76116006)(91956017)(66946007)(66476007)(66556008)(5660300002)(4326008)(8676002)(64756008)(8936002)(6916009)(156123004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SZECm7cr2d+velbfke4TBjN5KAKt62if/6lstEf0SKpFgtkEfgqVQVmej3+Y?=
 =?us-ascii?Q?C1GBh6Z3eNEkdpRgW7BYLpSxAsuXXC3bfwZOJY5qyBlNE1UqcXmGV+4wyIWP?=
 =?us-ascii?Q?FsciKpZSB4ys/fc3AOcpHI7Jy8qPdm/m5jDPymkbixu/wTRBI/4Ddm79FJgA?=
 =?us-ascii?Q?qEbCOGB2MOPu/z072jO1p9Fa/pa75GMErC8JSNvGrcmczEyorsYu0fiFJG0D?=
 =?us-ascii?Q?WNB69XgfUt9dhHufjpR0PJuVGhd9dV+bMK2cOEPhLsRJszFU/+AJ+xf88gL/?=
 =?us-ascii?Q?CpplxQ1F6ERKXJrGAkmCzLGHUTIRUWaHLnK+cCfVIDkBQVXtmCZTc9yaYIxz?=
 =?us-ascii?Q?56B1J3fqq8fa54RBojP02pViEdSqmroZY3q3HMmGjl8oLl+0P2gU4DBfMf43?=
 =?us-ascii?Q?4Pm5I3uCMUSAxjqzC72Zqn6QaC1CWLPfqhCUOsmMGRsz0s+/6uHJbPYyrX56?=
 =?us-ascii?Q?gwSvWTZTD//Xs9DE0KheZN5rC7zKDhdSTNMyL1O9HijJPZ7FPhwpZr14g/C+?=
 =?us-ascii?Q?A61vRckq08obZ7Zps9CrFYq9ozK351C0+yD3i+1z14PvHtmAUmrLCw3uyUcs?=
 =?us-ascii?Q?ac0S2haMMacwX4harlMnIx6JY2+w4zDNHfqWT6lSqkR3UHS3PdXAkVwG6gs8?=
 =?us-ascii?Q?wD/0avwb3VS6uQubEodtKnDMn1hHNa7OrO1id6j6BKit8Mv3kpGnm27IUQqS?=
 =?us-ascii?Q?KReA91QfayDktoogZZz9rO1MvDrroqNWTYwwlIa6O13ChYnigpsYSEePlQRP?=
 =?us-ascii?Q?PwfxETXofXgesG5c9pjhQ8t4uo6bgKjUQidLK+d3WGZoAnGGiuUqQl7urK0W?=
 =?us-ascii?Q?wNyCpqc637gEiwmHnODWGTcI0sTC41Wc4zvBa9eoLeVWEHL9L2eIUHsrstjJ?=
 =?us-ascii?Q?PUIpPBWVPhMAurPwzBaVppd5DIA4d7kKrSTnOWv8PSY2qjvo1ciYQfKp/E90?=
 =?us-ascii?Q?2yYTmfVDt4w2wOqB993RDMVBrPCuhGDN3sLoB4YQGTdjw2a6x3O9zzR1YZL8?=
 =?us-ascii?Q?3KzLUX9waoia8+sWDjku0b4TG/EFg5U+NeWuwkrzZ/aLc+0M2/P+qGmLemsu?=
 =?us-ascii?Q?cVOveUW/wmxt22kZAHysXe9Clkhn3l3+afWWJnXQoRzpYB4vdxl0pBslSH/G?=
 =?us-ascii?Q?+vwffLz3xdeiYziJsimEzExVYIItr8k9Xuouv8rcavfUGzJWsh75zVOUj5mU?=
 =?us-ascii?Q?tbzBhB65PU5un5IRY+njP+DJho78sQZT1EUW0bGBqheQ05vjoexzfvlTL6cj?=
 =?us-ascii?Q?uw2P1j3J0q6XNSY/azMXKQhWcsJEbmczMZMVU4uZbg/G0osgESeBlS9CfPx7?=
 =?us-ascii?Q?c/f/oLttn7z+NRwM/I4fBJ7tdLkCUIVoE0Szz/CS6mmkJrrXClVfuPu1a6QH?=
 =?us-ascii?Q?9P6/bOUFXeasumM0wisPiKfLEugz+qhzagPAd+fE+JlDdTezh6g3tmvRj1vW?=
 =?us-ascii?Q?sZDz5CZIUvDuBK9bw+vRbMgq+yjwzuVLwUTppMi4QjNHtinyBE5YZvefDyDB?=
 =?us-ascii?Q?bfWAysoeVIgX0N3zftz6zu0la4n+Kj0fPh0p83QxRc+OrEHCo2DI7cnmcFME?=
 =?us-ascii?Q?hgIG7/2shDg7aR17BGy9rnJ6a8VRF5IODailpRzSfq4vrXftHquu3XnuTgrD?=
 =?us-ascii?Q?qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EEF4D2CA85D437479449DBBAEC043A80@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N2hBSpvF1St/cqYOl4+61+GKTO9PlrDaxu7GHvbrAqxcDdaV/xQQpfS86PJr7pdopYnTrbPUxtR9tZO0WyHJ4QGNvE+XwKTrkhM9i4nfJ8X7SWfAjIASwC5Q27SYXK3VWxNOz6VLLSEzQC+irR61HEN1ioYJQhciPebnHZWVuXnoj2D9xMMYrPON70Z/RZtjbbDz2mVypyC8Zb4WuzrzhmPV9NOT2g/Vfm2cmCWDYBS8J3qOSNuna6P9dchCVcxcIRhbMIDTI114+oXzmRBUTJQf7Z4MtvjwEOMhxXcVyeBfpglUVjErhlS/RCnIsVsyu5jqu4jQ2olJZwqInga/YbV6IPUSwADm9GOwzZH3XLv70Horg3IBzQrT9pyrdnBg+CHCwL8AsYl3qS80XCUAc8ALmcmW3qCm7KKUSVMb9jdQSXkQ+KXzWqWWHp4gFPrzf3Sw/5zTLoF6iqBFIWQnk97RL22kvJQEMz63rqAThowqVEU4FjNE8iMFf931d7Gpwco6OJsDXok5eLsdK+l7Mfaa7/CD74uU3ghpfrHuw2MZKxI3OVHzOjVVpm1VvWbSjc8Y8ifUYlO2Ncqex8zCBjbfdypooZEIXj+BBQzUx1jqz5MA1jcVue43ItbkTTLmkWzC/Xqo/o2Vi3wI/ps9vsGrG99mUExX7yYltrJYCZlwMo0dh4Q5WUlhbMX196SCWc+Jag0LOiupo07C+0ssxJaQUN6nvpvc93vzF5lmI6T4sqCXalorCaKpuB/1uT09CHRlK9qVIxrmtMjDVFBruV3HuXk8ikXoOx+awke12kHCUkPir/vs8Zga1h9V5tFNw4Rjco9FUnKBbAl7vJ3BPXRhYIOB1j4uHwXXcIKtWpBjbgDMkBJjQfPyBm5DE1lX
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206d02ec-2172-4cec-8f0f-08db52f68c39
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 14:38:27.0966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FlgfjkSjEWOjNkX9ZG0CRBlB/dKg3wSZhHT56ey+LIDJ5tJApoX53UPONqXyTfD6bko/PM5XhTdYJrhQzNxZ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=578 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120122
X-Proofpoint-ORIG-GUID: aIrAdeTkpKAhSqAjDxVdrY8mUuVcCcv-
X-Proofpoint-GUID: aIrAdeTkpKAhSqAjDxVdrY8mUuVcCcv-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 12, 2023, at 7:30 AM, Azeem Shaikh <azeemshaikh38@gmail.com> wrote=
:
>=20
> Thanks Chuck and Kees for the review.
>=20
>>> Actually netid should use the __string() and __assign_str()
>>> macros rather than open-coding a string copy, I think.
>=20
> Do you mean something like this?
>=20
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 4183819ea082..72a906a053dc 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1365,19 +1365,19 @@ TRACE_EVENT(nfsd_cb_setup,
>                __field(u32, cl_id)
>                __field(unsigned long, authflavor)
>                __sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
> -               __array(unsigned char, netid, 8)
> +               __string(netid, netid)
>        ),
>        TP_fast_assign(
>                __entry->cl_boot =3D clp->cl_clientid.cl_boot;
>                __entry->cl_id =3D clp->cl_clientid.cl_id;
> -               strlcpy(__entry->netid, netid, sizeof(__entry->netid));
> +               __assign_str(netid, netid);
>                __entry->authflavor =3D authflavor;
>                __assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
>                                  clp->cl_cb_conn.cb_addrlen)
>        ),
>        TP_printk("addr=3D%pISpc client %08x:%08x proto=3D%s flavor=3D%s",
>                __get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
> -               __entry->netid, show_nfsd_authflavor(__entry->authflavor)=
)
> +               __get_str(netid), show_nfsd_authflavor(__entry->authflavo=
r))
> );

Yes. I don't remember why I chose to open-code the string
handling in here.

I agree with Kees, also: __assign_str() needs to handle
the memory accesses properly, and I had assumed it did
that already. My bad. That IMO should be handled as a
separate patch.


>>> Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")
>=20
> Ack.

I agree that it's not a high priority backport. However,
I expect those who want to use trace points on KASAN-
enabled stable kernels might prefer to have the
__assign_str fix in place, along with this one.

So, I'm good with including Fixes: or leaving it off. Up
to you!

--
Chuck Lever


