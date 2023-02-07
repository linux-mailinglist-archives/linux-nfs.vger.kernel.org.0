Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965F268DD10
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Feb 2023 16:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjBGPan (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Feb 2023 10:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjBGPam (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Feb 2023 10:30:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0BC22DCB
        for <linux-nfs@vger.kernel.org>; Tue,  7 Feb 2023 07:30:37 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317DxJoO016381;
        Tue, 7 Feb 2023 15:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xyy+OR2p5qSKljS5Jb6CmDp9349H7uipZENORLlyss4=;
 b=Y8KZmiIgrrOQtoQddQLikK9suaR2jYcPMbfxnyEObbcodxgQufw+Ce05TJWemhWal3cs
 IhUKc8n/esZxQTETWev7BASghFFLfklD/7Vxpd5VH/d4hl0ewLK8Yth3MONsYXLuwFq6
 F/aUcD4fqXVA5nVoEvBE6E3Mtk+hD5K0aYrq88EnnfMmVlh+eA+50FCQfa8BYRJvZZNl
 VDml7Ls4VDQFuBzClPmAg1PDAekpL0/44DwBT/HkgRtbO0dDKtt2lY5CE4++lzn52CA2
 id59JiP6pw8j6ImEkitv8+1BO53gZHr3aIQQi9NeSQLGlhU/LPa6xH+FtvIuFzVKH+MM Hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheytwuaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 15:30:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 317FGpgE032727;
        Tue, 7 Feb 2023 15:30:17 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtc2er2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 15:30:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7z1dFng37b7AQ9MntQcar2GWTlIJ3yQ5Jth5OzsgSBK13/+iumTCPPL+WpoX/Bqphmu08t2LPfkN6ZuKR9Tojuz6EnTs6Z7DiF34Qgb+vQrxc32/BN1msqCu1nLrLCVuvymMhDpVlq5OZwjieNHE/bLFogwmkldmf01fNoZnec43BM26IFQu8y0VkWaJ03um7tR/PvsbH0exe25gFkYWOIYJZnZ5oUs4l/sr8mYhv0N8hO0h2lUWXvzFjDaveWBlq3/Y4GRO08ArC00LtfFrN7mC9hwPuhdLLAMAEA0qdY4OQ2G9WC2DTpbvNssEOD3q5pFkBfr+u8KeVRUSwxagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyy+OR2p5qSKljS5Jb6CmDp9349H7uipZENORLlyss4=;
 b=UJRfkhkmfPQSsWsfktjNrAkTA5Ik2qCGbxc5KiZL0/RIm3e+nTSifFZau+a3i4+DW0u2KFEu6JXS/ezEOKb7fS8+uFsOn6e1kXBAeylR1KfGvn7Y1xXU7mTccYEfjf64ZFthSE9kSLEYaLEsg1y8Waae+41MbdB6lzI1fS9jtlQRwYhBeQ6e2kXRg5gov+pxC96aMKIbLxYxJBkdXCbcq3x4DD6ABfkkSlrChrMAlwZhnj180teTI/MzqtZUvLJNzlDgjrm+Ghk2XLdFmCr7LSw7+m7ksvulkzbFvVev6vHAS7mZmHFwV3yLZWundqj4Nbab3+195SfT7OvoEDVz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyy+OR2p5qSKljS5Jb6CmDp9349H7uipZENORLlyss4=;
 b=Op3q9mnDwGSgiKZmTnJo3DBJI4Sb1CiIgTqtgEOTznT/2LsiKJCUoW4hXeKydSkZAmdBEXFtoe06LeA7KNmVnac548vopEU8GLHMdzekPtTaypjYJNPBwz8OwcETPcfx5075mz5Hc3yTp29nAGLsRc8mBfN6zrDQBZZmhEPUylw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5618.namprd10.prod.outlook.com (2603:10b6:303:149::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.11; Tue, 7 Feb
 2023 15:30:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%6]) with mapi id 15.20.6086.015; Tue, 7 Feb 2023
 15:30:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Pierguido Lambri <plambri@redhat.com>
Subject: Re: [PATCH] nfsd: don't fsync nfsd_files on last close
Thread-Topic: [PATCH] nfsd: don't fsync nfsd_files on last close
Thread-Index: AQHZOwOLyJLMqY1kMEWJKMRFv6gLCa7DlAqAgAAD4QCAAAQxAA==
Date:   Tue, 7 Feb 2023 15:30:13 +0000
Message-ID: <C7ED924A-6A48-4143-A327-CEAF94CDB062@oracle.com>
References: <20230207145030.90123-1-jlayton@kernel.org>
 <90CCAB9B-935F-4450-8AE8-7F3C902A5402@oracle.com>
 <9137413986ba9c2e83c030513fa9ae3358f30a85.camel@kernel.org>
In-Reply-To: <9137413986ba9c2e83c030513fa9ae3358f30a85.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO6PR10MB5618:EE_
x-ms-office365-filtering-correlation-id: fb88469e-f17a-4e05-5423-08db0920352e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NprimMiegIk6Y6ReCkl9kkpGFGzXNDGjeovILwDqD0dY8DwIJXceEF8WdxC13hsirZdOaGHlhbvj8JLufE4iYvqVitdXlK223ZyYVj2vimEimyn4gqgOtXwTQniSfxnj56flN4To14es4cxplcs2HPEOK76TUK+U7DhPa9DKRP6M6V/wiTfqC6wpJu65h74uDdati7obsT/Xk4tSwI3Pp+p82vhL8RscudAAZlinqv2pAFGEWhGlALblpC5OlPbPmfv6Cjk9h6kqHTYUCTHMHrt6SCraZu93jLWEq9mThWvgJSwMzabyGmeVONOnqXkZyWnYYOYAfJtue7elWBQfMj0x/6d9RHz6qe3WI7o/wltOO4aec8pWjU2c/8rkXMXA7ymHdlmS03GszZBbHZ4PQ11zk7XpcURmYqH4iDm+2vPGKQpE9FYmYFLDjg6l8Xm20POgUnmvmrtJVOnpUlXuAS1oHoRIPnYYWe5tZfxuIuhNuG9o0wjXICm69POXyS55UP3CGqi4ZrVRK1A1qrcNhHxCsVHrgedZDhKSBfrvt1lvU+oY4N7ipUX3Dp0j69XU8Ao1VmZcEltzevMrJ1NwYj45/+Z+zjso9aX1tfHW+Pf8XanD8qc1Qq+UJqHnc7B4cFfZmX0OuBqhukjXT4qRxUIGkHuUNjgCdD2TDJHk13MKGRQV6cE0/m/gTP8kFARcrK1ffKJooGKs77ZQcEcOBiYuohDY8fOjJUSslsPfuaQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199018)(54906003)(33656002)(83380400001)(38070700005)(38100700002)(122000001)(71200400001)(478600001)(2906002)(2616005)(36756003)(6486002)(86362001)(6506007)(53546011)(6512007)(26005)(186003)(8676002)(66446008)(64756008)(41300700001)(8936002)(6916009)(4326008)(66476007)(5660300002)(76116006)(66556008)(66946007)(91956017)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Cfcoe/C+W4yHP0wmiG4C5dcGbZR7OTu6VG6xEAKdfBwzjrmoHE9tHWhpEdd?=
 =?us-ascii?Q?CxMAkE11eifmak+lxBMwg8Cr+ihy4rdW/kL3hMDuQTVEfLQUgoVIiEo8EElH?=
 =?us-ascii?Q?TCZBZ08zetQ5wY1y4ISfQ5Nh/6EYVoX1fOqPJVZ8LD5eDONQf4V/sDFeteAq?=
 =?us-ascii?Q?/JvnBf25HzwJjQSI/vuCFNpg11i0hNhQKwKB2QffZQLi5y6ldG57AeU+2fzE?=
 =?us-ascii?Q?tQxLY6FxLM9zpyPUgra4WzTnw2rNTzwUgT8DhJmlYptWwqN4X+SCygFYUs5Y?=
 =?us-ascii?Q?YE+MIFb2qfzhgBua5VhQWgAOeYplX3h64kqLSGf7V3L4cuZiuypqRZlv/0ae?=
 =?us-ascii?Q?lbgL2+7nXDghCTU3tEwk/DCzpV1hlHA9Tga8MrWli2Mvx4g2AJvsWFxHKMOq?=
 =?us-ascii?Q?kS8akn2Tt7A430Er99ec0GCdl8Q3efgCaSpal0huf2Nv9Spg/pozDmMKcWqO?=
 =?us-ascii?Q?3m7I99rLrcdTtOunGmQBEos7+8lT69VxmfJlMzHc4XZS9pVTqCCBaJCBEI0Y?=
 =?us-ascii?Q?0Xrt9uqiUPVbshNo8mJaep34RHxtrsqiDfyp0eLwQI8+UGk22xDl6QA0Qrdb?=
 =?us-ascii?Q?/bskR2Kucnm/P3Ke4tRwufzqX9XGwyWHS/gWv7MoTmrSCv+0bKj0WyZ/gh5j?=
 =?us-ascii?Q?qL/IxnGm40i5la0XsHIa6JJ2g1DXVvxCg7+HG2xlu2fdvy88HCqYmIFRAE8Q?=
 =?us-ascii?Q?OR8EajhtNJcYD6bJq4ZXDMDMt89PARro5suWAFqz4mgmoi8tPHha2SL8WmGz?=
 =?us-ascii?Q?P+D5WFSaJKTa/ymf3tULwIjx9fWytSciUOlbAJOTPtHqG24QGs72+bSgzICU?=
 =?us-ascii?Q?wCwIfeV2b/Z5KXLmHbZ2UglNmoizaetmsofcgSwptauMnBF6NT8nLSgOt/OE?=
 =?us-ascii?Q?JUtI2QzsuDJgRLpy/w1G1FnPhgnXkQz0txJW+WEk5LCLpngCb0WekMEaoCBs?=
 =?us-ascii?Q?wxd6xkO1jr+O/c3bpRQs9yD745WBEkT6fr5y3yGRR69Pth8Iz9iFLdk8WiES?=
 =?us-ascii?Q?L2K4mCzfAqV4gU0wIGLZphNo4bVKqdfBCV9B87IWXYeFvh/lUERyKJXb5JRo?=
 =?us-ascii?Q?S8EmmOUOg+WKTKKP80E/9fCny1jPKxuOxsrAM4PjTnUtFhz0Fl34AcNxGRqX?=
 =?us-ascii?Q?ty/kjEe4E57b2FyaW+P/dNcXk2eSn601rp1/SoA1bfLc8fCsb+iC93V4MeEg?=
 =?us-ascii?Q?vC4VehPuU8gIkAHYquF6YIf/SQ+m/WpQ5pwmSHCFmbnWnyVsVrJ9ekRm234P?=
 =?us-ascii?Q?Ok7bImABrNntNAV/5iLbl/I1VXbcEbWziljGmqFR0eQiZa3lK+Fhkmf2fgbM?=
 =?us-ascii?Q?4h0NoEl2D6M7tbD36r1/tZ0pujMnmr+xi1ToPvqiMrsCbGHKOhjE18XVU7HB?=
 =?us-ascii?Q?pVJ8+XRwEWj4UZi6AfSDAWlTr+YAWjZl2+4/ri01Hv3p9r1GHuexnzWbmhzS?=
 =?us-ascii?Q?ZVpLdJFyL61s5WTMtMqEWP4KPQBOYwN95LfeKl6GXH1S0ZDtA+x8VBXoC6Bb?=
 =?us-ascii?Q?mv97OAe+tIF1ncM1MGk0eVE6hzzVnLVGhHeaKayeLYb3WeDjUxW2ZDDO9g3c?=
 =?us-ascii?Q?bCCfTbPG629exZi4ean3cT/pLA6qi5BmsE9ahCQPAU5V95JfLiSF32unMVNI?=
 =?us-ascii?Q?Vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AEC8DB821E15C741A5BB0980D57AB896@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 24MSdbO9+ulQJRnKjOBBOmM0jn+ocP4mJlCkw28bvwGtzRC4NQlNFryLj+e5nFOnO+WARvDGzXUcuNiA0y2ccEpkeKaA7yzJA1Rz4NI0Hbxk1P6F9rg3FXq+Q0TdI9MLoBABt3WxECGo4PW494SoFVRVJm2+pbQOrUToQiECLaViJLYcviU0tqxA6sv9bZE1uC/fPo+62g/Yxb1UNsductMxvGQ2QedlU7omOYrdWnvYiHEiNtrqxe/md1bWeRYWXS9YqZR9J4bANB4fPNO5e60KuGeROvJvCQvqJR4SrirrHGx0dxsdxM5jdF+OT0UN3sx0iqev34QbFDszn5z0upm0yJB2G2MzE0RECe0YWFKYC5B+wsXRL8alK9M3ULYfSeCiXF06okylfq1pOZK7PYRD25azL//9oirgWj9/r1poKRKqRXUl0qPQ3/ZgEvQupgS53uoGxJY79yyktHSf8qM78cLGhSjt2xOEJufGHCngqXCzkSJqpN4/RMiVVIqGN6zN2B+T/1de4CQdDa3CjDwcvew1tFivH4LAjVlJHbWln5xaVcgvmqOqZc8BxTzotB0vWIFUWc/vc5Zntu7jy6P4iUbjRaNTMSbl3pMxBwcqn+I6DfPTpcGiPuU6cd2V8ZOsQxO7OSHURrbR4G+zihQg9S/QEMDOmkaxzlDZG/YFkdQlwdqb2bU5jNsKFn2zmCMdbwGHkBlD4bqDXpynVt6u8qyqcFggTnIeHQ3ivTSog83pxf1B/XVEHZ2CCGJsfQRiFgtWYaUApRWt1oT8X9Q0tuR5ahVL5OMwtuGsehdlyYcDBU6HTkizo6ZXvL4W
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb88469e-f17a-4e05-5423-08db0920352e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 15:30:13.8733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTyJNXQjz/mrAKH2OB7cDSJuRhj8UyFsaNBM098x0eRHB5YnXSduDxRO3SnKoxUCTp2KQq9r2MvEnm6ohuR6xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070137
X-Proofpoint-GUID: 1cn8iavIRdgMkEOPd5uEdFbBVIoImvWc
X-Proofpoint-ORIG-GUID: 1cn8iavIRdgMkEOPd5uEdFbBVIoImvWc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 7, 2023, at 10:15 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2023-02-07 at 15:01 +0000, Chuck Lever III wrote:
>>=20
>>> On Feb 7, 2023, at 9:50 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> Most of the time, NFSv4 clients issue a COMMIT before the final CLOSE o=
f
>>> an open stateid, so with NFSv4, the fsync in the nfsd_file_free path is
>>> usually a no-op and doesn't block.
>>>=20
>>> We have a customer running knfsd over very slow storage (XFS over Ceph
>>> RBD). They were using the "async" export option because performance was
>>> more important than data integrity for this application. That export
>>> option turns NFSv4 COMMIT calls into no-ops. Due to the fsync in this
>>> codepath however, their final CLOSE calls would still stall (since a
>>> CLOSE effectively became a COMMIT).
>>>=20
>>> I think this fsync is not strictly necessary. We only use that result t=
o
>>> reset the write verifier. Instead of fsync'ing all of the data when we
>>> free an nfsd_file, we can just check for writeback errors when one is
>>> acquired and when it is freed.
>>>=20
>>> If the client never comes back, then it'll never see the error anyway
>>> and there is no point in resetting it. If an error occurs after the
>>> nfsd_file is removed from the cache but before the inode is evicted,
>>> then it will reset the write verifier on the next nfsd_file_acquire,
>>> (since there will be an unseen error).
>>>=20
>>> The only exception here is if something else opens and fsyncs the file
>>> during that window. Given that local applications work with this
>>> limitation today, I don't see that as an issue.
>>>=20
>>> Reported-and-Tested-by: Pierguido Lambri <plambri@redhat.com>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>=20
>> Seems sensible and clean.
>>=20
>> I would like to queue this in the filecache topic branch, but
>> that means it won't get merged until v6.4 at the earliest. Is
>> that OK?
>>=20
>>=20
>=20
> Thanks! v6.4 would be a little late. Can we get it in for v6.3?
>=20
> Exporting with -o async is (unfortunately) quite common. I suspect we're
> going to see other bug reports due to this. Waiting out a whole cycle
> means wading through a bunch of those (and telling those folks to use
> older kernels until we can get it in).

