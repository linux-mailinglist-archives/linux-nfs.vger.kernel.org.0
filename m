Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36116520312
	for <lists+linux-nfs@lfdr.de>; Mon,  9 May 2022 18:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbiEIRA7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 May 2022 13:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbiEIRAz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 May 2022 13:00:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294D81E05AE
        for <linux-nfs@vger.kernel.org>; Mon,  9 May 2022 09:57:00 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249FiCjm022886;
        Mon, 9 May 2022 16:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SX3D9UitIgGVuocm2sZiNbK+vKKxI9uszwBCOpw2lXA=;
 b=TZfQ4FlrHng5rkI88GqTlHrLyTXj+SS87rhtzHsz29IPlTNmM30D0eWYw2bIgA2IKqc4
 3q7UWpjQ8sH4x8o3Ily7O/2s0bTh2AgZERtz3BI1RnAVJDuiAWN0hPKX3MUFaKcvIxV1
 Hu0FmLob+3xUE5VM42XUMOFT5U7sowQAaUHH54yeK0f6PlZi4jqv8/adADM9bcv0WLDz
 46s48WzBvtKXPmVV0qigXn5zDWNieN09Z00A6VgpzlGed2L+VSgVRsA9TdNiUM8xp7U+
 /JBI3Z1hGx9xXbHXqP5cOG696lDHdKVRG8SjXrIlHCaYWSWMclF3zcYwrzMD8tIh2DTa sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatc6uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 16:56:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 249GoBLT010000;
        Mon, 9 May 2022 16:56:51 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf71u3er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 16:56:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMgJJtm1svz0nBlI2n+OPWp8yvTgmn+jEc+xak7cZhDkkF6TEyDAMFf0HpeOWdfwmGkcrdFStODRQ6rR3cqbq2E3FroDOXxr1kJ8tXkb/DWV9rnGxK+9l89wHyr8OlNqyHys1zhdwEKHv988SVlml50++9T/lH21qYInFMSLs7cRQEGAB1R6FdLe4Vmc3Y/92V1759zNVyA6l1WTAdqRhCvEorIqO/DDQch5XrXXFyfQqyKWoguT14mf80vjb5oISmVPxW3Pd72Nuz1A61yPsp3Plo3J7TK0Emy4ZpGnTndzkcesrKzZLKIVEjOfExaWRcnuJpT/FKUxzrnydRwdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SX3D9UitIgGVuocm2sZiNbK+vKKxI9uszwBCOpw2lXA=;
 b=Y5bhq9nThez0FZOSzFowzEYOxAsnPCINykCBLFWiZRUs/W4eVFStvU5XKtKYdfiU7u/iHTo2WRQ6is4VoWF7F/NfSAj7JjvPKBSTowFHOB+hfYzghSwFEnj1eYoDOrpqeG6Cm+c+FtPpAfUMcYegPDKhrzgQgMDv8kbIYd7E4xt52nWx+nw0Kw5oq/3I4/mJwVyPJY/Ff0IxQoAQeVvT1t1dtliaF+tIzBvSHXmp7/ddjUYR1JIxY9w1klb+pnheDwySzbPmp91cuxEChDkMGZRTCAIV+X3jJZQ2JVQVcaeS0iXnGWbitNB2Id58af+zcjkvqGY0F4WB/spbChlWbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX3D9UitIgGVuocm2sZiNbK+vKKxI9uszwBCOpw2lXA=;
 b=CprOPlljoU4dEhVWeeOBYJ3xBdLIAtmdlCk4y1kz9YBDm8AtdXHtFC4OyA2CfeSWWtJs7mx3VNjcqQWt/a5qSUJUsQHeZTcAKqd9QuOixIUxC9YQonL5J5paJCHAkd7uGJxvq3S1rNXjpgiyGwTd5hNEWZuiiVoQP26T3RATS9U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR1001MB2227.namprd10.prod.outlook.com (2603:10b6:405:2f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Mon, 9 May
 2022 16:56:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 16:56:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH] SUNRPC: Don't disable preemption while calling
 svc_pool_for_cpu().
