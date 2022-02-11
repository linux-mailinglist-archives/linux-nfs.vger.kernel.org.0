Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AAE4B2E16
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Feb 2022 21:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353035AbiBKUAM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Feb 2022 15:00:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiBKUAK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Feb 2022 15:00:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01CEC4E
        for <linux-nfs@vger.kernel.org>; Fri, 11 Feb 2022 12:00:08 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BJc29f011225;
        Fri, 11 Feb 2022 20:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fu2KyCi/7Ns3RfPRci57ttbo3buVGVXcnO9tiMRH0Ws=;
 b=w2UWGKFmsLQP7XP5brv17Mbj0tkdSWc35oqln6U/ZAeVdYBvLCbLwxK1/OfqubG4y6Kf
 bglNdZyZOwO9zl6GHEQ0YieqwoVf+zStp7iKHW2IHsSjrESiwfY8vyOSIyFUrgzu7izF
 uFjQhLVN+tPE2g9z7cCVDgjNrWY/IsgoVH9rS58ZMSc6W+KmHzhfVA0eCXTFZMu8e+jU
 WExGPB3sNvaczZdes5kgv6AtlIW5T/VM7JcuzCBLNLrJEb/EcIuaAdmhLTOGyajdY6Ub
 50xmVC1dThgZYBP/TJxhw0SAxNCxjITTaFQvH0mq3i7fByIE0lWKVU/ZIyabRJRS5MT0 Ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e5njr1dwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 20:00:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21BJeIDd150272;
        Fri, 11 Feb 2022 20:00:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3030.oracle.com with ESMTP id 3e51rvvpr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 20:00:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVJ9BHh1LlqtZT9IM7zbBUXczTLSUiBXxIrWOe7NHWEdSyM6NG7ZBwdc6wSU4s4ssPoIPhJHyD9rXz4CsHWaa/8au1Bui7sTkDW1Y/7davXTKpAfM7Kyvvy9Gl+9ysp8JfAYNRplOGz4SN+UrsUmRT+c3bRaelLQSfF5WZnzCqIGSHb8wDBto+VWsOQLvf1FT86rlCEOGikqZ3wlldP18y7fhqrkiHW2AXdyv2Wrxe3giKRtd7tOd6rdHGlx6vFbdmlsjg0K0td+x9hAFh45tY3BIo4NkdY2JgeqMQ1n8Mn3vqO20PVU90iZ/cXJVHI66pMX9sgYKtIIdpbEbnKrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu2KyCi/7Ns3RfPRci57ttbo3buVGVXcnO9tiMRH0Ws=;
 b=LCNLvlvqazi5Peibe7VFbubw50EkDwREWX3aBthevSbO1O4Va+y/fBfiWUgAX9/02VIPD6HkkvCYtuifYnSMP+0msUbZ3Dc5CbI5UJttawYpcBPXmDIzVe6cBA1AyW5GUVQx2kVk1E8J1RWO1nrszFtlNPeA43ENTGdTGMbuvLqEc24jHKNXij8gZMzV4tu6nn5/cq+hawBmbyGpX6H5e35K9/43MV1+lsBc7e6q0IvCnVDeKj1eBOvYezq9DP53TQ+eRfGcDAAdf/hk/rNaI+/EHWDTMRcIdG7HKgthneRTv9hibzziRf2bucIBgrSUjS6+VTQhv6BYS9aqfNXzqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu2KyCi/7Ns3RfPRci57ttbo3buVGVXcnO9tiMRH0Ws=;
 b=SNjQj9WZ5HFtPHpf73nGcBPcCwPwSWL+t4DWFlyHxB83H33IZNC8vOMuheI4gYtLdQ29r2W5CWQidOJ1QLsiOXTuipRWeZTdVoxZb/9Ol846PSGyLBL+vLfVcrRK6/g/esjY+SMU1AZ/8jSredaIxO8GBc12cx3m+pyJvCLdAJo=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by DM6PR10MB3145.namprd10.prod.outlook.com (2603:10b6:5:1a2::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 20:00:02 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 20:00:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Thread-Topic: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Thread-Index: AQHYHqhMlT21uFtPcU6l7DrJSxeLtayNFxwAgAFGrYCAACKIAIAALKMAgAAKL4CAAAdIAIAACC0A
Date:   Fri, 11 Feb 2022 20:00:02 +0000
Message-ID: <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <9c046648bfd9c8260ec7bd37e0a93f7821e0842f.1644515977.git.bcodding@redhat.com>
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>
 <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>
In-Reply-To: <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1ab6269-c8fb-4fca-6ac1-08d9ed99173e
x-ms-traffictypediagnostic: DM6PR10MB3145:EE_
x-microsoft-antispam-prvs: <DM6PR10MB3145C4FDDC689EF65DE464EB93309@DM6PR10MB3145.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MjfXKI+bGtOU//T/w9j4DfK6uNYZx7eLceXiI5F9CGgeq4+f3WFPs7SVfdrAmufMRwES92UejYR115mqDpwd8RO/DIxjSBB2o2c1v8OjbPKTPeHgiwmPU3fe4rWGV7zdl/d8xHYSKmoPWEcZYBKhd06yRXW4BJa8xjTCnENKxWlFdDecan0WlGouHw/0a+JiOpdWCxu4/ulE8JryGOUIZFxMGN9eoUIKftMiyuCajSiERpPzZcqhg8sCwT1hNXFNrImkoOAz30FoOllSGqro+t0ynLEakl46uoivPJ7inZ7kYhBAiUl6k343BMnyNDTdPNtP5yFB1C3BRsmFXBk45U1TYuRLdpJA58N1V4FoOdtUBv1x5RFaQJdTaLWwBb6rxIyT64vowmINZImXoaav6jGiCkdywl2nP8voOBNOmpJlSyjiNy0BaIM1RuN1T0ZAJC3vYJVzWT6q+beD6h8E8/QGSFQy3e3c5XqTj88t54RAGu/fXdKtQedeAHGN/EdaR6ZoQC9QDGJ0ETlhKMioQJiYtzoj877wnqM/R+OS77PqRMeCoJUl3ianwFNrRa/f2y27/uV97p3Ovb0F63ZxcAJ2Dv7xhhUw9efBOd/q0gLtFkAKUQtCev4E+I2ToyKfDV4YE6e5UQ4V2x38LRhHvmL/67pp/3dVrOX2x0ItXSDUf29FC5IugWd/QTOMpEtg274cPRxBE/mYNA0AgU6WLpj0aGfQqYCT88wjXlw9DfcPd2h/OUwa5C7YGzrJoGAy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(36756003)(122000001)(33656002)(5660300002)(2906002)(4744005)(186003)(26005)(4326008)(6506007)(508600001)(316002)(8676002)(76116006)(66946007)(66556008)(8936002)(6916009)(54906003)(6512007)(38100700002)(64756008)(66476007)(71200400001)(66446008)(38070700005)(53546011)(86362001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?syg6hHFON2yWG4kVH+dG2mxKfkV2jrH7cToth8uS4QpGiGVdiWFMh/WPIPXv?=
 =?us-ascii?Q?0yGnudRxWLt0NyJQn8NCg/sxwX35jx9qRtHhtAoDMjJcZnCAw2Ex8VztSW4O?=
 =?us-ascii?Q?ikhG0A2pdOa1mgSfnc78gQFF8grA9J2ppX0a9/Ab0WkMXIMXjXsrbr3wScy/?=
 =?us-ascii?Q?Q7u3RqjB2zNo2K+lpZv0GkMFKZH7wLRsX3jhSQZijQVhj7drbh5O1Dgg5Pw3?=
 =?us-ascii?Q?3HErCTcEKIpWCRrIWUzVfkf5voaxQ1X1/Vt/IKICFsB+Oh1Lyl0SBuMsFgS7?=
 =?us-ascii?Q?8NVPYBxBOaiZ2EbyET13h/hG71efbJJxYzqVO36WHV10VOvr7aixjfwd/VM3?=
 =?us-ascii?Q?muBLqnn5etfJnOtNLiiHsBppcnBI9z0nt093h/viYQmOD4ucX8lBsrMUPp5y?=
 =?us-ascii?Q?qRO6Qa6oWNBOkbsTVPFstavCsQEXh3Df6sEy/J3UMBEibHmoaJcZqQ0qhXi3?=
 =?us-ascii?Q?roc82UyV5MX6FzqTGn44o2jP72xLwksN43+MAiXwVpKgWk5ff3Q4ks+Y0/UG?=
 =?us-ascii?Q?S0ENqWJtV4BoOUtKCVrvsDFpL6mYOAp8DsKqxn3Vf+WAY3odFFPDLst/k/J4?=
 =?us-ascii?Q?m+S/+SnNuYtYN2mJ6j6oT7vkMptly1/fBnwT63e+GP7xqPT7jXudZOaI5jNd?=
 =?us-ascii?Q?l4owo5lEycgTYAFGC9g7eXMxQrTmbhuHadxFuOnWgI8dYt/8+79dDNu0sLDj?=
 =?us-ascii?Q?eQ+PF2M2w5HMrKmqgeaGRl6yEscdGVum8rFN3LNAC/VD9uJpcaSgnfRbyOfe?=
 =?us-ascii?Q?z4ifguF9OD8qVeaQmumX/JWQkOWgdQ4iBhL5nmuahfuPe1PRirHcL7QVdxpH?=
 =?us-ascii?Q?2CvrzXE21fAYtaW8tC2zgZBeAiH8P7NazaaSQsdHEkEnu3i66yWVM8uVKoA2?=
 =?us-ascii?Q?ML4qAiKJMLgUgmgoZ/fCf2haE9LFE5MkQdeiCHmp5fEDzYfVLSMEQGB38vCR?=
 =?us-ascii?Q?ZnHYzr1RO3EUJ/kf0lbaGVao9nrkfDnJj8sv2PhmzDGghFs9mK43vGQdkVdX?=
 =?us-ascii?Q?VW/f5M+H1phgk9Qb0duXuRFJoLJhqvrVW0fTFCLDgUxxPcaCwnSy5+To6fwa?=
 =?us-ascii?Q?STBvcHuEqTICAIACLTr1xRklI2v6EAkynSZ/ktU11hmskDC64DBtu/zT3t0M?=
 =?us-ascii?Q?McuJ8are3a9HSvIO5R0XlYh4Gamb3A1dhywLMtnO/LU/371v0qke0cZJT6rK?=
 =?us-ascii?Q?Z3tr1Dvpi/sEF2UeIvpe9tij3RohU/CYMqgt1y3GzmZ8P7kHU7jGQBgMZ1qf?=
 =?us-ascii?Q?NY0nNv2aEEXfjwXTsbJVAyyau+x53f/QiWO+6/hmgWSI+cA5xNsbi3PVUPQ6?=
 =?us-ascii?Q?axH97+QGbvBro8UNcmNX6w6leJhWaPhWfKV+m2ZA0txX1rcl3zuyCbfZ5neT?=
 =?us-ascii?Q?mkJg6QOmoB2vVmDE0ZvBDLis3OVKYN3BwkgU5yy6fyPodoCHAmFPqPPr5T8/?=
 =?us-ascii?Q?7jV9BHzVOhiRE/NvxDeGyIrcPr7ui4qtBspGZj6huGJwcswv5RnkX1Ha9jUu?=
 =?us-ascii?Q?xR9EZhJ585JuDo7Ve5d23mXEPEfOyIdpnoCaWZfOHOn0LR6zD5JgQqB4JIAp?=
 =?us-ascii?Q?BuCb3gyC7x+E8wyf4Ku8BKBLkFLmmnvxbc2p05NhUL28b4KI5LRmQyDAYoNo?=
 =?us-ascii?Q?ZbJ5MhYyIXzic99htwifEng=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1762D5C0E8F9048A1BF565A02DF4F43@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ab6269-c8fb-4fca-6ac1-08d9ed99173e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 20:00:02.4600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/+Cha9hnxC0IlkIZcgK5JDploOvUU6NN0zQuoWvsOLzzZCVNFLdstHMeyc+z4keLeLT9riYHUwMuVJE5LyEcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3145
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10255 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110104
X-Proofpoint-GUID: VnCsy1uhMy3gdktye9m4yejkQVjS-l5E
X-Proofpoint-ORIG-GUID: VnCsy1uhMy3gdktye9m4yejkQVjS-l5E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Feb 11, 2022, at 2:30 PM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> All the arguments for exacting tolerances on how it should be named apply
> equally well to anything that implies its output will be used for nfs cli=
ent
> ids, or host ids.

I completely disagree with this assessment. I object strongly
to the name nfsuuid, and you seem to be inflexible. This is
not a hill I want to die on, however I reserve the right to
say "I told you so" when it turns out to be a poor choice.


--
Chuck Lever



