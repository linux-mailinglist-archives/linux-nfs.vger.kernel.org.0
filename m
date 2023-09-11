Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6AF79BB36
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355494AbjIKWAD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 18:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244432AbjIKUbN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 16:31:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F4DE6;
        Mon, 11 Sep 2023 13:31:03 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJatkj011489;
        Mon, 11 Sep 2023 20:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9uBySJW3BC6n+NxqNwE/DCcGKUP+WsyjPZpAzVyKxHo=;
 b=ShS6EcqCGZRIzaOFa+nbDnoO/3BP3HPKdsSzBB6Ij+IXul2tAcrBRZ479Mxyz+RF7B5P
 ANM6OwCSR4C1FfrPH3VvQUjqLsH48NxYgewxYIj8lDlc2kqKRA944XuLbROCiZzCCHCV
 /33UYPee+9Yy8wH7V7cYT/rzjLV4ZZ4S9cMJ6H99VUbcgI9C52S0/S6Ea/q4igaVjBlL
 15EW36IDUBmUr7yvoju2MFzy6xOyMDaKhvC5dn8ldD9NxwVDen2iiZajXphg4St9Z9pw
 ob6dkgvA3H6+CK9xwGPXqB0XDbObSbYrllQNkBdFnzJP4DLy0UMjiuer0yRd0f8p/Kpn Tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jhqaeue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 20:30:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJYCkf014676;
        Mon, 11 Sep 2023 20:30:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5b12wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 20:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX+5ZJFiwwBKYocES6Z0aUHWeK4GpxEln/JR8sRXFxzUlHvbFCQpPPxspyZa7n9jHhNKJjPIbcypKSo+7dqBgsglk+95siL5L/jCDIU6hLEypuM6You/jdFkiAZyEqSTzRYGxiov2xKEikjRI5D6pvPJJfJYSPi7RV7OE0ch1v9YlaRLpfBO7282GitugtAXjWINuxgk0u5V2p+FH0KjL5MixevkzwHPbb3MAyj8/0hJ4EZnW4wogDjn4KuAFrRv6Db0mjfYJ5ZUzeUS6nlq/zgN+R9tF7RpnjR4BFmwKec3U9nCC5DIT9hz/iJnW+MJHNmSH51YLN5305lPPAkztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uBySJW3BC6n+NxqNwE/DCcGKUP+WsyjPZpAzVyKxHo=;
 b=Q7g0RuSYfyl2bE0jCHPUHcfPRm3DJRaruvC+nJNrzULPsOlUXPgLexU112HYB8pBmXg7gzL/y64pV3NGEwm+q+xU+qQYDEeD6PzBTeMZPMj/UOT2iSy2ECTx4Q+mYXuUm36LxVUfZ0dIgboKuRMnl3gtK+BNrCZvsVNL+It9JQsBBTWswZdgQAFyPdhWmcYl4O3BQCc+9jB7lSGMR5MbM6x++aI41IHBQ3eiSoKewbx3s1E0d1uFnrV7sFBO+931VMudh2+28T6t/xXvfScTaw66XSkNzD1Tyqjto1Y4hFZ8wzpPks11hLrsAFxoOY0NDZ7c2B+0QDfa3J2h3Lt89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uBySJW3BC6n+NxqNwE/DCcGKUP+WsyjPZpAzVyKxHo=;
 b=uCjlvBBn4bhOaADF8gIRFE028Bl6jcyezcfs6cnpZ6AC8LuKiOM/+A0hRmHhZKkz8AZLyD1QotRrtlGoehO8BIcRK+w6AXXQVGEXg4B69n0lShXCt3tpb4u28HiBefkB/OE83CHwAVrIdYW9Ig1K/2zWQWVHUoqBIgupcilf9BU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6679.namprd10.prod.outlook.com (2603:10b6:303:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Mon, 11 Sep
 2023 20:30:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 20:30:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 11/17] lib: add light-weight queuing mechanism.
