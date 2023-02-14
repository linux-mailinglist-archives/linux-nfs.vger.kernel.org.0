Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF30696794
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 16:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjBNPFV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 10:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjBNPFU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 10:05:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F190228234
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 07:05:17 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EET8Vo002558;
        Tue, 14 Feb 2023 15:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BqaAbxDVkSgXUEBPdJuQEe813YLXOa57DE6CRLaqAnc=;
 b=hbkoAdPIvGL84FuJHapR90YA7lKHyeqZJA9gs7khcXwRTL+eoJKt5NekhQd7P9KFXu9n
 cKjxrR66TKeDWoWm1vZlWqIpe9/8Pjd32sGOAbs6B5FjYUdE7zenBsm4/EZ5/turqN8m
 xHCzywsoj+e+0mri6raCK9Lzoz3MqU9kPpvcpuzqamFnyel9fhsHFLs6FrFbTwZthu+N
 FgJbsnzVstOsMRzyF4OeKgPU/v74rVJBQkOMDQvFINs+rwzVUQ87+Dl5RYxtSLyyCgoY
 QJZTsD6xhTVBsgmlIBr0XMERbLvX2GGMBNdsyeM9x+PQRKkcMj/KmoNSOyMqfH8xncLS NA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1xb5ngs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 15:05:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31EEiw9E028986;
        Tue, 14 Feb 2023 15:05:13 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f5pxbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 15:05:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CO9qDGSz9pY9qfdUBHYmUezkFg/Fsj8g2rXXjfUn8FIj9EJ4Y5ejeDy+TXJHH08htUJ4/PWiHo36z4/TRwdKs85NDLwCbBiTzjPQvTKSB8/yK5pojqaMvVnZ0GgZ8zJjri4ELApyQ3MkBqLSvAiIhfyJyRM2b4PN9ulpUoIflyyqeJ5N2+NZ/vzFEM32H6AI93AH6OzZ8vf6lE8zF+j5hjSsgHfPtcBtcCLNl/Mbf1W9LjE3OOsjZLIAU5+W5779ri2/zBAOdpwcdt/hkbfuiq98pPAYyE+RYR/J0NY2U/Wz3wKTvUAXT6BcOpX9718EckcYyPUhYdif9LpeNzuFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqaAbxDVkSgXUEBPdJuQEe813YLXOa57DE6CRLaqAnc=;
 b=OQEPUYPU6F8TeyhasvZkfKCQbPrPE9OtJyYg5ssoGQ/BzJ0elGDbEC+lg1B5O/KYqvb8UVxL6n+4JPjdoIE5HdYjjNw+NyliP8Uw5hDPII2DxQJYX8eM1bJwrfuKrf3eiLfZZ1/a8cCXnWTvpTx66DI5ukHPpgPbT6PuRiNkg/qWEpN/Fiktu23HUuInjgE0DZK9OgfGrJD8jKWJ8XPo2thK/lLj79dYFEIycV0hWTMpnpM7CxB+mfVvipRgRMRrILz6+j239H0sZR6SvNOWIvpM1BvGmo0JV3YMLQ4VD0cNMLHYjcn6ZQwlozdV0w85mkOdBMfd7sayDIlmeF3/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqaAbxDVkSgXUEBPdJuQEe813YLXOa57DE6CRLaqAnc=;
 b=Dkq2S3PAx0PQ0FubAFJOI07jGS/RhwILMgQOq/pGW8fvYwPlJcjg/JKlXN51iIFJituaYsN4yG/tbHk8qXCcaiUo8XhzMDAYWK5dvry3sHXcqfk3agGSbMSbkP/l/pcy3wmXSn/aKQ/J3pPB+V+RvCGfKFfxT/jeWqk02RJlitA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6214.namprd10.prod.outlook.com (2603:10b6:930:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.8; Tue, 14 Feb
 2023 15:05:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6111.010; Tue, 14 Feb 2023
 15:05:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@kernel.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: allow reaping files that are still under writeback
Thread-Topic: [PATCH] nfsd: allow reaping files that are still under writeback
Thread-Index: AQHZP+kYZqo+lvM+xk+OVBsJow3AIK7OhuYAgAADi4CAAAEzAA==
Date:   Tue, 14 Feb 2023 15:05:10 +0000
Message-ID: <21FDFADF-FAA8-4526-80CB-9ECCB2F937CF@oracle.com>
References: <20230213202346.291008-1-jlayton@kernel.org>
 <E1A055FD-45C3-47A0-A6CB-296C84985D43@oracle.com>
 <d7eea987852cffb5fc719310ed01f771390d60d2.camel@kernel.org>
In-Reply-To: <d7eea987852cffb5fc719310ed01f771390d60d2.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY5PR10MB6214:EE_
x-ms-office365-filtering-correlation-id: e45d4c36-8310-4689-9cc2-08db0e9cde2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 98od5wFa73QAVa+5HyyiSEFSVuEZkS/kDeimXChKarE03nY7+a1H0751C2nx3vXP9/DaxiOexm1cLMWYiPulFzxj7/Ze+xBvDxHjZI/5fS/mBIHdlwEFyTFOZ8wzjqxbmu4voQZcNyiJNXYE7wQOCM52brBBeYdFlloHwWGzUULnXmXktMZ+kNBBY5KqNWBPn/7MaMoj471fVN4b48mB/TWMselYgBThkrV+NO/KpkCrn73RsdwLRdDWhIxYGJEjF93jwCLKab00SxleSKGtS93A3pibWssCSa7fXwArBSjaUdTnji0D01kFNd8S9QhYPjDeloA2yoZ6Ay0CNEhytN27cAD2Q5l2nxtFcRhq9ozuJ9TWV7A/X6Rh6qgLdYfqxPn74zfS0AmeWgBXxRygWcUJn+fu7xUpybuS20f9fygBCD0WnYdXpxjlBXWeazE4ui/PR4fF+RhLF9X2hTUBgxnMZgKK0e+WYEv50HB/UEmYS6oOQZgMKUbILZ0CDp9ufbjmNw5LQ6cB6tadGt7F37OzaIzB73ak+3UM21b/w0PjYOp+knGkdXpg+SIgdHZiVJGiTKX13KyLgGjHLo/PVlmXiA7YXc5V7Z0s2+LcnSBv61JVj6UG/zAMf+FkyiHiO8pwmPj3k+NZZrTHYap8jrDPnk9qUOn9V8Hw7bh3Gi6oIzSjZvzGu7AaV4XvNsK5KItaeTenx9e4I464AYIw79KyWesMEfGEMb1J8NH9HuE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199018)(91956017)(4326008)(76116006)(8676002)(83380400001)(66946007)(6916009)(66476007)(66556008)(66446008)(41300700001)(54906003)(64756008)(316002)(6512007)(186003)(38070700005)(26005)(33656002)(53546011)(66899018)(36756003)(8936002)(71200400001)(6506007)(38100700002)(5660300002)(478600001)(86362001)(122000001)(2906002)(6486002)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TR9o5L5f/OTHDkTXvBSSJED2Vtg1RlP7sx+PE8DRku+D5ulQJ9hBUPYooG6Z?=
 =?us-ascii?Q?gkUFTyL8oILkJvP68JTYaqEYQwptCcQqOHjCiKI5+bJkIInr3qtwgu3ihT/c?=
 =?us-ascii?Q?J0IwKHyh8ei+RN90+lqNVagi4Ob7LtFgr92wzpzRiBNa6hWJUEUJQ6v48zEL?=
 =?us-ascii?Q?yTa+qQb9FlX1AHkdMeXx6bmmxALB17z6t5eL613tZVS/3f6ZedbycoA+PSTw?=
 =?us-ascii?Q?bttNCo5+YHbZYeRBgCU31+Li2Z2EP+FOJT1NmrwI5ayvFMuOhwQhw2FZRsZ1?=
 =?us-ascii?Q?VW1nkeOxtKLWcmPh6HyBjXM4LH+EnTl8o3jk81ySAVK/EbeYq8owgAFlZcnv?=
 =?us-ascii?Q?p7s1xnY5aPVEwtRVi3epnXLVPMBdC+usrp+NUBKiiFdi/sFdGH6JUtMgvg6N?=
 =?us-ascii?Q?kHUZ8S0407RvGxC6LqVMQLiTCTe86Bh7nJCZL+N2CHCT9wjaiRzwrgmtiw90?=
 =?us-ascii?Q?4qkLaYmXNmbTF9fjM0UeXsCEqzaAN4/dbLiOA+iWH1Z5H6oFhUVF289vNULj?=
 =?us-ascii?Q?iGM8+kXjLMF1Oo8UizFtMVkJktEUw03mwkdeXK7Erh2t3FBW7ZNt6GyVyqOR?=
 =?us-ascii?Q?9O5lRrhASNyA3ORL+ZX69aCpSAbbb9NEGdHt6WK2/X1fKEhh7fcx0Sb8oXbD?=
 =?us-ascii?Q?fsg/SFnbE1U3t6bWQBqI0pqa7Z5dCbN2/p1g7JQlxnOY6i0CnmFmUPvkZlHd?=
 =?us-ascii?Q?46zk4ms/5z5wTI3C5t4pz2GfVzv7nt7210Ebsmkqe1d6TFuAVCFcHngTmvWg?=
 =?us-ascii?Q?ihoxYcVvviw7TE3brWJ/DIIDla8x1cTxsWYKzdt5073EnXJQUYnUZLjXv2m1?=
 =?us-ascii?Q?Lwhk4fPNQBTSsfjmRdni+w9j9ekCMs93AJewHs8oDr3qrcaQ+R9VIRfG8RMx?=
 =?us-ascii?Q?V76FAu+l4+P0AbN6RM8LFk3vF8oRSMgO08eLiHZ2F7mCSfiDrS5BksWFl7Nt?=
 =?us-ascii?Q?knt4qRiFdVd8SxKj6JFBJq28CURv0icdEvZ68yrBxOUJpDJwJjxbgmenelRn?=
 =?us-ascii?Q?90+9kZGczI+/nzdyqr/wCqLUr5SYoN7vYgw7iNWmViKkkSNlMnErBpM5wNIw?=
 =?us-ascii?Q?sjgpbijv8zRZKMwrZut6t7rhi6x/owM5HxDEvjyzUnfAke3XgXrWk6Q5sMtK?=
 =?us-ascii?Q?W2BSqmviQzjdTp1Oity5/g7Yj/C3YHgQWtBcHCrYYutZ8EktKF2NPzgWSz4L?=
 =?us-ascii?Q?XbQOrtgek22YFPG3H/6rJITDq+DyDvneEwecYw/WjmTt9QH07PW/dSFraw+K?=
 =?us-ascii?Q?VV0zudgjQcYe5SlTzZP7KRCD+WTWb4RK8zn6SNcf6olxIacvwS0fQOaigZkO?=
 =?us-ascii?Q?1zf4JHRJo93fnAmLtCJ27zbUzP6jcklQaCiydbt1+BVbiBHU0V4KNR/zdX8Y?=
 =?us-ascii?Q?vDB88Q2MqhlpB/9OE4NZfPRKiuG9ohOFt8nZCL2cA8qwAhQPGU/c+4WzYegM?=
 =?us-ascii?Q?p1mjH/ZJkRU1u4clIMheyHfz0fsj7SjrAfStQWjAcnSEvE4CoUa5zoKtH8tn?=
 =?us-ascii?Q?9WKhDew00HyNHVB9TVoJ/v5yATX8C3hsif5grTmdfBeisAHrVaKzjeg9q34/?=
 =?us-ascii?Q?jPI6GTcMohQh+8t8IptrBOaV6RBtYATo979PIX6F29y0a6X0WKVv0c6ReFVK?=
 =?us-ascii?Q?PA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EBB7E97A844E0C42881D2761FE295F3C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cIAjUWHL9qKX7rPl3T/2Bypqjr1IJBANqAQ/3mXxAuEp8F2JlOIiWca+ZYCZBQJjbZ/F/6dQqkAV7Kbh9vg5B2l4TqHmOA5qwunzGNM98t/T+9ySDScseXRD5lZ8aAdlVMrTVdUfbVfcf7vyCtFa9w5zKjySpq9z4HrhNPSHnf+LXX/k+wY8vM7/2STGDtHT2be66ZMJdTCqdJrpaGJpJQar4kNoNOoXyG1xWqJo1OtQeiQwuW8VOvqH96xPI4RzJAh6bGKVoW4qBMD2bxxDVID7Jt+CHX7sP3GQoqrkNgiyVmvEnNvn8tF6Ljuj2huBZe6+dzl3mlAZv0sK+6hzfDhA+nawWW2nbJ95uw8W/8VKQLw9gkYVsq0aVlFa4h59ttTBPwPsP8n98wWoRvvY9hhD8z9SDzswKJ5oDLqf+Kx2elNybyemOxu1e6SctB+Y1uGS1DIUkqq77i9H6Ma833ATDMzPpy1t3kd+B+zehMhIXWYt7I3x3+e+5ZyH5s5/xmIUVZW2+2Mwz4o0bwcFCgi4TMHPmAovx4VHz4z3susGMzHbtZr/mUysb3bnATg/tEjXmbs6fazvcKN+foqSMf1mzSpS/oJmvVZ6D5TK/oWjK3HC3J/ltM17VI7w1iwoo/SO1OMWEgc3UgCvzfwMC5u0N3kPt5XaxOtE01JSudxuK9GG0f6oAvlvue5TMosmZbBXuqj562ztYFh4CJVtApBWd9NX38RwkOuP23Yq9WW4+vQNG4ONCt9QPRtnShWhC6I3raGAu7/TAawKNGbIoU9FoOOxMXaAcnuYdiUw82Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45d4c36-8310-4689-9cc2-08db0e9cde2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 15:05:10.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNX2Yzv8syk/yvuGE4FBWG1wN6w7+8ACSkC60mGWK3XOHkraIUbYuT3CEu1FantwyDbs1PykTimLM6IXDF6VZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_10,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302140129
