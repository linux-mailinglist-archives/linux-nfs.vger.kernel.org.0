Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8262F758453
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 20:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjGRSPh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 14:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjGRSPc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 14:15:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DECADA
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 11:15:31 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IIE6me005443;
        Tue, 18 Jul 2023 18:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3L3rjCALdkHTBFVYU8wKyAQdcV63wNEaE/vfhJRLwTc=;
 b=0jc90bpAhX5UgigkDzs7fMbR+YBVV9Wi4BA0gztGohRD/mL306qMo/GyIrd2IkZ7+ZNG
 5EtaQGbHNv3v4Q7eTZYPKysCPcdcDrG+8XaBzDth30joVhubERgLsYPSLn+CrGEyEG3R
 ukT/UffbLlh45gxv3ed6T10zhKVCGR9Q2loBaqU1pxFlbzEFGWSnrC0lmpUofFGZf5yJ
 jK4HfGVijI3dL6ksxH2mH1qf8S7lVQ1Es+7YdaCY53OQ9MDdvPxpcvkzxHJkanvtGrMM
 fBuM50dz2cr36O+ArM5u5v4MzGmHCjhAGNonuyp18mz47QbeVEtGuCabidre7wXMuDjK LQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88nu5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 18:15:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36IHGMHB007779;
        Tue, 18 Jul 2023 18:15:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw595qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 18:15:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnFSk7QRPXzikm+k1SA/q9BjXrI4/n8qKjzf2GxAcW7Rz6LcDIYf9PtdKf1nF22e8F15QuHSVHSzTO1iRwLM7hUCvlPZETK9W0arCTVnQ8q0mljgbGM/IHr/LcbdVja/vFHJd0LeQyRW+pZvkKE6b0UZpTRYxCQS15/W17l9CTE0RbdZawVJCTfmL8TJMvpJYEH45uCbMo0qCHVkcTP/4Cet5NcnqQuKDVYHQS4Osn2N/PK2+4FC8DoDoKw++Lx1azxgmC/0/Bt7J1RE1MT4eA4eaNAPx/jH5aCGtsP0eWEz0y2s/nq0DOyZt6MP3x7+1G6mBpFcN0rm4u7bxbd42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3L3rjCALdkHTBFVYU8wKyAQdcV63wNEaE/vfhJRLwTc=;
 b=EnsGzmyf+4F6PrfH+NEmuAa7Yb1QDhuE4ZvtH9U729pgTGdliOzJRUvs4U5egxKvbsS6z4wTYK89rdqugITlqdPTAKyDLgn3hBjqjEUqb+SaoGM5o8JH8X/p0jsFKVK7MfZlbJHbMx7f2YY6DzszQC89Cb1iZ50sSwuBfi5dI5+NDIT+SVc4lPalhwgeLKd6lYQNwBDGXagkYR+cZd6rnkboy+n5WLMtZa2VYC9SJ65mXfIBQ1t4UF7Dwr6KTgtiHa9jQa32UCq/pe+JOnwgXG6MNuZaMazp6IFaESGGmajtoD0jpko/dwgglEC/WqhBZgFPdhaB0xyYYuGuAT1dVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3L3rjCALdkHTBFVYU8wKyAQdcV63wNEaE/vfhJRLwTc=;
 b=qf4DhLZ+vZt/Y1JduALDxywE3dNrYJnsg6H0QjcWFUDTV53kpWcULXbAUsf6JzmMicmP5vkCDTxVRLRco6/szlcxnAcLKuiL8jUNzqvoqOLwWnouPgzKTMVz07dLiVYnkaDjS7RnbuWcB+k6jM/RCAe2ZfFlxeOi40BPSkd7QpU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4979.namprd10.prod.outlook.com (2603:10b6:208:30d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Tue, 18 Jul
 2023 18:15:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.022; Tue, 18 Jul 2023
 18:15:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@kernel.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Remove incorrect check in nfsd4_validate_stateid
Thread-Topic: [PATCH] nfsd: Remove incorrect check in nfsd4_validate_stateid
Thread-Index: Adm5o9KLfU0YU/VCqESwFJrpMG+Gyg==
Date:   Tue, 18 Jul 2023 18:15:24 +0000
Message-ID: <13B5BDC9-AD46-44B2-BBE4-F07053CC8506@oracle.com>
References: <20230718123837.124780-1-trondmy@kernel.org>
 <6dc89e4859a6851773bc2931d919e1cb204ae690.camel@kernel.org>
 <106daf5e0242b67bdb04e2e8e4ae7e114a4b47ab.camel@kernel.org>
 <0F52C77C-C1AA-48E1-B30A-CD15342EEAFF@oracle.com>
 <cd4cdc83d81eb23faf919136b8ddfe5e52cfc052.camel@kernel.org>
In-Reply-To: <cd4cdc83d81eb23faf919136b8ddfe5e52cfc052.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4979:EE_
x-ms-office365-filtering-correlation-id: 8838f164-7a86-4b75-e250-08db87baf510
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U34JMKFgkdgLUX2o8XeG2yvGerhbRzbAUmasCZSOEoTokGozPLcIL8qtyFBf25JscQdr1yfcpopd6sSM+hg8zE4kvEzaS2BqC/eEwUDdxzV/ME51S6BrJdWpll6VIsXyZHxQaou//W/d88k8XIj9KjmRaVyNxxcrX9RmuIblfeHGNgWeSvsUJwt2o4imcSd2uecvtktc/VGl2Vjmhtscp5Sd8qT8wbtSI9nEtl1mKq8c+f8m6br0xBp1JlqyWfu4T4wdJKYBbpimGBQB4EohKKtr8HFOXprpTjNcM6tpX8hlMG2pZE2UBhsNO0N+usCR/AekGgIMjG7oo3Xy764kDrLMT5H/1iQivFooE91Rd4lwbDeRo79loDjhPrCz559yu83GnIHprqNSWNtGhk4ES786taJqnJwvndJocxW8oVXtNUStkisBQM4w2H6EFiilCN0rna7QuK/qSxs/gMJdk/DSvZq0qgXC8xpZ/Eepn0nwwPorXb29PH0l0C8DwJt+SC0M5A2xip/9XwMxtrwoIV0IoD6lKp1u5Yr1MVnlOZu8hm7Cu1/ILvy+0VgCgrLcIH0eVyBZGwdTWz2CapEssqR4NG+WJET0AOVHLT3ANGkGUzBLwlu2/f5h4YIH6dE8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(316002)(41300700001)(66556008)(64756008)(66476007)(4326008)(6916009)(66946007)(66446008)(5660300002)(8936002)(8676002)(6512007)(2616005)(33656002)(83380400001)(38070700005)(86362001)(38100700002)(122000001)(186003)(76116006)(26005)(91956017)(966005)(6486002)(53546011)(6506007)(36756003)(54906003)(478600001)(71200400001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pG+I9xfmqQBSMEn8A38Kgkxcz85+1SkG2iF6ViQffCGcI+8vGS0O8BUReuoq?=
 =?us-ascii?Q?xzCAI/NwY8vCCy+KYNWjnED99hY8ky1s0pyQdcePZ7g3DqYls07/kv9WKfxA?=
 =?us-ascii?Q?fZUdac/6ZmLh82/XXGBs9lnmYIG0N58WiifLKhi6A9CsDJUH084RvoYMwP6V?=
 =?us-ascii?Q?MREoKaDlbKaygvca4C46GBQMLdUZ68I35y/XUtJuOEDK6ZvlpSWnwXEy+rVF?=
 =?us-ascii?Q?GrvZK9UL9PURpTmsbCidrynAjLWYa3jG6eRMWFLfqW92HPVI9FvDWueG4hSR?=
 =?us-ascii?Q?xO9Q28K3ERWGsp3N8dCbNZ/lF1slA7puMH7jCs2pEuI0fvKPfpdD056kKpZT?=
 =?us-ascii?Q?ba0Pmo3/qwEUGq9wmg1pzDIYdCDQtWn/66lKg+M2tN6Krg6qjsDv1CwGSjIp?=
 =?us-ascii?Q?uJ96dWvKGfhbb3m4SNss8b4+xwfEQQ2xYH+wmi/Feu7oJ/N590mocAeguKCM?=
 =?us-ascii?Q?SIX9KpwT3pwDFZ3L22KXF1THtUFLwEQO8G4EpryX4yKBJ2utM44rUP3x941V?=
 =?us-ascii?Q?5UYsqaqbxqgjBN27ErE0+wnktFROSgy2IBzuLhH2YZ2mvY/6v3vVHvR9H0Mv?=
 =?us-ascii?Q?cCHpjMlkvcf2ObGGtDODQehVij/nHX0fcJvAmFVXtDUW7QfC0qc49MqYqPA7?=
 =?us-ascii?Q?Qg1DPaTfvJ7pErSZA8H6Wm6b2mCz0Lh45slkTXmLPKA4cpw/fi0U3oXDX1xt?=
 =?us-ascii?Q?CYhFoueyFzt3FOl1TkHncHCJNC70KZM7+3K7HDtu4jKrg9AvLlQdMD5VeN6i?=
 =?us-ascii?Q?tC0xCceQjmldXT5B61FBHOHnd7byeqMkUbSbusmVORw6a0a+WZE0lVJFWdiI?=
 =?us-ascii?Q?8l36IbCO19KNJOCBQ5nvr3//ah8UApFEcChO4lUWIZhcaUjbcQEPnmD8k2Ab?=
 =?us-ascii?Q?qAxAPZ7gk8a0xCb9JguiPNirYqTGIxTBtRMT/FifTp2lMwCSkZAT9/rsvkOT?=
 =?us-ascii?Q?+/tS14wzOECFZN1KwrXJSAeWF/a0j5tuwivQl3WrEWZNIBqz0HTR63VyfKFi?=
 =?us-ascii?Q?mwBckb2VGOVv2YlgoGEGeaKJkWIBJzRig1+TNHacfAz1Z1ODDA/XarsYQ2ZC?=
 =?us-ascii?Q?LPo579wNn7xN7t/Rv9HdYDXtUIN0Y5GMAarVkj8yBn3+VCNqwOIhtdPTdKlc?=
 =?us-ascii?Q?91OzjMvpoLInganu28ZKEyUtBWqzxyK8M/OIA9DrSikTw6/17WwjyyrirOia?=
 =?us-ascii?Q?ry0XlxNPw+lCmOHaetBm6BpoRY/KeOQQw8Si4pjHw0sHIF+wTwuQyIZSf8vZ?=
 =?us-ascii?Q?E8KhRb0GGoPEh/v7kanqri8W6372RTlPjsaWQ3vLt5sQkqawJ7OvP8ZoIguv?=
 =?us-ascii?Q?nhscxSS/CpyE7BvybmXSJ3E4Ow1OLpET0P+JPurDHoYzgLE5N/OaAFce0JgF?=
 =?us-ascii?Q?I+IzvdpZ2+c6wV7/YyiSxtduN+yv+Ed31TPK4sjk/UDbi1dACaCvyUyFCR6n?=
 =?us-ascii?Q?ZaSEwwGe7aHPFF5Nh/Ohm/PhiLZD8YsSJWQ9ksUPbJa3tdNq/QjOYhreeJ5B?=
 =?us-ascii?Q?y/mDHwfthc2Acqx+KWkTsb8XUqYyACCp58aYdCR0YtPuHI/N1MLG5S2SbuWj?=
 =?us-ascii?Q?i49+4iUgLakMq1HKyXvVvcUEwEfOiq6G0Wyihh5unaEoj8BOzxCIf7UBU6C5?=
 =?us-ascii?Q?8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <004BF297F23DB44390526E4896273419@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bDaQBIQ25piUo9BT3HKW2LFN9spy8W295peaPF86UG7lfMoGXN0C2ItLNpWFf9dG4owVU5xQGXKsBM0dMaT80Jwz/fxx68ZfOdymKvVdfRLPHR+7Qk0t7Uc1IJbb4FNMfWsFyVEwAIecZH8IfJO60qsr3B5rLTbkkX3S9yfy2XYMMPFhEatfcyBIu086aDSsBX/HtiLGpVjpREazd+RvapxrKEag2J3bRTaIEemVGhTtyxpMZ3oKPQmIGWcyXdzGRV2rjFkH1b23XTmcKtlZ7Ls4ZkX8pphw+8wT/b3Xin7/MZafV4RE2MJlzUQuLjdZZY3i8IK43yM2vTVQUV/yZwk+MwIXaQK5gJ2bSG214o6k31avRevjUEvaJR4ak8Q8Ds63PMp/LkCiqXg2dPSje9Lq8MQb8oH0yr4o8w6FlSHhHdpt8vpEmqix9pExg8CjMtSnoIkSEoY7085RcTfFD00YNzNgIIcDuJ2kTpN0r7HnjFd6YY4SkjSIpEp+WkOXUigi6CqtgqnQnDU2aT8s6he73cG67awsDvVNDsc3v96cf5a3fw1vxS1bSz37bph1Tb3isXS+uxkEkZ/dVwnqEv0dPjH5cIqkequKfgjcF/wRYhzzYTbhFa7RIVvbhCrmmjxOJIcyqx75cppVbMsefwjt18I86kOGYjRG7cjJQb6LgUS99NLLmmt4NwY4W4OkDa6VSzzaKBkY4swG1rJvxd/My3rCjvrNquR/++zQA5uGaNq8rNP6Xpmv1047a5IuKAAKidQYyP/HStQJbfghxHcYw0erF9jGcB219VED4us=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8838f164-7a86-4b75-e250-08db87baf510
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 18:15:24.7648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pi1/Eg6XhJaXZIxJPsqzBEukFmYhr2bBqD0o73DWW9s/YEziNbLpHpYSagzdmd29rcgf3HVxIKmDNnIU6Ny0ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_13,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180166
X-Proofpoint-GUID: lheHyDGHtGiRj0gWD8PuTTRDHRVsrqFP
X-Proofpoint-ORIG-GUID: lheHyDGHtGiRj0gWD8PuTTRDHRVsrqFP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 18, 2023, at 10:30 AM, Trond Myklebust <trondmy@kernel.org> wrote:
>=20
> On Tue, 2023-07-18 at 14:12 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Jul 18, 2023, at 9:51 AM, Trond Myklebust <trondmy@kernel.org>
>>> wrote:
>>>=20
>>> On Tue, 2023-07-18 at 09:35 -0400, Jeff Layton wrote:
>>>> On Tue, 2023-07-18 at 08:38 -0400, trondmy@kernel.org wrote:
>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>=20
>>>>> If the client is calling TEST_STATEID, then it is because some
>>>>> event
>>>>> occurred that requires it to check all the stateids for
>>>>> validity
>>>>> and
>>>>> call FREE_STATEID on the ones that have been revoked. In this
>>>>> case,
>>>>> either the stateid exists in the list of stateids associated
>>>>> with
>>>>> that
>>>>> nfs4_client, in which case it should be tested, or it does not.
>>>>> There
>>>>> are no additional conditions to be considered.
>>>>>=20
>>>>> Reported-by: Frank Ch. Eigler <fche@redhat.com>
>>>>> Fixes: 663e36f07666 ("nfsd4: kill warnings on testing stateids
>>>>> with
>>>>> mismatched clientids")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Trond Myklebust
>>>>> <trond.myklebust@hammerspace.com>
>>>>> ---
>>>>>  fs/nfsd/nfs4state.c | 2 --
>>>>>  1 file changed, 2 deletions(-)
>>>>>=20
>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>> index 6e61fa3acaf1..3aefbad4cc09 100644
>>>>> --- a/fs/nfsd/nfs4state.c
>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>> @@ -6341,8 +6341,6 @@ static __be32
>>>>> nfsd4_validate_stateid(struct
>>>>> nfs4_client *cl, stateid_t *stateid)
>>>>>         if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>>>>>                 CLOSE_STATEID(stateid))
>>>>>                 return status;
>>>>> -       if (!same_clid(&stateid->si_opaque.so_clid, &cl-
>>>>>> cl_clientid))
>>>>> -               return status;
>>>>>         spin_lock(&cl->cl_lock);
>>>>>         s =3D find_stateid_locked(cl, stateid);
>>>>>         if (!s)
>>>>=20
>>>> IDGI. Is this fixing an actual bug? Granted this code does seem
>>>> unnecessary, but removing it doesn't seem like it will cause any
>>>> user-visible change in behavior. Am I missing something?
>>>=20
>>> It was clearly triggering in
>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D2176575
>>>=20
>>> Furthermore, if you look at commit 663e36f07666, you'll see that
>>> all it
>>> does is remove the log message because "it is expected". For some
>>> unknown reason, it did not register that "then the check is
>>> incorrect".
>>=20
>> I don't think 663e36f altered this logic: it "returned status"
>> when it emitted the warning, and it "returned status" after
>> the warning was removed.
>>=20
>>=20
>>> So yes, this is fixing a real bug.
>>=20
>> If there is a bug, wouldn't it have been introduced when the
>> "!same_clid()" check was added?
>>=20
>=20
> Correct.
>=20
>> Fixes: 7df302f75ee2 ("NFSD: TEST_STATEID should not return
>> NFS4ERR_STALE_STATEID")
>>=20
>=20
> It can't fix anything older than that patch, because it won't apply.

Testing now. I plan to apply it to nfsd-fixes (for 6.5-rc).


--
Chuck Lever


