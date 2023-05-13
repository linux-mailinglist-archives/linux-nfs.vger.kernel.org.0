Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967F97013F1
	for <lists+linux-nfs@lfdr.de>; Sat, 13 May 2023 04:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241611AbjEMCWR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 May 2023 22:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241485AbjEMCWQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 May 2023 22:22:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0444D1734;
        Fri, 12 May 2023 19:22:14 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CNBSCW017783;
        Sat, 13 May 2023 02:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zljoiTIaCzpdt4YopAZfgcb5wjoN0UwTKCQg2D9N5oo=;
 b=TB1cVCuNqjKRXiHAy9LIvXq3+H2/MRE4oOPNeF6RCu0HbC8QCT+3NQJT0xLZPUMR2ysY
 hZc0KFxzdnTDWAtZjY0Ew/EkLX2pQqQNUO3g5kdXTj6wFRHNaehhGnuks2mCuo8AtcOO
 R3WPGD1b9KxL74GPpCPnVoAZp9BU/wo+8YNghATZnl3t5dnSghMlTrqIbuVBiTA+yRV/
 Xj2/wJLmOt3TzmW4HyOuNmROlkASNh6emzHBhYCrJFq8OaPiQdnrlVwkgxn7cN8pFK2D
 ZVmaye+w5XdQ25NnQxfe+bfdBM1gz86q1UuiMYAcSHm9Wm6GJpDUgaP1Vc8lu7JC9iKI bQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qhje7kk3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 May 2023 02:22:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34D1XlKu033113;
        Sat, 13 May 2023 02:22:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106gv45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 May 2023 02:22:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNQb/4k9M//Le/VYrX0KfTmT9aeqgGc4qpWXcoCZuSbbLSCsb1pj1mj6//NNkh049R6CdkpNP2oYtZUhZNfgzWRiFNvmAV7Opz0D9XZjevYyyWUbow41LWXG/m7BxycJItTC6FdolVRkcAXDaHgqGdlReSaLz9V083aeObfcKhEB+Bs7SkuLEW/ur6pl+AUZ2c5h+3cdFuhOCGV/P5gvh4J5FwJNrDd+7gvOL474DSHuqntXkFPUxr2NxFCxYn/FjY2WDnLwGbG9GRrVpvzEvH6yXxaDC6iIJFxBkYr5h1/or1LXxGnuTX4xm0qCVO9HRWitAAUe3kFr2Gwvi2Rd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zljoiTIaCzpdt4YopAZfgcb5wjoN0UwTKCQg2D9N5oo=;
 b=DRmH6H59kagZ42hDn4Mu6joer1okUv5ZPXPxXRS4S20SzyhEZeEVchh468l2kAHI8cG1vcfHmavEylv9ol5hnfRbBz/fOfQWk58TqEKiY/VykgQA0QjVk3rAC6ktL7jlSKCrpAThxupxY0X7Z9B70V2v26b9hwZZZmVF//Ubs1XH2UknzRDf2xbrvjhLF3PneZ4ctBu9V5sgW7H2ge4SWJZXjs/S3Uhhn5vIVIS2QQUVM7CQ0DJJamYEkl3+9UuSxk9XeqGdyijDyfOvaUARZLturSnqhMl9Lbqk6gxYUje/QYTUDo38AhGJRFOZUn2iuwLgY2LGlsS4eSvabhejxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zljoiTIaCzpdt4YopAZfgcb5wjoN0UwTKCQg2D9N5oo=;
 b=obbg005mEJYpg0yh2SdCgNRp3ZBPbyUlvwZOKykNNxwvn93KwxoaRSaVrggmU5C2ka9UvzrgJp6ygVIiJGIyuMwi96pOEQ+Q4F706IbiKhmQOjND4aD6bscuJ38r9T/sajGSC3Q/OaQ+HYpjvnHS+tIkRGnzzaIkhmhEUoISmlg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Sat, 13 May
 2023 02:22:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6387.027; Sat, 13 May 2023
 02:22:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: Remove all occurences of strlcpy
