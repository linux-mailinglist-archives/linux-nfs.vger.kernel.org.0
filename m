Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9AF5B7DAC
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Sep 2022 01:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiIMX5u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 19:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiIMX5s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 19:57:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0436D4D81D
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 16:57:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DN784V011168;
        Tue, 13 Sep 2022 23:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LNY297HAWND2O1eTkhNvZvtM3G54NIj8LTQm+HifpMo=;
 b=g079NhthgtpwBB8OvdMfn0Ca1hy44+4zKkzaqC3LULX8E5SXt7JvcAe3aEoH/u1PVTa/
 m3YGXFiNPBBlkcs+Gz4x5SpV7cRN9yhfnjfK4dpnaTjL7Q4zD8OKE12r9ADUNC4FgnoH
 a6hpL8RDotMm1V/iiRL55FJGdK4cboAn6+gu1Sv73EojxN3Bfrj3TfIoN7i8TGpjDL0b
 qJJtOLW+n4+DsaKQO9sLDDorKAp8UL1wdvpQPdG8tA1iPYiiIZq7pAv95KOdu3MPVd2M
 F4lfIZYjUTEmJTIS2UViEp5RgbccuIoj4aEJuoPXOxueGHmEOH2SVL+0pu5g0HOTvbPX tw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyp8nyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 23:57:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28DLpHwu023780;
        Tue, 13 Sep 2022 23:57:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyegpkxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 23:57:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmbYTKTmT4YQHeAaxKNMCZqynaYxWIKfqaLaQhiOVcLv3NEmkUQO+xj7EPVRF37iWwnPcPbWb0ouB+3vMyewBdlTMo86OeVP6uLooctzlHTRqbXuc2Rk5NCaC1V8G+GX+SmWyotNujX9F6+1/9nMN+AE0e//GrO1sFtWYFGqi7oeOdMOCwkpk19QO/TX9NjIJG/XW8IXqLiH/3GnSRfCyWbr4/6T1pgVJduRberNqtyXa1w/rgzSrow3/h4c1I33lWjN+OzAYXOqEVVdybNoI1TH69jjrDLlFJjfp8VadSvVDhq4KAHhBDi3TwkcgN+mid1io6sacCOaTrn4EJGkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNY297HAWND2O1eTkhNvZvtM3G54NIj8LTQm+HifpMo=;
 b=XrHnn/ep+jZntOs6c1zR5ojDfCtKP/1amBL9Xn6rYioSXLPmG7UPnHvQRjPepPVYFSUbPSweGO/a6NphtTOV/Yn/P+hi5V4FbfzuvKZaCMqe0y0SQCZ9qrNzRBOJe/uYjAyMDdw2QFDA8QuMZstWXJchLK//T6/OR/6FYSeMH+4gzgfOCsmiKCX6cCqlmrU0JI9tPVyqIAMgUGjlcCKOxGyN5wI8eQBwOSrec0Iy6kKDIKzKz8gpn8H1ck3u3SEQxot2eU8KpCxk4rWeDWuDpWkRDjtCRcurr4+hiMA3Y+4Q1hy5umAwOMALmipIFm//mhe1jroGh4k7cknWGde1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNY297HAWND2O1eTkhNvZvtM3G54NIj8LTQm+HifpMo=;
 b=cSqgYWDJbk9F6OtMcKW57sKjiVeCyFiAhRcXX+Yz/0KkhDqdRwoH/rsiCHfIHxMQ2kCNyictTvNdtVRLCVkcAvTsY8bDwRFswqIxeYUzX0ooKwIgjagv+lskCyCpzgOuGSB0tdP7wWCTEKXhIqSaDjC9QMMGzhtnFeFvrU2N1xw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4558.namprd10.prod.outlook.com (2603:10b6:a03:2d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 13 Sep
 2022 23:57:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 23:57:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] NFSD: keep track of the number of courtesy clients
 in the system
Thread-Topic: [PATCH v6 1/2] NFSD: keep track of the number of courtesy
 clients in the system
