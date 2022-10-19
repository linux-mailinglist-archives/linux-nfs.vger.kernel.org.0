Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6899604BF2
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 17:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiJSPo7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 11:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiJSPoa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 11:44:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179FB814DB
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 08:39:46 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JFNfwo022927;
        Wed, 19 Oct 2022 15:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gqe0tsUwrvdGPt34OeDRkRp6tWR5HwA6FnVECwB/Wuo=;
 b=NHMjz38SO+hDQoRgsrLwdg5ly2D0xfnMayofiYOtqsbxPeKhdjFjUK5s15Cp7vJwIqGj
 QoEpUtP1pE2BSXioZegqOMmDzqvK/ulA3Q6pSAdlnPVo7WhzjFXbil3EA7Y98S967Uob
 ieoUJ2/aqt/5AqXa7Df7qgapTMwd6W0dphjGYSFUqyqkaIHXYc/ntIi784GF7eWOI547
 zMPVXcw6pmzFBgaUKNeAdCQCztNvqypbh38atBgJBjTKEAIfiYk0Ph7y0MaV+Y3Pj56h
 tKrXDA9OyIbXLgXznPTXTgVjLqmIQZmixLL7nX/syvhRZ6EKN0dO1BVw7lwALdiyLPkl Lw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3jag9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 15:38:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JE1uqo026060;
        Wed, 19 Oct 2022 15:38:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8j0s15nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 15:38:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3aiNEbds/BS110V99tQt2PWc4xuoXzjcDQLdtjpAnqOngl3eHY3uCKB3oAO9H6F4WoCrwVV7ilVgDAphjxyjYC+6wddW7S94AtrfZphDlJUbjr/DWONjpDsUR/kI/XAmfhD4VqQUCkfYxZV4rLifHI3Hag71najuG84Pxuwc+rb3b4VTc/T3pdmRg6IgKBnmkthsyncu+cv0U4xh1A6G6tQDOrzRX9tAoGW892uvjzWL2upXiGw05zfotTCNwa24OrUCGRvgcKTOexn4OPVZmjbpl+6lBKJ4kU1pc+P1ghI6cLI9jOIGNxCFQI2YPBRYJEcCjow8dg0t9wAyjrfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqe0tsUwrvdGPt34OeDRkRp6tWR5HwA6FnVECwB/Wuo=;
 b=GpUhX/nf98zFgu2bQDVCm6X+7tq5Hw0hMWGjsAnnedCN4rc+QdY6c1+oJA3vuTQrbG3XNW5yRZF4alLr+68lgtDupLqnAp01At6kSwro/sQh29rOryEPY9aUYQhoMdCtOSJ4lYsyR6LPuJsaZCj3xJ/qy8PW9GFTCaLPel3khVNlSysZIb+VN9w/mypu2aYnrd9ecAfFB+GyEDXCny2WxKZLGUrdPUJ2ObMnJQDhkDnpIWX6rWamx0UDidWE7VzwfA9pmcgVecGy6qsMdofvrp+QyeARA3KKiUBm7FjZ/FEfhsiFoN8Nx+HLujMGGFfIDTjlrQDo021fcZieLpDa9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqe0tsUwrvdGPt34OeDRkRp6tWR5HwA6FnVECwB/Wuo=;
 b=OOdghkqQGxvAzX0jx9vM1pZGLYDMFm1ycupQIPmwIAXka7oJFvOG9nrAB2+LRAoMo6+ni9krC3mf27KgPXN90B7tAuGzbIBlcmrEIwLeIRIl95x7CGGmoTyi/ay6CYto5MePIur7ST+Z/qzWv+YF9cQyEaMyajh5nOqxGXn9aZE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6905.namprd10.prod.outlook.com (2603:10b6:930:84::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 19 Oct
 2022 15:38:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%4]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 15:38:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix crasher in gss_unwrap_resp_integ()