X-Proofpoint-ORIG-GUID: jGy5WV7GlT5ZN3cQo0x2seHToPdbkEfG
X-Proofpoint-GUID: jGy5WV7GlT5ZN3cQo0x2seHToPdbkEfG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 14, 2023, at 10:00 AM, Trond Myklebust <trondmy@kernel.org> wrote:
>=20
> On Tue, 2023-02-14 at 14:48 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Feb 13, 2023, at 3:23 PM, Jeff Layton <jlayton@kernel.org>
>>> wrote:
>>>=20
>>> There's no reason to delay reaping an nfsd_file just because its
>>> underlying inode is still under writeback. nfsd just relies on
>>> client
>>> activity or the local flusher threads to do writeback.
>>>=20
>>> Holding the file open does nothing to facilitate that, nor does it
>>> help
>>> with tracking errors. Just allow it to close and let the kernel do
>>> writeback as it normally would.
>>>=20
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>=20
>> Thanks! Applied to topic-filecache-cleanups.
>>=20
>>=20
>>> ---
>>> fs/nfsd/filecache.c | 22 ----------------------
>>> 1 file changed, 22 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index e6617431df7c..3b9a10378c83 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -296,19 +296,6 @@ nfsd_file_free(struct nfsd_file *nf)
>>>         call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
>>> }
>>>=20
>>> -static bool
>>> -nfsd_file_check_writeback(struct nfsd_file *nf)
>>> -{
>>> -       struct file *file =3D nf->nf_file;
>>> -       struct address_space *mapping;
>>> -
>>> -       if (!file || !(file->f_mode & FMODE_WRITE))
>>> -               return false;
>>> -       mapping =3D file->f_mapping;
>>> -       return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
>>> -               mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>>> -}
>>> -
>>> static bool nfsd_file_lru_add(struct nfsd_file *nf)
>>> {
>>>         set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
>>> @@ -438,15 +425,6 @@ nfsd_file_lru_cb(struct list_head *item,
>>> struct list_lru_one *lru,
>>>         /* We should only be dealing with GC entries here */
>>>         WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
>>>=20
>>> -       /*
>>> -        * Don't throw out files that are still undergoing I/O or
>>> -        * that have uncleared errors pending.
>>> -        */
>>> -       if (nfsd_file_check_writeback(nf)) {
>>> -               trace_nfsd_file_gc_writeback(nf);
>>> -               return LRU_SKIP;
>>> -       }
>>> -
>>>         /* If it was recently added to the list, skip it */
>>>         if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf-
>>>> nf_flags)) {
>>>                 trace_nfsd_file_gc_referenced(nf);
>>> --=20
>>> 2.39.1
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> Wait... There is a good reason for wanting to do this in the case of
> NFS re-exports, since close() is a very expensive operation if the file
> has dirty data.

Then perhaps skipping these files can be gated on an EXPORT_OP flag?


--
Chuck Lever