Thread-Index: AQHYx4rDD3NcBHvjY0+YO1U0/EN4+K3eCiEA
Date:   Tue, 13 Sep 2022 23:57:41 +0000
Message-ID: <343795C8-01A5-4FCA-848D-2952773DBF50@oracle.com>
References: <1663085170-23136-1-git-send-email-dai.ngo@oracle.com>
 <1663085170-23136-2-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1663085170-23136-2-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4558:EE_
x-ms-office365-filtering-correlation-id: 1541d3e7-5580-4804-6b04-08da95e3be91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nYWtH+V+5IABm5RFadnfddzRDB+7ynmKTUjzeQ79rRQUq+ul1ecf2jy50moWn17hp5lYbfMNOrKfRC5zUAuwvuGQVK6KUKSkP1mmFMOWchG+pSwYYsxgqJ7UfsyoNmorm4XD3BlqFQJdUrLz+Qty7s+sg9P/SFIZUtCxMx8vY7WjIFE8kn/SSLOY1RiLlLrVQSg62HzXCKs+n3NkqfnwdXS7bQvrLRQwCqm4/AQQVGNMG+J1aDdA556L10RQv/O+gIjlOq1EuwBQDez+pgaxuZVETtZ9arj+c0/874u/GR+mEHZRDmMfiS6NrPZ8kJAz4tiu4WwBY8rCgbj3uVuTQs/JpA6G8okZlJh1lbdygDcVj0y4hF/y1yCqRoS8PDEoAqfh9COMPuSOua85dLFvGP+lRK9KjcgstHt9Qku0249Ek9GjxBE/jlreTnVoBeAMQqowPwtPKCo4Ii/w6suXaK1NXj9o69I7mvKHBto0t6xNweRDH99v6Y1TB0F15Ojh8P/DDgMm+YeH0nJNrVDtDQ1tRiu9JY8fpgcMBJrFqykqoXl5Ki/LbeallC3V4OJMIPxAhTrYC29keT8V84kXaodu6xe4B5q240bqrYM1IoepIZmUH+heA5WFa7bUexlvyy5xnftMWuLi/QqAJ9IwdVZQhLpHlOPUnGm8k/nJo6PPmy2YyHeGUT+mzB07bJqs+ji79xJzSwvZfmvRVsL47Bdsfw7mePpCgTEZ4DLi+kvZuPNa324PmnZgFPIWB8UO1v2raKsjFXDkB5xlFBXg9KLWDRp7f+fosETRCwxPC7M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(71200400001)(54906003)(91956017)(37006003)(6486002)(2616005)(26005)(6512007)(186003)(478600001)(66446008)(41300700001)(53546011)(6506007)(8676002)(2906002)(66946007)(76116006)(8936002)(64756008)(6862004)(6636002)(4326008)(5660300002)(66476007)(316002)(66556008)(38100700002)(122000001)(83380400001)(38070700005)(33656002)(36756003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3lHOqIZRHW5msOI7n7NPcyjs3ZZI+5vzgI11pWJrp5JZ/mBDVlRFGIDUuxMQ?=
 =?us-ascii?Q?cn3SUankGyAmK0MLcWn6tS2WeSfJ39ecRWvdhRBFANO5t6r8v+/NHzFTZOJm?=
 =?us-ascii?Q?v6Hp6EFqZe2UL1ml5g3HvJkO2h1WQma6XPO7XETHIkjWYEbazUPVau9BfxON?=
 =?us-ascii?Q?sbIz5lx936h83FIMhNR1nx/QlWgJUatiK/rYZEPd61KFb74+RdaQs3Clx6s2?=
 =?us-ascii?Q?n/rwAo2PY9qu3aUZIsL5sPgBnUxAwxFRO3AViE9Zxl71Zjr8FkhQiUR3Ebgu?=
 =?us-ascii?Q?cFCFdiohhRV3CKCBCkJUwjWqCUusW7D9ZVoXg/tpUhMHub7lEZ8ARZEgR2R8?=
 =?us-ascii?Q?zb8g/lFJWx24ifVzhAr5URATnxqvmi96VMqd8OtjAhS3hqGC7Vbjw5u2SHT6?=
 =?us-ascii?Q?ChcPSizbj2iRqEJxqsxdfZ7k//v2+UKEyNf/e+920hqVIEd7yh20jELroqXJ?=
 =?us-ascii?Q?HxUZWUVkQvBQalPBb4AY+fcnbq6+Gp1vLBa+9o2V+sMPte+l6GRzK27MUhps?=
 =?us-ascii?Q?qtpa9Do+Ryh2J/ms2Lnsahbz69Zzi5G+T/WDnO46f841tdTA2PPR6JaIJ6CI?=
 =?us-ascii?Q?lcJz+dOaYnWCajTTBs61+TTfCDU9Ka9fAEvI28hsbr9JN3co+zFwmNQCy5rH?=
 =?us-ascii?Q?5JESnu0fzwDNwdOjZqmOGHY9A/AWqN2CfDiAhg4Y2SiJh75KZK0c09s0yXsz?=
 =?us-ascii?Q?J3CcnP9wSgrO/aUSuFlhOPkO1rw3f3o9Xrj1bv4oVi6KLPh6PhlpyzLrv3oS?=
 =?us-ascii?Q?tmum3GHvr/ZvMwa1WC9+359MxpqNqv1pdhwwjhSYVzzGb82TSrXOLY0OmLIZ?=
 =?us-ascii?Q?qtLVYnpNDGKQPSGoKA9UnYoZPrAvhfDnKOVg/97SxhB/6P77/immTk433yMf?=
 =?us-ascii?Q?MbSBzcDr/LARaxMlqYCg5IPofEoKrTsqybWiiFZXATuZfilSRjjR062lCUPm?=
 =?us-ascii?Q?h5wU3JHaEy55EDkOzVCgsp5KmjjaYtNN/Zv2xj1YU0xISGfLMAc+uDsG212g?=
 =?us-ascii?Q?pnMhAnQgTrJ476M+b/xQqeP0pQ8VZwEqz68RqGeI4AaWF1/MbycBP6lPxtIY?=
 =?us-ascii?Q?OB0NFnHzN0kCVNIRgyyns6gzfW7+hP3fnCxnipFn6WoUTNUziuP8jOl9ZxN8?=
 =?us-ascii?Q?vTP7164xZoyG45WsET5e1Ny3LCmZbj0jWilYN2rhmZD/pziiQteX0yn2xwnl?=
 =?us-ascii?Q?Nw+oV7ftoeU+9xPkPrYZXz+RkqDl1RKYooNs8EwbA6D/9iaVjgqR+FgFKZgG?=
 =?us-ascii?Q?kao3jdjNbt75Sg3ouRl5Lglw1Z+PNVwklSL/IfNKya4GL7/m3QKjg95kTI84?=
 =?us-ascii?Q?VpADc+Mx7NPICvM3KjvthJfihisPcPmqoe0wIpKBkM088lAhWvYhS3KNRV6o?=
 =?us-ascii?Q?1yzyK95D04DtUayezAMuLArVkFN4Cm5xvlU5xiXVevxJPb2a5ooSY4vqAcH+?=
 =?us-ascii?Q?cuSPLvXlwoWWS8MnDIM3z2E7QiTr8X9VUztUv1u/8X7yoAOuz5ZQWYMK/wf2?=
 =?us-ascii?Q?lwIK4O+VJ9/vY+k7D8S9fve3eS7+hR/a6yQLHdWo3Hc89i6DlQa0cTN6F9P5?=
 =?us-ascii?Q?odSpJ3w1RRzbbagoJwtUU2j0UYHjQ1w78krfsxXXmdRdb9duj3LnMXM+KgHC?=
 =?us-ascii?Q?lA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB1AFBF2E0D50142A1B47E3765E07F87@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1541d3e7-5580-4804-6b04-08da95e3be91
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 23:57:41.3193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1dhns2KCeaUc7ibv31MgOATJRjn6yOxLCNHHSae+ej4KpgYCbd3l+5YamKBVaIO+lf1sIJIgtrDWCOAhKceulA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_10,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209130111
X-Proofpoint-ORIG-GUID: wptsTtTF3l9igofmNaGXvuPvg_J94CGg
X-Proofpoint-GUID: wptsTtTF3l9igofmNaGXvuPvg_J94CGg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 13, 2022, at 9:06 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add counter nfs4_courtesy_client_count to nfsd_net to keep track
> of the number of courtesy clients in the system.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/netns.h     |  2 ++
> fs/nfsd/nfs4state.c | 17 ++++++++++++++++-
> 2 files changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index ffe17743cc74..55c7006d6109 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -192,6 +192,8 @@ struct nfsd_net {
>=20
> 	atomic_t		nfs4_client_count;
> 	int			nfs4_max_clients;
> +
> +	atomic_t		nfsd_courtesy_clients;
> };
>=20
> /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c5d199d7e6b4..3af4fc5241b2 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -160,6 +160,13 @@ static bool is_client_expired(struct nfs4_client *cl=
p)
> 	return clp->cl_time =3D=3D 0;
> }
>=20
> +static inline void nfsd4_decr_courtesy_client_count(struct nfsd_net *nn,
> +					struct nfs4_client *clp)

