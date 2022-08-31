Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865805A8035
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Aug 2022 16:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiHaOay (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Aug 2022 10:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiHaOax (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Aug 2022 10:30:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E29E1D336
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 07:30:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VEGEi3016563;
        Wed, 31 Aug 2022 14:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tfUQCvZX5XpSU4KiH6GBEF4T170bj8EYEy5S6+TOG1Q=;
 b=sUSV4tHTu0lCPw55nXFtcIVe7eDJon4KwFPdbVqOMGIoAlzUhSuMJX24WzJY5RbjO83+
 7rvtp2vHXJ1c1rTkxc6TH8+p9zoQb8FNWdbMcQkVIZ+lnExbFbn22noFJGrKx2r1TtK/
 KL33pNcMN82IVrpiBAhiebaINhSFtpLEGjRG0ReNHGGs3SsYecnxR/L2p6Yikui/NcM8
 d9wdxNnbSVVhl1IuHQUEaq63HNp3Smm8HaYoid3sfDH+onKIxAictQIzywRxU/G3P6Kh
 e1a9hv+YeKHY21rLyT9XWx7ydTl/CwVFuc1axXbexCk5twocpx0IqWEyyJOhLH264hEY YA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0sde0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 14:30:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27VEN6bZ022205;
        Wed, 31 Aug 2022 14:30:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q54ath-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 14:30:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQaR3e5L/Y3jWrHtfinW9Re2Tu69eJhDKQXuudDnWr2YevxwAD/gQrdXOv4iRvFOm/bwZw9h22KT6f3R60+/INLXWC684fxT8lipdRwg4gphpt7OZoqmPjNcOoPNpch1Mf5hqQ7q8dYpi+hmGxaZJasTDMwTvuZUINgN/4VdmL6XCybATA1M0zBxXKeAytrRGKZHSBATBBwPuy+AmFFdPre1OJq8SmfdRU1H2rJ4KZhG3KW0NqsEdz/WhS4dNhnf9U/UMtTkhaEo+elcq1llbM31c2DHi5T865CVxijLnoyS1FXKrwW1ZkA0pn/S7e+ohdmg4h/lQ6Qrhokas1/VXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfUQCvZX5XpSU4KiH6GBEF4T170bj8EYEy5S6+TOG1Q=;
 b=AlII37vQiA4BHIGTCOhiwMGExNM2rdEpElBr55ZYXjH5Nqc4RNzJ03d71ES2Gkud2nLIaGVO5/CR7ZD1T2laqbQ5QgN8qUGQnhT3OoYdvjC1Z2MNbDyPF02B6RG4Q7MRfzkoPiFpCbGtS3ouzXv1PmpOjJUShIw2bUuh6MQfk9+FGP5+X9l2CLsJmsBxXU0klHhqTpcqZ5Qe+UAwx0/JuKXzEOwhmvwWu5jUcNxpPE3BYdShUmk7QtYU9e748ThCgNkCwW5AS58l0nEux9ox2DCzwDTrMP7Uzz6kEUOfm1DzPYQePd0tnT/sIlzYqUMUY6EQ2YnJuBo4MOn5CkfN8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfUQCvZX5XpSU4KiH6GBEF4T170bj8EYEy5S6+TOG1Q=;
 b=NA3g8khMg717aim7BjwJokuhB68giP8S3G++l9nfZv8Z8yRJuoyGEVKrusNPiwcyXOwqwLImdDL+ugOzE4V5tS8/yhHsX7O6+6HtYJZgl99h4qyInR9Dpw57FGbR3+T+c3aRgi8Id3J4kobVDb+UgKBPWfqEuTMfJ7HwKIcVooE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6057.namprd10.prod.outlook.com (2603:10b6:510:1ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 14:30:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:30:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] NFSD: keep track of the number of courtesy clients
 in the system
Thread-Topic: [PATCH v4 1/2] NFSD: keep track of the number of courtesy
 clients in the system
Thread-Index: AQHYvLpFeOv+qreg3kCdpvS64YWpwK3JEwUA
Date:   Wed, 31 Aug 2022 14:30:39 +0000
Message-ID: <B4F7A73D-3306-4D9F-9DF2-A964F95EEAFD@oracle.com>
References: <1661896113-8013-1-git-send-email-dai.ngo@oracle.com>
 <1661896113-8013-2-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1661896113-8013-2-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 647019d6-1a38-4d3a-cbe6-08da8b5d606c
x-ms-traffictypediagnostic: PH7PR10MB6057:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: paVpr80m5Uu9ORl8UNfJqCSslAxJxYXmNB2MbUiUllQRy/uR8W8KmGgaFptJz/mF7z/ixiW/LwkpeqY16dSZRliTVkO7azQ3CixrCqBDdiGl9QWL/l7khl/rJEF7Z/WTd2gMRWpzDvRaMUvMNCF2g0FxQsZDshkr4Sw27gqVIxO91eJpeJDDH8q67qO3oKmG5THnB28Lyk2fNwwoSRbJg/vPAxpyxIWXG0uH6XhntshmbKaoItTl10zjcNuRQfCXxBJ/zvbt25PeZO3yipCgRjKR3CLEKnhfgdT235EW9CkWRct+MedaR5kegLr27p47OPuzI5hOPamKa1R19LpYt5D6U1dJIERP38bFi07oxttRXxskBiEq9NXnnXEZos/IRz4J3uBB6rIFfWWCmX00gXJBn6rAise1hD4gFU7VdZxrg1dnKp6xkRRt42PQyosnkKTtpIqKEkfDWFbnfsBQ95/NHVqpe/ALjy6AR4P+w3WdggChrFYbWOD3SM/frP3EUpnup9l5W2n5bWz2XO2KG35yOMm8HKQJWFmrGMl+tPgFGVl5ah64M5u+MKuw0T+yUtQkNyoBAQ96SsfwyYSYnMoPQq/YCHpVNWbDRTgvhemjs+DkuQRqa5vGzU13ahbocgjUdOPyPbJbrTAkGjKXdp/+AHib9Z/cQkpPXQROSfqR9c0BAiCCQIdyWXYtmNYI0gPz75ge+lmx3ma2KYtfkdrPyRlFY+60p7WZDJHzCdceCrrf90YBTYyCU2kAEPFhhMegodYtZCT/kvDQ6f5bZ/uXmqpUCS/UQklLbGhVhwI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(346002)(396003)(39860400002)(136003)(83380400001)(38070700005)(38100700002)(122000001)(91956017)(66476007)(4326008)(76116006)(66556008)(66946007)(66446008)(64756008)(8676002)(54906003)(37006003)(6636002)(316002)(2906002)(8936002)(6862004)(5660300002)(6506007)(6512007)(53546011)(26005)(186003)(2616005)(71200400001)(41300700001)(478600001)(6486002)(86362001)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2jkfHwY83xK89WHdtL98WxqxKb4q1FoMfZJqqoPaIkP2xnQkb/ByG+N7vjLB?=
 =?us-ascii?Q?hOizLzuq/G0FOVOTGIAmYV7gDzlCcItFumps8bZRpFRGCiEM4F1hCVUlpM0l?=
 =?us-ascii?Q?xjJHOdnRFU6qsVYCXV+OUIuh79W6GF0LnmaS+62BqpDuipt3E4mDxDgwLiXU?=
 =?us-ascii?Q?/Q8bIxCfl4XG0DAJdM8H5OXrbbM4wN7QSM1zFCTTKyr1SuVKx3e8HLdykAhL?=
 =?us-ascii?Q?rJ50xe8dow+ZzSP+Sa6utSDfvLId0IOz3MEw9FdyCQ/N1YwizyDebjOLJzB6?=
 =?us-ascii?Q?BkVz3sPSZWB6CDyiNiE7RSHwTowyudlvxYpon/zEPz//RKSqyb2Gb+QPasEh?=
 =?us-ascii?Q?xS0/RdRNFswKjPnrq9abFrxi3ila2//tLu1EPgfApQ+kDoejNi0LFIBwUGsR?=
 =?us-ascii?Q?L+S+Mjny5O3Jd1iHlADtE2EaFKRkbusxJzlAClr4CNDxHtwWnKLjyapC4Di1?=
 =?us-ascii?Q?8n+KWtuCMIgWYLWccAc4B1L5z8SY+7vvp5GXCzYv9KMz3J3aK0eRLjHR9p1l?=
 =?us-ascii?Q?Im+4b/nF6ggdYXeMwWOyfgXzmmr05H+c+cxJ3orq1qpFteCz0+GgMr7RSIbh?=
 =?us-ascii?Q?FCFTAiSmfQHjj44Xd9UuV8KENZjHoRz0FpjKMvLZ3xTnryqB1d6ziJt78J1W?=
 =?us-ascii?Q?wfSNcZtYuFPCFJSgqlswo7aDpUek7IZuo6y6PG6xv8mz+qPvgGBtZxaHNMd7?=
 =?us-ascii?Q?FC+DiGjyxwMSiX76hGpun1y/J+3k4sQc4PAPWDJybugeCCDIUBGoZcQdIL0j?=
 =?us-ascii?Q?eN6rV/OGjTMjoRX2ugn0LI9gWE24f1gMTMboIBuIt+DMuHLzdOTDnhldBgpa?=
 =?us-ascii?Q?xBx2Khy4Lo0GMzVunn5E7EvOvVy/cAjuiBBrBpH2hnOowZ1PutUqVVyOh76F?=
 =?us-ascii?Q?9tjB/VSQ6lrKkRtv2IA+2I6T3L/6x+rs9WOuHM5BYgPT2g/DEo7vo5/oZe85?=
 =?us-ascii?Q?OU2o/legCMbHwEyPS5jLGLd9sia0z3WTV0wa1XXFErGfARL/4nIxAIA29/f7?=
 =?us-ascii?Q?xbjA3ZHRQVQ0c+CXXHY4niPf9qNtbx7we02/8eTGT9bLZ1v2+mxWD+R60cR6?=
 =?us-ascii?Q?IGnmRyNgB05ce1nUhBbWjNSvhSlTS9iVk8sbSY2nQmajWjb16CSZejFLGrkq?=
 =?us-ascii?Q?5gDCvPDpqZ0rYCbjgGzV9XqzVCKav1eVmqdlJlpdqG0Jre41pUaELLladbOe?=
 =?us-ascii?Q?nmr1qAiOXNgiJvaW5YtFEumTHeM7Ah/7KVHRv1kszarH+qe7/JrHQyqV/8En?=
 =?us-ascii?Q?ypmrViZTxmCUc31Tb65tgyaknkWXTyBTqwAFrgemvDx++7X6q2ytRaE8TrJt?=
 =?us-ascii?Q?DrRHLxcqJe5hJMjU+HDParCFzjTjyh0aGTI+ChklcyNjqdCsCgwBBYEHQTTI?=
 =?us-ascii?Q?2H6/XDAplMhysffkdQJBz4AoIr+7YFYqU3jtvOY4dU+ndfFoFFSZPjSYYh2C?=
 =?us-ascii?Q?jjF8P316Mb+vkdBGa5WTG9ZNFC+TVT+gFvcMZ2g7XGGcEGbdFpDnueLQBwvn?=
 =?us-ascii?Q?qk27R4A4yOcUdY1VW2cr8wA4anTGwq73BmNIdD9mPYyd37/lVVIqDRrmgsAx?=
 =?us-ascii?Q?mPsEXXcrfPsypID0QLk/gjN+dJqKHR+6VHITPYGQMp7PMY5+/uSN2GMPlZua?=
 =?us-ascii?Q?JQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6DA2C44855CE424F83B027610CA3968B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647019d6-1a38-4d3a-cbe6-08da8b5d606c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 14:30:39.1996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 043zgR5/17b92eNZkhFJK7bQuTUOBOSpQ+UzdGYBP3txbPkk3SBkvVKlAPpFPRsONN2uzF13uB2/eGFD8J3/8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_09,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310073
X-Proofpoint-GUID: pahtDp_yocig_LRc73rDgdCHVhQNX-Jt
X-Proofpoint-ORIG-GUID: pahtDp_yocig_LRc73rDgdCHVhQNX-Jt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 30, 2022, at 5:48 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add counter nfs4_courtesy_client_count to nfsd_net to keep track
> of the number of courtesy clients in the system.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/netns.h     |  2 ++
> fs/nfsd/nfs4state.c | 13 ++++++++++++-
> 2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index ffe17743cc74..2695dff1378a 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -192,6 +192,8 @@ struct nfsd_net {
>=20
> 	atomic_t		nfs4_client_count;
> 	int			nfs4_max_clients;
> +
> +	atomic_t		nfsd_courtesy_client_count;

See comment for 2/2: rename this variable?


> };
>=20
> /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c5d199d7e6b4..eaf7b4dcea33 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -169,6 +169,8 @@ static __be32 get_client_locked(struct nfs4_client *c=
lp)
> 	if (is_client_expired(clp))
> 		return nfserr_expired;
> 	atomic_inc(&clp->cl_rpc_users);
> +	if (clp->cl_state !=3D NFSD4_ACTIVE)
> +		atomic_add_unless(&nn->nfsd_courtesy_client_count, -1, 0);

This appears to be a common bit of logic. Create a helper for it?


> 	clp->cl_state =3D NFSD4_ACTIVE;
> 	return nfs_ok;
> }
> @@ -190,6 +192,8 @@ renew_client_locked(struct nfs4_client *clp)
>=20
> 	list_move_tail(&clp->cl_lru, &nn->client_lru);
> 	clp->cl_time =3D ktime_get_boottime_seconds();
> +	if (clp->cl_state !=3D NFSD4_ACTIVE)
> +		atomic_add_unless(&nn->nfsd_courtesy_client_count, -1, 0);
> 	clp->cl_state =3D NFSD4_ACTIVE;
> }
>=20
> @@ -2233,6 +2237,8 @@ __destroy_client(struct nfs4_client *clp)
> 	if (clp->cl_cb_conn.cb_xprt)
> 		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
> 	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
> +	if (clp->cl_state !=3D NFSD4_ACTIVE)
> +		atomic_add_unless(&nn->nfsd_courtesy_client_count, -1, 0);
> 	free_client(clp);
> 	wake_up_all(&expiry_wq);
> }
> @@ -4356,6 +4362,8 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
> 	max_clients =3D (u64)si.totalram * si.mem_unit / (1024 * 1024 * 1024);
> 	max_clients *=3D NFS4_CLIENTS_PER_GB;
> 	nn->nfs4_max_clients =3D max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
> +
> +	atomic_set(&nn->nfsd_courtesy_client_count, 0);
> }
>=20
> static void init_nfs4_replay(struct nfs4_replay *rp)
> @@ -5878,8 +5886,11 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, stru=
ct list_head *reaplist,
> 			goto exp_client;
> 		if (!state_expired(lt, clp->cl_time))
> 			break;
> -		if (!atomic_read(&clp->cl_rpc_users))
> +		if (!atomic_read(&clp->cl_rpc_users)) {
> +			if (clp->cl_state =3D=3D NFSD4_ACTIVE)
> +				atomic_inc(&nn->nfsd_courtesy_client_count);
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



