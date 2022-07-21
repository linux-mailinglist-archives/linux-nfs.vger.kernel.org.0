Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF8B57D38D
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jul 2022 20:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiGUSqT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 14:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGUSqS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 14:46:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA78220CD
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 11:46:17 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LIDuKO013157;
        Thu, 21 Jul 2022 18:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2ytQbLjgopN+s5MfhGP8BiBs3MvO8IKumM/S07o7bcw=;
 b=TdmoBjhUctTMaRhymX+XZHg4lwgvYH3WFQq3lxCfzFI5u190F6m6zOTvx7TgWTqkHGNz
 PH1xqgRMMzhjcNa07PJ/Lvyx/iqFy9nqXBSi4Rb02YJiQg6B2jD7EHYaTBRDWW/U8qqf
 88zx3AF2ckuc9eczkWrAtArnL0+nUJdq3iszii7RrRXZip+nZIAK5xjepfpinBMed5DU
 4Yg8HRxJBiwRgyztav8GrmyVSr+kCmxk/ibIHBCSLASz7kWQBkb6ojZQTLI3CfHsZ98D
 7dnmTrt3gdAMDM6wkkJEpZI7Sn7B42kFcjPPrBwnCZIFT46l8HYlXlbPe5n3mzcRCHGW 0Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxsddbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:45:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LHpsFn039297;
        Thu, 21 Jul 2022 18:45:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k727j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:45:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7Q/EmQA1y6H+ghnoBwOkGRvVjpjbfpKeF+f/2qe43i3uvt4BmAYEF7wSRt1yL8qvt3nOYgrHao9J0a+9vAZYarPkh8KADcpjilFJkHmNojRGvhb/6/MeTOfzdGHWylFivY0UmIBUg5WaLAnvc5TxDl0WPnrXnCf0gPYAMjqwVdWBeo6LRDMoPk3V4Wq9GifSZwbpod6Vy4O9f2DUHUsurSbnfe9rzybBw3IIkBtRm/97WCXQ71y90xAfRgBoZ4R/DLUh6MqQrBUfheS9TnpdzZwxLhKAexhyRX4ysSxr9SVBX5YlH25lyHNzsREJqpqJ9JX0k8NqVlxGmkIR+00Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ytQbLjgopN+s5MfhGP8BiBs3MvO8IKumM/S07o7bcw=;
 b=kbMse9U3xf3G8/QeqS3mf/+LDozj8O1HhYQjmmqx9QXUOS2VN99uwVPmVs6iHbZ893O0m47d9VcPUMSWpNj8L9gJMShrHPhCHjM7lkL3pwujq0oY0jbtyU6A//EePlO4DOH4/wKCe99Fa7adq5Dlne7Kw4LuX9xTXWYXaGq16KnZjHVWU2/3Etl9sqvCxV1vSonwg9pnZ+eqpxOk4sPmc8Cp3euzB8d6tYSEYN1FMnfcfxwmmQbTU22m49r8E6f+PvorxEsMaIxNW0EHgTumJMuw8iBxCypjy+G+nmYr6TFSOiBAfmFOFE6SQNsVuv3UvU1DDJlpMKe1IwYRP1+XVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ytQbLjgopN+s5MfhGP8BiBs3MvO8IKumM/S07o7bcw=;
 b=exWuIHj8wuzlDN7IweufcJ7/iHQT359msAajpBCQcVAc0S8qYJgGao/o6xGQ4igvLKOALfrwTtVqdp5aduNaswmkwSvWbvriFPatE4agfS8WWLHKzrX4rTOKbw/tKAzmuPvb7CGz8DNDmU5chGRHwrM9a/3nUJUYhvjQHc6IRbw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB3790.namprd10.prod.outlook.com (2603:10b6:208:1b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 18:45:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 18:45:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Attila Kovacs <attila.kovacs@cfa.harvard.edu>
CC:     libtirpc List <libtirpc-devel@lists.sourceforge.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Thread safe client destruction
Thread-Topic: Thread safe client destruction
Thread-Index: AQHYnTF6fzXlFwD9KEiv5zmVGW3BSq2JKdKA
Date:   Thu, 21 Jul 2022 18:45:54 +0000
Message-ID: <4D490A86-E873-40E7-A30E-9189B127C65C@oracle.com>
References: <53af8ec6-4ece-09b2-9499-d46d0fdfaa15@cfa.harvard.edu>
In-Reply-To: <53af8ec6-4ece-09b2-9499-d46d0fdfaa15@cfa.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee052a7b-0222-4438-057f-08da6b493e1b
x-ms-traffictypediagnostic: MN2PR10MB3790:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yDNd/WgwDyWQIkPIqUK63Txvmd/D/91rvfQxKnXYaWbRE2uwOXA56YTb1G1eIYGsY1bqlmDoLvJK5g/D4P5hV2PCG+35Cvaoo2AMR+ZFiJ9mStdIq49QVlBJF38IDFEF2+7n6qazsU4HMKaE/ABsRorIfUCWye/H0uCv55widfPdhvR5BS2V953cNaxidog5qutydTN5i6f+Ns9yNFnp1PKVfEbKCGXFcGrx+kOiOQoxR5IslitMfb7BuM2P5dOjrenOW+OYe2pu4MFSpZJIHzFfwQntSQg9IFM1HcGmfJtnVHxSbGQ9eATSziMN9cN9AdHe+4DmW2vF9sUTOzzcvjFOSsJ3U1FzaThzmbhYpQjrlAd/0vd2dzzyHoe+a2ELSWq/qssOnVkp6CHB8WKGWJmBr6DiU3mppar3oMRz06HdVBxWdfDjdOmBtvqSK0FcOrQBnSpAF+kirc5Sbeyf7LVjxGebQj28wMqbliNbdZCB4Z4A2JeV8RfRtaI34Su5iPvUdsi1lDaKQkfwwWjUBFQVTdUU1HojdKZI31lZaJZ66Mjok4bAwWMT8woqzzTzzCqCvstQwLacnMe6JjjWcT9nCOIBjIGESktZ0YfFKxtPQQiPPjmZjZiFDVXIVpO84aknLOrfeyCEGvVCuUdq0uBR5UFpSe9DVBZ+dFHYxtuZm19EKZPQfTUkZ++0rXJfkaRqyZivIwxuxXR+aKkYP1cObdIhUzhgIpX+oQN+LCbVzUmoJv+Y6Djgkx/15rpt9Tubz4MOtvihkvu+dxuUaXjAnz/+k8PbizBSWCJD+fd0/fpIQqqMJaLZTOzBAxYLaWsVEIUZqZlW6pzcGICV5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(39860400002)(376002)(346002)(86362001)(66946007)(478600001)(8676002)(66476007)(91956017)(33656002)(76116006)(66556008)(2906002)(4326008)(64756008)(8936002)(38070700005)(38100700002)(5660300002)(53546011)(3480700007)(2616005)(36756003)(26005)(41300700001)(186003)(71200400001)(122000001)(316002)(6506007)(6916009)(54906003)(66446008)(6486002)(83380400001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QvRuGHYD6S4VtFhj7zUZT4p7nmyvcgAZZqsBfDU+JhMmqX2t5AHaFC34jotA?=
 =?us-ascii?Q?KAYLYx4GYUlBs14XTpevoIKGYH78xm02j3Rbo9S9BPoQau9dCxFWblGVd12w?=
 =?us-ascii?Q?2B9ZK9G8xaiJzRuTIcgCgArgvAKrFdpVLZ1sw3fXsfktlEjVdx1eWdhYqWDm?=
 =?us-ascii?Q?zaUxi0jcA3TQ8dGerReOoYzfC6DZSdwgEeRgqBW48kOwq74pj+Np1ivaFwKP?=
 =?us-ascii?Q?QAStbYToh2E9FTbWSRbiVO6bUUtqr1aZBviX88K+Aw6D8lQfKRzXU6T9UtHc?=
 =?us-ascii?Q?wITB60YYnhokuOThKwkzNGqXUc+M6YY4uBHDppOAtytUIIJ+bjNBYsAQxuma?=
 =?us-ascii?Q?m9CPHG0eNGYViZCTE0GmDEUSpTmbfy2jmSwnVdJW5XhGHGlBp3T+crVqkKH8?=
 =?us-ascii?Q?0LVXn6i4VISX5KHovEArw3gTywkBzgkOcARF1Pd49HOP5kskobFXFbSAVSPx?=
 =?us-ascii?Q?MMOo8w1Mp8WqMEeqFnKz3DMO9KPLgiH0qIDLKqBCibvuPwzxS9M5mfJW9OO7?=
 =?us-ascii?Q?HC37xdY3JL21bmb6JCVotZv13DjYP3JjLOs2iXISuB2ELQ6JFSW6VXtOvDOz?=
 =?us-ascii?Q?Qhls4CdnXnf0x1ciqI+8sVeYNA54PtTTUXFBs7aHTHTMd/cXgjG1hXSphK5M?=
 =?us-ascii?Q?BLLePCk0geC4YnOBL55PMdCTRj6101JVSHd1qquc+CjOlQHah2f/DnWLrErI?=
 =?us-ascii?Q?uQLEhlID7FKdr9s/sJoXb8EXjp38pzYNaSv6WNFjrVZ8OzNjhZDTfyFyvHRj?=
 =?us-ascii?Q?k2rbPt4FZ2ia3JkSEmHKtDBEfujC7F9fi75dnrSqX9SeQ+P4RjYWu8NwzCYI?=
 =?us-ascii?Q?kj4gzc+yEyA02+mkxjeuUEwHxq6QkF31OYeysYtgqyfuST4jMm8MEU4ge3Ey?=
 =?us-ascii?Q?yK+dSWkw/QvP02tiXV5O40Ew0VGLpUjBNt8B9OSuu6KLbEVINlnCxW7LIB6B?=
 =?us-ascii?Q?HMA03VHpeJkpZAp58JRY/+DWs2gvi3rtm+yGWfcEvdIoQct31ws6Hb+sPHwC?=
 =?us-ascii?Q?sQUiSqhAsJrIOMW5jr0napUYRhyjB34jZ/eetzCS7faPY0JP6c/bs2yoeL4Q?=
 =?us-ascii?Q?li+gOHx2NpECOcRuon10gajqb62grt8rxcKmPAHC9lME9u56sMSkc3OA6s5N?=
 =?us-ascii?Q?GD/CLlqXV8UN/voeJDdkPF6OFS9Mt+qtqA0p6FNiH1y1geKCfq+S5syCyINA?=
 =?us-ascii?Q?M7s7UDF3WlSAGFEs8gU7nZMwkbQaZganxEcgDxGciIwqTmwCJneNHk8/mnso?=
 =?us-ascii?Q?cnqb4y9STo+SSGik1RZ204i+dfpHEngtWMoALWW7wokED2vWusu9lHRg4ND2?=
 =?us-ascii?Q?1rTa7JJkspvlRzRV0IVuxKvXtkxVJUWtz6hKAJQ2aUg3klmKjTHlP2Xmby2n?=
 =?us-ascii?Q?nStuKrjgXvzIHdsf5PWeaXQrWsT+YFNvp+e8rdWHF0BHYZw9h5Uay+jC4zbF?=
 =?us-ascii?Q?tHl+wZeFBAyf6hXd1J+tzXdBa2lmiOckgBpwIpa0G0DZsdpuAUWM758mk1Rz?=
 =?us-ascii?Q?LEbhguRY/VRMTum45K2oKPEOkUzbTplpJ2DZkJB7A2uzSfqFDi7jp7Xyh7Gr?=
 =?us-ascii?Q?n1IJaSvFET9fPWAYyx29H3wZ+vxSPxjhs2RHvapTQkepmAmLhvAWuMnpQjKv?=
 =?us-ascii?Q?rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5FFCF6AC4B3904E8754440A347F20C5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee052a7b-0222-4438-057f-08da6b493e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 18:45:54.4776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uTCPoclgDRPvhLw9vP82oKrV0EFtLUDcpSXkrZ76Hi53v3B3lGRQlaZtVgIUfENPIlf7wrNAoCq2A17D+i4J7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_26,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207210075
X-Proofpoint-GUID: JGSTIxNWGkb2BnaYjVMzZMFcDiakQCYY
X-Proofpoint-ORIG-GUID: JGSTIxNWGkb2BnaYjVMzZMFcDiakQCYY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 21, 2022, at 2:41 PM, Attila Kovacs <attila.kovacs@cfa.harvard.edu=
> wrote:
>=20
> Hi again,
>=20
>=20
> I found yet more potential MT flaws in clnt_dg.c and clnt_vg.c.

IIRC libtirpc is not MT-enabled because it was forked from the
Solaris libtirpc before MT-enablement was completed. I could
be remembering incorrectly.

Therefore I think we would need some unit tests along with the
improvements you propose. There's a test suite somewhere, but
someone else will need to provide details.

(and also, please inline your patch submissions rather than
attaching them, to make it easier for us to review. thanks!)


> 1. In clnt_dg.c in clnt_dg_freeres(), cu_fd_lock->active is set to TRUE, =
with no corresponding clearing when the operation (*xdr_res() call) is comp=
leted. This would leave other waiting operations blocked indefinitely, effe=
ctively deadlocked. For comparison, clnt_vd_freeres() in clnt_vc.c does not=
 set the active state to TRUE. I believe the vc behavior is correct, while =
the dg behavior is a bug.
>=20
> 2. If clnt_dg_destroy() or clnt_vc_destroy() is awoken with other blocked=
 operations pending (such as clnt_*_call(), clnt_*_control(), or clnt_*_fre=
eres()) but no active operation currently being executed, then the client g=
ets destroyed. Then, as the other blocked operations get subsequently awoke=
n, they will try operate on an invalid client handle, potentially causing u=
npredictable behavior and stack corruption.
>=20
> The proposed fix is to introduce a simple mutexed counting variable into =
the client lock structure, which keeps track of the number of pending block=
ing operations on the client. This way, clnt_*_destroy() can check if there=
 are any operations pending on a client, and keep waiting until all pending=
 operations are completed, before the client is destroyed safely and its re=
sources are freed.
>=20
> Attached is a patch with the above fixes.
>=20
> -- A.<clnt_mt_safe_destroy.patch>

--
Chuck Lever



