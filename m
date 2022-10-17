Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7885B60168C
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 20:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJQSpn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 14:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJQSpm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 14:45:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEC354667
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 11:45:39 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HITJtt005795;
        Mon, 17 Oct 2022 18:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wt5EQIIuDqs6E5DRWT/pdBd3KXenjV9DaIY5gBmfRpA=;
 b=mb9hWindRCJMTMTlKFIjSbznFmAsopp5cb1/iweSFipajot8YX3CBIHDojM7poYQsyI/
 Dlr30V5T+gBcfqEXjO4vrzRe2dqynLpjHn12KdmyQJYZhUVFIn8bnotWSP2Ka4YvM7Ta
 iLY0zJ+NKgU8+hlPwmeVqKQ2CxnVDdAf/24GlfzdAwYWVkKnf2mvbCA/nCTUnBUNJCc+
 XdbyodmPx4mci7KMawQd4hP06HcIcbALIaYkp3/kxOYfEEmWnecdq9fUNlUUFTgfjmm2
 1Iex05QurvjtLialM8dOwnL8DimSwQlNzkN0W7Csdc7NQGIJPtCQUOZOPcSNUSu6ctdf +Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3cdqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 18:45:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HHKES4015964;
        Mon, 17 Oct 2022 18:45:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr9am06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 18:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFM8a96z7VfiOZPS+65P6ZVkbIrRnWe2k+lXHoO1yobRtXmfyGVGNpsXbABsr7c6JaWa7xIbLovLM57RVTeNg91BVJcEsAz8yPQXPQFX+hMc9IkoKurocQ62nipmVSkSPLvFUD5EzRSUYNfLRkhBT+KCZwk5eEjovV46rp6pHVBn/Btc/Nff5bNHfp5QqJIJieXKsjIxGzoZFqNRxKqIumZm7UN1Yr+N5mQPXvNwO54iVdd7W0yBN6blmLt4o6S7pO1J6/WXqyd8bTOYSa2e3zWW+oJx7lIN2X1Ja35fbx5vsxWxVBWjbm2gRFQKdyGnnDsYKGPg/zwLl63ZcMpr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wt5EQIIuDqs6E5DRWT/pdBd3KXenjV9DaIY5gBmfRpA=;
 b=ftRPYHvs3TO6YpEmWzZPyqPdVxCSbb5M2mCwh68F3WPkETVnCrEK//Ime5kuOWsupzu0boz9CKzbi1pLOxsKmooiujk83KCbtv5KneBUjjvOWNw7SGoGOtNI7X6pKrsapUy5FBIS+Nbv0FSpP0YelzI0u+xCZrz73wnlpbO5sbJUDxQVI3z3aTuTf/l+q9vdCAB1+slE2ojJtxeE7Eu1q3lBPfeczuBTR8Rgw4lLaphlPNVh1qY2rHdNsgjlt/1MOzAhO9bOU202tWzL9v+uKm2PLg4odjPK4O0NM87JklZ+JdAJ+FDbMhUBZDkdlPF8DkhG/oIM2w9PSgVwPPH7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt5EQIIuDqs6E5DRWT/pdBd3KXenjV9DaIY5gBmfRpA=;
 b=y6en7uj+PzIeukZ9Pxy6zWlie0BetoDuW2qwIOqf6VXg2w2YFj97rB39J7Y/FqsZN6Rva73xvb7PmtMr7IU62OKAgnpIp/ufP701uL1fK9xMVf+WgGbzURHSoCIpoSXf9/aOGTLWgY7CfpNRPpl9pFAiDaYoRg3TaAhjpafEKCo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5601.namprd10.prod.outlook.com (2603:10b6:303:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 18:45:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%4]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 18:45:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: allow disabling NFSv2 at compile time
