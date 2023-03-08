Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D0D6AFD4A
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Mar 2023 04:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCHDOa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Mar 2023 22:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCHDO1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Mar 2023 22:14:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799B293110
        for <linux-nfs@vger.kernel.org>; Tue,  7 Mar 2023 19:14:26 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327JwlBo014810;
        Wed, 8 Mar 2023 03:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2DLsMIP5+G/7vcoeLp6KLTYIeQTaUGhPPwwpw6xbsZ0=;
 b=TjRmXfdxPxZgBjv//wMeIvJjOxRuNtt8LwcpkKuvklzmEMaaY24+c6W7KLw54BqGGkaD
 ACDr0VOZjzxS+7hMjXQ/WEUgz94hikU2qcpjFcOiF9UCsnVs/8dQfuUFkWFB2cPqkrH0
 70YDU7Jd1gpuerV95t4/ZwirhxiO47C3abL41LwpnOlyXw8C50jcCZNp0EFu4z9ye/2+
 qPL1J/ZOBn1P3SSEgGc47/bjZRjYQFp+2sv/9uT0jBkQSC+5WUoQGr9X7FWyGll8QcHe
 LmaNdDugts+EnP1W9KKZI0sskThKdbjx4Hpn+o/jq3uEuuZcmuUDe7T4mGxJYLhLKS6+ wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417cf5ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 03:14:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3280kPdu036488;
        Wed, 8 Mar 2023 03:14:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g44v0bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 03:14:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dS+DJCdgyOWnDv59UmskHToBNgABmAPJt4ih0NWOdrv2uZzxiyCLpl+hid/itca+x/vqYN/Hy6vUPD8iSYcKOO6bGOPuAWf3GMqn1VS6expy23NcKSGzPK6XNvKdDPPWX8k3R85zFaqKgS/gd2GWVTY+c7BqxsklGGoyVQcbdYPLyA/kxaOvO7jmaxbGZvr52uvQKrl+Ygwa7rDiEcsHUepUApWexH8eL/+oNc/s2k73XKs6Z7JNSIAgH3TLTlDTI1zaA1hkzVvjw018wlzGzhPMf95D6bjEcaKmP/dqmXTiUey20K3P4afW40IC6F231MS25CrjUQTfaK9B1QSBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DLsMIP5+G/7vcoeLp6KLTYIeQTaUGhPPwwpw6xbsZ0=;
 b=nCRNEXWq9bXqrO+5rShgN1AWI939cUEGHrwYesEkK2sVLWyp6C1XbAqkTK3McgI3MRIvR1+28L/85TqQM9+NPqCRCKAi+TW18fv8CeUT178xUgD7p+/d9GJ/3zCJYhkDR7ESnaAzo0pA5bMmwUGI85MMyjbJ6bdQiwSYCu5XGs7rlWE8oe9QJ41HeIWHa8I9MWHKKDT402VPPMxDGVTYWRZm6NfwFboQ2G/Fh7WB0gZ7HfxvVqpKvHzjxAps2/VK6gnUmB9UYL7c18h+whyNwseu5IoLRofNgvpx+f6akIj+tqnCjQwWYgIDYbUX9PalVweUnvg2qCtupW9A0rAe6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DLsMIP5+G/7vcoeLp6KLTYIeQTaUGhPPwwpw6xbsZ0=;
 b=UAsBrNR24q2LLdpnzlWWjU24/azGZK25kkwjSbGtZsnSVQPpDw9SSJb4kmpxoFpABEmfkpw4YxG5ilZ80sqrvURdu8tJh17VvuQ3O/TTyGR2iUR3sHDiuza7LMtu+koL7fEwB0DP4wX2+zLqSwSkwBw20SGVhfEMmN4x2OJ4V9A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4206.namprd10.prod.outlook.com (2603:10b6:208:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 03:14:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 03:14:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] SUNRPC: Fix a server shutdown leak
Thread-Topic: [PATCH 1/1] SUNRPC: Fix a server shutdown leak
Thread-Index: AQHZThRbsBOmHSKc4EeHO2Q7T8KjwK7wO+SA
Date:   Wed, 8 Mar 2023 03:14:10 +0000
Message-ID: <FA64D05E-9902-4C37-9F14-40E3EEA3B656@oracle.com>
References: <cover.1677877233.git.bcodding@redhat.com>
 <65d0248533fbdea2f6190faa1ee150d2d615344b.1677877233.git.bcodding@redhat.com>