Nit: The usual naming scheme is "dec" for helpers like this
rather than "decr".

Also "inline" is not necessary here since this helper is used
only in the same source file where it is defined. The compiler
will figure out when to inline it.


> +{
> +	if (clp->cl_state !=3D NFSD4_ACTIVE)
> +		atomic_add_unless(&nn->nfsd_courtesy_clients, -1, 0);
> +}
> +
> static __be32 get_client_locked(struct nfs4_client *clp)
> {
> 	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> @@ -169,6 +176,7 @@ static __be32 get_client_locked(struct nfs4_client *c=
lp)
> 	if (is_client_expired(clp))
> 		return nfserr_expired;
> 	atomic_inc(&clp->cl_rpc_users);
> +	nfsd4_decr_courtesy_client_count(nn, clp);
> 	clp->cl_state =3D NFSD4_ACTIVE;
> 	return nfs_ok;
> }
> @@ -190,6 +198,7 @@ renew_client_locked(struct nfs4_client *clp)
>=20
> 	list_move_tail(&clp->cl_lru, &nn->client_lru);
> 	clp->cl_time =3D ktime_get_boottime_seconds();
> +	nfsd4_decr_courtesy_client_count(nn, clp);
> 	clp->cl_state =3D NFSD4_ACTIVE;
> }
>=20
> @@ -2233,6 +2242,7 @@ __destroy_client(struct nfs4_client *clp)
> 	if (clp->cl_cb_conn.cb_xprt)
> 		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
> 	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
> +	nfsd4_decr_courtesy_client_count(nn, clp);
> 	free_client(clp);
> 	wake_up_all(&expiry_wq);
> }
> @@ -4356,6 +4366,8 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
> 	max_clients =3D (u64)si.totalram * si.mem_unit / (1024 * 1024 * 1024);
> 	max_clients *=3D NFS4_CLIENTS_PER_GB;
> 	nn->nfs4_max_clients =3D max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
> +
> +	atomic_set(&nn->nfsd_courtesy_clients, 0);
> }
>=20
> static void init_nfs4_replay(struct nfs4_replay *rp)
> @@ -5878,8 +5890,11 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, stru=
ct list_head *reaplist,
> 			goto exp_client;
> 		if (!state_expired(lt, clp->cl_time))
> 			break;
> -		if (!atomic_read(&clp->cl_rpc_users))
> +		if (!atomic_read(&clp->cl_rpc_users)) {
> +			if (clp->cl_state =3D=3D NFSD4_ACTIVE)
> +				atomic_inc(&nn->nfsd_courtesy_clients);
> 			clp->cl_state =3D NFSD4_COURTESY;
> +		}
> 		if (!client_has_state(clp))
> 			goto exp_client;
> 		if (!nfs4_anylock_blockers(clp))
> --=20
> 2.9.5
>=20

--
Chuck Lever