Thread-Topic: [PATCH] SUNRPC: Fix crasher in gss_unwrap_resp_integ()
Thread-Index: AQHY20gyNwrQP/Q5iU6k0KDZxQuYAa4V6zYA
Date:   Wed, 19 Oct 2022 15:38:52 +0000
Message-ID: <7AADFC73-5748-4D80-BED3-CF8D6A92D510@oracle.com>
References: <166525550985.1954655.13884581337321315995.stgit@morisot.1015granger.net>
In-Reply-To: <166525550985.1954655.13884581337321315995.stgit@morisot.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6905:EE_
x-ms-office365-filtering-correlation-id: b08d8c7d-c361-4c2b-b18a-08dab1e80691
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ukLm6OzTGITaquQ/bm89gmME4b6z7TS7R+weS46UligkxWZ3xmLcAycDglb8/84MgoYPaeg53WODicCdfI6u9NXduWQs2xE3QCEjlSeU6nNrqgpKOz/KjzQ4KLMdFqfG2I8PzQmM2luMHJjl5L633wVcS7Lt6UtPytbCXdbJeyCXRVk93Xd1hgHmzfL6bE8W+u4zkpueiK0zV+2kNjdOjIskOOFlYrkVUWocTlwXAECM6s4JwFJHeUZ2+mXIops/dkpslhgggKIS36aU2Rn0mgJm0JIoYLAVCTwwaAWsUVWbyA8bE3gbWOn/ikbwgqpZfuI1uU+yS55du1oJ5J5VR67tYZXRdWPDlFCNnwC3txOAydytltHsFgkVoX0pNA5dqJzaul18ot19EHAhJBTNTJfeWAyX/6y/Cp5WvBQvTJdMVK+4Q6mWm3Vl0uQFBeo6OSeT34YWThcwnOT8OlsSWmZQKCCb83g2vW+Jir78n2d+hd492eFVGlV1859L0Ja3UOxNnh9MGR7107Peu45PbnnW3BZ5SIZbREvVOa5qLaWdVUK+hsDQrmJdLGHL4ZlZz0LPAlhOwvrIl1w8+CXmgfUSL/VoVeW2UYUct2gYBTOBH7uopUx09coR8TakeekQXOd4CBi7deJ5x4SYzHzilp2WV3tAhPiBDEtNS0/a0GwoCcY6bEZnwf+a8oH2A0YMm4hiSdoXWv0M4jX9t17EEeBKR6FJVvn/R2IEUUn0ZqzTzjcHUE28QeFMffcWuJWGxr94gbDdQSrB+imAmvoNhu+yfZ9l5vgziuAsjoh3dhc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199015)(316002)(110136005)(2616005)(53546011)(2906002)(186003)(6506007)(36756003)(41300700001)(26005)(5660300002)(83380400001)(33656002)(4744005)(8936002)(4326008)(64756008)(66446008)(76116006)(66476007)(6512007)(91956017)(66556008)(66946007)(8676002)(122000001)(38100700002)(86362001)(71200400001)(38070700005)(478600001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kBP6dFQITaXL6lYH5FnTYm9C2H7M2eH7n92kIUo10Y/SVy7QZVdMmtBCMa1I?=
 =?us-ascii?Q?F0q0t5xwC72zJMiDqsRzny3QMifr1FfOhKFMTNQycgTb4hRnRzPjD2nobFK9?=
 =?us-ascii?Q?Q7sqOqy2ix8C5ojQiguRVZnjxyUuMyNM426/cMZcGNMVDbHX/ZhquZAswuNN?=
 =?us-ascii?Q?rb/fm1dN90XL801OH4HsX37qjZdPy/aXiS8vFnGHgAjTd4Y3Mw/8x5+qi1LJ?=
 =?us-ascii?Q?0aKZsDGkt/9OCtk/K4RfLz+NRtiEMNHBPvoDqnsZFpgku3MaT/rQPTqkrogF?=
 =?us-ascii?Q?1lc4csjLEQIwZt9/Z23T8Sie8mF6piBJlgngw+GJpR5Xp4eoJZo5vymq9bwJ?=
 =?us-ascii?Q?8KDDVt3au7HrPVy+N/0EGCX38OD92jOAo0gpxf3P4lBBMI1Ef9vhzT72aI4M?=
 =?us-ascii?Q?sttCXZJ8wRbHcx46ffJCYWspmc7POqs6TE2OwycoFGfkpXe3j8lU1FgPp1hF?=
 =?us-ascii?Q?Xy8PsC1D20gIrPzwks04jnhfizNAkLj7th7SuvPi4qLBhOF+i3Ts1opTtkb+?=
 =?us-ascii?Q?6AiBy9YljSZwCjsHYoenJ41bRvKQznyFLtLI6Vo6JTATd9KYs95UuDIiqi++?=
 =?us-ascii?Q?rF5jaQxYDFC7zZJWGz7UZA6PYBq08T40V/QcXb1E7bX0TWcAJebydE15d58B?=
 =?us-ascii?Q?juAAEyM/cX837htuEv5cFy4t1Le2sq6qYAhEC062UTim4ha9zhHTKS2baFQc?=
 =?us-ascii?Q?hPan1jg8FZwco2qliOL8XNl2XNhvQcg7+DKDE+O8wR1ta7y1bfGyOkH6vS8Y?=
 =?us-ascii?Q?vQey9Wa+N+Z5ieVNGxelBePWJpoZMeoV3cLOw1WwHvnJNdNdEDZN+vP/0w5L?=
 =?us-ascii?Q?v/tTICojDwBI9olgIuD2EjUW59aFcZxi/Zc+qgoeIw+97bdjGLFtVc0S9DOF?=
 =?us-ascii?Q?HU5dHPU8aEUjRvD3dYf44HeQ39eD8/vE73brpUDB79YX0V4MXOdhs2VXZGiy?=
 =?us-ascii?Q?VK+Q2zz9eJ5ZeGsPWj3X9V3vyzD0xmMBxzYVnTE7rcxr3N2PcBVpg7ZOcjMN?=
 =?us-ascii?Q?ATOE0ir9SG2kwZF9HpdHGSySpElzz7dDohSwMRApBlO/VGipbI+olzRJMl1m?=
 =?us-ascii?Q?c29seFV/J5+Q3PI0Bc0NXnUzOiQJLKMRv23I4sF8+LHZICa5+1Mj9ZTXTVxW?=
 =?us-ascii?Q?B8WxS4vENGHeMqAeYb0w+K8CM2D/1u5NB5Prbm0duwJgb4Ymq88URMfDMewz?=
 =?us-ascii?Q?jprm43oTiqIidilf2tPdaZEIN0rtywLfqEeKPsuDHiBzDciLhmdSCkc8z104?=
 =?us-ascii?Q?mFub3R0f7x6feTJpCzMWB2LdcJ1hqFkX//JuofjDgph23YlgdGUbINJw51OE?=
 =?us-ascii?Q?JJfMfBKHR0BEthkImE3GbTgR6lEzueVGWJIq1I8RAxraQ8SsQayb7lMvzQfD?=
 =?us-ascii?Q?0aO26m3k9dBEV+89+L8Oj6Vp/PIhqs0M4EWf7pbOnl4q7y+geZuNCFFRzxr6?=
 =?us-ascii?Q?LHi1pKF4v/2eO3ExuUjtSdH32zzcDOetxiNmKzwEE12qlOVaMzkgSnuQ1xQy?=
 =?us-ascii?Q?i1jn0WNLMwdlxF8wCOlcRfE5xsG0ZEM1YGHuAxOMNuT1Cl35v0Qx12XWSePV?=
 =?us-ascii?Q?zA/so/xDyV1XOwa1wZAm6SbHzPAoo2lTFP1uhvL5fIqfIHG3iQgr/ecFhg0E?=
 =?us-ascii?Q?Zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <687E5449867A5D4395A194A2D4D30D84@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08d8c7d-c361-4c2b-b18a-08dab1e80691
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 15:38:52.6774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYjojmB6utpGR3gEqXWlNjo+m2Q6+nnHYdVoXxsFkg3IozRZ1Es854l8CVFGEDUE4PmW5hb2XEIxczJTimm55w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_09,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210190088
X-Proofpoint-ORIG-GUID: gtmuC25iwLQO2XZ07gFWT7XBtgOldhvq
X-Proofpoint-GUID: gtmuC25iwLQO2XZ07gFWT7XBtgOldhvq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 8, 2022, at 2:58 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> If a zero length is passed to kmalloc() it returns 0x10, which is
> not a valid address. gss_unwrap_resp_integ() subsequently crashes
> when it attempts to dereference that pointer.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Hi, is there a plan to merge this patch, or does the fix need
a different approach?


> ---
> net/sunrpc/auth_gss/auth_gss.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gs=
s.c
> index a31a27816cc0..7bb247c51e2f 100644
> --- a/net/sunrpc/auth_gss/auth_gss.c
> +++ b/net/sunrpc/auth_gss/auth_gss.c
> @@ -1989,7 +1989,7 @@ gss_unwrap_resp_integ(struct rpc_task *task, struct=
 rpc_cred *cred,
> 		goto unwrap_failed;
> 	mic.len =3D len;
> 	mic.data =3D kmalloc(len, GFP_KERNEL);
> -	if (!mic.data)
> +	if (ZERO_OR_NULL_PTR(mic.data))
> 		goto unwrap_failed;
> 	if (read_bytes_from_xdr_buf(rcv_buf, offset, mic.data, mic.len))
> 		goto unwrap_failed;
>=20
>=20

--
Chuck Lever