I will apply this to v6.3 if I can get a Fixes: or Cc: stable tag.
It looks like this is similar to 6b8a94332ee4 ("nfsd: Fix a write
performance regression").

Also one or two more R-b's would be awesome sauce.


>>> ---
>>> fs/nfsd/filecache.c | 48 ++++++++++++++-------------------------------
>>> fs/nfsd/trace.h     | 31 -----------------------------
>>> 2 files changed, 15 insertions(+), 64 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index 136e543ae44b..fcd16ffbf9ad 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -233,37 +233,27 @@ nfsd_file_alloc(struct net *net, struct inode *in=
ode, unsigned char need,
>>> 	return nf;
>>> }
>>>=20
>>> +/**
>>> + * nfsd_file_check_write_error - check for writeback errors on a file
>>> + * @nf: nfsd_file to check for writeback errors
>>> + *
>>> + * Check whether a nfsd_file has an unseen error. Reset the write
>>> + * verifier if so.
>>> + */
>>> static void
>>> -nfsd_file_fsync(struct nfsd_file *nf)
>>> -{
>>> -	struct file *file =3D nf->nf_file;
>>> -	int ret;
>>> -
>>> -	if (!file || !(file->f_mode & FMODE_WRITE))
>>> -		return;
>>> -	ret =3D vfs_fsync(file, 1);
>>> -	trace_nfsd_file_fsync(nf, ret);
>>> -	if (ret)
>>> -		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
>>> -}
>>> -
>>> -static int
>>> nfsd_file_check_write_error(struct nfsd_file *nf)
>>> {
>>> 	struct file *file =3D nf->nf_file;
>>>=20
>>> -	if (!file || !(file->f_mode & FMODE_WRITE))
>>> -		return 0;
>>> -	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err=
));
>>> +	if ((file->f_mode & FMODE_WRITE) &&
>>> +	    filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err)))
>>> +		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
>>> }
>>>=20
>>> static void
>>> nfsd_file_hash_remove(struct nfsd_file *nf)
>>> {
>>> 	trace_nfsd_file_unhash(nf);
>>> -
>>> -	if (nfsd_file_check_write_error(nf))
>>> -		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
>>> 	rhltable_remove(&nfsd_file_rhltable, &nf->nf_rlist,
>>> 			nfsd_file_rhash_params);
>>> }
>>> @@ -289,22 +279,13 @@ nfsd_file_free(struct nfsd_file *nf)
>>> 	this_cpu_add(nfsd_file_total_age, age);
>>>=20
>>> 	nfsd_file_unhash(nf);
>>> -
>>> -	/*
>>> -	 * We call fsync here in order to catch writeback errors. It's not
>>> -	 * strictly required by the protocol, but an nfsd_file could get
>>> -	 * evicted from the cache before a COMMIT comes in. If another
>>> -	 * task were to open that file in the interim and scrape the error,
>>> -	 * then the client may never see it. By calling fsync here, we ensure
>>> -	 * that writeback happens before the entry is freed, and that any
>>> -	 * errors reported result in the write verifier changing.
>>> -	 */
>>> -	nfsd_file_fsync(nf);
>>> -
>>> 	if (nf->nf_mark)
>>> 		nfsd_file_mark_put(nf->nf_mark);
>>> -	if (nf->nf_file)
>>> +
>>> +	if (nf->nf_file) {
>>> +		nfsd_file_check_write_error(nf);
>>> 		filp_close(nf->nf_file, NULL);
>>> +	}
>>>=20
>>> 	/*
>>> 	 * If this item is still linked via nf_lru, that's a bug.
>>> @@ -1080,6 +1061,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>>> out:
>>> 	if (status =3D=3D nfs_ok) {
>>> 		this_cpu_inc(nfsd_file_acquisitions);
>>> +		nfsd_file_check_write_error(nf);
>>> 		*pnf =3D nf;
>>> 	}
>>> 	put_cred(cred);
>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>> index 8f9c82d9e075..4183819ea082 100644
>>> --- a/fs/nfsd/trace.h
>>> +++ b/fs/nfsd/trace.h
>>> @@ -1202,37 +1202,6 @@ TRACE_EVENT(nfsd_file_close,
>>> 	)
>>> );
>>>=20
>>> -TRACE_EVENT(nfsd_file_fsync,
>>> -	TP_PROTO(
>>> -		const struct nfsd_file *nf,
>>> -		int ret
>>> -	),
>>> -	TP_ARGS(nf, ret),
>>> -	TP_STRUCT__entry(
>>> -		__field(void *, nf_inode)
>>> -		__field(int, nf_ref)
>>> -		__field(int, ret)
>>> -		__field(unsigned long, nf_flags)
>>> -		__field(unsigned char, nf_may)
>>> -		__field(struct file *, nf_file)
>>> -	),
>>> -	TP_fast_assign(
>>> -		__entry->nf_inode =3D nf->nf_inode;
>>> -		__entry->nf_ref =3D refcount_read(&nf->nf_ref);
>>> -		__entry->ret =3D ret;
>>> -		__entry->nf_flags =3D nf->nf_flags;
>>> -		__entry->nf_may =3D nf->nf_may;
>>> -		__entry->nf_file =3D nf->nf_file;
>>> -	),
>>> -	TP_printk("inode=3D%p ref=3D%d flags=3D%s may=3D%s nf_file=3D%p ret=
=3D%d",
>>> -		__entry->nf_inode,
>>> -		__entry->nf_ref,
>>> -		show_nf_flags(__entry->nf_flags),
>>> -		show_nfsd_may_flags(__entry->nf_may),
>>> -		__entry->nf_file, __entry->ret
>>> -	)
>>> -);
>>> -
>>> #include "cache.h"
>>>=20
>>> TRACE_DEFINE_ENUM(RC_DROPIT);
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
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