Thread-Topic: [PATCH v1 11/17] lib: add light-weight queuing mechanism.
Thread-Index: AQHZ5L3S7eczMxv7N0KGYdSIc28+v7AV7d2AgAAmQoA=
Date:   Mon, 11 Sep 2023 20:30:40 +0000
Message-ID: <4D5C2693-40E9-467D-9F2F-59D92CBE9D3B@oracle.com>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
 <169444318342.4327.18355944158180782708.stgit@bazille.1015granger.net>
 <20230911111333.4d1a872330e924a00acb905b@linux-foundation.org>
In-Reply-To: <20230911111333.4d1a872330e924a00acb905b@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6679:EE_
x-ms-office365-filtering-correlation-id: 6c9038c9-ad3d-42db-9706-08dbb305f6e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xicWZoDnXbKZ/GB5iF4+xV917RKWVFa8+/vuvxNI+9I5QlGCjCPyQUyLOnC/oe+ggq/Nr4aPFEqqzrRwChLpE1AVwzu7zwidIamXkvuLvtn63+xNj3/BTXnWOsZTykhPwRflgq5+O+NlQTPvncobXaAPlyKdjPBHIxFCC9CGf+onthjZex9wREA1ep2xEb3c70kpmmfBDyIUx6Eubke4OjYZjmoYTkdHR/OhQC1aNK8vuD5qeYmoYy5klO0SItbLeDRc+h21I+Tz8j5AYnVauzJRK5vD1YltKD8A9oB/91ro6Mm31u9Dr8N3ar0JP5rlztO6ReEB/m0zmoPdpaxzLsXjA02opY4dyFLk8Lm0cEt3XCZeVtCEjDkr33Fw1HLc59Dxp3VnpNnE2QamWJLGf+qx/ewvuuLTJJ0FbOce+927mFsWo0v4nbeZe9I5BIYa+7JeKkD38kRGXbC4msAVrCROp+1nuyir1PC2hAcAu8zs4rnmsHVKHGvMqrT2oJ+KlaR8A15ETnhA/ipE+31784ExCsc9XLBzsmydjqtrYPoMC8PhrGcANZjkvRpxAziih3/iGHRJ+Z37i0vN01ESHoURZelUx5RnMxhmcUGwr6tMM52JpAAC7/5prlj5uQLpzJKD4Jr6PccDYC+mnAh/JC4yEfm/U3+R5HDP4YM1Xiwpy1Wv1/ZnHBjglCgAu0hU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(1800799009)(451199024)(186009)(2906002)(26005)(6916009)(41300700001)(316002)(66946007)(64756008)(54906003)(66556008)(76116006)(66446008)(4744005)(66476007)(91956017)(478600001)(5660300002)(8936002)(8676002)(4326008)(53546011)(6486002)(6506007)(6512007)(36756003)(2616005)(71200400001)(83380400001)(33656002)(38070700005)(38100700002)(86362001)(122000001)(16393002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J+lOgQXc/kZny+mkC9UjmFvF7e3ym5SbsoUcski79lmTmnVEuyiU0faXguhn?=
 =?us-ascii?Q?ufRnPfTpHVUagsEerG5jlcezUx9S1eCw32H6g72tmZrZ/gXuQPAGNb12xT36?=
 =?us-ascii?Q?LIiWWg7+N7/Eisqsgeqp1aXtPSLsHvI48bvPdAdUENjhr58C9Y+3VKMFnxJ3?=
 =?us-ascii?Q?J2PtWcvIuzWqGGL/dVE4/1gnWu6z8ZJwUGkZTFFcKY7Z6UqwPHHYInDr9T2A?=
 =?us-ascii?Q?5QzukR6/zVDzzyzFR+m5SBjOUrH/ZAr8IJmpVwsQ9JFdvRxrWsPYU2vOsDP/?=
 =?us-ascii?Q?p6v7N/u1mextyvSjkYyfW10mHhTSXV58QgbTCeHpU0n61U2b+iiM2wWBpT+x?=
 =?us-ascii?Q?V7sHBOy1UyU/KXTWdzUFfFVdBH34uRnNYx2BTxm4mkagtTIKXB56MM9CPcxM?=
 =?us-ascii?Q?rMTSqDs/miTKzHUVCiXWIZ/vfmOcksdqEy/A+0QN0giXSepf/ZTLI9hI8Gc0?=
 =?us-ascii?Q?39gmBch9iHxyI2Wqtw644fXc+yCt1/XyynTFiv0+Ow4Lms+pDRxuq03FgaQB?=
 =?us-ascii?Q?oqJF1vOOln6qBybTa4gnPDCpi+B2Js4E0a1iXN62534Xw9ZtKjXTsn+Cl6Eq?=
 =?us-ascii?Q?lSS2sSwjTKvSQFze4yBIE8lGgq++qKYITFEuU8B++8eoeAZqoMy1vN1rRmkt?=
 =?us-ascii?Q?gWw0PAAi0xe/LIBjKkxDSIQxSadW7K5TftaeO0gOaBkBmJ9mlghcXBKcyLqm?=
 =?us-ascii?Q?tgLVo1hR9/AafYN5BcKOA+aMACv9t8nHeVN2a0tNPLS69rdDNPD0tMVCFdrD?=
 =?us-ascii?Q?+fvcvENFHTtTGf6skMcfH8oANlAD9wDGHRVJU5V86J4H/5364DJ4v0JzWL+D?=
 =?us-ascii?Q?NVQ6UdmHbbgCrDuTI6GIqTA5wrHPAOjMRqDMoEOE0tHLr7BihuDO3IjsZw0r?=
 =?us-ascii?Q?PJunYqbJ3jwjViNuHV2fPCQantTR3lG4SrMOQUMN8BJO0fg8750D27S2HqA8?=
 =?us-ascii?Q?IORPcy9HOpjMhxW/U7zay8foSrdyvm2qR8S82pLPDwGAa4WkIQd619ZVz2rp?=
 =?us-ascii?Q?IT9a/4BIN0E/j1IFiVq2/jhBFnk3xzP8yOhx0i9qCizQDBdcMO04tbgE7GRr?=
 =?us-ascii?Q?tAEO0tDrv63FKhH0ogPoXRGWausj457kwXFDWefOiRaaaLZsWHzDv7gk/7cC?=
 =?us-ascii?Q?vcJMm/o8io4VNyQCveOdtcwrtS7l0xtW88v68Dt7R4KD42UzKWkBUJPaHyi1?=
 =?us-ascii?Q?ajE7aD5Zli2rC2/pjCHjCbUHxlgwzGoZQqis650W52aeZ6uG0pkR3ihyQ4Ov?=
 =?us-ascii?Q?Yy9X8bEwcHwvglf0r9ZjWSZKyGGD5zXCmxhEs9L/AaDjnq3wb6g8i/EhkoC5?=
 =?us-ascii?Q?8uBdsyTOrgdLLs+ltTirZurbp/ZUPNvG09ndn1J0zXZqKaz9ABoDOaqgFAzY?=
 =?us-ascii?Q?X3GaZPDiMKTDBeYhjVd3bnnTPFHEMJTpYY2/ERDDcEqnJt7rCTy6bFZeuNVx?=
 =?us-ascii?Q?hHCeVC7vs076KcdtNREa4OClipyiofYWH30TWRPi3+09iFCv61e9QoRUkxAu?=
 =?us-ascii?Q?7RECwMTiLQ5+r69GXM/ABENzDl7LI8K9IylUtEKEHzvKMlh2t2/SW2+EY58S?=
 =?us-ascii?Q?Pm9VVSEyMlNhzHnVg/mefpfWkyA+Ohlku3a9GYkb2R45Fld5rL0u00ye0obq?=
 =?us-ascii?Q?ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B94A7225636AE94D826D87303CEB96D3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yrGc2c/e5dTWZJ9hV0WLF9K2jXMNvIsyJczPzvRXWIEzbOJ6mdSlvs6xMfel?=
 =?us-ascii?Q?ujetUHA60WsvacCSWFQpmTj0/bEWmKJmpIgh85NtU2ypwLw1t9QU9A1T5XbL?=
 =?us-ascii?Q?U0sDmDWM/GRX0435YIZYGIuZNK7EoV6IAcOs702nATaQIpaguP1ogNhDT6q8?=
 =?us-ascii?Q?t2HKbupL+Elw1mpyz3AKDFut3kGNEwJXpxSDscpvjarXpgx8L9XDIqxjz3BI?=
 =?us-ascii?Q?Tuq30lvGlDDAEOGh0Jaz/jHmhYeA8hO9wLf9oxEwASTE/GrdIIi+m72TlCPb?=
 =?us-ascii?Q?Jy27nybiu4VGXipPQTxQkFsseG712+y8toqOVcd5akfQaWOC1IzrXQwI8CIh?=
 =?us-ascii?Q?qpj5ouQF6nU1iX05oL40XKtZoNY27Y0jmt2G9vn9ZxJbpsmqmeRQfVtqdyyA?=
 =?us-ascii?Q?228M5oEXtKnp61aY1rzD0r3ReCFp2Elt3CgWHSGNpFxiSQMEjIggaYfwMAdU?=
 =?us-ascii?Q?15ckrDqe7MIEca145wRYeY9prCAA4yDVt4eoVRaFmBQ4hG9gu+c02xSfTJqm?=
 =?us-ascii?Q?JCOk183CgJMsihLsJeiSO0QJWx1/DmdVRYq0nh5Qr6njaJXr/mTz4KD+NhJv?=
 =?us-ascii?Q?kuLM2lEpzdiRXvHfryDZiVkM/F7nHN5dTyse/aEav4TJBA8DEcLtfFywrFw7?=
 =?us-ascii?Q?GgEd0W6QZjlPLb6mBrjMQsHM7gtu+/LjC8c7hRDErh3o6dKw4O9DjYLU5qXm?=
 =?us-ascii?Q?ghZLxfRsmU+tXQ9yVxZ8O768Igb6oX0pJr4phGDkAXs/kQp6URB4+jpQoORi?=
 =?us-ascii?Q?H+NX2JpGYienGDdiH1wDBdHqiTt90nm0rCrQS/hQtjUod9734+Y/javXO1qy?=
 =?us-ascii?Q?qk4Vun5kAvyxJq/c+1A0D9r+YaE7/73pd4nbUZn9GF07YXTepgX4f4wfgu7f?=
 =?us-ascii?Q?5476L5XoqEacDNrPSppR3esLawEDZW4M5/02lyDAhHheVGSr243pm8mSMEY/?=
 =?us-ascii?Q?7UqPCTqASdoyNxodMmfkHGiQYfstuh6EWXaonFPRPa8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9038c9-ad3d-42db-9706-08dbb305f6e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 20:30:40.1621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGXtLiT/IQ8zxC/ktiDpK2f8/Uak/IcH2DP3VETG8EwqHgmbIzuCxnBH5foboLiJ4BPCN/yT/SBN54QTgJQFmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=536 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110189
X-Proofpoint-ORIG-GUID: zXLin7POQbfCue4KFx1h2VVXRPQm4f5Y
X-Proofpoint-GUID: zXLin7POQbfCue4KFx1h2VVXRPQm4f5Y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 11, 2023, at 2:13 PM, Andrew Morton <akpm@linux-foundation.org> wr=
ote:
>=20
> On Mon, 11 Sep 2023 10:39:43 -0400 Chuck Lever <cel@kernel.org> wrote:
>=20
>> lwq is a FIFO single-linked queue that only requires a spinlock
>> for dequeueing, which happens in process context.  Enqueueing is atomic
>> with no spinlock and can happen in any context.
>=20
> What is the advantage of this over using one of the library
> facilities which we already have?

I'll let the patch author respond to that question, but let me pose
one of my own: What pre-existing facilities are you thinking of, so
that I may have a look?


--
Chuck Lever


