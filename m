Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139D57B7463
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 01:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjJCXAY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Oct 2023 19:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjJCXAX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Oct 2023 19:00:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F44BB;
        Tue,  3 Oct 2023 16:00:20 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I4NbW004017;
        Tue, 3 Oct 2023 23:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6HjeDfaYrhN2NB4j2WolPv2uKfle3EWJQMWhTN5kwos=;
 b=hIG3W6IUiQojE8IwYLCEOZeYw9+10sTcrysalBmiqPuoOjkEAhnWr5OCIQeEZLMl2sqP
 cbuevNJ5vf4V7Uj5TTxPKydFqGOLV/0uWt4QCbkrP6R8Ibm7Ei2cSCA1oALSjc4Q5MMR
 OCIpce3rcnfe1n9gJPxGlePUFuWr8p/Fp/NgkUItxTXZ780nHsmB+d/eD8wH8FYgnXJg
 lZ46elqrFQb7XsLdWuBmgykRzhbusq1V7Nz15fKAJ5rRiihodWWtQgMDYDdskrlbqtsy
 ofp6PuUWv5xb9ge5J7kPXIybZGnEc47lqL9N1fNASjAxNOszmtjhjMUoWfjGKlSBeuDa rA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9udvka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 23:00:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393MPZSt025916;
        Tue, 3 Oct 2023 23:00:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4d52d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 23:00:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekZQMy2plZ4ZQGZPxQ7F3nopOMhaZvVN/1jk5p9QyA+yOsytq2ZF1jSj49uFR/NLiZaADpeXOTE6V14KUfNqTocsSgUG2e+qFyb/ZfZ4bkPGlaSKu3sFEmaK9Kw0yRqJ1TOzzZ1ecoDy3WAqEumdQd96yBdt1pflUh+iCvxlDuO2AFBH2pDqA3lSOwd6LS0dDeoZ9mSlK46Uz8ocLouh8++xKNrFyzqQDlena8rg4rIz8BRNDSlrBbswbVS4/ppOBeWufFnC1VVFQR05FuewwS4u3ZhyXzVgggtgs+9eEdr9uvelVUEOE6uy8alVC9BfCdddPcYHsYyvYeMPDneUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HjeDfaYrhN2NB4j2WolPv2uKfle3EWJQMWhTN5kwos=;
 b=EGBAye5Nc5czujKvUvEAH2ek0gkD5eTy3NUEml+B+sE4I9/NI9IqWnRTXftciSXe85abyIq6HaWGnvGveEbhAHe9CYVKf+zeOHt8iB4SZcOfNXvPWQ2J8273pWMgTVr5KioM33txvNHs8suWHUANPkc25EtcNhcwuHY6MI7udQ2o65OaSBiyd/BzfBTG+F8cJR86KJCQsbAMMKEi0+uRJH5p7Ww927lJtkyEBBKFmHNwkWUcpE5OlxpLH6MrOV3Un8jzadeiyfR3NS5zS0RBKZOYNI/k7PDYEr0wXiGUachX+5luKDltCbjCdD8UqLVgz2CoIjC3SbBA1EGjCvJZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HjeDfaYrhN2NB4j2WolPv2uKfle3EWJQMWhTN5kwos=;
 b=VZQ6/2H2vL+c8rUCVRqg11xUG9EFIKdMhCbtshi0xLJtoRnMoVGHayL2nO2wFlmXvhf1pELw5rmtGrjiVNBlVLVDsqJXb1Sl6QtnLfF2c/hJpEjIDNWxpse4vk03Wy2djke2lvNUBivGmgyKY/NcNyAZl5iPTB0r50bVC3EQFgs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4825.namprd10.prod.outlook.com (2603:10b6:610:da::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 23:00:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Tue, 3 Oct 2023
 23:00:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v8 1/3] Documentation: netlink: add a YAML spec for
 nfsd_server
Thread-Topic: [PATCH v8 1/3] Documentation: netlink: add a YAML spec for
 nfsd_server
Thread-Index: AQHZ5K6VS5KBJ72dikWpg4qvkMdvd7A4fEcAgAAMeACAAAZXgIAAQjeA
Date:   Tue, 3 Oct 2023 23:00:09 +0000
Message-ID: <8631D22A-8050-4403-B03E-06F33C709184@oracle.com>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <47c144cfa1859ab089527e67c8540eb920427c64.1694436263.git.lorenzo@kernel.org>
 <20231003105540.75a3e652@kernel.org>
 <F39762FD-DFE3-4F17-9947-48A0EF67B07F@oracle.com>
 <20231003120259.39c6609a@kernel.org>
