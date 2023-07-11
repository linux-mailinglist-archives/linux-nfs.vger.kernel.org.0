Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7184174F526
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 18:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjGKQ1g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jul 2023 12:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjGKQ1e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jul 2023 12:27:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E8E10C2
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 09:27:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B9UTWg002903;
        Tue, 11 Jul 2023 16:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QrXbaVJN4P3gdMPm4t5Or1YcRk3wvdQoIJCjgHfYFRE=;
 b=IjATZg0CGtt2qcfAxkxgKOPX4dFeYk3LyNHku4AEck4RfUV+RvLKOSY/izBOvm0wwTjC
 x4L68UsyBxge4PpXwdXbLjelKN8Tmws9u5++22tTGuDYWLaPVeX12fubOUMmjYzM31Aq
 qSVjbaCqffSmw/rC1D4koeF0bpIK/+Ask+KImUWk4yC1S6IWPcHYMy2/j5TsZd14L0az
 1bT4PLFIF0P71VJxDSYGOKnywy+2VPPLhHei0yPp+8RRpXRpThw7PSzQyz40Su2nRD2A
 QodbBa3yUKGZr0llcWekUb3cyu71nGoQUyDPfJXOcl8YjSjXpn0ggNTQnjbvNB8lU7uO jA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr8xukrjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 16:27:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BF4ur6004260;
        Tue, 11 Jul 2023 16:27:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8bd4pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 16:27:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuh8VU+2O+uG6I4zU34rbAuHQ8OCfHJ+l4uU8SfrInM27cVqqDW4KhzXBg/Ckg67lEBPSCYR7WLoi25HHHq0mr2rFvn6FBrV1ksvREPCROiTPcJGihEU0EOsVjereS5sDEJ/T4bDXxzFt9g01KKof19/iLf8Lwx6Dt1HSb+LK/zS0EaC3xL6l2uF7dUhrlXPaQRSn94RGK6IL9PMlSCaooHo9M0wShyPrkXCBfzlJnS0NVWJ+OSQrJxUnqc3ReyJEbhj7AoUqjCYt0Mu6MasqcFx3KGO13RQ27kDyRhEOOSoh1QUGVwULTvy0iMptd0l7IlCU6+hxo3UgO9JFJbK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrXbaVJN4P3gdMPm4t5Or1YcRk3wvdQoIJCjgHfYFRE=;
 b=TEs2hDvxajWG7Njgmx7+49556Qrb5QOs7iBOt5Owq7kaBKkpVnvXgJSHj667MREV+3K0MD7o/y5hg/nClbG1PFyg38mOZ9802Xxatk79NGN/o9JUvDin/iowNJ+XEGPDPrIRS8FIxYwdsNHiuSiyKLmb17sDvqkAj71RYzXzQwPGOrqnh7yh57h25jc98eCz8K4+t3ic3KwEpNEnnPEmnN/+JzcyC0DG/ORVdE0IKr7x8yUpMUD2eZr7boheO+w44pvtKhtwG030TsvtdpwFUZVAwnKqaKJj/N4X6ziBv9eVKag0QPA0uqznBlgyziUfQbp23qYBPtwRcniq12TIJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrXbaVJN4P3gdMPm4t5Or1YcRk3wvdQoIJCjgHfYFRE=;
 b=W4f839pzJ+DDgeSRSu657RIErYK9RWBY3BZzG2m/0uU/DypLt49Bki4gl/tb/tccRk3JKCzJfK9xw8RwUmN3v7EJSfCP0O71dS5cHx0SEZodrEmX2Es1fr/Z/UdVk1/5zIO7MEdWaYWeVXzYgzvWInclVX++1z302fjhSXq3JWQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 16:27:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 16:27:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Neil Brown <neilb@suse.de>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v3 8/9] SUNRPC: Replace sp_threads_all with an xarray