Thread-Topic: [PATCH] SUNRPC: Don't disable preemption while calling
 svc_pool_for_cpu().
Thread-Index: AQHYX9vL0QvoWl04KkqOdhnLgfmokK0Wy9AA
Date:   Mon, 9 May 2022 16:56:47 +0000
Message-ID: <11F8D1AE-EB3D-48F0-A586-563165640AB8@oracle.com>
References: <YnK2ujabd2+oCrT/@linutronix.de>
In-Reply-To: <YnK2ujabd2+oCrT/@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39389ab8-abc8-49da-50f5-08da31dce793
x-ms-traffictypediagnostic: BN6PR1001MB2227:EE_
x-microsoft-antispam-prvs: <BN6PR1001MB2227B326B84905F66B192B6393C69@BN6PR1001MB2227.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fZUZQC99V73Gv6zV3XZ8zrFMt15PZSq7R/5ogMQh25cibHd3pyIzvIJmZz/zN2cRrJztF9R7Ke/oVIDKV/svxXMREfosy7qWoNN/8Ag4ec8jb6fDIbFz744unzWFpLmjU10XbLZrIyYi15fvk/JkJRuiCS0n0foFqSimMWcyvMTPNMw9MrlhiFMlDFhq/0lF4F3D29nrxO4PZpZAFnYWEsFHClOI477vT0gjQraeMgzSvlNhDEmJ6w1hwjRmKcTm58fllw4bKbI1B+uozAOqxI5LBJkqY1WxoD8pZctpYn4fVYrTza5hL9aPwhSkTMv7zV83HVuMTFA3++US30xnlFm+DUhHS3fnbsbH4hgQB3i+izp6BjVFkP7nZ0C88ATiUOsQkSGJsKhvTtS7pmNvgervDoPoyR/XkJ/vGpLDdiytPymgP1h3XxbJlu9XBykUJ399td0pcCLy/gqjr3UMsJrdPZCQLYVnl65R0+75diEGFFL2ae50plL2F3i958JqM/5Xz6RAGgJY4fUcJ2C7wS3NMfnU05+50YXcjHcvDqjI/cIZCK9tsTI3TL0DKX2fme31A1YGKZcs5Eb59M+UsHGI75+bg0VaX9a1Hm+6whJjqTgKLniot8BpBDz641gU0apec+A4td7czNHZ0jWpTvziKFkGVL7PTaMEaHZcP/N5Hiw+z0bPICrInEHLvjcEe688LX/ITh9h+2IzI3ygDJb8oeIn/bESXIdv853xPmNm9YyrgpvGOlttchZPFuzd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6916009)(316002)(8936002)(6506007)(33656002)(2906002)(83380400001)(6486002)(66556008)(508600001)(76116006)(5660300002)(36756003)(54906003)(64756008)(86362001)(8676002)(66946007)(4326008)(66446008)(66476007)(53546011)(38070700005)(38100700002)(71200400001)(6512007)(91956017)(122000001)(26005)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jnfg3jdDVfWC/zRTNHyPiTY65GLQfzANQ/Aee0cRQ/OJf2sYqxoLBKDCGmiz?=
 =?us-ascii?Q?A7ouegRWnW0Sa6ElSDZ38gkPQUxs0xOW5RK3cJTld4OROfSCiqdcKUGlp8XK?=
 =?us-ascii?Q?7ZTchNb2L3dOOsVqoLZcbGpjmsDFeqYhz5f7fiS7Hu0OMSQ9xPJ7b+IDUrFE?=
 =?us-ascii?Q?t50Y8h8kJOfdYGkZ6KMnapouGNybtmW/TzV0KZYrD/ajEUwYqzrD2Rlj7KZH?=
 =?us-ascii?Q?FrT6Ux24gPOhhYzdUCkH3BzoN7BGYYojC3RUQkJN+4fk8XEBdu4Yj24a5+m+?=
 =?us-ascii?Q?LaFzH1NtvcCMUb9GefSWWzqLULgwyN8zDuyg8DDp1GvVxgn+kCDam3sRiRd6?=
 =?us-ascii?Q?17wsQBZjLPenJA+FAUCiyADDbH1N0n05NHpz1dhFd0LdaFCR/d46WP6nGtWa?=
 =?us-ascii?Q?rllsiCpzxRMOQsc3Sh/UeGSw7B5kvWTIBfr/aNyw+rC+gUoe6HmdSQku4JcX?=
 =?us-ascii?Q?pvqCs+s7gbUS6B3BF7SlfRFxm8so8UQ1w1rPOr8fdrySt6GzRukz1VKOk4EA?=
 =?us-ascii?Q?xbRQblwi+H2wL3je8IAi4+58IU4MLo0vexnoXrCxKYnp2zaGRoXNtCqXzEnU?=
 =?us-ascii?Q?cOfvOPqmNiR1AkiWeiVJWjTCDzaydN81zkwVbTApI1vRaQHFbUq+cxTD2HTY?=
 =?us-ascii?Q?33meGhIgA3DXic5+gdYIYWRJMs/zZL7MSyp4w3p+UH90/jZBvwOre1pw/IxX?=
 =?us-ascii?Q?4+SOfnpRGfUL8u1FF8REZTzl4op6RjdZujH1mqMmqPCpERXq1J5Dca2vU2j2?=
 =?us-ascii?Q?Gigsj0Qphiieb9Bv3X0MlCM8a76Pzvw2G63c2Z+wRwSC7TAD3pxamoeQ38Pr?=
 =?us-ascii?Q?fmu0JdHjFxSXrlUzG8DoykoaP+ORqcvB0vd5DSZxTaH+Tbd63NRpVdVu+NvY?=
 =?us-ascii?Q?EQGWLARQpOPX0N87S5uYh/HPJ286gJMon54Plsfwd0gHtS4nYpRK2S5TzViO?=
 =?us-ascii?Q?xv68R73gprhPCBNNXVi/NNMXPUbUw2l5YlU3N+3NwuImcClcJg1GtL6IUiPA?=
 =?us-ascii?Q?0ni+dr3lasCm2pOl6Ej57KHymUAzKnjI2V8M0ThmtI26x8Vab/ubd3OFnkv8?=
 =?us-ascii?Q?KDeeXA+FndjFN1wYNXDCXV4scweu/BWQw7cmtsxjYuhwnICCW2yXqK2rFf87?=
 =?us-ascii?Q?ySkwko8WYPnmUMMpPB68V+hokVzJcChxD+0i8siFY6y1EEuDG6DINPNL2LN0?=
 =?us-ascii?Q?WkZnUMzOfkQcV6CUZEdUhd11NN0mrWlgYVEbv6Rix4joSt2ojsaUJxSJ87ip?=
 =?us-ascii?Q?NtH+xN+VVo6Tx4Fa1IeZ7q6RL/e5N9pUlZcNr2sJgAdM0UPJGMHGXznpJnw0?=
 =?us-ascii?Q?6XXwNKfcRCIIVFqWifQFbQ6M9AwYf6f01297mHd7rHE/6YUvv09J9XC1sI+w?=
 =?us-ascii?Q?BxUiegV1C8zWLHgFoMS1kradDOfuKh8/Rv8P4x0SMiL0dUqTmIJpmne7rPVu?=
 =?us-ascii?Q?8Uhw0eCMnBr7NDcFROWHDycSPImm/F7gIULyFQFtFxa78JLQTAMwxPiAfuXX?=
 =?us-ascii?Q?DDFXf7w6r8q8RsB9oiHkXOPVgQpliNI+tuiDHnjZQecaXIdfNiD2TgWgqnWj?=
 =?us-ascii?Q?tJ2xLgPVvaa+5AcpL1pxQNATNGDLkI4Z6UwNrXsfdSZBeXGVB+fUITIk7gqT?=
 =?us-ascii?Q?HljuL6nzQUUslZFeMTCi3V1q/iOjmnCblwMx25x2qcdA6EQmOl+wD9oKSyW2?=
 =?us-ascii?Q?USFVVr2l1C2k4HeAUt2DDFZGlTDSMnw0nuFQPi5Jt25xBf3PNJxEl4OlQLmn?=
 =?us-ascii?Q?dd2aVJuko8vND2Z+oC/aB/uVcEJSQbg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF05A19CB2A6434A989010C7C660A2E1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39389ab8-abc8-49da-50f5-08da31dce793
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 16:56:47.3479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVtWFc5lljKMI2C0WJ+KMhmxTxyujFSXSquS9vfLpXAo9IMq3lfLHhAVCgQl31lj0XmTuIZ/foDKyzQ0F+npFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2227
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-09_05:2022-05-09,2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090091
X-Proofpoint-GUID: 189ybFWLdfB7DgNG5GxTZo9sJ-KY81oi
X-Proofpoint-ORIG-GUID: 189ybFWLdfB7DgNG5GxTZo9sJ-KY81oi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Sebastian-