In-Reply-To: <20231003120259.39c6609a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB4825:EE_
x-ms-office365-filtering-correlation-id: d4f99aaa-8172-450e-ed9a-08dbc4647e3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hHNJTxvp5n688WtJHlmRooxJ1H2kN2KRiOz1rrAX+DH68Qne+MJetn6PHBgqdE3KmAVWlc3I1HDaqHgHyOyA3mQXUwBblSQFQI46RZHCp3ElBHETx2vwQ5RO/FTzDDu8gS3fMJkPchMXye3VXUU/xPW0f8i3Ee4ZpmDPe4OPvlr8RoSxAJDpaYdqR9kkwjj5qjGcwS2gm31y9Ze8fVtY9w9R8BqFf2uPJgf4t0wCzMAd8Nt53shLx5vDVWiYOgzAEVZSCe+W3cbvdymApr0OKCQemQRk3pnWYiIMClTqIwWfh7UPyRYttoM5VS2sO7Q8v0vKP2QFKhuPV7J3VBRmi3v5gWIlczDRAViU4EKXjpQGDuBU0iNuHeNmQAao3h0yCDRCD9xHrACRuoUAQzkAw/ICHq6tmw+cPqyLBBMVL3KYjN4Jhym4diSt298dJo1PqWv4pMdQnm3FgcVItLK0xHFXZdjAWD+Jjrxt0WICFGmxzdBLhTiM50qvCdCRcgGUSQ2Zt4trOCq7qqTVSUfGNpB5Bn7107p0xkgSbFmX4cdguShRyTovq/As/DWtPu9bFtS5uPPcyEEmKsEqwPGLePdEpayjEalhQ8IOASiPwx+Fb+ZgP85cNj8z8xuzTTE/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(38070700005)(83380400001)(86362001)(33656002)(38100700002)(36756003)(122000001)(316002)(76116006)(66946007)(66446008)(66476007)(64756008)(6916009)(66556008)(54906003)(6512007)(6506007)(91956017)(41300700001)(966005)(6486002)(2616005)(478600001)(71200400001)(53546011)(8936002)(8676002)(4326008)(5660300002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?78B9ULhtFQoSb0vLVut9PJaWhdZQ9gtBc90H7mOsbD9wu4BM69RkXz8BVC/D?=
 =?us-ascii?Q?2KkpbnkrqMfLCMhWTLI/iZ0ETzGC8cv67Vt2V3zQHVlnfWT4JiBc7WhFxNEw?=
 =?us-ascii?Q?hO+BD2TcLR6zg+Y8QE5nY5yfLMW1sicacRccG2LV2oIaCgz+uz6CfXZRdH06?=
 =?us-ascii?Q?dM8tCaDK5ClUXSM8f44Y5Hh5omXoxEaHV88KF+d5bDfIZZP28QJTw0nvH4eh?=
 =?us-ascii?Q?BVg4+T9hwyaSAvtvKGXdt/eapTGosqBEEdT77ac/seLo9hwyG5hiKOf5bJHU?=
 =?us-ascii?Q?77mYqV5ini27A5I99szoCV4gz1At9FkyEljKf0S2mIhFW0fg8Ngv0s2x8pWr?=
 =?us-ascii?Q?VCTr2eRVhJ+QWv4j5PAfC+v3XXA9my7MQnolq3LjL9/KugTi0/tHlHRMBhMl?=
 =?us-ascii?Q?Bp/RuUauyVKdPGe6dbFhk3A9dIts1K/VE/dB0ftIXM56TTLoZlLntGifLc3y?=
 =?us-ascii?Q?xrCqgdEy9rV2PXf1IeJ7KHePy7mwJ7hD8L043D6Do2TRXjDi02/uJZcmklS7?=
 =?us-ascii?Q?UvK52EDB4ndgWTxYue7L4x2CVBa6lapyRgl6QVL9ShWy/Fehw/+cAAmi8HHP?=
 =?us-ascii?Q?ZJZBxsnLbrZUM2Id4H9KdqtUouWir6SI0ivFKdyQFV3EuPTMI4b+EUpa0Ind?=
 =?us-ascii?Q?qtBWE7Q/zI2ywUQPmFCcE8DvvhKuc1MyrLdUwTEYC1Igc+kXqEWlWmkt0EZY?=
 =?us-ascii?Q?H1V+KL76Oz0wzSmVT6aZhXjZq5izW9cYf7pgHK19+/nC+lVawPaYTO6Km5YV?=
 =?us-ascii?Q?OrtUatDPr7TrV0fjgpODBMs+87SBcHKHLKKcsU/2nTfPnhf/3R39AvDZOMGI?=
 =?us-ascii?Q?d56x3hte19QcF34hXyimLd4CkK5RvmYoN1qeBHvWJ3UDB0WJsIgWjaDZ/XZ8?=
 =?us-ascii?Q?nEictD2fhD6pA5zGvqDuETjOyVpiYvgdzWOarGao6HNA0UhsqXGei4ZBjeZW?=
 =?us-ascii?Q?Fyf4SuR0yk13793Y1KMK9qjoo8xOszW3cCUKBvFgFGu750U1IeyxBr3DmOPT?=
 =?us-ascii?Q?iNi2EA4z6+rZgx9IYhUC5YnHB8sn2z6wFRmF1mplHrtzCZlKOhA6Bu1twCFI?=
 =?us-ascii?Q?OfcuS+Si+6vhio/KHgRZFF/W7fvwz6CkGfsTJNuMZlk5cgdgcOq+cgEN8N2E?=
 =?us-ascii?Q?fXjaxXY04P47c+SFmpihfFRsvfGzqS2ammW2urxOC808jSKC5A372FTvu166?=
 =?us-ascii?Q?zDH8N5oJ9xfaMk6X3jjNGMhWbHhh7XnXOaXHjCtlf10CjJ38tV12NscdHTPb?=
 =?us-ascii?Q?QQbK0K+3gsOnjQJUW45MWNiOm0sElrZHPmjuKZzqjVwC7FpYJG2aOYB+LwVB?=
 =?us-ascii?Q?j8Sf5/g9U1cFeZMBkHi3b+mXiKAY6he7m7kNn7ifzMDJO7VAaKLPrqY11zHw?=
 =?us-ascii?Q?EdG+jXlW1Z/Qhw1yrWtNoUVhDyhxtjdNk0RkBKXYQjMxaBviaxd9jQyHUa1R?=
 =?us-ascii?Q?mn2HL7BCRPqgIiotvqH8GQJ2nIyTBBDQsfGjBQWjG8kHG5nkOtKbdOMRA8kp?=
 =?us-ascii?Q?Ap0FHpByRVJGqfsqCiDowvGUA/xDBVzfTgyubj+pXpSZuo2akNUhfU+v1pdZ?=
 =?us-ascii?Q?Nnms9JahGtdxTVfvowqRs4+iow00wOAWxUjfDISPsxbOcYwV3/CGddX6GHnl?=
 =?us-ascii?Q?hA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <06297ED81152DA47A569769840031846@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TIbWTy2O1ekV8cxbZ3dNnWC142XEKg0fQSygQRSMuoTZ4EOEs8eqSAajR7+m4Ogt1DiuEaRCm3Lo0tWwmMVQBka5m680qYVccXYYXcahmGWE/JiGrIAg8V9vCpqB12gPZFq9dpACEjM2+mZCCVN3ScwkTV4QsuIRtP+Zgjc5CvvEvdZu+h2vM7KPGPalXX2v2DPp6PGRFTef2aMweVTqEO+qgIlYFma1qmwNCUFtdA/6fChqNRV1+TEVEg9K8EpVqHMloVwmWlLonJft1O9Of5tapeOzThCY4BtCaExXXody+2Co0x3kc1DXdz9oGEBCl0Wh9YzZwup5mMERyNKzY0YzWb1fv62RA+Jh28Bwe4suEpvQji4OlbDnCGXg2Ubza96zt6zzEtbfSZcqhbXWqdTREfUCpeKZ7PterkL/Hj3P4X8MZVcQNHWLhIoKBDKBt/abop4+DVAVp7Q5g6b/JsPwvm0NS4qivzxuWlCTrXEMbfnH62X549ds5l7RPGbWn6XLrbFEFf24iDaUbzqMOaA5TWkL9ZNhSFcq30d067RxBiAiUqGAuxoYcIZdodLnNa6lSw2swl1u3JrbgdhRRSC5wqq7ouEyHfy2LEXnkGQiSta5gs8hN4W7WdTu9Ovpt76lClr8kw3EeE7fN82RVU6icbKbwiE1519mXucSA6xzF2xXGo8cKC7KiZkPY8IDSooow/YIr1Zt9tpglIPAbc1JdIxu+UOosHMyGAy8Kx5Y0LTCgWOo6D/9en9NpEIb76+AeW47uV0YAyM5HGrT53fTXS6uLN6XEmAYizXYduZEieLXUnPc3O3MRd73jTrUvhbs1L70iwc2L6h6x472Zg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f99aaa-8172-450e-ed9a-08dbc4647e3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 23:00:09.6509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tpv0Vh/2j/sQ3ndh/xRpmjfrWavBl8V3pLkzuPVZYm0d0Gi6mKzy+F3OcwJeGhlrrbSwI0pegoe9YuC/MfaQ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_18,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=627
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030174
X-Proofpoint-ORIG-GUID: aWm0tnrOC_a2Rw3qobEcXOpC03W0m5_H
X-Proofpoint-GUID: aWm0tnrOC_a2Rw3qobEcXOpC03W0m5_H
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 3, 2023, at 3:02 PM, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> On Tue, 3 Oct 2023 18:40:29 +0000 Chuck Lever III wrote:
>> I've made similar modifications to Lorenzo's original
>> contribution. The current updated version of this spec
>> is here:
>>=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=
=3Dnfsd-next&id=3D55f55c77f624066895470306898190f090e00cda
>=20
> Great! I noticed too late :)
> Just the attr listing is missing in the spec, then.

To ensure that I understand you correctly:

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/=
specs/nfsd.yaml
index 403d3e3a04f3..f6a9f3da6291 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -72,3 +72,19 @@ operations:
       dump:
         pre: nfsd-nl-rpc-status-get-start
         post: nfsd-nl-rpc-status-get-done
+        reply:
+          attributes:
+            - xid
+            - flags
+            - prog
+            - version
+            - proc
+            - service_time
+            - pad
+            - saddr4
+            - daddr4
+            - saddr6
+            - daddr6
+            - sport
+            - dport
+            - compound-ops

Yes?

--
Chuck Lever