In-Reply-To: <65d0248533fbdea2f6190faa1ee150d2d615344b.1677877233.git.bcodding@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4206:EE_
x-ms-office365-filtering-correlation-id: 3a433243-f1ce-4de6-7e12-08db1f832f94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nGtB0ITj4/R6av2GJjw7XJ50BwoTnHk5UWRhReV11Chmo6gPfoONB07lWlgJjh5wH9DuqvLHnJP2fels2psuBPkZj+zfBwaav+q7+xmL/WXg8Py5aVrzqsL5oa2rpOGn9M8E/qhhXe4P6oMOEcypmslsaRd5+cifEI3abeBK2FW1fxlJqfh9WJh9Ufm10q0DJ73ftih3lFSn0E8Rh5ZgEMYVW1jD3CljqQyZQ7AOlUfT5ODgyr/DnNydnTel4vJ7dGRobtQBk8/yG7dy28d9prfBOeDfI4WkPScjWey6G6w9KhZB6F2yV7kvx4+TN2KaeSsN0s2R0khPl99Bd622jFKrN+0MKJ4Q7DA7cpoZFaLo97ykSxkN74HO93N+i5dr+f6a3eYQb7dWBIkK1dgf+EJXcUiMv6jY730ZAHkKaUJSD2GsTUIaOiqJT2NVGXxx7nQYraDtLlESgyPZfrrw2U1usxAlD+Qxa3y8NkwOhOOt9o4t/P2xiwNxsIlgomK4APKpf4tACtmSp54VQFiWD8KPw53QZnqyaKQBRMIMK6O7DuBSvFBLZTa+aNRNaJ9r7rqOOi3dqNWpJ++8e728o1kvcjj0wcdZG3uAi7tMn+G3w8n5wAUWWkaSDJEthQL/LtVliGK7Z2pYjjylJ8LtLRchzyDOTwQy2i/ba1rapn2zaPJ7Kb5UK0mYprkRS+I5Cnd9jEzPX7wyiT6SKtxS2XosTuF8LH6CjgMBSEpDAQ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199018)(91956017)(76116006)(8676002)(66556008)(41300700001)(64756008)(66446008)(122000001)(6916009)(66946007)(66476007)(4326008)(5660300002)(7416002)(8936002)(2906002)(86362001)(36756003)(33656002)(38070700005)(38100700002)(6506007)(26005)(71200400001)(54906003)(478600001)(53546011)(6512007)(316002)(186003)(2616005)(83380400001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yl/bocrQnSUknKhDV34NaOqNqLikoKttc46a/hPCGsXDSwLubWx9XAzm0VB+?=
 =?us-ascii?Q?i+2vnjTJoBzRLiA5OKy9B/rjsiq52fqM3SiPEXq0EmuDRVLAIsfnFk16k35U?=
 =?us-ascii?Q?UpjLe1tyKnUkArui+EMqU4TUSZyPeeGz0LQsED+2YqyABqP62Ddhj/TunB8C?=
 =?us-ascii?Q?dZsspw85eUzLDTV07yI5bZ5aCxW6l2jNyypUFzsY+JkAZsBOJXkPGKko3Jr7?=
 =?us-ascii?Q?W7X3D1SAilt5O5JwMslmZiCrBVhk1nE7qtXSU/AX2v0/ISvFwC/uJF31c8Jz?=
 =?us-ascii?Q?pIT/6bSDKTHYh4+dNj0oY18ZNY7NJKUy/VGBLgjzitG4IAi6h525uxOUgIMK?=
 =?us-ascii?Q?PsB/HAQPONs2l9yiTGomxItGWYs6T6JNjZuHTiq4ZZ9wCxR3d0MNebT/JXoa?=
 =?us-ascii?Q?FdNg1bjTddfhovu/lioJoOOM7r463+IfLhd4r6q33snaZVdKszj7rZhnnRHq?=
 =?us-ascii?Q?QPldaKWjLk8a03aOFua8oqOchCPUq51sorxr2QD9Xk2y1dtmO7MUcfI+uC+Y?=
 =?us-ascii?Q?skwhmCTeZ5fjN39LAlIRShu9XB9Plqkiw80QWP+bw+3F44e2txxR4q4ntjtk?=
 =?us-ascii?Q?iebrs6puer99SYue7odQVaevgCiTjFLkkMRLkxZWTQhIWCo9uLZkDvANscbt?=
 =?us-ascii?Q?Jez/sdfffPaK1wh35Fp/1vyGae84PWa9DEZOkoRBTM61R9US2rgYkX/GNDoB?=
 =?us-ascii?Q?nIpWquKGqyxyrFNzvtQZI5C3piEXuH4NwWIGyygFsogeLVrr6KCjABfx2hhT?=
 =?us-ascii?Q?08mJMUzks9+oCh3OgkvpeTFUBxdXOj9leQuFUmIPQdnpmpCY4WXaA9W+nuJc?=
 =?us-ascii?Q?nd1HTXnAcl+5+cX/sybXOF7tw2blshej0z7Jn6eHM95sA+YKeI0LWDEc/OSR?=
 =?us-ascii?Q?v0Ej8uhK6J/81n+/RoUQ4Iu9u2PbpHfWRC/UqGSlEJ7dP/hguKutvkhFBzMl?=
 =?us-ascii?Q?qS/vAfhQ+BsC4404qhLC8fdy5lQFykVFDatF+iBtQ835tmu/7WoZ17/jNXAq?=
 =?us-ascii?Q?7tDd3Xl6kYflqcrzcXn/oGbSdhnzFmXWPAIOwu/5Hr7ELejA8Wt/SKPytaD/?=
 =?us-ascii?Q?3Sr9YWvY2mncz6uW+ARXs0n9ZzkVrNTNq+DQX4F7uM7Bn1hUVETMeAdPtz8x?=
 =?us-ascii?Q?/dHh3BMQjb7UKn7omFIPWwINr75g+Rq/Qk2yNeFTxtE/JPiXgioYmnFBKIa5?=
 =?us-ascii?Q?VcCFeRhPj3UIsCdskZoa+5zBkK5AOspvFmwJ4eDPPmKezfxdpZW9kvHyzNdc?=
 =?us-ascii?Q?/RjNH0VQYedbWRBE9xBe+4MGCphs5fZZgtRRm009n1hFDim/VEck7DnerEJ+?=
 =?us-ascii?Q?FaijXMB6rox8bxnGUSOSqS6tf6MnAOMzEmqc2lMv+uf7/2blUMUV9eQNLIaY?=
 =?us-ascii?Q?Gm7dW+I1IyfD3TmU9Fa6R+Yf4DxkeLmUsHMOioVdTdYSD20JCEoK5cY7FdqT?=
 =?us-ascii?Q?+G9sEWeV6kJGimhBb47K3cUFu3yn7tLH42DBf1156PF6pNzlhqx8Euoif+Gk?=
 =?us-ascii?Q?yQXo8l4nygaTP6Qkcrh3sdW75tSZGRA3M1KTzTsDInLIDgZ0JjkIYeaOLgFK?=
 =?us-ascii?Q?ZxRyhqPeDoOZ4u2Tn74Vy7eck3MtZm8oH45jmQl84UlXufQZFhz+Trjb2VEE?=
 =?us-ascii?Q?RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ED3EE140D3E590469EF7663F1A0DF8AF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ERYoT+g/rwAKOPz6P/V53BmaocLCCUaelJHXhtsKRjDLUIYygLiPTKymvxS4?=
 =?us-ascii?Q?W89JwHHP864NumFnTzwQ3MJmij7zzv4Gq+bJPTFesSRZZJ007gZBVOqWM4xL?=
 =?us-ascii?Q?r12xS51cq0m3k1WTpzDRTCZIGe65cilVQZ1MQeI39q+ohQBxmgcAax6zVT1i?=
 =?us-ascii?Q?n5p19XHO4uGrzC94ktVq9kX3czjK0+R6jRJsDqvUKArzM6gfjZ/qAQfJA3sV?=
 =?us-ascii?Q?2WLk9gUOw1sf7mY8w7wYTYFwQU+i6mPhTQz+Z8TAXuWjptvjBhxlTpXFcxas?=
 =?us-ascii?Q?6zRV7/aC9fsvhqtiAkJf6/hGzMJwEN/itjFY+t2bnOMi/6AGvIx9OgA4KdDO?=
 =?us-ascii?Q?gIjwyu0mPl5rZvrbva77GAOMl1tA/btrqboF3oZiwPZ+ya3oNjyLdu02E5Ms?=
 =?us-ascii?Q?p+Kdsu/6CVt+8ihKb6y+sWXfOMD4rtdQua4WFJMLQE8YfWN2z3u2ZiVxAzcI?=
 =?us-ascii?Q?OKwNAYBkXyNYJocoaEU5f46kOk6+HR9ugpPdUtO/oBDZnpFGM9rJWmJWCQDw?=
 =?us-ascii?Q?XBdpJ5Udb8+t3Y91vYGOvmfpn+FR/NPvoS+Uyphgk3gmNOIslIvOam82L/qG?=
 =?us-ascii?Q?7YUxTfrZyUyApK9PAgutrTl/i+dqwmkHaeHM9cOXfny60+w8XKMUQ6800Zzx?=
 =?us-ascii?Q?kUAOMXBZgSk2hpXN9ep6pwrhZItoYj98FXf+mG/oh7X21q6OeloO3bTKE7FX?=
 =?us-ascii?Q?DLJ9ynBk+FudTEDp9tv/gX121CKI4pTcLxfm+Dy3J5G52BqmslcR1iE4CwhD?=
 =?us-ascii?Q?hlHtVq9UdZuTv7VHCgfxwxRKUZIE/bftx15FF91kO/8tldJ3n5s1xsh8vbx7?=
 =?us-ascii?Q?nmd8Jfk2+a+F5BUdve97KwVTT+S/jugXQ45vUET60u0aXC4v3MyC+tHSEdqF?=
 =?us-ascii?Q?Zwtr8g4GMwbIEM1q7RLt1bA1bJ6B02cDF6T5wjHiexlXB+7eCqq1Soc7Q0M6?=
 =?us-ascii?Q?5SKu6E0a8v2ia9BigaNveg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a433243-f1ce-4de6-7e12-08db1f832f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 03:14:10.2026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQ0cmtlz8e4Oy78rX1Q3zftWZZyg29SYdg2PpJzxFk18BCMWTHiucOzXR8sghaTGnhbnWwjMctglDwXMAjj+Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_18,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080027
X-Proofpoint-GUID: nnoTUMJ3ILWEbx6UzqiS67-z65btG7Fw
X-Proofpoint-ORIG-GUID: nnoTUMJ3ILWEbx6UzqiS67-z65btG7Fw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 3, 2023, at 4:08 PM, Benjamin Coddington <bcodding@redhat.com> wro=
te:
>=20
> Fix a race where kthread_stop() may prevent the threadfn from ever gettin=
g
> called.  If that happens the svc_rqst will not be cleaned up.
>=20
> Fixes: ed6473ddc704 ("NFSv4: Fix callback server shutdown")
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
> net/sunrpc/svc.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 1fd3f5e57285..fea7ce8fba14 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -798,6 +798,7 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_=
pool *pool, int nrservs)
> static int
> svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrser=
vs)
> {
> + struct svc_rqst *rqstp;
> struct task_struct *task;
> unsigned int state =3D serv->sv_nrthreads-1;
>=20
> @@ -806,7 +807,10 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_=
pool *pool, int nrservs)
> task =3D choose_victim(serv, pool, &state);
> if (task =3D=3D NULL)
> break;
> - kthread_stop(task);
> + rqstp =3D kthread_data(task);
> + /* Did we lose a race to svo_function threadfn? */
> + if (kthread_stop(task) =3D=3D -EINTR)
> + svc_exit_thread(rqstp);
> nrservs++;
> } while (nrservs < 0);
> return 0;
> --=20
> 2.31.1
>=20

Seems sensible, applied. Is there a bugzilla link that should be included?


--
Chuck Lever