Thread-Topic: [PATCH v2] NFSD: Remove all occurences of strlcpy
Thread-Index: AQHZhOJYGV62rs3GkUCJMHqFG7AZcq9WvaEAgAAnyoCAADM6AIAAYPYA
Date:   Sat, 13 May 2023 02:22:06 +0000
Message-ID: <A1414FC8-9CE0-4B8C-ABB1-2365E2F62B10@oracle.com>
References: <20230512145356.396567-1-azeemshaikh38@gmail.com>
 <109A2974-3AE0-48C6-8EE3-FADE95E8EF30@oracle.com>
 <5E054593-8995-46FF-824E-55B18BF53BE2@oracle.com>
 <CADmuW3UQ-wqobay34PY+myyk1Pr7s-cf7b-U7TUCnarEf+jsxg@mail.gmail.com>
In-Reply-To: <CADmuW3UQ-wqobay34PY+myyk1Pr7s-cf7b-U7TUCnarEf+jsxg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5550:EE_
x-ms-office365-filtering-correlation-id: 3ab03eb8-e56f-4895-06f5-08db5358d936
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mNloVlaB5VAp/g7ZDguKv7Ri1dPoinfiQsoXr7yV9D+9O2MzNtGkMvI3ZT27b5W/1ubQ+MpR9s2MpiXvrDh5TWTDND72VluJOYC5FTbzXjwfEczoRtOE01TZEjJqJ+1dtZsAIl5eW8bt/3pFIvugra+3vnF4+GyMkdVkydC+kT+mCfeXi+UspNrKMZ20/G4HEfRmMyq5PNjYgIKUDfQSg/nNiStKQa+r62Ny+7BDeooIGS7Qb/XlHkpti0Nid9Ea/FtdOuu4B0TJJG+FTNNysL3YED9AD9c11KiCA6Uq+O7LLGfZng3VI9baivWc8uve/zjqGXqk1cUvlptteYtj8SmTLhVrLVYi3EiIh3+CbVgDqPuo9qbL/zsqH2rIsg1bP1fwKqghdAiDh7Bx1REUDW5QwLc+x926plsCS7k3x5wu2WJJoD4gIk/v78HANGr7N6pSvF1XCwXSc6cwT/jRZB0I0oOMSU/einfGXY08xYZZtMf37esSHk4QP/5I2qErXymUqFbZHbcz7eBToYnhkNIhfaN+6vxycwFTFQyhMxITEntKUjPvj01BrytFhhjTXtbdmJjrpLccXY5bnqo6cGymNBsRC6CL7428zJH/GBlQwSeQnTYDSRkNbMVBjUnt48dcjHoBr0AVB4ZlKY6aIojClfUzu0jjuLxKT+Hx4Vn58+z0ugDa2X695RmFh+iTg/AqxJ6m1DzwyK9X9QpmNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199021)(66476007)(8676002)(316002)(8936002)(41300700001)(5660300002)(66446008)(66556008)(64756008)(91956017)(66946007)(76116006)(2906002)(54906003)(6916009)(4326008)(478600001)(71200400001)(53546011)(6486002)(86362001)(966005)(26005)(6512007)(186003)(6506007)(83380400001)(2616005)(33656002)(122000001)(38070700005)(38100700002)(36756003)(156123004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KUQ8/0qBBL3eysaAII/z5MfUnKswmztCbeSaN7V0FijlfNIl+bFgSwb60559?=
 =?us-ascii?Q?/AAgoAtIrBL3WmhOOJTe4FegGZiI3y5shiMRvm5lcBp3+sBH5YG5pDsRYnQX?=
 =?us-ascii?Q?lItR7aAECFS9LNr/XPZB7XrF7KFeRazthaYacyCZSbjCfj3AkqT113qkRWtP?=
 =?us-ascii?Q?iDRS0071uM2utdj2+ULZyuCIqk/34CqrRrPDUxnSWgPK2dk46LnSVMQOJ7zr?=
 =?us-ascii?Q?vI/zBdUiIWfdsSenhTJ+EtTPIkJgiWuhb4/s9l6fwvpIX9780w7wmZ/x1su6?=
 =?us-ascii?Q?SsTkqUuntl0cE9a023hjHnjYzGdWBBs0UHX2wpTNxdmasthZLkw/4b4tSXXB?=
 =?us-ascii?Q?gln6eBf02n+0/d2AyADlrjJuz6La3/3yrzP2mYhoZHSMCBZ4dbVt8ccJcXjo?=
 =?us-ascii?Q?covSnKguGFWXYX/IkYlOddFbeqFyczWsaeKDRwgZGnyDa0qHElcRb01wdW8+?=
 =?us-ascii?Q?m5t3hk16umllGepvg0gX17o0mUNRWU64q8WVHA5odoO/jRYHN/2giNJJMJXq?=
 =?us-ascii?Q?xJMxWgGDiT9LJA+QJh0+9l0Ie8P5A55If3xTpLsgAa2my1N2rnR+UdynKogS?=
 =?us-ascii?Q?l3XgYS3ceJcWWmAM5rsxeLGdhki+0c2b/if22WF4cRR9CchsPSb3n0CY1Bmp?=
 =?us-ascii?Q?+Vv2w2tDck1ZGO8aKRA1qwezUgzNP92jBSBnrviS4qZFYn4ONKFR2C+xYE8e?=
 =?us-ascii?Q?Mz+gPElRlumL2T6j2lmyBK8qeAvLea8E5SXq1SY3OKBCqnNGQPCtI1z72uqt?=
 =?us-ascii?Q?NSxY8bMhXAx0kgH8RUE/RF1At3NTgWnA8GHWjjJIvbkcjhFKvaXtfpsL7c1z?=
 =?us-ascii?Q?EC0pAj8FXqNT2e2+Ozv/0MzlqkKromGAGv0MvRLAeOffifscjHt3JQp66mY9?=
 =?us-ascii?Q?P0O0nK/EofQ2PW+Fs7uU5ULkg7zHlEaXED5aFSQDRazsVXr1EhwBD4yf/vsF?=
 =?us-ascii?Q?CSKYq1FwNxG294PytFFULv68bHNkoRDBuilOdOlhiw5TY3YxCcKOp9fzIHAn?=
 =?us-ascii?Q?4MNl7ue0VLUL4uPUZ2KRH+gii5s8ihM3Zi3Gb6mBiSSL/ldrHS4sK52moMhN?=
 =?us-ascii?Q?ylIwAth3a4RThbnOWnrjXBFUkWaK3wmu6ZpAuXKJmsJSihoDklo+h3YVT/3w?=
 =?us-ascii?Q?V1NGEsHaR9gGUU4AvPuPnIEj5WsPaQ9KQ1z5nDNBGOYAPe8e5Tj38cSHhrAY?=
 =?us-ascii?Q?1vznXKi6uA+KXm9MVAKrfPaXsKUYI+tR09Bky3ukKtT1ynSUFJkZre4TrjA5?=
 =?us-ascii?Q?PBfMAKbikteqcXE7yikHFyK4dZyQMEfRRHgTDFZWzne1FFnBnU9u9jsjET+n?=
 =?us-ascii?Q?plxk/IG9J5Il3kslktZ5Mse6+WAobKdL7movuwnl1uSukOfLhNRToA3sLwco?=
 =?us-ascii?Q?Gh7qJpyZFmIx8TsAZc8qd6gkHoUyNrkU+RrcjQ5S7S7Jh8s1pWXiyRLf4ilc?=
 =?us-ascii?Q?eKPNm8a5lZUPcMmxpopUD12iBNIh6A6bhD3aAzSCYh470ldOXnBZeh5hyHt9?=
 =?us-ascii?Q?McetdHySH9n0lX7ufxtkLcYNLsPapRiW3bD+U1EDvuOHf01FIwMn1V4UmHl9?=
 =?us-ascii?Q?p3MPKze0+XVSTkU795hl0iBoENa0DZGDoIb9i7PRefuZDmB0QTkdEqCwbb+G?=
 =?us-ascii?Q?2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E8CB8EBB156DB48BC2C050D7D49A5F9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ic3kNtDaHpLDQwOLZq80qQCjZTMMwXriZHfjf4RDgwA6/f4A4r0P2NdIpsQDqjIPLQgMy83mu5W4aVfqgxsInoqtm80VdzdMjgU8QK0rgT5ZNYqUzwsW2xsFEiLOLntVFJIjjdg4uu5UpBo5C4X4ZTf5r3necdK7mrU73/gfl5ePQjEC+AtA1DY1iXLDLQmCTgBZQLCAIBDxAYRFP/zz6FntGlfvv4qK/cdqUIR6I1EGKkZku2VvPhHF1ZJZsAy0P1lnvRpGyUiHpONO6DxAGB6PYNMsQVUDZqceWbGs6F+VlsOjnODv0kIfeo/206pqLmfBMf/FoT2FcOYGyiZ+xBmawkEePkaeekdR+hEG0oDDzxXD+ClYDhABP6vDYri9OPYwkbPnLuV3aLJd66cSUuW8U3RDHTHdZVJlfqMPMOaCtYWjsPyZ2VziCaklg4ngpoyL+47AY2/bOBP2yrQ6tE3xnFdMM2oQPjhYtmK+oUsV8VpaVXKVVm5ysYAU8dang52D8OfxxVFOPmLcqQqIlfZioa9TPfsieFbDn1s6voewL0WbUQxYpa/KeRbJJJZxUOy9tu2JAdqiMvJPSrZhXS5c+e590AUvvXONIPDGN/u35jp8NiZMbuxTC4jzfMPpN98RYrKiT3HsviefsHGvDm/dh+qvE1TDDoqFe04AS79oCa9ZaBBvmY0tu/mstwnjtb1E3ByuXN+65M+5OVEAxRkdlx3KqEwOszlchCFRBraiht85T+ndhUw0LCXTYKUGokEN6QwbfqweM2YKkFeKGHdyRVR51Ko0RbQ3jk73OeP4Qqu056luCyHcVZ6GmvQ//vwZ2MeAiyjp4mt6ZwkFr7/Kp37daEqZe/AlK2ZkUBg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab03eb8-e56f-4895-06f5-08db5358d936
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2023 02:22:06.9359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gl24GmmQvyRJ+c2wWhSn/EXVU/RF/OWhcZmkylcZ3hiR2AtcjQyy27bseqgUhr7109oq97w8jtKCZeuQ47QMoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5550
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=690 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305130019
X-Proofpoint-ORIG-GUID: prYzhowC0LyDXWBGb93mWRuB0lcw1Ivd
X-Proofpoint-GUID: prYzhowC0LyDXWBGb93mWRuB0lcw1Ivd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 12, 2023, at 1:34 PM, Azeem Shaikh <azeemshaikh38@gmail.com> wrote=
:
>=20
> Resending as plain text.
>=20
>>>> strlcpy() reads the entire source buffer first.
>>>> This read may exceed the destination size limit.
>>>> This is both inefficient and can lead to linear read
>>>> overflows if a source string is not NUL-terminated [1].
>>>> In an effort to remove strlcpy() completely [2], replace
>>>> strlcpy here.
>>>=20
>>> Let's update the patch description. This change is really
>>> a clean up -- it doesn't address the memory issues you
>>> originally described.
>>=20
>> Unless, of course, you intend to apply this patch /after/
>> a patch that fixes __assign_str(). In that case, no change
>> to the patch description is needed.
>=20
> No, I plan to land this patch before attempting to fix __assign_str itsel=
f.
> Let me know if the below description looks good to you and I'll send
> over a v3 patch:
>=20
> [PATCH v3] NFSD: Remove open coding of string copy
>=20
> Instead of open coding a __dynamic_array(), use the __string() and
> __assign_str()
> helper macros that exist for this kind of use case.
>=20
> Part of an effort to remove deprecated strlcpy() [1] completely from the
> kernel[2].
>=20
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>=20
> Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

This looks good to me. So you'd like me to take this through
the nfsd tree, possibly for 6.4-rc ?


--
Chuck Lever