> On May 4, 2022, at 1:24 PM, Sebastian Andrzej Siewior <bigeasy@linutronix=
.de> wrote:
>=20
> svc_xprt_enqueue() disables preemption via get_cpu() and then asks for a
> pool of a specific CPU (current) via svc_pool_for_cpu().
> With disabled preemption it acquires svc_pool::sp_lock, a spinlock_t,
> which is a sleeping lock on PREEMPT_RT and can't be acquired with
> disabled preemption.

I found this paragraph a little unclear. If you repost, I'd suggest:

    svc_xprt_enqueue() disables preemption via get_cpu() and then asks
    for a pool of a specific CPU (current) via svc_pool_for_cpu().
    While preemption is disabled, svc_xprt_enqueue() acquires
    svc_pool::sp_lock with bottom-halfs disabled, which can sleep on
    PREEMPT_RT.


> Disabling preemption is not required here. The pool is protected with a
> lock so the following list access is safe even cross-CPU. The following
> iteration through svc_pool::sp_all_threads is under RCU-readlock and
> remaining operations within the loop are atomic and do not rely on
> disabled-preemption.
>=20
> Use raw_smp_processor_id() as the argument for the requested CPU in
> svc_pool_for_cpu().
>=20
> Reported-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> net/sunrpc/svc_xprt.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 5b59e2103526e..79965deec5b12 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -448,7 +448,6 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
> {
> 	struct svc_pool *pool;
> 	struct svc_rqst	*rqstp =3D NULL;
> -	int cpu;
>=20
> 	if (!svc_xprt_ready(xprt))
> 		return;
> @@ -461,8 +460,7 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
> 	if (test_and_set_bit(XPT_BUSY, &xprt->xpt_flags))
> 		return;
>=20
> -	cpu =3D get_cpu();
> -	pool =3D svc_pool_for_cpu(xprt->xpt_server, cpu);
> +	pool =3D svc_pool_for_cpu(xprt->xpt_server, raw_smp_processor_id());

The pre-2014 code here was this:

	cpu =3D get_cpu();
	pool =3D svc_pool_for_cpu(xprt->xpt_server, cpu);
	put_cpu();

Your explanation covers the rationale for leaving pre-emption
enabled in the body of svc_xprt_enqueue(), but it's not clear
to me that rationale also applies to svc_pool_for_cpu().

Protecting the svc_pool data structures with RCU might be
better, but would amount to a more extensive change. To address
the pre-emption issue quickly, you could simply revert this
call site back to its pre-2014 form and postpone deeper changes.

I have an NFS server in my lab on NUMA hardware and can run
some tests this week with this patch.


> 	atomic_long_inc(&pool->sp_stats.packets);
>=20
> @@ -485,7 +483,6 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
> 	rqstp =3D NULL;
> out_unlock:
> 	rcu_read_unlock();
> -	put_cpu();
> 	trace_svc_xprt_enqueue(xprt, rqstp);
> }
> EXPORT_SYMBOL_GPL(svc_xprt_enqueue);
> --=20
> 2.36.0
>=20

--
Chuck Lever