Thread-Topic: [PATCH v3 8/9] SUNRPC: Replace sp_threads_all with an xarray
Thread-Index: AQHZs02RX5BKEn950kOti0uzTOYZhq+zUOoAgABuAACAAAIzAIAAFcyAgACgJoCAAAvMAIAAKNQAgAAWzIA=
Date:   Tue, 11 Jul 2023 16:27:21 +0000
Message-ID: <9FF4007F-D7BC-4637-9849-939A6EA8C98B@oracle.com>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
 <168900736644.7514.16807799597793601214.stgit@manet.1015granger.net>
 <9de14c8ef8584545ceef2179f0b57f84ef7706fe.camel@kernel.org>
 <0D6735B0-77A8-4710-8EE7-1F8E382A139B@oracle.com>
 <2909e8cfc2cbd218372e78f5e215759722faba51.camel@kernel.org>
 <ZKy9Q1wX/xPx5Mbu@manet.1015granger.net>
 <c0a221115e2bae7910b9e4ab6eacdc745f320b43.camel@kernel.org>
 <4E83808E-399F-46B7-9EF1-1D2999C801CC@oracle.com>
 <20a9d2c6f7d7131c12d0e6e3496d30ec9e8cccde.camel@kernel.org>
In-Reply-To: <20a9d2c6f7d7131c12d0e6e3496d30ec9e8cccde.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW6PR10MB7660:EE_
x-ms-office365-filtering-correlation-id: 2d028396-816a-4039-1eba-08db822bb3e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t5mgmc8UL5OTvvpnkT/dNIaCRRlSfkf6UafFVhgsSpda+hcPd7bLnk9ocnepDgTVzx5Knpp0xUiPqw/UkE5eeYLaJDZJ4x67ZBlPycr33/HjPNtBjIaysk4eNrDSqe3grpbMwuN5pt5dDIVrqXW5Wq3lQr99La8IDHX9dknJDIKzh0IRW9jwflEDkaHD4YJtX2TCkdG+H3xYZbjNflMTDJ1LZSJcWnPiUoJF6Xeu4FGWp/5m9RVp98Cn0i3pX6nKo2OTLgpMcnaRdPBtnO3YzNJk45o0Kf9hEfA0wf8XKR7es3IHFa17GGz6h4kfXeYSIBJ7oIzATwrfvki1S5a0VXRD5IOfJaKL2IgoR0pez34GU/Zwrc0cys0RHwIvFrxr9ieKjkvdkXNPdcPE/TNqbQM95tDkJWmpS4qWrk6gFFedtRi8GYFs2q8Rw7MDmTRB4kR9/A+oTrRgT2Y4HVv08gk8GGAwjZ/ObxiJQuCmfymWeRVlJHDE3vdDUXtwrkDp0BdtvqXNVP5PEooGJqGwLaqjRKwYSOE8p+nazLLesxR6PYqZFIBu5dvkCsegYlRYdL2RjseiKIjzMgGvD457Fg1m7BJPhe9qiroG51D0rtqtsf4EshDevRtVQuQYPioZj4zUL1HhHV1KGc9DXfXMFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199021)(8676002)(8936002)(5660300002)(2616005)(83380400001)(186003)(26005)(53546011)(6506007)(86362001)(41300700001)(33656002)(6486002)(71200400001)(316002)(6512007)(66556008)(64756008)(66446008)(66476007)(36756003)(2906002)(66899021)(6916009)(66946007)(4326008)(76116006)(30864003)(54906003)(91956017)(122000001)(478600001)(38100700002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GOuZP5sUnyljiv+1HdV9fh6gLbqWHZwH8imd6AIpJ2aGY2KdrDUIISGfLYq8?=
 =?us-ascii?Q?kqDDjtPMIllYEx2UObO5S/nMwnyuc3Xh/OBJ0/Nql5qfHjBwRocqGA61iG+o?=
 =?us-ascii?Q?2DvfUQ6mKmYcnoA6F8GMpkMIOOykFVqraNMhrG3jBhzDwll2qjTb6erRDRtw?=
 =?us-ascii?Q?aLqA/top2rtPX5TKhVQxTm0AXSo/XAdnPZk2uMSpJrnx21R0gMFVBlOZdyR+?=
 =?us-ascii?Q?wnbIuT4nT//+LP7DJC+SUTEFDp7kyspfPICX2Y2O/Sbd/VlKvyMLI+caX3c7?=
 =?us-ascii?Q?RlXZRnF3vXSKmUmdXzp3LV/6TER+OyUDlAZYmoGh3wwBg92SDnV+k1mD0D7z?=
 =?us-ascii?Q?gOKj9VBtSyJ+TDNpoS0zsEsFGhZYze6j7KFkycwbEOeS2VSzuVJKAQ+3AWt3?=
 =?us-ascii?Q?lu8ZEQrdPLiA/MjQH2+ZdrmI8JX4tgKazei3etac2T7klkKM29irqdml3K/0?=
 =?us-ascii?Q?Bw+ufEOQBfR/eTR+FJT+r9HP+BA2QrSm9yetoLnI5onOWv8d7Kf2opbKhTHc?=
 =?us-ascii?Q?ktuHFFjygUFzua4w557GlqX+h2ufI8eZtkIl5Tiq2vpimC1vJPDYuOOQCmpG?=
 =?us-ascii?Q?Xt34WnuibXuZbep22ppHuTob7+B9MRM+zH9qY5fddurY8SFG+W6JYYUOvwPc?=
 =?us-ascii?Q?jMO/yuBajH3490glE6pFGg/Lmo6KbWBBwO9obiUU/KjEjVuPGSCxFTLjw+Qg?=
 =?us-ascii?Q?LnM03qRhwHjg8Jg/AKM6RsCZeNbMZuepWfcjZqltlmH6XoWwIIQ+wwlG3q71?=
 =?us-ascii?Q?KXmGZEOay2ReLaVJqYvVqhiNV/cg4Jr4Bg3nLQpbvAuv45fapDdQpqXabQDR?=
 =?us-ascii?Q?YwpBjejYnbF4esuwziKpJejCDNWQXVi5D6hCpTYTpBzVoAoMK5QS5G15gRfF?=
 =?us-ascii?Q?SviuSCJnbjRDhEVo+mBwiejFSJrE/LDOODSmXowlcu3uwfVMHeae5wa08LXV?=
 =?us-ascii?Q?Hy2ovcBRcttm5z10iSWlAiu4M6hsmX3axvb1W9HmMnc7J0S5dWYLKPKaILyS?=
 =?us-ascii?Q?wObLs58R0gsSDTpBTGng26rypAv4TThAEcFXvpdkfHHVYmYKRtQFXoSjHDJC?=
 =?us-ascii?Q?tfJan57Iro8Y0J10Ec6bYaw7MnuDPWtWpdPJ+Pd0G9/5IQR+HOL1sNb1AVNI?=
 =?us-ascii?Q?xNRJMCIu5mnkACjHjGwIHPJO9GY26RI0AG5CAp+LxFjRurd3+7pHPCr0JdTZ?=
 =?us-ascii?Q?MvdMs8+RT3tGk9U1G2jZ1mR0OKD0xv/J+QcRgZhplM5eJIEupdndmGXEK6+f?=
 =?us-ascii?Q?vRaxngAsWhitA+FySoKTAVPXadvZ9DsMzrKxH6PZpQU/jdOb45l8zbbTzMkv?=
 =?us-ascii?Q?TNKSOz6Gjqj5E3O/5aXX4nhCCFNPwzD5kUlDUCntacVdFpoUzPluhkCEkpu2?=
 =?us-ascii?Q?6aUcZphaMXPfmb7lDClkaQZZJjs/rStp1bDmfg6U/e6LrLgTH1OrPbRuZzVo?=
 =?us-ascii?Q?tmCzIDxw5qGRmOAbpWmlsC/pD6C1GtC/NN+asSxbrgRtzOqAci+YFqyYQf60?=
 =?us-ascii?Q?NtK2msMp3X3Xlu482R0zuBkkZOkjiPhkXEerFdR+exckuXlX1Z+AhlUS8uJk?=
 =?us-ascii?Q?Xaqp3OGE5Bsh2qpMqQ5m95EPsjE8mqepLXeDT9DhBHYO9MGAh1m9nlUyYoqF?=
 =?us-ascii?Q?DQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <829570F7902D48408D5CAA231848B0C1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sQ5NVmFjiXJy8Bwx4qPLUfcKc4bsOoJhZl48jCQTJHTNjHl7I8yrx/oXs5OFlUkRpgEkmQOFHcX2qkJqVKAWc0OEKm2ioP6MDuwd4OxPUOGe5/tOzWR/wkeW0BGdhcj3T4+JQ6X2tvyUbgUmIwUGa3AgMii0Ar+8k7w0XmMH7sQ9XmczWT5BW+Dpi8Bj9e2EYPdri7awS65srjolKlEcmvWW33EgZaIxIBETTvTc1Nmho87vkxsBYVKE8NsPOmimTGCOMyjD/Q4OJao8javlnbxea76OV5B9PYl+JDC5UPlMsCbqa2O89uegvngBZrYpJiVODB8A24qK2CGbXCHIIWvHA/x+8hKe5IYxiZag7u2NQMxC8D2UP1g68J303JsjC0RADD9kaKA+ZNtFF3cvBtqxqBgVFwIb64vYj8FyVkvW2+CkTE5r7EtjFgti/Wp2pGvb228YVAvIymoKFVr793y5BVjSla+phfJ+IFUWbme/kQ1SdIkLWKtonC4zdWG/9ICwwG9I9f8yLdi+PBAR8w4gqftE5cMtQvYvJyEiR2/Y7XUK9iRwbLXPnr6rAWvpq896z33wWxfRlIfgNtb9q4+mp14kT1aTUKiBxIzPi6jvzz977e1o8Y8ry5t3JTpLN2Cl4UMBfoh/JwJ5M0Q1zNaF/i3LGpRTE/TR7GeVYSTb6O+WFjdz3+JpfgyZSTX/IeDNs2lT0MxtfH7kh5XO3r+eZNGVg1tS5JohS2wG68iIpVCPvVDctudzXJ+51Tu2RAbhyQjhnEWNSsr3XAPWetifauqKtDmHb86Gekar8ekHVFZr2rrDGog61WpoZtwrtVljvYTyt7rpZRYVIBI/u1fuYkjGlcu+WFhtZkXnc4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d028396-816a-4039-1eba-08db822bb3e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 16:27:21.6047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gfv96uLVMvZ/YhOzUXxKsq8Z2i0+AxjzujJ/fC4b/SrioaC0qyKohFL5qRLIybtd1aLlV8Pvz9HKdlllMEmLxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110148
X-Proofpoint-GUID: k84nrCErfQ4OODAxFO21FfuYw8pP2o39
X-Proofpoint-ORIG-GUID: k84nrCErfQ4OODAxFO21FfuYw8pP2o39
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 11, 2023, at 11:05 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2023-07-11 at 12:39 +0000, Chuck Lever III wrote:
>>=20
>>> On Jul 11, 2023, at 7:57 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> On Mon, 2023-07-10 at 22:24 -0400, Chuck Lever wrote:
>>>> On Mon, Jul 10, 2023 at 09:06:02PM -0400, Jeff Layton wrote:
>>>>> On Tue, 2023-07-11 at 00:58 +0000, Chuck Lever III wrote:
>>>>>>=20
>>>>>>> On Jul 10, 2023, at 2:24 PM, Jeff Layton <jlayton@kernel.org> wrote=
:
>>>>>>>=20
>>>>>>> On Mon, 2023-07-10 at 12:42 -0400, Chuck Lever wrote:
>>>>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>>>>=20
>>>>>>>> We want a thread lookup operation that can be done with RCU only,
>>>>>>>> but also we want to avoid the linked-list walk, which does not sca=
le
>>>>>>>> well in the number of pool threads.
>>>>>>>>=20
>>>>>>>> This patch splits out the use of the sp_lock to protect the set
>>>>>>>> of threads. Svc thread information is now protected by the xarray'=
s
>>>>>>>> lock (when making thread count changes) and the RCU read lock (whe=
n
>>>>>>>> only looking up a thread).
>>>>>>>>=20
>>>>>>>> Since thread count changes are done only via nfsd filesystem API,
>>>>>>>> which runs only in process context, we can safely dispense with th=
e
>>>>>>>> use of a bottom-half-disabled lock.
>>>>>>>>=20
>>>>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>>>>> ---
>>>>>>>> fs/nfsd/nfssvc.c              |    3 +-
>>>>>>>> include/linux/sunrpc/svc.h    |   11 +++----
>>>>>>>> include/trace/events/sunrpc.h |   47 ++++++++++++++++++++++++++++-
>>>>>>>> net/sunrpc/svc.c              |   67 +++++++++++++++++++++++++----=
------------
>>>>>>>> net/sunrpc/svc_xprt.c         |    2 +
>>>>>>>> 5 files changed, 94 insertions(+), 36 deletions(-)
>>>>>>>>=20
>>>>>>>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>>>>>>>> index 2154fa63c5f2..d42b2a40c93c 100644
>>>>>>>> --- a/fs/nfsd/nfssvc.c
>>>>>>>> +++ b/fs/nfsd/nfssvc.c
>>>>>>>> @@ -62,8 +62,7 @@ static __be32 nfsd_init_request(struct svc_rqst =
*,
>>>>>>>> * If (out side the lock) nn->nfsd_serv is non-NULL, then it must p=
oint to a
>>>>>>>> * properly initialised 'struct svc_serv' with ->sv_nrthreads > 0 (=
unless
>>>>>>>> * nn->keep_active is set).  That number of nfsd threads must
>>>>>>>> - * exist and each must be listed in ->sp_all_threads in some entr=
y of
>>>>>>>> - * ->sv_pools[].
>>>>>>>> + * exist and each must be listed in some entry of ->sv_pools[].
>>>>>>>> *
>>>>>>>> * Each active thread holds a counted reference on nn->nfsd_serv, a=
s does
>>>>>>>> * the nn->keep_active flag and various transient calls to svc_get(=
).
>>>>>>>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc=
.h
>>>>>>>> index 9dd3b16cc4c2..86377506a514 100644
>>>>>>>> --- a/include/linux/sunrpc/svc.h
>>>>>>>> +++ b/include/linux/sunrpc/svc.h
>>>>>>>> @@ -32,10 +32,10 @@
>>>>>>>> */
>>>>>>>> struct svc_pool {
>>>>>>>> unsigned int sp_id;     /* pool id; also node id on NUMA */
>>>>>>>> - spinlock_t sp_lock; /* protects all fields */
>>>>>>>> + spinlock_t sp_lock; /* protects sp_sockets */
>>>>>>>> struct list_head sp_sockets; /* pending sockets */
>>>>>>>> unsigned int sp_nrthreads; /* # of threads in pool */
>>>>>>>> - struct list_head sp_all_threads; /* all server threads */
>>>>>>>> + struct xarray sp_thread_xa;
>>>>>>>>=20
>>>>>>>> /* statistics on pool operation */
>>>>>>>> struct percpu_counter sp_messages_arrived;
>>>>>>>> @@ -196,7 +196,6 @@ extern u32 svc_max_payload(const struct svc_rq=
st *rqstp);
>>>>>>>> * processed.
>>>>>>>> */
>>>>>>>> struct svc_rqst {
>>>>>>>> - struct list_head rq_all; /* all threads list */
>>>>>>>> struct rcu_head rq_rcu_head; /* for RCU deferred kfree */
>>>>>>>> struct svc_xprt * rq_xprt; /* transport ptr */
>>>>>>>>=20
>>>>>>>> @@ -241,10 +240,10 @@ struct svc_rqst {
>>>>>>>> #define RQ_SPLICE_OK (4) /* turned off in gss privacy
>>>>>>>> * to prevent encrypting page
>>>>>>>> * cache pages */
>>>>>>>> -#define RQ_VICTIM (5) /* about to be shut down */
>>>>>>>> -#define RQ_BUSY (6) /* request is busy */
>>>>>>>> -#define RQ_DATA (7) /* request has data */
>>>>>>>> +#define RQ_BUSY (5) /* request is busy */
>>>>>>>> +#define RQ_DATA (6) /* request has data */
>>>>>>>> unsigned long rq_flags; /* flags field */
>>>>>>>> + u32 rq_thread_id; /* xarray index */
>>>>>>>> ktime_t rq_qtime; /* enqueue time */
>>>>>>>>=20
>>>>>>>> void * rq_argp; /* decoded arguments */
>>>>>>>> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/=
sunrpc.h
>>>>>>>> index 60c8e03268d4..ea43c6059bdb 100644
>>>>>>>> --- a/include/trace/events/sunrpc.h
>>>>>>>> +++ b/include/trace/events/sunrpc.h
>>>>>>>> @@ -1676,7 +1676,6 @@ DEFINE_SVCXDRBUF_EVENT(sendto);
>>>>>>>> svc_rqst_flag(USEDEFERRAL) \
>>>>>>>> svc_rqst_flag(DROPME) \
>>>>>>>> svc_rqst_flag(SPLICE_OK) \
>>>>>>>> - svc_rqst_flag(VICTIM) \
>>>>>>>> svc_rqst_flag(BUSY) \
>>>>>>>> svc_rqst_flag_end(DATA)
>>>>>>>>=20
>>>>>>>> @@ -2118,6 +2117,52 @@ TRACE_EVENT(svc_pool_starved,
>>>>>>>> )
>>>>>>>> );
>>>>>>>>=20
>>>>>>>> +DECLARE_EVENT_CLASS(svc_thread_lifetime_class,
>>>>>>>> + TP_PROTO(
>>>>>>>> + const struct svc_serv *serv,
>>>>>>>> + const struct svc_pool *pool,
>>>>>>>> + const struct svc_rqst *rqstp
>>>>>>>> + ),
>>>>>>>> +
>>>>>>>> + TP_ARGS(serv, pool, rqstp),
>>>>>>>> +
>>>>>>>> + TP_STRUCT__entry(
>>>>>>>> + __string(name, serv->sv_name)
>>>>>>>> + __field(int, pool_id)
>>>>>>>> + __field(unsigned int, nrthreads)
>>>>>>>> + __field(unsigned long, pool_flags)
>>>>>>>> + __field(u32, thread_id)
>>>>>>>> + __field(const void *, rqstp)
>>>>>>>> + ),
>>>>>>>> +
>>>>>>>> + TP_fast_assign(
>>>>>>>> + __assign_str(name, serv->sv_name);
>>>>>>>> + __entry->pool_id =3D pool->sp_id;
>>>>>>>> + __entry->nrthreads =3D pool->sp_nrthreads;
>>>>>>>> + __entry->pool_flags =3D pool->sp_flags;
>>>>>>>> + __entry->thread_id =3D rqstp->rq_thread_id;
>>>>>>>> + __entry->rqstp =3D rqstp;
>>>>>>>> + ),
>>>>>>>> +
>>>>>>>> + TP_printk("service=3D%s pool=3D%d pool_flags=3D%s nrthreads=3D%u=
 thread_id=3D%u",
>>>>>>>> + __get_str(name), __entry->pool_id,
>>>>>>>> + show_svc_pool_flags(__entry->pool_flags),
>>>>>>>> + __entry->nrthreads, __entry->thread_id
>>>>>>>> + )
>>>>>>>> +);
>>>>>>>> +
>>>>>>>> +#define DEFINE_SVC_THREAD_LIFETIME_EVENT(name) \
>>>>>>>> + DEFINE_EVENT(svc_thread_lifetime_class, svc_pool_##name, \
>>>>>>>> + TP_PROTO( \
>>>>>>>> + const struct svc_serv *serv, \
>>>>>>>> + const struct svc_pool *pool, \
>>>>>>>> + const struct svc_rqst *rqstp \
>>>>>>>> + ), \
>>>>>>>> + TP_ARGS(serv, pool, rqstp))
>>>>>>>> +
>>>>>>>> +DEFINE_SVC_THREAD_LIFETIME_EVENT(thread_init);
>>>>>>>> +DEFINE_SVC_THREAD_LIFETIME_EVENT(thread_exit);
>>>>>>>> +
>>>>>>>> DECLARE_EVENT_CLASS(svc_xprt_event,
>>>>>>>> TP_PROTO(
>>>>>>>> const struct svc_xprt *xprt
>>>>>>>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>>>>>>>> index ad29df00b454..109d7f047385 100644
>>>>>>>> --- a/net/sunrpc/svc.c
>>>>>>>> +++ b/net/sunrpc/svc.c
>>>>>>>> @@ -507,8 +507,8 @@ __svc_create(struct svc_program *prog, unsigne=
d int bufsize, int npools,
>>>>>>>>=20
>>>>>>>> pool->sp_id =3D i;
>>>>>>>> INIT_LIST_HEAD(&pool->sp_sockets);
>>>>>>>> - INIT_LIST_HEAD(&pool->sp_all_threads);
>>>>>>>> spin_lock_init(&pool->sp_lock);
>>>>>>>> + xa_init_flags(&pool->sp_thread_xa, XA_FLAGS_ALLOC);
>>>>>>>>=20
>>>>>>>> percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
>>>>>>>> percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
>>>>>>>> @@ -596,6 +596,8 @@ svc_destroy(struct kref *ref)
>>>>>>>> percpu_counter_destroy(&pool->sp_threads_timedout);
>>>>>>>> percpu_counter_destroy(&pool->sp_threads_starved);
>>>>>>>> percpu_counter_destroy(&pool->sp_threads_no_work);
>>>>>>>> +
>>>>>>>> + xa_destroy(&pool->sp_thread_xa);
>>>>>>>> }
>>>>>>>> kfree(serv->sv_pools);
>>>>>>>> kfree(serv);
>>>>>>>> @@ -676,7 +678,11 @@ EXPORT_SYMBOL_GPL(svc_rqst_alloc);
>>>>>>>> static struct svc_rqst *
>>>>>>>> svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, i=
nt node)
>>>>>>>> {
>>>>>>>> + struct xa_limit limit =3D {
>>>>>>>> + .max =3D U32_MAX,
>>>>>>>> + };
>>>>>>>> struct svc_rqst *rqstp;
>>>>>>>> + int ret;
>>>>>>>>=20
>>>>>>>> rqstp =3D svc_rqst_alloc(serv, pool, node);
>>>>>>>> if (!rqstp)
>>>>>>>> @@ -687,11 +693,21 @@ svc_prepare_thread(struct svc_serv *serv, st=
ruct svc_pool *pool, int node)
>>>>>>>> serv->sv_nrthreads +=3D 1;
>>>>>>>> spin_unlock_bh(&serv->sv_lock);
>>>>>>>>=20
>>>>>>>> - spin_lock_bh(&pool->sp_lock);
>>>>>>>> + xa_lock(&pool->sp_thread_xa);
>>>>>>>> + ret =3D __xa_alloc(&pool->sp_thread_xa, &rqstp->rq_thread_id, rq=
stp,
>>>>>>>> + limit, GFP_KERNEL);
>>>>>>>> + if (ret) {
>>>>>>>> + xa_unlock(&pool->sp_thread_xa);
>>>>>>>> + goto out_free;
>>>>>>>> + }
>>>>>>>> pool->sp_nrthreads++;
>>>>>>>> - list_add_rcu(&rqstp->rq_all, &pool->sp_all_threads);
>>>>>>>> - spin_unlock_bh(&pool->sp_lock);
>>>>>>>> + xa_unlock(&pool->sp_thread_xa);
>>>>>>>> + trace_svc_pool_thread_init(serv, pool, rqstp);
>>>>>>>> return rqstp;
>>>>>>>> +
>>>>>>>> +out_free:
>>>>>>>> + svc_rqst_free(rqstp);
>>>>>>>> + return ERR_PTR(ret);
>>>>>>>> }
>>>>>>>>=20
>>>>>>>> /**
>>>>>>>> @@ -708,19 +724,17 @@ struct svc_rqst *svc_pool_wake_idle_thread(s=
truct svc_serv *serv,
>>>>>>>> struct svc_pool *pool)
>>>>>>>> {
>>>>>>>> struct svc_rqst *rqstp;
>>>>>>>> + unsigned long index;
>>>>>>>>=20
>>>>>>>> - rcu_read_lock();
>>>>>>>=20
>>>>>>>=20
>>>>>>> While it does do its own locking, the resulting object that xa_for_=
each
>>>>>>> returns needs some protection too. Between xa_for_each returning a =
rqstp
>>>>>>> and calling test_and_set_bit, could the rqstp be freed? I suspect s=
o,
>>>>>>> and I think you probably need to keep the rcu_read_lock() call abov=
e.
>>>>>>=20
>>>>>> Should I keep the rcu_read_lock() even with the bitmap/xa_load
>>>>>> version of svc_pool_wake_idle_thread() in 9/9 ?
>>>>>>=20
>>>>>=20
>>>>> Yeah, I think you have to. We're not doing real locking on the search=
 or
>>>>> taking references, so nothing else will ensure that the rqstp will st=
ick
>>>>> around once you've found it. I think you have to hold it until after
>>>>> wake_up_process (at least).
>>>>=20
>>>> I can keep the RCU read lock around the search and xa_load(). But
>>>> I notice that the code we're replacing releases the RCU read lock
>>>> before calling wake_up_process(). Not saying that's right, but we
>>>> haven't had a problem reported.
>>>>=20
>>>>=20
>>>=20
>>> Understood. Given that we're not sleeping in that section, it's quite
>>> possible that the RCU callbacks just never have a chance to run before
>>> we wake the thing up and so you never hit the problem.
>>>=20
>>> Still, I think it'd be best to just keep the rcu_read_lock around that
>>> whole block. It's relatively cheap and safe to take it recursively, and
>>> that makes it explicit that the found rqst mustn't vanish before the
>>> wakeup is done.
>>=20
>> My point is that since the existing code doesn't hold the
>> RCU read lock for the wake_up_process() call, either it's
>> unnecessary or the existing code is broken and needs a
>> back-portable fix.
>>=20
>> Do you think the existing code is broken?
>>=20
>=20
> Actually, it varies. svc_xprt_enqueue calls wake_up_process with the
> rcu_read_lock held. svc_wake_up doesn't though.

Good catch. I'll change 1/9 to hold the RCU read lock until
after the wake_up_process() call, and then leave that pattern
in place through the rest of the series.

1/9 will be straightforward to backport if that should be
necessary.


> So yes, I think svc_wake_up is broken, though I imagine this is hard to
> hit outside of some very specific circumstances. Here is the existing
> svc_wake_up block:
>=20
>        rcu_read_lock();
>        list_for_each_entry_rcu(rqstp, &pool->sp_all_threads, rq_all) {
>                /* skip any that aren't queued */
>                if (test_bit(RQ_BUSY, &rqstp->rq_flags))
>                        continue;
>                rcu_read_unlock();
>                wake_up_process(rqstp->rq_task);
>                trace_svc_wake_up(rqstp->rq_task->pid);
>                return;
>        }
>        rcu_read_unlock();
>=20
> Once rcu_read_unlock is called, rqstp could technically be freed before
> we go to dereference the pointer. I don't see anything that prevents
> that from occurring, though you'd have to be doing this while the
> service's thread count is being reduced (which would cause entries to be
> freed).
>=20
> Worth fixing, IMO, but probably not worth sending to stable.
> --=20
> Jeff Layton <jlayton@kernel.org>


--
Chuck Lever