Thread-Topic: [PATCH] nfsd: allow disabling NFSv2 at compile time
Thread-Index: AQHY4kkOiBiIuJMRl0iShrTGEOpy/K4S7K4A
Date:   Mon, 17 Oct 2022 18:45:28 +0000
Message-ID: <1E2A0451-4D2C-4E8D-8241-C128F7CEF20C@oracle.com>
References: <20221017165353.462811-1-jlayton@kernel.org>
In-Reply-To: <20221017165353.462811-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO6PR10MB5601:EE_
x-ms-office365-filtering-correlation-id: bd621722-ed41-4ad2-44d4-08dab06fc33e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pHogt0/M2fDGBz3LjTymhnKxrUBFoRImj7zJ3hi5HEHfilpQn77R5GVDt7fAAaIMnd83kPHdNJlkw9y/8m1J2t5mzkpcnO/x28eRKhv/GwmqZWBPnLeRjGHQhoQOgsj0DrtOqFuMdVhQiT65ClaZ5AybgIGMiu5bbLhAGs9zy4+TY7GMig4mxoZPVWMF0AGIICeepySyh7N5u3jn7xsablT0CeKqoB0Aqm4aqFuP8I26xeL9kxFWvI69gPvQEU8PS3RBwE85GwdMBf7or1y7+rpbmhW0EH2OPfBTcb6AtnxLaCjwWArRTK8XwAOP9ILznjQTh/2/gguokXSXHk+5OTEvNqpgTe0p5BLfoQ9RwTvp1dx7yr/9DwVXrJEgNeUlGy+dhkLU5Glqhm+d5Ojy+SYKIQU97i3t1lky0zAERLC2oP9fxFvqcSJkIWBbWaSZYqJ1wVk455muLklU73dSO+3wzbdlH/NN5GdMwpzvc3JYRij+pTGRXkHTP0FOgTkWXeXZ8cgP+0/YdlwoDgxVFeXxCCI4446fSIQwaVV/gqXxoynt18Wcm2iozoAcpwOh2fqHdqGAYGX9HZjPIC9uGlNzaqCpZfzAKTCyBY7uKI2cldP0Wh4JcHJdmiDVqzn1F/F/c2O95K+2Pp/fjoDwdsiUruAWj6Lj0ezJNndscDtmGiKMtlrsWIRVIrk7kNKJf2lgpDPpP40wXWWkksDYmZ4En2pM/W8SwqMkwxIiXQ/D7DY5adheAfHkZXvBtYtPvCNCkpfykQYAsMnd8p6jIhhellOIbbryU8rLABxrDd1VCy7tipuOYrZjFo9JDWikvnq/1OEzW3bIFlCfIIBYvxlwE9rJ/Bt5wWBmrvrlNqE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(6916009)(4326008)(66556008)(64756008)(66446008)(66476007)(66946007)(8676002)(91956017)(76116006)(33656002)(2616005)(316002)(186003)(86362001)(83380400001)(2906002)(26005)(53546011)(41300700001)(6506007)(36756003)(5660300002)(6512007)(8936002)(478600001)(6486002)(38100700002)(122000001)(71200400001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q1xL3RU/1GkZYHYoy5lEnR7+Ty3CT0/8pV0DuVa8jlw+BrylkkgFi5jGqv41?=
 =?us-ascii?Q?TWMWT5ca2Jg/NYQkde4f2zJmrmX+x/KgUcrlbOEMAR9ABUE1AjmLXyNl1Kkr?=
 =?us-ascii?Q?INgUbtSbK7MLa0itTsAq9zJOOf/kBdM2zAh7v4F4z85I97YzVJRA8AsZz8HZ?=
 =?us-ascii?Q?rrQbQmaDdziIp/PExipDV7E0u19nbL9ZzzSjrjVdqgwHQOFmgLosM/Cjyx1C?=
 =?us-ascii?Q?OGudgvnsGe7+PJrilrMowuweRhaO6bpd3fv/vZw8rzw39DhZuePmx+Ms1wco?=
 =?us-ascii?Q?pqt4M6g4wNqIvafCzcf6EGC8GQEmP0WIvpEsMOlZ6YPIZ147G2DIC543hiBE?=
 =?us-ascii?Q?3Ze9xZemqZQcr0G/UrhFHKq9eaQJA7wRtmz0TxtZibZt3155TvxEbIDTphIb?=
 =?us-ascii?Q?kfWT5nveFfhsIxB9fljz/RJ8LDlb2r5Wk4qRWI6ecNZl6HwQd9lSt0yAuX+0?=
 =?us-ascii?Q?b+aHS7LzF6FqD6tBpniZ+zN8LoXwOfAQEty1+m9PuBmKC9EgUSyTGl/du2vB?=
 =?us-ascii?Q?s5SQXAH1ApWKbUGsiSAcUaxFyPlz6GMCOT6QOv3chDUu9Ms5U/BJ4XP9Vv7v?=
 =?us-ascii?Q?QaBA+eBgdlhDw1lgYeJMOm8w66fChWrjm0T3oWd3LXtAylwpwy5E/g/L1q9J?=
 =?us-ascii?Q?Ccp8SQxZQ0L9NgodeBlzu3a/aZjcMfaYcrjH7t+RG9ltxiIlZnd8y+BBNvvj?=
 =?us-ascii?Q?e83IS9zqsNG5Yf8VVE0J7YL7Cb4SmR1bbKxofRW+jQfJMgJVc/cM6zQgwjMF?=
 =?us-ascii?Q?HQR1XSbd6Z1zVK1ZMpJHYaWc2+3WU9WPAw8c6kzYxit1MDORv9abnUaM5AM1?=
 =?us-ascii?Q?AkhJZd3j9oF++qSsK52Ma81yNzDdcymkMgpUno952uVqOwEf1f9xqXMaNj0c?=
 =?us-ascii?Q?N1hL+DhbLZvO8aRBfj8x0m5nDYjwdamICkZlORMRIeX9wAAvKQ53T8KrONVw?=
 =?us-ascii?Q?YH/YVR8qCjRStuAUjNYJCq9e6ji5053wReoHk3SBHDP4xflAtCzhZD0xz289?=
 =?us-ascii?Q?F5rTWQPJAisrmvi12CAERjhCR0rQ/gng/b+/Mad6+dQR1I7FZiOJnWaZAyH9?=
 =?us-ascii?Q?fmhztegYENRaFgzD8Q+zNNPRN5voGhGmTPO7pRkrk+ItYJT19RoqnvQJR5ek?=
 =?us-ascii?Q?Wuz5eCIh7FlDi+xMrNK0mB5VnmzZvL+rcs/stMvhrAIXfut++m8kjNc/cMBk?=
 =?us-ascii?Q?tKSZjNoryeWvPYYxB4VJd8U+ktG4hrjZp+eIuuR29bqqHOk1TrH1HDwAqC5O?=
 =?us-ascii?Q?dbkkDjRbOAtT2GozSLcOk16vKFooy3V/Fn6AQ7naK6uZ6p1Yi+vUk3s+rarm?=
 =?us-ascii?Q?FVGlh6o5GiWNRvdpiFS0ZHMgxHOzGTxJQb75HBS+UUXSyBKzHnONqgH8VGWq?=
 =?us-ascii?Q?IuwzWxkGGkL++JmIPpUSiNFAwIzlLlzIJ0fKOmiXOl5pDLubPef0iV+E1OGI?=
 =?us-ascii?Q?GXoIK55UHrybRPee0eYyY4CbKo+tKlSqADpSJny7QT1Anob3Ph7831XA9dZ7?=
 =?us-ascii?Q?ds9IhhwL09DEvYK1aOrWDotntOuwZsd7Q88b2S/e6Q0LYrctDzlmVTu3NtzC?=
 =?us-ascii?Q?9KofVIKPbzfv0PJyDI/xXaifypgPoFYyaKqNk4t24F730ROIJk9/Pep5ndrR?=
 =?us-ascii?Q?RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F92325A8329E1B4AB41D0F1C53B96703@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd621722-ed41-4ad2-44d4-08dab06fc33e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 18:45:28.9217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9vNk+IUsATOypzWXMoQI3CX6JTG96yqisMdVU/S+EU3AnLSk82bAOSeV16kmLB1/aVNAgv8BKWHz6n/rSbT/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170108
X-Proofpoint-ORIG-GUID: uYsCII2ahVTTSZ7DWWywZK6Ll7EjALgw
X-Proofpoint-GUID: uYsCII2ahVTTSZ7DWWywZK6Ll7EjALgw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 17, 2022, at 12:53 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> rpc.nfsd stopped supporting NFSv2 a year ago, take the next logical
> step toward deprecating it and allow NFSv2 to be compiled out.
>=20
> We have long-term goal to deprecate NFSv2 in modern kernels. As a step
> toward that, allow disabling NFSv2 serving altogether at compile time.
> Add a new CONFIG_NFSD_V2 option, that can be turned off and rework the
> CONFIG_NFSD_V?_ACL option dependencies.

Can you move nfserrno() as a separate patch? I don't think export.c is
an especially intuitive place for it. Maybe vfs.c ? Other ideas?


> Fix the "versions" file to properly reject versions that aren't compiled
> in, and change the description of CONFIG_NFSD to state that the always-on
> version is 3 now instead of 2.
>=20
> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/Kconfig   | 12 ++++++---
> fs/nfsd/Makefile  |  5 ++--
> fs/nfsd/export.c  | 61 ++++++++++++++++++++++++++++++++++++++++++++++
> fs/nfsd/nfsctl.c  |  4 +++
> fs/nfsd/nfsd.h    |  3 +--
> fs/nfsd/nfsproc.c | 62 -----------------------------------------------
> fs/nfsd/nfssvc.c  |  6 +++++
> 7 files changed, 83 insertions(+), 70 deletions(-)
>=20
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index f6a2fd3015e7..c3c43b5e3892 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -8,6 +8,7 @@ config NFSD
> 	select SUNRPC
> 	select EXPORTFS
> 	select NFS_ACL_SUPPORT if NFSD_V2_ACL
> +	select NFS_ACL_SUPPORT if NFSD_V3_ACL
> 	depends on MULTIUSER
> 	help
> 	  Choose Y here if you want to allow other computers to access
> @@ -26,19 +27,22 @@ config NFSD
>=20
> 	  Below you can choose which versions of the NFS protocol are
> 	  available to clients mounting the NFS server on this system.
> -	  Support for NFS version 2 (RFC 1094) is always available when
> +	  Support for NFS version 3 (RFC 1813) is always available when
> 	  CONFIG_NFSD is selected.
>=20
> 	  If unsure, say N.
>=20
> -config NFSD_V2_ACL
> -	bool
> +config NFSD_V2
> +	bool "NFS server support for NFS version 2"
> 	depends on NFSD
>=20
> +config NFSD_V2_ACL
> +	bool "NFS server support for the NFSv2 ACL protocol extension"
> +	depends on NFSD_V2
> +
> config NFSD_V3_ACL
> 	bool "NFS server support for the NFSv3 ACL protocol extension"
> 	depends on NFSD
> -	select NFSD_V2_ACL
> 	help
> 	  Solaris NFS servers support an auxiliary NFSv3 ACL protocol that
> 	  never became an official part of the NFS version 3 protocol.
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index 805c06d5f1b4..6fffc8f03f74 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -10,9 +10,10 @@ obj-$(CONFIG_NFSD)	+=3D nfsd.o
> # this one should be compiled first, as the tracing macros can easily blo=
w up
> nfsd-y			+=3D trace.o
>=20
> -nfsd-y 			+=3D nfssvc.o nfsctl.o nfsproc.o nfsfh.o vfs.o \
> -			   export.o auth.o lockd.o nfscache.o nfsxdr.o \
> +nfsd-y 			+=3D nfssvc.o nfsctl.o nfsfh.o vfs.o \
> +			   export.o auth.o lockd.o nfscache.o \
> 			   stats.o filecache.o nfs3proc.o nfs3xdr.o
> +nfsd-$(CONFIG_NFSD_V2) +=3D nfsproc.o nfsxdr.o
> nfsd-$(CONFIG_NFSD_V2_ACL) +=3D nfs2acl.o
> nfsd-$(CONFIG_NFSD_V3_ACL) +=3D nfs3acl.o
> nfsd-$(CONFIG_NFSD_V4)	+=3D nfs4proc.o nfs4xdr.o nfs4state.o nfs4idmap.o =
\
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 668c7527b17e..20ba051f89a2 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1183,6 +1183,67 @@ exp_pseudoroot(struct svc_rqst *rqstp, struct svc_=
fh *fhp)
> 	return rv;
> }
>=20
> +/*
> + * Map errnos to NFS errnos.
> + */
> +__be32
> +nfserrno (int errno)
> +{
> +	static struct {
> +		__be32	nfserr;
> +		int	syserr;
> +	} nfs_errtbl[] =3D {
> +		{ nfs_ok, 0 },
> +		{ nfserr_perm, -EPERM },
> +		{ nfserr_noent, -ENOENT },
> +		{ nfserr_io, -EIO },
> +		{ nfserr_nxio, -ENXIO },
> +		{ nfserr_fbig, -E2BIG },
> +		{ nfserr_stale, -EBADF },
> +		{ nfserr_acces, -EACCES },
> +		{ nfserr_exist, -EEXIST },
> +		{ nfserr_xdev, -EXDEV },
> +		{ nfserr_mlink, -EMLINK },
> +		{ nfserr_nodev, -ENODEV },
> +		{ nfserr_notdir, -ENOTDIR },
> +		{ nfserr_isdir, -EISDIR },
> +		{ nfserr_inval, -EINVAL },
> +		{ nfserr_fbig, -EFBIG },
> +		{ nfserr_nospc, -ENOSPC },
> +		{ nfserr_rofs, -EROFS },
> +		{ nfserr_mlink, -EMLINK },
> +		{ nfserr_nametoolong, -ENAMETOOLONG },
> +		{ nfserr_notempty, -ENOTEMPTY },
> +#ifdef EDQUOT
> +		{ nfserr_dquot, -EDQUOT },
> +#endif
> +		{ nfserr_stale, -ESTALE },
> +		{ nfserr_jukebox, -ETIMEDOUT },
> +		{ nfserr_jukebox, -ERESTARTSYS },
> +		{ nfserr_jukebox, -EAGAIN },
> +		{ nfserr_jukebox, -EWOULDBLOCK },
> +		{ nfserr_jukebox, -ENOMEM },
> +		{ nfserr_io, -ETXTBSY },
> +		{ nfserr_notsupp, -EOPNOTSUPP },
> +		{ nfserr_toosmall, -ETOOSMALL },
> +		{ nfserr_serverfault, -ESERVERFAULT },
> +		{ nfserr_serverfault, -ENFILE },
> +		{ nfserr_io, -EREMOTEIO },
> +		{ nfserr_stale, -EOPENSTALE },
> +		{ nfserr_io, -EUCLEAN },
> +		{ nfserr_perm, -ENOKEY },
> +		{ nfserr_no_grace, -ENOGRACE},
> +	};
> +	int	i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(nfs_errtbl); i++) {
> +		if (nfs_errtbl[i].syserr =3D=3D errno)
> +			return nfs_errtbl[i].nfserr;
> +	}
> +	WARN_ONCE(1, "nfsd: non-standard errno: %d\n", errno);
> +	return nfserr_io;
> +}
> +
> static struct flags {
> 	int flag;
> 	char *name[2];
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index dc74a947a440..02ed0babd98c 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -581,10 +581,13 @@ static ssize_t __write_versions(struct file *file, =
char *buf, size_t size)
>=20
> 			cmd =3D sign =3D=3D '-' ? NFSD_CLEAR : NFSD_SET;
> 			switch(num) {
> +#ifdef CONFIG_NFSD_V2
> 			case 2:
> +#endif
> 			case 3:
> 				nfsd_vers(nn, num, cmd);
> 				break;
> +#ifdef CONFIG_NFSD_V4
> 			case 4:
> 				if (*minorp =3D=3D '.') {
> 					if (nfsd_minorversion(nn, minor, cmd) < 0)
> @@ -600,6 +603,7 @@ static ssize_t __write_versions(struct file *file, ch=
ar *buf, size_t size)
> 						minor++;
> 				}
> 				break;
> +#endif
> 			default:
> 				return -EINVAL;
> 			}
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 09726c5b9a31..93b42ef9ed91 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -64,8 +64,7 @@ struct readdir_cd {
>=20
>=20
> extern struct svc_program	nfsd_program;
> -extern const struct svc_version	nfsd_version2, nfsd_version3,
> -				nfsd_version4;
> +extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_versi=
on4;
> extern struct mutex		nfsd_mutex;
> extern spinlock_t		nfsd_drc_lock;
> extern unsigned long		nfsd_drc_max_mem;
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 82b3ddeacc33..52fc222c34f2 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -848,65 +848,3 @@ const struct svc_version nfsd_version2 =3D {
> 	.vs_dispatch	=3D nfsd_dispatch,
> 	.vs_xdrsize	=3D NFS2_SVC_XDRSIZE,
> };
> -
> -/*
> - * Map errnos to NFS errnos.
> - */
> -__be32
> -nfserrno (int errno)
> -{
> -	static struct {
> -		__be32	nfserr;
> -		int	syserr;
> -	} nfs_errtbl[] =3D {
> -		{ nfs_ok, 0 },
> -		{ nfserr_perm, -EPERM },
> -		{ nfserr_noent, -ENOENT },
> -		{ nfserr_io, -EIO },
> -		{ nfserr_nxio, -ENXIO },
> -		{ nfserr_fbig, -E2BIG },
> -		{ nfserr_stale, -EBADF },
> -		{ nfserr_acces, -EACCES },
> -		{ nfserr_exist, -EEXIST },
> -		{ nfserr_xdev, -EXDEV },
> -		{ nfserr_mlink, -EMLINK },
> -		{ nfserr_nodev, -ENODEV },
> -		{ nfserr_notdir, -ENOTDIR },
> -		{ nfserr_isdir, -EISDIR },
> -		{ nfserr_inval, -EINVAL },
> -		{ nfserr_fbig, -EFBIG },
> -		{ nfserr_nospc, -ENOSPC },
> -		{ nfserr_rofs, -EROFS },
> -		{ nfserr_mlink, -EMLINK },
> -		{ nfserr_nametoolong, -ENAMETOOLONG },
> -		{ nfserr_notempty, -ENOTEMPTY },
> -#ifdef EDQUOT
> -		{ nfserr_dquot, -EDQUOT },
> -#endif
> -		{ nfserr_stale, -ESTALE },
> -		{ nfserr_jukebox, -ETIMEDOUT },
> -		{ nfserr_jukebox, -ERESTARTSYS },
> -		{ nfserr_jukebox, -EAGAIN },
> -		{ nfserr_jukebox, -EWOULDBLOCK },
> -		{ nfserr_jukebox, -ENOMEM },
> -		{ nfserr_io, -ETXTBSY },
> -		{ nfserr_notsupp, -EOPNOTSUPP },
> -		{ nfserr_toosmall, -ETOOSMALL },
> -		{ nfserr_serverfault, -ESERVERFAULT },
> -		{ nfserr_serverfault, -ENFILE },
> -		{ nfserr_io, -EREMOTEIO },
> -		{ nfserr_stale, -EOPENSTALE },
> -		{ nfserr_io, -EUCLEAN },
> -		{ nfserr_perm, -ENOKEY },
> -		{ nfserr_no_grace, -ENOGRACE},
> -	};
> -	int	i;
> -
> -	for (i =3D 0; i < ARRAY_SIZE(nfs_errtbl); i++) {
> -		if (nfs_errtbl[i].syserr =3D=3D errno)
> -			return nfs_errtbl[i].nfserr;
> -	}
> -	WARN_ONCE(1, "nfsd: non-standard errno: %d\n", errno);
> -	return nfserr_io;
> -}
> -
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index bfbd9f672f59..62e473b0ca52 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -91,8 +91,12 @@ unsigned long	nfsd_drc_mem_used;
> #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> static struct svc_stat	nfsd_acl_svcstats;
> static const struct svc_version *nfsd_acl_version[] =3D {
> +# if defined(CONFIG_NFSD_V2_ACL)
> 	[2] =3D &nfsd_acl_version2,
> +# endif
> +# if defined(CONFIG_NFSD_V3_ACL)
> 	[3] =3D &nfsd_acl_version3,
> +# endif
> };
>=20
> #define NFSD_ACL_MINVERS            2
> @@ -116,7 +120,9 @@ static struct svc_stat	nfsd_acl_svcstats =3D {
> #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
>=20
> static const struct svc_version *nfsd_version[] =3D {
> +#if defined(CONFIG_NFSD_V2)
> 	[2] =3D &nfsd_version2,
> +#endif
> 	[3] =3D &nfsd_version3,
> #if defined(CONFIG_NFSD_V4)
> 	[4] =3D &nfsd_version4,
> --=20
> 2.37.3
>=20

--
Chuck Lever



