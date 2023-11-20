Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AC87F0A3C
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 02:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjKTBHo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 20:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTBHn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 20:07:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62E0115
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 17:07:39 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJMe0QN007732;
        Mon, 20 Nov 2023 01:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ZqSKUSUbZnF0JFFDPMPRldAAH/LMieO9X24PT7ivYO4=;
 b=RP0gtL/oAIiHQPO3+pKhnrlhoCmEhNZsdEdQi/cYzwwZ26Z1/EoiUYupCU1uhKUMRTs+
 cNsUu/bOEn+O3OHN6Q1GRCla9AzElTDY38RnGB6DPxsFgdlT9kkUq0IaUe+SvM/y7IX4
 8eritUDFvg5zlFsjfxV08X2b0ehvAyxITyjg+Yb/VKx3wFzAjt5I2u7hBjxh6jif5oSx
 ePo6XQninxs9cglH2bc8caqDF31ynqUR5vrtZLA3fjSKh+Q9bH+vJbyrwhdXeOUpmnTn
 vr0RGvcLvGNIFELl87Nh5ZGYJ2NXp1ej/5iOacdRYMHzpEG8O8rjsgdx4pSA+uZy62Fb tQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uem24sp0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 01:07:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJMLcDx031229;
        Mon, 20 Nov 2023 01:07:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq4qx3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 01:07:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnE+/KWUz7stNXBSa9LQtfE3G1P85ZFZ4QAVIzOj44IUd0OV3WkEpOp0fqykd1/iyf2iw8hCDIpt7EQklrAB35D1w3S9hhzeYeQCnc0D0kUuLMt6eQ92/CqTZMUVhoGZD1fR+exoHizwC7lNa9dzk9C0t9c5SgThr0IWlxs1Qb6q/96S0Dtvvi1FS+oAqPgnt6QO7hDRbucjsHRxNKpgfbZEzOeSC2XfalRDggjto3Gk0YXIrCLmHkXrSkHTs82o0dZKfGe++F/NcPoU6UkVfqtRqF6l2VBNnZKcp1lQ7jrfnspKaHcYcvdESQfxMDkGOqZQQ0I0kl6J7QIV+YD1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqSKUSUbZnF0JFFDPMPRldAAH/LMieO9X24PT7ivYO4=;
 b=Z6NXdCm5aYnXpmsU9gD0jYozJO8GXKXt3N1LkyF/vj8fk5sfNV2bpg/wzbLnh4gbflvWLMJGfCerDjbDZsKGRhzatyn+ultxRc+L13URQQqKSNkjdg9hgskjzjlL38TfxIY3B5Ijwh0FrI7Nv3oC/no80Fq0y76dFquBYNGWj/iKxOjo4fQRZGeblvIN55l5nyaDlAHlCNYGxLYXCK8UOiJpDMydQLjtH40kflzlR8kOt3r/qNZ3EnAQUtNeLroo0aeu45CfZKpCAsoLLBH7PLuQ8fcqDKJ3vN2pbRi8Xm11s14Olvz1GIUMMbn/e1F2j0bjb3VLWoxAp2DmmfCYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqSKUSUbZnF0JFFDPMPRldAAH/LMieO9X24PT7ivYO4=;
 b=eiyBujzzDJj0JZT8iAdlO+HlEqJAEFUbetix5/02xsQVP6cCDS71YIDCDm6m7bNdj0uLBsUgO/KbYa0TBpODTIFfW/TRYW5anu5HOGfiOBn7GvBVW1EuheYwwutpgyl9TSqwDiHIJ0YuQ7YTVcAuKZFJ7IhGP/VNQUqg6V71gAQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4368.namprd10.prod.outlook.com (2603:10b6:208:1d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 01:07:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 01:07:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Topic: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Index: AQHaGSnEPMpWeNwF5UG1EZJYD3+ecbB/omOAgACniYCAAAIOAIAAA+qAgAA+NgCAAc04AIAADi6A
Date:   Mon, 20 Nov 2023 01:07:32 +0000
Message-ID: <F12175F2-9CA3-4C6A-9089-BF5E62A196D0@oracle.com>
References: <bug-218138-226593@https.bugzilla.kernel.org/>
 <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
 <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
 <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
 <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com>
 <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
 <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com>
 <9bb44f33-9900-44e1-813d-df1c60d8307c@redhat.com>
 <35ffafefb1596f4941513bc8dd51470fbee842d4.camel@hammerspace.com>
In-Reply-To: <35ffafefb1596f4941513bc8dd51470fbee842d4.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4368:EE_
x-ms-office365-filtering-correlation-id: 2773c7dc-1362-4114-2a0e-08dbe9651323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wCYjRdOYwKuRcCSjdy2DlBQ28CJJgp6+o1Kt6yp4Awqp/KSReNST6VQ+4/uGbu4npCo/dbkzSrVXRPTeT8jHGblughxdQdfdl2GQ5f9ye6VTrZE+TcgyPQPfpZa1MXuba2xOwuiBMrf4XxVVFknnvRuoGVeZ1jp4goWAdwdarOQAHVYQ5jhjXTV5FWH/11p0/Dsz165PtL2Fv4uR72rmrc5+gwGFL4xuCAdU7NslYiLh9DZr75zfUWi3kohUCHYMICFG4tU6RQ3T0Jb+Bp6hN+RZsfU6WlYzTFWdCnTuNRaArFh/NMdEzaVR1dG2aod+ECgYwGL33+E0f6fs55tXOzzOw3Hz32HlRD07BPm/vf4SvapZIFhv7ANx8+BYqMTdcXLHm1MbNI4z4PsYkY2dEL7Zye70Y+ypKuPw2LW9gPWiMg2e81Bym/D/psYi8DbADZw0KPyXguX5SHrq+bhzIDC6zSXJ0vMWseh69bE4/v5qJFDiSaulQz6JBvh15FkyIleSEhCqh6TdvFcmsy9Fc4dezIEM6/IMmnzMCx4H2ULjH0HyKHoTwP9jxPhZ5aLDxd0bUk/W2g+9sAzzqEqrVJNjQomnLQMXaWmqMI8CCbE6FT9b+c1MQDQH6r7icxJN443a+rUi76N6W09x4BdIjcDTTGvY/yKrSEtV5VIK17oHRfLpK9YqW04lzzY0d7Z4Xofk8dBZSlyGYLdCEshX8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(6512007)(53546011)(26005)(2616005)(4326008)(8676002)(8936002)(38100700002)(15650500001)(2906002)(4001150100001)(5660300002)(41300700001)(478600001)(6486002)(6506007)(71200400001)(91956017)(76116006)(6916009)(66946007)(64756008)(66446008)(66476007)(66556008)(54906003)(316002)(36756003)(33656002)(122000001)(86362001)(38070700009)(43043002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yi8zaCs2MFQ0UlIrZ3Z6QnZCaTdRbHA1V0Ruc0hrUUIxUDlCRDJxUk5OTXBG?=
 =?utf-8?B?d2NLelpQOXJkZXhoMFVvVXRaV1R2T2RDR0M2REhYOFUrN2dhTTVNZWdnNTl1?=
 =?utf-8?B?SW5xS2RXY1NNS01XTGIvR25UelRLeTRQNU9KRnFFZDU1SzlDcjIzS3czSHFy?=
 =?utf-8?B?eFZyT0h2RUNDTDdmdzk2RWdwU0RtQXBNRC9jSVZXMjhvMVF2cmxpMmFuTmZq?=
 =?utf-8?B?VWNVMzJJeTJTQVM4b1poMGVuVkQzSUFVTXZDdEFtRUpBU3NvNWhDdGpTcFhp?=
 =?utf-8?B?VXAwbW5GSjE5Y3MwanU1ZW1PeCt4Y3VhcUlITis0NTBHNm10Tk9OVVFSVkcr?=
 =?utf-8?B?cEhSVmd5NDZ2NzNucStjMWE0QjJydzVvbTNFVXVIdjBaRVQ1b1M4ZTNhRWVI?=
 =?utf-8?B?aEd4dHF0NjI5cGdpTzIzTlBZMVVBdVVEUFZ2S1poVVZVQWsweGhyMVVIZ2Ez?=
 =?utf-8?B?V0M0MzBUVVhPaXhWaUR3TkZRb0tBUmdobzVwdHZpeGQyRTN0S1JFL1F2V1BQ?=
 =?utf-8?B?RE4rOG5rVTF5Kyt6bDJCQjRyUzNsTXM5K3hOMC9qSVN0VWJaTTMyaDVOQk11?=
 =?utf-8?B?ckhZZEIwQ3dZZ1FTOUo1TTB2TXlNUU1DbWYza0U1OUR6VFdmZnptcTFqdUtM?=
 =?utf-8?B?LzZWS2tYQlVIQklCUmVsclk1WFIwUG8xbzY1RUhFRWExeDl2UXV1bS9hTjRX?=
 =?utf-8?B?b09BVE00RVc1aTBxMlV2ZS9taFhQVmdYSWQ0R2dyc0MvRWRFNFdMK3VrTm5o?=
 =?utf-8?B?ZXBFNHhZeDlWdVpwYUh0cytZMXZ3bHRCWS84SWt3QjhJRnJ1bDlYQkhWLzZv?=
 =?utf-8?B?Z1h2QzhUbzVkaUxDaVE2a2xscnJXRUl6Y1RwbEhFK0hIZVlZcFFJN0NPS1A2?=
 =?utf-8?B?a0pNWHdLeVVJbVk2SWZ6QUN4RGtLb3NHRXd0b3lYcUJlcy92MERPSS96ODdB?=
 =?utf-8?B?RC9QT0E2TVNSeTRBY2RRSVVrc3o3Qy9QV3gxSUt2bnR3aVJwR1NHSzRVT05W?=
 =?utf-8?B?TWdXc3V2aFhmTTNRdzRPd3d6WWNQaXVLZEExTUcwT3VQQ1p1RG9wTVhKeFVP?=
 =?utf-8?B?NUJWRzZEZTZxVHVNcTN4UC85Z2hjaC9OSU9UbFQ0VTczVUxuQnk2WHE4N3Jp?=
 =?utf-8?B?WHNreG5NaERUdmtINWt0aWV5eXhJRzl5enB3REtqRklTQlh0TFZiODcwc2JE?=
 =?utf-8?B?OENObWNrOXFyL1NxRmowSURpd01jMWJJWWYwSW1Wc0xpMThzRWp3RHl1SVI5?=
 =?utf-8?B?OU5WZGRQak1Wb0dIZiswbmxBbmwyTW92MkMrMUFwMU84Z1NwNWtOdGhlK2NU?=
 =?utf-8?B?RHFZcENQRkFNZ3IrdlRGY1JSbDU2ZFFSYVQ3ZmcvbThJUVBRMUZvaTdrbjdp?=
 =?utf-8?B?Y1dFL2x0MUhBNExxbzVDUE5OcW4vRHIwazFHLzJmSzZzaytQUlBEbXRTdmtW?=
 =?utf-8?B?TWRNMkdQQ2RZQzc0WnUzcFR4RnhvZW5MZFQ3OE9vUTZXWURkV1pMTnY0Q3k1?=
 =?utf-8?B?Z1pOdkl4eVRRZ09veVpNUkVIYjV5elU2YW42THBuT05yUTNIenNoN0orR01l?=
 =?utf-8?B?Z2RpT0hmTHFHdy9MTENwam5NV3d4NERkbUlYdUg2S01wMjAwK25EeTY5UXAv?=
 =?utf-8?B?NnZmaTYvd2Z2dE8vWEhiNzh1QjF2T3M1YWhiZ01KUkdpbk1Id2ZnVEdwSW5y?=
 =?utf-8?B?d3pRNUVjMER4d0VTRmdzNVZNaHN6QUduNytyRGMzMXZJaVRZdWJETU1UcXlm?=
 =?utf-8?B?NW9pOWhPckJvbEZGOFJoS3g0Y1I5Nk5ZbWlJNndJOTBZWU01dFVKR0xsNGRL?=
 =?utf-8?B?c1N5U2FKbmxnNWw2TXowT0l2bWZoRVhxNS95MjFhOVhUbWVEcFgwQ3BzK0V4?=
 =?utf-8?B?UFVtM04ycStPY0ZtOWovdXB2MmpyLzJ3R1BiaDdtSHBSc3ZtcHpWa2hUbEdj?=
 =?utf-8?B?Q2JVVC9oM1c1VkQvS1pCd1VxVDh5MzNjdTJCbUVESHV5L0E3djhscWl3aWda?=
 =?utf-8?B?QVlGaU5PSXE1Y2JUa0Q2VUgzR282ZFNidDFtMW00Tmo5clFrUTRvUUNGbncx?=
 =?utf-8?B?dDNFUmFmYzU1VlQ2dUE0Nzl5Mnc1ZnVpT2tiMER4WVdBSWlrQmplaHoxM1F3?=
 =?utf-8?B?WktNd2szVlhlUTdIMmxNUUtTYUgzMDc0eDRZVnhQL01CdVY5SWZPVlUzQ0Rl?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB0841A511030B4EA37C401E0B5C21C6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kAqiz8D4fjkCh2GFPxQXyY+4ABnaUgjzgrYGNNrgvtjLj87n59gne1xkP6bebvnTVMINwFSJtMEzWb05JldV1abptZtGsMls/yH3VhvGGog4ePyW3RyB3zbg/L+9v7FNBHQ79/h8GfX8O6nrdBS6bl470K9l/wEc5VbQDH80iXEBMW/PNQXHWpnUO9Ns7DvLodjPg8XWvlvYOJH9YBnVhPTSUSBY0hZnLRqkmpK4E5iL5IZUE7SmDhJiqqM9kgq7ap3bPql41+XiIsrsG0UB5cRYYVo4Pj6HZh8kep1uAm+92BwO7b0kLbpuKUNelCQV5FdXSlggZ3t0WXfj8L45MiClbCo7M1DOqd/SLnd07/vbEQ/dGd4c+r8Ei3zTI1FMOTD7Ae+Bt0Y9MzF6/gC+3zEbMmG9r3Nx/Fi0mkTW8zycQtvonIxk0n5aDKSL7rfVa0t8vbrBpHr2W8ECUsPipUcYIH0XB4xwaoBAvjUN0TCPVdBDY5U6zTV7hrBNLniweoXbBUKozewhlaaZyZXSruw27n9fRTAEF6qxRb/LoCTl/mk+av4NFnN9fSittmg7SML08yGWYjEOSLg1lATP8F48rVlcWr/ibzJiEWntMwI/pxidUf4TytJOfJLnWZNvtHDMzhtfrWaQg07pbXpPwbrVwZeqqAKJlOQaBK6MCeXUihn1gegkX2Bz0r2IPEIy+/MjacLjxvvsC+fimo4F5zw/DkjLMjIQVfhl4k47YzuMm51pLUIdrpZnH09DTv+ZgSfKUPYzMLS+YZQeSs7JD1tPKrIKtuGFgRkgT0OvH9Mrdpm6OJjRv2aHKVZW6ii4jKBhZ4H4vR4/Xno/2nuryw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2773c7dc-1362-4114-2a0e-08dbe9651323
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 01:07:32.4775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZEQurTaREKORH/BaKbR1F/gEeVMmNs7VTKpnnXEIBa/PcoCPqP/cW/FJPm6WhZIexTrEHvnIfOpIoBFbOdfa9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4368
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_21,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=948 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200006
X-Proofpoint-GUID: eo_MBTdeIV3BVjqNJhNRUQswQnO2HXkq
X-Proofpoint-ORIG-GUID: eo_MBTdeIV3BVjqNJhNRUQswQnO2HXkq
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDE5LCAyMDIzLCBhdCA3OjE24oCvUE0sIFRyb25kIE15a2xlYnVzdCA8dHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiANCj4gT24gU2F0LCAyMDIzLTExLTE4IGF0
IDE1OjQ1IC0wNTAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0KPj4gDQo+PiANCj4+IE9uIDExLzE4
LzIzIDEyOjAzIFBNLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+Pj4gDQo+Pj4+IE9uIE5vdiAx
OCwgMjAyMywgYXQgMTE6NDnigK9BTSwgVHJvbmQgTXlrbGVidXN0DQo+Pj4+IDx0cm9uZG15QGhh
bW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBPbiBTYXQsIDIwMjMtMTEtMTggYXQg
MTY6NDEgKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4+IE9uIE5v
diAxOCwgMjAyMywgYXQgMTo0MuKAr0FNLCBDZWRyaWMgQmxhbmNoZXINCj4+Pj4+PiA8Y2Vkcmlj
LmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+Pj4gDQo+Pj4+Pj4gT24gRnJpLCAxNyBO
b3YgMjAyMyBhdCAwODo0MiwgQ2VkcmljIEJsYW5jaGVyDQo+Pj4+Pj4gPGNlZHJpYy5ibGFuY2hl
ckBnbWFpbC5jb20+IHdyb3RlOg0KPj4+Pj4+PiANCj4+Pj4+Pj4gSG93IG93bnMgYnVnemlsbGEu
bGludXgtbmZzLm9yZz8NCj4+Pj4+PiANCj4+Pj4+PiBBcG9sb2dpZXMgZm9yIHRoZSB0eXBlLCBp
dCBzaG91bGQgYmUgIndobyIsIG5vdCAiaG93Ii4NCj4+Pj4+PiANCj4+Pj4+PiBCdXQgdGhlIHBy
b2JsZW0gcmVtYWlucywgSSBzdGlsbCBkaWQgbm90IGdldCBhbiBhY2NvdW50DQo+Pj4+Pj4gY3Jl
YXRpb24NCj4+Pj4+PiB0b2tlbg0KPj4+Pj4+IHZpYSBlbWFpbCBmb3IgKkFOWSogb2YgbXkgZW1h
aWwgYWRkcmVzc2VzLiBJdCBhcHBlYXJzIGFjY291bnQNCj4+Pj4+PiBjcmVhdGlvbg0KPj4+Pj4+
IGlzIGJyb2tlbi4NCj4+Pj4+IA0KPj4+Pj4gVHJvbmQgb3ducyBpdC4gQnV0IGhlJ3MgYWxyZWFk
eSBzaG93ZWQgbWUgdGhlIFNNVFAgbG9nIGZyb20NCj4+Pj4+IFN1bmRheSBuaWdodDogYSB0b2tl
biB3YXMgc2VudCBvdXQuIEhhdmUgeW91IGNoZWNrZWQgeW91cg0KPj4+Pj4gc3BhbSBmb2xkZXJz
Pw0KPj4+PiANCj4+Pj4gSSdtIGNsb3NpbmcgaXQgZG93bi4gSXQgaGFzIGJlZW4gcnVuIGFuZCBw
YWlkIGZvciBieSBtZSwgYnV0IEkNCj4+Pj4gZG9uJ3QNCj4+Pj4gaGF2ZSB0aW1lIG9yIHJlc291
cmNlcyB0byBrZWVwIGRvaW5nIHNvLg0KPj4+IA0KPj4+IFVuZGVyc3Rvb2QgYWJvdXQgbGFjayBv
ZiByZXNvdXJjZXMsIGJ1dCBpcyB0aGVyZSBuby1vbmUgd2hvIGNhbg0KPj4+IHRha2Ugb3ZlciBm
b3IgeW91LCBhdCBsZWFzdCBpbiB0aGUgc2hvcnQgdGVybT8gWWFua2luZyBpdCBvdXQNCj4+PiB3
aXRob3V0IHdhcm5pbmcgaXMgbm90IGNvb2wuDQo+Pj4gDQo+Pj4gRG9lcyB0aGlzIGFubm91bmNl
bWVudCBpbmNsdWRlIGdpdC5saW51eC1uZnMub3JnDQo+Pj4gPGh0dHA6Ly9naXQubGludXgtbmZz
Lm9yZy8+IGFuZA0KPj4+IHdpa2kubGludXgtbmZzLm9yZyA8aHR0cDovL3dpa2kubGludXgtbmZz
Lm9yZy8+IGFzIHdlbGw/DQo+Pj4gDQo+Pj4gQXMgdGhpcyBzaXRlIGlzIGEgbG9uZy10aW1lIGNv
bW11bml0eS11c2VkIHJlc291cmNlLCBpdCB3b3VsZA0KPj4+IGJlIGZhaXIgaWYgd2UgY291bGQg
Y29tZSB1cCB3aXRoIGEgdHJhbnNpdGlvbiBwbGFuIGlmIGl0IHRydWx5DQo+Pj4gbmVlZHMgdG8g
Z28gYXdheS4NCj4+IA0KPj4gSWYgeW91IG5lZWQgcmVzb3VyY2VzIGFuZCB0aW1lLi4uIFBsZWFz
ZSByZWFjaCBvdXQuLi4NCj4+IA0KPj4gVGhpcyBpcyBhIGNvbW11bml0eS4uLiBJJ20gc3VyZSB3
ZSBjYW4gZmlndXJlIHNvbWV0aGluZyBvdXQuDQo+PiBCdXQgcGxlYXNlIHR1cm4gaXQgYmFjayBv
bi4NCj4+IA0KPiANCj4gU28gZmFyLCBJJ3ZlIGhlYXJkIGEgbG90IG9mICd3ZSBzaG91bGQnLCBh
bmQgYSBsb3Qgb2YgJ3dlIGNvdWxkJy4NCj4gDQo+IFdoYXQgSSBoYXZlIHlldCB0byBoZWFyIGFy
ZSB0aGUgbWFnaWMgd29yZHMgIkkgdm9sdW50ZWVyIHRvIGhlbHANCj4gbWFpbnRhaW4gdGhlc2Ug
c2VydmljZXMiLg0KDQpJIHZvbHVudGVlciB0byBoZWxwLiBJIGNhbiBkbyBhcyBtdWNoIG9yIGFz
IGxpdHRsZSBhcyB5b3UgcHJlZmVyLg0KQW5kIEkgdm9sdW50ZWVyIHRvIGxlYWQgYW4gZWZmb3J0
IHRvIGVpdGhlcjoNCg0KYSkgZmluZCBhIHJlcGxhY2VtZW50IGlzc3VlIHRyYWNraW5nIHNlcnZp
Y2UsIG9yDQoNCmIpIGZpbmQgYSB3YXkgdG8gYXJjaGl2ZSB0aGUgY29udGVudCBvZiB0aGUgYnVn
emlsbGEgaWYgd2UgYWdyZWUNCnRoZXJlIGlzIG5vIG1vcmUgbmVlZCBmb3IgYSBidWd6aWxsYS5s
aW51eC1uZnMuDQoNCk9yIGJvdGguDQoNClRoZXJlIGlzIG5vIHdheSBmb3IgdXMgdG8ga25vdyBo
b3cgbXVjaCBlZmZvcnQgaXQgdGFrZXMgaWYgeW91DQpzdWZmZXIgaW4gc2lsZW5jZSwgbXkgZnJp
ZW5kLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==
